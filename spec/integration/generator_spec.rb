require 'spec_helper'

describe Rails::Dummy::Generator do

  let(:dummy_path) { 'spec/dummy' }

  before do
    @current_path = Dir.pwd
  end

  after do
    FileUtils.cd @current_path
    full_dummy_path = File.join(@current_path, dummy_path)
    FileUtils.rm_rf(full_dummy_path) if File.exist?(full_dummy_path)
  end

  it 'creates a dummy app' do
    params = %W{. -q -f --skip-bundle -T -G --dummy-path}
    params << dummy_path
    Rails::Dummy::Generator.start(params)

    expect(Dir[File.join(@current_path, dummy_path, '*')]).to_not be_empty
  end
end
