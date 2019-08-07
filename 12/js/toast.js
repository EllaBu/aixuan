;(function ($) {
  let settings, timer

  let _renderDOM = function() {
    if( $('.toast').length > 0){
      return
    }

    clearTimeout(timer)

    $('body').append(toast = $('<div class="toast ' + settings.type + '"></div>'))
    toast.append('<i></i>')

    toast.append('<span>' + settings.message + '</span>')

  }

  let _bindEvent = function() {
    timer = setTimeout(function(){
      toast.remove()
      settings.callback()
    }, 2000);

  }






  $.toast = function(options) {
    settings = $.extend({}, $.fn.toast.defaults, options);
    $.toast.init();
    return this
  }

  $.toast.init = function() {
    _renderDOM()
    _bindEvent()
  }

  // 插件
  $.fn.toast = function(){
    return this
  };

  $.fn.toast.defaults = {
    type: 'loading',
    message: '信息获取中',
    callback: function () {}
  }

})(jQuery)