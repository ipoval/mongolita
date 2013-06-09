require_relative 'spec_helper'

describe 'mdb.indexes.js' do
  describe 'function ls_indexes_size_desc' do
    specify 'returns the list of index size per collection sorted by size desc' do
      system "#{$server_settings.mdb_path}/mongo --eval 'db.help();'"
    end
  end
end
