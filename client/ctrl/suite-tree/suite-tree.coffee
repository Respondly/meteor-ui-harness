SLIDE_DURATION = 200 # msecs.


###
The root of the tree.
Handles navigation through the hierarchy of lists.
###
Ctrl.define
  'uih-suite-tree':
    created: ->
      # Retrieve the Suite that was last loaded from [localStorage].
      if uid = INTERNAL.currentSuiteUid()
        suite = BDD.suite.findOne(uid:uid)

      # Load the tree with the initial Suite.
      @api.insert(suite ? BDD.suite)

      # Mark as loaded
      # NB: This prevents the [<] arrow from animating
      #     on first load.
      Util.delay =>
        @el().addClass('uih-loaded')
        INTERNAL.isInitialized(true)



    destroyed: ->
      @api.currentListCtrl()?.dispose()
      UIHarness.suite(null)


    api:
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

        fadeTitle = (toggle) => @find('.uih-title').toggleClass('uih-fade-out', not toggle)

        # Insert the new list.
        args =
          suite: suite
          cssClass: revealClass
        result = @appendCtrl('uih-list', '.uih-tree-outer', data:args)
        result.ready =>
            listCtrl = result.ctrl
            UIHarness.suite(suite)

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
                      @helpers.title(suite.name ? 'UI Harness')
                      Util.delay 10, => fadeTitle(true)
                      callback?() # Complete.

            if isAnimated
              # Remove the offset class.
              Util.delay 0, =>
                  listCtrl.el().removeClass(revealClass)
                  fadeTitle(false)
                  Util.delay SLIDE_DURATION, => onComplete()
            else
              onComplete() # No slide animation.



    helpers:
      hasParent: -> UIHarness.suite()?.parent?
      cssClasses: -> 'uih-has-parent' if @helpers.hasParent()
      title: (value) -> @prop 'title', value


    events:
      'click .uih-back-btn': (e) ->
        if e.metaKey
          INTERNAL.gotoRootSuite()
        else
          INTERNAL.gotoParentSuite()






