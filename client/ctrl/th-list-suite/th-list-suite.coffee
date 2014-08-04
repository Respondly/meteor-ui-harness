Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    events:
      'click': -> LOCAL.index.insertFromRight(@suite)


