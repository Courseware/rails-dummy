require 'spec_helper'

describe 'dummy:migrate' do

  context 'when DISABLE_MIGRATE variable is set' do
    before do
      ENV['DISABLE_MIGRATE'] = '1'
      # An equivalent of mocking `sh` method
      Rake::AltSystem.should_not_receive(:system)
    end

    after do
      ENV.delete('DISABLE_MIGRATE')
    end

    it 'does not call rake with db:migrate and db:test:prepare task' do
      task.invoke
    end
  end

  context 'when DISABLE_MIGRATE variable is not set' do
    before do
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' db:migrate db:test:prepare" % rakefile
      # An equivalent of mocking `sh` method
      Rake::AltSystem.should_receive(:system).with(command).and_return(true)
    end

    it 'calls rake with db:migrate db:test:prepare task' do
      task.invoke
    end
  end

end
