###
Handles the SELECT options on a Spec index-tree item.
###
class INTERNAL.SpecTypeSelect extends INTERNAL.SpecTypeBase
  ready: ->
    # Sync the <select> with the current property value.
    propName = @propName
    @autorun =>
      if ctrl = UIHarness.ctrl()
        if Object.isFunction(ctrl[propName])
          value = ctrl[propName]()
          @specCtrl.el('select').val(value)


  onCtrlLoaded: (ctrl) -> @setProp(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the <select> UI element.
  ###
  localStorage: (value) -> @spec.localStorage 'select-value', value


  ###
  The <option> values used by the template.
  ###
  options: ->
    options = @meta.options
    result = []
    if Object.isArray(options)
      for item in options
        result.push { label:item, value:item }

    if Object.isObject(options)
      for key, value of options
        result.push { label:key, value:value }
    result


  ###
  Invoked when the <select> changes.
  ###
  onChange: (e) ->
    value = e.target.value
    @localStorage(value)
    UIHarness.ctrl()?[@meta.propName]?(value)
    @specCtrl.run()
