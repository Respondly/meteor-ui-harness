Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    api:
      open: -> INTERNAL.index.insertFromRight(@suite)

    helpers:
      label: -> INTERNAL.formatText(@suite.name)

    events:
      'click': -> @api.open()
