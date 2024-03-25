<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title></title>
</head>
<body>
  <nav id="menu">
		<ul>
			<li><a href="index.jsp">Home</a>
			<li><a href="${pageContext.request.contextPath}/aluno">Aluno</a>
			<li><a href="${pageContext.request.contextPath}/curso">Curso</a>
			<li><a href="${pageContext.request.contextPath}/disciplina">Disciplina</a>
			<li><li><a href="conteudo.jsp">Conteudo</a></li>  
			<li><a href="${pageContext.request.contextPath}/professor">Professor</a>
		</ul>
	</nav>

</body>
</html>