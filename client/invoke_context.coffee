###
The [this] context passed to test methods.
###
class Context
  constructor: ->


  ###
  Inserts the given control into the host.
  ###
  insert: (ctrl, options = {}) -> TestHarness.host.insert(ctrl, options)





TestHarness.context = new Context