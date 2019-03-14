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
<title>异常检测定义（文本型）</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span >核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
        <li><span>核保项</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
      <li><span>异常检测定义（文本型）</span><span class="divider"></span>
      </li>
    </ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>异常检测定义（文本型）</h1>
			</div>

      <div class="row-fluid">
              <div class="row-fluid">
              <div class="span12">
               <!--  <p style="color:#2679b5;font-size:16px;font-weight:bold;float:right;" onclick="openDefinition()">批量设置</p> -->
              <table id="table_bug_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>性别</th>
                  <th>年龄</th>
                  <th>前置条件</th>
                  <th>定义/描述</th>
                  <th>重要性</th>
                  <th>相关类目和影响</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody id="listgroup">
                <!-- <tr>
                  	<td>#{rid_id}
                  	    <input id="ri_id#{rid_id}" type="hidden" class="form-control" style="width:50px" value="#{ri_id}">
                  		<input id="rule_id#{rid_id}" type="hidden" class="form-control" style="width:50px" value="#{rule_id}">
                  		<input id="rid_priority#{rid_id}" type="hidden" class="form-control" style="width:50px" value="#{rid_priority}">
                  		<input id="rid_type#{rid_id}" type="hidden" class="form-control" style="width:50px" value="#{rid_type}">
                  	</td>
	                <td>  
	                 	@{getSex}
	                </td>
	                <td>
	                 	<input id="rid_age#{rid_id}" type="text" class="form-control" style="width:50px" value="@{getAge}">
	                </td>
	                <td>
		             	<input id="rid_precond#{rid_id}" type="text" class="form-control" value="#{rid_precond}">
		            </td>
               	    <td>
                 		<label style="display:inline;">定义：</label>
						<input id="rid_def#{rid_id}" type="text" class="form-control" value="#{rid_def}">
             				<br>
		            </td>
		            <th>@{getImportant}</th>
		           <td onclick="updateRulesItemDefOp(#{rid_id})" >
		           	<a style="cursor:pointer;" id="#{rid_id}"></a>
		           </td>
		         <td>@{getLink}</td>
                </tr> -->
              </tbody>
              
              <!-- <label style="display:inline;">描述：  </label>
						<input type="text" class="form-control" value="#{rid_desc}"> -->
            </table>

            <!-- <div class="form-group">
                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset" onclick="openAddAmend()">保存/修改</button>
         	</div> -->
          </div>
        </div>
      </div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var ri_type = getURLparam("ri_type");
	var ri_id = getURLparam("ri_id");
	XCOTemplate.pretreatment(['listgroup']);
	var renderPage = true;
	xdoRequest(0,10);
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pagesize);
		xco.setIntegerValue("ri_type", ri_type);
		xco.setLongValue("ri_id", ri_id);
		var options = {
			url : "/rules/getRulesItemDefs.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
		//修改类目和影响
	function updateRulesItemDefOp(rid_id) {
		location.href="../ungstd/ruleItemDefOpList.jsp?rid_id="+rid_id;
	}
	//更新定义
	function updateRulesItemDefs(rid_id) {
		var xco = new XCO();
		var sex = $("#rid_sex"+rid_id).val();
		if(sex=="不限"){
			sex = 0;
			}
		if(sex=="女"){
			sex = 10;
			}
		if(sex=="男"){
			sex = 11;
			}
		var age = $("#rid_age"+rid_id).val();
		if(age=="不限"){
			age = 0;
			}
		xco.setLongValue("rid_id", rid_id);
		xco.setLongValue("ri_id", $("#ri_id"+rid_id).val());
		xco.setLongValue("rule_id", $("#rule_id"+rid_id).val());
		xco.setIntegerValue("rid_priority",  $("#rid_priority"+rid_id).val());
		xco.setIntegerValue("rid_sex", sex);
		xco.setIntegerValue("rid_age", age);
		xco.setIntegerValue("rid_type",  $("#rid_type"+rid_id).val());
		xco.setStringValue("rid_precond",  $("#rid_precond"+rid_id).val());
		xco.setStringValue("rid_def",  $("#rid_def"+rid_id).val());
		var options = {
			url : "/rules/updateRulesItemDef.xco",
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
		$("#size").text(10);
		var dataList=data.get('list');
		var opList=data.get('oplist');
		if(!dataList){
			dataList=new Array();	
		}
	    var html = '';
	    var ext = {
			getLink: function(xco){
				return str='<a style="cursor:pointer;" onclick="updateRulesItemDefs('+xco.get("rid_id")+')">保存</a><br />';
			},
			getSex: function(xco){
					var str = '<select id="rid_sex'+xco.get("rid_id")+'" style="width:100px;margin:0;">';
					if(xco.get("rid_sex")==0){
					str +='<option value="0" selected="selected">不限</option>'  +
								              '<option value="11">男</option>' +
								              '<option value="10">女</option></select>';
					}
					if(xco.get("rid_sex")==11){
					str +='<option value="0">不限</option>'  +
								              '<option selected="selected" value="11">男</option>' +
								              '<option value="10">女</option></select>';
					}
					if(xco.get("rid_sex")==10){
					str +='<option value="0">不限</option>'  +
								              '<option value="11">男</option>' +
								              '<option selected="selected" value="10">女</option></select>';
					}
					return 	str;	
			},
			getAge: function(xco){
				if(xco.get("rid_age")==0){
					return "不限";
				}else{
					return xco.get("rid_age");
				}
			},
			getImportant:function(xco){
				if(xco.get("rid_important")==1){
					return "重要";
				}
				if(xco.get("rid_important")==0){
					return "非重要";
				}
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("listgroup", dataList[i], ext);
    	}
   		document.getElementById("listgroup").innerHTML = html;
   		
   		for (var i = 0; i < opList.length; i++) {
   			var str='';
   			var obj=opList[i];
   			var def_id=obj.get("rid_id");
   			var rido_op=obj.get("rido_op");
   			var series_no=obj.get("series_no");
   			if(series_no==0){
   				str+="全部 :"
   			}else if(series_no==1){
   				str+="重疾险 :"
   			}else if(series_no==2){
   				str+="寿险 :"
   			}else if(series_no==3){
   				str+="癌症险 :"
   			}
   			if(rido_op==10){
   				str+="预警";
   			}else if(rido_op==20){
   				str+="加费";
   			}else if(rido_op==30){
   				str+="减费";
   			}else if(rido_op==50){
   				str+="转人工";
   			}else if(rido_op==60){
   				str+="拒保";
   			}else if(rido_op==100){
   				str+="通过";
   			}
   			if(obj.get("rido_sug_code")){
   				str+="("+obj.get("rido_sug_code")+")";
   			}
        	str+="<br />";
        	$("#"+def_id+"").append(str);
    	}
   			  
	}
	  
	$("#find").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
	});
	
	
	
	
	
</script>
