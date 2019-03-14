<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "定时任务";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>定时任务</title>
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
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../task/timeTaskList.jsp">定时任务列表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>新增定时任务<span class="divider"></span></li>
			</ul>
		</div>

		<div id="cover"></div>
		<div id="coverShow">
			<img src="/image/loaders/4.gif" />
			<p>请稍后......</p>
		</div>
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>新增定时任务</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">注意事项:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、生成由公司分导入引起的定时任务计算综合分。</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、请先导入公司分，然后再新增该任务。</p>
							</h5>
							<div class="from-group" style="margin-left:100px;">
								<label><span class="font-red">*</span>定时任务执行时间</label>
								<input type="text" class="form-control mar-t-15 Wdate w200" id="startTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"> 
								<!-- <input type="text" class="form-control mar-t-15 Wdate w200" id="orgScoreStartTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-{%d+1}'})"> -->
							</div>
							<div class="from-group mar-t-15" style="position: relative;top:20px;">
								<button class="btn btn-success" style="margin-left:180px;" type="submit"id="addOrgScoreTask">生成任务</button>
							</div>
							
							
							<!-- <hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;margin-top:40px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">注意事项:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、生成二级分类：<span Style="color:red;">投连账户</span> 下的所有产品的综合分。</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、请先输入"历史收益率"的配比分，然后再新增该任务。</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">3、目前数据库中（p_series表）“投连账户”该二级分类的id为14，如果当前二级分类（投连账户）不为14,请自行修改。</p>
							</h5>
							<div class="from-group" style="margin-left:100px;">
								<label><span class="font-red">*</span>投连账户</label>
								<input type="text" class="form-control mar-t-15 w200" id="temp" name="temp" value="14" onkeyup="clearNoNum(this)">
							</div>
							<div class="from-group" style="margin-left:100px;">
								<label><span class="font-red">*</span>历史收益率</label>
								<input type="text" class="form-control mar-t-15" id="historyScore" name="historyScore" onkeyup="clearNoNum(this)">
							</div>
							<div class="from-group" style="margin-left:100px;">
								<label><span class="font-red">*</span>定时任务执行时间</label>
								<input type="text" class="form-control mar-t-15 Wdate w200" id="orgScoreRatioStartTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
								<input type="text" class="form-control mar-t-15 Wdate w200" id="orgScoreRatioStartTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-{%d+1}'})">
							</div>
							<div class="from-group mar-t-15" style="position: relative;top:20px;">
								<button class="btn btn-success" style="margin-left:180px;" type="submit"id="addOrgScoreRatioTask">生成任务</button>
							</div>
							 -->
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;margin-top:40px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">注意事项:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、生成二级分类：<span Style="color:red;">万能险</span> 下的所有产品的综合分。</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、请先输入导入Excel，然后再新增该任务。</p>
							</h5>
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;margin-left:100px;">
								<label><span class="font-red">*</span>导入Excel文件</label>
								<input type="text" class="form-control" id="file_name" readonly="readonly">
								<button class="btn btn-info" type="reset" style="position:absolute; left:445px; top:0px;padding-left:30px;padding-right:30px;height:30px;">选择文件</button>
								<input type="hidden" id="file_url" name="file_url">
								<div style="position:absolute; left:445px; top:0px; background:#F00; width:116px; height:30px;opacity: 0;z-index: 2;">
									<form id="form1" name="upload" action="" method="post" enctype="multipart/form-data">
										<!-- <input type="hidden" id="update_desc2" name="update_desc2" value="xxxxxx"/> -->
										<input style="width:88px;height:30px;" type="file" name="file"
											id="fileField" onchange="select1(this);" value="选择文件"
											alt="点击选择文件" />
									</form>
									<br class="clear" />
								</div>
							</div>
							<div class="from-group mar-t-15">
								<span style="margin-left: 200px;color:red;">当前下载模板为2018年6月30号最新Excel</span><span><a href="/downAllPriceScoreTemplate.xco" style="margin-left:20px;">模板下载</a></span>
							</div>
							<div class="from-group" style="margin-left:100px;">
								<label><span class="font-red">*</span>定时任务执行时间</label>
								<input type="text" class="form-control mar-t-15 Wdate w200" id="orgScoreRatioStartTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
								<!-- <input type="text" class="form-control mar-t-15 Wdate w200" id="orgScoreRatioStartTime" placeholder="请选择定时任务执行时间" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-{%d+1}'})"> -->
							</div>
							<div class="from-group mar-t-15" style="position: relative;top:20px;">
								<button class="btn btn-success" style="margin-left:180px;" type="submit"id="addImportTask">生成任务</button>
							</div>
							<div class="row-fluid" style="margin-top:20px;" id="succMsg">
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
							<div class="row-fluid" style="margin-top:20px;" id="errMsg">
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
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	/*新增由公司分引起的计算综合分任务*/
	$("#addOrgScoreTask").click(function(){
		var xco = new XCO();
		var orgScoreStartTime = $("#startTime").val();
		if(orgScoreStartTime){
			xco.setStringValue("startTime",orgScoreStartTime);
		}else{
			axError("请选择定时任务执行时间");
			//$("#orgScoreStartTime").focus();
			return;
		}
		xco.setStringValue("title","调整公司分计算综合分");
		xco.setIntegerValue("task_type",1);//导入综合分类型
		var options = {
			url : "/task/addSysTask.xco",
			data : xco,
			success : function(data){
				//alert("xx="+data.toString());
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("生成成功！",function(){
						location.href="../task/timeTaskList.jsp";
					});
				}
			}
		};
		axConfirm("确定生成定时任务吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
	
	
	/*新增由历史收益率引起的计算综合分任务*/
	/* $("#addOrgScoreRatioTask").click(function(){
		var xco = new XCO();
		
		var historyScore = $("#historyScore").val();
		if(historyScore){
			if(getNum(historyScore)){
				xco.setLongValue("historyScore",historyScore*scoreRatio);
			}else{
				axError("历史收益率分请输入数字");
				$("#historyScore").focus();
				return;
			}
		}else{
			axError("请输入操作历史收益率分");
			$("#hisRatio").focus();
			return;
		}
		
		var orgScoreRatioStartTime = $("#orgScoreRatioStartTime").val();
		if(orgScoreRatioStartTime){
			xco.setStringValue("startTime",orgScoreRatioStartTime);
		}else{
			axError("请选择定时任务执行时间");
			//$("#orgScoreRatioStartTime").focus();
			return;
		}
		
		xco.setStringValue("title","调整历史收益率计算综合分");
		var temp = $("#temp").val();
		if(temp){
			xco.setIntegerValue("subTypeId",temp);//二级分类ID
		}else{
			axError("请输入投连账户的id");
			return;
		}
		xco.setIntegerValue("ratioId",7);//配比项id
		xco.setIntegerValue("task_type",2);//导入综合分类型
		var options = {
			url : "/task/addSysTask.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("生成成功！",function(){
						location.href="../task/timeTaskList.jsp";
					});
				}
			}
		};
		axConfirm("确定生成定时任务吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}) */
	
	/*只能输数字*/
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
	
	/*判断是否是数字*/
	function getNum(n){
		return /^\d+(\.\d+)?$/.test(n+"");
	}
	
	/*处理导入后的历史收益率引起的综合分计算*/
	$("#addImportTask").click(function(){
		var xco = new XCO();
		
		var orgScoreRatioStartTime = $("#orgScoreRatioStartTime").val();
		if(orgScoreRatioStartTime){
			xco.setStringValue("startTime",orgScoreRatioStartTime);
		}else{
			axError("请选择定时任务执行时间");
			return;
		}
		
		var fileName = $("#file_name").val();
		if(!fileName){
			axError("请上传价格分");
			return;
		}
		
		xco.setStringValue("title","万能险计算综合分");
		//xco.setIntegerValue("subTypeId",7);//万能险Id
		xco.setStringValue("task_arg","52");//万能险二级分类id
		xco.setIntegerValue("task_type",2);//导入综合分类型
		var options = {
			url : "/task/addImportHistorySysTask.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("生成成功！",function(){
						location.href="../task/timeTaskList.jsp";
					});
				}
			}
		};
		axConfirm("确定生成定时任务吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
	
	$("#errMsg").hide();
	$("#succMsg").hide();
	
	function select1(e){
		var xco = new XCO();
		$("#form1").attr("action","/uploadHistoryExcel.xco");
		if(e.value){
		
			$("#succMsg").hide();
			$("#errMsg").hide();
			
			var fileField = $("#fileField").val();
			var index = fileField.lastIndexOf(".");
			var suffix = fileField.substring(index+1,fileField.length);
			if(suffix == "xlsx"){
				var cover = document.getElementById("cover"); 
				var covershow = document.getElementById("coverShow"); 
				cover.style.display = 'block'; 
				covershow.style.display = 'block'; 
				$("form[name='upload']").ajaxSubmit({
			      	success:function(data){
			      		$("#fileField").val("");
			        	var xco=new XCO();
			        	xco.fromXML(data);
		      			cover.style.display = 'none'; 
						covershow.style.display = 'none'; 
			      		if(xco.getCode() == 0){
							var _dataList = xco.getXCOListValue("updateResult");
							if(_dataList.length > 0){
								var t_data = _dataList[0].get("data");
								$("#file_name").val(_dataList[0].getStringValue("filename"));
				      			$("#succMsg").show();
								$("#xmlid").html("处理结果:上传成功！上传记录数:"+t_data.getIntegerValue("count")+"条");
								$("#xmlid").css("color","green");
							}
			      		}else if(xco.getCode() == 110){
			      			$("#errMsg").show();
			      			var _dataList = xco.getXCOListValue("updateResult");
							if(_dataList.length > 0){
				      			var list = _dataList[0].getXCOValue("data").getXCOListValue("imxcoilist");
				      			var str = "";
				      			for(var i=0;i<list.length;i++){
				      				str+="<tr><td>"+list[i].getStringValue("msg")+"</td></tr>"
				      			}
				      			document.getElementById("table_content").innerHTML = str;
							}
			      		}else if(xco.getCode() == -1){
							$("#errMsg").show();
							var str = "<tr><td>"+list[i].getStringValue("msg")+"</td></tr>"
			      			document.getElementById("table_content").innerHTML = str;
			      		}
			      	}
		        })
			}else{
				$("#succMsg").show();
				$("#xmlid").html("请上传excel文件!");
				$("#xmlid").css("color","red");
				$("#fileField").val("");
				return;
			}
			
		}
	}
</script>