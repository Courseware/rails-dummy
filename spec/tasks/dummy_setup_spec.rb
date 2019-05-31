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

  include_examples 'setup task'

  context 'using ENGINE_DB environment variable' do
    let(:db_type) { ENV['ENGINE_DB'] = 'postgresql' }

    after { ENV.delete('ENGINE_DB') }

    include_examples 'setup task'
  end

  context 'using DUMMY_APP_PATH environment variable' do
    let(:dummy_path) { ENV['DUMMY_APP_PATH'] = 'test_path' }

    after { ENV.delete('DUMMY_APP_PATH') }

    include_examples 'setup task'
  end
end
