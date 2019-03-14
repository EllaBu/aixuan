<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数据导入";
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
			<li><i class="icon-bookmark"></i><span class="divider"></span><span > 数据管理</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>数据导入</span><span class="divider"></span>
    			</li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-th-list"></i>数据导入</h1>
		</div>
		<div id="cover" style="display: none"></div>
		<div id="coverShow" style="display: none">
			<img src="/image/loaders/4.gif" />
			<p>请稍后......</p>
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入核保管理Excel文件</label>
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
									<label>规则ID</label>
									<input type="text" class="form-control" value="101" id="ruleId1" >
								</div>	
								<div class="from-group mar-t-15" id="subbutton1">
									<label></label>
									<button class="btn mar-t-15  btn-success"  onclick="sunbmitform(1)" type="reset">导入</button>
								</div>
						</div>
						
					</div>		
				</div>
			</div>
			
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入医学管理Excel文件</label>
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
								<input type="hidden" class="form-control" value="101" id="ruleId2" >
								<div class="from-group mar-t-15" id="subbutton2">
									<label></label>
									<button class="btn mar-t-15  btn-success"  onclick="sunbmitform(2)" type="reset">导入</button>
								</div>
						</div>
						
					</div>		
				</div>
			</div>
			
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;">
								<label><span class="font-red">*</span>导入爱康无结论的描述映射</label>
								<input type="text" class="form-control" id="file_name4" readonly="readonly">
								<form id="form4" action=""  method="post" enctype="multipart/form-data">
										<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
											<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
													<input style="width:88px;height:30px;" type="file" name="file"
														id="fileField4" onchange="select4(this,4);" value="选择文件"
														alt="点击选择文件" />
												<br class="clear" />
											</div>
										</div>
								</form>
								<input type="hidden" class="form-control" value="101" id="ruleId4" >
								<div class="from-group mar-t-15" id="subbutton4">
									<label></label>
									<button class="btn mar-t-15   btn-success"  onclick="sunbmitform(4)" type="reset">导入</button>
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
	function select4(e,seq){
		var xco = new XCO();
		var fileField = $("#fileField"+seq+"").val();
		$("#file_name"+seq+"").val(fileField);
		if(e.value){
			var index = fileField.lastIndexOf(".");
			var suffix = fileField.substring(index+1,fileField.length);
			if(suffix != "txt"){
				axError("请上传txt文件!");
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
		$("#form"+seq+"").attr("action","/uploadExcel.xco?ruleId="+$("#ruleId"+seq+"").val()+"&type="+(seq-1));
		$("#form"+seq+"").ajaxSubmit({
	      	success:function(data){
	      		$("#fileField"+seq+"").val("");
	        	var xco=new XCO();
	        	xco.fromXML(data);
      			cover.style.display = 'none'; 
				covershow.style.display = 'none'; 
	      		if(xco.getCode()==0){
	      			if(seq==2){
	      				axSuccess("医学管理Excel导入成功",function(){
							window.location.reload();
						});
	      			}else if(seq==4){
		      			axSuccess("文本结论Txt导入成功！",function(){
							window.location.reload();
						});	      				
	      			}else{
						axSuccess("核保管理Excel导入成功",function(){
							window.location.reload();
						});
	      			}
	      		}else{
	      			axError("导入失败！");
	      		}
	      	}
        })
	}
</script>
