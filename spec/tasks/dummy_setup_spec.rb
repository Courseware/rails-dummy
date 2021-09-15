require 'spec_helper'

describe 'dummy:setup', type: :task do
  shared_examples 'setup task' do
    let(:dummy_path) { 'spec/dummy' }
    let(:db_type) { 'sqlite3' }

    it 'removes and generates a new dummy app' do
      full_dummy_path = File.expand_path("../../../#{dummy_path}", __FILE__)
      expect(FileUtils).to receive(:rm_rf).with(full_dummy_path)
      expect(Rails::Dummy::Generator).to receive(:start).with(
        %W(
          #{full_dummy_path} -q -f --skip-bundle -T -G --database=#{db_type}
        )
      )

      task.invoke
    end
  end

  before do
    File.write(File.expand_path('.dummyrc'),
      <<-BODY
        # Available options:
        # rails _4.2.11_ new --help

        # Usage:
        #   rails new APP_PATH [options]

        # Options:
        #   -r, [--ruby=PATH]  # Path to the Ruby binary of your choice
        #                      # Default: ~/.asdf/installs/ruby/2.7.3/bin/ruby
        # ....

        --database=#{db_type} # Using custom database driver
      BODY
    )
  end

  after do
    File.unlink(File.expand_path('.dummyrc'))
  end

  include_examples 'setup task'

  context 'using ENGINE_DB environment variable' do
    let(:db_type) { 'postgresql' }

    after { ENV.delete('ENGINE_DB') }

    include_examples 'setup task'
  end

  context 'using DUMMY_APP_PATH environment variable' do
    let(:dummy_path) { ENV['DUMMY_APP_PATH'] = 'test_path' }

    after { ENV.delete('DUMMY_APP_PATH') }

    include_examples 'setup task'
  end
end
