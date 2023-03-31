#teste rest api com python
''' Instalando pre-requisitos
Baixar e instalar https://visualstudio.microsoft.com/pt-br/visual-cpp-build-tools/ 
    Instalar o pacote: .net desktop build tools ou ferramentas de build de área de trabalho do .net
    (Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/)
pip3 install flask flask-cors
pip3 install pyproject.toml
python3 -m pip install cx_Oracle --upgrade
conda install cx_Oracle

python -m pip install oracledb --upgrade


Para executar a api rest '''
#python3 -m flask -A "C:\Users\Sullivan\source\Caberj\Plano de Saude\WebService\API_REST\apirest.py" run

from flask import Flask, jsonify, request
from flask_cors import CORS
import oracledb
import os

""" app = Flask(__name__)
app.run(debug=True, port=8080)
CORS(app) """

def oracle_connection():
    oracledb.init_oracle_client(lib_dir=r"C:\Users\Sullivan\source\Caberj\instantclient_21_9")
    un = os.environ.get('ORACLE_USER')
    pw = os.environ.get('ORACLE_PASSWORD')
    cs = os.environ.get('ORACLE_CONNECTION_STRING')
    with oracledb.connect(user="siga", password="taqui0pA", host="10.19.1.117", port="1521", service_name="caberj") as connection:
        with connection.cursor() as cursor:
            sql = """select sysdate from dual"""
            for r in cursor.execute(sql):
                print(r)
    """ con = cx_Oracle.connect('siga/taqui0pA@10.19.1.117:1521/caberj') """
    return

#@app.route('/', methods=['GET'])
def api_all():
    con = oracle_connection()
    cur = con.cursor()
    cur.execute('Select BB8.BB8_MUN NOME_MUNICIPIO from BB8010 BB8 where 1=1')
    rows = cur.fetchall()
    con.close() 
    return jsonify(rows)

print(oracle_connection()) 
