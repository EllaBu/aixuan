<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "评分配比";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>修改评分</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险公司管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../organization/orgScoreRatioList.jsp">评分配比</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>修改评分<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>修改评分</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>产品类型</label>
								<span id="productType"></span>
							</div>
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;color:#46A3FF">以下为综合评分的各项指标占比，总和为100分，保存时会校验。</h5>
							<div class="from-group mar-t-15">
								<label>公司占比</label>
								<input type="text" class="form-control" id="orgRatio" name="orgRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>风控能力</label>
								<input type="text" class="form-control" id="riskRatio" name="riskRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>服务占比</label>
								<input type="text" class="form-control" id="servRatio" name="servRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>价格占比</label>
								<input type="text" class="form-control" id="priceRatio" name="priceRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>责任占比</label>
								<input type="text" class="form-control" id="dutyRatio" name="dutyRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>内部收益率</label>
								<input type="text" class="form-control" id="inRatio" name="inRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>历史收益率</label>
								<input type="text" class="form-control" id="hisRatio" name="hisRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>最低保证利率</label>
								<input type="text" class="form-control" id="lowRatio" name="lowRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>费用率</label>
								<input type="text" class="form-control" id="feeRatio" name="feeRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>病种</label>
								<input type="text" class="form-control" id="illRatio" name="illRatio" onkeyup="clearNoNum(this)"><span style="margin-left:10px;">%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>目前合计</label>
								<span style="font-size:14px;color:red;" id="out">0</span>
							</div>
							<div class="from-group mar-t-15"
								style="position: relative;top:20px;">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit"id="updateScoreRatio">保存</button>
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
<script type="text/javascript">
	
	//从评分管理列表传递过来的用户org_no
	var seriesNo = getURLparamEncoder("seriesNo");
	var seriesName = getURLparamEncoder("seriesName");
	
	//初始化二级名称
	$("#productType").text(seriesName);
	
	getOrgScoreRatioBySeriesNo()
	
	/*根据 产品编号 查询出公司分比例 */
	function getOrgScoreRatioBySeriesNo(){
		var xco = new XCO();
		xco.setLongValue("series_no",seriesNo);
		var options = {
			url : "/org/getOrgScoreRatioBySeriesNo.xco",
			data : xco,
			success : getOrgScoreRatioBySeriesNoCallBack
		};
		
		$.doXcoRequest(options);
	} 
	/* 查询 出的结果 渲染 */
	function getOrgScoreRatioBySeriesNoCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			var out = 0;
			for(var i=0;i<data.length;i++){
				var scoreItemId = data[i].getLongValue("score_item_id");
				var ratio = "";
				var t_ratio = data[i].getLongValue("ratio");
				if(t_ratio != 0){
					ratio = t_ratio/scoreRatio;
					out += ratio;
				};
				if(scoreItemId == 1){
					$("#orgRatio").val(ratio);
				}
				if(scoreItemId == 2){
					$("#riskRatio").val(ratio);
				}
				if(scoreItemId == 3){
					$("#servRatio").val(ratio);
				}
				if(scoreItemId == 4){
					$("#priceRatio").val(ratio);
				}
				if(scoreItemId == 5){
					$("#dutyRatio").val(ratio);
				}
				if(scoreItemId == 6){
					$("#inRatio").val(ratio);
				}
				if(scoreItemId == 7){
					$("#hisRatio").val(ratio);
				}
				if(scoreItemId == 8){
					$("#lowRatio").val(ratio);
				}
				if(scoreItemId == 9){
					$("#feeRatio").val(ratio);
				}
				if(scoreItemId == 10){
					$("#illRatio").val(ratio);
				}
			}
			$("#out").text(out);
		}
	}
	
	//添加按钮点击事件监听
	$("#updateScoreRatio").click(function(){
		var dataXco = new XCO();
		var dataList = new Array();
		
		/* 操作公司分 */
		var orgRatioXco = new XCO();
		var orgRatio = $("#orgRatio").val();
		if(orgRatio){
			orgRatioXco.setLongValue("series_no",seriesNo);
			orgRatioXco.setLongValue("score_item_id",1);
			orgRatioXco.setLongValue("ratio",parseInt(orgRatio*scoreRatio));
			dataList.push(orgRatioXco);
		}else{
			axError("请输入公司占比");
			$("#orgRatio").focus();
			return;
		}
		/* 操作分控分 */
		var riskRatioXco = new XCO();
		var riskRatio = $("#riskRatio").val();
		if(riskRatio){
			riskRatioXco.setLongValue("series_no",seriesNo);
			riskRatioXco.setLongValue("score_item_id",2);
			riskRatioXco.setLongValue("ratio",parseInt(riskRatio*scoreRatio));
			dataList.push(riskRatioXco);
		}else{
			axError("请输入风控能力");
			$("#riskRatio").focus();
			return;
		}
		/* 操作服务分 */
		var servRatioXco = new XCO();
		var servRatio = $("#servRatio").val();
		if(servRatio){
			servRatioXco.setLongValue("series_no",seriesNo);
			servRatioXco.setLongValue("score_item_id",3);
			servRatioXco.setLongValue("ratio",parseInt(servRatio*scoreRatio));
			dataList.push(servRatioXco);
		}else{
			axError("请输入服务占比");
			$("#servRatio").focus();
			return;
		}
		
		var out = $("#out").text();
		var result =  parseInt(out*scoreRatio);
		if(result != 1000000){
			axError("所有项的和不为100,请重新填写");
			//$("#servRatio").focus();
			return;
		}
		
		/* 操作价格分 */
		var priceRatioXco = new XCO();
		priceRatioXco.setLongValue("series_no",seriesNo);
		var priceRatio = $("#priceRatio").val();
		if(priceRatio){
			priceRatioXco.setLongValue("score_item_id",4);
			priceRatioXco.setLongValue("ratio",parseInt(priceRatio*scoreRatio));
			dataList.push(priceRatioXco);
		}else{
			priceRatioXco.setLongValue("score_item_id",4);
			priceRatioXco.setLongValue("ratio",0);
			dataList.push(priceRatioXco);
		}
		/* 操作责任分 */
		var dutyRatioXco = new XCO();
		dutyRatioXco.setLongValue("series_no",seriesNo);
		var dutyRatio = $("#dutyRatio").val();
		if(dutyRatio){
			dutyRatioXco.setLongValue("score_item_id",5);
			dutyRatioXco.setLongValue("ratio",parseInt(dutyRatio*scoreRatio));
			dataList.push(dutyRatioXco);
		}else{
			dutyRatioXco.setLongValue("score_item_id",5);
			dutyRatioXco.setLongValue("ratio",0);
			dataList.push(dutyRatioXco);
		}
		/* 操作内部收益率分 */
		var inRatioXco = new XCO();
		inRatioXco.setLongValue("series_no",seriesNo);
		var inRatio = $("#inRatio").val();
		if(inRatio){
			inRatioXco.setLongValue("score_item_id",6);
			inRatioXco.setLongValue("ratio",parseInt(inRatio*scoreRatio));
			dataList.push(inRatioXco);
		}else{
			inRatioXco.setLongValue("score_item_id",6);
			inRatioXco.setLongValue("ratio",0);
			dataList.push(inRatioXco);
		}
		/* 操作历史收益率分 */
		var hisRatioXco = new XCO();
		hisRatioXco.setLongValue("series_no",seriesNo);
		var hisRatio = $("#hisRatio").val();
		if(hisRatio){
			hisRatioXco.setLongValue("score_item_id",7);
			hisRatioXco.setLongValue("ratio",parseInt(hisRatio*scoreRatio));
			dataList.push(hisRatioXco);
		}else{
			hisRatioXco.setLongValue("score_item_id",7);
			hisRatioXco.setLongValue("ratio",0);
			dataList.push(hisRatioXco);
		}
		/* 操作最低保证利率分 */
		var lowRatioXco = new XCO();
		lowRatioXco.setLongValue("series_no",seriesNo);
		var lowRatio = $("#lowRatio").val();
		if(lowRatio){
			lowRatioXco.setLongValue("score_item_id",8);
			lowRatioXco.setLongValue("ratio",parseInt(lowRatio*scoreRatio));
			dataList.push(lowRatioXco);
		}else{
			lowRatioXco.setLongValue("score_item_id",8);
			lowRatioXco.setLongValue("ratio",0);
			dataList.push(lowRatioXco);
		}
		/* 操作费用率分 */
		var feeRatioXco = new XCO();
		feeRatioXco.setLongValue("series_no",seriesNo);
		var feeRatio = $("#feeRatio").val();
		if(feeRatio){
			feeRatioXco.setLongValue("score_item_id",9);
			feeRatioXco.setLongValue("ratio",parseInt(feeRatio*scoreRatio));
			dataList.push(feeRatioXco);
		}else{
			feeRatioXco.setLongValue("score_item_id",9);
			feeRatioXco.setLongValue("ratio",0);
			dataList.push(feeRatioXco);
		}
		/* 操作病种分 */
		var illRatioXco = new XCO();
		illRatioXco.setLongValue("series_no",seriesNo);
		var illRatio = $("#illRatio").val();
		if(illRatio){
			illRatioXco.setLongValue("score_item_id",10);
			illRatioXco.setLongValue("ratio",parseInt(illRatio*scoreRatio));
			dataList.push(illRatioXco);
		}else{
			illRatioXco.setLongValue("score_item_id",10);
			illRatioXco.setLongValue("ratio",0);
			dataList.push(illRatioXco);
		}
		dataXco.setLongValue("series_no",seriesNo);
		dataXco.setStringValue("sys_op_log","编辑产品二级分类配比项占比-编辑："+$("#productType").text());
		dataXco.setXCOListValue("xcolist", dataList);
		
		var options = {
			url : "/org/updateOrgScoreRatio.xco",
			data : dataXco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../organization/orgScoreRatioList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存配比吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	
	
	function clearNoNum(obj){ 
	    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
	    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
	    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
	    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
	    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
	        obj.value= parseFloat(obj.value); 
	    } 
	    
	    var orgRatio = $("#orgRatio").val();
		var riskRatio = $("#riskRatio").val();
		var servRatio = $("#servRatio").val();
		var priceRatio = $("#priceRatio").val();
		var dutyRatio = $("#dutyRatio").val();
		var inRatio = $("#inRatio").val();
		var hisRatio = $("#hisRatio").val();
		var lowRatio = $("#lowRatio").val();
		var feeRatio = $("#feeRatio").val();
		var illRatio = $("#illRatio").val();
		
		var total = 0;
		
		if(orgRatio){
			total += parseInt(orgRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(riskRatio){
			total += parseInt(riskRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(servRatio){
			total += parseInt(servRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(priceRatio){
			total += parseInt(priceRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(dutyRatio){
			total += parseInt(dutyRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(inRatio){
			total += parseInt(inRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(lowRatio){
			total += parseInt(lowRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(hisRatio){
			total += parseInt(hisRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(feeRatio){
			total += parseInt(feeRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		if(illRatio){
			total += parseInt(illRatio*scoreRatio);
		}else{
			total += 0;
		}
		
		$("#out").text(total/scoreRatio);
	}

	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../organization/orgScoreRatioList.jsp";
	})
</script>