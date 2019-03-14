<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "榜单";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>榜单</title>
	<style type="text/css">
		.seriesName{
			width:210px;
			left: 5rem;
			top: .26rem;
		}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-file-alt"></i><a>数据统计</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li>榜单<span class="divider"></span>
				</li>
			</ul>
		</div>

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>榜单</h1>
			</div>
			<div class="modal fade" id="loadingModal">
   				 <div style="width: 200px;height:20px; z-index: 20000; position: absolute; text-align: center; left: 50%; top: 50%;margin-left:-100px;margin-top:35%">
			      <!--   <div class="progress progress-striped active" style="margin-bottom: 0;">
			            <div class="progress-bar" style="width: 100%;"></div>
			        </div> -->
    			 <img src="/image/loaders/4.gif" />
			        <h5>正在加载...</h5>
    			</div>
			</div>
			<div style="cursor:pointer;display:none" id="hidden_select"><i class="icon-chevron-down"></i><span>隐藏查询区域</span></div>
			<div style="cursor:pointer;" id="show_select" ><i class=" icon-tasks"></i><span>展示查询区域</span></div>
			<div class="row-fluid" >
				<!-- 查询条件div开始 -->
				<div class="row-fluid mar-t-15" id="select_info" style="display:none">
					<div class="span12">
						<div class="form-inline">
							<div class="form-group" style="line-height: 30px;">
								<label class="mar-l-15 mar-t-15" style="width:210px;text-align: left;">通用：</label>
								<label class="mar-l-15 mar-t-15" style="width:70px;text-align: right;">是否在售：</label>
								<select class="form-control mar-t-15 w150" style="width:110px" id="on_sale">
									<option value=-1>不限</option>
									<option selected="selected" value=1>是</option>
								</select> 
							</div>
							<div id="ranking_select_info"></div>
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
								<button onclick="getJson()" class="btn mar-t-15 mar-l-15  btn-info">获取数据文件</button>&nbsp;&nbsp;<a id="down" download="json"></a>
							</div>
						</div>
					</div>
				</div>
				<!-- 查询条件div结束 -->
				<div class="row-fluid">
					<div class="row-fluid mar-t-15">
						<div id="ranking_info"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!--查询条件-->
<div id="ranking_select_info_template"><!--
		<div class="form-group" style="line-height: 30px;">
		<label class="mar-l-15 mar-t-15" style="width:210px;text-align: left;color:@{getColor}">@{getName}：</label>
		<label class="mar-l-15 mar-t-15" style="width:70px;text-align: right;">性别：</label>
		<select id="sex_@{getId}" class="form-control mar-t-15 w150" style="width:110px">
			<option value=0>不限</option>
			<option selected="selected" value=11>男</option>
			<option value=10>女</option>
		</select> 
		<label  class="mar-l-15 mar-t-15" style="width:50px">年龄：</label>
		<input id="age_@{getId}" value="30"  style="width:100px" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
		<label class="mar-l-15 mar-t-15" style="width:60px">保障期：</label>
		<select id="isfixed_insure_period_@{getId}" class="form-control mar-t-15 w150" style="width:110px">
			<option selected="selected" value=0>不限</option>
			<option  value=3>最大保障期</option>
		</select> 
		<label class="mar-l-15 mar-t-15" style="width:90px">首选缴费期：</label>
		<select id="isfixed_pay_time_@{getId}" class="form-control mar-t-15 w150" style="width:110px">
			<option selected="selected" value=0>不限</option>
			<option value=30>30</option>
			<option value=20>20</option>
			<option value=3>最长缴费期</option>
		</select> 
		<label class="mar-l-15 mar-t-15" style="width:90px">备选缴费期：</label>
		<select id="has_alt_pay_time_@{getId}" class="form-control mar-t-15 w150" style="width:110px">
			<option selected="selected" value=0>无</option>
			<option value=3>最长缴费期</option>
		</select> 
	</div>
	-->
</div>
<!--排行榜展示-->
<div id="ranking_info_template"><!--
		<br/>
		<hr style="float:left;height:1px;border:none;border-top:1px solid #185598;width:100%;margin-top: 50px;">
		<div  style="width:48%;float:left;">
			<h2 style="color:@{getColor}">@{getName}(综合榜)</h2>
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>保险公司</th>
						<th>产品名</th>
						<th>保障期</th>
						<th>缴费期</th>
						<th>分数</th>
					</tr>
				</thead>
				<tbody id="@{getIntegListID}">
				</tbody>
			</table>
		</div>
		<div  style="width:48%;float:left;margin-left: 3%;">
			<h2 style="color:@{getColor}">@{getName}(价格榜)</h2>
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>保险公司</th>
						<th>产品名</th>
						<th>保障期</th>
						<th>缴费期</th>
						<th>分数</th>
					</tr>
				</thead>
				<tbody id="@{getPriceListID}">
				</tbody>
			</table>
		</div>
	-->
</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    
    var renderPage = true;
    var color = "red";
	XCOTemplate.pretreatment('ranking_info_template');
	XCOTemplate.pretreatment('ranking_select_info_template');

	//1.渲染选择条件
	renderingRankingSelect();
	//2.渲染下方排行榜
	renderingRankingInfo();
	//3.获取排行榜具体信息
	// getRangkingListPage();
	//搜索
	$("#search").click(function(){
		renderPage = true;
		$("#show_select").css("display","");
		$("#hidden_select").css("display","none");
		$("#select_info").css("display","none");
		getRangkingListPage();
	});
	//搜索区域显示与隐藏
	$("#show_select").click(function(){
		$("#show_select").css("display","none");
		$("#hidden_select").css("display","");
		$("#select_info").css("display","");
	});
	$("#hidden_select").click(function(){
		$("#show_select").css("display","");
		$("#hidden_select").css("display","none");
		$("#select_info").css("display","none");
	});
	var url = "/leaderboardService/getLeaderboard.xco";
	var callback = getRangkingListCallBack;
	/*获取榜单列表*/
	function getRangkingListPage() {
		var request = new XCO();
		var args = [];
		var typeList=[33,34,35,36,37,38,40,41,43,44,46,47,48,49,51,52,53,54,55,57,58,59];
		for(var i=0;i<typeList.length;i++){
			var xco = new XCO();
			xco.setIntegerValue("on_sale", $("#on_sale").val());// 是否在售[-1:不限, 0:否, 1:是]
			xco.setLongValue("sub_type_id", typeList[i]);
			xco.setIntegerValue("age", parseInt($("#age_"+typeList[i]).val()));// 年龄[0:不限]
			xco.setIntegerValue("sex", $("#sex_"+typeList[i]).val());// 性别[0:不限, 10:女, 11:男]
			xco.setIntegerValue("include_integ", 1);// 是否包含综合榜[0:N, 1:Y]
			xco.setIntegerValue("include_price", 1);// 是否包含价格榜[0:N, 1:Y]
	        var isfixed_insure_period = $("#isfixed_insure_period_"+typeList[i]).val();//保障期
	        var isfixed_pay_time = $("#isfixed_pay_time_"+typeList[i]).val();//缴费期
	        var has_alt_pay_time = $("#has_alt_pay_time_"+typeList[i]).val();//是否存在缴费期
	        
	        //2018.12.29新增前置与后置条件判断 axf
			//前置条件与后置条件判断	search_flag  标记:[0:前置, 1:后置]
			if(isfixed_insure_period ==0 && isfixed_pay_time==0 && has_alt_pay_time==0){//后置
				xco.setIntegerValue("search_flag", 1);
				xco.setIntegerValue("isfixed_pay_time", 3);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
				xco.setIntegerValue("min_pay_time", 0);
				xco.setIntegerValue("max_pay_time", 0);
				xco.setIntegerValue("pay_time_type", 0); 
				xco.setIntegerValue("isfixed_insure_period", 3);// 保险期间方式[1.固定值 2.区间值 3.最大值 4.最小值 5.终身]',
				xco.setIntegerValue("min_insure_period", 0);
				xco.setIntegerValue("max_insure_period", 0);
				xco.setIntegerValue("period_type", 0);	
				xco.setIntegerValue("has_alt_pay_time", 0); // 是否存在备选缴费期[0:N, 1.Y]
				xco.setIntegerValue("alt_isfixed_pay_time", 0);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
				xco.setIntegerValue("alt_min_pay_time", 0);
				xco.setIntegerValue("alt_max_pay_time", 0);
				xco.setIntegerValue("alt_pay_time_type", 0);
			}else{//前置
				xco.setIntegerValue("search_flag", 0);
		        if(isfixed_insure_period==0){
					xco.setIntegerValue("isfixed_insure_period", 0);// 保险期间方式[1.固定值 2.区间值 3.最大值 4.最小值 5.终身]',
					xco.setIntegerValue("min_insure_period", 0);
					xco.setIntegerValue("max_insure_period", 0);
					xco.setIntegerValue("period_type", 0);	        
		        }else if(isfixed_insure_period==3){
					xco.setIntegerValue("isfixed_insure_period", 3);// 保险期间方式[1.固定值 2.区间值 3.最大值 4.最小值 5.终身]',
					xco.setIntegerValue("min_insure_period", 0);
					xco.setIntegerValue("max_insure_period", 0);
					xco.setIntegerValue("period_type", 0);	        
		        }
				if(isfixed_pay_time==0){
					xco.setIntegerValue("isfixed_pay_time", 0);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", 0);
					xco.setIntegerValue("max_pay_time", 0);
					xco.setIntegerValue("pay_time_type", 0);
				}else if(isfixed_pay_time==3){
					xco.setIntegerValue("isfixed_pay_time", 3);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", 0);
					xco.setIntegerValue("max_pay_time", 0);
					xco.setIntegerValue("pay_time_type", 0);        
		        }else{
					xco.setIntegerValue("isfixed_pay_time", 1);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", isfixed_pay_time);
					xco.setIntegerValue("max_pay_time", isfixed_pay_time);
					xco.setIntegerValue("pay_time_type", 10);
				}
				if(has_alt_pay_time==0){
					xco.setIntegerValue("has_alt_pay_time", 0); // 是否存在备选缴费期[0:N, 1.Y]
				}else{
					xco.setIntegerValue("has_alt_pay_time", 1); // 是否存在备选缴费期[0:N, 1.Y]
				}
				xco.setIntegerValue("alt_isfixed_pay_time", 3);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
				xco.setIntegerValue("alt_min_pay_time", 0);
				xco.setIntegerValue("alt_max_pay_time", 0);
				xco.setIntegerValue("alt_pay_time_type", 0);				
			}
			if(typeList[i] == 38 || typeList[i] == 43){//定期重疾、定期寿险  查询条件为 后置条件
				xco.setIntegerValue("search_flag", 1);
		        if(isfixed_insure_period==0){
					xco.setIntegerValue("isfixed_insure_period", 0);// 保险期间方式[1.固定值 2.区间值 3.最大值 4.最小值 5.终身]',
					xco.setIntegerValue("min_insure_period", 0);
					xco.setIntegerValue("max_insure_period", 0);
					xco.setIntegerValue("period_type", 0);	        
		        }else if(isfixed_insure_period==3){
					xco.setIntegerValue("isfixed_insure_period", 3);// 保险期间方式[1.固定值 2.区间值 3.最大值 4.最小值 5.终身]',
					xco.setIntegerValue("min_insure_period", 0);
					xco.setIntegerValue("max_insure_period", 0);
					xco.setIntegerValue("period_type", 0);	        
		        }
				if(isfixed_pay_time==0){
					xco.setIntegerValue("isfixed_pay_time", 0);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", 0);
					xco.setIntegerValue("max_pay_time", 0);
					xco.setIntegerValue("pay_time_type", 0);
				}else if(isfixed_pay_time==3){
					xco.setIntegerValue("isfixed_pay_time", 3);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", 0);
					xco.setIntegerValue("max_pay_time", 0);
					xco.setIntegerValue("pay_time_type", 0);        
		        }else{
					xco.setIntegerValue("isfixed_pay_time", 1);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
					xco.setIntegerValue("min_pay_time", isfixed_pay_time);
					xco.setIntegerValue("max_pay_time", isfixed_pay_time);
					xco.setIntegerValue("pay_time_type", 10);
				}
				if(has_alt_pay_time==0){
					xco.setIntegerValue("has_alt_pay_time", 0); // 是否存在备选缴费期[0:N, 1.Y]
				}else{
					xco.setIntegerValue("has_alt_pay_time", 1); // 是否存在备选缴费期[0:N, 1.Y]
				}
				xco.setIntegerValue("alt_isfixed_pay_time", 3);// 缴费期方式[1.固定值 2.区间值 3.最大值 4.最小值 5.趸交]',
				xco.setIntegerValue("alt_min_pay_time", 0);
				xco.setIntegerValue("alt_max_pay_time", 0);
				xco.setIntegerValue("alt_pay_time_type", 0);
			}
			xco.setIntegerValue("social_security", 0); // 是否有社保[10:N, 11.Y]
			xco.setIntegerValue("smoke", 0); // 是否抽烟[10:N, 11.Y]
			args.push(xco);
		}				
		request.setXCOListValue("args", args);
		//显示
        $("#loadingModal").modal({backdrop: 'static', keyboard: false});
        $("#loadingModal").modal('show');
		var options = {
			url : url,
			data : request,
			success :callback
		};
		$.doXcoRequest(options);
	}
	function getJson() {
        url = "/downRankingList.xco";
        callback = downCallback;
        getRangkingListPage()
        url = "/leaderboardService/getLeaderboard.xco";
        callback = getRangkingListCallBack;
    }
    function downCallback(data){
        $("#loadingModal").modal('hide');
		if(data.getCode() == 0) {
		    data = data.get("data");
		    var file = data.get("file");
		    var name = data.get("name");
		    $("#down").attr("href",file).text("下载").attr("download",name)
        }
	}
	/*获取榜单列表成功回调*/
	function getRangkingListCallBack(data) {
		if (data.getCode() != 0) {
			//隐藏
            $("#loadingModal").modal('hide');
			axError(data.getMessage());
		} else {
			var total = 0;
			var size = 0;
			data = data.getData();
			var len = 0;
			if (data) {
				len = data.length;
			}
			for (var i = 0; i < len; i++) {
				var sub_type_id = data[i].get("sub_type_id");
				//综合榜单
				var integList = data[i].getXCOListValue("integList");
				if(null == integList || 0 == integList.length) {
     			 		 continue;
  					}
				var html="";
				for(var g=0;g<integList.length;g++){
					var org_name = integList[g].get("org_name");
					var name = integList[g].get("name");
					var pay_time = integList[g].get("pay_time");
					var pay_time_type = integList[g].get("pay_time_type");
					if(pay_time==999){
						pay_time="趸交";
					}
					if(pay_time_type==10){
						pay_time=pay_time+"年";
					}
					if(pay_time_type==11){
						pay_time="至"+pay_time+"岁";
					}
					if(pay_time_type==12){
						pay_time="趸交";
					}
					var insure_period = integList[g].get("insure_period");
					var period_type = integList[g].get("period_type");
					if(period_type==10){
						insure_period=insure_period+"年";
					}
					if(period_type==13){
						insure_period="至"+insure_period+"岁";
					}
					if(period_type==14){
						insure_period="终身";
					}
					if(insure_period==999){
						insure_period="终身";
					}
					
					var score = integList[g].get("score");
					if(score!=null && score!=0){
						score = score/10000;
						score=score.toFixed(2);
					}
					
					html+='<tr>';
					html+=	'<td>'+(g+1)+'</td>';
					html+=	'<td>'+org_name+'</td>';
					html+=	'<td>'+name+'</td>';
					html+=	'<td>'+insure_period+'</td>';
					html+=	'<td>'+pay_time+'</td>';
					html+=	'<td>'+score+'</td>';
					html+='</tr>';
				}
				document.getElementById('integList_'+sub_type_id).innerHTML = html;
				
				//价格榜单
				var priceList = data[i].getXCOListValue("priceList");
				if(null == priceList || 0 == priceList.length) {
     			 		 continue;
  					}
				html="";
				for(var h=0;h<priceList.length;h++){
					var org_name = priceList[h].get("org_name");
					var name = priceList[h].get("name");
					var pay_time = priceList[h].get("pay_time");
					var pay_time_type = priceList[h].get("pay_time_type");
					if(pay_time_type==10){
						pay_time=pay_time+"年";
					}
					if(pay_time_type==11){
						pay_time="至"+pay_time+"岁";
					}
					if(pay_time_type==12){
						pay_time="趸交";
					}
					var insure_period = priceList[h].get("insure_period");
					var period_type = priceList[h].get("period_type");
					if(pay_time==999){
						pay_time="趸交";
					}
					if(period_type==10){
						insure_period=insure_period+"年";
					}
					if(period_type==13){
						insure_period="至"+insure_period+"岁";
					}
					if(period_type==14){
						insure_period="终身";
					}
					if(insure_period==999){
						insure_period="终身";
					}
					
					var score = priceList[h].get("score4");
					if(score!=null && score!=0){
						score = score/10000;
						score=score.toFixed(2);
					}
					html+='<tr>';
					html+=	'<td>'+(h+1)+'</td>';
					html+=	'<td>'+org_name+'</td>';
					html+=	'<td>'+name+'</td>';
					html+=	'<td>'+insure_period+'</td>';
					html+=	'<td>'+pay_time+'</td>';
					html+=	'<td>'+score+'</td>';
					html+='</tr>';
				}				
				document.getElementById('priceList_'+sub_type_id).innerHTML = html;
				//隐藏
        		$("#loadingModal").modal('hide');
			}
			
		}
	}
		/**
	 * 渲染搜索条件
	 */
	function renderingRankingSelect(){
	   var typeList=[33,34,35,36,37,38,40,41,43,44,46,47,48,49,51,52,53,54,55,57,58,59];
	    var ext = {
	        getId :function(typeId){
	           	return typeId;
	        },
	        getName :function(typeId){
	        	var name = getName(typeId);
	           	return name;
	        },
	       	getColor : function(typeId){
				if(typeId==33 || typeId ==34 || typeId ==38 || typeId==40 || typeId==43){
					return color;
				}
				return "";
			}
	    };
	
	    var html = '';
	    for (var i = 0; i < typeList.length; i++) {
	        html += XCOTemplate.execute('ranking_select_info_template', typeList[i], ext);
  	  	}
	    document.getElementById('ranking_select_info').innerHTML = html;
	    $("#isfixed_pay_time_33").val(20);//重疾终身型（带身故保额责任）
	    $("#isfixed_pay_time_34").val(20);//重疾终身型（无身故保额责任）
	    $("#isfixed_pay_time_40").val(20);//终身寿险传统型
	    $("#has_alt_pay_time_33").val(3);//重疾终身型（带身故保额责任）
	    $("#has_alt_pay_time_34").val(3);//重疾终身型（无身故保额责任）
	    $("#has_alt_pay_time_40").val(3);//终身寿险传统型
	    $("#isfixed_insure_period_33").val(3);//重疾终身型（带身故保额责任）
	    $("#isfixed_insure_period_34").val(3);//重疾终身型（无身故保额责任）
	    $("#isfixed_insure_period_40").val(3);//终身寿险传统型
	    
	    $("#isfixed_pay_time_38").val(3);//定期重疾
	    $("#isfixed_pay_time_43").val(3);//定期终身
	    $("#isfixed_insure_period_38").val(3);//定期重疾
	    $("#isfixed_insure_period_43").val(3);//定期终身
	    
	    
	    
	}
	 /**
	 * 渲染排行列表
	 */
	function renderingRankingInfo(){
	   var typeList=[33,34,35,36,37,38,40,41,43,44,46,47,48,49,51,52,53,54,55,57,58,59];
	    var ext = {
	        getIntegListID :function(typeId){
	           	return "integList_"+typeId;
	        },
	        getPriceListID :function(typeId){
	           	return "priceList_"+typeId;
	        },
	        getName :function(typeId){
	        	var name = getName(typeId);
	           	return name;
	        },
	       	getColor : function(typeId){
				if(typeId==33 || typeId ==34 || typeId ==38 || typeId==40 || typeId==43){
					return color;
				}
				return "";
			}
	    };	
	    var html = '';
	    for (var i = 0; i < typeList.length; i++) {
	        html += XCOTemplate.execute('ranking_info_template', typeList[i], ext);
  	  	}
	    document.getElementById('ranking_info').innerHTML = html;
	}
	/*获取xco的编码*/
	function getName(id) {
			if(id==33){
				return "重疾终身型（带身故保额责任）";
			}
			if(id==34){
				return "重疾终身型（无身故保额责任）";
			}
			if(id==35){
				return "重疾返还型";
			}
			if(id==36){
				return "重疾消费型";
			}
			if(id==37){
				return "重疾防癌险";
			}
			if(id==38){
				return "重疾定期型";
			}
			if(id==40){
				return "终身寿险传统型";
			}
			if(id==41){
				return "终身寿险储蓄投资型";
			}
			if(id==43){
				return "定期寿险传统型";
			}
			if(id==44){
				return "定期寿险储蓄投资型";
			}
			if(id==46){
				return "医疗报销险中端";
			}
			if(id==47){
				return "医疗报销险高端";
			}
			if(id==48){
				return "一般报销险";
			}
			if(id==49){
				return "税优健康险";
			}
			if(id==51){
				return "储蓄投资险分红型";
			}
			if(id==52){
				return "储蓄投资险万能型";
			}
			if(id==53){
				return "储蓄投资险投连型";
			}
			if(id==54){
				return "储蓄投资险复合型";
			}
			if(id==55){
				return "储蓄投资险普通年金型";
			}
			if(id==57){
				return "普通意外险";
			}
			if(id==58){
				return "旅行意外险";
			}
			if(id==59){
				return "返还型意外险";
			}
	}
</script>