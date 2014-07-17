Ctrl.define
  'th-host':
    init: ->
      TestHarness.host = @ctrl

    created: ->
    destroyed: ->
    model: ->
    api:
      ###
      Clears the host.
      ###
      reset: ->
        # Dispose of the Blaze view.
        if view = @blazeView
          UI.remove(view.domrange)
          console.log 'view', view

        # Ensure the DOM element is empty.
        @find('.th-container').empty()


      ###
      Inserts a visual element into the [Host].
      @param ctrl:    The control to insert. Can be:
                      - Ctrl (definition)
                      - Ctrl (instance)
                      - DOM elemnet
                      - jQuery elemnet
      @param options:
      ###
      insert: (ctrl, options = {}) ->
        # Setup initial conditions.
        @api.reset()
        el = @find('.th-container')
        callback = options.callback

        # Ctrl.
        if (ctrl instanceof Ctrl.Definition)
          result = ctrl.insert(el, options.args)
          result.ready -> callback?()
          @blazeView = result.instance.__internal__.blazeView

        # Template.
        if ctrl.__proto__ is Template.prototype
          tmpl = ctrl
          domrange = UI.renderWithData(tmpl, options.args)
          result = UI.insert(domrange, el[0])
          # @blazeView = result.view

          console.error 'TODO - Store a ref to the blaze view'


    helpers: {}
    events: {}
