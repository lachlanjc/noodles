var getCss = require('get-css');
var CleanCSS = require('clean-css');
var Parker = require('parker/lib/Parker');
var ParkerMetrics = require('parker/metrics/All');

getCss('http://noodles.dev/login', { timeout: 5000 }).then(function(response) {
  var css = response.links[0].css;
  var minified = new CleanCSS().minify(response.links[0].css).styles;
  var parker = new Parker(ParkerMetrics);
  console.log(parker.run(minified.toString()));
});
