Ctrl.define
  'ui-harness':
    created: ->
      INTERNAL.index = @children.index.ctrl

      # Keen the top of the [host] in sync with the height
      # of the header if it's visible.
      @autorun =>
        title      = INTERNAL.headerText() # Hook into reactive callback.
        windowSize = INTERNAL.windowSize() # Hook into reactive callback.
        Deps.afterFlush =>
            top = @ctrl.children.header?.el().height() ? 0
            @el('.uih-host').css('top', (top + 1) + 'px')



    helpers:
      hasTitle: ->
        headerText = INTERNAL.headerText()
        headerText.title? or headerText.subtitle?

      mainCss: ->
        css = ''
        css += ' uih-has-title' if @helpers.hasTitle()
        css

