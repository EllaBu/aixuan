<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品总表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>公司评分</title>
<style type="text/css">
#cover {
	display: none;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.44);
}

#coverShow {
	display: none;
	position: fixed;
	z-index: 2;
	top: 50%;
	left: 50%;
	border: 0px solid #127386;
}
</style>
</head>
<body>
	<div id="cover"></div>
	<div id="coverShow">
		<img src="/image/loaders/4.gif" />
		<p>请稍后......</p>
	</div>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-file-alt"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../organization/orgScoreList.jsp">产品列表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>产品价格导入<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>产品价格导入</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>产品编号</label>
								<span id="productNo"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>产品名称</label>
								<span id="productName"></span>
							</div>
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px">
								<label>导入文件</label>
								<input type="text" class="form-control" id="file_name" readonly="readonly">
								<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
								<!-- <button class="btn btn-info" type="reset" id="downPriceScoreTemplate" style="position:absolute; left:570px; top:0px;padding-left:30px;padding-right:30px;height:30px;">下载模板</button> -->
								<input type="hidden" id="file_url" name="file_url">
								<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
									<form id="form1" name="upload" action="" method="post" enctype="multipart/form-data">
										<!-- <input type="hidden" id="update_desc2" name="update_desc2" value="xxxxxx"/> -->
										<input style="width:88px;height:30px;" type="file" name="file"
											id="fileField" onchange="select1(this);" value="选择文件"
											alt="点击选择文件" />
									</form>
									<br class="clear" />
								</div>
							</div>
							<div class="from-group mar-t-15">
								<span style="margin-left: 146px;color:red;">当前下载模板为2018年3月20号最新Excel</span><span><a href="/downPriceScoreTemplate.xco" style="margin-left:20px;">模板下载</a></span>
							</div>
							
						</div>
						<div class="row-fluid" id="succMsg">
							<div class="row-fluid ">
								<div class="span12">
									<table id="table_bug_report"
										class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="100%" style="color: green; text-align: left !important;" id="xmlid">处理成功!</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
						<div class="row-fluid" id="errMsg">
							<div class="row-fluid ">
								<div class="span12">
									<table id="table_bug_report" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="100%" style="color: red; text-align: left !important;">处理失败,错误原因如下:</th>
											</tr>
										</thead>
										<tbody id="table_content">
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn btn-info" type="submit" id="exit">返回</button>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	$("#exit").click(function(){
		//location.href="http://manager.boss.aixbx.com/product/productList.jsp";
		history.go(-1);
	});
	
	
	$("#errMsg").hide();
	$("#succMsg").hide();
	
	var productNo = getURLparamEncoder("productNo");//产品编号
	var productName = getURLparamEncoder("productName");//产品名称
	var productId = getURLparamEncoder("productId");//产品id
	$("#productNo").text(productNo);
	$("#productName").text(productName);
	
	function select1(e){
		var xco = new XCO();
		$("#form1").attr("action","/uploadMultipleScoreExcel.xco?"+productNo);
		//$("#form1").attr("action","/uploadOrgScoreExcel.xco?"+encodeURI(update_desc));
		//$("#form1").attr("action","/uploadOrgScoreExcel.xco?"+encodeURI(encodeURI(update_desc)));
		
		//$("#form1").attr("action","/uploadOrgScoreExcel.xco?"+encodeURIComponent(update_desc));
		//$("#form1").attr("action","/uploadOrgScoreExcel.xco?"+encodeURIComponent(encodeURI(update_desc)));
		
		if(e.value){
			$("#succMsg").hide();
			$("#errMsg").hide();
			var fileField = $("#fileField").val();
			var index = fileField.lastIndexOf(".");
			var suffix = fileField.substring(index+1,fileField.length);
			if(suffix == "xlsx"){
				var cover = document.getElementById("cover"); 
				var covershow = document.getElementById("coverShow"); 
				cover.style.display = 'block'; 
				covershow.style.display = 'block'; 
				$("form[name='upload']").ajaxSubmit({
			      	success:function(data){
			      	//alert(typeof data + "\tdata="+data);
			      		$("#fileField").val("");
			        	var xco=new XCO();
			        	xco.fromXML(data);
		      			cover.style.display = 'none'; 
						covershow.style.display = 'none'; 
						/**/
			      		if(xco.getCode() == 0){
							var _dataList = xco.getXCOListValue("updateResult");
							if(_dataList.length > 0){
				      			$("#succMsg").show();
								$("#xmlid").html("处理结果:"+_dataList[0].getXCOValue("data").getStringValue("info")+"<span style=\"margin-left:20px;\"><a href=\"../task/taskList.jsp\">查看任务</span>");
								$("#xmlid").css("color","green");
							}
			      		}else if(xco.getCode() == 110){
			      			$("#errMsg").show();
			      			var _dataList = xco.getXCOListValue("updateResult");
							if(_dataList.length > 0){
				      			var list = _dataList[0].getXCOValue("data").getXCOListValue("imxcoilist");
				      			var str = "";
				      			for(var i=0;i<list.length;i++){
				      				str+="<tr><td>"+list[i].getStringValue("msg")+"</td></tr>"
				      			}
				      			document.getElementById("table_content").innerHTML = str;
							}
			      		}else if(xco.getCode() == -1){
							$("#errMsg").show();
							var str = "<tr><td>"+list[i].getStringValue("msg")+"</td></tr>"
			      			document.getElementById("table_content").innerHTML = str;
			      		}
			      	}
		        })
			}else{
				cover.style.display = 'none'; 
				covershow.style.display = 'none'; 
				$("#succMsg").show();
				$("#xmlid").html("请上传excel文件!");
				$("#xmlid").css("color","red");
				$("#fileField").val("");
				return;
			}
			
		}
	}
	
</script>