Ctrl.define
  'th-list-suite':
    init: -> @suite = @data

    events:
      'click': -> TH.index.insertFromRight(@suite)


