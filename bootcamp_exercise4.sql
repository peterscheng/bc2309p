WITH all_score AS (
	SELECT
		p.player_id,
		p.group_id,
		(
			CASE
			WHEN m.first_score IS NULL THEN
				0
			ELSE
				m.first_score
			END
		) AS score
	FROM
		players p
	LEFT JOIN matches m ON p.player_id = m.first_player
	UNION
		SELECT
			p.player_id,
			p.group_id,
			(
				CASE
				WHEN m.second_score IS NULL THEN
					0
				ELSE
					m.second_score
				END
			) AS score
		FROM
			players p
		LEFT JOIN matches m ON p.player_id = m.second_player
),
 player_score AS (
	SELECT
		a.group_id,
		a.player_id,
		sum(a.score) AS score
	FROM
		all_score a
	GROUP BY
		a.group_id,
		a.player_id
),
 max_score AS (
	SELECT
		p.group_id,
		p.player_id,
		p.score
	FROM
		player_score p
	WHERE
		(p.group_id, p.score) IN (
			SELECT
				group_id,
				max(score) AS max_score
			FROM
				player_score
			GROUP BY
				group_id
		)
) SELECT
	m.group_id,
	m.player_id AS winner_id
FROM
	max_score m
WHERE
	m.player_id IN (
		SELECT
			min(player_id)
		FROM
			max_score
		WHERE
			score = m.score
	)
ORDER BY
	1 ASC;