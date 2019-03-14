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
<title>添加公司</title>
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
				<li><i class="icon-user-md"></i><a>保险公司管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../organization/orgList.jsp">公司管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>添加公司<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>添加公司</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>公司全称</label><input type="text" class="form-control"
									id="fullName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>公司简称</label><input type="text" class="form-control"
									id="name" name="title">
							</div>
							<div class="from-group mar-t-15"
								style="position:relative; border:0px solid #000; height:180px">
								<label><span class="font-red">*</span>公司logo</label> <input type="hidden" id="imgUrl"
									name="imgUrl">
								<div
									style="position:absolute; left:235px; top:0px; width:180px; height:180px;">
									<img alt="" src="../image/add.png" id="imgUpload"
										style="position:absolute; left:0px; top:0px; width:180px; height:180px;opacity: 1;" />
									<form name="upload" action="/uploadImage.xco" method="post"
										enctype="multipart/form-data" style="margin-bottom:10px;">
										<input style="width:180px;height:180px; opacity: 0;"
											type="file" name="file" id="fileField"
											onchange="select1(this);" value="选择文件" alt="点击选择文件" />
									</form>
									<label style="width: 180px; text-align: left !important; color:red;">注意：上传图片最大20M</label>
									<label id="fileName" style="width: 180px; text-align: center;"></label>
									<br class="clear" />
								</div>
							</div>
							<div class="from-group mar-t-15"
								style="position: relative;top:20px;">
								<label style="position: relative;bottom:48px;"><span class="font-red">*</span>公司介绍</label>
								<!-- <textarea class="form-control" rows="6" id="content" style="resize:none;width:360px;overflow-x:hidden"></textarea> -->
								<textarea class="form-control" style="resize:none;width:360px;overflow-x:hidden" cols="40" rows="5" id="content"
				                    name="content" maxlength="1000" value="" onkeyup="this.value=this.value.substring(0, 1000)" placeholder="最多可输入1000字"></textarea>
							</div>
							<div class="from-group" style="margin-top:20px;">
								<label></label>
								<span id="text-count2" value="">0</span>/1000
							</div>
							<div class="from-group mar-t-15"
								style="position: relative;top:20px;">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit"
									id="addOrg">添加</button>
								<button class="btn mar-l-15" type="submit" id="exit">返回</button>
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
	$('#content').keyup(function() {
        var len=this.value.length;
        $('#text-count2').text(len);
    });
    
	$("#fileName").hide();
	
	function select1(e){
		if(e.value){
			var fileField = $("#fileField").val();
			var index = fileField.indexOf(".");
			var suffix = fileField.substring(index+1,fileField.length);
			if(!isZip(fileField)){
				return;
			}
			var cover = document.getElementById("cover"); 
			var covershow = document.getElementById("coverShow"); 
			cover.style.display = 'block'; 
			covershow.style.display = 'block'; 
			$("form[name='upload']").ajaxSubmit({
		    	dataType:'xml',
		      	success:function(data){
		      		$("#fileField").val("");
		        	var xco=new XCO();
		        	xco.fromXML0(data);
	      			cover.style.display = 'none'; 
					covershow.style.display = 'none';
		      		if(xco.getCode() == 0){
						var _dataList = xco.getXCOListValue("updateResult");
						var imgUrl = _dataList[0].getStringValue("url");
						var imgName = _dataList[0].getStringValue("fileName");
						var n_url = fileurl+imgUrl;
						$("#fileName").show();
						$("#fileName").html(imgName);
						$("#imgUrl").val(imgUrl);
						//$("#img_upload").css("background-image","url(" + n_url + ")");
						$("#imgUpload").attr("src",n_url);
		      		}else{
		      			axError("上传失败!!");
		      		}
		      	}
	        })
		}
	}
	
	//判断上传文件格式是否满足条件
	function isZip(fileName) {
		if (fileName != null && fileName != "") {
			//lastIndexOf如果没有搜索到则返回为-1
			if (fileName.lastIndexOf(".") != -1) {
				var fileType = (fileName.substring(
						fileName.lastIndexOf(".") + 1, fileName.length))
						.toLowerCase();
				var suppotFile = new Array();
				suppotFile[0] = "jpg";
				suppotFile[1] = "png";
				for ( var i = 0; i < suppotFile.length; i++) {
					if (suppotFile[i] == fileType) {
						return true;
					} else {
						continue;
					}
				}
				axError("文件类型不合法!");
				//layer.msg("文件类型不合法!", {time: times, icon:no});
				return false;
			} else {
				axError("文件类型不合法!");
				//layer.msg("文件类型不合法!", {time: times, icon:no});
				return false;
			}
		}
	}

	
	//添加按钮点击事件监听
	$("#addOrg").click(function(){
		var xco = new XCO();
		
		var fullName = $("#fullName").val();
		if(fullName){
			xco.setStringValue("full_name",fullName);
		}else{
			axError("请输入公司全称");
			return;
		}
		
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}else{
			axError("请输入公司简称");
			return;
		}
		
		var imgUrl = $("#imgUrl").val();
		if(imgUrl){
			xco.setStringValue("img_url",imgUrl);
		}else{
			axError("请上传公司logo");
			return;
		}
		
		var content = $("#content").val();
		if(content){
			xco.setStringValue("content",content);
		}else{
			axError("请输入公司介绍");
			return;
		}
		//console.log(xco);
		xco.setStringValue("sys_op_log","新增公司-新增："+name);
		var options = {
			url : "/org/addOrg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("新增成功！",function(){
						location.href="../organization/orgList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加公司吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});

	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../organization/orgList.jsp";
	})
</script>