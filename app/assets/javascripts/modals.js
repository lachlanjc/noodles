(function($){
  $.fn.extend({
    modalize: function(options) {
      var defaults = {
        top: 33,
        overlay: 0.8
      };
      var overlay = $('<div class="col-12 bg-darken-4 modal__overlay" data-behavior="modal_overlay"></div>');
      if ($('.modal__overlay').length === 0) {
        $('body').append(overlay);
      }
      options = $.extend(defaults, options);
      return this.each(function(){
        var o = options;
        $(this).click(function(e) {
          var modal_id = $(this).attr('href');
          function close_modal(modal_id) {
            $(modal_id).hide()
            $('[data-behavior~=modal_overlay]').hide()
          }
          $('[data-behavior~=modal_overlay]').click(function() {
            close_modal(modal_id)
          });
          $('[data-behavior~=modal_close]').click(function() {
            close_modal(modal_id)
          });
          $(document).keydown(function(e) {
            if (e.keyCode == 27) {
              close_modal(modal_id)
            }
          });
          var modal_height = $(modal_id).outerHeight();
          var modal_width = $(modal_id).outerWidth();
          $('[data-behavior~=modal_overlay]').fadeTo(200, o.overlay);
          $(modal_id).css({
            'display': 'block',
            'position': 'fixed',
            'opacity': 0,
            'z-index': 100,
            'left': 50+'%',
            'margin-left': -(modal_width/2)+'px'
          });
          $(modal_id).fadeTo(200,1);
          e.preventDefault()
        })
      });
    }
  })
})(jQuery);

var totalModalize = function() {
  $('[data-behavior~=modal_trigger]').modalize()
};
