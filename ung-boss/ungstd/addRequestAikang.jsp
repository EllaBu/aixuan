<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "爱康请求";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增核保请求1</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-bar-chart"></i> <span href="#">核保系统</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 新增核保请求</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>获取保险推荐</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>获取保险推荐</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>体检编号</label>
								<input type="text" class="form-control mar-t-15" id="report_sn" style="width:366px;" placeholder="">
							</div>

						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">获取保险推荐</button>
							<a href="ungstd/ikangRequestList.jsp">查看请求列表</a>
						</div>
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	 $("#add").click(function(){
		var xco = new XCO();
		var report_sn=$("#report_sn").val();
		var req_sn_ext = ""+parseInt(Math.random()*100000);
	 	xco.setStringValue("req_sn_ext", req_sn_ext);
		if(report_sn){
			xco.setStringValue("report_sn",report_sn);
		}else{
			axError("请输入体检编号");
			return;
		}
		var options = {
			url : "/securityService/ikangRequest.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("操作成功！",function(){
						location.href="ungstd/ikangRequestList.jsp";
					});
				}
			}
		};
		axConfirm("确定获取保险推荐吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
