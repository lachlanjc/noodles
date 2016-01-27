#= require masonry/dist/masonry.pkgd.min.js
#= require imagesloaded/imagesloaded.pkgd.min.js

$(document).ready ->
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

  logSearchToIntercom = ->
    u = $('[data-behavior~=nav]').data 'user'
    q = _.trim $('[data-behavior~=explore_search_field]').val()
    if u isnt 'anon' and !_.isEmpty q
      e =
        user_id: u
        query: _.trim $('[data-behavior~=explore_search_field]').val()
        source: $('[data-behavior~=explore_src_pick_bar]').data 'src-selected'
      Intercom 'trackEvent', 'searched-explore', e

  searchActions = ->
    t = $('[data-behavior~=explore_search_field]')
    q = _.trim t.val()
    unless _.isEmpty q
      r = $('[data-behavior~=explore_results_container]')
      r.html null
      r.removeClass 'tc mw7'
      r.addClass 'busy busy--large mx-auto mw8'

      s = $('[data-behavior~=explore_src_pick_bar]').data 'src-selected'

      window.history.replaceState null, null, "?q=#{encodeURIComponent(q)}&src=#{s}"

      $('[data-behavior~=explore_clear_search]').show 'slow'
      m = $('[data-behavior~=explore_suggestions], [data-behavior~=inline_signup_btn_container]')
      m.css { 'display': 'none' }

      u = "/explore/results?q=#{encodeURIComponent(q)}&src=#{s}"

      $.get u, (t) ->
        r.removeClass 'busy busy--large'
        r.html t
        g = $('[data-behavior~=explore_masonry_grid]')
        masonry = ->
          g.masonry
            itemSelector: '[data-behavior~=explore_result_item]'
            gutter: 32
            isFitWidth: true
          activateModals()
        if _.isEmpty g.find('[data-behavior~=explore_result_item] img')
          masonry()
        else
          g.imagesLoaded().progress -> masonry()
        return

  f = $('[data-behavior~=explore_search_field]')
  f.on 'keypress', _.debounce searchActions, 400
  f.on 'change', _.debounce logSearchToIntercom, 1000

  $('[data-behavior~=explore_clear_search], [data-behavior~=explore_suggestions]').css { 'display': 'none' }
  $(document).on 'click', '[data-behavior~=explore_clear_search]', ->
    $(this).hide 'slow'
    $('[data-behavior~=explore_search_field]').val null
    $('[data-behavior~=explore_results_container]').removeClass 'busy busy--large'
    $('[data-behavior~=explore_masonry_grid]').remove()
    $('[data-behavior~=explore_suggestions]').fadeIn()
    window.history.replaceState null, null, '/explore'

  clippingFinished = (b, id) ->
    b.attr 'data-behavior', null
    b.attr 'href', '/recipes/' + id
    b.removeClass 'bg-blue busy'
    b.attr 'style', 'color: #0092ff; box-shadow: inset 0 0 0 2px #0092ff;'
    b.text 'Clipped!'

  $(document).on 'click', '[data-behavior~=explore_clip_from_list]', ->
    t = $(this)
    t.text ''
    t.toggleClass 'bg-blue busy'

    u = '/save?url=' + t.closest('[data-behavior~=explore_result_item]').data 'url'
    $.get u, (s) ->
      clippingFinished t, s

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
    $('[data-behavior~=explore_preview_description]').text 'Recipe from ' + s

    c = $('[data-behavior~=explore_preview_body]')
    c.html null
    c.addClass 'busy busy--large mx-auto'

    $.get '/explore/preview?url=' + u, (d) ->
      c.removeClass 'busy busy--large mx-auto'
      c.html d

    $(document).on 'click', '.modal__overlay', -> $(this).hide 200

  $(document).on 'click', '[data-behavior~=explore_trigger_inline_signup]', ->
    $(this).closest('.modal').hide()
    $('[data-behavior~=inline_signup_btn]').click()

  $(document).on 'click', '[data-behavior~=explore_clip_from_preview]', ->
    t = $(this)
    t.text null

    t.attr 'class', 'btn busy db mtm mx-auto'

    u = t.data 'url'

    $.get '/save?url=' + u, (s) ->
      t.attr 'class', 'b mtm db link-reset'
      t.text 'Clipped!'

      p = $("[data-behavior~=explore_result_item][data-url='#{u}']")
      p = p.find '[data-behavior~=explore_clip_from_list]'
      clippingFinished p, s

      c = ->
        $('.modal__overlay').fadeOut 200
        $('[data-behavior=explore_preview_modal]').css 'display': 'none'
        t.text 'Clip'
        t.attr 'class', 'btn bg-blue mtm'
      setTimeout c, 600
