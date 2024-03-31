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
            <li><a href="index.jsp">Home</a></li>
            <li class="submenu">
                <a href="#">Aluno &#9662;</a>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/aluno">Manter Aluno</a></li>
                    <li><li><a href="matricula.jsp">Matricula</a></li>                
                </ul>
            </li>
            <li><a href="${pageContext.request.contextPath}/curso">Curso</a></li>
            <li><a href="${pageContext.request.contextPath}/disciplina">Disciplina</a></li>
            <li><li><a href="conteudo.jsp">Conteudo</a></li>  
            <li><a href="${pageContext.request.contextPath}/professor">Professor</a></li>
        </ul>
    </nav>

</body>
</html>