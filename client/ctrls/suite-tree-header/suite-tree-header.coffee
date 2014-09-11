Ctrl.define
  'uih-suite-tree-header':
    api:
      title: (value) -> @prop 'title', value
      fadeTitle: (toggle) -> @el('.uih-title').toggleClass('uih-fade-out', not toggle)


    helpers:
      title: -> @api.title()?.remove(/`/g)


    events:
      'click .uih-refresh-btn': (e) -> PKG.refreshSuite(UIHarness.suite(), deep:false)
      'click .uih-back-btn': (e) ->
        if e.metaKey
          PKG.gotoRootSuite()
        else
          PKG.gotoParentSuite()


