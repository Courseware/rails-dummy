require 'rails/generators'
require 'rails/generators/rails/plugin_new/plugin_new_generator' if Rails.version.to_f >= 3.1 && Rails.version.to_f <= 4.0
require 'rails/generators/rails/plugin/plugin_generator' if Rails.version.to_f >= 4.1
require 'rails/dummy/version'

module Rails
  module Dummy

    generator_class = Rails::Generators::PluginNewGenerator if Rails.version.to_f >= 3.1 && Rails.version.to_f <= 4.0
    generator_class = Rails::Generators::PluginGenerator if Rails.version.to_f >= 4.1

    class Generator < generator_class
      def self.default_source_root
        generator_class.default_source_root
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
