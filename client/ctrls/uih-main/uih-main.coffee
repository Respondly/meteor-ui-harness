Ctrl.define
  'uih-main':
    init: ->
      @harness = @data

    ready: ->
      # Store referecnes.
      @harness.__internal.mainHostCtrl = @api.hostCtrl()

      # Keep the top of the [host] in sync with the height
      # of the header if it's visible.
      @autorun =>
        # Hook into reactive callback.
        title      = @api.headerText()
        windowSize = PKG.windowSize()
        hasTitle   = not @api.headerText().isBlank

        Deps.afterFlush =>
            top = @children.header?.el().height() ? 0
            @api.hostCtrl().el().style().top(top)


    api:
      hostCtrl: -> @children.mainHost
      headerCtrl: -> @children.header
      headerText: -> PKG.headerText(@harness)

