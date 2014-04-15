# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/dummy/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-dummy"
  spec.version       = Rails::Dummy::VERSION
  spec.authors       = ["Stas SUȘCOV"]
  spec.email         = ["stas@net.utcluj.ro"]
  spec.description   = %q{Rake task to generate a dummy Rails app.}
  spec.summary       = %q{Use it to generate a dummy app for RSpec}
  spec.homepage      = "https://github.com/courseware/rails-dummy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.1.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rake"
end
