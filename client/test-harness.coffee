#= require ./api.js


###
Root API for the TestHarness
###
class TH.TestHarness
  ###
  Inserts a visual element into the [Host].
  @param content: The control to insert. Can be:
                  - Ctrl (definition)
                  - Ctrl (instance)
                  - DOM element
                  - jQuery element
                  - String (HTML)
  @param options:
  ###
  load: (content, options, callback) ->
    TH.host.insert(content, options, callback)




# EXPORT ----------------------------------------------------------------------



TestHarness = new TH.TestHarness()