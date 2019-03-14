// 产品评分详情
XCOTemplate.pretreatment('grade_temp');
XCOTemplate.pretreatment('selectView');
XCOTemplate.pretreatment('checkboxView');
XCOTemplate.pretreatment('radioView');


var product_no = getURLparam("product_no")||'1060010A';
var productName = getURLparamEncoder("name")||'太平福利健康C款组合计划';
var subTypeName = getURLparamEncoder("sub_type_name");
var sub_type_id = getURLparam("sub_type_id")||'33';
var oc_score_type =getURLparam("oc_score_type")||'1';

$("#productNo").text("产品编号："+product_no)
$("#productName").text("产品名称："+productName)
$("#subTypeName").text("产品分类："+subTypeName)
$("#type").append(oc_score_type==1?"责任分":"病种分")
$("title").html(oc_score_type==1?"产品打分-责任分":"产品打分-病种分")
$(function () {
    var xco = new XCO();
    xco.setStringValue("product_no", product_no);
    xco.setStringValue("sub_type_id", sub_type_id);
    xco.setStringValue("oc_score_type", oc_score_type);
    // layer.open({type:2});
    var options = {
        url : "/productGrade/getProductGradeInfo.xco",
        data : xco,
        success : getProductInfoCallBack
    };
    $.doXcoRequest(options);
})
function getProductInfoCallBack(data) {
    // layer.closeAll();
    if (data.getCode() != 0) {
        axError(data.getMessage());
        return;
    }
    data = data.getData();

    //展示评分
    $("#grade_temp").html("");
    var grades = data.get("grades");
    if(grades == null){
        return;
    }
    var totalScore = 0;
    var oc_type = 0;
    var show4end = false;
    var dis_oc_id = 0;
    var rowNum =0;
    var arr = new Array();//oc_type分组
    var lastFlag = false;
    for (var i = 0; i < grades.length; i++) {
        var grade = grades[i];
        var oct = grade.get("oc_type");
        if(oct != oc_type){
            oc_type = oct;
            if(i != 0){
                show4end = true;
            }
        }
        //最后一条特殊处理
        if(lastFlag) {
            show4end = true;
        }else if(i == grades.length-1){
            if(dis_oc_id == grade.get("oc_id")){
                arr.push(grade);
                show4end = true;
            }else {
                lastFlag = true;
                i--;//退回一步
            }
        }
        if(show4end){
            //处理前面数据
            arr[0].setStringValue("first",1);
            arr[0].setStringValue("rowNum",arr.length);
            var oc_id = 0;
            var oc ;//区别分类
            var arr_ = new Array();//oc分组
            var needManage= false;
            var lastOv = false;
            for (var j = 0; j < arr.length; j++) {
                var ov = arr[j];
                var ocid = ov.get("oc_id");
                if(oc_id != ocid){
                    oc_id = ocid
                    if(j == 0){
                        //第一个的初始化
                        oc = new XCO();
                        oc.fromXML(ov.toString())
                        oc.setStringValue("oldValue",0)
                    }else{
                        needManage = true;
                    }
                    if(j == arr.length -1){
                        lastOv = true;
                        j--;
                    }
                }else{
                    if(lastOv){
                        needManage = true;
                    }else if(j == arr.length -1){
                        needManage = true;
                        var oldValue = ov.get("oldValue");
                        if(oldValue!=null){
                            // console.log("a:"+oc.getStringValue("oc_id")+","+ov.get("ov_id")+","+oc.get("oldValue")+","+ov.get("oldValue"))
                            oc.setStringValue("oldValue",parseFloat(oldValue)+parseFloat(oc.getStringValue("oldValue")?oc.getStringValue("oldValue"):0));
                            totalScore += parseFloat(oldValue)/10000*(parseFloat(oc.get("oc_ratio"))/10000);
                        }
                        arr_.push(ov);
                    }
                }
                if(needManage){
                    var extendedFunction = {
                        firstColumn:function(){
                            var first = oc.get("first");
                            if(first != null){
                                var oct = oc.get("oc_type");
                                var name = '基本信息';
                                switch (oct) {
                                    case 1:
                                        name = '基本信息';
                                        break;
                                    case 2:
                                        name = '保险责任';
                                        break;
                                    case 3:
                                        name = '免除责任';
                                        break;
                                    case 4:
                                        name = '创新点';
                                        break;
                                    case 11:
                                        name = '重疾（癌症）';
                                        break;
                                    case 12:
                                        name = '轻症';
                                        break;
                                    case 13:
                                        name = '病种创新';
                                        break;
                                }
                                return '<td rowspan="'+rowNum+'" class="color'+(parseFloat(oct)%10)+'">'+name+'</td>';
                            }else{
                                return '';
                            }
                        },
                        contentView:function () {
                            var oc_content_type  = oc.get("oc_content_type");
                            var efunction = {
                                options:function () {
                                    var html = '';
                                    for (var k = 0; k < arr_.length; k++) {
                                        var ov = arr_[k];
                                        var seleted = '';

                                        if(ov.get("oldValue")){
                                            seleted = 'selected="selected"';
                                        }
                                        html+='<option value="'+ov.get("ov_value")+'" ov_id="'+ov.get("ov_id")+'" '+seleted+'>'+ov.get("ov_name")+'</option>';
                                    }
                                    return html;
                                },
                                checked:function () {
                                    return ov.get("oldValue")!=null?'checked odv="'+ov.get("oldValue")+'"':'odv="'+ov.get("oldValue")+'"';
                                }
                            }
                            var contentTemp = '';
                            switch (oc_content_type) {
                                case 1:
                                    contentTemp = 'selectView';
                                    return XCOTemplate.execute(contentTemp, oc, efunction);
                                    break;
                                case 2:
                                    contentTemp = 'radioView';
                                    break;
                                case 3:
                                    contentTemp = 'checkboxView';
                                    break;
                            }
                            var html = '';
                            for (var k = 0; k < arr_.length; k++) {
                                var ov = arr_[k];
                                html += XCOTemplate.execute(contentTemp, ov, efunction);
                            }
                            return html;
                        }
                    };
                    var old = oc.get("oldValue");
                    if(old==0 && oc.get("oc_content_type")==1){
                        oc.setStringValue("total","");
                        oc.setStringValue("oldValueShow","");
                    }else{
                        var total = parseFloat(old)/10000*(parseFloat(oc.get("oc_ratio")/10000));
                        oc.setStringValue("total",total);
                        oc.setStringValue("oldValueShow",parseFloat(old)/10000);
                    }
                    if(old==0 && oc.get("oc_content_type")!=1){
                        var has = false;
                        for (var x = 0; x < arr_.length; x++) {
                            var o = arr_[x];
                            if(o.getStringValue("oldValue")!=null){
                                has = true;
                            }
                        }
                        if(!has){
                            oc.setStringValue("total","");
                            oc.setStringValue("oldValueShow","");
                        }
                    }
                    $("#grade_temp").append(XCOTemplate.execute('grade_temp', oc, extendedFunction))
                    arr_ = new Array();
                    needManage= false;
                    oc = new XCO();
                    oc.fromXML(ov.toString())
                    oc.setStringValue("oldValue",0)
                    lastOv = false;
                }
                if(j != arr.length -1){
                    var oldValue = ov.get("oldValue");
                    if(oldValue!=null){
                        // console.log("b:"+oc.getStringValue("oc_id")+","+ov.get("ov_id")+","+oc.get("oldValue")+","+ov.get("oldValue"))
                        oc.setStringValue("oldValue",parseFloat(oldValue)+parseFloat(oc.getStringValue("oldValue")?oc.getStringValue("oldValue"):0));
                        totalScore += parseFloat(oldValue)/10000*(parseFloat(oc.get("oc_ratio"))/10000);
                    }
                    arr_.push(ov);
                }
            }
            arr = new Array();
            rowNum =0;
            show4end = false;
        }
        arr.push(grade);
        if(dis_oc_id != grade.get("oc_id")){
            dis_oc_id = grade.get("oc_id")
            rowNum ++;
        }
    }
    $("#grade_temp").append(XCOTemplate.execute('lastTr', null, {totalScore:function () {
            return totalScore;
        }}))
}
function change(el,oc_id) {
    var val = $(el).val()
    $("#"+oc_id).text(val/10000)

    var oc_ratio = $("#r"+oc_id).attr('oc_ratio');
    $("#r"+oc_id).text(parseFloat(val)/10000*(parseFloat(oc_ratio)/10000))
    if(el.nodeName=="SELECT" && val==0){
        $("#"+oc_id).text("");
        $("#r"+oc_id).text("");
    }
    caleScore()
}
function changeCK(el,oc_id) {
    var val = 0;
    var hasChecked = false;
    $(".ck"+oc_id).each(function() {
        if ($(this).prop('checked')) {
            val += parseFloat($(this).val());
            hasChecked = true;
        }
    });
    if(hasChecked){
        $("#"+oc_id).text(val/10000)
        var oc_ratio = $("#r"+oc_id).attr('oc_ratio');
        $("#r"+oc_id).text(parseFloat(val)/10000*(parseFloat(oc_ratio)/10000))
    }else{
        $("#"+oc_id).text("");
        $("#r"+oc_id).text("");
    }

    caleScore()
}
function caleScore(){
    var totalScore = 0;
    $("[oc_ratio]").each(function () {
        var score = $(this).text();
        if(!score){
            score = 0;
        }
        totalScore += parseFloat(score)*10000;
    })
    $("#totalScore").text(totalScore/10000);
}

function save(){
    var toatlScore = parseFloat($("#totalScore").text());
    if(toatlScore<0){
        axError("总分数不可为负数")
        return;
    }
    var arr = new Array();
    $(".ov").each(function () {
        var val = $(this).val();
        var oc_id = $(this).attr("oc_id");
        // alert(val+","+oc_id+","+$(this)[0].nodeName+","+$(this).attr("type")+","+$(this).attr("checked"))
        if($(this)[0].nodeName=="SELECT"){
            if(val != 0){
                var one = new XCO();
                one.setStringValue("oc_id",oc_id);
                one.setStringValue("ov_id",$(this).find("option:selected").attr("ov_id"));
                arr.push(one)
            }
        }else{
            if(this.checked){
                var one = new XCO();
                one.setStringValue("oc_id",oc_id);
                one.setStringValue("ov_id",$(this).attr("ov_id"));
                arr.push(one)
            }
        }
    })
    var param = new XCO();
    param.setStringValue("product_no",product_no);
    param.setStringValue("sub_type_id",sub_type_id);
    param.setStringValue("oc_score_type",oc_score_type);
    param.setXCOArrayValue("grades",arr);
	if(oc_score_type ==1){
		param.setStringValue("sys_op_log","责任分打分-产品编号："+product_no);
	}else{
		param.setStringValue("sys_op_log","病种分打分-产品编号："+product_no);
	}    
    if(arr.length == 0){
        axError("请至少选择一项")
        return;
    }
    var options = {
        url : "/productGradeService/saveProductGradeInfo.xco",
        data : param,
        success : saveCallBack
    };
    $.doXcoRequest(options);

}
function saveCallBack(data) {
    if (data.getCode() != 0) {
        axError(data.getMessage());
    }else{
        axSuccess("保存成功")
    }
}