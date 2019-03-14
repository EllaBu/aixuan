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
<title>编辑标签</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../dictionary/labelList.jsp">标签维护</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><a>编辑标签</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑标签</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>标签名称</label>
								<input type="text" class="form-control" id="name" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="updateLabels">保存</button>
								<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
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
	var labelNo = getURLparam("labelNo");
	getOneLabels();

	/* 获取标签详情 */
	function getOneLabels(){
		var xco = new XCO();
		xco.setLongValue("labelNo",labelNo);
		
		var options = {
			url : "/dic/getOneLabels.xco",
			data : xco,
			success : getOneLabelsCallBack
		};
		$.doXcoRequest(options);
	}
	/* 获取标签详情成功回调 */
	function getOneLabelsCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			$("#name").val(data.getStringValue("name"));
		}
	}

	//编辑按钮点击事件监听
	$("#updateLabels").click(function(){
		var xco = new XCO();
		xco.setLongValue("labelNo",labelNo);
		
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}else{
			axError("请输入标签名称");
			return;
		}
		xco.setStringValue("sys_op_log","编辑标签-编辑："+name);
		var options = {
			url : "/dic/updateLabels.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../dictionary/labelsList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存标签吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/labelsList.jsp";
	})
	XCOTemplate.pretreatment('listgroup');
</script>