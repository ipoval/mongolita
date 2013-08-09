// sort indexes in the db by size desc
//
function total_index_size_per_collection() {
  var index_size_per_collection = [];

  db.getCollectionNames().forEach(function(collection_name) {
    var tuple = [collection_name, db[collection_name].stats().totalIndexSize];
    index_size_per_collection.push(tuple);
  });

  index_size_per_collection.sort(
    function(coll1, coll2) { return coll2[1] - coll1[1]; }
  );

  var res = [];
  index_size_per_collection.forEach(function(elem) {
    var col_name = elem[0], bytes = elem[1];
    res.push(
      {
        collection: col_name,
        MB: (bytes / (1 << 20)).toFixed(3),
        KB: (bytes / (1 << 10)).toFixed(3),
        Bytes: bytes
      }
    );
  });

  return res;
}

// list collections with only one index, in the big app. it could mean there is a missing index on that collection
//
function single_index_collections() {
  var res = [];

  db.getCollectionNames().forEach(
    function(collection_name) {
      if (db[collection_name].getIndexes().length == 1) {
        res.push(collection_name);
      }
    }
  );

  return res;
}
