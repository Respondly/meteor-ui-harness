Ctrl.define
  'uih-list-suite':
    init: -> @suite = @data

    events:
      'click': -> INTERNAL.index.insertFromRight(@suite)


