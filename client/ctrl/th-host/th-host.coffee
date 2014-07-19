Ctrl.define
  'th-host':
    init: -> TH.host = @ctrl
    created: ->
    destroyed: ->

    api:
      elContainer: -> @find('.th-container')
      elContent: -> $(@api.elContainer()?.children()[0])


      ###
      Inserts a visual element into the [Host].
      See: [TestHarness] object for parameter documentation.
      ###
      insert: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.clear()
        el = @api.elContainer()

        # Parameter fix-up.
        if Object.isFunction(options)
          callback = options
          options = {}

        done = =>
            @api.updateState()
            callback?()

        # Don't continue unless some content has been specified.
        return done() unless content?

        # Ctrl.
        if (content instanceof Ctrl.Definition)
          result = content.insert(el, options.args)
          result.ready -> done()
          @_current =
            type:       'ctrl'
            ctrl:       result.instance.ctrl
            blazeView:  result.instance.__internal__.blazeView
            options:    options

        # Template.
        if content.__proto__ is Template.prototype
          domrange = UI.renderWithData(content, options.args)
          domrange.view.onRendered -> done()
          UI.insert(domrange, el[0])
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
          el.append(content)
          @_current =
            type:       'element'
            el:         $(content)
            options:    options
          done()



      ###
      Clears the host.
      ###
      clear: ->
        # Dispose of the Blaze view.
        if view = @_current?.blazeView
          UI.remove(view.domrange)

        # Ensure the DOM element is empty.
        el = @api.elContainer()
        el.empty()
        el.toggle(false)

        # Finish up.
        delete @_current



      ###
      Updates the visual state of the host.
      ###
      updateState: ->
        # Setup initial conditions.
        options = @_current?.options
        return unless options
        if el = @api.elContent()

          # Set default values.
          options.size  ?= 'auto'
          options.align ?= 'center,middle'

          # Reset.
          el.removeClass('th-fill')
          el.css('width', '')
          el.css('height', '')

          # Adjust size.
          switch options.size
            when 'auto' then # No-op.
            when 'fill' then el.addClass 'th-fill'
            else
              if options.size?
                size = Util.toSize(options.size) if options.size?
                el.css('width', "#{ size.width }px")
                el.css('height', "#{ size.height }px")

          # Finish up.
          @api.elContainer().toggle(true)



    helpers: {}
    events: {}


