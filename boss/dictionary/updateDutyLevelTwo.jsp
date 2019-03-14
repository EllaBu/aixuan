<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "责任项维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>编辑二级责任项</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../dictionary/dutyList.jsp">责任项维护</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><a>编辑二级责任项</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑二级责任项</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:70%;float:left;">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>一级责任项</label>
								<span id="fId"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>二级责任项</label>
								<input type="text" class="form-control" id="dutyName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>文本类型</label>
								<select id="inputType" class="form-control">
									<option value="1">文本框</option>
									<option value="2">文本域</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>责任项排序</label>
								<input type="text" class="form-control" id="sort" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>标准值</label>
								<select id="standardType" class="form-control">
									<option value="0">N</option>
									<option value="1">Y</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label>特殊标识</label>
								<select id="itemType" class="form-control">
									<option value="1">普通</option>
									<option value="2">特殊</option>
								</select>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="updateDutyLevelTwo">保存</button>
								<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid mar-t-15" style="width:27%;float: right;">
					<div class="span12">
						<table border="0" id="table_bug_report" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>二级责任项</th>
									<th>责任项排序</th>
								</tr>
							</thead>
							<tbody id="listgroup">
								<!-- 
								<tr>
									<td>#{list[i].duty_name}</td>
									<td>#{list[i].sort}</td>
								</tr>
								 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var dutyId = getURLparam("dutyId");
	
	getOneDuty();
	
	/* 获取单个责任项详情 */
	function getOneDuty(){
		var xco = new XCO();
		xco.setLongValue("dutyId", dutyId);
		
		var options = {
			url : "/dic/getOneDuty2.xco",
			data : xco,
			success : getOneDutyCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取单个责任项详情成功回调 */
	function getOneDutyCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			var xco = data.getData();
			$("#dutyName").val(xco.getStringValue("duty_name"));
			$("#sort").val(xco.getIntegerValue("sort"));
			//初始化一级责任项名称
			$("#fId").text(xco.getStringValue("f_id_name"));
			$("#inputType").val(xco.getIntegerValue("input_type"));
			$("#standardType").val(xco.getIntegerValue("standard_type"));
			$("#itemType").val(xco.getIntegerValue("item_type"));
			getSeriesList(xco.getLongValue("f_id"));
		}
	}

	//编辑按钮点击事件监听
	$("#updateDutyLevelTwo").click(function(){
		var xco = new XCO();
		xco.setLongValue("dutyId", dutyId);
		
		var dutyName = $("#dutyName").val();
		if(dutyName){
			xco.setStringValue("dutyName",dutyName);
		}else{
			axError("请输入二级责任项");
			return;
		}
		
		var inputType = $("#inputType").val();
		if(inputType){
			xco.setIntegerValue("inputType",inputType);
		}else{
			axError("请选择文本类型");
			return;
		}
		
		var sort = $("#sort").val();
		if(sort){
			xco.setIntegerValue("sort",sort);
		}else{
			axError("请输入责任项排序");
			return;
		}

		var standardType = $("#standardType").val();
		if(standardType){
			xco.setIntegerValue("standardType",standardType);
		}else{
			axError("请选择标准值");
			return;
		}
		
		var itemType = $("#itemType").val();
		if(itemType){
			xco.setIntegerValue("itemType",itemType);
		}else{
			axError("请选择特殊标识");
			return;
		}
		
		xco.setIntegerValue("level",2);
		xco.setStringValue("sys_op_log","编辑二级责任项-编辑："+dutyName);
		
		var options = {
			url : "/dic/updateDuty.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../dictionary/dutyList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存二级责任项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/dutyList.jsp";
	})
	
	XCOTemplate.pretreatment('listgroup');
	
	/* 获取分类列表 */
	function getSeriesList(fId) {
		if(fId==null){
			fId = $("#fId").val();
		}
		var xco = new XCO();
		xco.setLongValue("fId",fId);
		xco.setIntegerValue("level",2);
		
		var options = {
			url : "/dic/oneLevelDutyList.xco",
			data : xco,
			success : oneLevelDutyListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取分类列表成功回调 */
	function oneLevelDutyListCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		var data = xco.getData();
		if (null == data) {
			return;
		}
		
		var total = 0;
		total = data.getIntegerValue("total");
		var len = 0;
		var list = data.getXCOListValue("list");
	
		var html = "";
		if (list) {
			len = list.length;
		}
		
		for (var i = 0; i < len; i++) {
			data.setIntegerValue("i", i);
			html += XCOTemplate.execute('listgroup', data, null);
		}
		document.getElementById('listgroup').innerHTML = html;
	}
</script>