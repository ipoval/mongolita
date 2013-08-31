require 'rspec'
require 'fileutils'
Dir[File.expand_path('../support/*', __FILE__)].each &method(:require)

$mongod          = MongodInTest.new
$mongod[:bin]    = File.join('/Users', ENV['USER'], 'bin/mongodb')
$mongod[:dbpath] = '/tmp/mongolita'
$mongod[:pid]    = File.join $mongod[:dbpath], 'mongod.lock'
$mongod.freeze

$mongod.run

RSpec.configure do |conf|
  conf.include MongolitaTestHelpers

  conf.order = 'random'
  conf.mock_with :rspec
  conf.fail_fast = false
  conf.filter_run focus: true
  conf.filter_run_excluding(broken: true)
  conf.run_all_when_everything_filtered = true
  conf.treat_symbols_as_metadata_keys_with_true_values = true
  conf.expect_with :rspec, :stdlib
end

at_exit {
  Process.kill 9, File.read($mongod[:pid]).strip.to_i
  FileUtils.rm_rf $mongod[:dbpath]
}
