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

CREATE TABLE comentario (
    conteudo TEXT,
    data_de_criacao TIMESTAMP,
    data_de_edicao TIMESTAMP,
    username VARCHAR(20) NOT NULL,
    CONSTRAINT pk_comentario PRIMARY KEY (username, data_de_criacao),
    CONSTRAINT fk_comentario_aula FOREIGN KEY username REFERENCES user(username)
);

CREATE TABLE material_de_apoio (
    "url" VARCHAR(200),
    titulo VARCHAR(50),
    tamanho INTEGER,
    aula_id INTEGER NOT NULL,
    CONSTRAINT pk_material_de_apoio PRIMARY KEY ("url", aula_id),
    CONSTRAINT fk_material_de_apoio_aula FOREIGN KEY aula_id REFERENCES aula(id),
    CONSTRAINT ck_material_de_apoio_tamanho CHECK (tamanho > 0)
);

CREATE TABLE mensagem (
    username VARCHAR(20) NOT NULL,
    discussao_id INTEGER NOT NULL,
    data_msg TIMESTAMP,
    conteudo TEXT,
    CONSTRAINT pk_mensagem PRIMARY KEY (usuario, discussao_id, data_msg),
    CONSTRAINT fk_mensagem_usario FOREIGN KEY usuario REFERENCES usuario(username),
    CONSTRAINT fk_mensagem_discussao FOREIGN KEY discussao REFERENCES discussao(id)
);

