var fs = require('fs')
var Pageres = require('pageres')

new Pageres({delay: 2})
  .src('http://noodles.dev/embed', ['400x400'], {filename: 'Embed'})
  .dest('./meta/results')
  .run()
