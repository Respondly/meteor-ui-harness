#= base
UIHarness = {} unless UIHarness?


# Namespace for users consuming the UIHarness to share
# functions and state around.
TEST =
  hash: new ReactiveHash()
