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
<title>新增标准项分类</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	 <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span>
					<span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li><span>医学标准项分类</span><span class="divider"><i class="icon-angle-right"></i></span></li>
				<li><span>新增标准项分类</span><span class="divider"></span></li>
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
								<label><span style="color:red;">*</span>类型名称</label>
								<input type="text" class="form-control mar-t-15" id="catg_name" placeholder="">
							</div>
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
	
	
	
	$("#add").click(function(){
		var xco = new XCO();
		var catg_name=$("#catg_name").val();
		if(catg_name){
			xco.setStringValue("catg_name",catg_name);
		}else{
			axError("请输入分类名称");
			return;
		}
		xco.setIntegerValue("catg_state",$("input[name='catg_state']:checked").val());
		var options = {
			url : "/standard/insertMedStdCatg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../medstd/medStdCatgList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加标准项分类吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
