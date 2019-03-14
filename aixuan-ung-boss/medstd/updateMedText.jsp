<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "文本结论";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>修改文本结论</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span>文本结论</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>修改文本结论</span><span class="divider">
			</span>
			</li>
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
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>体检机构</label>
								<select class="form-control" id="inst_code" onchange="dogetTextCatgList()">
									<!-- <option value="#{inst_code}">#{inst_name}</option> -->
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>分类</label>
								<select class="form-control" id="tcc_id">
									<!-- <option value="#{tcc_id}">#{tcc_name}</option> -->
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>文本结论</label>
								<input type="text" class="form-control mar-t-15" id="tcm_context" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>医学标准值</label>
								<input type="text" class="form-control mar-t-15"  id="std_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>三方字段编码</label>
								<input type="text" class="form-control mar-t-15" id="tcm_tp_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>字段名称</label>
								<input type="text" class="form-control mar-t-15" id="field_key" placeholder="">
							</div>
							<input type="hidden" id="oldtcc_id">
							<input type="hidden"  id="tcm_id">
							<!-- <div class="from-group mar-t-15">
								<label>数据提取</label>
								<input type="radio" name="text_type" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">需要</span>
								<input type="radio" name="text_type" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">不需要</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="text_type" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="text_type" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>
							<!-- <div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="tcm_state" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">启用</span>
								<input type="radio" name="tcm_state" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="tcm_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="tcm_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>
							<div class="from-group mar-t-15">
								<label>描述</label>
								<textarea id="tcm_desc" rows="3"></textarea>
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
	var tcm_id = getURLparam("tcm_id");
	XCOTemplate.pretreatment(['inst_code','tcc_id']);
	dogetInstList();
	function dogetInstList(){
		var xco =new XCO();
		var options = {
			url : "/standard/selectItems.xco",
			data : xco,
			success : instRequestCallBack
		};
		$.doXcoRequest(options);		
	}
	function instRequestCallBack(data){
		if(data.getCode()==0){
			var dataList=data.getData();
			var html = '<option value="0">请选择</option>';
			for (var i = 0; i < dataList.length; i++) {
	        	html += XCOTemplate.execute("inst_code", dataList[i], null);
	    	}
	    	document.getElementById("inst_code").innerHTML = html;
		}
		dogetTextInfo();
	}
	
	function dogetTextCatgList(){
		var xco =new XCO();
		var inst_code=$("#inst_code").val();
		if(inst_code){
			xco.setStringValue("inst_code",inst_code);
		}else {
			return;
		}
		var options = {
			url : "/standard/selectInsNames.xco",
			data : xco,
			success : instCatgRequestCallBack
		};
		$.doXcoRequest(options);	
	}
	
	function instCatgRequestCallBack(data){
		$("#tcc_id").empty();
		var oldtcc_id=$("#oldtcc_id").val();
		var html = '<option value="0">请选择</option>';	
		if(data.getCode()==0){
			var dataList=data.getData();
			for (var i = 0; i < dataList.length; i++) {
	        	html += XCOTemplate.execute("tcc_id", dataList[i], null);
	    	}
		}
		document.getElementById("tcc_id").innerHTML = html; 
		if(oldtcc_id){
			$("#tcc_id").val(oldtcc_id);
		}
	}
	
	function dogetTextInfo(){
		var xco =new XCO();
		xco.setIntegerValue("tcm_id", tcm_id);
		var options = {
			url : "/medtextcon/findMedTextConMappingByID.xco",
			data : xco,
			success : textInfoCallBack
		};
		$.doXcoRequest(options);
	}
	
	function textInfoCallBack(data){
		if(data.getCode()==0){
			var obj=data.getData();
			$("#tcm_id").val(obj.get("tcm_id"));
			$("#inst_code").val(obj.get("inst_code"));
			$("#oldtcc_id").val(obj.get("tcc_id"));
			$("#tcm_context").val(obj.get("tcm_context"))
			$("#std_code").val(obj.get("std_code"));
			$("#field_key").val(obj.get("field_key"));
			$("#tcm_tp_code").val(obj.get("tcm_tp_code"));
			$("#tcm_desc").val(obj.get("tcm_desc"));
			
			$("input[name='tcm_state']").each(function(i,el){
				if($(el).val()==obj.get('tcm_state')){
					$(el).prop("checked",true);
				}
			});
			$("input[name='text_type']").each(function(i,el){
				if($(el).val()==obj.get('text_type')){
					$(el).prop("checked",true);
				}
			});	
			dogetTextCatgList();
		}
	}
	
	
	$("#add").click(function(){
		var xco = new XCO();
		var inst_code=$("#inst_code").val();
		if(inst_code!=0){
			xco.setStringValue("inst_code",inst_code);
		}else{
			axError("请选择机构");
			return;
		}
		var tcc_id=$("#tcc_id").val();
		if(tcc_id!=0){
			xco.setIntegerValue("tcc_id",tcc_id);
		}else{
			axError("请选择分类");
			return;
		}
		
		var tcm_context=$("#tcm_context").val();
		if(tcm_context){
			xco.setStringValue("tcm_context",tcm_context);
		}else{
			axError("请输入文本结论");
			return;
		}
		var std_code=$("#std_code").val();
		if(std_code!=0){
			xco.setStringValue("std_code",std_code);
		}else{
			axError("请输入医学标准项");
			return;
		}
		var tcm_tp_code=$("#tcm_tp_code").val();
		if(tcm_tp_code){
			xco.setStringValue("tcm_tp_code",$("#tcm_tp_code").val());
		}else{
			axError("请输入三方字段编码");
			return;
		}
		var field_key=$("#field_key").val();
		if(field_key){
			xco.setStringValue("field_key",$("#field_key").val());
		}else{
			axError("请输入字段名称");
			return;
		}

		var tcm_desc=$("#tcm_desc").val();
		if(tcm_desc){
			xco.setStringValue("tcm_desc",$("#tcm_desc").val());
		}else{
			axError("请输入描述");
			return;
		}
		xco.setIntegerValue("tcm_state",$("input[name='tcm_state']:checked").val());
		xco.setIntegerValue("text_type",$("input[name='text_type']:checked").val());
		xco.setIntegerValue("tcm_id", $("#tcm_id").val());
		var options = {
			url : "/medtextcon/updateMedTextConMappingByID.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../medstd/textList.jsp";
					});
				}
			}
		};
		axConfirm("确定修改文本结论吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
