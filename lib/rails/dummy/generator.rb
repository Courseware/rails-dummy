require 'rails/generators'
require 'rails/generators/rails/plugin_new/plugin_new_generator'
require 'rails/dummy/version'

module Rails
  module Dummy

    class Generator < Rails::Generators::PluginNewGenerator
      def self.default_source_root
        Rails::Generators::PluginNewGenerator.default_source_root
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
