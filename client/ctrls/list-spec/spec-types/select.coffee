###
Handles the SELECT options on a Spec index-tree item.
###
class INTERNAL.SpecTypeSelect extends INTERNAL.SpecTypeBase
  ready: ->
    # Sync the <select> with the current property value.
    @autorun =>
      @specCtrl.el('select').val(@prop())


  onLoaded: -> @prop(@localStorage())


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

    for item in result
      label = item.label
      item.label = 'null' if label is null
      item.label = 'false' if label is false
      item.label = 'undefined' if label is undefined
      item.label = '<empty>' if label is ''

    result


  ###
  Invoked when the <select> changes.
  ###
  onChange: (e) ->
    # Store the new value.
    value = e.target.value
    value = null if value is 'null'
    value = true if value is 'true'
    value = false if value is 'false'

    @localStorage(value)

    # Update the API.
    @prop(value)

    # Pass execution to the [Spec].
    @specCtrl.run()
