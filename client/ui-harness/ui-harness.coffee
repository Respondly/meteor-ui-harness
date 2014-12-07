CommonMethods = stampit().enclose ->

  @style = PKG.Style().init(@)

  ###
  Resets the UIHarness to it's default state.
  ###
  @reset = ->
    @reset.hostCtrl?()
    @delay?.reset()
    @autorun?.stop()
    @log?.reset()
    @style.reset()


  # ----------------------------------------------------------------------
  return @



UIHarnessFactory = stampit.compose(
  Stamps.AutoRun,
  PKG.Config,
  CommonMethods,
  PKG.CtrlHost,
  PKG.Log,
  PKG.Delay,
  PKG.Lorem
)



# ----------------------------------------------------------------------


###
Creates a new UIHarness model.
###
Ctrls.UIHarness = -> UIHarnessFactory()

