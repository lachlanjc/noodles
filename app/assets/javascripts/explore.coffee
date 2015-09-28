$(document).ready ->
  $(document).on 'click', '[data-behavior~=explore_src_pick]', ->
    t = $(this)
    b = $('[data-behavior~=explore_src_pick_bar]')
    src = t.data 'src-name'
    activeClasses = 'bg-orange bold'
    b.find('[data-src-name=' + b.data('src-selected') + ']').toggleClass activeClasses
    t.toggleClass(activeClasses) if b.data('src-selected') isnt src
    b.data 'src-selected', src
    $('[data-behavior~=explore_search_field]').keyup()

  $('[data-behavior~=explore_src_pick][data-src-name=nyt]').click()

  searchActions = ->
    if q = _.trim(this.value)
      r = $('[data-behavior~=explore_results_container]')
      r.html null
      r.addClass 'busy busy-large mx-auto'
      s = $('[data-behavior~=explore_src_pick_bar]').data('src-selected')
      u = '/explore/results?src=' + s + '&q=' + q
      $.get u, (t) ->
        r.removeClass 'busy busy-large mx-auto'
        r.html t
        $('[data-behavior~=modal_trigger]').leanModal()

  $('[data-behavior~=explore_search_field]').on 'keyup', _.debounce(searchActions, 400)

  $(document).on 'click', '[data-behavior~=explore_clip_from_list]', ->
    t = $(this)
    t.text null
    t.toggleClass 'bg-blue busy'

    $.get '/save?url=' + $(this).parent().data('url'), (s) ->
      t.attr 'class', 'grey-2 link-reset'
      t.text '✔︎'

  $(document).on 'click', '[data-behavior~=explore_preview]', ->
    t = $(this)
    p = t.parent()

    $('[data-behavior~=explore_clip_from_preview]').attr('data-url', p.data('url'))

    $('[data-behavior~=explore_preview_title]').text(n) if n = _.trim(p.data('title'))

    s = $('[data-behavior~=explore_src_pick_bar]').data('src-selected')
    d = if s is 'nyt' then 'NYT Cooking' else _.capitalize(s)
    $('[data-behavior~=explore_preview_description]').text('Recipe from ' + d)

    b = $('[data-behavior~=explore_preview_body]')
    b.html(null)
    b.addClass('busy busy-large mx-auto')

    $.get '/explore/preview?url=' + p.data('url'), (p) ->
      b.removeClass('busy busy-large mx-auto')
      b.html(p)

  $(document).on 'click', '[data-behavior~=explore_clip_from_preview]', ->
    t = $(this)
    t.text(null)

    t.attr('class', 'btn busy block')
    t.parent().toggleClass 'py1'

    $.get '/save?url=' + t.data('url'), (s) ->
      t.toggleClass 'btn busy green link-reset'
      t.text 'Clipped!'

      p = $('[data-behavior~=explore_result_item][data-url=\'' + t.data('url') + '\']').find('[data-behavior~=explore_clip_from_list]')
      p.attr 'class', 'grey-2 link-reset'
      p.text '✔︎'

      c = ->
        $('.modal-overlay').fadeOut 200
        $('#previewRecipe').css {'display': 'none'}
        t.text 'Clip'
        t.attr 'class', 'btn bg-blue mt1'
        t.parent().toggleClass 'py1'
      setTimeout c, 600
