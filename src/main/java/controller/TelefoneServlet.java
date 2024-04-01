package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Telefone;
import persistence.AlunoDao;
import persistence.GenericDao;
import persistence.TelefoneDao;

@WebServlet("/telefone")
public class TelefoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TelefoneServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String erro = "";
		String aluno = request.getParameter("aluno");
		Aluno a = new Aluno();
		List<Telefone> telefones = new ArrayList<>();
		
		try {
			telefones = listarTelefones(aluno);

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("telefones", telefones);

			RequestDispatcher rd = request.getRequestDispatcher("telefone.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String cmd = request.getParameter("botao");
		String codigo = request.getParameter("codigo");
		String aluno = request.getParameter("aluno");
		String numero = request.getParameter("numero");
		String tipo = request.getParameter("tipo");

		String saida = "";
		String erro = "";

		Telefone t = new Telefone();

		Aluno a = new Aluno();
		List<Aluno> alunos = new ArrayList<>();
		List<Telefone> telefones = new ArrayList<>();

		try {
			aluno = request.getParameter("aluno");
			telefones = listarTelefones(aluno);

			if (!cmd.contains("Listar")) {
				t.setCodigo(Integer.parseInt(codigo));
			}

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				t.setNumero(numero);
				t.setTipo(tipo);
				a.setCPF(aluno);
				a = buscarAluno(a);
				t.setAluno(a);
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarTelefone(t);
				t = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarTelefone(t);
				t = null;
			}
			if (cmd.contains("Excluir")) {
				t = buscarTelefone(t);
				saida = excluirTelefone(t);
				t = null;
			}
			if (cmd.contains("Buscar")) {
				t = buscarTelefone(t);
				if (t == null) {
					saida = "Nenhum telefone encontrado com o código especificado.";
					t = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				t = null;
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("telefone", t);
			request.setAttribute("alunos", alunos);
			request.setAttribute("telefones", telefones);
			RequestDispatcher rd = request.getRequestDispatcher("telefone.jsp");
			rd.forward(request, response);
		}

	}

	private String cadastrarTelefone(Telefone a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("I", a);
		return saida;

	}

	private String alterarTelefone(Telefone a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("U", a);
		return saida;

	}

	private String excluirTelefone(Telefone a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("D", a);
		return saida;

	}

	private Telefone buscarTelefone(Telefone a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		a = pDao.consultar(a);
		return a;
	}

	private List<Telefone> listarTelefones(String cpfAluno) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		List<Telefone> telefones = pDao.listar(cpfAluno);
		return telefones;
	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultar(a);
		return a;
	}

}
