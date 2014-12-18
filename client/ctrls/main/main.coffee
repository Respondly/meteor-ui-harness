Ctrl.define
  'uih-main':
    init: -> @harness = @data

    ready: ->
      # Store reference.
      ctrls = @harness.configure.ctrls
      ctrls.main = @ctrl
      ctrls.host = @api.hostCtrl()


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
      hostCtrl: -> @children.host
      headerCtrl: -> @children.header
      headerText: -> PKG.headerText(@harness)
      logCtrl: (value) -> @prop 'logCtrl', value



    helpers:
      cssClass: ->
        log = @harness.log
        css = ''
        css = " uih-log-#{ log.edge() }" if log.edge()
        css


      style: ->
        color = @harness.style.background()
        if Util.isObject(color)
          {r, g, b, a} = color
          color = "rgba(#{ r }, #{ g }, #{ b }, #{ a })"
        "background-color:#{ color };"


      showLog: -> @harness.log.edge()?
      logHtml: ->
        if @harness.log.edge()?
          def =
            type: 'c-log'
            onInit: (ctrl) => @api.logCtrl(ctrl)
            onDestroyed: => @api.logCtrl(null)

      contentOffsetStyle: ->
        log = @harness.log
        if edge = log.edge()
          "#{ edge }:#{ log.offset() }px"

      logOffsetStyle: ->
        log = @harness.log
        if edge = log.edge()
          style = switch edge
                    when 'left', 'right' then 'width'
                    when 'top', 'bottom' then 'height'
          "#{ style }:#{ log.offset() }px;"









