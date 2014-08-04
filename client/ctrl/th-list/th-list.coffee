###
Lists a set of specs and sub-suites.
###
Ctrl.define
  'uih-list':
    init: -> @suite = @data.suite

    api:
      ###
      Invoked when the list has been revealed on screen.
      ###
      onRevealed: (callback) ->
        beforeHandlers = @suite.getBefore()
        BDD.runMany beforeHandlers, { this:UIHarness, throw:true }, -> callback?()

      ###
      Invoked when the list has been taken off screen.
      ###
      onHidden: (callback) ->
        afterHandlers = @suite.getAfter()
        BDD.runMany afterHandlers, { this:UIHarness, throw:true }, -> callback?()


    helpers:
      isEmpty: -> @suite.items.length is 0
      items: ->
        @suite.items.map (item) ->
                result =
                  isSuite: (item instanceof BDD.Suite)
                  isSpec:  (item instanceof BDD.Spec)
                  data: item



