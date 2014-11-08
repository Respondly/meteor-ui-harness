###
Provides a delay timer method to the object.
###
PKG.stamps.Delay = stampit().enclose ->
  timers = []

  # ----------------------------------------------------------------------

  ###
  Provides a convenient way of setting a timeout.

  @param msecs:  The milliseconds to delay.
  @param func:   The function to invoke.

  @returns  The timer handle.
            Use the [stop] method to cancel the timer.
  ###
  @delay = (msecs, func) ->
    timer = Util.delay(msecs, func)
    timers.push(timer)
    timer


  ###
  Stops any timers that are running.
  ###
  @delay.reset = ->
    timer.stop() for timer in timers
    timers = []



  # ----------------------------------------------------------------------
  return @
