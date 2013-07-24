require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.indexes.js', __FILE__) }

  describe 'function total_index_size_per_collection()' do
    specify 'defined in mongo shell' do
      exec = run_mongo 'typeof(total_index_size_per_collection);'

      exec.should eq 'function'
    end

    specify 'returns the list of index sizes per collection sorted by size desc' do
      run_mongo('var objects = []; for(var i = 0; i < 1000; ++i) { objects.push({ key: i }); }; db.test.insert(objects); db.test.ensureIndex( { key: 1 } );')

      result = run_mongo 'printjson(total_index_size_per_collection());'

      puts result
      result.should include '"collection" : "test"'
      result.should include '"collection" : "system.indexes"'
      result.should include '"MB" : "0.000"'
    end
  end

  describe 'ls_single_index_collections' do
    specify 'defined in mongo shell' do
      exec = run_mongo 'typeof(total_index_size_per_collection);'

      exec.should eq 'function'
    end
  end
end
