###
Handles the Markdown spec type.
###
class PKG.SpecTypeMarkdown extends PKG.SpecTypeBase
  onRun: ->
    # Setup initial conditions.
    file = @meta.file
    title = file.title
    UIHarness.title('Loading...')
    UIHarness.subtitle(null)

    # Load the markdown as HTML.
    file.load (err, html) ->
      UIHarness.title(title ? null)
      html = "<div class='markdown-body'>#{ html }</div>"
      UIHarness.load html, size:'fill', margin:40, scroll:true, =>

        # Remove the title from the HTML as it's accounted
        # for the harness header.
        if title?
          el = UIHarness.el()
          UIHarness.el('h1').first().remove()

