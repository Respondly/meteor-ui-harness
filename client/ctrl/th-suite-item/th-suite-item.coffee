Ctrl.define
  'th-suite-item':
    init: ->
      @spec = @options.spec

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
