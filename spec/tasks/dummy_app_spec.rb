require 'spec_helper'

describe 'dummy:app', type: :task do
  its(:prerequisites) { should include('setup') }
  its(:prerequisites) { should include('install_migrations') }
  its(:prerequisites) { should include('db_create') }
  its(:prerequisites) { should include('db_migrate') }
end
