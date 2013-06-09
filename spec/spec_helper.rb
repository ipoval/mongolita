require 'rspec'

class ServerSettings < Hash
  def mdb_path
    fetch :mdb_path
  end
end

$server_settings = ServerSettings.new
$server_settings[:mdb_path] = File.join('/Users', ENV['USER'], 'mongodb/bin')
$server_settings.freeze

RSpec.configure do |conf|
  conf.order = 'random'
  conf.mock_with :rspec
  conf.fail_fast = false
  conf.filter_run focus: true
  conf.filter_run_excluding(broken: true)
  conf.run_all_when_everything_filtered = true
  conf.treat_symbols_as_metadata_keys_with_true_values = true
  conf.expect_with :rspec, :stdlib

  conf.before(:all) {
    system 'mkdir /tmp/mongolita/'
    system "#{$server_settings.mdb_path}/mongod --dbpath /tmp/mongolita/ --logpath /dev/null --fork"
  }

  conf.before(:each) {
  }

  conf.after(:all) {
  }
end
