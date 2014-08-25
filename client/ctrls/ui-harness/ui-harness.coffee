Ctrl.define
  'ui-harness':
    ready: ->
      INTERNAL.index = @children.index.ctrl

      # Keep the top of the [host] in sync with the height
      # of the header if it's visible.
      @autorun =>
        # Hook into reactive callback.
        title      = INTERNAL.headerText()
        windowSize = INTERNAL.windowSize()
        hasTitle   = @helpers.hasTitle()

        Deps.afterFlush =>
            top = @ctrl.children.header?.el().height() ? 0
            @el('.uih-host').css('top', top + 'px')



    helpers:
      hasTitle: -> not INTERNAL.headerText().isBlank

      mainCss: ->
        css = ''
        css += ' uih-has-title' if @helpers.hasTitle()
        css

