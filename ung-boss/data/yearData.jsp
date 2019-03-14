<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数据统计";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
	.color_01{
		color: blue;
		cursor:pointer;
	}
	.color_02{
		color: black;
		cursor:pointer;
	}
	.header-tab {
		margin-top: 5px;
		margin-bottom: 4px;
	}
	.header-tab a {
		float: left;
		background-color: #4c8fbd;
		color: #fff;
		width: 72px;
		text-align: center;
		padding: 6px 10px;
		margin: 0 5px 0 0;
	}	
	.header-tab a.active {
		background-color: #ffca85;
		color: #666;
	}
	.t-header {
		background-color: #f1f1f1;
		padding: 10px 10px 1px;
		font-weight: bold;
	}	
</style>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>数据统计</title>
</head>
<script type="text/javascript" src="/js/echarts.common.min.js"></script>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bookmark"></i><span class="divider"></span><span>数据管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>数据统计</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>数据统计</h1>
				<div class="header-tab">
					<a href="../data/allData.jsp" class="color_02">总览</a>　
		           	<a href="../data/monthData.jsp" class="color_02">按月统计</a>　
		           	<a  class="active"><strong>按年统计</strong></a>　
				</div>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
						  	<div class="row-fluid">
	                            <div class="span3">
	                                <label>统计年份</label> 
									<input type="text" class="form-control mar-t-15 Wdate w150" id="yearTime" placeholder="请选择年份" onfocus="WdatePicker({dateFmt: 'yyyy' })">
	                            </div>
	                            <div class="span3">
	                                 <button style="top: 10px;" class="btn  btn-info mar-l-15" id="search" type="reset">查询</button>
	                            </div>
                        	</div>
						</div>
					</div>
				</div>

		        <div class="result-title-new">
		        		 总量统计
		        </div>	
				<div class="result-analysis-new" style="height: 300px" id="pie"></div>
				<div class="t-header result-analysis-new" style="display:none" id="noPie">
					<p>该年无数据</p>
				</div>	
		        <div class="result-title-new">
		        		 明细统计
		        </div>					
				<div class="result-analysis-new" style="height: 300px" id="line"></div>			
				<div class="t-header result-analysis-new" style="display:none" id="noLine">
					<p>该年无数据</p>
				</div>	
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	var nameData = ['预警','加费','减费','缺项','转人工','拒保','通过','失败'];
	var monthArr = ['1月份','2月份','3月份','4月份','5月份','6月份','7月份','8月份','9月份','10月份','11月份','12月份'];
	var obj = [];
	var objLine = [];
	var date=new Date;
	var year=date.getFullYear(); 
	$("#yearTime").val(year);
	xdoRequest(year);
	xdoRequestYear(year);
	function xdoRequest(year) {
		obj = [];
		var xco = new XCO();
		xco.setStringValue("year", year);
		var options = {
			url : "/statistics/simpleView.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function doRequestCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			return;
		}
		
		data = data.getData();
		var dataList=data;
		if(!dataList){
			dataList=new Array();	
		}
		if(dataList == null || dataList.length==0){
			$("#noPie").css("display","");
    		$("#pie").css("display","none");
    		return;
		}
	    for (var i = 0; i < nameData.length; i++) {
	    	var name = nameData[i];
	    	var jsonData = {};
	    	var value = 0;
	    	for (var j = 0; j < dataList.length; j++) {
	    		var state = dataList[j].getIntegerValue("proc_result");
	    		var stateName = getStateName(state);
	    		if(name == stateName){
	    			value = dataList[j].getIntegerValue("num");
	    			break;
	    		}
    		}
    		jsonData['value'] = value;
    		jsonData['name'] = name;
    		obj.push(jsonData);
    	}
    	InintPie(); 
	}
	
	function xdoRequestYear(year) {
		objLine = [];
		var xco = new XCO();
		xco.setIntegerValue("year", year);
		var options = {
			url : "/statistics/complexView_year.xco",
			data : xco,
			success : doRequestYearCallBack
		};
		$.doXcoRequest(options);
	}
	
	function doRequestYearCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			return;
		}
		
		data = data.getData();
		var dataList=data;
		if(!dataList){
			dataList=new Array();	
		}
		if(dataList == null || dataList.length==0){
			$("#noLine").css("display","");
    		$("#line").css("display","none");
    		return;
		}		
	    for (var i = 0; i < nameData.length; i++) {
	    	var name = nameData[i];
	    	var jsonData = {};
	    	var valueArr = [];
	    	for (var k = 0; k < monthArr.length; k++) {
	    		var mon = monthArr[k];
	    		if(k>=9){
	    			mon=mon.substring(0,2);
	    		}else{
	    			mon=mon.substring(0,1);
	    		}
	    		var value = 0;
		    	for (var j = 0; j < dataList.length; j++) {
		    		if(mon == dataList[j].getIntegerValue("month")){
		    			var state = getStateByName(name);
		    			value = dataList[j].getDoubleValue(state);
		    			break;
		    		}
	    		}
	    		valueArr.push(value);
	    	}
    		jsonData['name'] = name;
    		jsonData['type'] = "line";
    		//jsonData['stack'] = "总量";
    		jsonData['data'] = valueArr;
    		objLine.push(jsonData);
    	}
    	InintLine(); 
	}
	  

	
    $("#search").click(function(){
    	var yearTime = $("#yearTime").val();
    	if(yearTime){
			xdoRequest(yearTime);
			xdoRequestYear(yearTime);    	
    	}else{
			xdoRequest(year);
			xdoRequestYear(year);    	
    	}
	});

	function getStateName(state) {
		var stateName = "失败";
		if(state==10){
			stateName = "预警";
		}
		if(state==20){
			stateName = "加费";
		}
		if(state==30){
			stateName = "减费";
		}
		if(state==40){
			stateName = "缺项";
		}
		if(state==50){
			stateName = "转人工";
		}
		if(state==60){
			stateName = "拒保";
		}
		if(state==100){
			stateName = "通过";
		}
		return stateName;
	}
	function getStateByName(stateName) {
		var state = "fail";
		if(stateName=="预警"){
			state = "state_10";
		}
		if(stateName=="加费"){
			state = "state_20";
		}
		if(stateName=="减费"){
			state = "state_30";
		}
		if(stateName=="缺项"){
			state = "state_40";
		}
		if(stateName=="转人工"){
			state = "state_50";
		}
		if(stateName=="拒保"){
			state = "state_60";
		}
		if(stateName=="通过"){
			state = "state_100";
		}
		return state;
	}	
	
	function InintPie() {
		$("#noPie").css("display","none");
    	$("#pie").css("display","");
		var myChartPie = echarts.init(document.getElementById('pie'));
		optionPie = {
		    /* title : {
		        text: '总量统计图',
		        x:'center'
		    }, */
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    color:['#53868B','#EEA2AD','#00ccff','#ffcc00','#BA55D3','#A0522D','#8fc31f','#EE0000'],
		    legend: {
		        data: nameData,
		         x: 'center',
		    },
		    series : [
		        {
		            name: '核保统计',
		            type: 'pie',
		            radius : '65%',
		            center: ['50%', '60%'],
		            data:obj,
			        label: {
			                normal: {
			                    formatter: '{b} : {c} ({d}%)',
			                    borderWidth: 1,
			                    borderRadius: 4,
			                    rich: {
			                        b: {
			                            fontSize: 16,
			                            lineHeight: 33
			                        },
			                        per: {
			                          /*   color: '#eee',
			                            backgroundColor: '#334455', */
			                            padding: [2, 4],
			                            borderRadius: 2
			                        }
			                    }
			                },
			                emphasis: {
			                    show: true,
			                    textStyle: {
			                        fontSize: '20',
			                        fontWeight: 'bold'
			                    }
			                }
	           			 },
		        }
		    ]
		};
		myChartPie.setOption(optionPie);
	}
	function InintLine() {
		$("#noLine").css("display","none");
   		$("#line").css("display","");		
		var myChartLine = echarts.init(document.getElementById('line'));
		optionLine = {
		    /* title: {
		        text: '时间段统计图',
		        x:'center'
		    }, */
		    tooltip: {
		        trigger: 'axis'
		    },
		    color:['#53868B','#EEA2AD','#00ccff','#ffcc00','#BA55D3','#A0522D','#8fc31f','#EE0000'],
		    legend: {
		        data: nameData,
		         x: 'center',
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: monthArr
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: objLine
		};
		myChartLine.setOption(optionLine);
	}
</script>