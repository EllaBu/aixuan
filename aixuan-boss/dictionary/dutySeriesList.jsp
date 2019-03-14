<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "映射维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>映射维护</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>映射维护</a><span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>映射维护</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="display: none;">
					<div class="span12">
						<div  class="form-inline">
                           <div class="form-group">
                           		<label>二级分类</label>
                          		<input class="form-control w150" id="twoLevelSeries" type="text"/>
                          		<input class="form-control w150" id="twoLevelSeriesId" type="hidden"/>
	                       </div>
	                       <div class="form-group">
	                       		<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
	                       		<button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
	                       </div>
                        </div>
					</div>
				</div>
				
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>一级分类名称</th>
										<th>二级分类名称</th>
										<th>前端显示名称</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{i+1}</td>
										<td>#{list[i].series_name}</td>
										<td>@{getOpt}</td>
									</tr> -->
                                </tbody>
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
		var array = ["#twoLevelSeries","#twoLevelSeriesId"];
		resetInput(array);
	})
	/* 输入框自动提示控件 */
	$.setAutoComplete({
		ainId:"#twoLevelSeries",//搜索框ID
		url:"/dic/twoLevelSeriesList.xco",//请求地址
		isAutoFocus:false,//是否需要默认选中第一项。
		setXCO:function(event){//传参
			$("#twoLevelSeriesId").val("");
			var xco = new XCO();
			xco.setStringValue("inputValue",$(event).val());
			return xco;
		},
		callback:function(item){//需要的参数 item是list里单个xco对象
			var result={//这里的值会在下边用的
				lable : item.getLongValue("series_no"),
				value : item.getStringValue("series_name")
			}
			return result;
		},
		focus:function(event,item){//item相当于callback里的result
			$("#twoLevelSeries").val(item.value);
			$("#twoLevelSeriesId").val(item.lable);
		},
		select : function(event, item) {//item相当于callback里的result
			$("#twoLevelSeries").val(item.value);
			$("#twoLevelSeriesId").val(item.lable);
		}
	});

    
	var renderPage = true;//分页
	var getAllSeriesList = [];//分类列表
	var treeNode = null;
	var treeMap = null;
	var serialNum = 0;//序号
    
	/* 按条件查询按钮 */
	$("#search").click(function(){
		renderPage = true;
		var twoLevelSeries = $("#twoLevelSeries").val();
		if(!twoLevelSeries){
			$("#twoLevelSeriesId").val("");
		}
		getDutySeries();
	});
	
	getDutySeries();
	
	/*获取映射关系列表*/
	function getDutySeries() {
		serialNum = 0;
		getAllSeriesList = [];
		treeNode = null;
		treeMap = null;
		
		var xco = new XCO();
		var twoLevelSeriesId = $("#twoLevelSeriesId").val();
		if(twoLevelSeriesId){
			xco.setLongValue("twoLevelSeriesId",twoLevelSeriesId);
		}

		var options = {
			url : "/dic/getDutySeriesList.xco",
			data : xco,
			success : getDutySeriesCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取系统用户列表成功回调*/
	function getDutySeriesCallBack(xco) {
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

		getAllSeriesList = data.getXCOListValue("list");
		listToTree();
		
		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
	}
	
	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var seriesName1 = '';
			var seriesName2 = '';
			var typeName = node.typeName;
			var opt = node.opt;
			var size = node.size;
			
			if(node.level == 1){
				seriesName1 = node.seriesName;
			} else {
				seriesName2 = node.seriesName;
			}
			
			html += '<tr>';
			html += '	<td>'+(++serialNum)+'</td>';
			html += '	<td>'+seriesName1+'</td>';
			html += '	<td>'+seriesName2+'</td>';
			html += '	<td>'+typeName+'</td>';
			if(node.level==2){
				if(size!=0){
					var url = '../dictionary/updateDutySeries.jsp?seriesNo='+opt+'&seriesName='+seriesName2;
					url =  encodeURI(encodeURI(url));
					html += '	<td><a href="'+url+'">编辑</a></td>';
				}else{
					var url = '../dictionary/addDutySeries.jsp?seriesNo='+opt+'&seriesName='+seriesName2;
					url =  encodeURI(encodeURI(url));
					html += '	<td><a href="'+url+'">绑定</a></td>';
				}
			}else{
				html += '	<td></td>';
			}
			html += '</tr>';
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
			seriesNo : '0',
			seriesName : '',
			typeName : '',
			level : 0,
			size : 0,
			opt : '',
			children : []
		};
		treeMap = [];
		treeMap[treeNode.seriesNo] = treeNode;
		var len = getAllSeriesList.length;
		for ( var i = 0; i < len; i++) {
			var xco = getAllSeriesList[i];
			var parent = treeMap['' + xco.get('f_id')];
			var node = {
				parent : parent,
				seriesNo : '' + xco.get('series_no'),
				seriesName : xco.get('series_name'),
				typeName : xco.get('type_name'),
				level : xco.get('level'),
				size : xco.get('size'),
				opt : xco.get('series_no'),
				children : []
			};
			if (parent) {
				parent.children.push(node);
			} else {
				throw "Missing parent:" + xco.get('series_name');
			}
			treeMap[node.seriesNo] = node;
		}
	}
</script>