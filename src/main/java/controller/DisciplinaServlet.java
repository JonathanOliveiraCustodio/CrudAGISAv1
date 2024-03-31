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
		
		List<Professor> professores = new ArrayList<>();
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		
		List<Curso> cursos = new ArrayList<>();
		CursoDao cDao = new CursoDao(gDao);
			
		List<Disciplina> disciplinas = new ArrayList<>();
	//	DisciplinaDao dDao = new DisciplinaDao(gDao);
		
		try {
			professores = pDao.listar();
			cursos = cDao.listar();
		//	disciplinas = dDao.listar();
					
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("professores", professores);	
			request.setAttribute("cursos", cursos);
			request.setAttribute("disciplinas", disciplinas);
			
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
		String horaInicio = request.getParameter("horaInicio");
		String semestre = request.getParameter("semestre");
		String diaSemana = request.getParameter("diaSemana");
		String professor = request.getParameter("professor");
		String curso = request.getParameter("curso");
		
		// saida
		String saida = "";
		String erro = "";	
		
		
		Disciplina d = new Disciplina();
		Professor p = new Professor();
        Curso c = new Curso();
		
		
		List<Professor> professores = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();
		List<Disciplina> disciplinas = new ArrayList<>();
	    

		try {
			
		if (!cmd.contains("Listar")) {
			p.setCodigo(Integer.parseInt(professor));
			p = buscarProfessor(p);
			d.setProfessor(p);			
			c.setCodigo(Integer.parseInt(curso));
			c = buscarCurso(c);
			d.setCurso(c);			
			d.setCodigo(Integer.parseInt(codigo));
		}			
			professores = listarProfessores();
			cursos = listarCursos();
				
		    if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {	  			
		    	d.setNome(nome);
		    	d.setHorasSemanais(Integer.parseInt(horasSemanais));
		    	d.setHoraInicio(horaInicio);
		    	d.setSemestre(Integer.parseInt(semestre));
		    	d.setDiaSemana(diaSemana);			
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
				if (d == null) {
					saida = "Nenhuma disciplina encontrado com o código especificado.";
					d = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				d = null;
			}

			if (cmd.contains("Listar")) {
				disciplinas = listarDisciplinas();
			}
		    			    
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {
		    request.setAttribute("saida", saida);
		    request.setAttribute("erro", erro);
		    request.setAttribute("disciplina", d);
		    request.setAttribute("professores", professores);
		    request.setAttribute("cursos", cursos);
		    request.setAttribute("disciplinas", disciplinas);		   
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
