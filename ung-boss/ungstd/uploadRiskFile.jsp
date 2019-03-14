<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "风险指标导入";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>数据导入</title>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-lock"></i><span class="divider"></span><span > 爱康管理</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>风险指标导入</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-th-list"></i>风险指标导入</h1>
		</div>
		<div id="cover" style="display: none"></div>
		<div id="coverShow" style="display: none">
			<img src="/image/loaders/4.gif" />
			<p>请稍后......</p>
		</div>
		<div class="row-fluid">
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入风险指标Excel文件</label>
								<input type="text" class="form-control" id="file_name3" readonly="readonly">
								<form id="form3" action=""  method="post" enctype="multipart/form-data">
										<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
											<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
													<input style="width:88px;height:30px;" type="file" name="file"
														id="fileField3" onchange="select1(this,3);" value="选择文件"
														alt="点击选择文件" />
												<br class="clear" />
											</div>
										</div>
								</form>
								<input type="hidden" class="form-control" value="101" id="ruleId3" >
								<div class="from-group mar-t-15" id="subbutton3">
									<label></label>
									<button class="btn mar-t-15  btn-success"  onclick="sunbmitform(3)" type="reset">导入</button>
								</div>
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
	function select1(e,seq){
		var xco = new XCO();
		var fileField = $("#fileField"+seq+"").val();
		$("#file_name"+seq+"").val(fileField);
		if(e.value){
			var index = fileField.lastIndexOf(".");
			var suffix = fileField.substring(index+1,fileField.length);
			if(suffix != "xlsx"){
				axError("请上传excel文件!");
				$("#fileField"+seq+"").val("");
				$("#subbutton"+seq+"").hide();
				return;
			}else{
				$("#subbutton"+seq+"").show();
			}
		}
	}
	
	function  sunbmitform(seq){
		if(!$("#file_name"+seq+"").val()){
			axError("请上传文件");
			return;
		}
		var rule_xco = new XCO();
		rule_xco.setLongValue("rule_id",$("#ruleId"+seq+"").val());
		var cover = document.getElementById("cover"); 
		var covershow = document.getElementById("coverShow"); 
		cover.style.display = 'block'; 
		covershow.style.display = 'block'; 
		$("#form"+seq+"").attr("action","/uploadExcel.xco?ruleId="+$("#ruleId"+seq+"").val()+"&type="+(seq-1));
		$("#form"+seq+"").ajaxSubmit({
	      	success:function(data){
	      		$("#fileField"+seq+"").val("");
	        	var xco=new XCO();
	        	xco.fromXML(data);
      			cover.style.display = 'none'; 
				covershow.style.display = 'none'; 
	      		if(xco.getCode()==0){
	      			axSuccess("风险指标Excel导入成功",function(){
						window.location.reload();
					});
	      		}else{
	      			axError("导入失败!");
	      		}
	      	}
        })
	}
</script>
