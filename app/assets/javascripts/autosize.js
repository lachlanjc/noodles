!function(t){function e(e){this.element=e,this.$element=t(e),this.init()}var i="textareaAutoSize",n="plugin_"+i,h=function(t){return t.replace(/\s/g,"").length>0};e.prototype={init:function(){var e=this.$element.outerHeight(),i=parseInt(this.$element.css("paddingBottom"))+parseInt(this.$element.css("paddingTop"));this.element.scrollHeight+i<=e&&(i=0),h(this.element.value)&&this.$element.height(this.element.scrollHeight),this.$element.on("input keyup",function(){t(this).height("auto").height(this.scrollHeight-i)})}},t.fn[i]=function(i){return this.each(function(){t.data(this,n)||t.data(this,n,new e(this,i))}),this}}(jQuery,window,document);

window.onload = function() {
  $('textarea.js-auto-size').textareaAutoSize();
};
