<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<title>CRUD Sistema AGIS</title>
</head>
<body>
	<nav id="menu">
		<ul>
			<li><a href="index.jsp">Home</a></li>
			<li class="submenu"><a href="#">Matricula &#9662;</a>
				<ul>
					<li><a href="periodoMatricula.jsp">Perido Matricula</a></li>
					<li>
					<li><a href="matricula.jsp">Matricula</a></li>
				</ul></li>
			<li><a href="${pageContext.request.contextPath}/aluno">Aluno</a></li>
			<li><a href="${pageContext.request.contextPath}/curso">Curso</a></li>
			<li><a href="${pageContext.request.contextPath}/disciplina">Disciplina</a></li>
			<li>
			<li><a href="conteudo.jsp">Conteudo</a></li>
			<li><a href="${pageContext.request.contextPath}/professor">Professor</a></li>
		</ul>
	</nav>

	<div class="spacer"></div>
	<div align="center">
		<h1 class="title">Bem-vindo Secretaria ao Sistema AGIS</h1>
		<h2 class="subtitle">Aqui voc� pode realizar as seguintes op��es:</h2>

		<div class="option">
			<h3 class="option-title">Manter Aluno</h3>
		</div>
		<div class="option">
			<h2 class="option-title">- Matricula</h2>
		</div>

		<div class="option">
			<h3 class="option-title">Manter Curso</h3>
		</div>

		<div class="option">
			<h3 class="option-title">Manter Disciplina</h3>
		</div>
		<div class="option">
			<h3 class="option-title">Manter Conteudo</h3>
		</div>
		<div class="option">
			<h3 class="option-title">Manter Professor</h3>
		</div>
	</div>
</body>
</html>
