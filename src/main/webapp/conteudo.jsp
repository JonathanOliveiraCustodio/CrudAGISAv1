<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Conteudo</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="conteudo" method="post">
			<p class="title">
				<b>Manutenção de Conteudo</b>
			</p>
			<table>
				<tr>
					<td colspan="3"><label for="data">Código Conteudo:</label> <input
						class="input_data_id" type="number" min="0" step="1" id="codigo"
						name="codigo" placeholder="Codigo Conteudo"
						value='<c:out value="${conteudo.codigo }"></c:out>'
						style="width: 80px;"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar"></td>
				</tr>

				<tr>
					<td colspan="4"><label for="data">Nome :</label> <input
						class="input_data" type="text" id="nome" name="nome"
						placeholder="Nome"
						value='<c:out value="${conteudo.nome }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="data">Descrição:</label> <input
						class="input_data" type="text" id="descricao" name="descricao"
						placeholder="Descrição"
						value='<c:out value="${conteudo.descricao }"></c:out>'></td>
				</tr>
				<tr>
					<td colspan="4"><label for="data">Disciplina:</label> <select
						class="input_data" id="disciplina" name="disciplina">
							<option value="0">Escolha uma Disciplina</option>
							<c:forEach var="d" items="${disciplinas }">
								<c:if
									test="${(empty conteudo) || (d.codigo ne conteudo.disciplina.codigo) }">
									<option value="${d.codigo }"><c:out value="${d }" /></option>
								</c:if>
								<c:if test="${d.codigo eq conteudo.disciplina.codigo }">
									<option value="${d.codigo }" selected="selected"><c:out
											value="${d }" /></option>
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
		<c:if test="${not empty conteudos}">
			<table class="table_round">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="4" style="text-align: center; font-size: 23px;">Lista
							de Conteudo</th>
					</tr>
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Descricao</th>
						<th>Disciplina</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${conteudos}">
						<tr>
							<td><c:out value="${c.codigo}" /></td>
							<td><c:out value="${c.nome}" /></td>
							<td><c:out value="${c.descricao}" /></td>
							<td><c:out value="${c.disciplina.nome}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

	</div>
</body>
</html>
