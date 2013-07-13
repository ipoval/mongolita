// Guard against "fat fingers" on production env
var disabled_mongolita = function() { print('disabled by .mongorc.js'); };
db.dropDatabase                  = disabled_mongolita;
DB.prototype.dropDatabase        = disabled_mongolita;
DBCollection.prototype.drop      = disabled_mongolita;
DBCollection.prototype.dropIndex = disabled_mongolita;

// Set up the custom prompt
prompt = function() {
  if (typeof(db) === 'undefined') {
    return '(nodb)> ';
  }

  // Check the last db operation
  try {
    db.runCommand({ getLastError: 1 });
  } catch(e) {
    print(e);
  }

  return db + '> ';
};
