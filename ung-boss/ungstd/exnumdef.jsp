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
<title>异常检测定义（数值型/阴阳型）</title>
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
        <li><span >核保项</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
      <li><span>异常检测定义（数值型/阴阳型）</span><span class="divider"></span>
      </li>
    </ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>异常检测定义（数值型/阴阳型）</h1>
			</div>

      <div class="row-fluid">
              <div class="row-fluid">
              <div class="span12">
                <!-- <p style="color:#2679b5;font-size:16px;font-weight:bold;float:right;" onclick="openDefinition()">批量设置</p> -->
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
						<input type="text" id="rid_def#{rid_id}" class="form-control" value="#{rid_def}">
             				<br>
		            </td>
		            
		            <td>@{getImportant}</td>
		            <td onclick="updateRulesItemDefOp(#{rid_id})">
		            	<a style="cursor:pointer;" id="#{rid_id}"></a>
		            </td>
		            <td>@{getLink}</td>
                </tr> -->
              </tbody>
              <%--  <label style="display:inline;">描述：  </label>
						<input type="text" class="form-control" value="#{rid_desc}"> --%>
            </table>
          </div>
        </div>
      </div>
		</div>
	</div>
	
	
	<div id="cont"><!-- 
			<tr>
               <td>1</td>
               <td>  
                 <input type="text" class="form-control w150" value="#{rid_sex}">
               </td>
               <td>
                 <input type="text" class="form-control" value="#{rid_age}">
               </td>
               <td>
                 <label style="display:inline;">定义：</label>
					<input type="text" class="form-control" value="#{rid_def}">
             <br><br>
             <label style="display:inline;">描述：  </label>
						<input type="text" class="form-control" value="#{rid_desc}">
           </td>
           <td>
             <input type="text" class="form-control" name="title">
           </td>
           <td >
           	
           </td>
           <td><a href="javascript:;" onclick="remove(this)">删除</a></td>
    	</tr>  -->
	</div>
	
	<div id="t1">
		<!-- <div class="" tagdef="childformdata"  style="float:right;">
              <label style="display:inline;padding: 0 10px;">一级分类</label>
              <select  name="level1"  onchange="choosetwolevel(this)" style="margin:0;width:100px;">@{getL1}</select>
              <label style="display:inline;padding: 0 10px;">二级分类</label>
              <select  name="level2"   style="margin:0;width:100px;">@{getL2}</select>
              <label style="display:inline;padding: 0 10px;">动作</label>
              <select name="action" style="width:100px;margin:0;">
	              <option value=10">预警</option>
	              <option value="20">加费</option>
	              <option value="30">减费</option>
	              <option value="50">转人工</option>
	              <option value="60">拒保</option>
	              <option value="100">通过</option>
              </select>
              <label style="display:inline;padding: 0 10px;">系数</label>
              <input type="text" class="form-control" name="ratio" style="margin:0;width:100px;">
              <span style="color:red;margin-right:80px;padding-left:10px;">删除</span>
              <br><br>
         </div> -->
	</div>
	
	<div id="t1_1"><!-- 
			<option value="#{series_no}">#{series_name}</option>
		 -->
	</div>
		<div id="t1_2"><!-- 
			<option value="#{series_no}" fid="#{f_id}">#{series_name}</option>
		 -->
	</div>
</body>
</html>
<script type="text/javascript">
/* /rules/getRulesItemDefs , */
	var ri_type = getURLparam("ri_type");
	var ri_id = getURLparam("ri_id");
	XCOTemplate.pretreatment(['listgroup','t1','t1_1','t1_2']);
	xdoRequest(0,50);
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
	
	
	/* var leveldata;
	var twoleveldata; 
	getOneLevelData();
	getTwoLevelSeriesList();
	add=function(){
		var html= XCOTemplate.execute("cont");
		$("#listgroup").append(html);
	}
	
	function remove(obj){
		$(obj).parent().parent().remove();
	}
	
	function addpre(obj){
		var ext = {
			getL1: function(){
				var html = '<option value="0">请选择</option>';
				for (var i = 0; i < leveldata.length; i++) {
		        	html += XCOTemplate.execute("t1_1", leveldata[i], null);
		    	}
		    	
		   		return html;
			}
			 ,
			getL2:function(){
				var html = '<option value="0">请选择</option>';	
				for (var i = 0; i < twoleveldata.length; i++) {
		        	html += XCOTemplate.execute("t1_2", twoleveldata[i], null);
		    	}
		   		return html;
			} 
		};
		var text=XCOTemplate.execute("t1",null,ext);
		 layer.open({
			type: 1,
	        title:'批量定义',
	        skin:'layui-layer-rim',
	        area:['900px', '300px'],
	        content:
         	 '<div class="" style="padding:10px 20px"><div class="" id="effects" style="float:right;">'+text+'</div><a href="javascript:;" onclick="addnode()">添加</a></div>'
	        ,
	        btn:['修改/更新'],
	        btn1:function(){
	        	$("div[tagdef='childformdata']").each(function(i,el){
	        		var l1=$(el).find("select[name='level1']");
	        		var l2=$(el).find("select[name='level2']");
	        		var ac=$(el).find("select[name='action']");
	        		var ra=$(el).find("input[name='ratio']");
	        		var l1v=$(l1).val();
	        		var l2v=$(l1).val();
	        		var l2n=$(l2).find("option:selected").text();
	        		var acv=$(ac).val();
	        		var acn=$(ac).find("option:selected").text();
	        		var rav=$(ra).val();
	        		var str=l2n+":"+acn+"<br />";
	        		$(obj).append(str);
	        	})
	        	
	        }
		});
		
	}
	function addnode(){
		var ext = {
			getL1: function(){
				var html = '<option value="0">请选择</option>';
				for (var i = 0; i < leveldata.length; i++) {
		        	html += XCOTemplate.execute("t1_1", leveldata[i], null);
		    	}
		    	
		   		return html;
			}
			 ,
			getL2:function(){
				var html = '<option value="0">请选择</option>';	
				for (var i = 0; i < twoleveldata.length; i++) {
		        	html += XCOTemplate.execute("t1_2", twoleveldata[i], null);
		    	}
		   		return html;
			} 
		};
		var text=XCOTemplate.execute("t1",null,ext);
		$("#effects").append(text);
	}
	function getOneLevelData() {
		var xco = new XCO();
		var options = {
			url : "/rulecalculate/oneLevelSeriesList.xco",
			data : xco,
			success : levelCallBack
		};
		$.doXcoRequest(options);
	}
	
	function getTwoLevelSeriesList() {
		var xco = new XCO();
		var options = {
			url : "/rulecalculate/twoLevelSeriesList.xco",
			data : xco,
			success : twolevelcallback
		}
		$.doXcoRequest(options);
	} 
	
	function twolevelcallback(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		twoleveldata = data.getData();
		if(!twoleveldata){
			twoleveldata=new Array();	
		}
	}
	function levelCallBack(data){
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		data=data.getData();
		leveldata=data.get('list');
		if(!leveldata){
			leveldata=new Array();	
		}
		
	}
	
	//添加按钮点击事件监听
	 $("#addLabels").click(function(){
		var xco = new XCO();

		var name = $("#name").val();
		if(name){
			xco.setStringValue("name",name);
		}else{
			axError("请输入标签名称");
			return;
		}
		xco.setStringValue("sys_op_log","新增标签-新增："+name);
		var options = {
			url : "/dic/addLabels.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../dictionary/labelsList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加标签吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}); 
	
	 function choosetwolevel(obj){
		var val=$(obj).val();
		$("select[name='level2']").find("option").hide();
		$("select[name='level2']").find("option[fid="+val+"]").show();
	} 
	/* 返回按钮点击事件监听 */
/* 	 $("#exit").click(function(){
		location.href="../dictionary/labelsList.jsp";
	})  */
  // 打开批量设置
	/* function openDefinition() {
		layer.open({
			type: 1,
	        title:'批量定义',
	        skin:'layui-layer-rim',
	        area:['900px', 'auto'],
	        content:
          '<div class="" style="padding:10px 20px">'
          +'<div class="">'
            +'<input type="checkbox" style="opacity: 1;position: static;" name="" value="">'
            +'<span style="padding-left:10px;">区分性别</span>'
            +'<div class="" style="float:right;">'
             +'<input type="radio" style="opacity: 1;position: static;" name="sex" value="">'
              +'<span style="padding: 0 10px;">男</span>'
              +'<input type="radio" style="opacity: 1;position: static;" name="sex" value="">'
              +'<span style="padding: 0 10px;padding-right: 590px;">女</span>'
            +'</div>'
          +'</div>'
          +'<br>'
          +'<div class="">'
            +'<input type="checkbox" style="opacity: 1;position: static;" name="" value="">'
            +'<span style="padding-left:10px;">区分年龄</span>'
            +'<div class="" style="float:right;">'
              +'<span style="padding: 0 10px;">从</span>'
              +'<input type="text" class="form-control" name="title" style="margin:0;">'
              +'<span style="padding: 0 10px;">岁至</span>'
              +'<input type="text" class="form-control" name="title" style="margin:0;">'
              +'<span style="padding: 0 10px;padding-right: 150px;">岁</span>'
            +'</div>'
          +'</div>'
          +'<br>'
          +'<div class="">'
            +'<input type="checkbox" style="opacity: 1;position: static;" name="" value="">'
            +'<span style="padding-left:10px;">定义</span>'
            +'<div class="" style="float:right;">'
              +'<input type="text" class="form-control" name="title" style="margin:0;margin-right: 461px;">'
            +'</div>'
          +'</div>'
          +'<br>'
          +'<div class="">'
            +'<input type="checkbox" style="opacity: 1;position: static;" name="" value="">'
              +'<span style="padding-left:10px;">描述</span>'
              +'<div class="" style="float:right;">'
                  +'<input type="text" class="form-control" name="title" style="margin:0;margin-right: 461px;">'
              +'</div>'
          +'</div>'
          +'<br>'
          +'<div class="">'
            +'<input type="checkbox" style="opacity: 1;position: static;" name="" value="">'
              +'<span style="padding-left:10px;">影响</span>'
              +'<div class="" style="float:right;">'
                +'<label style="display:inline;padding: 0 10px;">分类</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">动作</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">系数</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<span style="color:red;margin-right: 173px;padding-left:10px;">删除</span>'
                +'<br><br>'
                +'<label style="display:inline;padding: 0 10px;">分类</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">动作</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">系数</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<span style="color:red;padding-left:10px;">删除</span>'
                +'<span style="color:rgb(102, 204, 0);font-size:16px;font-weight:bold;padding-left:10px;">+</span>'
              +'</div>'
          +'</div>'
          +'</div>'
	        ,
	        btn:['批量定义'], */
	    //     btn1: function (index,layero) {
	    //     	var roleName = jQuery.trim($('#roleName').val());
			// 	var roleDesc = jQuery.trim($('#roleDesc').val());
			// 	if ('' == roleName || '' == roleDesc) {
			// 		axError('角色名称和描述不能为空.');
			// 		return;
			// 	}
			// 	//运营人员
      //
			// 	var xco = new XCO();
			// 	xco.setStringValue("roleName", roleName);
			// 	xco.setStringValue("roleDesc", roleDesc);
			// 	var options = {
			// 		url : "/system/addRole.xco",
			// 		data : xco,
			// 		success : function(data) {
			// 			if (0 != data.getCode()) {
			// 				axError(data.getMessage());
			// 				return;
			// 			}
			// 			layer.close(index);
			// 			parent.location.reload();
			// 		}
			// 	};
			// 	$.doXcoRequest(options);
	    //     },
	    //     btn2:function (index,layero) {
	    //          layer.close(index);
	    //     },
			// scrollbar:false
	/* 	});
	} */
</script>
