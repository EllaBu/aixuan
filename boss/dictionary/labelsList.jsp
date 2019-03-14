<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "标签维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>标签维护</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>标签维护</a><span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>标签维护</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
	                       <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addLabels" type="reset">新增标签</button>
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
										<th>序号</th>
										<th>标签名称</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{i+1}</td>
										<td>#{list[i].name}</td>
										<td>@{getOpt}</td>
									</tr> -->
                                </tbody>
							</table>
                            
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
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#addLabels").click(function(){
		location.href = "../dictionary/addLabels.jsp";
	});
	
	getLabelsList();
	
	/*获取标签列表*/
	function getLabelsList() {
		var xco = new XCO();

		var options = {
			url : "/dic/getLabelsList.xco",
			data : xco,
			success : getLabelsListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取系统用户列表成功回调*/
	function getLabelsListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			data = data.getData();
			var len = 0;
			var total = data.getXCOValue("total");
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getOpt : function(){
					return '<a href="../dictionary/updateLabels.jsp?labelNo='+list[i].getLongValue("label_no")+'">编辑</a>';
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getLabelsList, pageSize);
			}
		}
	}
</script>