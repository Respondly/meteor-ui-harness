Ctrl.define
  'th-list-spec':
    init: ->
      @spec = @options.data

    created: ->
    destroyed: ->
    model: ->
    api: {}
    helpers:
      spec: -> @spec

    events:
      'click': ->
        @spec.run @, ->
          console.log 'RUN DONE'
          console.log ''
