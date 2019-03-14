<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "公司评分";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>公司评分列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">
		
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险公司管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>公司评分管理<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>公司评分管理</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
						    <div class="form-group" style="line-height:30px;">
                           		<label>公司名称</label>
                          		<input type="text" class="form-control w150" id="name" placeholder="公司名称">
                          		<label>备注信息</label>
                          		<input type="text" class="form-control w150" id="updateDesc" placeholder="备注信息">
                          		<label>开始日期</label>
                          		<input type="text" class="form-control Wdate w150" id="startTime" placeholder="开始日期" onfocus="WdatePicker({readOnly:true})">
                          		<label>结束日期</label>
                          		<input type="text" class="form-control Wdate w150" id="endTime" placeholder="结束日期" onfocus="WdatePicker({readOnly:true})">
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="importExcel" type="reset">导入</button>
	                       </div>
                        </div>
					</div>
				</div>
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                        	<label style="color: #008800;">当前系统总共<span style="color: red;" id="size"></span>个公司</label>
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover dataTable" style="margin-bottom: 20px;">
								<thead>
									<tr>
										<th class="ax_th sorting" data-type="org_no" data-class="sorting">公司编号</th>
										<th>保险公司名称</th>
										<th class="ax_th sorting" data-type="score1" data-class="sorting">公司分</th>
										<th class="ax_th sorting" data-type="score2" data-class="sorting">风控分</th>
										<th class="ax_th sorting" data-type="score3" data-class="sorting">服务分</th>
										<th>备注</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].org_no}</td>
										<td>#{list[i].name}</td>
										<td>#{list[i].score1@formatScore}</td>
										<td>#{list[i].score2@formatScore}</td>
										<td>#{list[i].score3@formatScore}</td>
										<td>#{list[i].update_desc}</td>
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
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	var data_class = "sorting";
	var data_type = "org_no";
	$(".ax_th").click(function(){
		data_class = $(this).attr("data-class");
		data_type = $(this).attr("data-type");
		if(data_class=="sorting"){
			$(".ax_th").removeClass("sorting_asc").removeClass("sorting_desc").addClass("sorting");
			$(this).removeClass("sorting").addClass("sorting_asc");
			$(this).attr("data-class","sorting_asc");
		}else if(data_class=="sorting_asc"){
			$(".ax_th").removeClass("sorting_asc").removeClass("sorting_desc").addClass("sorting");
			$(this).removeClass("sorting").addClass("sorting_desc");
			$(this).attr("data-class","sorting_desc");
		}else if(data_class=="sorting_desc"){
			$(".ax_th").removeClass("sorting_asc").removeClass("sorting_desc").addClass("sorting");
			$(this).removeClass("sorting").addClass("sorting_asc");
			$(this).attr("data-class","sorting_asc");
		}
		getOrgScoreListPage(0,pageSize);
	})

	$("#reset").click(function(){
	   	var array = ["#name","#updateDesc","#startTime","#endTime"];
	   	resetInput(array);
	})
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		getOrgScoreListPage(0,pageSize);
	});
	
	$("#importExcel").click(function(){
		location.href = "../organization/addOrgScore.jsp";
	});
	
	getOrgScoreListPage(0,pageSize);
	
	/*获取公司分列表*/
	function getOrgScoreListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		if(data_class=="sorting"||data_class=="sorting_desc"){
			xco.setStringValue("data_class", "asc");
		}else{
			xco.setStringValue("data_class", "desc");
		}
		xco.setStringValue("data_type", data_type);
		/*公司名称*/
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}
		/*公司描述*/
		var updateDesc = $("#updateDesc").val();
		if(updateDesc){
			xco.setStringValue("update_desc",updateDesc);
		}
		/*开始日期*/
		var startTime = $("#startTime").val();
		if(startTime){
			xco.setStringValue("start_time",startTime);
		}
		/*结束日期*/
		var endTime = $("#endTime").val();
		if(endTime){
			xco.setStringValue("end_time",endTime);
		}

		var options = {
			url : "/org/getOrgScoreListPage.xco",
			data : xco,
			success : getOrgScoreListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取公司分列表成功回调*/
	function getOrgScoreListPageCallBack(data) {
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
				
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getOrgScoreListPage, pageSize);
			}
		}
	}
	
</script>