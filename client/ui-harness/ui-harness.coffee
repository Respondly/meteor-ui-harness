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
  PKG.AutoRun,
  PKG.CtrlHost,
  PKG.Config,
  PKG.Delay,
  PKG.Lorem,
  PKG.Log,
  PKG.Helpers,
  UIHarness
)

