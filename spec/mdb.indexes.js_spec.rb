require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.indexes.js', __FILE__) }

  describe 'total_index_size_per_collection()' do
    specify 'defined in mongo shell' do
      exec = run_mongo 'typeof(total_index_size_per_collection);'

      exec.should eq 'function'
    end

    specify 'returns the list of index sizes per collection sorted by size desc' do
      run_mongo('var objects = []; for(var i = 0; i < 1000; ++i) { objects.push({ key: i }); }; db.test.insert(objects); db.test.ensureIndex( { key: 1 } );')

      out = run_mongo 'printjson(total_index_size_per_collection());'

      puts out
      out.should include '"collection" : "test"'
      out.should include '"collection" : "system.indexes"'
      out.should include '"MB" : "0.000"'
    end
  end

  describe 'single_index_collections()' do
    specify 'defined in mongo shell' do
      exec = run_mongo 'typeof(single_index_collections);'

      exec.should eq 'function'
    end

    specify 'returns the list of collections with a single index' do
      out = run_mongo 'printjson(single_index_collections());'

      puts out
      out.should include '"collection" : "test"'
    end
  end
end
