#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

#DEFINE c_ent CHR(13) + CHR(10)

///*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³CABA058    º Autor ³ Renato Peixoto     º Data ³  08/03/2012 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ Gera rateio ADU para a Integral Saude, por meio de inclusão º±±
//±±º          ³ de guias no contas medicas, conforme parametros.            º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP6 IDE                                                     º±±
//±±ºAlteração ³ Motta - Data: 27/11/2019                                    º±±
//±±º                    Tratar bloqueios temporários                        º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

///*/                                                       .
//falta alterar geraçao do arquivo texto de acordo com novo layout da BEM. Eloiza disse que nao ha necessidade...
User Function CABA058()
                                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oGeraTxt
Private cPerg       := "CABA58"
Private cString     := "BA1"
Private nlinha      := 0
Private nlinha1     := 0
Private nTamLin, cLin, cCpo
Private lAbortPrint := .F.
private xUsu        := {}
private aPlano      := {}
private aCarGer     := {}
private aVDS        := {}
Private cBF4Name    := RetSQLName("BF4")
Private cBA1Name    := RetSQLName("BA1")
Private cBI3Name    := RetSQLName("BI3")
Private cBT3Name    := RetSQLName("BT3")
Private cBG9Name    := RetSQLName("BG9")
Private lRet        := .T.
Private nTamLin     := 15
Private cLin        := Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
Private nValor      := 0
Private nTusu       := 0
Private cTipo       := ""
Private _cgc        := ""
Private cNomeProg   := "GERAREM"
Private nCaracter   := 15
Private Tamanho     := "M"
Private cTitulo     := "Quantidade de Usuarios que possuem opcional ADU."
Private cDesc1      := "Emite relatorio com a quantidade de ususarios por"
Private cDesc2      := "produto que possuem direito ao ADU."
Private cDesc3      := ""
Private cCabec1     := "Produtos com ADU"
Private cCabec2     := ""
Private cAlias      := "BA1"
Private wnRel       := "GERAADU"
Private Li          := 99
Private m_pag       := 1
Private aReturn     := {"Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
Private Limite      := 132
Private cCodEmp     := GETNEWPAR("MV_YCODADU","311")
Private cProADU     := GETNEWPAR("MV_XPROADU","80170315")
Private nVlADU      := GETNEWPAR("MV_YVLADU",2.22)
//Private nVlVDS      := GETNEWPAR("MV_YVLVDS",60.00)
//Private nVlCGER     := GETNEWPAR("MV_YVLCGER",15.40)
//Private cRDASP      := GETNEWPAR("MV_YRDASP","106445")
Private cRDARJ      := GETNEWPAR("MV_YRDARJ","126004")
Private cProdADU    := GETNEWPAR("MV_XCODADU","0023")
Private cPlanosADU  := GETNEWPAR("MV_XPLAADU","'0045','0053','0056','0057','0060','0062','0065','0072'")
Private nContGeral  := 0
Private cCodInt     := PLSINTPAD()
Private lGerouRat   := .F.   
Private aRelExcel   := {}//Variável que irá armazenar os usuários impressos, para exibir um relatório em excel ao final do processo...
aADD (aRelExcel,{"Projeto", "Código do Plano", "Descrição do Plano", "Matrícula", " Nome do Usuário", "Código do RDA", "Valor","Idade","UF","MUNICIPIO"})

//Verifica em qual empresa o usuário está logado. Só pode executar a rotina na Integral Saúde.
If cEmpAnt == "01"
	APMSGSTOP("Atenção. Você está tentando executar esta rotina na Caberj. Favor executar novamente na Integral Saúde.","Empresa incorreta!")
	Return
EndIf

// Criar campo na tabela BT3 (produtos relacionados) para indicar qual será o codigo do lancamento de debito/credito
// a ser incluido no cadastro de debito/credito pela rotina automatica.
// Nome do Campo := BT3_YCDDBCR
// Tipo := C
// Tamanho := 3
// Descricao := Cod. Deb/Cre
// usar a mesma consulta do cadastro de Debito/Credito do campo BGQ_CODLAN (Lancamento)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)

dbSelectArea("BA1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@ 200,1 TO 390,430 DIALOG oGeraTxt TITLE OemToAnsi("Gera‡„o de Arquivo Texto")
@ 02,10 TO 90,200 //faz as bordas internas
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " BA1                                                           "

@ 60,108 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 60,138 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 60,168 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKGERATXTº Autor ³ AP5 IDE            º Data ³  19/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a geracao do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function OkGeraTxt

Local cDirGrava    := GetNewPar("MV_PLSDIRC","C:\")
Local cDirPls      := ""
Private nHdl       := 0   //Local
Private cArquivo   := space(0)
Private cEOL       := "CHR(13)+CHR(10)"
Private cCompet    := ""
Private lExisteRat := .F.
Private dDtEvento  := MV_PAR08

Inclui := .T. //seta a variavel publica inclui como .T. para que nao ocorra erros nos inicializadores padrao dos campos...

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

cCompet := MV_PAR06+MV_PAR05

DbSelectArea("PB8")
DbSetOrder(1)
If DbSeek(XFILIAL("PB8")+cCompet+cRDARJ)
	APMSGINFO("Atenção, já existe rateio gerado para esta competencia. Somente serão gerados registros para os beneficiarios que por ventura tenham ficado de fora do rateio já gerado anteriormente.","Já existe rateio ADU para esta competencia na Integral.")
	lExisteRat := .T.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(mv_par01) .or. Empty(mv_par02) .or. Empty(mv_par04) ;   //.or. Empty(mv_par03)
	.or. Empty(mv_par05) .or. Empty(mv_par06) .or. Empty(mv_par07)
	MsgAlert("Informe os parametros .....")
	Close(oGeraTxt)
	Return
Endif
/* rever uso, pois nao esta fazendo nada... parametros desatualizados... Renato Peixoto em 10/04/12
If mv_par04 = 1
	cTipo := "S"
ElseIf mv_par04 = 2
	cTipo := "P"
ElseIf mv_par04 = 3
	cTipo := "F"
ElseIf mv_par04 = 4
	cTipo := "A"
EndIf
*/
_data := (substr(Dtoc(dDataBase),1,2)+ substr(Dtoc(dDataBase),4,2)+ substr(Dtoc(dDataBase),7,2))

cDirPls := alltrim(MV_PAR03)
If !Empty(cDirPls)
	cDirGrava := alltrim(cDirPls)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao informou a barra												³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SubStr(cDirGrava,Len(cDirGrava),1) <> "\"
	cDirGrava += "\"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto layout de Informacoes Cadastrais               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cArquivo := cDirGrava + "T"+ Alltrim(cCodEmp) + "0001.TXT"   //+Alltrim(mv_par03) + cTipo +_data  + "." + "TXT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se e possivel criar o arquivo						³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHdl := fCreate(cArquivo)

If nHdl == -1
	MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a regua de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oProcess := MsNewProcess():New({||ProcTXTInt()},"Processando...","",.F.)
oProcess:Activate()
//MsAguarde({|| ProTXTInt() }, "Processando...", "", .T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³PROCTXTIntº Autor ³ Renato Peixoto     º Data ³  12/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ProcTXTInt()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local dDatIni      := CtoD("  /  /    ")
Local dDtInicial   := CtoD("  /  /    ")
Local aCriticas    := {}

Private nContador  := 0
Private nIdade
Private nVlTotReal := 0 //Armazena o valor total real que foi gerado no rateio, ja deduzindo possiveis valores de glosa...
Private cNumGuia

oProcess:SetRegua1(0)
oProcess:SetRegua2(0)

For i := 1 to 5
	oProcess:IncRegua1("Selecionando registros...")
Next

//MsgRun("Selecionando Registros...",,{|| BuscaRegs(),CLR_HBLUE})
MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})
/* Essa query foi comentada pois sempre foi errada, por trazer apenas beneficiarios do plano 0045, desconsiderando os demais planos que tem direito, alem dos beneficiarios que possuem o ADU como opcional
//Renato Peixoto em 09/04/2012
cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, BA1.* "
cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "+RetSQLName("BA3") + " BA3 "
cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "
cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "
cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "
cSQL += " BA1.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3.D_E_L_E_T_ = ' '  AND "
cSQL += " BG9.D_E_L_E_T_ = ' '  AND "
cSQL += " BA1_CODPLA = '0045' AND " 
cSQL += " BA1_DATINC <= '"+dtos(Mv_Par02)+"' AND " 
cSQL += " BA3_CODINT = BA1_CODINT AND "
cSQL += " BA3_CODEMP = BA1_CODEMP AND "
cSQL += " BA3_MATRIC = BA1_MATRIC AND "
//cSQL += " BA1_DATBLO = '      ' AND "
//cSQL += " BA1_MOTBLO = '  ' AND "
cSQL += " ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR BA1_DATBLO >= '"+DtoS(mv_par02)+"') AND  "
cSQL += " BG9_CODIGO = BA1_CODEMP AND "
cSQL += " BTS_MATVID = BA1_MATVID AND "
//ver qual estado deve ser. RJ ou SP ou ambos
cSQL += " BA1_ESTADO = 'RJ' "  //ver Estado se deve ser SP em vez de RJ

If lExisteRat
	cSQL += "AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO NOT IN (SELECT PB8_CODINT||PB8_CODEMP||PB8_MATRIC||PB8_TIPREG||PB8_DIGITO "
	cSQL += "FROM "+RETSQLNAME("PB8")+" PB8 WHERE D_E_L_E_T_ = ' ' AND PB8_COMPET = '"+cCompet+"' AND PB8_CODRDA = '"+cRDARJ+"') "
EndIf

//	cSQL += " BA1_ESTADO = 'SP' AND "
//	cSQL += " BA1_CODMUN IN ('3304557','3303302','3304904','3300456','3301702','3302270','3303203','3303500','3304144','3305109','421954') "
//EndIf
cSQL += " Order by BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"
*/ 
//Query atualizada de acordo com os critérios atuais de captação de todos os beneficiarios que possuem o ADU vinculado ao Plano ou como opcional.
//Esta query foi validada com a GERIN e com o Dr. Jose Paulo. Segundo o Dr. Jose Paulo, o contrato dos colaboradores caberj na integral saude, nao possui direito ao ADU.
//Renato Peixoto em 10/04/2012
cSQL := "SELECT 'VINCULADOS_PLANO',BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, IDADE_S(BA1_DATNAS) IDADE, BA1.* "+c_ent
cSQL += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BG9")+" BG9, "+RetSqlName("BTS")+" BTS, "+RetSqlName("BA3")+" BA3 "+c_ent
cSQL += "WHERE BA1_FILIAL = '"+XFILIAL("BA1")+"'  AND  BG9_FILIAL = '"+XFILIAL("BG9")+"'  AND  BA3_FILIAL = '"+XFILIAL("BA3")+"' "+c_ent
cSQL += "AND  BA1.D_E_L_E_T_ = ' '  AND  BA3.D_E_L_E_T_ = ' '   AND  BG9.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "AND ba1_codpla IN ("+cPlanosADU+") "+c_ent //alterar para um parâmetro pra nao ficar chumbado
cSQL += "AND  BA1_DATINC <= '"+DTOS(MV_PAR02)+"' AND  BA3_CODINT = BA1_CODINT AND  BA3_CODEMP = BA1_CODEMP AND  BA3_MATRIC = BA1_MATRIC "+c_ent
cSQL += "AND  ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) "+c_ent
cSQL += "AND   BG9_CODIGO = BA1_CODEMP AND  BTS_MATVID = BA1_MATVID "+c_ent
// motta 26/11/19
// cSQL += "AND  ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) "+c_ent
cSQL += "AND ( ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) "+c_ent
cSQL += "    OR  "+c_ent
cSQL += "        (RETORNA_MOTIVO_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'" + Iif(cEmpAnt=='01','C','I') + "') LIKE '%TEMP%') ) "+c_ent
// fim motta 16/11/19
//Chamado 15751 - BIANCHINI - Mudanca de regras do publico que vai ao RATEIO.  Rotina foi desmebrada para mostrar os elegiveis pelo CABA173
cSQL += "AND BA1_ESTADO = 'RJ' "+c_ent
cSQL += "AND BA1_CODMUN IN ('3300456','3303609','3302007','3305109','3302270','3300803','3301850','3303203','3303500','3302858','3302502',"+c_ent
cSQL += " '3304300','3305752','3304557','3303302','3304144','3305554','3304904','3301702','3301900','3302700') "+c_ent
//Chamado 15751 - FIM


If lExisteRat
//	cSQL += "AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO NOT IN (SELECT PB8_CODINT||PB8_CODEMP||PB8_MATRIC||PB8_TIPREG||PB8_DIGITO "+c_ent
//	cSQL += "FROM "+RETSQLNAME("PB8")+" PB8 WHERE D_E_L_E_T_ = ' ' AND PB8_COMPET = '"+cCompet+"' AND PB8_CODRDA = '"+cRDARJ+"') "+c_ent
////BIANCHINI - DINAMIZAR QUERY
	cSQL += "AND NOT EXISTS (SELECT 1 "+c_ent
	cSQL += "FROM "+RETSQLNAME("PB8")+" PB8 WHERE D_E_L_E_T_ = ' ' AND PB8_COMPET = '"+cCompet+"' AND PB8_CODRDA = '"+cRDARJ+"' "+c_ent
	cSQL += "AND BA1_CODINT = PB8_CODINT AND BA1_CODEMP = PB8_CODEMP AND BA1_MATRIC = PB8_MATRIC "+c_ent
	cSQL += "AND BA1_TIPREG = PB8_TIPREG AND BA1_DIGITO = PB8_DIGITO ) "+c_ent
EndIf
//cSQL += " --AND  BA1_ESTADO = 'RJ' " segundo dr. jose paulo eh para trazer todo mundo que tem direito de usar caso esteja no RJ
// --Order by BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO
cSQL += "UNION "+c_ent

cSQL += "SELECT * "+c_ent
cSQL += "FROM "+c_ent
cSQL += "( "+c_ent

cSQL += "SELECT CASE WHEN BYX_MATRIC IS NULL THEN 'NAO EXISTE' ELSE 'EXISTE' END EXISTE, "+c_ent
cSQL += "BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, IDADE_S(BA1_DATNAS) IDADE, BA1.* "+c_ent
cSQL += "FROM "+RetSqlName("BA1")+"  BA1 "+c_ent
cSQL += "  LEFT JOIN "+RetSqlName("BYX")+" BYX ON BYX.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "  		AND BYX_CODEMP = BA1_CODEMP "+c_ent
cSQL += "  		AND BYX_MATRIC = BA1_MATRIC "+c_ent
cSQL += "  		AND BYX_TIPREG = BA1_TIPREG "+c_ent
cSQL += "  		AND BYX_FILIAL = '"+XFILIAL("BYX")+"' "+c_ent
cSQL += "  INNER JOIN "+RetSqlName("BF4")+" BF4 ON BF4.D_E_L_E_T_ = ' ' "+c_ent 
cSQL += "	    AND BF4_FILIAL = '"+XFILIAL("BF4")+"' "+c_ent
cSQL += "	    AND BF4_CODINT = BA1_CODINT "+c_ent
cSQL += "	    AND BF4_CODEMP = BA1_CODEMP "+c_ent
cSQL += "	    AND BF4_MATRIC = BA1_MATRIC "+c_ent
cSQL += "	    AND BA1_TIPREG = BF4_TIPREG "+c_ent
cSQL += "	    AND BF4_CODPRO = '"+cProdADU+"' "+c_ent//colocar um parametro para buscar o codigo produto ADU Integral
cSQL += "		AND BF4_MOTBLO = ' ' "+c_ent
cSQL += "		AND BF4_DATBLO = ' ' "+c_ent
cSQL += "	INNER JOIN "+RetSqlName("BA3")+" BA3 ON ba3.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "   	AND ba3_filial = '"+XFILIAL("BA3")+"' AND  BA3_CODINT = BA1_CODINT AND  BA3_CODEMP = BA1_CODEMP AND  BA3_MATRIC = BA1_MATRIC "+c_ent
cSQL += "	INNER JOIN "+RetSqlName("BG9")+" BG9 ON bg9.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "		AND bg9_filial = '"+XFILIAL("BG9")+"'  AND BG9_CODIGO = BA1_CODEMP "+c_ent
cSQL += "	INNER JOIN "+RetSqlName("BTS")+" BTS ON BTS.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "   	AND bts_filial = '"+XFILIAL("BTS")+"' AND  BTS_MATVID = BA1_MATVID "+c_ent
cSQL += "WHERE  BA1.D_E_L_E_T_ = ' ' "+c_ent
cSQL += "AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cSQL += "AND ba1_datinc <= '"+DTOS(MV_PAR02)+"' "+c_ent
// motta 26/11/19 
// cSQL += "AND ((BA1_DATBLO = ' ' AND BA1_MOTBLO = ' ' ) OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) " +c_ent
cSQL += "AND ( ((BA1_DATBLO = ' ' AND BA1_MOTBLO = ' ' ) OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) " +c_ent
cSQL += "    OR  "+c_ent
cSQL += "        (RETORNA_MOTIVO_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'" + Iif(cEmpAnt=='01','C','I') + "') LIKE '%TEMP%') ) "+c_ent
// fim motta 26/11/19 
//Chamado 15751 - BIANCHINI - Mudanca de regras do publico que vai ao RATEIO.  Rotina foi desmebrada para mostrar os elegiveis pelo CABA173
cSQL += "AND BA1_ESTADO = 'RJ' "+c_ent
cSQL += "AND BA1_CODMUN IN ('3300456','3303609','3302007','3305109','3302270','3300803','3301850','3303203','3303500','3302858','3302502',"+c_ent
cSQL += " '3304300','3305752','3304557','3303302','3304144','3305554','3304904','3301702','3301900','3302700') "+c_ent
//Chamado 15751 - FIM

If lExisteRat
	//cSQL += "AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO NOT IN (SELECT PB8_CODINT||PB8_CODEMP||PB8_MATRIC||PB8_TIPREG||PB8_DIGITO "+c_ent
	//cSQL += "FROM "+RETSQLNAME("PB8")+" PB8 WHERE D_E_L_E_T_ = ' ' AND PB8_COMPET = '"+cCompet+"' AND PB8_CODRDA = '"+cRDARJ+"') "+c_ent
	////BIANCHINI - DINAMIZAR QUERY
	cSQL += "AND NOT EXISTS (SELECT 1 "+c_ent
	cSQL += "FROM "+RETSQLNAME("PB8")+" PB8 WHERE D_E_L_E_T_ = ' ' AND PB8_COMPET = '"+cCompet+"' AND PB8_CODRDA = '"+cRDARJ+"' "+c_ent
	cSQL += "AND BA1_CODINT = PB8_CODINT AND BA1_CODEMP = PB8_CODEMP AND BA1_MATRIC = PB8_MATRIC "+c_ent
	cSQL += "AND BA1_TIPREG = PB8_TIPREG AND BA1_DIGITO = PB8_DIGITO) "+c_ent
EndIf
cSQL += " )  "+c_ent

cSQL += "WHERE EXISTE = 'EXISTE' "+c_ent
cSQL += "Order by 9,10,16,17 "+c_ent //ba1.BA1_CODEMP, ba1.BA1_MATRIC, ba1.BA1_TIPREG, ba1.BA1_DIGITO


memowrit("C:\TEMP\GERAADU_1.SQL",cSQL)

PLSQuery(cSQL,"TF4")

TF4->(Dbgotop())
nCont := 0
COUNT TO nCont 
oProcess:SetRegua1(nCont)
cTot :=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
nCont := 0

cCodRDA := cRDARJ
	
DbSelectArea("TF4")
TF4->(Dbgotop())
nTotal := 0              

While !TF4->(Eof())
	
	oProcess:IncRegua1("Processando usuário " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )
	//MsProcTxt("Processando Usuario..."+ TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		Exit
	Endif
	
	//	verifcar no parametro qual o tipo de arquivo vou gerar
	// mv_par04 = 1 todos os usuarios validos
	// mv_par04 = 2 somente titular se houver dependente valido
	// mv_par04 = 3 todosos titulares
	If mv_par04 = 1
		//			If TF4->BA1_TIPREG <> "00"
		//				nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
		//				If nIdade > TF4->BA1_YIDMPE
		//					TF4->(DbSkip())
		//					Loop
		//				Endif
		//				If TF4->BA1_YVAIPE = "0"
		//					TF4->(DbSkip())
		//					Loop
		//				Endif
		//			Endif
	ElseIf mv_par04 = 2
		If TF4->BA1_TIPREG = "00"
			nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
			cSql1 := "SELECT COUNT(BA1_MATRIC) AS Total FROM "+ cBA1Name
			cSql1 += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' AND "
			cSql1 += " BA1_CODINT = '"+TF4->BA1_CODINT+"' AND "
			cSql1 += " BA1_CODEMP = '"+TF4->BA1_CODEMP+"' AND "
			cSql1 += " BA1_CONEMP=  '"+TF4->BA1_CONEMP+"' AND "
			cSql1 += " BA1_VERCON = '"+TF4->BA1_VERCON+"' AND "
			cSql1 += " BA1_SUBCON = '"+TF4->BA1_SUBCON+"' AND "
			cSql1 += " BA1_VERSUB = '"+TF4->BA1_VERSUB+"' AND "
			cSql1 += " BA1_MATRIC = '"+TF4->BA1_MATRIC+"' AND "
			//				cSql1 += " BA1_YVAIPE = '1' AND "
			cSql1 += cBA1Name+".D_E_L_E_T_ = ' '"
			PLSQuery(cSQL1,"TBA1")
			DbSelectArea("TBA1")
			If TBA1->Total <= 1
				TBA1->(DbCloseArea("TBA1"))
				TF4->(DbSkip())
				Loop
			Else
				TBA1->(DbCloseArea("TBA1"))
			Endif
		Else
			TF4->(DbSkip())
			Loop
		Endif
	Else
		If TF4->BA1_TIPREG <> "00"
			TF4->(DbSkip())
			Loop
		Endif
	EndIf
	
	If !Empty(TF4->BA1_CODPLA)
		cCodPla := TF4->(BA1_CODPLA+BA1_VERSAO)
	Else
		cCodPla := TF4->(BA3_CODPLA+BA3_VERSAO)
	EndIf
	
	cDesPla := "Produto nao Identificado"
	BI3->(DbSetOrder(1))
	If BI3->(DbSeek(xFilial("BI3")+TF4->BA1_CODINT+cCodPla))
		cDesPla := BI3->BI3_DESCRI   //BI3->BI3_NREDUZ
	EndIf
	
	If MV_PAR07 == 1
		cUsu :=(TF4->BA1_CODINT+TF4->BA1_CODEMP+TF4->BA1_MATRIC+TF4->BA1_TIPREG+TF4->BA1_DIGITO)
		
		nPos := aScan(xUsu, {|x| substr(x[1],9,17) == cUsu})
		
		//  Modo antigo de geração do arquivo txt (layout antigo BEM)
		
	////BIANCHINI - 12/02/2015 - Chamado 15751 - Desmembramento Geracao TXT pelo CABA174	
   /*		If nPos = 0
		   	Aadd(xUsu,{"00000000"+;
		   	     Padr(cUsu,20)+;
    		     Padr(substr(cCodPla,1,4),10)+;     //PADR(alltrim(TF4->BA1_CODPLA),10)+;
    	         SPACE(10)+;
		         PADR(cDesPla,20)+;   //Descricao do Produto
    		     SPACE(10)+;                                     
			     Iif(!Empty(TF4->BA1_DATINC),DtoS(TF4->BA1_DATINC),DtoS(TF4->BA1_DATINC))+;   //Data Inicio Opcional
			     Space(08)+;
    	         Iif(TF4->BA1_TIPREG == "00","T","D")+;
			     Padr(Alltrim(TF4->BA1_NOMUSR),50)+;
				 DtoS(TF4->BA1_DATNAS)+;
				 Iif(TF4->BA1_SEXO == "1","M","F")+;
				 Space(01)+;
				 Padr(alltrim(TF4->BTS_DRGUSR),15)+;
				 Padr(Alltrim(TF4->BTS_CPFUSR),14)+;
				 Space(20)+;
				 Padr(alltrim(TF4->BA1_MUNICI),30)+;
    			 Padr(Alltrim(TF4->BA1_ESTADO),2)+;
				 Iif(TF4->BG9_TIPO="1","0","1")+;              //Iif(TF4->BG9_TIPO="1","F","J")+;
    	         DtoS(TF4->BA1_DATBLO)+;   //Iif(TF4->BA1_DATBLO > TF4->BA1_YDTLIM, DtoS(TF4->BA1_DATBLO), DtoS(TF4->BA1_YDTLIM))+; // Somente se a data limite for superior a data do parametro  //DtoS(TF4->BA1_YDTLIM)+;                       // Data Limite
				 "0023"+;                                      // Codigo de Grupo de Produtos BEM
				 Space(04)+;
				 Space(04)+;
				 Space(04)+;
				 Space(04)+;
				 Space(04)+;
				 Space(10)+;    //Pessoa Juridica //			   	Space(40)+;    //Iif(MV_PAR09=1,Padr(Alltrim(TF4->BG9_DESCRI),40))+;   //Nome Empresa
				 Padr(Alltrim(TF4->BG9_DESCRI),50)+;   //Iif(MV_PAR09=1,Padr(Alltrim(TF4->BG9_DESCRI),50),Space(50))+;   //Nome Empresa   Padr(Alltrim(TF4->BA1_ENDERE),50)+;
    	         Space(50)+;    //
				 "I"})
		Endif */
   ////BIANCHINI - 12/02/2015 - Chamado 15751 - FIM

		//O trecho comentado abaixo esta reservado para implementaçao futura, caso a BEM solicite atualizacao de layout, assim como solicitou para a CABERJ AUTOGESTAO
		/* alteracao para novo layout da BEM. Na Caberj foi necessaria essa adaptacao. Em conversa com a Eloisa, ate agora nao foi necessario alterar o layout na Integral Saude
		cGrupo1 := Space(4)
		cGrupo2 := Space(4)
		
		If nIdade >= 50
	
			cAliasTmp := GetNextAlias()
	
 			cQuery := "SELECT NVL(RETORNA_NUCLEO_MS(BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,'" + DtoS(dDataBase) + "'),' ') AGENCIA" 	+ c_ent
 			cQuery += "FROM " + RetSqlName('BF4') 											  												+ c_ent
 			cQuery += "WHERE D_E_L_E_T_ = ' '" 																								+ c_ent 
 			cQuery += "		AND BF4_FILIAL = '" + xFilial('BF4') + "'" 																		+ c_ent
 			cQuery += "		AND BF4_CODINT = '" + TF4->BA1_CODINT + "'"    																	+ c_ent
 			cQuery += "		AND BF4_CODEMP = '" + TF4->BA1_CODEMP + "'" 																	+ c_ent
 			cQuery += "		AND BF4_MATRIC = '" + TF4->BA1_MATRIC + "'" 																	+ c_ent
 			cQuery += "		AND BF4_TIPREG = '" + TF4->BA1_TIPREG + "'" 																	+ c_ent
 			cQuery += "		AND BF4_MOTBLO = ' '" 		   																					+ c_ent
 			cQuery += "		AND (BF4_DATBLO = ' ' OR BF4_DATBLO > '" + DtoS(MV_PAR02) + "')"												+ c_ent
			cQuery += "		AND BF4_MOTBLO = ' '"																							+ c_ent
		
			TcQuery cQuery New Alias cAliasTmp
 		
 			//Leonardo Portella - 31/10/11 - Inicio    
		
			If allTrim(cAliasTmp->(AGENCIA)) $ '1|2|3'
		
				//cGrupo1 := '3547' 
					
				//Codigo BEM que identifica que o beneficiario possui mais de 49 anos e esta em uma das agencias (TIJUCA, NITEROI ou BANGU)
					
				Do Case
			
					Case allTrim(cAliasTmp->(AGENCIA)) == '1'//Niteroi 
						cGrupo1 := '3548'
					
					Case allTrim(cAliasTmp->(AGENCIA)) == '2'//Tijuca 
						cGrupo1 := '3547'

					Case allTrim(cAliasTmp->(AGENCIA)) == '3'//Bangu
						cGrupo1 := '3549'

				EndCase
				
				//Leonardo Portella - 31/10/11 - Fim
			
				cGrupo2 := Space(4)

 			EndIf 
 		
 			cAliasTmp->(dbCloseArea())
 		
		EndIf
	
		If empty(cGrupo1)//Mesmo conceito de antes, apenas separado por grupo
			cGrupo1 := If(cCodBEM == "0023",If(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+Space(04),Space(04)+"0024")
			cGrupo2 := Right(cGrupo1,4)
			cGrupo1 := Left(cGrupo1,4)
		EndIf

		aAdd(xUsu,{;
			Replicate('0',8)+;//Reservado
			PadR(cUsu,20)+;//Matricula
			PadR(cCodPla,10)+;//Codigo Plano
			Space(10)+;//Filler
			PadR(cDesPla,20)+;//Descricao do plano
			Space(10)+;//Filler
			If(!Empty(dDatIni),DtoS(dDatIni),DtoS(TF4->BA1_DATINC))+;//Data adesao
			Space(08)+;//Filler
			If(TF4->BA1_TIPREG == "00","T","D")+;//Tipo Beneficiario - T = Titular; D = Dependente
			PadR(Alltrim(TF4->BA1_NOMUSR),50)+;//Nome associado
			DtoS(TF4->BA1_DATNAS)+;//Data Nascimento
			If(TF4->BA1_SEXO == "1","M","F")+;//Sexo
			Space(01)+;//Filler
			PadR(alltrim(TF4->BTS_DRGUSR),15)+;//RG
			PadR(Alltrim(TF4->BTS_CPFUSR),14)+;//CPF
			Space(20)+;//Filler
			PadR(alltrim(TF4->BA1_MUNICI),30)+;//Municipio
			PadR(Alltrim(TF4->BA1_ESTADO),2)+;//UF
			If(TF4->BG9_TIPO == "1","0","1")+;//Tipo de pessoa - 0 = Fisica; 1 = Juridica
			DtoS(TF4->BA1_DATBLO)+;//Data de validade
			cGrupo1+;//Codigo de Grupo 1 de Produtos BEM
			cGrupo2+;//Codigo de Grupo 2 de Produtos BEM
			Space(04)+;//Codigo de Grupo 3 de Produtos BEM
			Space(04)+;//Codigo de Grupo 4 de Produtos BEM
			Space(04)+;//Codigo de Grupo 5 de Produtos BEM
			Space(04)+;//Codigo de Grupo 6 de Produtos BEM
			Space(10)+;//Pessoa Juridica 
			Space(40)+;//Nome da empresa do associado
			PadR(Alltrim(TF4->BA1_ENDERE),50)+;//Endereco
			PadR(Alltrim(TF4->BA1_NR_END),5)+;//Numero
			PadR(Alltrim(TF4->BA1_COMEND),10)+;//Complemento
			PadR(Alltrim(TF4->BA1_BAIRRO),30)+;//Bairro
			PadR(Alltrim(TF4->BA1_CEPUSR),8)+;//CEP
			PadR(Alltrim(TF4->BA1_DDD)+Alltrim(TF4->BA1_TELEFO),15)+;//Telefone 1
			Space(15)+;//Telefone 2
			Space(15)+;//Telefone 3 
			PadR(Substr(Alltrim(TF4->BA1_MATANT),1,20),20)+;//Matricula anterior 
			Space(02)+;//Motivo da baixa 
			Space(10)+;//Codigo do convenio
			"I";//Operacao - I = Inclusao; E = Exclusao; A = Alteracao
			})
		
		*/
		
	EndIf

	cCodADU := Space(03)
	//Pesquisa opcional no nivel do usuario
	DbSelectArea("BT3")
	BT3->(DbSetOrder(1))
	
	If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0023"))
		//Opcional no produto sem o codigo de lancamento
   		aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+SubStr(cCodPla,1,4)+"]"})
		ElseIf Empty(BT3_YCDADU)
   		aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+SubStr(cCodPla,1,4)+"]"})
	Else
	   cCodADU := BT3->BT3_YCDADU
	EndIf
	
	aADD (aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,cProADU, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "ADU"})
	
	aADD (aRelExcel,{"ADU",cCodPla,cDesPla, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,TF4->IDADE,TF4->BA1_ESTADO,TF4->BA1_MUNICI})
	
	//Chama a função que vai realizar o rateio ADU da Integral Saude, a partir de inclusao de guias no contas medicas...
	If U_GERADUINT(aPlano,"ADU")
		lGerouRat := .T.
		//Posiciono na tabela BD6, no registro que acabou de ser gravado pelo rateio...
		DbSelectArea("BD6")
		DbSetOrder(1)
		If DbSeek(XFILIAL("BD6")+cCodInt+"0001"+BCI->BCI_CODPEG+cNumGuia)
			//atualiza valor que foi gravado como valor de pagamento 
			nVlTotReal += BD6->BD6_VLRPAG	
			aPlano[nCont][9] := BD6->BD6_VLRPAG                  
		EndIf
		//Grava na tabela de controle de pagamento ADU
		RecLock("PB8",.T.)
		PB8->PB8_FILIAL := XFILIAL("PAH")
		PB8->PB8_COMPET := cCompet
		PB8->PB8_CODRDA := cCodRDA
		PB8->PB8_CODINT := TF4->BA1_CODINT
		PB8->PB8_CODEMP := TF4->BA1_CODEMP
		PB8->PB8_MATRIC := TF4->BA1_MATRIC
		PB8->PB8_TIPREG := TF4->BA1_TIPREG
		PB8->PB8_DIGITO := TF4->BA1_DIGITO
		PB8->PB8_NOMUSR := TF4->BA1_NOMUSR
		PB8->PB8_NOMPRO := "ADU" 
		PB8->PB8_VLRRAT := aPlano[nCont][9]
		PB8->(MsUnlock())
		
	EndIf
	
	TF4->(DbSkip())
	
Enddo
TF4->(DbCloseArea("TF4"))

//So vai fazer o restante se houve rateio
If lGerouRat
	//Atualiza total da PEG na capa das guias rateio (BCI)
	RecLock("BCI",.F.)
	BCI->BCI_QTDEVE := nContGeral
	BCI->BCI_VLRGUI := nVlTotReal
	BCI->(MsUnlock())

	If MV_PAR07 == 1
		nLinha := 0
		/*    ////BIANCHINI - 12/02/2015 - Chamado 15751 - Desmembramento Geracao TXT pelo CABA174
		For I:= 1 to len(xUsu)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicio da Gravação do Arquivo Texto                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nlinha ++
			nTamLin := 120
			cLin    := space(Len(xUsu[I,1]))   //Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Substitui nas respectivas posicioes na variavel cLin pelo conteudo  ³
			//³ dos campos segundo o Lay-Out. Utiliza a funcao STUFF insere uma     ³
			//³ string dentro de outra string. DETALHE                              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			//	cCpo := PADR('"'+xUsu[I,1]+'"',03)
			//	cCpo := PADR(",973,",05)
			//	cLin := Stuff(cLin,04,05,cCpo)
			//	cCpo := PADR(xUsu[I,2]+",",22)
			//	cLin := Stuff(cLin,09,22,cCpo)
			cCpo := xUsu[I,1]+strzero(nLinha,8)
			cLin := cCpo + cEOL
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ³
			//³ linha montada.                                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
				If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
					Exit
				Endif
			Endif
		Next
		fClose(nHdl)
		Close(oGeraTxt)
		*/ ////BIANCHINI - 12/02/2015 - Chamado 15751 - FIM
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite relat¢rio                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|lEnd| Imprime_Log() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ³
	//³ cao anterior.                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim do programa                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Else
	APMSGINFO("Atenção, não foi processado rateio para nenhum beneficiário. Talvez o rateio já tenha sido efetuado para esta competência. Verifique os parametros e tente novamente.","Rateio não foi gerado")
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Imprime_Log ³ Autor ³ Nelson / Angelo    ³ Data ³ 22/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Imprime_Log()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Imprime_Log()

dbSelectArea(cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel := SetPrint(cAlias,wnRel,"",@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,,lCompres,Tamanho,{},lFiltro,lCrystal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey  == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| Impr_Log() }, "Imprimindo relatorio totalizador ...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Impr_Log ³ Autor ³ Renato Peixoto        ³ Data ³ 08/03/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Impr_Log()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Impr_Log()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nQtdLin  := 58
Local nColuna  := 00
Local nOrdSel  := aReturn[8]
Local nVlTot   := 0
Local nTvalor  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista criticas                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aPlano) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	cTitulo := "Produtos com ADU - " + Iif(MV_PAR10 = 1," RIO DE JANEIRO"," SAO PAULO"
	cTitulo := "Produtos com ADU"
	cCabec1 := "Ativos ate: "+Dtoc(Mv_Par02)+"   Nome do Arquivo: "+cArquivo
	cCabec2 := "Plano     Desc. Plano      Matricula      Tipo Reg.    Digito   Nome                                    Valor Rateio        "  
	Li := 99
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta regua                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetRegua(len(aPlano))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa vetor com log de criticas                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to len(aPlano)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Li ++
			@ Li, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Li > nQtdLin
			//Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)   Estrutura do cabec no padrao. Abaixo esta dando erro
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//tratar aqui as colunas a serem impressas, de acordo com relatorio rateio ADU Caberj...
		//aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,cProADU, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "ADU"})
		@ Li, 000 pSay aPlano[I,1]
		@ Li, 012 pSay aPlano[I,2]
		//@ Li, 036 pSay aPlano[I,5] 
		@ Li, 029 pSay aPlano[I,6] 
		@ Li, 046 pSay aPlano[I,11]
		@ Li, 058 pSay aPlano[I,12]
		@ Li, 065 pSay aPlano[I,7]
		@ Li, 108 pSay aPlano[I,9] Picture "@R 999.99"
		Li ++
		//nTusu := nTusu + aPlano[I,3]
		nVlTot += nVlADU
	Next
	
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total ADU: "
	@ Li, 013 pSay nVlTotReal Picture "@R 9,999,999.99"
	//nTValor += nVlTot

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),Tamanho)
Endif

//Ordena o Vetor por ondem alfabética...
ASort(aRelExcel , , , {|x,y|x[5] < y[5]})
//Exibe o relatório em excel
DlgToExcel({{"ARRAY","Usuários do programa ADU","",aRelExcel}})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERADUINT ºAutor  ³Renato Peixoto      º Data ³  09/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina que irá gerar o contas médicas para o rateio ADU.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GERADUINT(aVetor,cTpProduto)

//Local aArray1  := {}
Local cQuery   := ""
Local cQuery2  := ""
Local cArqQry  := GetNextAlias()
Local cArqQry2 := GetNextAlias()

Private cCodEmpre := ""
Private cMatric   := ""
Private cTipreg   := ""
Private cDigito   := ""
Private cNomInt   := ""
Private nValProj  := nVlADU
Private cLocalBB8 := ""
Private cCodLoc   := ""
Private cDesLocBB8:= "" 
Private cBB8END   := ""
Private cBB8NR_END:= ""
Private cBB8COMEND:= ""
Private cBB8BAIRRO:= ""
Private cCodEsp   := ""
Private cCodPad   := "01"
Private cCodPro   := cProADU
Private aArray1   := {}
Private cTipProd  := cTpProduto

nContGeral++

//verifico se o registro ja foi gravado na tabela espelho do rateio ADU Integral (PB8)
DbSelectArea("PB8")
DbSetOrder(1)
If DbSeek(XFILIAL("PB8")+cCompet+cCodRDA+aVetor[nCOntGeral][4]+aVetor[nCOntGeral][5]+aVetor[nCOntGeral][6]+aVetor[nCOntGeral][11]+aVetor[nCOntGeral][12])
	Return .F.
EndIf

oProcess:SetRegua2(nCont)

aArray1 := {}//zero o vetor a cada loop
  
oProcess:IncRegua2("Inclusão de contas médicas para rateio "+cTipProd+"...")
cCodEmpre  := aVetor[nContGeral][5]
cMatric    := aVetor[nContGeral][6]
cTipReg    := aVetor[nContGeral][11]
cDigito    := aVetor[nContGeral][12]

cCodInt    := aVetor[nContGeral][4]
cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")
nValProj   := aVetor[nContGeral][9]
	
DbSelectArea("BAU")
DbSetOrder(1)
MSSeek(XFILIAL("BAU")+cCodRDA)
cLocalBB8  := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_CODLOC")
cCodLoc    := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_LOCAL")    
cDesLocBB8 := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_DESLOC")
cBB8END    := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_END")
cBB8NR_END := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_NR_END")
cBB8COMEND := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_COMEND")
cBB8Bairro := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_BAIRRO")
cCodEsp    := POSICIONE("BAX",1,XFILIAL("BAX")+cCodRDA+cCodInt+cLocalBB8,"BAX_CODESP")

If Empty(cLocalBB8)
	APMSGSTOP("Atenção, não existe código de localidade cadastrado para o RDA "+aVetor[nContGeral][8]+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
	Return .F.
EndIf

If Empty(cCodEsp)
	APMSGSTOP("Atenção, não existe especialidade cadastrada para o RDA "+aVetor[nContGeral][8]+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
	Return .F.
EndIf
		
aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
{"CODRDA",aVetor[nContGeral][8]},;
{"OPERDA",cCodInt},;
{"CODINT",cCodInt},;  //No BD5 é CODOPE
{"NOMINT",cNomInt},;
{"DATA",dDtEvento},; 
{"DATPRO",dDtEvento},; 
{"HORPRO",STRTRAN(substr(time(),1,5),":","")},;
{"NOMUSR",aVetor[nContGeral][7]},;
{"TELEFO",aVetor[nContGeral][13]},;
{"CODESP",cCodEsp},;
{"CODLOC",cLocalBB8},;
{"LOCAL",cCodLoc},;
{"SIGLA",BAU->BAU_SIGLCR},;
{"ESTCR",BAU->BAU_ESTCR},;
{"REGSOL",BAU->BAU_CONREG},;
{"CDPFSO",BAU->BAU_CODBB0},;
{"TPCON","1"},; 
{"SEXO",aVetor[nContGeral][14]},;
{"ANOPAG",SUBSTR(cCompet,3,4)},;
{"MESPAG",SUBSTR(cCompet,1,2)},;
{"MATANT",aVetor[nContGeral][15]},;    
{"MATVID",aVetor[nContGeral][16]},;
{"OPEUSR",aVetor[nContGeral][4]},;  //codint
{"TIPRDA",BAU->BAU_TIPPE},;
{"MATRIC",aVetor[nContGeral][6]},;  
{"TIPREG",aVetor[nContGeral][11]},;	   
{"CPFRDA",BAU->BAU_CPFCGC},; 
{"DIGITO",aVetor[nContGeral][12]},;
{"NOMRDA",BAU->BAU_NOME},;
{"NOMSOL",BAU->BAU_NOME},;
{"CODEMP",aVetor[nContGeral][5]},;  
{"CONEMP",aVetor[nContGeral][17]},;
{"VERCON",aVetor[nContGeral][18]},;
{"SUBCON",aVetor[nContGeral][19]},;	
{"VERSUB",aVetor[nContGeral][20]},;
{"DATDIG",DDATABASE},;
{"CODPAD","01"},;
{"CODPRO",cCodPro},;
{"TIPPRE",BAU->BAU_TIPPRE},;
{"DTDIG1",DDATABASE},;
{"YVLTAP", nValProj},;//nao aparece no BD5
{"VLRAPR", nValProj},;
{"QTDAPR", 1},;//nao aparece na bd5
{"QTDPRO", 1},;//nao aparece na BD5
{"BLOCPA", "1"},;  //bloqueia a cobranca da co-participacao     Na BD5 o campo é BLOPAG
{"DESBPF", "INFORMAR A DESCRICAO DO MOTIVO"},; 
{"TIPSAI", "5"},;
{"ORIMOV", "1"},; 
{"DESLOC", cDesLocBB8},;
{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
{"MOTBPF", "999"},; //    // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 é MOTBPG
{"TIPATE", "06"},; //Atendimento domiciliar, pois segundo o Dr. Jose Paulo é o que melhor se enquadra ao ADU.
{"CODPLA", cCodPla} }) //Código do Plano acrescentado por Renato Peixoto em 14/03/2011, pois estava gerando erros na BD6 e BD7.

U_GRVADUINT()
  	
oProcess:IncRegua2("Processando...")
  	
Return .T.



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GRVADUINT  ³ Autor ³ Renato Peixoto       ³ Data ³ 09/03/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grava dados de consulta em um PEG e GUIA                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function GRVADUINT(/*cNumAte,dDataBase*/)
Local I__f := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara variaveis da rotina...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nH := PLSAbreSem("GRVGUIADU.SMF")
LOCAL nFor
LOCAL nTmp
LOCAL nAux
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aColsAux
LOCAL cCampos
LOCAL aStruARQ    := {}

LOCAL aRetCal     := PLSXVLDCAL(dDtEvento,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
LOCAL cAnoBase    := aRetCal[4]
LOCAL cMesBase    := aRetCal[5]
LOCAL nHESP
LOCAL nStackSX8   := GetSx8Len()
Local aHeaderBE2  := {}

Local nQ          := 0

PRIVATE cOpeRDA   := cCodInt
//PRIVATE cCodRDA   := cCodRda já é declarada como private na função que chama esta
PRIVATE cNomRDA   := BAU->BAU_NOME
PRIVATE cTipRDA   := BAU->BAU_TIPPE
PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel
PRIVATE cNewPEG
PRIVATE aDadUSR   := PLSDADUSR(cCodInt+cCodEmp+cMatric+cTipreg+cdigito,"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado
Private aArea     := GetArea() //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"
Private aAreaBD6  := BD6->(GetArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG.SMF")
If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoBase+cMesBase+"211")) //2 - incluído eletronicamente; 1-em digitacao; 1- ativo
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0017'//"0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cCodRDA//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","02")//GetNewPar("MV_PLSTPGC","01")
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	//BCI->BCI_QTDGUI := 1
	BCI->BCI_VLRGUI := 0 //REVER
	BCI->BCI_DATREC := dDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	//BCI->BCI_VALDIG := 0 //REVER
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesBase
	BCI->BCI_ANO    := cAnoBase
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	BCI->(MsUnLock())
	
	While GetSx8Len() > nStackSX8
		BCI->( ConfirmSX8() )
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif
PLSFechaSem(nHESP,"PLSPEG.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do processo de gravacao das guias...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada ususario contido no array
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os Objetivos...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		//BIANCHINI - P12 - RETIRADO O IF. SE NA BCS A BD6 E BD7 FICAREM COM O TIPO 2 DÁ ERRO
		//NA INCLUSAO E VISUALIZAO DE GUIAS NO CONTAS MEDICAS
		//If aFiles[nFor,3] == "2"
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta RegToMemory...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//RegToMemory(cAliasAux,.T.,.F.)
				
			Copy (cAliasAux) To Memory Blank
			
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next
			
			PLUPTENC(cAliasAux,K_Incluir)
		//Else
		//	QOut("Gravacao de itens nao implementada") //
		//Endif
	Next
Next

//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("BE2"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "BE2")
	If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
		Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo
DbGoto(_Recno)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de gravacao dos dados...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cFunGRV)
	aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cCodPro,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
	cMacro := (AllTrim(cFunGRV)+"(aPar)")
	&(cMacro)
Endif

//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
DbSelectArea("BD6")
//BIANCHINI - AJUSTES P12 - SEM NENHUMA RAZAO SE USAVA UM DBSELECTAREA AQUI SEM SEEK E DESPONTEIRAVA A BD6, QUE POR SI SÓ JA VEM 
//DESPONTEIRADA DEPOIS DA GRAVAÇÃO PELO PLSA720
//TAMBÉM FEITO O TRATAMENTO DE CAMPOS QUE ERAM PREENCHIDOS NA P11 E NÃO MAIS NA P12
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD6",.F.)
	BD6->BD6_DESPRO := POSICIONE("BR8",1,XFILIAL("BR8")+'01'+cCodPro,"BR8_DESCRI")
	BD6->BD6_NIVEL  := '3'
	BD6->BD6_CODTAB := '008'
	BD6->BD6_ALIATB := 'BH0'
	BD6->BD6_YVLTAP := nValProj
	BD6->BD6_VLRAPR := nValProj
	BD6->BD6_VALORI := nValProj
	//BD6->BD6_QTDAPR := 1   //DESCONTINUADO P12
	BD6->BD6_QTDPRO := 1  
	BD6->BD6_BLOCPA := "1"
	BD6->BD6_DESBPF := "PAGAMENTO "+cTipProd //"ADU"
	BD6->BD6_MOTBPF := "501" 
Endif
//Forço a gravação do plano correto do usuário, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
//Alterado em 17/03/2011 por Renato Peixoto
If BD6->Bd6_CODPLA <> cCodPla
	BD6->BD6_CODPLA := cCodPla
EndIf
//Fim Alteração Renato Peixoto 
BD6->(MsUnlock())
//Forço a gravação do plano correto do usuário, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
//Alterado em 17/03/2011 por Renato Peixoto
DbSelectArea("BD7")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD7",.F.)
	//BIANCHINI - 04/05/2019 - AJUSTES P12 - CAMPOS QUE ERAM PREENCHIDOS NA P11 E NÃO MAIS NA P12
	BD7->BD7_CODUNM := 'REA'
	BD7->BD7_FATMUL := 1
	BD7->BD7_REFTDE := nValProj
	BD7->BD7_UNITDE := 'R$'
	BD7->BD7_PROBD7 := '1'
	BD7->BD7_VALORI := nValProj
	//FIM 
	If BD7->BD7_CODPLA <> cCodPla
		BD7->BD7_CODPLA := cCodPla
	EndIf
	MsUnlock()
Endif
//Fim alteração Renato Peixoto. 
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Muda a fase da guia...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")

If !Empty(BCL->BCL_FUNMFS)
     /*LOCAL cAlias     := aPar[1]
	LOCAL cTipo      := aPar[2]
	LOCAL cCodOpe    := aPar[3]
	LOCAL cTipoGuia  := aPar[4]
	LOCAL cCpoFase   := aPar[5]
	LOCAL cCodLDP    := aPar[6]
	LOCAL cCodPEG    := aPar[7]
	LOCAL cGuiRel    := aPar[8]
	LOCAL lAutori    := aPar[09]
	LOCAL dDatPro    := aPar[10]
	LOCAL lHelp      := aPar[11]
	LOCAL cAliasPri  := aPar[16]*/
     
     
    //Leonardo Portella - 23/12/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
    aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}
    //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}
    
    //Leonardo Portella - 23/12/13 - Fim
    
    cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
    aRetAux := &(cMacro) 
    
    //BIANCHINI - 04/05/2019 - AJUSTES P12 - LIMPANDO A GLOSA EM BD6 E BD7 NA MARRA. GLOSANDO 100%.ESSE PRESTADOR NÃO PODE USAR O PARAMETRO
    //NOVO(BAU_TPCALC) PARA PAGAR VALORES APRESENTADOS VISTO QUE ELE APRESENTA OUTRAS GUIAS EM DIFERENTES LOCAIS, CODIGOS E VALORES
    //O RATEIO NÃO PODE GLOSAR
    DbSelectArea("BD6")
	DbSetOrder(1)
	If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
		RecLock("BD6",.F.)
		BD6->BD6_VLRGLO := 0
		BD6->(MsUnlock())
	Endif

	DbSelectArea("BD7")
	DbSetOrder(1)
	If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
		RecLock("BD7",.F.)
		BD7->BD7_VLRGLO := 0
		BD7->(MsUnlock())
	Endif
     
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza transacao fisica...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSFechaSem(nH,"GRVGUIADU.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea) //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Renato Peixoto      º Data ³  08/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}
//mv_par04 pode ser retirado
Aadd(aRegs,{cPerg,"01","Data Inicial?              ","","","MV_CH1","D",08,0,0,"G","           ","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data Final?                ","","","MV_CH2","D",08,0,0,"G","           ","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Diretorio do Arquivo?      ","","","MV_CH3","C",60,0,0,"G","           ","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
Aadd(aRegs,{cPerg,"04","Tipos de Usuarios?         ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Envia todos","","","","","Env.Tit.C/Dep","","","","","Envia so Titular","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Ano Competencia?           ","","","MV_CH5","C",04,0,0,"G","           ","Mv_Par05","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Mes Competencia?           ","","","MV_CH6","C",02,0,0,"G","PlsVldMes()","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Gera o Arquivo?            ","","","MV_CH7","N",01,0,0,"C","           ","Mv_Par07","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"09","Informa Grupo Empresa?     ","","","MV_CH9","N",01,0,0,"C","           ","Mv_Par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"10","Gera Lanc. Debito/Credito? ","","","MV_CHA","N",01,0,0,"C","           ","Mv_Par10","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"10","Qual a Localidade?         ","","","MV_CHA","N",01,0,0,"C","           ","Mv_Par10","Rio de Janeiro","","","","","São Paulo","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Data do Evento:            ","","","MV_CH8","D",08,0,0,"G","           ","Mv_Par08","","","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return(.T.)
