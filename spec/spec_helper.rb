require 'rspec'
require 'fileutils'

class ServerSettings < Hash
  def mdb_path
    fetch :mdb_path
  end
end

$db_settings = ServerSettings.new
$db_settings[:mdb_path]      = File.join('/Users', ENV['USER'], 'bin/mongodb')
$db_settings[:tmp_dbpath]    = '/tmp/mongolita'
$db_settings[:tmp_mongolock] = File.join $db_settings[:tmp_dbpath], 'mongod.lock'
$db_settings.freeze

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
    FileUtils.mkdir_p $db_settings[:tmp_dbpath]
    system "#{$db_settings.mdb_path}/mongod --dbpath #{$db_settings[:tmp_dbpath]} --logpath /dev/null --fork"
  }

  conf.after(:all) {
    Process.kill 9, File.read($db_settings[:tmp_mongolock]).strip.to_i
  }
end

module MongolitaTestHelpers
  def run_mongo test_execution_str
    cmd = %Q{#{$db_settings.mdb_path}/mongo --eval "load('#{lib_path}'); #{test_execution_str};"}
    %x/#{cmd}/
  end
end

include MongolitaTestHelpers
