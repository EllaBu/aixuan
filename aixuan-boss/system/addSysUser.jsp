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
<title>添加系统用户</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">系统用户管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><a href="../system/sysUserList.jsp">系统用户列表</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li>添加系统用户<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>添加系统用户</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>用户名</label><input type="text" class="form-control"
									id="loginName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>密码</label><input type="text" class="form-control"
									id="passWord" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>昵称	</label><input type="text" class="form-control"
									id="nickName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>角色</label><select id="role" class="form-control"></select>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="addUser">添加</button>
								<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/sys_role.js"></script>
<script type="text/javascript">
	//添加用户时候，获取可用的用户角色
	sys_role.init();

	//添加按钮点击事件监听
	$("#addUser").click(function(){
		var xco = new XCO();
		
		var loginName = $("#loginName").val();
		if(loginName){
			xco.setStringValue("loginName",loginName);
		}else{
			axError("请输入登录用户名");
			return;
		}
		
		var passWord = $("#passWord").val();
		if(passWord){
			xco.setStringValue("passWord",passWord);
		}else{
			axError("请输入密码");
			return;
		}
		
		var nickName = $("#nickName").val();
		if(nickName){
			xco.setStringValue("nickName",nickName);
			xco.setStringValue("realName",nickName);
		}else{
			axError("请输入用户昵称");
			return;
		}
		
		var role = $("#role").val();
		if(role){
			xco.setIntegerValue("role",role);
		}else{
			axError("请选择角色");
			return;
		}
		
		var options = {
			url : "/addSystemUser.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../system/sysUserList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加系统用户吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../system/sysUserList.jsp";
	})
</script>