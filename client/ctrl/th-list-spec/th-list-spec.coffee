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
        @data.run TestHarness.context, ->
          console.log 'RUN DONE'
          console.log ''
