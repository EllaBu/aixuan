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
<title>新增核保规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><span href="#">核保系统</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span >核保规则</span><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
        <li><span href="../dictionary/labelList.jsp">核保项</span><span class="divider"><i
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
				<h1>异常检测定义（数值型/阴阳型）</h1>
			</div>

      <div class="row-fluid">
              <div class="row-fluid mar-t-15">
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
                  <th>相关类目和影响</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody id="listgroup">
                <tr>
                  <td>1</td>
                  <td>
                    <input type="text" class="form-control" name="title">
                  </td>
                  <td>
                    <input type="text" class="form-control" name="title">
                  </td>
                  <td>
                    <label style="display:inline;">定义：</label>
    								<input type="text" class="form-control" name="title">
                    <br><br>
                    <label style="display:inline;">描述：  </label>
      							<input type="text" class="form-control" name="title">
                  </td>
                  <td>
                    <input type="text" class="form-control" name="title">
                  </td>
                  <td>寿险：拒保</td>
                  <td>删除</td>
                </tr>
                <!-- <tr>
                  <td>#{list[i].sys_user_id}</td>
                  <td>#{list[i].login_name}</td>
                  <td>#{list[i].nick_name}</td>
                  <td>#{list[i].role_name}</td>
                  <td>@{getState}</td>
                  <td>@{getOpt}</td>
                </tr> -->
              </tbody>
            </table>

            <div class="form-group">
                <button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset" onclick="openAddAmend()">保存/修改</button>
         </div>


            <jsp:include page="../common/page.jsp"/>
          </div>
        </div>
      </div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">

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
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/labelsList.jsp";
	})
	XCOTemplate.pretreatment('listgroup');
  // 打开批量设置

	function openDefinition() {
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
	        btn:['批量定义'],
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
		});
	}
  function openAddAmend (){
    layer.open({
			type: 1,
	        title:'批量定义',
	        skin:'layui-layer-rim',
	        area:['700px', 'auto'],
	        content:
          '<div class="" style="padding:10px 20px">'
              +'<div class="" style="float:right;">'
                +'<label style="display:inline;padding: 0 10px;">分类</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">动作</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<label style="display:inline;padding: 0 10px;">系数</label>'
                +'<input type="text" class="form-control" name="title" style="margin:0;width:100px;">'
                +'<span style="color:red;margin-right:80px;padding-left:10px;">删除</span>'
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
	        ,
	        btn:['修改/更新'],
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
		});
  }
</script>
