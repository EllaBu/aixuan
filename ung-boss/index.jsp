<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>XXX</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Expires" content="0">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="Cache" content="no-cache">

</head>
<body>
	<h2>hello, world.1</h2>
	
	<a href="###" onclick="doRquest()">测试XCO请求</a>
	
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/xco-1.0.1.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js" ></script>
<script type="text/javascript" src="/js/xco.databinding-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.jquery-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.template-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.validate-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.variable-1.0.1.js"></script>
<script type="text/javascript">
	function doRquest(){
		var xco = new XCO();
		xco.setIntegerValue("start", 0);
		xco.setIntegerValue("pageSize", 20);
		var options = {
			url : "/standard/standardList.xco",
			data : xco,
			success : doRquestCallBack
		};
		$.doXcoRequest(options);		
	}
	
	function doRquestCallBack(data){
		if(0 != data.getCode()){
			alert(data.getMessage());
			return;
		}
		data = data.getData();
		alert(data);		
	}
	
</script>
</body>
</html>
