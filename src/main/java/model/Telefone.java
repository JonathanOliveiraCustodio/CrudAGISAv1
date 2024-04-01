package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Telefone{
	int codigo; 
	Aluno aluno;
	String numero;
	String tipo;
    
    @Override
	public String toString() {
		return numero;
	}

}
