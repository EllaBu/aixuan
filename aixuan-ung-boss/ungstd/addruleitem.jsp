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
        <li><span href="../dictionary/labelList.jsp">核保项</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
      <li><span>新增核保项</span><span class="divider"></span>
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
					<label><span style="color:red;">*</span>名称</label>
					<input type="text" class="form-control fd" dt="S" req="t" id="name" name="ri_name">
				</div>
				<div class="from-group mar-t-15">
	            	<label><span style="color:red;">*</span>类型</label>
					<select type="text" class="form-control fd" dt="I" id="type" name="ri_type">
						<option value="1">数值型</option>
						<option value="2">逻辑型</option>
						<option value="3">文本型</option>
					</select>
				</div>
				<div class="from-group mar-t-15">
	            	<label>优先级</label>
					<input type="text" class="form-control fd" dt="I" id="priority" name="ri_priority">
				</div>
				<div class="from-group mar-t-15">
	                <label><span style="color:red;">*</span>错误反馈</label>
						<textarea name="ri_msg" rows="2" class="fd" dt="S" id="msg"></textarea>
				</div>
                <div class="from-group mar-t-15">
	                <label>前置条件</label>
						<textarea name="ri_precond" rows="2" class="fd" dt="S" id="precond"></textarea>
				</div>
				<!-- <div class="from-group mar-t-15">
                	<label><span style="color:red;">*</span>状态</label>
                    <input type="radio" name="ri_state" id="state" class="fd" dt="I" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
                    <span style="vertical-align: -webkit-baseline-middle;">启用</span>
                    <input type="radio" name="ri_state"  value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
                    <span style="vertical-align: -webkit-baseline-middle;">停用</span>
				</div> -->
				<div class="from-group mar-t-15">
					<label>状态</label>
					<input type="radio" name="ri_state" id="state" class="fd" dt="I" value="1" checked class="ace">
					<span class="lbl">启用</span>
					<input type="radio" name="ri_state" value="0" class="ace">
					<span class="lbl">停用</span>
				</div>	
              <div class="from-group mar-t-15">
                <label><span style="color:red;">*</span>描述</label>
				<textarea name="ri_desc" rows="2" class="fd" dt="S" id="desc"></textarea>
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
// console.log(111);
	var rule_id = getURLparam("rule_id");
	//添加按钮点击事件监听
	$("#add").click(function(){
		var xco = new XCO();
		var name = $("#name").val();
		var type = $("#type").val();
		var priority=$("#priority").val();
		var ruleid=rule_id;
		if(name){
			xco.setStringValue("ri_name",name);
		}else{
			axError("请输入核保项名称");
			return;
		}
		if(ruleid){
			xco.setIntegerValue("rule_id",ruleid);
		}else{
			axError("获取规则id失败");
			return;
		}
		if(priority==""){
			priority=10;
		}
		if(isNaN(priority)){
			axError("优先级请输入数字");
			document.getElementById("priority").focus();
			return false;
		}
		var msg = $("#msg").val();
		if (msg == "" || msg == null){
			axError("请输入错误反馈");
			return;
		}
		var desc = $("#desc").val();
		if (desc == "" || desc == null){
			axError("请输入描述");
			return;
		}
		xco.setIntegerValue("ri_type",type);
		xco.setIntegerValue("ri_priority",priority);
		xco.setStringValue("ri_msg", $("#msg").val());
		xco.setStringValue("ri_precond", $("#precond").val());
		xco.setIntegerValue("ri_state",$("input[name='ri_state']:checked").val());
		xco.setStringValue("ri_desc", $("#desc").val());
		var options = {
			url : "/rules/insertRulesItem.xco",
			data : xco,
			success : SuccessMsg
		};
		axConfirm("确定添加核保项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		}) 
	});
	
	
	/* function submitForm(){
		
	} */
	
	function SuccessMsg(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			axSuccess("添加成功！",function(){
				window.location.href="/ungstd/ruleItemList.jsp?rule_id="+rule_id;
			});
		}
	}
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/labelsList.jsp";
	})
</script>
