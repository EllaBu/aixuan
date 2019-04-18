(function ($) {
  $.fn.messageBox = function (options) {
    var defaults = {
      titleText: '提示',
      tipText: '您确定要删除此项？',
      callback: function () {
      }
    };

    var endOptions = $.extend(defaults, options);
    oMb.init(this, endOptions)

  };
  var oMb = {
    init: function (obj, options) {
      return (function () {
        oMb.addText(obj, options)
        oMb.bindEvent(obj, options)
      }())
    },
    addText: function (obj, options) {
      return (function () {
        obj.find('.modal').remove()

        var html = '<div class="modal">\n' +
          '  <div class="modal-box">\n' +
          '    <header class="modal-header">\n' +
          '      <h4>'+options.titleText+'</h4>\n' +
          '      <span class="glyphicon glyphicon-remove"></span>\n' +
          '    </header>\n' +
          '    <section class="modal-body">\n' +
          '      <p>\n' +
          '        <i class="icon-tip"></i>\n' +
          '        <span>'+options.tipText+'</span>\n' +
          '      </p>\n' +
          '    </section>\n' +
          '    <footer class="modal-footer">\n' +
          '      <button class="btn cancel">取消</button>\n' +
          '      <button class="btn btn-blue sure">删除</button>\n' +
          '    </footer>\n' +
          '  </div>\n' +
          '</div>'

        obj.append(html)
      }())
    },
    bindEvent: function (obj, options) {
      return (function () {
        obj.find('.modal').on('click', 'span.delete, button.cancel', function () {
          obj.find('.modal').remove()
        })
        obj.find('.modal').on('click', 'button.sure', function () {
          obj.find('.modal').fadeOut()
          options.callback()
        })
      }())
    }
  }
}(jQuery))