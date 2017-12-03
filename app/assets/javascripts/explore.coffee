#= require masonry/dist/masonry.pkgd
#= require imagesloaded/imagesloaded.pkgd

$(document).on 'turbolinks:load', ->
  activateSrc = (src) ->
    b = $('[data-behavior~=explore_src_pick_bar]')
    c = b.find("[data-behavior~=explore_src_pick][data-src-name=#{src}]")
    activeClasses = 'bg-orange b tsn'
    b.find("[data-src-name=#{b.data('src-selected')}]").toggleClass activeClasses
    c.toggleClass(activeClasses) if b.data('src-selected') isnt src or !c.attr('class').match activeClasses
    b.data 'src-selected', src

  $(document).on 'click', '[data-behavior~=explore_src_pick]', ->
    src = $(this).data('src-name') || 'nyt'
    activateSrc src
    $('[data-behavior~=explore_search_field]').keypress()
    q = $('[data-behavior~=explore_search_field]').val()
    if !_.isEmpty q
      window.history.replaceState null, null, "?q=#{encodeURIComponent(q)}&src=#{src}"

  if !_.isEmpty urlParams
    f = $('[data-behavior~=explore_search_field]')
    f.val urlParams.q
    s = urlParams.src || 'nyt'
    $('[data-behavior~=explore_src_pick_bar]').data 'src', s
    activateSrc s
    k = -> f.keypress()
    k
    setTimeout k, 1
  else if _.isEmpty urlParams.src
    $('[data-behavior~=explore_src_pick_bar]').data 'src-selected', 'nyt'
    activateSrc 'nyt'

  logSearchToAnalytics = ->
    if N.signed_in
      e =
        user_id: N.user
        query: _.trim $('[data-behavior~=explore_search_field]').val()
        source: $('[data-behavior~=explore_src_pick_bar]').data 'src-selected'
      Intercom('trackEvent', 'searched-explore', e) if typeof Intercom isnt 'undefined'
      heap.track('Searches Explore', _.omit(e, 'user_id')) if typeof heap isnt 'undefined'

  searchActions = ->
    t = $('[data-behavior~=explore_search_field]')
    q = _.trim t.val()
    unless _.isEmpty q
      r = $('[data-behavior~=explore_results_container]')
      r.html null
      r.removeClass 'tc mw7'
      r.addClass 'busy busy--large mx-auto mw8'

      s = $('[data-behavior~=explore_src_pick_bar]').data 'src-selected'

      p = "?q=#{encodeURIComponent(q)}&src=#{s}"
      window.history.replaceState null, null, p

      $('[data-behavior~=explore_clear_search]').show 'fast'
      $('[data-behavior~=explore_suggestions]').fadeOut()

      u = "/explore/results#{p}"

      $.get u, (t) ->
        r.removeClass 'busy busy--large'
        r.html t
        g = $('[data-behavior~=explore_masonry_grid]')
        masonry = ->
          g.masonry
            itemSelector: '[data-behavior~=explore_result_item]'
            gutter: 32
            isFitWidth: true
          totalModalize()
        if _.isEmpty g.find('[data-behavior~=explore_result_item] img')
          masonry()
        else
          g.imagesLoaded().progress -> masonry()
        return

  f = $('[data-behavior~=explore_search_field]')
  f.on 'keypress', _.debounce searchActions, 400
  f.on 'change', _.debounce logSearchToAnalytics, 1000

  $(document).on 'click', '[data-behavior~=explore_clear_search]', ->
    $(this).hide 'fast'
    $('[data-behavior~=explore_search_field]').val null
    $('[data-behavior~=explore_results_container]').removeClass 'busy busy--large'
    $('[data-behavior~=explore_masonry_grid]').remove()
    $('[data-behavior~=explore_suggestions]').fadeIn()
    window.history.replaceState null, null, '/explore'

  $(document).on 'click', '[data-behavior~=explore_preview]', ->
    t = $(this)
    r = t.closest '[data-behavior~=explore_result_item]'

    u = r.data 'url'
    $('[data-behavior~=explore_clip_from_preview]').data 'url', u
    $('[data-behavior~=explore_open_original]').attr 'href', u

    if n = _.trim r.data 'title'
      $('[data-behavior~=explore_preview_title]').text n

    b = $('[data-behavior~=explore_src_pick_bar]').data 'src-selected'
    s = if b is 'nyt' then 'NYT Cooking' else _.capitalize b
    $('[data-behavior~=explore_preview_description]').text 'Source: ' + s

    c = N.s 'explore_preview_body'
    c.html null
    c.addClass 'busy busy--large mx-auto'

    $('[data-behavior~=explore_clipped_open]').hide 0
    p = $('[data-behavior~=explore_clip_from_preview]')
    p.show 0
    p.text 'Clip'
    p.attr 'class', 'btn btn--primary bg-blue'

    $.get '/explore/preview?url=' + u, (d) ->
      c.removeClass 'busy busy--large mx-auto'
      c.html d
      if N.signed_in
        N.addGroceries li for li in c.find('[data-behavior~=recipe_ingredients] li')

  $(document).on 'click', '[data-behavior~=explore_clip_from_preview]', ->
    t = $(this)
    t.text ''
    t.attr 'class', 'btn busy db mtm mx-auto'
    u = t.data 'url'

    $.get '/save?url=' + u, (s) ->
      $('[data-behavior~=explore_clipped_open]').attr 'href', '/recipes/' + s
      t.fadeOut 128
      $('[data-behavior~=explore_clipped_open]').fadeIn 128

      heap.track('Clips Recipe', { 'URL': u }) if typeof heap isnt 'undefined'

      setTimeout (->
        $('[data-behavior~=modal_overlay]').fadeOut 256
        $('[data-behavior~=explore_preview_modal]').fadeOut 256, ->
          t.text 'Clip'
          t.attr 'class', 'btn btn--primary bg-blue'
          t.hide 0
      ), 1024
