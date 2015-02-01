Ctrl.define
  'uih-list-spec':
    init: ->
      # Store state.
      @harness = @data.harness
      @spec = @data
      @meta = @spec.meta

      # Create controllers for the various types of spec.
      switch @meta?.type
        when 'ctrl'     then @customCtrl = @specType = new PKG.SpecTypeCtrl(@ctrl)
        when 'boolean'  then @boolean = @specType = new PKG.SpecTypeBoolean(@ctrl)
        when 'markdown' then @markdown = @specType = new PKG.SpecTypeMarkdown(@ctrl)

        when 'select'
          if @meta.options?
            @select = @specType = new PKG.SpecTypeSelect(@ctrl)

        when 'radio'
          if @meta.options?
            @radio = @specType = new PKG.SpecTypeRadio(@ctrl)

      # Finish up.
      @isSpecial = @boolean? or @radio? or @select? or @markdown?


    api:
      run: ->
        # Increment the count.
        count = @helpers.count() ? 0
        count += 1
        @helpers.count(count)

        # Pass execution to the various controllers.
        @specType?.onRun?()

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
      isCustomCtrl: -> @customCtrl?

      select: -> @select
      radio: -> @radio

      customCtrl: ->
        if options = @customCtrl.meta.options
          options = Object.clone(options)
          type = options.type
          delete options.type
          def =
            id: 'customCtrl'
            type: type
            data: options
            spec: @spec
            harness: @harness
            ctrl: -> @harness.ctrl()
            log: @harness.log
          def


    events:
      'click': (e) ->
        el = $(e.target)
        return if @select? and el.closest('.uih-select-options').length > 0
        return if @radio? and el.closest('.uih-radio-options').length > 0
        # return if @customCtrl? and el.closest('.uih-custom-ctrl-outer').length > 0
        @api.run()

      'change select': (e) -> @select?.onChange(e)
      'change input[type="radio"]': (e) -> @radio?.onChange(e)

