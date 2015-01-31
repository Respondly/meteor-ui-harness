###
The hosted control loader.
###
Ctrl.define
  'uih-host-ctrl-container':
    init: ->
      @harness = @options.harness


    api:
      cssClass: (value) -> @prop 'cssClass', value, default:''
      currentCtrl: (value) -> @prop 'currentCtrl', value, default:null
      elContent: -> $(@el()?.children()[0])

      ###
      Inserts a visual element into the [Host].
      See: [UIHarness] object for parameter documentation.
      ###
      load: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.unload()
        el = @el()

        # Parameter fix-up.
        if Object.isFunction(options)
          callback = options
          options = {}

        # Attempt to match strings with Ctrl/Template.
        if Object.isString(content)
          unless content.startsWith('<')
            if ctrl = Ctrl.defs[content]
              content = ctrl
            else
              content = Template[content] if Template[content]?


        done = =>
              @api.cssClass(options.cssClass ? '')
              @api.currentCtrl(@_current.ctrl ? null)
              callback?()

        # Don't continue unless some content has been specified.
        return done() unless content?

        # Ctrl.
        if (content instanceof Ctrl.CtrlDefinition)
          ctrl = @appendCtrl(content, el, options.args)
          ctrl.onReady -> done()
          @_current =
            type:       'ctrl'
            ctrl:       ctrl
            blazeView:  ctrl.context.__internal__.blazeView
            options:    options

        # Template.
        if content.__proto__ is Template.prototype
          view = Blaze.renderWithData(content, options.args, el[0])
          @_current =
            type:       'tmpl'
            tmpl:       content
            blazeView:  view
            options:    options
          Deps.afterFlush => done()

        # String (HTML).
        content = $(content) if Object.isString(content)

        # jQuery element.
        content = content[0] if content.jquery?

        # DOM element.
        if (content instanceof HTMLElement)
          el.append(content)
          @_current =
            type:       'element'
            el:         $(content)
            options:    options
          done()


      ###
      Removes the hosted control.
      ###
      unload: ->
        # Dispose of the Blaze view.
        if view = @_current?.blazeView
          Blaze.remove(view)

        # Ensure the DOM element is empty.
        @el().empty()

        # Finish up.
        delete @_current






    helpers:
      containerClass: ->
        css = @api.cssClass()

        # Provide a standard class for putting styles in test/spec files.
        if ctrl = @api.currentCtrl()
          css += " #{ ctrl.type }-test"

        css


      style: ->
        style = ''
        if @harness
          style += "border:#{ @harness.style.border() };"
        style


