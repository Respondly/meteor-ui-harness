Package.describe({
  summary: 'A visual test harness for UI controls.'
});



Package.on_use(function (api) {
  api.use('http', ['client', 'server']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use(['coffeescript', 'sugar']);
  api.use(['util', 'bdd', 'ctrl', 'stylus-compiler']);
  api.export('TestHarness');

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('shared/api.coffee', ['client', 'server']);
  api.add_files('client/ctrl/th/test-harness.html', 'client');
  api.add_files('client/ctrl/th-host/th-host.html', 'client');
  api.add_files('client/ctrl/th-index/th-index.html', 'client');
  api.add_files('client/ctrl/th/test-harness.coffee', 'client');
  api.add_files('client/ctrl/th/test-harness.styl', 'client');
  api.add_files('client/ctrl/th-host/th-host.coffee', 'client');
  api.add_files('client/ctrl/th-host/th-host.styl', 'client');
  api.add_files('client/ctrl/th-index/th-index.coffee', 'client');
  api.add_files('client/ctrl/th-index/th-index.styl', 'client');
  api.add_files('client/css-mixins/test-harness.import.styl', 'client');

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('test-harness');

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/test-harness-test.coffee', ['client', 'server']);

});
