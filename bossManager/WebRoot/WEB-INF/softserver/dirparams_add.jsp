<%@page import="com.echounion.bossmanager.common.enums.ParamType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script type="text/javascript">
		$(function(){
			$("#dirId").attr("value",$("#serviceparamstable input")[0].value);
			Boss.form.initDialogForm("serviceparamstable","dirParamForm","soft/param!addDirParam");
		});
	</script>
	<form method="post" name="dirParamForm" id="dirParamForm" >
		<input type="hidden" id="dirId" name="serviceDirParam.serviceDirId">
		<table style="padding:10px;" cellpadding="3">
			<tr>
				<td>参数名称:</td><td><input type="text"  validType="unnormal[1,20]"  name="serviceDirParam.name" size=50;  class="easyui-validatebox" required="true"/>&nbsp;<span class="tip">*</span>必填</td>
			</tr>		
			<tr>
				<td>参数代号:</td><td><input type="text"  validType="alphanum[1,20]"  name="serviceDirParam.code" size=50;  class="easyui-validatebox" required="true"/>&nbsp;<span class="tip">*</span>必填</td>
			</tr>
			<tr>
				<td>是否必填:</td>
				<td>
					<input type="checkbox" name="serviceDirParam.require" value="false" onchange="if($(this).attr('checked')){$(this).val('true')}else{$(this).val('false');}"/>
				</td>
			</tr>			
			<tr>
				<td>参数类型:</td>
				<td>
					<select name="serviceDirParam.typeId">
						<c:forEach items="<%=ParamType.values()%>" var="item" varStatus="vs">
							<option <c:if test="${item.id eq 4}">selected="selected" </c:if> value="${item.id}" >${item.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>备注:</td><td><textarea rows="5" cols="50" name="serviceDirParam.remark"></textarea> </td>
			</tr>			
			<tr>
				<td colspan="2">
						<br/>
						<div class="toolbar" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" id="softwareFormFormsavebtn" iconCls="icon-save" onclick="if($('#dirParamForm').form('validate')){$('#dirParamForm').submit();}">保存</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" onclick="Boss.util.closeDialogWin()">取消</a>
						</div>
				</td>
			</tr>
		</table>
</form>
