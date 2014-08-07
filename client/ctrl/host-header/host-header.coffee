Ctrl.define
  'uih-host-header':
    init: ->
      # Clear the custom title if the new suite has a title
      # set by the [@title] method that was set within the
      # [describe] block
      @autorun =>
        suite = UIHarness.suite() # Hook into reactive context.
        Deps.nonreactive =>
            if Util.asValue(suite?.uiHarness?.title)
              UIHarness.title(null)

    helpers:
      text: -> INTERNAL.headerText()

