<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "体检机构";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增文本结论分类</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span>体检机构</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>文本结论分类</span><span class="divider"></span><i class="icon-angle-right"></i> 
    			</li>
    			<li><span>新增文本结论分类</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<!-- <div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>机构名称</label>
								<select class="form-control w150" id="std_code">
									<option value="0">请选择</option>
									<option value="1001">爱康</option>
									<option value="1002">天方达</option>
								</select>
							</div> -->
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>类目名称</label>
								<input type="text" class="form-control mar-t-15" id="tcc_name" style="width:366px;" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>类目标识</label>
								<input type="text" class="form-control mar-t-15" id="tcc_key" style="width:366px;" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>描述</label>
								<input type="text" class="form-control mar-t-15" id="tcc_desc" style="width:366px;" placeholder="">
							</div>
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">保存</button>
						</div>
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	var inst_code = getURLparam("inst_code");
	$("#add").click(function(){
		var xco = new XCO();
		if(inst_code){
			xco.setStringValue("inst_code",inst_code);
		}else{
			axError("请选择机构");
			return;
		}
		var tcc_name=$("#tcc_name").val();
		if(tcc_name){
			xco.setStringValue("tcc_name",tcc_name);
		}else{
			axError("请输入类目名称");
			return;
		}
		var tcc_key=$("#tcc_key").val();
		if(tcc_key){
			xco.setStringValue("tcc_key",tcc_key);
		}else{
			axError("请输入类目标识");
			return;
		}
		var tcc_desc=$("#tcc_desc").val();
		if(tcc_desc){
			xco.setStringValue("tcc_desc",$("#tcc_desc").val());
		}else{
			axError("请输入描述");
			return;
		}
		
		var options = {
			url : "/medtextcon/insertMedtextconcatg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../medstd/medTextCatgList.jsp?inst_code="+inst_code;
					});
				}
			}
		};
		axConfirm("确定添加结论分类吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
