require 'spec_helper'

describe 'dummy:setup', type: :task do
  let(:dummy_path) { 'spec/dummy' }

  before do
    full_dummy_path = File.expand_path("../../../#{dummy_path}", __FILE__)
    expect(FileUtils).to receive(:rm_rf).with(full_dummy_path)
    expect(Rails::Dummy::Generator).to receive(:start).with(
      %W(
        . -q -f --skip-bundle -T -G
        --dummy-path=#{full_dummy_path}
        --database=sqlite3
      )
    )
  end

  it 'removes and generates a new dummy app' do
    task.invoke
  end

  context 'using DUMMY_APP_PATH environment variable' do
    let(:dummy_path) { 'test_path' }

    it 'removes and generates a new dummy app' do
      ENV['DUMMY_APP_PATH'] = dummy_path
      task.invoke
      ENV.delete('DUMMY_APP_PATH')
    end
  end
end
