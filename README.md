# Rails::Dummy

[![Build Status](https://travis-ci.org/Courseware/rails-dummy.png?branch=master)](https://travis-ci.org/Courseware/rails-dummy)
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

## Customization via environment variables:

`DUMMY_APP_PATH` - Specify path where dummy app will be located. Defaults to
`spec/dummy`.

`ENGINE` - Specify engine name migrations to be installed via `rake
ENGINE:install:migrations`. Defaults to nil; engine specific migrations are not
installed.

`DISABLE_CREATE` - Don't run `db:create`.

`DISABLE_MIGRATE` - Don't run `db:migrate db:test:prepare` after creating database.

### Customization via `.dummyrc`

In addition to the environment variables, you can create a `.dummyrc` file which
will be picked up by the dummy application generator.

This file follows [the same syntax as the `.railsrc` file](https://github.com/rails/rails/blob/master/railties/lib/rails/generators/rails/app/USAGE).

## Projects using this gem

* [Coursewa.re](http://coursewa.re/about)
* [easy_auth-angel_list](https://github.com/geekcelerator/easy_auth-angel_list)
* [questionnaire_engine](http://github.com/twinge/questionnaire_engine)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes. Write some tests. (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This gem was extracted from the [http://coursewa.re](Coursewa.re) project.
