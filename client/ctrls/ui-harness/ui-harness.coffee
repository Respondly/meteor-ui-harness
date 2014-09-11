Ctrl.define
  'ui-harness':
    ready: ->
      PKG.index = @children.index


    helpers:
      harness: -> UIHarness


