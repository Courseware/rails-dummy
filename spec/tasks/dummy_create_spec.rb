require 'spec_helper'

describe 'dummy:create' do

  context 'when DISABLE_CREATE variable is set' do
    before do
      ENV['DISABLE_CREATE'] = '1'
      # An equivalent of mocking `sh` method
      Rake::AltSystem.should_not_receive(:system)
    end

    after do
      ENV.delete('DISABLE_CREATE')
    end

    it 'does not call rake with db:create task' do
      task.invoke
    end
  end

  context 'when DISABLE_CREATE variable is not set' do
    before do
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' db:create" % [rakefile]
      # An equivalent of mocking `sh` method
      Rake::AltSystem.should_receive(:system).with(command).and_return(true)
    end

    it 'calls rake with db:create task' do
      task.invoke
    end
  end

end
