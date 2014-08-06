###
Declares a "spec" as a boolean property that can be toggled.

@param name: The name of the property
@param func: The test function.

###
it.boolean = (name, func) ->
  spec = it(name, func)
  extension = spec.extension ?= {}
  extension.type = 'boolean'
  extension.propName = name
  spec




# ----------------------------------------------------------------------



###
Update the [this] context that is passed to the
"describe" function
###
BDD.beforeDescribe (context) ->
  context.title = setTitle


###
Sets the "display" title on the host header.
@param title: The title to display:
               - String
               - Function
###
setTitle = (title) ->
  meta = @suite.uiHarness ?= {}
  meta.title = title

