require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.indexes.js', __FILE__) }

  describe 'Mongolita.total_index_size_per_collection()' do
    specify 'defined in mongo shell' do
      exec = eval_mongo 'typeof(Mongolita.total_index_size_per_collection);'

      exec.should eq 'function'
    end

    let(:js_insert) {
      js = <<-JS
        var objects = [];
        for(var i = 0; i < 100; ++i) { objects.push({ key: i }); };
        db.test.insert(objects);
        db.test.ensureIndex( { key: 1 } );
      JS
    }

    specify 'returns the list of index sizes per collection sorted by size desc' do
      eval_mongo js_insert

      out = eval_mongo 'printjson(Mongolita.total_index_size_per_collection());'

      puts out
      out.should include '"collection" : "test"'
      out.should include '"collection" : "system.indexes"'
      out.should include '"MB" : "0.000"'
    end
  end

  describe 'single_index_collections()' do
    specify 'defined in mongo shell' do
      out = eval_mongo 'typeof(Mongolita.single_index_collections);'

      out.should eq 'function'
    end

    let(:drop_index_js) { 'db.test.dropIndex( { key: 1 } );' }

    specify 'returns the list of collections with a single index' do
      eval_mongo drop_index_js

      out = eval_mongo 'printjson(Mongolita.single_index_collections());'

      puts out
      out.should include '"collection" : "test"'
      out.should include '"index_key" : { "_id" : 1 }'
    end
  end
end
