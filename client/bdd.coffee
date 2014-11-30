###
See the extensions to the BDD "describe" and "it" statements
in the [/shared] folder.

Shared on the server to protect against the user writing these
specs without putting them in a client-only location.
###


###
Update the [this] context that is passed to the
"describe" function
###
BDD.beforeDescribe (context) ->
  context.ctrl = -> UIHarness.ctrl()
  context.hash = UIHarness.hash
  context.log = PKG.log
  context.prop = (key, value, options) -> UIHarness.prop(key, value, options)
  context.delay = (msecs, func) -> UIHarness.delay(msecs, func)



# ----------------------------------------------------------------------



###
Initialize common meta data and function extensions
on each [Spec] model at creation.
###
BDD.specCreated (spec) -> extendModel 'spec', spec


###
Initialize common meta data and function extensions
on each [Suite] model at creation.
###
BDD.suiteCreated (suite) -> extendModel 'suite', suite


extendModel = (type, model) ->
  model.meta ?= {}
  keyPrefix = "uih-#{ type }:#{ model.uid() }:"

  # Read/write to local storage for the model.
  model.localStorage = (key, value, options) ->
        LocalStorage.prop((keyPrefix + key), value, options)

  # Clears all local-storage values for the model.
  model.localStorage.clear = ->
    for key, value of localStorage
      if key.startsWith(keyPrefix)
        localStorage.removeItem(key)





