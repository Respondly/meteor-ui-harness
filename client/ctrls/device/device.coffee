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

      size: ->
        size = @helpers.device()?.size
        switch @api.orientation()
          when 'portrait' then size
          when 'landscape' then { width:size.height, height:size.width }

      sizeLabel: ->
        if size = @helpers.device()?.size

          "#{ size.width } x #{ size.height }"
