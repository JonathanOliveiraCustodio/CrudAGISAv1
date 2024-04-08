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
		List<Telefone> telefones = new ArrayList<>();
		Aluno a = new Aluno();
		a.setCPF(aluno);
		
		try {
			telefones = listarTelefones(aluno);

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("telefones", telefones);
			request.setAttribute("aluno", a);

			RequestDispatcher rd = request.getRequestDispatcher("telefone.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Entrada
	    String cmd = request.getParameter("botao");   
	    String aluno = request.getParameter("aluno");
	    String numero = request.getParameter("numero");
	    String tipo = request.getParameter("tipo");
	    
	    // Verificar se o botão Telefones foi clicado
	    if (cmd != null && cmd.equals("Telefones")) {
	        // Redirecionar para a página "telefone" com o parâmetro aluno
	        response.sendRedirect("telefone?aluno=" + aluno);
	        return; // Terminar o processamento do método doPost
	    }
	    
	    // Saída
	    String saida = "";
	    String erro = "";
	    
	    Telefone t = new Telefone();
	    Aluno a = new Aluno();

	    List<Telefone> telefones = new ArrayList<>();
	    
	    try {
	        if (!cmd.contains("Listar")) {
	            a.setCPF(aluno);
	            a = buscarAluno(a);
	            t.setAluno(a);
	            t.setNumero(numero);
	            t.setTipo(tipo);
	        }
	        
	        if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {        
	            t.setNumero(numero);
	            t.setTipo(tipo);        
	        }

	        if (cmd.contains("Cadastrar")) {
	            saida = cadastrarTelefone(t, a);
	        }
	        if (cmd.contains("Alterar")) {
	            saida = alterarTelefone(t, a);
	        }
	        if (cmd.contains("Excluir")) {       
	            saida = excluirTelefone(t, a);
	        }
	        if (cmd.contains("Buscar")) {
	            t = buscarTelefone(t);
	            if (t == null) {
	                saida = "Nenhum conteudo encontrado com o código especificado.";
	            }
	        }
	        
	        telefones = listarTelefones(aluno);
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        erro = e.getMessage();
	    } finally {
	        request.setAttribute("saida", saida);
	        request.setAttribute("erro", erro);
	        request.setAttribute("telefone", t);
	        request.setAttribute("telefones", telefones);
	        request.setAttribute("aluno", a);
	        RequestDispatcher rd = request.getRequestDispatcher("telefone.jsp");
	        rd.forward(request, response);
	    }
	}

	private String cadastrarTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("I", a, al);
		return saida;

	}

	private String alterarTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("U", a, al);
		return saida;

	}

	private String excluirTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("D", a, al);
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
