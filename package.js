Package.describe({
  summary: 'A visual test harness for UI controls.'
});



Package.on_use(function (api) {
  api.use('http', ['client', 'server']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use(['coffeescript', 'chai', 'npm']);
  api.use(['css-stylus', 'css-common']);
  api.use(['util', 'bdd', 'ctrl', 'markdown']);
  api.use(['ctrls', 'ctrls-input', 'ctrls-log']);
  api.export('chai');
  api.export('UIHarness');
  api.export('TEST');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/ns.shared.coffee', ['client', 'server']);
  api.add_files('server/markdown.coffee', 'server');
  api.add_files('server/ns.server.js', 'server');
  api.add_files('client/ctrls/suite-tree/suite-tree.html', 'client');
  api.add_files('client/ctrls/host-header/host-header.html', 'client');
  api.add_files('client/ctrls/list/list.html', 'client');
  api.add_files('client/ctrls/list-search-box/list-search-box.html', 'client');
  api.add_files('client/ctrls/list-spec/list-spec.html', 'client');
  api.add_files('client/ctrls/host/host.html', 'client');
  api.add_files('client/ctrls/list-suite-section/list-suite-section.html', 'client');
  api.add_files('client/ctrls/list-suite/list-suite.html', 'client');
  api.add_files('client/ctrls/suite-tree-header/suite-tree-header.html', 'client');
  api.add_files('client/ctrls/ui-harness/ui-harness.html', 'client');
  api.add_files('client/ctrls/uih-main/uih-main.html', 'client');
  api.add_files('client/ns.client.js', 'client');
  api.add_files('client/ctrls/list-spec/spec-types/base.coffee', 'client');
  api.add_files('client/ctrls/list-spec/spec-types/boolean.coffee', 'client');
  api.add_files('client/ctrls/list-spec/spec-types/radio.coffee', 'client');
  api.add_files('client/ctrls/list-spec/spec-types/select.coffee', 'client');
  api.add_files('client/ctrls/suite-tree/suite-tree.coffee', 'client');
  api.add_files('client/ctrls/suite-tree/suite-tree.styl', 'client');
  api.add_files('client/ctrls/host-header/host-header.coffee', 'client');
  api.add_files('client/ctrls/host-header/host-header.styl', 'client');
  api.add_files('client/ctrls/list/list.coffee', 'client');
  api.add_files('client/ctrls/list/list.styl', 'client');
  api.add_files('client/ctrls/list-search-box/list-search-box.coffee', 'client');
  api.add_files('client/ctrls/list-search-box/list-search-box.styl', 'client');
  api.add_files('client/ctrls/list-spec/list-spec.coffee', 'client');
  api.add_files('client/ctrls/list-spec/list-spec.styl', 'client');
  api.add_files('client/ctrls/host/host.coffee', 'client');
  api.add_files('client/ctrls/host/host.styl', 'client');
  api.add_files('client/ctrls/list-suite-section/list-suite-section.coffee', 'client');
  api.add_files('client/ctrls/list-suite-section/list-suite-section.styl', 'client');
  api.add_files('client/ctrls/list-suite/list-suite.coffee', 'client');
  api.add_files('client/ctrls/list-suite/list-suite.styl', 'client');
  api.add_files('client/ctrls/suite-tree-header/suite-tree-header.coffee', 'client');
  api.add_files('client/ctrls/suite-tree-header/suite-tree-header.styl', 'client');
  api.add_files('client/ctrls/ui-harness/ui-harness.coffee', 'client');
  api.add_files('client/ctrls/ui-harness/ui-harness.styl', 'client');
  api.add_files('client/ctrls/uih-main/uih-main.coffee', 'client');
  api.add_files('client/ctrls/uih-main/uih-main.styl', 'client');
  api.add_files('client/bdd/bdd-specs.coffee', 'client');
  api.add_files('client/bdd/bdd-suites.coffee', 'client');
  api.add_files('client/bdd/bdd.coffee', 'client');
  api.add_files('client/css/common.styl', 'client');
  api.add_files('client/css-mixins/uih.import.styl', 'client');
  api.add_files('client/internal/init.coffee', 'client');
  api.add_files('client/internal/internal.coffee', 'client');
  api.add_files('client/internal/key-handlers.coffee', 'client');
  api.add_files('client/log.coffee', 'client');
  api.add_files('client/ui-harness.coffee', 'client');
  api.add_files('images/nav-back-hover.png', ['client', 'server']);
  api.add_files('images/nav-back-hover@2x.png', ['client', 'server']);
  api.add_files('images/nav-back.png', ['client', 'server']);
  api.add_files('images/nav-back@2x.png', ['client', 'server']);
  api.add_files('images/nav-child-hover.png', ['client', 'server']);
  api.add_files('images/nav-child-hover@2x.png', ['client', 'server']);
  api.add_files('images/nav-child.png', ['client', 'server']);
  api.add_files('images/nav-child@2x.png', ['client', 'server']);
  api.add_files('images/refresh-hover.png', ['client', 'server']);
  api.add_files('images/refresh-hover@2x.png', ['client', 'server']);
  api.add_files('images/refresh.png', ['client', 'server']);
  api.add_files('images/refresh@2x.png', ['client', 'server']);
  api.add_files('images/suite.png', ['client', 'server']);
  api.add_files('images/suite@2x.png', ['client', 'server']);

});



