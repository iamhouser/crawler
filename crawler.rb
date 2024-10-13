require 'open-uri'
require 'nokogiri'
require 'ffi/aspell'

# Массив URL для проверки
urls = [
  "https://example.com"
]



speller = FFI::Aspell::Speller.new('ru')


File.open('spelling_errors.txt', 'w') do |file|
  urls.each do |url|
    begin
      puts "Проверяем URL: #{url}"
      file.puts "URL: #{url}"
      file.puts "-" * 50


      html = URI.open(url).read


      doc = Nokogiri::HTML(html)


      doc.css('script, style, noscript').remove


      text = doc.xpath('//body//text()').map(&:text).join(' ')


      words = text.scan(/[А-Яа-яЁё]+/)

      misspelled_words = {}

      words.each do |word|
        word = word.downcase
        unless speller.correct?(word)
          suggestions = speller.suggestions(word)
          misspelled_words[word] = suggestions
        end
      end

      if misspelled_words.empty?
        puts "Ошибок не найдено на странице #{url}."
        file.puts "Ошибок не найдено."
      else
        puts "Найдены ошибки на странице #{url}."
        file.puts "Найдены ошибки в следующих словах:"
        misspelled_words.each do |word, suggestions|
          file.puts "Слово: #{word}"
          file.puts "Возможные варианты: #{suggestions.take(5).join(', ')}"
          file.puts "------------------------"
        end
      end

      file.puts "\n"

    rescue OpenURI::HTTPError => e
      puts "Не удалось открыть URL #{url}: #{e.message}"
      file.puts "Ошибка при открытии URL: #{e.message}"
    rescue SocketError => e
      puts "Ошибка сети при обращении к URL #{url}: #{e.message}"
      file.puts "Ошибка сети: #{e.message}"
    rescue => e
      puts "Произошла ошибка при обработке URL #{url}: #{e.message}"
      file.puts "Произошла ошибка: #{e.message}"
    end
  end
end

puts "Проверка завершена. Результаты сохранены в файл 'spelling_errors.txt'."
