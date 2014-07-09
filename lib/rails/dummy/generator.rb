require 'rails'
require 'rails/generators'
require 'rails/dummy/version'

begin
  require 'rails/generators/rails/plugin_new/plugin_new_generator'
rescue LoadError
  require 'rails/generators/rails/plugin/plugin_generator'
end

module Rails
  module Dummy

    def self.generator_class
      begin
        Rails::Generators::PluginNewGenerator
      rescue
        Rails::Generators::PluginGenerator
      end
    end

    class Generator < Rails::Dummy.generator_class

      def self.default_source_root
        superclass.default_source_root
      end

      def do_nothing
      end

      alias_method :create_root, :do_nothing
      alias_method :create_root_files, :do_nothing
      alias_method :create_app_files, :do_nothing
      alias_method :create_config_files, :do_nothing
      alias_method :create_lib_files, :do_nothing
      alias_method :create_public_stylesheets_files, :do_nothing
      alias_method :create_javascript_files, :do_nothing
      alias_method :create_script_files, :do_nothing
      alias_method :update_gemfile, :do_nothing
      alias_method :create_test_files, :do_nothing
      alias_method :finish_template, :do_nothing
      alias_method :create_bin_files, :do_nothing
    end
  end
end
