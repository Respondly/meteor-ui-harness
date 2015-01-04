###
Declares a "spec/test" that runs on the server.

@param name: The name of the property
@param func: The test function.
@param callback(err, result): Optional. Invoked upon completion.

###
it.server = (name, func, callback) ->
  if Meteor.isServer
    it(name, func)

  if Meteor.isClient
    # Create a client-side wrapper function that will
    # invoke the Spec's method on the server.
    spec = it name, ->
      Meteor.call 'ui-harness/invokeSpec', spec.uid(), (err, result) ->
          hasCallback = Object.isFunction(callback)
          if err?
            console.error err.message
            return

          # Print a default result set to the console.
          console.group(spec.name)
          console.log 'Result:', result.result
          console.log 'Elapsed:', result.msecs, 'msecs'
          console.error 'Error:', result.error if result.error?
          console.groupEnd()
          console.log ''

          if hasCallback
            # Invoke the spec callback allowing the author
            # to handle the results as they wish.
            callback.call(UIHarness, err, result)


    meta = spec.meta
    meta.type = 'server'
    spec
