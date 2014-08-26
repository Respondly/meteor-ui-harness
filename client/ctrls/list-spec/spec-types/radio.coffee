###
Handles the radio-buttons options on a Spec index-tree item.
###
class INTERNAL.SpecTypeRadio extends INTERNAL.SpecTypeBase
  ready: ->
    elRadioButtons = => @specCtrl.el('input[type="radio"]')

    getCheckbox = (value) =>
        value = value?.toString()
        for el in elRadioButtons()
          el = $(el)
          return el if value is el.val()

    # Sync the selected radio button with the current property value.
    propName = @propName
    @autorun =>
      # Reset radio buttons.
      el = elRadioButtons()
      el.prop('checked', false)
      el.closest('label').toggleClass('uih-not-checked', true)
      el.closest('label').toggleClass('uih-checked', false)

      # Update the checked radio button.
      value = @prop()
      if el = getCheckbox(value)
        el.prop('checked', true)
        el.closest('label').toggleClass('uih-not-checked', false)
        el.closest('label').toggleClass('uih-checked', true)


  onLoaded: -> @prop(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the radio UI element.
  ###
  localStorage: (value) -> @spec.localStorage 'radio-value', value


  ###
  The <option> values used by the template.
  ###
  options: ->
    uid = @spec.uid()
    options = @meta.options
    result = []
    if Object.isArray(options)
      for item in options
        result.push { uid:uid, label:item, value:item }

    if Object.isObject(options)
      for key, value of options
        result.push { uid:uid, label:key, value:value }

    for item in result
      label = item.label
      cssClass = ''
      cssClass += ' uih-blank-value' if not label? or label is ''
      item.cssClass = cssClass
      item.label = 'null' if label is null
      item.label = 'undefined' if label is undefined
      item.label = '<empty>' if label is ''

    result


  ###
  Invoked when the radio changes.
  ###
  onChange: (e) ->
    # Store the value.
    value = e.target.value
    @localStorage(value)

    # Update the API.
    @prop(value)
    # UIHarness.ctrl()?[@meta.propName]?(value)

    # Pass execution to the [Spec].
    @specCtrl.run()





