Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    api:
      open: -> INTERNAL.index.insertFromRight(@suite)
      onMouseOver: (e) -> INTERNAL.overSuiteCtrl(@ctrl)
      onMouseLeave: (e) -> INTERNAL.overSuiteCtrl(null)

    helpers:
      label: -> UTIL.formatText(@suite.name)

    events:
      'click': -> @api.open()
