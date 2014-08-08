fs = Npm.require('fs')


Meteor.methods
  'pkg/ui-harness/markdown': (path) ->
    fullPath = "#{ process.env.PWD }/#{ path.remove /^\// }"
    markdown = Async.runSync (done) ->
        fs.readFile fullPath, 'utf8', (err, data) ->
          if err
            done(err)
          else
            html = Markdown.toHtml(data)
            done(null, html)

    result =
      path:path
      html: markdown.result
