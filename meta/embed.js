const fs = require('fs')
const Pageres = require('pageres')

new Pageres({ delay: 2 })
  .src('http://localhost:5100/embed', ['350x225'], { filename: 'Embed' })
  .dest('./meta/results')
  .run()
