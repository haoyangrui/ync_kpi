<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>查看评价</title>
<style>
	td{
		text-align:center;
	}
</style>
</head>
<body>
	<h4>
	上级评价ID:${assessment.id } &nbsp;&nbsp;&nbsp;&nbsp;
	被评价者:${assessment.beEvaluatedName }&nbsp;&nbsp;&nbsp;&nbsp;
	部门:${assessment.departmentName }&nbsp;&nbsp;&nbsp;&nbsp;
	评价者：${assessment.mt }<br />
	评价时间:<fmt:formatDate value="${assessment.evaluatedTime }" pattern="yyyy-MM-dd"/>
	</h4>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
			<td>行为要项</td>
			<td>行为藐视</td>
			<td>上级评分</td>
		</tr>
		<tr>
			<td>主动承担</td>
			<td>职责范围之内的工作，主动计划，高效推进；职责边界模糊的工作，主动推进积极协作，确保结果落实</td>
			<td>${assessment.action1_Score }</td>
		</tr>
		<tr>
			<td>快速高效</td>
			<td>接到任务马上执行，不推诿，不迟疑，并想法设法高效完成</td>
			<td>${assessment.action2_Score }</td>
		</tr>
		<tr>
			<td>结果意识</td>
			<td>以价值为根本，始终保持对目标的关注，通过不断地监控和排除各种困难，高效率地实施计划，取得高质量的成果</td>
			<td>${assessment.action3_Score }</td>
		</tr>
		<tr>
			<td>沟通协作</td>
			<td>以积极的行动，谦和的态度主动沟通，并与工作上下游良好协作，支持团队总体目标的达成</td>
			<td>${assessment.action4_Score }</td>
		</tr>
		<tr>
			<td>坚韧耐挫</td>
			<td>困难面前不低头，压力面前不弯腰、挑战面前不后退；愈挫愈勇、百折不挠、坚韧不拔、持之以恒</td>
			<td>${assessment.action5_Score }</td>
		</tr>
	</table>
	<div>
		<h4><span>总分:</span><span id="count">${assessment.totalScore }</span>分</h4>
		<h4>评价: ${assessment.comment }</h4>
	</div>
</body>

</html>