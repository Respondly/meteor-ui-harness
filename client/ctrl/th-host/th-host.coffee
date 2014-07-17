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
        @find('.th-container').empty()
        console.log 'TODO - Dispose of control'


      ###
      Inserts an visual contorl into the Host.
      @param ctrl:    The control to insert. Can be:
                      - Ctrl (definition)
                      - Ctrl (instance)
                      - DOM elemnet
                      - jQuery elemnet
      @param options:
      ###
      insert: (ctrl, options = {}) ->
        @api.reset()

        console.log 'INSERT', @
        console.log 'ctrl', ctrl

        el = @find('.th-container')
        ctrl.insert(el)

        console.log 'TODO', 'Position'
        console.log 'TODO', 'Invoke callback'
        console.log ''

    helpers: {}
    events: {}
