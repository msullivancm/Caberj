#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
CORRECOES A SEREM PROGRAMADAS NA ROTINA
OK 1 - Nao enviar guias cuja data do procedimento estiver maior que a data do bloqueio do usuario. customizado em 02072009 por L๚zio
OK	2 - Nao enviar guias cuja data do procedimento for menor que a data da inclusao do beneficiario no contrato.
OK 3 - Verificar se a funcional esta com mais de 1 - (tracinho) na BA1_MATEMP. Nao enviar e gerar no relatorio.
4 - Criar relatorio de criticas para as guias nao enviadas pelo motivo acima. Mensagem 76.
OK 5 - Enviar como *Estorno (3)* todas as guias com fase 3 e valor diferente de 0 (zero). Verificar se o campo BD6_YERITA esta preenchido.
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFTMITAAG  บAutor  ณJean Schulz         บ Data ณ  15/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExportacao desenvolvida para enviar todos os registros em   บฑฑ
ฑฑบ          ณaberto, do mes inicial ao mes final.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA026()   //FTMITAU()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta matriz com as opcoes do browse...                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar	},;
{ "E&xportar"	, 'U_CB026EXP'     , 0 , K_Incluir		},;   //NEXPFATM
{ "&Excluir"	, 'U_CB026EXC'     , 0 , K_Excluir		},;   //NEXCFATM
{ "&Importar"	, 'U_CB026IMP'     , 0 , K_Incluir		},;   //NIMPFATM
{ "&Canc. Imp"	, 'U_CB026CAN'     , 0 , K_Incluir		},;   //NCANCIMP
{ "Legenda"     , 'U_CB026LEG'     , 0 , K_Incluir		} }   //NLEGFATM

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo e variavies para indicar o status do arquivo                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cCadastro 	:= "Log de envio/receb. arquivos Rio Previd๊ncia"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo e variavies para indicar o status do arquivo                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cCadastro	:= "Log de envio/receb. arquivos Fat. Mod. Ita๚"
PRIVATE aCdCores  	:= { 	{ 'BR_VERDE'    ,'Arquivo Gerado' },;
							{ 'BR_AZUL'     ,'Arquivo Exportado e Importado' },;
							{ 'BR_AMARELO'  ,'Exportacao Incompleta - Excluir' } }
PRIVATE aCores      := {	{ 'ZZH_STATUS = "1"',aCdCores[1,1] }	,;
							{ 'ZZH_STATUS = "2"',aCdCores[2,1] }	,;
							{ 'ZZH_STATUS = "3"',aCdCores[3,1] }	}

PRIVATE cPath 		:= ""
PRIVATE cAlias		:= "ZZH"
PRIVATE cCodExp		:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cNomeProg   := "CABA026"
PRIVATE nQtdLin     := 50
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Exportacao Ft.Mod. Ita๚"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "ZZH"
PRIVATE cPerg       := "YEXITA"+Space(10-Len("YEXITA")) 
PRIVATE nRel        := "CABA026"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Protocolo de exporta็ใo de movimentacao de usuแrios Ita๚"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE cString     := "ZZH"
PRIVATE nTipo		:=GetMv("MV_COMP")
PRIVATE nReg		:= 0
PRIVATE nHdl

PRIVATE cNameBD7	:= RetSQLName("BD7")

PRIVATE cProPar     := GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012,10101012,10101039")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Starta mBrowse...                                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZH->(DBSetOrder(1))

ZZH->(mBrowse(006,001,022,075,"ZZH" , , , , , Nil    , aCores, , , ,nil, .T.))
ZZH->(DbClearFilter())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNEXPFATM  บAutor  ณMicrosiga           บ Data ณ  21/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChama rotina de exportacao FTM Itau...                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CB026EXP()   //NEXPFATM()
Local cNomeArq	:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis de parametros do relatorio.                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cCodEmp		:= ""
PRIVATE cNumSE1		:= ""
PRIVATE cLayout		:= ""

ParSX1()
If !Pergunte(cPerg,.T.)
	MsgAlert("Exporta็ใo abortada!")
	Return
Endif

//WnRel := SetPrint(cString,nrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//
//SetDefault(aReturn,cString)
//
//If nLastKey == 27
//	Return            *
//End

Processa({|| ImpRel() }, "Buscando dados...", "", .T.)

If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpRel    บAutor  ณJean Schulz         บ Data ณ  15/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao chamada pela funcao processa para imprimir protocolo บฑฑ
ฑฑบ          ณe gerar texto para empresa.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpRel

Local aFatExp	:= {}
//Local nLin		:= 100
Local nReg		:= 0
Local cDirExp	:= GETNEWPAR("MV_YEXFTIT","\Exporta\FTMITAU\")
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""
Local nTotCob   := 0
Local cMatEmpr	:= ""
Local cMatrAnt	:= ""
Local dDatPro	:= CtoD("")
Local cDatPro	:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis de utilizacao da rotina...  			                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nCont		:= 1
Local cNumFun	:= ""
Local cNumDep	:= ""
Local cCPFUsr	:= ""
Local cNomUsr	:= ""
Local cMatTit	:= ""
Local cIndFM	:= "N"
Local nVlrPro	:= 0
Local nQtdExc	:= 0
Local aErro		:= {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis de totalizador...           			                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nQtdProcF		:= 0
Local nQtdProcFEs	:= 0
Local nVlrProcF		:= 0
Local nQtdProFM		:= 0
Local nVlrCobFM		:= 0
Local nVlrAgrFM 	:= 0
Local nVlrTFaFM 	:= 0
Local nVltTotPro	:= 0
Local nTotProcFM	:= 0
Local nTotCobrFM	:= 0
Local nTotAgreFM	:= 0
Local nTotTtFaFM	:= 0
Local aRetUti		:= {}

Local nVlTPro  := 0
Local nTCobrFM := 0
Local nTAgreFM := 0
Local nTTtFaFM := 0

Local cPadAnt	:= ""
Local cProAnt	:= ""
Local nPos		:= 0
Local nPos1		:= 0

Local aArBD6New	:= {}
Local aGetUsr	:= {}

Local lPodImp20	:= .F.

Local cMatEmpAgr := ""
Local dDatBlo	 := CtoD("  /  /    ")
Local dDatInc	 := CtoD("  /  /    ")

Local nRegAgBA1	:= 0
Local nQtdImp		:= 0
Local aImpresso	:= {}
Local nQtdTPF		:= 0
Local nVlrTPF		:= 0
Local nQtdTPFEs   := 0
Local nVlrTPFEs   := 0
Local cNomArqH14  := GetNewPar("MV_YFTMNM","MOVIMENTO DE UTILIZACAO")

Local _cCodigo	 := ""
Local nVlrTotBD7 := 0
Local cSQLTmp	 := ""

Local nPosArray := 0
Local aTTotMes    := {}
Local cClasProc   := Space(35)

Local nTotal   := 0 // recebe o n total de registros
Local nTotGer  := 0 // recebe o n total de registros
Local nProc    := 1 // incrementado por unidade de registro
Local Npercent := 0
Local cRegAte  := ""
Local nQtdCh   := 0
Local cGrpPro  := "99"

Local cArq	:= Space(0)
Local aArq	:= {}
Local cTrbl	:= CriaTrab(,.F.)
Local aArea	:= GetArea()

Local cCodPro1 := Space(0)
Local cCodTmp  := Space(0)
Local nNivel   := 0
Local lTemCoPart := .F.
Local cCodCon := GetNewPar("MV_YCONITA","000000000001")    //Codigo do Contrato do Grupo Empresa
Local cTipUsu := Space(0)
Local cCodMat := Space(0)                                  //Codigo da Matricula do Usuario completa com digito e codigo do plano
Local lBusPro := .T.

PRIVATE cCodEmp	:= ""
PRIVATE cConEmp	:= ""
PRIVATE cVerCon	:= ""
PRIVATE cAno	:= ""
PRIVATE cMes	:= ""

PRIVATE cAnoAte	:= ""
PRIVATE cMesAte	:= ""

PRIVATE cObser  := ""
PRIVATE nTotReg	:= 0

PRIVATE aVetUti := {}

PRIVATE aVetUti := {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Atualiza variaveis a partir dos parametros do pergunte.             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Atu_Var()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define indices e tabelas para uso.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BA0->(DbSetOrder(1))
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD6->(DbSetOrder(19)) //BD6->(DbSetOrder(10))
BD7->(DbSetOrder(1))
BR8->(DbSetOrder(3))
ZZG->(DbSetOrder(1))
ZZH->(DbSetOrder(1))

cDiaGer  := cMesAte+Substr(cAnoAte,3,2)
cNomeArq := cDirExp+"PS9"+Iif(cCodCon == cConEmp,"A","I")+cDiaGer+".TXT"

/*
cArq := "PS9"+Iif(cCodCon == cConEmp,"A","I")+cDiaGer

If !TcCanOpen(cArq)
	
	aAdd(aArq,{"CPOSTRING","C",500,0})
	
	DbCreate(cArq, aArq, "TOPCONN")
	
EndIf

DbUseArea(.T., "TOPCONN", cArq, cTrbl, .F., .F.)
*/

/*
If Select(cTrbl) <> 0
	(cTrbl)->(DbCloseArea())
Endif
If TcCanOpen(cTrbl)
	TcDelFile(cTrbl)
Endif

DbCreate(cTrbl,aStruct,"TopConn")

If Select(cTrbl) <> 0
(cTrbl)->(DbCloseArea())
Endif

DbUseArea(.T.,"TopConn",cTrbl,cTrbl,.T.,.F.)

(cTrbl)->(DbCommit())
*/

MsgRun("Selecionando Registros...",,{|| BuscaRegs(),CLR_HBLUE})

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Obter historico de utilizacao de todos os usuarios do arquivo...    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nProc  := 1   

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta regua                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//TRB->(DBEval({|| nTotal++ }))
//TRB->(DbGotop())

dbSelectArea("TRB")
TRB->(DbGotop())
While !TRB->(EOF())
	nTotal += 1
	TRB->(DbSkip())
EndDo

memowrit("C:\PROCESSO0.TXT",Time())
ProcRegua(nTotal)

memowrit("C:\PROCESSO1.TXT",Time())

cCodMat := Space(0)
cTipUsu := Space(0)
lBusPro := .F.
cCodPro := Space(0)

TRB->(DbGoTop())
While !TRB->(EOF())
	Npercent := (nProc/nTotal)*100
	IncProc("Proc. 1- Hist๓rico: " + Transform(Npercent,"@E 999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	If AllTrim(TRB->BD6_CODEMP) == '0006'
		If cCodMat != TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BA1_CODPLA)
			cCodMat := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BA1_CODPLA)
			cTipUsu := BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG, TRB->BA1_CODPLA)
            lBusPro := .T.
		EndIf	

		If (cCodPro != TRB->(BD6_CODPAD+BD6_CODPRO)) .or. lBusPro
			cCodPro := TRB->(BD6_CODPAD+BD6_CODPRO)
			AtuUtil(@aVetUti,TRB->BD6_OPEUSR,TRB->BD6_CODEMP,TRB->BD6_MATRIC,TRB->BD6_TIPREG,TRB->BD6_DIGITO,TRB->BD6_CONEMP,TRB->BD6_VERCON,TRB->BD6_SUBCON,TRB->BD6_VERSUB,TRB->BD6_CODPAD,TRB->BD6_CODPRO, TRB->BD6_VLRPAG, TRB->BD6_QTDPRO, cAno, cMes, TRB->BA1_CODPLA, cTipUsu, iif(Empty(Alltrim(TRB->BD6_YFTITA)),.F.,.T.))
			lBusPro := .F.
        EndIf			
	EndIf

	nProc++
	TRB->(DbSkip())
EndDo

memowrit("C:\PROCESSO2.TXT",Time())

BA1->(DbSetOrder(2))

TRB->(DbGotop())
ProcRegua(nTotal)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Gravacao do registro de log da exportacao...                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

_cCodigo := GetSx8Num("ZZH","ZZH_CODIGO")
ConfirmSx8()

ZZH->(RecLock("ZZH",.T.))
ZZH->ZZH_FILIAL := xFilial("ZZH")
ZZH->ZZH_STATUS := "1"     // "Incompleto" -- "1" //Gerado...
ZZH->ZZH_CODIGO := _cCodigo
ZZH->ZZH_DATEXP := dDataBase
ZZH->ZZH_OBSERV := cObser
ZZH->ZZH_CODEMP := cCodEmp
ZZH->ZZH_CONVER := cConEmp+cVerCon
ZZH->ZZH_ANO    := cAnoAte  //cAno
ZZH->ZZH_MES    := cMesAte  //cMes
ZZH->(MsUnlock())

cCodExp := ZZH->ZZH_CODIGO

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Gerar linhas de detalhe (registro 3)                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nProc    := 1
nQtdCh   := 0
cGrpPro  := "99"
cTipInt := Space(0)

memowrit("C:\PROCESSO3.TXT",Time())

If U_Cria_TXT(cNomeArq)

memowrit("C:\PROCESSO4.TXT",Time())

While ! TRB->(EOF())
	
	cYcdCon := TRB->BQC_YCDCON
	cCodInt := TRB->BD6_OPEUSR
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Montagem do Header...                                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cLin := Space(1)+cEOL
	cCpo :=	"01" //H01
	cCpo +=	Replicate("0",11)                                                            //H02
	If !Empty(AllTrim(TRB->BQC_YCDCON))
		cCpo +=	AllTrim(TRB->BQC_YCDCON)                                                 //H03
	Else
		If AllTrim(TRB->BD6_CODEMP) == "0006"
//			cCpo +=	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123") //H03
			cCpo +=	Iif(cCodCon == cConEmp,"01115","01123")                       //H03
		Else
//			cCpo +=	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01628","01123") //H03

    		If AllTrim(TRB->BQC_YCDCON) == "01628"
				cCpo +=	"01628" //H03
			ElseIf AllTrim(TRB->BQC_YCDCON) == "01644"
				cCpo +=	"01644" //H03
			Else
				cCpo +=	Space(05) //H03
			EndIf

		EndIf
		//			cCpo +=	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705") //H04
	EndIf
	If AllTrim(TRB->BQC_YCDCON) == "01115"
		cCpo +=	"04697" //H04
	ElseIf AllTrim(TRB->BQC_YCDCON) == "01628"
		cCpo +=	"05397" //H04
	ElseIf AllTrim(TRB->BQC_YCDCON) == "01644"
		cCpo +=	"05454" //H04
	ElseIf AllTrim(TRB->BQC_YCDCON) == "01123"
		cCpo +=	"04705" //H04
	Else
		//cCpo +=	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")
		//cCpo +=	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705") //H04
		cCpo +=	Space(05) //H04
	EndIf
	
	cCpo +=	Alltrim(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT"))+Space(50-Len(Alltrim(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT")))) //H05
	cCpo +=	Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_CGC") //H06
	cCpo +=	Space(10) //H07
	cCpo +=	"01" //H08
	cCpo +=	cCodExp //H09
	cCpo +=	"002" //H10
	cCpo +=	"001" //H11
	cCpo +=	Substr(DtoS(dDataBase),7,2)+"."+Substr(DtoS(dDataBase),5,2)+"."+Substr(DtoS(dDataBase),1,4) //H12
	cCpo +=	StrTran(Time(),":","") //H13
	cCpo +=	cNomArqH14+Space(50-Len(cNomArqH14)) //H14
	cCpo +=	Space(303) //H15
	cCpo +=	Space(10) //H16
	cCpo +=	StrZero(nCont,10) //H17
	
	nCont++
	
	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE O CABEวALHO! OPERAวรO ABORTADA!")
		Return
	Endif
	
//	(cTrbl)->(RecLock((cTrbl),.T.))
//	(cTrbl)->CPOSTRING := cCpo
//	(cTrbl)->(MsUnlock())
	
	While TRB->BQC_YCDCON == cYcdCon .And. TRB->BD6_OPEUSR == cCodInt .And. !TRB->(EOF())
		
		cCodEmp := TRB->BD6_CODEMP
		
		dDatBlo	:= CtoD("  /  /    ")
		dDatInc	:= CtoD("  /  /    ")
		
		If Empty(Dtos(TRB->BD6_DATPRO))
//			aadd(aErro,{"1360 - Data do Evento em branco. USUARIO :"+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)+" GUIA : "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
			TRB->(DbSkip())
			Loop
		Endif
		
		If Dtos(TRB->BA1_DATINC) > Dtos(TRB->BD6_DATPRO)   // .and. AllTrim(TRB->BD6_CODEMP) == "0010"
//			aadd(aErro,{"1360 - Data do Atendimento menor que a data da inclusao do usuario. USUARIO :"+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)+" GUIA : "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
			TRB->(DbSkip())
			Loop
		Endif
		
		While TRB->BQC_YCDCON == cYcdCon .And. TRB->BD6_OPEUSR == cCodInt .And. TRB->BD6_CODEMP == cCodEmp .And. !TRB->(EOF())
			
			cMatEmp := TRB->BA3_MATEMP
			
			cMatTit := Space(0)
			
			cSQLTmp := " SELECT BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG "
			cSQLTmp += " FROM "+RetSqlName("BA1")+" BA1 "
			cSQLTmp += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
			cSQLTmp += " AND BA1_CODINT = '"+AllTrim(TRB->BD6_OPEUSR)+"' "
			cSQLTmp += " AND BA1_CODEMP = '"+AllTrim(TRB->BD6_CODEMP)+"' "
			cSQLTmp += " AND BA1_MATEMP = '"+AllTrim(TRB->BA3_MATEMP)+"00' "
			cSQLTmp += " AND D_E_L_E_T_ = ' ' "
			
			PLSQUERY(cSQLTmp,"TRBBA1")
			TRBBA1->(DbGoTop())
			
			If !TRBBA1->(Eof())
				cMatTit := Substr(TRBBA1->BA1_CODINT,2,3)+TRBBA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
			Else
				TRBBA1->(DbCloseArea())
//				aadd(aErro,{"1292 - Titular nao encontrado! "+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)+"00"})
				TRB->(DbSkip())
				Loop
			Endif
			TRBBA1->(DbCloseArea())

			cCodMat := Space(0)
			
			While !TRB->(EOF()) .And. TRB->BQC_YCDCON == cYcdCon .And. TRB->BD6_OPEUSR == cCodInt .And.;
				TRB->BD6_CODEMP == cCodEmp .And. TRB->BA3_MATEMP == cMatEmp
				
				cMatric := TRB->BD6_MATRIC
				
				Npercent := (nProc/nTotal)*100
				IncProc("Proc. 2-Linha detalhe: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
				ProcessMessage()

				nProc++

				If TRB->BD6_VLRPAG == 0
					TRB->(DbSkip())
					Loop
				EndIf
				
				//Inserido por Luzio em 02/07/08 para que recupere a data de bloqueio do usuario contida no BA1
				dDatBlo := TRB->BA1_DATBLO
				dDatInc := TRB->BA1_DATINC
				
//Nao descomentar. Esta na query.
/*
				If BA1->(MsSeek(xFilial("BA1")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
					cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
					cNomUsr	:= Substr(Alltrim(BA1->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(BA1->BA1_NOMUSR),1,30)))
					//							cMatTit := Iif(BA1->BA1_TIPREG == "00",Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),Alltrim(cMatTit))
					cNumDep := BA1->BA1_YDEPEN
					
					cNumFun := Replicate("0",11-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
					If Substr(Alltrim(BA1->BA1_MATEMP),1,1) = "_"
						cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),2,11)
					ElseIf Substr(Alltrim(BA1->BA1_MATEMP),1,2) = "__"
						cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),3,11)
					ElseIf Substr(Alltrim(BA1->BA1_MATEMP),1,3) = "___"
						cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),4,11)
					Endif
				Else
					aadd(aErro,{"1354 - Usuario nao encontrado! "+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)})
					TRB->(DbSkip())
					Loop
				Endif
*/

				cCPFUsr := TRB->BA1_CPFUSR
				cNomUsr	:= Substr(Alltrim(TRB->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(TRB->BA1_NOMUSR),1,30)))
				//cMatTit := Iif(BA1->BA1_TIPREG == "00",Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),Alltrim(cMatTit))
				cNumDep := TRB->BA1_YDEPEN
					
				cNumFun := Replicate("0",11-Len(Alltrim(TRB->BA1_MATEMP)))+Alltrim(TRB->BA1_MATEMP)
				If Substr(Alltrim(TRB->BA1_MATEMP),1,1) = "_"
					cNumFun := Substr(Alltrim(TRB->BA1_MATEMP),2,11)
				ElseIf Substr(Alltrim(TRB->BA1_MATEMP),1,2) = "__"
					cNumFun := Substr(Alltrim(TRB->BA1_MATEMP),3,11)
				ElseIf Substr(Alltrim(TRB->BA1_MATEMP),1,3) = "___"
					cNumFun := Substr(Alltrim(TRB->BA1_MATEMP),4,11)
				Endif

				If cCodMat != TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BA1_CODPLA)
					cCodMat := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BA1_CODPLA)
					cTipUsu := BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG, TRB->BA1_CODPLA)
				EndIf	
								
//				dDatPro := Iif(Empty(TRB->BD6_DATPRO),	Iif(TRB->BD6_ORIMOV=="1",Posicione("BD5",1,xFilial("BD5")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO"),Posicione("BE4",1,xFilial("BE4")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")),TRB->BD6_DATPRO)
				dDatPro := TRB->BD6_DATPRO
				If Empty(AllTrim(DtoS(TRB->BD6_DATPRO)))
					If TRB->BD6_ORIMOV == "1"
						dDatPro := Posicione("BD5",1,xFilial("BD5")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO")
					Else	
						dDatPro := Posicione("BE4",1,xFilial("BE4")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")
					EndIf	
                EndIf

				If Empty(allTrim(DtoS(TRB->BD6_DATPRO)))
//					aadd(aErro,{"1360 - Data do Evento em branco. USUARIO :"+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)+" GUIA : "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
					TRB->(DbSkip())
					Loop
				Endif

				cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
				
				//					// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento
				//					// for maior que a data de bloqueio do usuario.
				//					If (dDatPro > dDatBlo) .and. !Empty(dDatBlo)    //TRB->BD6_DATPRO > dDatBlo
				//						aadd(aErro,{"1355 - Data do Atendimento maior que a data do bloqueio. USUARIO :"+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)+" GUIA : "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
				//						TRB->(DbSkip())
				//						Loop
				//					Endif
				
				If Dtos(dDatInc) > Dtos(TRB->BD6_DATPRO) .and. AllTrim(cCodEmp) == "0010"
//					aadd(aErro,{"1360 - Data do Atendimento menor que a data da inclusao do usuario. USUARIO :"+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)+" GUIA : "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
					TRB->(DbSkip())
					Loop
				Endif
				
				nQtdExc := 0
				nVlrExc := 0
				nVlrPro := 0
				cIndFM := "N"
				nPos1 := 0

                If AllTrim(cCodEmp) == '0006'
//					nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
					nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) } )
				
					If nPos > 0
					
						While nPos <= Len(aVetUti)
							
							If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
								nPos1 := 0
								Exit
							Endif
						
							If ( aVetUti[nPos,3] $ Iif(Alltrim(TRB->BD6_CODPRO) $ cProPar,"00010014",Alltrim(TRB->BD6_CODPRO)) ) .or.  ;
							   ( aVetUti[nPos,3] $ Iif(Alltrim(TRB->BD6_CODPRO) $ cProPar,"10101012",Alltrim(TRB->BD6_CODPRO)) )
								nPos1 := nPos
								Exit
							Endif
						
							nPos++
						
						Enddo
						If nPos1 > 0 .And. aVetUti[nPos1,7] > 0 .And. aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+TRB->BD6_QTDPRO
							cIndFM := "S"
							nQtdExc := TRB->BD6_QTDPRO
							nVlrPro := (aVetUti[nPos1,8]*nQtdExc)
						EndIf
					Endif
				EndIf
				
				nVlrTotBD7 := TRB->BD6_VLRPAG
				
//Nao descomentar estre trecho, pois esta embutida na query principal
				/*
				If TRB->REENB == '0' .and. TRB->BD6_CODPRO != '83000089'
				
				cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
				cSQLTmp += " FROM "+RetSqlName("BD7")+" BD7 "
				//		cSQLTmp += " FROM BD7010AUXFM BD7 "
				//		cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
				cSQLTmp += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "' "
				cSQLTmp += " AND BD7_CODOPE = '"+TRB->BD6_CODOPE+"' "
				cSQLTmp += " AND BD7_CODLDP = '"+TRB->BD6_CODLDP+"' "
				cSQLTmp += " AND BD7_CODPEG = '"+TRB->BD6_CODPEG+"' "
				cSQLTmp += " AND BD7_NUMERO = '"+TRB->BD6_NUMERO+"' "
				cSQLTmp += " AND BD7_ORIMOV = '"+TRB->BD6_ORIMOV+"' "
				cSQLTmp += " AND BD7_SEQUEN = '"+TRB->BD6_SEQUEN+"' "
				cSQLTmp += " AND BD7_CODPAD = '"+TRB->BD6_CODPAD+"' "
				cSQLTmp += " AND BD7_CODPRO = '"+TRB->BD6_CODPRO+"' "
				
				//Habilitar
				//		Inserido por Luzio para que considere apenas as composicoes que foram realmente pagas
				If Empty(Alltrim(TRB->BD6_YFTITA))  //.or. Substr(TRB->BD6_YERITA,1,1) == "R"     // Somo se nao for estorno de servico medico
				cSQLTmp += " AND BD7_VLRPAG > 0 "
				If !Empty(Alltrim(TRB->BD7_NUMLOT)) // Verifica se a guia ja foi paga
				cSQLTmp += " AND BD7_BLOPAG <> '1' "
				cSQLTmp += " AND BD7_NUMLOT <> '     ' "
				Else                               // Paga as guias do OPME
				cSQLTmp += " AND BD7_BLOPAG = '1' "
				cSQLTmp += " AND BD7_NUMLOT = '     ' "
				EndIf
				cSQLTmp += "AND BD7_NUMLOT BETWEEN '"+cAno+cMes+"0000' AND '"+cAnoAte+cMesAte+"9999' "
				//							cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) >= '"+cAno+cMes+"'0000 "
				//							cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) <= '"+cAnoAte+cMesAte+"' "
				EndIf
				cSQLTmp += " AND D_E_L_E_T_ = ' ' "
				
				PLSQUERY(cSQLTmp,"TRBBD7")
				nVlrTotBD7 := TRBBD7->TOTPAG
				TRBBD7->(DbCloseArea())
				Else
				nVlrTotBD7 := TRB->BD6_VLRPAG
				
				EndIf
				*/
				
				If nVlrTotBD7 == 0
					TRB->(DbSkip())
					Loop
				EndIf
				
				cNomRDABD6 := TRB->BD6_NOMRDA
				If Empty(cNomRDABD6)
					cNomRDABD6 := Posicione("BAU",1,xFilial("BAU")+TRB->BD6_CODRDA,"BAU_NOME")
				Endif
				
				cClasProc := Space(35)
				cGrpPro   := "99"
				cTipInt   := Space(0)
				
				If TRB->BD6_TIPGUI == '03'
					cClasProc := "HOSPITALAR/INTERNACAO"+Space(35-len("HOSPITALAR/INTERNACAO"))
					cSQL := " SELECT BE4_GRPINT "
					cSQL += " FROM "+RetSqlName("BE4")+" BE4 "
					cSQL += " WHERE BE4_FILIAL = '" + xFilial("BE4") + "' "
					cSQL += " AND BE4_CODOPE = '"+TRB->BD6_CODOPE+"' "
					cSQL += " AND BE4_CODLDP = '"+TRB->BD6_CODLDP+"' "
					cSQL += " AND BE4_CODPEG = '"+TRB->BD6_CODPEG+"' "
					cSQL += " AND BE4_NUMERO = '"+TRB->BD6_NUMERO+"' "
					cSQL += " AND BE4_ANOPAG = '"+TRB->BD6_ANOPAG+"' "
					cSQL += " AND BE4_MESPAG = '"+TRB->BD6_MESPAG+"' "
					cSQL += " AND D_E_L_E_T_ = ' ' "
					PLSQUERY(cSQL,"TRBBE4")
					cTipInt := TRBBE4->BE4_GRPINT
					TRBBE4->(DbCloseArea())
					If cTipInt == "5" //Internacao psiquiatrica
						cGrpPro := "04"
					EndIf
				Else
					cRegAte := space(0)
					cSQL := " SELECT DISTINCT BD5_REGATE "
					cSQL += " FROM "+RetSqlName("BD5")+" BD5 "
					cSQL += " WHERE BD5.BD5_FILIAL = '" + xFilial("BD5") + "' "
					cSQL += " AND BD5.BD5_CODOPE = '"+TRB->BD6_CODOPE+"' "
					cSQL += " AND BD5.BD5_CODLDP = '"+TRB->BD6_CODLDP+"' "
					cSQL += " AND BD5.BD5_CODPEG = '"+TRB->BD6_CODPEG+"' "
					cSQL += " AND BD5.BD5_NUMERO = '"+TRB->BD6_NUMERO+"' "
					cSQL += " AND BD5.D_E_L_E_T_ = ' ' "
					PLSQUERY(cSQL,"TRBBD5")
					cRegAte := TRBBD5->BD5_REGATE
					TRBBD5->(DbCloseArea())
					
					If cRegAte == '1'  //regime de internacao
						cClasProc := "SADT INTERNADO"+Space(35-len("SADT INTERNADO"))
					Else
						If TRB->BR8_YEVCAB == 1   //TRB->BR8_YNEVEN == 1   //CONSULTAS
							cClasProc := "CONSULTAS"+Space(35-len("CONSULTAS"))
							cGrpPro   := "03"
							//If cCodEmp ==  '0010'
								cIndFM  := "S"
								nVlrPro := (nVlrTotBD7 * 20)/100
							//EndIf
						Else
							lTemCoPart := .F.

							If cCodEmp == '0010'
								//Verifica na BD7 o total de CH do procedimento para os procedimentos, menos para consulta
								DbSelectArea("BD7")
								BD7->(DbSetOrder(2))
								If BD7->(MsSeek(xFilial("BD7")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO)))
									While !BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO) == xFilial("BD6")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO)
										If BD7->BD7_CODUNM $ ("HM_COP_UCO_CO")   //PPM_UCO
											nQtdCh += BD7->BD7_REFTDE
										ElseIf BD7->BD7_CODUNM $ ("PPM_UCO")
										
										EndIf
										BD7->(DbSkip())
									EndDo
									
									If nQtdCh <= 180
										lTemCoPart := .T.
										cIndFM  := "S"
									Else 
									   	lTemCoPart := .F.
									EndIf
								Endif
								DbSelectArea("BD7")
								BD7->(DbSetOrder(1))
							EndIf
							
							If TRB->BR8_YEVCAB == 2 .or. TRB->BR8_YEVCAB == 3   //EXAMES AMBULATORIAIS
								cClasProc := "EXAMES AMBULATORIAIS"+Space(35-len("EXAMES AMBULATORIAIS"))
								cGrpPro   := "02"
								If cCodEmp ==  '0010' .and. lTemCoPart
									cIndFM  := "S"
									nVlrPro := (nVlrTotBD7 * 20)/100
								EndIf
							ElseIf TRB->BR8_YEVCAB == 20 .or. TRB->BR8_YEVCAB == 21
								cClasProc := "TERAPIAS"+Space(35-len("TERAPIAS"))
							ElseIf TRB->BR8_YEVCAB == 6 .OR. TRB->BR8_YEVCAB == 7
								cClasProc := "PROCEDIMENTO AMBULATORIAL"+Space(35-len("PROCEDIMENTO AMBULATORIAL"))
							ElseIf TRB->BR8_YEVCAB == 23
								cClasProc := "QUIMIOTERAPIA"+Space(35-len("QUIMIOTERAPIA"))
							ElseIf TRB->BR8_YEVCAB == 24
								cClasProc := "RADIOTERAPIA"+Space(35-len("RADIOTERAPIA"))
							ElseIf TRB->BR8_YEVCAB == 22
								cClasProc := "TERAPIA RENAL SUBSTITUTIVA (TRS)"+Space(35-len("TERAPIA RENAL SUBSTITUTIVA (TRS)"))
							ElseIf TRB->BR8_YEVCAB >= 34
								cClasProc := "HOSPITALAR/INTERNACAO"+Space(35-len("HOSPITALAR/INTERNACAO"))
								//Else
								//	cClasProc := "HOSPITALAR/INTERNACAO"+Space(35-len("HOSPITALAR/INTERNACAO"))
							EndIf
						EndIf
					EndIf
				EndIf
				
				//Habilitar
				cLin := Space(1)+cEOL
				cCpo :=	"10" //D01
				cCpo += cNumFun //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03

//Nao descomentar
//				If TRB->BD6_CODEMP == '0006'
//					cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123") //D04
//					cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705") //D05
//				ElseIf TRB->BD6_CODEMP == '0010'
//					cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01628","01123") //D04
//					cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"05397","04705") //D05
//				Endif

				If AllTrim(TRB->BD6_CODEMP) == "0006"
					cCpo +=	Iif(cCodCon == cConEmp,"01115","01123")                       //D04
				Else
		    		If AllTrim(TRB->BQC_YCDCON) == "01628"
						cCpo +=	"01628" //D04
					ElseIf AllTrim(TRB->BQC_YCDCON) == "01644"
						cCpo +=	"01644" //D04
					Else
						cCpo +=	Space(05) //D04
					EndIf
				
				EndIf

				If AllTrim(TRB->BQC_YCDCON) == "01115"
					cCpo +=	"04697" //H04
				ElseIf AllTrim(TRB->BQC_YCDCON) == "01628"
					cCpo +=	"05397" //H04
				ElseIf AllTrim(TRB->BQC_YCDCON) == "01644"
					cCpo +=	"05454" //H04
				ElseIf AllTrim(TRB->BQC_YCDCON) == "01123"
					cCpo +=	"04705" //H04
				Else
					cCpo +=	Space(05) //H04
				EndIf

				cCpo += cCPFUsr //D06
				cCpo += cNomUsr //D07
				cCpo += BA1->BA1_MATRIC+Space(4) //D08   //BA1->BA1_MATRIC
				cCpo += cMatTit //D09
				cCpo += BA1->BA1_TIPREG+Space(2) //D10
				cCpo += Iif(TRB->REENB == '5',"05",Iif(Empty(TRB->BD6_YFTITA),"01","03"))      //D11   // 01-Despesas Medicas, 03-Estorno Despesas Medicas
				//cCpo += TRB->(BD6_ANOPAG+BD6_MESPAG) //D12
				cCpo += Substr(TRB->(BD7_NUMLOT),1,6) //D12
				cCpo += cDatPro //D13
				If TRB->BD6_CODLDP == '0012' .and. TRB->BD6_CODPRO != '83000089'
					cCpo += Alltrim(TRB->BD6_NOMSOL)+Space(50-Len(AllTrim(TRB->BD6_NOMSOL)))      //D14
				Else
					cCpo += Alltrim(cNomRDABD6)+Space(50-Len(Alltrim(cNomRDABD6)))                //D14
				EndIf
				cCpo += Alltrim(TRB->BD6_DESPRO)+Space(90-Len(Alltrim(TRB->BD6_DESPRO)))       //D15
				cCpo += Iif(Empty(alltrim(TRB->BD6_YFTITA)),"D","C")                           //D16
				cCpo += StrZero(nVlrTotBD7*100,15)                                             //D17
				cCpo += Iif(nVlrPro <= 0, "N",cIndFm)                                          //cIndFM //D18
				cCpo += StrZero((nVlrPro)*100,15)                                              //D19
				cCpo += TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Space(6) //D20
				cCpo += Space(20) //D21
				cCpo += "I"       //D22
				cCpo +=	Alltrim(cClasProc)+Space(35-len(Alltrim(cClasProc))) //D23
				cCpo +=	cGrpPro     //'00' //D24
				cCpo += Space(119)  //D25, D26, D27
				//					cCpo += Space(1)    //D26
				//					cCpo += Space(10)   //D27
				cCpo += StrZero(nCont,10) //D28
				
                nCont++
				lPodImp20 := .T.
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAวรO ABORTADA!")
					Return
				Endif
				
//				(cTrbl)->(RecLock((cTrbl),.T.))
//				(cTrbl)->CPOSTRING := cCpo
//				(cTrbl)->(MsUnlock())

				nTotGer += 1
				
				If cIndFM == "S"
					nQtdImp += TRB->BD6_QTDPRO
				Endif
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Nova regra: mesma guia pode ser exportada varias vezes, porem soh   ณ
				//ณ deve ser marcada na primeira exportacao. Nas demais, nao marcar...  ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				//deshabilitar
				//			If Empty(Alltrim(TRB->BD6_YFTITA))
				
				BD6->(DbGoto(TRB->(REGBD6)))
				If !BD6->(EOF())
					BD6->(Reclock("BD6",.F.))
					BD6->BD6_YFTITA := cCodExp
					BD6->BD6_YERITA := "00"
					BD6->BD6_YVLITA := nVlrPro
					BD6->BD6_YMTEMI := cNumFun
					BD6->BD6_YINFTM := cIndFM
					BD6->(MsUnlock())
				Else
					MsgAlert("Linha 1708. "+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+" registro "+StrZero(TRB->(REGBD6),10,0))
				Endif
				
				//			Endif
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Totais para linha de Trailler do detalhe...                         ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				nQtdProcF ++

//				nPosArray := Ascan(aTTotMes, { |x| AllTrim(x[1]) == Iif(Empty(Alltrim(TRB->BD6_YFTITA)),'0','1')+substr(TRB->BD7_NUMLOT,1,6)+TRB->BD6_CODPLA } )
//				If nPosArray > 0
//					aTTotMes[nPosArray,4] += nVlrTotBD7
//				Else
//					Aadd(aTTotMes, {Iif(Empty(Alltrim(TRB->BD6_YFTITA)),'0','1'), substr(TRB->BD7_NUMLOT,1,6), TRB->BD6_CODPLA, nVlrTotBD7})
//				EndIf
				

				If Empty(Alltrim(TRB->BD6_YFTITA))    // Somo se nao for estorno de servico medico
					nVlrProcF += nVlrTotBD7
					nVlrCobFM += nVlrPro
					nVlrAgrFM += Iif(cTipUsu == "T",0,nVlrPro)
					nVlrTFaFM += Iif(cTipUsu <> "T",0,nVlrPro)
				Else
					nVlrProcF -= nVlrTotBD7   // Subtrai se for estorno de servico medico
					nVlrCobFM -= nVlrPro
					nVlrAgrFM -= Iif(cTipusu == "T",0,nVlrPro)
					nVlrTFaFM -= Iif(cTipUsu <> "T",0,nVlrPro)
				EndIf
								
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Totais para linha de Trailler geral do arquivo...                   ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If Empty(Alltrim(TRB->BD6_YFTITA))    // Somo se nao for estorno de servico medico
					nVltTotPro += nVlrTotBD7
					nTotCobrFM += nVlrPro
					nTotAgreFM += Iif(cTipUsu == "T",0,nVlrPro)
					nTotTtFaFM += Iif(cTipUsu <> "T",0,nVlrPro)
				Else
					nVltTotPro -= nVlrTotBD7
					nTotCobrFM -= nVlrPro
					nTotAgreFM -= Iif(cTipUsu == "T",0,nVlrPro)
					nTotTtFaFM -= Iif(cTipUsu <> "T",0,nVlrPro)
					// Alimenta variaveis totalizadoras do estorno
					nVlTPro += nVlrTotBD7
					nTCobrFM += nVlrPro
					nTAgreFM += Iif(cTipUsu == "T",0,nVlrPro)
					nTTtFaFM += Iif(cTipUsu <> "T",0,nVlrPro)
				EndIf
				
				nQtdProFM  += Iif(cIndFM == "S",1,0)
				nTotProcFM += Iif(cIndFM == "S",1,0)

				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Zerar variaveis de fator moderador Itau...                          ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				cIndFm := "N"
				nQtdExc := 0
				nVlrPro := 0
				nVlrTotBD7 := 0
				
//				nProc++
				
				TRB->(DbSkip())
				
			EndDo
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Imprimir ultimo rodape do detalhe (registro 4)                      ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If lPodImp20
				//Habilitar
				cLin := Space(1)+cEOL
				cCpo :=	"20"+; //TD01
				substr(cNumFun,1,9)+; //TD02
				Replicate("9",12)+; //TD03
				StrZero(nQtdProcF,9)+; //TD04
				StrZero(abs(nVlrProcF)*100,15)+; //TD05
				StrZero(nQtdProFM,9)+; //TD06
				StrZero(abs(nVlrCobFM)*100,15)+; //TD07
				StrZero(abs(nVlrAgrFM)*100,15)+; //TD08
				StrZero(abs(nVlrTFaFM)*100,15)+; //TD09
				Space(370)+; //TD10
				Replicate("0",9)+; //TD11
				Replicate("0",10)+; //TD12
				StrZero(nCont,10) //TD13
				
				nCont++
				lPodImp20 := .F.
				
				nQtdTPF += nQtdProcF
				nVlrTPF += nVlrProcF
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE O TRAILLER DO DETALHE! OPERAวรO ABORTADA!")
					Return
				Endif
				
//				(cTrbl)->(RecLock((cTrbl),.T.))
//				(cTrbl)->CPOSTRING := cCpo
//				(cTrbl)->(MsUnlock())
				
				nQtdProcF := 0
				nVlrProcF := 0
				nQtdProFM := 0
				nVlrCobFM := 0
				nVlrAgrFM := 0
				nVlrTFaFM := 0
			Endif
		EndDo
		
	EndDo
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Montagem do Trailler...                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cLin := Space(1)+cEOL
	cCpo :=	"99"+; //T01
	Replicate("9",21)+; //T02
	StrZero(nCont,9)+; //T03
	StrZero(abs(nVlrTPF)*100,15)+; //T04
	StrZero(nTotProcFM,9)+; //T05
	StrZero(abs(nTotCobrFM)*100,15)+; //T06
	StrZero(abs(nTotAgreFM)*100,15)+; //T07
	StrZero(abs(nTotTtFaFM)*100,15)+; //T08
	Space(379)+; //T09
	Space(10)+; //T10
	StrZero(nCont,10) //TD11
	
	nCont++

	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAวรO ABORTADA!")
		Return
	Endif
	
//	(cTrbl)->(RecLock((cTrbl),.T.))
//	(cTrbl)->CPOSTRING := cCpo
//	(cTrbl)->(MsUnlock())
	
	nQtdProcF := 0
	nVlrProcF := 0
	nQtdProFM := 0
	nVlrCobFM := 0
	nVlrAgrFM := 0
	nVlrTFaFM := 0
	
EndDo

	U_Fecha_TXT()

Endif

/*
ProcRegua(nTotGer)
nProc := 1
If U_Cria_TXT(cNomeArq)
	cLin := Space(1)+cEOL

	dbSelectArea((cTrbl))
	(cTrbl)->(DbGoTop())

	While !(cTrbl)->(EOF())
		cCpo :=	(cTrbl)->CPOSTRING

		Npercent := (nProc/nTotGer)*100
		IncProc("Proc. 3-Gravacao do Arquivo: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotGer,"@E 9999999"))
		ProcessMessage()

		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAวรO ABORTADA!")
			Return
		Endif
				
*//*
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Nova regra: mesma guia pode ser exportada varias vezes, porem soh   ณ
		//ณ deve ser marcada na primeira exportacao. Nas demais, nao marcar...  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BD6->(DbGoto((cTrbl)->(REGBD6)))
		If !BD6->(EOF())
			BD6->(Reclock("BD6",.F.))
			BD6->BD6_YFTITA := cCodExp
			BD6->BD6_YERITA := "00"
			BD6->BD6_YVLITA := nVlrPro
			BD6->BD6_YMTEMI := cNumFun
			BD6->BD6_YINFTM := cIndFM
			BD6->(MsUnlock())
		Else
			MsgAlert("Linha 1708. "+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+" registro "+StrZero((cTrbl)->(REGBD6),10,0))
		Endif
*//*

		nProc++
		(cTrbl)->(DbSkip())
	EndDo
	U_Fecha_TXT()
Endif
*/

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Alterar o status para importado...                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZH->(Reclock("ZZH",.F.))
ZZH->ZZH_STATUS := "1"
ZZH->(MsUnlock())

For y = 1 to Len(aErro)
	cNomeArq := cDirExp+"CRI"+Iif(cCodCon == cConEmp,"A","I")+cDiaGer+".LOG"
	
	If U_Cria_TXT(cNomeArq)
		
		For n = 1 to Len(aErro)
			cLin := Space(1)+cEOL
			cCpo :=	aErro[n,1]
			
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENวรO! NรO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAวรO ABORTADA!")
				//				Return
			Endif
			
		Next
		U_Fecha_TXT()
	EndIf
	//	PLSCRIGEN(aErro,{ {"Descri็ใo","@C",230} },"Inconsist๊ncias na exporta็ใo...",.T.)
Next
*/

memowrit("C:\FIMCABA026.TXT",Time())

WnRel := SetPrint(cString,nrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Impressao do protocolo de exportacao.	    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nLin > nQtdLin
	nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
	nLin++
Endif

@ nLin,000 PSay Replicate("-",63)
nLin++
@ nLin,000 PSay "GERAวรO DO ARQUIVO DE EXPORTAวรO FATOR MODERADOR / ITAฺ"
nLin++
@ nLin,000 PSay Replicate("-",64)
nLin++
@ nLin,000 PSay "Valor total exportado................: "+Transform(nVlrTPF,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Qtd de registros com Fat. Moderador..: "+Transform(nTotProcFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Valor total de Fat. Moderador........: "+Transform(nTotCobrFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Agregados....: "+Transform(nTotAgreFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Titulares....: "+Transform(nTotTtFaFM,"@E 999,999,999.99")
nLin++
nLin++

@ nLin,000 PSay "REENVIO DE REJEITADOS"
nLin++
nLin++
@ nLin,000 PSay "Valor total exportado................: "//+Transform(nVlrTPFEs,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Qtd de registros com Fat. Moderador..: "//+Transform(nQtdProcFEs,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Valor total de Fat. Moderador........: "//+Transform(nTCobrFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Agregados....: "//+Transform(nTAgreFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Titulares....: "//+Transform(nTTtFaFM,"@E 999,999,999.99")
nLin++
nLin++

/*
@ nLin,000 PSay "TOTAL ESTORNO DE DESPESAS MEDICAS"
nLin++
nLin++
@ nLin,000 PSay "Valor total exportado................: "+Transform(nVlrTPFEs,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Qtd de registros com Fat. Moderador..: "+Transform(nQtdProcFEs,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Valor total de Fat. Moderador........: "+Transform(nTCobrFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Agregados....: "+Transform(nTAgreFM,"@E 999,999,999.99")
nLin++
@ nLin,000 PSay "Total de Fat. Moderador Titulares....: "+Transform(nTTtFaFM,"@E 999,999,999.99")
nLin++

If Len(aTTotMes) > 0
cNomeArq := cDirExp+"RESUMO.TXT"
U_Cria_TXT(cNomeArq)
For n = 1 to Len(aTTotMes)
cLin := Space(1)+cEOL
cCpo := aTTotMes[n,1]+aTTotMes[n,2]+aTTotMes[n,3]+Transform(aTTotMes[n,4],"@E 999,999,999.99")
U_GrLinha_TXT(cCpo,cLin)
Next
U_Fecha_TXT()
EndIf
*/
/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ordenar Array por  tipo movimento, Competencia Lote Pagamento, Produto Usuario...   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aSort(aTTotMes,,, { |x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })

If Len(aTTotMes)
cTipo := aTTotMes[1,1]
nLin := 86
For n = 1 to Len(aTTotMes)
If nLin > nQtdLin
nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
@ nLin,000 PSay "FATOR MODERADOR / ITAU"
nLin++
Endif
If aTTotMes[n,1] <> cTipo
nLin++
@ nLin,000 PSay "TOTAL ESTORNO DE DESPESAS MEDICAS"
nLin++
EndIf
@ nLin,000 PSay aTTotMes[n,2]+"     "+aTTotMes[n,3]+"     "+Transform(aTTotMes[n,4],"@E 999,999,999.99")
Next
EndIf
*/

TRB->(DbCloseArea())

//(cTrbl)->(DbCloseArea())
RestArea(aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ParSX1       บAutor  ณJean Schulz     บ Data ณ  15/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros para exportacao.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ParSX1()
Local cExt    := "A0 (*.A0) | *.A0 |"     //'+'Todos (*.*) | *.* |'"  //"Arquivo DBF | *.DBF"
Local cPath   := "Selecione os Arquivos"

If cPerg == "YEXITA"
	PutSx1(cPerg,"01",OemToAnsi("Empresa")				,"","","mv_ch1","C",04,0,0,"G","","BG9A","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Contrato/Versao")	,"","","mv_ch2","C",15,0,0,"G","","BT5PLS","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Mes Compet. De")	,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Ano Compet. De")	,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Mes Compet. Ate")	,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Ano Compet. Ate")	,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"07",OemToAnsi("Observacao")			,"","","mv_ch7","C",60,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
Else
	PutSx1(cPerg,"01",OemToAnsi("Arquivo a importar "),"","","mv_ch1","C",60,0,0,"G","U_fGetFile('A0 (*.A0) | *.A0 |')","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Atu_Var      บAutor  ณJean Schulz     บ Data ณ  25/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza variaveis de parametros para uso no relatorio.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Atu_Var()

cCodEmp	:= mv_par01
cConEmp	:= Substr(mv_par02,1,12)
cVerCon	:= Substr(mv_par02,13,3)
cMes	   := mv_par03
cAno	   := mv_par04
cMesAte	:= MV_PAR05
cAnoAte	:= MV_PAR06
cObser	:= mv_par07
cCodExp := ""
//Raios
//MsgAlert("ROTINA EMERGENCIAL! GERAวรO DE Mส/ANO DE/ATษ 07/2007 A 06/2008")

//cAno		:= "2007"
//cMes		:= "07"
//cAnoAte		:= "2008"
//cMesAte		:= "06"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBuscaRegs บAutor  ณMicrosiga           บ Data ณ  15/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registros a serem utilizados pela rotina...       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaRegs()
Local nCont	:= 1
Local cSQL	:= ""

//CONTAS MEDICAS
cSQL := " SELECT BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_CONEMP, "
cSQL += "BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, "
cSQL += "BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, sum(VLRPAG) as BD6_VLRPAG, BD6_QTDPRO, BD6F.R_E_C_N_O_ AS REGBD6, BD6_NOMUSR, "
cSQL += "BD6_CODRDA, BD6_YFTITA, BD6_YERITA, BD7_NUMLOT, BD6_NOMSOL, BR8_YNEVEN, '0' AS REENB, BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, "
cSQL += "BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB, "
cSQL += "DECODE(TRIM(BA1_CPFUSR), '', BA1_CPFPRE, BA1_CPFUSR) AS BA1_CPFUSR, BA1_NOMUSR, BA1_YDEPEN, "
cSQL += "DECODE(TRIM(BA1_CODPLA), '', BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) AS BA1_CODPLA " 
cSQL += "FROM "
cSQL += "(SELECT BD7.BD7_FILIAL,BD7_CODPLA,BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, "
cSQL += "BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG, "
cSQL += "COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "
cSQL += "FROM "+RetSqlName("BD7")+" BD7 "
cSql += "WHERE BD7.BD7_FILIAL = '" + xFilial("BD7") + "' "
cSQL += "AND BD7_NUMLOT BETWEEN '"+cAno+cMes+"0000' AND '"+cAnoAte+cMesAte+"9999' "
//cSQL += "AND BD7_NUMLOT <> '     ' "    // Inserido por Luzio em 06/08/08 para que nao considere ITENS GLOSSADOS
cSQL += "AND BD7_DATPRO BETWEEN '"+cAno+cMes+"01' AND '"+cAnoAte+cMesAte+"31' "  // Inserido por Bianchini em 07/10/2011 pra for็ar data de utilizacao
cSQL += "AND BD7.BD7_CODOPE = '0001' "
cSQL += "AND BD7.BD7_SITUAC = '1' "
cSQL += "AND BD7.BD7_FASE   = '4' "
cSQL += "AND BD7.BD7_BLOPAG not in ('1','2') "
cSQL += "AND BD7_CODEMP in ('0006','0010') "
cSQL += "AND BD7.BD7_VLRPAG <> 0 "
cSQL += "AND BD7.D_E_L_E_T_ = ' ' "                                                                            

cSQL += "GROUP BY BD7_FILIAL, BD7_CODPLA,BD7_CODRDA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO,BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, "
cSQL += "BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, "
cSQL += RetSqlName("BD6")+" BD6F, "+RetSqlName("BR8")+" BR8, "+RetSqlName("BQC")+" BQC, "
cSQL += RetSqlName("BA3")+" BA3, "+RetSqlName("BA1")+" BA1 "
cSQL += " WHERE BD6F.BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQL += "AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += "AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += "AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += "AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "
cSQL += "AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "
cSQL += "AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "
cSQL += "AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "
cSQL += "AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "
cSQL += "AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "
cSQL += "AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "
//INSERIDO POR BIANCHINI EM 03/12/2010 A PEDIDO DO ROBERTO
//cSQL += "AND BD7F.BD7_CODRDA NOT IN ('032883','111406','055930','040703') "
cSQL += "AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "
//cSQL += "AND BD6F.BD6_YFTITA = ' ' "
cSQL += "AND BD6F.BD6_CODOPE = '0001' "
cSQL += "AND BD6F.BD6_CODEMP IN ('0006','0010') "

if cConEmp = '000000000001' 
   cSQL += "AND BD6F.BD6_CONEMP IN ('" +AllTrim(cConEmp)+ "','000000000004') "   
else 
   cSQL += "AND BD6F.BD6_CONEMP = '"+AllTrim(cConEmp)+"' "  
endif        

cSQL += "AND BD6F.BD6_FASE = '4' "
cSQL += "AND BD6F.BD6_SITUAC = '1' "
cSQL += "AND BD6F.BD6_YFTITA = ' ' "
cSQL += "AND BD6F.BD6_VLRPAG > 0 "
cSQL += "AND BR8_FILIAL = BD6F.BD6_FILIAL "
cSQL += "AND BR8_CODPAD = BD6F.BD6_CODPAD "
cSQL += "AND BR8_CODPSA = BD6F.BD6_CODPRO "
cSQL += "AND BD6F.BD6_OPEUSR = BQC_CODINT "
cSQL += "AND BD6F.BD6_CODEMP = BQC_CODEMP "
cSQL += "AND BD6F.BD6_CONEMP = BQC_NUMCON "
cSQL += "AND BD6F.BD6_VERCON = BQC_VERCON "
cSQL += "AND BD6F.BD6_SUBCON = BQC_SUBCON "
cSQL += "AND BD6F.BD6_VERSUB = BQC_VERSUB "
//INSERIDO POR BIANCHINI EM 03/12/2010 A PEDIDO DO ROBERTO
//cSQL += "AND BD6F.BD6_CODRDA NOT IN ('032883','111406','055930','040703') " 
//AJUSTES GEPLAN 20/12/2012
cSQL += "AND BD6F.R_E_C_N_O_ NOT IN (select BD6RECNO from custo_adm_201210)
cSQL += "AND BA1_CODINT = BD6F.BD6_OPEUSR "
cSQL += "AND BA1_CODEMP = BD6F.BD6_CODEMP "
cSQL += "AND BA1_CONEMP = BD6F.BD6_CONEMP "
cSQL += "AND BA1_VERCON = BD6F.BD6_VERCON "
cSQL += "AND BA1_SUBCON = BD6F.BD6_SUBCON "
cSQL += "AND BA1_VERSUB = BD6F.BD6_VERSUB "
cSQL += "AND BA1_MATRIC = BD6F.BD6_MATRIC "
cSQL += "AND BA1_TIPREG = BD6F.BD6_TIPREG "
cSQL += "AND BA3_CODINT = BA1_CODINT "
cSQL += "AND BA3_CODEMP = BA1_CODEMP "
cSQL += "AND BA3_CONEMP = BA1_CONEMP "
cSQL += "AND BA3_VERCON = BA1_VERCON "
cSQL += "AND BA3_SUBCON = BA1_SUBCON "
cSQL += "AND BA3_VERSUB = BA1_VERSUB "
cSQL += "AND BA3_MATRIC = BA1_MATRIC "
cSQL += "AND BD6F.D_E_L_E_T_ = ' '"
cSQL += "AND BR8.D_E_L_E_T_ = ' ' "
cSQL += "AND BA1.D_E_L_E_T_ = ' ' "
cSQL += "AND BA3.D_E_L_E_T_ = ' ' "
cSQL += "AND BQC.D_E_L_E_T_ = ' ' "
cSQL += "GROUP BY BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_CONEMP, "
cSQL += "BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, "
cSQL += "BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, BD6_QTDPRO, BD6F.R_E_C_N_O_ , BD6_NOMUSR, "
cSQL += "BD6_CODRDA, BD6_YFTITA, BD6_YERITA, BD7_NUMLOT, BD6_NOMSOL, BR8_YNEVEN, '0' , BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, "
cSQL += "BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB, "
cSQL += "DECODE(TRIM(BA1_CPFUSR), '', BA1_CPFPRE, BA1_CPFUSR), BA1_NOMUSR, BA1_YDEPEN, "
cSQL += "DECODE(TRIM(BA1_CODPLA), '', BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) "

cSQL += "UNION ALL "

//cSQL += " --MATERIAL "
cSQL += " SELECT BD6_CODOPE "
cSQL += "               , BD6_FASE "
cSQL += "               , BD6_SITUAC "
cSQL += "               , BD6_OPEUSR "
cSQL += "               , BD6_CODEMP "
cSQL += "               , BD6_MATRIC "
cSQL += "               , BD6_TIPREG "
cSQL += "               , BD6_DIGITO "
cSQL += "               , BD6_CONEMP "
cSQL += "               , BD6_VERCON "
cSQL += "               , BD6_SUBCON "
cSQL += "               , BD6_VERSUB "
cSQL += "               , BD6_CODPAD "
cSQL += "               , BD6_CODPRO "
cSQL += "               , BD6_CODLDP "
cSQL += "               , BD6_CODPEG "
cSQL += "               , BD6_NUMERO "
cSQL += "               , BD6_ORIMOV "
cSQL += "               , BD6_SEQUEN "
cSQL += "               , BD6_DATPRO "
cSQL += "               , BD6_ANOPAG "
cSQL += "               , BD6_MESPAG "
cSQL += "               , BD6_NOMRDA "
cSQL += "               , BD6_DESPRO "
cSQL += "               , BD6_VLRPAG "
cSQL += "               , BD6_QTDPRO "
cSQL += "               , BD6.R_E_C_N_O_ AS REGBD6 "
cSQL += "               , BD6_NOMUSR "
cSQL += "               , BD6_CODRDA "
cSQL += "               , BD6_YFTITA "
cSQL += "               , BD6_YERITA "
cSQL += "               , F1_EMISSAO "
cSQL += "               , BD6_NOMSOL "
cSQL += "               , BR8_YNEVEN, '0' AS REENB "
cSQL += "               , BD6_TIPGUI "
cSQL += "               , BD6_GUIORI "
cSQL += "               , BQC_YCDCON "
cSQL += "               , BA3_MATEMP "
cSQL += "               , BA1_MATEMP "
cSQL += "               , BA1_DATBLO "
cSQL += "               , BA1_DATINC "
cSQL += "               , BD6_CODPLA "
cSQL += "               , BR8_YEVCAB, "
cSQL += "DECODE(TRIM(BA1_CPFUSR), '', BA1_CPFPRE, BA1_CPFUSR) AS BA1_CPFUSR, BA1_NOMUSR, BA1_YDEPEN, "
cSQL += "DECODE(TRIM(BA1_CODPLA), '', BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) AS BA1_CODPLA " 
cSQL += "FROM "+RetSqlName("B19")+" B19, "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF1")+" SF1, "+RetSqlName("BD6")+" BD6, "
cSQL += RetSqlName("SA2")+" SA2, "+RetSqlName("BI3")+" BI3, "+RetSqlName("BR8")+" BR8, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "
cSQL += RetSqlName("BQC")+" BQC "
cSQL += " WHERE BI3_FILIAL = '" + xFilial("BI3") + "' "
cSQL += "    AND A2_FILIAL = '" + xFilial("SA2") + "' "
cSQL += "    AND BR8_FILIAL = '" + xFilial("BR8") + "' "
cSQL += "    AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += "    AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += "    AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += "    AND BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQL += "AND F1_EMISSAO BETWEEN '"+cAno+cMes+"01' AND '"+cAnoAte+cMesAte+"31' "   //"AND F1_EMISSAO BETWEEN '20100101' AND '20100731' "
cSQL += "    AND A2_COD = B19_FORNEC "
cSQL += "    AND D1_FORNECE = A2_COD "
cSQL += "    AND f1_FORNECE = A2_COD "
cSQL += "    AND D1_DOC = F1_DOC "
cSQL += "    AND B19_DOC = D1_DOC "
cSQL += "    AND D1_ITEM = B19_ITEM "
cSQL += "    AND BD6_CODPLA = BI3_CODIGO "
cSQL += "    AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "
cSQL += "    AND BD6_CODLDP = SubStr(B19_GUIA,05,04) "
cSQL += "    AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "
cSQL += "    AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "
cSQL += "    AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) "
cSQL += "    AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) "
cSQL += "    AND BD6_CODLDP = '0013' "
cSQL += "    AND BD6_CODOPE = '0001' "
cSQL += "    AND BD6_CODEMP IN ('0006','0010') "
cSQL += "    AND BD6_DATPRO BETWEEN '"+cAno+cMes+"01' AND '"+cAnoAte+cMesAte+"31' "  // Inserido por Bianchini em 07/10/2011 pra for็ar data de utilizacao
if cConEmp = '000000000001' 
   cSQL += "AND BD6_CONEMP IN ('" +AllTrim(cConEmp)+ "','000000000004') "   
else 
   cSQL += "AND BD6_CONEMP = '"+AllTrim(cConEmp)+"' "  
endif        

cSQL += "    AND BD6_FASE IN (3,4) "
cSQL += "    AND BD6_SITUAC = '1' "
cSQL += "    AND BD6_YFTITA = ' ' "
cSQL += "    AND BD6_VLRPAG > 0 "
cSQL += "    AND BD6_OPEUSR = BQC_CODINT "
cSQL += "    AND BD6_CODEMP = BQC_CODEMP "
cSQL += "    AND BD6_CONEMP = BQC_NUMCON "
cSQL += "    AND BD6_VERCON = BQC_VERCON "
cSQL += "    AND BD6_SUBCON = BQC_SUBCON "
cSQL += "    AND BD6_VERSUB = BQC_VERSUB "
//INSERIDO POR BIANCHINI EM 03/12/2010 A PEDIDO DO ROBERTO
//cSQL += "    AND BD6_CODRDA NOT IN ('032883','111406','055930','040703') "
//AJUSTES GEPLAN 20/12/2012
cSQL += "    AND BD6.R_E_C_N_O_ NOT IN (select BD6RECNO from custo_adm_201210)
cSQL += "    AND BA1_CODINT = BD6_OPEUSR "
cSQL += "    AND BA1_CODEMP = BD6_CODEMP "
cSQL += "    AND BA1_CONEMP = BD6_CONEMP "
cSQL += "    AND BA1_VERCON = BD6_VERCON "
cSQL += "    AND BA1_SUBCON = BD6_SUBCON "
cSQL += "    AND BA1_VERSUB = BD6_VERSUB "
cSQL += "    AND BA1_MATRIC = BD6_MATRIC "
cSQL += "    AND BA1_TIPREG = BD6_TIPREG "
cSQL += "    AND BA3_CODINT = BA1_CODINT "
cSQL += "    AND BA3_CODEMP = BA1_CODEMP "
cSQL += "    AND BA3_CONEMP = BA1_CONEMP "
cSQL += "    AND BA3_VERCON = BA1_VERCON "
cSQL += "    AND BA3_SUBCON = BA1_SUBCON "
cSQL += "    AND BA3_VERSUB = BA1_VERSUB "
cSQL += "    AND BA3_MATRIC = BA1_MATRIC "
cSQL += "    AND BR8_CODPAD = BD6_CODPAD "
cSQL += "    AND BR8_CODPSA = BD6_CODPRO "
cSQL += "    AND SA2.D_E_L_E_T_ = ' ' "
cSQL += "    AND B19.D_E_L_E_T_ = ' ' "
cSQL += "    AND SD1.D_E_L_E_T_ = ' ' "
cSQL += "    AND SF1.D_E_L_E_T_ = ' ' "
cSQL += "    AND BD6.D_E_L_E_T_ = ' ' "
cSQL += "    AND BI3.D_E_L_E_T_ = ' ' "
cSQL += "    AND BR8.D_E_L_E_T_ = ' ' "
cSQL += "    AND BA1.D_E_L_E_T_ = ' ' "
cSQL += "    AND BA3.D_E_L_E_T_ = ' ' "
cSQL += "    AND BQC.D_E_L_E_T_ = ' ' "

If Val(cAno+cMes) < 201006
	cSQL += "UNION ALL "
	
	cSQL += "SELECT BD6_CODOPE, BD6_FASE, BD6_SITUAC, B44_OPEUSR AS BD6_OPEUSR, B44_CODEMP AS BD6_CODEMP "
	cSQL += "               , B44_MATRIC AS BD6_MATRIC "
	cSQL += "               , B44_TIPREG AS BD6_TIPREG "
	cSQL += "               , B44_DIGITO AS BD6_DIGITO "
	cSQL += "               , B44_CONEMP AS BD6_CONEMP "
	cSQL += "               , B44_VERCON AS BD6_VERCON "
	cSQL += "               , B44_SUBCON AS SUBCON "
	cSQL += "               , B44_VERSUB AS BD6_VERSUB "
	cSQL += "               , B45_CODPAD AS BD6_CODPAD "
	cSQL += "               , B45_CODPRO AS BD6_CODPRO "
	cSQL += "               , B45_CODLDP AS BD6_CODLDP "
	cSQL += "               , B45_CODPEG AS BD6_CODPEG "
	cSQL += "               , B45_NUMERO AS BD6_NUMERO "
	cSQL += "               , B45_ORIMOV AS BD6_ORIMOV "
	cSQL += "               , B45_SEQUEN AS BD6_SEQUEN "
	cSQL += "               , B45_DATPRO AS BD6_DATPRO "
	cSQL += "               , B44_ANOPAG AS BD6_ANOPAG "
	cSQL += "               , B44_MESPAG AS BD6_MESPAG "
	cSQL += "               , B44_NOMEXE AS BD6_NOMRDA "
	cSQL += "               , BD6_DESPRO AS BD6_DESPRO "
	cSQL += "               , B45_VLRAPR AS BD6_VLRPAG "
	cSQL += "               , B45_QTDPRO AS BD6_QTDPRO "
	cSQL += "               , BD6.R_E_C_N_O_ AS REGBD6 "
	cSQL += "               , B44_NOMUSR AS BD6_NOMUSR "
	cSQL += "               , B44_REGEXE AS BD6_CODRDA "
	cSQL += "               , BD6_YFTITA "
	cSQL += "               , BD6_YERITA "
	cSQL += "               , B44_NUM AS BD7_NUMLOT "
	cSQL += "               , B44_NOMSOL AS BD6_NOMSOL "
	cSQL += "               , BR8_YNEVEN, '5' AS REENB "
	cSQL += "               , BD6_TIPGUI "
	cSQL += "               , BD6_GUIORI "
	cSQL += "               , BQC_YCDCON "
	cSQL += "               , BA3_MATEMP "
	cSQL += "               , BA1_MATEMP "
	cSQL += "               , BA1_DATBLO "
	cSQL += "               , BA1_DATINC "
	cSQL += "               , BD6_CODPLA "
	cSQL += "               , BR8_YEVCAB, "
	cSQL += "DECODE(TRIM(BA1_CPFUSR), '', BA1_CPFPRE, BA1_CPFUSR) AS BA1_CPFUSR, BA1_NOMUSR, BA1_YDEPEN, "
	cSQL += "DECODE(TRIM(BA1_CODPLA), '', BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) AS BA1_CODPLA "
	cSQL += "FROM "+RetSqlName("B44")+" C, "+RetSqlName("B45")+" D, "+RetSqlName("BD6")+" BD6, "
	cSQL += RetSqlName("BR8")+" BR8, "+RetSqlName("SE1")+" T, "+RetSqlName("BQC")+" BQC, "
	cSQL += RetSqlName("BA3")+" F, "+RetSqlName("BA1")+" U "
	cSQL += "WHERE B45_FILIAL = '" + xFilial("B45") + "' "
	cSQL += "AND B44_FILIAL = '"+ xFilial("B44") + "' "
	cSQL += "AND BA3_FILIAL = '"+ xFilial("BA3") + "' "
	cSQL += "AND BA1_FILIAL = '"+ xFilial("BA1") + "' "
	cSQL += "AND BD6_FILIAL = '"+ xFilial("BD6") + "' "
	cSQL += "AND BR8_FILIAL = '"+ xFilial("BR8") + "' "
	cSQL += "AND BQC_FILIAL = '"+ xFilial("BQC") + "' "
	cSQL += "AND E1_FILIAL  = '01' "
	cSQL += "AND E1_PREFIXO = 'RLE' "
	cSQL += "AND B44_CODLDP = B45_CODLDP "
	cSQL += "AND B44_CODPEG = B45_CODPEG "
	cSQL += "AND B44_NUMAUT = B45_NUMAUT "
	cSQL += "AND B44_PREFIX = E1_PREFIXO "
	cSQL += "AND B44_NUM=E1_NUM "
	cSQL += "AND BA1_CODINT=BA3_CODINT "
	cSQL += "AND BA1_CODEMP=BA3_CODEMP "
	cSQL += "AND BA1_MATRIC=BA3_MATRIC "
	cSQL += "AND BA1_CODINT=B44_OPEUSR "
	cSQL += "AND BA1_CODEMP=B44_CODEMP "
	cSQL += "AND BA1_MATRIC=B44_MATRIC "
	cSQL += "AND BA1_TIPREG=B44_TIPREG "
	cSQL += "AND B44_CODEMP IN ('0006','0010') "
    cSQL += "AND B44_DATPRO BETWEEN '"+cAno+cMes+"01' AND '"+cAnoAte+cMesAte+"31' "  // Inserido por Bianchini em 07/10/2011 pra for็ar data de utilizacao
	if cConEmp = '000000000001' 
   	   cSQL += "AND B44_CONEMP IN ('" +AllTrim(cConEmp)+ "','000000000004') "   
	else 
   	   cSQL += "AND B44_CONEMP = '"+AllTrim(cConEmp)+"' "  
	endif        

	cSQL += "AND B44_OPEMOV = '0001' "
	cSQL += "AND B44_NUM <> '   ' "
	cSQL += "AND B45_VLRPAG > 0 "         
	//INSERIDO POR BIANCHINI EM 03/12/2010 A PEDIDO DO ROBERTO
    //cSQL += "AND B44_CODRDA NOT IN ('032883','111406','055930','040703') "
    //AJUSTES GEPLAN 20/12/2012
	cSQL += "AND BD6.R_E_C_N_O_ NOT IN (select BD6RECNO from custo_adm_201210)
	// a partir de junho/2010 contabiliza็ใo por emissao "
	//cSQL += "AND (((vmesano < '201006') AND (SubStr(E1_VENCREA,1,6) = vmesano)) OR ((vmesano >='201006') AND (SubStr(E1_EMISSAO,1,6)=vmesano)) )"
	cSQL += "AND E1_VENCREA BETWEEN '"+cAno+cMes+"01' AND '20100531' "   //"AND F1_EMISSAO BETWEEN '20100101' AND '20100731' "
	cSQL += "AND B45_OPEMOV = BD6_CODOPE "
	cSQL += "AND B45_CODLDP = BD6_CODLDP "
	cSQL += "AND B45_CODPEG = BD6_CODPEG "
	cSQL += "AND B45_NUMERO = BD6_NUMERO "
	cSQL += "AND B45_SEQUEN = BD6_SEQUEN "
	cSQL += "AND B45_CODPAD = BD6_CODPAD "
	cSQL += "AND B45_CODPRO = BD6_CODPRO "
	cSQL += "AND BR8_CODPAD = B45_CODPAD "
	cSQL += "AND BR8_CODPSA = B45_CODPRO "
	cSQL += "AND BA1_CODINT = BQC_CODINT "
	cSQL += "AND BA1_CODEMP = BQC_CODEMP "
	cSQL += "AND BA1_CONEMP = BQC_NUMCON "
	cSQL += "AND BA1_VERCON = BQC_VERCON "
	cSQL += "AND BA1_SUBCON = BQC_SUBCON "
	cSQL += "AND BA1_VERSUB = BQC_VERSUB "
	cSQL += "AND B44_YSITUA = '2' "
	cSQL += "AND BD6_YFTITA = ' ' "
	cSQL += "AND C.D_E_L_E_T_   = ' ' "
	cSQL += "AND D.D_E_L_E_T_   = ' ' "
	cSQL += "AND T.D_E_L_E_T_   = ' ' "
	cSQL += "AND U.D_E_L_E_T_   = ' ' "
	cSQL += "AND F.D_E_L_E_T_   = ' ' "
	cSQL += "AND BD6.D_E_L_E_T_ = ' ' "
	cSQL += "AND BR8.D_E_L_E_T_ = ' ' "
	cSQL += "AND BQC.D_E_L_E_T_ = ' ' "
EndIf

If Val(cAnoAte+cMesAte) > 201005
	cSQL += "UNION ALL "
	cSQL += " SELECT BD6_CODOPE "
	cSQL += "      , BD6_FASE "
	cSQL += "      , BD6_SITUAC "
	cSQL += "      , B44_OPEUSR AS BD6_OPEUSR "
	cSQL += "      , B44_CODEMP AS BD6_CODEMP "
	cSQL += "      , B44_MATRIC AS BD6_MATRIC "
	cSQL += "      , B44_TIPREG AS BD6_TIPREG "
	cSQL += "      , B44_DIGITO AS BD6_DIGITO "
	cSQL += "      , B44_CONEMP AS BD6_CONEMP "
	cSQL += "      , B44_VERCON AS BD6_VERCON "
	cSQL += "      , B44_SUBCON AS SUBCON "
	cSQL += "      , B44_VERSUB AS BD6_VERSUB "
	cSQL += "      , B45_CODPAD AS BD6_CODPAD "
	cSQL += "      , B45_CODPRO AS BD6_CODPRO "
	cSQL += "      , B45_CODLDP AS BD6_CODLDP "
	cSQL += "      , B45_CODPEG AS BD6_CODPEG "
	cSQL += "      , B45_NUMERO AS BD6_NUMERO "
	cSQL += "      , B45_ORIMOV AS BD6_ORIMOV "
	cSQL += "      , B45_SEQUEN AS BD6_SEQUEN "
	cSQL += "      , B45_DATPRO AS BD6_DATPRO "
	cSQL += "      , B44_ANOPAG AS BD6_ANOPAG "
	cSQL += "      , B44_MESPAG AS BD6_MESPAG "
	cSQL += "      , B44_NOMEXE AS BD6_NOMRDA "
	cSQL += "      , BD6_DESPRO AS BD6_DESPRO "
	cSQL += "      , B45_VLRAPR AS BD6_VLRPAG "
	cSQL += "      , B45_QTDPRO AS BD6_QTDPRO "
	cSQL += "      , BD6.R_E_C_N_O_ AS REGBD6 "
	cSQL += "      , B44_NOMUSR AS BD6_NOMUSR "
	cSQL += "      , B44_REGEXE AS BD6_CODRDA "
	cSQL += "      , BD6_YFTITA "
	cSQL += "      , BD6_YERITA "
	cSQL += "      , B44_NUM AS BD7_NUMLOT "
	cSQL += "      , B44_NOMSOL AS BD6_NOMSOL "
	cSQL += "      , BR8_YNEVEN, '5' AS REENB "
	cSQL += "      , BD6_TIPGUI "
	cSQL += "      , BD6_GUIORI "
	cSQL += "      , BQC_YCDCON "
	cSQL += "      , BA3_MATEMP "
	cSQL += "      , BA1_MATEMP "
	cSQL += "      , BA1_DATBLO "
	cSQL += "      , BA1_DATINC "
	cSQL += "      , BD6_CODPLA "
	cSQL += "      , BR8_YEVCAB, "
	cSQL += "DECODE(TRIM(BA1_CPFUSR), '', BA1_CPFPRE, BA1_CPFUSR) AS BA1_CPFUSR, BA1_NOMUSR, BA1_YDEPEN, "
	cSQL += "DECODE(TRIM(BA1_CODPLA), '', BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) AS BA1_CODPLA " 
	cSQL += "        FROM B44010 C,B45010 D ,SE1010 T ,BA1010 U,BA3010 F,BD6010 BD6, BR8010 BR8, BQC010 BQC "
	cSQL += "       WHERE B45_FILIAL=' ' "
	cSQL += "         AND B44_FILIAL=' ' "
	cSQL += "         AND BA3_FILIAL=' ' "
	cSQL += "         AND BA1_FILIAL=' ' "
	cSQL += "         AND BD6_FILIAL=' ' "
	cSQL += "         AND BR8_FILIAL = ' ' "
	cSQL += "         AND BQC_FILIAL = ' ' "
	cSQL += "         AND E1_FILIAL='01' "
	cSQL += "         AND E1_PREFIXO='RLE' "
	cSQL += "         AND B44_CODLDP=B45_CODLDP "
	cSQL += "         AND B44_CODPEG=B45_CODPEG "
	cSQL += "         AND B44_NUMAUT=B45_NUMAUT "
	cSQL += "         AND B44_PREFIX =E1_PREFIXO "
	cSQL += "         AND B44_NUM=E1_NUM "
	cSQL += "         AND BA1_CODINT=BA3_CODINT "
	cSQL += "         AND BA1_CODEMP=BA3_CODEMP "
	cSQL += "         AND BA1_MATRIC=BA3_MATRIC "
	cSQL += "         AND BA1_CODINT=B44_OPEUSR "
	cSQL += "         AND BA1_CODEMP=B44_CODEMP "
	cSQL += "         AND BA1_MATRIC=B44_MATRIC "
	cSQL += "         AND BA1_TIPREG=B44_TIPREG "
	cSQL += "         AND B44_CODEMP IN ('0006','0010') "      
	//INSERIDO POR BIANCHINI EM 03/12/2010 A PEDIDO DO ROBERTO
    //cSQL += "AND B44_CODRDA NOT IN ('032883','111406','055930','040703') "
    //AJUSTES GEPLAN 20/12/2012
    cSQL += "		  AND BD6.R_E_C_N_O_ NOT IN (select BD6RECNO from custo_adm_201210)
	if cConEmp = '000000000001' 
   	   cSQL += "AND B44_CONEMP IN ('" +AllTrim(cConEmp)+ "','000000000004') "   
	else 
   	   cSQL += "AND B44_CONEMP = '"+AllTrim(cConEmp)+"' "  
	endif        

	cSQL += "         AND BD6_CODOPE='0001' "
	cSQL += "         AND B44_NUM <> '   ' "
	cSQL += "         AND B45_VLRPAG > 0 "
	//cSQL += "         -- apartir de junho/2010 contabiliza็ใo por emissao                                                                   "
	//cSQL += "       //AND (((vmesano < '201006') AND (SubStr(E1_VENCREA,1,6)=vmesano)) OR                                                 "
	//cSQL += "       //       ((vmesano >='201006') AND (SubStr(E1_EMISSAO,1,6)=vmesano)) )"
	cSQL += "         AND E1_EMISSAO BETWEEN '20100601' AND '"+cAnoAte+cMesAte+"31' "
    cSQL += "         AND B44_DATPRO BETWEEN '"+cAno+cMes+"01' AND '"+cAnoAte+cMesAte+"31' "  // Inserido por Bianchini em 07/10/2011 pra for็ar data de utilizacao
	cSQL += "         AND B45_CODLDP=BD6_CODLDP "
	cSQL += "         AND B45_CODPEG=BD6_CODPEG "
	cSQL += "         AND B45_NUMERO=BD6_NUMERO "
	cSQL += "         AND B45_SEQUEN=BD6_SEQUEN "
	cSQL += "         AND B45_CODPAD=BD6_CODPAD "
	cSQL += "         AND B45_CODPRO=BD6_CODPRO "
	cSQL += "         AND BR8_CODPAD = B45_CODPAD "
	cSQL += "         AND BR8_CODPSA = B45_CODPRO "
	cSQL += "         AND BA1_CODINT = BQC_CODINT "
	cSQL += "         AND BA1_CODEMP = BQC_CODEMP "
	cSQL += "         AND BA1_CONEMP = BQC_NUMCON "
	cSQL += "         AND BA1_VERCON = BQC_VERCON "
	cSQL += "         AND BA1_SUBCON = BQC_SUBCON "
	cSQL += "         AND BA1_VERSUB = BQC_VERSUB "
	cSQL += "         AND B44_YSITUA = '2' "
	cSQL += "         AND BD6_YFTITA = ' ' "
	cSQL += "         AND C.D_E_L_E_T_=' ' "
	cSQL += "         AND D.D_E_L_E_T_=' ' "
	cSQL += "         AND T.D_E_L_E_T_=' ' "
	cSQL += "         AND U.D_E_L_E_T_=' ' "
	cSQL += "         AND F.D_E_L_E_T_=' ' "
	cSQL += "         AND BD6.D_E_L_E_T_=' ' "
	cSQL += "         AND BR8.D_E_L_E_T_ = ' ' "
	cSQL += "         AND BQC.D_E_L_E_T_ = ' ' "
EndIf
cSQL += "ORDER BY BQC_YCDCON, BD6_OPEUSR, BD6_CODEMP, BA3_MATEMP, BD6_MATRIC, BD6_TIPREG, BD6_CONEMP, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_CODPAD, BD6_CODPRO"

/*
cSQL := " SELECT DISTINCT BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, "
cSQL += " BD6_CONEMP, BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, "
cSQL += " BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, "
cSQL += " BD6_VLRPAG, BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, BD6_NOMUSR , BD6_CODRDA, BD6_YFTITA, BD6_YERITA, BD7_NUMLOT, "
cSQL += " BD6_NOMSOL, BR8_YNEVEN, '0' AS REENB, BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB "
//cSQL += " (SELECT DISTINCT BFA_CODIGO "
//cSQL += " FROM BFA010 "
//cSQL += " WHERE BFA_FILIAL = '" + xFilial("BFA") + "' "
//cSQL += " AND BFA_CODPSA = BD6_CODPRO "
//cSQL += " AND BFA_CODPAD = BD6_CODPAD "
//cSQL += " AND D_E_L_E_T_ = ' ') AS BFA_CODIGO "
cSQL += " FROM "+RetSqlName("BD6")+" BD6, "+RetSqlName("BD7")+" BD7, "+RetSqlName("BR8")+" BR8, "+RetSqlName("BQC")+" BQC, "
cSQL += RetSqlName("BA3")+" BA3, "+RetSqlName("BA1")+" BA1 "

cSQL += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQL += " AND BD6_CODOPE = '0001' "
//cSQL += " AND BD6_CODEMP = '"+cCodEmp+"' "
cSQL += " AND BD6_CODEMP IN ('0006','0010') "  //NOVA RESOLUCAO ITAU
//cSQL += " AND BD6_CODEMP IN ('0006') "
//cSQL += " AND BD6_CODEMP IN ('0010') "
cSQL += " AND BD6_CONEMP = '"+AllTrim(cConEmp)+"' "
cSQL += " AND BD6_FASE = '4' "
cSQL += " AND BD6_SITUAC = '1' "
cSQL += " AND BD6_YFTITA = ' ' "
cSQL += " AND BD6_VLRPAG > 0 "          // Inserido por Luzio em 10/06/08 para que nao considere valores de pagamento zerados

//cSQL += " AND BD6_GUIORI = '   ' "                   // Inserido por Luzio em 22/10/08 para que nao considere guias clonadas ou oriundas de recurso
//cSQL += " AND SUBSTR(BD6_NUMIMP,1,3) <> 'REC' "      // Inserido por Luzio em 22/10/08 para que nao considere guias clonadas ou oriundas de recurso

cSql += " AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += " AND BD6_OPEUSR = BQC_CODINT "
cSQL += " AND BD6_CODEMP = BQC_CODEMP "
cSQL += " AND BD6_CONEMP = BQC_NUMCON "
cSQL += " AND BD6_VERCON = BQC_VERCON "
cSQL += " AND BD6_SUBCON = BQC_SUBCON "
cSQL += " AND BD6_VERSUB = BQC_VERSUB "

cSql += " AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += " AND BA1_CODINT = BD6_OPEUSR "
cSQL += " AND BA1_CODEMP = BD6_CODEMP "
cSQL += " AND BA1_CONEMP = BD6_CONEMP "
cSQL += " AND BA1_VERCON = BD6_VERCON "
cSQL += " AND BA1_SUBCON = BD6_SUBCON "
cSQL += " AND BA1_VERSUB = BD6_VERSUB "
cSQL += " AND BA1_MATRIC = BD6_MATRIC "
cSQL += " AND BA1_TIPREG = BD6_TIPREG "

cSql += " AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += " AND BA3_CODINT = BA1_CODINT "
cSQL += " AND BA3_CODEMP = BA1_CODEMP "
cSQL += " AND BA3_CONEMP = BA1_CONEMP "
cSQL += " AND BA3_VERCON = BA1_VERCON "
cSQL += " AND BA3_SUBCON = BA1_SUBCON "
cSQL += " AND BA3_VERSUB = BA1_VERSUB "
cSQL += " AND BA3_MATRIC = BA1_MATRIC "

cSql += " AND BR8_FILIAL = '" + xFilial("BR8") + "' "
cSQL += " AND BR8_CODPAD = BD6_CODPAD "
cSQL += " AND BR8_CODPSA = BD6_CODPRO "

cSQL += " AND SubStr(BD7_NUMLOT,1,6) >= '"+cAno+cMes+"' "
cSQL += " AND SubStr(BD7_NUMLOT,1,6) <= '"+cAnoAte+cMesAte+"' "
cSQL += " AND BD7_VLRPAG > 0 "          // Inserido por Luzio em 06/08/08 para que nao considere ITENS GLOSSADOS
cSQL += " AND BD7_BLOPAG <> '1' "        // Inserido por Luzio em 06/08/08 para que nao considere ITENS GLOSSADOS
cSQL += " AND BD7_NUMLOT <> '     ' "    // Inserido por Luzio em 06/08/08 para que nao considere ITENS GLOSSADOS
cSql += " AND BD7_FILIAL = '" + xFilial("BD7") + "' "
cSQL += " AND BD7_CODOPE = BD6_CODOPE "
cSQL += " AND BD7_CODLDP = BD6_CODLDP "
cSQL += " AND BD7_CODPEG = BD6_CODPEG "
cSQL += " AND BD7_NUMERO = BD6_NUMERO "
cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
cSQL += " AND BD7.D_E_L_E_T_ <> '*' "
cSQL += " AND BR8.D_E_L_E_T_ <> '*' "
cSQL += " AND BQC.D_E_L_E_T_ <> '*' "
cSQL += " AND BA3.D_E_L_E_T_ <> '*' "
cSQL += " AND BA1.D_E_L_E_T_ <> '*' "
//cSQL += "   AND bd6.r_e_c_n_o_ IN (6291494,6315481)"

// Guias com as guias do OPME pagas a Fornecedores por nota fiscal.
cSQL += " UNION "
cSQL += " SELECT DISTINCT BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, "
cSQL += " BD6_CONEMP, BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, "
cSQL += " BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, "
cSQL += " BD6_VLRPAG, BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, BD6_NOMUSR, BD6_CODRDA, BD6_YFTITA, BD6_YERITA, BD7_NUMLOT, "
cSQL += " BD6_NOMSOL, BR8_YNEVEN, '0' AS REENB, BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB "
//cSQL += " (SELECT DISTINCT BFA_CODIGO "
//cSQL += " FROM BFA010 "
//cSQL += " WHERE BFA_FILIAL = '" + xFilial("BFA") + "' "
//cSQL += " AND BFA_CODPSA = BD6_CODPRO "
//cSQL += " AND BFA_CODPAD = BD6_CODPAD "
//cSQL += " AND D_E_L_E_T_ = ' ') AS BFA_CODIGO "
cSQL += " FROM BD6010 BD6, BD7010 BD7, BR8010 BR8, B19010 B19 , "+RetSqlName("BQC")+" BQC, "
cSQL += RetSqlName("BA3")+" BA3, "+RetSqlName("BA1")+" BA1 "
cSQL += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQL += " AND BD6_CODOPE = '0001' "
//cSQL += " AND BD6_CODEMP = '"+cCodEmp+"' "
//cSQL += " AND BD6_CODLDP   = '0012' "      //Local de digitacao ugaul a 0013
cSQL += " AND BD6_CODEMP IN ('0006','0010') "  //NOVA RESOLUCAO ITAU
//cSQL += " AND BD6_CODEMP IN ('0006') "
//cSQL += " AND BD6_CODEMP IN ('0010') "
cSQL += " AND BD6_CONEMP = '"+AllTrim(cConEmp)+"' "
cSQL += " AND BD6_FASE     = '3' "         //Fase da Guia igual a PRONTA
cSQL += " AND BD6_SITUAC   = '1' "         //Situacao igual
cSQL += " AND BD6_YFTITA   = ' ' "     //Nao foi enviado ao Itau

cSql += " AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += " AND BD6_OPEUSR = BQC_CODINT "
cSQL += " AND BD6_CODEMP = BQC_CODEMP "
cSQL += " AND BD6_CONEMP = BQC_NUMCON "
cSQL += " AND BD6_VERCON = BQC_VERCON "

cSQL += " AND BD6_SUBCON = BQC_SUBCON "
cSQL += " AND BD6_VERSUB = BQC_VERSUB "

cSql += " AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += " AND BA1_CODINT = BD6_OPEUSR "
cSQL += " AND BA1_CODEMP = BD6_CODEMP "
cSQL += " AND BA1_CONEMP = BD6_CONEMP "
cSQL += " AND BA1_VERCON = BD6_VERCON "
cSQL += " AND BA1_SUBCON = BD6_SUBCON "
cSQL += " AND BA1_VERSUB = BD6_VERSUB "
cSQL += " AND BA1_MATRIC = BD6_MATRIC "
cSQL += " AND BA1_TIPREG = BD6_TIPREG "

cSql += " AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += " AND BA3_CODINT = BA1_CODINT "
cSQL += " AND BA3_CODEMP = BA1_CODEMP "
cSQL += " AND BA3_CONEMP = BA1_CONEMP "
cSQL += " AND BA3_VERCON = BA1_VERCON "
cSQL += " AND BA3_SUBCON = BA1_SUBCON "
cSQL += " AND BA3_VERSUB = BA1_VERSUB "
cSQL += " AND BA3_MATRIC = BA1_MATRIC "

cSql += " AND BR8_FILIAL = '" + xFilial("BR8") + "' "
cSQL += " AND BR8_CODPAD = BD6_CODPAD "
cSQL += " AND BR8_CODPSA = BD6_CODPRO "
cSql += " AND BD7_FILIAL = '" + xFilial("BD7") + "' "
cSQL += " AND BD7_CODOPE = BD6_CODOPE "
cSQL += " AND BD7_CODLDP = BD6_CODLDP "
cSQL += " AND BD7_CODPEG = BD6_CODPEG "
cSQL += " AND BD7_NUMERO = BD6_NUMERO "
cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
cSQL += " AND BD7_BLOPAG = '1' "             //Bloqueio de pagamento da composicao do prodcedimento
cSQL += " AND BD7_NUMLOT = '     ' "
cSQL += " AND B19_GUIA   = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN "
cSQL += " AND B19_COD    = BD6_CODPRO "
cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
cSQL += " AND BD7.D_E_L_E_T_ <> '*' "
cSQL += " AND BR8.D_E_L_E_T_ <> '*' "
cSQL += " AND B19.D_E_L_E_T_ <> '*' "
cSQL += " AND BQC.D_E_L_E_T_ <> '*' "
cSQL += " AND BA3.D_E_L_E_T_ <> '*' "
cSQL += " AND BA1.D_E_L_E_T_ <> '*' "
//cSQL += "   AND bd6.r_e_c_n_o_ IN (6291494,6315481)"

// Analisa as guias contendo o material medicamento de ortese e protese que estao com fase pronta, valor para pagamento
// , mas canceladas
cSQL += " UNION "
cSQL += " SELECT DISTINCT BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, "
cSQL += " BD6_CONEMP, BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, "
cSQL += " BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, "
cSQL += " BD6_VLRPAG, BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, BD6_NOMUSR, BD6_CODRDA, BD6_YFTITA, BD6_YERITA, BD7_NUMLOT, "
cSQL += " BD6_NOMSOL, BR8_YNEVEN, '1' AS REENB, BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB "
//cSQL += " (SELECT DISTINCT BFA_CODIGO "
//cSQL += " FROM BFA010 "
//cSQL += " WHERE BFA_FILIAL = '" + xFilial("BFA") + "' "
//cSQL += " AND BFA_CODPSA = BD6_CODPRO "
//cSQL += " AND BFA_CODPAD = BD6_CODPAD "
//cSQL += " AND D_E_L_E_T_ = ' ') AS BFA_CODIGO "
cSQL += " FROM BD6010 BD6, BD7010 BD7, BR8010 BR8 , "+RetSqlName("BQC")+" BQC, "
cSQL += RetSqlName("BA3")+" BA3, "+RetSqlName("BA1")+" BA1 "
cSQL += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
//cSQL += " AND BD6_CODOPE = '0001' "
////cSQL += " AND BD6_CODEMP = '"+cCodEmp+"' "
//cSQL += " AND BD6_CODEMP IN ("+cCodEmp+") "  //NOVA RESOLUCAO ITAU
////cSQL += " AND BD6_CONEMP = '"+cConEmp+"' "
cSQL += " AND BD6_CODEMP IN ('0006','0010') "  //NOVA RESOLUCAO ITAU
//cSQL += " AND BD6_CODEMP IN ('0006') "
//cSQL += " AND BD6_CODEMP IN ('0010') "
cSQL += " AND BD6_CONEMP IN ("+AllTrim(cConEmp)+") "  //NOVA RESOLUCAO ITAU
cSQL += " AND BD6_CODLDP   = '0012' "      //Local de digitacao igual a 0012
cSQL += " AND BD6_FASE     = '3' "         //Fase da Guia igual a PRONTA
cSQL += " AND BD6_SITUAC   = '2' "         //Situacao igual
cSQL += " AND BD6_YFTITA   = ' ' "         //Nao foi enviado ao Itau

cSql += " AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += " AND BD6_OPEUSR = BQC_CODINT "
cSQL += " AND BD6_CODEMP = BQC_CODEMP "
cSQL += " AND BD6_CONEMP = BQC_NUMCON "
cSQL += " AND BD6_VERCON = BQC_VERCON "
cSQL += " AND BD6_SUBCON = BQC_SUBCON "
cSQL += " AND BD6_VERSUB = BQC_VERSUB "

cSql += " AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += " AND BA1_CODINT = BD6_OPEUSR "
cSQL += " AND BA1_CODEMP = BD6_CODEMP "
cSQL += " AND BA1_CONEMP = BD6_CONEMP "
cSQL += " AND BA1_VERCON = BD6_VERCON "
cSQL += " AND BA1_SUBCON = BD6_SUBCON "
cSQL += " AND BA1_VERSUB = BD6_VERSUB "
cSQL += " AND BA1_MATRIC = BD6_MATRIC "
cSQL += " AND BA1_TIPREG = BD6_TIPREG "

cSql += " AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += " AND BA3_CODINT = BA1_CODINT "
cSQL += " AND BA3_CODEMP = BA1_CODEMP "
cSQL += " AND BA3_CONEMP = BA1_CONEMP "
cSQL += " AND BA3_VERCON = BA1_VERCON "
cSQL += " AND BA3_SUBCON = BA1_SUBCON "
cSQL += " AND BA3_VERSUB = BA1_VERSUB "
cSQL += " AND BA3_MATRIC = BA1_MATRIC "

cSql += " AND BR8_FILIAL = '" + xFilial("BR8") + "' "
cSQL += " AND BR8_CODPAD = BD6_CODPAD "
cSQL += " AND BR8_CODPSA = BD6_CODPRO "
//cSQL += " AND BD6_CODPRO   = '83000089' "
//cSQL += " AND BD7_VLRPAG   > 0 "
cSql += " AND BD7_FILIAL = '" + xFilial("BD7") + "' "
cSQL += " AND BD7_CODOPE = BD6_CODOPE "
cSQL += " AND BD7_CODLDP = BD6_CODLDP "
cSQL += " AND BD7_CODPEG = BD6_CODPEG "
cSQL += " AND BD7_NUMERO = BD6_NUMERO "
cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
cSQL += " AND BD7_BLOPAG = '1' "         //Bloqueio de pagamento da composicao do prodcedimento
cSQL += " AND BD7_NUMLOT = '     ' "
cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
cSQL += " AND BD7.D_E_L_E_T_ <> '*' "
cSQL += " AND BR8.D_E_L_E_T_ <> '*' "
cSQL += " AND BQC.D_E_L_E_T_ <> '*' "
cSQL += " AND BA3.D_E_L_E_T_ <> '*' "
cSQL += " AND BA1.D_E_L_E_T_ <> '*' "
//cSQL += "   AND bd6.r_e_c_n_o_ IN (6291494,6315481)"

// Processa as guias de reembolso realizadas pela rotina padrao.
cSQL += " UNION "
cSQL += " SELECT DISTINCT BD6_CODOPE, BD6_FASE, BD6_SITUAC, B44_OPEUSR AS BD6_OPEUSR, B44_CODEMP AS BD6_CODEMP, B44_MATRIC AS BD6_MATRIC, B44_TIPREG AS BD6_TIPREG, B44_DIGITO AS BD6_DIGITO, "
cSQL += "       B44_CONEMP AS BD6_CONEMP, B44_VERCON AS BD6_VERCON, B44_SUBCON AS SUBCON, B44_VERSUB AS BD6_VERSUB, B45_CODPAD AS BD6_CODPAD, B45_CODPRO AS BD6_CODPRO, B45_CODLDP AS BD6_CODLDP, B45_CODPEG AS BD6_CODPEG, "
cSQL += "       B45_NUMERO AS BD6_NUMERO, B45_ORIMOV AS BD6_ORIMOV, B45_SEQUEN AS BD6_SEQUEN, B45_DATPRO AS BD6_DATPRO, B44_ANOPAG AS BD6_ANOPAG, B44_MESPAG AS BD6_MESPAG, B44_NOMEXE AS BD6_NOMRDA, BD6_DESPRO AS BD6_DESPRO, "
//Alterado para que passe a considerar o RECNO() do arquivo BD6  e nao o do B45, pois esta causando problemas nas guia do reembolso
//cSQL += "       B45_VLRPAG AS BD6_VLRPAG, B45_QTDPRO AS BD6_QTDPRO, B45.R_E_C_N_O_ AS REGBD6, B44_NOMUSR AS BD6_NOMUSR, B44_REGEXE AS BD6_CODRDA, BD6_YFTITA, BD6_YERITA, B44_NUM AS BD7_NUMLOT, "

//Alterado a pedido do Rafael do Itau para que envie o valor apresentado pelo ususario na cobranca do reembolso.
//cSQL += "       B45_VLRPAG AS BD6_VLRPAG, B45_QTDPRO AS BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, B44_NOMUSR AS BD6_NOMUSR, B44_REGEXE AS BD6_CODRDA, BD6_YFTITA, BD6_YERITA, B44_NUM AS BD7_NUMLOT, "
cSQL += "       B45_VLRAPR AS BD6_VLRPAG, B45_QTDPRO AS BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, B44_NOMUSR AS BD6_NOMUSR, B44_REGEXE AS BD6_CODRDA, BD6_YFTITA, BD6_YERITA, B44_NUM AS BD7_NUMLOT, "
cSQL += "       B44_NOMSOL AS BD6_NOMSOL, BR8_YNEVEN, '5' AS REENB, BD6_TIPGUI, BD6_GUIORI, BQC_YCDCON, BA3_MATEMP, BA1_MATEMP, BA1_DATBLO, BA1_DATINC, BD6_CODPLA, BR8_YEVCAB "
cSQL += "       FROM "+RetSqlName("B44")+" B44, "+RetSqlName("B45")+" B45, "+RetSqlName("BD6")+" BD6, "+RetSqlName("BD7")+" BD7, "
cSQL += RetSqlName("BR8")+" BR8, "+RetSqlName("SE1")+" SE1, "+RetSqlName("SE2")+" SE2 , "+RetSqlName("BQC")+" BQC, "
cSQL += RetSqlName("BA3")+" BA3, "+RetSqlName("BA1")+" BA1 "
cSQL += "       WHERE B45_FILIAL = '" + xFilial("B45") + "' "
cSQL += "         AND B44_FILIAL = '" + xFilial("B44") + "' "
cSQL += "         AND BR8_FILIAL = '" + xFilial("BR8") + "' "
cSQL += "         AND BD7_FILIAL = '" + xFilial("BD7") + "' "
cSQL += "         AND BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQL += "         AND E1_FILIAL  = '01'
//cSQL += "       AND E1_PREFIXO = 'RLE'
////cSQL += "       AND B44_CODEMP = '"+cCodEmp+"' "
//cSQL += "        AND B44_CODEMP IN ("+cCodEmp+") "  //NOVA RESOLUCAO ITAU
cSQL += "         AND B44_CODEMP IN ('0006','0010') "  //NOVA RESOLUCAO ITAU
//cSQL += "         AND B44_CODEMP IN ('0006') "
//cSQL += "         AND B44_CODEMP IN ('0010') "
cSQL += "         AND B44_CONEMP IN ("+AllTrim(cConEmp)+") "
cSQL += "         AND B44_CODLDP = B45_CODLDP "
cSQL += "         AND B44_CODPEG = B45_CODPEG "
cSQL += "         AND B44_NUMAUT = B45_NUMAUT "
cSQL += "         AND B44_NUM <> '   ' "
cSQL += "         AND B44_YSITUA = '2' "
cSQL += "         AND B44_PREFIX = E1_PREFIXO "
cSQL += "         AND B44_NUM    = E1_NUM "
cSQL += "         AND B45_VLRPAG > 0 "

cSql += "         AND BQC_FILIAL = '" + xFilial("BQC") + "' "
cSQL += " 		  AND B44_OPEUSR = BQC_CODINT "
cSQL += "         AND B44_CODEMP = BQC_CODEMP "
cSQL += "         AND B44_CONEMP = BQC_NUMCON "
//cSQL += "         AND B44_VERCON = BQC_VERCON "
cSQL += "         AND B44_SUBCON = BQC_SUBCON "
cSQL += "         AND B44_VERSUB = BQC_VERSUB "

cSql += " 		  AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSQL += "         AND BA1_CODINT = B44_OPEUSR "
cSQL += "         AND BA1_CODEMP = B44_CODEMP "
cSQL += "         AND BA1_CONEMP = B44_CONEMP "
//cSQL += "         AND BA1_VERCON = B44_VERCON "
cSQL += "         AND BA1_SUBCON = B44_SUBCON "
cSQL += "         AND BA1_VERSUB = B44_VERSUB "
cSQL += "         AND BA1_MATRIC = B44_MATRIC "
cSQL += "         AND BA1_TIPREG = B44_TIPREG "

cSql += "         AND BA3_FILIAL = '" + xFilial("BA3") + "' "
cSQL += "         AND BA3_CODINT = BA1_CODINT "
cSQL += "         AND BA3_CODEMP = BA1_CODEMP "
cSQL += "         AND BA3_CONEMP = BA1_CONEMP "
cSQL += "         AND BA3_VERCON = BA1_VERCON "
cSQL += "         AND BA3_SUBCON = BA1_SUBCON "
cSQL += "         AND BA3_VERSUB = BA1_VERSUB "
cSQL += "         AND BA3_MATRIC = BA1_MATRIC "

cSQL += "         AND BD6_CODOPE = '0001' "
cSQL += "         AND BD6_CODLDP = B45_CODLDP "
cSQL += "         AND BD6_CODPEG = B45_CODPEG "
cSQL += "         AND BD6_NUMERO = B45_NUMERO "
//cSQL += "       AND BD6_ORIMOV = B45_ORIMOV "
cSQL += "         AND BD6_SEQUEN = B45_SEQUEN "

cSQL += "         AND BD6_YFTITA = ' ' "

cSQL += "         AND BR8_CODPAD = B45_CODPAD "
cSQL += "         AND BR8_CODPSA = B45_CODPRO "
cSQL += "         AND BD7_CODOPE = BD6_CODOPE "
cSQL += "         AND BD7_CODLDP = BD6_CODLDP "
cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "
//cSQL += "         AND DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,1,6),SubStr(E2_VENCREA,1,6)) = '200906' "

cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "

cSQL += "         AND (BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG <> '0001000600360300' AND BD6_CODLDP = '9000' ) "

cSQL += "         AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO = E2_TITORIG(+) "
cSQL += "         AND BR8.D_E_L_E_T_ = ' ' "
cSQL += "         AND B44.D_E_L_E_T_=' ' "
cSQL += "         AND B45.D_E_L_E_T_=' ' "
cSQL += "         AND BD6.D_E_L_E_T_=' ' "
cSQL += "         AND BD7.D_E_L_E_T_=' ' "
cSQL += "         AND SE1.D_E_L_E_T_=' ' "
cSQL += "         AND SE2.D_E_L_E_T_=' ' "
cSQL += "         AND BQC.D_E_L_E_T_=' ' "
cSQL += " AND BA3.D_E_L_E_T_ <> '*' "
cSQL += " AND BA1.D_E_L_E_T_ <> '*' "
//cSQL += "   AND bd6.r_e_c_n_o_ IN (6291494,6315481)"

cSQL += " ORDER BY BQC_YCDCON, BD6_OPEUSR, BD6_CODEMP, BA3_MATEMP, BD6_MATRIC, BD6_TIPREG, BD6_CONEMP, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_CODPAD, BD6_CODPRO "
//cSQL += " ORDER BY BQC_YCDCON, BD6_OPEUSR, BD6_CODEMP, BD6_CONEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "
//cSQL += " ORDER BY BQC_YCDCON, BD6_CONEMP, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "

*/

//memowrit("C:\FTMITAAGR.SQL",cSQL)
memowrit("C:\CABA026.SQL",cSQL)

PLSQuery(cSQL,"TRB")

//memowrit("C:\fimquery",cSQL)
memowrit("C:\CABA026FIM.SQL",cSQL)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑฑ
ฑฑณFuncao    ณ CB026LEG   ณ Autor ณ Jean Schulz         ณ Data ณ 21.11.06 ณฑฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑฑ
ฑฑณDescricao ณ Exibe a legenda...                                         ณฑฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CB026LEG()    //NLEGFATM()
Local aLegenda

aLegenda := { { aCdCores[1,1],aCdCores[1,2] },{ aCdCores[2,1],aCdCores[2,2] } ,{ aCdCores[3,1],aCdCores[3,2] }}

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ CB026EXC   ณ Autor ณ Jean Schulz       ณ Data ณ 21.11.2006 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Exclui o arquivo e sua composicao                          ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CB026EXC(cAlias,nReg,nOpc)    //NEXCFATM(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK		:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }

PRIVATE cAlias	:= "ZZH"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define dialogo...                                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Enchoice...                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Copy cAlias To Memory

oEnc := ZZH->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ativa o dialogo...                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define tratamento de acordo com a opcao...                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOpca == K_OK
	
	If ZZH->ZZH_STATUS <> "1" .AND. ZZH->ZZH_STATUS <> "3"
		MsgInfo("Nao ้ possํvel excluir! Arquivo jแ importado!")
	Else
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Deleta registro excluido e desmarca os itens ja exportados...       ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BEGIN TRANSACTION
		MsgRun("Desmarcando Registros Exportados...",,{|| DesmacaRegs(ZZH->ZZH_CODIGO),CLR_HBLUE})
		ZZH->(PLUPTENC("ZZH",K_Excluir))
		END TRANSACTION
		
	Endif
	
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fim da Rotina...                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZH->(DbClearFilter())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDesmacaRegsบAutor ณMicrosiga           บ Data ณ  21/11/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDesmarca registros (emite mensagem na tela)                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DesmacaRegs(cCodExp)
Local cSQL := ""

cSQL := " UPDATE "+RetSQLName("BD6")+" SET BD6_YFTITA = ' ', BD6_YERITA = ' ', BD6_YVLITA = 0, BD6_YMTEMI = ' ', BD6_YINFTM = ' ' "
cSQL += " WHERE BD6_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNIMPFATM   บAutor  ณMicrosiga           บ Data ณ  22/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImporta arquivo referente ao retorno Itau.                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CB026IMP()    //NIMPFATM()
Local cNmArq := ""

cPerg := "YIMITA"

ParSX1()
If !Pergunte(cPerg,.T.)
	MsgAlert("Importa็ใo abortada!")
	Return
Endif

cNmArq	:= mv_par01

If !File(cNmArq)
	MsgStop("Arquivo invalido. Impossํvel importar!")
	Return
Endif

Processa({|| Processa1(cNmArq) }, cTitulo, "", .T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  26/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1(cNmArq)

Local aStruc	:= {}
Local aErr		:= {}
Local aCritica	:= {}
Local aBD6		:= {}
Local nLinha	:= 0
Local cLinha	:= ""
Local lReemb	:= .F.

Private cTrb

//Cria estrutura em area de trabalho para importar arquivo
aAdd(aStruc,{"CAMPO","C",500,0})

cTrb := CriaTrab(aStruc,.T.)

If Select("TRB") <> 0
	TRB->(dbCloseArea())
EndIf

DbUseArea(.T.,,cTrb,"TRB",.T.)

MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNmArq),CLR_HBLUE})

TRB->(DbGoTop())
If TRB->(EOF())
	MsgStop("Arquivo Vazio!")
	TRB->(DBCLoseArea())
	lRet := .F.
	Return
End

ProcRegua(TRB->(LastRec()))
TRB->(DbGoTop())

ZZH->(DbSetOrder(1))
BD6->(DbSetOrder(1))

nLin := 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Validar a composicao do arquivo de retorno e criar array de baixa...ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
While !TRB->(Eof())
	
	nLinha++
	IncProc("Processando Linha... "+strzero(nLinha,6)+" / "+strzero(TRB->(LastRec()),6))
	
	cLinha := TRB->CAMPO
	
	Do Case
		Case Substr(cLinha,1,2) == "01" //Registro Header
			If !ZZH->(MsSeek(xFilial("ZZH")+Substr(cLinha,100,006)))
				MsgStop("Registro referente a exporta็ใo nใo encontrado. Importa็ใo abortada!")
				Return
			Else
				If ZZH->ZZH_STATUS <> "1" .AND. ZZH->ZZH_STATUS <> "3"
					MsgStop("Status nใo permite importa็ใo! Verifique!")
					Return
				Endif
			Endif
			
		Case Substr(cLinha,1,2) == "10" //Registro Detalhe
			lReemb := Iif(Substr(cLinha,284,3)=="RBS",.T.,.F.) //Valida se guia tem origem de reembolso ou nao...
			
			If !lReemb
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Caso nao seja reembolso, devera buscar registros no BD6...          ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+Substr(cLinha,284,24)))
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Nova rotina: somente gravar caso cod. de exportacao == cod exp guia!ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If Alltrim(ZZH->ZZH_CODIGO) == Alltrim(BD6->BD6_YFTITA)
						If Substr(cLinha,480,1) == "R" //Registro rejeitado - Gravar conteudo no item de nota...
							//aadd(aBD6,{BD6->(Recno()),StrZero(Val(Substr(cLinha,481,2)),2)})
							aadd(aBD6,{BD6->(Recno()),Substr(cLinha,480,11),Substr(cLinha,480,1)})
						Else
							aadd(aCritica,{"Guia/Item com crํtica, por้m aceito. Chave: "+PLSINTPAD()+Substr(cLinha,284,24),Substr(cLinha,481,10)})
						Endif
					Endif
				Else
					aadd(aErr,{"Guia/Item nใo localizado. Chave: "+PLSINTPAD()+Substr(cLinha,284,24)})
				Endif
				
			Endif
	EndCase
	
	TRB->(DbSkip())
	
Enddo

TRB->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Iniciar transacao e efetuar todas as manutencoes de uma so vez...   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Begin Transaction

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Alterar o status para importado...                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZH->(Reclock("ZZH",.F.))
ZZH->ZZH_STATUS := "2"
ZZH->(MsUnlock())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Atualizar registros que possuiram erros apontados no arquivo...     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgRun("Atualizando status dos registros retornados...",,{|| AtualizaRegs(aBD6),CLR_HBLUE})

End Transaction


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Apresentar criticas e erros encontrados durante a importacao...     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len(aCritica) > 0
	PLSCRIGEN(aCritica,{ {"Descri็ใo da crํtica","@C",200},{"C๓digo da crํtica","@C",50} },"Crํticas encontradas! (Importa็ใo)",.T.)
Endif

If Len(aErr) > 0
	PLSCRIGEN(aErr,{ {"Descri็ใo do erro!","@C",300}},"Aten็ใo! Erros encontrados! (Importa็ใo)",.T.)
Endif

aErr		:= {}

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualizaRegs บAutor  ณMicrosiga        บ Data ณ  22/11/06   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza registros retornados pelo arquivo Itau.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtualizaRegs(aBD6)
Local nCont := 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Alterar registros de BD6 (Cts Medicas)retornados no arquivo retorno ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nCont := 1 to Len(aBD6)
	BD6->(DbGoTo(aBD6[nCont,1]))
	BD6->(RecLock("BD6",.F.))
	BD6->BD6_YERITA := aBD6[nCont,2]
	//	BD6->BD6_YERRIT := aBD6[nCont,3]
	//BD6->BD6_YMESEN := '12'
	BD6->(MsUnlock())
Next

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Zerar matrizes que tiveram suas atualizacoes...                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aBD6 := {}
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ EXCFATM    ณ Autor ณ Jean Schulz       ณ Data ณ 21.11.2006 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Exclui o arquivo e sua composicao                          ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CB026CAN(cAlias,nReg,nOpc)   //NCANCIMP(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK		:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }

PRIVATE cAlias	:= "ZZH"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define dialogo...                                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Enchoice...                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Copy cAlias To Memory

oEnc := ZZH->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ativa o dialogo...                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define tratamento de acordo com a opcao...                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOpca == K_OK
	
	if ZZH->ZZH_STATUS == "1"
		MsgInfo("Somente ้ possํvel cancelar a importa็ใo quando o registro estแ com status jแ importado!")
	Else
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Deleta registro excluido e desmarca os itens ja exportados...       ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BEGIN TRANSACTION
		MsgRun("Cancelando importa็ใo...",,{|| CancelaImp(ZZH->ZZH_CODIGO),CLR_HBLUE})
		ZZH->(Reclock("ZZH",.F.))
		ZZH->ZZH_STATUS := "1"
		ZZH->(MsUnlock())
		END TRANSACTION
		
	Endif
	
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fim da Rotina...                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZH->(DbClearFilter())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCancelaImp บAutor ณMicrosiga           บ Data ณ  21/11/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDesmarca registros (emite mensagem na tela)                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CancelaImp(cCodExp)
Local cSQL := ""

cSQL := " UPDATE "+RetSQLName("BD6")+" SET BD6_YERITA = '00' "
cSQL += " WHERE BD6_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuUtil   บAutor  ณ Jean Schulz        บ Data ณ  16/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca a utilizacao de determinado procedimento, utilizando  บฑฑ
ฑฑบ          ณo ano civil, conforme regra Itau...                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
AtuUtil(@aVetUti,TRB->BD6_OPEUSR,TRB->BD6_CODEMP,TRB->BD6_MATRIC,TRB->BD6_TIPREG,TRB->BD6_DIGITO,TRB->BD6_CONEMP,TRB->BD6_VERCON,;
TRB->BD6_SUBCON,TRB->BD6_VERSUB,TRB->BD6_CODPAD,TRB->BD6_CODPRO, cAno, cMes, iif(Empty(Alltrim(TRB->BD6_YFTITA)),.F.,.T.))
*/

Static Function AtuUtil(aRet, cOpeUsr, cCodEmp, cMatric, cTipReg, cDigito, cConEmp, cVerCon, cSubCon, cVerSub, cCodPad, cCodPro, nVlrPag, nQtdPro, cAno, cMes, cCodPla, cTipUsu)
Local nCont		:= 0
Local nCont1	:= 0
Local nCont2	:= 0
Local cTipo		:= ""
Local nQtdMax	:= 0
Local nVlrFat	:= 0
Local nPerFat   := 0
Local aCodUsr	:= {}
Local nQtdTit	:= 0
Local nQtdAgr	:= 0
Local nQtdUti	:= 0
Local aCodPro	:= {}
Local nNivel	:= 0
Local nPos		:= 0

Local nPerCons  := 0
Local nPerExam  := 0
Local nPerIntP  := 0


Local aAreaBA1	:= BA1->(GetArea())
Local aAreaBD6	:= BD6->(GetArea())

//Local cCodPro1 := Iif(Alltrim(cCodPro) $ cProPar, cProPar, AllTrim(cCodPro))
//Local cCodTmp  := Iif(Alltrim(cCodPro) $ cProPar, "00010014", Alltrim(cCodPro))

Local cCodPro1 := Iif(Alltrim(cCodPro) $ cProPar, cProPar, AllTrim(cCodPro))
Local cCodTmp  := Iif(Alltrim(cCodPro) $ cProPar, "00010014",Alltrim(cCodPro))

ZZG->(MsSeek(xFilial("ZZG")+cCodEmp))
nNivel := 0

While !ZZG->(Eof()) .And. ZZG->ZZG_CODEMP == cCodEmp
	
	If ZZG->ZZG_CODTAB == cCodPad .And. Alltrim(ZZG->ZZG_CODPRO) $ cCodTmp .And. Substr(DtoS(ZZG->ZZG_VIGINI),1,6) <= cAno+cMes ;
		.And. (Empty(ZZG->ZZG_VIGFIN) .Or. (!Empty(ZZG->ZZG_VIGFIN) .And. cAno+cMes <= Substr(DtoS(ZZG->ZZG_VIGFIN),1,6) ) )
		
		If (!Empty(ZZG->ZZG_SUBCON) .And. ZZG->(ZZG_SUBCON+ZZG_VERSUB) == cSubCon+cVerSub) .And. (!Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon)
			
			cTipo := ZZG->ZZG_TIPO
			//nQtdMax := ZZG->ZZG_QTDMAX     Deixou de ser usado. Segundo Alexandre eles tratarใo la.  Bianchini 08/08/2011
			nVlrFat := ZZG->ZZG_VLRFAT
			nPerCons := 0
			nPerExam := 0
			nPerIntP := 0
			nNivel	:= 3
		Else
			
			If !Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon .And. nNivel <= 2
				
				cTipo := ZZG->ZZG_TIPO
				//nQtdMax := ZZG->ZZG_QTDMAX     deixou de ser usado. Segundo Alexandre eles tratarใo la.  Bianchini 08/08/2011
				nVlrFat := ZZG->ZZG_VLRFAT
				nPerCons := 0
				nPerExam := 0
				nPerIntP := 0
				nNivel 	:= 2
				
			Else
				If nNivel <= 1
					cTipo := ZZG->ZZG_TIPO
					//nQtdMax := ZZG->ZZG_QTDMAX     deixou de ser usado. Segundo Alexandre eles tratarใo la.  Bianchini 08/08/2011
					nVlrFat := ZZG->ZZG_VLRFAT
					nPerCons := 0
					nPerExam := 0
					nPerIntP := 0
					nNivel	:= 1
				Endif
				
			Endif
			
		Endif
		
	Endif                                                                                                                   
	
	ZZG->(DbSkip())
	
Enddo

If cTipo == "1" //Familia
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se o usuario em questao for Agregado, regra igual a usuario, fixa qtd = 3    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BA1->(DbSetOrder(2))
	If BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric+cTipReg))
		If cTipUsu == "A"
			Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
			//nQtdMax := 3  Deixou de ser usado. Segundo o alexandre, eles tratarao isso la. Bianchini 08/08/2011
		Else
			BA1->(DbGoTop())
			BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric))
			
			While !BA1->(Eof()) .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)==cOpeUsr+cCodEmp+cMatric
				If BA1->BA1_TIPUSU <> "A"
					Aadd(aCodUsr,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				Endif
				BA1->(DbSkip())
			Enddo
		Endif
	Endif
	
Else
	Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
Endif
//EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Conforme solicitacao do cliente em 11/12/06, tratar consulta alem de 00010014ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aCodPro := {{cCodPad,cCodPro1}}

If ( Alltrim(cCodTmp) == "00010014") .or. ( Alltrim(cCodTmp) == "10101012" )   //Somente para consulta
	aCodPro := {}
	
	While .T.
		
		If At(",",cCodPro1) > 0
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1,At(",",cCodPro1)-1)})
			cCodPro1 := Substr(cCodPro1,At(",",cCodPro1)+1)
		Else
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1)})
			Exit
		Endif
		
	Enddo
	
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ordenar Array para  do usuario, quantidade de utilizacoes ja realizadas...   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aSort(aCodPro,,, { |x,y| x[1]+x[2] < y[1]+y[2] })

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Buscar no historico do usuario, quantidade de utilizacoes ja realizadas...   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

nQtdUti := 0

If !Empty(cTipo) .And. Val(cMes) > 1
	
	For nCont := 1 to (Val(cMes)-1)
		
		For nCont1 := 1 to Len(aCodUsr)
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Itens de notas...                                                            ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			BD6->(DbSetOrder(10))
			BD6->(DbGoTop())
			
			If BD6->(MsSeek(xFilial("BD6")+aCodUsr[nCont1]+cAno+StrZero(nCont,2)))
				
				While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_MESPAG+BD6_ANOPAG) == aCodUsr[nCont1]+StrZero(nCont,2)+cAno
					
					If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
						BD6->(DbSkip())
						Loop
					Endif
					
					If ( Alltrim(BD6->BD6_CODPRO) $ Iif(Alltrim(cCodTmp) == "00010014", cProPar, Alltrim(cCodTmp)) .or.         ;
					     Alltrim(BD6->BD6_CODPRO) $ Iif(Alltrim(cCodTmp) == "10101012", cProPar, Alltrim(cCodTmp))      ) .And. ;
						(Substr(aCodUsr[nCont1],15,2) == cTipReg .Or. Substr(aCodUsr[nCont1],15,2) <> cTipReg )
						
						If BD6->BD6_FASE $ "3,4" .And. BD6->BD6_SITUAC == "1"
							
							nQtdUti += BD6->BD6_QTDPRO
							If cTipUsu == "T"
								nQtdTit += BD6->BD6_QTDPRO
							Else
								nQtdAgr += BD6->BD6_QTDPRO
							Endif
							//Inserido por Luzio em 07/10/08 para que considere as consultas digitadas como recupracao de reembolso pelo saude
						ElseIf BD6->BD6_CODLDP == '0012' .and. BD6->BD6_FASE == "3" .And. BD6->BD6_SITUAC == "2"
							nQtdUti += BD6->BD6_QTDPRO
							If cTipUsu == "T"
								nQtdTit += BD6->BD6_QTDPRO
							Else
								nQtdAgr += BD6->BD6_QTDPRO
							Endif
						Endif
						
					Endif
					
					BD6->(DbSkip())
					
				Enddo
				
			Endif
			
		Next
		
	Next
	
Endif

nPos := Ascan(aRet, { |x| AllTrim(x[1]+x[3]) == cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito+cCodTmp } )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Buscar parametrizacao de procedimento, conforme usuario...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If nPos == 0
	If cCodEmp == '0006' //.and. nQtdMax > 0
		aadd(aRet,{cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito,;
		cTipUsu,;
		cCodTmp,;
		nQtdUti,;
		nQtdTit,;
		nQtdAgr,;
		nQtdMax,;
		nVlrFat,;
		nPerFat,;
		nPerCons,;
		nPerExam,;
		nPerIntP})
	ElseIf cCodemp == '0010'
		aadd(aRet,{cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito,;
		cTipUsu,;
		cCodTmp,;
		nQtdUti,;
		nQtdTit,;
		nQtdAgr,;
		nQtdMax,;
		nVlrFat,;
		nPerFat,;
		nPerCons,;
		nPerExam,;
		nPerIntP})
	Endif
EndIf

RestArea(aAreaBA1)
RestArea(aAreaBD6)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusTipUsu บAutor  ณLuzio Tavares       บ Data ณ  19/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca o tipo de usuario conforme cadastro de usuarios       บฑฑ
ฑฑบ          ณpermitidos por subcontrato.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - Corrigido                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg, cCodPla)
Local cTipUsu	:= ""
//Local aAreaBA1	:= BA1->(GetArea())
//Local aAreaBA3	:= BA1->(GetArea())
Local aAreaBT0	:= BA1->(GetArea())
//Local cCodPla	:= ""
//Local cVerPla	:= ""

BT0->(DbSetOrder(1))
//BA1->(DbSetOrder(2))
//BA3->(DbSetOrder(1))

//BA3->(MsSeek(xFilial("BA3")+cOpeUsr+cCodEmp+cMatric))
//cCodPla := BA3->BA3_CODPLA
//cVerPla	:= BA3->BA3_VERSAO
//If BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric+cTipReg))
//	cCodPla := Iif(!Empty(BA1->BA1_CODPLA),BA1->BA1_CODPLA,cCodPla)
//	cVerPla := Iif(!Empty(BA1->BA1_VERSAO),BA1->BA1_VERSAO,cVerPla)
//Endif

If BT0->(MsSeek(xFilial("BT0")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cCodPla))
	cTipUsu := "A"
	While !BT0->(Eof()) .And.;
		 BT0->(BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cCodPla
		If BT0->BT0_TIPUSR <> "T"
			cTipUsu := "T"
			Exit
		Endif
		BT0->(DbSkip())
	Enddo
Else
	cTipUsu := "T"
Endif

//RestArea(aAreaBA1)
//RestArea(aAreaBA3)
RestArea(aAreaBT0)

Return cTipUsu