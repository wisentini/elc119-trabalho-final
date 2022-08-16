-- Ranking das maiores notas em componente específico na prova de engenharia elétrica por IES do RS
SELECT
    c.cod_curso,
    ies.nome AS ies,
    m.nome AS municipio,
    ce.nota_padr_ce AS nota_componente_especifico
FROM
    conceito_enade AS ce
    JOIN curso AS c USING (cod_curso)
    JOIN municipio AS m USING (cod_municipio)
    JOIN ies USING (cod_ies)
    JOIN area_avaliacao AS aa USING (cod_area_avaliacao)
WHERE
    aa.nome = 'ENGENHARIA ELÉTRICA' AND
    m.sigla_uf = 'RS'
ORDER BY nota_componente_especifico DESC;
