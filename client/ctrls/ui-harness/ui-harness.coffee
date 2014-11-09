Ctrl.define
  'ui-harness':
    init: ->
      @harness = UIHarness


    ready: ->
      console.log 'TODO - DO this in the instance of harness.'
      PKG.index = @children.index

      # Store referecnes.
      ctrls           = @harness.configure.ctrls
      ctrls.uiHarness = @ctrl
      ctrls.main      = @children.main
      ctrls.host      = @children.main.hostCtrl()
      ctrls.index     = @children.index


    helpers:
      harness: -> @harness


