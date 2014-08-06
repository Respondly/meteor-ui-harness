#= require ./ns.js


###
Formats the text of labels within the index tree.
###
UTIL.formatText = (text) ->
  text = ticksToCode(text)
  text = '&nbsp;' if Util.isBlank(text)
  text



# PRIVATE ----------------------------------------------------------------------


###
Convert `foo` => <code>foo</code>
###
ticksToCode = (text) ->
  return text unless text.indexOf('`') > -1
  result = []
  withinBlock = false
  block = null

  startBlock = ->
      block = []
      result.push(block)
  startBlock()

  convertTick = ->
      switch withinBlock
        when true
          block.push('</code>')
          startBlock()
          withinBlock = false

        when false
          startBlock()
          block.push('<code>')
          withinBlock = true

  for char in text
    if char is '`' then convertTick() else block.push(char)

  # Finish up.
  result.flatten().join('')

