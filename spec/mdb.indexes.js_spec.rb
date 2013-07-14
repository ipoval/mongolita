require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.indexes.js', __FILE__) }

  describe 'function total_index_size_per_collection()' do
    specify 'gets defined in mongo shell' do
      exec = run_mongo 'typeof(total_index_size_per_collection);'

      exec.should eq 'function'
    end

    specify 'returns the list of index sizes per collection sorted by size desc' do
       run_mongo('var objects = []; for(var i = 0; i < 1000; ++i) { objects.push({ key: i }); }; db.test.insert(objects); db.test.ensureIndex( { key: 1 } );')

       exec = run_mongo 'total_index_size_per_collection();'

       p exec
    end
  end
end
