import os
from dotenv import load_dotenv

load_dotenv();

config = {
    'csv': {
        'filepath': os.environ.get('CSV_FILEPATH')
    },
    'database': {
        'name': os.environ.get('DATABASE_NAME'),
        'host': os.environ.get('DATABASE_HOST'),
        'port': int(os.environ.get('DATABASE_PORT')),
        'user': os.environ.get('DATABASE_USER'),
        'password': os.environ.get('DATABASE_PASSWORD')
    },
    'log': {
        'filename': os.environ.get('LOG_FILENAME'),
        'filemode': os.environ.get('LOG_FILEMODE'),
        'format': os.environ.get('LOG_FORMAT'),
        'datefmt': os.environ.get('LOG_DATEFMT'),
        'level': int(os.environ.get('LOG_LEVEL'))
    },
    'flag': {
        'success': 0,
        'error': 1
    }
};
