# Russian Spelling Checker for Web Pages

This Ruby script checks Russian web pages for spelling errors. It fetches web pages, extracts the text content, and uses Aspell to identify misspelled Russian words. The results, including suggestions for correct spellings, are saved in a `spelling_errors.txt` file.

## Prerequisites

- **Ruby** installed on your system.
- The following Ruby gems:
  - `nokogiri`
  - `ffi-aspell`
- **Aspell** installed with the Russian dictionary.

## Installation

### Install Required Gems

Install the necessary Ruby gems by running:

```bash
gem install nokogiri
gem install ffi-aspell
```

### Install Aspell with Russian Dictionary

#### On Ubuntu/Debian:

```bash
sudo apt-get install aspell
sudo apt-get install aspell-ru
```

#### On macOS using Homebrew:

```bash
brew install aspell
brew install aspell-lang
```

*Note: Ensure that the Russian dictionary is included or installed separately if needed.*

## Usage

1. **Update the URLs:**

   Edit the script and update the `urls` array with the web pages you want to check:

   ```ruby
   urls = [
     "https://example.com",
     "https://another-example.com"
   ]
   ```

2. **Run the Script:**

   Execute the script by running:

   ```bash
   ruby spelling_checker.rb
   ```

3. **View the Results:**

   The script will process each URL, check for spelling errors, and save the results in `spelling_errors.txt`.

## Output

The `spelling_errors.txt` file will contain entries like:

```
URL: https://example.com
--------------------------------------------------
Found errors in the following words:
Word: неправильно
Possible suggestions: правильно, неправильный, неправильное
------------------------

Word: тестирование
Possible suggestions: тестирование, тестированием
------------------------

...
```

## Error Handling

If the script encounters issues while fetching or processing a URL, it will output error messages to the console and write them to `spelling_errors.txt`. Common errors include network issues or inaccessible URLs.

## Notes

- **Ignored Content:** The script ignores text within `<script>`, `<style>`, and `<noscript>` tags to focus on visible content.
- **Language Support:** Only Russian words are checked. Text in other languages will be ignored.
- **Case Sensitivity:** Words are converted to lowercase before spell-checking to ensure consistency.

## License

This project is open-source and available under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss improvements or fixes.

## Contact

For questions or suggestions, please contact [e.domnin@proton.me](mailto:e.domnin@proton.me).
