<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Curso</title>

<script>
	function validarBusca() {
		var cpf = document.getElementById("codigo").value;
		if (cpf.trim() === "") {
			alert("Por favor, insira um Código.");
			return false;
		}
		return true;
	}
</script>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="curso" method="post">
			<p class="title">
				<b>Manutenção Curso</b>
			</p>

			<table>
				<tr>
					<td><label for="codigo"
						style="display: inline-block; width: 100%;">Código:</label></td>
					<td colspan="3"><input class="input_data_id" type="number"
						min="0" step="1" id="codigo" name="codigo" placeholder="Código"
						value='<c:out value="${curso.codigo }"></c:out>'
						style="width: calc(100% - 90px);"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar" onclick="return validarBusca()"></td>
				</tr>
				<tr>
					<td><label for="nome"
						style="display: inline-block; width: 100%;">Nome:</label></td>
					<td colspan="4"><input class="input_data" type="text"
						id="nome" name="nome" placeholder="Nome"
						value='<c:out value="${curso.nome }"></c:out>'
						style="width: calc(100% - 90px);"></td>
				</tr>
				<tr>
					<td><label for="cargaHoraria"
						style="display: inline-block; width: 100%;">Carga Horaria:</label></td>
					<td colspan="3"><input class="input_data" type="number"
						min="0" step="1" id="cargaHoraria" name="cargaHoraria"
						placeholder="Carga Horária"
						value='<c:out value="${curso.cargaHoraria }"></c:out>'
						style="width: calc(100% - 90px);"></td>
				</tr>
				<tr>
					<td><label for="sigla"
						style="display: inline-block; width: 100%;">Sigla:</label></td>
					<td colspan="4"><input class="input_data" type="text"
						id="sigla" name="sigla" placeholder="Sigla"
						value='<c:out value="${curso.sigla }"></c:out>'
						style="width: calc(100% - 90px);"></td>
				</tr>
				<tr>
					<td><label for="ultimaNotaENADE"
						style="display: inline-block; width: 100%;">Nota ENADE:</label></td>
					<td colspan="4"><input class="input_data" type="text"
						id="ultimaNotaENADE" name="ultimaNotaENADE"
						placeholder="Última Nota ENADE"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(parseFloat(this.value) > 5.0) this.value = '5.0';"
						value='<c:out value="${curso.ultimaNotaENADE}"></c:out>'
						style="width: calc(100% - 90px);"></td>
				</tr>


				<tr>
					<td><label for="turno"
						style="display: inline-block; width: 100%;">Turno:</label></td>
					<td colspan="4"><input class="input_data" type="text"
						id="turno" name="turno" placeholder="Turno"
						value='<c:out value="${curso.turno }"></c:out>'
						style="width: calc(100% - 90px);"></td>
				</tr>
			</table>
			<table>
				<tr style="text-align: center;">
					<td><input type="submit" id="botao" name="botao"
						value="Cadastrar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Alterar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Excluir"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Listar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Limpar"></td>
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
		<c:if test="${not empty cursos }">
			<table class="table_round">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="6"
							style="text-align: center; font-size: 23px;">Lista de Cursos</th>
					</tr>
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Carga Horária</th>
						<th>Sigla</th>
						<th>Última Nota ENADE</th>
						<th>Turno</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${cursos }">
						<tr>
							<td><c:out value="${c.codigo }" /></td>
							<td><c:out value="${c.nome }" /></td>
							<td><c:out value="${c.cargaHoraria }" /></td>
							<td><c:out value="${c.sigla }" /></td>
							<td><c:out value="${c.ultimaNotaENADE }" /></td>
							<td><c:out value="${c.turno }" /></td>
						</tr>
					</c:forEach>

				</tbody>

			</table>
		</c:if>
	</div>
</body>
</html>
