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
        # Run all the "before" handlers in the hierarchy if
        # this is the initial load, because they won't have been
        # run already.
        # If this is not the initial load, then each "before" handler
        # will have been run as the user stepped down into the suite.
        deep = not INTERNAL.isInitialized()
        beforeHandlers = @suite.getBefore(deep)
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

    events:
      'mouseover .uih-items > li': (e) -> Ctrl.fromElement(e)?.onMouseOver?(e)
      'mouseleave .uih-items > li': (e) -> Ctrl.fromElement(e)?.onMouseLeave?(e)

