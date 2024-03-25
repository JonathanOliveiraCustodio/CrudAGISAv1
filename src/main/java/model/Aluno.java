package model;




import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Aluno {

	String CPF;
	String nome;
	String nomeSocial;
	String dataNascimento;
	String telefoneContato;
	String emailPessoal;
	String emailCorporativo;
	String dataConclusao2Grau;
	String instituicaoConclusao2Grau;
	float pontuacaoVestibular;
	int posicaoVestibular;
	int anoIngresso;
	int semestreIngresso;
	String semestreAnoLimiteGraduacao;
	int RA;
	Curso curso;
	

	@Override
	public String toString() {
		return nome;
	}
}