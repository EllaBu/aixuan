<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "核保请求";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title>结果明细</title>
</head>
<body>
<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li>
				<i class="icon-leaf"></i><span class="divider"></span>
				<span href="#">核保管理</span>
				<span  class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li>
				<span >核保请求</span>
				<span class="divider"><i class="icon-angle-right"></i></span>
			</li>
			<li>
				<span>结果明细</span><span class="divider"></span>
			</li>
		</ul>
	</div>
		<!--#breadcrumbs-->
		
	<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>结果明细</h1>
			</div>
			<div class="row-fluid">
        	<div class="result-title-new">
       		   基本信息
        	</div>
        	<div id="req_result">
			<!--<div class="row-fluid">
				<div class="span12">
					<div class="form-inline bord1dd form-add1">
		              	<div class="from-group mar-t-15">
							<label>请求编号</label>
							<input type="text" class="form-control mar-t-15"  value="#{req_sn_ext}" disabled style="width:366px;" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label>产品编号</label>
							<input type="text" class="form-control mar-t-15" value="#{up_ext_pno}" disabled style="width:366px;" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label>核保规则</label>
							<input type="text" class="form-control mar-t-15" value="#{rule_name}" disabled style="width:366px;" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label>核保模式</label>
							<input type="text" class="form-control mar-t-15" value="@{getModel2}" disabled style="width:366px;" placeholder="">
						</div>
					</div>
				</div>
			</div>
	        <div class="result-title-new">
			 	核保结论
			</div>
			<div class="result-analysis-new clearfix">
				@{getModel}              <span style="float:right" id="rescount" ></span> 
			</div> -->
	        </div>
	        <div class="result-title-new">
	        		  结果明细   
	        </div>
	       
	        <div class="row-fluid">
			       <div class="row-fluid">
			              <div class="span12">
			                    <div  class="form-inline" style="padding: 0;">
									<div class="form-group" style="line-height: 30px;">
										<div class="form-group result-search-new">
											<label>明细结果</label>
											<select class="form-control w150"  id="ri_result">
												<option value="-1">请选择</option>
												<option value="0">忽略</option>
												<option value="10">预警</option>
												<option value="20">加费</option>
												<option value="30">减费</option>
												<option value="40">缺项</option>
												<option value="50">转人工</option>
												<option value="60">拒保</option>
												<option value="100">通过</option>
												<option value="110">失败</option>
											</select>
											<button id="find" type="reset">搜索</button>
										</div>
									</div>
								</div>
	                            <table id="table_bug_report" class="table table-striped table-bordered table-hover" style="margin:0;">
									<thead>
										<tr>
										<th>ID</th>
										<th>核保项</th>
										<th>定义</th>
										<th>评点分</th>
										<th>预警编码</th>
										<th>系数</th>
										<th>描述</th>
										<th>明细结果</th>
										</tr>
									</thead>
									<tbody id="datalist">
										<!-- <tr>
										<td>#{rd_id}</td>
										<td>#{ri_name}</td>
										<td>#{rid_def}</td>
										<td>#{ri_score}</td>
										<td>#{ri_sug_code}</td>
										<td>#{ri_coe}</td>
										<td>#{ri_desc}</td>
										<td>@{getResult}</td>
										</tr> -->
									</tbody>
								</table>
								<div style="margin-top: 10px">
									<div id="loading" style="display: none">
										<img alt="" src="../image/loaders/4.gif"/>
									</div> 
									<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
	                            	<jsp:include page="../common/page.jsp"/>
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
   var res;
   var req_sn = getURLparam("request_id");
   var renderPage = true;
   XCOTemplate.pretreatment(['req_result','datalist']);
   getRequestDetail(0,100);
   
   getRequest();
   function getRequest(){
   		$("#loading").show();
   		var xco = new XCO();
   		xco.setLongValue("req_sn", req_sn);
   		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", 100);
		xco.setIntegerValue("ri_result", $("#ri_result").val());
		var options = {
			url : "/rulecalculate/getRequestForDetail.xco",
			data : xco,
			success : doRequestInfoCallBack
		};
		$.doXcoRequest(options);
   }
   
   function getRequestDetail(start,pageSize){
   		$("#loading").show();
   		var xco = new XCO();
   		xco.setLongValue("req_sn", req_sn);
   		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		xco.setIntegerValue("ri_result", $("#ri_result").val());
		var options = {
			url : "/rulecalculate/getRequestDetail.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
   }
   
   function doRequestInfoCallBack(data){
		$("#loading").hide();
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		var Data=data.getData();
	    var ext = {
			getModel:function(xco){
				var str='';
				if(xco.get("proc_state")<100){
					return '处理状态：【<font color="red">处理中</font>】';
				}
				if(xco.get("rule_model")==1){
					str+='核保结果：【'+Result(xco.get("proc_result"))+'】';
					if(xco.get("warn_sn")){
						str+='    预警编码:【'+xco.get("warn_sn")+'】';
					}
					return str;
				}
				if(xco.get("rule_model")==2){
					if(xco.get("req_score")){
						str+="评点分：【"+xco.get("req_score")+"】 ";
					}
					str+="    核保结果：【"+Result(xco.get("proc_result"))+"】";
					return str;
				}
				if(xco.get("rule_model")==3){
					str+="核保结果：【"+Result(xco.get("proc_result"))+"】 ";
					if(xco.get("warn_sn")){
						str+="    预警编码:【"+xco.get("warn_sn")+"】";
					}
					if(xco.get("warn_level")){
						str+="评级结果:【"+xco.get("warn_level")+"】";
					}
					return str;
				}
				if(xco.get("rule_model")==4){
					return "爱康产品推荐";
				}
				if(xco.get("rule_model")==5){
					if(xco.get("req_score")){
						str+="评点分：【"+xco.get("req_score")+"】 ";
					}
					 str+="   核保结果：【"+Result(xco.get("proc_result"))+"】 ";
					if(xco.get("warn_level")){
						str+="   评级结果:【"+xco.get("warn_level")+"】";
					}
					return str;
				}
				if(xco.get("rule_model")==6){
					if(xco.get("warn_level"))
					return "评级结果:【"+xco.get("warn_level")+"】";
				}
			},
		  getModel2:function(xco){
		  		if(xco.get("rule_model")==1){
					return "预警";
				}
				if(xco.get("rule_model")==2){
					return "评点";
				}
				if(xco.get("rule_model")==3){
					return "预警+评级";
				}
				if(xco.get("rule_model")==4){
					return "爱康产品推荐";
				}
				if(xco.get("rule_model")==5){
					return "评点+评级";
				}
				if(xco.get("rule_model")==6){
					return "评级";
				}
		  }	
	    };
	    var resulthtml='';
	    var reqobj=Data.get("request");
	    var rescount=Data.get("resultcount");
	    resulthtml+=XCOTemplate.execute("req_result", reqobj,ext);
	    document.getElementById("req_result").innerHTML = resulthtml;
	   
	    if(rescount){
	    	var	reshtml="明细统计：";
	    	var hl_total = 0;
		    for (var i = 0; i < rescount.length; i++) {
	        	var xco=rescount[i];
	        	if(xco.get("ri_result")==0){
	        		hl_total = hl_total +xco.get("total");
				}
				if(xco.get("ri_result")==10){
					reshtml+= " 预警【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==20){
					reshtml+= " 加费【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==30){
					reshtml+= " 减费【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==40){
					reshtml+= " 缺项【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==50){
					reshtml+= " 转人工【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==60){
					reshtml+= " 拒保【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==100){
					reshtml+= " 通过【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==110){
					reshtml+= " 医学解析错误【"+xco.get("total")+"】";
				}
				if(xco.get("ri_result")==120){
					hl_total = hl_total +xco.get("total");
				}
				if(xco.get("ri_result")==130){
					hl_total = hl_total +xco.get("total");
				}
	    	}
	    		if(hl_total>0){
					reshtml+= " 忽略【"+hl_total+"】";
				}
	    	$("#rescount").append(reshtml);
	    }
	}
	
	
	function doRequestCallBack(data){
		$("#loading").hide();
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		var Data=data.getData();
		total = Data.getIntegerValue("count");
		$("#total").text(total);
		$("#size").text(10);
		var dataList=Data.get('list');
		if(!dataList){
			dataList=new Array();	
		}
	    var ext = {
			getResult:function(xco){
				if(xco.get("ri_result")==0){
					return "忽略";
				}
				if(xco.get("ri_result")==10){
					return "预警";
				}
				if(xco.get("ri_result")==20){
					return "加费";
				}
				if(xco.get("ri_result")==30){
					return "减费";
				}
				if(xco.get("ri_result")==40){
					return "缺项";
				}
				if(xco.get("ri_result")==50){
					return "转人工";
				}
				if(xco.get("ri_result")==60){
					return "拒保";
				}
				if(xco.get("ri_result")==100){
					return "通过";
				}
				if(xco.get("ri_result")==110){
					return "医学解析错误";
				}
				if(xco.get("ri_result")==120){
					return "忽略";
				}
				if(xco.get("ri_result")==130){
					return "忽略";
				}
			}
	    };
      	var html = '';
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), getRequestDetail, 100);
		}		
	}
	  
	$("#find").click(function(){
		renderPage = true;
		getRequestDetail(0,100);
	});
	
	
	function Result(res){
				if(res==0){
					return '<font color="red">未处理</font>';
				}
				if(res==10){
					return '<font color="red">预警</font>';
				}
				if(res==20){
					return '<font color="red">加费</font>';
				}
				if(res==30){
					return '<font color="red">减费</font>';
				}
				if(res==40){
					return '<font color="red">缺项</font>';
				}
				if(res==50){
					return '<font color="red">转人工</font>';
				}
				if(res==60){
					return '<font color="red">拒保</font>';
				}
				if(res==100){
					return '<font color="green">通过</font>';
				}
				if(res==110){
					return '<font color="red">失败</font>';
				}
			}
	
	function formatdate(time){
		var date = new Date(time);
	    var year =  date.getFullYear(),
			        month = date.getMonth() + 1,//月份是从0开始的
			        day = date.getDate(),
			        hour = date.getHours(),
			        min = date.getMinutes(),
			        sec = date.getSeconds();
			        if(day<10) day='0'+day;	
			        if(month<10) month='0'+month;
			        if(hour<10) hour= '0'+hour;
			        if(min<10) min= '0'+min;
			        if(sec<10) sec= '0'+sec;	
		var newTime = year + '-' +  month + '-' +day + ' ' +
				                hour + ':' +min + ':' +sec;
	    return newTime;         
	}
   
</script>
