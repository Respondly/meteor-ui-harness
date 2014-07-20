Ctrl.define
  'th-list-suite':
    init: -> @suite = @data

    events:
      'click': ->
        treeCtrl = @ctrl.parent.parent
        treeCtrl.insertFromRight(@suite)

