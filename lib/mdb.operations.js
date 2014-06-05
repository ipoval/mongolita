"use strict";

/**
 * Get the slowest currently running operations on the server
 */
function ls_slowest_ops() {
  var inprog_ops = db.currentOp().inprog;

  inprog_ops.sort(function(op1, op2) {
    return op2.secs_running - op1.secs_running;
  });

  // FIXME: return opid, query
}

/**
 * Generate a random hex guid
 * returns \h{4}-\h{4}-\h{4}-\h{4}-\h{4}-\h{4}-\h{4}-\h{4}
 */
function guid() {
  // returns random '0000' - 'ffff' (0 - 65535)
  var s = function() {
    var hex = Math.floor(Math.random() * 0x10000).toString(16),
      prefix = Array(4 - hex.length + 1).join('0');
    return prefix + hex;
  };

  return [s(), s(), s(), s(), s(), s(), s(), s()].join('-');
}
