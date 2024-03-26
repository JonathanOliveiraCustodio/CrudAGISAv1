<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Disciplina</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="disciplina" method="post">
			<p class="title">
				<b>Disciplina</b>
			</p>
			<table>
				<tr>
					<td colspan="3"><label for="data">Código Disciplina:</label> <input
						class="input_data_id" type="number" min="0" step="1" id="codigo"
						name="codigo" placeholder="Codigo Disciplina"
						value='<c:out value="${disciplina.codigo }"></c:out>'></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar"></td>
				</tr>

				<tr>
					<td colspan="4"><label for="data">Nome :</label> <input
						class="input_data" type="text" id="nome" name="nome"
						placeholder="Nome"
						value='<c:out value="${disciplina.nome }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="data">Horas Semanais:</label> <input
						class="input_data_id" type="number" min="0" max="23" step="1"
						id="horasSemanais" name="horasSemanais"
						placeholder="Horas Semanais"
						value='<c:out value="${disciplina.horasSemanais }"></c:out>'></td>
				</tr>
				
				<tr>
					<td colspan="4"><label for="data">Hora Inicio:</label> <input
						class="input_data_id" type="number" min="0" max="23" step="1"
						id="horaInicio" name="horaInicio"
						placeholder="Hora Inicio"
						value='<c:out value="${disciplina.horaInicio }"></c:out>'></td>
				</tr>
				
				<tr>
					<td colspan="4"><label for="data">Semestre:</label> <input
						class="input_data_id" type="number" min="0" max="23" step="1"
						id="semestre" name="semestre"
						placeholder="Semestre"
						value='<c:out value="${disciplina.semestre }"></c:out>'></td>
				</tr>
				
				<tr>
					<td colspan="4"><label for="data">Dia da Semana:</label> <input
						class="input_data" type="text" id="diaSemana" name="diaSemana"
						placeholder="Dia da Semana"
						value='<c:out value="${disciplina.diaSemana }"></c:out>'></td>
				</tr>
				

				<tr>
					<td colspan="4"><label for="data">Professor:</label><select
						class="input_data" id="professor" name="professor">
							<option value="0">Escolha um professor</option>
							<c:forEach var="p" items="${professores }">
								<c:if
									test="${(empty disciplina) || (p.codigo ne disciplina.professor.codigo) }">
									<option value="${p.codigo }">
										<c:out value="${p }" />
									</option>
								</c:if>
								<c:if test="${p.codigo eq disciplina.professor.codigo }">
									<option value="${p.codigo }" selected="selected"><c:out
											value="${p }" /></option>
								</c:if>

							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<td colspan="4"><label for="data">Curso:</label><select
						class="input_data" id="curso" name="curso">
							<option value="0">Escolha um Curso</option>
							<c:forEach var="c" items="${cursos }">
								<c:if
									test="${(empty disciplina) || (c.codigo ne disciplina.curso.codigo) }">
									<option value="${c.codigo }">
										<c:out value="${c }" />
									</option>
								</c:if>
								<c:if test="${c.codigo eq disciplina.curso.codigo }">
									<option value="${c.codigo }" selected="selected"><c:out
											value="${c }" /></option>
								</c:if>

							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Cadastrar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Alterar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Excluir"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Listar"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<h2>
				<b><c:out value="${erro }" /></b>
			</h2>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty saida }">
			<h3>
				<b><c:out value="${saida }" /></b>
			</h3>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:choose>
			<c:when test="${not empty tipoTabela && tipoTabela eq 'Listar'}">
				<c:if test="${not empty disciplinas}">
					<table class="table_round">
						<thead>
							<tr>
								<th>Código</th>
								<th>Nome</th>
								<th>Hora Semanais</th>
								<th>Hora Inicio</th>
								<th>Semestre</th>
								<th>Dia Semana</th>								
								<th>Professor</th>
								<th>Curso</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach var="d" items="${disciplinas}">
								<tr>
									<td><c:out value="${d.codigo}" /></td>
									<td><c:out value="${d.nome}" /></td>
									<td><c:out value="${d.horasSemanais}" /></td>
									<td><c:out value="${d.horaInicio}" /></td>
									<td><c:out value="${d.semestre}" /></td>
									<td><c:out value="${d.diaSemana}" /></td>							
									<td><c:out value="${d.professor.nome}" /></td>
									<td><c:out value="${d.curso.nome}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</c:when>


		</c:choose>
	</div>
</body>
</html>
