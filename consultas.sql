-- Lista aulas com views, likes e dislikes
SELECT a.*,
SUM(b.quantidade) AS views,
COUNT(CASE WHEN b.avaliacao = 1 THEN 1 END) AS likes,
COUNT(CASE WHEN b.avaliacao = -1 THEN 1 END) AS dislikes
FROM aula a JOIN aula_assistida b
ON a.id = b.aula
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

