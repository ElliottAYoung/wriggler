# Wriggler

Wriggler was created to serve and the crawler for a search engine, moving its way through HTML files and grabbing data based on pre determined tags then making/storing the data in a number of specifically created CSV files. 

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
Wriggler.crawl([array, of, HTML/XML, tags], directory)
```

Note: The directory in this should be the top level directory that your HTML/XML files are in. Wriggler will account for any nested directories within this directory that also contain HTML/XML files and at the end of it running will save a new file named "tag_content.csv" to this directory

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wriggler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

On top of that, please contribute. I built this for a very specific reason, but I would very much like to see it become something bigger, so if you can assist with that please do!


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

