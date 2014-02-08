require 'spec_helper'

describe 'dummy:app' do
  its(:prerequisites) { should include('setup') }
  its(:prerequisites) { should include('template') }
  its(:prerequisites) { should include('install_migrations') }
  its(:prerequisites) { should include('create') }
  its(:prerequisites) { should include('migrate') }
end
