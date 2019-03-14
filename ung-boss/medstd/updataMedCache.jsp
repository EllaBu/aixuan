<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "缓存管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>医学管理缓存管理</title>
</head>
<body>
	<div id="main-content" class="clearfix">
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>医学管理缓存管理</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
						
							<div class="user-count">
								<h5>满足以下条件之一即需更新缓存：</h5>
								<p><span Style="color:red;">1、医学管理EXCEL更新</span></p>
								<p><span Style="color:red;">2、所有医学管理菜单内的增删改操作</span></p>
								<div class="user-count-handle">
									<button id="getUngStd" type="reset">更新缓存</button>
								</div>
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

	//添加按钮点击事件监听
	$("#getUngStd").click(function(){
		var xco = new XCO();
		var options = {
			url : "/excelService/updataMedCache.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("更新缓存成功！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	

</script>
