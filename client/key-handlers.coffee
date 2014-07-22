Meteor.startup ->
  $(document).keydown (e) ->
    if e.which is 8 # DELETE / BACKSPACE

      # Step up to the parent suite if the DELETE/BACKSPACE key
      # was pressed while the mouse is over the index.
      TH.gotoParentSuite() if $('.th-suite-tree').is(':hover')

      # Prevent backspacing off the page by default.
      e.preventDefault()