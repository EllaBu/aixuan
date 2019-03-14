<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "系统用户";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>系统用户详情</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">系统用户管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><a href="../system/sysUserList.jsp">系统用户</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li>系统用户详情<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>系统用户详情</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>用户名</label><span id="loginName"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>昵称</label><span id="nickName"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>角色</label><span id="role"></span>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-info" type="submit" id="exit">返回</button>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	
	var sysUserId = getURLparam("sysUserId");
	
	getSysUser();
	
	/*获取用户基本资料*/
	function getSysUser(){
		var xco = new XCO();
		xco.setLongValue("sysUserId",sysUserId);
		var options = {
			url : "/system/getSysUserAndRole.xco",
			data : xco,
			success : getSysUserCallBack
		};
		
		$.doXcoRequest(options);
	}
	
	/*获取用户基本资料成功回调*/
	function getSysUserCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			$("#loginName").text(data.getStringValue("login_name"));
			$("#nickName").text(data.getStringValue("nick_name"));
			$("#role").text(data.getStringValue("role_name"));
		}
	}

	/*返回按钮成功回调*/
	$("#exit").click(function(){
		location.href="../system/sysUserList.jsp";
	})
</script>