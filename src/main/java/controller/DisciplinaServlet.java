package controller;

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
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/disciplina")
public class DisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DisciplinaServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String erro = "";
		
	    List<Disciplina> disciplinas = new ArrayList<>();
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);

		List<Professor> professores = new ArrayList<>();
		ProfessorDao pDao = new ProfessorDao(gDao);
		
		List<Curso> cursos = new ArrayList<>();
		CursoDao cDao = new CursoDao(gDao);

		try {
			disciplinas = dDao.listar();
			professores = pDao.listar();
			cursos = cDao.listar();

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("disciplinas", disciplinas);
			request.setAttribute("professores", professores);
			request.setAttribute("cursos", cursos);

			RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
			rd.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// entrada
		String cmd = request.getParameter("botao");
		String codigo = request.getParameter("codigo");
		String nome = request.getParameter("nome");
		String horasSemanais = request.getParameter("horasSemanais");		
		String horarioInicio = request.getParameter("horarioInicio");
		String semestre = request.getParameter("semestre");
		String diaSemana = request.getParameter("diaSemana");
		String professor = request.getParameter("professor");
		String curso = request.getParameter("curso");
	

		// saida
		String saida = "";
		String erro = "";
		
		Disciplina d = new Disciplina();

		List<Disciplina> disciplinas = new ArrayList<>();
		List<Professor> professores = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();

		if (!cmd.contains("Listar")) {
			d.setCodigo(Integer.parseInt(codigo));
		}
		try {
			disciplinas = listarDisciplinas();
			professores = listarProfessores();
			cursos = listarCursos();
		    
		    if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
		  
		    	d.setNome(nome);
		    	d.setHorasSemanais(Integer.parseInt(horasSemanais));
		    	d.setHoraInicio(Time.valueOf(horarioInicio));
		    	d.setSemestre(Integer.parseInt(semestre));
		    	d.setDiaSemana(diaSemana);
		    	
		    	Professor p = new Professor();
				p.setCodigo(Integer.parseInt(professor));
				p = buscarProfessor(p);
				
				Curso c = new Curso();
				c.setCodigo(Integer.parseInt(curso));
				c = buscarCurso(c);
				
				d.setProfessor(p);
				d.setCurso(c);
		    }

		    if (cmd.contains("Cadastrar")) {
		    	saida = cadastrarDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Alterar")) {
		    	saida = alterarDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Excluir")) {
		    	saida = excluirDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Buscar")) {
		        d = buscarDisciplina(d);
		    }
		    
		    if (cmd.contains("Listar")) {
		        disciplinas = listarDisciplinas();
		        request.setAttribute("tipoTabela", "Listar"); 
		    }
		    
	
		    
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {
		    request.setAttribute("saida", saida);
		    request.setAttribute("erro", erro);
		    request.setAttribute("disciplina", d);
		    request.setAttribute("disciplinas", disciplinas);
		    request.setAttribute("professores", professores);
		    request.setAttribute("cursos", cursos);
		    RequestDispatcher rd = request.getRequestDispatcher("disciplina.jsp");
		    rd.forward(request, response);
		}
	}



	private String cadastrarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao pDao = new DisciplinaDao(gDao);
		String saida = pDao.iudDisciplina("I", d);
		return saida;

	}

	private String alterarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.iudDisciplina("U", d);
		return saida;

	}

	private String excluirDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.iudDisciplina("D", d);
		return saida;

	}
	private Disciplina buscarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		d = dDao.consultar(d);
		return d;
	}

	private List<Disciplina> listarDisciplinas() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();
		return disciplinas;
	}
	

	private Professor buscarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		p = pDao.consultar(p);
		return p;

	}

	private List<Professor> listarProfessores() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		List<Professor> professores = pDao.listar();

		return professores;
	}
	
	private Curso buscarCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		c = cDao.consultar(c);
		return c;

	}

	private List<Curso> listarCursos() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		List<Curso> cursos = cDao.listar();

		return cursos;
	}

}
