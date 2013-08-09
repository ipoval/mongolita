require 'rspec'
require 'fileutils'

class ServerSettings < Hash
  def mdb_path; fetch :bin; end
end

$db_settings = ServerSettings.new
$db_settings[:bin]    = File.join('/Users', ENV['USER'], 'bin/mongodb')
$db_settings[:dbpath] = '/tmp/mongolita'
$db_settings[:pid]    = File.join $db_settings[:dbpath], 'mongod.lock'
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
    FileUtils.mkdir_p $db_settings[:dbpath]
    system "#{$db_settings.mdb_path}/mongod --dbpath #{$db_settings[:dbpath]} --logpath /dev/null --fork"
  }

  conf.after(:all) {
    Process.kill 9, File.read($db_settings[:pid]).strip.to_i
    # FIXME
    # FileUtils.rm_rf $db_settings[:dbpath]
  }
end

module MongolitaTestHelpers
  @@shell_strip = /MongoDB shell version:.*?connecting to: test/m

  def eval_mongo exec_script
    cmd = %Q{#{$db_settings.mdb_path}/mongo --eval "load('#{lib_path}'); #{exec_script};"}
    @response = %x/#{cmd}/
    strip_noise
  end

  private

  def strip_noise
    @response[@@shell_strip] = '' if @response.match @@shell_strip
    @response.strip
  end
end

include MongolitaTestHelpers
