<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
        <form action="aluno" method="post">
            <p class="title">
                <b>Disciplina</b>
            </p>
            <table>
                <tr>
                    <td colspan="3"><label for="RA" class="input_label">RA:</label><input class="input_data" type="text" id="RA" name="RA" placeholder="RA" value='<c:out value="${matricula.RA}"></c:out>'></td>
                    <td><input type="submit" id="botao" name="botao" value="Buscar"></td>
                </tr>
                <tr>
                    <td colspan="3"><label for="data" class="input_label">Disciplina:</label> <select class="input_data" id="disciplina" name="disciplina">
                            <option>Seleciona uma Disciplina</option>
                            <c:forEach var="d" items="${disciplinas}">
                                <option value="${d.codigo}">
                                    <c:out value="${d.nome}" />
                                </option>
                            </c:forEach>
                    </select></td>
                    <td>
                        <input class="input_data" type="submit" id="botao" name="botao" value="Matricular">
                        <input class="input_data" type="submit" id="botao" name="botao" value="Listar">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <c:if test="${not empty matriculas}">
        <table class="table_round">
            <thead>
                <tr>
                    <th><b>Codigo Matricula</b></th>
                    <th><b>RA</b></th>
                    <th><b>Ano</b></th>
                    <th><b>Semest. Inicio</b></th>
                    <th><b>Disciplina</b></th>
                    <th><b>Situação</b></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${matriculas}">
                    <tr>
                        <td><c:out value="${a.idMatricula}"></c:out></td>
                        <td><c:out value="${a.aluno.RA}"></c:out></td>
                        <td><c:out value="${a.ano}"></c:out></td>
                        <td><c:out value="${a.semestreMatricula}"></c:out></td>
                        <td><c:out value="${a.disciplina.nomeDisciplina}"></c:out></td>
                        <td><c:out value="${a.aprovacao}"></c:out></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
