<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Aluno</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="aluno" method="post">
			<p class="title">
				<b>Aluno</b>
			</p>

			<table>
				<tr>
					<td colspan="3"><label for="CPF">CPF:</label><input
						class="input_data" type="number" id="CPF" name="CPF"
						placeholder="CPF" value='<c:out value="${aluno.CPF }"></c:out>'></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar"></td>
				</tr>
				<tr>
					<td colspan="4"><label for="nome">Nome:</label><input
						class="input_data" type="text" id="nome" name="nome"
						placeholder="Nome" value='<c:out value="${aluno.nome }"></c:out>'></td>
				</tr>
				<tr>
					<td colspan="4"><label for="nomeSocial">Nome Social:</label><input
						class="input_data" type="text" id="nomeSocial" name="nomeSocial"
						placeholder="Nome Social"
						value='<c:out value="${aluno.nomeSocial }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="dataNascimento">Data
							Nascimento:</label><input class="input_data" type="date"
						id="dataNascimento" name="dataNascimento"
						placeholder="Data Nascimento"
						value='<c:out value="${aluno.dataNascimento }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="4"><label for="telefoneContato">Telefone
							Contato:</label><input class="input_data" type="text"
						id="telefoneContato" name="telefoneContato"
						placeholder="Telefone Contato"
						value='<c:out value="${aluno.telefoneContato }"></c:out>'></td>
				</tr>
				<tr>
					<td colspan="4"><label for="emailPessoal">E-mail
							Pessoal:</label><input class="input_data" type="text" id="emailPessoal"
						name="emailPessoal" placeholder="E-mail Pessoal"
						value='<c:out value="${aluno.emailPessoal }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="emailCorporativo">E-mail
							Corporativo:</label><input class="input_data" type="text"
						id="emailCorporativo" name="emailCorporativo"
						placeholder="E-mail Corporativo"
						value='<c:out value="${aluno.emailCorporativo }"></c:out>'></td>
				</tr>
				<tr>
					<td colspan="4"><label for="dataConclusao2Grau">Data
							Conclusao 2Grau:</label><input class="input_data" type="date"
						id="dataConclusao2Grau" name="dataConclusao2Grau"
						placeholder="Data Conclusao 2 Grau"
						value='<c:out value="${aluno.dataConclusao2Grau }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="nome">Instituicao
							Conclusao 2Grau:</label><input class="input_data" type="text"
						id="instituicaoConclusao2Grau" name="instituicaoConclusao2Grau"
						placeholder="Instituicao Conclusao 2 Grau"
						value='<c:out value="${aluno.instituicaoConclusao2Grau }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="pontuacaoVestibular">Pontuacao
							Vestibular:</label><input class="input_data" type="text"
						id="pontuacaoVestibular" name="pontuacaoVestibular"
						placeholder="Pontuacao Vestibular"
						value='<c:out value="${aluno.pontuacaoVestibular }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="posicaoVestibular">Posicao
							Vestibular:</label><input class="input_data" type="text"
						id="posicaoVestibular" name="posicaoVestibular"
						placeholder="Posicao Vestibular"
						value='<c:out value="${aluno.posicaoVestibular }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="anoIngresso">Ano Ingresso:</label><input
						class="input_data" type="text" id="anoIngresso" name="anoIngresso"
						placeholder="Ano Ingresso"
						value='<c:out value="${aluno.anoIngresso }"></c:out>'></td>
				</tr>

				<tr>
					<td colspan="4"><label for="semestreIngresso">Semestre
							Ingresso:</label><input class="input_data" type="text"
						id="semestreIngresso" name="semestreIngresso"
						placeholder="Semestre Ingresso"
						value='<c:out value="${aluno.semestreIngresso }"></c:out>'></td>
				</tr>
				<tr>
					<td colspan="4"><label for="semestreAnoLimiteGraduacao">Semestre
							Limite Graduação:</label> <input class="input_data" type="text"
						id="semestreAnoLimiteGraduacao" name="semestreAnoLimiteGraduacao"
						placeholder="Semestre Limite Graduação"
						value='<c:out value="${aluno.semestreAnoLimiteGraduacao }"></c:out>'
						readonly onkeypress="showAlert()"></td>
				</tr>

				<tr>
					<td colspan="4"><label for="RA">RA:</label> <input
						class="input_data" type="text" id="RA" name="RA" placeholder="RA"
						value='<c:out value="${aluno.RA }"></c:out>' readonly
						onkeypress="showAlert()"></td>
				</tr>
				
				<tr>
				<td colspan="4"><label for="data">Curso:</label><select class="input_data" id="curso"
					name="curso">
						<option value="0">Escolha um Curso</option>
						<c:forEach var="p" items="${cursos }">
							<c:if
								test="${(empty curso) || (p.codigo ne aluno.curso.codigo) }">
								<option value="${p.codigo }">
									<c:out value="${p }" />
								</option>
							</c:if>
							<c:if test="${p.codigo eq aluno.curso.codigo}">
								<option value="${p.codigo }" selected="selected"><c:out
										value="${p }" /></option>
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
		<c:if test="${not empty alunos }">
			<table class="table_round">
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>Nome Social</th>
						<th>Data Nascimento</th>
						<th>Telefone Contato</th>
						<th>E-mail Pessoal</th>
						<th>E-mail Corporativo</th>
						<th>Data Conclusao 2Grau</th>
						<th>Instituicao 2Grau</th>
						<th>Pontuacao Vestibular</th>
						<th>Posicao Vestibular</th>
						<th>Ano Ingresso</th>
						<th>Semestre Ingresso</th>
						<th>Semestre Limite</th>
						<th>RA</th>
						<th>Curso</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="a" items="${alunos }">
						<tr>
							<td><c:out value="${a.CPF }" /></td>
							<td><c:out value="${a.nome }" /></td>
							<td><c:out value="${a.nomeSocial }" /></td>
							<td><c:out value="${a.dataNascimento }" /></td>
							<td><c:out value="${a.telefoneContato }" /></td>
							<td><c:out value="${a.emailPessoal }" /></td>
							<td><c:out value="${a.emailCorporativo }" /></td>
							<td><c:out value="${a.dataConclusao2Grau }" /></td>
							<td><c:out value="${a.instituicaoConclusao2Grau }" /></td>
							<td><c:out value="${a.pontuacaoVestibular }" /></td>
							<td><c:out value="${a.posicaoVestibular }" /></td>
							<td><c:out value="${a.anoIngresso }" /></td>
							<td><c:out value="${a.semestreIngresso }" /></td>
							<td><c:out value="${a.semestreAnoLimiteGraduacao }" /></td>
							<td><c:out value="${a.RA }" /></td>
							<td><c:out value="${a.curso.nome }" /></td>
						</tr>
					</c:forEach>

				</tbody>

			</table>
		</c:if>
	</div>
</body>
</html>