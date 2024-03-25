package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Disciplina {
	
	int codigo;
	String nome;
	int horasSemanais;
	Professor professor;
	Curso curso;
	

	@Override
	public String toString() {
		return codigo + " - " + nome + " - " + professor;
	} 

}
