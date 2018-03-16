namespace :dummy do
  desc(
    'Generates a dummy app for testing.'\
    'Use options: `DUMMY_APP_PATH`, `ENGINE` and `ENGINE_DB`'
  )
  task :app => [:setup, :template, :install_migrations, :create, :migrate]

  task :setup do
    database = ENV['ENGINE_DB'] || 'sqlite3'

    FileUtils.rm_rf(dummy_path)
    params = %W{. -q -f --skip-bundle -T -G}
    params << '--dummy-path=%s' % dummy_path
    params << '--database=%s' % database
    Rails::Dummy::Generator.start(params)

    patch_database_config(dummy_path) if ENV['ENGINE_DB']
  end

  task :template do
    unless ENV['TEMPLATE']
      Kernel.puts(
        'No `TEMPLATE` environment variable was set, no template to apply.'
      )
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
      Kernel.puts(
        'No `ENGINE` environment variable was set, no migrations to install.'
      )
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
    command = "rake -f '%s' db:migrate" % rakefile
    command << " db:test:prepare" if ::Rails::VERSION::STRING.to_f < 4.1
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

  # Replaces the `database.yml` file with a version to allow reading from env.
  #
  # See: https://github.com/rails/rails/issues/28827
  def patch_database_config(path)
    db_config_path = File.expand_path('config/database.yml', path)
    content = <<-YML
test:
  url: <%= ENV['DATABASE_URL'] %>
development:
  url: <%= ENV['DATABASE_URL'] %>
production:
  url: <%= ENV['DATABASE_URL'] %>
    YML
    open(db_config_path, 'w').write(content)
  end
end
