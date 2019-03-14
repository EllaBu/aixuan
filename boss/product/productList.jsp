<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品总表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>产品总表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-file-alt"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li>产品总表<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>产品总表</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline">
							<div class="form-group" style="line-height: 30px;">
								<label class="mar-l-15 mar-t-15">产品编号</label> 
								<input type="text" class="form-control mar-t-15 w150" id="productNo" placeholder="请输入产品编号"> 
								<label class="mar-l-15 mar-t-15">产品名称</label>
								<input type="text" class="form-control mar-t-15 w150" id="name" placeholder="请输入产品名称"> 
								<label class="mar-l-15 mar-t-15">业务状态</label>
								<select class="form-control mar-t-15 w150" id="mark">
									<option value="0">选择业务状态</option>
									<option value="1">未拆解</option>
									<option value="2">未导入</option>
									<option value="3">未打分</option>
									<option value="4">未生成综合分</option>
									<option value="5">未审核</option>
									<option value="11">已拆解</option>
									<option value="21">已导入</option>
									<option value="31">已打分</option>
									<option value="41">已生成综合分</option>
								</select> 
								<label class="mar-l-15 mar-t-15">所属公司</label> 
								<input type="text" class="form-control mar-t-15 w150" id="orgName" placeholder="请输入所属公司">
							</div>
							<div class="form-group">
								<label class="mar-l-15 mar-t-15">主产品编号</label> 
								<input type="text" class="form-control mar-t-15 w150" id="mainNo" placeholder="请输入主产品编号"> 
								<!-- <label class="mar-l-15 mar-t-15">销售状态</label> 
								<select class="form-control mar-t-15 w150">
									<option value="">选择销售状态</option>
									<option value="1">已上架</option>
									<option value="0">未上架</option>
								</select>  -->
								<label class="mar-l-15 mar-t-15">起始日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="startTime" placeholder="产品录入起始时间" onfocus="WdatePicker({readOnly:true})"> 
								<label class="mar-l-15 mar-t-15">结束日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="endTime" placeholder="产品录入结束时间" onfocus="WdatePicker({readOnly:true})">
								<label class="mar-l-15 mar-t-15">产品类型</label>
								<select class="form-control mar-t-15 w150" id="typeId">
								</select> 
							</div>
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
								<button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
								<button class="btn mar-t-15 mar-l-15  btn-success" id="addProduct" type="reset">新增产品</button>
							</div>
						</div>
					</div>
				</div>

				<div class="row-fluid">
					<div class="row-fluid mar-t-15">
						<div class="span12">
							<label style="color: #008800;">当前系统总共<span style="color: red;" id="size"></span>个产品</label>
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>产品编号</th>
										<th>公司名称</th>
										<th>产品全称</th>
										<th>产品类型</th>
										<th>合同类型</th>
										<th>主产品编号</th>
										<th>子产品编号</th>
										<th>销售状态</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].product_no}</td>
										<td>#{list[i].org_name}</td>
										<td>@{getName}</td>
										<td>#{list[i].type_name}</td>
										<td>@{getContractType}</td>
										<td>#{list[i].main_no}</td>
										<td>@{getSubProductNo}</td>
										<td>@{getSaleState}</td>
										<td>@{getState}</td>
										<td>@{getOpt}</td>
									</tr> -->
								</tbody>
							</table>
							<label style="float: left;width: 40%;">查询结果总条数：<span id="total"></span>条</label>
							<jsp:include page="../common/page.jsp" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/gradePublic.js" ></script>
<script type="text/javascript">
    
    $("#reset").click(function(){
    	var array = ["#productNo","#name","#orgName","#mainNo","#startTime","#endTime"];
    	resetInput(array);
    	$("#mark").val(0);
    	$("#typeId").val(0);
    })
    
    initSelectOption("typeId","/dic/twoLevelSeriesList2.xco","series_no","series_name");
    
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#search").click(function(){
		renderPage = true;
		getProductListPage(0,pageSize);
	});
	
	$("#addProduct").click(function(){
		location.href = "../product/addProduct.jsp";
	});
	
	getProductListPage(0,pageSize);
	
	/*获取产品总列表*/
	function getProductListPage(_start,_pageSize) {
		var xco = new XCO();
		
		var productNo = $("#productNo").val();
		if(productNo){
			xco.setStringValue("productNo", productNo);
		}
		
		var name = $("#name").val();
		if(name){
			xco.setStringValue("name", name);
		}
		
		var orgName = $("#orgName").val();
		if(orgName){
			xco.setStringValue("orgName", orgName);
		}
		
		var mainNo = $("#mainNo").val();
		if(mainNo){
			xco.setLongValue("mainNo", mainNo);
		}
		
		var mark = $("#mark").val();
		if(mark){
			if(mark==1){
				xco.setIntegerValue("mark1", 0);
			}
			if(mark==2){
				xco.setIntegerValue("mark2", 0);
			}
			if(mark==3){
				xco.setIntegerValue("mark3", 0);
			}
			if(mark==4){
				xco.setIntegerValue("mark4", 0);
			}
			if(mark==5){
				xco.setIntegerValue("mark", 0);
			}
			if(mark==11){
				xco.setIntegerValue("mark1", 1);
			}
			if(mark==21){
				xco.setIntegerValue("mark2", 1);
			}
			if(mark==31){
				xco.setIntegerValue("mark3", 1);
			}
			if(mark==41){
				xco.setIntegerValue("mark4", 1);
			}
		}
		
		var startTime = $("#startTime").val();
		if(startTime){
			xco.setStringValue("startTime", startTime);
		}
		
		var endTime = $("#endTime").val();
		if(endTime){
			xco.setStringValue("endTime", endTime);
		}
		
		var typeId = $("#typeId").val();
		if(typeId!=0&&typeId!=null){
			xco.setStringValue("sub_type_id", typeId);
		}
		
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);

		var options = {
			url : "/product/getProductListPage.xco",
			data : xco,
			success : getOrgListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取公司列表成功回调*/
	function getOrgListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			var size = 0;
			data = data.getData();
			total = data.getIntegerValue("total");
			size = data.getIntegerValue("size");
			var len = 0;
			var list = data.getXCOListValue("list");
			$("#total").text(total);
			$("#size").text(size);
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getName : function(){
					var name = list[i].getStringValue("name");
					var contract_url = "http://test.file.aixbx.com"+list[i].getStringValue("contract_url");
					return '<a target="_blank" href="'+contract_url+'">'+name+'</a>';
				},
				getContractType : function(){//合同类型[0:主合同, 1:附加合同, 2:组合产品]
					var contractType = list[i].getIntegerValue("contract_type");
					if(contractType==0){
						return '主合同';
					}
					if(contractType==1){
						return '附加合同';
					}
					if(contractType==2){
						return '组合产品';
					}
				},
				getSubProductNo : function(){//子产品编号集合[12,13],需要有序
					var subProductNo = list[i].getStringValue("sub_product_no");
					if(subProductNo){
						var regExp = new RegExp(",","g"); //定义正则表达式
						subProductNo = subProductNo.replace(regExp, "<br>"); 
					}
					return subProductNo;
				},
				getSaleState : function(){//销售状态[0:不可售, 1:可销售]
					var on_sale = list[i].getIntegerValue("on_sale");
					//if(on_sale==1){
					if(on_sale==0){	
						return '停售';
					}
					return '在售';
				},
				getState : function(){
					var mark1 = list[i].getIntegerValue("mark1");//拆解标记[0:N, 1:Y]
					var mark2 = list[i].getIntegerValue("mark2");//价格分导入标记[0:N, 1:Y]
					var mark3 = list[i].getIntegerValue("mark3");//剩余分录入标记[0:N, 1:Y]
					var mark4 = list[i].getIntegerValue("mark4");//综合分计算标记[0:N, 1:Y]
					var mark5 = list[i].getIntegerValue("mark5");//是否有产品病种详情[0:N, 1:Y]
					var mark6 = list[i].getIntegerValue("mark6");//责任打分操作标记[0:N, 1:Y]
					var mark7 = list[i].getIntegerValue("mark7");//病种打分操作标记[0:N, 1:Y]
					var series_no = list[i].getIntegerValue("series_no");//二级分类id
					var audit_status = list[i].getIntegerValue("audit_status");
					var icdMark = list[i].getIntegerValue("icd_mark");
					var productId = list[i].getLongValue("product_id");
					var product_no = list[i].getLongValue("product_no");
					var stateStr = '';
					if(icdMark==1){
						if(mark1==0){
							stateStr += '未拆解';
						}else{
							stateStr += '已拆解';
							if(audit_status==0){
								stateStr += '<br>未审核';
							}else{
								stateStr += '<br>已审核';
							}
						}
						if(mark2==0){
							stateStr += '<br>未导入';
						}else{
							stateStr += '<br>已导入';
							stateStr += '<br><a href="../product/productScoreList.jsp?productId='+productId+'">产品分</a>';
						}
						if(mark3==0){
							stateStr += '<br>未打分';
						}else{
							stateStr += '<br>已打分';
						}
						var duty = isDuty(series_no);
						if(duty){
							if(mark6==0){
								stateStr += '<br>未打责任分';
							}else{
								stateStr += '<br>已打责任分';
							}							
						}
						var disease = isDisease(series_no);
						if(disease){
							if(mark7==0){
								stateStr += '<br>未打病种分';
							}else{
								stateStr += '<br>已打病种分';
							}						
						}						
						if(mark4==0){
							stateStr += '<br>未生成综合分';
						}else{
							stateStr += '<br>已生成综合分';
						}
						if(mark5==1){
							stateStr += '<br><a href="../disease/productDisease.jsp?product_no='+product_no+'">产品病种详情</a>';
						}

					}else{
						stateStr += '非拆解';
					}
					return stateStr;
				},
				getOpt : function(){
					var icdMark = list[i].getIntegerValue("icd_mark");
					var remark1 = list[i].getStringValue("remark1");
					var mark1 = list[i].getIntegerValue("mark1");//拆解标记[0:N, 1:Y]
					var audit_status = list[i].getIntegerValue("audit_status");
					var optHtml = '<a href="../product/updateProduct.jsp?productNo='+list[i].getStringValue("product_no")+'">编辑</a>';
					if(icdMark==1){
						optHtml += '<br><a href="../product/dutyProduct.jsp?productNo='+list[i].getStringValue("product_no")+'">拆解</a>';
						if(mark1==1&&audit_status==0){
							optHtml += '<br><a href="../product/dutyProductForStatus.jsp?productNo='+list[i].getStringValue("product_no")+'">审核</a>';
						}
						if(remark1=="Y"){
							var importPriceScoreUrl = '../product/addPriceScore.jsp?productNo='+list[i].getStringValue("product_no")+'&productName='+list[i].getStringValue("name")+'&productId='+list[i].getLongValue("product_id");
							importPriceScoreUrl =  encodeURI(encodeURI(importPriceScoreUrl));
							optHtml += '<br><a href="'+importPriceScoreUrl+'">价格分导入</a>';
						}
						var duty = isDuty(list[i].getLongValue("series_no"));
						if(duty){
							var setDutyScoreUrl = '../grade/grade.jsp?product_no='+list[i].getStringValue("product_no")+'&name='+list[i].getStringValue("name")+'&sub_type_id='+list[i].getLongValue("series_no")+'&sub_type_name='+list[i].getStringValue("series_name")+'&oc_score_type=1';
							optHtml += '<br><a href="'+setDutyScoreUrl+'">责任项打分</a>';
						}
						var disease = isDisease(list[i].getLongValue("series_no"));
						if(disease){
							var setDiseaseScoreUrl = '../grade/grade.jsp?product_no='+list[i].getStringValue("product_no")+'&name='+list[i].getStringValue("name")+'&sub_type_id='+list[i].getLongValue("series_no")+'&sub_type_name='+list[i].getStringValue("series_name")+'&oc_score_type=2';
							optHtml += '<br><a href="'+setDiseaseScoreUrl+'">病种项打分</a>';
						}						
						var setPriceScoreUrl = '../product/setPriceScore.jsp?productNo='+list[i].getStringValue("product_no")+'&productName='+list[i].getStringValue("name")+'&productId='+list[i].getLongValue("product_id");
						setPriceScoreUrl =  encodeURI(encodeURI(setPriceScoreUrl));
						optHtml += '<br><a href="'+setPriceScoreUrl+'">综合项打分</a>';
					}
					optHtml += '<br><a href="javascript:delProduct(\''+list[i].getStringValue("product_no")+'\')">删除</a>'
					return optHtml;
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getProductListPage, pageSize);
			}
		}
	}
	
	
	function delProduct(productNo){
		var xco = new XCO();
		xco.setStringValue("productNo",productNo);
		
		var options = {
			url : "/product/delProduct.xco",
			data : xco,
			success : delProductCallBack
		};
		axConfirm("确定删除该产品吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	function delProductCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			location.reload();
		}
	}
</script>