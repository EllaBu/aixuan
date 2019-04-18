// 面向对象的插件开发

(function () {
  //定义oM的构造函数
  var oM = function (ele, opt) {
    this.$element = ele,
      this.defaults = {
        message: '这是一条提示信息',
        type: 'default'
      },
      this.options = $.extend({}, this.defaults, opt)
  }
  //定义oM的方法
  oM.prototype = {
    init: function () {
      this.addText()
    },
    addText: function () {
      var This = this
      var $message = This.$element.find('.message')
      if ($message) {
        $message.remove()
      }

      var oType = ''
      switch (This.options.type) {
        case 'error':
          oType = 'error'
          break
        case 'success':
          oType = 'success'
          break
        default:
          oType = ''
      }

      var html = '<div class="message ' + oType + '">\n' +
        '  <i></i><span>' + This.options.message + '</span>\n' +
        '</div>'

      This.$element.append(html)
      console.log(This.$element.find('.message'))
      This.$element.find('.message').delay(3000).slideUp()

      setTimeout(function () {
        console.log(This.$element)
        This.$element.find('.message').remove()
      }, 3500);

    }
  }
  //在插件中使用oM对象
  $.fn.message = function (options) {
    //创建Beautifier的实体
    var om = new oM(this, options);
    //调用其方法
    return om.init();
  }
})();