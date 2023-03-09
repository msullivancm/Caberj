#Include 'RWMAKE.CH'                               
#Include 'PROTHEUS.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#Include 'UTILIDADES.CH'

#DEFINE c_ent CHR(13) + CHR(10)

///*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³CABA172    º Autor ³ Altamiro           º Data ³  30/04/2008 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ Gera arquivo texto dos usuarios que possuem atendimento     º±±
//±±º          ³ domiciliar de urgencia e também o rateio no contas medicas. º±±
//±±º          ³ alterado para tratar guias de projeto monitoramento         º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP6 IDE                                                     º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
///*/                                                       .

User Function CABA172(cOrig)  

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄesmo¿
//³Melhorias a serem feitas.                                ³
//³1- Eliminar o parâmetro "Gera debito/credito"            ³
//³2-Mudar nome da rotina principal e chamada da mesma no   ³
//³menu, visando evitar conflito com a atual rotina de mesmo³
//³nome que gera pagamento a partir do lançamento de        ³
//³debito/credito.                                          ³
//³                                                         ³
//³Renato Peixoto em 17/12/2010                             ³
//³Documentation                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄesmoÙ
ENDDOC*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oGeraTxt
Private cPerg       := "RATADU"
Private cString     := "BA1"
Private nlinha      := 0  
Private nlinha1     := 0
Private nTamLin, cLin, cCpo
Private lAbortPrint := .F.
private xUsu        := {}
private aPlano      := {}
private aExcPlano   := {}
private aCarGer     := {}
private aExcCarGer  := {}
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
Private cTipo       := ""  //não está em uso
Private _cgc        := ""
Private cNomeProg   := "RATEADU"
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
Private nVlADU      :=0.00 // GETNEWPAR("MV_YVLADU",2.09)
Private nVlVDS      :=0.00 // GETNEWPAR("MV_YVLVDS",60.00)
Private nVlCGER     :=0.00 // GETNEWPAR("MV_YVLCGER",15.40)
Private cRDASP      := GETNEWPAR("MV_YRDASP","106445")
Private cRDARJ      := GETNEWPAR("MV_YRDARJ","126004")
Private cCodRDA     := ""
Private cOrigem     := cOrig                          
Private cOrigem     := "RATEIO"
Private cProADU     := GetMV("MV_XPROADU") //Código de procedimento referente ao projeto ADU
Private cProCGER    := GetMv("MV_XPROCGE") //Código de procedimento referente ao projeto ADU Especial
Private cProVDS     := GetMv("MV_XPROVDS") //Código de procedimento referente ao projeto VDS
Private cProLeve    := GetMv("MV_XPROLEV") //Código de procedimento referente ao Veiculo Leve - (EMD Eletiva)
Private dDtEvento   := dDataBase //inicio com a data do dia, mas depois irá assumir o valor do parâmetro...
Private cCompet     := ""
Private nCont       := 0
Private nCont2      := 0
Private aRelExcel   := {}//Variável que irá armazenar os usuários impressos, para exibir um relatório em excel ao final do processo...
Private cTempoRot   := ""
private cDthr       := (dtos(DATE()) + "-" + Time()) 
private  cAnoBaseN  := ' '
private  cMesBaseN  := ' '
 private DdDataBase  := ' ' 


aADD (aRelExcel,{"Projeto", "Código do Plano", "Descrição do Plano", "Matrícula", " Nome do Usuário", "Código do RDA", "Valor","Idade","UF","MUNICIPIO"})
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
INCLUI := .T. //Chumbado como .T., pq essa variável é utilizada em um inicializador padrão de campo da tabela BD5

dbSelectArea("BA1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Leonardo Portella - 06/07/11 - Inicio

Pergunte(cPerg,.F.)
                
nOpca := 0

aSays := {}
aAdd(aSays, 'Este programa ira gerar um arquivo texto, conforme os parametros definidos'   )
aAdd(aSays, 'pelo usuario, com os registros do arquivo de BA1')
           
aButtons := {}
aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )
 
FormBatch( OemToAnsi("Gera‡„o de Arquivo Texto"), aSays, aButtons,, 240, 450 )

If nOpca == 1
	OkGeraTxt()
EndIf

/*
@ 200,1 TO 390,430 DIALOG oGeraTxt TITLE OemToAnsi("Gera‡„o de Pagamento ADU")
@ 02,10 TO 90,200 //faz as bordas internas
@ 10,018 Say " Este programa irá gerar pagamento/relatório para ADU, além "
@ 18,018 Say " de gerar um arquivo texto, com os registros do arquivo de  "
@ 26,018 Say " BA1.                                                       "

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

cTempoRot := "Hora de início da rotina: " + DtoC(Date()) + ' - ' + Time()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
//MV_PAR01 não está sendo usado para nada. Verificar se ele poderá ser usado para filtrar na query o ba1_dtinc
If Empty(mv_par01) .or. Empty(mv_par02) .or. Empty(mv_par04) ;   //.or. Empty(mv_par03)
	.or. Empty(mv_par05) .or. Empty(mv_par06) .or. Empty(mv_par07) .or. Empty(mv_par08)
	MsgAlert("Informe os parametros .....")
	//Close(oGeraTxt)
	Return
Endif

//Renato Peixoto. 24/12/10. Parâmetro MV_PAR10 passa a ser MV_PAR09 devido a eliminação do parâmetro de geração déb./créd.
dDtEvento := MV_PAR09
cCompet   := MV_PAR06+MV_PAR05

If cOrigem == "RATEIO"

	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	
	//Leonardo Portella - 07/07/11
	//MV_PAR08 = 2 //No caso da rotina de rateio, o relatório deve sempre ser analítico...
	MV_PAR08 := 2 //No caso da rotina de rateio, o relatório deve sempre ser analítico...
	
EndIf	

DdDataBase :=  lastday(stod(MV_PAR05+MV_PAR06+"01"))

//_data := (substr(Dtoc(DdDataBase),1,2)+ substr(Dtoc(DdDataBase),4,2)+ substr(Dtoc(DdDataBase),7,2)) altamiro

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
	//Leonardo Portella - 14/10/13 - Virada P11
	MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser criado! Verifique os parametros." + CHR(13) + CHR(10) + cDesFerror(FError()),AllTrim(SM0->M0_NOMECOM))
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a regua de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Leonardo Portella - 06/07/11
Private oProcess := MsNewProcess():New({||ProcTXT()},"Processando...","",.F.)
oProcess:Activate()
//MsAguarde({|| Processa() }, "Processando...", "", .T.)

Return

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
//Local cCodPla  := Space(0)
//Local cCodPla1 := Space(0)
Local cSql1 := Space(0)
Local cSql2 := Space(0)
Local lExistRat	:= .F.

Private cCodPla  := Space(0)
Private cCodPla1 := Space(0)
Private nContador := 0
Private nIdade    := 0  
Private cCodInt   := "" 
Private nContPlano:= 0
Private nContCGER := 0
Private nContVDS  := 0

oProcess:SetRegua1(0)
oProcess:SetRegua2(0)

For i := 1 to 5
	oProcess:IncRegua1("Selecionando registros...")
Next
//MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})
/*
If cOrigem = "RATEIO"
	DbSelectArea("PAH")
	DbSetOrder(1)
	If DbSeek(XFILIAL("PAH")+cCompet)
		lExistRat	:= .T.
		If !APMSGYESNO("Atenção, já existem pagamentos gerados para a competência informada nos parâmetros. Deseja gerar assim mesmo? OBS: Somente serão gerados pagamentos que ainda não tenham sido processados.","Já existe pagamento para a competência informada.")
			Return
		EndIf
	EndIf
EndIf
*/
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

cCodRDA := cRDASP
cCodRDA := cRDARJ

	cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, "+c_ent
	cSQL += " Decode(Sign(IDADE_S(BA1_DATNAS)-70),-1,'0023','0024') PROJ, IDADE_S(BA1_DATNAS) IDADE, PRE.* ,BA1.* "+c_ent
	cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "+c_ent
	cSQL += RetSQLName("BA3") + " BA3, "+RetSQLName("BA0") +" BA0 , PRE_ESTABELECIDO PRE "+c_ent
	cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "+c_ent
	cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "+c_ent
	cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "+c_ent
	cSQL += " BA0_FILIAL = '"+xFilial("BA0")+"'  AND "+c_ent
	cSQL += " BA1.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA3.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BG9.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA0.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA3_CODINT = BA1_CODINT AND "+c_ent
	cSQL += " BA3_CODEMP = BA1_CODEMP AND "+c_ent
	cSQL += " BA3_MATRIC = BA1_MATRIC AND "+c_ent
//	cSQL += " (BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+DtoS(mv_par02)+"') AND  "+c_ent
//	cSQL += " BA1_CODEMP NOT IN ('0006','0004','0009','0010') AND "+c_ent
//  cSQL += " BA1_DATINC BETWEEN '"+DtoS(mv_par01)+"' AND '"+Dtos(MV_PAR02)+"' AND "+c_ent
//	cSQL += " BA1_DATINC <= '"+DtoS(mv_par02)+"' AND "
	cSQL += " BTS_MATVID = BA1_MATVID AND "+c_ent
/*
	cSQL += " BA1_CODINT  = '0001' AND "+c_ent
    cSQL += " BA1_CODEMP  = '0005' AND "+c_ent
    cSQL += " BA1_MATRIC  = '027027' AND "+c_ent  
    cSQL += " BA1_TIPREG  = '00' AND "+c_ent
*/	

    cSQL += " PRE.REFERENCIA = '"+MV_PAR05+MV_PAR06+"' AND "+c_ent

//	cSQL += " BA1_MATRIC  >= '027027' AND "+c_ent
//	cSQL += " BA1_MATRIC  <= '030027' AND "+c_ent

	cSQL += " BA1_CODINT  = SUBSTR(PRE.MATRICULA,1,4) AND "+c_ent
    cSQL += " BA1_CODEMP  = SUBSTR(PRE.MATRICULA,5,4) AND "+c_ent
    cSQL += " BA1_MATRIC  = SUBSTR(PRE.MATRICULA,9,6) AND "+c_ent
    cSQL += " BA1_TIPREG  = SUBSTR(PRE.MATRICULA,15,2) "+c_ent
If cEmpant =='01'
   cSQL += " AND  PRE.OPE = 'C' "+c_ent
Else
   cSQL += " AND PRE.OPE = 'I' "+c_ent
EndIf   
   // cSQL += " and pre.matricula = '00010001016536005'"
	
	cSQL += " AND BG9_CODIGO = BA1_CODEMP "+c_ent
	cSQL += " AND BG9_HSPEMP = ' ' "+c_ent

	cSQL += " AND BA0_CODIDE||BA0_CODINT = BA1_OPEDES "+c_ent
		
	cSQL += " 	AND BTS_FILIAL = ' ' "																+ c_ent
	cSQL += " 	AND BTS.D_E_L_E_T_ = ' ' "															+ c_ent
	
	If lExistRat
	 
		cSQL += " 	 AND NOT EXISTS"																+ c_ent
		cSQL += " 	 ("																				+ c_ent
		cSQL += " 	 SELECT PAH_FILIAL"																+ c_ent
		cSQL += " 	 FROM " + RetSqlName('PAH') + " PAH"											+ c_ent
		cSQL += " 	  WHERE PAH_FILIAL = ' ' "														+ c_ent
		cSQL += " 	    AND PAH_CODRDA = '" + cCodRDA + "'"											+ c_ent
		cSQL += " 	    AND PAH_COMPET = '" + cCompet + "'"											+ c_ent
		cSQL += " 	    AND BA1_CODINT = PAH_CODINT"												+ c_ent
		cSQL += " 	    AND BA1_CODEMP = PAH_CODEMP"												+ c_ent
		cSQL += " 	    AND BA1_MATRIC = PAH_MATRIC"												+ c_ent
		cSQL += " 	    AND BA1_TIPREG = PAH_TIPREG"												+ c_ent
		cSQL += " 	    AND PAH.D_E_L_E_T_ = ' '"													+ c_ent 
		cSQL += " 	 )"																				+ c_ent
	
	EndIf
	
    //Leonardo Portella - 20/07/15 - Fim
    
    cSQL += " ORDER BY BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"
	
memowrit("C:\temp\CABA172.SQL",cSQL)

//return() // altamiro

PLSQuery(cSQL,"TF4")

DbSelectArea("TF4")
TF4->(Dbgotop())
                
nCont := 0

COUNT TO nCont 

TF4->(Dbgotop()) 

oProcess:SetRegua1(nCont)

cTot 	:=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
nCont 	:= 0

nTotal 	:= 0

While !TF4->(Eof())
	
	oProcess:IncRegua1("Processando usuário " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )

	If lAbortPrint
		Exit
	Endif
	//Referências a MV_PAR05 atualizadas para MV_PAR04 em 21/10/2010 por Renato Peixoto
	//verifcar no parametro qual o tipo de arquivo vou gerar
	// mv_par04 = 1 todos os usuarios validos
	
	// mv_par04 = 2 somente titular se houver dependente valido
	// mv_par04 = 3 todos os titulares
	If mv_par04 == 1  //todos os usuarios validos
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
	ElseIf mv_par04 = 2  //2 somente titular se houver dependente valido
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
/* altamiro	
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
				
				//Pesquisa opcional no nivel da familia para verificar se o produto eh vinculado
				BF1->(DbSetOrder(1))   //BF1_FILIAL + BF1_CODINT + BF1_CODEMP + BF1_MATRIC + BF1_CODPRO
				
				If BF1->(DbSeek(xFilial("BF1") + TF4->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + "0023")))
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
*/	
	cDesPla := "Produto nao Identificado"
	BI3->(DbSetOrder(1))  //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO = "  00010001001"
	If BI3->(DbSeek(xFilial("BI3")+TF4->BA1_CODINT+cCodPla1))
		cDesPla := BI3->BI3_DESCRI
	EndIf
	
	dDtInicial := DdDataBase //CtoD(substr(DtoC(DdDataBase),1,6)+"/"+alltrim(Str(Val(Substr(DtoS(DdDataBase),1,4))-65)))
	
	//nIdade := Calc_Idade(DdDataBase,TF4->BA1_DATNAS)
	nIdade := Calc_Idade(mv_par02,TF4->BA1_DATNAS)
	
	//Leonardo Portella - 15/07/15 - Inicio - Conforme informado por Roberto Meirelles, caso o beneficiario
	//tenha idade maior ou igual a 70 anos, so fara parte da carteira gerenciada se for MATER ou AFINIDADE
	//Para manter a coerencia, tenho que colocar com idade maior ou igual a 70 e NAO sendo MATER ou AFINIDADE
	//como ADU
	 
	//If nIdade < 70 //65
	If ( nIdade < 70 ) .or. ( ( nIdade >= 70 ) .and. !( TF4->BA1_CODEMP $ '0001|0002|0005' ) ) //MATER e AFINIDADE 
			
	//Leonardo Portella - 15/07/15 - Fim
	
		//		If DtoS(TF4->B A1_DATNAS) > DtoS(dDtInicial)
		cCodBEM := "0023"  //Iif(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+;   //"0023"+;   // Codigo de Grupo de Produtos BEM
		
		cCodADU := Space(03)
		//Pesquisa qual o codigo de lancamento de debito e credito do produto
		DbSelectArea("BT3")
		BT3->(DbSetOrder(1))  //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA = "  000100010010023001"
		If !BT3->(DbSeek(xFilial("BT3") + TF4->BA1_CODINT + cCodPla + "0010023"))
			//Opcional no produto sem o codigo de lancamento
			aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		ElseIf Empty(BT3_YCDADU)
			aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
		Else
			cCodADU := BT3->BT3_YCDADU
		EndIf
		//Acrescentado por Renato Peixoto em 08/09/10 para tratar relatório analítico
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 == 2 //analítico
			//aADD (aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR})  //ba1_tipreg, ba1_digito, ba1_telefo, ba1_sexo, ba1_matant, ba1_matvid, ba1_conemp, ba1_vercon, ba1_subcon, ba1_versub
		//	aADD (aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,cProADU, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "ADU"})
   		    aADD (aPlano,{cCodPla,;
			              cDesPla,;
						  cCodADU,;
						  TF4->BA1_CODINT,;
						  TF4->BA1_CODEMP,;
						  TF4->BA1_MATRIC, ;
						  TF4->BA1_NOMUSR,;
						  TF4->CodRDA,;
						  nVlADU,;
						  TF4->CODPRO,; 
						  TF4->BA1_TIPREG,; 
						  TF4->BA1_DIGITO,;
						  TF4->BA1_TELEFO,; 
						  TF4->BA1_SEXO,; 
						  TF4->BA1_MATANT,; 
						  TF4->BA1_MATVID,; 
						  TF4->BA1_CONEMP,; 
						  TF4->BA1_VERCON,; 
						  TF4->BA1_SUBCON,; 
						  TF4->BA1_VERSUB,; 
						  nIdade,; 
						  "ADU",;
						  TF4->DAT_REALIZACAO,;
						  TF4->REFERENCIA})
	
	        dDtEvento :=TF4->DAT_REALIZACAO  
	
			nContPlano++//incrementa o contador controlador do ADU
			aADD (aRelExcel,{"ADU",cCodPla,cDesPla, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,TF4->IDADE,TF4->BA1_ESTADO,TF4->BA1_MUNICI})
			//chama a rotina que vai gerar o pagamento no contas médicas

			U_GERCTAEST(aPlano,"ADU")
	/*		
	        If cOrigem == "RATEIO"
				U_GERCTAEST(aPlano,"ADU")
				//Grava na tabela de controle de pagamento ADU
				RecLock("PAH",.T.)
				PAH->PAH_FILIAL := XFILIAL("PAH")
				PAH->PAH_COMPET := cCompet
				PAH->PAH_CODRDA := cCodRDA
				PAH->PAH_CODINT := TF4->BA1_CODINT
				PAH->PAH_CODEMP := TF4->BA1_CODEMP
				PAH->PAH_MATRIC := TF4->BA1_MATRIC
				PAH->PAH_TIPREG := TF4->BA1_TIPREG
				PAH->PAH_DIGITO := TF4->BA1_DIGITO
				PAH->PAH_NOMUSR := TF4->BA1_NOMUSR
				PAH->PAH_NOMPRO := "ADU"
				PAH->(MsUnlock())
			EndIf  
	*/ //altamiro		
		Else
			nPos := aScan(aPlano, {|x| x[1] == cCodPla})
		
			If nPos = 0
				Aadd(aPlano,{cCodPla,cDesPla,1,cCodADU})
			Else
				aPlano[nPos,3] := aPlano[nPos,3]+1
			EndIf
		EndIf//Fim alteração Renato.
		
	Else // >= 70
	
		
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
		
		//Alterado por Renato Peixoto em 08/09/10 para tratar relatório analítico
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			//Aadd(aCARGER, {cCodPla,cDesPla,cCdCGer, TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR, nIdade})
	//		aADD(aCARGER, {cCodPla,cDesPla,cCdCGer,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlCGER,cProCGER, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "CARGER"})

 		 aADD(aCARGER, {cCodPla,;
						cDesPla,;
						cCdCGer,;
						TF4->BA1_CODINT,;
						TF4->BA1_CODEMP,;
						TF4->BA1_MATRIC,;
						TF4->BA1_NOMUSR,;
						TF4->CodRDA,;
						nVlCGER,;
						TF4->CODPRO,;
						TF4->BA1_TIPREG,;
						TF4->BA1_DIGITO,;
						TF4->BA1_TELEFO,;
						TF4->BA1_SEXO,;
						TF4->BA1_MATANT,; 
						TF4->BA1_MATVID,;
						TF4->BA1_CONEMP,;
						TF4->BA1_VERCON,;
						TF4->BA1_SUBCON,;    
						TF4->BA1_VERSUB,;  
						nIdade,;
						"CARGER",;
						TF4->DAT_REALIZACAO,;
						TF4->REFERENCIA})

			nContCGER++ //Incrementa o contador controlador do Carteira Gerenciada
			aADD(aRelExcel, {"Carteira Gerenciada",cCodPla,cDesPla, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlCGER,TF4->IDADE,TF4->BA1_ESTADO,TF4->BA1_MUNICI})
			//chama a rotina que vai gerar o pagamento no contas médicas
		U_GERCTAEST(aCARGER,"CARGER")	
		/*	If cOrigem == "RATEIO"
				U_GERCTAEST(aCARGER,"CARGER")
				//Grava na tabela de controle de pagamento ADU
				RecLock("PAH",.T.)
				PAH->PAH_FILIAL := XFILIAL("PAH")
				PAH->PAH_COMPET := cCompet
				PAH->PAH_CODRDA := cCodRDA
				PAH->PAH_CODINT := TF4->BA1_CODINT
				PAH->PAH_CODEMP := TF4->BA1_CODEMP
				PAH->PAH_MATRIC := TF4->BA1_MATRIC
				PAH->PAH_TIPREG := TF4->BA1_TIPREG
				PAH->PAH_DIGITO := TF4->BA1_DIGITO
				PAH->PAH_NOMUSR := TF4->BA1_NOMUSR
				PAH->PAH_NOMPRO := "CARGER"
				PAH->(MsUnlock())
			EndIf
		*/ // ALTAMIRO		
		Else
			nPos := aScan(aCARGER, {|x| x[1] == cCodPla})
			If nPos = 0
				Aadd(aCARGER,{cCodPla,cDesPla,1,cCdCGer})
			Else
				aCARGER[nPos,3] := aCARGER[nPos,3]+1
			EndIf
		EndIf//Fim alteração Renato.
   
	EndIf
	
	//	If MV_PAR08 == 1 passaria a ser MV_par07 pq houve exclusão de parâmetros
	
	cUsu :=(TF4->BA1_CODINT+TF4->BA1_CODEMP+TF4->BA1_MATRIC+TF4->BA1_TIPREG+TF4->BA1_DIGITO)

	//Leonardo Portella - 05/07/11 - Inicio
	//Gravacao do projeto ao qual pertence o usuario com 50 ou mais anos 
	
	//Chamado 15751 - BIANCHINI - Mudanca de regras do publico que vai ao RATEIO.  Rotina foi desmebrada para mostrar TXT dos elegiveis pelo CABA173
	/*
	cGrupo1 := Space(4)
	cGrupo2 := Space(4)
		
	If nIdade >= 50
	
		cAliasTmp := GetNextAlias()
	
 		cQuery := "SELECT NVL(RETORNA_NUCLEO_MS(BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,'" + DtoS(DdDataBase) + "'),' ') AGENCIA" 	+ c_ent
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
	*/
	/*
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
	//Chamado 15751 - FIM - BIANCHINI
	
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
	Space(15)+;    
	Space(15)+;    //			   	Substr(Alltrim(TF4->BA1_MATANT),1,20)+	Space(02)+Space(10)+;
	"I" }) 
    */
    
    //Leonardo Portella - 05/07/11 - Fim
		
	TF4->(DbSkip())
	
Enddo

TF4->(DbCloseArea("TF4")) 

aELETIVA := aClone(aCARGER)

nContLeve := 0 //BIANCHINI - 04/05/2015 - Quantidade para ratear valor do Veiculo Leve - Usaremos somente acima de 70         

If Len(aELETIVA) > 0 
	While nContLeve <= (Len(aELETIVA) - 1)  
		nContLeve++	
	Enddo
Endif

//Não irá mais gerar pagamento VDS. Comentado por Renato Peixoto em 03/02/2011
/*
DbSelectArea("VDS")
VDS->(Dbgotop())

nContador := 0
While !VDS->(Eof())
	
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
	
	MsProcTxt("Processando Usuario VDS..."+ cUsu)
	
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

		//Alteração Renato Peixoto para tratar relatório analítico
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			//Aadd(aVDS,{cCodPla,cDesPla,cCodVDS, VDS->BD7_OPEUSR, VDS->BD7_CODEMP, VDS->BD7_MATRIC, VDS->BA1_NOMUSR, VDS->SINISTRALIDADE})
			aADD(aVDS, {cCodPla,cDesPla,cCodVDS,VDS->BD7_OPEUSR, VDS->BA1_CODEMP, VDS->BA1_MATRIC, VDS->BA1_NOMUSR,cCodRDA,nVlVDS,cProVDS, VDS->BA1_TIPREG, VDS->BA1_DIGITO, VDS->BA1_TELEFO, VDS->BA1_SEXO, VDS->BA1_MATANT, VDS->BA1_MATVID, VDS->BA1_CONEMP, VDS->BA1_VERCON, VDS->BA1_SUBCON, VDS->BA1_VERSUB, VDS->SINISTRALIDADE, "VDS"})
			nContVDS++//incrementa o contador controlador do VDS
			aADD(aRelExcel, {"VDS",cCodPla,cDesPla, VDS->BA1_MATRIC, VDS->BA1_NOMUSR,cCodRDA,nVlVDS})
			//chama a rotina que vai gerar o pagamento no contas médicas
			If cOrigem == "RATEIO"
				U_GERCTAEST(aVDS,"VDS")
				//Grava na tabela de controle pagamento ADU
				RecLock("PAH",.T.)
				PAH->PAH_FILIAL := XFILIAL("PAH")
				PAH->PAH_COMPET := cCompet
				PAH->PAH_CODRDA := cCodRDA
				PAH->PAH_CODINT := VDS->BA1_CODINT
				PAH->PAH_CODEMP := VDS->BA1_CODEMP
				PAH->PAH_MATRIC := VDS->BA1_MATRIC
				PAH->PAH_TIPREG := VDS->BA1_TIPREG
				PAH->PAH_DIGITO := VDS->BA1_DIGITO
				PAH->PAH_NOMUSR := VDS->BA1_NOMUSR
				PAH->PAH_NOMPRO := "VDS"
				PAH->(MsUnlock())
			EndIf 
			
		Else
			nPos := aScan(aVDS, {|x| x[1] == cCodPla})
			If nPos = 0
				Aadd(aVDS,{cCodPla,cDesPla,1,cCodVDS})
			Else
				aVDS[nPos,3] := aVDS[nPos,3]+1
			EndIf
			nContador += 1
		EndIf //Fim altera
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
		              
		//Alteração Renato Peixoto para tratar relatório analítico
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			//Aadd(aVDS,{cCodPla,cDesPla,cCodVDS,VDS->BD7_OPEUSR, VDS->BD7_CODEMP, VDS->BD7_MATRIC, VDS->BA1_NOMUSR, VDS->SINISTRALIDADE})
			aADD(aVDS, {cCodPla,cDesPla,cCodVDS,VDS->BD7_OPEUSR, VDS->BA1_CODEMP, VDS->BA1_MATRIC, VDS->BA1_NOMUSR,cCodRDA,nVlVDS,cProVDS, VDS->BA1_TIPREG, VDS->BA1_DIGITO, VDS->BA1_TELEFO, VDS->BA1_SEXO, VDS->BA1_MATANT, VDS->BA1_MATVID, VDS->BA1_CONEMP, VDS->BA1_VERCON, VDS->BA1_SUBCON, VDS->BA1_VERSUB, VDS->SINISTRALIDADE, "VDS"})
			nContVDS++//incrementa o contador controlador do VDS
			aADD(aRelExcel, {"VDS",cCodPla,cDesPla, VDS->BA1_MATRIC, VDS->BA1_NOMUSR,cCodRDA,nVlVDS})
			//chama a rotina que vai gerar o pagamento no contas médicas
			If cOrigem == "RATEIO"
				U_GERCTAEST(aVDS,"VDS")
				//Grava na tabela de controle pagamento ADU
				RecLock("PAH",.T.)
				PAH->PAH_FILIAL := XFILIAL("PAH")
				PAH->PAH_COMPET := cCompet
				PAH->PAH_CODRDA := cCodRDA
				PAH->PAH_CODINT := VDS->BA1_CODINT
				PAH->PAH_CODEMP := VDS->BA1_CODEMP
				PAH->PAH_MATRIC := VDS->BA1_MATRIC
				PAH->PAH_TIPREG := VDS->BA1_TIPREG
				PAH->PAH_DIGITO := VDS->BA1_DIGITO
				PAH->PAH_NOMUSR := VDS->BA1_NOMUSR
				PAH->PAH_NOMPRO := "VDS"
				PAH->(MsUnlock())
			EndIf 
		Else
			nPos := aScan(aVDS, {|x| x[1] == cCodPla })
			If nPos = 0
				Aadd(aVDS,{cCodPla,cDesPla,1,cCodVDS})
			Else
				aVDS[nPos,3] := aVDS[nPos,3]+1
			EndIf
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
		nContador += 1
	EndIf
	If nContador = 600
		Exit
	EndIf
	VDS->(DbSkip())
EndDo
VDS->(DbCloseArea("VDS"))
*/

//Se não houver nenhum usuário selecionado para ADU, CARGER nem VDS, significa que não existe registro a ser processado
If Len(aPlano) = 0 .AND. Len(aCARGER) = 0 //.AND. Len(aVDS) = 0 não irá mais gerar pagamento VDS. Comentado por Renato Peixoto em 03/02/2011
	APMSGSTOP("Atenção, não existe pagamento/relatório a ser gerado de acordo com os parâmetros informados. Verifique os parâmetros e execute novamente.","Não existe pagamento a ser gerado para os parâmetros informados!")
	//Close(oGeraTxt)
	Return                                                                                                                                                                                                              
EndIf

//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
If MV_PAR08 = 2 //analítico
	 ASort(aPlano , , , {|x,y|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]})  
	 ASort(aCARGER, , , {|x,y|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]})  
	 //ASort(aVDS   , , , {|x,y|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]})  Não vai mais gerar pagamento VDS. Comentado por Renato Peixoto em 03/02/2011
EndIf

nLinha := 0

//Chamado 15751 - BIANCHINI - TXT DE ELEGIVEIS A ADU FOI PARA O CABR173
/*
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
	
	//Leonardo Portella - 14/07/11 - Inclusao dos 50 caracteres (obs) no fim de cada linha conforme solicitacao da BEM.
	cCpo := xUsu[I,1] + strZero(nLinha,8) + space(50)
	//cCpo := xUsu[I,1]+strzero(nLinha,8)
	
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
*/
//Chamado 15751 - BIANCHINI - FIM

//Close(oGeraTxt)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera lancamento no cadastro de Debito/Credito                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Referências a MV_PAR10 atualizadas para MV_PAR08 em 21/10/2010 por Renato Peixoto
//Comentado por Renato Peixoto em 24/12/2010, pois não irá mais gerar lançamento déb./créd.
/*If MV_PAR08 == 1   //2
	If Len(aCriticas) > 0
		MsgAlert( "Ocorreram criticas no processamento que nao permite gerar lancamentos automaticamente. Corrija e processe novamente!" ) //"Tabela BQL nao existente no SX2, favor cria-la."
		PLSCRIGEN(aCriticas,{ {"Tabela","@C",20} , {"Descricao","@C",400 } },"Criticas")
	Else
		//Referências a MV_PAR08 atualizadas para MV_PAR07 em 21/10/2010 por Renato Peixoto
		If MV_PAR07 == 1
			//Referências a MV_PAR06 atualizadas para MV_PAR05 em 21/10/2010 por Renato Peixoto
			//Referências a MV_PAR07 atualizadas para MV_PAR06 em 21/10/2010 por Renato Peixoto
			u_gerdebcre(cCODRDA,aPlano,aCARGER,aVDS,MV_PAR05,MV_PAR06,nVlADU,nVlVDS,nVlCGER)
		EndIf
	Endif
EndIf*/

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chama a função que vai incluir o rateio no contas médicas.³
//³Renato Peixoto em 21/10/2010.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
//aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR}
/*If cOrigem == "RATEIO" 
	U_GERCTAEST(aPlano,"ADU")//Gera contas médicas para os usuários do ADU
	U_GERCTAEST(aCARGER,"CARGER")//Gera contas médicas para os usuários do carteira gerenciada
	U_GERCTAEST(aVDS,"VDS")   //Gera contas médicas para os usuários do VDS
EndIf*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| Imprime_Log() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTempoRot += "   /   Hora de término: " + DtoC(Date()) + ' - ' + Time()

Alert(cTempoRot)

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
Local nQtdLin    := 58
Local nColuna    := 00
Local nOrdSel    := aReturn[8]
Local nVlTot     := 0
Local nTvalor    := 0

Local nLoop      := 0
Local cProduto   := ""
Local nTotPrADU  := 0
Local nTotPrCAGE := 0
Local nTotPrVDS  := 0
Local cOperadora := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista criticas                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aPlano) > 0 .OR. Len(aCARGER) > 0 //.OR. Len(aVDS) > 0  //testo tambem o vetor aCARGER e aVDS. Alterado em 10/12/10. Renato Peixoto.  Não vai mais gerar pagamento VDS
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//Lanc. Produto                                  Quant.  Vlr.Unit       Valor
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
	//XXX   XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
	
	
	//	cTitulo := "Produtos com ADU - " + Iif(MV_PAR11 = 1," RIO DE JANEIRO"," SAO PAULO")
	cTitulo := "Produtos com ADU"
	cCabec1 := "Ativos ate: "+Dtoc(Mv_Par02)+"   Nome do Arquivo: "+cArquivo
	//Alterado por Renato Peixoto em 08/09/10
	//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	If MV_PAR08 = 2 //analítico
		Tamanho := "M"
		Limite	:= 132
		//cCabec2 := "Matrícula                        Nome Usuário                                                   Valor Unitário" 
		cCabec2 := "Matrícula                        Nome Usuário                                     Idade         Valor Unitário" 
	Else
		cCabec2 := "Produto                                  Quant.  Vlr.Unit       Valor"  //"Produto                                            Quant."
	EndIf //Fim alteração Renato.
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
		//nLoop++
		
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
		//Alteração Renato Peixoto para tratar relatório analítico
		//Verifica se trocou de plano
		//aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR}
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //se for relatório analítico
			If cProduto <> aPlano[i,1]
				If i > 1
					Li++
					@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
					@ Li, 096 pSay nTotPrADU Picture "@R 999,999,999.99"//095
					Li++
					@ Li,  0 pSay Replicate("-",Limite)
					Li++	
					nTotPrADU := 0
				EndIf
				cProduto := aPlano[i,1]
				/*If nLoop > 1
					If  Li > nQtdLin
						Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
						Li := 9
					Endif
				Else*/ 
					Li+=2
					@ Li, 000 pSay /*"Código ADU: "+aPlano[i,3]+" - */"Produto: "+aPlano[I,1] +"-" + aPlano[I,2]
					Li++
				//EndIf
			EndIf
			Li++
			@ Li, 000 pSay aPlano[I,4]+aPlano[i,5]+aPlano[i,6]
			@ Li, 035 pSay aPlano[I,7]
			@ Li, 084 pSay aPlano[I,21]//idade
			@ Li, 095 pSay nVlADU Picture "@R 999,999,999.99"
			//Li++
			nTusu++
			nVlTot += nVlADU
			nTotPrADU += nVlADU
		Else			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime linha de detalhe                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@ Li, 000 pSay aPlano[I,4]
			@ Li, 006 pSay aPlano[I,1] +"-" + aPlano[I,2]
			@ Li, 047 pSay aPlano[I,3] Picture "@R 999999"
			@ Li, 055 pSay nVlADU Picture "@R 999,999,999.99"
			@ Li, 063 pSay aPlano[I,3]*nVlADU Picture "@R 9,999,999.99"
			Li ++
			nTusu := nTusu + aPlano[I,3]
			nVlTot += (aPlano[I,3]*nVlADU)
		EndIf
		cOperadora := aPlano[i][4]
	Next
	
	cTitulo := "Produtos com Carteira Gerenciada"
	//Produto                                  Quant.  Vlr.Unit       Valor
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
	//XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
	//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	If MV_PAR08 = 2 //analítico
		Li++
		@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
		@ Li, 096 pSay nTotPrADU Picture "@R 999,999,999.99"//095
		Li++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		@ Li, 000 pSay "Total ADU"
		@ Li, 034 pSay "Quantidade de Usuários: "
		@ Li, 058 pSay nTusu Picture "@R 99999"
		@ Li, 090 pSay nVlTot Picture "@R 9,999,999.99"
		nTValor += nVlTot
	
		Li ++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		Li ++
		
		cCabec2 := "Matrícula                        Nome Usuário                                     Idade         Valor Unitário" 
	
		Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
		Li := 9
		@ Li, 000 pSay "CARTEIRA GERENCIADA"
		Li ++
		Li ++
	Else
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		@ Li, 000 pSay "Total ADU"
		@ Li, 041 pSay nTusu Picture "@R 99999"
		@ Li, 053 pSay nVlTot Picture "@R 9,999,999.99"
		nTValor += nVlTot
	
		Li ++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		Li ++
		
		@ Li, 000 pSay "CARTEIRA GERENCIADA"
		Li ++
		Li ++
	EndIf
	
	nTusu := 0
	nVlTot := 0
	//nLoop := 0
	
	For i := 1 to len(aCARGER)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLoop++
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
		//Aadd(aCARGER, {cCodPla,cDesPla,cCdCGer, TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR})
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //se for relatório analítico
			If cProduto <> aCARGER[i,1]
				If i > 1
					Li++
					@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
					@ Li, 096 pSay nTotPrCAGE Picture "@R 999,999,999.99"
					Li++
					@ Li,  0 pSay Replicate("-",Limite)
					Li++	
					nTotPrCAGE := 0
				EndIf
				cProduto := aCARGER[i,1]
				/*If nLoop > 1
					If  Li > nQtdLin
						Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
						Li := 9
					Endif
				Else*/ 
					Li+=2
					@ Li, 000 pSay /*"Código Carteira Gerenciada: "+aCARGER[i,3]+" - */"Produto: "+aCARGER[I,1] +"-" + aCARGER[I,2]
					Li++
				//EndIf
			EndIf
			Li++
			@ Li, 000 pSay aCARGER[I,4]+aCARGER[i,5]+aCARGER[i,6]
			@ Li, 035 pSay aCARGER[I,7]
			//@ Li, 084 pSay aCARGER[I,8]//idade
			@ Li, 084 pSay aCARGER[I,21]//idade
			@ Li, 095 pSay nVlCGER Picture "@R 999,999,999.99"
			//Li++
			nTusu++
			nVlTot += nVlCGER
			nTotPrCAGE += nVlCGER
		Else//se for sintético
			@ Li, 000 pSay aCARGER[I,4]
			@ Li, 006 pSay aCARGER[I,1] + "-" + aCARGER[I,2]
			@ Li, 047 pSay aCARGER[I,3] Picture "@R 999999"
			@ Li, 055 pSay nVlCGER Picture "@E 999,999,999.99"
			@ Li, 063 pSay aCARGER[I,3]*nVlCGER Picture "@E 9,999,999.99"
			Li ++
			nTusu := nTusu + aCARGER[I,3]
			nVlTot += (aCARGER[I,3]*nVlCGER)
		EndIf
		cOperadora := aCARGER[i][4]
	Next
	
	cTitulo := "Produtos com VDS"
	//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	If MV_PAR08 = 2 //analítico
		Li++
		@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
		@ Li, 096 pSay nTotPrCAGE Picture "@R 999,999,999.99"
		Li++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
		@ Li, 034 pSay "Quantidade de Usuários: "
		@ Li, 058 pSay nTusu Picture "@R 99999"
		@ Li, 090 pSay nVlTot Picture "@E 9,999,999.99"
		nTValor += nVlTot
		
		Li ++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		Li ++
		/*cCabec2  := "Matrícula                        Nome Usuário                               Sinistralidade      Valor Unitário" 
		Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
		Li := 9
		@ Li, 000 pSay "VIGILANCIA - VDS"
		Li ++*/ //Comentado em 08/02/2011, pois não mais irá tratar o VDS, de acordo com o Roberto.
		Li ++
	Else
	 	@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
		@ Li, 041 pSay nTusu Picture "@R 99999"
		@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
		nTValor += nVlTot
	
		Li ++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		/*Li ++     Comentado em 08/02/2011, pois nao irá mais tratar o VDS, de acordo com o Roberto.
	
		@ Li, 000 pSay "VIGILANCIA - VDS"
		Li ++ */
		Li ++
	EndIf
	nTusu := 0
	nVlTot := 0
	//nLoop := 0
	/* Não vai mais gerar VDS. Comentado por Renato Peixoto em 03/02/2011
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
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //se for relatório analítico
			If cProduto <> aVDS[i,1]
				If i > 1
					Li++
					@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
					@ Li, 098 pSay nTotPrVDS Picture "@R 999,999,999.99"
					Li++
					@ Li,  0 pSay Replicate("-",Limite)
					Li++	
					nTotPrVDS := 0
				EndIf
				cProduto := aVDS[i,1]
				/*If nLoop > 1
					If  Li > nQtdLin
						Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
						Li := 9
					Endif
				Else */
	/*				Li+=2
					@ Li, 000 pSay /*"Código VDS: "+aVDS[i,3]+" - *///"Produto: "+aVDS[I,1] +"-" + aVDS[I,2]
	/*				Li++
				//EndIf
			EndIf
			Li++
			@ Li, 000 pSay aVDS[I,4]+aVDS[i,5]+aVDS[i,6]
			@ Li, 035 pSay aVDS[I,7]
			//@ Li, 080 pSay aVDS[I,8] Picture "@R 999,999.99" //Sinistralidade
			@ Li, 080 pSay aVDS[I,21] Picture "@R 999,999.99"//Sinistralidade. A posição foi alterada para adaptar à rotina de inclusão contas médicas. Renato Peixoto em 05/11/2010 
			@ Li, 099 pSay nVlVDS Picture "@R 999,999,999.99"
			//Li++
			nTusu++
			nVlTot += nVlVDS
			nTotPrVDS += nVlVDS
		Else//se for sintético
			@ Li, 000 pSay aVDS[I,4]
			@ Li, 006 pSay aVDS[I,1] +"-" + aVDS[I,2]
			@ Li, 047 pSay aVDS[I,3] Picture "@R 999999"
			@ Li, 055 pSay nVlVDS Picture "@E 999,999,999.99"
			@ Li, 063 pSay aVDS[I,3]*nVlVDS Picture "@E 9,999,999.99"
			Li ++
			nTusu := nTusu + aVDS[I,3]
			nVlTot += (aVDS[I,3]*nVlVDS)
		EndIf
		cOperadora := aVDS[i][4]
	Next *///Não vai mais gerar VDS. Comentado por Renato Peixoto em 03/02/2011
	//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	If MV_PAR08 = 2 //analítico
		/*Li++Não vai mais gerar VDS. Comentado por Renato Peixoto em 03/02/2011
		@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_DESCRI"))
		@ Li, 098 pSay nTotPrVDS Picture "@R 999,999,999.99"
		Li++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		@ Li, 000 pSay "Total VDS"
		@ Li, 034 pSay "Quantidade de Usuários: "
		@ Li, 058 pSay nTusu Picture "@R 99999"
		@ Li, 092 pSay nVlTot Picture "@E 9,999,999.99"
		nTValor += nVlTot*/
		Li ++
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		Li ++
		@ Li, 041 pSay "TOTAL GERAL"
		@ Li, 092 pSay nTValor Picture "@E 9,999,999.99"
	Else
		/*@ Li,  0 pSay Replicate("-",Limite) Não vai mais gerar VDS. Comentado por Renato Peixoto em 03/02/2011
		Li ++
		@ Li, 000 pSay "Total VDS"
		@ Li, 041 pSay nTusu Picture "@R 99999"
		@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
		nTValor += nVlTot
		Li ++   */
		@ Li,  0 pSay Replicate("-",Limite)
		Li ++
		Li ++
		@ Li, 041 pSay "TOTAL GERAL"
		@ Li, 057 pSay nTValor Picture "@E 9,999,999.99"
	EndIf
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

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Alguns parâmetros foram retirados dessa rotina, pois a partir do momento que esta passou a ser³
//³via inclusão de guias no contas médicas, não seriam mais necessários uma série de parâmetros  ³
//³que antes eram utilizados nesta mesma rotina, quando a geração do pagamento era feita via l   ³
//³lançamento débito/crédito.                                                                    ³
//³                                                                                              ³
//³By: Renato Peixoto                                                                            ³
//³Data: 24/12/10                                                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
Aadd(aRegs,{cPerg,"01","Data Inicial?              ","","","MV_CH1","D",08,0,0,"G","           ","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data Final?                ","","","MV_CH2","D",08,0,0,"G","           ","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Diretorio do Arquivo?      ","","","MV_CH3","C",60,0,0,"G","           ","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
//Não está em uso. Comentado em 21/10/2010 por Renato Peixoto.
//Aadd(aRegs,{cPerg,"04","Tipos de Arquivo?          ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Atendimento Domiciliar","","","","","Todos Produtos","","","","","","","","","","","","","","","","","","","",""})
//Os parâmetros abaixo tiveram que ser renomeados, já que os parâmetros MV_PAR04 e MV_PAR09 foram retirados
Aadd(aRegs,{cPerg,"04","Tipos de Usuarios?         ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Envia todos","","","","","Env.Tit.C/Dep","","","","","Envia so Titular","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Ano Competencia?           ","","","MV_CH5","C",04,0,0,"G","           ","Mv_Par05","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Mes Competencia?           ","","","MV_CH6","C",02,0,0,"G","PlsVldMes()","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Gera o Arquivo?            ","","","MV_CH7","N",01,0,0,"C","           ","Mv_Par07","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//MV_PAR09 não está em uso. Comentado em 21/10/2010 por Renato Peixoto.
//Aadd(aRegs,{cPerg,"09","Informa Grupo Empresa?     ","","","MV_CH9","N",01,0,0,"C","           ","Mv_Par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})

//MV_PAR08 comentado em 24/12/10, pois não será mais necessário gerar lançamento débito/crédito, já que o pagamento será feito via inclusão de guias no contas médicas. Renato Peixoto em 24/12/10
//Aadd(aRegs,{cPerg,"08","Gera Lanc. Debito/Credito? ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Fim alteração Renato Peixoto.

//MV_PAR11 e 12 não estão em uso. Comentado por Renato Peixoto em 21/10/2010
//Aadd(aRegs,{cPerg,"11","Qual a Localidade?         ","","","MV_CHB","N",01,0,0,"C","           ","Mv_Par11","Rio de Janeiro","","","","","Sao Paulo","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"12","Gera Contas Médicas?       ","","","MV_CHC","N",01,0,0,"C","           ","Mv_Par12","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
Aadd(aRegs,{cPerg,"08","Tipo de Relatório?         ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sintético","","","","","Analítico","","","","","","","","","","","","","","","","","","","",""})
//Renato Peixoto. 24/12/10. Parâmetro MV_PAR10 passa a ser MV_PAR09 devido a eliminação do parâmetro de geração déb./créd.
Aadd(aRegs,{cPerg,"09","Data do Evento:           ","","","MV_CH9","D",08,0,0,"G","           ","Mv_Par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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
*/ /*
User Function gerdebcre(cCODRDA,aPlano,aCARGER,aVDS,cAno,cMes,nVlADU,nVlVDS,nVlCGER)

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

Return(NIL)  */ //Não vai mais gerar debito/credito. Agora somente via contas médicas.





          




//Trecho a ser alterado para gerar contas médicas rateio ADU. O trecho abaixo está tratando o AAG. Necessita alteração
//Renato Peixoto
//15/10/10

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERCTAEST   ºAutor  ³Renato Peixoto    º Data ³  21/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina que irá gerar o contas médicas para o rateio ADU.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GERCTAEST(aVetor,cTpProduto)

//Local aArray1  := {}
Local cQuery   := " "
Local cQuery2  := ""
Local cArqQry  := GetNextAlias()
Local cArqQry2 := GetNextAlias()

Private cCodEmpre := ""
Private cMatric   := ""
Private cTipreg   := ""
Private cDigito   := ""
Private cNomInt   := ""
Private nValProj  := 0
Private cLocalBB8 := ""
Private cCodLoc   := ""
Private cDesLocBB8:= "" 
Private cBB8END   := ""
Private cBB8NR_END:= ""
Private cBB8COMEND:= ""
Private cBB8BAIRRO:= ""
Private cCodEsp   := ""
Private cCodPro   := ""
Private cCodPad   := "16"
Private aArray1   := {}
Private cTipProd  := cTpProduto
Private nContGeral:= 0
//(aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,cProADU})
/*campos utilizados na query do caba022:
cQuery := "SELECT bf4_ynupre nupre, bf4_codpro, bf4_datbas, bf4_datblo, bf4_motblo, ba1_matvid, ba1_codint, ba1_codemp, ba1_matric, ba1_tipreg, "+c_ent
cQuery += "ba1_digito,ba1_nomusr, ba1_datblo, ba1_telefo, ba1_sexo, ba1_matant, ba1_conemp, ba1_vercon, ba1_subcon, ba1_versub, BA3_CODPLA, BI3_DESCRI, "+c_ent
cQuery += "PA6_CODINT, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_DTINI, PA6_CODLOC "+c_ent
cQuery += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
*/
/*
If cTpProduto = "ADU"
	nContGeral := nContPlano
ElseIf cTpProduto = "CARGER"
	nContGeral := nContCGER
Else
	nContGeral := nContVDS
EndIf */
If cTpProduto = "ADU"
	nContGeral := nContPlano
Else 
	nContGeral := nContCGER
EndIf

cCodPro   := TRIM(aVetor[nContGeral][10])

oProcess:SetRegua2(nCont)

//While !((cArqQry)->(Eof()))
    
    aArray1 := {}//zero o vetor a cada loop
    
	oProcess:IncRegua2("Inclusão de contas médicas para rateio "+cTipProd+"...")
	//nLoop++ 
	/*cCodEmp     := (cArqQry)->BA1_CODEMP
    cMatric     := (cArqQry)->BA1_MATRIC
    cTipreg     := (cArqQry)->BA1_TIPREG
	cDigito     := (cArqQry)->BA1_DIGITO */
	cCodEmpre  := aVetor[nContGeral][5]
	cMatric    := aVetor[nContGeral][6]
	cTipReg    := aVetor[nContGeral][11]
	cDigito    := aVetor[nContGeral][12]
	
	cCodInt    := aVetor[nContGeral][4]
	cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")
	nValProj   := aVetor[nContGeral][9]
	
    cCodRDA:=TRIM(aVetor[nContGeral][8]) // ALTAMIRO


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
		Return
	EndIf

	If Empty(cCodEsp)
		APMSGSTOP("Atenção, não existe especialidade cadastrada para o RDA "+aVetor[nContGeral][8]+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
		Return
	EndIf
		
	aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
	{"CODRDA",aVetor[nContGeral][8]},;
	{"OPERDA",cCodInt},;
	{"CODINT",cCodInt},;  //No BD5 é CODOPE
	{"NOMINT",cNomInt},;
	{"DATA",aVetor[nContGeral][23]},; 
	{"DATPRO", aVetor[nContGeral][23]},; 
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
	{"ANOPAG",SUBSTR(aVetor[nContGeral][24],1,4)},;
	{"MESPAG",SUBSTR(aVetor[nContGeral][24],5,2)},;
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
	{"DATDIG",aVetor[nContGeral][23]},;
	{"CODPAD","16"},;
	{"CODPRO",cCodPro},;
	{"TIPPRE",BAU->BAU_TIPPRE},;
	{"DTDIG1",aVetor[nContGeral][23]},;
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
	//falta colocar TIPATE (01-Remocao;02-Pequena Cirurgia; 03-Terapia; 04-Consulta; 05-Exame; 06-Atend. Domiciliar; 07-SADT Intern; 08-Quimioterapia; 09-Radioterapia; 10-TRS
	/*
	If (cArqQry)->PA6_CODNUP <> cNUPRE .AND. nLoop <> 1
		cNUPRE := (cArqQry)->PA6_CODNUP
		nValor := (cArqQry)->PA6_VALIND
	
		nTotGer   += nTotNupre
		nQtdGeral += nQtdNUPRE
		nTotNupre := 0
		nQtdNUPRE := 0
	    
		U_CABAGRVGUI //chama a função que irá incluir a PEG e Guias automaticamente
		
	EndIf
	*/
/*	If nLoop = 1
	
		cNUPRE := (cArqQry)->PA6_CODNUP
		nValor := (cArqQry)->PA6_VALIND
		
	EndIf
	*/
    cAnoBaseN:= SUBSTR(aVetor[nContGeral][24],1,4)
	cMesBaseN:= SUBSTR(aVetor[nContGeral][24],5,2)

   	U_GRVGUIEST()  
   	
   	oProcess:IncRegua2("Processando...")
   	
  //	(cArqQry)->(DbSkip())
	   		
//Enddo

//dbSelectArea(cArqQry)
//(cArqQry)->(dbCloseArea())

//APMSGINFO("Processo de inclusão automática de contas médicas finalizado com sucesso. O Relatório de total de usuários por NUPRe será exibido em seguida. Por favor, aguarde.","Processo finalizado.")
//Chama o relatório de qtd de usuários por NUPRE
//U_CABR027(,dDataFim,cLocalDe,cLocalAte,cCompet,dDtEvento,cGeraCtaM,cTipoRel,cProjeto,cOperIni,cOperFin,cCodRdaIni,cCodRdaFim) 

Return





//Fazer em 08/11/2010: Falta somente ver variáveis dessa função e dar uma revisada geral.... depois, colocar para processa para testar
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GRVGUIEST  ³ Autor ³ Luzio Tavares        ³ Data ³ 24.06.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grava dados de consulta em um PEG e GUIA                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function GRVGUIEST(/*cNumAte,DdDataBase*/)
Local I__f := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara variaveis da rotina...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nH := PLSAbreSem("GRVGUIEST.SMF")
LOCAL cNumGuia
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
Local lNewPeg	  := .F.

PRIVATE cOpeRDA   := cCodInt
//PRIVATE cCodRDA   := cCodRda já é declarada como private na função que chama esta
PRIVATE cNomRDA   := BAU->BAU_NOME
PRIVATE cTipRDA   := BAU->BAU_TIPPE
PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel
PRIVATE cNewPEG
PRIVATE aDadUSR   := PLSDADUSR(cCodInt+cCodEmp+cMatric+cTipreg+cdigito,"1",.T.,DdDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado
Private aArea     := GetArea() //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbSetOrder(4)) //BCI_FILIAL+BCI_OPERDA+BCI_CODRDA+BCI_ANO+BCI_MES+BCI_TIPO+BCI_FASE+BCI_SITUAC+BCI_TIPGUI+BCI_CODLDP+BCI_ARQUIV

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf   

nHESP := PLSAbreSem("PLSPEG.SMF")      

//Leonardo Portella - 23/07/15 - Inicio - Verificar se existe PEG ativa/pronta ou ativa/digitacao para inclusao

lNewPeg := .T.
BCI->(MsSeek(xFilial("BCI") + cOpeRDA + cCodRDA + cAnoBase + cMesBase))

While !BCI->(EOF()) .and. BCI->( BCI_FILIAL + BCI_OPERDA + BCI_CODRDA + BCI_ANO + BCI_MES ) == ( xFilial("BCI") + cOpeRDA + cCodRDA + cAnoBase + cMesBase )

	//Incluído eletronicamente e Nao Faturada e Ativa e Local Digitacao Rateio
	If 	( BCI->BCI_TIPO == '2' ) .and. ;
		( BCI->BCI_FASE <> '4' ) .and. ;
		( BCI->BCI_SITUAC == '1' ) .and. ;
		( BCI->BCI_CODLDP == '0021' )

		lNewPeg := .F.
		Exit		
	EndIf	
	
	BCI->(DbSkip())
	
EndDo

If lNewPeg
//If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoBase+cMesBase+"211")) //2 - incluído eletronicamente; 1-em digitacao; 1- ativo

//Leonardo Portella - 23/07/15 - Fim 
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0021'//"0001" //GetNewPar("MV_PLSPEGE","0001")
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
	BCI->BCI_DATREC := DdDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := DdDataBase//dDtEvento
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
		//	CONOUT("Gravacao de itens nao implementada") //
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
	BD6->BD6_DESBPF := "PAGAMENTO "+cTipProd //"RATEIO NUPRE"
	BD6->BD6_MOTBPF := "501" 
	BD6->BD6_DTDIGI := dDataBase
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
	If cCodPro == cProAdu  //80170315            
		BD7->BD7_CODUNM := 'REA'
	ElseIf cCodPro == cProCGER  //80170471
	  	BD7->BD7_CODUNM := 'RE1'          
	Endif
	BD7->BD7_FATMUL := 1
	BD7->BD7_REFTDE := nValProj
	BD7->BD7_UNITDE := 'R$'
	BD7->BD7_PROBD7 := '1'
	BD7->BD7_VALORI := nValProj

	BD7->BD7_DTDIGI := dDataBase
	//FIM 
	If BD7->BD7_CODPLA <> cCodPla
		BD7->BD7_CODPLA := cCodPla
	Endif
	BD7->(MsUnlock())
EndIf
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
	
	//Leonardo Portella - 13/11/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
    aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,DdDataBase,.F.,,,,,cAliasPri,{}}
    //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,DdDataBase,.F.,,,,,cAliasPri}
         
    //Leonardo Portella - 13/11/13 - Fim
     
    cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
    aRetAux := &(cMacro)
    
    //BIANCHINI - 04/05/2019 - AJUSTES P12 - LIMPANDO A GLOSA EM BD6 E BD7 NA MARRA. GLOSANDO 100%.ESSE PRESTADOR NÃO PODE USAR O PARAMETRO
    //NOVO(BAU_TPCALC) PARA PAGAR VALORES APRESENTADOS VISTO QUE ELE APRESENTA OUTRAS GUIAS EM DIFERENTES LOCAIS, CODIGOS E VALORES
    //O RATEIO NÃO PODE GLOSAR
    DbSelectArea("BD6")
	DbSetOrder(1)
	If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
		
		RecLock("BD5",.F.)
		    BD5->BD5_DTDIGI := DdDataBase
		BD5->(MsUnlock())
		
		RecLock("BD6",.F.)
			BD6->BD6_VLRGLO := 0
			BD6->BD6_DTDIGI := DdDataBase
		BD6->(MsUnlock())
	Endif

	DbSelectArea("BD7")
	DbSetOrder(1)
	If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
		RecLock("BD7",.F.)
			BD7->BD7_VLRGLO := 0
			BD7->BD7_DTDIGI := DdDataBase
		BD7->(MsUnlock())
	Endif
	    
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza transacao fisica...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSFechaSem(nH,"GRVGUIEST.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea) //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

Return
