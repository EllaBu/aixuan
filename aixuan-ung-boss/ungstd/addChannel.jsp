<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "渠道管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增渠道</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 渠道管理</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>新增渠道</span><span class="divider"></span>
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
								<label><span style="color:red;">*</span>渠道名称</label>
								<input type="text" class="form-control" id="ch_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>类型</label>
								<select class="form-control" id="ch_type">
									<option value="0">请选择</option>
									<option value="1">代理</option>
									<option value="2">保险</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>计费规则</label>
								<select class="form-control" id="ch_billing">
									<option value="0">请选择</option>
									<option value="1">按次</option>
									<option value="2">包年</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>响应方式</label>
								<select class="form-control" id="ch_reponse">
									<option value="0">请选择</option>
									<option value="1">同步</option>
									<option value="2">异步</option>
									<option value="3">同步+异步</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>回调地址</label>
								<input type="text" class="form-control" id="ch_callbak" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>密钥</label>
								<input type="text" class="form-control" id="ch_secret_key" placeholder="">
							</div>
							<!-- <div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>状态</label>
								<input type="radio" name="ch_state" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">启用</span>
								<input type="radio" name="ch_state" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="ch_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="ch_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>	
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>描述</label>
								<textarea id="ch_desc" rows="3"></textarea>
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
		var ch_name=$("#ch_name").val();
		if(ch_name){
			xco.setStringValue("ch_name",ch_name);
		}else{
			axError("请输入渠道名称");
			return;
		}
		var ch_type=$("#ch_type").val();
		if(ch_type==0){
			axError("请选择类型");
			return;
		}
		var ch_billing=$("#ch_billing").val();
		if(ch_billing==0){
			axError("请选择计费规则");
			return;
		}
		var ch_reponse=$("#ch_reponse").val();
		if(ch_reponse==0){
			axError("请选择响应方式");
			return;
		}
		var ch_callbak = $("#ch_callbak").val();
		if (ch_callbak == "" || ch_callbak == null){
			axError("请输入回调地址");
			return;
		}
		var ch_secret_key = $("#ch_secret_key").val();
		if (ch_secret_key == "" || ch_secret_key == null){
			axError("请输入密匙");
			return;
		}
		var ch_desc = $("#ch_desc").val();
		if (ch_desc == "" || ch_desc == null){
			axError("请输入描述");
			return;
		}
		
		xco.setIntegerValue("ch_billing",$("#ch_billing").val());
		xco.setIntegerValue("ch_reponse",$("#ch_reponse").val());
		xco.setStringValue("ch_callbak",$("#ch_callbak").val());
		xco.setStringValue("ch_secret_key",$("#ch_secret_key").val());
		xco.setStringValue("ch_desc",$("#ch_desc").val());
		xco.setIntegerValue("ch_type",$("#ch_type").val());
		xco.setIntegerValue("ch_state",$("input[name='ch_state']:checked").val());
		var options = {
			url : "/securityMultiple/insertChannel.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../ungstd/chList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加渠道吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
