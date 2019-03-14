<%@ page language="java" pageEncoding="utf8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">


<jsp:include page="/common/comm_css.jsp"></jsp:include>
<!-- PAGE CONTENT BEGINS HERE -->
<!-- basic scripts -->
<script src="/js/jquery-1.11.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<!-- page specific plugin scripts -->

<!--[if lt IE 9]>
    <script type="text/javascript" src="/js/excanvas.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="/js/xco-1.0.1.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js" ></script>
<script type="text/javascript" src="/js/xco.databinding-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.jquery-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.template-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.validate-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.variable-1.0.1.js"></script>
<!-- ace scripts -->
<script src="/js/ace-elements.min.js"></script>
<script src="/js/ace.min.js"></script>
<script type="text/javascript" src="/js/bootstrap-datepicker.min.js"
	charset="utf-8"></script>
<script type="text/javascript" src="/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="/js/jqPaginator.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/autocomplete.js"></script>
<script src="/js/layer/layer.js"></script>
<style>
.icon-little-logo {
	background: url("/image/logo/logo.png") no-repeat center center
		!important;
    background-size: 20px 20px !important;
	width: 20px;
	height: 20px;
	vertical-align: bottom;
}
</style>
</head>
<body>
	<div class="navbar navbar-inverse">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="brand" style="cursor:pointer;">
					<small>
						<i class="icon-little-logo logo"></i>
						爱选核保系统管理后台
					</small> 
				</a>
				<ul class="nav ace-nav pull-right">
					<li class="light-blue user-profile">
						<a class="user-menu dropdown-toggle" >
							<img alt="Jason's Photo" src="/image/user.jpg" class="nav-user-photo" /> 
							<span id="user_info">XXX</span>
						</a>
						<ul id="user_menu" class="pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
						</ul>
					</li>
				</ul>
				<!--/.ace-nav-->
			</div>
			<!--/.container-fluid-->
		</div>
		<!--/.navbar-inner-->
	</div>
	<!--/.navbar-->
	<div class="container-fluid" id="main-container">
		<a href="#" id="menu-toggler"><span></span>
		</a>
		<!-- menu toggler -->
		<div id="sidebar">
			<ul class="nav nav-list">
			</ul>
			<!--/.nav-list-->

			<div id="sidebar-collapse">
				<i class="icon-double-angle-left"></i>
			</div>

		</div>
		<!--/#sidebar-->
	</div>
</body>
<script type="text/javascript">
	$("#sidebar-collapse").click(function(){
		if($("#main-content").css("margin-left")=="190px"){
			$(this).find("i").addClass("icon-double-angle-right").removeClass("icon-double-angle-left");
			$("#main-content").css("margin-left","43px");
		}else{
			$(this).find("i").removeClass("icon-double-angle-right").addClass("icon-double-angle-left");
			$("#main-content").css("margin-left","190px");
		}
	})
</script>

</html>

