<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "同步请求";
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
			<h1>同步模拟</h1>
           	<a href="../api/addRequestAikang.jsp" class="color_02">爱康产品推荐</a>　
           	<a href="../api/addRequestWarnByUser.jsp" class="color_02">普通预警(用户信息)</a>　
           	<a  class="color_01"><strong>普通预警(体检编号)</strong></a>　
           	<a href="../api/addRequestGradeByReport.jsp" class="color_02">健康评测(体检编号)</a>			
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
							<div class="from-group mar-t-15">
								<label>核保模式</label>
								<select class="form-control w150" id="rule_model">
									<option value=1 selected>预警</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>类目</label>
								<select class="form-control w150" id="series_no">
									<option value=0 selected>全部</option>
									<option value=1 >重疾险</option>
									<option value=2 >寿险</option>
									<option value=3 >癌症险</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>渠道ID</label>
								<input type="text" class="form-control mar-t-15" id="ch_id" style="width:366px;" placeholder="">
							</div>								
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">发起核保请求</button>
						</div>
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	 var req_sn_ext = ""+new Date().getTime();
	 $("#req_sn_ext").val(req_sn_ext);
	 $("#add").click(function(){
		var xco = new XCO();
		var report_sn=$("#report_sn").val();
	 	xco.setStringValue("req_sn_ext", req_sn_ext);
	 	xco.setIntegerValue("series_no",$("#series_no").val());
		xco.setIntegerValue("rule_model", $("#rule_model").val());
	 	var ch_id = $("#ch_id").val();
		if(ch_id){
			if(isNaN(ch_id)){ 
				axError("渠道请输入数字");
				document.getElementById("ch_id").focus();
				return;
			}else{
				xco.setIntegerValue("ch_id", ch_id);
			}
		}else{
			axError("请输入渠道");
			return;
		}		
		if(report_sn){
			xco.setStringValue("rp_code",report_sn);
		}else{
			axError("请输入体检编号");
			return;
		}
		var options = {
			url : "/warnByReport.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage(),function(){
						window.location.reload();
					});					
				}else{
					axSuccess("请求成功！",function(){
						window.location.reload();
					});				
				}
			}
		};
		axConfirm("确定提交核保请求吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
