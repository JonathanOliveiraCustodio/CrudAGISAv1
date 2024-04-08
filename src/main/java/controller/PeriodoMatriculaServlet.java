package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Curso;
import model.Disciplina;
import model.Professor;
import persistence.CursoDao;
import persistence.DisciplinaDao;
import persistence.GenericDao;
import persistence.ProfessorDao;

@WebServlet("/periodoMatricula")
public class PeriodoMatriculaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PeriodoMatriculaServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String erro = "";
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		Curso c = new Curso();
		
		try {
			c = cDao.consultarPeriodoMatricula();
		} catch (Exception e) {
			erro = e.getMessage();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("periodoMatricula.jsp");
		request.setAttribute("erro", erro);
		request.setAttribute("curso", c);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Entrada
		String periodoMatriculaInicio = request.getParameter("periodoMatriculaInicio");		
		String periodoMatriculaFim = request.getParameter("periodoMatriculaFim");
		
		// Saída
		String saida = "";
		String erro = "";
		
		Curso c = new Curso();
		c.setPeriodoMatriculaInicio(Date.valueOf(periodoMatriculaInicio));
		c.setPeriodoMatriculaFim(Date.valueOf(periodoMatriculaFim));
		
		try {
			saida = alterarPeriodoMatricula(c);
		} catch (Exception e) {
			erro = e.getMessage();
		}
		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("curso", c);
		
		RequestDispatcher rd = request.getRequestDispatcher("periodoMatricula.jsp");
		rd.forward(request, response);
	}
	
	private String alterarPeriodoMatricula(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		String saida = cDao.alterarPeriodoMatricula(c);
		return saida;

	}

}
