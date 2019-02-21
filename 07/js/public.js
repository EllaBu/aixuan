$(function () {

    // 搜索框

    $("header.sticky .secondary").on('mouseenter', '.search', function () {
        $(this).css({ "width": "140px", "transition-duration": "300ms" });
        $("input.search-input").css({ "width": "100px", "transition-duration": "300ms" });
        $("input.search-input").show().focus();
    });


    $(".main,.solu_main").click(function () {
        $("header.sticky #sPC").css({ "width": "30px", "transition-duration": "300ms" });
        $("input.search-input").css({ "width": "30px", "transition-duration": "300ms" });
        $("header.sticky form.search .search-input").hide();
    })
    $(".search-input").blur(function () {
        $("header.sticky #sPC").css({ "width": "30px", "transition-duration": "300ms" });
        $("input.search-input").css({ "width": "30px", "transition-duration": "300ms" });
        $("header.sticky form.search .search-input").hide();
    });
    // 搜索框结束
    pubLicHehit();
    //	滚动条滚动
    $(window).scroll(function () {
        pubLicHehit();
    })




    // 公共浮动按钮交互
    $("#wrap .public_fd_nav").find('img:nth-of-type(2)').addClass('dis');

    $("#wrap .public_fd_nav").hover(function () {
      //  alert("ss");
        $(this).children().stop(false, true);
        $(this).find('img:nth-of-type(2)').fadeIn();
        $(this).addClass('bg_color');
    }, function () {

        $(this).children().stop(false, true);
        $(this).find('img:nth-of-type(2)').fadeOut();
        $(this).removeClass('bg_color');
    })
    //回到顶部
    $(".top").click(function () {
        $("html,body").animate({ scrollTop: 0 }, 500);
    });
    $(window).scroll(function () {
        if ($(document).scrollTop() >= 200) {
            $(".top").show();
        } else {
            $(".top").hide();
        }
    });

    //手机端微信二维码展示
    $("body").on("click", ".weixinIcon", function () {
        var flag = $(this).attr("flag");
        if (flag == "hidden") {
            $(this).attr("flag", "show");
            $(".share_ico_Ma_ico ").show();
        } else if (flag == "show") {
            $(this).attr("flag", "hidden");
            $(".share_ico_Ma_ico ").hide();
        }
    });
    $("body").on("mouseenter", ".weixinIcon", function () {
        var flag = $(this).attr("flag");
        if (flag == "hidden") {
            $(this).attr("flag", "show");
            $(".share_ico_Ma_ico ").show();
        }
    });
    $("body").on("mouseleave", ".weixinIcon", function () {
        var flag = $(this).attr("flag");
        if (flag == "show") {
            $(this).attr("flag", "hidden");
            $(".share_ico_Ma_ico ").hide();
        }
    });


    $("body *:not(.share_ico_Ma_ico)").on("click", function () {
        var flag = $(".weixinIcon").attr("flag");
        if (flag == "show") {
            $(".weixinIcon").attr("flag", "hidden");
            $(".share_ico_Ma_ico").hide();
        }
    });
   
})
$().ready(function () {
    navTextColor();
});
window.onload = function () {
    //navTextColor();

};
//当前页对应主导的文字变红
function navTextColor() {
    var url = window.location.href;
    var arr = new Array();
    arr.push(url.split("/"));
    var hrefUrl = arr[0][3];
    
    var link = arr[0][2];
  
    if (hrefUrl == "") {
        $(".nav_main").first().children("a").first().css({ "color": "#ff0000" });
    } else {
        $(".nav_menu a[href*='" + hrefUrl + "']").parents(".nav_main").children("a").first().css({ "color": "#ff0000" });
    }
    if (hrefUrl.split("#")[0] == "home") {
        $(".nav_main").first().children("a").first().css({ "color": "#ff0000" });

    }
    //外部链接新页面打开
    $("a").removeAttr("target");
    $("body").on("click", "a", function () {
        var hrefVal,arrHref=new Array();
        hrefVal = $(this).attr("href");
        arrHref.push(hrefVal.split("/"));
        if (link != arrHref[0][2] && (arrHref[0][0] == "https:" || arrHref[0][0] == "http:" || arrHref[0][0] == " https:" || arrHref[0][0] == " http:")) {
            $(this).attr("target", "_blank");
        }

    });

   
   

};
function pubLicHehit() {
    var h = document.documentElement.scrollTop || document.body.scrollTop;
    if (h >= 40) {
        $(".navbar-default .navbar-nav>li").addClass("li");
        $(".secondary").addClass('sec');
        $("header.sticky").addClass('header_bj');
        $(".header_bj").addClass('ms_bj');

        $(".In-Logo").attr('src', UrlBase + 'img/logo.png');
        $(".M_logo ").attr('src', UrlBase + 'img/logo.png');

        $(".header_M-btn").attr('src', UrlBase + 'img/M_btnbs.png');

        //$(".M_clone_nav").attr('src', UrlBase +'img/M_btnclonehs.png');
        $("header.sticky .navbar-default .navbar-nav> li> a").addClass('li_color');
        $(".secondary >li ").addClass('li_color');
        $(".search-trigger").css('background', ' url(' + UrlBase + 'img/sechat_white.png)');
        $(".secondary li .search").css('background', '#000');
        $(".search-input").css('color', '#fff');


    } else {
        $(".navbar-default .navbar-nav>li").removeClass("li");
        $(".secondary").removeClass('sec');
        $("header.sticky").removeClass('header_bj');
        $(".In-Logo").removeClass('M_In-Logo');
        $(".In-Logo").attr('src', UrlBase + 'img/logo.png');
        $(".header_M-btn").attr('src', UrlBase + 'img/M_btnbs.png');
        //$(".M_clone_nav").attr('src', UrlBase +'img/M_btnclone.png');
        $(" .navbar-default .navbar-nav> li> a").removeClass('li_color');
        $(" .secondary >li ").removeClass('li_color');
        $(".search-trigger").css('background', ' url(' + UrlBase + 'img/sechat.png)');
        $(".secondary li .search").css('background', '#fff');
        $(".search-input").css('color', '#101113');
        $("header.sticky").removeClass('ms_bj');

    }
}
