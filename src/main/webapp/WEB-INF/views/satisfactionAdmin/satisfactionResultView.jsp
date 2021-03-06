<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
function cancle() {
	window.location.href='${ctx}/admin/satisfaction/resultList';
}
</script>
</head>
<body>
	<h4>月度客户满意</h4>
	<table>
		<tr>
			<td>被评者：</td>
			<td><input type="text" class="input-large " value="${satisfactionDetailPage.beEvaluatedName}" readonly /></td>
			<td>时间：</td>
				<td><input type="text" class="input-large " value="${satisfactionDetailPage.evaluatedTime}" readonly /></td>
		</tr>
		<tr>
			<td>项目数</td>
				<td><input type="text" class="input-large " value="${satisfactionDetailPage.projectNum}" readonly /></td>
			<td>部门：</td>
				<td><input type="text" class="input-large " value="${satisfactionDetailPage.beEvaluatedDepartmentName}" readonly /></td>
		</tr>
	</table>
	<h4>项目满意详情</h4>
	<c:forEach var="listProject" items="${satisfactionDetailPage.project}">
		<h4>${listProject.projectName }</h4>
		<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td>评价者</td>
				<td>部门</td>
				<td>时间</td>
				<td>评分</td>
				<td>评语</td>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="listSatisfaction" items="${listProject.list}">
				<tr>
					<td>${listSatisfaction.evaluatedName}</td>
					<td>${listSatisfaction.evaluatedDepartmentName}</td>
					<td><fmt:formatDate value= '${listSatisfaction.evaluatedTime}' pattern='yyyy-MM-dd'/></td>
					<td>${listSatisfaction.score}</td>
					<td>${listSatisfaction.comment}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</c:forEach>
	<h4>客户满意总分:${satisfactionDetailPage.totalScore }分</h4>
	<button class="btn" onclick="cancle()">返回</button>
</body>

</html>