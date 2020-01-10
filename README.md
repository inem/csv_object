# CsvObject

Ever found yourself trying to find the right way to use Ruby's `CSV` library? Confused about all those `CSV.parse` and `CSV.open`, and when to use each of them?

The purpose of CsvObject gem is to create convenient interface to work with CSV files and data in Ruby. Whatever you have: string with filename, CSV data itself, `Pathname`, `CSV::Table`, array of hashes, or even `Paperclip::Attachment`, just throw it into `CsvObject.new(your_stuff)`

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/csv_object`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_object

## Usage



Let's say we have `people.csv` file:

```
Id,Name,Age,Sex
1011,Mike,13,Male
1012,Annette,27,Female
1013,Zoran,22,Male
```

We can do the following:

```
csv_object = CsvObject.new('test/fixtures/people.csv')
# => #<CsvObject:0x00007fc91dcd78a8 @csv=#<CSV::Table mode:col_or_row row_count:4>>

csv_object.headers
# => ["Id", "Name", "Age", "Sex"]

csv_object.sort { |a, b| a[2].to_i <=> b[2].to_i }.map{|a| [a["Name"], a["Age"]]}
# => [["Mike", "13"], ["Zoran", "22"], ["Annette", "27"]]

subset = csv_object.subset(["1013","1011"], "Id")
# => #<CsvObject:0x00007fc91f472e40 @csv=#<CSV::Table mode:col_or_row row_count:3>>

subset.size # => 2
subset.to_csv # => "Id,Name,Age,Sex\n1011,Mike,13,Male\n1013,Zoran,22,Male\n"
subset.to_file('/tmp/subset.csv') # saves subset to file

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inem/csv_object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
