<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "核保规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>正常值</title>
</head>
<body>
	<div id="main-content" class="clearfix">

    <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-leaf"></i>
				<span class="divider"></span><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span href="../dictionary/labelList.jsp">核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><span>正常值</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>正常值列表</h1>
			</div>

      <div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline form-inline-list">
							<div class="row-fluid">
								<div class="span3">
									<label>医学项名称</label>
	                          		<input type="text" class="form-control" id="std_cn_name" placeholder="医学项名称">
								</div>
								<div class="span3">
									<label>类型</label>
	                          		<select class="form-control" id="rnd_type">
		                                <option value="0">请选择</option>
		                                <option value="1">数值型</option>
		                       			<option value="2">阴阳型</option>
		                       			<option value="3">文本型</option>
	                              </select>
								</div>
							</div>
                           <!-- <div class="form-group" style="line-height: 30px;">
                           		<label>医学项名称</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="std_cn_name" placeholder="医学项名称">
                          		<label>类型</label>
                          		<select class="form-control w150" id="rnd_type">
                                <option value="0">请选择</option>
                                <option value="1">数值型</option>
                       			<option value="2">阴阳型</option>
                       			<option value="3">文本型</option>
                              </select>
                          	</div> -->
                          	<!-- <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">+新增</button>
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
										<th>正常值ID</th>
					                    <th>医学项名称</th>
					                    <th>KEY</th>
										<th>设定类型</th>
										<th>子条目数量</th>
										<th>状态</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!--
									<tr>
										<td>#{rn_id}</td>
										<td>#{std_cn_name}</td>
										<td>#{std_key}</td>
										<td>@{getType}</td>
										<td>#{rn_sub_total}</td>
										<td>@{getState}</td>
										<td>#{create_time@formatdate}</td>
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
	var rule_id = getURLparam("rule_id");
	XCOTemplate.pretreatment(['datalist']);
	var renderPage = true;
	xdoRequest(0,50);
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setIntegerValue("rnd_type", $("#rnd_type").val());
		xco.setStringValue("std_cn_name", $("#std_cn_name").val());
		xco.setStringValue("rule_id",rule_id);
		var options = {
			url : "/securityMultiple/getNormalPageList.xco",
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
				var str='';
				if(xco.get('std_type')==1){
					str+='<a href="http://ung.boss.aixbx.com/ungstd/normalNumberic.jsp?rn_id='+xco.get('rn_id')+'">编辑</a><br />';
				}
				/* 	str+='<a href="javascript:;" onclick="deleteNormal('+xco.get("rn_id")+')">删除</a><br />'; */
				return str;
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
				if(xco.get("rn_state")==1){
					return '正常';
				}else{
					return '停用';
				}
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
	  
	$("#find").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
	});
	
	
	function deleteNormal(opt){
		var xco = new XCO();
		xco.setIntegerValue("rn_id", opt);
		var options = {
			url : "/rulecalculate/deleteNormalAndDef.xco",
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
