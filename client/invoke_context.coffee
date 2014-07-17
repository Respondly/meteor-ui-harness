###
The [this] context passed to test methods.
###
class Context
  ###
  Inserts the given control into the host.
  ###
  load: (ctrl, options = {}) -> TestHarness.host.insert(ctrl, options)





TestHarness.context = new Context