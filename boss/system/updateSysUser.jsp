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
<title>编辑系统用户</title>
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
				<li>编辑系统用户<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑系统用户</h1>
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
								<label>角色</label><select id="role" class="form-control"></select>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="updateUser">保存</button>
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
	//从系统用户列表传递过来的用户ID
	var sysUserId = getURLparam("sysUserId");
	
	getSysUser();
	
	//通过ID获取系统用户基本资料
	function getSysUser(){
		var xco = new XCO();
		xco.setLongValue("sysUserId",sysUserId);
		var options = {
			url : "/system/getSysUser.xco",
			data : xco,
			success : getSysUserCallBack
		};
		
		$.doXcoRequest(options);
	}
	
	//获取系统用户基本资料成功回调
	function getSysUserCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			$("#loginName").text(data.getStringValue("login_name"));
			$("#nickName").text(data.getStringValue("nick_name"));
			//修改角色时候，获取所有的用户角色，并选中当前角色
			sys_role2.init(data.getIntegerValue("role"));
		}
	}

	//修改按钮点击事件监听
	$("#updateUser").click(function(){
		var xco = new XCO();
		xco.setLongValue("sysUserId",sysUserId);
		
		var role = $("#role").val();
		if(role){
			xco.setIntegerValue("role",role);
		}else{
			axError("请选择角色");
			return;
		}
		
		var options = {
			url : "/system/updateSysUserRole.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../system/sysUserList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存系统用户吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	
	//返回按钮点击事件监听
	$("#exit").click(function(){
		location.href="../system/sysUserList.jsp";
	})
</script>