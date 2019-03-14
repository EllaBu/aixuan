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
<meta charset="utf-8" />
<title>结果明细</title>
</head>
<body>
<div id="main-content" class="clearfix">
	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li>
				<i class="icon-heart"></i><span class="divider"></span><span href="#">医学管理</span><span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li>
				<span>分析结果 </span><span class="divider"><i class="icon-angle-right"></i></span>
			</li>
			<li>
				<span>结果明细</span><span class="divider"></span>
			</li>
		</ul>
	</div>
	<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>结果明细</h1>
			</div>
			<div class="row-fluid">
        	<div class="result-title-new">基本信息</div>
        	<div id="reqResult">
			<!--<div class="row-fluid">
				<div class="span12">
					<div class="form-inline bord1dd form-add1">
		                <div class="from-group mar-t-15">
							<label>体检机构</label>
							<input type="text" class="form-control"  value="#{inst_name}" disabled>
						</div>
						<div class="from-group mar-t-15">
	          				<label>体检编号</label>
							<input type="text" class="form-control" value="#{report_sn}" disabled>
						</div> 
					</div>
				</div>
			</div>
	        <div class="result-title-new">
			 	医学结论
			</div>
			<div class="result-analysis-new clearfix">
				@{getState}               <dl id="countres"></dl>
			</div> -->
	        </div>
	        <div class="result-title-new">
	        		  结果明细   
	        </div>
	       
	        <div class="row-fluid">
	                    <div class="row-fluid">
	                        <div class="span12">
	                        	<div  class="form-inline" style="padding: 0;">
									<div class="form-group" style="line-height: 30px;">
											<div class="form-group result-search-new">
												<label>解析结果</label>
												<select class="form-control w150" id="rard_result">
												<option value="-1">请选择</option>
												<option value="0">未知</option>
												<option value="100">成功</option>
												<option value="110">解析失败</option>
												<option value="115">解析异常</option>
												<option value="120">缺少体检结果</option>
												</select>
												<button id="find" type="reset">搜索</button>
												 <span style="float:right;margin-top: 20px;" id="rescount" ><!--@{getResult}:【#{total}】  --></span> 
											</div>
									</div>
								</div> 
	                            <table id="table_bug_report" class="table table-striped table-bordered table-hover" style="position: relative; top: -15px;"">
									<thead>
										<tr>
											<th>ID</th>
											<th>项标识 </th>
											<th>项内容</th>
											<th>医学标准项</th>
											<th>解析后的值</th>
											<th>解析结果</th>
											<th>错误原因</th>
											<th>创建时间</th>
										</tr>
									</thead>
									<tbody id="datalist">
										<!-- <tr>
										<td>#{rard_id}</td>
										<td>#{field_key}</td>
										<td>#{field_value}</td>
										<td>#{std_code}</td>
										<td>#{parsed_value}</td>
										<td>@{getResult}</td>
										<td>#{rard_err_msg}</td>
										<td>#{create_time@formatdate}</td>
										</tr>
										 -->
									</tbody>
								</table>
								<div style="margin-top: 10px">
									<div id="loading" style="display: none">
										<img alt="" src="../image/loaders/4.gif"/>
									</div> 
									<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
	                            	<jsp:include page="../common/page.jsp"/>
								</div>
	                        </div>
	                    </div>
	                </div>
				</div>
			</div>	
</div>	
</body>
</html>
<script type="text/javascript">
   var rar_id = getURLparam("rar_id");
   var data_content = getURLparam("data_content");
   XCOTemplate.pretreatment(['reqResult','datalist']);
   var renderPage = true;
   getReportList(0,100);
   function getReportList(start,pageSize){
   		$("#loading").show();
   		var xco = new XCO();
   		xco.setIntegerValue("rar_id", rar_id);
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		xco.setIntegerValue("rard_result", $("#rard_result").val());
		xco.setIntegerValue("data_content", data_content);
		var options = {
			url : "/medanalysis/getMedReportArDetailByPage.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
   }
	
	function doRequestCallBack(data){
		$("#loading").hide();
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
			getResult:function(xco){
				if(xco.get("rard_result")==0){
					return "未知";
				}
				if(xco.get("rard_result")==100){
					return "成功";
				}
				if(xco.get("rard_result")==110){
					return "解析失败";
				}
				if(xco.get("rard_result")==115){
					return "解析异常";
				}
				if(xco.get("rard_result")==120){
					return "缺少体检结果";
				}
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), getReportList, 100);
		}		  
	}
	  
	$("#find").click(function(){
		renderPage = true;
		getReportList(0,100);
	});
	
	dogetMedReport();
	function dogetMedReport(){
		var xco = new XCO();
   		xco.setIntegerValue("rar_id", rar_id);
   		xco.setIntegerValue("data_content", data_content);
   		var options = {
			url : "/medanalysis/getMedReportforDetail.xco",
			data : xco,
			success : dogetMedReportCallBack
		};
		$.doXcoRequest(options);
	}
	
	function dogetMedReportCallBack(data){
		if(data.getCode()==0){
			data=data.getData();
			var res=data.get("repRes");
			
			var ext={
				getState:function(xco){
					if(xco.get("state")==0){
						return '<p>处理状态：【<font color="red">待处理</font>】</p>';
					}
					if(xco.get("state")==10){
						return '<p>处理状态：【<font color="red">获取体检报告-处理中</font>】</p>';
					}
					if(xco.get("state")==20){
						return '<p>处理状态：【<font color="red">获取体检报告完毕</font>】</p>';
					}
					if(xco.get("state")==30){
						return '<p>处理状态：【<font color="red">分析体检报告-处理中</font>】</p>';
					}
					if(xco.get("state")==40){
						return '<p>处理状态：【<font color="red">分析体检报告完成</font>】</p>';
					}
					if(xco.get("state")==50){
						return '<p>处理状态：【<font color="red">处理失败：'+xco.get("rar_msg")+'</font>】</p>';
					}
					if(xco.get("state")==100){
						return '<p>处理状态：【<font color="green">处理成功</font>】</p>';
					}
				} 
			}
			var reshtml=XCOTemplate.execute("reqResult", res,ext);;
			document.getElementById("reqResult").innerHTML = reshtml;
			var count=data.get("countRes");
			if(count){
				var str='<dt>明细统计：</dt><dd>';
				for ( var i = 0; i < count.length; i++) {
					var obj = count[i];
					if(obj.get("rard_result")==0){
						str+='<p><span>未知：</span>【'+obj.get("total")+'】</p>';
					}
					if(obj.get("rard_result")==100){
						str+='<p><span>成功：</span>【'+obj.get("total")+'】</p>';
					}
					if(obj.get("rard_result")==110){
						str+='<p><span>解析失败：</span>【'+obj.get("total")+'】</p>';
					}
					if(obj.get("rard_result")==115){
						str+='<p><span>解析异常：</span>【'+obj.get("total")+'】</p>';
					}
					if(obj.get("rard_result")==120){
						str+='<p><span>缺少体检结果：</span>【'+obj.get("total")+'】</p>';
					}
				}
				str+='</dd>';
				$("#countres").append(str);
			}
		}
	}
	
	
	
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
