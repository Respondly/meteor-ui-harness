###
Lists a set of specs and sub-suites.
###
Ctrl.define
  'th-suite-list':
    init: ->
      @suite = @options.suite

    created: ->
    destroyed: ->
    model: ->
    api: {}

    helpers:
      specs: -> @suite.specs()

    events: {}
