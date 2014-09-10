Ctrl.define
  'ui-harness':
    ready: ->
      INTERNAL.index = @children.index


    helpers:
      harness: -> UIHarness


