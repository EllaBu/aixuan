$(function () {
    $('.home-list ul li').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
    })
})