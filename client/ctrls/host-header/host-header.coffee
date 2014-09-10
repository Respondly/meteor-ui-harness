Ctrl.define
  'uih-host-header':
    init: ->
      @harness = @data

      # Clear the custom title if the new suite has a title
      # set by the [@title] method that was set within the
      # [describe] block.
      @autorun =>
        suite = @harness.suite() # Hook into reactive context.
        Deps.nonreactive =>
            if metaValues = suite?.uiHarness
              @harness.title(null)    if INTERNAL.valueAsMarkdown(metaValues.title)?
              @harness.subtitle(null) if INTERNAL.valueAsMarkdown(metaValues.subtitle)?


    helpers:
      text: -> INTERNAL.headerText(@harness)

      cssClass: ->
        css = ''
        css += ' uih-show-hr' if @harness.title.hr()
        css

