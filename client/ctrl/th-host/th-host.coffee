DEFAULT_SIZE = 'auto'
DEFAULT_ALIGN = 'center,middle'
DEFAULT_MARGIN = null


Ctrl.define
  'th-host':
    init: ->
      LOCAL.host = @ctrl
      @autorun => @api.updateSize()
      @autorun => @api.updatePosition()


    api:
      elContainer: -> @find('.th-container')
      elContent: -> $(@api.elContainer()?.children()[0])

      size: (value) -> @prop 'size', value, default:DEFAULT_SIZE
      align: (value) -> @prop 'align', value, default:DEFAULT_ALIGN
      margin: (value) -> @prop 'margin', value, default:DEFAULT_MARGIN


      ###
      Inserts a visual element into the [Host].
      See: [TestHarness] object for parameter documentation.
      ###
      insert: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.clear()
        elContainer = @api.elContainer()

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
              # Update visual state.
              @api.size(options.size ? DEFAULT_SIZE)
              @api.align(options.align ? DEFAULT_ALIGN)
              @api.margin(options.margin ? DEFAULT_MARGIN)
              @api.updateState()

              # Store global state.
              TestHarness.el(@api.elContent())
              TestHarness.ctrl(@_current.ctrl ? null)
              elContainer.toggle(true)

              # Finish up.
              callback?()

        # Don't continue unless some content has been specified.
        return done() unless content?

        # Ctrl.
        if (content instanceof Ctrl.Definition)
          result = @appendCtrl(content, '.th-container', options.args)
          result.ready -> done()
          @_current =
            type:       'ctrl'
            ctrl:       result.ctrl
            blazeView:  result.ctrl.context.__internal__.blazeView
            options:    options

        # Template.
        if content.__proto__ is Template.prototype
          domrange = UI.renderWithData(content, options.args)
          domrange.view.onRendered -> done()
          UI.insert(domrange, elContainer[0])
          @_current =
            type:       'tmpl'
            tmpl:       content
            blazeView:  domrange.view
            options:    options

        # String (HTML).
        content = $(content) if Object.isString(content)

        # jQuery element.
        content = content[0] if content.jquery?

        # DOM element.
        if (content instanceof HTMLElement)
          elContainer.append(content)
          @_current =
            type:       'element'
            el:         $(content)
            options:    options
          done()



      ###
      Resets the host to it's default state.
      ###
      reset: ->
        @api.clear()
        @api.size(DEFAULT_SIZE)
        @api.align(DEFAULT_ALIGN)


      ###
      Removes the host.
      ###
      clear: ->
        # Dispose of the Blaze view.
        if view = @_current?.blazeView
          UI.remove(view.domrange)

        # Ensure the DOM element is empty.
        elContainer = @api.elContainer()
        elContainer.empty()
        elContainer.toggle(false)

        # Finish up.
        TestHarness.el(null)
        TestHarness.ctrl(null)
        delete @_current


      ###
      Updates the visual state of the host.
      ###
      updateState: ->
        @api.updateSize()
        @api.updatePosition()


      ###
      Updates the size of the hosted content.
      ###
      updateSize: ->
        size = @api.size()
        margin = @api.margin()

        if elContainer = @api.elContainer()
          elContent = @api.elContent()

          # Reset.
          elContent.removeClass('th-fill')
          elContainer.removeClass('th-fill')
          for attr in ['width', 'height', 'left', 'top', 'right', 'bottom']
            elContainer.css(attr, '')

          # Adjust size.
          switch size
            when 'auto' then # No-op.
            when 'fill'
              elContent.addClass('th-fill')
              if margin? and margin isnt 'none'
                margin = Util.toSpacing(margin)
                for attr in ['left', 'top', 'right', 'bottom']
                  elContainer.css(attr, "#{ margin[attr] }px")

              else
                elContainer.addClass('th-fill')

            else
              if size?
                size = Util.toSize(size)
                elContainer.css('width', "#{ size.width }px")
                elContainer.css('height', "#{ size.height }px")
                elContent.addClass('th-fill')



      ###
      Updates the positon of the hosted control.
      ###
      updatePosition: ->
        size  = @api.size()
        align = @api.align()

        if elContainer = @api.elContainer()

          # Reset CSS classes.
          elContainer.removeClass 'th-left th-center th-right'
          elContainer.removeClass 'th-top th-middle th-bottom'
          elContainer.removeClass 'th-center-middle'

          # Update CSS classes.
          switch size
            when 'fill' then # Ignore
            else
              align = Util.toAlignment(align ? 'center,middle')
              if align.x is 'center' and align.y is 'middle'
                elContainer.addClass('th-center-middle')
              else
                elContainer.addClass("th-#{ align.x } th-#{ align.y }")


