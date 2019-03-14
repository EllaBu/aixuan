<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "分析结果";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>分析结果</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span href="#">医学管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span>分析结果</span><span class="divider">
				</span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>分析结果</h1>
			</div>

	      	<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<div  class="form-inline form-inline-list">
							<div class="row-fluid">
								<div class="span3">
									<label>体检机构</label>
									<select class="form-control" id="inst_code">
		                                <option value="">请选择</option>
		                                <option value="1001">爱康国宾</option>
		                                <option value="1002">天方达</option>
		                              </select>		                              
								</div>
								<div class="span3">
									<label>体检编号</label>
	                           	  	<input type="text" class="form-control" id="report_sn" placeholder="">
								</div>
								<div class="span3">
									<label>请求编号</label>
	                       		  	<input type="text" class="form-control" id="req_sn_ext" placeholder="">
								</div>
								<div class="span3">
									<label>分析结果</label>
									<select class="form-control" id="rar_result">
		                              	<option value="-1">请选择</option>
		                                <option value="0">初始</option>
		                                <option value="10">解析错误</option>
		                                <option value="30">不存在体检报告</option>
		                                <option value="100">完整</option>
		                              </select>
	                              
								</div>
							</div>
							<div class="row-fluid mar-t-15">
								<div class="span3">
									<label>处理状态</label>
									<select class="form-control" id="state">
		                                <option value="-1">请选择</option>
		                                <option value="0">初始</option>
		                                <option value="10">获取报告处理中</option>
		                                <option value="20">获取体检报告处理完毕</option>
		                                <option value="30">分析体检报告处理中</option>
		                                <option value="40">分析体检报告处理完毕</option>
		                                <option value="50">处理失败</option>
		                                <option value="100">处理成功</option>
		                              </select>
		                              
								</div>
							</div>
	                           <!-- <div class="form-group" style="line-height: 30px;">
	                       		  <label class="mar-l-15 mar-t-15">体检机构</label>
	                              <select class="form-control w150" id="inst_code">
	                                <option value="">请选择</option>
	                                <option value="1001">爱康国宾</option>
	                                <option value="1002">天方达</option>
	                              </select>
	                              <label class="mar-l-15 mar-t-15">体检编号</label>
	                           	  <input type="text" class="form-control mar-t-15 w150" id="report_sn" placeholder="">
	                              <label class="mar-l-15 mar-t-15">请求编号</label>
	                       		  <input type="text" class="form-control mar-t-15 w150" id="req_sn_ext" placeholder="">
	                       		  <label class="mar-l-15 mar-t-15">分析结果</label>
	                              <select class="form-control w150" id="rar_result">
	                              	<option value="-1">请选择</option>
	                                <option value="0">初始</option>
	                                <option value="10">解析错误</option>
	                                <option value="30">不存在体检报告</option>
	                                <option value="100">完整</option>
	                              </select>
	                          	</div>
	                           <div class="form-group">
                                 
	                              <label class="mar-l-15 mar-t-15">处理状态</label>
	                              <select class="form-control w150" id="state">
	                                <option value="-1">请选择</option>
	                                <option value="0">初始</option>
	                                <option value="10">获取报告处理中</option>
	                                <option value="20">获取体检报告处理完毕</option>
	                                <option value="30">分析体检报告处理中</option>
	                                <option value="40">分析体检报告处理完毕</option>
	                                <option value="50">处理失败</option>
	                                <option value="100">处理成功</option>
	                              </select>
		                       </div> -->
		                       <!-- <div class="form-group mar-l-15">
	                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
		                       </div> -->
	                        </div>
	                        <div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn mar-l-15  btn-info" id="find" type="reset">搜索</button>
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
			                    <th>ID</th>
			                    <th>机构名称</th>
			                    <th>身份证号/体检编号</th>
			                    <th>报告数量</th>
								<th>请求编号</th>
								<th>核保模式</th>
								<th>分析结果</th>
			                    <th>处理状态</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						 </thead>
						<tbody id="datalist">
						<!-- <tr>
		                        <td>#{rar_id}</td>
		                        <td>#{inst_name}</td>
		                        <td>@{getIDSN}</td>
		                        <td>#{content_count}</td>
		                        <td>#{req_sn_ext}</td>
		                        <td>@{getModel}</td>
		                        <td>@{getResult}</td>
		                        <td>@{getState}</td>
		                        <td ><ul style="float:left;margin:0 0">请求时间：#{create_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">完成时间：#{completed_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">响应时间：#{reponse_time@formatdate}</ul></td>
							  	<td>@{getLink}</td>
							</tr>
							 -->
	         			 </tbody>
					  </table>
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
	var req_sn_ext= getURLparam("req_sn_ext");
	$("#req_sn_ext").val(req_sn_ext);
   XCOTemplate.pretreatment(['datalist']);
   var renderPage = true;
   getReportList(0,50)
   
   function getReportList(start,pageSize){
   		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		xco.setStringValue("inst_code", $("#inst_code").val());
		xco.setStringValue("report_sn", $("#report_sn").val());
		xco.setStringValue("req_sn_ext", $("#req_sn_ext").val());
		xco.setIntegerValue("rar_result", $("#rar_result").val());
		xco.setIntegerValue("state", $("#state").val());
		var options = {
			url : "/medanalysis/getMedReportArByPage.xco",
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
				var count=xco.get("content_count");
				var str='';
				if(count>0){
					for(var i=0;i<count;i++){
						var number='';
						if(count>1){
							number=i+1;
						}
						str+='<a href="/medstd/reportDetail.jsp?rar_id='+xco.get("rar_id")+'&data_content='+i+'">结果明细'+number+'</a><br />';
					}
				}else{
					str+='<a href="/medstd/reportDetail.jsp?rar_id='+xco.get("rar_id")+'&data_content='+0+'">结果明细</a><br />';
				}
				return str;
			},
			getState:function(xco){
				var str="";
				if(xco.get("state")==0){
					str+= "初始";
				}	
				if(xco.get("state")==10){
					str+= "获取体检报告-处理中";
				}
				if(xco.get("state")==20){
					str+= "获取体检报告-处理完毕";
				}
				if(xco.get("state")==30){
					str+= "分析体检报告-处理中";
				}
				if(xco.get("state")==40){
					str+= "分析体检报告-处理完毕";
				}
				if(xco.get("state")==50){
					str+= "处理失败";
				}
				if(xco.get("state")==100){
					str+= "处理成功";
				}
				if(xco.get("rar_msg")){
					str+="<br />【"+xco.get("rar_msg")+"】";
				}
				return str;
			},
			getModel:function(xco){
				if(xco.get("rule_model")==1){
					return "预警";
				}
				if(xco.get("rule_model")==2){
					return "评点";
				}
				if(xco.get("rule_model")==3){
					return "预警+评级";
				}
				if(xco.get("rule_model")==4){
					return "推荐";
				}
				if(xco.get("rule_model")==5){
					return "评点+评级";
				}
				if(xco.get("rule_model")==6){
					return "评级";
				}				
			},
			getResult:function(xco){
				if(xco.get("rar_result")==0){
					return "初始";
				}
				if(xco.get("rar_result")==10){
					return "解析错误(可能有未解析项和解析错误项)";
				}
				if(xco.get("rar_result")==30){
					return "不存在体检报告";
				}
				if(xco.get("rar_result")==100){
					return "完整";
				}
			},
			getIDSN:function(xco){
				var str='';
				if(xco.get("idcard")){
					str+='<span style="float:left;margin:0 0" >身份证号：'+xco.get("idcard")+'</span><br />';
				}
				if(xco.get("report_sn")){
					str+='<span style="float:left;margin:0 0" >体检编号：'+xco.get("report_sn")+'</span>'
				}
				return str;
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
