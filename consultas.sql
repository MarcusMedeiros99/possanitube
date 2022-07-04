-- Lista aulas com views, likes e dislikes
SELECT a.*,
SUM(b.quantidade) AS views,
COUNT(CASE WHEN b.avaliacao = 1 THEN 1 END) AS likes,
COUNT(CASE WHEN b.avaliacao = -1 THEN 1 END) AS dislikes
FROM aula a JOIN aula_assistida b
ON a.id = b.aula
GROUP BY a.id
ORDER BY views DESC, likes DESC;
