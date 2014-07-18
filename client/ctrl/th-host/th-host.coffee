Ctrl.define
  'th-host':
    init: ->
      TestHarness.host = @ctrl

    created: ->
    destroyed: ->
    model: ->

    api:
      ###
      Inserts a visual element into the [Host].
      @param content: The control to insert. Can be:
                      - Ctrl (definition)
                      - Ctrl (instance)
                      - DOM element
                      - jQuery element
                      - String (HTML)
      @param options:
      ###
      insert: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.reset()
        el = @find('.th-container')

        # Parameter fix-up.
        if Object.isFunction(options)
          callback = options
          options = {}

        # Ctrl.
        if (content instanceof Ctrl.Definition)
          result = content.insert(el, options.args)
          result.ready -> callback?()
          @blazeView = result.instance.__internal__.blazeView

        # Template.
        if content.__proto__ is Template.prototype
          domrange = UI.renderWithData(content, options.args)
          domrange.view.onRendered -> callback?()
          UI.insert(domrange, el[0])
          @blazeView = domrange.view

        # String (HTML).
        content = $(content) if Object.isString(content)

        # jQuery element.
        content = content[0] if content.jquery?

        # DOM element.
        if (content instanceof HTMLElement)
          el.append(content)
          callback?()



      ###
      Clears the host.
      ###
      reset: ->
        # Dispose of the Blaze view.
        if view = @blazeView
          UI.remove(view.domrange)

        # Ensure the DOM element is empty.
        @find('.th-container').empty()



    helpers: {}
    events: {}


