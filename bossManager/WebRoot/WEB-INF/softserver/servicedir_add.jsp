<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.echounion.bossmanager.common.enums.HttpReqeuestType"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	$(function(){
			$("#bindsoftID").combogrid({panelWidth:200,idField:"id",textField:"softName",url:"soft/soft",columns:[[{field:"id",title:"编号",width:60},{field:"softName",title:"软件名称",width:100}]]});
			$("#serviceParamstable").datagrid({
				toolbar:[
					{id:"btnflush",text:"刷新",iconCls:"icon-reload",handler:function(){Boss.grid.reload("servicedirtable");}},
					{id:"btnremove",text:"移除",iconCls:"icon-remove",handler:function(){Boss.grid.removeSelected("serviceParamstable");}},
					{id:"btnsave",text:"添加",iconCls:"icon-add",handler:function(){Boss.util.createDialogWin("添加接口参数",500,400,"softserver_params_add");}}
				]
			});			
		});
		function getParamsGrid1()
		{
			var softId = $("#bindsoftID").combogrid("grid").datagrid("getSelections")[0];
			if(softId == null ){
				Boss.message.errorMessageShow("该软件不存在，请重新选择!");	
				return ;
			};
			
			if($("#servicedirForm").form("validate"))
			{
				var rows=Boss.grid.getData("serviceParamstable");
				for(var index=0;index<rows.length;index++)
				{
					var str="<input type='hidden' name='params["+index+"].code' value='"+rows[index].code+"' />";
					str+="<input type='hidden' name='params["+index+"].name' value='"+rows[index].name+"' />";
					str+="<input type='hidden' name='params["+index+"].require' value='"+rows[index].require+"' />";
					str+="<input type='hidden' name='params["+index+"].typeId' value='"+rows[index].typeId+"' />";
					str+="<input type='hidden' name='params["+index+"].remark' value='"+rows[index].remark+"' />";
					$(str).appendTo("#servicedirForm");
				}
				$.ajax(
				{
					url:"soft/dir!addServiceDirForGrid",
					type:"POST",
					data:$("#servicedirForm").serialize(),
					success:function(msg)
					{
						Boss.message.successMessageShow(msg);
						Boss.location.reload();
					}
				});
				Boss.util.closeDialogWin();
			}
		}
</script>
<form method="post" name="servicedirForm" id="servicedirForm">
		<table style="padding:10px;" cellpadding="3" border="0">
			<tr>
				<td>服务软件:</td>
				<td>
					<input type="text" id="bindsoftID"  name="serviceDir.softId" readonly="readonly"   required="true" /><span style="color: red;"> *</span>必填
				</td>
			</tr>
			<tr>
				<td>服务代码:</td>
				<td>
					<input type="text" validType="alphanum[1,50]"  name="serviceDir.serviceCode" class="easyui-validatebox" required="true" onblur="Boss.dir.checkServicedirCode(this)"/><span style="color: red;"> *</span>必填
				</td>
			</tr>
			<tr>
				<td>服务名称:</td><td><input validType="unnormal[1,100]"  type="text" name="serviceDir.serviceName" class="easyui-validatebox" required="true"/><span style="color: red;"> *</span>必填</td>				
			</tr>
			<tr class="apielement">
				<td>服务URL:</td>
				<td colspan="3"><input type="text"  validType="unblank[1,300]"  name="serviceDir.serviceUrl" size="30" class="easyui-validatebox" required="true"/></td>
			</tr>
				<tr class="apielement">
				<td>请求方式:</td>
				<td colspan="3">
					<select id="methodSelect" name="serviceDir.methodId">
								<c:forEach items="<%=HttpReqeuestType.values()%>" var="item">
									<option value="${item.id}">${item}</option>
								</c:forEach>
					</select>
				</td>
			</tr>
			<tr class="apielement">
				<td>备注:</td>
				<td colspan="3">
					<textarea rows="5" name="serviceDir.remark" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
						<br/>
						<div class="toolbar" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" id="softwareFormFormsavebtn" iconCls="icon-save" onclick="getParamsGrid1()">保存</a>									
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" onclick="Boss.util.closeDialogWin();">取消</a>
						</div>
				</td>
			</tr>
		</table>
</form>
<br/>
<table id="serviceParamstable" fitColumns="true" fit="true" title="服务接口参数列表" idField="code" >
		<thead>
			<tr>
				<th checkbox="true">编号</th>
				<th field="code" width="100">参数代号</th>
				<th field="name" width="100">参数名称</th>
				<th field="require" width="100">是否必填</th>
				<th field="typeId" width="100" formatter="Boss.dir.changeParamTypeCharacterType">参数类型</th>
				<th field="remark" >参数说明</th>
			</tr>
		</thead>	
</table>