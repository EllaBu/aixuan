/*
 * Copyright 2018 ABC Online English
 * Author ABC
 */

$(function () {
  console.log($(document).height()　)
  console.log($(document).width()　)
  console.log(window.devicePixelRatio　)

  var width = $(document).width()
  var height = $(document).height()

  var ratio = width/height;
  var phoneRatio = 375/611
  console.log(ratio);
  console.log(phoneRatio);

  if (ratio > phoneRatio) {
    console.log('宽')
  } else if (ratio < phoneRatio){
    console.log('长')
  } else {
    console.log('正常')
  }


  var swiper = new Swiper('.swiper-container', {
    slidesPerView: 'auto',
    spaceBetween: 15,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
  });
  $(".swiper-slide").click(function () {
    var imgSrc = $(this).children('image').attr('src');
    console.log(imgSrc);
    $('#back').children('image').attr('src', imgSrc)
    $(this).addClass("select")
    $(this).siblings().removeClass("select")
  })

  $("#creatImg").click(function () {
    get();
  })
  $("#beginCreate").click(function () {
    bindLogin()
  })
  $('#chooseImg').click(function () {
    $(".choose-box").fadeIn()
  })
  $(".choose-box p").click(function () {
    $(".choose-box").fadeOut()
  })
  $(".double a").click(function () {
    location.reload()
  })
})

var uid = getQueryString('uid') || window.localStorage.getItem('uid');
console.log(uid)

window.localStorage.setItem("uid",uid);

function bindLogin() {
  console.log('uid' + uid)
  $.ajax({
    type: 'GET',
    url: '/abc-weixin/v1/oauth/bindingLogin',
    // url: 'http://192.168.70.31/v1/oauth/bindingLogin',
    data: {
      uid: uid
    },
    success: function (data) {
      console.log(data)
      $(".choose-box").fadeIn()
    },
    error: function () {
      console.log('去登录')
      $('.begin-login').fadeIn()
      $('.begin-create').fadeOut()
    }
  })
}

//从 canvas 提取图片 image
function convertCanvasToImage(canvas) {
  //新Image对象，可以理解为DOM
  var image = new Image();
  // canvas.toDataURL 返回的是一串Base64编码的URL，当然,浏览器自己肯定支持
  // 指定格式 PNG
  image.src = canvas.toDataURL("image/png");
  return image;
}

function utf16to8(str) {
  var out, i, len, c;
  out = "";
  len = str.length;
  for (i = 0; i < len; i++) {
    c = str.charCodeAt(i);
    if ((c >= 0x0001) && (c <= 0x007F)) {
      out += str.charAt(i);
    } else if (c > 0x07FF) {
      out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
      out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
      out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
    } else {
      out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
      out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
    }
  }
  return out;
}



//图片上传
function imgPreview(fileDom) {
  //判断是否支持FileReader
  if (window.FileReader) {
    var reader = new FileReader();
  } else {
    alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
  }

  //获取文件
  var file = fileDom.files[0];
  var imageType = /^image\//;
  //是否是图片
  if (!imageType.test(file.type)) {
    alert("请选择图片！");
    return;
  }
  //读取完成
  reader.onload = function (e) {
    //获取图片dom
    var img = document.getElementById("targetObj");
    //图片路径设置为读取的图片
    img.src = e.target.result;
  };
  reader.readAsDataURL(file);
  $('.begin-create').hide();
}

function getQueryString(name) {
  var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
  var r = window.location.search.substr(1).match(reg);
  if (r !== null) {
    return unescape(r[2]);
  }
  return null;
}

function get() {
  console.log('uid2-' + uid);
  var fontSize = getComputedStyle(window.document.documentElement)['font-size']
  console.log('fontSize---' + parseInt(fontSize))
  var qrSize = Math.floor((parseInt(fontSize))*1.36)
  console.log('qrSize---' + qrSize)

  // 设置参数方式
  var qrcode = new QRCode('qrCode', {
    text: "http://talk.abc.com.cn/marketing-activity/reg606/index.html?uid=" + uid + "&channel=weixin_hb&keyword=changgui",
    width: qrSize,
    height: qrSize,
    colorDark : '#000000',
    colorLight : '#ffffff',
    correctLevel : QRCode.CorrectLevel.M
  });

  //   // 获取网页中的canvas对象
  // var mycanvas1=document.getElementsByTagName('canvas')[0];
  // //将转换后的img标签插入到html中
  // var image=convertCanvasToImage(mycanvas1);
  // $('#qrCode').append(image);//imagQrDiv表示你要插入的容器id

  var timer = setTimeout(function () {
    var shareContent = document.getElementById('area');// 需要绘制的部分的 (原生）dom 对象 ，注意容器的宽度不要使用百分比，使用固定宽度，避免缩放问题
    var width = shareContent.offsetWidth;  // 获取(原生）dom 宽度
    var height = shareContent.offsetHeight; // 获取(原生）dom 高
    var offsetTop = shareContent.offsetTop;  //元素距离顶部的偏移量

    var canvas = document.createElement('canvas');  //创建canvas 对象
    var context = canvas.getContext('2d');
    var scaleBy = getPixelRatio(context);  //获取像素密度的方法 (也可以采用自定义缩放比例)
    canvas.width = width * scaleBy;   //这里 由于绘制的dom 为固定宽度，居中，所以没有偏移
    canvas.height = (height + offsetTop) * scaleBy;  // 注意高度问题，由于顶部有个距离所以要加上顶部的距离，解决图像高度偏移问题
    context.scale(scaleBy, scaleBy);

    var opts = {
      allowTaint:true,//允许加载跨域的图片
      tainttest:true, //检测每张图片都已经加载完成
      scale:scaleBy, // 添加的scale 参数
      canvas:canvas, //自定义 canvas
      logging: true, //日志开关，发布的时候记得改成false
      width:width, //dom 原始宽度
      height:height //dom 原始高度
    };
    html2canvas(shareContent, opts).then(function (canvas) {
      console.log("html2canvas");
      // var body = document.getElementsByTagName("body");
      // body[0].appendChild(canvas);
      var img = Canvas2Image.convertToImage(canvas, canvas.width, canvas.height);
      console.log(img);

      $('.page-one').hide();
      $('.page-two').show();
      $('.page-two .area-box').append(img);
    }, 10000);
  })
}

//获取像素密度
function getPixelRatio(context){
  var backingStore = context.backingStorePixelRatio ||
    context.webkitBackingStorePixelRatio ||
    context.mozBackingStorePixelRatio ||
    context.msBackingStorePixelRatio ||
    context.oBackingStorePixelRatio ||
    context.backingStorePixelRatio || 1;
  return (window.devicePixelRatio || 1) / backingStore;
}

