#= require ../ns.client.js

###
Internal API for shared functions and state.
###
INTERNAL.hash = hash = new ReactiveHash()


###
REACTIVE: Gets or sets the [Suite] or [Spec] list-item control
          that the mouse is currently over.
###
INTERNAL.hoveredListItemCtrl = (value) -> hash.prop 'hoveredListItemCtrl', value, onlyOnChange:true



###
REACTIVE: Gets or sets whether the UIHarness has completed
          it's initial load sequence.
###
INTERNAL.isInitialized = (value) -> hash.prop 'isInitialized', value, onlyOnChange:true, default:false



###
REACTIVE: Gets or sets the screen dimensions.
###
INTERNAL.windowSize = (value) -> hash.prop 'windowSize', value


###
Loads the parent suite into the tree index.
###
INTERNAL.gotoParentSuite = (callback) ->
  if parentSuite = UIHarness.suite()?.parent
    # Step up a level if this is a "section"
    # ie. [describe.section '', ->]
    parentSuite = parentSuite.parent if parentSuite.isSection

    if parentSuite is BDD.suite
      INTERNAL.gotoRootSuite()
    else
      INTERNAL.index.insertFromLeft(parentSuite, callback)


###
Loads the root suite into the tree index.
###
INTERNAL.gotoRootSuite = (callback) ->
  INTERNAL.index.insertFromLeft(BDD.suite, callback)
  UIHarness.reset()



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
INTERNAL.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value


###
Invokes the "before" handlers for the given suite.
###
INTERNAL.runBeforeHandlers = (suite, options = {}, callback) ->
  if suite
    deep = options.deep ? false
    beforeHandlers = suite.getBefore(deep)
    BDD.runMany beforeHandlers, { this:UIHarness, throw:true }, -> callback?()


###
Refrehses a suite, clearing stored state and
running all before handlers.
###
INTERNAL.refreshSuite = (suite, options = {}) ->
  if suite
    # Clear all [localStorage] state.
    suite.localStorage.clear()
    for spec in suite.specs()
      spec.localStorage.clear()

    # Reset and run "before" handlers.
    UIHarness.reset()
    INTERNAL.runBeforeHandlers(suite, options)






###
REACTIVE: Gets the current title/sub-title text for the header.
          This is set either from:

            1. Calling UIHarness.title(value)

            2. Setting @title within a describe block:

                describe 'suite', ->
                  @title('My Title')

###
INTERNAL.headerText = ->
  formatValue = (value) ->
        return value unless Object.isString(value)
        INTERNAL.formatText(value)

  getText = (prop) ->
        # Retrieve reactive values.
        viaProp   = UIHarness[prop]()
        viaBefore = UIHarness.suite()?.meta?[prop]

        # Explicitly set title values on [UIHarness].
        if viaProp isnt undefined
          return formatValue(viaProp)

        # Fall back to the @title(...) value set within the "describe" function.
        if viaBefore isnt undefined
          return formatValue(viaBefore)

  title = getText('title')
  subtitle = getText('subtitle')

  title = true if title is undefined
  if title is true
    if suiteName = UIHarness.suite()?.name
      title = formatValue(suiteName)

  title = null if title is false or title is '&nbsp;'
  subtitle = null if subtitle is false or subtitle is '&nbsp;'

  # Finish up.
  result =
    title:    title
    subtitle: subtitle
    isBlank:  (Util.isBlank(title) and Util.isBlank(subtitle))




###
Formats the text of labels within the index tree.
###
INTERNAL.formatText = (text) ->
  text = text.call(UIHarness) if Object.isFunction(text)
  text = Util.asValue(text)
  text = Markdown.toHtml(text)
  text = '&nbsp;' if Util.isBlank(text)
  text

