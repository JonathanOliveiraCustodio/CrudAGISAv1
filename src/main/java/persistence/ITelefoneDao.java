package persistence;

import java.sql.SQLException;

import model.Aluno;
import model.Telefone;

public interface ITelefoneDao {

	String iudTelefone(String acao, Telefone t, Aluno a) throws SQLException, ClassNotFoundException;
	

}
