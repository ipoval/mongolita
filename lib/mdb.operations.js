// get the slowest currently running operations on the server
//
function ls_slowest_ops() {
  var inprog_ops = db.currentOp().inprog;

  inprog_ops.sort(function(op1, op2) {
    return op2.secs_running - op1.secs_running;
  });

  // FIXME: return opid, query
}
