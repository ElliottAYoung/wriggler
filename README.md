# Wriggler

Wriggler was created to serve and the crawler for a search engine, moving its way through HTML and/or XML files and grabbing data based on pre determined tags then exporting it in a manipulatable format. Wriggler acts similarly to a spider, but was designed to be used with any number of local files, not as an actual web scraper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wriggler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wriggler

## Usage

You only need to run one command to use Wriggler, run: 

```ruby
Wriggler.crawl(["array", "of", "HTML/XML", "tags"], directory)
```

Note: The directory in this should be the top level directory that your HTML/XML files are in. Wriggler will account for any nested directories within this directory that also contain HTML/XML files. At the end you will have a data structure that resembles this:

```ruby
===============
Files Found: 2
===============
content = {
	tag1: ["Content", "Found", "in", "the", "First", "Opened", "File"], ["Content", "Found", "in", "the", "Second", "Opened", "File"]
	tag2: [], []
	tag3: ["Content", "Found", "in", "the", "First", "Opened", "File"], []
	tag4: [], ["Content", "Found", "in", "the", "Second", "Opened", "File"]
}
```

Where tag2 has no content found between both files, tag3 only found content in the first of the two files, tag4 only found content in the second of two files, and tag1 found content in both.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elliottayoung/wriggler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

On top of that, please contribute. I built this for a very specific reason, but I would very much like to see it become something bigger, so if you can assist with that please do!


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

