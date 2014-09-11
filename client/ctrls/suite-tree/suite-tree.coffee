SLIDE_DURATION = 200 # msecs.


###
The root of the tree.
Handles navigation through the hierarchy of lists.
###
Ctrl.define
  'uih-suite-tree':
    ready: ->
      # Retrieve the Suite that was last loaded from [localStorage].
      if uid = PKG.currentSuiteUid()
        suite = BDD.suite.findOne(uid:uid)

      # Load the tree with the initial Suite.
      @api.insert(suite ? BDD.suite)

      # Mark as loaded
      # NB: This prevents the [<] arrow from animating
      #     on first load.
      Util.delay =>
        @el().addClass('uih-loaded')
        PKG.isInitialized(true)


    destroyed: ->
      @api.currentListCtrl()?.dispose()
      UIHarness.suite(null)


    api:
      title: (value) -> @children.header.title(value)
      currentSuite: (value) -> @prop 'currentSuite', value
      currentListCtrl: (value) -> @prop 'currentListCtrl', value

      insertFromRight: (suite, callback) -> @api.insert(suite, direction:'left', callback)
      insertFromLeft: (suite, callback) -> @api.insert(suite, direction:'right', callback)



      ###
      Inserts a suite list.
      @param suite: The suite.
      @param options:
                - cssClass: The offset class used to slide on/off.
      @param callback: The function to invoke upon completion.
      ###
      insert: (suite, options = {}, callback) ->
        # Setup initial conditions.
        return if @isInserting
        @isInserting  = true
        direction     = options.direction
        isAnimated    = direction?
        options.suite = suite
        headerCtrl    = @children.header

        switch direction
          when 'left'
            revealClass = 'uih-right'
            hideClass   = 'uih-left'
          when 'right'
            revealClass = 'uih-left'
            hideClass   = 'uih-right'

        # Hide the existing list.
        if current = @api.currentListCtrl()
          current.el().addClass(hideClass)

        # Insert the new list.
        args =
          suite: suite
          cssClass: revealClass
          expandSections: true
        listCtrl = @appendCtrl('uih-list', '.uih-tree-outer', data:args)

        listCtrl.onReady =>
            # Store new state.
            UIHarness.suite(suite)
            PKG.hoveredListItemCtrl(null)

            onComplete = =>
                  # Store state.
                  retiredListCtrl = @api.currentListCtrl()
                  @api.currentListCtrl(listCtrl)

                  retire = (ctrl, done) ->
                      return done() unless ctrl?
                      ctrl.onHidden direction, ->
                          ctrl.dispose()
                          done()

                  initialize = (ctrl, done) ->
                      return done() unless ctrl?
                      ctrl.onRevealed(direction, done)

                  # Finish up.
                  retire retiredListCtrl, =>
                    initialize listCtrl, =>
                      delete @isInserting
                      @api.title(suite.name ? 'UI Harness')
                      Util.delay 10, => headerCtrl.fadeTitle(true)
                      callback?() # Complete.

            removeList = =>
                if isAnimated
                  # Remove the offset class.
                  Util.delay 0, =>
                      listCtrl.el().removeClass(revealClass)
                      headerCtrl.fadeTitle(false)
                      Util.delay SLIDE_DURATION, => onComplete()
                else
                  onComplete() # No slide animation.

            # Alert the list that it is about to be hidden.
            if currentListCtrl = @api.currentListCtrl()
              currentListCtrl.onHiding direction, => removeList()
            else
              removeList()


    helpers:
      hasParent: -> UIHarness.suite()?.parent?
      cssClasses: -> 'uih-has-parent' if @helpers.hasParent()








