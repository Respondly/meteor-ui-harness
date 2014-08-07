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
  api.add_files('client/ctrl/suite-tree/suite-tree.html', 'client');
  api.add_files('client/ctrl/list/list.html', 'client');
  api.add_files('client/ctrl/host-header/host-header.html', 'client');
  api.add_files('client/ctrl/list-spec/list-spec.html', 'client');
  api.add_files('client/ctrl/list-suite/list-suite.html', 'client');
  api.add_files('client/ctrl/host/host.html', 'client');
  api.add_files('client/ctrl/ui-harness/ui-harness.html', 'client');
  api.add_files('client/ctrl/suite-tree/suite-tree.coffee', 'client');
  api.add_files('client/ctrl/suite-tree/suite-tree.styl', 'client');
  api.add_files('client/ctrl/list/list.coffee', 'client');
  api.add_files('client/ctrl/list/list.styl', 'client');
  api.add_files('client/ctrl/host-header/host-header.coffee', 'client');
  api.add_files('client/ctrl/host-header/host-header.styl', 'client');
  api.add_files('client/ctrl/list-spec/list-spec.coffee', 'client');
  api.add_files('client/ctrl/list-spec/list-spec.styl', 'client');
  api.add_files('client/ctrl/list-suite/list-suite.coffee', 'client');
  api.add_files('client/ctrl/list-suite/list-suite.styl', 'client');
  api.add_files('client/ctrl/host/host.coffee', 'client');
  api.add_files('client/ctrl/host/host.styl', 'client');
  api.add_files('client/ctrl/ui-harness/ui-harness.coffee', 'client');
  api.add_files('client/ctrl/ui-harness/ui-harness.styl', 'client');
  api.add_files('client/css-mixins/ui-harness.import.styl', 'client');
  api.add_files('client/css/common.styl', 'client');
  api.add_files('client/internal/bdd.coffee', 'client');
  api.add_files('client/ns.js', 'client');
  api.add_files('client/internal/internal.coffee', 'client');
  api.add_files('client/internal/key-handlers.coffee', 'client');
  api.add_files('client/internal/util.coffee', 'client');
  api.add_files('client/ui-harness.coffee', 'client');
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
