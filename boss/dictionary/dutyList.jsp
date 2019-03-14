<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String pageName = "责任项维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>责任项维护</title>
<style type="text/css">
.scrollbar::-webkit-scrollbar {/*滚动条整体样式*/
    width: 5px;     /*高宽分别对应横竖滚动条的尺寸*/
    height: 1px;
}
.scrollbar::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
    border-radius: 20px;
     -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
    background: #ccc;
}
.scrollbar::-webkit-scrollbar-track {/*滚动条里面轨道*/
    -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
    border-radius: 20px;
    background: #efefef;
}
</style>
</head>
<body>

	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>责任项维护</a></li>

			</ul>
			<!--.breadcrumb-->
		</div>
		<!--#breadcrumbs-->

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>责任项维护</h1>
			</div>
			<!--/page-header-->
			<!--<div class="row-fluid"></div>-->
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
						   <div class="form-group" style="line-height: 30px;">
                              	 <label class="mar-l-15">一级责任项</label>
                              	 <select class="form-control w150" id="dutyLevelOne"></select>
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addDutyLevelOne" type="reset">新增一级责任项</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addDutyLevelTwo" type="reset">新增二级责任项</button>
	                       </div>
                        </div>
					</div>
				</div>
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>一级责任项</th>
										<th>二级责任项</th>
										<th>文本类型</th>
										<th>排序</th>
										<th>标准值</th>
										<th>特殊标识</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	$("#reset").click(function(){
		$("#dutyLevelOne").val(0);
	})
	//初始化一级名称
	initSelectOption("dutyLevelOne","/dic/oneLevelDutyList.xco","duty_id","duty_name");
	
	var renderPage = true;//分页
	var getAllDutyList = [];//分类列表
	var treeNode = null;
	var treeMap = null;
	var serialNum = 0;//序号

	/*搜索查询责任项列表*/
	$("#search").click(function(){
		renderPage = true;
		getDutyList();
	})
	
	
	/* 获取责任项列表 */
	function getDutyList() {
		serialNum = 0;
		var xco = new XCO();
		var dutyLevelOne = $("#dutyLevelOne").val();
		if(dutyLevelOne!=0 && dutyLevelOne!="" &&dutyLevelOne!=null){
			xco.setLongValue("dutyLevelOne",dutyLevelOne);
		}
		
		var options = {
			url : "/dic/getDutyList.xco",
			data : xco,
			success : getDutyListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取责任项列表成功回调 */
	function getDutyListCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		var data = xco.getData();
		if (null == data) {
			return;
		}
		
		var total = data.getXCOValue("total");
		if(total==0){
			return;
		}

		getAllDutyList = data.getXCOListValue("list");
		listToTree();
		
		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
	}

	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var dutyName1 = '';
			var dutyName2 = '';
			var typeName = node.typeName;
			var sort = node.sort;
			var opt = node.opt;
			
			if(node.level == 1){
				dutyName1 = node.dutyName;
				html += '<tr>';
				html += '	<td>'+(++serialNum)+'</td>';
				html += '	<td>'+dutyName1+'</td>';
				html += '	<td>'+dutyName2+'</td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td><div style="float:left"><a href="updateDutyLevelOne.jsp?dutyId='+opt+'">编辑</a></div></td>';
				html += '</tr>';
			} else {
				dutyName2 = node.dutyName;
				html += '<tr>';
				html += '	<td>'+(++serialNum)+'</td>';
				html += '	<td>'+dutyName1+'</td>';
				html += '	<td>'+dutyName2+'</td>';
				if(node.inputType==1){
					html += '	<td>文本框</td>';
				}else if(node.inputType==2){
					html += '	<td>文本域</td>';
				}else{
					html += '	<td>单选:是/否</td>';
				}
				html += '	<td>'+sort+'</td>';
				if(node.standardType==0){
					html += '	<td>N</td>';
				}else{
					html += '	<td>Y</td>';
				}
				if(node.itemType==1){
					html += '	<td>普通</td>';
				}else{
					html += '	<td>特殊</td>';
				}
				if(node.standardType==0){
					html += '	<td><div style="float:left"><a href="updateDutyLevelTwo.jsp?dutyId='+opt+'">编辑</a>&nbsp;&nbsp;<a href="../duty/allDuty.jsp?duty_id='+opt+'&duty_name='+dutyName2+'">值管理</a></div></td>';
				}else{
					html += '	<td><div style="float:left"><a href="updateDutyLevelTwo.jsp?dutyId='+opt+'">编辑</a>&nbsp;&nbsp;<a href="###" onclick="openAddRoleDialog('+opt+',\''+dutyName2+'\')">标准值</a>&nbsp;&nbsp;<a href="../duty/allDuty.jsp?duty_id='+opt+'&duty_name='+dutyName2+'">值管理</a></div></td>';
				}
				
				html += '</tr>';
			}
		}
		var children = node.children;
		for(var i=0; i<children.length; i++){
			html += traversalTree(children[i]);
		}
		return html;
	}
	
	function listToTree() {
		treeNode = {
			parent : null,
			dutyId : '0',
			dutyName : '',
			level : 0,
			sort : '',
			inputType : 0,
			itemType : 0,
			standardType : 0,
			opt : '',
			children : []
		};
		treeMap = [];
		treeMap[treeNode.dutyId] = treeNode;
		var len = getAllDutyList.length;
		for ( var i = 0; i < len; i++) {
			var xco = getAllDutyList[i];
			var parent = treeMap['' + xco.get('f_id')];
			var node = {
				parent : parent,
				dutyId : '' + xco.get('duty_id'),
				dutyName : xco.get('duty_name'),
				level : xco.get('level'),
				sort : xco.get('sort'),
				inputType : xco.get('input_type'),
				itemType : xco.get('item_type'),
				standardType : xco.get('standard_type'),
				opt : xco.get('duty_id'),
				children : []
			};
			if (parent) {
				parent.children.push(node);
			} else {
				throw "Missing parent:" + xco.get('duty_name');
			}
			treeMap[node.dutyId] = node;
		}
	}
	
	getDutyList();
	
	/* 新增一级分类按钮点击事件 */
	$("#addDutyLevelOne").click(function(){
		location.href="../dictionary/addDutyLevelOne.jsp";
	})

	/* 新增二级分类按钮点击事件 */
	$("#addDutyLevelTwo").click(function(){
		location.href="../dictionary/addDutyLevelTwo.jsp";
	})
	
	/* 打开标准值弹窗 */
	function openAddRoleDialog(dutyId,dutyName) {
		layer.open({
			type: 1,  
	        skin:'layui-layer-rim',  
	        area:['800px', '600px'],
	        content: 
        	 '<div class="row" style="width: 770px;  margin-left:15px; margin-top:10px;">'  
	            +'<div class="input-group" style="line-height:30px;">'  
		            +'<lable>二级责任项</lable>'  
		            +'<span id="roleName" style="margin-left:15px;">'+dutyName+'</span>'  
		            +'<button class="btn btn-info" style="float:right;" id="addDutyStandard">新增标准值</button>'
	            +'</div>'  
	            +'<div class="input-group scrollbar" style="margin-top:10px;height:300px;overflow:auto;">'  
	           		+'<table class="table table-striped table-bordered table-hover" style="margin-top:0px;margin-bottom:0px;">' 
           				+'<thead>' 
           					+'<tr>' 
           						+'<th style="width:10%;">序号</th>' 
           						+'<th style="width:70%;">标准值</th>' 
           						+'<th style="width:20%;">操作</th>' 
           					+'</tr>' 
           				+'</thead>' 
           				+'<tbody id="listgroup2">'
           				+'</tbody>'
           			+'</table>' 
	            +'</div>'  
            +'</div>'
            +'<div class="row" style="width: 770px;  margin-left:15px; margin-top:10px;display:none;" id="inputDutyStandard">' 
	            +'<div class="input-group" style="margin-top:10px;position: relative;">'  
		            +'<lable style="position: relative;bottom:23px;width:10%;display:inline-block;">　　标准值</lable>'  
		            +'<textarea id="content" rows="3" type="text" class="form-control" placeholder="请输入标准值" style="display:inline;resize:none;width:88%;"></textarea>'  
		        +'</div>'  
	            +'<div class="input-group" style="position: relative;">'  
		            +'<lable style="position: relative;bottom:15px;width:10%;display:inline-block;">　　　序号</lable>'  
		            +'<input id="sort" type="text" class="form-control" placeholder="请输入序号" style="display:inline;width:88%;">'  
		            +'<input id="dutyStandardId" type="hidden" class="form-control">'  
		        +'</div>'  
		        +'<div class="input-group" style="position: relative;float:right;padding-bottom:15px;">' 
		        	+'<button class="btn btn-success" id="saveDutyStandard" style="margin-right:15px;">保存</button>'
		        	+'<button class="btn btn-info" id="cancel">取消</button>'
		        +'</div>'  
            +'</div>'
            , 
			scrollbar:false,
			success:function(layero, index){
				getDutyStandardList(dutyId);
				
				$("#addDutyStandard").click(function(){
					$("#content").val("");
					$("#sort").val("");
					$("#dutyStandardId").val("");
					$("#inputDutyStandard").slideDown();
				})
				$("#cancel").click(function(){
					$("#inputDutyStandard").slideUp();
				})
				/* 保存二级责任项标准值 */
				$("#saveDutyStandard").click(function(){
					var xco = new XCO();
					xco.setLongValue("dutyId",dutyId);
					var content = $("#content").val();
					if(content){
						if(content.length>2048){
							axError("标准值长度过长！");
							return;
						}else{
							xco.setStringValue("content",content);
						}
					}else{
						axError("请填写标准值！");
						return;
					}

					var sort = $("#sort").val();
					if(sort){
						xco.setStringValue("sort",sort);
					}else{
						axError("请填写标准值排序！");
						return;
					}
					var dutyStandardId = $("#dutyStandardId").val();
					if(dutyStandardId){
						xco.setLongValue("dutyStandardId",dutyStandardId);
						xco.setStringValue("sys_op_log","编辑二级责任项标准值-编辑："+$("#content").val());
					}else{
						xco.setStringValue("sys_op_log","新增二级责任项标准值-新增："+$("#content").val());
					}
					
					var options = {
						url : "/dic/insertAndUpdateDutyStandard.xco",
						data : xco,
						success : function(xco){
							if(xco.getCode()!=0){
								axError(xco.getMessage());
							}else{
								getDutyStandardList(dutyId);
								$("#inputDutyStandard").slideUp();
							}
						}
					};
					axConfirm("确认此操作吗?",function(){
						$.doXcoRequest(options);
						layer.close(layer.index);
					})
				})
			}
		});
	}
	
	/* 二级责任项标准值列表 */
	function getDutyStandardList(dutyId){
		var xco = new XCO();
		xco.setLongValue("dutyId",dutyId);
		
		var options = {
			url : "/dic/getDutyStandardList.xco",
			data : xco,
			success : function(xco){
				if(xco.getCode()!=0){
					axError(xco.getMessage());
				}else{
					var data = xco.getData();
					var len = data.getXCOValue("total");
					var list = data.getXCOListValue("list");
					var html='';
					if(len!=0){
						for(var i = 0; i<len; i++){
							html += '<tr>';
							html += '	<td>'+list[i].getIntegerValue("sort")+'</td>';
							//html += '	<td>'+list[i].getStringValue("content")+'</td>';
							html += '	<td>'+list[i].getStringValue("content").replace(new RegExp("\n","g"),"<br/>")+'</td>';
							html += '	<td><a herf="###" onclick="updateDutyStard('+list[i].getLongValue("duty_standard_id")+',\''+list[i].getIntegerValue("sort")+'\',\''+encodeToXMLText(list[i].getIntegerValue("content"))+'\');">编辑</a></td>';
							html += '</tr>';
						}
						$("#listgroup2").html(html);
					}
				}
			}
		};
		$.doXcoRequest(options);
	}
	
	function updateDutyStard(dutyStandardId,sort,content){
		$("#inputDutyStandard").slideDown();
		$("#dutyStandardId").val(dutyStandardId);
		$("#sort").val(sort);
		$("#content").val(content.replace(new RegExp("\\$N\\$","g"),"\n"));
	}
</script>