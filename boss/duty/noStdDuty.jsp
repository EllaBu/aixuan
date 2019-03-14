<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "责任项维护";
%>
<%@ include file="../common/menu_and_navbar_ung.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>责任项值管理</title>
<style>
	.table textarea {
		width: 96%;
		height: 70px;
		margin: 0;
		resize: none;
	}
	.tab-title {
		line-height: 30px;
	}
	.tab-title a {
		display: inline-block;
		padding: 0 20px;
		color: #333;
		background-color: #eee;
	}
	.tab-title a.active {
		background-color: #2679b5;
		color: #fff;
	}
	.t-header {
		background-color: #f1f1f1;
		padding: 10px 10px 1px;
		border-radius: 4px;
		font-weight: bold;
	}
	.banma{
		background-color: #F0F0F0;
	}	
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i><span class="divider"></span><span>数据字典</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>责任项维护</span><span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li><span>责任项值管理</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>责任项值管理</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="t-header">
							<p>二级责任项：<span id="duty_name"></span></p>
						</div>
						<div class="tab-title  mar-t-15">
							<a onclick="goDuty(0)">全部</a>
							<a  class="active">非标准项值</a>
							<a onclick="goDuty(2)">标准项</a>
						</div>
						<div class="t-header" style="margin-top: 20px;display:none" id="noData">
							<p>该责任项暂无拆解项值</p>
						</div>						
					</div>
				</div>
				<div class="row-fluid" id="tableDiv" style="display:none">
					<div class="span12">
						
						<table class="table table-bordered">
							<thead>
								<tr>
									<td style="width: 60px;">SN</td>
									<td style="width: 120px;">产品编号</td>
									<td>拆解项值</td>
									<td style="width: 80px;">是否是标准项</td>
									<td style="width: 100px;">操作</td>
								</tr>
							</thead>
							<tbody id="listgroup">
<!-- 								<tr class="@{getClass}" id="tr_#{product_duty_id}">
									<td>@{getIndex}</td>
									<td>#{product_no}</td>
									<td>
										<textarea id="#{product_duty_id}" rows="" cols="">#{str_val}</textarea>
									</td>
									<td>@{isStd}</td>
									<td>
										<a onclick="updateProductDuty(#{product_duty_id})">更新</a>
										<br/>
										<a onclick="updateProductDutyBatch(#{product_duty_id})">批量更新</a>
										<br/>
										<a onclick="convertToStandard(#{product_duty_id})">批量转换标准项</a>
									</td>
								</tr> -->
							</tbody>
						</table>
						<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
						<jsp:include page="../common/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var duty_id = getURLparam("duty_id");//二级分类
	var duty_name = getURLparamEncoder("duty_name");//二级分类名称
	$("#duty_name").text(duty_name);
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
	getTaskListPage(0,200);
	/*获取任务列表*/
	function getTaskListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		xco.setIntegerValue("sub_duty_id", duty_id);
		//传递参数  全部、非标准项、标准项
		xco.setStringValue("standard_flag", "N");
		var options = {
			url : "/productDuty/getproductDutys.xco",
			data : xco,
			success : getTaskListPageCallBack
		};
		$.doXcoRequest(options);
	}
	/*获取任务列表成功回调*/
	function getTaskListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			total = data.getIntegerValue("total");
			$("#total").text(total);
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
				$("#tableDiv").css("display","");	
			}else{
				$("#tableDiv").css("display","none");
				$("#noData").css("display","");
			}
			var index = 1;
			var str = "";
			var str_index = 2;			
			var extendedFunction = {
				getIndex: function(xco){
					return index++;						
				},
				isStd: function(xco){
					var duty_standard_id = xco.get("duty_standard_id");
					if(duty_standard_id==0){
						return "否";
					}
					return "是";				
				},
				getClass: function(xco){
					var str_val = xco.get("str_val");
					if(str_val != str){
						str =  str_val;
						str_index++;
					}
					if(str_index % 2 ==0){
						return "banma";
					}else{
						return "";
					}
				}								
			};
			for (var i = 0; i < len; i++) {
				html += XCOTemplate.execute('listgroup', list[i], extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getTaskListPage, 200);
			}
		}
	}
	
	/*更新*/
	function updateProductDuty(product_duty_id) {
		var xco = new XCO();
		var str_val = $("#"+product_duty_id).val();
		xco.setIntegerValue("product_duty_id", product_duty_id);
		xco.setStringValue("str_val", str_val.trim());
		xco.setStringValue("sys_op_log","责任项值管理-"+duty_name+"-非标准项：更新");		
		var options = {
			url : "/productDuty/updateProductDuty.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("更新成功！");
					$("#tr_"+product_duty_id).css("background-color","#D1EEEE");
				}
			}
		};
		axConfirm("当前操作将会更新本行的数据，您确认要更新吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}
	/*批量更新*/
	function updateProductDutyBatch(product_duty_id) {
		var xco = new XCO();
		var str_val = $("#"+product_duty_id).val();
		xco.setIntegerValue("product_duty_id", product_duty_id);
		xco.setStringValue("str_val", str_val.trim());
		xco.setIntegerValue("sub_duty_id", duty_id);
		xco.setStringValue("sys_op_log","责任项值管理-"+duty_name+"-非标准项：批量更新");
		var options = {
			url : "/productDuty/updateProductDutyBatch.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("批量更新成功！",function(){
						window.location.reload();
					});	
				}
			}
		};
		axConfirm("当前操作将会批量更新当前责任项相关的所有内容相同的数据，您确认要更新吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}	
	/*批量转换标准项*/
	function convertToStandard(product_duty_id) {
		var xco = new XCO();
		var str_val = $("#"+product_duty_id).val();
		xco.setIntegerValue("product_duty_id", product_duty_id);
		xco.setStringValue("str_val", str_val.trim());
		xco.setIntegerValue("sub_duty_id", duty_id);
		xco.setStringValue("sys_op_log","责任项值管理-"+duty_name+"-非标准项：批量转换标准项");
		var options = {
			url : "/productDuty/convertToStandard.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("转换成功！",function(){
						window.location.reload();
					});					
				}
			}
		};
		axConfirm("当前操作会批量将非标准项转换成标准项，您确认要更新吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}	
	
	
	/*跳转页面*/
	function goDuty(duty_type) {
		var url = "";
		if(duty_type==0){
			url = "duty/allDuty.jsp";
		}else if(duty_type==1){
			url = "duty/noStdDuty.jsp";
		}else if(duty_type==2){
			url = "duty/stdDuty.jsp";
		}
    	var param = "";
    	param +="?duty_id="+duty_id;
    	param +="&duty_name="+duty_name;
		window.location.href=url+param;   		
	}
</script>