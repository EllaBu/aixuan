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
      <#if navigates??>
        <#list navigates as per>
          <li>
            <#if (per_index==0)>
              <i class="icon-heart"></i>
              <span class="divider"></span>
            </#if>
            <span href="${per.href}">${per.name}</span>
            <span class="divider">
          <#if (per_index!=navigates?size-1)>
            <i class="icon-angle-right"></i>
          <#else>
            <#assign leaf>${per.name}</#assign>
          </#if>
        </span>
          </li>
        </#list>

      <#else>
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
          <span>修改标准项</span>
          <span class="divider"></span>
        </li>
      </#if>

    </ul>
  </div>

  <!--#breadcrumbs-->
  <div id="page-content" class="clearfix">
    <div class="page-header position-relative crumbs-nav">
      <h1><i class="icon-edit"></i>${leaf!("修改")}</h1>
    </div>
    <div class="row-fluid">
      <div class="row-fluid">
        <div class="span12">
          <div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">

            <#list list as lists>
              <div class="from-group mar-t-15">
                <label>
                  <#if lists.required=="true">
                    <span style="color:red;">*</span>
                  </#if>
                  ${lists.name}
                </label>
                <#if (lists.type=="text")>
                  <input type="text" class="" id="${lists.code}" placeholder="请输入${lists.name}">

                <#elseif (lists.type=="select")>
                  <select class="form-control" id="${lists.code}">
                    <option value="-1">请选择</option>
                    <#if (lists.values??)>
                      <#list lists.values as item>
                        <option value="${item.code}">${item.name}</option>
                      </#list>
                    </#if>
                  </select>

                <#elseif (lists.type="checkbox")>
                  <#if (lists.values??)>
                    <#list lists.values as item>
                      <input type="checkbox" name="${lists.code}" value="${item.code}" class="ace">
                      <span class="lbl">${item.name}</span>
                    </#list>
                  </#if>

                <#elseif (lists.type="radio")>
                  <#if lists.values??>
                    <#list lists.values as item>
                      <input type="radio" name="${lists.code}" value="${item.code}" class="ace">
                      <span class="lbl">${item.name}</span>
                    </#list>
                  </#if>

                <#elseif (lists.type="textarea")>
                  <textarea id="${lists.code}" rows="3"></textarea>
                </#if>
              </div>
            </#list>


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
        <#list list as item>
        var ${item.code} = $("#${item.code}").val();
        <#if (item.type=="text" || item.type=="textarea")>
        <#if (item.required=="true")>
        if (!${item.code}) {
            axError("请输入${item.name}");
            return;
        }
        </#if>


        <#elseif (item.type == "checkbox")>
        ${item.code} = "";
        $("input[name='${item.code}']:checked").each(function () {
            ${item.code} += $(this).val() + ","
        })
        <#if item.required == "true">
        if(!${item.code}){
            axError("请选择${item.name}");
            return;
        }
        </#if>

        <#elseif (item.type == "radio")>
        ${item.code} = $("input[name='${item.code}']:checked").val()
        <#if (item.required == "true")>
        if (!${item.code}) {
            axError("请选择${item.name}");
            return;
        }
        </#if>

        <#elseif (item.type == "select")>
        <#if (item.required == "true")>
        if (${item.code} == -1) {
            axError("请选择${item.name}");
            return;
        }
        </#if>



        </#if>

        xco.set${item.dataType}Value("${item.code}", ${item.code});
        console.log(${item.code} )
        </#list>

        console.log(xco.toString())
        var options = {
            url: "${save_url!('')}",
            data: xco,
            success: function (data) {
                if (data.getCode() != 0) {
                    axError(data.getMessage());
                } else {
                    axSuccess("修改成功！",function(){
                        location.href="";
                    });
                }
            }
        }
        axConfirm("确定修改吗?", function () {
            $.doXcoRequest(options);
            layer.close(layer.index);
        })
    })

</script>
</body>


</html>
