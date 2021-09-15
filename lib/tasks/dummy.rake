namespace :dummy do
  desc(
    'Generates a dummy app for testing.'\
    'Use $DUMMY_APP_PATH and $ENGINE`'\
    'to overwrite the location and integrate with a Rails engine.'\
    'Create a .dummyrc (aka .railsrc) file to customize the generator options.'
  )
  task :app => [:setup, :install_migrations, :db_create, :db_migrate]

  task :setup do
    FileUtils.rm_rf(dummy_path)

    params = [dummy_path] + %W{-q -f --skip-bundle -T -G}

    params = [dummy_path] + %W{-q -f --skip-bundle -T -G}

    if File.exist?('.dummyrc')
      File.readlines(File.expand_path('.dummyrc')).each do |option|
        next if option.blank?
        next if option.start_with?('#')

        option.chomp!

        value = option[/^(?:(?!#).)*/].strip
        next if value.blank?

        params << value
      end
    end

    Rails::Dummy::Generator.start(params)

    patch_database_config(dummy_path) if ENV['ENGINE_DB']
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

  task :db_create do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile', dummy_path)
    command = "rake -f '%s' db:create" % rakefile
    sh(command) unless ENV["DISABLE_CREATE"]
  end

  task :db_migrate do
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
development:
  url: <%= ENV['DATABASE_URL'] %>
test:
  url: <%= ENV['DATABASE_URL'] %>
    YML
    open(db_config_path, 'w').write(content)
  end
end
