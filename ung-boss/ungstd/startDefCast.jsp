<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数据统计";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>定义匹配</title>
</head>
<body>
	<div id="main-content" class="clearfix">
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>跑库统计专用	</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
						
						<div class="user-count">
							<h5>功能说明：</h5>
							<p>1、抽取核保标准值：<span Style="color:red;">输入规则ID</span></p>
							<p>2、请先输入导入规则ID，然后再生成核保项</p>
							<div class="user-count-handle">
								<span><i>*</i>规则ID</span>
								<input type="text" class="form-control" id="rule_id" >
								<button id="getUngStd" type="reset">核保标准项抽取</button>
							</div>
						</div>
						
						<div class="user-count">
							<h5>功能说明：</h5>
							<p>1、统计指定标准项：<span Style="color:red;">输入标准项编码</span></p>
							<div class="user-count-handle">
								<span><i>*</i>标准项编码 </span>
								<input type="text" class="form-control"  id="std_code" >
								<p>
									<button id="countAllStd" type="reset">统计指定标准项</button>
									<a href="/count/count1.txt">下载结果</a>
								</p>
							</div>
							
							<h5>功能说明：</h5>
							<p>1、统计指定规则下所有标准项：<span Style="color:red;">获取页面最上方输入框规则ID</span></p>
							<div class="user-count-handle">
								<p>
									<button id="countStdByRule" type="reset">统计指定规则下所有标准项</button>
			               			<a href="/count/count2.txt">下载结果</a>
								</p>
							</div>
							
						</div>
						
						<div class="user-count">
							<h5>注意事项：</h5>
							<p>1、匹配定义</span></p>
							<p>2、统计定义匹配结果</p>
							<div class="user-count-handle">
								 <button id="add" type="reset">匹配定义</button>
								 <button id="countParseByDef" type="reset">统计定义</button>
			               		 <a href="/count/count3.txt">下载结果</a>
							</div>
						</div>
						
						<div class="user-count">
							<h5>注意事项：</h5>
							<p>1、基于核保结果明细统计(展示核保项匹配情况)</span></p>
							<p>2、基于核保定义统计(展示定义,前置条件以及匹配结果以及比例)</p>
							<p>3、统计核保规则(统计体检报告匹配结果以及评级结果，比例)</p>
							<div class="user-count-handle">
								 <button id="countRuleLose" type="reset">核保明细统计</button>
				               	 <a target="_blank" href="/count/count4.txt"  >下载结果</a>
				                 <button id="countRuleLose2" type="reset">核保定义统计</button>
				               	 <a target="_blank" href="/count/count6.txt"  >下载结果</a>
				                 <button id="countALL" type="reset">核保汇总统计</button>
				              	 <a target="_blank" href="/count/count5.txt"  >下载结果</a>
							</div>
						</div>
						
						
						
							<!-- <hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">功能说明:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、抽取核保标准值：<span Style="color:red;">输入规则ID</span></p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、请先输入导入规则ID，然后再生成核保项</p>
							</h5>
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;margin-left:30px;">
								<label><span class="font-red">*</span>规则ID</label>
								<input type="text" class="form-control" id="rule_id" >
								<button class="btn btn-success" id="getUngStd" type="reset" style="position:absolute; left:445px; top:0px;padding: 0 12px;border:none;line-height: 30px;">核保标准项抽取</button>
							</div>


							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px; margin-top:40px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">功能说明:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、统计指定标准项：<span Style="color:red;">输入标准项编码</span></p>
							</h5>
							<div class="from-group mar-t-15" style="position:relative; border:0px solid #000; height:30px;margin-left:50px;">
								<label><span class="font-red">*</span>标准项编码</label>
								<input type="text" class="form-control"  id="std_code" >
							</div>
							<div class="from-group mar-t-15" style="position: relative;">
								<button class="btn mar-l-15  btn-success" style="margin-left:180px;" id="countAllStd" type="reset">统计指定标准项</button>
				               	<a href="/count/count1.txt">下载结果</a>
							</div>
							
							<h5 style="margin-left:120px;">
								<span style="color: red;">功能说明:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、统计指定规则下所有标准项：<span Style="color:red;">获取页面最上方输入框规则ID</span></p>
							</h5>
							
							<div class="from-group mar-t-15" style="position: relative;">
								<button class="btn mar-l-15  btn-success" style="margin-left:180px;" id="countStdByRule" type="reset">统计指定规则下所有标准项</button>
			               		<a href="/count/count2.txt">下载结果</a>
							</div>
						
						
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;margin-top:40px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">注意事项:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、匹配定义</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、统计定义匹配结果</p>
							</h5>
							<div class="from-group" style="margin-left:30px;">
								 <button class="btn btn-success" id="add"  style="margin-left:130px;" type="reset">匹配定义</button>
								 <button class="btn mar-l-15  btn-success" style="margin-top: -1px" id="countParseByDef" type="reset">统计定义</button>
			               		 <a href="/count/count3.txt">下载结果</a>
							</div>
							
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;margin-top:40px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">注意事项:</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1、基于核保结果明细统计(展示核保项匹配情况)</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2、基于核保定义统计(展示定义,前置条件以及匹配结果以及比例)</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">3、统计核保规则(统计体检报告匹配结果以及评级结果，比例)</p>
							</h5>
							<div class="from-group" style="margin-left:30px;">
								 <button class="btn mar-l-15  btn-success" style="margin-left:130px;" id="countRuleLose" type="reset">核保明细统计</button>
				               	 <a target="_blank" href="/count/count4.txt"  >下载结果</a>
				                 <button class="btn mar-l-15  btn-success" id="countRuleLose2" type="reset">核保定义统计</button>
				               	 <a target="_blank" href="/count/count6.txt"  >下载结果</a>
				                 <button class="btn mar-l-15  btn-success" id="countALL" type="reset">核保汇总统计</button>
				              	 <a target="_blank" href="/count/count5.txt"  >下载结果</a>
							</div> -->
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- <div id="main-content" class="clearfix">
#breadcrumbs
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>数据统计</h1>
		</div>
		<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							
							
							<div class="from-group mar-t-15" >
								<label><span style="color:red;"></span>规则名称</label>
								<input type="text" class="form-control" id="rule_id" >
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>核保标准项抽取</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="getUngStd" type="reset">执行</button>
							</div>
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>标准项名称</label>
								<textarea type="text" class="form-control"  id="std_code" ></textarea>
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>统计指定标准项</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="countAllStd" type="reset">执行</button>
				               		<a   href="/count/count1.txt">下载结果</a>
							</div>
							
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>统计指定规则标准项</label>
								<button class="btn mar-t-15 mar-l-15  btn-success" id="countStdByRule" type="reset">执行</button>
				               	<a class= target="_blank" href="/count/count2.txt"  >下载结果</a>
							</div>
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>匹配定义</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">执行</button>
							</div>
							
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>统计定义</label>
								<button class="btn mar-t-15 mar-l-15  btn-success" id="countParseByDef" type="reset">执行</button>
				               <a  target="_blank" href="/count/count3.txt"  >下载结果</a>
							</div>
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>基于核保结果明细统计</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="countRuleLose" type="reset">执行</button>
				               <a target="_blank" href="/count/count4.txt"  >下载结果</a>
							</div>
							
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>基于核保定义统计</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="countRuleLose2" type="reset">执行</button>
				               <a target="_blank" href="/count/count6.txt"  >下载结果</a>
							</div>
							
							<div class="from-group mar-t-15">
								<label><span style="color:red;"></span>统计核保规则(汇总)</label>
								 <button class="btn mar-t-15 mar-l-15  btn-success" id="countALL" type="reset">执行</button>
				               <a target="_blank" href="/count/count5.txt"  >下载结果</a>
							</div>
						</div>
						
					</div>		
				</div>
			</div>
	</div>
</div>
	 -->
</body>
</html>
<script type="text/javascript">

	//添加按钮点击事件监听
	$("#getUngStd").click(function(){
		var xco = new XCO();
		xco.setLongValue("rule_id", $("#rule_id").val());
		var options = {
			url : "/ruleService/findKeyFromFormula.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("核保标准值抽取完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	//添加按钮点击事件监听
	$("#countAllStd").click(function(){
		var xco = new XCO();
		var stds=new Array();
		var std_code=$("#std_code").val();
		if(std_code){
		var sts=std_code.split(",");
		for ( var i = 0; i < sts.length; i++) {
			stds.push(sts[i]);
		}
		xco.setStringListValue("stdCodes",stds);
		}
		
		var options = {
			url : "/countService/countStdLose.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	$("#countStdByRule").click(function(){
		var xco = new XCO();
		xco.setLongValue("rule_id", $("#rule_id").val());
		var options = {
			url : "/countService/countRuleDefStd.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	//添加按钮点击事件监听
	$("#add").click(function(){
		var xco = new XCO();
		/* xco.setIntegerValue("tt_total",1);
		xco.setIntegerValue("tt_index",0); */
		var options = {
			url : "/resultAnalysisService/start.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("任务已开始！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	$("#countParseByDef").click(function(){
		var xco = new XCO();
		var rid_id=$("#rid_id").val();
		if(rid_id==null || rid_id==""){
			rid_id=0;
		}
		xco.setLongValue("rid_id",rid_id );  
		var options = {
			url : "/countService/countParseByDef.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	$("#countRuleLose").click(function(){
		var xco = new XCO();
		var options = {
			url : "/countService/countRuleLose.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	$("#countRuleLose2").click(function(){
		var xco = new XCO();
		var options = {
			url : "/countService/countRuleLose2.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});
	
	
	$("#countALL").click(function(){
		var xco = new XCO();
		var options = {
			url : "/countService/countALL.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("统计完毕！",function(){						
					});
				}
			}
		};
		$.doXcoRequest(options);
	});	

</script>
