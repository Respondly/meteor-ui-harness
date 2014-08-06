Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    api:
      open: -> INTERNAL.index.insertFromRight(@suite)

    helpers:
      label: -> UTIL.formatText(@suite.name)

    events:
      'click': -> @api.open()
