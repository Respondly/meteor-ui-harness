###
Handles the radio-buttons options on a Spec index-tree item.
###
class PKG.SpecTypeRadio extends PKG.SpecTypeBase
  ready: ->
    elRadioButtons = => @specCtrl.el('input[type="radio"]')

    getCheckbox = (value) =>
        value = 'null' if value is null
        value = 'undefined' if value is undefined
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


  onLoaded: ->
    @prop(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the radio UI element.
  ###
  localStorage: (value) ->
    @spec.localStorage 'radio-value', value


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

      # Escape [null] and [undefined] values.
      value = item.value
      value = 'null' if value is null
      value = 'undefined' if value is undefined
      item.value = value

      cssClass = ''
      cssClass += ' uih-blank-value' if not label? or label is ''
      item.cssClass = cssClass
      item.label = @formatLabel(label)

    result


  ###
  Invoked when the radio changes.
  ###
  onChange: (e) ->
    # Store the value.
    value = @formatValue(e.target.value)
    @localStorage(value)

    # Update the API.
    @prop(value)

    # Pass execution to the [Spec].
    @specCtrl.run()


# ----------------------------------------------------------------------


PKG.processSelectItem = (item) ->


