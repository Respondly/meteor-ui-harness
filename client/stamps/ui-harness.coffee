UIHarness = stampit
  ###
  Resets the UIHarness to it's default state.
  ###
  reset: ->
    @hostCtrl?.reset()
    @delay?.reset()
    @autorun?.reset()



###
Creates a new UIHarness model.
###
Ctrls.UIHarness = stampit.compose(
  PKG.stamps.AutoRun,
  PKG.stamps.CtrlHost,
  PKG.stamps.Config,
  PKG.stamps.Delay,
  PKG.stamps.Lorem,
  PKG.stamps.Log,
  PKG.stamps.Helpers,
  UIHarness
)

