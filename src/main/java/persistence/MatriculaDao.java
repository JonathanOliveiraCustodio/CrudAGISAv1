package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import model.Aluno;
import model.Matricula;

public class MatriculaDao {

	private GenericDao gDao;

	public MatriculaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public Matricula buscarMatriculaAluno(Aluno a, Date dataMatriculaInicio, Date dataMatriculaFim)
			throws NumberFormatException, SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT TOP 1 * FROM matricula WHERE codigoAluno = ? AND dataMatricula <= ? AND dataMatricula >= ? ORDER BY semestre DESC";
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, a.getCPF());
		ps.setDate(2, dataMatriculaFim);
		ps.setDate(3, dataMatriculaInicio);
		ResultSet rs = ps.executeQuery();

		Matricula m = new Matricula();
		if (rs.next()) {
			m.setCodigo(rs.getInt("codigo"));
			m.setCodigoAluno(rs.getString("codigoAluno"));
			m.setDataMatricula(rs.getDate("dataMatricula"));
			m.setSemestre(rs.getInt("semestre"));
		}
		rs.close();
		c.close();

		return m;
	}

	public Matricula buscarMatriculaAtualAluno(Aluno a)
			throws NumberFormatException, SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT TOP 1 * FROM matricula WHERE codigoAluno = ? ORDER BY semestre DESC";
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, a.getCPF());
		ResultSet rs = ps.executeQuery();

		Matricula m = new Matricula();
		if (rs.next()) {
			m.setCodigo(rs.getInt("codigo"));
			m.setCodigoAluno(rs.getString("codigoAluno"));
			m.setDataMatricula(rs.getDate("dataMatricula"));
			m.setSemestre(rs.getInt("semestre"));
		}
		rs.close();
		c.close();

		return m;
	}

	public String novaMatricula(Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_nova_matricula (?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, a.getCPF());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(2);
		cs.close();
		c.close();

		return saida;
	}

}
