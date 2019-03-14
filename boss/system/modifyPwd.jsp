<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String pageName = "人员信息";
%>
<%@ include file="../common/comm_css.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

  <head>
    <base href="<%=basePath%>">
   	<meta charset="utf-8" />
    <title>基本信息-人员信息</title>
    <jsp:include page="/common/comm_css.jsp"></jsp:include>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/xco-1.0.1.js"></script>
	<script type="text/javascript" src="/js/jquery-ui.js" ></script>
	<script type="text/javascript" src="/js/xco.databinding-1.0.1.js"></script>
	<script type="text/javascript" src="/js/xco.jquery-1.0.1.js"></script>
	<script type="text/javascript" src="/js/xco.template-1.0.1.js"></script>
	<script type="text/javascript" src="/js/xco.validate-1.0.1.js"></script>
	<script type="text/javascript" src="/js/xco.variable-1.0.1.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script src="/js/layer/layer.js"></script>
</head>
<body>
	
	<div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-inline" style="background: none;padding: 10px;">
                	<div class="form-group">
                        <label for="exampleInputName2" class="mar-t-15" style="text-align:right;margin-right:10px;">原密码</label>
                        <input type="password" class="form-control mar-t-15" style="height:30px;width:250px;" id="oldPwd" >
                    </div>
                    
                    <div class="form-group">
                        <label for="exampleInputName2" class="mar-t-15" style="text-align:right;margin-right:10px;">新密码</label>
                        <input type="password" class="form-control mar-t-15 w150" style="height:30px; width:250px;" id="newPwd" >
                    </div>
                    <div class="form-group">
                        <label for="exampleInputName2" class="mar-t-15" style="text-align:right;margin-right:10px;">确认密码</label>
                        <input type="password" class="form-control mar-t-15 w150" style="height:30px; width:250px;" id="newPwd1" >
                    </div>
                    <div class="span12">
						<div class="tc mar-t-20">
							<button type="button" class="btn btn-submit" id="ok" data-toggle="button">
								<i class=" icon-ok mr10"></i>保存
							</button>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>	
</body>
<script type="text/javascript">
$(function() {	
	//确定
	$("#ok").click(function(){
		var xco = new XCO();
		var oldPwd = $("#oldPwd").val();
		if(oldPwd){
			xco.setStringValue("oldPwd",oldPwd);
		}else{
			axError("请输入原密码");
			return;
		}
		var newPwd = $("#newPwd").val();
		if(newPwd){
			xco.setStringValue("password",newPwd);
		}else{
			axError("请输入新密码");
			return;
		}
		var newPwd1 = $("#newPwd1").val();
		if(newPwd1){
			if(newPwd1!=newPwd){
				axError("两次密码不一致");
				return;
			}
		}else{
			axError("请输入确认密码");
			return;
		}
		var options ={
			url:"/updateSysPwd.xco",
			data:xco,
			success: function(result){
				if (result.getCode() != 0) {
					axError(result.getMessage());
				} else {
					axSuccess("保存成功！",function(){
						 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				         parent.layer.close(index);
				         parent.window.location.href="../loginout.jsp";
					});
				}
			}
		};
		$.doXcoRequest(options);
	})
})
</script>
</html>
