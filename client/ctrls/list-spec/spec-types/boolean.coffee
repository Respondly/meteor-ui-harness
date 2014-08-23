###
Handles the Boolean checkbox on a Spec index-tree item.
###
class INTERNAL.SpecTypeBoolean extends INTERNAL.SpecTypeBase
  ready: ->
    checkbox = @specCtrl.children.chk
    propName = @propName

    # Sync: Checkbox state.
    @autorun =>
      if ctrl = UIHarness.ctrl()
        if Object.isFunction(ctrl[propName])
          value = ctrl[propName]()
          checkbox.isEnabled(Object.isBoolean(value))
          checkbox.toggle(value) if Object.isBoolean(value)


  onCtrlLoaded: (ctrl) -> @setProp(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the boolean/checkbox UI element.
  ###
  localStorage: (value) -> @spec.localStorage 'bool-value', value



  onRun: ->
    # Toggle the value.
    UIHarness.toggle(@spec.name)

    # Persist to [localStorage].
    value = UIHarness.ctrl()?[@propName]?()
    @localStorage(value)
