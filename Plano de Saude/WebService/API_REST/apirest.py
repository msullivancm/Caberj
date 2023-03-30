#teste rest api com python
''' Instalando pre-requisitos
Baixar e instalar https://visualstudio.microsoft.com/pt-br/visual-cpp-build-tools/ 
    Instalar o pacote: .net desktop build tools ou ferramentas de build de área de trabalho do .net
    (Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/)
pip3 install flask flask-cors
pip3 install cx_Oracle --upgrade
Para executar a api rest '''
#python3 -m flask -A "C:\Users\Sullivan\source\Caberj\Plano de Saude\WebService\API_REST\apirest.py" run

from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
app.run(debug=True, port=8080)
CORS(app)

def oracle_connection():
    import cx_Oracle
    con = cx_Oracle.connect('siga/taqui0pA@10.19.1.117:1521/caberj')
    return con

@app.route('/', methods=['GET'])
def api_all():
    con = oracle_connection()
    cur = con.cursor()
    cur.execute('Select BB8.BB8_MUN NOME_MUNICIPIO from BB8010 BB8 where 1=1')
    rows = cur.fetchall()
    con.close() 
    return jsonify(rows)

