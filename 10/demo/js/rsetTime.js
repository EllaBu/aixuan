

var currentViewId='';

 function firstView(){
        $.ajax({
            type: 'POST',
            url: "http://47.95.112.19/abc-weixin/v1/userBehavior/fristVisit",
            async: false,
            data: {
                oldUid: oldUid,
                uid: newUid,
                activityId: activityId,
            },
            // cache: false,
            dataType: 'json',
            success: function (result) {
                currentViewId = result.currentViewId;

                // alert(123)
                // alert("currentViewId" + currentViewId);
                // alert("第一次访问成功"+currentViewId)
            },
            error: function (d) {
                // alert(JSON.stringify(d))
            }
        })
    }

    function countTime() {
        $.ajax({
            type: 'POST',
            url: "http://47.95.112.19/abc-weixin/v1/userBehavior/duration",
            async: false,
            data: {
                currentViewId: currentViewId,
                duration: "5",
            },
            // cache: false,
            dataType: 'text',
            success: function (result) {

            },
            error:function (d) {
            // alert(JSON.stringify(d))
        }
        })
    }