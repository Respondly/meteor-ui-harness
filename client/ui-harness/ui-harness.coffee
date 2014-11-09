CommonMethods = stampit().enclose ->


  ###
  Resets the UIHarness to it's default state.
  ###
  @reset = ->
    @reset.hostCtrl?()
    # @hostCtrl?.reset()
    @delay?.reset()
    @autorun?.reset()
    @log?.reset()

  # ----------------------------------------------------------------------
  return @



UIHarnessFactory = stampit.compose(
  PKG.AutoRun,
  PKG.Config,
  CommonMethods,
  PKG.CtrlHost,
  PKG.Log,
  PKG.Delay,
  PKG.Lorem,
  PKG.Helpers
)



# ----------------------------------------------------------------------


###
Creates a new UIHarness model.
###
Ctrls.UIHarness = -> UIHarnessFactory()

