(function() {
  this.default_host    = 'localhost';
  this.default_port    = 27017;
  this.default_db_name = 'mam';

  this.mongodb_connect = function mongodb_connect(host, port, db_name, callback_fn) {
    this.default_db = connect(host + ':' + port);
    this.working_db = this.default_db.getSisterDB(db_name);

    callback_fn();
  };
})();

mongodb_connect(
  default_host,
  default_port,
  default_db_name,
  function() {
    print('Connected to ...' + this.working_db.getName());
    print('`db.serverStatus();`');
  }
);

// load('./lib/mdb.indexes.js');
// load('./lib/mdb.operations.js');
