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
<title>新增体检机构</title>
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
			<li><span>新增体检机构</span><span class="divider">
			</span>
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
								<label><span style="color:red;">*</span>机构编码</label>
								<input onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" type="text" class="form-control mar-t-15" id="inst_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>机构名称</label>
								<input type="text" class="form-control mar-t-15" id="inst_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>接口地址</label>
								<input type="text" class="form-control mar-t-15" id="inst_api" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>密钥</label>
								<input type="text" class="form-control mar-t-15" id="inst_secret_key" placeholder="">
							</div>
							<!-- <div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="inst_state" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">启用</span>
								<input type="radio" name="inst_state" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="inst_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="inst_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>	
							<div class="from-group mar-t-15">
								<label>描述</label>
								<textarea id="inst_desc" rows="3"></textarea>
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
		var inst_code=$("#inst_code").val();
		if(inst_code){
			xco.setStringValue("inst_code",inst_code);
		}else{
			axError("请输入机构编码");
			return;
		}
		var inst_name=$("#inst_name").val();
		if(inst_name){
			xco.setStringValue("inst_name",inst_name);
		}else{
			axError("请输入机构名称");
			return;
		}
		var inst_api=$("#inst_api").val();
		if(inst_api){
			xco.setStringValue("inst_api",inst_api);
		}else{
			axError("请输入接口地址");
			return;
		}
		var inst_secret_key=$("#inst_secret_key").val();
		if(inst_secret_key){
			xco.setStringValue("inst_secret_key",inst_secret_key);
		}else{
			axError("请输入密钥");
			return;
		}
		var inst_desc=$("#inst_desc").val();
		if(inst_desc){
			xco.setStringValue("inst_desc",$("#inst_desc").val());
		}else{
			axError("请输入描述");
			return;
		}

		xco.setIntegerValue("inst_state",$("input[name='inst_state']:checked").val());
		xco.setStringValue("inst_desc",$("#inst_desc").val());
		var options = {
			url : "/medinstitution/insertMedInstitution.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../medstd/medInstList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加机构吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
