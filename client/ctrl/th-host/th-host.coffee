Ctrl.define
  'th-host':
    init: ->
      TH.host = @ctrl

    created: ->
    destroyed: ->
    model: ->

    api:
      ###
      Inserts a visual element into the [Host].
      See: [TestHarness] object for parameter documentation.
      ###
      insert: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.clear()
        el = @find('.th-container')

        # Parameter fix-up.
        if Object.isFunction(options)
          callback = options
          options = {}

        done = -> callback?()

        # Don't continue unless some content has been specified.
        return done() unless content?

        # Ctrl.
        if (content instanceof Ctrl.Definition)
          result = content.insert(el, options.args)
          result.ready -> done()
          @blazeView = result.instance.__internal__.blazeView

        # Template.
        if content.__proto__ is Template.prototype
          domrange = UI.renderWithData(content, options.args)
          domrange.view.onRendered -> done()
          UI.insert(domrange, el[0])
          @blazeView = domrange.view

        # String (HTML).
        content = $(content) if Object.isString(content)

        # jQuery element.
        content = content[0] if content.jquery?

        # DOM element.
        if (content instanceof HTMLElement)
          el.append(content)
          done()



      ###
      Clears the host.
      ###
      clear: ->
        # Dispose of the Blaze view.
        if view = @blazeView
          UI.remove(view.domrange)

        # Ensure the DOM element is empty.
        @find('.th-container').empty()



    helpers: {}
    events: {}


