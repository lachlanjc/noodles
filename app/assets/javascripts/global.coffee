@N =
  space: [0, 4, 8, 16, 32, 64]
  openMenuSelector: '[data-behavior~=menu_toggle][aria-expanded=true]'
  exists: (o) -> !_.isEmpty o
  s: (s) -> $("[data-behavior~=#{s}]")
  theres: (s) -> !_.isEmpty $("[data-behavior~=#{s}]")

@N.cxs = (args) ->
  _.join _.filter(args, (a) ->
    !_.isEmpty(a)
  ), ' '

@N.track = (name, options) ->
  # Intercom 'trackEvent', name, options if typeof Intercom isnt 'undefined'
  heap.track name, options if typeof heap isnt 'undefined'
