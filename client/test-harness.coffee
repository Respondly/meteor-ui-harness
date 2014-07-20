#= require ./api.js


###
Root API for the TestHarness
###
class TH.TestHarness
  ###
  Retrieves the element for the content that is currently under test.
  ###
  el: -> $(TH.host?.elContainer()?.children()?[0])


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
  @param value:
           - 'width,height', eg: '20,30'
           - 'fill'
           - 'auto' (default)
  ###
  size: (value) -> TH.host.size(value)


  ###
  Gets or sets the alignment of the hosted control.
  @param value: {x:y}
           - 'center,middle' (default)
           - x: left|center|right
           - y: top|middle|bottom
  ###
  align: (value) -> TH.host.align(value)





# EXPORT ----------------------------------------------------------------------



TestHarness = new TH.TestHarness()