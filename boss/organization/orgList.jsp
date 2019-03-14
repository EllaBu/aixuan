<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "公司管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>系统用户列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险公司管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>公司管理<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>公司管理</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
							<div class="form-group" style="line-height:30px;">
                           		<label>公司名称</label>
                          		<input type="text" class="form-control w150" id="name" placeholder="公司名称">
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">新增</button>
	                       </div>
                        </div>
					</div>
				</div>
				
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                        	<label style="color: #008800;">当前系统总共<span style="color: red;" id="size"></span>个公司</label>
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>公司编号</th>
										<th>公司全称</th>
										<th>公司简称</th>
										<th>创建日期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].org_no}</td>
										<td>#{list[i].full_name}</td>
										<td>#{list[i].name}</td>
										<td>#{list[i].create_time@formatDateTime}</td>
										<td>@{getOpt}</td>
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
    
	$("#reset").click(function(){
		var array = ["#name"];
		resetInput(array);
	})
    
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		getOrgListPage(0,pageSize);
		$("#name").val("");
	});
	
	$("#add").click(function(){
		location.href = "../organization/addOrg.jsp";
	});
	
	getOrgListPage(0,pageSize);
	
	/*获取公司列表*/
	function getOrgListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}

		var options = {
			url : "/org/getOrgListPage.xco",
			data : xco,
			success : getOrgListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取公司列表成功回调*/
	function getOrgListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			var size = 0;
			data = data.getData();
			total = data.getIntegerValue("total");
			size = data.getIntegerValue("size");
			var len = 0;
			var list = data.getXCOListValue("list");
			$("#total").text(total);
			$("#size").text(size);
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getOpt : function(){
					return '<a class="mar-r-15" href="../organization/updateOrg.jsp?orgNo='+list[i].getLongValue("org_no")+'">编辑</a>';
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getOrgListPage, pageSize);
			}
		}
	}
	
</script>