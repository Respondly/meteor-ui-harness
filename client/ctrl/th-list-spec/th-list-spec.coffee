Ctrl.define
  'th-list-spec':
    init: ->
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
        @data.run TestHarness, -> # Complete.


