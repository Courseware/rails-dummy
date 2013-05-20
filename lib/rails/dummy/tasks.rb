require 'rails/dummy/generator'

module Rails
  module Dummy
    module Tasks
      def self.install(tasks_path)
        Dir[tasks_path].each { |task| load(task) }
      end
    end
  end
end

if defined?(Rake)
  tasks_path = File.expand_path('../../../tasks/*.rake', __FILE__)
  Rails::Dummy::Tasks.install(tasks_path)
end
