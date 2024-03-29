<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Matricula</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<p class="title">
			<b>Manutenção Matricula</b>
		</p>

		<table>
			<tr>
				<td colspan="4"><label for="CPF">CPF:</label><input
					class="input_data" type="number" id="CPF" name="CPF"
					placeholder="CPF" value='<c:out value="${aluno.CPF }"></c:out>'></td>
				<td><input type="submit" id="botao" name="botao" value="Buscar"></td>
			</tr>
		</table>


		<table class="table_round">
			<thead>
				<tr>
					<th></th>
					<th class="titulo-tabela" colspan="5"
						style="text-align: center; font-size: 21px;">Segunda-Feira</th>
				</tr>
				<tr>
					<th></th>
					<th>Código</th>
					<th>Nome</th>
					<th>Hora Semanais</th>
					<th>Hora Início</th>
					<th>Semestre</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="disciplina" items="${segundaFeira }">
					<tr>
						<td><input type="checkbox" name="disciplinaCheckbox"
							value="${disciplina.codigo}"></td>
						<td>${disciplina.codigo}</td>
						<td>${disciplina.nome}</td>
						<td>${disciplina.horaSemanais}</td>
						<td>${disciplina.horaInicio}</td>
						<td>${disciplina.Semestre}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<table class="table_round">
			<thead>
				<tr>
					<th></th>
					<th class="titulo-tabela" colspan="5"
						style="text-align: center; font-size: 21px;">Terça-Feira</th>
				</tr>
				<tr>
					<th></th>
					<th>Código</th>
					<th>Nome</th>
					<th>Hora Semanais</th>
					<th>Hora Início</th>
					<th>Semestre</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="disciplina" items="${tercaFeira }">
					<tr>
						<td><input type="checkbox" name="disciplinaCheckbox"
							value="${disciplina.codigo}"></td>
						<td>${disciplina.codigo}</td>
						<td>${disciplina.nome}</td>
						<td>${disciplina.horaSemanais}</td>
						<td>${disciplina.horaInicio}</td>
						<td>${disciplina.Semestre}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		
	</div>
</body>
</html>
