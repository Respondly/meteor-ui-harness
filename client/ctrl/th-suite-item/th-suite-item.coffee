Ctrl.define
  'th-suite-item':
    init: ->
    created: ->
    destroyed: ->
    model: ->
    api: {}
    helpers:
      spec: -> @options.spec

    events:
      'click': -> console.log '@', @
