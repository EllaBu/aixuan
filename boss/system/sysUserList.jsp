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
<title>系统用户</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">系统用户管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>系统用户<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>系统用户</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
                           <div class="form-group" style="line-height: 30px;">
                           		<label>用户昵称</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="nickName" placeholder="请输入用户昵称">
                          		<label>用户角色</label>
                          		<select class="form-control w150" id="role"></select>
                          	</div>
                          	<div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">新增系统用户</button>
	                       </div>
                        </div>
					</div>
				</div>
				
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>用户编号</th>
										<th>用户名</th>
										<th>昵称</th>
										<th>身份</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].sys_user_id}</td>
										<td>#{list[i].login_name}</td>
										<td>#{list[i].nick_name}</td>
										<td>#{list[i].role_name}</td>
										<td>@{getState}</td>
										<td>@{getOpt}</td>
									</tr> -->
                                </tbody>
							</table>
                            
                            <jsp:include page="../common/page.jsp"/>
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
	$("#reset").click(function(){
		var array = ["#nickName"];
		resetInput(array);
		$("#role").val(0);
	})	

	sys_role.init();
    
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		getSysUserListPage(0,pageSize);
		$("#role").val(0);
		$("#user_name").val("");
	});
	
	$("#add").click(function(){
		location.href = "../system/addSysUser.jsp";
	});
	
	getSysUserListPage(0,pageSize);
	
	/*获取系统用户列表*/
	function getSysUserListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		var role = $("#role").val();
		var nickName = $("#nickName").val();
		if(role != 0 && role !=null){
			xco.setIntegerValue("role",role);
		}
		if(nickName){
			xco.setStringValue("nickName",nickName);
		}

		var options = {
			url : "/system/getSysUserList.xco",
			data : xco,
			success : getSysUserListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取系统用户列表成功回调*/
	function getSysUserListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			data = data.getData();
			var total = 0;
			total = data.getIntegerValue("total");
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getState : function(){
					var state = list[i].getIntegerValue("state");
					if(state==0){
						return '停用';
					}
					if(state==1){
						return '启用';
					}
					if(state==2){
						return '删除';
					}
				},
				getOpt : function(){
					var state = list[i].getIntegerValue("state");
					if(state==0){
						return '<a class="mar-r-15" href="../system/sysUser.jsp?sysUserId='+list[i].getLongValue("sys_user_id")+'">查看</a><a class="mar-r-15" href="../system/updateSysUser.jsp?sysUserId='+list[i].getLongValue("sys_user_id")+'">编辑</a><a href="javascript:startSysUser('+list[i].getLongValue("sys_user_id")+')">启用</a>';
					}
					if(state==1){
						return '<a class="mar-r-15" href="../system/sysUser.jsp?sysUserId='+list[i].getLongValue("sys_user_id")+'">查看</a><a class="mar-r-15" href="../system/updateSysUser.jsp?sysUserId='+list[i].getLongValue("sys_user_id")+'">编辑</a><a href="javascript:stopSysUser('+list[i].getLongValue("sys_user_id")+')">停用</a>';
					}
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getSysUserListPage, pageSize);
			}
		}
	}
	/*停用用户*/
	function stopSysUser(sysUserId){
		var xco = new XCO();
		xco.setLongValue("sysUserId",sysUserId);
		
		var options = {
			url : "/system/stopSysUser.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("停用成功！",function(){
						location.reload();
					});
				}
			}
		};
		axConfirm("确定停用该用户吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	/*启用用户*/
	function startSysUser(sysUserId){
		var xco = new XCO();
		xco.setLongValue("sysUserId",sysUserId);
		
		var options = {
			url : "/system/startSysUser.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("启用成功！",function(){
						location.reload();
					});
				}
			}
		};
		axConfirm("确定启用该用户吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
</script>