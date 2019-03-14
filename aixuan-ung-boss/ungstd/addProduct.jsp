<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>新增 产品规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
				class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 产品规则</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>新增产品规则</span><span class="divider"></span>
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
								<label><span style="color:red;">*</span>渠道</label>
								<select class="form-control" id="ch_id">
									<!-- <option value="#{ch_id}">#{ch_name}</option> -->
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>保险公司编号</label>
								<input  type="text" class="form-control" id="org_no" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>保险公司</label>
								<input type="text" class="form-control" id="org_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label>产品分类</label>
								<select class="form-control" id="series_no">
									<option value="0">请选择</option>
									<option value="1">重疾险</option>
									<option value="2">寿险</option>
									<option value="3">癌症险</option>
								</select>
							</div>
							<div class="from-group mar-t-15" >
								<label><span style="color:red;">*</span>外部产品编号</label>
								<input type="text" class="form-control" id="up_ext_pno" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>外部产品名称</label>
								<input type="text" class="form-control" id="up_ext_pname" placeholder="">
							</div>
							<div class="from-group mar-t-15" >
								<label><span style="color:red;">*</span>内部产品编号</label>
								<input type="text" class="form-control" id="up_intl_pno" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>内部产品名称</label>
								<input type="text" class="form-control" id="up_intl_pname" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>核保规则</label>
								<!-- <input type="hidden" id="rule_id" class="form-control mar-t-15"  style="width:366px;" placeholder=""> -->
								<input type="text" id="rule_id" class="form-control" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>类型</label>
								<select class="form-control" id="up_type">
									<option value="0">请选择</option>
									<option value="1">产品级</option>
									<option value="2">类目级</option>
									<option value="3">保险公司级</option>
									<option value="4">渠道级别</option>
								</select>
							</div>
							<!-- <div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>状态</label>
								<input type="radio" name="up_state" value="1" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">启用</span>
								<input type="radio" name="up_state" value="0" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
								<span style="vertical-align: -webkit-baseline-middle;">停用</span>
							</div> -->
							<div class="from-group mar-t-15">
								<label>状态</label>
								<input type="radio" name="up_state" value="1" checked class="ace">
								<span class="lbl">启用</span>
								<input type="radio" name="up_state" value="0" class="ace">
								<span class="lbl">停用</span>
							</div>	
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>描述</label>
								<textarea id="up_desc" rows="3"></textarea>
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
	XCOTemplate.pretreatment(['ch_id']);
	channelRequest();
	function channelRequest(){
		var xco = new XCO();
		var options = {
			url : "/security/getAllChannel.xco",
			data : xco,
			success : channelRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function channelRequestCallBack(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		var dataList = data.getData();
		var html = '<option value="0">请选择</option>';
		 for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("ch_id", dataList[i], null);
    	}
    	
   		document.getElementById("ch_id").innerHTML = html;
	}
	
	$("#add").click(function(){
		var xco = new XCO();
		var ch_id=$("#ch_id").val();
		if(ch_id==0){
			axError("请选择渠道");
			return;
		}
		var rule_id = $("#rule_id").val();
		if(isNaN(rule_id)){
			axError("核保规则请输入数字");
			document.getElementById("rule_id").focus();
			return false;
		}
		if(rule_id){
			xco.setLongValue("rule_id",rule_id);
		}else{
			axError("请输入核保规则");
			return;
		}
		var series_no=$("#series_no").val();
	/* 	if(series_no==0){
			axError("请选择产品类型");
			return;
		} */
		var org_no = $("#org_no").val();
		if(org_no==""||org_no==null){
			org_no = 0;
		}
		if(isNaN(org_no)){ 
			axError("保险公司编号请输入数字");
			document.getElementById("org_no").focus();
			return false;
		}
		var org_name = $("#org_name").val();
		if (org_name == "" || org_name==null){
			axError("请输入保险公司");
			return;
		}
		var up_ext_pno = $("#up_ext_pno").val();
		if (up_ext_pno == "" || up_ext_pno == null){
			axError("请输入外部产品编号");
			return;
		}
		var up_ext_pname = $("#up_ext_pname").val();
		if (up_ext_pname == "" || up_ext_pname == null){
			axError("请输入外部产品名称");
			return;
		}
		var up_intl_pno = $("#up_intl_pno").val();
		if (up_intl_pno == "" || up_intl_pno == null){
			axError("请输入内部产品编号");
			return;
		}
		var up_intl_pname = $("#up_intl_pname").val();
		if (up_intl_pname == "" || up_intl_pname == null){
			axError("请输入内部产品名称");
			return;
		}
		var up_desc = $("#up_desc").val();
		if (up_desc == "" || up_desc == null){
			axError("请输入描述");
			return;
		}
		var up_type=$("#up_type").val();
		if(up_type==0){
			axError("请选择类型");
			return;
		}
		xco.setLongValue("ch_id",$("#ch_id").val());
		xco.setLongValue("rule_id",rule_id);
		xco.setLongValue("org_no",org_no);
		xco.setStringValue("org_name",org_name);
		xco.setLongValue("series_no",series_no);
		xco.setStringValue("series_name",$("#series_no option:selected").text());
		xco.setLongValue("sub_series_no",0);
		xco.setStringValue("sub_series_name","");
		xco.setStringValue("up_ext_pno",up_ext_pno);
		xco.setStringValue("up_ext_pname",up_ext_pname);
		xco.setStringValue("up_intl_pno",up_intl_pno);
		xco.setStringValue("up_intl_pname",up_intl_pname);
		xco.setStringValue("up_desc",up_desc);
		xco.setIntegerValue("up_type",$("#up_type").val());
		xco.setIntegerValue("up_state",$("input[name='up_state']:checked").val());
		var options = {
			url : "/security/insertProduct.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../ungstd/productList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加产品规则吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
