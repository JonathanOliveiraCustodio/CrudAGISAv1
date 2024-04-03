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
	<div>
		<jsp:include page="headerAluno.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">Bem-vindo Aluno ao Sistema AGIS</h1>
		      	<p class="lead">Aqui voc� pode realizar as seguintes op��es:</p>
		      	<div class=" mx-5 px-5 bg-body-tertiary rounded-3 text-center">
			      	<ul class="list-group d-grid gap-2 border-0">
	  					<li class="list-group-item">Manter sua Matricula</li>
	  					<li class="list-group-item">Consultar a Grade</li>
	  				</ul>
				</div>
		    </div>
		</div>
	</div>
</body>