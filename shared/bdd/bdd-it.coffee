###
Declares a "spec" as a boolean property that can be toggled.

@param name: The name of the property
@param func: Optional. The test function.

###
it.boolean = (name, func) ->
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'boolean'
  meta.propName = name
  spec



###
Declares a "spec" with multiple dropdown options.

@param name:    The name of the property
@param options: The options:
                 - array
                 - object (key:value)
@param func:    Optional. The test function.

###
it.select = (name, options, func) ->
  { name, options, func } = fixOptionParams(name, options, func)
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'select'
  meta.propName = name
  meta.options = options
  spec




###
Declares a "spec" with multiple radio-button options.

@param name:    The name of the property
@param options: The options:
                 - array
                 - object (key:value)
@param func:    Optional. The test function.

###
it.radio = (name, options, func) ->
  { name, options, func } = fixOptionParams(name, options, func)
  spec = it(name, func)
  meta = spec.meta
  meta.type = 'radio'
  meta.propName = name
  meta.options = options
  spec


###
Declares a "spec" as a markdown file.

@param name:  The name of the spec.
              If not declared the title (h1) of the file is used.

@param file:  The markdown file, either
                - String: The path to the markdown file.
                - {file}  The file object, as declared on [Markdown.files].

@param func:   Optional. The test function.

###
it.md = (name, file, func) ->
  { name, file, func } = fixMarkdownParams(name, file, func)
  spec = it(name, func)
  spec = asMarkdown(spec, file)
  spec


# PRIVATE ----------------------------------------------------------------------


PKG.markdownSpec = (name, file, func) ->
  # Makes the new spec without putting it in the default parent
  # context that happens with "it" is called.
  { name, file, func } = fixMarkdownParams(name, file, func)
  spec = new BDD.Spec(name, func)
  spec = asMarkdown(spec, file)
  spec



asMarkdown = (spec, file) ->
  meta = spec.meta
  meta.type = 'markdown'
  meta.file = file
  spec



fixMarkdownParams = (name, file, func) ->
  if Object.isString(file)
    path = file
    file = Markdown.files[file]

  if not file?
    throw new Error("Markdown file not found: #{ path }")

  if not name?
    name = file.title
    name ?= '*Untitled*' # Italic.

  result =
    name: name
    file: file
    func: func



fixOptionParams = (name, options, func) ->
  if Object.isFunction(options) and not func?
    func = options
    options = null

  result =
    name: name
    options: options
    func: func
