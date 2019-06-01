require 'spec_helper'

describe 'dummy:db_create', type: :task do
  context 'when DISABLE_CREATE variable is set' do
    before do
      ENV['DISABLE_CREATE'] = '1'

      expect_any_instance_of(::Kernel).not_to receive(:system)
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

      expect_any_instance_of(::Kernel).to(
        receive(:system).with(command, {}).and_return(true)
      )
    end

    it 'calls rake with db:create task' do
      task.invoke
    end
  end
end
