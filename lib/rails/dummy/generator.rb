require 'rails'
require 'rails/generators'
require 'rails/dummy/version'
require 'rails/generators/rails/app/app_generator'

module Rails
  module Dummy
    class Generator < Rails::Generators::AppGenerator
      def self.default_source_root
        superclass.default_source_root
      end
    end
  end
end
