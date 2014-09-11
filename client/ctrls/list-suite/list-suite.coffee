Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    api:
      open: -> PKG.index.insertFromRight(@suite)

    helpers:
      label: -> PKG.formatText(@suite.name)

    events:
      'click': -> @api.open()
