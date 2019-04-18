(function ($) {
  $.fn.message = function (options) {
    var defaults = {
      message: '这是一条提示信息',
      type: 'default'
    };

    var endOptions = $.extend(defaults, options);
    oM.init(this, endOptions)

  };
  var oM = {
    init: function (obj, options) {
      return (function () {
        oM.addText(obj, options)
      }())
    },
    addText: function (obj, options) {
      return (function () {
        var $message = obj.find('.message')
        $message.remove()
        var oType = ''
        switch (options.type) {
          case 'error':
            oType = 'error'
            break
          case 'success':
            oType = 'success'
            break
          default:
            oType = ''
        }

        var html = '<div class="message '+oType+'">\n' +
          '  <i></i><span>'+options.message+'</span>\n' +
          '</div>'

        obj.append(html)
        obj.find('.message').delay(3000).slideUp()

        setTimeout(function () {
          obj.find('.message').remove()
        }, 3500);
      }())
    }
  }
}(jQuery))