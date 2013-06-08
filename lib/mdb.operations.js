// the slowest currently running operation on the server

var inprog_ops = db.currentOp().inprog;

inprog_ops.sort(function(op1, op2) {
  return op2.secs_running - op1.secs_running;
});
