<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>标准项列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

    <div id="breadcrumbs">
        <ul class="breadcrumb">
                        <li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
                    class="divider"><i class="icon-angle-right"></i> </span></li>
   <li>
                <span href="../dictionary/labelList.jsp"> 渠道管理</span><span class="divider"><i class="icon-angle-right"></i></span>
            </li>
   <li><span>修改渠道</span><span class="divider">

            </span>
            </li>
        </ul>
    </div>

    <div id="page-content" class="clearfix">
        <div class="page-header position-relative crumbs-nav">
            <h1><i class="icon-edit"></i>修改</h1>
        </div>
        <div class="row-fluid">
            <div class="row-fluid mar-t-15">
                <div class="span12">
                    <div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
                                <div class="from-group mar-t-15">
                                    <label><span style="color:red;">*</span>最高值</label>
                                    <input type="text" class="form-control" id="norm_high" placeholder="">
                                </div>
                                <div class="from-group mar-t-15">
                                    <label><span style="color:red;">*</span>解析结果</label>
                                    <input type="text" class="form-control" id="rard_result" placeholder="">
                                </div>
                                <div class="from-group mar-t-15">
                                    <label><span style="color:red;">*</span>单位</label>
                                    <input type="text" class="form-control" id="norm_unit" placeholder="">
                                </div>

                        <div class="from-group">
                            <button class="user-add-save" id="save">保存</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $("#save").click(function(){
        var xco = new XCO();
        //参数必填验证
            var norm_high=$("#norm_high").val();
                if(!norm_high){
                    axError("请输入最高值");
                    return;
                }
            xco.setStringValue("norm_high",norm_high);
            var rard_result=$("#rard_result").val();
                if(!rard_result){
                    axError("请输入解析结果");
                    return;
                }
            xco.setIntegerValue("rard_result",rard_result);
            var norm_unit=$("#norm_unit").val();
                if(!norm_unit){
                    axError("请输入单位");
                    return;
                }
            xco.setStringValue("norm_unit",norm_unit);
        console.log(xco.toString())
        var options = {
            url : " ",
            data : xco,
            success : function(data){
                if(data.getCode()!=0){
                    axError(data.getMessage());
                }else{
                    axSuccess("保存成功！");
                }
            }
        };
        axConfirm("确定保存吗?",function(){
            $.doXcoRequest(options);
        })
    })
</script>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    
    
    XCOTemplate.pretreatment(['datalist']);  //// 模板预处理
	var renderPage = true;
	xdoRequest(0,10);
	
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setStringValue("std_code", $("#std_code").val());
		xco.setStringValue("std_cn_name", $("#std_cn_name").val());
		xco.setStringValue("std_en_name", $("#std_en_name").val());
		xco.setIntegerValue("std_type", $("#std_type").val());
		var options = {
			url : "/standard/standardList.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function doRequestCallBack(data){
		//var xco=new XCO();
		//xco.fromXML(data);
		//var data = xco.getData();
		
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
			getLink: function(xco){
				return '<a href="/medstd/updateMedStd.jsp?std_id='+xco.get("std_id")+'">编辑</a><br />';
			},
			getType:function(xco){
				var name='';
				if(xco.get('std_type')==1){
					name='数值型';
					return name;
				}
				if(xco.get('std_type')==2){
					name='阴阳型';
					return name;
				}
				if(xco.get('std_type')==3){
					name='文本型';
					return name;
				}
			},
			getState:function(xco){
				if(xco.get("std_state")==1){
					return '正常';
				}else{
					return '停用';
				}
			}
	    };
	    
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);  // 填充模板, data为XCO对象
    	}
   		document.getElementById("datalist").innerHTML = html;  // 渲染页面
   		
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), xdoRequest, pageSize);
		}		  
	}
	
	function deleteStd(opt){
		xco.setIntegerValue("std_id", opt);
		var options = {
			url : "/standard/deleteMedstd.xco",
			data : xco,
			success : doDeleteCallBack
		};
		$.doXcoRequest(options);
	
	}
	
	function doDeleteCallBack(data){
		if(data.getCode()==0){
			window.location.reload();
		}else{
		// TODO 错误提示
			return;
		}
	}
	  
    $("#search").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
	});
    
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