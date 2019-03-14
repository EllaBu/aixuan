<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "核保规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>核保规则</title>
</head>
<body>
	
	<div id="main-content" class="clearfix">
	
    <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li> 
				<i class="icon-leaf"></i>
				<span class="divider"></span>
				<span href="#">核保管理</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>核保规则</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>核保规则列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="javascript:window.location.href='/ungstd/addrule.jsp'" type="reset">+新增</button>
           		</div>
			</div>

      <div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline form-inline-list">
						<div class="row-fluid">
							<div class="span3">
								<label>规则名称</label>
                          		<input type="text" class="form-control" id="rule_name" placeholder="请输入规则名称">
							</div>
							<div class="span3">
								<label>规则类型</label>
                          		<select class="form-control" id="rule_type">
                          			<option value="0">选择规则类型</option>
                          			<option value="1">通用</option>
                          			<option value="2">类目</option>
                          			<option value="3">产品</option>
                          		</select>
							</div>
						</div>
                           <!-- <div class="form-group" style="line-height: 30px;">
                           		<label>规则名称</label>
                          		<input type="text" class="form-control mar-t-15 w150" id="rule_name" placeholder="请输入规则名称">
                          		<label>规则类型</label>
                          		<select class="form-control w150" id="rule_type">
                          			<option value="0">选择规则类型</option>
                          			<option value="1">通用</option>
                          			<option value="2">类目</option>
                          			<option value="3">产品</option>
                          		</select>
                          	</div> -->
                          	<!-- <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" onclick="javascript:window.location.href='/ungstd/addrule.jsp'" type="reset">+新增</button>
	                       </div> -->
                        </div>
                        <div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn mar-l-15  btn-info" id="find" type="reset">搜索</button>
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
										<th>规则ID</th>
										<th>规则名称</th>
										<th>规则描述</th>
										<th>类型</th>
										<th>核保项/正常值</th>
										<th>状态</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist"><!--
									<tr>
										<td>#{rule_id}</td>
										<td>#{rule_name}</td>
										<td>#{rule_desc}</td>
										<td>@{getType}</td>
										<td>#{rule_item_total}/#{rule_normal_total}</td>
										<td>@{getState}</td>
										<td>#{create_time@formatdate}</td>
										<td>@{getLink}</td>
									</tr>
                                --></tbody>
							</table>
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
	XCOTemplate.pretreatment(['datalist']);
	var renderPage = true;
	xdoRequest(0,50);
	/* 获取责任项序号列表 */
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setStringValue("rule_name", $("#rule_name").val());
		xco.setIntegerValue("rule_type", $("#rule_type").val());
		var options = {
			url : "/rules/getRules.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	/* 停用或者禁用 */
	function startOrStop(id,state) {
	var stateName = "";
		if(state==1){
					stateName = "启用";
				}else{
					stateName = "停用";
				}
		var xco = new XCO();
		xco.setLongValue("rule_id",id);
		xco.setIntegerValue("state",state);
		var options = {
			url : "/rules/updateRulesState.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess(stateName+"成功！",function(){
						location.href="../ungstd/ruleList.jsp";
					});
				}
			}
		};
		axConfirm("确定"+ stateName +"该规则吗?",function(){
			$.doXcoRequest(options);
		})
	}
	/* 同步缓存 */
	function syncRuleCache(id) {
		var stateName = "";
		var xco = new XCO();
		xco.setLongValue("rule_id",id);
		var options = {
			url : "/ruleService/findKeyFromFormula.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess(stateName+"成功！",function(){
						location.href="../ungstd/ruleList.jsp";
					});
				}
			}
		};
		axConfirm("确定同步缓存吗?",function(){
			$.doXcoRequest(options);
		})
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
		$("#size").text(5);
		var dataList=data.get('list');
		if(!dataList){
			dataList=new Array();
		}
		/*
	    var html = '';
	    var ext = {
			getLink: function(xco){
				return '<a >编辑</a><br /><a href="###">删除</a>';
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	data.setIntegerValue("i", i);
        	html += XCOTemplate.execute("datalist", data, ext);
    	}
   		document.getElementById("datalist").innerHTML = html;*/
   		
	    var html = '';
	    var ext = {
			getLink: function(xco){
				var str = "";
				if(xco.get("rule_state")==1){
						str='<a href="/ungstd/updateRule.jsp?rule_id='+xco.get("rule_id")+'">编辑</a><br />'+
						/* '<a >删除</a><br />' + */
						'<a href="/ungstd/ruleItemList.jsp?rule_id='+xco.get("rule_id")+'">配置核保项</a><br />' +
						'<a href="/ungstd/normalList.jsp?rule_id='+xco.get("rule_id")+'">配置正常值</a><br />' +
						'<a style="cursor:pointer;" onclick="startOrStop('+xco.get("rule_id")+',0)">停用</a><br />' +
						'<a  style="cursor:pointer;color:red" title="清理缓存并抽取核保规则" onclick="syncRuleCache('+xco.get("rule_id")+')">同步缓存</a><br />';
						/*' <a >分级设置</a><br />' +
						'<a >预警设置</a><br />' +
						'<a >复制</a><br />' */
					}else{
						str='<a href="/ungstd/updateRule.jsp?rule_id='+xco.get("rule_id")+'">编辑</a><br />'+
						/* '<a >删除</a><br />' + */
						'<a href="/ungstd/ruleItemList.jsp?rule_id='+xco.get("rule_id")+'">配置核保项</a><br />' +
						'<a href="/ungstd/normalList.jsp?rule_id='+xco.get("rule_id")+'">配置正常值</a><br />' +
						'<a style="cursor:pointer;" onclick="startOrStop('+xco.get("rule_id")+',1)">启用</a><br />' +
						'<a style="cursor:pointer;color:red" title="清理缓存并抽取核保规则" onclick="syncRuleCache('+xco.get("rule_id")+')">同步缓存</a><br />';
						/*' <a >分级设置</a><br />' +
						'<a >预警设置</a><br />' +
						'<a >复制</a><br />'+ */
					}
				
				return str;
			},
			getType:function(xco){
				var name='';
				if(xco.get('rule_type')==1){
					name='通用';
					return name;
				}
				if(xco.get('rule_type')==2){
					name='类目';
					return name;
				}
				if(xco.get('rule_type')==3){
					name='产品';
					return name;
				}
			},
			getState:function(xco){
				if(xco.get("rule_state")==1){
					return '正常';
				}else{
					return '停用';
				}
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   		if (renderPage) {
			renderPage = false;
			pageUtil('pagination_1', parseInt(total), xdoRequest, pageSize);
		}		  
	}
	  
	$("#find").click(function(){
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
