###
Handles the Boolean checkbox on a Spec index-tree item.
###
class INTERNAL.SpecTypeBoolean extends INTERNAL.SpecTypeBase
  ready: ->
    checkbox = @specCtrl.children.chk

    # Sync: Checkbox state.
    @autorun =>
      value = @prop()
      checkbox.isEnabled(Object.isBoolean(value))
      checkbox.toggle(value) if Object.isBoolean(value)



  onLoaded: -> @prop(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the boolean/checkbox UI element.
  ###
  localStorage: (value) -> @spec.localStorage 'bool-value', value



  onRun: ->
    # Toggle the value.
    @prop(not @prop())

    # Persist to [localStorage].
    @localStorage(@prop())
