<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数值引擎";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增数值引擎</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li><span>数值引擎</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>新增数值引擎</span><span class="divider"></span></li>
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
							<input type="hidden" id="ne_id">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>体检机构</label>
								<select class="form-contro" id="inst_code">
									<option value="0">请选择</option>
									<option value="1001">爱康</option>
									<option value="1002">天方达</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>字段标识</label>
								<input type="text" class="form-control mar-t-15" id="field_key" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>医学标准值编码</label>
								<input type="text" class="form-control mar-t-15" id="std_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>实现类</label>
								<input type="text" class="form-control mar-t-15" id="imp_class" placeholder="">
							</div>
						<!-- 	<div class="from-group mar-t-15">
								<label>处理方式</label>
								<input type="radio" name="te_processing" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">函数</span>
								<input type="radio" name="te_processing" value="2" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">服务</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="ne_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="ne_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>
							<div class="from-group mar-t-15">
								<label>描述</label>
								<textarea id="ne_desc" rows="3"></textarea>
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
	
	$("#add").click(function(){
		var xco = new XCO();
		var instCode=$("#inst_code").val();
		if(instCode!=0){
			xco.setStringValue("inst_code",$("#inst_code").val());
		}else{
			axError("请选择体检机构");
			return;
		}
		var field_key = $("#field_key").val();
		if(field_key=="" || field_key==null){
			axError("请输入字段标识!");
			return;
		}
		var std_code = $("#std_code").val();
		if(std_code=="" || std_code==null){
			axError("请输入医学标准值编码!");
			return;
		}
		var imp_class = $("#imp_class").val();
		if(imp_class=="" || imp_class==null){
			axError("请输入实现类!");
			return;
		}
		
		var ne_desc = $("#ne_desc").val()
		if(ne_desc){
			xco.setStringValue("ne_desc",ne_desc);
		}else{
			axError("请输入描述!");
			return;
		}
		
		xco.setStringValue("field_key",field_key);
		xco.setIntegerValue("te_processing",1); //默认为函数
		xco.setStringValue("ne_desc",$("#ne_desc").val());
		xco.setStringValue("std_code",std_code);
		xco.setIntegerValue("ne_state",$("input[name='ne_state']:checked").val());
		xco.setStringValue("imp_class",imp_class);
		var options = {
			url : "medengine/insertMedNumEngine.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../medstd/numberEngineList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加数值引擎吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
