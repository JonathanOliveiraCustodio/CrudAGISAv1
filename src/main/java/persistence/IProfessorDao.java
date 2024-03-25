package persistence;

import java.sql.SQLException;

import model.Professor;

public interface IProfessorDao {
	
	public String iudProfessor (String acao, Professor p) throws SQLException, ClassNotFoundException;
	

}
