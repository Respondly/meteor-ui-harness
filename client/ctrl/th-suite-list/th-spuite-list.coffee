console.error 'Create "model" test for Ctrl'



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
      specs: ->
        @suite.specs.map (spec) ->
          result =
            name: spec.name
    events:
      'click ul.th-specs > li': (e) -> console.log 'click', @




