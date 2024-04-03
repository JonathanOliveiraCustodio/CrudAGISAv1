<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Telefones do Aluno</title>
</head>
<body>
	<div>
		<%@include file="menu.jsp"%>
	</div>
	<br />
	<div align="center" class="container">
		<form action="telefone" method="post">
			<p class="title">
				<b>Telefones do Aluno</b>
			</p>
			<input type="hidden" name="aluno" value="${aluno.CPF}">


			<table>
				<tr>
					<td><label for="numero">Número:</label></td>
					<td><input class="input_data" type="text" id="numero"
						name="numero" placeholder="Número"></td>
					<td><label for="tipo">Tipo:</label></td>
					<td><select class="input_data" id="tipo" name="tipo">
							<option value="Residencial">Residencial</option>
							<option value="Comercial">Comercial</option>
							<option value="Celular">Celular</option>
					</select></td>
					<td><input type="submit" name="botao" value="Incluir"></td>

				</tr>
			</table>
		</form>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty telefones}">
			<table class="table_round">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="7"
							style="text-align: center; font-size: 23px;">Lista de
							Telefones</th>
					</tr>
					<tr>
						<th>Selecionar</th>
						<th>Código</th>
						<th>CPF do Aluno</th>
						<th>Número</th>
						<th>Tipo</th>
						<th>Editar</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${telefones}">
						<tr>
							<td><input type="checkbox" name="telefonesSelecionados"
								value="${t.codigo}"></td>
							<td><c:out value="${t.codigo}" /></td>
							<td><c:out value="${t.aluno.CPF}" /></td>
							<td><c:out value="${t.numero}" /></td>
							<td><c:out value="${t.tipo}" /></td>
							<td>
								<form action="editar-telefone" method="post">
									<input type="hidden" name="codigo" value="${t.codigo}">
									<input type="hidden" name="aluno" value="${t.aluno.CPF}">
									<input type="hidden" name="numero" value="${t.numero}">
									<input type="hidden" name="tipo" value="${t.tipo}">
									<button type="submit">Editar</button>
								</form>
							</td>
							<td>
								<form action="telefone" method="post">
									<input type="hidden" name="codigo" value="${t.codigo}">
									<input type="hidden" name="aluno" value="${t.aluno.CPF}">
									<input type="hidden" name="numero" value="${t.numero}">
									<input type="hidden" name="tipo" value="${t.tipo}"> <input
										type="hidden" name="botao" value="Excluir">
									<button type="submit">Excluir</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>