Ctrl.define
  'th-suite-tree':
    init: ->
    created: ->
    destroyed: ->
    model: ->
    api: {}
    helpers:
      suite: -> BDD.suite.children()[0]
    events: {}
