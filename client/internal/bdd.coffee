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


fixOptionParams = (name, options, func) ->
  if Object.isFunction(options) and not func?
    func = options
    options = null

  result =
    name: name
    options: options
    func: func




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



# ----------------------------------------------------------------------



###
Update the [this] context that is passed to the
"describe" function
###
BDD.beforeDescribe (context) ->
  context.title    = (value) -> setHeaderText.call(context, 'title', value)
  context.subtitle = (value) -> setHeaderText.call(context, 'subtitle', value)
  context.ctrl = -> UIHarness.ctrl()
  context.hash = UIHarness.hash
  context.log = INTERNAL.log
  context.prop = (key, value, options) -> UIHarness.prop(key, value, options)
  context.delay = (msecs, func) -> UIHarness.delay(msecs, func)


###
Sets the "display" title/subtitle on the host header.
@param prop:  The name of the property attribute.
@param value: The title to display:
               - String
               - Function
###
setHeaderText = (prop, value) ->
  meta = @suite.meta
  meta[prop] = value



