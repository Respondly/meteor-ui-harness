###
The [this] context passed to test methods.
###
class Context
  ###
  Inserts the given control into the host.
  ###
  load: (ctrl, options, callback) -> TestHarness.host.insert(ctrl, options, callback)





TestHarness.context = new Context