-- Criação de usuários:

INSERT INTO usuario
VALUES ('possani', 'possani@usp.br', 'Cláudio Possani', B'0100');

INSERT INTO usuario
VALUES ('grings123', 'grings@matematica.br', 'Fernando Grings', B'0100');

INSERT INTO usuario
VALUES ('joao22', 'joaozinho@ufscar.br', 'João da Silva', B'1000');

INSERT INTO usuario
VALUES ('maria33', 'maria@ufu.br', 'Maria Pereira', B'1000');


-- Criação de disciplinas:

INSERT INTO disciplina
VALUES ('CALC1', 'Cálculo 1', 'Limites, derivadas e integrais simples');

INSERT INTO disciplina
VALUES ('CALC2', 'Cálculo 2', 'Funções de 2 variáveis, funções vetoriais, derivadas parciais');

INSERT INTO disciplina
VALUES ('CALC3', 'Cálculo 3', 'Integrais duplas, integrais de superfície, integrais de linha');

INSERT INTO disciplina
VALUES ('GA', 'Geometria Analítica', 'Vetores, retas, planos, cônicas e quádricas');


-- Criação de aulas: 

INSERT INTO aula (professor, titulo, data_de_criacao, duracao, descricao, disciplina)
VALUES ('possani', 'Limites Laterais', '2011-10-10', 65, 'Definição de limites laterais', 'CALC1');

INSERT INTO aula (professor, titulo, data_de_criacao, duracao, descricao, disciplina)
VALUES ('possani', 'Teorema de Stokes', '2012-02-11', 47, 'Revisão do teorema de Stokes', 'CALC3');

INSERT INTO aula (professor, titulo, data_de_criacao, duracao, descricao, disciplina)
VALUES ('grings123', 'Equação da Reta', '2011-10-10', 65, 'Apresentação da equação da reta', 'GA');


-- Criação de aulas assistidas:

INSERT INTO aula_assistida
VALUES ('joao22', 1, 4, 1);

INSERT INTO aula_assistida
VALUES ('joao22', 2, 1, -1);

INSERT INTO aula_assistida
VALUES ('maria33', 3, 2, 0);


-- Criação de comentários:

INSERT INTO comentario
VALUES ('joao22', '2022-01-02', NULL, 2, 'Muito difícil o conteúdo');

INSERT INTO comentario
VALUES ('maria33', '2022-04-06', NULL, 3, 'Didática incrível!');


-- Criação de materiais de apoio:

INSERT INTO material_de_apoio
VALUES ('https://www.wikifox.org/pt/wiki/Teorema_de_Stokes', 'Descrição textual do Teorema de Stokes', 20, 2);

INSERT INTO material_de_apoio
VALUES ('https://www.preparaenem.com/matematica/plano-cartesiano.htm', 'Foto do plano Cartesiano', 5, 3);


-- Criação de discussões:

INSERT INTO discussao (aula, usuario, data_criacao, titulo, descricao)
VALUES (2, 'joao22', '2022-01-02', 'Utilidades do Teorema de Stokes', 'Exemplos de aplicações em que usarei Stokes quando me formar');

INSERT INTO discussao (aula, usuario, data_criacao, titulo, descricao)
VALUES (3, 'maria33', '2022-04-06', 'Exercício proposto 3', 'Resolução do exercício proposto em aula');

INSERT INTO discussao (aula, usuario, data_criacao, titulo, descricao)
VALUES (1, 'joao22', '2022-05-01', 'Ajuda com o exercício 2', 'Alguem pode me ajudar a resolver esse exercicio?');


-- Criação de mensagens para discussões:

INSERT INTO mensagem
VALUES ('maria33', 1, '2022-01-03', 'Será útil pelo raciocínio lógico');

INSERT INTO mensagem
VALUES ('joao22', 1, '2022-01-03 00:10:00', 'Algo mais?');

INSERT INTO mensagem
VALUES ('maria33', 1, '2022-01-03 00:20:00', 'Melhor esperar uma resposta do professor.');

INSERT INTO mensagem
VALUES ('grings123', 2, '2022-04-06', 'Sim, Maria. Seu raciocínio está correto');


-- Criação de playlists:

INSERT INTO playlist (usuario, titulo, data_criacao, duracao)
VALUES ('joao22', 'Cálculos', '2021-05-07', NULL);

INSERT INTO playlist (usuario, titulo, data_criacao, duracao)
VALUES ('maria33', 'Primeiro Semestre', '2022-03-01', NULL);


-- Criação de associações aula - playlist:

INSERT INTO aula_playlist
VALUES (1, 1);  -- Limites laterais em Cálculos (do joão)

INSERT INTO aula_playlist
VALUES (2, 1);  -- Stokes em Cálculos (do joão)

INSERT INTO aula_playlist
VALUES (3, 2);  -- Equação da Reta em 1° semestre (da maria)

INSERT INTO aula_playlist
VALUES (1, 2);  -- Limites Laterais em 1° semestre (da maria)
