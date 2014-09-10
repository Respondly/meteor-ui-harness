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
      onRevealed: (direction, callback) ->
        # Run all the "before" handlers in the hierarchy if
        # this is the initial load, because they won't have been
        # run already.
        # If this is not the initial load, then each "before" handler
        # will have been run as the user stepped down into the suite.
        deep = not INTERNAL.isInitialized()
        INTERNAL.runBeforeHandlers(@suite, deep:deep, callback)

      ###
      Invoked immediately before the list is taken off screen.
      ###
      onHiding: (direction, callback) ->
        if direction is 'right'
          # Only run "after" handlers if the user is stepping up/out
          # of the suite, not drilling deeper down into the suite.
          afterHandlers = @suite.getAfter()
          BDD.runMany afterHandlers, { this:UIHarness, throw:true }, -> callback?()

        else
          callback?()


      ###
      Invoked when the list has been taken off screen.
      ###
      onHidden: (direction, callback) -> callback?()


    helpers:
      cssClass: ->
        css = @data.cssClass ? ''
        css += ' uih-is-section' if @suite.isSection
        css += ' uih-not-section' if not @suite.isSection
        css

      showSearch: -> @suite.isSection isnt true

      mouseOver: (e, isOver) ->
        # Store a reference to the currently overed list-item ctrl.
        if isOver
          ctrl = Ctrl.fromElement(e) ? null
        else
          ctrl = null
        INTERNAL.hoveredListItemCtrl(ctrl)

      isEmpty: -> @suite.items.length is 0

      items: ->
        # Setup initial conditions.
        items = []
        childSuites = []

        # Seperate out items for this list, vs. child suites.
        for item in @suite.items
          if (item instanceof BDD.Spec)
            items.push({ isSpec:true, data:item })

          if (item instanceof BDD.Suite)
            asSection = (item.isSection and @data.expandSections)
            suiteData =
              asSection: asSection
              isSuite:true
              data:item
            if asSection then items.push(suiteData) else childSuites.push(suiteData)

        # Finish up.
        childSuites = childSuites.sortBy (item) -> item.data.name
        [childSuites, items].flatten()



    events:
      'mouseenter ul.uih-items > li': (e) -> @helpers.mouseOver(e, true)
      'mouseleave ul.uih-items > li': (e) -> @helpers.mouseOver(e, false)


