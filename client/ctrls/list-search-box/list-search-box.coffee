Ctrl.define
  'uih-list-search-box':
    init: ->
    ready: ->
      @textbox = @children.find (ctrl) -> ctrl.type is 'c-content-editable'
      @textbox.on 'changed', (j, e) ->
        # console.log 'e', e


    destroyed: ->
    model: ->
    api: {}
    helpers: {}
    events: {}
