// response time by operation type
db.system.profile.aggregate(
  { $group :
    { _id: '$op',
      count: { $sum: 1 },
      'max response time': { $max: '$millis' },
      'avg response time': { $avg: '$millis' }
    }
  }
);

// slowest by namespace
db.system.profile.aggregate(
  { $group:
    { _id: "$ns",
      count:{$sum:1},
      "max response time":{$max:"$millis"},
      "avg response time":{$avg:"$millis"}
    }
  },
{$sort: {
  "max response time":-1}
} 
);

// slowest by client
db.system.profile.aggregate(
{$group : { 
  _id :"$client", 
  count:{$sum:1},  
  "max response time":{$max:"$millis"},  
  "avg response time":{$avg:"$millis"}  }
}, 
{$sort: {
  "max response time":-1}
} 
);

// summary of response time of moved vs non-moved
db.system.profile.aggregate(
  { $group : { 
    _id :"$moved", 
    count:{$sum:1},  
    "max response time":{$max:"$millis"},  
    "avg response time":{$avg:"$millis"}  
  }});

// common queries, good for finding what to shard on
db.system.profile.aggregate(
{$group : { 
  _id :"$query", 
  count:{$sum:1},  
  "max response time":{$max:"$millis"},  
  "avg response time":{$avg:"$millis"}  }
}, 
{$sort: {
  count:-1}
},
{ $limit : 5},
{ $match : {count:{$gt:1} } }
);


// slowest 100 by query having count > 1
db.system.profile.aggregate(
{$group : { 
  _id :"$query", 
  count:{$sum:1},  
  "max response time":{$max:"$millis"},  
  "avg response time":{$avg:"$millis"}  }
},
{$sort: {
  "max response time":-1}
},
{ $limit : 100},
{ $match : {count:{$gt:1} } }
);

// show relative performance of moved queries only
db.system.profile.aggregate({ $group : { _id :"moved", count:{$sum:1}, "max response time":{$max:"$millis"},"avg response time":{$avg:"$millis"}}});
