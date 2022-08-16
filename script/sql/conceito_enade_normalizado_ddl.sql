USE conceito_enade_2019;

DROP TABLE IF EXISTS conceito_enade;

DROP TABLE IF EXISTS curso;

DROP TABLE IF EXISTS area_avaliacao;

DROP TABLE IF EXISTS ies;

DROP TABLE IF EXISTS municipio;

CREATE TABLE IF NOT EXISTS municipio (
    cod_municipio INT NOT NULL,
    nome VARCHAR(63) NOT NULL,
    sigla_uf CHAR(2) NOT NULL,
    PRIMARY KEY (cod_municipio)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ies (
    cod_ies INT NOT NULL,
    nome VARCHAR(127) NOT NULL,
    sigla VARCHAR(31) DEFAULT NULL,
    org_acad ENUM('Centro Federal de Educação Tecnológica', 'Centro Universitário', 'Faculdade', 'Instituto Federal de Educação, Ciência e Tecnologia', 'Universidade') NOT NULL,
    categ_adm ENUM('Especial', 'Privada com fins lucrativos', 'Privada sem fins lucrativos', 'Pública Municipal', 'Pública Federal', 'Pública Estadual') NOT NULL,
    PRIMARY KEY (cod_ies)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS area_avaliacao (
    cod_area_avaliacao INT NOT NULL,
    nome VARCHAR(63) NOT NULL,
    PRIMARY KEY (cod_area_avaliacao)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS curso (
    cod_curso INT NOT NULL,
    mod_ens ENUM('Educação a Distância', 'Educação Presencial') NOT NULL,
    cod_area_avaliacao INT NOT NULL,
    cod_ies INT NOT NULL,
    cod_municipio INT NOT NULL,
    PRIMARY KEY (cod_curso),
    FOREIGN KEY (cod_area_avaliacao) REFERENCES area_avaliacao (cod_area_avaliacao),
    FOREIGN KEY (cod_ies) REFERENCES ies (cod_ies),
    FOREIGN KEY (cod_municipio) REFERENCES municipio (cod_municipio)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS conceito_enade (
    cod_curso INT NOT NULL,
    num_concl_inscr INT NOT NULL,
    num_concl_part INT NOT NULL,
    nota_bruta_fg DOUBLE DEFAULT NULL,
    nota_padr_fg DOUBLE DEFAULT NULL,
    nota_bruta_ce DOUBLE DEFAULT NULL,
    nota_padr_ce DOUBLE DEFAULT NULL,
    conceito_enade_continuo DOUBLE DEFAULT NULL,
    conceito_enade_faixa INT DEFAULT NULL,
    observacao VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (cod_curso),
    FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
