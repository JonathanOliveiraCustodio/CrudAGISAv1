package persistence;

import java.sql.SQLException;

import model.Conteudo;

public interface IConteudoDao {
	
	public String iudConteudo (String acao, Conteudo c) throws SQLException, ClassNotFoundException;

}
