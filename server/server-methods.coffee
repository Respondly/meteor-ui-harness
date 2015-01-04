Meteor.methods
  'ui-harness/invokeSpec': (uid) ->
    # Setup initial conditions.
    check(uid, String)

    # Find the "it" spec.
    spec = BDD.suite.findOne(uid:uid)
    unless spec?
      throw new Meteor.Error(404, "A spec with the id [#{ uid }] was not found.")

    # Attempt to invoke the function.
    startedAt = new Date()
    returnValue = {}
    Async.runSync (done) ->
        spec.run (err, result) ->
            returnValue.result = result
            if err?
              returnValue.error = error = { message: err.message }

              if err.errorType is 'Meteor.Error'
                error.number = err.error
                error.reason = err.reason
                error.details = err.details

            done(err)

    # Finish up.
    returnValue.msecs = startedAt.millisecondsAgo()
    returnValue
