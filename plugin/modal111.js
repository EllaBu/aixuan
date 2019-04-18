var MyModal = (function () {
  function modal(fn) {
    this.fn = fn;
    this._addClickListen();
  }

  modal.prototype = {
    show: function () {
      $('.m-modal').fadeIn(100);
      $('.m-modal').children('.m-modal-dialog').animate({"margin-top": "30px"}, 250);
    },
    _addClickListen: function () {
      var that = this;
      $(".m-modal").find('*').on("click", function (event) {
        event.stopPropagation();
      });
      $(".m-modal,.m-modal-close,.m-btn-cancel").on("click", function (event) {
        that.hide();
      });
      $(".m-btn-sure").on("click", function (event) {
        that.fn();
        that.hide();
      });
    },
    hide: function () {
      var $modal = $('.m-modal');
      $modal.children('.m-modal-dialog').animate({"margin-top": "-100%"}, 500);
      $modal.fadeOut(100);
    }
  };
  return {modal: modal}
})();


/*
var m1 = new MyModal.modal(function() {
  alert("你点击了确定");//点击确定后的回调函数
});
$('.btn1').on("click", function() {
  m1.show();//显示
  /!*隐藏的方法*!/
  //m1.hide()
});*/
