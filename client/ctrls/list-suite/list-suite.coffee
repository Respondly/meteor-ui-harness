Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    api:
      open: ->
        UIHarness.configure.ctrls.index.insertFromRight(@suite)

    helpers:
      label: -> PKG.formatText(@suite.name)

    events:
      'click': -> @api.open()
