-- Lista aulas com views, likes e dislikes
SELECT a.*,
SUM(b.quantidade) AS views,
COUNT(CASE WHEN b.avaliacao = 1 THEN 1 END) AS likes,
COUNT(CASE WHEN b.avaliacao = -1 THEN 1 END) AS dislikes
FROM aula a JOIN aula_assistida b ON a.id = b.aula
GROUP BY a.id
ORDER BY views DESC, likes DESC;


-- Lista os professores ordenados por likes
SELECT a.professor,
COUNT(CASE WHEN b.avaliacao = 1 THEN 1 END) AS likes,
COUNT(CASE WHEN b.avaliacao = -1 THEN 1 END) AS dislikes
FROM aula a JOIN aula_assistida b
ON a.id = b.aula
GROUP BY a.professor
ORDER BY likes DESC, dislikes ASC;


-- Lista as aulas que receberam avaliação positiva E foram colocadas em alguma playlist por um mesmo usuário
SELECT a.titulo, p.usuario, p.titulo, p.data_criacao
FROM aula a JOIN aula_playlist ap ON a.id = ap.aula
            JOIN playlist p ON ap.playlist = p.id
WHERE (
    SELECT b.avaliacao
    FROM aula a2 JOIN aula_assistida b ON a2.id = b.aula
    WHERE a.id = a2.id AND b.aluno = p.usuario
) = 1;

-- Lista nome de todos os alunos, e, se houver, conteúdo e matéria da aula de mensagens enviadas por ele em fóruns a partir de 2022
SELECT u.nome, m.conteudo, c.codigo
FROM usuario u LEFT JOIN mensagem m ON u.username = m.usuario
               LEFT JOIN discussao d ON m.discussao = d.id
               LEFT JOIN aula a ON d.aula = a.id
               LEFT JOIN disciplina c ON a.disciplina = c.codigo
WHERE data_msg IS NULL OR EXTRACT (YEAR FROM data_msg) >= 2022;

-- Lista da média de minutos das aulas relacionadas a disciplinas de cálculo por professor
SELECT p.nome, AVG(duracao)
FROM aula a JOIN disciplina d ON a.disciplina = d.codigo
            JOIN usuario p ON a.professor = p.username
WHERE d.codigo LIKE 'CALC_'
GROUP BY p.username;
