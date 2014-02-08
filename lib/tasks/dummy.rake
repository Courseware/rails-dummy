namespace :dummy do
  desc 'Generates a dummy app for testing. Use options: `DUMMY_PATH` and `ENGINE`'
  task :app => [:setup, :template, :install_migrations, :create, :migrate]

  @original_dir = File.expand_path('.')

  task :setup do
    dummy = File.expand_path(dummy_path)
    FileUtils.rm_rf(dummy)
    Rails::Dummy::Generator.start(
      %W(. -q -f --skip-bundle -T -G --dummy-path=#{dummy})
    )
  end

  task :template do
    unless ENV['TEMPLATE']
      puts 'No `TEMPLATE` environment variable was set, no template to apply.'
    else
      # File.expand_path is executed directory of generated Rails app
      rakefile = File.expand_path('Rakefile')
      template = File.expand_path(ENV['TEMPLATE'], @original_dir)      
      sh("rake -f #{rakefile} rails:template LOCATION=#{template}")
    end
  end

  task :install_migrations do
    engine = ENV['ENGINE']
    unless engine
      puts 'No `ENGINE` environment variable was set, no migrations to install.'
    else
      # File.expand_path is executed directory of generated Rails app
      rakefile = File.expand_path('Rakefile')
      sh("rake -f #{rakefile} #{engine.downcase}:install:migrations")
    end
  end
  
  task :create do 
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile')
    sh("rake -f #{rakefile} db:create") unless ENV["DISABLE_CREATE"]
  end
  
  task :migrate do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile')
    sh("rake -f #{rakefile} db:migrate db:test:prepare") unless ENV["DISABLE_MIGRATE"]
  end
  
  def dummy_path
    ENV['DUMMY_APP_PATH'] || 'spec/dummy'
  end
end
