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
<title>新增产品</title>
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
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><a href="../product/productList.jsp">产品总表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>新增产品<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header crumbs-nav">
				<h1>新增产品</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">合同信息</h4>
						</div>
						<div class="form-inline form-add1 bord1dd">
							
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>所属公司</label>
								<input type="text" class="form-control" id="orgName" onblur="getProductNo();">
								<input type="hidden" class="form-control" id="orgNo">
							</div>
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>合同类型</label>
								<select class="form-control" id="contractType">
									<option value="0">主合同</option>
									<option value="2">组合产品</option>
									<option value="1">附加合同</option>
								</select> 
							</div>
							<div id="contract">
								<div class="from-group mar-t-15">
									<label><span class="font-red">*</span>合同名称</label>
									<input type="text" class="form-control" id="contractName" oninput="inputFNameAndPName(this)" name="title" onblur="getProductNo();">
								</div>
								<div class="from-group mar-t-15" style="position:relative;">
									<label></label> 
									<input type="hidden" id="file_url" name="file_url">
									<div style="position:absolute; left:225px; top:0px;">
										<button id="file_upload" class="btn btn-info" style="position:absolute; left:0px; top:0px;z-index:2;width:80px;">上传合同</button>
										<form name="upload" action="/uploadProductPdf.xco" method="post" enctype="multipart/form-data" style="margin-bottom:10px;">
											<input style="opacity: 0;z-index:0;width:0px;height:0px;position: absolute;" type="file" name="file" id="fileField" onchange="select1(this);" value="选择文件" alt="点击选择文件" />
										</form>
										<span id="file_name" style="position: absolute;left:95px;top:5px;width: 300px;"></span>
									</div>
								</div>
							</div>
							<div id="product" style="display: none;">
								<div class="from-group mar-t-15">
									<label><span class="font-red">*</span>主产品编号</label>
									<input type="text" class="form-control" id="mainNo" name="title" onblur="getProductNo();">
								</div>
								<div class="from-group mar-t-15" style="line-height: 30px;position: relative;">
									<label style="display: inline-block;position: absolute;top:6px;">子产品编号</label>
									<div style="display: inline-block;width:70%;position: relative;left: 224px;">
										<button id="subProductNo" class="btn btn-info" onclick="showSubProductNoDalog()">+</button>
									</div>
								</div>
							</div>
							<div class="from-group mar-t-15">
								<label class="mar-t-15">子计划名</label>
								<input type="text" class="form-control mar-t-15" id="combPlanName" oninput="inputFNameAndPName2(this)" name="title" onblur="getProductNo();">
							</div>	
						</div>
					</div>
				</div>
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">名称信息</h4>
						</div>
						<div class="form-inline form-add1 bord1dd">
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>家族名称</label>
								<input type="text" class="form-control" id="familyName1" name="title">
								<span id="familyName2" style="display: none;"></span>
							</div>
							
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>产品全称</label>
								<input type="text" class="form-control" id="name" name="title">
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">基础信息</h4>
						</div>
						<div class="form-inline form-add1 bord1dd">
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>产品编号</label>
								<input type="text" class="form-control" id="productNo" name="title">
							</div>
							
							<div class="from-group mar-t-15">
								<label><span class="font-red">*</span>是否拆解</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="icdMark" value="1"/>
									<span class="lbl">是</span>
								</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="icdMark" value="0" checked="checked"/>
									<span class="lbl">否</span>
								</label>
							</div>
							
							<div class="from-group mar-t-15" style="line-height: 30px;">
								<label><span class="font-red"></span>是否在售</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="onSale" value="1"/>
									<span class="lbl">是</span>
								</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="onSale" value="0" checked="checked"/>
									<span class="lbl">否</span>
								</label>
							</div>
							<div class="from-group mar-t-15" style="line-height: 30px;">
								<label><span class="font-red"></span>销售链接</label>
								<input type="text" class="form-control" id="salesUrl" placeholder="请输入销售链接"/>
							</div>
							<div class="from-group mar-t-15" style="line-height: 30px;">
								<label><span class="font-red"></span>销售图片</label>
								<input type="text" class="form-control" id="imgUrl" placeholder="请输入销售图片链接"/>
							</div>
							<div class="from-group mar-t-15">
								<label id="type_span">产品类型</label>
								<select id="typeId" class="form-control" onchange="initTwoLevelType()"></select>
								<select id="subTypeId" class="form-control"></select>
							</div>
							<div class="from-group mar-t-15">
							</div>
							<div class="from-group mar-t-15" style="line-height: 30px;position: relative;">
								<label style="display: inline-block;position: absolute;top:6px;">产品标签</label>
								<div style="display: inline-block;width:70%;position: relative;left: 224px;">
									<button id="labelNo" class="btn btn-info" onclick="labelNoDalog()">+</button>
								</div>
							</div>
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn btn-success mar-r-15" type="submit" id="addProduct">添加</button>
							<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
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

	function inputFNameAndPName(e){
		$('#familyName1').val(e.value);
		$('#name').val(e.value);
	}

	function inputFNameAndPName2(e){
		var contractType = $("#contractType").val();
		if(contractType==2){
			$('#name').val($('#familyName2').text()+e.value)
		}else{
			$('#name').val($('#familyName1').val()+e.value)
		}
	}
	//上传合同事件绑定
	$("#file_upload").click(function(){
		$("#fileField").click();
	})
	
	//是否销售事件显示隐藏销售链接
	//$("input[name='onSale']").change(function(){
	//	if($(this).val()==1){
	//		$("#salesUrl").show();
	//	}else{
	//		$("#salesUrl").hide();
	//	}
	//})

	//是否拆解事件显示隐藏销售链接
	$("input[name='icdMark']").change(function(){
		var html1 = '<span class="font-red">*</span>产品类型';
		var html2 = '产品类型';
		if($(this).val()==1){
			$("#type_span").html(html1);
		}else{
			$("#type_span").html(html2);
		}
	})
	
	/*初始化一级分类*/
	initSelectOption("typeId","/dic/oneLevelSeriesList.xco","series_no","series_name");
	/* 初始化二级分类 */
	function initTwoLevelType(){
		var xco = new XCO();
		xco.setLongValue("fId", $("#typeId").val());
		xco.setIntegerValue("level", 2);
		initSelectOption2(xco,"subTypeId","/dic/oneLevelSeriesList.xco","series_no","series_name");
	}
	
	//合同类型变化导致输入框的变化
	$("#contractType").change(function(){
		if($(this).val()==2){
			$("#contract").hide();
			$("#product").show();
			$("#familyName1").hide();
			$("#familyName2").show();
		}else{
			$("#contract").show();
			$("#product").hide();
			$("#familyName1").show();
			$("#familyName2").hide();
		}
	})
	
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
						var url = _dataList[0].getStringValue("url");
						var fileName = _dataList[0].getStringValue("fileName");
						$("#file_name").text(fileName);
						$("#file_url").val(url);
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
				suppotFile[0] = "pdf";
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
	
	//子产品选择弹窗
	function showSubProductNoDalog(){
		layer.open({
			type: 1,  
	        title:'子产品编号',  
	        skin:'layui-layer-rim',  
	        area:['450px', 'auto'],
	        zIndex: 13,
	        content: 
        	 '<div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'  
	            +'<div class="input-group" style="position: relative;">'  
		            +'<lable style="position: relative;bottom:15px;left:15px;width:15%;">子产品编号</lable>'  
		            +'<input id="subProductNoForDalog" type="text" class="form-control" style="margin-left:25px;width:75%;">'  
		            +'<input id="subProductNameForDalog" type="hidden">'  
	            +'</div>'  
            +'</div>'  
	        ,  
	        success: function(index,layero){
	        	/* 输入框自动提示控件 */
	        	$.setAutoComplete({
	        		ainId:"#subProductNoForDalog",//搜索框ID
	        		url:"/product/getProductListForAssociation.xco",//请求地址
	        		isAutoFocus:false,//是否需要默认选中第一项。
	        		setXCO:function(event){//传参
	        			//$("#subProductNoForDalog").val("");
	        			var xco = new XCO();
	        			xco.setIntegerValue("contractType",1);
	        			xco.setStringValue("inputValue",$(event).val());
	        			return xco;
	        		},
	        		callback:function(item){//需要的参数 item是list里单个xco对象
	        			var result={//这里的值会在下边用的
	        				lable : item.getLongValue("product_no"),
	        				value : "子产品编号："+item.getLongValue("product_no")+"　　子产品名称："+item.getStringValue("name"),
	        				name : item.getStringValue("name")
	        			}
	        			return result;
	        		},
	        		focus:function(event,item){//item相当于callback里的result
	        			$("#subProductNameForDalog").val(item.name);
	        			$("#subProductNoForDalog").val(item.lable);
	        		},
	        		select : function(event, item) {//item相当于callback里的result
	        			$("#subProductNameForDalog").val(item.name);
	        			$("#subProductNoForDalog").val(item.lable);
	        		}
	        	});
	        },
	        btn:['确定','取消'],  
	        btn1: function (index,layero) {  
	        	if($("#subProductNoForDalog").val()){
	        		var subProductNoLabel = '<span data-sub="'+$("#subProductNoForDalog").val()+'" class="sub-pro-no mar-r-15 label label-success label-white middle">'+$("#subProductNameForDalog").val()+'&nbsp;&nbsp;<a style="color: white;" onclick="delLabel(this);">x</a></span>';//子产品标签
		        	$("#subProductNo").before(subProductNoLabel);
		        	layer.close(index);  
	        	}
	        },  
	        btn2:function (index,layero) {  
	             layer.close(index);  
	        },  
			scrollbar:false
		});
	}
	
	/* 标签弹窗 */
	function labelNoDalog(){
		layer.open({
			type: 1,  
	        title:'选择标签',  
	        skin:'layui-layer-rim',  
	        area:['800px', '600px'],
	        zIndex: 13,
	        content: 
            '<div class="row" style="width: 770px;  margin-left:15px; margin-top:10px;">'  
	            +'<div class="input-group scrollbar" style="margin-top:10px;overflow:auto;">'  
	           		+'<table class="table table-striped table-bordered table-hover" style="margin-top:0px;margin-bottom:0px;">' 
	       				+'<thead>' 
	       					+'<tr>' 
	       						+'<th style="width:10%;">序号</th>' 
	       						+'<th style="width:70%;">标签名称</th>' 
	       						+'<th style="width:20%;">操作</th>' 
	       					+'</tr>' 
	       				+'</thead>' 
	       				+'<tbody id="listgroup4">'
	       				+'</tbody>'
	       			+'</table>' 
	            +'</div>'  
	        +'</div>'
	        ,  
	        success: function(index,layero){
	        	var xco = new XCO();

	    		var options = {
	    			url : "/dic/getLabelsList.xco",
	    			data : xco,
	    			success : function(data){
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
	    					
	    					if(len!=0){
	    						for(var i = 0; i<len; i++){
	    							html += '<tr>';
	    							html += '	<td>'+(i+1)+'</td>';
	    							html += '	<td>'+list[i].getStringValue("name")+'</td>';
	    							html += '	<td><a href="javascript:callback('+list[i].getLongValue("label_no")+',\''+list[i].getIntegerValue("name")+'\');">使用</a></td>';
	    							html += '</tr>';
	    						}
	    						$("#listgroup4").html(html);
	    					}
	    				}
	    			}
	    		};
	    		$.doXcoRequest(options);
	        },
			scrollbar:false
		});
	}
	
	function callback(labelNo,name){
		var labelNoLabel = '<span data-label="'+labelNo+'" class="label-no mar-r-15 label label-success label-white middle">'+name+'&nbsp;&nbsp;<a style="color: white;" onclick="delLabel(this);">x</a></span>';//子产品标签
    	$("#labelNo").before(labelNoLabel);
    	layer.closeAll("page");  
	}
	
	/* 主产品编号输入框自动提示控件 */
	$.setAutoComplete({
		ainId:"#mainNo",//搜索框ID
		url:"/product/getProductListForAssociation.xco",//请求地址
		isAutoFocus:false,//是否需要默认选中第一项。
		setXCO:function(event){//传参
			var xco = new XCO();
			xco.setIntegerValue("contractType",0);
			xco.setStringValue("inputValue",$(event).val());
			return xco;
		},
		callback:function(item){//需要的参数 item是list里单个xco对象
			var result={//这里的值会在下边用的
				lable : item.getLongValue("product_no"),
				value : "主产品编号："+item.getLongValue("product_no")+"　　主产品名称："+item.getStringValue("name"),
				faName :item.getStringValue("family_name")
			}
			return result;
		},
		focus:function(event,item){//item相当于callback里的result
			$("#mainNo").val(item.lable);
			$("#familyName2").text(item.faName);
			$("#name").val(item.faName);
		},
		select : function(event, item) {//item相当于callback里的result
			$("#mainNo").val(item.lable);
			$("#familyName2").text(item.faName);
			$("#name").val(item.faName);
		}
	});
	
	/* 自动获取产品编号 */
	function getProductNo(){
		var xco = new XCO();
		
		var contractType = $("#contractType").val();
		
		if(contractType==2){
			if($("#orgNo").val()){
				xco.setLongValue("org_no", $("#orgNo").val());
			}else{
				return;
			}
			
			if($("#mainNo").val()){
				xco.setStringValue("main_no", $("#mainNo").val());
			}else{
				return;
			}
		}else{
			if($("#orgNo").val()){
				xco.setLongValue("org_no", $("#orgNo").val());
			}else{
				return;
			}
		}
		
		var options = {
			url : "/productIdService/getProductId.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					$("#productNo").val(data.getData());
				}
			}
		};
		$.doXcoRequest(options);
	}
	
	/* 公司名称输入框自动提示控件 */
	$.setAutoComplete({
		ainId:"#orgName",//搜索框ID
		url:"/org/getOrgList.xco",//请求地址
		isAutoFocus:false,//是否需要默认选中第一项。
		setXCO:function(event){//传参
			$("#orgNo").val("");
			var xco = new XCO();
			if(isNum($("#orgName").val())){
				xco.setIntegerValue("inputType",2);
			}else{
				xco.setIntegerValue("inputType",1);
			}
			xco.setStringValue("inputValue",$(event).val());
			return xco;
		},
		callback:function(item){//需要的参数 item是list里单个xco对象
			var result={//这里的值会在下边用的
				lable : item.getLongValue("org_no"),
				value : "公司编号："+item.getLongValue("org_no")+"　　公司简称："+item.getStringValue("name"),
				orgName : item.getStringValue("name")
			}
			return result;
		},
		focus:function(event,item){//item相当于callback里的result
			$("#orgNo").val(item.lable);
			$("#orgName").val(item.orgName);
		},
		select : function(event, item) {//item相当于callback里的result
			$("#orgNo").val(item.lable);
			$("#orgName").val(item.orgName);
		}
	});
	
	/* 删除label标签 */
	function delLabel(e){
		$(e).parent().remove();
	}
	
	//添加按钮点击事件监听
	$("#addProduct").click(function(){
		var xco = new XCO();
		
		var orgName = $("#orgName").val();
		var orgNo = $("#orgNo").val();
		if(orgName){
			xco.setStringValue("orgName",orgName);
			xco.setLongValue("orgNo",orgNo);
		}else{
			axError("请选择所属公司");
			return;
		}
		
		var contractType = $("#contractType").val();//合同类型

		var productNo = $("#productNo").val();
		if(productNo){
			xco.setStringValue("productNo",productNo);
		}else{
			axError("请输入产品编号");
			return;
		}
		
		var mainNo = $("#mainNo").val();//主产品编号
		xco.setIntegerValue("contractType",contractType);
		if(contractType==2){
			if (mainNo) {
				xco.setStringValue("mainNo",mainNo);
			}else{
				axError("请选择主产品ID");
				return;
			}
			var subProductNo = '';
			if($(".sub-pro-no").length!=0){
				$(".sub-pro-no").each(function(e,v){
					if(subProductNo){
						subProductNo += ","
						subProductNo += $(v).attr("data-sub");
					}else{
						subProductNo = $(v).attr("data-sub");
					}
				})
				xco.setStringValue("subProductNo",subProductNo);
			}
			var familyName2 = $("#familyName2").text();
			xco.setStringValue("familyName",familyName2);
		}else{
			var contractUrl = $("#file_url").val();
			if(contractUrl){
				xco.setStringValue("contractUrl",contractUrl);
			}else{
				axError("请上传合同");
				return;
			}
			var contractName = $("#contractName").val();
			if(contractName){
				xco.setStringValue("contractName",contractName);
			}else{
				axError("请填写合同名称");
				return;
			}
			var familyName1 = $("#familyName1").val();
			xco.setStringValue("familyName",familyName1);
			xco.setStringValue("mainNo",productNo);
		}
		
		var combPlanName = $("#combPlanName").val();
		if(combPlanName){
			xco.setStringValue("combPlanName",combPlanName);
		}
		
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}else{
			axError("请输入产品全称");
			return;
		}
		
		var icdMark = $("input[name='icdMark']:checked").val();
		xco.setIntegerValue("icdMark",icdMark);
		var onSale = $("input[name='onSale']:checked").val();
		xco.setIntegerValue("onSale",onSale);
		var salesUrl = $("#salesUrl").val();
		if(salesUrl){
			xco.setStringValue("salesUrl",salesUrl);
		}
		
		var imgUrl = $("#imgUrl").val();
		if(imgUrl){
			xco.setStringValue("imgUrl",imgUrl);
		}
		
		var typeId = $("#typeId").val();
		if(typeId!=0){
			xco.setLongValue("typeId",typeId);
		}else{
			if(icdMark==1){
				axError("请选择分类");
				return;
			}
		}
		var subTypeId = $("#subTypeId").val();
		if(subTypeId!=0&&subTypeId!=null){
			xco.setLongValue("subTypeId",subTypeId);
		}else{
			if(icdMark==1){
				axError("请选择分类");
				return;
			}
		}
		
		var labelNo = '';
		if($(".label-no").length!=0){
			$(".label-no").each(function(e,v){
				if(labelNo){
					labelNo += ","
						labelNo += $(v).attr("data-label");
				}else{
					labelNo = $(v).attr("data-label");
				}
			})
			xco.setStringValue("labelNo",labelNo);
		}
		
		xco.setStringValue("sys_op_log","新增产品-新增："+name);
		console.log(xco.toString());
		var options = {
			url : "/product/addProduct.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("新增成功！",function(){
						location.href="../product/productList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加产品吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});

	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		window.history.go(-1);
	})
	
	
	/* 合同名称输入框自动提示控件 */
	$.setAutoComplete2({
		ainId:"#contractName",//搜索框ID
		url:"/product/getProductContractNameList.xco",//请求地址
		isAutoFocus:false,//是否需要默认选中第一项。
		setXCO:function(event){//传参
			var xco = new XCO();
			xco.setStringValue("inputValue",$("#contractName").val());
			return xco;
		},
		callback:function(item){//需要的参数 item是list里单个xco对象
			var result={//这里的值会在下边用的
				lable : item.getStringValue("contract_name"),
				value : item.getStringValue("contract_name"),
			}
			return result;
		}
	});
</script>