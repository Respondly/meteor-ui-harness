# Testing Server Code
When developing out a back-end system, or doing integration testing, it is
useful run server side code.

To achieve this use the `it.server` declaration.

### Sync

    describe 'My Server Package', ->
      it.server 'runs on the server', ->
        console.log 'Server!'
        "My Result"

When the spec is invoked within the UIHarness the method is run on the server
and the return value is automatically logged to the console:

The return value (if there is one) can be any type of value or object that can be
serialized and sent over the wire via a
[Meteor Server Method](http://docs.meteor.com/#/basic/Meteor-methods).

![Sync](https://cloud.githubusercontent.com/assets/185555/5623416/d0cc63c0-95b8-11e4-87ba-8be005bda100.png)




### Async
Alternatively, you can use the async version by simply including a callback parmater.
If there is a return value, pass it as the second parameter of the the `done(err, result)` callback:

    it.server 'runs on the server', (done) ->
      console.log 'Server!'
      Util.delay 100, -> done(null, "My Result")



### Errors
Errors are handled implicitly, simply throw the error within the server method.
This can be either a standard Javascript `Error`, or a `Meteor.Error`:

    it.server 'runs on the server', ->
      throw new Error('Fail')

or

    it.server 'runs on the server', ->
      throw new Meteor.Error(404, 'Model not found.')


The error will be automatically reported to the console.

#### Asynchronous Errors
Likewise with asynchronous tests, simply throw an error

    it.server 'runs on the server', (done) ->
      throw new Error('Fail')
      done()

Or pass it back as the first parameter to the `done(err, result)` callback:

    describe 'My Server Package', ->
      it.server 'runs on the server', (done) ->
        err = new Error('Fail')
        done(err)



## Logging Results
Whilst the browser console is a helpful automatic default, you often want to
take the result of the server method and either log the state to screen, or
update a hosted UI control.

To do this, pass an additional callback function to the `it.server` declaration:
