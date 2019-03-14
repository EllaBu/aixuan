<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增标准项</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li><span>标准项管理</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>新增标准项</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增</h1>
<!-- 			<div class="form-add-new">
                <button class="btn btn-info" type="reset">保存 ✔</button>
         	</div> -->
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>标准项编码</label>
								<input type="text" class="" id="std_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>中文名</label>
								<input type="text" class="form-control" id="std_cn_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>英文名</label>
								<input type="text" class="form-control" id="std_en_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>KEY</label>
								<input type="text" class="form-control" id="std_key" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>类型</label>
								<select class="form-control" id="std_type">
									<option value="0">请选择</option>
									<option value="1">数值型</option>
									<option value="2">阴阳性</option>
									<option value="3">文本型</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>过期时间</label>
								<input type="number" class="form-control" id="std_invalidtime" placeholder="">
							</div>
							<div class="from-group mar-t-15">
			                <label>单位</label>
				                <input type="text" class="form-control"  style="width:105px;" id="std_unit1">
				                <input type="text" class="form-control" name="title" style="width:105px;" id="std_unit2">
				                <input type="text" class="form-control" name="title" style="width:104px;" id="std_unit3">
			              	</div>
							<div class="from-group mar-t-15">
								<label>分类</label>
								<select class="form-control" id="std_catg_id">
									<option value="0">请选择</option>
									<!-- <option value="#{std_catg_id}">#{catg_name}</option> -->
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="std_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="std_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>
							<div class="from-group mar-t-15">
								<label>描述</label>
								<textarea id="std_desc" rows="3"></textarea>
							</div>
							<div class="from-group">
								<button class="user-add-save" id="add" type="reset">保存</button>
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
	
	XCOTemplate.pretreatment(['std_catg_id']);
	dogetStdCatg();
	function dogetStdCatg(){
		var xco=new XCO();
		var options = {
			url : "/standard/stdcatgList.xco",
			data : xco,
			success : function(data){
			if(data.getCode()==0){
				 var dataList=data.getData();
				 var html='<option value="0">请选择</option>';
				 for (var i = 0; i < dataList.length; i++) {
			        	html += XCOTemplate.execute("std_catg_id", dataList[i], null);
		    	 }
	    	 	 document.getElementById("std_catg_id").innerHTML = html;
			}
		}
	};
		$.doXcoRequest(options);
	}
	
	$("#add").click(function(){
		var xco = new XCO();
		var std_code=$("#std_code").val();
		if(std_code){
			xco.setStringValue("std_code",std_code);
		}else{
			axError("请输入标准项编码");
			return;
		}
		var std_type=$("#std_type").val();
		if(std_type!=3){
			var std_cn_name=$("#std_cn_name").val();
			if(std_cn_name){
				xco.setStringValue("std_cn_name",std_cn_name);
			}else{
				axError("请输入中文名称");
				return;
			}
			var std_en_name=$("#std_en_name").val();
			if(std_en_name){
				xco.setStringValue("std_en_name",std_en_name);
			}else{
				axError("请输入英文名称");
				return;
			}
		}else{
			xco.setStringValue("std_en_name","");
			xco.setStringValue("std_cn_name","");
		}
		var std_key=$("#std_key").val();
		if(std_key){
				xco.setStringValue("std_key",std_key);
		}else{
			axError("请输入KEY");
			return;
		}
		if(std_type==0){
			axError("请选择分类");
			return;
		}
		
		
		var std_unit1=$("#std_unit1").val();
		if(std_type!=3){
			if(std_unit1){
				xco.setStringValue("std_unit1",std_unit1);
			}else{
				axError("请输入单位1");
				return;
			}
		}
		var std_catg_id=$("#std_catg_id").val();
		if(std_catg_id==0){
			axError("请选择分类");
			return;
		}
		var std_desc=$("#std_desc").val();
		if(std_desc){
			xco.setStringValue("std_desc",std_desc);
		}else{
			axError("请输入描述");
			return;
		}
		xco.setStringValue("std_unit2",$("#std_unit2").val());
		xco.setStringValue("std_unit3",$("#std_unit3").val());
		xco.setLongValue("std_catg_id",std_catg_id);
		xco.setIntegerValue("std_type",std_type);
		xco.setIntegerValue("std_state",$("input[name='std_state']:checked").val());
	
		var time=$("#std_invalidtime").val();
		if(time){
			xco.setIntegerValue("std_invalidtime",time);
		}else{
			xco.setIntegerValue("std_invalidtime",0);
		}
		xco.setStringValue("std_sug_code",$("#std_sug_code").val());
		var options = {
			url : "/standard/insertStandard.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../medstd/stdList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加标准项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
