###
Creates a device object from a definition string.
@param value: A string containing [device/version/orientation]
@returns object.
###
PKG.toDevice = (value) ->
  # Setup initial conditions.
  return unless Object.isString(value)

  # Extract parts from the definition.
  parts = value.split(':')
  result =
    type:    (parts[0] ? 'iphone').toLowerCase()
    version: (parts[1] ? '6').toLowerCase()

  # Determine size.
  size = (width, height) -> result.size = { width:width, height:height }

  switch result.type
    when 'iphone'
      switch result.version
        when '4', '4s'        then size(320, 480)
        when '5', '5c', '5s'  then size(320, 586)
        when '6'              then size(375, 667)
        when '6plus'          then size(414, 736)

  # Finish up.
  result

