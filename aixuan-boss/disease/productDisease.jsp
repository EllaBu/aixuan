<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品总表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>产品病种详情</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				</li>
				<li><a>产品总表</a><span class="divider"> <i class="icon-angle-right"></i></span>
				</li>
				<li><a>产品病种详情</a><span class="divider"> </i></span>
				</li>
			</ul>
		</div>
		

		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>产品病种详情</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:100%;float: left;">
				
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">产品病种概述</h4>
						</div>
						<div class="form-inline form-add1 bord1dd" id="product">
							<!--
							<div class="from-group mar-t-15">
								<label>25种标准重疾:</label>
								<span>#{product.type_num_1}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>25种标准重疾以外的重大疾病:</label>
								<span>#{product.type_num_2}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>轻症疾病:</label>
								<span>#{product.type_num_3}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>特殊疾病:</label>
								<span>#{product.type_num_4}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>中症疾病:</label>
								<span>#{product.type_num_5}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>病种拆分:</label>
								<span>#{product.merge_num}</span>
							</div>
							<div class="from-group mar-t-15">
								<label>备注:</label>
								<textarea  rows="1" cols="50" style="width:50%;">#{product.remark1}
								</textarea>
							</div> -->
						</div>
					</div>
				</div>
				
			<div class="row-fluid mar-t-15" style="width:100%;float: left;margin-top: 50px">
				<div class="span12">
					<div class="widget-header bord1dd">
							<h4 class="widget-title">搜索区域</h4>
					</div>
					<div class="form-inline">
						<div class="form-group" style="line-height: 30px;">
							<label class="mar-l-15 mar-t-15">是否包含:</label>
							<select class="form-control mar-t-15 w150" id="include">
								<option value="0">请选择</option>
								<option value="1">是</option>
								<option value="2">否</option>
							</select> 
							<label class="mar-l-15 mar-t-15">病种名:</label>
							<input type="text" id="d_name" >
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				
				<div class="row-fluid mar-t-15" style="width:100%;float: left;margin-top: 50px">
					<div class="span12">
						<div class="widget-header bord1dd">
								<h4 class="widget-title">产品病种详情</h4>
						</div>
						<table border="0" style="margin-top: 0px" id="table_bug_report" class="table table-striped table-bordered table-hover ">
								<thead>
									<tr>
										<th>分类</th>
										<th>病种序号</th>
										<th>病种名</th>
										<th>是否包含</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									
									<!-- <tr ">
											<td style="width:15%;background-color:@{getColor};color:#000000">@{getDType}</td>
											<td style="background-color:@{getColor};color:#000000">@{getIndex}</td>
											<td style="background-color:@{getColor};color:#000000">#{list[i].d_name}</td>
											<td style="background-color:@{getColor};color:#000000">@{getIcon}</td>
										</tr> -->
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
	var product_no = getURLparam("product_no");
	XCOTemplate.pretreatment('listgroup');
	XCOTemplate.pretreatment('product');
	getFactorList();
	$("#search").click(function(){
		getFactorList();
	});
	/* 获取分类列表 */
	function getFactorList() {
		var xco = new XCO();
		xco.setStringValue("product_no", product_no);
		xco.setIntegerValue("include", $("#include").val());
		xco.setStringValue("d_name", $("#d_name").val());
		var options = {
			url : "/productDisease/getProductDisease.xco",
			data : xco,
			success :getFactorListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取分类列表成功回调 */
	function getFactorListCallBack(xco) {
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
		var product = data.getXCOListValue("product");
		var html = "";
		if (list) {
			len = list.length;
		}
		var d_type_g="";
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
			getIcon : function(){
				var include = list[i].getStringValue("include");
				if(include==1){
					return '<i class="icon-ok"></i>';
				}
				return '';
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
		var product_html = "";
		var product_ext = {
		};
		product_html += XCOTemplate.execute('product', data, product_ext);
		document.getElementById('product').innerHTML = product_html;
	}
	
</script>