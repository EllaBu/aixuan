;(function ($) {
  let settings, cancelBtn, okBtn, closeBtn, timer

  let _renderDOM = function() {
    if( $('.toast').length > 0){
      return
    }

    clearTimeout(timer)

    $('body').append(messageBox = $('<div class="message-box"></div>'))
    messageBox.append(
      messageBoxShade = $('<div class="message-box-shade"></div>')
    )
    messageBox.append(
      messageBoxContent = $('<div class="message-box-content"></div>')
    )


    // messageBox
    messageBoxContent.append(header = $('<header class="message-box-header"></header>'))
    header.append('<h4>' + settings.title + '</h4>')
    header.append(closeBtn = $('<span></span>'))

    messageBoxContent.append('<section class="message-box-body">\n' +
      '      <p>'+ settings.message +'</p>\n' +
      '    </section>')

    messageBoxContent.append(footer = $('<footer class="message-box-footer"></footer>'))
    footer.append(cancelBtn = $('<button class="btn btn-cancel">' + settings.cancelBtn + '</button>'))
    footer.append(okBtn = $('<button class="btn btn-ok">'+ settings.okBtn +'</button>'))


    setTimeout(function(){
      messageBox.addClass('message-box-show')
    }, 20);

  }

  let _bindEvent = function() {
    okBtn.on('click', function () {
      settings.okFun()
      $.messageBox.close()
    })
    cancelBtn.on('click', function () {
      settings.cancelFun()
      $.messageBox.close()
    })
    closeBtn.on('click', function () {
      $.messageBox.close()
    })
  }






  $.messageBox = function(options) {
    settings = $.extend({}, $.fn.messageBox.defaults, options);
    $.messageBox.init();
    return this
  }

  $.messageBox.init = function() {
    _renderDOM()
    _bindEvent()
  }

  // 弹窗关闭
  $.messageBox.close = function() {
    messageBox.removeClass('message-box-show')
    timer = setTimeout(function(){
      messageBox.remove()
    }, 200);
  }

  // 插件
  $.fn.messageBox = function(){
    return this
  };

  $.fn.messageBox.defaults = {
    title: 'VIP功能提醒',
    message: '该服务是VIP专属，您确定要了解么？',

    cancelBtn: '返回',
    okBtn: '去了解',

    okFun: function () {},
    cancelFun: function () {}
  }

})(jQuery)