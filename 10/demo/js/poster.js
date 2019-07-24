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
    text: "http://talk.abc.com.cn/marketing-activity/reg606/index.html?uid=" + uid + "&channel=weixin_hb&keyword=changgui&activityId"+ activityId,
    width: qrSize,
    height: qrSize,
    colorDark : '#000000',
    colorLight : '#ffffff',
    correctLevel : QRCode.CorrectLevel.M
  });

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

// 活动分享营销部分  start
var appid = 'wxe2ef31435675fd38'; //appid
var newurl = ''; //新的分享链接
var newUid = ''; //新的用户id
var imgurl = ''; //分享的图片
var content = '';//分享的内容
var title = '';  //分享的标题

//获取url
var oldurl = window.location.href;
// var rooturl = "http://" + window.location.host + window.location.pathname;

var code = window.localStorage.getItem("code") //获取localstorage中的code（如果有）

var activityId = GetRequest(oldurl).activityId; //获取url中的activityId
var oldUid = GetRequest(oldurl).uid;      //获取url中的用户id（即上个用户的id）
if (oldUid == undefined) {               //没有上个用户的id记为空
  oldUid = "";
}
oldurl = encodeURIComponent(oldurl);

// window.localStorage.setItem("oldUid", oldUid);
// window.localStorage.setItem("activityId", activityId);

if (code == "" || code == null || code == "undefined") {
  window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid + "&redirect_uri=" + oldurl + "&response_type=code&scope=snsapi_base&state=newone#wechat_redirect";
  var parsurl = window.location.href;
  code = GetRequest(parsurl).code;
  window.localStorage.setItem("code", code);
}
else {
  parsurl = window.location.href;
  judgeState();
  getopenid();
  firstView();
  window.setInterval("countTime()", 5000);

  wx.ready(function () {
    wx.onMenuShareTimeline({
      title: title,
      desc: content,
      link: newurl,
      imgUrl: imgurl,
      success: function () {
        $.ajax({
          type: 'POST',
          url: "http://47.95.112.19/abc-weixin/v1/userBehavior/retransmission",
          async: true,
          data: {
            oldUid: oldUid,
            uid: newUid,
            activityId: activityId,
          },
          // cache: false,
          dataType: 'text',
          success: function (result) {
            // alert("转发成功")
          }
        })
      },
      cancel: function () {
      }
    });

    // 分享给朋友
    wx.onMenuShareAppMessage({
      title: title,
      desc: content,
      link: newurl,
      imgUrl: imgurl,
      success: function () {

        $.ajax({
          type: 'POST',
          url: "http://47.95.112.19/abc-weixin/v1/userBehavior/retransmission",
          async: true,
          data: {
            oldUid: oldUid,
            uid: newUid,
            activityId: activityId,
          },
          // cache: false,
          dataType: 'text',
          success: function (result) {
            // alert("转发成功")
          }
        })
      },
      cancel: function () {
      }
    });


    // 获取地理位置
    wx.getLocation({
      type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
      success: function (res) {
        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
        var speed = res.speed; // 速度，以米/每秒计
        var accuracy = res.accuracy; // 位置精度
        $.ajax({
          type: 'POST',
          url: "http://47.95.112.19/abc-weixin/v1/userBehavior/location",
          async: true,
          data: {
            oldUid: oldUid,
            uid: newUid,
            activityId: activityId,
            longitude: longitude,
            latitude: latitude
          },
          // cache: false,
          dataType: 'text',
          success: function (result) {
            console.log("get location success")
            // alert("获取地址成功")
          },
          error: function (d) {
            alert(JSON.stringify(d))
          }
        })
      }
    });
  })
}


function getopenid() {
  let timestamp = '';
  let nonceStr = '';
  let signature = '';

  $.ajax({
    type: 'POST',
    url: "http://47.95.112.19/abc-weixin/v1/userInfo/info",
    async: false,
    data: {
      oldUid: oldUid,
      code: code,
      url: parsurl,
      activityId: activityId,
    },
    // cache: false,
    dataType: 'json',
    success: function (result) {
      window.localStorage.removeItem("code");

      imgurl = result.coverUrl;
      title = result.shareTitle;
      content = result.content;
      newurl = result.url;
      timestamp = result.timestamp;
      nonceStr = result.nonceStr;
      signature = result.signature;
      newUid = result.uid;

      // window.localStorage.setItem("newUid", newUid);
      // alert(JSON.stringify(result))
      // alert(newUid)

      wx.config({
        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: appid, // 必填，公众号的唯一标识
        timestamp: timestamp, // 必填，生成签名的时间戳
        nonceStr: nonceStr, // 必填，生成签名的随机串
        signature: signature,// 必填，签名
        jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'getLocation'] // 必填，需要使用的JS接口列表
      });
    },
    error: function (d) {
      // alert(JSON.stringify(d))
      window.localStorage.removeItem("code");
    }

  })
}

function judgeState() {
  $.ajax({
    type: 'POST',
    url: "http://47.95.112.19/abc-weixin/v1/activity/state",
    async: true,
    data: {
      activityId: activityId,
    },
    // cache: false,
    dataType: 'text',
    success: function (result) {

    },
    error: function (d) {
      console.log(JSON.stringify(d))
      if (d.status == 403) {
        alert("本活动已结束！")
      }
    }
  })
}

// 截取url
function GetRequest(url) {
  var theRequest = new Object();
  if (url.lastIndexOf("?") != -1) {
    var str = url.substr(1);
    str = str.split("?")[1];
    strs = str.split("&");
    for (var i = 0; i < strs.length; i++) {
      theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
    }
  }
  return theRequest;
}

