package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Conteudo;
import model.Disciplina;
import persistence.ConteudoDao;
import persistence.DisciplinaDao;
import persistence.GenericDao;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/conteudo")
public class ConteudoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ConteudoServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String erro = "";
		List<Disciplina> disciplinas = new ArrayList<>();
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		
		
	    List<Conteudo> conteudos = new ArrayList<>();
		ConteudoDao cDao = new ConteudoDao(gDao);
		
		try {
			disciplinas = dDao.listar();
			conteudos = cDao.listar();
					
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("disciplinas", disciplinas);
			request.setAttribute("conteudos", conteudos);
			
	
			RequestDispatcher rd = request.getRequestDispatcher("conteudo.jsp");
			rd.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// entrada
		String cmd = request.getParameter("botao");
		String codigo = request.getParameter("codigo");	
		String nome = request.getParameter("nome");
		String descricao = request.getParameter("descricao");
		String disciplina = request.getParameter("disciplina");
		
		// saida
		String saida = "";
		String erro = "";	
		
		Conteudo c = new Conteudo();
		Disciplina d = new Disciplina();

		List<Disciplina> disciplinas = new ArrayList<>();
		List<Conteudo> conteudos = new ArrayList<>();
	    

		try {
			
		if (!cmd.contains("Listar")) {
			d.setCodigo(Integer.parseInt(disciplina));
			d = buscarDisciplina(d);
			c.setDisciplina(d);
			c.setCodigo(Integer.parseInt(codigo));
		}
			
			disciplinas = listarDisciplinas();
			//conteudos = listarConteudos();
				
		    if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {	  			
		    	c.setNome(nome);
		    	c.setDescricao(descricao);			
		    }

		    if (cmd.contains("Cadastrar")) {
		    	saida = cadastrarConteudo(c);
				c = null;
		    }
		    if (cmd.contains("Alterar")) {
		    	saida = alterarConteudo(c);
				c = null;
		    }
		    if (cmd.contains("Excluir")) {    	
		   
		    	saida = excluirConteudo(c);
				c = null;
		    }
		    if (cmd.contains("Buscar")) {
				c = buscarConteudo(c);
				if (c == null) {
					saida = "Nenhum conteudo encontrado com o código especificado.";
					c = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				c = null;
			}

			if (cmd.contains("Listar")) {
				conteudos = listarConteudos();
			}
		    			    
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {
		    request.setAttribute("saida", saida);
		    request.setAttribute("erro", erro);
		    request.setAttribute("conteudo", c);
		    request.setAttribute("disciplinas", disciplinas);
		    request.setAttribute("conteudos", conteudos);		   
		    RequestDispatcher rd = request.getRequestDispatcher("conteudo.jsp");
		    rd.forward(request, response);
		}
	}


	private String cadastrarConteudo(Conteudo c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ConteudoDao cDao = new ConteudoDao(gDao);
		String saida = cDao.iudConteudo("I", c);
		return saida;

	}

	private String alterarConteudo(Conteudo c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ConteudoDao cDao = new ConteudoDao(gDao);
		String saida = cDao.iudConteudo("U", c);
		return saida;

	}

	private String excluirConteudo(Conteudo c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ConteudoDao cDao = new ConteudoDao(gDao);
		String saida = cDao.iudConteudo("D", c);
		return saida;

	}
	private Conteudo buscarConteudo(Conteudo c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ConteudoDao cDao = new ConteudoDao(gDao);
		c = cDao.consultar(c);
		return c;
	}

	private List<Conteudo> listarConteudos() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ConteudoDao cDao = new ConteudoDao(gDao);
		List<Conteudo> conteudos = cDao.listar();
		return conteudos;
	}
	

	private Disciplina buscarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao pDao = new DisciplinaDao(gDao);
		d = pDao.consultar(d);
		return d;

	}

	private List<Disciplina> listarDisciplinas() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();

		return disciplinas;
	}


}
