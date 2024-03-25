USE master
CREATE DATABASE SistemaAGIS
--DROP DATABASE SistemaAGIS 

USE SistemaAGIS 

CREATE TABLE aluno (
    CPF							CHAR(11) UNIQUE,
    nome						VARCHAR(100),
    nomeSocial					VARCHAR(100),
    dataNascimento				DATE,
    telefoneContato				VARCHAR(20),
    emailPessoal				VARCHAR(100),
    emailCorporativo			VARCHAR(100),
    dataConclusao2Grau			DATE,
    instituicaoConclusao2Grau	VARCHAR(100),
    pontuacaoVestibular			DECIMAL(5,2),
    posicaoVestibular			INT,
    anoIngresso					INT,
    semestreIngresso			INT,
    semestreAnoLimiteGraduacao  DATE,
    RA							INT,
	curso						INT
	PRIMARY KEY (CPF)
	FOREIGN KEY (curso) REFERENCES curso(codigo)
)
GO

CREATE TABLE professor (
codigo    INT           NOT NULL,
nome      VARCHAR(100)  NOT NULL,
titulacao  VARCHAR(50)  NOT NULL
PRIMARY KEY (codigo)
)
GO

-- Tabela Curso
CREATE TABLE curso (
codigo					INT CHECK (codigo >= 0 AND codigo <= 100)		NOT NULL,
nome					VARCHAR(100)									NOT NULL,
cargaHoraria			INT												NOT NULL,			
sigla					VARCHAR(10)										NOT NULL,
ultimaNotaENADE			DECIMAL(5,2)									NOT NULL,
turno					VARCHAR(20)										NOT NULL
PRIMARY KEY  (codigo)
)
GO

-- Tabela Disciplina
CREATE TABLE disciplina (
codigo				INT IDENTITY (1001,1)		NOT NULL,
nome				VARCHAR(100)				NOT NULL,
horasSemanais		INT							NOT NULL,
horarioInicio       TIME						NOT NULL,
semestre			INT							NOT NULL,
codigoProfessor		INT							NOT NULL,
codigoCurso		INT							    NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codigoProfessor) REFERENCES professor(codigo),
FOREIGN KEY (codigoCurso) REFERENCES curso(codigo)
)
GO

-- Tabela Telefones
CREATE TABLE telefone (
aluno			CHAR(11),
numero  		CHAR(12)
PRIMARY KEY (numero)
FOREIGN KEY (aluno) REFERENCES aluno(CPF)
)
GO

-- Tabela Matricula
CREATE TABLE matricula (
codigo				INT			NOT NULL,
aluno				CHAR(11)		NOT NULL,
codigoCurso			INT		NOT NULL,
codigoDisciplina	INT     NOT NULL,
dataMatricula		DATE	NOT NULL,
situacaoDisciplina	VARCHAR(20)	NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (aluno) REFERENCES Aluno(CPF),
FOREIGN KEY (codigoCurso,codigoDisciplina) REFERENCES disciplinaCurso(codigoCurso,codigoDisciplina)
)
GO

-- Dados para Teste
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, codigoProfessor, codigoCurso)
VALUES
('Matemática Discreta', 4, '09:00', 1, 1, 1),
('Estrutura de Dados', 5, '13:30', 1, 4, 2),
('Banco de Dados', 4, '10:00', 2, 1, 1);

INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno) 
VALUES 
(1, 'Administração de Empresas', 4000, 'ADM', 7.8, 'Matutino'),
(2, 'Engenharia Civil', 4500, 'ENG CIV', 8.5, 'Vespertino'),
(3, 'Direito', 4000, 'DIR', 8.2, 'Noturno'),
(4, 'Medicina', 6000, 'MED', 9.3, 'Integral'),
(5, 'Ciência da Computação', 3600, 'CC', 8.9, 'Matutino'),
(6, 'Psicologia', 4200, 'PSI', 8.0, 'Vespertino'),
(7, 'Administração Pública', 3800, 'ADM PUB', 7.5, 'Noturno'),
(8, 'Engenharia Elétrica', 4800, 'ENG ELE', 8.7, 'Integral'),
(9, 'Gastronomia', 3200, 'GAS', 7.0, 'Matutino'),
(10, 'Arquitetura e Urbanismo', 4200, 'ARQ', 8.4, 'Vespertino');

INSERT INTO professor VALUES
(1, 'João Silva', 'Doutor'),
(2, 'Maria Santos', 'Mestre'),
(3, 'Carlos Oliveira', 'Doutor'),
(4, 'Ana Costa', 'Mestre'),
(5, 'Pedro Mendes', 'Doutor'),
(6, 'Marta Pereira', 'Mestre'),
(7, 'Ricardo Almeida', 'Doutor'),
(8, 'Sofia Ramos', 'Mestre'),
(9, 'Luís Fernandes', 'Doutor'),
(10, 'Catarina Sousa', 'Mestre')

SELECT * FROM professor

CREATE VIEW v_listarCurso AS
SELECT codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno FROM curso

SELECT * FROM v_listarCurso

CREATE VIEW v_listarAluno AS
SELECT a.CPF, a.nome, a.nomeSocial, a.dataNascimento, a.telefoneContato,
a.emailPessoal, a.emailCorporativo, a.dataConclusao2Grau, a.instituicaoConclusao2Grau, 
a.pontuacaoVestibular, a.posicaoVestibular, a.anoIngresso, a.semestreIngresso, 
a.semestreAnoLimiteGraduacao, a.RA, c.codigo AS codigoCurso, c.nome AS nomeCurso
FROM aluno a JOIN curso c ON a.curso = c.codigo

SELECT * FROM v_listarAluno


CREATE PROCEDURE sp_validatitulacao (@titulacao VARCHAR(50), @valido BIT OUTPUT)
AS
   IF(@titulacao = 'Doutor' OR @titulacao = 'Mestre' OR @titulacao = 'Especialista')
   BEGIN 
       SET @valido =1
   END
   ELSE
   BEGIN 
       SET @valido = 0
   END

CREATE PROCEDURE sp_iud_professor 
    @acao CHAR(1), 
    @codigo INT, 
    @nome VARCHAR(100), 
    @titulacao VARCHAR(50),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @tit_valido BIT

    EXEC sp_validatitulacao @titulacao, @tit_valido OUTPUT

    IF (@acao = 'I')
    BEGIN
        IF @tit_valido = 1
        BEGIN
            INSERT INTO professor VALUES (@codigo, @nome, @titulacao)
            SET @saida = 'Professor inserido com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Titulação inválida', 16, 1)
            RETURN
        END
    END
    ELSE IF (@acao = 'U')
    BEGIN
        IF @tit_valido = 1
        BEGIN
            UPDATE professor SET nome = @nome, titulacao = @titulacao WHERE codigo = @codigo
            SET @saida = 'Professor alterado com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Titulação inválida', 16, 1)
            RETURN
        END
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM professor WHERE codigo = @codigo
        SET @saida = 'Professor excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END


DECLARE @out1 VARCHAR(100)
EXEC sp_iud_professor 'D', 22113, 'Teste Prof 1', 'Doutosr', @out1 OUTPUT
PRINT @out1

SELECT * FROM professor

CREATE PROCEDURE sp_iud_curso 
    @acao CHAR(1), 
    @codigo INT, 
    @nome VARCHAR(100), 
    @cargaHoraria INT,
    @sigla VARCHAR(10),
    @ultimaNotaENADE DECIMAL(5,2),
    @turno VARCHAR(20),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @validoCodigo BIT

    -- Verificar se o código é válido
    IF (@codigo >= 0 AND @codigo <= 100)
    BEGIN
        SET @validoCodigo = 1
    END
    ELSE
    BEGIN
        SET @validoCodigo = 0
    END

    IF (@acao = 'I')
    BEGIN
        -- Inserir curso
        IF @validoCodigo = 1
        BEGIN
            INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno) 
            VALUES (@codigo, @nome, @cargaHoraria, @sigla, @ultimaNotaENADE, @turno)
            SET @saida = 'Curso inserido com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Código de curso inválido', 16, 1)
            RETURN
        END
    END
    ELSE IF (@acao = 'U')
    BEGIN
        -- Atualizar curso
        IF @validoCodigo = 1
        BEGIN
            UPDATE curso SET nome = @nome, cargaHoraria = @cargaHoraria, 
            sigla = @sigla, ultimaNotaENADE = @ultimaNotaENADE, turno = @turno 
            WHERE codigo = @codigo
            SET @saida = 'Curso alterado com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Código de curso inválido', 16, 1)
            RETURN
        END
    END
    ELSE BEGIN
    IF (@acao = 'D')
    BEGIN
        -- Verificar se existem disciplinas associadas a este curso
        IF EXISTS (SELECT 1 FROM disciplina WHERE codigoCurso = @codigo)
        BEGIN
            SET @saida = 'Não é possível excluir o curso pois existem disciplinas associadas a ele.';
            RETURN;
        END;

        DELETE FROM curso WHERE codigo = @codigo;
        SET @saida = 'Curso excluído com sucesso.';
    END
END
END

SELECT * FROM curso

DECLARE @out1 VARCHAR(100);
EXEC sp_iud_curso 'D', 1, 'Curso Teste', 400, 'CT', 8.5, 'Manhã', @out1 OUTPUT;
PRINT @out1;



-- Procedure que Valida CPF
CREATE PROCEDURE sp_validaCPF 
    @CPF CHAR(11),
    @valido BIT OUTPUT
AS
BEGIN
    DECLARE @primeiroDigito INT;
    DECLARE @segundoDigito INT;
    DECLARE @i INT;
    DECLARE @soma INT;
    DECLARE @resto INT;

    SET @valido = 0; -- Inicializa como inválido por padrão

    -- Verificação se o CPF contém apenas dígitos numéricos
    IF @CPF NOT LIKE '%[^0-9]%' AND @CPF NOT IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999')
    BEGIN
        -- Cálculo do primeiro dígito verificador
        SET @soma = 0;
        SET @i = 10;
        WHILE @i >= 2
        BEGIN
            SET @soma = @soma + (CAST(SUBSTRING(@CPF, 11 - @i, 1) AS INT) * @i);
            SET @i = @i - 1;
        END;
        SET @resto = @soma % 11;
        SET @primeiroDigito = IIF(@resto < 2, 0, 11 - @resto);

        -- Cálculo do segundo dígito verificador
        SET @soma = 0;
        SET @i = 11;
        SET @CPF = @CPF + CAST(@primeiroDigito AS NVARCHAR(1));
        WHILE @i >= 2
        BEGIN
            SET @soma = @soma + (CAST(SUBSTRING(@CPF, 12 - @i, 1) AS INT) * @i);
            SET @i = @i - 1;
        END;
        SET @resto = @soma % 11;
        SET @segundoDigito = IIF(@resto < 2, 0, 11 - @resto);

        -- Verificação dos dígitos verificadores
        IF LEN(@CPF) = 11 AND SUBSTRING(@CPF, 10, 1) = CAST(@primeiroDigito AS NVARCHAR(1)) AND SUBSTRING(@CPF, 11, 1) = CAST(@segundoDigito AS NVARCHAR(1))
        BEGIN
            SET @valido = 1; -- CPF válido
        END;
    END;
END;

CREATE PROCEDURE sp_ValidarIdade 
    @dataNascimento DATE,
    @valido BIT OUTPUT
AS
BEGIN
    SET @valido = 0;

    IF DATEDIFF(YEAR, @dataNascimento, GETDATE()) < 16 
    BEGIN
        SET @valido = 0; -- Idade inválida
    END
    ELSE
    BEGIN
        SET @valido = 1; -- Idade válida
    END;
END;


CREATE PROCEDURE sp_CalcularDataLimiteGraduacao 
    @anoIngresso INT,
    @dataLimiteGraduacao DATE OUTPUT
AS
BEGIN
    SET @dataLimiteGraduacao = DATEADD(YEAR, 5, DATEFROMPARTS(@anoIngresso, 1, 1));
END;

CREATE PROCEDURE sp_GerarRA 
    @AnoIngresso INT,
    @SemestreIngresso INT,
    @RA VARCHAR(10) OUTPUT
AS
BEGIN
    SET @RA = CAST(@AnoIngresso AS VARCHAR(4)) + CAST(@SemestreIngresso AS VARCHAR(2)) + RIGHT('0000' + CAST(CAST(RAND() * 10000 AS INT) AS VARCHAR), 4);
END;

-- Teste Validação CPF
DECLARE @CPF CHAR(11) = '38941111111'; -- Substitua pelo CPF desejado
DECLARE @valido BIT;
EXEC sp_validaCPF @CPF, @valido OUTPUT;
IF @valido = 1
    PRINT 'CPF válido'
ELSE
    PRINT 'CPF inválido'

-- Teste Procedure Idade 
DECLARE @dataNascimento DATE = '01-01-2010'; -- Substitua pela data de nascimento desejada
DECLARE @valido BIT;
EXEC sp_ValidarIdade @dataNascimento, @valido OUTPUT;
IF @valido = 1
    PRINT 'Idade válida (igual ou superior a 16 anos)'
ELSE
    PRINT 'Idade inválida (inferior a 16 anos)'

-- Teste Procedure Limite Graduação
DECLARE @anoIngresso INT = 2024; 
DECLARE @dataLimiteGraduacao DATE;
EXEC sp_CalcularDataLimiteGraduacao @anoIngresso, @dataLimiteGraduacao OUTPUT;
PRINT 'Data limite de graduação: ' + CONVERT(VARCHAR, @dataLimiteGraduacao, 103);

-- Teste Procedure Gerar RA
DECLARE @AnoIngresso INT = 2024;
DECLARE @SemestreIngresso INT = 1;
DECLARE @RA VARCHAR(10);

EXEC sp_GerarRA @AnoIngresso, @SemestreIngresso, @RA OUTPUT;

PRINT 'RA gerado: ' + @RA;

-- Procedure para Inserir, Atualizar ou Deletar Aluno
CREATE PROCEDURE sp_iud_aluno 
    @acao CHAR(1), 
    @CPF CHAR(11), 
    @nome VARCHAR(100), 
    @nomeSocial VARCHAR(100),
    @dataNascimento DATE,
    @telefoneContato VARCHAR(20),
    @emailPessoal VARCHAR(100),
    @emailCorporativo VARCHAR(100),
    @dataConclusao2Grau DATE,
    @instituicaoConclusao2Grau VARCHAR(100),
    @pontuacaoVestibular DECIMAL(5,2),
    @posicaoVestibular INT,
    @anoIngresso INT,
    @semestreIngresso INT,
    @semestreAnoLimiteGraduacao DATE OUTPUT,
    @RA VARCHAR(10) OUTPUT,
	@curso INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @validoCPF BIT;
    DECLARE @validoIdade BIT;

    -- Validar CPF
    EXEC sp_validaCPF @CPF, @validoCPF OUTPUT;

    IF @validoCPF = 0
    BEGIN
        SET @saida = 'CPF inválido.';
        RETURN;
    END;

    -- Validar Idade
    EXEC sp_ValidarIdade @dataNascimento, @validoIdade OUTPUT;

    IF @validoIdade = 0
    BEGIN
        SET @saida = 'Idade inválida para ingresso.';
        RETURN;
    END;

    -- Calcular data limite de graduação
    EXEC sp_CalcularDataLimiteGraduacao @anoIngresso, @semestreAnoLimiteGraduacao OUTPUT;

    -- Gerar RA
    EXEC sp_GerarRA @anoIngresso, @semestreIngresso, @RA OUTPUT;

    -- Inserir, atualizar ou deletar aluno
    IF (UPPER(@acao) = 'I')
    BEGIN
        INSERT INTO aluno VALUES (@CPF, @nome, @nomeSocial, @dataNascimento, @telefoneContato,
            @emailPessoal, @emailCorporativo,
            @dataConclusao2Grau, @instituicaoConclusao2Grau,
            @pontuacaoVestibular, @posicaoVestibular,
            @anoIngresso, @semestreIngresso,
            @semestreAnoLimiteGraduacao, @RA, @curso);
        SET @saida = 'Aluno inserido com sucesso.';
    END
    ELSE IF (UPPER(@acao) = 'U')
    BEGIN
        UPDATE aluno SET nome = @nome, nomeSocial = @nomeSocial, dataNascimento = @dataNascimento,
            telefoneContato = @telefoneContato, emailPessoal = @emailPessoal,
            emailCorporativo = @emailCorporativo,
            dataConclusao2Grau = @dataConclusao2Grau, instituicaoConclusao2Grau = @instituicaoConclusao2Grau,
            pontuacaoVestibular = @pontuacaoVestibular, posicaoVestibular = @posicaoVestibular,
            anoIngresso = @anoIngresso, semestreIngresso = @semestreIngresso,
            semestreAnoLimiteGraduacao = @semestreAnoLimiteGraduacao, curso = @curso
        WHERE CPF = @CPF;
        SET @saida = 'Aluno atualizado com sucesso.';
    END
    ELSE IF (UPPER(@acao) = 'D')
    BEGIN
        DELETE FROM aluno WHERE CPF = @CPF;
        SET @saida = 'Aluno deletado com sucesso.';
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
        RETURN;
    END;
END;

DECLARE @saida VARCHAR(100);
DECLARE @semestreAnoLimiteGraduacao DATE;
DECLARE @RA VARCHAR(10);

EXEC sp_iud_aluno 'U', '38942231896', 'Jonathan', 'fulano social', '1990-07-31', '123456789', 'fulano@email.com', NULL, NULL, NULL, 750.20, 1, 2020, 1, @semestreAnoLimiteGraduacao OUTPUT, @RA OUTPUT,1, @saida OUTPUT;

PRINT @saida;

SELECT * FROM aluno
SELECT * FROM disciplina

SELECT d.codigo AS codDisc, d.nome AS nomeDisc, d.horasSemanais, p.codigo AS codProf,p.nome AS nomeProf, p.titulacao AS titProf  
FROM disciplina d INNER JOIN professor p ON d.codigoProfessor = p.codigo 

CREATE PROCEDURE sp_iud_disciplina 
    @acao CHAR(1), 
    @codigo INT, 
    @nome VARCHAR(100), 
    @horasSemanais INT,
    @horarioInicio TIME,
    @semestre INT,
    @codigoProfessor INT,
    @codigoCurso INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, codigoProfessor, codigoCurso) 
        VALUES (@nome, @horasSemanais, @horarioInicio, @semestre, @codigoProfessor, @codigoCurso)
        SET @saida = 'Disciplina inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE disciplina 
        SET nome = @nome, horasSemanais = @horasSemanais, horarioInicio = @horarioInicio, semestre = @semestre, codigoProfessor = @codigoProfessor, codigoCurso = @codigoCurso
        WHERE codigo = @codigo
        SET @saida = 'Disciplina alterada com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM disciplina WHERE codigo = @codigo
        SET @saida = 'Disciplina excluída com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END


DECLARE @out1 VARCHAR(100)
EXEC sp_iud_disciplina 'I', 1013, 'Nome da Disciplina', 4, '13:00', 2, 1, 7, @out1 OUTPUT
PRINT @out1

SELECT * FROM disciplina