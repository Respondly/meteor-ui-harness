Ctrl.define
  'ui-harness':
    init: ->
      @harness = UIHarness


    ready: ->
      # Store referecnes.
      ctrls           = @harness.configure.ctrls
      ctrls.uiHarness = @ctrl
      ctrls.main      = @children.main
      ctrls.host      = @children.main.hostCtrl()
      ctrls.index     = @children.index


    helpers:
      harness: -> @harness


