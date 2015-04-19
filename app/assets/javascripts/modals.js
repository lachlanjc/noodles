// leanModal v1.1 by Ray Stone
// Modified by @lachlanjc

(function($){
  $.fn.extend({
    leanModal: function(options){
      var defaults = {
        top: 33,
        overlay: 0.8,
        closeButton: $(".modal-close")
      };
      var overlay = $("<div class='full-width bg-darken-4 modal-overlay'></div>");
      $("body").append(overlay);
      options = $.extend(defaults, options);
      return this.each(function(){
        var o = options;
        $(this).click(function(e) {
          var modal_id=$(this).attr("href");
          function close_modal(modal_id) {
            $(".modal-overlay").fadeOut(200);
            $(modal_id).css({"display": "none"})
          }
          $(".modal-overlay").click(function() {
            close_modal(modal_id)
          });
          $(o.closeButton).click(function() {
            close_modal(modal_id)
          });
          $(document).keydown(function(e) {
            if (e.keyCode == 27) {
              close_modal(modal_id);
            }
          });
          var modal_height = $(modal_id).outerHeight();
          var modal_width = $(modal_id).outerWidth();
          $(".modal-overlay").fadeTo(200,o.overlay);
          $(modal_id).css({
            "display": "block",
            "position": "fixed",
            "opacity": 0,
            "z-index": 100,
            "left": 50+"%",
            "margin-left": -(modal_width/2)+"px"
          });
          $(modal_id).fadeTo(200,1);
          e.preventDefault()
        })
      });
    }
  })
})(jQuery);
