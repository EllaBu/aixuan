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
							<a onclick="goDuty(1)">非标准项值</a>
							<a class="active">标准项</a>
						</div>
						<div class="t-header" style="margin-top: 20px;display:none" id="noData">
							<p>该责任项暂无标准项</p>
						</div>							
					</div>
				</div>
				<div class="row-fluid" id="tableDiv" style="display:none">
					<div class="span12">
						
						<table class="table table-bordered">
							<thead>
								<tr>
									<td style="width: 60px;">SN</td>
									<td>拆解项值</td>
									<td style="width: 80px;">是否是标准项</td>
									<td style="width: 80px;">操作</td>
								</tr>
							</thead>
							<tbody id="listgroup">
<!-- 								<tr class="@{getClass}" id="tr_#{duty_standard_id}">
									<td>@{getIndex}</td>
									<td>
										<textarea id="#{duty_standard_id}" rows="" cols="">#{content}</textarea>
									</td>
									<td>是</td>
									<td>
										<a onclick="updateProductDuty(#{duty_standard_id})">批量更新</a>
										<br/>
										<a onclick="deleteStd(#{duty_standard_id})">删除</a>
									</td>
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
	var duty_id = getURLparam("duty_id");//二级分类
	var duty_name = getURLparamEncoder("duty_name");//二级分类名称
	$("#duty_name").text(duty_name);
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
	getTaskListPage();
	/*获取任务列表*/
	function getTaskListPage() {
		var xco = new XCO();
		xco.setIntegerValue("sub_duty_id", duty_id);
		//传递参数  全部、非标准项、标准项
		var options = {
			url : "/productDuty/getStandards.xco",
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
			var list = data.getData();
			var len = 0;
			//var list = data.getXCOListValue("list");
		
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
				getClass: function(xco){
					var str_val = xco.get("content");
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
	function updateProductDuty(duty_standard_id) {
		var xco = new XCO();
		var str_val = $("#"+duty_standard_id).val();
		xco.setIntegerValue("duty_standard_id", duty_standard_id);
		xco.setStringValue("str_val", str_val.trim());
		xco.setStringValue("sys_op_log","责任项值管理-"+duty_name+"-标准项：批量更新");
		var options = {
			url : "/productDuty/updateProductDutyByStandardId.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("更新成功！");
					$("#tr_"+duty_standard_id).css("background-color","#D1EEEE");
				}
			}
		};
		axConfirm("当前操作将会批量更新当前标准项相关的所有数据，您确认要更新吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}
	
	/*删除*/
	function deleteStd(duty_standard_id) {
		var xco = new XCO();
		xco.setIntegerValue("duty_standard_id", duty_standard_id);
		xco.setStringValue("sys_op_log","责任项值管理-"+duty_name+"-标准项：删除标准项");
		var options = {
			url : "/productDuty/deleteStandard.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("删除成功！",function(){
						window.location.reload();
					});	
				}
			}
		};
		axConfirm("当前操作将会删除此标准项，并且其关联下的产品拆解项值将置为非标准项值，您确认要删除吗？",function(){
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