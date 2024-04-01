package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Curso {
    int codigo;
    String nome;
    int cargaHoraria;			
    String sigla;
    float ultimaNotaENADE;
    String turno;
    
    @Override
	public String toString() {
		return nome + " " + turno;
	}

}
