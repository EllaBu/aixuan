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
	.t-header {
		background-color: #f1f1f1;
		padding: 10px 10px 1px;
		border-radius: 4px;
		font-weight: bold;
	}
	.header-tab {
		margin-top: 5px;
		margin-bottom: 15px;
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
			        <a  class="active"><strong>总览</strong></a>　
		           	<a href="../data/monthData.jsp" class="color_02">按月统计</a>　
		           	<a href="../data/yearData.jsp" class="color_02">按年统计</a>　
				</div>				
			</div>

			<div class="row-fluid">
		        <div class="result-title-new">
		        		 总量统计
		        </div>	
				<div class="result-analysis-new" style="height: 300px" id="pie"></div>
				<div class="t-header result-analysis-new" style="display:none" id="noPie">
					<p>无数据</p>
				</div>					
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	var nameData = ['预警','加费','减费','缺项','转人工','拒保','通过','失败'];
	var obj = [];
	//获取总览数据
	xdoRequest();
	function xdoRequest() {
		obj = [];
		var xco = new XCO();
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
		//拼装展示json数据
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
	  
	//获取状态名称
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
	//渲染饼图
	function InintPie() {
		$("#noPie").css("display","none");
    	$("#pie").css("display","");	
		var myChartPie = echarts.init(document.getElementById('pie'));
		optionPie = {
/* 		    title : {
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
</script>