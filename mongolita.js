(function() {
  this.default_host    = 'localhost';
  this.default_port    = 27017;
  this.default_db_name = 'mam';

  this.mongodb_connect = function mongodb_connect(host, port, db_name, callback_fn) {
    this.default_db = connect(host + ':' + port);
    this.working_db = this.default_db.getSisterDB(db_name);

    callback_fn();
  };

  this.print_header = function print_header() {
    print('\nMongolita - mongodb custom shell analytics tools and functions\n');
    print('DB name: ' + this.working_db.getName() + ' | MongoDB: ' + this.working_db.version() + '\n');
  };

  this.print_server_info = function print_server_info() {
    this.working_db.serverStatus();
  };
})();

mongodb_connect(
  default_host,
  default_port,
  default_db_name,
  function() {
    print_header();
    print_server_info();
  }
);
