<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数据上传";
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
			<li><span > 病种库</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>数据上传</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>病种库相关导入</h1>
		</div>
		<div id="cover" style="display: none"></div>
		<div id="coverShow" style="display: none">
			<img src="/image/loaders/4.gif" />
			<p>请稍后......</p>
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入病种库Excel文件</label>
								<input type="text" class="form-control" id="file_name1" readonly="readonly">
								<form id="form1" action=""  method="post" enctype="multipart/form-data">
										<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
											<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
													<input style="width:88px;height:30px;" type="file" name="file"
														id="fileField1" onchange="select1(this,1);" value="选择文件"
														alt="点击选择文件" />
												<br class="clear" />
											</div>
										</div>
								</form>
								<div class="from-group mar-t-15">
									<span style="margin-left: 50px;color:red;">当前下载模板为2018年11月22号最新Excel</span><span><a target="_blank" href="../templete/病种库模板20181122.xlsx" style="margin-left:20px;">模板下载</a></span>
								</div>
						</div>
						<div class="from-group mar-t-15" id="subbutton1">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success"  onclick="sunbmitform(1)" type="reset">导入</button>
						</div>
					</div>		
				</div>
			</div>
			
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入产品相关病种Excel文件</label>
								<input type="text" class="form-control" id="file_name2" readonly="readonly">
								<form id="form2" action=""  method="post" enctype="multipart/form-data">
										<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
											<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
													<input style="width:88px;height:30px;" type="file" name="file"
														id="fileField2" onchange="select1(this,2);" value="选择文件"
														alt="点击选择文件" />
												<br class="clear" />
											</div>
										</div>
								</form>
								<div class="from-group mar-t-15">
									<span style="margin-left: 50px;color:red;">当前下载模板为2018年11月22号最新Excel</span><span><a target="_blank" href="../templete/产品病种库模板20181122.xlsx" style="margin-left:20px;">模板下载</a></span>
								</div>
								<div class="from-group mar-t-15" id="repeat_no_div" style="display:none">
									<label><span class="font-red">重复的产品编号：</span></label>
									<input type="text" class="form-control" readonly="readonly" id="repeat_no">
								</div>
								<div class="from-group mar-t-15" id="none_name_div" style="display:none">
									<label><span class="font-red">产品编号为空的产品名称：</span></label>
									<textarea readonly="readonly" id="none_name" rows="2" style="width:70%;"></textarea>
								</div>
								<div class="from-group mar-t-15" id="none_no_div" style="display:none">
									<label><span class="font-red">不存在的产品编号：</span></label>
									<input type="text" class="form-control" readonly="readonly" id="none_no">
								</div>
						</div>
						<div class="from-group mar-t-15" id="subbutton2">
							<label></label>
							<button class="btn mar-t-15 mar-l-15  btn-success"  onclick="sunbmitform(2)" type="reset">导入</button>
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
		var cover = document.getElementById("cover"); 
		var covershow = document.getElementById("coverShow"); 
		cover.style.display = 'block'; 
		covershow.style.display = 'block'; 
		$("#none_no_div").css("display","none");
		$("#none_name_div").css("display","none");
		$("#repeat_no_div").css("display","none");
		$("#form"+seq+"").attr("action","/uploadExcel.xco?type="+(seq-1));
		$("#form"+seq+"").ajaxSubmit({
	      	success:function(data){
	      		$("#fileField"+seq+"").val("");
	        	var xco=new XCO();
	        	xco.fromXML(data);
      			cover.style.display = 'none'; 
				covershow.style.display = 'none'; 
	      		if(xco.getCode()==0){
	      			if(seq==1){
	      				axSuccess("病种库Excel导入成功",function(){
							window.location.reload();
						});
	      			}else{
	      				axSuccess("产品相关病种Excel导入成功",function(){
							window.location.reload();
						});
	      			}
	      		}else{
	      			if(xco.getCode()==-2){
	      				var list = xco.getXCOListValue("list");
	      				var product_no="";
	      				for(var i=0;i<list.length;i++){
	      					product_no+=list[i]+",";
	      				}
	      				$("#none_no").val(product_no.substring(0,product_no.length-1));
	      				$("#none_no_div").css("display","");
	      				axError("产品编号不存在！");
	      			}else if(xco.getCode()==-3){
	      				var list = xco.getXCOListValue("list");
	      				var product_name="";
	      				for(var i=0;i<list.length;i++){
	      					product_name+=list[i]+",";
	      				}
	      				$("#none_name").val(product_name.substring(0,product_name.length-1));
	      				$("#none_name_div").css("display","");
	      				axError("产品编号不能为空！");
	      			}else if(xco.getCode()==-4){
	      				var list = xco.getXCOListValue("list");
	      				var product_no="";
	      				for(var i=0;i<list.length;i++){
	      					product_no+=list[i]+",";
	      				}
	      				$("#repeat_no").val(product_no.substring(0,product_no.length-1));
	      				$("#repeat_no_div").css("display","");
	      				axError("存在重复的产品编号！");
	      			}else{
	      				axError("导入失败！");
	      			}
	      		}
	      	}
        })
	}
</script>
