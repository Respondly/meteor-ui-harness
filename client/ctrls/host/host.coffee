DEFAULT_SIZE        = 'auto'
DEFAULT_ALIGN       = 'center,top'
DEFAULT_MARGIN      = 50
DEFAULT_SCROLL      = false
DEFAULT_ORIENTATION = 'portrait'


###
The Control Host canvas.
###
Ctrl.define
  'uih-host':
    init: ->
      @harness = @options.harness


    ready: ->
      @autorun => @api.updateSize()
      @autorun => @api.updatePosition()
      @autorun => @api.updateDevice(  )


    api:
      elContainer: -> @children.ctrlOuter.el()
      elContent: -> @children.ctrlOuter.elContent()

      currentCtrl: -> @children.ctrlOuter.currentCtrl()
      cssClass: -> @children.ctrlOuter.cssClass()

      align: (value) -> @prop 'align', value, default:DEFAULT_ALIGN
      margin: (value) -> @prop 'margin', value, default:DEFAULT_MARGIN
      device: (value) -> @prop 'device', value, default:null
      orientation: (value) -> @prop 'orientation', value, default:DEFAULT_ORIENTATION

      size: (value) ->
        result = @prop 'size', value, default:[DEFAULT_SIZE]
        if result
          value = if Object.isArray(result) then result[0] else result
          if value is 'auto' or value is 'fill'
            value
          else
            Util.toSize(result)

      scroll: (value) ->
        result = @prop 'scroll', value, default:DEFAULT_SCROLL
        Util.toScroll(result)




      ###
      Inserts a visual element into the [Host].
      See: [UIHarness] object for parameter documentation.
      ###
      load: (content, options = {}, callback) ->
        # Setup initial conditions.
        @api.unload()
        device = options.device
        orientation = options.orientation ? DEFAULT_ORIENTATION

        # Override display options for showing the device
        # if a device was specified.
        if device
          options =
            size: 'auto'
            align: 'center,middle'
            scroll: false
            margin: 0
            args:
              content:      content
              device:       device
              orientation:  orientation
              args:         options.args

          content = 'uih-device'

        @children.ctrlOuter.load content, options, =>
              # Update visual state.
              @api.size(options.size ? DEFAULT_SIZE)
              @api.align(options.align ? DEFAULT_ALIGN)
              @api.margin(options.margin ? DEFAULT_MARGIN)
              @api.scroll(options.scroll ? DEFAULT_SCROLL)
              @api.device(device ? null)
              @api.orientation(orientation ? DEFAULT_ORIENTATION)

              # Finish up.
              @api.updateState()
              @el().toggle(true)
              callback?()


      ###
      Removes the hosted control.
      ###
      unload: ->
        @children.ctrlOuter.unload()
        @el().toggle(false)


      ###
      Resets the host to it's default state.
      ###
      reset: ->
        @api.unload()
        @api.size(DEFAULT_SIZE)
        @api.align(DEFAULT_ALIGN)
        @api.margin(DEFAULT_MARGIN)
        @api.cssClass('')
        @api.device(null)
        @api.orientation(DEFAULT_ORIENTATION)



      ###
      Updates the visual state of the host.
      ###
      updateState: ->
        @api.updateSize()
        @api.updatePosition()
        @api.updateDevice()




      ###
      Updates the size of the hosted content.
      ###
      updateSize: ->
        size = @api.size()
        margin = @api.margin()
        isScrolling = @api.scroll().isScrolling()

        if elContainer = @api.elContainer()
          elContent = @api.elContent()
          elContainerOuter = @find('.uih-container-margin')
          elements = [elContainer, elContent, elContainerOuter]

          # Reset.
          for el in elements
            el.removeClass('uih-fill')

          for attr in ['width', 'height', 'left', 'top', 'right', 'bottom']
            for suffix in ['', 'padding-']
              for el in elements
                el.css((suffix + attr), '')

          # Adjust size.
          switch size
            when 'auto' then # No-op.
            when 'fill'
              unless isScrolling
                elContainer.addClass('uih-fill')
                elContent.addClass('uih-fill')
            else
              if size?
                setSize = (prop) ->
                      if size[prop]?
                        unit  = size["#{prop}Unit"]
                        value = size.toValueString(prop, 'px')
                        elContent.css(prop, value)
                        elContainer.css(prop, value) if unit is '%'
                setSize('width')
                setSize('height')

          # Adjust margin.
          margin = 0 if margin is 'none'
          margin = DEFAULT_MARGIN if margin is undefined
          margin = Util.toSpacing(margin)

          if size is 'fill' and isScrolling
            # Use padding when relative positioning is used.
            for attr in ['left', 'top', 'right', 'bottom']
              elContainer.css("padding-#{attr}", "#{ margin[attr] }px")
          else
            # Use margin when the content is absolutely positioned.
            for attr in ['left', 'top', 'right', 'bottom']
              elContainerOuter.css(attr, "#{ margin[attr] }px")


      ###
      Updates the positon of the hosted control.
      ###
      updatePosition: ->
        size  = @api.size()
        align = @api.align()

        if elContainer = @api.elContainer()

          # Reset CSS classes.
          elContainer.removeClass 'uih-left uih-center uih-right'
          elContainer.removeClass 'uih-top uih-middle uih-bottom'
          elContainer.removeClass 'uih-center-middle'

          # Update CSS classes.
          switch size
            when 'fill' then # Ignore
            else
              align = Util.toAlignment(align ? 'center,middle')
              if align.x is 'center' and align.y is 'middle'
                elContainer.addClass('uih-center-middle')
              else
                elContainer.addClass("uih-#{ align.x } uih-#{ align.y }")

      ###
      Updates the device settings.
      ###
      updateDevice: ->
        device = @api.device()
        orientation = @api.orientation()
        if device?
          if ctrl = @api.currentCtrl()
            if ctrl.type is 'uih-device'
              ctrl.device(device)
              ctrl.orientation(orientation)


    helpers:
      harness: -> @harness
      rootClass: ->
        css = ''
        css += ' uih-is-fill' if @api.size() is 'fill'
        if scroll = @api.scroll()
          css += ' uih-is-scrolling' if scroll.x or scroll.y
          css += ' uih-scroll-x'     if scroll.x
          css += ' uih-scroll-y'     if scroll.y
        css







