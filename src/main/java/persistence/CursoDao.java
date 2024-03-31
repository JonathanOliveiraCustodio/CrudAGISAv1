package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Curso;

public class CursoDao implements ICrud<Curso>, ICursoDao {

	private GenericDao gDao;

	public CursoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Curso consultar(Curso c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "SELECT codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno FROM curso WHERE codigo = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, c.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			c.setCargaHoraria(rs.getInt("cargaHoraria"));
			c.setSigla(rs.getString("sigla"));
			c.setUltimaNotaENADE(rs.getFloat("ultimaNotaENADE"));
			c.setTurno(rs.getString("turno"));
			
			rs.close();
	        ps.close();
	        con.close();
	        return c;
	    } else {
	        rs.close();
	        ps.close();
	        con.close();
	        return null;
	    }
	}

	@Override
	public List<Curso> listar() throws SQLException, ClassNotFoundException {
		List<Curso> cursos = new ArrayList<>();
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM v_listarCurso";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Curso c = new Curso();
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			c.setCargaHoraria(rs.getInt("cargaHoraria"));
			c.setSigla(rs.getString("sigla"));
			c.setUltimaNotaENADE(rs.getFloat("ultimaNotaENADE"));
			c.setTurno(rs.getString("turno"));
			cursos.add(c);
		}
		rs.close();
		ps.close();
		con.close();
		return cursos;
	}

	@Override
	public String iudCurso(String acao, Curso c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_iud_curso (?,?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, c.getCodigo());
		cs.setString(3, c.getNome());
		cs.setInt(4, c.getCargaHoraria());
		cs.setString(5, c.getSigla());
	    cs.setFloat(6, c.getUltimaNotaENADE());
	    cs.setString(7, c.getSigla());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		con.close();

		return saida;
	}

}
