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
<title>核保请求</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-leaf"></i><span class="divider"></span> <span>核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span href="../dictionary/labelList.jsp">核保请求</span><span class="divider">
				</span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>核保请求</h1>
			</div>

      <div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div  class="form-inline form-inline-list">
							<div class="row-fluid">
								<div class="span3">
									<label>渠道</label>
	                          		<select class="form-control w150" id="ch_id">
	                           				<option value="0">请选择</option>	
										<!-- <option value="#{ch_id}">#{ch_name}</option> -->
									</select>
								</div>
								<div class="span3">
									<label>请求编号</label>
                          			<input type="text" class="form-control" id="req_sn_ext" placeholder="">
								</div>
								<div class="span3">
									<label>处理结果</label>
	                          		<select class="form-control"  id="proc_result">
		                                <option value="-1">请选择</option>
		                                <option value="0">未处理</option>
		                                <option value="10">预警</option>
		                                <option value="20">加费</option>
		                                <option value="30">减费</option>
		                                <option value="40">缺项</option>
		                                <option value="50">转人工</option>
		                                <option value="60">拒保</option>
		                                <option value="100">通过</option>
		                                <option value="110">失败</option>
	                              </select>
								</div>
							</div>
                           <!-- <div class="form-group" style="line-height: 30px;">
                          		<label>渠道</label>
                          		<select class="form-control w150" id="ch_id">
                           				<option value="0">请选择</option>	
									<option value="#{ch_id}">#{ch_name}</option>
								</select>
                              </select>
                              <label>请求编号</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="req_sn_ext" placeholder="">
                              <label>处理结果</label>
                          		<select class="form-control w150"  id="proc_result">
                                <option value="-1">请选择</option>
                                <option value="0">未处理</option>
                                <option value="10">预警</option>
                                <option value="20">加费</option>
                                <option value="30">减费</option>
                                <option value="40">缺项</option>
                                <option value="50">转人工</option>
                                <option value="60">拒保</option>
                                <option value="100">通过</option>
                                <option value="110">失败</option>
                              </select> -->
                              <!-- <label>响应状态</label>
                          		<select class="form-control w150"  id="resp_state">
                                <option value="-1">请选择</option>
                                <option value="0">未响应</option>
                                <option value="10">等待响应</option>
                                <option value="30">响应失败</option>
                                <option value="100">响应成功</option>
                              </select> -->
                              <!-- <br> -->
                             <!--  <label>开始时间</label>
                          		<input type="text" class="form-control mar-t-15 w150" placeholder="">
                              <label>结束时间</label>
                            	<input type="text" class="form-control mar-t-15 w150" placeholder=""> -->
                          	<!-- </div>
                          	<div class="form-group mar-l-15">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">+新增</button>
	                       </div> -->
                        </div>
                        <div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn mar-l-15 btn-info" id="find" type="reset">搜索</button>
                                </div>
                            </div>
                       	</div>
					</div>
				</div>

				<div class="row-fluid">
                    <div class="row-fluid">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
					                    <th>ID</th>
					                    <th>渠道</th>
					                    <th>请求编号</th>
										<th>产品编号</th>
										<th>产品分类</th>
										<th>核保模式</th>
                   						<th>核保规则</th>
                   						<th>业务模式</th>
                   						<th>处理结果</th>
										<th>处理状态</th>
										<!-- <th>响应状态</th> -->
                    					<th>时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id=datalist>
									<!-- <tr>
										<td>#{req_sn}</td>
										<td>#{ch_name}</td>
										<td>#{req_sn_ext}</td>
										<td>#{up_ext_pno}</td>
										<td>@{getProduct}</td>
										<td>@{getRequestModel}</td>
										<td>#{rule_name}</td>
										<td>@{getBusinessModel}</td>
										<td>@{getResult}</td>
										<td>@{getState}</td>
										<td ><ul style="float:left;margin:0 0">请求时间：#{create_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">完成时间：#{completed_time@formatdate}</ul><br /><ul style="float:left;margin:0 0">响应时间：#{reponse_time@formatdate}</ul></td>
										<td>@{getLink}</td>
									</tr> -->
                                </tbody>
							</table>
								<!-- <td>@{getState1}</td> -->
							<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
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

   var req_sn_ext_u = getURLparam("req_sn_ext");
   if(req_sn_ext_u)$("#req_sn_ext").val(req_sn_ext_u);
   XCOTemplate.pretreatment(['ch_id','datalist']);
   
   channelRequest();
   function channelRequest(){
		var xco = new XCO();
		var options = {
			url : "/security/getAllChannel.xco",
			data : xco,
			success : channelRequestCallBack
		};
		$.doXcoRequest(options);
   }
   function channelRequestCallBack(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		var dataList = data.getData();
		var html = '<option value="0">请选择</option>';
		 for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("ch_id", dataList[i], null);
    	}
    	
   		document.getElementById("ch_id").innerHTML = html;
   }
   var renderPage = true;
   getReportList(0,50)
   
   function getReportList(start,pageSize){
   		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		xco.setIntegerValue("proc_result", $("#proc_result").val());
		xco.setIntegerValue("ch_id", $("#ch_id").val());
		var req_sn_ext = $("#req_sn_ext").val();
        xco.setStringValue("req_sn_ext", req_sn_ext);
       
		var options = {
			url : "/rulecalculate/getRequestByPage.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
   }
  
	
	function doRequestCallBack(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		
		data = data.getData();
		total = data.getIntegerValue("count");
		$("#total").text(total);
		$("#size").text(10);
		var dataList=data.get('list');
		if(!dataList){
			dataList=new Array();	
		}
	    var html = '';
	    var ext = {
			getResult:function(xco){
				if(xco.get("proc_result")==0){
					return "未处理";
				}
				if(xco.get("proc_result")==10){
					return "预警";
				}
				if(xco.get("proc_result")==20){
					return "加费";
				}
				if(xco.get("proc_result")==30){
					return "减费";
				}
				if(xco.get("proc_result")==40){
					return "缺项";
				}
				if(xco.get("proc_result")==50){
					return "转人工";
				}
				if(xco.get("proc_result")==60){
					return "拒保";
				}
				if(xco.get("proc_result")==100){
					return "通过";
				}
				if(xco.get("proc_result")==110){
					return "失败";
				}
			},						
			getLink: function(xco){
				return '<a href="/ungstd/requestDetail.jsp?request_id='+xco.get("req_sn")+'">结果明细</a><br />'+
				'<a href="/medstd/reportlist.jsp?req_sn_ext='+xco.get("req_sn_ext")+'">体检分析</a>';
			},
			getState:function(xco){
				var str='';
				if(xco.get("proc_state")==0){
					str+= "未处理";
				}	
				if(xco.get("proc_state")==20){
					str+= "规则匹配完成";
				}
				if(xco.get("proc_state")==30){
					str+= "医学结论分析中";
				}
				if(xco.get("proc_state")==40){
					str+= "医学结论分析完成";
				}
				if(xco.get("proc_state")==50){
					str+= "核保检测中";
				}
				if(xco.get("proc_state")==100){
					str+= "处理成功";
				}
				if(xco.get("proc_state")==110){
					str+= "未匹配到规则";
				}
				if(xco.get("proc_state")==120){
					str+= "获取体检报告失败";
				}
				if(xco.get("req_msg")){
					str+="<br />【"+xco.get("req_msg")+"】";
				}
				return str;
			} ,
			getProduct:function(xco){
				if(xco.get("series_no")==1){
					return "重疾险";
				}
				if(xco.get("series_no")==2){
					return "寿险";
				}
				if(xco.get("series_no")==3){
					return "癌症险";
				}
			},
			getRequestModel:function(xco){
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
			},
			getBusinessModel:function(xco){
				if(xco.get("business_model")==1){
					return "普通预警";
				}
				if(xco.get("business_model")==2){
					return "爱康推荐";
				}
				if(xco.get("business_model")==3){
					return "反向核保";
				}
				if(xco.get("business_model")==4){
					return "健康评测(体检编号)";
				}
				if(xco.get("business_model")==5){
					return "健康评测(H5)";
				}
				if(xco.get("business_model")==6){
					return "普通预警(体检编号)";
				}
			},			
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), getReportList, pageSize);
		}		  
	}
	  
	$("#find").click(function(){
		renderPage = true;
		getReportList(0,pageSize);
	});
	
	
	function formatdate(time){
		if(!time){
			return ;
		}
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
