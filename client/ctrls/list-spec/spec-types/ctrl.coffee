###
Handles the custom Ctrl on a Spec index-tree item.
###
class PKG.SpecTypeCtrl extends PKG.SpecTypeBase
  ready: ->
    type = @meta.options.type
    @customCtrl = @meta.ctrl = @specCtrl.context.findChild(type)


  onRun: ->
    # Pass execution down to the custom ctrl.
    harness = @spec.harness
    args =
      spec: @spec
      harness: harness
      log: harness.log
      ctrl: -> harness.ctrl()
    @customCtrl.onRun?(args)

