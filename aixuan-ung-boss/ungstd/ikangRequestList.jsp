<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "爱康请求列表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title><%=pageName%></title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-lock"></i><span class="divider"></span><span href="#">爱康管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span >爱康请求列表</span><span class="divider">
				</span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>爱康请求列表</h1>
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
									<label>响应状态</label>
	                          		<select class="form-control"  id="resp_state">
		                                <option value="-1">请选择</option>
		                                <option value="0">未响应</option>
		                                <option value="10">等待响应</option>
		                                <option value="30">响应失败</option>
		                                <option value="100">响应成功</option>
	                              </select>
								</div>
								<div class="span3">
									<label>体检编号</label>
							   		<input type="text" class="form-control" id="report_sn" placeholder="">
								</div>
								<div class="span3"></div>
							</div>
                           <!-- <div class="form-group" style="line-height: 30px;">
                              <label>请求编号</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="req_sn_ext" placeholder="">
                              <label>响应状态</label>
                          		<select class="form-control w150"  id="resp_state">
                                <option value="-1">请选择</option>
                                <option value="0">未响应</option>
                                <option value="10">等待响应</option>
                                <option value="30">响应失败</option>
                                <option value="100">响应成功</option>
                              </select>
							   <label>体检编号</label>
							   <input type="text" class="form-control mar-t-15 w150" id="report_sn" placeholder="">
							   <br>
                          	</div> -->
                          	<!-- <div class="form-group mar-l-15">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">+新增</button>
	                       </div> -->
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
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
					                    <th>请求编号</th>
					                    <th>体检编号</th>
					                    <th>任务总数</th>
										<th>当前完成数</th>
										<th>响应状态</th>
                    					<th>时间</th>
									</tr>
								</thead>
								<tbody id=datalist>
									<!-- <tr>
										<td>@{getLink}</td>
										<td>#{report_sn}</td>
										<td>#{total_task}</td>
										<td>#{curr_task}</td>
										<td>@{getState}</td>
										<td><ul style="float:left;margin:0 0">请求时间：#{create_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">完成时间：#{completed_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">响应时间：#{reponse_time@formatdate}</ul></td>
									</tr> -->
                                </tbody>
							</table>
								<!-- <td>@{getState1}</td> -->
							<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
                            <jsp:include page="../common/page.jsp"/>
                        </div>
                    </div>
                </div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
   var req_sn_ext_u = getURLparam("req_sn_ext");
   if(req_sn_ext_u)$("#req_sn_ext").val(req_sn_ext_u);		
   XCOTemplate.pretreatment(['datalist']);
   var renderPage = true;
   getReportList(0,50)
   
   function getReportList(start,pageSize){
   		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		xco.setIntegerValue("resp_state", $("#resp_state").val());
		xco.setStringValue("req_sn_ext", $("#req_sn_ext").val());
		xco.setStringValue("report_sn", $("#report_sn").val());
		var options = {
			url : "/securityMultiple/getAikangRequestByPage.xco",
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
            getLink: function(xco){
                return '<a href="http://ung.boss.aixbx.com/ungstd/ruquestList.jsp?req_sn_ext='+xco.get("req_sn_ext")+'">'+xco.get("req_sn_ext")+'</a><br />';
            },
			getState:function(xco){
                var state = xco.getIntegerValue("resp_state");
                switch (state) {
					case 0:
                        return "未响应";
					case 10:
                        return "等待响应";
					case 30:
                        return "响应失败";
					case 100:
                        return "响应成功";
                }
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), getReportList, pageSize);
		}		  
	}
	  
	$("#find").click(function(){
		renderPage = true;
		getReportList(0,pageSize);
	});

   function formatdate(time){
       if(!time){
           return ;
       }
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


</script>
