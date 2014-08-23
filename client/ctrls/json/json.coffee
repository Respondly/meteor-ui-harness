Ctrl.define
  'uih-json':
    api:
      ###
      Gets or sets the displayed object.
      ###
      value: (value) -> @prop 'value', value

      ###
      Gets or sets whether function values are rendered.
      ###
      showFuncs: (value) -> @prop 'showFuncs', value, default:true


      ###
      Gets or sets whether functions should be invoked to convert them to a value.
      ###
      invokeFuncs: (value) -> @prop 'invokeFuncs', value, default:false


      ###
      Gets or sets the names of properties to exclude from export.
      ###
      exclude: (value) ->
        result = @prop 'exclude', value, default:[]
        result = [result] unless Object.isArray(result)
        result.compact(true)



    helpers:
      fullPath: ->
        result = ''
        walk = (level) ->
            return unless level
            if parentKey = level.options.parentKey
              result = "#{ parentKey }.#{ result }"
            walk(level.parent) # <== RECURSION.
        walk(@)
        result.remove /\.$/

      props: ->
        showFuncs = @api.showFuncs()
        invokeFuncs = @api.invokeFuncs()
        exclude = @api.exclude()

        if obj = @api.value()
          result      = []
          circular    = getCircular(obj)
          fullPath    = @helpers.fullPath()

          funcToString = (fn) =>
                params = Util.params(fn).join(', ')
                "function (#{ params })"


          typeName = (value) ->
            return 'string' if Object.isString(value)
            return 'number' if Object.isNumber(value)
            return 'boolean' if Object.isBoolean(value)
            return 'object' if Util.isObject(value)
            'unknown-type'


          process = (key, value) =>
            isExcluded = exclude.any (item) -> item is key
            valueCss = ''

            formatValue = (value) ->
                  if isString = Object.isString(value)
                    valueCss += ' uih-string'
                    value = "\"#{ value }\""

                  if isBoolean = Object.isBoolean(value)
                    valueCss += ' uih-bool'
                    value = value.toString()

                  if isArray = Object.isArray(value)
                    valueCss += ' uih-array'
                    value = "Array[#{ value.length }]"

                  if isNumber = Object.isNumber(value)
                    valueCss += ' uih-number'

                  if isNull = value is null
                    valueCss += ' uih-null'
                    value = "null"

                  if isUndefined = value is undefined
                    valueCss += ' uih-undefined'
                    value = "undefined"

                  if isExcluded and value?
                    valueCss += ' uih-excluded'
                    value = "<#{ typeName(value) }>"

                  value

            value = formatValue(value)

            if isFunction = Object.isFunction(value)
              return unless showFuncs
              valueCss += ' uih-func'
              if invokeFuncs
                value = obj[key]()
                value = formatValue(value)
              else
                value = funcToString(value)


            if isObject = Util.isObject(value)
              isCircular = circular.any (item) -> item.path is fullPath
              if isCircular
                valueCss += ' uih-circular'
                value = '<circular>'
                isObject = false
              else
                if Object.isEmpty(value)
                  isObject = false # Prevent the string representation being rendered with a child instance.
                  value = '{}'

            result.push
              key:            key
              value:          value
              valueCss:       valueCss
              isObject:       isObject
              showFuncs:      showFuncs
              invokeFuncs:    invokeFuncs
              exclude:        exclude

          process(key, value) for key, value of obj
          result


# PRIVATE ----------------------------------------------------------------------


getCircular = (parent, path, objects = [], circular = []) ->
  return [] unless Object.isObject(parent)
  for key, value of parent

    isCircular = objects.any (item) -> item.value is value
    if isCircular
      circular.push({ value:parent, path:path })

    if Util.isObject(value)
      objects.push({ key:key, value:value, path:path })
      unless isCircular
        childPath = if path then "#{ path }.#{ key }" else key
        getCircular(value, childPath, objects, circular) # <== RECURSION.

  circular


