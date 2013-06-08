// sort indexes in the system by size desc

var index_size_per_collection = [];

db.getCollectionNames().forEach(function(collection_name) {
  var tuple = [collection_name, db[collection_name].stats().totalIndexSize];
  index_size_per_collection.push(tuple);
});

index_size_per_collection.sort(function(collection1, collection2) {
  return collection2[1] - collection1[1];
});
