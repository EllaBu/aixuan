<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "体检机构";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>文本结论分类列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li>体检机构<span class="divider"></span><i class="icon-angle-right"></i> </span>
				<li>文本结论分类<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>文本结论分类列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" id="addTextcatg" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">
				<!-- <div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline">
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-success" id="addTextcatg" type="reset">+新增</button>
							</div>
						</div>
					</div>
				</div> -->

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>机构名称</th>
										<th>类目名称</th>
										<th>类目标识</th>
										<th>描述</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{tcc_id}</td>
										<td>爱康国宾</td>
										<td>#{tcc_name}</td>
										<td>#{tcc_key}</td>
										<td>#{tcc_desc}</td>
										<td>#{create_time@formatdate}</td>
										<td>@{getLink}</td>
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
	var inst_code = getURLparam("inst_code");
	xdoRequest(0,10);
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setStringValue("inst_code", inst_code);
		var options = {
			url : "/medtextcon/getMedtextconcatgByPage.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	$("#addTextcatg").on("click",function(){
		window.location.href="/medstd/addmedTextCatg.jsp?inst_code="+inst_code;
	})
	
	function doRequestCallBack(data){
		//var xco=new XCO();
		//xco.fromXML(data);
		//var data = xco.getData();
		
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
				return '<a href="/medstd/updatemedTextCatg.jsp?tcc_id='+xco.get("tcc_id")+'">编辑</a><br />';
			}
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
	  
    $("#search").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
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