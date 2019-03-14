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
<title>新增核保规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span href="../dictionary/labelList.jsp">核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><span>新增核保规则</span><span class="divider"></span>
      </li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-plus"></i>新增核保规则</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>规则名称</label>
								<input type="text" class="form-control" id="rule_name" >
							</div>
							<div class="from-group mar-t-15">
                				<label>类型</label>
                				<select id="rule_type">
									<option value="1">通用</option>
									<option value="2">类目</option>
									<option value="3">产品</option>
                				</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>评级实现类</label>
								<input type="text" class="form-control" id="rule_impl" >
							</div>							
<!-- 				            <div class="from-group mar-t-15">
				                <label>状态</label>
				                <input type="radio" name="rule_state"   value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
			                    <span style="vertical-align: -webkit-baseline-middle;">启用</span>
			                    <input type="radio" name="rule_state"  value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
			                    <span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
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

	//添加按钮点击事件监听
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
		xco.setStringValue("rule_desc",rule_desc);
	/* 	xco.setIntegerValue("rule_state",$("input[name='rule_state']").val()); */
		xco.setIntegerValue("rule_type",$("#rule_type").val());
		var options = {
			url : "/rules/insertRules.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../ungstd/ruleList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加规则吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	
</script>
