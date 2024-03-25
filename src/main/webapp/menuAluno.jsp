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
			<li><a href="matricula.jsp">Matricula</a>
			<li><a href="${pageContext.request.contextPath}/onibus">Horarios</a>
		</ul>
	</nav>
	<div align="center">
		<h1 class="title">Bem-vindo Aluno ao Sistema AGIS</h1>
		<h2 class="subtitle">Aqui você pode realizar as seguintes opções:</h2>
		<h3 class="subtitle">- Realizar Sua Matricula:</h3>
		<h3 class="subtitle">- Consultar Sua Grade:</h3>
	</div>
</body>
</html>