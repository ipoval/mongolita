load('./lib/mdb.indexes.js');
load('./lib/mdb.operations.js');

db = connect('localhost:10000/mam');

sister_db = db.getSisterDB('db_name');
