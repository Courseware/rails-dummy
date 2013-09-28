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


## Customization by environment variables: 

`DUMMY_APP_PATH` - Specify path where dummy app will be located. Defaults to `spec/dummy`.

`TEMPLATE` - Use a Rails template by passing  environment variable. Defaults to nil; creates generic Rails app.

`ENGINE` - Specify engine name migrations to be installed via `rake ENGINE:install:migrations`. Defaults to nil; engine specific migrations are not installed.

`DISABLE_MIGRATE` - Does not run `db:migrate db:test:prepare` after creating database.

## Projects using this gem

* [Coursewa.re](http://coursewa.re/about)
* [easy_auth-angel_list](https://github.com/geekcelerator/easy_auth-angel_list)
* [questionnaire_engine](http://github.com/twinge/questionnaire_engine)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This gem was extracted from the [http://coursewa.re](Coursewa.re) project.
