<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "文本结论";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>文本结论列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>医学管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>文本结论</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>文本结论列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="javascript:window.location.href='medstd/addMedText.jsp'" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-list">
						<div class="row-fluid">
							<div class="span3">
								<label>文本结论</label> 
								<input type="text" class="form-control" id="tcm_context" placeholder="文本结论"> 
							</div>
							<div class="span3">
								<label>体检机构</label>
								<select class="form-control" id="std_type">
									<option value="0">选择体检机构</option>
									<option value="1001">爱康</option>
								</select> 
							</div>
						</div>
						
							<!-- <div class="form-group" style="line-height: 30px;">
								<label class="mar-l-15 mar-t-15">文本结论</label> 
								<input type="text" class="form-control mar-t-15 w150" id="tcm_context" placeholder="文本结论"> 
								<label class="mar-l-15 mar-t-15">体检机构</label>
								<select class="form-control mar-t-15 w150" id="std_type">
									<option value="0">选择体检机构</option>
									<option value="1001">爱康</option>
								</select> 
							</div> -->
							<!-- <div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
								<button class="btn mar-t-15 mar-l-15  btn-success" onclick="javascript:window.location.href='medstd/addMedText.jsp'" type="reset">+新增</button>
							</div> -->
						</div>
						<div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn mar-l-15 btn-info" id="search" type="reset">查询</button>
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
										<th>体检机构</th>
										<th>三方编码</th>
										<th>文本结论分类</th>
										<th>文本结论描述</th>
										<th>医学标准项</th>
										<th>字段名称</th>
										<th>数据提取</th>
										<th>状态</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{tcm_id}</td>
										<td>爱康</td>
										<td>#{tcm_tp_code}</td>
										<td>#{tcc_name}</td>
										<td>#{tcm_context}</td>
										<td>#{std_code}</td>
										<td>#{field_key}</td>
										<td>@{getType}</td>
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
    
    
    XCOTemplate.pretreatment(['datalist']);
	var renderPage = true;
	xdoRequest(0,100);
	
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setStringValue("tcm_context", $("#tcm_context").val());
		var options = {
			url : "/medtextcon/getMedTextConMappingByPage.xco",
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
				return '<br />';
			},
			getState:function(xco){
				if(xco.get("tcm_state")==1){
					return '正常';
				}else{
					return '停用';
				}
			},
			getType:function(xco){
				if(xco.get("text_type")==0){
					return 'N';
				}else{
					return 'Y';
				}
			},
			getLink:function(xco){
				return '<a href="/medstd/updateMedText.jsp?tcm_id='+xco.get("tcm_id")+'">编辑</a>';
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), xdoRequest, 100);
		}		  
	}
	  
    $("#search").click(function(){
		renderPage = true;
		xdoRequest(0,100);
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