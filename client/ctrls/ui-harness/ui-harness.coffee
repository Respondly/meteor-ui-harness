Ctrl.define
  'ui-harness':
    init: ->
      @harness = UIHarness
      @harness.configure.ctrls.uiHarness = @ctrl


    helpers:
      harness: -> @harness


