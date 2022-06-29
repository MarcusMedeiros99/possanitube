CREATE TABLE usuario (
    username VARCHAR (20) NOT NULL,
    email VARCHAR (20),
    nome VARCHAR (30),
    tipo BIT(4),
    CONSTRAINT pk_usuario PRIMARY KEY (username),
    CONSTRAINT ck_tipo CHECK (tipo <> B'0000')
);

CREATE TABLE aula (
    id_aula SERIAL NOT NULL,
    professor VARCHAR (30),
    titulo VARCHAR (30),
    data_de_criacao TIMESTAMP,
    duracao INTEGER,
    descricao VARCHAR (100),
    n_views INTEGER,
    likes INTEGER,
    dislikes INTEGER,
    disciplina VARCHAR (10) NOT NULL,
    CONSTRAINT pk_aula PRIMARY KEY (id_aula),
    CONSTRAINT unq_aula UNIQUE (professor, titulo, data_de_criacao),
    CONSTRAINT fk_aula_disciplina FOREIGN KEY (disciplina)
        REFERENCES disciplina(codigo)
        ON DELETE CASCADE
);

CREATE TABLE aula_assistida(
    aluno VARCHAR (20) NOT NULL,
    aula INTEGER NOT NULL,
    quantidade INTEGER,
    avaliacao INTEGER,
    CONSTRAINT pk_aula_assistida PRIMARY KEY (aluno, aula),
    CONSTRAINT fk_aa_aluno FOREIGN KEY (aluno)
        REFERENCES aluno
        ON DELETE CASCADE,
    CONSTRAINT fk_aa_aula FOREIGN KEY (aula)
        REFERENCES aula
        ON DELETE CASCADE,
    CONSTRAINT ck_avaliacao CHECK (avaliacao BETWEEN -1 AND 1)
);

