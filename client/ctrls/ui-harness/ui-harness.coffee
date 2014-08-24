Ctrl.define
  'ui-harness':
    ready: ->
      INTERNAL.index = @children.index.ctrl

      # Keen the top of the [host] in sync with the height
      # of the header if it's visible.
      @autorun =>
        # Hook into reactive callback.
        title      = INTERNAL.headerText()
        windowSize = INTERNAL.windowSize()
        hasTitle   = @helpers.hasTitle()

        Deps.afterFlush =>
            top = @ctrl.children.header?.el().height() ? 0
            @el('.uih-host').css('top', (top + 1) + 'px')



    helpers:
      hasTitle: ->
        headerText = INTERNAL.headerText()
        not Util.isBlank(headerText.title) and not Util.isBlank(headerText.subtitle)


      mainCss: ->
        css = ''
        css += ' uih-has-title' if @helpers.hasTitle()
        css

