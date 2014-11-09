Ctrl.define
  'uih-list-spec':
    init: ->
      # Store state.
      @spec = @data
      @meta = @spec.meta

      # Create controllers for the various types of spec.
      switch @meta?.type
        when 'boolean' then @boolean = new PKG.SpecTypeBoolean(@ctrl)
        when 'markdown' then @markdown = new PKG.SpecTypeMarkdown(@ctrl)
        when 'select'
          if @meta.options?
            @select = new PKG.SpecTypeSelect(@ctrl)
        when 'radio'
          if @meta.options?
            @radio = new PKG.SpecTypeRadio(@ctrl)

      # Finish up.
      @isSpecial = @boolean? or @radio? or @select? or @markdown?


    api:
      run: ->
        # Increment the count.
        count = @helpers.count() ? 0
        count += 1
        @helpers.count(count)

        # Pass execution to the various controllers.
        @boolean?.onRun()
        @markdown?.onRun()

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
        name = "`#{ name }`" if @meta.propName?
        PKG.formatText(name)

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

