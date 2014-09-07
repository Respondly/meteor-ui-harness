###
Declares a "suite" as a set of markdown documents.

@param name:       The title of the suite.
@param folderPath: The path to the root folder containing the markdown documents.
@param func:       The suite function.

@returns the resulting [Suite] object.
###
describe.md = (name, folderPath, func) -> describe.markdown(name, folderPath, func)
describe.markdown = (name, folderPath, func) ->
  # Setup initial conditions.
  suite       = describe(name, func)
  meta        = suite.meta
  meta.type   = 'markdown'
  meta.folder = folderPath
  meta.paths  = paths = {}

  # Store paths.
  for key, value of Markdown.files
    if key.startsWith(folderPath)
      paths[key] = value

  # Finish up.
  suite


