<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "核保规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>修改核保规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li> <i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span>核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><span>修改核保规则</span><span class="divider"></span>
      </li>
			</ul>
		</div>

		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-edit"></i>修改核保规则</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>规则名称</label>
								<input type="text" class="form-control" id="rule_name" >
							</div>
							<input type="hidden" id="rule_id" >
							<div class="from-group mar-t-15">
                				<label>类型</label>
                				<select id="rule_type">
                					<option value="0">请选择</option>
									<option value="1">通用</option>
									<option value="2">类目</option>
									<option value="3">产品</option>
                				</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>评级实现类</label>
								<input type="text" class="form-control" id="rule_impl" >
							</div>								
				            <!-- <div class="from-group mar-t-15">
				                <label>状态</label>
				                <input type="radio" name="rule_state"   value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
			                    <span style="vertical-align: -webkit-baseline-middle;">启用</span>
			                    <input type="radio" name="rule_state"  value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
			                    <span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="rule_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="rule_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>	
				            <div class="from-group mar-t-15">
                				<label><span style="color:red;">*</span>描述</label>
								<textarea name="rule_desc" id="rule_desc" rows="2"></textarea>
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
 	var rule_id = getURLparam("rule_id");
	getruleForUpdate();
	function getruleForUpdate(){
		var xco = new XCO();
		xco.setIntegerValue("rule_id",rule_id);
		var options = {
			url : "/rules/getRuleById.xco",
			data : xco,
			success : getruleForUpdateCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getruleForUpdateCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			var xco=data.getData();
			$("#rule_id").val(xco.get('rule_id'));
			$("#rule_name").val(xco.get('rule_name'));
			$("#rule_impl").val(xco.get('rule_impl'));
			$("#rule_type").val(xco.get('rule_type'));
			$("input[name='rule_state']").each(function(i,el){
				if($(el).val()==xco.get('rule_state')){
					$(el).prop("checked",true);
				}
			});
			$("#rule_desc").val(xco.get('rule_desc'));
		}
	}
	
	$("#add").click(function(){
		var xco = new XCO();
		var name = $("#rule_name").val();
		if(name){
			xco.setStringValue("rule_name",name);
		}else{
			axError("请输入规则名称");
			return;
		}
		var rule_impl = $("#rule_impl").val();
		if(rule_impl){
			xco.setStringValue("rule_impl",rule_impl);
		}else{
			axError("请输入评级实现类");
			return;
		}			
		var rule_desc = $("#rule_desc").val();
		if(rule_desc == "" || rule_desc == null ){
			axError("请输入规则描述");
			return;
		}
		xco.setStringValue("rule_id",$("#rule_id").val());
		xco.setStringValue("rule_desc",rule_desc);
		xco.setIntegerValue("rule_state",$("input[name='rule_state']:checked").val());
		xco.setIntegerValue("rule_type",$("#rule_type").val());
		var options = {
			url : "/rules/updateRules.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../ungstd/ruleList.jsp";
					});
				}
			}
		};
		axConfirm("确定修改规则吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
</script>
