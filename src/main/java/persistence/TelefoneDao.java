package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import model.Aluno;
import model.Telefone;

public class TelefoneDao implements ICrud<Telefone>, ITelefoneDao {

	private GenericDao gDao;

	public TelefoneDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override

	public Telefone consultar(Telefone t) throws SQLException, ClassNotFoundException {
	    Connection con = gDao.getConnection();
	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT a.CPF AS cpfAluno, a.nome AS nomeAluno, t.numero, t.tipo ");
	    sql.append("FROM aluno a ");
	    sql.append("JOIN telefone t ON a.CPF = t.aluno ");
	    sql.append("WHERE a.CPF = ? AND t.codigo = ?");

	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ps.setString(1, t.getAluno().getCPF()); 
	    ps.setInt(2, t.getCodigo()); 
	    ResultSet rs = ps.executeQuery();
	    
	    if (rs.next()) {
	        Aluno a = new Aluno();
	        a.setCPF(rs.getString("cpfAluno"));
	        a.setNome(rs.getString("nomeAluno"));
	        
	        Telefone telefone = new Telefone();
	        telefone.setAluno(a);
	        telefone.setNumero(rs.getString("numero"));
	        telefone.setTipo(rs.getString("tipo"));

	        rs.close();
	        ps.close();
	        con.close();
	        return telefone;
	    } else {
	        rs.close();
	        ps.close();
	        con.close();
	        return null;
	    }
	}

	

	
	public List<Telefone> listar(String cpfAluno) throws SQLException, ClassNotFoundException {
	    List<Telefone> telefones = new ArrayList<>();
	    Connection con = gDao.getConnection();
	    StringBuffer sql = new StringBuffer();
	    
	    sql.append("SELECT t.codigo, a.CPF AS cpfAluno, a.nome AS nomeAluno, t.numero, t.tipo ");
	    sql.append("FROM aluno a ");
	    sql.append("JOIN telefone t ON a.CPF = t.aluno ");
	    sql.append("WHERE a.CPF = ?");

	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ps.setString(1, cpfAluno); 
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        Telefone t = new Telefone();
	        t.setCodigo(rs.getInt("codigo"));
	        
	        Aluno a = new Aluno();
	        a.setCPF(rs.getString("cpfAluno"));
	        a.setNome(rs.getString("nomeAluno"));
	        t.setAluno(a);
	        t.setNumero(rs.getString("numero"));
	        t.setTipo(rs.getString("tipo"));	      
	        telefones.add(t);
	    }

	    rs.close();
	    ps.close();
	    con.close();

	    return telefones;
	}

	@Override

	public String iudTelefone(String acao, Telefone t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_telefone (?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, t.getCodigo());
		cs.setString(3, t.getAluno().getCPF());
		cs.setString(4, t.getNumero());
		cs.setString(5, t.getTipo());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(6);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public List<Telefone> listar() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
