Meteor.startup ->
  $(document).keydown (e) ->

    # Only react if the UIHarness has been instantiated.
    elTree = $('.th-suite-tree')
    return unless elTree.length > 0

    if e.which is 8 # DELETE / BACKSPACE
      # Step up to the parent suite if the DELETE/BACKSPACE key
      # was pressed while the mouse is over the index.
      TH.gotoParentSuite() if elTree.is(':hover')

      # Prevent backspacing off the page by default.
      e.preventDefault()