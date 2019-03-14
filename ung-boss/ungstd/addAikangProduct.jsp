<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "爱康产品推荐";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增产品</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-lock"></i><span class="divider"></span><span >爱康管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span> 爱康产品推荐</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>新增产品推荐</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>产品编号</label>
								<input type="text" class="form-control" id="ap_pno" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>产品名称</label>
								<input type="text" class="form-control" id="ap_pname" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>核保模式</label>
								<select class="form-control" id="rule_model">
									<option value="0">请选择</option>
									<option value="1">预警</option>
									<option value="2">评点</option>
									<option value="3">预警+评级</option>
									<option value="5">评点+评级</option>
									<option value="6">评级</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>产品分类</label>
								<select class="form-control" id="series_no">
									<option value="0">请选择</option>
									<option value="1">重疾险</option>
									<option value="2">寿险</option>
									<option value="3">癌症险</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>规则ID</label>
								<select class="form-control" id="rule_id">
									<option value="0">请选择</option>
									<!-- <option value="#{rule_id}">#{rule_id}</option> -->
									
								</select>
							</div>
							<div class="from-group">
								<button class="user-add-save" id="add" type="reset">保存</button>
							</div>
						</div>
						<!-- <div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">保存</button>
						</div> -->
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	
	XCOTemplate.pretreatment(['rule_id']);
	getRules();
	function getRules(){
		var xco = new XCO();
		var options = {
			url : "/rules/selectRulesND.xco",
			data : xco,
			success : channelRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function channelRequestCallBack(data){
		if(data.getCode()==0){
			var dataList=data.getData();
			var html='<option value="0">请选择</option>';
			for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("rule_id", dataList[i], null);
    		}
   			document.getElementById("rule_id").innerHTML = html;
		}
	}
		
	$("#add").click(function(){
		var xco = new XCO();
		var ap_pno=$("#ap_pno").val();
		if(ap_pno){
			xco.setStringValue("ap_pno",ap_pno);
		}else{
			axError("请填写产品编号");
			return;
		}
		var ap_pname=$("#ap_pname").val();
		if(ap_pname){
			xco.setStringValue("ap_pname",ap_pname);
		}else{
			axError("请填写产品名称");
			return;
		}
		var rule_model=$("#rule_model").val();
		if(rule_model!=0){
			xco.setIntegerValue("rule_model",rule_model);
		}else{
			axError("请选择核保模式");
			return;
		}
		xco.setIntegerValue("series_no",$("#series_no").val());
		var rule_id=$("#rule_id").val();
		if(rule_id!=0){
			xco.setLongValue("rule_id",rule_id);
		}else{
			axError("请选择核保规则");
			return;
		}
		var options = {
			url : "/rules/insertAkangRecProduct.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../ungstd/aikangProductList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加推荐产品吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
