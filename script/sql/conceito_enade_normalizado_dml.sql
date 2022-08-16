USE conceito_enade_2019;

INSERT INTO municipio (
    cod_municipio,
    nome,
    sigla_uf
)
SELECT DISTINCT
    cod_municipio,
    nome_municipio,
    sigla_uf_municipio
FROM
    conceito_enade_desnormalizado;

INSERT INTO ies (
    cod_ies,
    nome,
    sigla,
    org_acad,
    categ_adm
)
SELECT DISTINCT
    cod_ies,
    nome_ies,
    sigla_ies,
    org_acad_ies,
    categ_adm_ies
FROM
    conceito_enade_desnormalizado;

INSERT INTO area_avaliacao (
    cod_area_avaliacao,
    nome
)
SELECT DISTINCT
    cod_area_avaliacao,
    nome_area_avaliacao
FROM
    conceito_enade_desnormalizado;

INSERT INTO curso (
    cod_curso,
    mod_ens,
    cod_area_avaliacao,
    cod_ies,
    cod_municipio
)
SELECT DISTINCT
    cod_curso,
    mod_ens_curso,
    cod_area_avaliacao,
    cod_ies,
    cod_municipio
FROM
    conceito_enade_desnormalizado;

INSERT INTO conceito_enade (
    cod_curso,
    num_concl_inscr,
    num_concl_part,
    nota_bruta_fg,
    nota_padr_fg,
    nota_bruta_ce,
    nota_padr_ce,
    conceito_enade_continuo,
    conceito_enade_faixa,
    observacao
)
SELECT DISTINCT
    cod_curso,
    num_concl_inscr,
    num_concl_part,
    nota_bruta_fg,
    nota_padr_fg,
    nota_bruta_ce,
    nota_padr_ce,
    conceito_enade_continuo,
    conceito_enade_faixa,
    observacao
FROM
    conceito_enade_desnormalizado;
