SLIDE_DURATION = 200 # msecs.


###
The root of the tree.
Handles navigation through the hierarchy of lists.
###
Ctrl.define
  'th-suite-tree':
    created: -> @api.insert(BDD.suite)
    destroyed: -> @currentListCtrl()?.dispose()

    api:
      currentListCtrl: (value) -> @prop 'currentSuite', value
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
            ctrl = result.ctrl

            onComplete = =>
                @api.currentListCtrl()?.dispose()
                @api.currentListCtrl(ctrl)
                callback?(ctrl)

            if isAnimated
              # Remove the offset class.
              Util.delay 100, =>
                  ctrl.el().removeClass(revealClass)
                  Util.delay SLIDE_DURATION, => onComplete()

            else
              onComplete() # No slide animation.


