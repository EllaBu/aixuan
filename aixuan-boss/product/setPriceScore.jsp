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
<title>产品打分</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../product/productList.jsp">产品总表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>产品打分<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>评分维护</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>产品编号</label>
								<span id="productNo"></span>
								<!-- <input type="text" id="productNo" class="form-control" name="productNo" disabled/> -->
							</div>
							<div class="from-group mar-t-15">
								<label>产品名称</label>
								<span id="productName"></span>
								<!-- <input type="text" id="productName" class="form-control" name="productName" disabled/> -->
							</div>
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 id="msg" style="margin-left:120px;color:red;"></h5>
							<div id="listgroup">
								
                           </div>
							<div class="from-group mar-t-15"
								style="position: relative;top:20px;">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit"id="addProductScore">确定</button>
								<button class="btn btn-info mar-r-15"  id="back">返回</button>
								<button class="btn mar-r-15" type="submit" id="multipleScore">生成综合分</button>
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
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$("#msg").hide();
	$("#errMsg").hide();
	$("#succMsg").hide();
	var productNo = getURLparamEncoder("productNo");//产品编号
	var productName = getURLparamEncoder("productName");//产品名称
	var productId = getURLparamEncoder("productId");//产品id
	$("#productNo").text(productNo);
	$("#productName").text(productName);
	
	getItemListByProductNo();
	
	//由产品编号获取该产品编号下的二级分类下的所有评分项
	function getItemListByProductNo(){
		var xco = new XCO();
		xco.setStringValue("product_no",productNo);
		var options = {
			url : "/product/getItemListByProductNo.xco",
			data : xco,
			success : getItemListByProductNoCallBack
		};
		
		$.doXcoRequest(options);
	}
	
	//由产品编号获取该产品编号下的二级分类下的所有评分项成功回调
	function getItemListByProductNoCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			var len = data.length;
			if(len == 0){
				$("#msg").show();
				$("#msg").text("请设置该产品下的评分项占比");
			}else{
				var html = "";
				var sisId = 0;
				var pssId = 0;
				var inputId = "";
				var inputValue = 0;
				
				for(var i=0;i<len;i++){
					sisId = data[i].getLongValue("score_item_id");
					pssId = data[i].getLongValue("pss_id");
					//没有打分
					if(typeof pssId == "undefined"){
						pssId = 0;
					};
					inputValue = data[i].getLongValue("score_item_value");
					if(typeof inputValue == "undefined"){
						inputValue = '';
					}
					if(inputValue != '' && inputValue > 0){
						inputValue = parseFloat(inputValue/scoreRatio);
					}
					if(sisId == 5){
						inputId = "dutyRatio";
					}else if(sisId == 6){
						inputId = "inRatio";
					}else if(sisId == 7){
						inputId = "hisRatio";
					}else if(sisId == 8){
						inputId = "lowRatio";
					}else if(sisId == 9){
						inputId = "feeRatio";
					}else if(sisId == 10){
						inputId = "illRatio";
					}
					html += "<div class=\"from-group mar-t-15\">";
					html += "	<label><span class=\"font-red\">*</span>"+data[i].getStringValue("score_item_name")+"分</label>";
					html += "	<input type=\"text\" class=\"form-control\" id=\""+inputId+"\" name=\""+inputId+"\" data-id2=\""+sisId+"\" data-id=\""+pssId+"\" value=\""+inputValue+"\" onkeyup=\"clearNoNum(this)\">";
					html += "</div>";
				}
				document.getElementById('listgroup').innerHTML = html;
			}
		}
	}
	/*返回*/
	$("#back").click(function(){	
		history.go(-1);
	})
	
	
	//添加按钮点击事件监听
	$("#addProductScore").click(function(){
		var dataXco = new XCO();
		var dataList = new Array();
		
		/* 操作责任分 */
		var dutyRatioXco = new XCO();
		var dutyRatio = $("#dutyRatio").val();
		if(dutyRatio){
			if(getNum(dutyRatio)){
				dutyRatioXco.setLongValue("sis_id",$("#dutyRatio").attr("data-id2"));
				dutyRatioXco.setLongValue("pss_id",$("#dutyRatio").attr("data-id"));
				dutyRatioXco.setLongValue("product_id",productId);
				dutyRatioXco.setLongValue("score_item_value",parseInt(dutyRatio*scoreRatio));
				dataList.push(dutyRatioXco);
			}else{
				axError("责任分请输入数字");
				$("#dutyRatio").focus();
				return;
			}
		}else{
			if(typeof dutyRatio != "undefined"){
				axError("请输入责任分");
				$("#dutyRatio").focus();
				return;
			}
			
		}
		/* 操作内部收益率分 */
		var inRatioXco = new XCO();
		var inRatio = $("#inRatio").val();
		if(inRatio){
			if(getNum(inRatio)){
				inRatioXco.setLongValue("sis_id",$("#inRatio").attr("data-id2"));
				inRatioXco.setLongValue("pss_id",$("#inRatio").attr("data-id"));
				inRatioXco.setLongValue("product_id",productId);
				inRatioXco.setLongValue("score_item_value",parseInt(inRatio*scoreRatio));
				dataList.push(inRatioXco);
			}else{
				axError("操作内部收益率分请输入数字");
				$("#inRatio").focus();
				return;
			}
		}else {
			if(typeof inRatio != "undefined"){
				axError("请输入操作内部收益率分");
				$("#inRatio").focus();
				return;
			}
		}
		/* 操作历史收益率分 */
		var hisRatioXco = new XCO();
		var hisRatio = $("#hisRatio").val();
		if(hisRatio){
			if(getNum(hisRatio)){
				hisRatioXco.setLongValue("sis_id",$("#hisRatio").attr("data-id2"));
				hisRatioXco.setLongValue("pss_id",$("#hisRatio").attr("data-id"));
				hisRatioXco.setLongValue("product_id",productId);
				hisRatioXco.setLongValue("score_item_value",parseInt(hisRatio*scoreRatio));
				dataList.push(hisRatioXco);
			}else{
				axError("操作内部收益率分请输入数字");
				$("#hisRatio").focus();
				return;
			}
			
		}else{
			if(typeof hisRatio != "undefined"){
				axError("请输入操作历史收益率分");
				$("#hisRatio").focus();
				return;
			}
			
		}
		/* 操作最低保证利率分 */
		var lowRatioXco = new XCO();
		var lowRatio = $("#lowRatio").val();
		if(lowRatio){
			if(getNum(lowRatio)){
				lowRatioXco.setLongValue("sis_id",$("#lowRatio").attr("data-id2"));
				lowRatioXco.setLongValue("pss_id",$("#lowRatio").attr("data-id"));
				lowRatioXco.setLongValue("product_id",productId);
				lowRatioXco.setLongValue("score_item_value",parseInt(lowRatio*scoreRatio));
				dataList.push(lowRatioXco);
			}else{
				axError("操作最低保证利率分请输入数字");
				$("#lowRatio").focus();
				return;
			}
		}else{
			if(typeof lowRatio != "undefined"){
				axError("请输入操作最低保证利率分");
				$("#lowRatio").focus();
				return;
			}
		}
		/* 操作费用率分 */
		var feeRatioXco = new XCO();
		var feeRatio = $("#feeRatio").val();
		if(feeRatio){
			if(getNum(feeRatio)){
				feeRatioXco.setLongValue("sis_id",$("#feeRatio").attr("data-id2"));
				feeRatioXco.setLongValue("pss_id",$("#feeRatio").attr("data-id"));
				feeRatioXco.setLongValue("product_id",productId);
				feeRatioXco.setLongValue("score_item_value",parseInt(feeRatio*scoreRatio));
				dataList.push(feeRatioXco);
			}else{
				axError("操作费用率分请输入数字");
				$("#feeRatio").focus();
				return;
			}
			
		}else{
			if(typeof feeRatio != "undefined"){
				axError("请输入操作费用率分");
				$("#feeRatio").focus();
				return;
			}
			
		}
		/* 操作病种分 */
		var illRatioXco = new XCO();
		var illRatio = $("#illRatio").val();
		if(illRatio){
			if(getNum(illRatio)){
				illRatioXco.setLongValue("sis_id",$("#illRatio").attr("data-id2"));
				illRatioXco.setLongValue("pss_id",$("#illRatio").attr("data-id"));
				illRatioXco.setLongValue("product_id",productId);
				illRatioXco.setLongValue("score_item_value",parseInt(illRatio*scoreRatio));
				dataList.push(illRatioXco);
			}else{
				axError("操作病种分请输入数字");
				$("#illRatio").focus();
				return;
			}
		}else{
			if(typeof illRatio != "undefined"){
				axError("请输入操作病种分");
				$("#illRatio").focus();
				return;
			}
		}
		//alert(dataList);
		//dataXco.setLongValue("product_no",productNo);
		dataXco.setLongValue("product_id",productId);
		dataXco.setStringValue("sys_op_log","产品打分-编辑："+$("#productNo").text());
		dataXco.setXCOListValue("xcolist", dataList);
		if(dataList.length == 0){
			axError("该产品评分至少要有一项评分");
			return;
		}else{
			var options = {
				url : "/product/updateItemScoreList.xco",
				data : dataXco,
				success : function(data){
					if(data.getCode()!=0){
						axError(data.getMessage());
					}else{
						axSuccess("保存成功！",function(){
							//location.href="../product/productList.jsp";
							window.location.reload();
						});
					}
				}
			};
			axConfirm("确定保存打分吗?",function(){
				$.doXcoRequest(options);
				layer.close(layer.index);
			})
		}
	});
	
	
	function clearNoNum(obj){ 
	    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
	    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
	    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
	    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
	    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
	        obj.value= parseFloat(obj.value); 
	    } 
		var dutyRatio = $("#dutyRatio").val();
		var inRatio = $("#inRatio").val();
		var hisRatio = $("#hisRatio").val();
		var lowRatio = $("#lowRatio").val();
		var feeRatio = $("#feeRatio").val();
		var illRatio = $("#illRatio").val();
	}

	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		//location.href="../organization/orgScoreRatioList.jsp";
		window.history.go(-1);
	})

	/* 生成综合分 */
	$("#multipleScore").click(function(){
		var xco = new XCO();
		xco.setLongValue("productId", productId);
		xco.setStringValue("productNo", productNo);
		
		var options = {
			url : "/product/getMultipleScore.xco",
			data : xco,
			success : getMultipleScoreCallBack
		};
		axConfirm("确定生成综合分吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
	
	//生成综合分成功回调
	function getMultipleScoreCallBack(data){
		data = data.getData();
		if(data.getCode() == -1){
			$("#errMsg").show();
		}else if(data.getXCOListValue("resultList").length > 0){
			$("#errMsg").show();
	    	var _dataList = data.getXCOListValue("resultList");
			if(_dataList.length > 0){
     			var str = "";
     			for(var i=0;i<_dataList.length;i++){
     				str+="<tr><td>"+_dataList[i].getStringValue("msg")+"</td></tr>"
     			}
     			document.getElementById("table_content").innerHTML = str;
			}
		}else{
			//var _dataList = data.getXCOListValue("resultList");
			$("#succMsg").show();
			$("#xmlid").html("处理结果:处理成功!<span style=\"margin-left:20px;\"><a href=\"../task/taskList.jsp\">查看任务</span>");
			$("#xmlid").css("color","green"); 
		}
	}
	
	/*判断是否是数字*/
	function getNum(n){
		return /^\d+(\.\d+)?$/.test(n+"");
	}
</script>