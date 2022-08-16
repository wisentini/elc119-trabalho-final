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
    aa.nome = 'ENGENHARIA ELÉTRICA' AND m.sigla_uf = 'RS'
ORDER BY nota_componente_especifico DESC;

-- Ranking das médias do conceito enade por universidade pública
-- O número de cursos participantes por universidade pública também
-- compõe o resultado, já que ele influencia na média final
SELECT
    ies.nome AS nome_ies,
    COUNT(*) AS num_cursos_part,
    AVG(conceito_enade_faixa) AS media_conceito_enade
FROM
    conceito_enade AS ce NATURAL JOIN curso AS c NATURAL JOIN ies
WHERE
    ies.org_acad = "Universidade" AND ies.categ_adm LIKE "Pública%"
GROUP BY ies.cod_ies
ORDER BY media_conceito_enade DESC;
