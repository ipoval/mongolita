"use strict";

// a. db.collection_name.findById("\h{24}");
// b. db.collection_name.findById(ObjectId("\h{24}"));
//
DBCollection.prototype.findById = function(id, projection) {
  // ObjectId or String used as id in DB
  var is_objectid = function is_objectid() {
    var random_id = this.findOne({}, { _id: 1 });
    if (random_id) {
      return random_id._id.isObjectId;
    }
  };

  if (!id.isObjectId && is_objectid) {
    id = new ObjectId(id);
  }

  return this.findOne({ _id: id }, projection || {});
};
