USE master
CREATE DATABASE SistemaAGIS
GO
USE SistemaAGIS 
GO
CREATE TABLE curso (
codigo					INT CHECK (codigo >= 0 AND codigo <= 100)		NOT NULL,
nome					VARCHAR(100)									NOT NULL,
cargaHoraria			INT												NOT NULL,			
sigla					VARCHAR(10)										NOT NULL,
ultimaNotaENADE			DECIMAL(5,2)									NOT NULL,
turno					VARCHAR(20)										NOT NULL,
periodo_matricula_inicio	DATE										NULL,
periodo_matricula_fim	DATE											NULL,
PRIMARY KEY  (codigo)
)
GO
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
CREATE TABLE disciplina (
codigo				INT IDENTITY (1001,1)		NOT NULL,
nome				VARCHAR(100)				NOT NULL,
horasSemanais		INT							NOT NULL,
horarioInicio       VARCHAR(10)       		    NOT NULL,
semestre			INT							NOT NULL,
diaSemana			VARCHAR(20)					NOT NULL,
codigoProfessor		INT							NOT NULL,
codigoCurso		INT							    NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codigoProfessor) REFERENCES professor(codigo),
FOREIGN KEY (codigoCurso) REFERENCES curso(codigo)
)
GO
CREATE TABLE telefone (
aluno			CHAR(11),
numero  		CHAR(12),
tipo			VARCHAR(100)
PRIMARY KEY (aluno, numero)
FOREIGN KEY (aluno) REFERENCES aluno(CPF)
)
GO
CREATE TABLE matricula (
codigo				INT			NOT NULL,
codigoAluno				CHAR(11)		NOT NULL,
dataMatricula		DATE	NOT NULL,
semestre        	INT	NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codigoAluno) REFERENCES aluno(CPF),
)
GO
CREATE TABLE matriculaDisciplina (
CodigoMatricula				    INT 			 NOT NULL,
codigoDisciplina				INT				 NOT NULL,
situacao						VARCHAR(20)		 NOT NULL,
notaFinal						DECIMAL	(4,2)	 NOT NULL
PRIMARY KEY (CodigoMatricula,codigoDisciplina)
FOREIGN KEY (CodigoMatricula) REFERENCES matricula(codigo),
FOREIGN KEY (codigoDisciplina) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE conteudo(
codigo				INT			   NOT NULL,
nome				VARCHAR(100)   NOT NULL,
descricao			VARCHAR(100)   NOT NULL,
codigoDisciplina	INT			   NOT NULL
PRIMARY KEY   (codigo)
FOREIGN KEY (codigoDisciplina) REFERENCES disciplina (codigo)
)
GO
INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno, periodo_matricula_inicio, periodo_matricula_fim) 
VALUES 
(1, 'Administração de Empresas', 4000, 'ADM', 7.8, 'Matutino', '2024-01-01', '2024-01-01'),
(2, 'Engenharia Civil', 4500, 'ENG CIV', 8.5, 'Vespertino', '2024-01-01', '2024-01-01'),
(3, 'Direito', 4000, 'DIR', 8.2, 'Noturno', '2024-01-01', '2024-01-01'),
(4, 'Medicina', 6000, 'MED', 9.3, 'Integral', '2024-01-01', '2024-01-01'),
(5, 'Ciência da Computação', 3600, 'CC', 8.9, 'Matutino', '2024-01-01', '2024-01-01'),
(6, 'Psicologia', 4200, 'PSI', 8.0, 'Vespertino', '2024-01-01', '2024-01-01'),
(7, 'Administração Pública', 3800, 'ADM PUB', 7.5, 'Noturno', '2024-01-01', '2024-01-01'),
(8, 'Engenharia Elétrica', 4800, 'ENG ELE', 8.7, 'Integral', '2024-01-01', '2024-01-01'),
(9, 'Gastronomia', 3200, 'GAS', 7.0, 'Matutino', '2024-01-01', '2024-01-01'),
(10, 'Arquitetura e Urbanismo', 4200, 'ARQ', 8.4, 'Vespertino', '2024-01-01', '2024-01-01');
GO
INSERT INTO aluno (CPF, nome, nomeSocial, dataNascimento, telefoneContato, emailPessoal, emailCorporativo, dataConclusao2Grau, instituicaoConclusao2Grau, pontuacaoVestibular, posicaoVestibular, anoIngresso, semestreIngresso, semestreAnoLimiteGraduacao, RA, curso)
VALUES
    ('55312103020', 'João Silva', NULL, '1998-05-15', '123456789', 'joao@email.com', 'joao@empresa.com', '2016-12-20', 'Escola Estadual ABC', 8.75, 25, 2016, 1, '2020-12-31', 123456, 1),
    ('86462326034', 'Maria Santos', NULL, '1999-09-22', '987654321', 'maria@email.com', 'maria@empresa.com', '2017-05-10', 'Escola Municipal XYZ', 8.50, 30, 2017, 1, '2021-12-31', 234567, 2),
    ('39112829072', 'José Oliveira', NULL, '1997-02-10', '987123456', 'jose@email.com', 'jose@empresa.com', '2016-08-30', 'Colégio Particular QRS', 9.00, 15, 2016, 2, '2020-12-31', 345678, 1),
    ('39590327060', 'Ana Souza', NULL, '2000-11-05', '654987321', 'ana@email.com', 'ana@empresa.com', '2017-11-28', 'Escola Estadual XYZ', 8.25, 40, 2017, 1, '2021-12-31', 456789, 2),
    ('09129892031', 'Pedro Lima', NULL, '1996-07-30', '987123654', 'pedro@email.com', 'pedro@empresa.com', '2016-04-12', 'Colégio Municipal DEF', 8.90, 20, 2016, 2, '2020-12-31', 567890, 1),
    ('89125916068', 'Juliana Castro', NULL, '1999-03-18', '654321987', 'juliana@email.com', 'juliana@empresa.com', '2017-09-03', 'Colégio Estadual LMN', 8.80, 10, 2017, 1, '2021-12-31', 678901, 2),
    ('97006247063', 'Lucas Almeida', NULL, '1998-12-25', '321987654', 'lucas@email.com', 'lucas@empresa.com', '2016-10-05', 'Escola Particular GHI', 8.70, 35, 2016, 2, '2020-12-31', 789012, 1),
    ('12697967044', 'Carla Pereira', NULL, '2001-04-08', '987321654', 'carla@email.com', 'carla@empresa.com', '2017-12-15', 'Colégio Municipal OPQ', 8.45, 50, 2017, 1, '2021-12-31', 890123, 2),
    ('29180596096', 'Marcos Fernandes', NULL, '1997-10-20', '654321789', 'marcos@email.com', 'marcos@empresa.com', '2016-06-18', 'Escola Estadual RST', 8.95, 5, 2016, 1, '2020-12-31', 901234, 1),
    ('30260403040', 'Aline Rocha', NULL, '2000-01-12', '321654987', 'aline@email.com', 'aline@empresa.com', '2017-08-20', 'Colégio Particular UVW', 8.60, 45, 2017, 2, '2021-12-31', 123450, 2);
GO
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
GO
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES
('Matemática Avançada', 4, '08:00', 2, 'Segunda-feira', 1, 1),
('Matemática', 4, '08:00', 1, 'Segunda-feira', 1, 10),
('Física', 3, '10:00', 1, 'Terça-feira', 1, 8),
('Química', 3, '13:00', 2, 'Quarta-feira', 3, 6),
('Biologia', 2, '09:00', 2, 'Quinta-feira', 4, 1),
('História', 2, '11:00', 1, 'Sexta-feira', 5, 1);
GO
INSERT INTO matricula (codigo, codigoAluno, dataMatricula, semestre)
VALUES
(1, '55312103020', '2022-01-10', 1),
(2, '55312103020', '2022-07-28', 2),
(3, '86462326034', '2024-01-28', 1),
(4, '86462326034', '2024-07-28', 2),
(5, '39112829072', '2025-03-28', 1),
(6, '39112829072', '2024-03-28', 2),
(7, '39590327060', '2024-03-28', 1),
(8, '39590327060', '2021-01-1', 2),
(9, '39590327060', '2021-07-28', 3);
GO
INSERT INTO matriculaDisciplina (CodigoMatricula, codigoDisciplina, situacao, notaFinal)
VALUES
(1,1001,'Aprovado', 8.5),
(1,1002,'Reprovado', 5.0),
(1,1003,'Aprovado', 7.2),
(2,1001,'Reprovado', 4.8),
(2,1002,'Aprovado', 9.0),
(2,1003,'Reprovado', 6.5),
(3,1001,'Aprovado', 8.0),
(4,1002, 'Reprovado', 4.0),
(4,1003, 'Aprovado', 7.8),
(5,1001, 'Reprovado', 3.5);
GO
INSERT INTO conteudo VALUES 
    (1, 'Álgebra', 'Estudo dos números e operações', 1003),
    (2, 'Geometria', 'Estudo das formas e dos espaços', 1003),
    (3, 'Cálculo Diferencial', 'Estudo das taxas de variação', 1003),
    (4, 'Células', 'Unidades básicas da vida', 1005),
    (5, 'Energia', 'Capacidade de realizar trabalho', 1005),
    (6, 'Evolução', 'Desenvolvimento das espécies ao longo do tempo', 1005),
    (7, 'Idade Média', 'Período histórico entre os séculos V e XV', 1001),
    (8, 'Revolução Industrial', 'Transformações econômicas e sociais no século XVIII', 1001),
    (9, 'Descobrimento do Brasil', 'Chegada dos portugueses em 1500', 1002),
    (10, 'Relevo Brasileiro', 'Características geográficas do país', 1002),
    (11, 'Literatura Brasileira', 'Produções literárias do Brasil', 1004),
    (12, 'Gramática', 'Estudo da estrutura e funcionamento da língua', 1004),
    (13, 'Equações', 'Expressões matemáticas com incógnitas', 1003),
    (14, 'Fisiologia', 'Estudo das funções dos organismos vivos', 1005),
    (15, 'Guerra Fria', 'Conflito político entre EUA e URSS', 1005),
    (16, 'Globalização', 'Integração econômica e cultural mundial', 1004),
    (17, 'Morfologia', 'Estudo da estrutura das palavras', 1004),
    (18, 'Polinômios', 'Expressões algébricas com várias variáveis',1004),
    (19, 'Genética', 'Estudo dos genes e hereditariedade', 1003),
    (20, 'Renascimento', 'Movimento cultural e artístico do século XVI', 1004);
GO
CREATE VIEW v_listarCurso AS
SELECT codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno FROM curso
GO
CREATE VIEW v_periodoMatricula AS
SELECT TOP 1 periodo_matricula_inicio, periodo_matricula_fim FROM curso ORDER BY codigo ASC
GO
CREATE VIEW v_listarAluno AS
SELECT a.CPF, a.nome, a.nomeSocial, a.dataNascimento, a.telefoneContato,
a.emailPessoal, a.emailCorporativo, a.dataConclusao2Grau, a.instituicaoConclusao2Grau, 
a.pontuacaoVestibular, a.posicaoVestibular, a.anoIngresso, a.semestreIngresso, 
a.semestreAnoLimiteGraduacao, a.RA, c.codigo AS codigoCurso, c.nome AS nomeCurso
FROM aluno a JOIN curso c ON a.curso = c.codigo
GO
CREATE PROCEDURE sp_validatitulacao 
	@titulacao VARCHAR(50),
	@valido BIT OUTPUT
AS
BEGIN
   IF(@titulacao = 'Doutor' OR @titulacao = 'Mestre' OR @titulacao = 'Especialista')
   BEGIN 
       SET @valido =1
   END
   ELSE
   BEGIN 
       SET @valido = 0
   END
END
GO
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
    
    IF @tit_valido = 0
    BEGIN
        SET @saida = 'Titulação inválida'
        RETURN
    END

    IF (@acao = 'I')
    BEGIN
        IF EXISTS (SELECT 1 FROM professor WHERE codigo = @codigo)
        BEGIN
            SET @saida = 'Código de professor já existe.'
            RETURN
        END
        
        INSERT INTO professor VALUES (@codigo, @nome, @titulacao)
        SET @saida = 'Professor inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE professor SET nome = @nome, titulacao = @titulacao WHERE codigo = @codigo
        SET @saida = 'Professor alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DECLARE @count INT
        -- Verificar se há disciplinas associadas a esse professor
        SELECT @count = COUNT(*) FROM disciplina WHERE codigoProfessor = @codigo
        
        -- Se houver disciplinas associadas, emitir uma mensagem e não excluir o professor
        IF @count > 0
        BEGIN
            SET @saida = 'Este professor está associado a disciplinas e não pode ser excluído.'
            RETURN
        END
        
        DELETE FROM professor WHERE codigo = @codigo
        SET @saida = 'Professor excluído com sucesso'
    END
END
GO
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
GO
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
GO
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
GO
CREATE PROCEDURE sp_CalcularDataLimiteGraduacao 
    @anoIngresso INT,
    @dataLimiteGraduacao DATE OUTPUT
AS
BEGIN
    SET @dataLimiteGraduacao = DATEADD(YEAR, 5, DATEFROMPARTS(@anoIngresso, 1, 1));
END;
GO
CREATE PROCEDURE sp_GerarRA 
    @AnoIngresso INT,
    @SemestreIngresso INT,
    @RA VARCHAR(10) OUTPUT
AS
BEGIN
    SET @RA = CAST(@AnoIngresso AS VARCHAR(4)) + CAST(@SemestreIngresso AS VARCHAR(2)) + RIGHT('0000' + CAST(CAST(RAND() * 10000 AS INT) AS VARCHAR), 4);
END;
GO
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

    -- Verificar se o aluno existe
    IF (UPPER(@acao) <> 'I') AND (NOT EXISTS (SELECT 1 FROM aluno WHERE CPF = @CPF))
    BEGIN
        SET @saida = 'Aluno não encontrado.';
        RETURN;
    END;

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
GO
CREATE PROCEDURE sp_iud_disciplina
    @acao CHAR(1),
    @codigo INT,
    @nome VARCHAR(100),
    @horasSemanais INT,
    @horarioInicio TIME,
    @semestre INT,
    @diaSemana VARCHAR(20),
    @codigoProfessor INT,
    @codigoCurso INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
        VALUES (@nome, @horasSemanais, @horarioInicio, @semestre, @diaSemana, @codigoProfessor, @codigoCurso)
        SET @saida = 'Disciplina inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE disciplina
        SET nome = @nome, horasSemanais = @horasSemanais, horarioInicio = @horarioInicio, semestre = @semestre,
            diaSemana = @diaSemana, codigoProfessor = @codigoProfessor, codigoCurso = @codigoCurso
        WHERE codigo = @codigo
        SET @saida = 'Disciplina alterada com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        -- Excluir os conteúdos relacionados à disciplina
        DELETE FROM conteudo WHERE codigoDisciplina = @codigo
        
        -- Em seguida, excluir a disciplina
        DELETE FROM disciplina WHERE codigo = @codigo
        
        SET @saida = 'Disciplina excluída com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_conteudo 
 @acao CHAR(1), 
 @codigo INT, 
 @nome VARCHAR(100), 
 @descricao VARCHAR(100),
 @codigoDisciplina INT,
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO conteudo (codigo, nome, descricao, codigoDisciplina) 
        VALUES (@codigo, @nome, @descricao, @codigoDisciplina)
        SET @saida = 'Conteúdo inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE conteudo 
        SET nome = @nome, descricao = @descricao, codigoDisciplina = @codigoDisciplina
        WHERE codigo = @codigo
        SET @saida = 'Conteúdo alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM conteudo WHERE codigo = @codigo
        SET @saida = 'Conteúdo excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_u_periodomatricula 
 @periodo_inicio DATE, 
 @periodo_fim DATE,
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@periodo_inicio IS NOT NULL AND @periodo_fim IS NOT NULL)
    BEGIN
        UPDATE curso SET periodo_matricula_inicio = @periodo_inicio, periodo_matricula_fim = @periodo_fim
        SET @saida = 'Período de matrícula alterado com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Datas inválidas', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_nova_matricula
	@codigo_aluno	CHAR(11),
	@saida VARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE @semestre INT
	SELECT @semestre = MAX(semestre) FROM matricula WHERE codigoAluno = @codigo_aluno
	IF @semestre IS NULL
	BEGIN
		SET @semestre = 1
	END
	ELSE
	BEGIN
		SET @semestre = @semestre + 1
	END
	DECLARE @codigo INT
	SELECT @codigo = MAX(codigo) FROM matricula
	SET @codigo = @codigo + 1

	INSERT INTO matricula VALUES (@codigo, @codigo_aluno, GETDATE(), @semestre)
END
GO
CREATE PROCEDURE sp_matricular_disciplina
	@codigo_disciplina	INT,
	@codigo_matricula	INT,
	@saida VARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE @horario_inicio INT, @horas_semanais INT, @dia_semana VARCHAR(100)
	SELECT @horario_inicio = (CAST(SUBSTRING(horarioInicio, 1, CHARINDEX(':', horarioInicio) - 1) AS INT) + 1) FROM disciplina WHERE codigo = @codigo_disciplina
	SELECT @horas_semanais = horasSemanais FROM disciplina WHERE codigo = @codigo_disciplina
	SELECT @dia_semana = diaSemana FROM disciplina WHERE codigo = @codigo_disciplina

	DECLARE @conflito INT
	SELECT @conflito = COUNT(d.codigo) FROM matriculaDisciplina m JOIN disciplina d ON m.codigoDisciplina = d.codigo WHERE m.CodigoMatricula = @codigo_matricula AND d.diaSemana = @dia_semana AND
	((CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) >= @horario_inicio AND (@horario_inicio + @horas_semanais) >= CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT)) OR
	((CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais) >= @horario_inicio AND (@horario_inicio + @horas_semanais) >= (CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais)) OR
	(CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) <= @horario_inicio AND (@horario_inicio + @horas_semanais) <= (CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais)))
	
	IF @conflito > 0
	BEGIN
		RAISERROR('Um ou mais horários de disciplinas apresentam conflitos', 16, 1)
        RETURN
	END
	ELSE
	BEGIN
		INSERT INTO matriculaDisciplina VALUES (@codigo_matricula, @codigo_disciplina, 'Cursando', 0.0)
	END
END
GO
CREATE PROCEDURE sp_iud_telefone
 @acao CHAR(1), 
 @numero VARCHAR(100), 
 @aluno VARCHAR(100), 
 @tipo VARCHAR(100),
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO telefone VALUES (@aluno, @numero, @tipo) 
        SET @saida = 'Telefone inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE telefone 
        SET tipo = @tipo
        WHERE aluno = @aluno AND numero = @numero
        SET @saida = 'Telefone alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM telefone WHERE aluno = @aluno AND numero = @numero
        SET @saida = 'Telefone excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END