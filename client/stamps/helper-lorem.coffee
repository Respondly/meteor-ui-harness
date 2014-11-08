LOREM = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
LOREM_WORDS = LOREM.split(' ')


###
Helpers for generating "lorem ipsum..." sample text.
###
PKG.stamps.Lorem = stampit
  ###
  Generates a string of Lorem Ipsum
  @param options: The number of words, or an object:
                    - words:        The total number of words to return.
                                    Default: 30
                    - random:       Flag indicating if the string should be generated from
                                    a random starting place.
                                    Default:true
                    - period:       Flag indicating if the string should end
                                    in a period (.)
                                    Default:true
                    - capitalize:   Flag indicating if the result should
                                    start with a capital letter.
                                    Default:true
  ###
  lorem: (options) ->
    # Setup initial conditions.
    options = { words:(options ? 30) } unless Object.isObject(options)
    options.period      = true unless options.period?
    options.capitalize  = true unless options.capitalize?
    options.random      = true unless options.random?

    # Prepare a specific number of words.
    result = []
    index = switch options.random
              when true then Number.random(0, LOREM_WORDS.length - 1)
              when false then 0

    for i in [0..(options.words - 1)]
      result.push(LOREM_WORDS[index])
      index += 1
      index = 0 if index > LOREM_WORDS.length
    result = result.join(' ')

    # Format result.
    result = result.remove /,$/
    result = result.remove /.$/
    result = result.trim()
    result += '.' if options.period is true
    if options.capitalize is true and result.length > 1
      result = "#{ result[0].capitalize() }#{ result.substring(1, result.length) }"

    # Finish up.
    result


