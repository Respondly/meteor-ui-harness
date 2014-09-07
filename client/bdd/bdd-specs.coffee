###
Declares a "spec" as a boolean property that can be toggled.

@param name: The name of the property
@param func: The test function.

###
it.boolean = (name, func) ->
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'boolean'
  meta.propName = name
  spec



###
Decalres a "spec" with multiple dropdown options.

@param name:    The name of the property
@param options: The options:
                 - array
                 - object (key:value)
@param func:    The test function.

###
it.select = (name, options, func) ->
  { name, options, func } = fixOptionParams(name, options, func)
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'select'
  meta.propName = name
  meta.options = options
  spec




###
Decalres a "spec" with multiple radio-button options.

@param name:    The name of the property
@param options: The options:
                 - array
                 - object (key:value)
@param func:    The test function.

###
it.radio = (name, options, func) ->
  { name, options, func } = fixOptionParams(name, options, func)
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'radio'
  meta.propName = name
  meta.options = options
  spec



# ----------------------------------------------------------------------




fixOptionParams = (name, options, func) ->
  if Object.isFunction(options) and not func?
    func = options
    options = null

  result =
    name: name
    options: options
    func: func
