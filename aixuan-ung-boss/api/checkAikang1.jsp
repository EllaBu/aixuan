<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "接口测试";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>核保检查接口测试</title>
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
			<li><i class="icon-random"></i> <span href="#">接口测试</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 核保检查</span>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>核保检查接口测试</h1>
			<a  class="color_01"><strong>核保检查</strong></a>　
           	<a href="../api/checkAikang2.jsp" class="color_02">核保检查(指定体检后)</a>　
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>身份证号</label>
								<input type="text"  class="form-control mar-t-15" id="idcard" style="width:366px;" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>产品编号</label>
								<input type="text" class="form-control mar-t-15" id="ap_pno" style="width:366px;" placeholder="">
							</div>

						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">发起请求</button>
						</div>
						
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
							<label>返回结果</label>
								<textarea id="result" style="width:50%" rows="5" cols="2"></textarea>
							</div>
						</div>						
					</div>		
				</div>
			</div>
	</div>
</div>
<script type="text/javascript" src="/js/jquery.form.js"></script>
</body>
</html>
<script type="text/javascript">
	 $("#add").click(function(){
		var xco = new XCO();
		var idcard=$("#idcard").val();
		if(idcard){
			xco.setStringValue("idcard",idcard);
		}else{
			axError("请输入身份证号");
			return;
		}
		var ap_pno=$("#ap_pno").val();
		if(ap_pno){
			xco.setStringValue("ap_pno",ap_pno);
		}else{
			axError("请输入产品编号");
			return;
		}		
		var options = {
			url : "/checkSimple.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage(),function(){
						$("#result").val(data.get("data"));
					});					
				}else{
					axSuccess("请求成功！",function(){
						$("#result").val(data.get("data"));
					});				
				}
			}
		};
		axConfirm("确定发起请求吗?",function(){
			$("#result").val("");
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
