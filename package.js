Package.describe({
  summary: 'A visual test harness for UI controls.'
});



Package.on_use(function (api) {
  api.use('http', ['client', 'server']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use(['coffeescript', 'sugar']);
  api.use(['util', 'bdd', 'ctrl', 'stylus-compiler', 'chai']);
  api.export('chai');
  api.export('UIHarness');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/api.coffee', ['client', 'server']);
  api.add_files('client/ctrl/th/test-harness.html', 'client');
  api.add_files('client/ctrl/th-host/th-host.html', 'client');
  api.add_files('client/ctrl/th-list/th-list.html', 'client');
  api.add_files('client/ctrl/th-list-spec/th-list-spec.html', 'client');
  api.add_files('client/ctrl/th-list-suite/th-list-suite.html', 'client');
  api.add_files('client/ctrl/th-suite-tree/th-suite-tree.html', 'client');
  api.add_files('client/ctrl/th/test-harness.coffee', 'client');
  api.add_files('client/ctrl/th/test-harness.styl', 'client');
  api.add_files('client/ctrl/th-host/th-host.coffee', 'client');
  api.add_files('client/ctrl/th-host/th-host.styl', 'client');
  api.add_files('client/ctrl/th-list/th-list.coffee', 'client');
  api.add_files('client/ctrl/th-list/th-list.styl', 'client');
  api.add_files('client/ctrl/th-list-spec/th-list-spec.coffee', 'client');
  api.add_files('client/ctrl/th-list-spec/th-list-spec.styl', 'client');
  api.add_files('client/ctrl/th-list-suite/th-list-suite.coffee', 'client');
  api.add_files('client/ctrl/th-list-suite/th-list-suite.styl', 'client');
  api.add_files('client/ctrl/th-suite-tree/th-suite-tree.coffee', 'client');
  api.add_files('client/ctrl/th-suite-tree/th-suite-tree.styl', 'client');
  api.add_files('client/css-mixins/ui-harness.import.styl', 'client');
  api.add_files('client/bdd.coffee', 'client');
  api.add_files('client/common.styl', 'client');
  api.add_files('client/key-handlers.coffee', 'client');
  api.add_files('client/local-api.js', 'client');
  api.add_files('client/local-api.coffee', 'client');
  api.add_files('client/test-harness.coffee', 'client');
  api.add_files('images/nav-back-hover.png', ['client', 'server']);
  api.add_files('images/nav-back-hover@2x.png', ['client', 'server']);
  api.add_files('images/nav-back.png', ['client', 'server']);
  api.add_files('images/nav-back@2x.png', ['client', 'server']);
  api.add_files('images/nav-child-hover.png', ['client', 'server']);
  api.add_files('images/nav-child-hover@2x.png', ['client', 'server']);
  api.add_files('images/nav-child.png', ['client', 'server']);
  api.add_files('images/nav-child@2x.png', ['client', 'server']);
  api.add_files('images/suite.png', ['client', 'server']);
  api.add_files('images/suite@2x.png', ['client', 'server']);

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('ui-harness');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/test-harness-test.coffee', ['client', 'server']);

});
