Ctrl.define
  'th-list-spec':
    init: -> @spec = @data
    helpers:
      count: (value) -> @prop 'count', value
      cssClasses: ->
        css = ''
        css += ' th-has-count' if @helpers.count() > 0
        css


    events:
      'click': ->
        # Increment the count.
        count = @helpers.count() ? 0
        count += 1
        @helpers.count(count)

        # Invoke the method.
        @spec.run { this:TestHarness, throw:true }, -> # Complete.

