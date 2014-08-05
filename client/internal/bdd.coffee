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


