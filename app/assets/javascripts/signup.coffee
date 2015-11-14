$(document).ready ->
  activateModals()
  $('[data-behavior~=inline_signup_form]').on 'ajaxBeforeSend', ->
    t = $(this)
    t.html null
    t.toggleClass 'busy busy-large mx-auto'
    t.find('[data-behavior~=hide_on_inline_submit]').hide()
  $(document).on 'ajaxSuccess', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    t.closest('.modal').find('[data-behavior~=modal_close]').click()
    if b = $('[data-behavior~=inline_signup_btn]')
      b.hide()
      b.parent().append '<p class="blue bold">Signed up! Thanks.</p>'
    setTimeout location.reload(), 600
  $(document).on 'ajaxError', '[data-behavior~=inline_signup_form]', ->
    t = $(this)
    t.toggleClass 'busy busy-large mx-auto bg-darken-1 border rounded pvm mt2 tc'
    $('[data-behavior~=inline_signup_error]').toggleClass 'dn'
