require 'spec_helper'

describe 'dummy:install_migrations', type: :task do
  context 'when ENGINE variable is set' do
    let(:engine_name) { 'TEST_ENGINE' }

    before do
      ENV['ENGINE'] = engine_name
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' %s:install:migrations" % [
        rakefile, engine_name.downcase ]

      expect_any_instance_of(::Kernel).to(
        receive(:system).with(command, {}).and_return(true)
      )
    end

    after do
      ENV.delete('ENGINE')
    end

    it 'calls rake with $ENGINE:install:migrations task' do
      task.invoke
    end
  end
end
