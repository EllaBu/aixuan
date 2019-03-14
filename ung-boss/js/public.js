/*数据库分页查询从0开始*/
var start = 0;
/* 数据库分页查询，每页查询50条数据  */
var pageSize = 50;

var pageSize_10 = 10;
var pageSize_20 = 20;
var pageSize_30 = 30;
var pageSize_100 = 100;

/* 扩大比例 */
var scoreRatio = 10000;

var fileurl = "http://test.file.aixbx.com";

/*confirm询问框*/
function axConfirm(msg,callback){
	layer.confirm(msg, {icon: 3, title:'提示'}, callback);
}

/*成功弹出框*/
function axSuccess(msg,callback){
	layer.msg(msg, {icon: 1, time: 2000}, callback);  
}

/*失败弹出框*/
function axError(msg,callback){
	layer.msg(msg, {icon: 2, time: 2000}, callback);  
}
/*获取URL参数的方法*/
function getURLparam(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}

/*设置URL参数的方法*/
function setURLparam(parms, parmsValue) {
    var urlstrings = document.URL;
    var values = getURLparam(parms);
    //如果参数不存在，则添加参数       
    if (values == undefined) {
        var query = location.search.substring(1); //获取查询串 
        //如果Url中已经有参数，则附加参数
        if (query) {
            urlstrings += ("&" + parms + "=" + parmsValue);
        }
        else {
            urlstrings += ("?" + parms + "=" + parmsValue);  //向Url中添加第一个参数
        }
        window.location = urlstrings;
    }
    else {
        window.location = updateParms(parms, parmsValue);  //修改参数
    }
}

/*修改URL参数，parms：参数名，parmsValue：参数值，return：修改后的URL*/
function updateParms(parms, parmsValue) {
    var newUrlParms = "";
    var newUrlBase = location.href.substring(0, location.href.indexOf("?") + 1); //截取查询字符串前面的url
    var query = location.search.substring(1); //获取查询串   
    var pairs = query.split("&"); //在逗号处断开   
    for (var i = 0; i < pairs.length; i++) {
        var pos = pairs[i].indexOf('='); //查找name=value   
        if (pos == -1) continue; //如果没有找到就跳过   
        var argname = pairs[i].substring(0, pos); //提取name   
        var value = pairs[i].substring(pos + 1); //提取value 
        //如果找到了要修改的参数
        if (findText(argname, parms)) {
            newUrlParms = newUrlParms + (argname + "=" + parmsValue + "&");
        }
        else {
            newUrlParms += (argname + "=" + value + "&");
        }
    }
    return newUrlBase + newUrlParms.substring(0, newUrlParms.length - 1);
}

/*辅助方法*/
function findText(urlString, keyWord) {
    return urlString.toLowerCase().indexOf(keyWord.toLowerCase()) != -1 ? true : false;
}

/*  */
function getURLparamEncoder(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = decodeURI(decodeURI(window.location.search)).substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}

//相关函数
function formatDateTime(_date) {
	if(typeof _date == 'undefined' || null == _date){
		return "";
	}else{
		return XCOUtil.getDateTimeString(_date);       // 格式化时间
	}
}

/**
 * 初始化select工具
 * @param selectId	容器
 * @param url		
 * @param optionVal	 选项value对于的xco的key
 * @param optionName	选项的name对于的xco的key
 * @param checkedVal	预选中的值
 */
function initSelectOption(selectId,url,optionVal,optionName,checkedVal){
	var options ={
			url:url,
			data:new XCO(),
			success: render
	};
	$.doXcoRequest(options);
	function render(data){
		var list = data.getData().get("data");
		if(!list)list = data.getData().get("list");
		var html = '<option value="0">请选择</option>';
		if(list){
			for(var i=0;i<list.length;i++){
				html += "<option value='"+list[i].get(optionVal)+"' "+(list[i].get(optionVal)==checkedVal?"selected":"")+">"+list[i].get(optionName)+"</option>"
			}
		}
		$("#"+selectId).append(html);
	}
}

/**
 * 初始化select工具
 * @param data	xco参数
 * @param selectId	容器
 * @param url		
 * @param optionVal	 选项value对于的xco的key
 * @param optionName	选项的name对于的xco的key
 * @param checkedVal	预选中的值
 */
function initSelectOption2(data,selectId,url,optionVal,optionName,checkedVal){
	var options ={
			url:url,
			data:data,
			success: render
	};
	$.doXcoRequest(options);
	function render(data){
		var list = data.getData().get("data");
		if(!list)list = data.getData().get("list");
		var html = '<option value="0">请选择</option>';
		if(list){
			for(var i=0;i<list.length;i++){
				html += "<option value='"+list[i].get(optionVal)+"' "+(list[i].get(optionVal)==checkedVal?"selected":"")+">"+list[i].get(optionName)+"</option>"
			}
		}
		$("#"+selectId).html(html);
	}
}

//格式化分数
function formatScore(score) {
    return score/10000;       // 格式化分数
}

//判断是否为数字
function isNum(num){
	var reNum=/^\d*$/;
	return(reNum.test(num));
}

//判断是否为数字和英文
function isNumOrLetter(str){
	var reNum=/^[0-9a-zA-Z]+$/;
	return(reNum.test(str));
} 

//重置input输入框
function resetInput(array){
	for ( var int = 0; int < array.length; int++) {
		$(array[int]).val("");
	}
}

/* 标准值字符转码 */
function encodeToXMLText(strText){
	var strOutput="";
	var nLength=strText.length;
	for(var i=0;i<nLength;i=i+1){
		var ch=strText.charAt(i);
		switch(ch){
			case '\'':
				strOutput+="\\\'";
				break;
			case '\"':
				strOutput+="&quot;";
				break;
			//case '\r':
			//	strOutput+="";
			//	break;
			case '\n':
				//strOutput+="\\\\n";
				strOutput+="$N$";
				break;
			default:
				strOutput+=ch;
		}
	}
	return strOutput;
}

String.prototype.formatTextToHTML=function(){
	return this.replace(/&gt;/g,">" ).replace(/&lt;/g,"<" ).replace(/&amp;/g,"&").replace(/&nbsp;/g," ")
	.replace(/&#47;/g,"/").replace(/&apos;/g,"'").replace(/&quot;/g,"\"").replace(/""/g,"\r");
}

