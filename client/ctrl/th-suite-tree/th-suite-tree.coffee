SLIDE_DURATION = 200 # msecs.


###
The root of the tree.
Handles navigation through the hierarchy of lists.
###
Ctrl.define
  'th-suite-tree':
    created: -> @api.insert(BDD.suite)
    destroyed: ->
      @api.currentListCtrl()?.dispose()
      @api.currentSuite(null)

    api:
      currentSuite: (value) -> @prop 'currentSuite', value
      currentListCtrl: (value) -> @prop 'currentListCtrl', value
      insertFromRight: (suite) -> @api.insert(suite, direction:'left')
      insertFromLeft: (suite) -> @api.insert(suite, direction:'right')



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

        # Insert the new list.
        args =
          suite: suite
          cssClass: revealClass
        result = @appendCtrl('th-list', '.th-tree-outer', data:args)
        result.ready =>
            listCtrl = result.ctrl
            @api.currentSuite(suite)

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
                      callback?() # Complete.

            if isAnimated
              # Remove the offset class.
              Util.delay 0, =>
                  listCtrl.el().removeClass(revealClass)
                  Util.delay SLIDE_DURATION, => onComplete()
            else
              onComplete() # No slide animation.



    helpers:
      hasParent: -> @api.currentSuite()?.parent?
      cssClasses: -> 'th-has-parent' if @helpers.hasParent()

    events:
      'click .th-back-btn': ->
        if suite = @api.currentSuite()?.parent
          @api.insertFromLeft(suite)


