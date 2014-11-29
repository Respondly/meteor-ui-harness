Package.describe({
  name: 'respondly:ui-harness',
  summary: 'Isolate, test and document modular UI with Meteor.',
  version: '1.0.4',
  git: 'https://github.com/Respondly/meteor-ui-harness.git'
});



Package.onUse(function (api) {
  api.versionsFrom('1.0');
  api.use('standard-app-packages');
  api.use('http', ['client', 'server']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use('coffeescript');
  api.use('meteorhacks:async@1.0.0');
  api.use('practicalmeteor:chai@1.9.2_3');
  api.use('respondly:css-stylus@1.0.0');
  api.use('respondly:css-common@1.0.0');
  api.use('respondly:util@1.0.0');
  api.use('respondly:bdd@1.0.0');
  api.use('respondly:ctrl@1.0.0');
  api.use('respondly:markdown@1.0.0');
  api.use('respondly:ctrls@1.0.1');
  api.use('respondly:ctrls-input@1.0.1');
  api.use('respondly:ctrls-log@1.0.1');
  api.export('chai');
  api.export('UIHarness');
  api.export('TEST');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('shared/ns.shared.coffee', ['client', 'server']);
  api.addFiles('server/markdown.coffee', 'server');
  api.addFiles('server/ns.server.js', 'server');
  api.addFiles('client/ctrls/suite-tree/suite-tree.html', 'client');
  api.addFiles('client/ctrls/host/host.html', 'client');
  api.addFiles('client/ctrls/host-ctrl-container/host-ctrl-container.html', 'client');
  api.addFiles('client/ctrls/host-header/host-header.html', 'client');
  api.addFiles('client/ctrls/list/list.html', 'client');
  api.addFiles('client/ctrls/list-search-box/list-search-box.html', 'client');
  api.addFiles('client/ctrls/device/device.html', 'client');
  api.addFiles('client/ctrls/list-suite/list-suite.html', 'client');
  api.addFiles('client/ctrls/list-suite-section/list-suite-section.html', 'client');
  api.addFiles('client/ctrls/list-spec/list-spec.html', 'client');
  api.addFiles('client/ctrls/suite-tree-header/suite-tree-header.html', 'client');
  api.addFiles('client/ctrls/ui-harness/ui-harness.html', 'client');
  api.addFiles('client/ctrls/uih-main/uih-main.html', 'client');
  api.addFiles('client/ns.js', 'client');
  api.addFiles('client/ctrls/list-spec/spec-types/base.coffee', 'client');
  api.addFiles('client/ctrls/list-spec/spec-types/boolean.coffee', 'client');
  api.addFiles('client/ctrls/list-spec/spec-types/markdown.coffee', 'client');
  api.addFiles('client/ctrls/list-spec/spec-types/radio.coffee', 'client');
  api.addFiles('client/ctrls/list-spec/spec-types/select.coffee', 'client');
  api.addFiles('client/ctrls/suite-tree/suite-tree.coffee', 'client');
  api.addFiles('client/ctrls/suite-tree/suite-tree.styl', 'client');
  api.addFiles('client/ctrls/host/host.coffee', 'client');
  api.addFiles('client/ctrls/host/host.styl', 'client');
  api.addFiles('client/ctrls/host-ctrl-container/host-ctrl-container.coffee', 'client');
  api.addFiles('client/ctrls/host-ctrl-container/host-ctrl-container.styl', 'client');
  api.addFiles('client/ctrls/host-header/host-header.coffee', 'client');
  api.addFiles('client/ctrls/host-header/host-header.styl', 'client');
  api.addFiles('client/ctrls/list/list.coffee', 'client');
  api.addFiles('client/ctrls/list/list.styl', 'client');
  api.addFiles('client/ctrls/list-search-box/list-search-box.coffee', 'client');
  api.addFiles('client/ctrls/list-search-box/list-search-box.styl', 'client');
  api.addFiles('client/ctrls/device/device.coffee', 'client');
  api.addFiles('client/ctrls/device/device.styl', 'client');
  api.addFiles('client/ctrls/list-suite/list-suite.coffee', 'client');
  api.addFiles('client/ctrls/list-suite/list-suite.styl', 'client');
  api.addFiles('client/ctrls/list-suite-section/list-suite-section.coffee', 'client');
  api.addFiles('client/ctrls/list-suite-section/list-suite-section.styl', 'client');
  api.addFiles('client/ctrls/list-spec/list-spec.coffee', 'client');
  api.addFiles('client/ctrls/list-spec/list-spec.styl', 'client');
  api.addFiles('client/ctrls/suite-tree-header/suite-tree-header.coffee', 'client');
  api.addFiles('client/ctrls/suite-tree-header/suite-tree-header.styl', 'client');
  api.addFiles('client/ctrls/ui-harness/ui-harness.coffee', 'client');
  api.addFiles('client/ctrls/ui-harness/ui-harness.styl', 'client');
  api.addFiles('client/ctrls/uih-main/uih-main.coffee', 'client');
  api.addFiles('client/ctrls/uih-main/uih-main.styl', 'client');
  api.addFiles('client/bdd/bdd-specs.coffee', 'client');
  api.addFiles('client/bdd/bdd-suites.coffee', 'client');
  api.addFiles('client/bdd/bdd.coffee', 'client');
  api.addFiles('client/ui-harness/autorun.coffee', 'client');
  api.addFiles('client/ui-harness/config.coffee', 'client');
  api.addFiles('client/ui-harness/ctrl-host.coffee', 'client');
  api.addFiles('client/ui-harness/helper-delay.coffee', 'client');
  api.addFiles('client/ui-harness/helper-lorem.coffee', 'client');
  api.addFiles('client/ui-harness/helpers.coffee', 'client');
  api.addFiles('client/ui-harness/log.coffee', 'client');
  api.addFiles('client/ui-harness/ui-harness.coffee', 'client');
  api.addFiles('client/css/common.styl', 'client');
  api.addFiles('client/css/markdown.styl', 'client');
  api.addFiles('client/css-mixins/uih.import.styl', 'client');
  api.addFiles('client/internal/devices.coffee', 'client');
  api.addFiles('client/internal/init.coffee', 'client');
  api.addFiles('client/internal/internal.coffee', 'client');
  api.addFiles('client/internal/key-handlers.coffee', 'client');
  api.addFiles('client/main.coffee', 'client');
  api.addFiles('images/nav-back-hover.png', ['client', 'server']);
  api.addFiles('images/nav-back-hover@2x.png', ['client', 'server']);
  api.addFiles('images/nav-back.png', ['client', 'server']);
  api.addFiles('images/nav-back@2x.png', ['client', 'server']);
  api.addFiles('images/nav-child-hover.png', ['client', 'server']);
  api.addFiles('images/nav-child-hover@2x.png', ['client', 'server']);
  api.addFiles('images/nav-child.png', ['client', 'server']);
  api.addFiles('images/nav-child@2x.png', ['client', 'server']);
  api.addFiles('images/refresh-hover.png', ['client', 'server']);
  api.addFiles('images/refresh-hover@2x.png', ['client', 'server']);
  api.addFiles('images/refresh.png', ['client', 'server']);
  api.addFiles('images/refresh@2x.png', ['client', 'server']);
  api.addFiles('images/suite.png', ['client', 'server']);
  api.addFiles('images/suite@2x.png', ['client', 'server']);

});



