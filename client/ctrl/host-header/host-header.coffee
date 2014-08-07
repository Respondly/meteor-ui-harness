Ctrl.define
  'uih-host-header':
    init: ->
      # Clear the custom title if the new suite has a title
      # set by the [@title] method that was set within the
      # [describe] block
      @autorun =>
        suite = UIHarness.suite() # Hook into reactive context.
        Deps.nonreactive =>
            if metaValues = suite?.uiHarness
              UIHarness.title(null) if Util.asValue(metaValues.title)?
              UIHarness.subtitle(null) if Util.asValue(metaValues.subtitle)?


    helpers:
      text: -> INTERNAL.headerText()

