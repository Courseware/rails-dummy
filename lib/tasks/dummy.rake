namespace :dummy do
  desc 'Generates a dummy app for testing. Use options: `DUMMY_APP_PATH` and `ENGINE`'
  task :app => [:setup, :template, :install_migrations, :create, :migrate]

  task :setup do
    dummy = File.expand_path(dummy_path)
    FileUtils.rm_rf(dummy)
    params = %W{. -q -f --skip-bundle -T -G}
    params << '--dummy-path=%s' % dummy
    Rails::Dummy::Generator.start(params)
  end

  task :template do
    unless ENV['TEMPLATE']
      Kernel.puts 'No `TEMPLATE` environment variable was set, no template to apply.'
    else
      # File.expand_path is executed directory of generated Rails app
      rakefile = File.expand_path('Rakefile', dummy_path)
      template = File.expand_path(
        ENV['TEMPLATE'], File.expand_path('../../', dummy_path))
      command = "rake -f '%s' rails:template LOCATION='%s'" % [
        rakefile, template]
      sh(command)
    end
  end

  task :install_migrations do
    engine = ENV['ENGINE']
    unless engine
      Kernel.puts 'No `ENGINE` environment variable was set, no migrations to install.'
    else
      # File.expand_path is executed directory of generated Rails app
      rakefile = File.expand_path('Rakefile', dummy_path)
      command = "rake -f '%s' %s:install:migrations" % [
        rakefile, engine.downcase]
      sh(command)
    end
  end

  task :create do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile', dummy_path)
    command = "rake -f '%s' db:create" % rakefile
    sh(command) unless ENV["DISABLE_CREATE"]
  end

  task :migrate do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile', dummy_path)
    command = "rake -f '%s' db:migrate db:test:prepare" % rakefile
    sh(command) unless ENV["DISABLE_MIGRATE"]
  end

  def dummy_path
    rel_path = ENV['DUMMY_APP_PATH'] || 'spec/dummy'
    if @current_path.to_s.include?(rel_path)
      @current_path
    else
      @current_path = File.expand_path(rel_path)
    end
  end
end
