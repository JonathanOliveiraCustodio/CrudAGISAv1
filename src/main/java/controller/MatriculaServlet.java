package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

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
import persistence.AlunoDao;
import persistence.CursoDao;
import persistence.DisciplinaDao;
import persistence.DisciplinasMatriculadasDao;
import persistence.GenericDao;
import persistence.MatriculaDao;

@WebServlet("/matricula")
public class MatriculaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MatriculaServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String erro = "";
		boolean periodoValido = false;
		try {
			periodoValido = estaNoPeriodoDeMatricula();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("periodoValido", periodoValido);

			RequestDispatcher rd = request.getRequestDispatcher("matricula.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getParameter("botao");
		String RA = request.getParameter("RA");
		boolean periodoValido = false;

		// saida
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		Matricula m = new Matricula();
		Map<String, List<Disciplina>> disciplinasPorSemana = new HashMap<String, List<Disciplina>>();
		List<Integer> codigosDisciplinasMatriculadas = new ArrayList<>();

		try {
			periodoValido = estaNoPeriodoDeMatricula();
			a.setRA(Integer.parseInt(RA));
			if (cmd.contains("Buscar")) {
				a = buscarAluno(a);
				if (a == null) {
					saida = "Nenhum aluno encontrado com o RA especificado.";
					a = null;
				} else {
					disciplinasPorSemana = disciplinasDisponiveis(a);
					m = buscarMatriculaAtual(a);

					if (m.getCodigo() == 0) {
						m = novaMatricula(a);
					} else {
						codigosDisciplinasMatriculadas = buscarDisciplinasMatriculadasCodigos(m);
					}

				}
			} else {
				a = buscarAluno(a);
				m = buscarMatriculaAtual(a);
				String[] checkboxes = request.getParameterValues("disciplinaCheckbox");
				for (String c : checkboxes) {
					Disciplina d = new Disciplina();
					d.setCodigo(Integer.parseInt(c));
					d = buscarDisciplina(d);

					saida = realizarMatriculaDisciplina(d, m);
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("aluno", a);
		request.setAttribute("matricula", m);
		request.setAttribute("periodoValido", periodoValido);
		request.setAttribute("disciplinas", disciplinasPorSemana);
		request.setAttribute("disciplinasMatriculadas", codigosDisciplinasMatriculadas);
		RequestDispatcher rd = request.getRequestDispatcher("matricula.jsp");
		rd.forward(request, response);
	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultarPorRA(a);
		return a;
	}

	private Disciplina buscarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		d = dDao.consultar(d);
		return d;
	}

	private String realizarMatriculaDisciplina(Disciplina d, Matricula m) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinasMatriculadasDao dmDao = new DisciplinasMatriculadasDao(gDao);
		String saida = dmDao.matricularDisciplina(d, m);
		return saida;
	}

	private boolean estaNoPeriodoDeMatricula() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		Curso c = new Curso();

		long millisAtual = System.currentTimeMillis();
		Date dataAtual = new Date(millisAtual);
		boolean periodoValido = false;

		c = cDao.consultarPeriodoMatricula();
		periodoValido = (!c.getPeriodoMatriculaInicio().after(dataAtual) && !c.getPeriodoMatriculaFim().before(dataAtual));
		return periodoValido;
	}

	private Matricula buscarMatriculaAtual(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		MatriculaDao mDao = new MatriculaDao(gDao);
		Curso c = new Curso();
		c = cDao.consultarPeriodoMatricula();

		Matricula m = new Matricula();
		m = mDao.buscarMatriculaAluno(a, c.getPeriodoMatriculaInicio(), c.getPeriodoMatriculaFim());
		return m;
	}

	private List<Integer> buscarDisciplinasMatriculadasCodigos(Matricula m) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		DisciplinasMatriculadasDao dmDao = new DisciplinasMatriculadasDao(gDao);

		List<Integer> codigos = dmDao.buscarCodigoDisciplinasMatriculadas(m.getCodigo());
		return codigos;
	}

	private Matricula novaMatricula(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		MatriculaDao mDao = new MatriculaDao(gDao);

		mDao.novaMatricula(a);
		Matricula m = buscarMatriculaAtual(a);
		return m;
	}

	private Map<String, List<Disciplina>> disciplinasDisponiveis(Aluno a) throws ClassNotFoundException, SQLException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Map<String, List<Disciplina>> disciplinasPorSemana = new HashMap<String, List<Disciplina>>();
		GenericDao gDao2 = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao2);

		disciplinas = dDao.listarParaMatricula(a);
		for (Disciplina d : disciplinas) {
			List<Disciplina> temp = disciplinasPorSemana.get(d.getDiaSemana());

			if (temp == null) {
				temp = new ArrayList<Disciplina>();
				disciplinasPorSemana.put(d.getDiaSemana(), temp);
			}
			temp.add(d);
		}
		return disciplinasPorSemana;
	}
}
