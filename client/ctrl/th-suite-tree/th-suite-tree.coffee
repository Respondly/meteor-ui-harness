SLIDE_DURATION = 200 # msecs.


###
The root of the tree.
Handles navigation through the hierarchy of lists.
###
Ctrl.define
  'th-suite-tree':
    init: -> TH.index = @ctrl
    created: ->
      # Retrieve the Suite that was last loaded from [localStorage].
      if uid = TH.currentSuiteUid()
        suite = BDD.suite.findOne(uid:uid)

      # Load the tree with the initial Suite.
      @api.insert(suite ? BDD.suite)

      # Mark as loaded
      # NB: This prevents the [<] arrow from animating
      #     on first load.
      Util.delay =>
        @el().addClass('th-loaded')


    destroyed: ->
      @api.currentListCtrl()?.dispose()
      TestHarness.suite(null)


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
        @isInserting = true
        isAnimated = options.direction?
        options.suite = suite

        switch options.direction
          when 'left'
            revealClass = 'th-right'
            hideClass   = 'th-left'
          when 'right'
            revealClass = 'th-left'
            hideClass   = 'th-right'

        # Hide the existing list.
        if current = @api.currentListCtrl()
          current.el().addClass(hideClass)

        fadeTitle = (toggle) => @find('.th-title').toggleClass('th-fade-out', not toggle)

        # Insert the new list.
        args =
          suite: suite
          cssClass: revealClass
        result = @appendCtrl('th-list', '.th-tree-outer', data:args)
        result.ready =>
            listCtrl = result.ctrl
            TestHarness.suite(suite)

            onComplete = =>
                  # Store state.
                  retiredListCtrl = @api.currentListCtrl()
                  @api.currentListCtrl(listCtrl)

                  retire = (ctrl, done) ->
                      return done() unless ctrl?
                      ctrl.onHidden ->
                          ctrl.dispose()
                          done()

                  initialize = (ctrl, done) ->
                      return done() unless ctrl?
                      ctrl.onRevealed(done)

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
      hasParent: -> TestHarness.suite()?.parent?
      cssClasses: -> 'th-has-parent' if @helpers.hasParent()
      title: (value) -> @prop 'title', value


    events:
      'click .th-back-btn': -> TH.gotoParentSuite()





