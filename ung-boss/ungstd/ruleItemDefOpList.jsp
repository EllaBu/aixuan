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
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>类目和影响</title>
</head>
<body>
	<div id="main-content" class="clearfix">

    <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li> 
				<li><span >核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
        <li><span >核保项</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
		<li><span >异常检测定义</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
      <li><span>类目和影响</span><span class="divider"></span>
      </li>
    </ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>类目和影响</h1>
			</div>

      <div class="row-fluid">
				<!-- <div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
                          	<div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">搜索</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" onclick="window.location.href='/ungstd/addChannel.jsp'"  type="reset">+新增</button>
	                       </div>
                        </div>
					</div>
				</div> -->

				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>分类</th>
										<th>动作</th>
										<th>预警编码</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>#{rido_id}</td>
										<td>@{getSeries}</td>
										<td>@{getRidoOp}</td>
										<td>
										<input id="rido_coe#{rido_id}" type="text" class="form-control" value="#{rido_coe}">
										</td>
										<td>@{getLink}</td>
									</tr> -->
                                </tbody>
							</table>
							<label style="float: left;width: 40%;">查询结果总条数：<span id="total"></span>条</label>
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
	var rid_id = getURLparam("rid_id");
	var renderPage = true;
	xdoRequest(0,10);
	/* 获取责任项序号列表 */
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setLongValue("rid_id", rid_id);
		var options = {
			url : "/rules/getRulesOpsListByDefId.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
		//更新类目
	function updateRulesItemDefOp(rido_id) {
		var xco = new XCO();
		xco.setLongValue("rido_id", rido_id);
		xco.setIntegerValue("series_no",  $("#series_no"+rido_id).val());
		xco.setIntegerValue("rido_op", $("#rido_op"+rido_id).val());
		xco.setStringValue("rido_coe",  $("#rido_coe"+rido_id).val());
		var options = {
			url : "/rules/updateRulesOpsById.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定修改吗?",function(){
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
   		
	    var html = '';
	    var ext = {
			getLink: function(xco){
				return '<a style="cursor:pointer;" onclick="updateRulesItemDefOp('+xco.get("rido_id")+')">保存</a>';
			},
			getSeries: function(xco){
				var str = '<select id="series_no'+xco.get("rido_id")+'" style="width:100px;margin:0;">';
					if(xco.getIntegerValue("series_no")==0){
					str +='<option value="0" selected="selected">全部</option>'  +
								              '<option value="1">重疾险</option>' +
								              '<option value="2">寿险</option>' +
								              '<option value="3">癌症险</option></select>';
					}
					if(xco.getIntegerValue("series_no")==1){
					str +='<option value="0">全部</option>'  +
								              '<option selected="selected" value="1">重疾险</option>' +
								              '<option value="2">寿险</option>' +
								              '<option value="3">癌症险</option></select>';
					}
					if(xco.getIntegerValue("series_no")==2){
					str +='<option value="0">全部</option>'  +
								              '<option value="1">重疾险</option>' +
								              '<option selected="selected" value="2">寿险</option>' +
								              '<option value="3">癌症险</option></select>';
					}
					if(xco.getIntegerValue("series_no")==3){
					str +='<option value="0">全部</option>'  +
								              '<option value="1">重疾险</option>' +
								              '<option value="2">寿险</option>' +
								              '<option selected="selected" value="3">癌症险</option></select>';
					}
					return 	str;		             
			
			},
			getRidoOp: function(xco){
				var str = '<select id="rido_op'+xco.get("rido_id")+'" style="width:100px;margin:0;">';
					if(xco.getIntegerValue("rido_op")==10){
					str +='<option selected="selected" value="10">预警</option>'  +
								              '<option value="20">加费</option>' +
								              '<option value="30">减费</option>' +
								              '<option value="50">转人工</option>'+
								              '<option value="60">拒保</option>' +
								              '<option value="100">通过</option></select>';
					}
					if(xco.getIntegerValue("rido_op")==20){
					str +='<option  value="10">预警</option>'  +
								              '<option selected="selected" value="20">加费</option>' +
								              '<option value="30">减费</option>' +
								              '<option value="50">转人工</option>'+
								              '<option value="60">拒保</option>' +
								              '<option value="100">通过</option></select>';
					}
					if(xco.getIntegerValue("rido_op")==30){
					str +='<option value="10">预警</option>'  +
								              '<option value="20">加费</option>' +
								              '<option selected="selected" value="30">减费</option>' +
								              '<option value="50">转人工</option>'+
								              '<option value="60">拒保</option>' +
								              '<option value="100">通过</option></select>';
					}
					if(xco.getIntegerValue("rido_op")==50){
					str +='<option value="10">预警</option>'  +
								              '<option value="20">加费</option>' +
								              '<option value="30">减费</option>' +
								              '<option selected="selected" value="50">转人工</option>'+
								              '<option value="60">拒保</option>' +
								              '<option value="100">通过</option></select>';
					}
					if(xco.getIntegerValue("rido_op")==60){
					str +='<option value="10">预警</option>'  +
								              '<option value="20">加费</option>' +
								              '<option value="30">减费</option>' +
								              '<option value="50">转人工</option>'+
								              '<option selected="selected" value="60">拒保</option>' +
								              '<option value="100">通过</option></select>';
					}
					if(xco.getIntegerValue("rido_op")==100){
					str +='<option value="10">预警</option>'  +
								              '<option value="20">加费</option>' +
								              '<option value="30">减费</option>' +
								              '<option value="50">转人工</option>'+
								              '<option value="60">拒保</option>' +
								              '<option selected="selected" value="100">通过</option></select>';
					}
					return 	str;		             
			
			},
			
			
			
			
			
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
