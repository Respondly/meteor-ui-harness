Ctrl.define
  'th-list-suite':
    init: -> @suite = @data

    events:
      'click': -> LOCAL.index.insertFromRight(@suite)


