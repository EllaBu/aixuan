<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String a = request.getParameter("score_item_id");
	String pageName = "责任分打分配置";
	if("10".equals(a)){
		pageName = "病种分打分配置";
	}
%>

<%@ include file="../common/menu_and_navbar_ung.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>打分管理</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-signal"></i><span class="divider"></span><span>打分管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span id="score_item_id_1"></span><span>打分配置</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i><span id="score_item_id_2"></span>打分配置</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<table class="table table-bordered">
							<thead>
								<tr>
								<td>序号</td>
								<td>分类名称（一级）</td>
								<td>分类名称（二级）</td>
								<td>操作</td>
							</tr>
							</thead>
							<tbody id="listgroup">
							<!-- 								
								<tr>
									<td>@{getIndex}</td>
									<td>#{f_series_name}</td>
									<td>#{series_name}</td>
									<td>
										<a href="grade/optionList.jsp?series_no=#{series_no}&series_name=#{series_name}&oc_score_type=@{getType}">配置</a>
										<a onclick="againGrade(#{series_no},'#{series_name}')">重新计算</a>
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
	var score_item_id = getURLparam("score_item_id");//[5:责任,10病种]
    XCOTemplate.pretreatment('listgroup');
    var oc_score_type = 1;//打分类型[1:责任, 2:病种]
    if(score_item_id == 5){
   		oc_score_type = 1;
   		$("#score_item_id_1").text("责任分");
   		$("#score_item_id_2").text("责任分");
    }
    if(score_item_id == 10){
   		oc_score_type = 2;
   		$("#score_item_id_1").text("病种分");
   		$("#score_item_id_2").text("病种分");
   		
    }
    
	getSeriesList();
	
	/*获取责任（疾病）分类列表*/
	function getSeriesList() {
		var xco = new XCO();
		xco.setIntegerValue("score_item_id", score_item_id);
		var options = {
			url : "/grade/getSeriesList.xco",
			data : xco,
			success :getSeriesListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取责任（疾病）分类列表回调*/
	function getSeriesListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
			return;
		} 
		data = data.getData();
		var list = data.getXCOListValue("list");
		var html = "";
		var index = 1;
		var extendedFunction = {
			getIndex: function(xco){
				return index++;						
			},
			getType: function(xco){
				return oc_score_type;						
			}		
			
		};
		for (var i = 0; i < list.length; i++) {
			html += XCOTemplate.execute('listgroup', list[i], extendedFunction);
		}
		document.getElementById('listgroup').innerHTML = html;
	}
	
	/*重新计算*/
	function againGrade(series_no,series_name) {
		var xco = new XCO();
		xco.setIntegerValue("sub_type_id", series_no);
		xco.setStringValue("sub_type_name",series_name);
		xco.setIntegerValue("oc_score_type", oc_score_type);
		if(oc_score_type ==1){
			xco.setStringValue("sys_op_log","重新计算-责任分："+series_name);
		}else{
			xco.setStringValue("sys_op_log","重新计算-病种分："+series_name);
		}
		var options = {
			url : "/gradeTaskService/addTaskForAgainGrade.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					if(data.getCode() == -2){
						axSuccess(data.getMessage());
					}else{
						axError(data.getMessage());
					}
				}else{
					axSuccess(data.getMessage());
				}
			}
		};
		axConfirm("确定重新计算该类别下的产品分吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})		
	}
</script>
