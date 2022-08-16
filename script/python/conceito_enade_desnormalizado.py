import sys
import logging
import pandas
import numpy
import mysql.connector
from mysql.connector import Error
from config.config import config


logging.basicConfig(
    filename = config['log']['filename'],
    filemode = config['log']['filemode'],
    format   = config['log']['format'],
    datefmt  = config['log']['datefmt'],
    level    = config['log']['level']
)


def parse_csv_data(csv_data):
    csv_data_tuple_list = list()

    iterator = csv_data.itertuples(index = False)

    for row in iterator:
        row_list = list(row)
        conceito_faixa_curso_enade = row[20]
        row_list[20] = None if conceito_faixa_curso_enade == 'SC' else conceito_faixa_curso_enade
        row_tuple = tuple(row_list)
        csv_data_tuple_list.append(row_tuple)

    return csv_data_tuple_list


def get_csv_data():
    filepath = config['csv']['filepath']

    csv_data = pandas.read_csv(
        filepath,
        index_col = False,
        delimiter=','
    )

    csv_data = csv_data.replace({
        numpy.nan: None
    })

    csv_data = parse_csv_data(csv_data)

    return csv_data


def init_connection():
    try:
        connection = mysql.connector.connect(
            database = config['database']['name'],
            host = config['database']['host'],
            port = config['database']['port'],
            user = config['database']['user'],
            password = config['database']['password'],
        )

        cursor = connection.cursor()

        return connection, cursor
    except Error as error:
        logging.critical('Couldn\'t connect to database');
        logging.critical(error);
        sys.exit(config['flag']['error'])


def close_connection(connection, cursor):
    if connection is not None:
        cursor.close()
        connection.close()
    else:
        logging.critical('Couldn\'t close database connection')
        sys.exit(config['flag']['error'])


def execute(connection, cursor, command, params=tuple()):
    try:
        cursor.execute(command, params)
    except Error as error:
        connection.rollback()
        sql = cursor.statement
        logging.error(f'Couldn\'t execute "{sql}"')
        logging.error(error)
        sys.exit(config['flag']['error'])


def drop_database(connection, cursor):
    logging.info(f'Dropping database "conceito_enade_2019"')

    command = 'DROP DATABASE IF EXISTS conceito_enade_2019;'
    execute(connection, cursor, command)

    logging.info(f'Database "conceito_enade_2019" was successfully dropped')


def create_database(connection, cursor):
    logging.info(f'Creating database "conceito_enade_2019"')

    command = 'CREATE DATABASE IF NOT EXISTS conceito_enade_2019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;'
    execute(connection, cursor, command)

    logging.info(f'Database "conceito_enade_2019" was successfully created')


def use_database(connection, cursor):
    command = 'USE conceito_enade_2019;'
    execute(connection, cursor, command)

    logging.info(f'Using database "conceito_enade_2019"')


def drop_table(connection, cursor):
    logging.info(f'Dropping table "conceito_enade_desnormalizado"')

    command = 'DROP TABLE IF EXISTS conceito_enade_desnormalizado;'
    execute(connection, cursor, command)

    logging.info(f'Table "conceito_enade_desnormalizado" was successfully dropped')


def create_table(connection, cursor):
    logging.info(f'Creating table "conceito_enade_desnormalizado"')

    command = '''
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
    '''

    execute(connection, cursor, command)

    logging.info(f'Table "conceito_enade_desnormalizado" was successfully created')


def insert_into_table(connection, cursor):
    rows = get_csv_data()

    for row in rows:
        command = 'INSERT INTO conceito_enade_desnormalizado VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'
        
        execute(connection, cursor, command, row)

        cod_curso = row[10]

        logging.info(f'Row identified by (cod_curso = {cod_curso}) was successfully inserted')


def main():
    print(f'\nThis script output will be written to "output.log". Be sure to check it after its completion...\n')

    connection, cursor = init_connection()

    drop_database(connection, cursor)
    create_database(connection, cursor)
    use_database(connection, cursor)

    drop_table(connection, cursor)
    create_table(connection, cursor)
    insert_into_table(connection, cursor)

    connection.commit()
    close_connection(connection, cursor)


if __name__ == '__main__':
    main()
