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
import model.Curso;
import persistence.AlunoDao;
import persistence.CursoDao;
import persistence.GenericDao;


@WebServlet("/aluno")
public class AlunoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AlunoServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {String erro = "";
			
		    List<Aluno> alunos = new ArrayList<>();
			GenericDao gDao = new GenericDao();
		//	AlunoDao aDao = new AlunoDao(gDao);

			List<Curso> cursos = new ArrayList<>();
			CursoDao cDao = new CursoDao(gDao);

			try {
			//	alunos = aDao.listar();
				cursos = cDao.listar();

			} catch (ClassNotFoundException | SQLException e) {
				erro = e.getMessage();

			} finally {
				request.setAttribute("erro", erro);
				request.setAttribute("alunos", alunos);
				request.setAttribute("cursos", cursos);

				RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
				rd.forward(request, response);
			}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// entrada
		String cmd = request.getParameter("botao");
		String CPF = request.getParameter("CPF");
		String nome = request.getParameter("nome");
		String nomeSocial = request.getParameter("nomeSocial");
		String dataNascimento = request.getParameter("dataNascimento");
		String telefoneContato = request.getParameter("telefoneContato");
		String emailPessoal = request.getParameter("emailPessoal");
		String emailCorporativo = request.getParameter("emailCorporativo");
		String dataConclusao2Grau = request.getParameter("dataConclusao2Grau");
		String instituicaoConclusao2Grau = request.getParameter("instituicaoConclusao2Grau");
		String pontuacaoVestibular = request.getParameter("pontuacaoVestibular");
		String posicaoVestibular = request.getParameter("posicaoVestibular");
		String anoIngresso = request.getParameter("anoIngresso");
		String semestreIngresso = request.getParameter("semestreIngresso");
		String semestreAnoLimiteGraduacao = request.getParameter("semestreAnoLimiteGraduacao");
		String RA = request.getParameter("RA");
		String curso = request.getParameter("curso");

		// saida
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();
		
		

		if (!cmd.contains("Listar")) {
			a.setCPF((CPF));
		}
		try {
			alunos = listarAlunos();
			cursos = listarCursos();
		    
		    if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
		    	
		    	a.setNome(nome);
				a.setNomeSocial(nomeSocial);
			//	a.setDataNascimento(Date.valueOf(dataNascimento));
				a.setDataNascimento(dataNascimento);
				a.setTelefoneContato(telefoneContato);
				a.setEmailPessoal(emailPessoal);
				a.setEmailCorporativo(emailCorporativo);
			//	a.setDataConclusao2Grau(Date.valueOf(dataConclusao2Grau));
				a.setDataConclusao2Grau(dataConclusao2Grau);
				a.setInstituicaoConclusao2Grau(instituicaoConclusao2Grau);
				a.setPontuacaoVestibular(Float.parseFloat(pontuacaoVestibular));
				a.setPosicaoVestibular(Integer.parseInt(posicaoVestibular));
				a.setAnoIngresso(Integer.parseInt(anoIngresso));
				a.setSemestreIngresso(Integer.parseInt(semestreIngresso));
			//	a.setSemestreAnoLimiteGraduacao(Date.valueOf(semestreAnoLimiteGraduacao));	
				a.setSemestreAnoLimiteGraduacao(semestreAnoLimiteGraduacao);
				a.setRA(Integer.parseInt(RA)); 
		  
		    
				
				Curso c = new Curso();
				c.setCodigo(Integer.parseInt(curso));
				c = buscarCurso(c);
				
				a.setCurso(c);
		    }

		    if (cmd.contains("Cadastrar")) {
		    	saida = cadastrarAluno(a);
				a = null;
		    }
		    if (cmd.contains("Alterar")) {
		    	saida = alterarAluno(a);
				a = null;
		    }
		    if (cmd.contains("Excluir")) {
		    	saida = excluirAluno(a);
				a = null;
		    }
		    if (cmd.contains("Buscar")) {
		        a = buscarAluno(a);
		    }
		    
		    if (cmd.contains("Listar")) {
		        alunos = listarAlunos();
		        request.setAttribute("tipoTabela", "Listar"); 
		    }
		    
	
		    
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {
		    request.setAttribute("saida", saida);
		    request.setAttribute("erro", erro);
		    request.setAttribute("aluno", a);
		    request.setAttribute("alunos", alunos);
		    request.setAttribute("cursos", cursos);
		    RequestDispatcher rd = request.getRequestDispatcher("aluno.jsp");
		    rd.forward(request, response);
		}
	
	}

	private String cadastrarAluno(Aluno p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("I", p);
		return saida;

	}

	private String alterarAluno(Aluno p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("U", p);
		return saida;

	}

	private String excluirAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("D", a);
		return saida;

	}

	private Aluno buscarAluno(Aluno p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		p = pDao.consultar(p);
		return p;

	}

	private List<Aluno> listarAlunos() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		List<Aluno> alunos = pDao.listar();

		return alunos;
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