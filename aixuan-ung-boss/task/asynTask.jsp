<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "爱康异步列表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>爱康异步列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-lock"></i><span class="divider"></span><span>爱康管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>爱康异步列表</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>爱康异步列表</h1>
			</div>

			<div class="row-fluid">
			
				<div class="row-fluid">
					<div class="span12">
						<div  class="form-inline form-inline-list">
							<div class="row-fluid">
								<div class="span3">
									<label>请求编号</label>
                          			<input type="text" class="form-control" id="req_sn_ext" placeholder="">
								</div>
								<div class="span3">
									<label>处理状态</label>
	                          		<select class="form-control"  id="at_state">
		                                <option value="-1">请选择</option>
		                                <option value="10">未处理</option>
		                                <option value="20">未响应</option>
		                                <option value="90">响应失败</option>
		                                <option value="100">响应成功</option>
	                              </select>
								</div>
							</div>
                        </div>
                        <div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn mar-l-15 btn-info" id="find" type="reset">搜索</button>
                                </div>
                            </div>
                       	</div>
					</div>
				</div>			

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>请求编号(外部)</th>
										<th>业务模式</th>
										<th>回调地址</th>
										<th>错误信息</th>
										<th>响应重试次数</th>
										<th>处理状态</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{at_id}</td>
										<td><a href="http://ung.boss.aixbx.com/ungstd/ikangRequestList.jsp?req_sn_ext=#{req_sn_ext}">#{req_sn_ext}</a></td>
										<td>@{getBusinessModel}</td>
										<td>#{callbak}</td>
										<td>#{err_msg}</td>
										<td>#{retry_count}</td>
										<td>@{getState}</td>
										<td ><ul style="float:left;margin:0 0">创建时间：#{create_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">计划时间：#{scheduled_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">完成时间：#{completed_time@formatdate}</ul></td>
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
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    
    XCOTemplate.pretreatment(['datalist']);
	var renderPage = true;
	xdoRequest(0,50);
	
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setIntegerValue("at_state", $("#at_state").val());
		xco.setStringValue("req_sn_ext", $("#req_sn_ext").val());		
		var options = {
			url : "/task/getAsynTaskList.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function doRequestCallBack(data){
		
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		
		data = data.getData();
		total = data.getIntegerValue("count");
		$("#total").text(total);
		$("#size").text(10);
		var dataList=data.get('list');
		if(!dataList){
			dataList=new Array();	
		}
	    var html = '';
	    var ext = {
			getState: function(xco){
				if(xco.get("at_state")==10){
					return "未处理";
				}
				if(xco.get("at_state")==20){
					return "未响应";
				}
				if(xco.get("at_state")==90){
					return "响应失败";
				}
				if(xco.get("at_state")==100){
					return "响应成功";
				}									
			},
			getBusinessModel:function(xco){
				if(xco.get("business_model")==1){
					return "普通预警";
				}
				if(xco.get("business_model")==2){
					return "爱康推荐";
				}
				if(xco.get("business_model")==3){
					return "反向核保";
				}
				if(xco.get("business_model")==4){
					return "健康评测(体检编号)";
				}
				if(xco.get("business_model")==5){
					return "健康评测(H5)";
				}
				if(xco.get("business_model")==6){
					return "普通预警(体检编号)";
				}
			},
			
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), xdoRequest, pageSize);
		}		  
	}
  
  	$("#find").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
	});
    
	function formatdate(time){
		if(time){
			var date = new Date(time);
		    var year =  date.getFullYear(),
				        month = date.getMonth() + 1,//月份是从0开始的
				        day = date.getDate(),
				        hour = date.getHours(),
				        min = date.getMinutes(),
				        sec = date.getSeconds();
				        if(day<10) day='0'+day;	
				        if(month<10) month='0'+month;
				        if(hour<10) hour= '0'+hour;
				        if(min<10) min= '0'+min;
				        if(sec<10) sec= '0'+sec;	
			var newTime = year + '-' +  month + '-' +day + ' ' +
					                hour + ':' +min + ':' +sec;
		    return newTime;  			
		}
		return null;
	}
</script>