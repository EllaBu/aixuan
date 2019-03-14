<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "异步请求";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增核保请求</title>
</head>
<style type="text/css">
	.color_01{
		color: blue;
		cursor:pointer;
	}
	.color_02{
		color: black;
		cursor:pointer;
	}	
</style>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-random"></i> <span href="#">核保模拟</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 新增核保请求</span>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>异步模拟</h1>
           	<a href="../api/addRequest2.jsp"  class="color_02">爱康产品推荐(老)</a>　
           	<a  class="color_01"><strong>爱康产品推荐(新)</strong></a>　
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>请求编号</label>
								<input type="text" readonly="readonly" class="form-control mar-t-15" id="req_sn_ext" style="width:366px;" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>体检编号</label>
								<input type="text" class="form-control mar-t-15" id="report_sn" style="width:366px;" placeholder="">
							</div>

						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">获取保险推荐</button>
							<a href="http://ung.boss.aixbx.com/ungstd/ikangRequestList.jsp">查看请求列表</a>
						</div>
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	 var req_sn_ext = "AN:"+new Date().getTime();
	 $("#req_sn_ext").val(req_sn_ext);
	 $("#add").click(function(){
		var xco = new XCO();
		var report_sn=$("#report_sn").val();
	 	xco.setStringValue("req_sn_ext", req_sn_ext);
	 	xco.setStringValue("mode", "A001");
		if(report_sn){
			xco.setStringValue("rp_code",report_sn);
		}else{
			axError("请输入体检编号");
			return;
		}
		var options = {
			url : "/aikangAsyn.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("请求成功！",function(){
						window.location.reload();
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
