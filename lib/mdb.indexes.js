// sort indexes in the system by size desc
//
function ls_indexes_size_desc() {
  var index_size_per_collection = [];

  db.getCollectionNames().forEach(function(collection_name) {
    var tuple = [collection_name, db[collection_name].stats().totalIndexSize];
    index_size_per_collection.push(tuple);
  });

  index_size_per_collection.sort(
    function(collection1, collection2) { return collection2[1] - collection1[1]; }
  );

  return index_size_per_collection;
}

// list collections with only one index,
// in the big app. it could mean
// there is a missing index on that collection
//
function ls_single_index_collections() {
  db.getCollectionNames().forEach(
    function(collection_name) {
      if (db[collection_name].getIndexes().length == 1) {
        print(collection_name);
      }
    }
  );
}
