Ctrl.define
  'uih-list-spec':
    init: ->
      @spec = @data
      @extension = @spec.extension
      @isBoolean = @extension?.type is 'boolean'

    created: ->
      # Handle Boolean toggling.
      if @isBoolean
        @autorun =>
          if ctrl = UIHarness.ctrl()
            key = @spec.name
            if Object.isFunction(ctrl[key])
              value = ctrl[key]()
              chk = @children.chk.api
              chk.isEnabled(Object.isBoolean(value))
              chk.toggle(value) if Object.isBoolean(value)


    api:
      run: ->
        # Increment the count.
        count = @helpers.count() ? 0
        count += 1
        @helpers.count(count)

        # Toggle if the spec represents a [Boolean] property.
        UIHarness.toggle(@spec.name) if @isBoolean

        # Invoke the method.
        @spec.run { this:UIHarness, throw:true }, -> # Complete.


    helpers:
      label: ->
        name = @spec.name
        name = "`#{ name }`" if @isBoolean
        INTERNAL.formatText(name)

      count: (value) -> @prop 'count', value
      isBoolean: -> @isBoolean
      cssClasses: ->
        css = ''
        css += ' uih-has-count' if @helpers.count() > 0 and not @isBoolean
        css



    events:
      'click': -> @api.run()

