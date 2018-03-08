const getCss = require('get-css')
const CleanCSS = require('clean-css')
const Parker = require('parker/lib/Parker')
const ParkerMetrics = require('parker/metrics/All')

getCss('http://localhost:5100/explore', { timeout: 2000 }).then(res => {
  const css = res.links[0].css
  const minified = new CleanCSS().minify(res.links[0].css).styles
  const parker = new Parker(ParkerMetrics)
  console.log(parker.run(minified.toString()))
})
