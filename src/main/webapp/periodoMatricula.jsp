<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <link rel="stylesheet" href="./css/styles.css">
    <title>Data para Matr�cula</title>
</head>
<body>
<div>
    <%@include file="menu.jsp"%>
</div>
<br />
<div align="center" class="container">
    <form action="dataMatricula" method="post">
        <p class="title">
            <b>Data para Matr�cula</b>
        </p>
        
        <table>
            <tr>
                <td><label for="periodoInicio">Per�odo de In�cio:</label></td>
                <td><input class="input_data" type="date" id="periodoInicio" name="periodoInicio"></td>
            </tr>
            <tr>
                <td><label for="periodoFim">Per�odo de Encerramento:</label></td>
                <td><input class="input_data" type="date" id="periodoFim" name="periodoFim"></td>
            </tr>
        </table>
        
        <input type="submit" id="botao" name="botao" value="Salvar">
    </form>
</div>
</body>
</html>
