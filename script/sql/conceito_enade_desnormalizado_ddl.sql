DROP DATABASE IF EXISTS conceito_enade_2019;

CREATE DATABASE IF NOT EXISTS conceito_enade_2019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

USE conceito_enade_2019;

DROP TABLE IF EXISTS conceito_enade_desnormalizado;

CREATE TABLE IF NOT EXISTS conceito_enade_desnormalizado (
    ano INT NOT NULL,
    cod_area_avaliacao INT NOT NULL,
    nome_area_avaliacao VARCHAR(63) NOT NULL,
    cod_ies INT NOT NULL,
    nome_ies VARCHAR(127) NOT NULL,
    sigla_ies VARCHAR(31) DEFAULT NULL,
    org_acad_ies ENUM('Centro Federal de Educação Tecnológica', 'Centro Universitário', 'Faculdade', 'Instituto Federal de Educação, Ciência e Tecnologia', 'Universidade') NOT NULL,
    categ_adm_ies ENUM('Especial', 'Privada com fins lucrativos', 'Privada sem fins lucrativos', 'Pública Municipal', 'Pública Federal', 'Pública Estadual') NOT NULL,
    cod_curso INT NOT NULL,
    mod_ens_curso ENUM('Educação a Distância', 'Educação Presencial') NOT NULL,
    cod_municipio INT NOT NULL,
    nome_municipio VARCHAR(63) NOT NULL,
    sigla_uf_municipio CHAR(2) NOT NULL,
    num_concl_inscr INT NOT NULL,
    num_concl_part INT NOT NULL,
    nota_bruta_fg DOUBLE DEFAULT NULL,
    nota_padr_fg DOUBLE DEFAULT NULL,
    nota_bruta_ce DOUBLE DEFAULT NULL,
    nota_padr_ce DOUBLE DEFAULT NULL,
    conceito_enade_continuo DOUBLE DEFAULT NULL,
    conceito_enade_faixa INT DEFAULT NULL,
    observacao VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (cod_curso)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
