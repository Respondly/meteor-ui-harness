Ctrl.define
  'uih-list-suite-section':
    init: ->
      @suite = @data

      # Sync local-storage with current [isOpen] value.
      @autorun =>
        @helpers.isOpenStorage(@api.isOpen())


    ready: ->
      options =
        visible:  @api.isOpen()
        duration: 0.2
      heightAnimator = new Util.HeightAnimator(@el('.uih-list-outer'), options)
      heightAnimator.init()

      # Sync: UI controls with logical state.
      @autorun =>
          isOpen = @api.isOpen()
          @children.twisty.isOpen(isOpen)
          heightAnimator.toggle(isOpen)


    api:
      isOpen: (value) -> @prop 'isOpen', value, default:@helpers.isOpenStorage()
      toggle: -> @api.isOpen(not @api.isOpen())


    helpers:
      title: -> INTERNAL.formatText(@data.name)
      listData: -> { suite: @data }
      isOpen: -> @api.isOpen()
      isOpenStorage: (value) -> @suite.localStorage 'isOpen', value, default:true


    events:
      'click .uih-title': (e) -> @api.toggle()

