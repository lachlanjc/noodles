@N =
  openMenuSelector: '[data-behavior~=menu_toggle][aria-expanded=true]'

@N.toggleMenu = (m) ->
  $(m).find('[data-behavior~=menu_content]').slideToggle 120
  o = $(m).attr('aria-expanded') is 'true'
  $(m).attr 'aria-expanded', !o
  return
