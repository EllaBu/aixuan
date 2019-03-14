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
<title>产品分数列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a href="../product/productList.jsp">产品总表</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>产品分数<span class="divider"></span></li>
			</ul>
		</div>
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>产品分数</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
							<div class="form-group" style="line-height:30px;">
                           		<label class="mar-l-15 mar-t-15">投保年龄</label>
                          		<input type="text" class="form-control w150" id="age" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'')" placeholder="投保年龄">
                          		<label class="mar-l-15 mar-t-15">性别</label>
                           		<select class="form-control mar-t-15 w150" id="sex">
									<option value="">选择性别</option>
									<option value="10">女</option>
									<option value="11">男</option>
								</select>
								<label class="mar-l-15 mar-t-15">缴费期</label>
                           		<select class="form-control mar-t-15 w150" id="jiaofeiqi">
								</select>
								<label class="mar-l-15 mar-t-15">保障期</label>
                           		<select class="form-control mar-t-15 w150" id="baozhangqi">
								</select>
							</div>
							<div class="form-group">
								<label class="mar-l-15 mar-t-15">优选等级</label>
                           		<select class="form-control mar-t-15 w150" id="youxuandengji">
								</select>
								<label class="mar-l-15 mar-t-15">吸烟状态</label>
                           		<select class="form-control mar-t-15 w150" id="smoke">
									<option value="">选择吸烟状态</option>
									<option value="不区分">不区分</option>
									<option value="10">否</option>
									<option value="11">是</option>
								</select>
	                       </div>
                           <div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
								<button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
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
										<th>公司简称</th>
										<th>产品编号</th>
										<th>产品名称</th>
										<th>投保年龄</th>
										<th>缴费期</th>
										<th>保障期</th>
										<th>性别</th>
										<th>年金起始年</th>
										<th>吸烟</th>
										<th>优选等级</th>
										<th>社保</th>
										<th>费率</th>
										<th>保额</th>
										<th>产品价格分</th>
										<th>产品综合分</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].org_name}</td>
										<td>#{list[i].product_no}</td>
										<td>#{list[i].name}</td>
										<td>@{getAge}</td>
										<td>@{getPayTime}</td>
										<td>@{getInsureType}</td>
										<td>@{getSex}</td>
										<td>@{getPensionAge}</td>
										<td>@{getSmoke}</td>
										<td>@{priority}</td>
										<td>@{getSupplementary}</td>
										<td>@{getRatio}</td>
										<td>@{getAmount}</td>
										<td>@{getPrice}</td>
										<td>@{getScore}</td>
									</tr> -->
                                </tbody>
							</table>
                            <button class="btn btn-info" type="submit" id="exit" style="position: relative;">返回</button>
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
	$("#exit").click(function(){
		//location.href="http://manager.boss.aixbx.com/product/productList.jsp";
		window.history.go(-1);
	});
	
	$("#reset").click(function(){
    	var array = ["#age","#jiaofeiqi","#baozhangqi","#youxuandengji","#smoke","#sex",];
    	resetInput(array);
    });
    
    $("#search").click(function(){
		renderPage = true;
		getProductScoreListPage(0,pageSize);
	});

    /*获取参数*/
    var productId = getURLparam("productId");
    
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
	
	getProductScoreListPage(0,pageSize);
	
	/*获取产品分列表*/
	function getProductScoreListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		xco.setLongValue("productId", productId);
		var age = $("#age").val();
		var sex = $("#sex").val();
		var jiaofeiqi = $("#jiaofeiqi").val();
		var baozhangqi = $("#baozhangqi").val();
		var youxuandengji = $("#youxuandengji").val();
		var smoke = $("#smoke").val();
		if(age){
			xco.setStringValue("age", age);
		}
		if(sex){
			xco.setStringValue("sex", sex);
		}
		if(jiaofeiqi){
			xco.setStringValue("jiaofeiqi", jiaofeiqi);
		}
		if(baozhangqi){
			xco.setStringValue("baozhangqi", baozhangqi);
		}
		if(youxuandengji){
			xco.setStringValue("youxuandengji", youxuandengji);
		}
		if(smoke){
			xco.setStringValue("smoke", smoke);
		}
		//alert(xco);
		var options = {
			url : "/product/getProductScoreListPage.xco",
			data : xco,
			success : getProductScoreListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取产品分列表成功回调*/
	function getProductScoreListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			//alert(data);
			total = data.getIntegerValue("total");
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				
				getAge : function(){
					var age = list[i].getIntegerValue("age");
					if(age == 0){
						return "0";
					}else{
						return age;
					}
				},
			
				getPayTime : function(){
					var payTime = list[i].getIntegerValue("pay_time");
					var payTimeType = list[i].getIntegerValue("pay_time_type");
					if(payTime == 999){
						return "趸交";
					}else{
						if(payTimeType == 10){
							return payTime+"年";
						}
						if(payTimeType == 11){
							return payTime+"岁";
						}
						return "-";
					}
				},
				
				getInsureType : function(){
					var insurePeriod = list[i].getIntegerValue("insure_period");
					var periodType = list[i].getIntegerValue("period_type");
					//alert("insurePeriod="+insurePeriod);
					//alert("periodType="+periodType);
					if(insurePeriod == 999){
						return "终身";
					}else{
						if(periodType == 10){
							return insurePeriod+"年";
						}
						if(periodType == 11){
							return insurePeriod+"天";
						}
						if(periodType == 12){
							return insurePeriod+"月";
						}
						if(periodType == 13){
							return insurePeriod+"岁";
						}
						return "-";
					}
					
				},
				
				getSex : function(){
					var gender = list[i].getIntegerValue("gender");
					if(gender == 0){
						return "不限";
					}
					if(gender == 10){
						return "女性";
					}
					if(gender == 11){
						return "男性";
					}
				},
				
				getPensionAge : function(){
					var pensionAge = list[i].getIntegerValue("pension_age");
					var pensionAgeType = list[i].getIntegerValue("pension_age_type");
					if(pensionAgeType == 10){
						return pensionAge + "年";
					}
					if(pensionAgeType == 11){
						return pensionAge + "周岁";
					}
					return "-";
				},
				
				getSmoke : function(){
					var smoke = list[i].getIntegerValue("smoke");
					if(smoke == 0){
						return "不区分";
					}
					if(smoke == 10){
						return "否";
					}
					if(smoke == 11){
						return "是";
					}
				},
				
				getSupplementary : function(){
					supplementary = list[i].getIntegerValue("social_security");
					if(supplementary == 10){
						return "否";
					}
					if(supplementary == 11){
						return "是";
					}
					return "不区分";
				},
				
				getRatio : function(){
					rate = list[i].getLongValue("rate");
					return rate/scoreRatio;
				},
				
				priority : function(){
					rate = list[i].getStringValue("priority");
					if(rate){
						return rate;
					}else{
						return "-";
					}
				},
				
				
				getAmount : function(){
					amount = list[i].getLongValue("amount");
					return amount/scoreRatio;
				},
				
				getPrice : function(){
					amount = list[i].getLongValue("score4");
					return amount/scoreRatio;
				},
				
				getScore : function(){
					score = list[i].getLongValue("score");
					return score/scoreRatio;
				}
				
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getProductScoreListPage, pageSize);
			}
		}
	}
	
	//初始化保障期select
	getBaozhangqiSelect();
	function getBaozhangqiSelect() {
		var xco = new XCO();
		xco.setLongValue("product_id", productId);
		var options = {
			url : "/product/getBaozhangqiSelect.xco",
			data : xco,
			success : getBaozhangqiSelectCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getBaozhangqiSelectCallBack(data){
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			var str = "<option value=\"\">选择保障期</option>";
			if(null != data){
				var len = data.length;
				for(var i=0;i<len;i++){
					var baoxianqi = data[i].getStringValue("baozhangqi");
					if("0,0" != baoxianqi){
						str+="<option value="+baoxianqi+">";
						var arr = baoxianqi.split(",");
						var insure_period = arr[0];
						var period_type = arr[1];
						if(insure_period == 999){
							str+="终身</option>";
						}else if(period_type == "14"){
							str+="终身</option>";
						}else if(period_type == "10"){
							str+=insure_period+"年</option>";
						}else if(period_type == "11"){
							str+=insure_period+"天</option>";
						}else if(period_type == "12"){
							str+=insure_period+"月</option>";
						}else if(period_type == "13"){
							str+=insure_period+"岁</option>";
						}
					}
				}
			}
			$("#baozhangqi").html(str);
		}
	}
	 
	//初始化缴费期select
	getJiaofeiqiSelect();
	function getJiaofeiqiSelect() {
		var xco = new XCO();
		xco.setLongValue("product_id", productId);
		var options = {
			url : "/product/getJiaofeiqiSelect.xco",
			data : xco,
			success : getJiaofeiqiSelectCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getJiaofeiqiSelectCallBack(data){
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			var str = "<option value=\"\">选择缴费期</option>";
			if(null != data){
				var len = data.length;
				for(var i=0;i<len;i++){
					var jiaofeiqi = data[i].getStringValue("jiaofeiqi");
					if("0,0" != jiaofeiqi){
						str+="<option value="+jiaofeiqi+">";
						var arr = jiaofeiqi.split(",");
						var pay_time = arr[0];
						var pay_time_type = arr[1];
						if(pay_time_type == "12"){
							str+="趸交</option>";
						}else if(pay_time_type == "10"){
							str+=pay_time+"年</option>";
						}else if(pay_time_type == "11"){
							str+=pay_time+"岁</option>";
						}
					}
				}
			}
			$("#jiaofeiqi").html(str);
		}
	}
	
	//初始化优选等级select
	getYouxuandengjiSelect();
	function getYouxuandengjiSelect() {
		var xco = new XCO();
		xco.setLongValue("product_id", productId);
		var options = {
			url : "/product/getYouxuandengjiSelect.xco",
			data : xco,
			success : getYouxuandengjiSelectCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getYouxuandengjiSelectCallBack(data){
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			var str = "<option value=\"\">选择优选等级</option>";
			if(null != data){
				var len = data.length;
				for(var i=0;i<len;i++){
					var youxuandengji = data[i].getStringValue("youxuandengji");
					var arr = youxuandengji.split(",");
					var pay_time = arr[0];
					var pay_time_type = arr[1];
					str+="<option value="+pay_time+">"+pay_time+"</option>";
				}
			}
			$("#youxuandengji").html(str);
		}
	}
	
</script>