Ctrl.define
  'ui-harness':
    ready: ->
      INTERNAL.index = @children.index
      INTERNAL.main = @children.main
      INTERNAL.mainHost = @children.main.hostCtrl()

    helpers:
      harness: -> UIHarness


