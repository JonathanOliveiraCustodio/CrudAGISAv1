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
import model.Professor;
import persistence.GenericDao;
import persistence.ProfessorDao;

@WebServlet("/professor")
public class ProfessorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProfessorServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("professor.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// entrada
		String cmd = request.getParameter("botao");
		String codigo = request.getParameter("codigo");
		String nome = request.getParameter("nome");
		String titulacao = request.getParameter("titulacao");

		// saida
		String saida = "";
		String erro = "";
		Professor p = new Professor();
		List<Professor> professores = new ArrayList<>();
		

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			p = null;
		
		} else {
			
			if (!cmd.contains("Listar")) {
				p.setCodigo(Integer.parseInt(codigo));
			}
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				p.setNome(nome);
				p.setTitulacao(titulacao);
			}
			try {
				if (cmd.contains("Cadastrar")) {
					saida = cadastrarProfessor(p);
					p = null;
				}
				if (cmd.contains("Alterar")) {
					saida = alterarProfessor(p);
					p = null;
				}
				if (cmd.contains("Excluir")) {
					saida = excluirProfessor(p);
					p = null;
				}
				if (cmd.contains("Buscar")) {
					p = buscarProfessor(p);
					if (p == null) {
						saida = "Nenhum professor encontrado com o código especificado.";
						p = null;
					}
				}
				if (cmd.contains("Listar")) {
					professores = listarProfessores();
				}
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			}
		}

		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("professor", p);
		request.setAttribute("professores", professores);

		RequestDispatcher rd = request.getRequestDispatcher("professor.jsp");
		rd.forward(request, response);
	}

	private String cadastrarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		String saida = pDao.iudProfessor("I", p);
		return saida;

	}

	private String alterarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		String saida = pDao.iudProfessor("U", p);
		return saida;

	}

	private String excluirProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		String saida = pDao.iudProfessor("D", p);
		return saida;

	}

	private Professor buscarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		p = pDao.consultar(p);
		return p;

	}

	private List<Professor> listarProfessores() throws SQLException, ClassNotFoundException {

		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		List<Professor> professores = pDao.listar();

		return professores;
	}

}