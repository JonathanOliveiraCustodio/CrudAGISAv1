package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Curso;
import model.Disciplina;
import model.Matricula;
import model.Professor;
import persistence.AlunoDao;
import persistence.CursoDao;
import persistence.DisciplinaDao;
import persistence.GenericDao;
import persistence.MatriculaDao;
import persistence.ProfessorDao;
import java.io.IOException;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/horarios")
public class HorariosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public HorariosServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("horarios.jsp");
		rd.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RA = request.getParameter("RA");
		Aluno a = new Aluno();
		Matricula m = new Matricula();
		String erro = null;
		String saida = null;
		Map<String, List<Disciplina>> disciplinasMatriculadas = new HashMap<String, List<Disciplina>>();
		
		try {
			a.setRA(Integer.parseInt(RA));
			a = buscarAluno(a);
			if (a == null) {
				saida = "Nenhum aluno encontrado com o RA especificado.";
				a = null;
			} else {
				m = buscarMatriculaAtual(a);
				disciplinasMatriculadas = buscarDisciplinasAluno(m);				
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}
		
		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("aluno", a);
		request.setAttribute("matricula", m);
		request.setAttribute("disciplinas", disciplinasMatriculadas);
		RequestDispatcher rd = request.getRequestDispatcher("horarios.jsp");
		rd.forward(request, response);
		
	}


	private Map<String, List<Disciplina>> buscarDisciplinasAluno(Matricula m) throws ClassNotFoundException, SQLException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Map<String, List<Disciplina>> disciplinasPorSemana = new HashMap<String, List<Disciplina>>();
		GenericDao gDao2 = new GenericDao();
	 	DisciplinaDao dDao = new DisciplinaDao(gDao2);
	 	
		disciplinas = dDao.listarDisciplinasCursadas(m);
		for(Disciplina d : disciplinas){
		    List<Disciplina> temp = disciplinasPorSemana.get(d.getDiaSemana());

		    if(temp == null){
		        temp = new ArrayList<Disciplina>();
		        disciplinasPorSemana.put(d.getDiaSemana(), temp);
		    }
		    temp.add(d);
		}
		return disciplinasPorSemana;
	}


	private Matricula buscarMatriculaAtual(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		MatriculaDao mDao = new MatriculaDao(gDao);
		Matricula m = new Matricula();
		m = mDao.buscarMatriculaAtualAluno(a);
		return m;
	}


	private Aluno buscarAluno(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultarPorRA(a);
		return a;
	}

}
