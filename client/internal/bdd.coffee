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
  context.title    = (value) -> setHeaderText.call(context, 'title', value)
  context.subtitle = (value) -> setHeaderText.call(context, 'subtitle', value)


###
Sets the "display" title/subtitle on the host header.
@param prop:  The name of the property attribute.
@param value: The title to display:
               - String
               - Function
###
setHeaderText = (prop, value) ->
  meta = @suite.uiHarness ?= {}
  meta[prop] = value



