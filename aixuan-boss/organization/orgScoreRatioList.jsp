<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "评分配比";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>评分配比</title>
</head>
<body>
	<div id="main-content" class="clearfix">
		
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>保险公司管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>评分配比管理<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>评分配比管理</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="display: none;">
					<div class="span12">
						<div  class="form-inline">
	                       <div class="form-group" style="line-height:30px;">
                           		<label>产品类型</label>
                          		<input class="form-control w150" id="twoLevelSeries" type="text"/>
                          		<input class="form-control w150" id="product_type" type="hidden"/>
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find">查询</button>
                               	<button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addScoreRatio">新增</button>
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
										<th>公司%</th>
										<th>风控能力%</th>
										<th>服务%</th>
										<th>价格%</th>
										<th>责任%</th>
										<th>内部收益率%</th>
										<th>历史收益率%</th>
										<th>最低保证利率%</th>
										<th>费用率%</th>
										<th>病种%</th>
										<th>更新日期</th>
										<th style="width:30px; !important">操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].series_name}</td>
										<td>@{getOne}</td>
										<td>@{getTwo}</td>
										<td>@{getThree}</td>
										<td>@{getFour}</td>
										<td>@{getFive}</td>
										<td>@{getSix}</td>
										<td>@{getSeven}</td>
										<td>@{getEight}</td>
										<td>@{getNine}</td>
										<td>@{getTen}</td>
										<td>#{list[i].update_time}</td>
										<td>@{getOpt}</td>
									</tr> -->
                                </tbody>
							</table>
                            
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
	var renderPage = true;//分页
	var getAllSeriesList = [];//分类列表
	var treeNode = null;
	var treeMap = null;
	var serialNum = 0;//序号
	
	$("#reset").click(function(){
		var array = ["#twoLevelSeries","#product_type"];
		resetInput(array);
	})
	/* 输入框自动提示控件 */
	$.setAutoComplete({
		ainId:"#twoLevelSeries",//搜索框ID
		url:"/dic/twoLevelSeriesList.xco",//请求地址
		isAutoFocus:false,//是否需要默认选中第一项。
		setXCO:function(event){//传参
			$("#product_type").val("");
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
			$("#product_type").val(item.lable);
		},
		select : function(event, item) {//item相当于callback里的result
			$("#twoLevelSeries").val(item.value);
			$("#product_type").val(item.lable);
		}
	});
    
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		var twoLevelSeries = $("#twoLevelSeries").val();
		if(!twoLevelSeries){
			$("#product_type").val("");
		}
		getOrgScoreListPage(0,pageSize);
	});
	
	$("#addScoreRatio").click(function(){
		location.href = "../organization/addOrgScoreRatio.jsp";
	});
	
	getOrgScoreListPage();
	
	/*获取评分配比列表分页*/
	function getOrgScoreListPage() {
		var xco = new XCO();

		var options = {
			url : "/org/getOrgScoreRatioListPage.xco",
			data : xco,
			success : getOrgScoreRatioListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取评分配比列表分页成功回调*/
	function getOrgScoreRatioListPageCallBack(xco) {
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
		var list1 = data.getXCOListValue("list");
		var list2 = data.getXCOListValue("list2");
		if(list1==null){
			return;
		}
		if(list2!=null){
			for ( var i = 0; i < list1.length; i++) {
				for ( var j = 0; j < list2.length; j++) {
					if(list1[i].getLongValue("series_no")==list2[j].getLongValue("series_no")){
						list1[i].setStringValue("update_time",list2[j].getStringValue("update_time"));
						list1[i].setStringValue("scorelist",list2[j].getStringValue("scorelist"));
					}
				}
			}
		}
		
		
		
		getAllSeriesList = list1;
		listToTree();

		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
	}
	
	function getOne(scorelist){
		var reStr = scorelist.split(",")[0];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getTwo(scorelist){
		var reStr = scorelist.split(",")[1];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getThree(scorelist){
		var reStr = scorelist.split(",")[2];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getFour(scorelist){
		var reStr = scorelist.split(",")[3];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getFive(scorelist){
		var reStr = scorelist.split(",")[4];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getSix(scorelist){
		var reStr = scorelist.split(",")[5];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getSeven(scorelist){
		var reStr = scorelist.split(",")[6];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getEight(scorelist){
		var reStr = scorelist.split(",")[7];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	function getNine(scorelist){
		var reStr = scorelist.split(",")[8];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function getTen(scorelist){
		var reStr = scorelist.split(",")[9];
		if(reStr != 0){
			return parseFloat(reStr/scoreRatio);
		}else{
			return 0;
		}
	}
	
	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var seriesName1 = '';
			var seriesName2 = '';
			var typeName = node.typeName;
			var opt = node.opt;
			var size = node.size;
			var scorelist = node.scorelist;
			var update_time = node.update_time;
			
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
			if(scorelist!=null&&scorelist!=''){
				html += '	<td>'+getOne(scorelist)+'</td>';
				html += '	<td>'+getTwo(scorelist)+'</td>';
				html += '	<td>'+getThree(scorelist)+'</td>';
				html += '	<td>'+getFour(scorelist)+'</td>';
				html += '	<td>'+getFive(scorelist)+'</td>';
				html += '	<td>'+getSix(scorelist)+'</td>';
				html += '	<td>'+getSeven(scorelist)+'</td>';
				html += '	<td>'+getEight(scorelist)+'</td>';
				html += '	<td>'+getNine(scorelist)+'</td>';
				html += '	<td>'+getTen(scorelist)+'</td>';
				html += '	<td>'+update_time+'</td>';
				var url = '../organization/updateOrgScoreRatio.jsp?seriesNo='+opt+'&seriesName='+seriesName2;
				url =  encodeURI(encodeURI(url));
				html += '<td><a href="'+url+'">编辑</a></td>';
			}else{
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				html += '	<td></td>';
				if(node.level==2){
					var url = '../organization/addOrgScoreRatio.jsp?seriesNo='+opt+'&seriesName='+seriesName2;
					url =  encodeURI(encodeURI(url));
					html += '	<td><a href="'+url+'">新增</a></td>';
				}else{
					html += '	<td></td>';
				}
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
			scorelist : '',
			update_time : '',
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
				scorelist : xco.get('scorelist'),
				update_time : xco.getStringValue('update_time'),
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