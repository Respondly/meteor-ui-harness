#= require ../ns.js

###
Internal API for shared functions and state.
###
PKG.hash = hash = new ReactiveHash()


###
REACTIVE: Gets or sets the [Suite] or [Spec] list-item control
          that the mouse is currently over.
###
PKG.hoveredListItemCtrl = (value) -> hash.prop 'hoveredListItemCtrl', value, onlyOnChange:true



###
REACTIVE: Gets or sets whether the UIHarness has completed
          it's initial load sequence.
###
PKG.isInitialized = (value) -> hash.prop 'isInitialized', value, onlyOnChange:true, default:false



###
REACTIVE: Gets or sets the screen dimensions.
###
PKG.windowSize = (value) -> hash.prop 'windowSize', value


###
Loads the parent suite into the tree index.
###
PKG.gotoParentSuite = (callback) ->
  if parentSuite = UIHarness.suite()?.parent
    # Step up a level if this is a "section"
    # ie. [describe.section '', ->]
    parentSuite = parentSuite.parent if parentSuite.isSection

    if parentSuite is BDD.suite
      PKG.gotoRootSuite()
    else
      indexCtrl = UIHarness.configure.ctrls.index
      indexCtrl.insertFromLeft(parentSuite, callback)


###
Loads the root suite into the tree index.
###
PKG.gotoRootSuite = (callback) ->
  indexCtrl = UIHarness.configure.ctrls.index
  indexCtrl.insertFromLeft(BDD.suite, callback)
  UIHarness.reset()



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
PKG.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value


###
Invokes the "before" handlers for the given suite.
###
PKG.runBeforeHandlers = (suite, options = {}, callback) ->
  if suite
    deep = options.deep ? false
    beforeHandlers = suite.getBefore(deep)
    BDD.runMany beforeHandlers, { this:UIHarness, throw:true }, -> callback?()


###
Refrehses a suite, clearing stored state and
running all before handlers.
###
PKG.refreshSuite = (suite, options = {}) ->
  if suite
    # Clear all [localStorage] state.
    suite.localStorage.clear()
    for spec in suite.specs()
      spec.localStorage.clear()

    # Reset and run "before" handlers.
    UIHarness.reset()
    PKG.runBeforeHandlers(suite, options)






###
REACTIVE: Gets the current title/sub-title text for the header.
          This is set either from:

            1. Calling UIHarness.title(value)

            2. Setting @title within a describe block:

                describe 'suite', ->
                  @title('My Title')

###
PKG.headerText = (harness) ->
  harness ?= UIHarness

  formatValue = (value) ->
        return value unless Object.isString(value)
        PKG.formatText(value)

  getText = (prop) ->
        # Retrieve reactive values.
        viaProp   = harness[prop]()
        viaBefore = harness.suite()?.meta?[prop]

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
    if suiteName = harness.suite()?.name
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
PKG.formatText = (text) ->
  text = text.call(UIHarness) if Object.isFunction(text)
  text = Util.asValue(text)
  text = Markdown.toHtml(text)
  text = text.replace /\n/g, '<br>'
  text = '&nbsp;' if Util.isBlank(text)
  text

