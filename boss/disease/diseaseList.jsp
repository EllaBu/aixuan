<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "病种列表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>病种列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-file-alt"></i><a>病种库</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li>病种列表<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>病种库列表</h1>
		</div>

		<div class="row-fluid">
			<div class="row-fluid mar-t-15">
				<div class="span12">
					<div class="form-inline">
						<div class="form-group" style="line-height: 30px;">
							<label class="mar-l-15 mar-t-15">类型</label>
							<select class="form-control mar-t-15 w150" id="d_type">
								<option value="0">请选择</option>
								<option value="1">25种标准重疾</option>
								<option value="2">25种标准重疾以外的重大疾病</option>
								<option value="3">轻症疾病</option>
								<option value="4">特殊疾病</option>
								<option value="5">中症疾病</option>
							</select> 
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row-fluid">
			<div class="row-fluid mar-t-15">
				<div class="span12">
					<table id="table_bug_report"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>分类</th>
								<th>病种序号</th>
								<th>病种名</th>
							</tr>
						</thead>
						<tbody id="listgroup">
							<!-- <tr>
								<td style="width:15%;background-color:@{getColor};color:#000000"">@{getDType}</td>
								<td style="width:25%;background-color:@{getColor};color:#000000"">@{getIndex}</td>
								<td style="background-color:@{getColor};color:#000000">#{list[i].d_name}</td>
							</tr> -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    XCOTemplate.pretreatment('listgroup');
    var renderPage = true;
	
	$("#search").click(function(){
		renderPage = true;
		getRecordListPage(0,1000);
	});
	
	getRecordListPage(0,1000);
	
	/*获取产品总列表*/
	function getRecordListPage(start,pageSize) {
		var xco = new XCO();
		
		var d_type = $("#d_type").val();
		if(d_type!=0){
			xco.setIntegerValue("d_type", d_type);
		}
		
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);

		var options = {
			url : "/productDisease/getDiseaseByPage.xco",
			data : xco,
			success :getRecordListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取公司列表成功回调*/
	function getRecordListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			var size = 0;
			data = data.getData();
			total = data.getIntegerValue("count");
			$("#total").text(total);
			$("#size").text(5);
			var len = 0;
			var list = data.getXCOListValue("list");
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getDType : function(){
					var d_type = list[i].getStringValue("d_type");
					if(d_type==1){
						return '25种标准重疾';
					}
					if(d_type==2){
						return '25种标准重疾以外的重大疾病';
					}
					if(d_type==3){
						return '轻症疾病';
					}
					if(d_type==4){
						return '特殊疾病';
					}
					if(d_type==5){
						return '中症疾病';
					}
				},
				getColor: function(){
					var d_type = list[i].getStringValue("d_type");
					if(d_type==1){
						return '#B7DEE8';
					}
					if(d_type==2){
						return '#FDE9D9';
					}
					if(d_type==3){
						return '#F2DCDB';
					}
					if(d_type==4){
						return '#FFFFFF';
					}
					if(d_type==5){
						return '#E4DFEC';
					}
				},
				getIndex: function(){
					var d_type = list[i].getStringValue("d_id");
					var temp = d_type.split("_");
					d_type = temp[1];
					return d_type;						
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getRecordListPage, pageSize);
			}
		}
	}
</script>