#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

Static CRLF := chr(13) + chr(10)

///*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³GERAADU    º Autor ³ Lzio Tavares       º Data ³  30/04/2008 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ Gera arquivo texto dos usuarios que possuem atendimento     º±±
//±±º          ³ domiciliar (Rateio para BEM). Conforme parametros           º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP6 IDE                                                     º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
///*/

User Function GERAADU()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oGeraTxt
Private cPerg       := "PLSREO"
Private cString     := "BA1"
Private nlinha      := 0
Private nlinha1     := 0
Private nTamLin, cLin, cCpo
Private lAbortPrint := .F.
private xUsu        := {}
private aPlano      := {}
private aExcPlano := {}
private aCarGer     := {}
private aExcCarGer := {}
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
Private Tamanho     := "P"
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
Private Limite      := 80
Private cCodEmp     := GETNEWPAR("MV_YCODADU","164")
Private nVlADU      := GETNEWPAR("MV_YVLADU",2.09)
Private nVlVDS      := GETNEWPAR("MV_YVLVDS",60.00)
Private nVlCGER     := GETNEWPAR("MV_YVLCGER",15.40)
Private cRDASP      := GETNEWPAR("MV_YRDASP","106445")
Private cRDARJ      := GETNEWPAR("MV_YRDARJ","126004")

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

//Leonardo Portella - 06/07/11 - Inicio
Pergunte(cPerg,.F.)
                
nOpca := 0

aSays := {}
aAdd(aSays, 'Este programa ira gerar um arquivo texto, conforme os parame-' )
aAdd(aSays, 'tros definidos pelo usuario, com os registros do arquivo de'   )
aAdd(aSays, 'BA1')
           
aButtons := {}
aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )
 
FormBatch( OemToAnsi("Gera‡„o de Arquivo Texto"), aSays, aButtons,, 230, 400 )

If nOpca == 1
	OkGeraTxt()
EndIf

/*
@ 200,1 TO 390,430 DIALOG oGeraTxt TITLE OemToAnsi("Gera‡„o de Arquivo Texto")
@ 02,10 TO 90,200 //faz as bordas internas
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " BA1                                                           "

@ 60,108 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 60,138 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 60,168 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered
*/

//Leonardo Portella - 06/07/11 - Fim

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

Local cDirGrava := GetNewPar("MV_PLSDIRC","C:\")
Local cDirPls := ""
Private nHdl    := 0   //Local
Private cArquivo := space(0)
Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(mv_par01) .or. Empty(mv_par02) .or. Empty(mv_par04) ;   //.or. Empty(mv_par03)
	.or. Empty(mv_par05) .or. Empty(mv_par06) .or. Empty(mv_par07) .or. Empty(mv_par08)
	MsgAlert("Informe os parametros .....")
	//Close(oGeraTxt)
	Return
Endif

If mv_par04 = 1
	cTipo := "S"
ElseIf mv_par04 = 2
	cTipo := "P"
ElseIf mv_par04 = 3
	cTipo := "F"
ElseIf mv_par04 = 4
	cTipo := "A"
EndIf

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
//If MV_PAR11 = 1
Private cArquivo := cDirGrava + "T"+ Alltrim(cCodEmp) + "0001.TXT"   //+Alltrim(mv_par03) + cTipo +_data  + "." + "TXT"
//Else
//	Private cArquivo := cDirGrava + "T0000000.TXT"   //Arquivo dos usuarios da regiao de Sao Paulo
//EndIf

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

//Leonardo Portella - 06/07/11
Processa({||ProcTXT() }, "Processando...")
//MsAguarde({|| Processa() }, "Processando...", "", .T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ ProcTXT  º Autor ³ Luzio Tavares      º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ProcTXT()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local dDatIni    := CtoD("  /  /    ")
Local dDtInicial := CtoD("  /  /    ")
Local aCriticas  := {}
Local lDescontar := .F.
Local cCodPla  := Space(0)
Local cCodPla1 := Space(0)
Local cSql1 := Space(0)
Local cSql2 := Space(0)

Private nContador := 0
Private nIdade    := 0

ProcRegua(0)

For i := 1 to 5
	IncProc('Processando...')
Next
//MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})

/*
cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, BF4_DATBAS, BF4_DATBLO, "
cSQL += " Decode(Sign(IDADE_S(BA1_DATNAS)-65),-1,'0023','0024') PROJ, BA1.* "
cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "+RetSQLName("BA3") + " BA3, "
cSQL += RetSQLName("BF4") +" BF4, "+RetSQLName("BA0") +" BA0 "
cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "
cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "
cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "
cSQL += " BF4_FILIAL = '"+xFilial("BF4")+"'  AND "
cSQL += " BA0_FILIAL = '"+xFilial("BA0")+"'  AND "
cSQL += " BA1.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3.D_E_L_E_T_ = ' '  AND "
cSQL += " BG9.D_E_L_E_T_ = ' '  AND "
cSQL += " BF4.D_E_L_E_T_ = ' '  AND "
cSQL += " BA0.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3_CODINT = BA1_CODINT AND "
cSQL += " BA3_CODEMP = BA1_CODEMP AND "
cSQL += " BA3_MATRIC = BA1_MATRIC AND "
cSQL += " (BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+DtoS(mv_par02)+"') AND  "
cSQL += " BA1_CODEMP NOT IN ('0006','0004','0009','0010') AND "
cSQL += " BA1_DATINC <= '"+DtoS(mv_par02)+"' AND "
cSQL += " BTS_MATVID = BA1_MATVID AND "
cSQL += " (BA1_ESTADO = 'RJ' OR "
cSQL += " (BA1_ESTADO = 'SP' AND BA1_CODMUN IN ('3534401','3518800','3547809','3548708','3548708','3548807','3513801','3550308'))) "
cSQL += " AND BG9_CODIGO = BA1_CODEMP "
cSQL += " AND BG9_HSPEMP = ' ' "

cSQL += " AND BF4_CODPRO = '0023' "
cSQL += " AND BF4_CODINT = BA1_CODINT "
cSQL += " AND BF4_CODEMP = BA1_CODEMP "
cSQL += " AND BF4_MATRIC = BA1_MATRIC "
cSQL += " AND BF4_TIPREG = BA1_TIPREG "
cSQL += " AND BF4_DATBAS <= '" + DTOS(mv_par02)+ "' "
cSQL += " AND (BF4_DATBLO = ' ' OR BF4_DATBLO > '" + DTOS(mv_par02)+ "') "
cSQL += " AND BA0_CODIDE||BA0_CODINT = BA1_OPEDES "
cSQL += " AND BA0_EST = BA1_ESTADO "
*/

cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, "
cSQL += " Decode(Sign(IDADE_S(BA1_DATNAS)-65),-1,'0023','0024') PROJ, BA1.* "
cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "
cSQL += RetSQLName("BA3") + " BA3, "+RetSQLName("BA0") +" BA0 "
cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "
cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "
cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "
cSQL += " BA0_FILIAL = '"+xFilial("BA0")+"'  AND "
cSQL += " BA1.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3.D_E_L_E_T_ = ' '  AND "
cSQL += " BG9.D_E_L_E_T_ = ' '  AND "
cSQL += " BA0.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3_CODINT = BA1_CODINT AND "
cSQL += " BA3_CODEMP = BA1_CODEMP AND "
cSQL += " BA3_MATRIC = BA1_MATRIC AND "
cSQL += " (BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+DtoS(mv_par02)+"') AND  "
cSQL += " BA1_CODEMP NOT IN ('0006','0004','0009','0010') AND "
cSQL += " BA1_DATINC <= '"+DtoS(mv_par02)+"' AND "
cSQL += " BTS_MATVID = BA1_MATVID AND "
cSQL += " (BA1_ESTADO = 'RJ' OR "
cSQL += " (BA1_ESTADO = 'SP' AND BA1_CODMUN IN ('3534401','3518800','3547809','3548708','3548708','3548807','3513801','3550308'))) "
cSQL += " AND BG9_CODIGO = BA1_CODEMP "
cSQL += " AND BG9_HSPEMP = ' ' "

cSQL += " AND BA0_CODIDE||BA0_CODINT = BA1_OPEDES "
cSQL += " AND BA0_EST = BA1_ESTADO "

cSQL += " ORDER BY BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"

//memowrit("C:\GERAADU_1.SQL",cSQL)

PLSQuery(cSQL,"TF4")

cCodRDA := cRDASP
cCodRDA := cRDARJ

//*****************************************************************************************************************
// Seleciona beneficiarios para o vigilancia. Os 600 maiores custos.
// Parametros:
// UF = RJ
//*******************************************************************************************************************

IncProc("Selecionando registros para VDS...")
//MsgRun("Selecionando Registros para VDS de acordo com a sinistralidade de cada usuario...",,{|| ,CLR_HBLUE})

dDtInicial := CtoD(substr(DtoC(dDataBase),1,6)+"/"+alltrim(Str(Val(Substr(DtoS(dDataBase),1,4))-60)))

cSQL := "SELECT SUM(BD7_VLRPAG) SINISTRALIDADE, BD7_OPEUSR, BD7_CODEMP, BD7_MATRIC, BD7_TIPREG, DECODE(Trim(BA1_CODPLA),null,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA, BA1.BA1_CODINT, BA1.BA1_VERSAO, "
cSQL += " BA1.R_E_C_N_O_ AS BA1RECNO "
cSQL += "FROM  " + RetSQLName("BD7") + " BD7, "+ RetSQLName("BA1")+ " BA1, "+ RetSQLName("BA3")+ " BA3, "+ RetSQLName("BG9") + " BG9, "+ RetSQLName("BA0") + " BA0 "
cSQL += "WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND "
cSQL += "BA1_FILIAL = '"+xFilial("BA1")+"' AND "
cSQL += "BA3_FILIAL = '"+xFilial("BA3")+"' AND "
cSQL += "BG9_FILIAL = '"+xFilial("BG9")+"' AND "
cSQL += "BA0_FILIAL = '"+xFilial("BA0")+"' AND "
cSQL += "BD7.D_E_L_E_T_ = ' ' AND "
cSQL += "BA1.D_E_L_E_T_ = ' ' AND "
cSQL += "BA3.D_E_L_E_T_ = ' ' AND "
cSQL += "BG9.D_E_L_E_T_ = ' ' AND "
cSQL += "BA0.D_E_L_E_T_ = ' ' AND "
cSQL += "BD7_CODOPE = '0001' AND "
cSQL += "BD7_FASE   = '4' AND "   //-- Somente Faturado
cSQL += "BD7_SITUAC = '1' AND "   //-- Ativo
cSQL += "BD7_OPELOT <> '  ' AND "
cSQL += "BD7_NUMLOT <> '  ' AND "
cSQL += "BA1_DATBLO = ' ' AND "
cSQL += "BA1_MOTBLO = ' ' AND "
cSQL += "BA1_CODEMP NOT IN ('0006','0004','0009','0010') AND "
cSQL += "BA1_FILIAL = BD7_FILIAL AND "
cSQL += "BA1_CODINT = BD7_OPEUSR AND "
cSQL += "BA1_CODEMP = BD7_CODEMP AND "
cSQL += "BA1_MATRIC = BD7_MATRIC AND "
cSQL += "BA1_TIPREG = BD7_TIPREG AND "
cSQL += "BA1_DATNAS < '"+DtoS(dDtInicial)+"' AND "

cSQL += "BA1_ESTADO = 'RJ' AND "
cSQL += "BA1_CODMUN IN ('3304557','3303302','3304904','3300456','3301702','3302270','3303203','3303500','3304144','3305109','421954') AND "

cSQL += "BA3_CODINT = BA1_CODINT AND "
cSQL += "BA3_CODEMP = BA1_CODEMP AND "
cSQL += "BA3_MATRIC = BA1_MATRIC AND "

cSQL += "BG9_CODIGO = BA1_CODEMP AND "
cSQL += "BG9_HSPEMP = ' ' AND "

cSQL += "BA0_CODIDE||BA0_CODINT = BA1_OPEDES AND "
cSQL += "BA0_EST = BA1_ESTADO "

//Debug
//cSQL += " AND ROWNUM < 20 "

cSQL += "GROUP BY BD7_OPEUSR,BD7_CODEMP, BD7_MATRIC, BD7_TIPREG, DECODE(TRIM(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA), BA1.BA1_CODINT, BA1.BA1_VERSAO, BA1.R_E_C_N_O_ "
cSQL += "ORDER BY SINISTRALIDADE DESC, BD7_OPEUSR, BD7_CODEMP, BD7_MATRIC, BD7_TIPREG "

//memowrit("C:\GERAADU_3.SQL",cSQL)
PLSQuery(cSQL,"VDS")

DbSelectArea("TF4")
TF4->(Dbgotop())
                
nCont := 0

COUNT TO nCont 

TF4->(Dbgotop()) 

ProcRegua(nCont)

nTotal := 0

While !TF4->(Eof())
	
	IncProc("Processando usuário matr. " + TF4->BA1_CODINT + '.' + TF4->BA1_CODEMP + '.' + TF4->BA1_MATRIC + '.' + TF4->BA1_TIPREG + '-' + TF4->BA1_DIGITO )
	//MsProcTxt("Processando Usuario..."+ TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		Exit
	Endif
	
	//verifcar no parametro qual o tipo de arquivo vou gerar
	// mv_par05 = 1 todos os usuarios validos
	
	// mv_par05 = 2 somente titular se houver dependente valido
	// mv_par05 = 3 todos os titulares
	If mv_par05 = 1  //todos os usuarios validos
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
	ElseIf mv_par05 = 2  //2 somente titular se houver dependente valido
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
	Else  //3 todos os titulares
		If TF4->BA1_TIPREG <> "00"
			TF4->(DbSkip())
			Loop
		Endif
	EndIf
	
	If !Empty(TF4->BA1_CODPLA)
		cCodPla1 := TF4->(BA1_CODPLA+BA1_VERSAO)
		cCodPla  := TF4->(BA1_CODPLA)
	Else
		cCodPla1 := TF4->(BA3_CODPLA+BA3_VERSAO)
		cCodPla  := TF4->(BA3_CODPLA)
	EndIf
	
	dDatIni := CtoD("  /  /    ")
	DbSelectArea("BT3")
	BT3->(DbSetOrder(1))
	If BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla1+"0023")) //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA
		If BT3->BT3_TIPVIN == '0'
			//Pesquisa opcional no nivel do usuario
			BF4->(DbSetOrder(1)) //BF4_FILIAL + BF4_CODINT + BF4_CODEMP + BF4_MATRIC + BF4_TIPREG + BF4_CODPRO
			If !BF4->(DbSeek(xFilial("BF4")+TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+"0023")))
				
				cSql2 := "SELECT * "
				cSql2 += " FROM " + RetSQLName("BA3") +" BA3 "
				cSql2 += " WHERE BA3_FILIAL = '"+xFilial("BA3")+"' AND "
				cSql2 += " BA3_CODINT = '"+TF4->BA1_CODINT+"' AND "
				cSql2 += " BA3_CODEMP = '"+TF4->BA1_CODEMP+"' AND "
				cSql2 += " BA3_CONEMP=  '"+TF4->BA1_CONEMP+"' AND "
				cSql2 += " BA3_VERCON = '"+TF4->BA1_VERCON+"' AND "
				cSql2 += " BA3_SUBCON = '"+TF4->BA1_SUBCON+"' AND "
				cSql2 += " BA3_VERSUB = '"+TF4->BA1_VERSUB+"' AND "
				cSql2 += " BA3_MATRIC = '"+TF4->BA1_MATRIC+"' AND "
				cSql2 += " BA3_CODPLA = '"+cCodPla+"' AND "
				cSql2 += "D_E_L_E_T_ = ' '"
				PLSQuery(cSQL2,"TBA3")
				DbSelectArea("TBA3")
				TBA3->(DbGoTop())
				If TBA3->(EOF())
					TBA3->(DbCloseArea("TBA3"))
					TF4->(DbSkip())
					Loop
				Endif
				TBA3->(DbCloseArea("TBA3"))
				
				//Pesquisa opcional no nivel da para verificar se o produto eh vinculado
				BF1->(DbSetOrder(1))   //BF1_FILIAL + BF1_CODINT + BF1_CODEMP + BF1_MATRIC + BF1_CODPRO
				If BF1->(DbSeek(xFilial("BF1")+TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+"0023")))
					If BF1->BF1_TIPVIN = '0'  //Nao eh vinculado
						TF4->(DbSkip())
						Loop
					ElseIf !DTOS(BF1->BF1_DATBAS) <= DTOS(mv_par02) .or. !Empty(BF1->BF1_DATBLO) .or. !Empty(BF1->BF1_MOTBLO)
						TF4->(DbSkip())
						Loop
					EndIf
				Else
					TF4->(DbSkip())
					Loop
				EndIf
				dDatIni := BF1->BF1_DATBAS
			Else
				If !DTOS(BF4->BF4_DATBAS) <= DTOS(mv_par02) .or. !Empty(BF4->BF4_DATBLO) .or. !Empty(BF4->BF4_MOTBLO)
					TF4->(DbSkip())
					Loop
				EndIf
				dDatIni := BF4->BF4_DATBAS
			EndIf
		EndIf
	Else
		TF4->(DbSkip())
		Loop
	EndIf
	
	
	//	dDatIni := BF4_DATBAS     //CtoD("  /  /    ")
	
	cDesPla := "Produto nao Identificado"
	BI3->(DbSetOrder(1))  //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO = "  00010001001"
	If BI3->(DbSeek(xFilial("BI3")+TF4->BA1_CODINT+cCodPla1))
		cDesPla := BI3->BI3_DESCRI
	EndIf
	
	dDtInicial := CtoD(substr(DtoC(dDataBase),1,6)+"/"+alltrim(Str(Val(Substr(DtoS(dDataBase),1,4))-65)))
	
	nIdade := Calc_Idade(mv_par02,TF4->BA1_DATNAS)
	//	nIdade := Calc_Idade(dDataBase,TF4->BA1_DATNAS)
	If nIdade < 65
		//		If DtoS(TF4->BA1_DATNAS) > DtoS(dDtInicial)
		cCodBEM := "0023"  //Iif(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+;   //"0023"+;   // Codigo de Grupo de Produtos BEM
		
		cCodADU := Space(03)
		//Pesquisa qual o codigo de lancamento de debito e credito do produto
		DbSelectArea("BT3")
		BT3->(DbSetOrder(1))  //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA = "  000100010010023001"
		If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0010023"))
			//Opcional no produto sem o codigo de lancamento
			aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		ElseIf Empty(BT3_YCDADU)
			aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		Else
			cCodADU := BT3->BT3_YCDADU
		EndIf
		
		nPos := aScan(aPlano, {|x| x[1] == cCodPla})
		
		If nPos = 0
			Aadd(aPlano,{cCodPla,cDesPla,1,cCodADU})
		Else
			aPlano[nPos,3] := aPlano[nPos,3]+1
		EndIf
	Else
		cCodBEM := "0024"
		cCdCGER := Space(03)
		
		DbSelectArea("BT3")
		BT3->(DbSetOrder(1))
		//Pesquisa qual o codigo de lancamento de debito e credito do produto
		If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0010023"))
			aadd(aCriticas,{"BT3","Produto CARTEIRA GERENCIADA sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla1+"]"})
		ElseIf Empty(BT3_YCDGER)
			aadd(aCriticas,{"BT3","Produto CARTEIRA GERENCIADA sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla1+"]"})
		Else
			cCdCGER := BT3->BT3_YCDGER
		EndIf
		
		nPos := aScan(aCARGER, {|x| x[1] == cCodPla})
		If nPos = 0
			Aadd(aCARGER,{cCodPla,cDesPla,1,cCdCGer})
		Else
			aCARGER[nPos,3] := aCARGER[nPos,3]+1
		EndIf
	EndIf
	
	//	If MV_PAR08 == 1
	
	cUsu :=(TF4->BA1_CODINT+TF4->BA1_CODEMP+TF4->BA1_MATRIC+TF4->BA1_TIPREG+TF4->BA1_DIGITO)
	
	//Leonardo Portella - 05/07/11 - Inicio
	//Gravacao do projeto ao qual pertence o usuario com 50 ou mais anos 
	
	cGrupo1 := Space(4)
	cGrupo2 := Space(4)
		
	If nIdade >= 50
	
		cAliasTmp := GetNextAlias()
	
 		cQuery := "SELECT NVL(RETORNA_NUCLEO_MS(BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,'20110706'),' ') AGENCIA" 	+ CRLF
 		cQuery += "FROM " + RetSqlName('BF4') 																			+ CRLF   
 		cQuery += "WHERE D_E_L_E_T_ = ' '" 																				+ CRLF 
 		cQuery += "		AND BF4_FILIAL = '" + xFilial('BF4') + "'" 														+ CRLF
 		cQuery += "		AND BF4_CODINT = '" + TF4->BA1_CODINT + "'"    													+ CRLF
 		cQuery += "		AND BF4_CODEMP = '" + TF4->BA1_CODEMP + "'" 													+ CRLF
 		cQuery += "		AND BF4_MATRIC = '" + TF4->BA1_MATRIC + "'" 													+ CRLF
 		cQuery += "		AND BF4_TIPREG = '" + TF4->BA1_TIPREG + "'" 													+ CRLF
 		cQuery += "		AND BF4_MOTBLO = ' '" 		   																	+ CRLF
 		cQuery += "		AND (BF4_DATBLO = ' ' OR BF4_DATBLO > '" + DtoS(MV_PAR02) + "')"								+ CRLF
		cQuery += "		AND BF4_MOTBLO = ' '"																			+ CRLF
	
 		TcQuery cQuery New Alias cAliasTmp
 		
 		If allTrim(cAliasTmp->(AGENCIA)) $ '1|2|3'
			cGrupo1 := '3547' //Codigo BEM que identifica que o beneficiario possui mais de 49 anos e esta em uma das agencia (TIJUCA, NITEROI ou BANGU)
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
		Space(10)+;//Pessoa Juridica 
		Space(40)+;//Nome da empresa do associado
		PadR(Alltrim(TF4->BA1_ENDERE),50)+;//Endereco
		PadR(Alltrim(TF4->BA1_NR_END),5)+;//Numero
		PadR(Alltrim(TF4->BA1_COMEND),10)+;//Complemento
		PadR(Alltrim(TF4->BA1_BAIRRO),30)+;//Bairro
		PadR(Alltrim(TF4->BA1_CEPUSR),8)+;//CEP
		PadR(Alltrim(TF4->BA1_DDD)+Alltrim(TF4->BA1_TELEFO),15)+;//Telefone 1
		Space(15)+;//Telefone 2
		Space(15)+;//Telefone 3 //Substr(Alltrim(TF4->BA1_MATANT),1,20)+;//Matricula anterior //Space(02)+;//Motivo da baixa //Space(10)+;//Codigo do convenio
		"I";//Operacao - I = Inclusao; E = Exclusao; A = Alteracao
		})
	
	/*
	Aadd(xUsu,{"00000000"+;
	Padr(cUsu,20)+;
	Padr(cCodPla,10)+;     //PADR(alltrim(TF4->BA1_CODPLA),10)+;
	SPACE(10)+;
	PADR(cDesPla,20)+;   //Descricao do Produto
	SPACE(10)+; //Iif(!Empty(TF4->BF4_DATBAS),DtoS(TF4->BF4_DATBAS),DtoS(TF4->BA1_DATINC))+;   //Data Inicio Opcional
	Iif(!Empty(dDatIni),DtoS(dDatIni),DtoS(TF4->BA1_DATINC))+;   //Data Inicio Opcional
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
	Iif(TF4->BG9_TIPO="1","0","1")+;   //			   	  Iif(TF4->BG9_TIPO="1","F","J")+;
	DtoS(TF4->BA1_DATBLO)+;   //Iif(TF4->BA1_DATBLO > TF4->BA1_YDTLIM, DtoS(TF4->BA1_DATBLO), DtoS(TF4->BA1_YDTLIM))+; // Somente se a data limite for superior a data do parametro
	Iif(cCodBEM == "0023",Iif(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+Space(04),Space(04)+"0024")+;     //"0023"+;   // Codigo de Grupo de Produtos BEM
	Space(04)+;
	Space(04)+;
	Space(04)+;
	Space(10)+;    //Pessoa Juridica //			   	Space(40)+;    //Nome Empresa
	Space(0)+;    //Iif(MV_PAR09=1,Padr(Alltrim(TF4->BG9_DESCRI),40),Space(0))+;
	Padr(Alltrim(TF4->BA1_ENDERE),50)+;
	Padr(Alltrim(TF4->BA1_NR_END),5)+;
	Padr(Alltrim(TF4->BA1_COMEND),10)+;
	Padr(Alltrim(TF4->BA1_BAIRRO),30)+;
	Padr(Alltrim(TF4->BA1_CEPUSR),8)+;
	Padr(Alltrim(TF4->BA1_DDD)+Alltrim(TF4->BA1_TELEFO),15)+;
	Space(15)+;    //
	Space(15)+;    //			   	Substr(Alltrim(TF4->BA1_MATANT),1,20)+	Space(02)+Space(10)+;
	"I"})
	*/
	
	//Leonardo Portella - 05/07/11 - Fim
	
	TF4->(DbSkip())
Enddo

TF4->(DbCloseArea("TF4"))

DbSelectArea("VDS")
VDS->(Dbgotop())

nCont := 0

COUNT TO nCont

ProcRegua(nCont)

cTot 	:= allTrim(Transform(nCont, "@E 999,999,999,999"))
nCont 	:= 0

VDS->(Dbgotop())

nContador := 0

While !VDS->(Eof())                                       

	IncProc('Processando ' + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot)
	
	If !(VDS->BA1_CODPLA $ ('0001_0003_0005_0006_0007'))
		VDS->(DbSkip())
		Loop
	EndIf
	
	If VDS->BA1_CODPLA $ ('0002_0004_0008')
		VDS->(DbSkip())
		Loop
	EndIf
	
	cUsu := VDS->BD7_OPEUSR+VDS->BD7_CODEMP+VDS->BD7_MATRIC+VDS->BD7_TIPREG
	
	cSQL := "SELECT * "
	cSQL += " FROM "  + RetSQLName("BF4")
	cSQL += " WHERE BF4_FILIAL = '" + xFilial("BF4") + "' AND "
	cSQL += " D_E_L_E_T_ <> '*' AND "
	cSQL += " BF4_CODPRO IN ('0024','0038') AND "   // O usuario nao participa do AED
	cSQL += " (BF4_DATBLO = ' ' OR BF4_DATBLO > '"+DtoS(MV_PAR02)+"') AND "
	cSQL += " BF4_MOTBLO = ' ' AND "
	cSQL += " BF4_CODINT = '"+VDS->BD7_OPEUSR+"' AND "
	cSQL += " BF4_CODEMP = '"+VDS->BD7_CODEMP+"' AND "
	cSQL += " BF4_MATRIC = '"+VDS->BD7_MATRIC+"' AND "
	cSQL += " BF4_TIPREG = '"+VDS->BD7_TIPREG+"' "

	PLSQuery(cSQL,"TBF4")

	DbSelectArea("TBF4")

	If !TBF4->(EOF())  //É porque existe o opcional AED para o usuario
		TBF4->(DbCloseArea("TBF4"))
		DbSelectArea("VDS")
		VDS->(DbSkip())
		Loop
	Endif

	TBF4->(DbCloseArea("TBF4"))
	   
	//MsProcTxt("Processando Usuario VDS..."+ cUsu)
	
	DbSelectArea("VDS")
	
	If !Empty(VDS->BA1_CODPLA)
		cCodPla1 := VDS->(BA1_CODPLA+BA1_VERSAO)
		cCodPla  := VDS->(BA1_CODPLA)
	Else
		cCodPla1 := VDS->(BA3_CODPLA+BA3_VERSAO)
		cCodPla  := VDS->(BA3_CODPLA)
	EndIf
	
	dDatIni := CtoD("  /  /    ")
	
	cDesPla := "Produto nao Identificado"
	
	BI3->(DbSetOrder(1))  //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO = "  00010001001"
	
	If BI3->(DbSeek(xFilial("BI3")+VDS->BA1_CODINT+cCodPla1))
		cDesPla := BI3->BI3_DESCRI
	EndIf
	
	cCodVDS := Space(03)
	
	nPos := aScan(xUsu, {|x| substr(x[1],9,16) == cUsu})
	
	If nPos <> 0
		cLin := xUsu[nPos,1]
		cLin := Stuff(cLin,254,04,"0025")
		xUsu[nPos,1] := cLin
		
		cCodPla := substr(xUsu[nPos,1],29,4)
		
		cDesPla := Space(03)
		nPos := aScan(aPlano, {|x| x[1] == cCodPla })
		If nPos != 0
			cDesPla := aPlano[nPos,2]
		EndIf
		
		//Pesquisa opcional no nivel do usuario
		DbSelectArea("BT3")
	
		BT3->(DbSetOrder(1))     //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA = "  000100010010023001"
	
		//Pesquisa qual o codigo de lancamento de debito e credito do produto
		If !BT3->(DbSeek(xFilial("BT3")+VDS->BD7_OPEUSR+cCodPla+"0010023"))
			//Opcional no produto sem o codigo de lancamento
			aadd(aCriticas,{"BT3","Produto VDS sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		ElseIf Empty(BT3_YCDVDS)
			aadd(aCriticas,{"BT3","Produto VDS sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		Else
			cCodVDS := BT3->BT3_YCDVDS
		EndIf
		
		nPos := aScan(aVDS, {|x| x[1] == cCodPla})
	
		If nPos = 0
			Aadd(aVDS,{cCodPla,cDesPla,1,cCodVDS})
		Else
			aVDS[nPos,3] := aVDS[nPos,3]+1
		EndIf
	
		nContador += 1
	
	Else
	
		//Pesquisa opcional no nivel do usuario
		DbSelectArea("BT3")
	
		BT3->(DbSetOrder(1))     //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA = "  000100010010023001"
	
		If !BT3->(DbSeek(xFilial("BT3")+VDS->BD7_OPEUSR+cCodPla+"0010023"))
			//Opcional no produto sem o codigo de lancamento
			aadd(aCriticas,{"BT3","Produto VDS sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		ElseIf Empty(BT3_YCDVDS)
			aadd(aCriticas,{"BT3","Produto VDS sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		Else
			cCodVDS := BT3->BT3_YCDVDS
		EndIf
		
		nPos := aScan(aVDS, {|x| x[1] == cCodPla })
	
		If nPos = 0
			Aadd(aVDS,{cCodPla,cDesPla,1,cCodVDS})
		Else
			aVDS[nPos,3] := aVDS[nPos,3]+1
		EndIf
		
		BA1->(DbGoTo(VDS->BA1RECNO))
		
		cUsu :=(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BA1->BA1_DIGITO)
		
		//Pesquisa opcional no nivel do usuario
		DbSelectArea("BG9")
	
		BG9->(DbSetOrder(1))
		BG9->(DbSeek(xFilial("BG9")+BA1->(BA1_CODINT+BA1_CODEMP)))
		
		//Pesquisa opcional no nivel do usuario
		DbSelectArea("BTS")
	
		BTS->(DbSetOrder(1))
		BTS->(DbSeek(xFilial("BTS")+BA1->BA1_MATVID))
		
		//Leonardo Portella - 06/07/11 - Inicio
		//Gravacao do projeto ao qual pertence o usuario com 50 ou mais anos
		
		cGrupo1 := Space(4)
		
		If Calc_Idade(mv_par02,BA1->BA1_DATNAS) >= 50
	
			cAliasTmp := GetNextAlias()
		
	 		cQuery := "SELECT NVL(RETORNA_NUCLEO_MS(BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,'20110706'),' ') AGENCIA" 	+ CRLF
	 		cQuery += "FROM " + RetSqlName('BF4') 																			+ CRLF   
	 		cQuery += "WHERE D_E_L_E_T_ = ' '" 																				+ CRLF 
	 		cQuery += "		AND BF4_FILIAL = '" + xFilial('BF4') + "'" 														+ CRLF
	 		cQuery += "		AND BF4_CODINT = '" + BA1->BA1_CODINT + "'"    													+ CRLF
	 		cQuery += "		AND BF4_CODEMP = '" + BA1->BA1_CODEMP + "'" 													+ CRLF
	 		cQuery += "		AND BF4_MATRIC = '" + BA1->BA1_MATRIC + "'" 													+ CRLF
	 		cQuery += "		AND BF4_TIPREG = '" + BA1->BA1_TIPREG + "'" 													+ CRLF
	 		cQuery += "		AND BF4_MOTBLO = ' '" 		   																	+ CRLF
	 		cQuery += "		AND (BF4_DATBLO = ' ' OR BF4_DATBLO > '" + DtoS(MV_PAR02) + "')"								+ CRLF
			cQuery += "		AND BF4_MOTBLO = ' '"																			+ CRLF
	
	 		TcQuery cQuery New Alias cAliasTmp
	 		
	 		If allTrim(cAliasTmp->(AGENCIA)) $ '1|2|3'
				cGrupo1 := '3547' //Codigo BEM que identifica que o beneficiario possui mais de 49 anos e esta em uma das agencia (TIJUCA, NITEROI ou BANGU)
	 		EndIf 
	 		
	 		cAliasTmp->(dbCloseArea())
	 		
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
			Space(04)+;//Codigo de Grupo 2 de Produtos BEM
			"0025"+;//Codigo de Grupo 3 de Produtos BEM
			Space(04)+;//Codigo de Grupo 4 de Produtos BEM
			Space(04)+;//Codigo de Grupo 5 de Produtos BEM
			Space(10)+;//Pessoa Juridica 
			Space(40)+;//Nome da empresa do associado
			PadR(Alltrim(BA1->BA1_ENDERE),50)+;//Endereco
			PadR(Alltrim(BA1->BA1_NR_END),5)+;//Numero
			PadR(Alltrim(BA1->BA1_COMEND),10)+;//Complemento
			PadR(Alltrim(BA1->BA1_BAIRRO),30)+;//Bairro
			PadR(Alltrim(BA1->BA1_CEPUSR),8)+;//CEP
			PadR(Alltrim(BA1->BA1_DDD)+Alltrim(BA1->BA1_TELEFO),15)+;//Telefone 1
			Space(15)+;//Telefone 2
			Space(15)+;//Telefone 3 //Substr(Alltrim(TF4->BA1_MATANT),1,20)+;//Matricula anterior //Space(02)+;//Motivo da baixa //Space(10)+;//Codigo do convenio
			"I";//Operacao - I = Inclusao; E = Exclusao; A = Alteracao
			})

		/*
		Aadd(xUsu,{"00000000"+;
		Padr(cUsu,20)+;
		Padr(cCodPla,10)+;     //PADR(alltrim(BA1->BA1_CODPLA),10)+;
		SPACE(10)+;
		PADR(cDesPla,20)+;   //Descricao do Produto
		SPACE(10)+;          //Data Inicio Opcional
		Iif(!Empty(dDatIni),DtoS(dDatIni),DtoS(BA1->BA1_DATINC))+;   //Data Inicio Opcional
		Space(08)+;
		Iif(BA1->BA1_TIPREG == "00","T","D")+;
		Padr(Alltrim(BA1->BA1_NOMUSR),50)+;
		DtoS(BA1->BA1_DATNAS)+;
		Iif(BA1->BA1_SEXO == "1","M","F")+;
		Space(01)+;
		Padr(alltrim(BTS->BTS_DRGUSR),15)+;
		Padr(Alltrim(BTS->BTS_CPFUSR),14)+;
		Space(20)+;
		Padr(alltrim(BA1->BA1_MUNICI),30)+;
		Padr(Alltrim(BA1->BA1_ESTADO),2)+;
		Iif(BG9->BG9_TIPO = "1","0","1")+;   //			   	  Iif(TF4->BG9_TIPO="1","F","J")+;
		DtoS(BA1->BA1_DATBLO)+;   //Iif(BA1->BA1_DATBLO > BA1->BA1_YDTLIM, DtoS(BA1->BA1_DATBLO), DtoS(BA1->BA1_YDTLIM))+; // Somente se a data limite for superior a data do parametro
		Space(04)+;
		Space(04)+;
		"0025"+;
		Space(04)+;
		Space(04)+;
		Space(10)+;    //Pessoa Juridica //			   	Space(40)+;    //Nome Empresa
		Space(0)+;
		Padr(Alltrim(BA1->BA1_ENDERE),50)+;
		Padr(Alltrim(BA1->BA1_NR_END),5)+;
		Padr(Alltrim(BA1->BA1_COMEND),10)+;
		Padr(Alltrim(BA1->BA1_BAIRRO),30)+;
		Padr(Alltrim(BA1->BA1_CEPUSR),8)+;
		Padr(Alltrim(BA1->BA1_DDD)+Alltrim(BA1->BA1_TELEFO),15)+;
		Space(15)+;    //
		Space(15)+;    //			   	Substr(Alltrim(BA1->BA1_MATANT),1,20)+	Space(02)+Space(10)+;
		"I"})
		*/
		//Leonardo Portella - 06/07/11 - Fim
		
		nContador += 1
	
	EndIf
	
	If nContador = 600
		Exit
	EndIf
	
	VDS->(DbSkip())
	
EndDo

VDS->(DbCloseArea("VDS"))

nLinha := 0                             

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
//Close(oGeraTxt)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera lancamento no cadastro de Debito/Credito                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR10 = 1   //2
	If Len(aCriticas) > 0
		MsgAlert( "Ocorreram criticas no processamento que nao permite gerar lancamentos automaticamente. Corrija e processe novamente!" ) //"Tabela BQL nao existente no SX2, favor cria-la."
		PLSCRIGEN(aCriticas,{ {"Tabela","@C",20} , {"Descricao","@C",400 } },"Criticas")
	Else
		If MV_PAR08 == 1
			u_gerdebcre(cCODRDA,aPlano,aCARGER,aVDS,MV_PAR06,MV_PAR07,nVlADU,nVlVDS,nVlCGER)
		EndIf
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| Imprime_Log() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
±±³Fun‡…o    ³ Impr_Log ³ Autor ³ Nelson / Angelo       ³ Data ³ 22/01/04 ³±±
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
Local	nVlTot   := 0
Local nTvalor  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista criticas                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aPlano) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//Lanc. Produto                                  Quant.  Vlr.Unit       Valor
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
	//XXX   XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
	
	
	//	cTitulo := "Produtos com ADU - " + Iif(MV_PAR11 = 1," RIO DE JANEIRO"," SAO PAULO")
	cTitulo := "Produtos com ADU"
	cCabec1 := "Ativos ate: "+Dtoc(Mv_Par02)+"   Nome do Arquivo: "+cArquivo
	cCabec2 := "Produto                                  Quant.  Vlr.Unit       Valor"  //"Produto                                            Quant."
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
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li, 000 pSay aPlano[I,4]
		@ Li, 006 pSay aPlano[I,1] +"-" + aPlano[I,2]
		@ Li, 047 pSay aPlano[I,3] Picture "@R 999999"
		@ Li, 055 pSay nVlADU Picture "@R 999.99"
		@ Li, 063 pSay aPlano[I,3]*nVlADU Picture "@R 9,999,999.99"
		Li ++
		nTusu := nTusu + aPlano[I,3]
		nVlTot += (aPlano[I,3]*nVlADU)
	Next
	
	//Produto                                  Quant.  Vlr.Unit       Valor
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
	//XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
	
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total ADU"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@R 9,999,999.99"
	nTValor += nVlTot
	
	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	@ Li, 000 pSay "CARTEIRA GERENCIADA"
	Li ++
	Li ++
	
	nTusu := 0
	nVlTot := 0
	For i := 1 to len(aCARGER)
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
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li, 000 pSay aCARGER[I,4]
		@ Li, 006 pSay aCARGER[I,1] + "-" + aCARGER[I,2]
		@ Li, 047 pSay aCARGER[I,3] Picture "@R 999999"
		@ Li, 055 pSay nVlCGER Picture "@E 999.99"
		@ Li, 063 pSay aCARGER[I,3]*nVlCGER Picture "@E 9,999,999.99"
		Li ++
		nTusu := nTusu + aCARGER[I,3]
		nVlTot += (aCARGER[I,3]*nVlCGER)
	Next
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
	nTValor += nVlTot
	
	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	
	@ Li, 000 pSay "VIGILANCIA - VDS"
	Li ++
	Li ++
	nTusu := 0
	nVlTot := 0
	For i := 1 to len(aVDS)
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
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		@ Li, 000 pSay aVDS[I,4]
		@ Li, 006 pSay aVDS[I,1] +"-" + aVDS[I,2]
		@ Li, 047 pSay aVDS[I,3] Picture "@R 999999"
		@ Li, 055 pSay nVlVDS Picture "@E 999.99"
		@ Li, 063 pSay aVDS[I,3]*nVlVDS Picture "@E 9,999,999.99"
		Li ++
		nTusu := nTusu + aVDS[I,3]
		nVlTot += (aVDS[I,3]*nVlVDS)
	Next
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total VDS"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
	nTValor += nVlTot
	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	@ Li, 041 pSay "TOTAL GERAL"
	@ Li, 057 pSay nTValor Picture "@E 9,999,999.99"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),Tamanho)
Endif

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
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
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

Aadd(aRegs,{cPerg,"01","Data Inicial?              ","","","MV_CH1","D",08,0,0,"G","           ","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data Final?                ","","","MV_CH2","D",08,0,0,"G","           ","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Diretorio do Arquivo?      ","","","MV_CH3","C",60,0,0,"G","           ","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
Aadd(aRegs,{cPerg,"04","Tipos de Arquivo?          ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Atendimento Domiciliar","","","","","Todos Produtos","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Tipos de Usuarios?         ","","","MV_CH5","N",01,0,0,"C","           ","Mv_Par05","Envia todos","","","","","Env.Tit.C/Dep","","","","","Envia so Titular","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Ano Competencia?           ","","","MV_CH6","C",04,0,0,"G","           ","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Mes Competencia?           ","","","MV_CH7","C",02,0,0,"G","PlsVldMes()","Mv_Par07","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Gera o Arquivo?            ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"09","Informa Grupo Empresa?     ","","","MV_CH9","N",01,0,0,"C","           ","Mv_Par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"10","Gera Lanc. Debito/Credito? ","","","MV_CHA","N",01,0,0,"C","           ","Mv_Par10","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"11","Qual a Localidade?         ","","","MV_CHB","N",01,0,0,"C","           ","Mv_Par11","Rio de Janeiro","","","","","Sao Paulo","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³gerdebcre ºAutor  ³Luzio Tavares       º Data ³  02/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function gerdebcre(cCODRDA,aPlano,aCARGER,aVDS,cAno,cMes,nVlADU,nVlVDS,nVlCGER)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL aArea    := GetArea()
Local cCodLanc := Space(03)
//LOCAL nPERC   := GetNewPar("MV_PLPEDIV",50)

BAU->(DbSetOrder(1))
BAU->(msSeek(xFilial("BAU")+cCODRDA))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a Transacao													     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Begin Transaction

For i := 1 to len(aPlano)
	cCodLanc := aPlano[i,4]
	BBB->(DbSetOrder(1))
	If BBB->(msSeek(xFilial("BBB")+cCodLanc))
		//		BGQ->(DbSetOrder(4)) //BGQ_FILIAL + BGQ_CODOPE + BGQ_CODIGO + BGQ_ANO + BGQ_MES + BGQ_CODLAN + BGQ_OPELOT + BGQ_NUMLOT
		//		If !BGQ->(msSeek(xFilial("BGQ")+ PlsIntPad() + cCODRDA + cAno + cMes + cCodLanc))  //aPlano[nPos,4]))
		BGQ->(RecLock("BGQ",.T.))
		BGQ->BGQ_FILIAL := xFilial("BGQ")
		BGQ->BGQ_CODSEQ := GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO := cCODRDA
		BGQ->BGQ_NOME   := BAU->BAU_NOME
		BGQ->BGQ_ANO    := cAno
		BGQ->BGQ_MES    := cMes
		BGQ->BGQ_CODLAN := cCodLanc   //aPlano[nPos,4]
		BGQ->BGQ_VALOR  := aPlano[i,3]*nVlADU
		BGQ->BGQ_TIPO   := BBB->BBB_TIPSER
		BGQ->BGQ_TIPOCT := BBB->BBB_TIPOCT
		BGQ->BGQ_INCIR  := BBB->BBB_INCIR
		BGQ->BGQ_INCINS := BBB->BBB_INCINS
		BGQ->BGQ_INCPIS := BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF := BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL := BBB->BBB_INCCSL
		BGQ->BGQ_VERBA  := BBB->BBB_VERBA
		BGQ->BGQ_CODOPE := PlsIntPad()
		BGQ->BGQ_CONMFT := BBB->BBB_CONMFT
		BGQ->BGQ_OBS    := alltrim(str(aPlano[i,3]))+" VIDAS X R$ "+alltrim(str(nVLADU))
		BGQ->BGQ_LANAUT := "1"
		//			  BGQ->BGQ_OPELAU := BAU->BAU_CODOPE
		BGQ->BGQ_NUMLAU := "" //Sera gravado logo abaixo quando o titulo for gerado...
		BGQ->BGQ_INTERC := "0"
		BGQ->(msUnLock())
		ConfirmSX8()
		//		EndIf
	Endif
Next

For i := 1 to len(aCARGER)
	cCodLanc := aCARGER[i,4]
	BBB->(DbSetOrder(1))
	If BBB->(msSeek(xFilial("BBB")+cCodLanc))
		//		BGQ->(DbSetOrder(4)) //BGQ_FILIAL + BGQ_CODOPE + BGQ_CODIGO + BGQ_ANO + BGQ_MES + BGQ_CODLAN + BGQ_OPELOT + BGQ_NUMLOT
		//		If !BGQ->(msSeek(xFilial("BGQ")+ PlsIntPad() + cCODRDA + cAno + cMes + cCodLanc))  //aPlano[i,4]))
		BGQ->(RecLock("BGQ",.T.))
		BGQ->BGQ_FILIAL := xFilial("BGQ")
		BGQ->BGQ_CODSEQ := GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO := cCODRDA
		BGQ->BGQ_NOME   := BAU->BAU_NOME
		BGQ->BGQ_ANO    := cAno
		BGQ->BGQ_MES    := cMes
		BGQ->BGQ_CODLAN := cCodLanc   //aPlano[nPos,4]
		BGQ->BGQ_VALOR  := aCARGER[i,3]*nVlCGER
		BGQ->BGQ_TIPO   := BBB->BBB_TIPSER
		BGQ->BGQ_TIPOCT := BBB->BBB_TIPOCT
		BGQ->BGQ_INCIR  := BBB->BBB_INCIR
		BGQ->BGQ_INCINS := BBB->BBB_INCINS
		BGQ->BGQ_INCPIS := BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF := BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL := BBB->BBB_INCCSL
		BGQ->BGQ_VERBA  := BBB->BBB_VERBA
		BGQ->BGQ_CODOPE := PlsIntPad()
		BGQ->BGQ_CONMFT := BBB->BBB_CONMFT
		BGQ->BGQ_OBS    := alltrim(str(aCARGER[i,3]))+" VIDAS X R$ "+alltrim(str(nVlCGER))
		BGQ->BGQ_LANAUT := "1"
		//			  BGQ->BGQ_OPELAU := BAU->BAU_CODOPE
		BGQ->BGQ_NUMLAU := "" //Sera gravado logo abaixo quando o titulo for gerado...
		BGQ->BGQ_INTERC := "0"
		BGQ->(msUnLock())
		ConfirmSX8()
		//		EndIf
	Endif
Next

For i := 1 to len(aVDS)
	cCodLanc := aVDS[i,4]
	BBB->(DbSetOrder(1))
	If BBB->(msSeek(xFilial("BBB")+cCodLanc))
		//		BGQ->(DbSetOrder(4)) //BGQ_FILIAL + BGQ_CODOPE + BGQ_CODIGO + BGQ_ANO + BGQ_MES + BGQ_CODLAN + BGQ_OPELOT + BGQ_NUMLOT
		//		If !BGQ->(msSeek(xFilial("BGQ")+ PlsIntPad() + cCODRDA + cAno + cMes))  // + cCodLanc))  //aPlano[i,4]))
		BGQ->(RecLock("BGQ",.T.))
		BGQ->BGQ_FILIAL := xFilial("BGQ")
		BGQ->BGQ_CODSEQ := GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO := cCODRDA
		BGQ->BGQ_NOME   := BAU->BAU_NOME
		BGQ->BGQ_ANO    := cAno
		BGQ->BGQ_MES    := cMes
		BGQ->BGQ_CODLAN := cCodLanc   //aPlano[nPos,4]
		BGQ->BGQ_VALOR  := aVDS[i,3]*nVlVDS
		BGQ->BGQ_TIPO   := BBB->BBB_TIPSER
		BGQ->BGQ_TIPOCT := BBB->BBB_TIPOCT
		BGQ->BGQ_INCIR  := BBB->BBB_INCIR
		BGQ->BGQ_INCINS := BBB->BBB_INCINS
		BGQ->BGQ_INCPIS := BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF := BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL := BBB->BBB_INCCSL
		BGQ->BGQ_VERBA  := BBB->BBB_VERBA
		BGQ->BGQ_CODOPE := PlsIntPad()
		BGQ->BGQ_CONMFT := BBB->BBB_CONMFT
		BGQ->BGQ_OBS    := alltrim(str(aVDS[i,3]))+" VIDAS X R$ "+alltrim(str(nVlVDS))
		BGQ->BGQ_LANAUT := "1"
		//			  BGQ->BGQ_OPELAU := BAU->BAU_CODOPE
		BGQ->BGQ_NUMLAU := "" //Sera gravado logo abaixo quando o titulo for gerado...
		BGQ->BGQ_INTERC := "0"
		BGQ->(msUnLock())
		ConfirmSX8()
		//		EndIf
	Endif
Next

End Transaction

Return(NIL)
