@expect = chai.expect


if Meteor.isClient
  Meteor.startup ->
    $('title').html('Tests:test-harness')