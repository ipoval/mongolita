require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  let(:lib_path) { File.expand_path('../../lib/mdb.indexes.js', __FILE__) }

  describe 'function ls_indexes_size_desc' do
    specify 'returns the list of index size per collection sorted by size desc' do
      puts run_mongo 'typeof(ls_indexes_size_desc);'
    end
  end
end
