Ctrl.define
  'th-list-spec':
    init: ->
    created: ->
    destroyed: ->
    model: ->
    api: {}
    helpers: {}

    events:
      'click': ->
        @data.run @, ->
          console.log 'RUN DONE'
          console.log ''
