Ctrl.define
  'uih-list-search-box':
    init: ->
    ready: ->
      @textbox = @children.find (ctrl) -> ctrl.type is 'c-content-editable'


      txt = @textbox
      console.log 'txt.isPlainText()', txt.isPlainText()
      console.log 'txt.multiLine()', txt.multiLine()


      @textbox.on 'changed', (j, e) ->
        console.log 'e', e

        console.log 'Ctrls.focused()', Ctrl.focused()
        console.log ''


    destroyed: ->
    model: ->
    api: {}
    helpers: {}
    events: {}
