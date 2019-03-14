<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>产品规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

    <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li> <i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>产品规则</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>产品规则列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="window.location.href='ungstd/addProduct.jsp'"  type="reset">+新增</button>
           		</div>
			</div>

      <div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div  class="form-inline form-inline-list">
						<div class="row-fluid">
							<div class="span3">
								<label>渠道</label>
                           		<select class="form-control" id="ch_id">
                           				<option value="0">请选择</option>	
									<!-- <option value="#{ch_id}">#{ch_name}</option> -->
								</select>
							</div>
							<div class="span3">
								<label>类型</label>
                          		<select class="form-control" id="up_type">
                          			<option value="0">请选择</option>
                          			<option value="1">产品级</option>
                          			<option value="2">类目级</option>
                          			<option value="3">保险公司级</option>
                          			<option value="4">渠道级别</option>
                          		</select>
							</div>
							<div class="span3">
								<label>产品编码</label>
                          		<input type="text" class="form-control" id="up_ext_pno" placeholder="请输入产品编码">
							</div>
						</div>
                           <!-- <div class="form-group" style="line-height: 30px;">
                           		<label>渠道</label>
                           		<select class="form-control w150" id="ch_id">
                           				<option value="0">请选择</option>	
									<option value="#{ch_id}">#{ch_name}</option>
								</select>
                          		<label>类型</label>
                          		<select class="form-control w150" id="up_type">
                          			<option value="0">请选择</option>
                          			<option value="1">产品级</option>
                          			<option value="2">类目级</option>
                          			<option value="3">保险公司级</option>
                          			<option value="4">渠道级别</option>
                          		</select>
                          		<label>产品编码</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="up_ext_pno" placeholder="请输入产品编码">
                          	</div> -->
                          	<!-- <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" onclick="window.location.href='ungstd/addProduct.jsp'"  type="reset">+新增</button>
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
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>ID</th>
					                    <th>渠道</th>
										<th>保险公司</th>
										<th>产品分类</th>
										<th>产品编号</th>
										<th>类型</th>
										<th>核保规则</th>
										<th>状态</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{up_id}</td>
										<td>#{ch_name}</td>
										<td>#{org_name}</td>
										<td>#{series_name}</td>
										<td>#{up_ext_pno}</td>
										<td>@{getType}</td>
										<td>#{rule_name}</td>
										<td>@{getState}</td>
										<td>#{create_time@formatdate}</td>
										<td>@{getLink}</td>
									</tr> -->
                                </tbody>
							</table>
							<label style="float: left;width: 40%;">查询结果总条数：<span id="total"></span>条</label>
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
	
	XCOTemplate.pretreatment(['ch_id','datalist']);
	
	channelRequest();
	function channelRequest(){
		var xco = new XCO();
		var options = {
			url : "/security/getAllChannel.xco",
			data : xco,
			success : channelRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function channelRequestCallBack(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		var dataList = data.getData();
		var html = '<option value="0">请选择</option>';
		 for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("ch_id", dataList[i], null);
    	}
    	
   		document.getElementById("ch_id").innerHTML = html;
	}
	
	var renderPage = true;
	xdoRequest(0,50);
	/* 获取责任项序号列表 */
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setLongValue("ch_id", $("#ch_id").val());
		xco.setIntegerValue("up_type", $("#up_type").val());
		xco.setStringValue("up_ext_pno", $("#up_ext_pno").val()); 
		var options = {
			url : "/securityMultiple/getProductPageList.xco",
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
		$("#size").text(5);
		var dataList=data.get('list');
		if(!dataList){
			dataList=new Array();
		}
		/*
	    var html = '';
	    var ext = {
			getLink: function(xco){
				return '<a href="###">编辑</a><br /><a href="###">删除</a>';
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	data.setIntegerValue("i", i);
        	html += XCOTemplate.execute("datalist", data, ext);
    	}
   		document.getElementById("datalist").innerHTML = html;*/
   		
	    var html = '';
	    var ext = {
			getLink: function(xco){
				return '<a href="/ungstd/updateProduct.jsp?up_id='+xco.get("up_id")+'">编辑</a>';
			},
			getType:function(xco){
				var name='';
				if(xco.get('up_type')==1){
					name='产品级';
					return name;
				}
				if(xco.get('up_type')==2){
					name='类目级';
					return name;
				}
				if(xco.get('up_type')==3){
					name='保险公司级';
					return name;
				}
				if(xco.get('up_type')==4){
					name='渠道级别';
					return name;
				}
			},
			getState:function(xco){
				if(xco.get("up_state")==1){
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
		var newTime = year + '-' +  month + '-' + day + ' ' +
				                hour + ':' +min + ':' +sec;
	    return newTime;         
	}

</script>
