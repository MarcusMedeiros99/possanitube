CREATE TABLE usuario (
    username VARCHAR (20) NOT NULL,
    email VARCHAR (20),
    nome VARCHAR (30),
    tipo BIT(4) NOT NULL,

    CONSTRAINT pk_usuario PRIMARY KEY (username),
    CONSTRAINT ck_tipo CHECK (tipo <> B'0000')
);

CREATE TABLE disciplina (
    codigo VARCHAR(10) NOT NULL,
    nome VARCHAR(50),
    ementa TEXT,

    CONSTRAINT pk_disciplina PRIMARY KEY (codigo)
);

CREATE TABLE aula (
    id SERIAL NOT NULL,
    professor VARCHAR (20) NOT NULL,
    titulo VARCHAR (30) NOT NULL,
    data_de_criacao TIMESTAMP NOT NULL,
    duracao INTEGER,
    descricao VARCHAR (100),
    n_views INTEGER,
    likes INTEGER,
    dislikes INTEGER,
    disciplina VARCHAR (10) NOT NULL,

    CONSTRAINT pk_aula PRIMARY KEY (id),
    CONSTRAINT unq_aula UNIQUE (professor, titulo, data_de_criacao),
    CONSTRAINT fk_aula_professor FOREIGN KEY (professor)
        REFERENCES usuario(username)
        ON DELETE CASCADE,
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
        REFERENCES usuario(username)
        ON DELETE CASCADE,
    CONSTRAINT fk_aa_aula FOREIGN KEY (aula)
        REFERENCES aula(id)
        ON DELETE CASCADE,
    CONSTRAINT ck_avaliacao CHECK (avaliacao BETWEEN -1 AND 1),
    CONSTRAINT ck_quatidade CHECK (quantidade > 0)
);

CREATE TABLE comentario (
    usuario VARCHAR(20) NOT NULL,
    data_de_criacao TIMESTAMP NOT NULL,
    data_de_edicao TIMESTAMP,
    aula INTEGER NOT NULL,
    conteudo TEXT,

    CONSTRAINT pk_comentario PRIMARY KEY (usuario, data_de_criacao),
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (usuario)
        REFERENCES usuario(username)
        ON DELETE CASCADE,
    CONSTRAINT fk_comentario_aula FOREIGN KEY (aula)
        REFERENCES aula(id)
        ON DELETE CASCADE
);

CREATE TABLE material_de_apoio (
    "url" VARCHAR(200) NOT NULL,
    titulo VARCHAR(50),
    tamanho INTEGER,
    aula_id INTEGER NOT NULL,

    CONSTRAINT pk_material_de_apoio PRIMARY KEY ("url", aula_id),
    CONSTRAINT fk_material_de_apoio_aula FOREIGN KEY (aula_id)
        REFERENCES aula(id)
        ON DELETE CASCADE,
    CONSTRAINT ck_material_de_apoio_tamanho CHECK (tamanho > 0)
);

CREATE TABLE discussao (
    id SERIAL NOT NULL,
    aula INTEGER NOT NULL,
    usuario VARCHAR(20) NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    titulo VARCHAR(50),
    descricao TEXT,

    CONSTRAINT pk_discussao PRIMARY KEY (id),
    CONSTRAINT unq_discussao UNIQUE(aula, usuario, data_criacao),
    CONSTRAINT fk_aula FOREIGN KEY (aula)
        REFERENCES aula(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_usuario FOREIGN KEY (usuario)
        REFERENCES usuario(username)
        ON DELETE CASCADE
);

CREATE TABLE mensagem (
    usuario VARCHAR(20) NOT NULL,
    discussao INTEGER NOT NULL,
    data_msg TIMESTAMP NOT NULL,
    conteudo TEXT,

    CONSTRAINT pk_mensagem PRIMARY KEY (usuario, discussao, data_msg),
    CONSTRAINT fk_mensagem_usario FOREIGN KEY (usuario)
        REFERENCES usuario(username)
        ON DELETE CASCADE,
    CONSTRAINT fk_mensagem_discussao FOREIGN KEY (discussao)
        REFERENCES discussao(id)
        ON DELETE CASCADE
);

CREATE TABLE playlist (
    id SERIAL NOT NULL,
    usuario VARCHAR(20) NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    duracao INTERVAL,

    CONSTRAINT pk_playlist PRIMARY KEY (id),
    CONSTRAINT unq_playlist UNIQUE(usuario, titulo, data_criacao),
    CONSTRAINT fk_usuario FOREIGN KEY (usuario)
        REFERENCES usuario(username)
        ON DELETE CASCADE
);

CREATE TABLE aula_playlist (
    aula INTEGER NOT NULL,
    playlist INTEGER NOT NULL,

    CONSTRAINT pk_aula_playlist PRIMARY KEY (aula, playlist),
    CONSTRAINT fk_aula FOREIGN KEY (aula)
        REFERENCES aula(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_playlist FOREIGN KEY (playlist)
        REFERENCES playlist(id)
        ON DELETE CASCADE
);

