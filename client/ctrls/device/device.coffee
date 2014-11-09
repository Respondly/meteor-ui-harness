Ctrl.define
  'uih-device':
    ready: ->
      # Load the inner content control.
      if content = @options.content
        @children.ctrlOuter.load(content, { args: @options.args })



    api:
      device: (value) -> @prop 'device', value
      orientation: (value) -> @prop 'orientation', value, default:'portrait'


    helpers:
      device: -> PKG.toDevice(@api.device())
      cssClass: ->
        device = @helpers.device()
        css = @api.orientation()
        css

      screenSize: ->
        { width, height } = @helpers.device()?.size

        # Acount for screen border.
        width += 2
        height += 2

        switch @api.orientation()
          when 'portrait'  then { width:width,  height:height }
          when 'landscape' then { width:height, height:width } # Flip orientation.

      sizeLabel: ->
        isOverLabel = @helpers.isOverLabel()
        device = @helpers.device()
        if size = device?.size
          text = "#{ size.width } x #{ size.height } dp"
          if isOverLabel
            text = "#{ device.type } | #{ device.version } | #{ text }"
          text



      isOverLabel: (value) -> @prop 'isOverLabel', value, default:false

    events:
      'mouseenter .uih-size-label': -> @helpers.isOverLabel(true)
      'mouseleave .uih-size-label': -> @helpers.isOverLabel(false)

