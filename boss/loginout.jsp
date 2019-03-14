<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// String urlScheme = cn.shareos.core.web.Constant.urlScheme;
	String urlScheme = request.getScheme() + "://";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>退出</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">

<SCRIPT src="/js/jquery-1.11.1.min.js" crossorigin="anonymous"></SCRIPT>
<SCRIPT src="/js/xco-1.0.1.js" crossorigin="anonymous"></SCRIPT>
<SCRIPT src="/js/xco.jquery-1.0.1.js" crossorigin="anonymous"></SCRIPT>
</head>
<body>
	<script type="text/javascript">
	doSysExit();
	function doSysExit() {
		var xco = new XCO();
		var options = {
			url : "/sysExit.xco",
			data : xco,
			success : doUserExitCallBack
		};
		$.doXcoRequest(options);
	}

	function doUserExitCallBack(data) {
		location.href="http://sso.boss.aixbx.com/backstage";
	}
	</script>
</body>
</html>
