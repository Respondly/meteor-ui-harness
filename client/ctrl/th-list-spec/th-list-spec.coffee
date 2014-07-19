Ctrl.define
  'th-list-spec':
    init: -> @spec = @data
    created: ->
    destroyed: ->
    model: ->
    api: {}
    helpers:
      invokeCount: (value) -> @prop 'invokeCount', value

    events:
      'click': ->
        # Increment the count.
        invokeCount = @helpers.invokeCount() ? 0
        invokeCount += 1
        @helpers.invokeCount(invokeCount)

        # Invoke the method.
        @spec.run { this:TestHarness, throw:true }, -> # Complete.
