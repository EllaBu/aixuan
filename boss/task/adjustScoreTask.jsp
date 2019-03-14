<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "调整综合分";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>调整综合分任务</title>
<style type="text/css">
#cover {
	display: none;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.44);
}

#coverShow {
	display: none;
	position: fixed;
	z-index: 2;
	top: 50%;
	left: 50%;
	border: 0px solid #127386;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../task/timeTaskList.jsp">定时任务列表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>调整综合分<span class="divider"></span></li>
			</ul>
		</div>

		<div id="cover"></div>
		<div id="coverShow">
			<img src="/image/loaders/4.gif" />
			<p>请稍后......</p>
		</div>
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>调整综合分</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">根据公司系数调整综合分:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">参数格式: 公司ID 公司名称	系数</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">说明: 参数之间使用空格隔开</p>
							</h5>
							<div class="from-group mar-t-15" style="position: relative;top:1px;">
								<textarea rows="10" cols="600" style="margin-left: 180px; width: 450px;" id="arg_info"></textarea> 
							</div>							
							<div class="from-group mar-t-15" style="position: relative;top:1px;">
								<button class="btn btn-success" style="margin-left:180px;" type="submit" id="df_test_btn" onclick="df(1)">开始调整</button>
							</div>
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;margin-top:40px;">
							<div class="from-group mar-t-15" style="position: relative;top:1px;">
								<textarea rows="20" cols="800" style="margin-left: 105px; width: 850px;" id="df_info"></textarea> 
							</div>
							
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">

	var _today = new Date();
	var _qname = 'adjust_score:' + _today.getFullYear() + "_" + _today.getMonth() + "_" + _today.getDay();
	// alert(_qname);
	
	var _start_log = false;
	var _timer = null;
	var _type = 1;
	
	function df(type){
		var xco = new XCO();
		xco.setStringValue("qname", _qname);

		var arg_info = $("#arg_info").val();
		arg_info = $.trim(arg_info);
		
		if('' == arg_info){
			axError("参数为空！");
			return;
		}
		
		var orgs = [];
		
		var arg_array = arg_info.split('\n');
		for(var i=0; i<arg_array.length; i++){
			var line = $.trim(arg_array[i]);
			var line_array = line.split(/\s+/);
			if(3 != line_array.length) {
				axError("每行必须有三个参数！当前:" + line_array.length);
				return;
			} else {
				var org = new XCO();
				org.setLongValue("org_no", parseInt(line_array[0]));
				org.setDoubleValue("ratio", parseFloat(line_array[2]));
				orgs.push(org);
			}
		}
		
		// alert(arg_info);
		xco.setXCOListValue("orgs", orgs);
		// alert(xco);
		doTask(xco);
	}
	
	function doTask(xco){
		var _url = 'scoreService/adjustScore.xco';
		var options = {
			url : _url,
			data : xco,
			success : dfCallBack
		};
		$.doXcoRequest(options);		
	}
	
	function dfCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			return ;
		}
		closeButton();
		axSuccess("同步任务已经提交，请稍候！");
		getLog();
	}
	
	function getLog(){
		_timer = window.setInterval(getLog0, 1000);
	}
	
	function cleanTimer(){
		if(null != _timer){
			window.clearInterval(_timer); 
			_timer = null;
		}
	}
	
	function closeButton(){
		if(1 == _type){
			$("#df_test_btn").removeClass("btn-success");
			$("#df_test_btn").removeAttr("onclick");
		}
		if(2 == _type){
			$("#df_h5_btn").removeClass("btn-success");
			$("#df_h5_btn").removeAttr("onclick");
		}
	}
	
	function getLog0(){
		var xco = new XCO();
		xco.setStringValue("qname", _qname);
		var options = {
			url : "dfService/getDfLog.xco",
			data : xco,
			success : getLogCallBack
		};
		$.doXcoRequest(options);		
	}
	
	function getLogCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			cleanTimer();
			return ;
		}
		
		var list = data.getData();
		if(null == list || 0 == list.length) {
			_start_log = false;
			cleanTimer();
			return;// stop
		}
		
		var df_info_obj = document.getElementById("df_info");
		
		var oldText = df_info_obj.value;
		if(oldText != ''){
			oldText = oldText + '\n';
		}
		var newText = oldText + list.join("\n");
		df_info_obj.value = newText;
		
		df_info_obj.scrollTop = df_info_obj.scrollHeight; // good

	}

</script>