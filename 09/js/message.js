(function ($) {
  $.fn.message = function (options) {
    var defaults = {
      text: '这是一条提示信息',
      type: 'default'
    };

    var endOptions = $.extend(defaults, options);
    zp.init(this, endOptions)

  };
  var zp = {
    init: function (obj, options) {
      return (function () {
        zp.addText(obj, options)
      }())
    },
    addText: function (obj, options) {
      return (function () {
        var $message = obj.find($('.message'))
        $message.remove()
        var oType = ''
        switch (options.type) {
          case 'warn':
            oType = 'warn'
            break
          case 'success':
            oType = 'success'
            break
          default:
            oType = ''
        }

        var html = '<div class="message '+ oType +'">\n' +
          '  <p>' + options.text + '</p>\n' +
          '</div>'

        // setTimeout(function () {
          obj.append(html)
        // }, 500);

        setTimeout(function () {
          obj.find($('.message')).slideUp();
        }, 2500);




      }())
    }
  }
}(jQuery))