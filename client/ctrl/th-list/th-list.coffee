###
Lists a set of specs and sub-suites.
###
Ctrl.define
  'th-list':
    init: ->
      @suite = @options.suite

    created: ->
    destroyed: ->
    model: ->
    api: {}

    helpers:
      items: ->
        @suite.items.map (item) ->
                result =
                  isSuite: (item instanceof BDD.Suite)
                  isSpec:  (item instanceof BDD.Spec)
                  data: item

    events: {}


