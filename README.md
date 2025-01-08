# AGIS - Sistema Acadêmico (Versão 1)

Este projeto é o protótipo de um sistema acadêmico desenvolvido para a gestão de alunos, cursos e matrículas na FATEC-ZL. O sistema foi projetado para permitir o cadastro e matrícula de alunos, a gestão de cursos e disciplinas, e o acompanhamento da situação acadêmica dos estudantes.

## Funcionalidades

### Cadastro de Alunos
- O sistema permite o cadastro de alunos com dados como CPF, nome completo, nome social (opcional), data de nascimento, telefones de contato, e-mails pessoal e corporativo, data de conclusão do segundo grau, instituição de ensino, pontuação no vestibular, posição no vestibular, ano e semestre de ingresso, e semestre e ano limite de graduação.
- O sistema valida automaticamente o CPF do aluno e verifica se o aluno tem idade igual ou superior a 16 anos no momento da matrícula.

### Cadastro de Cursos e Disciplinas
- O sistema gerencia os cursos oferecidos pela faculdade, com informações como código único, nome, carga horária, sigla interna e a última nota no ENADE.
- As disciplinas são registradas, associadas a um curso específico e incluem dados como código numérico, nome e carga horária semanal.

### Matrículas
- O aluno pode se matricular em disciplinas do seu curso, considerando o horário das aulas e evitando conflitos entre as matérias.
- O processo de matrícula é controlado por uma stored procedure, que valida as condições antes de permitir a inserção.
- O sistema gera o RA do aluno automaticamente, com base no ano e semestre de ingresso, seguidos de 4 números aleatórios.
- O aluno pode consultar as disciplinas em que está matriculado, mas não pode remover uma matrícula já realizada. A alteração é permitida apenas para adicionar novas disciplinas.

### Validações Importantes
- **Validação de CPF**: A inserção de um aluno no sistema só é permitida se o CPF for válido.
- **Validação de Idade**: A inserção de um aluno só é permitida se ele tiver 16 anos ou mais.
- **Data Limite de Graduação**: O sistema calcula automaticamente a data limite de graduação, que é 5 anos após o ingresso.
- **Matrícula**: A matrícula é validada através de stored procedures e não é possível excluir uma matrícula existente.

### Tecnologias Utilizadas
- **Frontend**: JSP, JSTL
- **Backend**: Java (Maven)
- **Banco de Dados**: SQL Server
- **Validações**: Stored Procedures no banco de dados

## Funcionalidades Implementadas

1. **Cadastro de Alunos**: Cadastro completo com validação de CPF, idade mínima e cálculo automático do RA.
2. **Cadastro de Cursos e Disciplinas**: Inclusão de cursos e disciplinas na base de dados.
3. **Matrícula de Alunos**: Sistema de matrícula que valida a compatibilidade de horários e impede a exclusão de matrículas já realizadas.
4. **Tela de Consulta de Matrículas**: O aluno pode visualizar as disciplinas em que está matriculado.

## Como Executar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/JonathanOliveiraCustodio/CrudAGISAv1.git
