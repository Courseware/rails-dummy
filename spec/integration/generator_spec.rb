require 'spec_helper'

describe Rails::Dummy::Generator do
  let(:dummy_path) { './dummy_app_path' }
  let(:full_dummy_path) do
    spec_folder_path = File.expand_path('../../../', __FILE__)
    File.expand_path(dummy_path, spec_folder_path)
  end

  before do
    params = %W{. -q -f --skip-bundle -T -G}
    params << '--dummy-path=%s' % dummy_path
    Rails::Dummy::Generator.start(params)
  end

  after do
    FileUtils.rm_rf(full_dummy_path) if File.exist?(full_dummy_path)
  end

  it 'creates a dummy app' do
    File.exist?(full_dummy_path).should be_true
  end
end
