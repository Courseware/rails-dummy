namespace :dummy do
  desc 'Generates a dummy app for testing. Use options: `DUMMY_PATH` and `ENGINE`'
  task :app => [:setup, :template, :install_migrations, :migrate]

  task :setup do
    dummy = File.expand_path(dummy_path)
    sh("rm -rf #{dummy}")
    Rails::Dummy::Generator.start(
      %W(. -q -f --skip-bundle -T -G --dummy-path=#{dummy})
    )
  end

  task :template do
    unless ENV['TEMPLATE']
      puts 'No `TEMPLATE` environment variable was set, no template to apply.'
    else
      rakefile = File.expand_path('Rakefile')
      template = File.expand_path(ENV['TEMPLATE'], '../../')
      sh("rake -f #{rakefile} rails:template LOCATION=#{template}")
    end
  end

  task :install_migrations do
    engine = ENV['ENGINE']
    unless engine
      puts 'No `ENGINE` environment variable was set, no migrations to install.'
    else
      rakefile = File.expand_path('Rakefile')
      sh("rake -f #{rakefile} #{engine.downcase}:install:migrations")
    end
  end

  task :migrate do
    rakefile = File.expand_path('Rakefile')
    sh("rake -f #{rakefile} db:create db:migrate db:test:prepare")
  end

  def dummy_path
    ENV['DUMMY_PATH'] || 'spec/dummy'
  end
end
