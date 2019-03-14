<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>标准项列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>标准项管理</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>标准项列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="window.location.href='/medstd/addMedStd.jsp'" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
						  	<div class="row-fluid">
	                            <div class="span3">
	                                <label>编码</label> 
									<input type="text" class="form-control" id="std_code" placeholder="请输入标准项编码"> 
	                            </div>
	                            <div class="span3">
	                                <label>中文名</label>
									<input type="text" class="form-control" id="std_cn_name" placeholder="请输入标准项中文名称"> 
	                            </div>
	                             <div class="span3">
	                                <label>英文名</label> 
									<input type="text" class="form-control" id="std_en_name" placeholder="请输入标准项英文名称"> 
	                            </div>
	                            <div class="span3">
	                               <label>值类型</label>
									<select class="form-control" id="std_type">
										<option value="0">选择值类型</option>
										<option value="1">数值型</option>
										<option value="2">阴阳型</option>
										<option value="3">文本型</option>
									</select> 
	                            </div>
                        	</div>
                        	
						</div>
						<div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">查询</button>
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
										<th>标准项ID</th>
										<th>标准项编码</th>
										<th>中文名</th>
										<th>英文名</th>
										<th>值类型</th>
										<th>单位1</th>
										<th>单位2</th>
										<th>分类</th>
										<th>状态</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{std_id}</td>
										<td>#{std_code}</td>
										<td>#{std_cn_name}</td>
										<td>#{std_en_name}</td>
										<td>@{getType}</td>
										<td>#{std_unit1}</td>
										<td>#{std_unit2}</td>
										<td>#{catg_name}</td>
										<td>@{getState}</td>
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
    
    
    XCOTemplate.pretreatment(['datalist']);  //// 模板预处理
	var renderPage = true;
	xdoRequest(0,10);
	
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setStringValue("std_code", $("#std_code").val());
		xco.setStringValue("std_cn_name", $("#std_cn_name").val());
		xco.setStringValue("std_en_name", $("#std_en_name").val());
		xco.setIntegerValue("std_type", $("#std_type").val());
		var options = {
			url : "/standard/standardList.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
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
				return '<a href="/medstd/updateMedStd.jsp?std_id='+xco.get("std_id")+'">编辑</a><br />';
			},
			getType:function(xco){
				var name='';
				if(xco.get('std_type')==1){
					name='数值型';
					return name;
				}
				if(xco.get('std_type')==2){
					name='阴阳型';
					return name;
				}
				if(xco.get('std_type')==3){
					name='文本型';
					return name;
				}
			},
			getState:function(xco){
				if(xco.get("std_state")==1){
					return '正常';
				}else{
					return '停用';
				}
			}
	    };
	    
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);  // 填充模板, data为XCO对象
    	}
   		document.getElementById("datalist").innerHTML = html;  // 渲染页面
   		
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), xdoRequest, pageSize);
		}		  
	}
	
	function deleteStd(opt){
		xco.setIntegerValue("std_id", opt);
		var options = {
			url : "/standard/deleteMedstd.xco",
			data : xco,
			success : doDeleteCallBack
		};
		$.doXcoRequest(options);
	
	}
	
	function doDeleteCallBack(data){
		if(data.getCode()==0){
			window.location.reload();
		}else{
		// TODO 错误提示
			return;
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