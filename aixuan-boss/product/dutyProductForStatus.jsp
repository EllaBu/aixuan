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
<title>拆解审核</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-file-alt"></i><a>保险产品</a><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><a href="../product/productList.jsp">产品总表</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>拆解审核<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header crumbs-nav">
				<h1>拆解审核</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">产品信息</h4>
						</div>
						<div class="form-inline form-add1 bord1dd">
							
							<div class="from-group mar-t-15">
								<label>产品编号</label>
								<span id="productNo"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>产品名称</label>
								<span id="name"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>产品类型</label>
								<span id="subTypeName"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>合同类型</label>
								<span id="contractType"></span>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-info" onclick="showProductNoDalog();">选择复制产品</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="widget-header bord1dd">
							<h4 class="widget-title">一级责任项</h4>
						</div>
						<div class="form-inline form-add1 bord1dd">
							<div class="from-group mar-t-15">
								<div id="listgroup1">
									<!-- 
									<label class="pos-rel" style="text-align: left;width: auto;">
										<input type="checkbox" class="ace" name="oneLevelDuty" value="#{list[i].duty_id}" />
										<span class="lbl">#{list[i].duty_name}</span>
									</label>
									 -->
								</div>
							</div>
							<table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<tbody id="listgroup2"><!-- 
									<tr id="oneLvDuty#{list[i].duty_id}" style="display:none;">
										<td style="width:10%;">#{list[i].duty_name}</td>
										<td style="text-align: left !important;">
											<table border="0" style="width:100%;">
												<tbody id="dutyId_#{list[i].duty_id}">
												</tbody>
											</table>
										</td>
									</tr>
								 --></tbody>
							</table>
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<button class="btn btn-success mar-r-15" type="submit" id="save">审核</button>
							<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="listgroup3"><!--
		<tr>
			<td style="border-left-width: 0px;vertical-align: text-top;padding-top: 14px;text-align:right !important;width:15%;">#{list[i].duty_name}</td>
			<td style="border-left-width: 0px; width:75%;">@{inputType}</td>
			<td style="border-left-width: 0px;vertical-align: text-top;">@{standardType}</td>
		</tr>
	 -->
	</div>
</body>
</html>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	var productNo = getURLparam("productNo");
	var rows = 3;//文本域行数
	var productId = 0;
	var name = '';//产品名
	
	function getOneProductForSeries(){
		var xco = new XCO();
		xco.setStringValue("productNo",productNo);
		
		var options = {
			url : "/product/getOneProductForSeries.xco",
			data : xco,
			success : getOneProductForSeriesCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getOneProductForSeriesCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			var product = data.getXCOValue("product");
			var dutySeriesList = data.getXCOListValue("dutySeriesList");
			var dutyList = data.getXCOListValue("dutyList");
			
			var contractType = product.getIntegerValue("contract_type");
			if(contractType==0){
				$("#contractType").text("主合同");
			}else if(contractType==1){
				$("#contractType").text("附加合同");
			}else if(contractType==2){
				$("#contractType").text("组合产品");
			}
			
			name = product.getStringValue("name");
			
			$("#name").text(name);
			$("#productNo").text(product.getStringValue("product_no"));
			$("#subTypeName").text(product.getStringValue("sub_type_name"));
			productId = product.getLongValue("product_id");
			if(dutyList!=null){
				setDutyValue(dutyList);
			}else{
				if(dutySeriesList!=null){
					setDutySeriesShow(dutySeriesList);
				}
			}
		}
	}
	
	/* 渲染拆解值 */
	function setDutyValue(_dutyList){
		for ( var int = 0; int < _dutyList.length; int++) {
			var array_element = _dutyList[int];
			var duty_id = array_element.getLongValue("duty_id");
			$("input[name='oneLevelDuty'][value='"+duty_id+"']").attr("checked",true);
			$("#oneLvDuty"+duty_id).show();			
			$("#dutyId_"+duty_id+"_"+array_element.getLongValue("sub_duty_id")).val(array_element.getStringValue("str_val"));
			if(array_element.getLongValue("duty_standard_id")!=0){
				$("#standard_"+duty_id+"_"+array_element.getLongValue("sub_duty_id")).val(array_element.getLongValue("duty_standard_id"))
			}
		}
	}	
	
	function setDutySeriesShow(_dutySeriesList){
		for ( var int = 0; int < _dutySeriesList.length; int++) {
			var array_element = _dutySeriesList[int];
			var duty_id = array_element.getLongValue("duty_id");
			$("input[name='oneLevelDuty'][value='"+duty_id+"']").attr("checked",true);
			$("#oneLvDuty"+duty_id).show();	
		}
	}
	
	getDutyList()
	/* 获取责任项列表 */
	function getDutyList() {
		var xco = new XCO();
		
		var options = {
			url : "/dic/getDutyList.xco",
			data : xco,
			success : getDutyListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取责任项列表成功回调 */
	function getDutyListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			total = data.getIntegerValue("total");
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var listgroup1 = "";
			var listgroup2 = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				inputType : function(){
					var input_type = data.get("list[i].input_type");
					if(input_type==1){
						return '<input type="text" name="twoLevelDuty" style="width:100%;" id="dutyId_'+data.get("list[i].f_id")+'_'+data.get("list[i].duty_id")+'" />'
					}else if(input_type==2){
						return '<textarea rows='+rows+' type="text" style="width:100%;resize: none;" id="dutyId_'+data.get("list[i].f_id")+'_'+data.get("list[i].duty_id")+'"></textarea>'
					}
				},
				standardType : function(item){
					var standard_type = data.get("list[i].standard_type");
					if(standard_type==1){
						return '<button style="position: relative; top: -2px; left: 15px;" class="btn btn-info" onclick="showStandard(\''+data.get("list[i].duty_id")+'\',\''+data.get("list[i].duty_name")+'\',\''+data.get("list[i].f_id")+'_'+data.get("list[i].duty_id")+'\');">标准值</button><input type="hidden" id="standard_'+data.get("list[i].f_id")+'_'+data.get("list[i].duty_id")+'"/>';
					}
				}
			};
			
			var start = 0;
			
			for (var i = 0; i < len; i++) {
				if(list[i].getLongValue("f_id")==0){
					data.setIntegerValue("i", start);
					listgroup1 += XCOTemplate.execute('listgroup1', data, null);
					listgroup2 += XCOTemplate.execute('listgroup2', data, null);
					start++;
				}else{
					break;
				}
			}
			document.getElementById('listgroup1').innerHTML = listgroup1;
			document.getElementById('listgroup2').innerHTML = listgroup2;
			
			var listgroup3 =  [];
			
			var fId = list[start].getLongValue("f_id");
			while(start<len){
				var newfId = list[start].getLongValue("f_id");
				if(fId!=newfId){
					$("#dutyId_"+fId).html(listgroup3.toString());
					listgroup3 =  [];
					fId = newfId;
				}
				data.setIntegerValue("i", start);
				listgroup3.push(XCOTemplate.execute('listgroup3', data, extendedFunction));
				start++;
			}
			if(listgroup3.length>0){
				$("#dutyId_"+fId).html(listgroup3.toString());
			}
			
			$("input[name='oneLevelDuty']").change(function(){
				if($(this).is(":checked")){
					$("#oneLvDuty"+$(this).val()).show();
				}else{
					$("#oneLvDuty"+$(this).val()).hide();
				}
			})
		}
		getOneProductForSeries();
	}
	
	/* 标准值弹窗 */
	function showStandard(dutyId,dutyName,duty){
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
           				+'<tbody id="listgroup4">'
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
				getDutyStandardList(dutyId,duty);
				
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
								getDutyStandardList(dutyId,duty);
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
	function getDutyStandardList(dutyId,duty){
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
							html += '	<td>'+list[i].getStringValue("content").replace(new RegExp("\n","g"),"<br/>")+'</td>';
							html += '	<td><a href="javascript:updateDutyStard('+list[i].getLongValue("duty_standard_id")+',\''+list[i].getIntegerValue("sort")+'\',\''+encodeToXMLText(list[i].getStringValue("content"))+'\');">编辑</a>&nbsp;<a href="javascript:closeStandard('+list[i].getLongValue("duty_standard_id")+',\''+encodeToXMLText(list[i].getStringValue("content"))+'\',\''+duty+'\');">使用</a></td>';
							html += '</tr>';
						}
						$("#listgroup4").html(html);
						
						
						//html += '	<a href="javascript:updateDutyStard(\' '+ list[i].getLongValue("duty_standard_id") +' \',\'b\',0)">xxx</a>';
					}
				}
			}
		};
		$.doXcoRequest(options);
	}
	
	/* 选择标准时并关闭弹窗 */
	function closeStandard(dutyStandardId,content,duty){
		$("#dutyId_"+duty).val(content.replace(new RegExp("\\$N\\$","g"),"\n"));
		$("#standard_"+duty).val(dutyStandardId);
		layer.closeAll("page");
	}
	
	/* 修改标准值 */
	function updateDutyStard(dutyStandardId,sort,content){
		$("#inputDutyStandard").slideDown();
		$("#dutyStandardId").val(dutyStandardId);
		$("#sort").val(sort);
		$("#content").val(content.replace(new RegExp("\\$N\\$","g"),"\n"));
	}
	
	$("#save").click(function(){
		var xco = new XCO();
		xco.setStringValue("productNo",productNo);
		xco.setLongValue("productId",productId);
		
		var dutyValList = [];
		$("input[name='oneLevelDuty']").each(function(){
			if($(this).is(":checked")){
				var dutyIdStr = "dutyId_"+$(this).val();
				var dutyId = $(this).val();
				$("input[id^='"+dutyIdStr+"_']").each(function(){
					if($(this).val()!=null&&$(this).val()!=''){
						var item = new XCO();
						var inputId = $(this).attr("id");
						item.setLongValue("dutyId",dutyId);
						item.setLongValue("subDutyId",inputId.substring(dutyIdStr.length+1,inputId.length));
						item.setStringValue("strVal",$(this).val());
						var standard = $(this).parent().next().find("input");
						if(typeof standard != undefined){
							if(standard.val()!=''&&standard.val()!=null){
								item.setLongValue("dutyStandardId",standard.val());
							}
						}
						dutyValList.push(item);
					}
				});
				$("textarea[id^='"+dutyIdStr+"_']").each(function(){
					if($(this).val()!=null&&$(this).val()!=''){
						var item = new XCO();
						var textareaId = $(this).attr("id");
						item.setLongValue("dutyId",dutyId);
						item.setLongValue("subDutyId",textareaId.substring(dutyIdStr.length+1,textareaId.length));
						item.setStringValue("strVal",$(this).val());
						var standard = $(this).parent().next().find("input");
						if(typeof standard != undefined){
							if(standard.val()!=''&&standard.val()!=null){
								item.setLongValue("dutyStandardId",standard.val());
							}
						}
						dutyValList.push(item);
					}
				});
			}
		})
		
		if(dutyValList.length!=0){
			for ( var i = 0; i < dutyValList.length; i++) {
				var strVal = dutyValList[i].getStringValue("strVal");
				var dutyId = dutyValList[i].getLongValue("dutyId");
				var subDutyId = dutyValList[i].getLongValue("subDutyId");
				if(strVal.length>2048){
					axError($("#dutyId_"+dutyId+"_"+subDutyId).parent().prev().text()+"，文字长度过长！");
					return;
				}
			}
			xco.setXCOListValue("dutyValList",dutyValList);
		}else{
			axError("请填写责任值");
			return;
		}
		
		xco.setIntegerValue("audit_status",1);
		xco.setStringValue("sys_op_log","审核责任项："+name);
		
		var options = {
			url : "/product/insertDutyVal.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("审核成功！",function(){
						location.href="../product/productList.jsp";
					});
				}
			}
		};
		axConfirm("确认审核此次操作吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
	
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		//location.href="../product/productList.jsp";
		history.go(-1);
	})
	
	
	//产品选择弹窗
	function showProductNoDalog(){
		layer.open({
			type: 1,  
	        title:'选择要复制的产品',  
	        skin:'layui-layer-rim',  
	        area:['450px', 'auto'],
	        zIndex: 13,
	        content: 
        	 '<div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'  
	            +'<div class="input-group" style="position: relative;">'  
		            +'<lable style="position: relative;bottom:15px;left:15px;width:15%;">产品名称</lable>'  
		            +'<input id="productNoForDalog" type="text" class="form-control" style="margin-left:25px;width:75%;" placeholder="产品名称/编号">'  
		            +'<input id="nameForDalog" type="hidden">'  
	            +'</div>'  
            +'</div>'  
	        ,  
	        success: function(index,layero){
	        	/* 输入框自动提示控件 */
	        	$.setAutoComplete({
	        		ainId:"#productNoForDalog",//搜索框ID
	        		url:"/product/getProducListForSuggest.xco",//请求地址
	        		isAutoFocus:false,//是否需要默认选中第一项。
	        		setXCO:function(event){//传参
	        			var xco = new XCO();
	        			if(isNumOrLetter($(event).val())){
	        				xco.setIntegerValue("inputType",2);
	        			}else{
	        				xco.setIntegerValue("inputType",1);
	        			}
	        			
	        			xco.setStringValue("inputValue",$(event).val());
	        			return xco;
	        		},
	        		callback:function(item){//需要的参数 item是list里单个xco对象
	        			var result={//这里的值会在下边用的
	        				lable : item.getStringValue("product_no"),
	        				value : "产品编号："+item.getStringValue("product_no")+"　　产品名称："+item.getStringValue("name"),
	        				name : item.getStringValue("name")
	        			}
	        			return result;
	        		},
	        		focus:function(event,item){//item相当于callback里的result
	        			$("#nameForDalog").val(item.name);
	        			$("#productNoForDalog").val(item.lable);
	        		},
	        		select : function(event, item) {//item相当于callback里的result
	        			$("#nameForDalog").val(item.name);
	        			$("#productNoForDalog").val(item.lable);
	        		}
	        	});
	        },
	        btn:['确定','取消'],  
	        btn1: function (index,layero) {  
	        	if($("#productNoForDalog").val()){
	        		getProductDuty($("#productNoForDalog").val());
	        		layer.close(index);  
	        	}
	        },  
	        btn2:function (index,layero) {  
	             layer.close(index);  
	        },  
			scrollbar:false
		});
	}
	
	function getProductDuty(_productNo){
		var xco = new XCO();
		xco.setStringValue("productNo",_productNo);
		
		var options = {
			url : "/product/getProductDuty.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					setDutyValue(data.getData());
				}
			}
		};
		$.doXcoRequest(options);
	}
</script>