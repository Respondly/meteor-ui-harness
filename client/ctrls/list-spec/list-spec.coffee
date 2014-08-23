Ctrl.define
  'uih-list-spec':
    init: ->
      # Store state.
      @spec = @data
      @meta = @spec.meta

      # Create controllers for the various types of spec.
      switch @meta?.type
        when 'boolean' then @boolean = new INTERNAL.SpecTypeBoolean(@ctrl)
        when 'select'
          if @meta.options?
            @select = new INTERNAL.SpecTypeSelect(@ctrl)
        when 'radio'
          if @meta.options?
            @radio = new INTERNAL.SpecTypeRadio(@ctrl)

      @isSpecial = @boolean? or @radio? or @select?


    api:
      run: ->
        # Increment the count.
        count = @helpers.count() ? 0
        count += 1
        @helpers.count(count)

        # Pass execution to the various controllers.
        @boolean?.onRun()

        # Invoke the method.
        @spec.run { this:UIHarness, throw:true }, -> # Complete.


    helpers:
      cssClasses: ->
        count = @helpers.count()

        css = ''
        css += ' uih-blue-bullet' if count > 0
        css += ' uih-has-count' if count > 0 and not @isSpecial
        css

      label: ->
        name = @spec.name
        name = name + ':' if @select? or @radio?
        name = "`#{ name }`" if @meta.propName?
        INTERNAL.formatText(name)

      count: (value) -> @prop 'count', value
      isBoolean: -> @boolean?
      isSelect: -> @select?
      isRadio: -> @radio?

      select: -> @select
      radio: -> @radio


    events:
      'click': (e) ->
        el = $(e.target)
        return if @select? and el.closest('.uih-select-options').length > 0
        return if @radio? and el.closest('.uih-radio-options').length > 0
        @api.run()

      'change select': (e) -> @select?.onChange(e)
      'change input[type="radio"]': (e) -> @radio?.onChange(e)

