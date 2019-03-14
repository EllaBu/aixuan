<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项分类";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>修改标准项分类</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><span>医学管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span>医学标准项分类</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>修改标准项分类</span><span class="divider">
			</span>
			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>修改</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<input type="hidden" id="std_catg_id">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>类型名称</label>
								<input type="text" class="form-control mar-t-15" id="catg_name" style="width:366px;" placeholder="">
							</div>
							<!-- <div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="catg_state" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">启用</span>
								<input type="radio" name="catg_state" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="catg_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="catg_state" value="0" class="ace">
								<span class="lbl">停用</span>
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
	var std_catg_id = getURLparam("std_catg_id");
	dogetStdCatgInfo()
	function dogetStdCatgInfo(){
		var xco=new XCO();
		xco.setLongValue("std_catg_id", std_catg_id);
		var options = {
			url : "/standard/stdcatgInfo.xco",
			data : xco,
			success : function(data){
				if(data.getCode()==0){
					var obj=data.getData();
					$("#std_catg_id").val(obj.get("std_catg_id"));
					$("#catg_name").val(obj.get("catg_name"));
					$("input[name='catg_state']").each(function(i,el){
						if($(el).val()==obj.get('catg_state')){
							$(el).prop("checked",true);
						}
					});
				}
			}
		}
		$.doXcoRequest(options);
	}
	
	
	
	$("#add").click(function(){
		var xco = new XCO();
		var catg_name=$("#catg_name").val();
		if(catg_name){
			xco.setStringValue("catg_name",catg_name);
		}else{
			axError("请输入分类名称");
			return;
		}
		xco.setLongValue("std_catg_id", std_catg_id);
		xco.setIntegerValue("catg_state",$("input[name='catg_state']:checked").val());
		var options = {
			url : "/standard/updateMedStdCatg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../medstd/medStdCatgList.jsp";
					});
				}
			}
		};
		axConfirm("确定修改标准项分类吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
