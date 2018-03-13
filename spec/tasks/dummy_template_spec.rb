require 'spec_helper'

describe 'dummy:template', type: :task do

  context 'when TEMPLATE variable was not set' do
    it 'calls puts with a notice message' do
      task.invoke
    end
  end

  context 'when TEMPLATE variable is set' do
    let(:template) { 'test/TMPL' }

    before do
      ENV['TEMPLATE'] = template
      rakefile = File.expand_path('../../dummy/Rakefile', __FILE__)
      template_path = File.expand_path(
        template, File.expand_path('../../../', __FILE__))

      command = "rake -f '%s' rails:template LOCATION='%s'" % [
        rakefile, template_path ]

      expect_any_instance_of(::Kernel).to(
        receive(:system).with(command, {}).and_return(true)
      )
    end

    after do
      ENV.delete('TEMPLATE')
    end

    it 'calls rake with rails:template task' do
      task.invoke
    end
  end
end
