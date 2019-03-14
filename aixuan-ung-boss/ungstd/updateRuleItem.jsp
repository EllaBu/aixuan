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
<title>修改核保项</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span >核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
        <li><span href="../dictionary/labelList.jsp">核保项</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
      <li><span>修改核保项</span><span class="divider"></span>
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
						<input type="hidden" id="ri_id"  >
				<div class="from-group mar-t-15">
					<label><span style="color:red;">*</span>名称</label>
					<input type="text" class="form-control fd" dt="S" req="t" id="ri_name" >
				</div>
				<div class="from-group mar-t-15">
	            	<label>类型</label>
					<select type="text" class="form-control fd" dt="I" id="ri_type" >
						<option value="0">请选择</option>
						<option value="1">数值型</option>
						<option value="2">逻辑型</option>
						<option value="3">文本型</option>
					</select>
				</div>
				<input type="hidden" id="ruleid" value="30">
				<div class="from-group mar-t-15">
	            	<label>优先级</label>
					<input type="text" class="form-control fd" dt="I" id="ri_priority" name="ri_priority">
				</div>
				<div class="from-group mar-t-15">
	                <label>错误反馈</label>
						<textarea name="ri_msg" rows="2" class="fd" dt="S" id="ri_msg"></textarea>
				</div>
                <div class="from-group mar-t-15">
	                <label>前置条件</label>
						<textarea name="ri_precond" rows="2" class="fd" dt="S" id="ri_precond"></textarea>
				</div>
				<!-- <div class="from-group mar-t-15">
                	<label>状态</label>
                    <input type="radio" name="ri_state"  class="fd" dt="I" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
                    <span style="vertical-align: -webkit-baseline-middle;">启用</span>
                    <input type="radio" name="ri_state"  value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
                    <span style="vertical-align: -webkit-baseline-middle;">停用</span>
				</div> -->
				<div class="from-group mar-t-15">
					<label>状态</label>
					<input type="radio" name="ri_state" class="fd" dt="I" value="1" checked class="ace">
					<span class="lbl">启用</span>
					<input type="radio" name="ri_state" value="0" class="ace">
					<span class="lbl">停用</span>
				</div>	
              <div class="from-group mar-t-15">
                <label>描述</label>
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
 var ri_id = getURLparam("ri_id");
 dogetItem();
 function dogetItem(){
 	var xco=new XCO();
 	xco.setLongValue("ri_id", ri_id);
 	var options = {
			url : "/rules/getItemById.xco",
			data : xco,
			success : function(data){
				if(data.getCode()==0){
					var obj=data.getData();
					$("#ri_id").val(obj.get("ri_id"));
					$("#ruleid").val(obj.get("rule_id"));
					$("#ri_name").val(obj.get("ri_name"));
					$("#ri_type").val(obj.get("ri_type"));
					$("#ri_priority").val(obj.get("ri_priority"));
					$("#ri_msg").val(obj.get("ri_msg"));
					$("#ri_precond").val(obj.get("ri_precond"));
					$("input[name='ri_state']").each(function(i,el){
						if($(el).val()==obj.get('ri_state')){
							$(el).prop("checked",true);
						}
					}); 
					$("#desc").val(obj.get("ri_desc"));
					
				}else{
					axSuccess("获取数据失败",null);
				}
			}
		};
		$.doXcoRequest(options);
 }
 
 //添加按钮点击事件监听
	$("#add").click(function(){
		var xco = new XCO();
		var name = $("#ri_name").val();
		var type = $("#ri_type").val();
		var priority=$("#ri_priority").val();
		var ruleid=$("#ruleid").val();
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
			priority=0;
		}
		if(isNaN(priority)){ 
			axError("优先级请输入数字");
			document.getElementById("priority").focus();
			return false;
		}
		var ri_msg = $("#ri_msg").val();
		if (ri_msg == "" || ri_msg == null){
			axError("请输入错误反馈");
			return;
		}
		var desc = $("#desc").val();
		if (desc == "" || desc == null){
			axError("请输入描述");
			return;
		}
		xco.setLongValue("ri_id", ri_id);
		xco.setIntegerValue("ri_type",type);
		xco.setIntegerValue("ri_priority",priority);
		xco.setStringValue("ri_msg", $("#ri_msg").val());
		xco.setStringValue("ri_precond", $("#ri_precond").val());
		xco.setIntegerValue("ri_state",$("input[name='ri_state']:checked").val());
		xco.setStringValue("ri_desc", $("#desc").val());
		var options = {
			url : "/rules/updateRulesItem.xco",
			data : xco,
			success : SuccessMsg
		};
		axConfirm("确定修改核保项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		}) 
	});
	
	function SuccessMsg(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			axSuccess("修改成功！",function(){
				window.location.href="/ungstd/ruleItemList.jsp?rule_id="+$("#ruleid").val();
			});
		}
	}
</script>
