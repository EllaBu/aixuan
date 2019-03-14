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
<title>修改数值引擎</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li><span>数值引擎</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>修改数值引擎</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-edit"></i>修改</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
						<input type="hidden" id="ne_id">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>体检机构</label>
								<select class="form-control" id="inst_code">
									<option value="1001">爱康</option>
									<option value="1002">天方达</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>字段标识</label>
								<input type="text" class="form-control mar-t-15" id="field_key" placeholder="">
							</div>
						<!-- 	<div class="from-group mar-t-15">
								<label>处理方式</label>
								<select class="form-control w150" id="te_processing">
									<option value="0">请选择</option>
									<option value="1">函数</option>
									<option value="2">服务</option>
								</select>
							</div> -->
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>医学标准值编码</label>
								<input type="text" class="form-control mar-t-15" id="std_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>实现类</label>
								<input type="text" class="form-control mar-t-15" id="imp_class" placeholder="">
							</div>
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
	var ne_id = getURLparam("ne_id");
	dogetStdInfo();
	function dogetStdInfo(){
		var xco = new XCO();
		xco.setLongValue("ne_id",ne_id);
		var options = {
			url : "/medengine/findMedNumEngineByID.xco",
			data : xco,
			success : function(data){
				if(data.getCode()==0){
				var xco=data.getData();
				$("#ne_id").val(xco.get("ne_id"));
				$("#inst_code").val(xco.get("inst_code"));
				$("#field_key").val(xco.get("field_key"));
				$("#te_processing").val(xco.get("te_processing"));
				$("#std_code").val(xco.get("std_code"));
				$("#ne_desc").val(xco.get("ne_desc"));
				$("#imp_class").val(xco.get("imp_class"));
				$("input[name='ne_state']").each(function(i,el){
						if($(el).val()==xco.get('std_state')){
							$(el).prop("checked",true);
						}
					});
				}else{
					axError("服务异常");
				}
			}
		}
		$.doXcoRequest(options);
	}
	
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
		xco.setLongValue("ne_id",$("#ne_id").val());
		xco.setStringValue("inst_code",$("#inst_code").val());
		xco.setStringValue("field_key",field_key);
		//xco.setIntegerValue("te_processing",$("#te_processing").val());
		xco.setStringValue("ne_desc",$("#ne_desc").val());
		xco.setStringValue("std_code",std_code);
		xco.setIntegerValue("ne_state",$("input[name='ne_state']:checked").val());
		xco.setStringValue("imp_class",$("#imp_class").val());
		var options = {
			url : "/medengine/updateMedNumEngineByID.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../medstd/numberEngineList.jsp";
					});
				}
			}
		};
		axConfirm("确定修改数值引擎吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
