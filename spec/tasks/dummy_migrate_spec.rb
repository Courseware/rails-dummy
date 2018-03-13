require 'spec_helper'

describe 'dummy:migrate', type: :task do

  context 'when DISABLE_MIGRATE variable is set' do
    before do
      ENV['DISABLE_MIGRATE'] = '1'

      expect_any_instance_of(::Kernel).not_to receive(:system)
    end

    after do
      ENV.delete('DISABLE_MIGRATE')
    end

    it 'does not call rake with db:migrate and db:test:prepare task' do
      task.invoke
    end
  end

  context 'when DISABLE_MIGRATE variable is not set (pre RAILS 4.1)' do
    before do
      stub_const("::Rails::VERSION::STRING", 3.2)
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' db:migrate db:test:prepare" % rakefile

      expect_any_instance_of(::Kernel).to(
        receive(:system).with(command, {}).and_return(true)
      )
    end

    it 'calls rake with db:migrate db:test:prepare task' do
      task.invoke
    end
  end

  context 'when DISABLE_MIGRATE variable is not set (post RAILS 4.1)' do
    before do
      stub_const("::Rails::VERSION::STRING", 4.1)
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      command = "rake -f '%s' db:migrate" % rakefile

      expect_any_instance_of(::Kernel).to(
        receive(:system).with(command, {}).and_return(true)
      )
    end

    it 'calls rake with db:migrate task' do
      task.invoke
    end
  end

end
