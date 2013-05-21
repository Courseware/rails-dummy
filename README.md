# Rails::Dummy

A simple task to generate a dummy app for engines using RSpec or Test::Unit.

## Installation

Add this line to your application's Gemfile:

    gem 'rails-dummy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-dummy

## Usage

Add this to your `Rakefile`

    require 'rails/dummy/tasks'

Now you should be able to run:

    rake dummy:app

You can use environment variables `DUMMY_PATH` and `ENGINE` to specify the
engine name migrations to run and the path for the dummy app.

You can also use a Rails template by passing `TEMPLATE` environment variable.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
