"use strict";

// clean up GridFS chunks collection
//   * make sure there are no "orphan" chunks with no link to a file

function find_orphan_chunks() {
  var cursor = db.fs.chunks.find({}, { _id: 1, files_id: 1 });

  while (cursor.hasNext()) {
    var chunk = cursor.next();
    if (db.fs.files.findOne({ _id: chunk.files_id }) === null) {
      print('orphaned gridfs chunk: ' + chunk._id);
    }
  }
}
