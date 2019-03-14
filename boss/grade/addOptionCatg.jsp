<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String a = request.getParameter("oc_score_type");
	String pageName = "责任分打分配置";
	if("2".equals(a)){
		pageName = "病种分打分配置";
	}
%>
<%@ include file="../common/menu_and_navbar_ung.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增分项</title>
<style>
.f-tip {
	color: #2679b5;
	margin-left: 20px;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-signal"></i><span class="divider"></span><span>打分管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li><span id="oc_score_type"></span><span>打分配置</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>新增分项</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增&nbsp;&nbsp;<span id="series_name"></span></h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>分项名称</label>
								<input type="text" id="oc_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>分项类型</label>
								<select id="oc_type_duty" style="display:none">
									<option value=0>请选择</option>
									<option value=1>基本信息</option>
									<option value=2>保险责任</option>
									<option value=3>免除责任</option>
									<option value=4>创新点</option>
								</select>
								<select id="oc_type_disease" style="display:none">
									<option value=0>请选择</option>
									<option value=11>重疾（癌症）</option>
									<option value=12>轻症</option>
									<option value=13>病种创新</option>									
								</select>								
								<!-- <span class="f-tip">固定选项：基本信息，保险责任，免除责任，创新点</span> -->
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选择类型</label>
								<select id="oc_content_type">
									<option value=0>请选择</option>
									<option value=1>列表</option>
									<option value=2>单选</option>
									<option value=3>复选</option>	
								</select>
								<!-- <span class="f-tip">固定选项：列表，单选，复选</span> -->
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>分项占比</label>
								<input id="oc_ratio" type="text" placeholder="" value=100>
								<b>%</b>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>分项顺序</label>
								<input id="oc_sort" type="text" placeholder="">
								<span class="f-tip">建议以10为单位递增</span>
							</div>
							<div class="from-group">
								<button id="add" class="user-add-save" type="reset">保存</button>
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
	var series_no = getURLparam("series_no");//二级分类
	var series_name = getURLparamEncoder("series_name");//二级分类名称
	var oc_score_type = getURLparam("oc_score_type");//打分类型[1:责任, 2:病种]
	if(oc_score_type==1){
		$("#oc_score_type").text("责任分");
		$("#oc_type_duty").css("display","");
		$("#oc_type_disease").css("display","none");
	}
	if(oc_score_type==2){
		$("#oc_score_type").text("病种分");
		$("#oc_type_duty").css("display","none");
		$("#oc_type_disease").css("display","");
	}	
	$("#series_name").text(series_name);
	$("#add").click(function(){
		var xco = new XCO();
		var oc_name=$("#oc_name").val();
		if(oc_name){
			xco.setStringValue("oc_name",oc_name);
		}else{
			axError("请输入分项名称");
			return;
		}
		
		var oc_type=1;
		if(oc_score_type==1){
			oc_type=$("#oc_type_duty").val();
		}
		if(oc_score_type==2){
			oc_type=$("#oc_type_disease").val();
		}		
		if(oc_type != 0){
				xco.setIntegerValue("oc_type",oc_type);
		}else{
			axError("请选择分项类型");
			return;
		}
		var oc_content_type=$("#oc_content_type").val();
		if(oc_content_type != 0){
				xco.setIntegerValue("oc_content_type",oc_content_type);
		}else{
			axError("请选择选择类型");
			return;
		}
		var oc_ratio = $("#oc_ratio").val();
		if(isNaN(oc_ratio)){
			axError("分项占比请输入数字");
			document.getElementById("oc_ratio").focus();
			return;
		}
		if(oc_ratio){
			oc_ratio = parseInt(oc_ratio);
			oc_ratio = oc_ratio * 100;
			xco.setIntegerValue("oc_ratio",oc_ratio);
		}else{
			axError("请输入分项占比");
			return;
		}				
		var oc_sort=$("#oc_sort").val();
		if(isNaN(oc_sort)){
			axError("分项顺序请输入数字");
			document.getElementById("oc_sort").focus();
			return;
		}
		if(oc_sort){
			xco.setIntegerValue("oc_sort",oc_sort);
		}else{
			axError("请输入分项顺序");
			return;
		}
		xco.setIntegerValue("sub_type_id", series_no);
		xco.setStringValue("sub_type_name", series_name);
		xco.setIntegerValue("oc_score_type", oc_score_type);
		if(oc_score_type ==1){
			xco.setStringValue("sys_op_log","新增责任分分项-："+oc_name);
		}else{
			xco.setStringValue("sys_op_log","新增病种分分项-："+oc_name);
		}		
		var options = {
			url : "/grade/insertGOptionCatg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("新增成功！",function(){
						location.href="../grade/optionList.jsp?series_no="+series_no+"&series_name="+series_name+"&oc_score_type="+oc_score_type;
					});
				}
			}
		};
		axConfirm("确定新增分项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
