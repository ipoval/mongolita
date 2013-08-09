require_relative 'spec_helper'

describe 'mdb.operations.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.operations.js', __FILE__) }

  describe 'ls_slowest_ops()' do
    specify 'defined in mongo shell' do
      out = eval_mongo 'typeof(ls_slowest_ops);'

      out.should eq 'function'
    end
  end
end
