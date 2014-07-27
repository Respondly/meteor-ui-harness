#= require ./internal-api.js
@expect = chai.expect

hash = new ReactiveHash()


# ----------------------------------------------------------------------


###
Root API for the TestHarness
###
class TH.TestHarness
  ###
  REACTIVE Gets or sets the current [Suite].
  ###
  suite: (value) -> hash.prop 'suite', value, default:null


  ###
  REACTIVE Retrieves the element for the content that is currently under test.
  ###
  el: (value) -> hash.prop 'el', value, default:null


  ###
  REACTIVE Retrieves the Ctrl that is currently under test (if exists).
  ###
  ctrl: (value) -> hash.prop 'ctrl', value, default:null



  ###
  Inserts a visual element into the [Host].
  @param content: The control to insert. Can be:
                  - Ctrl (definition)
                  - Ctrl (instance)
                  - DOM element
                  - jQuery element
                  - String (HTML)
  @param options:
            - size:       The size of the control:
                             - 'width,height', eg: '20,30'
                             - 'fill'
                             - 'auto' (default)

            - align:      How to align the control within the host (x:y):
                             - 'center,middle' (default)
                             - x: left|center|right
                             - y: top|middle|bottom

            - margin:     The margin to place around the hosted control
                          when the size is set to 'fill'.
                             String: {left|top|right|bottom}
  ###
  load: (content, options, callback) -> TH.host.insert(content, options, callback)



  ###
  Removes the hosted control.
  ###
  clear: -> TH.host.clear()


  ###
  Resets the TestHarness to it's default state.
  ###
  reset: -> TH.host.reset()


  ###
  Updates the visual state of the test-harness.
  ###
  updateState: -> TH.host.updateState()


  ###
  Gets or sets the size of the hosted controls
  @param value: String
           - 'width,height', eg: '20,30'
           - 'fill'
           - 'auto' (default)
  ###
  size: (value) -> TH.host.size(value)


  ###
  Gets or sets the alignment of the hosted control.
  @param value: String - {x:y}
           - 'center,middle' (default)
           - x: left|center|right
           - y: top|middle|bottom
  ###
  align: (value) -> TH.host.align(value)


  ###
  Gets or sets the margin around the content.
  Relevant when 'size' is set to 'fill'.
  @param value: String - {left|top|right|bottom}
  ###
  margin: (value) -> TH.host.margin(value)


  ###
  Toggles a boolean property method on the ctrl.
  @param attr:    The name of the property.
  @param value:   (optional) The boolean value to set.
                             Calculates the opposite if not specified.
  ###
  toggle: (attr, value) ->
    if ctrl = @ctrl()
      # Ensure the property exists.
      unless Object.isFunction(ctrl[attr])
        throw new Error("The control does not have a property named '#{ attr }'.")

      # Determine the new toggled value.
      unless value?
        value = ctrl[attr]()
        value = true if (not value?) or Util.isBlank(value)
        unless Object.isBoolean(value)
          throw new Error("Cannot toggle because the current '#{ attr }' value is not a boolean. (Value: #{ value })")
        value = not value

      # Update the property.
      ctrl[attr](value)
      value






# EXPORT ----------------------------------------------------------------------


TestHarness = new TH.TestHarness()





