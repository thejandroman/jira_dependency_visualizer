[![Build Status](https://travis-ci.org/thejandroman/jira_dependency_visualizer.svg?branch=master)](https://travis-ci.org/thejandroman/jira_dependency_visualizer)

# JiraDependencyVisualizer

This gem was created as a way to visualize dependencies between
tickets in Jira. The initial use case was to view how an epic's
dependent tickets were interconnected along with their current status.

The status colors in the graph are customizable via a yaml file. See
`./config/color.yaml` for an example.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jira_dependency_visualizer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jira_dependency_visualizer

## Usage

The gem can be consumed as either a CLI tool or as a library.

### CLI Tool

    $ jira_dependency_visualizer --help

### Library

See documentation: http://www.rubydoc.info/gems/jira_dependency_visualizer/

## Development

After checking out the repo, run `bundle install` to install
dependencies. Then, run `bundle exec rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/thejandroman/jira-dependency-visualizer. This
project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

## Attribution

This ruby gem is heavily influenced by
https://github.com/pawelrychlik/jira-dependency-graph.
