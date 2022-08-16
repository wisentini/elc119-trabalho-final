# Script para gerenciar o esquema desnormalizado

## Configuração do ambiente de desenvolvimento

```bash
# cria um ambiente virtual
python -m venv venv

# acessa o ambiente virtual (linux)
source venv/bin/activate

# acessa o ambiente virtual (windows)
.\venv\Scripts/activate

# atualiza o gerenciador de pacotes do python
python -m pip install --upgrade pip

# instala as dependências necessárias
pip install -r requirements.txt
```

Se tudo ocorreu como o esperado, agora você deve conseguir ver o nome do ambiente virtual prefixado ao seu `host` no terminal. Por exemplo:

```bash
(venv) joao@silva:~$
```

Caso você queira sair do ambiente virtual, é só executar o comando `deactivate`.

## Variáveis de ambiente

Em `config/.env` encontram-se algumas variáveis de ambiente utilizadas pelo script `conceito_enade_desnormalizado.py`. Antes de rodar o script, certifique-se de que elas contém os valores corretos, caso contrário, o programa se comportará de forma imprevisível.

## Rodando

Para rodar o script `conceito_enade_desnormalizado.py`, basta abrir um terminal nesse mesmo diretório e executar o comando `python conceito_enade_desnormalizado.py`. Certifique-se de executar esse comando através do ambiente virtual criado anteriormente.
