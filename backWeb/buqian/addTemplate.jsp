<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8" />
  <title></title>
</head>
<body>
<div id="main-content" class="clearfix">

  <div id="breadcrumbs">
    <ul class="breadcrumb">
              <li>
          <i class="icon-heart"></i>
          <span class="divider"></span>
          <span>医学管理</span>
          <span class="divider"><i class="icon-angle-right"></i></span>
        </li>
        <li>
          <span>标准项管理</span>
          <span class="divider"><i class="icon-angle-right"></i></span>
        </li>
        <li>
          <span>新增标准项</span>
          <span class="divider"></span>
        </li>

    </ul>
  </div>

  <!--#breadcrumbs-->
  <div id="page-content" class="clearfix">
    <div class="page-header position-relative crumbs-nav">
      <h1><i class="icon-plus"></i>新增</h1>
    </div>
    <div class="row-fluid">
      <div class="row-fluid">
        <div class="span12">
          <div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">

              <div class="from-group mar-t-15">
                <label>
                    <span style="color:red;">*</span>
                  最高值
                </label>
                  <input type="text" class="" id="norm_high" placeholder="请输入最高值">

              </div>
              <div class="from-group mar-t-15">
                <label>
                    <span style="color:red;">*</span>
                  单位
                </label>
                      <input type="checkbox" name="norm_unit" value="1" class="ace">
                      <span class="lbl">哈哈</span>
                      <input type="checkbox" name="norm_unit" value="2" class="ace">
                      <span class="lbl">嘟嘟</span>
                      <input type="checkbox" name="norm_unit" value="3" class="ace">
                      <span class="lbl">多多</span>

              </div>
              <div class="from-group mar-t-15">
                <label>
                  解析结果
                </label>
                  <select class="form-control" id="rard_result">
                    <option value="-1">请选择</option>
                        <option value="0">未知</option>
                        <option value="100">成功</option>
                        <option value="110">解析失败</option>
                        <option value="120">缺少体检结果</option>
                  </select>

              </div>


            <div class="from-group">
              <button class="user-add-save" id="save" type="reset">保存</button>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
<script>

    $("#save").click(function () {
        var xco = new XCO();
        var norm_high = $("#norm_high").val();
        if (!norm_high) {
            axError("请输入最高值");
            return;
        }



        xco.setStringValue("norm_high", norm_high);
        console.log(norm_high )
        var norm_unit = $("#norm_unit").val();
        norm_unit = "";
        $("input[name='norm_unit']:checked").each(function () {
            norm_unit += $(this).val() + ","
        })
        if(!norm_unit){
            axError("请选择单位");
            return;
        }


        xco.setStringValue("norm_unit", norm_unit);
        console.log(norm_unit )
        var rard_result = $("#rard_result").val();




        xco.setIntegerValue("rard_result", rard_result);
        console.log(rard_result )

        console.log(xco.toString())
        var options = {
            url: "",
            data: xco,
            success: function (data) {
                if (data.getCode() != 0) {
                    axError(data.getMessage());
                } else {
                    axSuccess("保存成功！");
                }
            }
        }
        axConfirm("确定保存吗?", function () {
            $.doXcoRequest(options);
        })
    })

</script>
</body>


</html>
