require 'spec_helper'

describe 'dummy:install_migrations' do

  context 'when ENGINE variable was not set' do
    before { Kernel.should_receive(:puts) }

    it 'calls puts with a notice message' do
      task.invoke
    end
  end

  context 'when ENGINE variable is set' do
    let(:engine_name) { 'TEST_ENGINE' }

    before do
      ENV['ENGINE'] = engine_name
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' %s:install:migrations" % [
        rakefile, engine_name.downcase ]
      # An equivalent of mocking `sh` method
      Rake::AltSystem.should_receive(:system).with(command).and_return(true)
    end

    after do
      ENV.delete('ENGINE')
    end

    it 'calls rake with $ENGINE:install:migrations task' do
      task.invoke
    end
  end
end
