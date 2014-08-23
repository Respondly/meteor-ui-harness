KEYS =
  DELETE: 8
  ENTER: 13
  CURSOR_LEFT: 37
  CURSOR_RIGHT: 39



Meteor.startup ->
  $(document).keydown (e) ->
      # Only react if the UIHarness has been instantiated.
      elTree = $('.uih-suite-tree')
      return unless elTree.length > 0
      isOverTree = elTree.is(':hover')
      keyCode = e.which

      # Handle "step up the hierarchy" keys.
      if keyCode is KEYS.DELETE or keyCode is KEYS.CURSOR_LEFT
        # Step up to the parent suite if the DELETE/BACKSPACE key
        # was pressed while the mouse is over the index.
        if isOverTree
          if e.metaKey
            INTERNAL.gotoRootSuite()
          else
            INTERNAL.gotoParentSuite()

        # Prevent backspacing off the page by default.
        e.preventDefault()


      # Handle "open suite" keys (right key).
      if isOverTree and (keyCode is KEYS.CURSOR_RIGHT or keyCode is KEYS.ENTER)
        if ctrl = INTERNAL.hoveredListItemCtrl()
          type = ctrl.type
          if type.endsWith('-suite')
            ctrl.open()

          if type.endsWith('-spec')
            ctrl.run()




