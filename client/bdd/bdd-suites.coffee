###
Declares a "suite" as a set of markdown documents.

@param name:       The title of the suite.
@param folderPath: The path to the root folder containing the markdown documents.
@param func:       The suite function.

@returns the resulting [Suite] object.
###
describe.md = (name, folderPath, func) ->
  # Fix up parameters.
  if Object.isFunction(folderPath)
    func = folderPath

  if not Object.isString(folderPath)
    folderPath = name

  # Setup initial conditions.
  suite       = describe(name, func)
  meta        = suite.meta
  meta.type   = 'markdown'
  meta.folder = folderPath
  meta.files  = files = {}

  # Store file references.
  for key, value of Markdown.files
    if key.startsWith(folderPath)
      files[key] = value

  # Add child specs.
  for path, file of files
    spec = INTERNAL.markdownSpec(null, path)
    suite.addSpec(spec)

  # Finish up.
  suite


