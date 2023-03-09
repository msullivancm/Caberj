#include "PLSA090.ch"
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"

//mbctirar
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NLGRPREV  ºAutor  ³ Marcela Coimbra    º Data ³  05/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de log de exportacao / importacao de arquivos para a  º±±
±±º          ³ Rio Previdencia.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//Leonardo Portella - 24/02/15 - Alteracoes diversas para contemplar o novo layout da Previ.
//Conforme informado por Guilherme S. Nazareth da Previ:
//Layout do QW60 e o arquivo “QW60_NAO_FINANCEIRA_201501_CABERJ_PREVI.txt” neste layout.
//O QW60 contempla todos os descontos e “Não Descontos” com os respectivos motivos, desde
//que tenham sido enviados pela consignante. Desta forma sugiro que você use o QW60 pois desta
//forma não precisará ler o QW54 (Descontos), QW52(Perda de margem) e QW53(Afastados).

***************************************************************************************************************

User Function CABA333()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aRotina	:=	{	{ "Pesquisar"				, 'AxPesqui'		, 0, K_Pesquisar	},;
		{ "&Visualizar"				, 'AxVisual'		, 0, K_Visualizar	},;
		{ "Exportar Movimentação"	, 'u_TEXPRIOPR'		, 0, K_Incluir		},;
		{ "&Excluir"				, 'u_TEXCRIOPR'		, 0, K_Excluir		},;
		{ "Exportar Alterações"		, 'u_TExAlte'		, 0, K_Incluir		},;
		{ "&Composicao"				, 'u_COM2RIOPR'		, 0, K_Incluir		},;//{ "&Exibe não enviados"		, 'u_NAOENVI'		, 0, K_Incluir		},;
		{ "&Importar Benef. Previ"	, 'u_ImpMatXTEC'	, 0, K_Incluir		},;//	{ "&Beneficiarios Previ"	, 'u_BenefPRE'		, 0, K_Incluir		},;	{ "&Relatorio de baixa"		, "u_BAIXA2015('1')"	, 0, K_Incluir		},;
		{ "&Relatorios de base"	    , 'u_GerRelPre'	, 0, K_Incluir		},;//	{ "&Beneficiarios Previ"	, 'u_BenefPRE'		, 0, K_Incluir		},;	{ "&Relatorio de baixa"		, "u_BAIXA2015('1')"	, 0, K_Incluir		},;
		{ "&Relatorio de não baixados", 'u_GerBolPrev'	, 0, K_Incluir		},;//	{ "&Beneficiarios Previ"	, 'u_BenefPRE'		, 0, K_Incluir		},;	{ "&Relatorio de baixa"		, "u_BAIXA2015('1')"	, 0, K_Incluir		},;
		{ "&Importar Baixa"			, 'u_ImpBxPrevi'	, 0, K_Incluir		},;//						{ "&VerIfica"   			, 'VERBXPRE'		, 0, K_Incluir		},;
		{ "&Planilha de Baixa"		, "u_BAIXA2015('1')"	, 0, K_Incluir		},;//						{ "&Baixar"	    			, 'u_BaixaTMP'	, 0, K_Incluir		},;
		{ "&Baixar"	    			, "u_BAIXA2015('2')"	, 0, K_Incluir		},;//						{ "&Baixar"	    			, 'u_BaixaTMP'	, 0, K_Incluir		},;
		{ "Legenda"					, 'LEGRIOPR(1)'		, 0, K_Incluir		} }
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo e variavies para indicar o status do arquivo                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Private cCadastro	:= "Log de envio/receb. arquivos Rio Previdência"
	
	Private aCdCores	:= { 	{ 'BR_VERDE'    ,'Arquivo Gerado' },;
		{ 'BR_AZUL'     ,'Arquivo Exportado e Importado' } }
	
	Private aCores		:= {{'PBR_STATUS = "1"', aCdCores[1,1]},;
		{'PBR_STATUS = "2"', aCdCores[2,1]}	}
	Private cPath  		:= ""
	Private cAlias 		:= "PBR"
	Private cPerg		:= "PLYRPR"
	Private cNomeProg   := "IMPRIOPR"
	Private nQtdLin     := 68
	Private nLimite     := 132
	Private cControle   := 15
	Private cTamanho    := "M"
	Private cTitulo     := "Imp. Rio Previdência"
	Private cDesc1      := ""
	Private cDesc2      := ""
	Private cDesc3      := ""
	Private nRel        := "IMPRIOPR"
	Private nlin        := 100
	Private nOrdSel     := 1
	Private m_pag       := 1
	Private lCompres    := .F.
	Private lDicion     := .F.
	Private lFiltro     := .T.
	Private lCrystal    := .F.
	Private aOrdens     := {}
	Private aReturn     := { "", 1,"", 1, 1, 1, "",1 }
	Private lAbortPrint := .F.
	Private cCabec1     := "Importação Rio Previdência"
	Private cCabec2     := ""
	Private nColuna     := 00
	
	// Dados do banco, agencia e conta
	// p/ realizar a movimentação bancária.
	Private cBanco		:= "341"
	Private cAgencia	:= "6015 "
	Private cConta		:= "017251"
	Private cLote		:= ""
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Starta mBrowse...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PBR->(DBSetOrder(1))
	PBR->(mBrowse(006,001,022,075,"PBR" , , , , , Nil    , aCores, , , ,nil, .T.))
	PBS->(DbClearFilter())
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXPRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa Arquivo de Usuario para Layout Padrao.             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TEXPRIOPR(cAlias,nReg,nOpc)
	
	Local oDlg
	Local nOpca   := 0
	Local oEnc
	Local aRet
	Local bOK		:= { || nOpca := 1, oDlg:End() }
	Local bCancel	:= { || nOpca := 0, oDlg:End() }
	Local aCampos := {}
	Local i__f
	
	aObjects := {}
	aSizeAut := MsAdvSize()
	
	AAdd( aObjects, { 100,  100, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Enchoice...                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	COPY "PBR" TO Memory Blank
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define dialogo...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSizeAut[7],00 TO aSizeAut[6],aSizeAut[5] PIXEL OF GetWndDefault()
	
	//oEnc := PBR->(MsMGet():New(cAlias,nReg,nOpc,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
	oEnc := PBR->(MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]},,,,,,oDlg,,,.F.))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa o dialogo...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define tratamento de acordo com a opcao...                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpca == K_OK
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inclui movimento...                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRet := EXPARQRIO(oEnc:aGets,oEnc:aTela,"",oDlg)
		
		M->PBR_QTDENV	:= aRet[1]
		M->PBR_VALREM	:= aRet[2]
		
		M->PBR_TOTMEN	:= aRet[3]
		M->PBR_TOTDIV	:= aRet[4]
		M->PBR_QTDMEN	:= aRet[5]
		M->PBR_QTDDIV	:= aRet[6]
		
		M->PBR_DATREM	:= dDatabase
		PBR->(PLUPTENC("PBR",K_Incluir))
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXPARQRIO  ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Trata rotina externa                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EXPARQRIO(aGets,aTela,cNomArq,oDlg)
	
	Local aRet := {0,0,0,0,0,0}
	
	Private nBytes := 0
	Private cTitulo := "Export. Rio Previdência"
	Private nHdl
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa campos obrigatorios...                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Obrigatorio(aGets,aTela)
		Return(aRet)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera a exportacao do arquivo RIO PREVIDENCIA...                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Processa({|| aRet := GeraExport() } , cTitulo                           , "", .T.)
	
Return aRet

***************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CBIMPLEG   ³ Autor ³ Jean Schulz         ³ Data ³ 06.09.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function LEGRIOPR(nTipLeg)
	
	Local aLegenda
	
	If nTipLeg == 2
		
		aCdCores  	:= { 	{ 'BR_VERDE'       ,'Enviado' }		,;
			{ 'BR_VERMELHO'    ,'Erro Envio Detectado'},;
			{ 'BR_AZUL'        ,'Baixa Autorizada' }	,;
			{ 'BR_AMARELO'     ,'Baixa Não Autorizada' } }
		
		aCores      := {	{ 'PBS_STATUS = "1"',aCdCores[1,1] },;
			{ 'PBS_STATUS = "2"',aCdCores[2,1] },;
			{ 'PBS_STATUS = "3"',aCdCores[3,1] },;
			{ 'PBS_STATUS = "4"',aCdCores[4,1] } }
		
		aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
			{ aCdCores[2,1],aCdCores[2,2] },;
			{ aCdCores[3,1],aCdCores[3,2] },;
			{ aCdCores[4,1],aCdCores[4,2] } }
	Else
		aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
			{ aCdCores[2,1],aCdCores[2,2] } }
	EndIf
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXCRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TEXCRIOPR(cAlias,nReg,nOpc)
	
	Local oDlg
	Local nOpca   	:= 0
	Local oEnc
	Local bOK     	:= { || nOpca := 1, oDlg:End() }
	Local bCancel 	:= { || oDlg:End() }
	Local cPreRem 	:= PBR->PBR_PREREM
	Local cCodRem 	:= PBR->PBR_CODREM
	Local i__f
	
	aObjects := {}
	aSizeAut := MsAdvSize()
	
	AAdd( aObjects, { 100,  100, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define dialogo...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSizeAut[7],00 TO aSizeAut[6],aSizeAut[5] PIXEL OF GetWndDefault()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Enchoice...                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Copy cAlias To Memory
	
	//oEnc := PBR->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
	oEnc := PBR->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]},,,,,,oDlg,,,.F.))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa o dialogo...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define tratamento de acordo com a opcao...                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpca == K_OK
		
		If .F.//PBR->PBR_STATUS <> "1"
			MsgInfo("Nao e possivel excluir! Arquivo já importado!")
		Else
			Processa({||PTEXCRIOPR(cAlias,nReg,nOpc,cPreRem,cCodRem)},'Processando...')
		EndIf
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
Return

***************************************************************************************************************

Static Function PTEXCRIOPR(cAlias,nReg,nOpc,cPreRem,cCodRem)
	
	Local nI	:= 0
	Local cQtd	:= ''
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Deleta todas as linhas do arquivo excluido...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cSQL := " SELECT PBS_PRETIT, PBS_NUMTIT, PBS_PARTIT, PBS_TIPTIT "
	cSQL += " FROM "+RetSQLName("PBS")
	cSQL += " WHERE PBS_FILIAL = '"+xFilial("PBS")+"' "
	cSQL += " AND PBS_PREREM = '"+cPreRem+"' "
	cSQL += " AND PBS_CODREM = '"+cCodRem+"' "
	cSQL += " AND D_E_L_E_T_ = ' ' "
	cSQL += " GROUP BY PBS_PRETIT, PBS_NUMTIT, PBS_PARTIT, PBS_TIPTIT "
	
	PLSQuery(cSQL,"TRB")
	
	TRB->(DbGotop())
	
	COUNT TO nI
	
	TRB->(DbGotop())
	
	ProcRegua(nI)
	
	cQtd	:= AllTrim(Transform(nI,'@E 999,999,999'))
	
	nI		:= 0
	
	BEGIN TRANSACTION
		
		While !TRB->(Eof())
			
			IncProc('Processando ' + AllTrim(Transform(++nI,'@E 999,999,999')) + ' de ' + cQtd )
			
			If SE1->(MsSeek(xFilial("SE1")+TRB->(PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT)))
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= ""
				SE1->E1_YTPEDSC	:= ""
				SE1->(MsUnlock())
			EndIf
			
			TRB->(DbSkip())
		Enddo
		
		TRB->(DbCloseArea())
		
		/*cSQL := " DELETE FROM " + RetSQLName("PBS")+" "
		cSQL += " WHERE PBS_FILIAL = '"+xFilial("PBS")+"' "
		cSQL += " AND PBS_PREREM = '"+cPreRem+"' "
		cSQL += " AND PBS_CODREM = '"+cCodRem+"' "
		cSQL += " AND D_E_L_E_T_ = ' '"
		PLSSQLEXEC(cSQL)
		*/
		
		dbSelectArea("PBS")
		dbSetOrder(1)
		If dbSeeK( xFilial("PBS") + cPreRem + cCodRem )
			
			While !PBS->( EOF() ) .AND. PBS->PBS_PREREM == cPreRem .and. PBS->PBS_CODREM = cCodRem
				
				PBS->(RecLock("PBS",.F.))
				
				PBS->(dbDelete())
				
				PBS->(MsUnlock())
				
				PBS->( dbSkip() )
				
			EndDo
			
		EndIf
		
		//PBR->(PLUPTENC("PBR",K_Excluir))
		DbSelectArea("PBR")
		DbSetOrder(1) //PBR_FILIAL+PBR_PREREM+PBR_CODREM+DTOS(PBR_DATREM)+PBR_TIPREM
		If DbSeek(xFilial("PBR") + cPreRem + cCodRem )
			
			While !PBR->( EOF() ) .AND. PBR->PBR_PREREM == cPreRem .and. PBR->PBR_CODREM = cCodRem
				
				PBR->(RecLock("PBR",.F.))
				
				PBR->(dbDelete())
				
				PBR->(MsUnlock())
				
				PBR->( dbSkip() )
				
			EndDo
			
		EndIf
		
		
	END TRANSACTION
	
Return

***************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ COMRIOPR   ³ Autor ³ Antonio de Padua    ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Arquivo                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function COM2RIOPR()
	
	Private aFilAdic := {.T.,"('01','02')"}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aRotina   	:=	{	{ "Pesquisar"	, 'AxPesqui'	  	, 0 , K_Pesquisar  	},;
		{ "Visualizar"	, 'AxVisual'	    , 0 , K_Visualizar 	},;
		{ "Legenda"     , "LEGRIOPR(2)"		, 0 , K_Incluir     },;
		{ "Filtro"      , "FILRIOPR"	    , 0 , K_Incluir     } }
	
	PBS->(DbClearFilter())
	
	aCdCores  	:= { 	{ 'BR_VERDE'       	,'Enviado' 				},;
		{ 'BR_VERMELHO'    	,'Erro Detectado'		},;
		{ 'BR_AZUL'        	,'Baixa Autorizada' 	},;
		{ 'BR_AMARELO'     	,'Baixa Não Autorizada' }}
	
	aCores      := {	{ 'PBS_STATUS = "1"',aCdCores[1,1] },;
		{ 'PBS_STATUS = "2"',aCdCores[2,1] },;
		{ 'PBS_STATUS = "3"',aCdCores[3,1] },;
		{ 'PBS_STATUS = "4"',aCdCores[4,1] }}
	
	Private cAlias    := "PBS"
	
	Private cFil := ""
	
	cFil := "@PBS_FILIAL = '"+xFilial("PBS")+"'"
	cFil += " AND PBS_PREREM = '"+PBR->PBR_PREREM+"' "
	cFil += " AND PBS_CODREM = '"+PBR->PBR_CODREM+"' "
	cFil += " AND D_E_L_E_T_ = ' '"
	
	PBS->(DBSetOrder(1))
	DbSelectArea("PBS")
	SET FILTER TO &cFil
	
	PBS->(mBrowse(006,001,022,075,"PBS" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
	PBS->(DbClearFilter())
	
	aCdCores  	:= { 	{ 'BR_VERDE'		,'Arquivo Gerado' }				,;
		{ 'BR_AZUL'			,'Arquivo Exportado e Importado' }	}
	aCores      := {	{ 'PBR_STATUS = "1"',aCdCores[1,1] }	,;
		{ 'PBR_STATUS = "2"',aCdCores[2,1] }	}
	
	cAlias		:= "PBS"
	cFil		:= ""
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraExportºAutor  ³Jean Schulz         º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera exportacao para Rio Previdencia, conforme parametros   º±±
±±º          ³repassados anteriormente...                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GeraExport
	
	Local nLin		:= 100
	Local cSQL      := ""
	Local nReg		:= 0
	Local cDirExp	:= GETNEWPAR("MV_YLGRIPR","\interface\exporta\RioPrevi\")
	Local cEOL		:= CHR(13)+CHR(10)
	Local cCpo		:= ""
	Local nCont		:= 0
	Local aCritica	:= {}
	Local aDetalhe	:= {}
	Local aExpVal	:= {}
	Local aExpTit	:= {}
	Local cMatEmp	:= ""
	Local cTMatEmp	:= ""
	Local cMatric	:= ""
	Local cTec		:= ""
	Local cNomUsr	:= ""
	Local nPos		:= 0
	Local nSeq		:= 0
	Local nVlrTot	:= 0
	Local nTotMen	:= 0
	Local nTotDiv	:= 0
	Local nQtdMen	:= 0
	Local nQtdDiv	:= 0
	Local aRet		:= {0,0,0,0,0,0}
	Local cPreTit	:= ""
	Local cNumTit	:= ""
	Local cParTit	:= ""
	Local cTipTit	:= ""
	Local cCodErr	:= "0"
	Local _cCodEve 	:= ""
	Local _nRecNoBA1:= 0
	Local _nRec		:= 0
	Local _nVlrRes	:= 0
	Local _nVlrCob	:= 0
	Local aExpValClo:= {}
	Local _nAjusta	:= 0
	Local lExisOdo	:= .F.
	Local _nVlrOdo	:= 0
	Local _nPosCop	:= 0
	Local nContNeg	:= 0
	Local cTmp		:= ''
	Local aTmp		:= {}
	Local nI		:= 0
	
	Private aVetDet := {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define indices e tabelas para uso.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SE1->(DbSetOrder(1))
	BA1->(DbSetOrder(2))
	BHH->(DbSetOrder(1))
	BSP->(DbSetOrder(1))
	BSQ->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validacao para emitir somente se nao houverem titulos som. de copart³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := " SELECT Count(BM1F.R_E_C_N_O_ ) AS TOTAL 	"
	cSQL += " FROM "+RetSQLName("BM1")+" BM1F, "+RetSQLName("BA3")+" BA3, "+RetSQLName("SE1")+ " SE1 "
	cSQL += " WHERE BM1F.BM1_FILIAL = '"+xFilial("BM1")+"' "
	cSQL += " AND BM1F.BM1_MES = '"+M->PBR_MESREM+"' "
	cSQL += " AND BM1F.BM1_ANO = '"+M->PBR_ANOREM+"' "
	cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+"' "
	cSQL += " AND BM1F.BM1_CODINT = BA3_CODINT "
	cSQL += " AND BM1F.BM1_CODEMP = BA3_CODEMP "
	cSQL += " AND BM1F.BM1_MATRIC = BA3_MATRIC "
	cSQL += " AND E1_FILIAL = '"+xFilial("SE1")+"' "
	cSQL += " AND E1_PREFIXO = BM1_PREFIX "
	cSQL += " AND E1_NUM = BM1_NUMTIT "
	cSQL += " AND E1_PARCELA = BM1_PARCEL "
	cSQL += " AND E1_TIPO = BM1_TIPTIT "
	//cSQL += " AND E1_YTPEXP = ' ' "
	//ALERT("tIRAR")
	
	If M->PBR_TIPREM == "2" //Previ
		cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGRIOP","'1001','1002','1003'")+") "
	ElseIf M->PBR_TIPREM == "3" //BERJ
		cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGBERJ","'1500'")+") "
	Else //Controle de erros - nao envia nada...
		cSQL += " AND 0 = 1 "
	EndIf
	
	cSQL += " AND BA3_TIPPAG <> '00' "
	cSQL += " AND E1_FORMREC <> '00' "
	cSQL += " AND E1_FORMREC <> ' ' "
	cSQL += " AND ( BA3_DATBLO = ' ' AND ( "
	cSQL += "   SELECT Count(R_E_C_N_O_) "
	cSQL += "   FROM BA1010 "
	cSQL += "   WHERE BA1_FILIAL = '  ' "
	cSQL += "   AND BA1_CODINT = BA3_CODINT "
	cSQL += "   AND BA1_CODEMP = BA3_CODEMP "
	cSQL += "   AND BA1_MATRIC = BA3_MATRIC "
	cSQL += "   AND BA1_DATBLO = ' ' "
	
	//Leonardo Portella - 05/03/15 - Forcar que sejam enviados somente forma de cobranca 01 e 08
	//da Previ, conforme Esther e Alan
	cSQL += "   AND BA3_TIPPAG IN ( '01','08' ) "
	
	cSQL += "   AND BA1010.D_E_L_E_T_ = ' ' "
	cSQL += "  ) > 0 ) "
	cSQL += " AND ( "
	cSQL += "   SELECT Count(R_E_C_N_O_) "
	cSQL += "   FROM BM1010 BM1I  "
	cSQL += "   WHERE BM1I.BM1_FILIAL = BM1F.BM1_FILIAL "
	cSQL += "   AND BM1I.BM1_PREFIX = BM1F.BM1_PREFIX "
	cSQL += "   AND BM1I.BM1_NUMTIT = BM1F.BM1_NUMTIT "
	cSQL += "   AND BM1I.BM1_PARCEL = BM1F.BM1_PARCEL "
	cSQL += "   AND BM1I.BM1_TIPTIT = BM1F.BM1_TIPTIT "
	//cSQL += "   AND BM1I.BM1_CODTIP <> '101' "
	cSQL += "   AND BM1I.D_E_L_E_T_ = ' ' "
	cSQL += " ) = 0 "
	cSQL += " AND BM1F.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA3.D_E_L_E_T_ = ' ' "
	cSQL += " AND SE1.D_E_L_E_T_ = ' ' "
	
	PLSQuery(cSQL,"TRB")
	
	If TRB->TOTAL > 0
		MsgAlert("Existem títulos a serem exportados para Rio Previdência sem mensalidade! Impossível continuar! Geração abortada!")
		TRB->(DbCloseArea())
		Return {0,0}
	EndIf
	
	TRB->(DbCloseArea())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso nao exista nenhum titulo somente com copart, continuar a rotina³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	For nCont := 1 to 2
		
		If nCont = 1
			cSQL := " SELECT COUNT("+RetSQLName("BM1")+".R_E_C_N_O_) AS TOTAL "
		Else
			cSQL := " SELECT BA3_MATEMP, BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB, "
			cSQL += " BM1_MES, BM1_ANO, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
			cSQL += " BA3_VALSAL, BA3_DATBLO, BA3_MOTBLO , BA3_CODPLA, BA3_TIPPAG, BA3_GRPCOB, decode(BM1_CODTIP,'101','101','999') BM1_CODTIP, sum(DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) BM1_VALOR "
		EndIf
		
		cSQL += " FROM "+RetSQLName("BM1")+", "+RetSQLName("BA3")+", "+RetSQLName("SE1")
		cSQL += " WHERE BM1_FILIAL = '"+xFilial("BM1")+ "' "
		cSQL += " AND BM1_CODINT = '"+M->PBR_CODINT+ "' "
		cSQL += " AND BM1_ANO = '"+M->PBR_ANOREM+"' "
		cSQL += " AND BM1_MES = '"+M->PBR_MESREM+"' "
		cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+ "' "
		cSQL += " AND BM1_CODINT = BA3_CODINT "
		cSQL += " AND BM1_CODEMP = BA3_CODEMP "
		cSQL += " AND BM1_MATRIC = BA3_MATRIC "
		cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGRIOP","'1001','1002','1003'")+") "
		cSQL += " AND (BA3_TIPPAG <> '00') "
		cSQL += " AND E1_FORMREC <> '00' "
		cSQL += " AND E1_FORMREC <> ' ' "
		
		//Leonardo Portella - 05/03/15 - Forcar que sejam enviados somente forma de cobranca 01 e 08
		//da Previ, conforme Esther e Alan
		cSQL += " AND BA3_TIPPAG IN ( '01','08' ) "
		
		If M->PBR_TIPREM == "2" //Previ
			cSQL += " AND E1_FORMREC IN ('01','08') "
		EndIf
		
		//Fim da nova implementacao: filtro por grupo de cobranca.
		cSQL += " AND E1_FILIAL  = '"+xFilial("SE1")+ "' "
		cSQL += " AND E1_PREFIXO = BM1_PREFIX "
		cSQL += " AND E1_NUM     = BM1_NUMTIT "
		cSQL += " AND E1_PARCELA = BM1_PARCEL "
		cSQL += " AND E1_TIPO    = BM1_TIPTIT "
		cSQL += " AND E1_YTPEXP = ' ' "
		cSQL += " AND "+RetSQLName("BM1")+".D_E_L_E_T_ <> '*' "
		cSQL += " AND "+RetSQLName("BA3")+".D_E_L_E_T_ <> '*' "
		cSQL += " AND "+RetSQLName("SE1")+".D_E_L_E_T_ <> '*' "
		
		If nCont > 1
			
			cSQL += " GROUP BY BA3_MATEMP, BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB,  "
			cSQL += " BM1_MES, BM1_ANO, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
			cSQL += " BA3_VALSAL, BA3_DATBLO, BA3_MOTBLO , BA3_CODPLA, BA3_TIPPAG, BA3_GRPCOB, decode(BM1_CODTIP,'101','101','999') "
			
			cSQL += " ORDER BY BA3_MATEMP, BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG "
			
		EndIf
		
		PLSQuery(cSQL,"TRB")
		
		If nCont = 1
			nTotReg := TRB->TOTAL
			TRB->(DbCloseArea())
			
			If nTotReg <= 0
				Help("",1,"RECNO")
				Return aRet
			EndIf
			
		EndIf
		
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Geracao do texto para empresa...     	  ³
	//³ Formato do nome: REMNNNNN.TXT onde:       ³
	//³ REM: Indica a arquivo de remessa     	  ³
	//³ NNNNN: Sequencial de remessa do arquivo.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcRegua(nTotReg)
	cNomeArq := cDirExp+M->(PBR_PREREM+PBR_CODREM)+".TXT"
	
	cDatRem := DtoS(M->PBR_DATREM)
	cDatRem := Substr(cDatRem,7,2)+"/"+Substr(cDatRem,5,2)+"/"+Substr(cDatRem,1,4)
	
	If nTotReg > 0
		
		If U_Cria_TXT(cNomeArq)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime linha de cabecalho...                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cLin := Space(1)+cEOL
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime linha detalhe...                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			
			While ! TRB->(EOF())
				
				nReg++
				IncProc("Registro: "+StrZero(nReg,6)+"/"+StrZero(nTotReg,6))
				
				
				If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) <> cMatric .And. cMatric <> ""
					
					_nRec := aScan(aExpVal,{|x| x[5] == "999"})
					
					//Nova regra definida por Caberj
					If _nRec <> 0 .and. aExpVal[_nRec][2] < 0
						aExpVal[_nRec,3] := "3" //Creditos diversos / nao enviar...
						aadd(aCritica,{"Usuário com item menor que zero! "+cMatric})
					EndIf
					
					For nCont := 1 to Len(aExpVal)
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valida criticas de exportacao. Caso nao encontre, exportar...       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						If aExpVal[nCont,3] == "0"  .and. aExpVal[nCont,5] <> '101' //mbctirar
							
							nSeq++
							cLin := Space(1)+cEOL
							cCpo := "1"+cMatEmp+space(11)+cNomUsr+StrZero((aExpVal[nCont,2])*100,13)+aExpVal[nCont,1]+StrZero(nSeq,7)+space(40)+Substr(cMatric,1,16)
							//	cCpo := AllTrim(cMatEmp)+Space(15-Len(AllTrim(cMatEmp)))+cMatric+aExpVal[nCont,1]+StrZero((aExpVal[nCont,2])*100,12)+cSequen
							
							If !(U_GrLinha_TXT(cCpo,cLin))
								MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O REGISTRO DETALHE! OPERAÇÃO ABORTADA!")
								Return aRet
							EndIf
							
						EndIf
						
						PBS->(RecLock("PBS",.T.))
						PBS->PBS_FILIAL	:= xFilial("PBS")
						PBS->PBS_STATUS	:= IIf(aExpVal[nCont,3]=="0","1","2")
						PBS->PBS_PREREM	:= M->PBR_PREREM
						PBS->PBS_CODREM := M->PBR_CODREM
						PBS->PBS_PRETIT := cPreTit
						PBS->PBS_NUMTIT := cNumTit
						PBS->PBS_PARTIT := cParTit
						PBS->PBS_TIPTIT := cTipTit
						PBS->PBS_CODINT := Substr(cMatric,1,4)
						PBS->PBS_CODEMP := Substr(cMatric,5,4)
						PBS->PBS_MATRIC := Substr(cMatric,9,6)
						PBS->PBS_TIPREG := Substr(cMatric,15,2)
						PBS->PBS_DIGITO := Substr(cMatric,17,1)
						PBS->PBS_CODDES := aExpVal[nCont,1]
						PBS->PBS_VLRDES := aExpVal[nCont,2]
						PBS->PBS_CODERR := aExpVal[nCont,3]
						**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na PBS para conferência futura'**
						PBS->PBS_CODEVE := aExpVal[nCont,4]
						PBS->PBS_TIPMOV := iIf(aExpVal[nCont,5] <> '101', 'D', 'M')
						PBS->PBS_MATEMP := cMatEmp
						PBS->PBS_CODTEC := cTec
						**'Marcela Coimbra - 03/02/2012 - Fim - Cadastro código do evento na PBS para conferência futura'**
						
						PBS->(MsUnlock())
						
						nPos := aScan(aExpTit,SE1->(Recno()))
						
						If PBS->PBS_CODERR == "0"
							
							nVlrTot += PBS->PBS_VLRDES
							nTotMen	+= iIf(aExpVal[nCont,5] == '101', aExpVal[nCont,2], 0)
							nTotDiv	+= iIf(aExpVal[nCont,5] <> '101', aExpVal[nCont,2], 0)
							
							nQtdMen	+= iIf(aExpVal[nCont,5] == '101', 1, 0)
							nQtdDiv	+= iIf(aExpVal[nCont,5] <> '101', 1, 0)
							
						EndIf
						
						If nPos == 0
							aadd(aExpTit,SE1->(Recno()))
						EndIf
						
					Next
					
					cMatEmp := ""
					cNomUsr := ""
					cPreTit	:= ""
					cNumTit	:= ""
					cParTit	:= ""
					cTipTit	:= ""
					aExpVal := {}
					cCodErr := "0"
					lExisOdo:= .F.
					_nVlrOdo:= 0
					
				EndIf // fim odonto
				
				cMatric	:= TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
				cPreTit	:= TRB->BM1_PREFIX
				cNumTit	:= TRB->BM1_NUMTIT
				cParTit	:= TRB->BM1_PARCEL
				cTipTit	:= TRB->BM1_TIPTIT
				cTMatEmp:= TRB->(BA3_MATEMP)
				cTec 	:= POSICIONE("BA1", 2, XfILIAL("BA1") + cMatric, "BA1_XTEC" )
				
				If ! SE1->(DbSeek(xFilial("SE1")+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)))
					MsgAlert("TITULO: "+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+" NÃO ENCONTRADO NO CTS A RECEBER! OPERAÇÃO ABORTADA!" )
					Return aRet
				Else
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Caso o titulo ja tenha sido enviado, nao reenviar...                ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty(SE1->E1_YTPEXP)
						aadd(aCritica,{"Título já exportado em outra remessa! "+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)})
						TRB->(DbSkip())
						Loop
					EndIf
					
					If SE1->(E1_ANOBASE+E1_MESBASE)	>= Substr(DtoS(TRB->BA3_DATBLO),1,6) .And. !Empty(TRB->BA3_DATBLO)
						cCodErr := "9" //Familia bloqueada...
					EndIf
					
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Array para critica caso valor da composicao seja negativo...        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If TRB->BM1_VALOR < 0
					cCodErr := "1" //Valor Negativo
				EndIf
				
				//Criticar caso salario menor que 700 e Rio Prev.
				If TRB->BA3_VALSAL < GetNewPar("MV_YVLSLP",700) .And. TRB->BA3_TIPPAG = '01' .And. TRB->BA3_GRPCOB $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'")
					aadd(aCritica,{"Usuário não encontrado no cadastro! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
					//Alert("1" + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) )
					aAdd(aTmp,"8 - Salario incompativel com Rio Prev: " + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
					cCodErr := "8" //Salario incompativel com Rio Prev
				EndIf
				
				If ! BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)))
					aadd(aCritica,{"Usuário não encontrado no cadastro! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
					
					aAdd(aTmp,"- Usuário não encontrado no cadastro: " + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
					//Alert("1" + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) )
					
					TRB->(DBSkip())
					Loop
				Else
					//cMatEmp := AllTrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(AllTrim(Substr(BA1->BA1_MATEMP,1,9))))
					cMatEmp := Replicate('0',(8-Len(AllTrim(Substr(TRB->BA3_MATEMP,1,8))))) + AllTrim(Substr(TRB->BA3_MATEMP,1,8))
					// Motta 14/8/7
					cNomUsr	:= AllTrim(BA1->BA1_NOMUSR)+space(50-Len(AllTrim(BA1->BA1_NOMUSR)))
					
					//MELHORIA JEAN
					//BUSCA NO TITULAR
					If Empty(AllTrim(cMatEmp))
						_nRecNoBA1 := BA1->(Recno())
						If BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+"00")))
							//cMatEmp := AllTrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(AllTrim(Substr(BA1->BA1_MATEMP,1,9))))
							cMatEmp := Replicate('0',(8-Len(AllTrim(Substr(TRB->BA3_MATEMP,1,8))))) + AllTrim(Substr(TRB->BA3_MATEMP,1,8))
							// Motta 14/8/7
						EndIf
						BA1->(DbGoTo(_nRecNoBA1))
					EndIf
					
					//BUSCA NA FAMILIA
					If Empty(AllTrim(cMatEmp))
						//cMatEmp := AllTrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(AllTrim(Substr(BA1->BA1_MATEMP,1,9))))
						cMatEmp := Replicate('0',(8-Len(AllTrim(Substr(TRB->BA3_MATEMP,1,8))))) + AllTrim(Substr(TRB->BA3_MATEMP,1,8))
						// Motta 14/8/7
					EndIf
					//FIM MELHORIA JEAN
					
					If Empty(AllTrim(cMatEmp))
						aadd(aCritica,{"Usuário não possui matrícula funcional! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
						TRB->(DBSkip())
						Loop
					EndIf
				EndIf
				
				//Jean - Fim do odontologico...
				
				_cCodEve := AllTrim(TRB->BA3_CODPLA)
				
				If ! ZUN->(MsSeek(xFilial("ZUN")+iIf(TRB->BM1_CODTIP == '101', "M", "D")+AllTrim(_cCodEve))) // ml
					aadd(aCritica,{"De x Para de lançamentos de faturamento não encontrado! Lançamento:  Produto: "+;
						AllTrim(_cCodEve)+" Usuário: "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
					TRB->(DBSkip())
					Loop
				Else
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ VerIficar se linha ja foi exportada, e analisada...                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If PBS->(MsSeek(xFilial("PBS")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO+BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+ZUN->ZUN_RUBRIC)) .And. !(PBS->PBS_STATUS $ "1,2")
						aadd(aCritica,{"Item de faturamento já enviado! Usuario: "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)+" Titulo: "+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+" Despesa: "+ZUN->ZUN_RUBRIC})
						TRB->(DbSkip())
						Loop
					EndIf
					
					nPos := aScan(aExpVal,{|x| x[1]+x[5] == ZUN->ZUN_RUBRIC + TRB->BM1_CODTIP})
					
					If nPos > 0
						aExpVal[nPos,2] += TRB->BM1_VALOR
					Else
						aadd(aExpVal,{	ZUN->ZUN_RUBRIC,;  // 1
						TRB->BM1_VALOR,;// 2
						cCodErr,;// 3
						ZUN->ZUN_CODPLA,;// 4
						TRB->BM1_CODTIP})// 5
					EndIf
					
				EndIf
				
				TRB->(DbSkip())
				
			Enddo
			
			TRB->(DbCloseArea())
			
			For nI := 1 to 50
				If nI > len(aTmp)
					Exit
				EndIf
				If ( nI == 1 ) .and. ( len(aTmp) > 50 )
					cTmp += 'Existem mais de 50 críticas. Exibindo apenas as 50 primeiras...' + CRLF + CRLF
				EndIf
				cTmp += aTmp[nI] + CRLF
			Next
			
			LogErros(cTmp,AllTrim(SM0->M0_NOMECOM),.T.)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprimir as ultimas linhas da exportacao...                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Conforme solicitado, tratar como unica verba caso exista credito... ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Regra para abatimento odontologico (Rio Previdencia).               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Conforme solicitado, tratar como unica verba caso exista credito... ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//Regra de aglutinacao desativada...
			//Nova regra: nao enviar nenhuma verba de credito...
			_nRec := aScan(aExpVal,{|x| x[5] == "999"})
			
			//Nova regra definida por Caberj
			If _nRec > 0 .and. aExpVal[_nRec][2] < 0
				aExpVal[_nRec,3] := "3" //Creditos diversos / nao enviar...
				aadd(aCritica,{"Usuário com item menor que zero! "+cMatric})
			EndIf
			
			For nCont := 1 to Len(aExpVal)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Valida criticas de exportacao. Caso nao encontre, exportar...       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If aExpVal[nCont,3] == "0"  .and. aExpVal[nCont,5] <> '101' //mbctirar
					
					nSeq++
					cLin := Space(1)+cEOL
					cCpo := "1"+cMatEmp+space(11)+cNomUsr+StrZero((aExpVal[nCont,2])*100,13)+aExpVal[nCont,1]+StrZero(nSeq,7)+space(40)+Substr(cMatric,1,16)
					//cCpo := AllTrim(cMatEmp)+Space(15-Len(AllTrim(cMatEmp)))+cMatric+aExpVal[nCont,1]+StrZero((aExpVal[nCont,2])*100,12)+cSequen
					
					If !(U_GrLinha_TXT(cCpo,cLin))
						MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O REGISTRO DETALHE! OPERAÇÃO ABORTADA!")
						Return aRet
					EndIf
					
				EndIf
				
				PBS->(RecLock("PBS",.T.))
				PBS->PBS_FILIAL	:= xFilial("PBS")
				PBS->PBS_STATUS	:= IIf(aExpVal[nCont,3]=="0","1","2")
				PBS->PBS_PREREM	:= M->PBR_PREREM
				PBS->PBS_CODREM := M->PBR_CODREM
				PBS->PBS_PRETIT := cPreTit
				PBS->PBS_NUMTIT := cNumTit
				PBS->PBS_PARTIT := cParTit
				PBS->PBS_TIPTIT := cTipTit
				PBS->PBS_CODINT := Substr(cMatric,1,4)
				PBS->PBS_CODEMP := Substr(cMatric,5,4)
				PBS->PBS_MATRIC := Substr(cMatric,9,6)
				PBS->PBS_TIPREG := Substr(cMatric,15,2)
				PBS->PBS_DIGITO := Substr(cMatric,17,1)
				PBS->PBS_CODDES := aExpVal[nCont,1]
				PBS->PBS_VLRDES := aExpVal[nCont,2]
				PBS->PBS_CODERR := aExpVal[nCont,3]
				**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na PBS para conferência furtura'**
				PBS->PBS_CODEVE := aExpVal[nCont,4]
				**'Marcela Coimbra - 03/02/2012 - Fim - Cadastro código do evento na PBS para conferência furtura'**
				PBS->PBS_CODEVE := cTMatEmp
				
				
				PBS->(MsUnlock())
				
				If Empty(SE1->E1_YTPEXP)
					SE1->(Reclock("SE1",.F.))
					
					If PBS->PBS_CODERR == "0"
						SE1->E1_YTPEXP	:= "A"  //Rio Previdencia - ENVIO OK - TABELA K1
						SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"A", "X5_DESCRI")
					Else
						SE1->E1_YTPEXP	:= "M"  //Rio Previdencia - ERRO ENVIO - TABELA K1
						SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"M", "X5_DESCRI")
					EndIf
					
					SE1->(MsUnlock())
				EndIf
				
				If PBS->PBS_CODERR == "0"
					
					nVlrTot += PBS->PBS_VLRDES
					
					nTotMen	+= iIf(aExpVal[nCont,5] == '101', aExpVal[nCont,2], 0)
					nTotDiv	+= iIf(aExpVal[nCont,5] <> '101', aExpVal[nCont,2], 0)
					
					nQtdMen	+= iIf(aExpVal[nCont,5] == '101', 1, 0)
					nQtdDiv	+= iIf(aExpVal[nCont,5] <> '101', 1, 0)
					
				EndIf
				
			Next
			
			cMatEmp := ""
			cNomUsr := ""
			cPreTit	:= ""
			cNumTit	:= ""
			cParTit	:= ""
			cTipTit	:= ""
			aExpVal := {}
			cCodErr := "0"
			lExisOdo:= .F.
			_nVlrOdo:= 0
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime linha de rodape...                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cLin := Space(1)+cEOL
			cCpo := "9"+M->(PBR_TIPREM+PBR_PREREM+PBR_CODREM)+space(2)+cDatRem+space(49)+StrZero((nVlrTot*100),13)+space(3)+StrZero(nSeq,7)+space(56)
			
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O RODAPÉ! OPERAÇÃO ABORTADA!")
				Return aRet
			EndIf
			
			U_Fecha_TXT()
			
			//		u_TExAlte()
			
			aRet := {nSeq,nVlrTot, nTotMen,nTotDiv , nQtdMen, nQtdDiv}
			
		EndIf
		
		For nCont := 1 to Len(aExpTit)
			
			SE1->(DbGoTo(aExpTit[nCont]))
			
			If Empty(SE1->E1_YTPEXP)
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= "A"  //Rio Previdencia  - ENVIO - TABELA K1
				SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"A", "X5_DESCRI")
				SE1->(MsUnlock())
			EndIf
			
		Next
		aExpTit := {}
		
		If Len(aCritica) > 0
			PLSCRIGEN(aCritica,{ {"Descrição da crítica","@C",300}},"Críticas encontradas / Exportação...",.T.)
		EndIf
		
		aCritica := {}
		
		**'Função que marca as familias com mudança de valor'**
		U_MudVal(M->PBR_ANOREM, M->PBR_MESREM, M->PBR_CODREM)
		
	EndIf
	
Return aRet

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³N2LGRIO   ºAutor  ³Microsiga           º Data ³  08/30/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FILRIOPR
	
	Local cFilAdic := BuildExpr("PBS",oMainWnd,"")
	
	cFil := "@PBS_FILIAL = '"+xFilial("PBS")+"'"
	cFil += " AND PBS_PREREM = '"+PBR->PBR_PREREM+"' "
	cFil += " AND PBS_CODREM = '"+PBR->PBR_CODREM+"' "
	
	If !Empty(cFilAdic)
		cFilAdic := StrTran(cFilAdic,'"',"'")
		cFilAdic := StrTran(cFilAdic,'==','=')
		cFilAdic := StrTran(cFilAdic,'.AND.','AND')
		cFilAdic := StrTran(cFilAdic,'.OR.','OR')
		cFil += " AND "+cFilAdic
	EndIf
	
	cFil += " AND D_E_L_E_T_ = ' '"
	
	PBS->(DBSetOrder(1))
	DbSelectArea("PBS")
	SET FILTER TO &cFil
	
	CloseBrowse()
	
	PBS->(mBrowse(006,001,022,075,"PBS" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
	PBS->(DbClearFilter())
	
Return Nil

***************************************************************************************************************
***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ IMPRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 26.10.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa o arquivo e sua composicao                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IMP33RIOPR(cAlias,nReg,nOpc)
	
	Local cNmArq 	:= ""
	Local cTitulo 	:= "Baixa títulos"
	Private nTpMov := 1
	
	AjustaSX1(cPerg)
	
	If !Pergunte(cPerg,.T.)
		Return
	End
	
	Pergunte(cPerg,.F.)
	
	/*	cNmArq	:= mv_par01
	nTpMov	:= mv_par02
	*/
	
	dDataBaixa	:= stod(AllTrim(str(mv_par01)))
	
	If dDataBaixa > Date()
		MsgStop("Data Inválida")
		Return
	EndIf
	
	Processa({|| PIMP33RIOPR(dDataBaixa) }, cTitulo, "", .T.)
	
Return

***************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  26/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PIMP33RIOPR(dDataBaixa)
	
	Local aStruc		:= {}
	Local nLinha		:= 0
	Local cLinha		:= ""
	Local aHeader		:= {}
	Local aDetalhe		:= {}
	Local aTrailler	:= {}
	Local nCont			:= 0
	Local nPos			:= 0
	Local l_Previa 		:= .T.
	Local n_Qtd			:= 0
	Local c_Qtd			:= ''
	Local nI			:= 0
	Local nX			:= 0
	Local aPrevia		:= {}
	Local nVlrBx		:= 0
	Local c_MatEmp		:= ''
	
	Private cCodRem		:= ""
	Private cCodInt		:= ""
	Private cCodEmp		:= ""
	Private cMatric		:= ""
	Private cTipReg		:= ""
	Private cConEmp		:= ""
	Private cVerCon		:= ""
	Private cSubCon		:= ""
	Private cVerSub		:= ""
	Private cBsqUsu		:= ""
	Private cCodDes		:= ""
	Private nValor		:= 0
	Private cComent		:= AllTrim(Substr(cLinha,105,30))
	Private cCodPro		:= ""
	Private cVerPro		:= ""
	Private cLanFat		:= ""
	Private cDatBai		:= ""
	Private dDatBai		:= Stod("")
	Private cChaveTit	:= ""
	Private lPrima		:= .T.
	Private aArrAux		:= {}
	Private cMatEmp		:= ""
	Private lAchou		:= .F.
	Private aBaixa		:= {}
	Private aCopBai		:= {}
	Private lBaixou		:= .T.
	Private lSemTit		:= .F.
	Private aParcela	:= {}
	Private aDadUsr		:= {}
	Private aErrImp		:= {}
	Private cTrb
	Private nTotBaixas	:= 0
	Private c_Qry	:= ""
	Private cCodRem
	
	//MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNmArq),CLR_HBLUE})
	//MsgRun("Atualizando Arquivo...",,{|| MSAPPEND( (cNmArq), CLR_HBLUE )})
	
	dDataAtu  := dDataBase
	dDataBase := dDataBaixa
	
	ProcRegua(10000)
	cTotal := 10000
	
	ZUN->(DbSetOrder(1))
	PBS->(DbSetOrder(1))
	BA1->(DbSetOrder(2))
	BA3->(DbSetOrder(1))
	
	BQC->(DbSetOrder(1))
	BT5->(DbSetOrder(1))
	PBR->(DbSetOrder(1))
	
	nLin := 1
	cChaveTit := ""
	
	//ModIficado por Jean emergencialmente.
	//Necessita-se rever conceito da rotina,
	//pois o lote nao deveria ser usado para
	//este fim.
	//LoteCont( "FIN" )
	//cLote := "00008850"
	//cLote := "00008871"//Soma1(cLote)
	
	/*
	dbSelectArea("SE5")
	dbSetOrder(5)
	While dbSeek(xFilial("SE5")+cLote)
		While !Eof() .and. SE5->E5_LOTE == cLote .and. E5_FILIAL == xFilial()
			If SE5->E5_RECPAG == "R"
				cLote := Soma1(cLote)
				Exit
			EndIf
			dbSkip()
		EndDo
	EndDo
	
	*/
	
	c_Qry := " select max(E5_LOTE)  LOTE  "
	c_Qry += " from se5010            "
	c_Qry += " where e5_filial = '01' "
	c_Qry += " and E5_RECPAG = 'R'    "
	c_Qry += " and LENGTH(TRIM(E5_LOTE)) = 8 "
	c_Qry += " and d_e_l_e_t_ = ' ' "
	
	TcQuery c_Qry ALIAS "TMPLOTE" NEW
	
	While !tmplote->( EOF() )
		
		cLote := soma1( tmplote->LOTE )
		
		tmplote->( dbSkip() )
		
	EndDo
	
	If Empty(cLote)
		
		Alert("Deu Ruim no lote")
		
		c := a + 9
		
		cLote := "00008871"//Soma1(cLote)
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validar a composicao do arquivo de retorno e criar array de baixa...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	MontaTmp( PBR->PBR_CODREM, PBR->PBR_ANOREM + PBR->PBR_MESREM )
	
	cCodRem := PBR->PBR_CODREM
	aAnoRem := PBR->PBR_ANOREM
	aMesRem := PBR->PBR_MESREM
	
	Private l_Previa := ( Aviso(AllTrim(SM0->M0_NOMECOM),'Deseja realizar a Prévia (Nada será alterado) ou Baixa?',{'Prévia','Baixa'}) == 1 )
	
	If !l_Previa
		l_Previa := !MsgYesNo('A rotina irá realizar a BAIXA! Confirma?',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
	If l_Previa
		c_Script := "DELETE FROM AN_PREVIA_BAIXA_PREVI WHERE ANO_MES = '" + PBR->(PBR_ANOREM + PBR_MESREM) + "' OR ANO_MES IS NULL"
		
		//COMENTADO PARA DEBUG
		
		If TcSqlExec(c_Script) < 0
			LogErros("Falha ao deletar linhas da tabela AN_PREVIA_BAIXA_PREVI" + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)
			
			Return
		EndIf
		
	EndIf
	
	COUNT TO n_Qtd
	
	ProcRegua(n_Qtd)
	
	c_Qtd 	:= AllTrim(Transform(n_Qtd,'@E 999,999,999'))
	n_Qtd	:= 0
	
	tmpqry->(DbGoTop())
	
	While !tmpqry->(Eof())
		nLinha++
		IncProc("Processando " + If(l_Previa,'Prévia','Baixa') + ": " + Alltrim(Transform(++n_Qtd,'@E 999,999,999')) + " de " + c_Qtd)
		
		nSaldo 		:=  tmpqry->valor
		cMatTot		:=  tmpqry->matricula
		cTecTot		:=  tmpqry->tec
		
		//aBaixa := {}
		
		dbSelectArea("ZRL")
		dbSetOrder(3)
		If dbSeek(xFilial("ZRL") + substr(cTecTot, 3, 13))
			
			cMatTec :=	ZRL_MATRIC
			
		EndIf
		
		If nSaldo > 0
			
			c_Qry := "   SELECT DISTINCT PBS010.R_E_C_N_O_ recPBS, VALOR, PBS_VLRDES, PBS010.*
			
			c_Qry += "   FROM PBS010 INNER JOIN AN_PREVI ON "
			c_Qry += "                     PBS_MATEMP = MATRICULA "
			c_Qry += "               INNER JOIN ZRL010 ON  " //-- TABELA DE JOIN ENTRE PBS E AN_PREVI PELA TEC
			c_Qry += "                     ZRL_MATRIC = PBS_CODINT || PBS_CODEMP || PBS_MATRIC || PBS_TIPREG || PBS_DIGITO "
			
			c_Qry += "   WHERE PBS_CODREM      = '" + cCodRem + "' "
			c_Qry += "         AND PBS_MATEMP  = '" + cMatTot + "' "
			c_Qry += "         AND ANOMES  	   = '" + aAnoRem + aMesRem+ "' "
			c_Qry += "         AND PBS_CODINT || PBS_CODEMP || PBS_MATRIC || PBS_TIPREG  	   = '" + SUBSTR(cMatTec, 1, 16)+ "' "
			
			c_Qry += "         AND ( (PBS_TIPMOV = 'M' AND TEC = '" + cTecTot + "' AND ZRL_TEC = SUBSTR(TEC, 3, 13) )  OR  ( PBS_TIPMOV = 'D' AND PBS_VLRDES = VALOR )  "
			c_Qry += "             ) "
			
			c_Qry += "         AND PBS010.D_E_L_E_T_ = ' '  "
			
			
			
			
			TcQuery c_Qry ALIAS "tmpqry2" NEW
			
			While !tmpqry2->(EOF	())
				
				cCodPro := ""
				cVerPro := ""
				
				PBS->( dbGoTo( tmpqry2->recPBS ) )
				
				cCodInt	:= "0001"
				cCodEmp	:= tmpqry2->PBS_CODEMP
				cMatric	:= tmpqry2->PBS_MATRIC
				cTipReg	:= tmpqry2->PBS_TIPREG
				cCodDes	:= tmpqry2->PBS_CODDES
				cDatBai	:= DTOS(dDataBase)
				dDatBai	:= IIf(Empty(cDatBai),dDataBase,StoD(cDatBai))
				cComent	:= '00'//AllTrim(Substr(cLinha,105,30))
				cCodRem := tmpqry2->PBS_CODREM
				
				
				
				nValor	:= tmpqry2->VALOR//PBS_VLRDES // IIf( tmpqry2->PBS_VLRDES < nSaldo , tmpqry2->PBS_VLRDES, nSaldo)
				
				//Quando ocorria de valor na PBS mas o saldo zerado ele faz nValor := 0 e tentava baixa de valor zero
				//If nValor <= nSaldo
				If  ( nValor > 0 )   // ( nValor <= nSaldo ) .and.
					
					If 	BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg))
						BA3->(MsSeek(xFilial("BA3")+cCodInt+cCodEmp+cMatric))
						
						cConEmp 	:= BA1->BA1_CONEMP
						cVerCon 	:= BA1->BA1_VERCON
						cSubCon 	:= BA1->BA1_SUBCON
						cVerSub 	:= BA1->BA1_VERSUB
						cBsqUsu 	:= BA1->(	BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO )
						cMatEmp		:= StrZero(Val(BA3->BA3_MATEMP),15)
						
						c_MatEmp 	:= StrZero(Val(BA3->BA3_MATEMP),8)
						
						If BA3->BA3_COBNIV == "1" .Or. BA1->BA1_COBNIV == "1"
							cConEmp := ""
							cVerCon := ""
							cSubCon := ""
							cVerSub := ""
						Else
							If Posicione("BQC",1,xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB),"BQC_COBNIV") <> "1"
								cSubCon := ""
								cVerSub := ""
							EndIf
							
							If Posicione("BT5",1,xFilial("BT5")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON),"BT5_COBNIV") <> "1"
								cConEmp := ""
								cVerCon := ""
							EndIf
						EndIf
						If Empty(BA1->BA1_CODPLA)
							cCodPro := BA3->BA3_CODPLA
							cVerPro := BA3->BA3_VERSAO
						Else
							cCodPro := BA1->BA1_CODPLA
							cVerPro := BA1->BA1_VERSAO
						EndIf
						If Val(cMatEmp) = 0
							cMatEmp	:= StrZero(Val(BA3->BA3_MATEMP),15)
						EndIf
					EndIf
					If !(PBS->PBS_STATUS $ "3,4")//1=Enviado;2=Criticado;3=Baixado
						
						**'Marcela Coimbra - 03/02/2012 - Se tiver cadastrado código do evento na PBS uso ele para pegar o plano'**
						cCodPro := AllTrim(iIf( Empty(PBS->PBS_CODEVE), cCodPro,  PBS->PBS_CODEVE ))
						**'Marcela Coimbra - 03/02/2012 - Se tiver cadastrado código do evento na PBS uso ele para pegar o plano'**
						
						If .t.
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Alimentar matriz de baixa e parcelamento, conforme o caso...        ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							cChaveTit := PBS->(PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT)
							nPos := aScan( aBaixa, { |x| AllTrim(x[1]+x[2]+x[3]+x[4]+x[5]) == AllTrim(IIf(Substr(cComent,1,2) == "00","NOR","NEG")+cChaveTit) } )
							If nPos == 0
								//Implementada esta funcao para melhorar o desempenho
								If Len(aBaixa)>0
									
									If l_Previa
										For nX := 1 to len(aBaixa)
											cMsg := 'BAIXA: ' + If(Substr(cComent,1,2) == "00","NOR","NEG") + '; '
											cMsg += 'TITULO: ' + PBS->(PBS_PRETIT + PBS_NUMTIT + PBS_PARTIT + PBS_TIPTIT) + '; '
											cMsg += 'DT BAIXA: ' + DtoC(dDatBai) + '; '
											cMsg += 'DESCRI: BX. AUTOM. RIO PREV. ' + cLote + '; '
											cMsg += 'VALOR: ' + cValToChar(aBaixa[nX][8])
											
											aAdd(aPrevia,{cMsg,aBaixa[nX][2],aBaixa[nX][3],aBaixa[nX][4],aBaixa[nX][5],aBaixa[nX][8],aBaixa[nX][10]})
										Next
									Else
										BxTitulo()
									EndIf
									
									aBaixa := {}
								EndIf
								aAdd(aBaixa,{IIf(Substr(cComent,1,2) == "00","NOR","NEG"),PBS->PBS_PRETIT,PBS->PBS_NUMTIT,PBS->PBS_PARTIT,PBS->PBS_TIPTIT,dDatBai,"BX. AUTOM. RIO PREV. " + cLote,nValor,{{cCodDes,nValor}},c_MatEmp})
								nSaldo := nSaldo - nValor
							Else
								aBaixa[nPos,8] += nValor
								//nSaldo:= nSaldo - nValor
								aArrAux := aClone(aBaixa[1,9])
								nPos2 := aScan(aArrAux,{|x| AllTrim(x[1]) == AllTrim(cCodDes)})
								If nPos2 == 0
									aadd(aBaixa[nPos,9],{cCodDes,nValor})
								Else
									aBaixa[nPos,9,nPos2,2] += nValor
								EndIf
								aArrAux := {}
							EndIf
						Else
							cMsg := "Codigo de despesa x Lancto. faturamento não encontrado! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes
							
							aAdd(aPrevia,{cMsg})
							aAdd(aErrImp,{cMsg})
						EndIf
					Else
						cMsg := "Registro não encontrado! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes
						
						aAdd(aPrevia,{cMsg})
						aadd(aErrImp,{cMsg})
					EndIf
				Else
					
					cMsg := "Valor de baixa menor ou igual a Zero! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes
					
					aAdd(aPrevia,{cMsg})
					aadd(aErrImp,{cMsg})
				EndIf
				
				
				tmpqry2->(dbSkip())
				
			EndDo
			
		EndIf
		
		tmpqry2->(dbCloseArea())
		
		tmpqry->(DbSkip())
		
	Enddo
	
	tmpqry->(DbCloseArea())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ultimo registro...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aBaixa) > 0
		If l_Previa
			For nX := 1 to len(aBaixa)
				cMsg := 'BAIXA: ' + If(Substr(cComent,1,2) == "00","NOR","NEG") + '; '
				cMsg += 'TITULO: ' + PBS->(PBS_PRETIT + PBS_NUMTIT + PBS_PARTIT + PBS_TIPTIT) + '; '
				cMsg += 'DT BAIXA: ' + DtoC(dDatBai) + '; '
				cMsg += 'DESCRI: BX. AUTOM. RIO PREV. ' + cLote + '; '
				cMsg += 'VALOR: ' + cValToChar(aBaixa[nX][8])
				
				aAdd(aPrevia,{cMsg,aBaixa[nX][2],aBaixa[nX][3],aBaixa[nX][4],aBaixa[nX][5],aBaixa[nX][8],aBaixa[nX][10]})
			Next
		Else
			BxTitulo()
		EndIf
		
		aBaixa := {}
	EndIf
	
	//	Gera movimentação bancária e atualiza saldo caso
	//	a movimentação bancária seja baseada no valor total.
	If nTpMov == 1 .And. nTotBaixas > 0
		
		If l_Previa
			cMsg := 'MOVIMEN. SE5: '
			cMsg += 'E5_BANCO: ' 	+ cBanco
			cMsg += 'E5_AGENCIA: '	+ cAgencia
			cMsg += 'E5_CONTA: '	+ cConta
			cMsg += 'E5_VALOR: '	+ cValToChar(nTotBaixas)
			cMsg += 'E5_RECPAG: '	+ "R"
			cMsg += 'E5_HISTOR: '	+ "BX. AUTOM. RIO PREV. " + cLote
			cMsg += 'E5_DTDIGIT: '	+ DtoC(dDataBase)
			cMsg += 'E5_DATA: '		+ DtoC(dDataBase)
			cMsg += 'E5_NATUREZ: '	+ "BX.RIOPR"
			cMsg += 'E5_LOTE: '		+ cLote
			cMsg += 'E5_TIPODOC: ' 	+ "BL"
			cMsg += 'E5_DTDISPO: '	+ DtoC(dDataBase)
			
			aAdd(aPrevia,{cMsg})
		Else
			// Gerar movimentação bancária
			Reclock( "SE5" , .T. )
			SE5->E5_FILIAL	:= xFilial()
			SE5->E5_BANCO	:= cBanco
			SE5->E5_AGENCIA	:= cAgencia
			SE5->E5_CONTA	:= cConta
			SE5->E5_VALOR	:= nTotBaixas
			SE5->E5_RECPAG	:= "R"
			SE5->E5_HISTOR	:= "BX. AUTOM. RIO PREV. " + cLote
			SE5->E5_DTDIGIT	:= dDataBase
			SE5->E5_DATA	:= dDataBase
			SE5->E5_NATUREZ	:= "BX.RIOPR"
			SE5->E5_LOTE	:= cLote
			SE5->E5_TIPODOC := "BL"
			SE5->E5_DTDISPO	:= dDataBase
			If SpbInUse()
				SE5->E5_MODSPB := "1"
			EndIf
			MsUnlock()
		EndIf
		
		//Atualizar saldo.
		//AtuSalBco(cBanco, cAgencia, cConta, dDatabase, nTotBaixas, "+")
		
		/*
		PBR->(Reclock("PBR",.F.))
		PBR->PBR_STATUS := "2"
		PBR->(MsUnlock())
		*/
	EndIf
	
	If Len(aErrImp) > 0
		PLSCRIGEN(aErrImp,{ {"Descrição da crítica","@C",300}},"Críticas encontradas / Importação...",.T.)
	EndIf
	
	aErrImp		:= {}
	aBaixa		:= {}
	aParcela	:= {}
	aDadUsr		:= {}
	
	dDataBase 	:= dDataAtu
	
	ProcRegua(len(aPrevia))
	
	For nI := 1 to len(aPrevia)
		
		IncProc("Incluindo log...")
		
		If len(aPrevia[nI]) > 1
			c_Script := "INSERT INTO AN_PREVIA_BAIXA_PREVI (ID,DATA_PREVIA,PRETIT,NUMTIT,PARTIT,TIPTIT,VLR_BX_PREVIA,MATEMP,OBS) VALUES ( " +;
				"ID_PREVIA_BAIXA_PREVI.NEXTVAL," 	+ ;
				"SYSDATE," 							+ ;
				"'" + aPrevia[nI][2] 		+ "'," 	+ ;
				"'" + aPrevia[nI][3] 		+ "'," 	+ ;
				"'" + aPrevia[nI][4] 		+ "'," 	+ ;
				"'" + aPrevia[nI][5] 		+ "'," 	+ ;
				cValToChar(aPrevia[nI][6]) 	+  "," 	+ ;
				"'" + aPrevia[nI][7] 		+ "'," 	+ ;
				"'" + aPrevia[nI][1] 		+ "')"
		Else
			c_Script := "INSERT INTO AN_PREVIA_BAIXA_PREVI (ID,DATA_PREVIA,OBS) VALUES ( " + ;
				"ID_PREVIA_BAIXA_PREVI.NEXTVAL," 	+ ;
				"SYSDATE," 							+ ;
				"'" + aPrevia[nI][1] + "')"
		EndIf
		
		//COMENTADO PARA DEBUG
		
		If TcSqlExec(c_Script) < 0
			LogErros("Falha ao inserir o registro da linha " + cValToChar(nI) + " na tabela AN_PREVIA_BAIXA_PREVI" + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)
			
			If !MsgYesNo('Continua?',AllTrim(SM0->M0_NOMECOM))
				Exit
			EndIf
			
		EndIf
		
	Next
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BxTitulo  ºAutor  ³Microsiga           º Data ³  09/20/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Baixa de titulo individual, para melhorar performance do    º±±
±±º          ³sistema.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function BxTitulo()
	
	Local aAreaPBS := PBS->(GetArea())
	Local nCont2	:= 0
	Local _cRecSE1	:= 0
	Local i__f
	Local nCont
	PBS->(DbSetOrder(1)) //PBS_FILIAL+PBS_PREREM+PBS_CODREM+PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT
	
	//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	³ Inicia a transacao / garantia de integridade na baixa do arquivo... ³
	//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Begin Transaction
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Baixar os titulos conforme matriz de baixa...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	For nCont := 1 to Len(aBaixa)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIficar se o titulo possui alguma composicao como baixa normal.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan( aBaixa, { |x| x[1] == "NOR" } )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Caso nenhuma baixa ok seja encontrada, nao realizar operacao nenhuma³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lBaixou := .F.
		lSemTit := .F.
		
		If nPos > 0
			lBaixou := BaixaTitulo(aBaixa[nCont,1],aBaixa[nCont,2],aBaixa[nCont,3],aBaixa[nCont,4],aBaixa[nCont,5],aBaixa[nCont,6],aBaixa[nCont,7],aBaixa[nCont,8])
		Else
			aadd(aErrImp,{"Nenhuma baixa autorizada no título: "+aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]})
			lSemTit := .T.
		EndIf
		
		If lBaixou
			nTotBaixas += aBaixa[nCont,8]
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Modificar o status da composicao e do cabecalho da exportacao...    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		For nCont2 := 1 To Len(aBaixa[nCont,9])
			PBS->(MsSeek(xFilial("PBS")+cCodRem+aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]))
			While !PBS->(Eof()) .And. PBS->(PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT) == aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]
				
				If PBS->PBS_CODDES == aBaixa[nCont,9,nCont2,1]
					PBS->(Reclock("PBS",.F.))
					PBS->PBS_STATUS := IIf(aBaixa[nCont,1]=="NOR","3","4")
					If lSemTit
						PBS->PBS_CODERR := "5" // Nenhuma baixa autorizada no titulo...
						_cRecSE1 := SE1->(Recno())
						SE1->(MsSeek(xFilial("SE1")+PBS->(PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT)))
						SE1->(Reclock("SE1",.F.))
						SE1->E1_YTPEXP	:= "N" // Retorno Rio Prev - nenhuma bx autorizada - Tabela K1
						SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"N", "X5_DESCRI")
						SE1->(MsUnlock())
						SE1->(DbGoTo(_cRecSE1))
					EndIf
					If !lBaixou
						PBS->PBS_CODERR := "6" // Problema na baixa...
					EndIf
					
					**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na PBS para conferência furtura'**
					
					If lBaixou  .and. !lSemTit
						PBS->PBS_BAIXAD := DATE()
					EndIf
					
					**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na PBS para conferência furtura'**
					
					PBS->(MsUnlock())
				EndIf
				
				PBS->(DbSkip())
				
			EndDo
		Next
		
		If lPrima
			lPrima := .F.
			If PBR->(MsSeek(xFilial("PBR")+cCodRem))
				If PBR->PBR_STATUS == "1"
					PBR->(Reclock("PBR",.F.))
					PBR->PBR_STATUS := "2"
					PBR->(MsUnlock())
				EndIf
			EndIf
		EndIf
		
		If aBaixa[nCont,1] == "NEG" .And. !lSemTit
			cAnoMesAd := U_SomaComp(Substr(DtoS(dDataBase),1,6))
			aadd(aParcela,{cAnoMesAd,aBaixa[nCont,8],"",GetNewPar("MV_YCDLNEG","999"),"","","LANCTO AUTOMATICO RIO PREV."})
			aDadUsr := {cCodInt,cCodEmp,cMatric,cConEmp,cVerCon,cSubCon,cVerSub,"",cBsqUsu}
			If !U_GerAdNeg(aParcela,aDadUsr,SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
				MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
			EndIf
		EndIf
	Next
	
	//End Transaction
	RestArea(aAreaPBS)
	
Return

***************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³BaixaTituloº Autor ³ Jean Schulz       º Data ³  27/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Baixa de titulo financeiro, conforme parametros...         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo,dDtBaixa,cHisBaixa,nVlrBaixa, n_TotBx, c_Lote)
	
	Local lRet := .F.
	
	Private lmsErroAuto := .f.
	Private lmsHelpAuto := .t. // para mostrar os erros na tela
	
	nTpMov := 1
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)) .and. cNumero <> '002324762'
		
		If SE1->E1_SALDO > 0
			nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, nVlrBaixa)
			SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
			SA6->(MsSeek(xFilial("SA6")+"3416015 017251     "))
			
			aCamposSE5 := {}
			aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
			aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
			aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
			aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
			aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
			aAdd(aCamposSE5, {"E1_LOTE"		, c_Lote			, Nil})
			aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
			aAdd(aCamposSE5, {"AUTBANCO"	, SA6->A6_COD		, Nil})
			aAdd(aCamposSE5, {"AUTAGENCIA"	, SA6->A6_AGENCIA	, Nil})
			aAdd(aCamposSE5, {"AUTCONTA"	, SA6->A6_NUMCON	, Nil})
			
			aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})
			
			msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)
			
			If lMsErroAuto
				lRet := .F.
				//	aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
				MostraErro()
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= "F" // RETORNO RIO PREVIDENCIA - ERRO - TABELA K1
				SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"F", "X5_DESCRI")
				SE1->(MsUnlock())
				
			Else
				
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= "E" // RETORNO RIO PREVIDENCIA - OK - TABELA K1
				SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"E", "X5_DESCRI")
				SE1->(MsUnlock())
				//Informa o lote no movimento totalizador
				If nTpMov == 1
					SE5->(Reclock("SE5",.F.))
					SE5->E5_TIPODOC	:= "BA"
					SE5->E5_LOTE	:= c_Lote
					SE5->(MsUnlock())
				EndIf
				
				n_TotBx+= nVlrBaixa
				
				//	lRet := .T.
			EndIf
		Else
			//		aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		EndIf
		
	EndIf
	
Return lRet

***************************************************************************************************************

Static  Function MontaTmp( c_CodRem, c_AnoMes )

Local aEstrutura := {;
	{'PBS_numtit','C', 9,0}, ;
	{'PBS_CODEMP','C', 4,0}, ;
	{'PBS_MATRIC','C', 6,0}, ;
	{'PBS_TIPREG','C', 2,0}, ;
	{'EVENTO'    ,'C', 3,0}, ;
	{'VALOR'     ,'N',10,2}, ;// Cria a tabela com a RDD corrente
{'recPBS'    ,'N',10,0}  }// Cria a tabela com a RDD corrente


//PORTELLA - ALTERAR TITULOS QUE NAO PODEM SER BAIXADOS AQUI
/*
c_Qry := " SELECT PBS_numtit, PBS_CODEMP, PBS_MATRIC, PBS_TIPREG,  RETORNO.evento, REMESSA.VALOR , recPBS "
c_Qry += " FROM ( "
c_Qry += "         select lpad(trim(Substr(trim(ba3_matemp) , 1, length(trim(ba3_matemp)) -1 )), 10, '0') matricula , PBS010.r_e_c_n_o_ recPBS,  PBS_numtit, PBS_CODEMP, PBS_MATRIC, PBS_TIPREG, PBS_coddes evento ,  sum(PBS_vlrdes) valor "
c_Qry += "         from  ba1010, ba3010, PBS010 "
c_Qry += "         where ba3_filial = ' '       "
c_Qry += "               and ba3_codint = '0001'"
c_Qry += "               and ba3_codemp in ('0001','0002','0005') "
c_Qry += "               and ba1_filial = ' '                     "
c_Qry += "               and ba1_codint = ba3_codint              "
c_Qry += "               and ba1_codemp = ba3_codemp              "
c_Qry += "               and ba1_matric = ba3_matric              "
c_Qry += "               and PBS_codrem = '" + c_CodRem + "'                 "
c_Qry += "               and ba1_codemp = PBS_codemp              "
c_Qry += "               and ba1_matric = PBS_matric              "
c_Qry += "               and ba1_tipreg = PBS_tipreg			  "
c_Qry += "               and ba1010.d_e_l_e_t_ = ' '              "
c_Qry += "               and ba3010.d_e_l_e_t_ = ' '              "
c_Qry += "               and PBS010.d_e_l_e_t_ = ' '              "
c_Qry += "         group by lpad(trim(Substr(trim(ba3_matemp), 1, length(trim(ba3_matemp)) -1 )), 10, '0'),PBS010.r_e_c_n_o_,  PBS_numtit, PBS_CODEMP, PBS_MATRIC, PBS_TIPREG, PBS_coddes ) remessa, "

c_Qry += "         ( select lpad(Substr(matricula, 2, 6),10,'0') matricula , Substr(evento, 3,3) evento, sum(valor) valor  "
c_Qry += "           from an_previ "
c_Qry += "           where anomes =  '" + c_AnoMes + "' "
c_Qry += "           group by lpad(Substr(matricula, 2, 6),10,'0'), Substr(evento, 3,3) ) retorno "

c_Qry += " where remessa.matricula =  retorno.matricula "
c_Qry += " and remessa.evento =  retorno.evento         "
c_Qry += " order by 1         "
*/
/*
c_Qry := " SELECT PBS_numtit, e1_valor,PBS_CODEMP, PBS_MATRIC, PBS_TIPREG,  RETORNO.evento, RETORNO.VALOR , remessa.valor, recPBS  "
c_Qry += "  FROM (  "
c_Qry += "           select lpad(trim(Substr(trim(ba3_matemp) , 1, length(trim(ba3_matemp)) -1 )), 10, '0') matricula , PBS010.r_e_c_n_o_ recPBS,  PBS_numtit, PBS_CODEMP, PBS_MATRIC, PBS_TIPREG, PBS_coddes evento ,  sum(PBS_vlrdes) valor  "
c_Qry += "           from  ba1010, ba3010, PBS010  "
c_Qry += "           where ba3_filial = ' ' "
c_Qry += "                 and ba3_codint = '0001' "
c_Qry += "                 and ba3_codemp in ('0001','0002','0005')  "
c_Qry += "                 and ba1_filial = '' ' "
c_Qry += "                 and ba1_codint = ba3_codint "
c_Qry += "                 and ba1_codemp = ba3_codemp "
c_Qry += "                 and ba1_matric = ba3_matric "
c_Qry += "                 and PBS_codrem = '" + c_CodRem + "'    "
c_Qry += "                 and ba1_codemp = PBS_codemp "
c_Qry += "                 and ba1_matric = PBS_matric "
c_Qry += "                 and ba1_tipreg = PBS_tipreg "
c_Qry += "                 and ba1010.d_e_l_e_t_ = ' ' "
c_Qry += "                 and ba3010.d_e_l_e_t_ = ' ' "
c_Qry += "                 and PBS010.d_e_l_e_t_ = ' ' "
c_Qry += "           group by lpad(trim(Substr(trim(ba3_matemp), 1, length(trim( )) -1 )), 10, '0'),PBS010.r_e_c_n_o_,  PBS_numtit, PBS_CODEMP, PBS_MATRIC, PBS_TIPREG, PBS_coddes ) remessa,  "

c_Qry += "           ( select lpad(Substr(matricula, 2, 6),10,'0') matricula , Substr(evento, 3,3) evento, sum(valor) valor  "
c_Qry += "             from an_previ  "
c_Qry += "             where anomes =  '" + c_AnoMes + "'  "
c_Qry += "             group by lpad(Substr(matricula, 2, 6),10,'0'), Substr(evento, 3,3) ) retorno  , se1010 e1   "

c_Qry += "   where remessa.matricula =  retorno.matricula  "
c_Qry += "   and remessa.evento =  retorno.evento   "
c_Qry += "   and e1.e1_filial = '01'        "
c_Qry += "   and e1.e1_prefixo = 'PLS'   "
c_Qry += "   and e1.e1_num = PBS_numtit   "

c_Qry += "   order by 1  "
*/


//c_Qry += "   select matricula, sum(valor) valor ""
c_Qry := "   select CGA, matricula, sum(valor) valor " // mbc1703
c_Qry += "   from  AN_PREVI "
c_Qry += "   where ANOMES = '" + c_AnoMes + "' "

//INCLUIDO PARA DEBUG
//c_Qry += "   AND MATRICULA IN ('00055178','00751248','00855379','00923987','00923987','01124023','01124023','01124023','04058418','04153326','04247813','04297248') "

//c_Qry += "   and matricula = '10343630' " // mbc1703
c_Qry += "   group by TEC, matricula           "     // mbc1703
c_Qry += "   order by 1, 2           "     // mbc1703

TcQuery c_Qry ALIAS "tmpqry" NEW
/*
DBCREATE('\system\N2LGRIO.dbf', aEstrutura)

dbUseArea(.T., NIL, '\system\N2LGRIO.dbf', "QRYNGL", .F.)

While !tmpqry->( EOF() )
	
	QRYNGL->(Reclock("QRYNGL",.T.))
	
	QRYNGL->PBS_numtit := tmpqry->PBS_numtit
	QRYNGL->PBS_CODEMP := tmpqry->PBS_CODEMP
	QRYNGL->PBS_MATRIC := tmpqry->PBS_MATRIC
	QRYNGL->PBS_TIPREG := tmpqry->PBS_TIPREG
	QRYNGL->EVENTO := tmpqry->PBS_CODEVE
	QRYNGL->VALOR := tmpqry->PBS_VLRDES
	QRYNGL->recPBS := tmpqry->R_E_C_N_O_
	
	QRYNGL->(MsUnlock())
	
	tmpqry->( dbSkip() )
	
EndDo

*/
//tmpqry->( dbCloseArea() )

//QRYNGL->( dbGoTop() )

Return

***************************************************************************************************************
***************************************************************************************************************

**'Marcela - Importa arquivo de baixa'**

User Function ImpBxPrevi(cAlias,nReg)
	
	Local cPerg	       		:= "COMPFAI"
	Local l_Erro			:= .F.
	
	Private cComboBx1
	Private cTitRotina 		:= "Imp. arq. baixa (Layout QW60)"
	Private lLayout    		:= .T.
	Private oDlg
	Private c_dirimp   		:= space(100)
	Private _nOpc	  		:= 0
	Private c_Separador 	:= ""
	Private a_Erro 		:= {}
	Private l_Importa := .F.
	
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE "Importação de arquivo de baixa (Layout QW60)" FROM 000,000 TO 175,320 PIXEL
	
	@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
	@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
	@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038
	
	*-----------------------------------------------------------------------------------------------------------------*
	*Buscar o arquivo no diretorio desejado.                                                                          *
	*Comando para selecionar um arquivo.                                                                              *
	*Parametro: GETF_LocalFLOPPY - Inclui o floppy drive Local.                                                       *
	*           GETF_LocalHARD   - Inclui o Harddisk Local.                                                           *
	*-----------------------------------------------------------------------------------------------------------------*
	
	@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
	@ 045,009 Say  "Delimitador"      Size 045,008 PIXEL OF oDlg
	
	//aCombo := {"Somente relatorio","Executar atualização"}
	//cCombo := space(1)
	
	//@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,10 PIXEL OF oDlg
	
	*-----------------------------------------------------------------------------------------------------------------*
	@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:End()
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If _nOpc == 1
		
		c_Separador := ';'
		
		c_QryTot :=  " select sum(valor) TOTAL ""
		c_QryTot +=  " from an_previ  "
		c_QryTot +=  " where anomes = '" + PBR->PBR_ANOREM + PBR->PBR_MESREM + "' and coddes = '01' "
		
		If Select("QRYIMPO") > 0
			dbSelectArea("QRYIMPO")
			dbclosearea()
		EndIf
		
		TcQuery c_QryTot ALIAS "QRYIMPO" NEW
		
		If QRYIMPO->TOTAL > 0
			
			If MsgYesNo("Arquivo já importado, total do período: R$" + Transform(QRYIMPO->TOTAL,"999,999,999.99") + ". Deseja reimportar ?")
				c_QrytTot :=  "  delete from an_previ  "
				c_QrytTot +=  "  where anomes = '" + PBR->PBR_ANOREM + PBR->PBR_MESREM + "'"
				
				TcSqlExec(c_QrytTot)
				
				l_Importa := .T.
			Else
				l_Importa := .F.
			EndIf
			
		Else
			If _nOpc == 1
				l_Importa := .T.
			EndIf
		EndIf
		
		If l_Importa
			
			Processa({|| l_Erro := COMPFAIA(PBR->PBR_ANOREM + PBR->PBR_MESREM)},"Importando de arquivo de baixa...", "", .T.)
			
			//Processa({|| aRet := GeraExport() }, cTitulo, "", .T.)
			
			If !l_Erro
				
				c_QryTot :=  " select sum(valor) TOTAL ""
				c_QryTot +=  "  from an_previ  "
				c_QryTot +=  "  where anomes = '" + PBR->PBR_ANOREM + PBR->PBR_MESREM + "'"
				
				If Select("QRYTOT") > 0
					dbSelectArea("QRYTOT")
					dbclosearea()
				EndIf
				
				TcQuery c_QryTot ALIAS "QRYTOT" NEW
				
				If 	QRYTOT->TOTAL > 0
					MsgAlert("Total importado R$" + AllTrim(Transform(QRYTOT->TOTAL,"@E 999,999,999.99")),AllTrim(SM0->M0_NOMECOM))
					/*
					If MsgYesNo("Total importado R$" + Transform(QRYTOT->TOTAL,"999,999,999.99")+". Deseja processar a baixa?")
						IMPRIOPR(cAlias,nReg,K_Incluir)
					EndIf
					*/
				Else
					MsgStop("Nenhum valor foi importado",AllTrim(SM0->M0_NOMECOM))
				EndIf
				
				QRYTOT->(DbCloseArea())
				
			EndIf
			
		EndIf
		
	EndIf
	
Return

***************************************************************************************************************

*------------------------------------------------------------------*
Static Function COMPFAIA(cAnoMes)
	*------------------------------------------------------------------*
	* função para importar o arquivo
	*------------------------------------------------------------------*
	
	Local c_Arq		:= c_dirimp
	Local n_Lin   	:= 0
	Local c_Qry    	:= ""
	Local n_QtdLin	:= 0
	Local l_Erro	:= .F.
	
	Private A_ERRO := {}
	
	If !Empty(c_Arq)
		
		FT_FUSE(c_Arq)
		FT_FGOTOP()
		
	Else
		Alert("Informe o arquivo a ser importado!")
		Return
	EndIf
	
	n_QtdLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform( n_QtdLin,'@E 999,999,999'))
	
	ProcRegua( n_QtdLin )
	
	n_QtdLin := 0
	
	aDados := {}
	
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
		
		c_Buffer   := FT_FREADLN()
		n_Loop     := 0
		
		cDesconto 	:= Substr(c_Buffer,206,2)
		
		//00 = "Sem retorno da folha"; 01 = "Descontado"; 02 = "Não descontado"; 03 = "Desconto parcial"; 04 = "Não enviado p/ desconto"
		//Situação do desconto tem que ser Descontado ou Desconto Parcial para baixa
		/*	If !( cDesconto $ '01|03' )
		FT_FSKIP()
		Loop
	EndIf
	*/
	a_TmpDados := {}
	aAdd (a_TmpDados , {"","","","","","",""} )
	
	If cDesconto = '01'
		cDescriDesc	:= 'NORMAL'
	ElseIf cDesconto = '02'
		cDescriDesc	:= 'PARCIAL'
	Else
		cDescriDesc	:= 'NAODESC'
	EndIf
	
	c_Script := "INSERT INTO AN_PREVI ( TIPO,MATRICULA,DIGITO,NOME,DESCONTO,EVENTO,VALOR,VALOR_PARCELA,CPF,TEC,ANOMES,BAIXADO,SEQUEN, CGA , CODDES ) VALUES ( "
	
	c_Script += "'" + Substr(c_Buffer,99,1) + "', "					//Tipo (Ativo ou Inativo)
	c_Script += "'" + Substr(c_Buffer,5,8) + "', "					//Matricula
	c_Script += "' ', "												//Digito (Nao utiliza mais)
	c_Script += "'" + Substr(c_Buffer,13,35) + "', "				//Nome
	c_Script += "'" + cDescriDesc + "', "							//Descricao do desconto
	c_Script += "'" + Substr(c_Buffer,49,04) + "', "				//Evento
	c_Script += cValToChar(Val(Substr(c_Buffer,69,11))/100) + ", "	//Valor descontado
	c_Script += cValToChar(Val(Substr(c_Buffer,58,11))/100) + ", "	//Valor da parcela
	c_Script += "'" + Substr(c_Buffer,80,11) + "', "				//CPF
	c_Script += "'" + Substr(c_Buffer,106,15) + "'," 				//TEC
	c_Script += "'" + cAnoMes + "', "
	c_Script += "'N', "
	c_Script += "'" + cValToChar(++n_Lin) + "', "
	c_Script += "'" + Substr(c_Buffer,130,16) + "', "
	c_Script += "'" + cDesconto + "') "
	
	If TcSqlExec(c_Script) < 0
		LogErros("Falha ao inserir o registro da linha " + cValToChar(n_QtdLin) + " na tabela AN_PREVI" + CRLF;
			+ "Script executado: " + c_Script + CRLF;
			+ "Erro: " + TcSQLError();
			,AllTrim(SM0->M0_NOMECOM),.T.)
		l_Erro	:= .T.
		Exit
	EndIf
	
	FT_FSKIP()
	
Enddo

FT_FUSE()

Return l_Erro

***************************************************************************************************************
***************************************************************************************************************

User Function F33ERROPRE()
	
	Local cPerg	       		:= "COMPFAI"
	
	Private cComboBx1
	Private cTitRotina 		:= "Importa erros Previ"
	Private lLayout    		:= .T.
	Private oDlg
	Private c_dirimp   		:= space(100)
	Private _nOpc	  		:= 0
	Private c_Separador 	:= ""
	Private a_Erro 			:= {}
	
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE "Importa erros Previ (Layout QW60)" FROM 000,000 TO 175,320 PIXEL
	
	@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
	@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
	@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038
	
	*-----------------------------------------------------------------------------------------------------------------*
	*Buscar o arquivo no diretorio desejado.                                                                          *
	*Comando para selecionar um arquivo.                                                                              *
	*Parametro: GETF_LocalFLOPPY - Inclui o floppy drive Local.                                                       *
	*           GETF_LocalHARD   - Inclui o Harddisk Local.                                                           *
	*-----------------------------------------------------------------------------------------------------------------*
	
	c_Separador := ';'
	
	@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
	@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg
	
	//aCombo := {"Somente relatorio","Executar atualização tabela AN_ERRO_PREVI"}
	//cCombo := space(1)
	
	//@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,90 PIXEL OF oDlg
	
	*-----------------------------------------------------------------------------------------------------------------*
	@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If _nOpc == 1
		Processa({||ERRCOMPFAIA()},"Importando arquivo de erros Previ...")
	EndIf
	
Return

***************************************************************************************************************

*------------------------------------------------------------------*
Static Function ERRCOMPFAIA()
	*------------------------------------------------------------------*
	* função para importar o arquivo
	*------------------------------------------------------------------*
	
	Local c_Arq		:= c_dirimp
	Local n_QtdLin	:= 0
	Local n_TotLin	:= 0
	Local nInserido	:= 0
	Local cDescrErr	:= ''
	Local c_Erro	:= ''
	Local c_AnoMes 	:= ''
	Local l_Erro	:= .F.
	
	Private A_ERRO 	:= {}
	
	If !Empty(c_Arq)
		
		ProcRegua(0)
		
		For n_TotLin := 1 to 5
			IncProc('Abrindo o arquivo...')
		Next
		
		FT_FUSE(c_Arq)
		FT_FGOTOP()
		
		c_AnoMes := PBR->( PBR_ANOREM + PBR_MESREM )
		c_Script := "DELETE FROM AN_ERRO_PREVI WHERE ANOMES = '" + c_AnoMes  + "' "
		
		If TcSqlExec(c_Script) < 0
			LogErros("Falha ao limpar anomes da tabela AN_ERRO_PREVI" + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)
			l_Erro	:= .T.
			Return
		EndIf
		
	Else
		MsgStop("Informe o Arquivo a ser importado!",AllTrim(SM0->M0_NOMECOM))
	EndIf
	
	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))
	
	ProcRegua( n_TotLin )
	
	aDados := {}
	
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
		
		c_Buffer   := FT_FREADLN()
		
		If n_QtdLin == 1 //Header
			FT_FSKIP()
			Loop
		ElseIf n_QtdLin == n_TotLin //Trailer
			FT_FSKIP()
			Loop
		EndIf
		
		//00 = "Sem retorno da folha"; 01 = "Descontado"; 02 = "Não descontado"; 03 = "Desconto parcial"; 04 = "Não enviado p/ desconto"
		c_Erro := Substr(c_Buffer,196,2)
		
		If ( c_Erro $ '01|03' )//Descontado ou Desconto Parcial
			FT_FSKIP()
			Loop
		EndIf
		
		cDescrErr := AllTrim(Substr(c_Buffer,198,25)) + ' - ' + AllTrim(Substr(c_Buffer,223,40))
		cDescrErr := Upper(cDescrErr)
		cDescrErr := StrTran(cDescrErr,'Ã','A')
		
		c_Script := "INSERT INTO AN_ERRO_PREVI (TIPO,MATRICULA,DIGITO,VALOR,COD_ERRO,ANOMES,TEC,DESCR_ERRO) VALUES ( "
		
		c_Script += "'" + Substr(c_Buffer,99,1) + "', " 				//Tipo (Ativo ou Inativo)
		c_Script += "'" + Substr(c_Buffer,5,8) + "', " 					//Matricula
		c_Script += "' '," 												//Digito (Nao utiliza mais)
		c_Script += cValToChar(Val(Substr(c_Buffer,58,11))/100) + ", " 	//Valor
		c_Script += "'" + Substr(c_Buffer,196,2) + "'," 				//COD_ERRO
		c_Script += "'" + c_AnoMes + "'," 								//ANOMES
		c_Script += "'" + Substr(c_Buffer,106,15) + "'," 				//TEC
		c_Script += "'" + Upper(cDescrErr) + "')" 						//Descricao do erro
		
		If TcSqlExec(c_Script) < 0
			LogErros("Falha ao inserir o registro da linha " + cValToChar(n_QtdLin) + " na tabela AN_ERRO_PREVI" + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)
			l_Erro	:= .T.
			Exit
		EndIf
		
		nInserido++
		
		FT_FSKIP()
		
	EndDo
	
	FT_FUSE()
	
	If !l_Erro
		MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " itens na tabela AN_ERRO_PREVI",AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return

***************************************************************************************************************

User Function TExAlte()
	
	Processa({||PTExAlte()},'Processando...')
	
Return

***************************************************************************************************************

Static Function PTExAlte
	
	Local cEOL		:= CHR(13)+CHR(10)
	Local cDirExp	:= GETNEWPAR("MV_YLGRIPR","\interface\exporta\RioPrevi\")
	Local cNomeArq  := cDirExp+"ALTERACOES_" + PBR->(PBR_PREREM+PBR_CODREM)+".TXT"
	Local c_Qry 	:= ""
	Local nI		:= 0
	Local nQtd		:= 0
	Local cQtd		:= 0
	
	For nI := 1 to 5
		IncProc('Processando...')
	Next
	
	Private nHdl
	
	U_MudVal(PBR->PBR_ANOREM, PBR->PBR_MESREM, PBR->PBR_CODREM)
	
	c_Qry+= " select  pbs_matemp, "
	c_Qry+= "         '90' orgao, "
	c_Qry+= "         (select cpf from an_previ where AN_PREVI.MATRICULA = pbs_matemp and rownum = 1) cpf, "
	
	//Leonardo Portella - 03/03/15 - Inicio - Olhar para a PREVI_MAX_X_TEC ao inves da temporaria. As matriculas
	//foram carregadas do QW60 na PREVI_MAX_X_TEC e depois o de/para nela foi feito baseado no de/para feito
	//pela planilha da que Marcela encaminhou para Esther e depois alterada por ela. posteriormente foi colocada
	//na tabela TEC_X_PROTHEUS.
	
	c_Qry+= "         pbs_codtec tec, "
	//c_Qry+= "         (select TEC from PREVI_MAX_X_TEC b where b.matemp = pbs_matemp and pbs_codemp = codemp and pbs_matric = matric and pbs_tipreg = tipreg ) tec, "
	//c_Qry+= "         (select TEC from TMP_PREVI_TEC b where b.matemp = pbs_matemp and pbs_codemp = codemp and pbs_matric = matric and pbs_tipreg = tipreg ) tec, "
	
	//Leonardo Portella - 03/03/15 - Fim
	
	c_Qry+= "         pbs_vlrdes valor "
	
	c_Qry+= " from " + RetSqlName("PBS") + " "
	c_Qry+= " where pbs_filial = ' '
	c_Qry+= " and pbs_codrem = '" + PBR->PBR_CODREM + "'
	c_Qry+= " and PBS_MUDVAL = 'S'
	//c_Qry+= " and PBS_matemp = '04237343'
	//	c_Qry+= " group by pbs_matemp,'90', 3, ' '
	
	TcQuery c_Qry ALIAS "QRYNB" NEW
	
	COUNT TO nQtd
	
	nI 		:= 0
	cQtd	:= AllTrim(Transform(nQtd,'@E 999,999,999'))
	
	QRYNB->(DbGoTop())
	
	If U_Cria_TXT(cNomeArq)
		
		While !QRYNB->( EOF() )
			
			IncProc('Processando ' + AllTrim(Transform(++nI,'@E 999,999,999')) + ' de ' + cQtd)
			
			//Leonardo Portella - 03/03/15 - Combinado com a Esther de nao enviar se nao tiver TEC. Nesses casos a
			//TEC sera cadastrada mais tarde no site da Previ.
			If !empty(QRYNB->tec)
				
				cLin := Space(1)+cEOL
				
				cCpo := QRYNB->( Alltrim(Str(Val(pbs_matemp))) + ';' + alltrim(orgao) + ';' + alltrim(cpf) + ';' + alltrim(tec) + ';' + alltrim(Transform( valor ,'@E 999999999.99'))) + ';'
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O REGISTRO DETALHE! OPERAÇÃO ABORTADA!")
					Return aRet
				EndIf
				
			EndIf
			
			QRYNB->( dbSkip() )
			
		EndDo
		
	Else
		
		Alert("Ops!!!")
		
	EndIf
	
	QRYNB->( dbCloseArea()  )
	
	U_Fecha_TXT()
	
	_copyfile(cNomeArq,cDirExp+"ALTERACOES_2" + PBR->(PBR_PREREM+PBR_CODREM)+".csv")
	
Return

***************************************************************************************************************

// Exibe não enviados
User Function NAOENVI()
	
	Local c_Qry := ""
	
	c_Qry += " select  ba1_codint||'-'||ba1_codemp||'-'||ba1_matric matricula,"
	c_Qry += "         ba1_nomusr nome,                                       "
	c_Qry += "         pbs_numtit titulo,                                      "
	c_Qry += "         decode( pbs_coderr, '3','Usuário com item menor que zero!', '5', 'Nenhuma baixa autorizada no titulo', '6', 'Problema na baixa', '9', 'Família Bloqueada'  ) Erro,"
	c_Qry += "         to_date(  trim( ba1_datblo ), 'YYYYMMDD' ) Data_Bloqueio, "
	c_Qry += "         sum(pbs_vlrdes) valor "
	
	c_Qry += "         from " + RetSqlName("PBS") + ", " + RetSqlName("BA1") + " "
	c_Qry += "         where PBS_CODREM = '" + PBR->PBR_CODREM + "' "
	c_Qry += "         and pbs_coderr <> '0' "
	c_Qry += "         and ba1_filial = '" + xFilial("BA1") + "' "
	c_Qry += "         and ba1_codemp = pbs_codemp "
	c_Qry += "         and ba1_matric = pbs_matric "
	c_Qry += "         and ba1_tipreg = pbs_tipreg "
	c_Qry += "         and PBS010.d_e_l_e_t_ = ' ' "
	c_Qry += "         and ba1010.d_e_l_e_t_ = ' ' "
	c_Qry += "         group by  ba1_codint||'-'||ba1_codemp||'-'||ba1_matric , "
	c_Qry += "                   ba1_nomusr , "
	c_Qry += "                   pbs_numtit , "
	c_Qry += "                   decode( pbs_coderr, '3','Usuário com item menor que zero!', '5', 'Nenhuma baixa autorizada no titulo', '6', 'Problema na baixa', '9', 'Família Bloqueada'  ) , "
	c_Qry += "                   to_date( trim( ba1_datblo ), 'YYYYMMDD' ) "
	c_Qry += "         order by 1 "
	
	If Select("QRYNB") > 0
		
		dbSelectArea("QRYNB")
		dbclosearea()
		
	EndIf
	
	TcQuery c_QryTot ALIAS "QRYNB" NEW
	
Return

***************************************************************************************************************

User Function MudVal(c_AnoRem, c_MesRem, c_Rem)
	
	Local c_Qry 	:= ""
	Local a_Area 	:= GetArea("PBS")
	
	If c_MesRem == "01"
		
		c_MesAnt := "12"
		c_AnoAnt := trim( str(val( c_AnoRem ) - 1 ))
		
	Else
		
		c_MesAnt := strzero(  val( c_MesRem ) - 1 , 2 )
		c_AnoAnt := c_AnoRem
		
	EndIf
	/*
	c_Qry += " select * "
	c_Qry += " from (select PBS_MATEMP AMATEMP, SUM(PBS_VLRDES) valor "
	c_Qry += "       from " + RetSqlName("PBS") + " PBS, " + RetSqlName("PBR") + " PBR "
	c_Qry += "       where pbs.d_e_l_e_t_ = ' ' "
	c_Qry += "       and pbr.d_e_l_e_t_ = ' '   "
	c_Qry += "       and pbr_anorem = '" + c_AnoAnt + "' "
	c_Qry += "       and pbr_mesrem = '" + c_MesAnt + "' "
	c_Qry += "       AND PBS_TIPMOV = 'M' "
	c_Qry += "       and pbr_codrem = pbs_codrem "
	c_Qry += "       GROUP BY PBS_MATEMP) antes, "
	
	c_Qry += "       ( select PBS_MATEMP DMATEMP, SUM(PBS_VLRDES) valor "
	c_Qry += "         from " + RetSqlName("PBS") + " pbs, " + RetSqlName("PBR") + " pbr "
	c_Qry += "         where pbs.d_e_l_e_t_ = ' '  "
	c_Qry += "         and pbr.d_e_l_e_t_ = ' '    "
	c_Qry += "         and pbr_codrem = '" + c_Rem + "' "
	//	c_Qry += "         and pbr_mesrem = '" + c_MesRem + "'
	c_Qry += "         AND PBS_TIPMOV = 'M' "
	c_Qry += "         and pbr_codrem = pbs_codrem  "
	c_Qry += "         GROUP BY PBS_MATEMP ) depois "
	c_Qry += "   where AMATEMP = dMATEMP  "
	c_Qry += "   and ANTES.valor <> depois.valor   "
	*/
	
	c_Qry += "     SELECT DEPOIS.*, SITE.ZRL_TEC"
	c_Qry += "  from            "
	c_Qry += "   ( select PBS_CODTEC, PBS_CODREM, PBS_CODEMP ,  PBS_MATRIC , PBS_TIPREG, PBS_MATEMP, SUM(PBS_VLRDES) valor  "
	c_Qry += "          from   PBS010 pbs,   PBR010 pbr  "
	c_Qry += "          where pbs.d_e_l_e_t_ = ' ' "
	c_Qry += "          and pbr.d_e_l_e_t_ = ' '  "
	c_Qry += "          and pbr_codrem = '"+c_Rem+"'  "
	c_Qry += "          AND PBS_TIPMOV = 'M'    "
	c_Qry += "          and pbr_codrem = pbs_codrem   "
	c_Qry += "          GROUP BY PBS_CODTEC, PBS_CODREM, PBS_CODEMP ,  PBS_MATRIC , PBS_TIPREG, PBS_MATEMP ) depois  ,  ba1010, ba3010, ZRL010 SITE "
	c_Qry += "   where PBS_CODTEC = SITE.ZRL_TEC
	c_Qry += "      and depois.valor <> SITE.ZRL_valor  "
	c_Qry += "      and ba1_codemp = pbs_codemp     "
	c_Qry += "      and ba1_matric = pbs_matric     "
	c_Qry += "      and ba1_tipreg = pbs_tipreg     "
	c_Qry += "      and ba1_codemp = ba3_codemp     "
	c_Qry += "      and ba1_matric = ba3_matric      "
	
	TcQuery c_Qry ALIAS "QRYAB" NEW
	
	While !QRYAB->( EOF() )
		
		dbSelectArea("PBS")
		dbSetOrder(2)
		If dbSeek(xFilial("PBS") + c_Rem + QRYAB->PBS_MATEMP )
			
			While !PBS->( EOF() ) .AND. PBS->( PBS_CODREM + PBS_MATEMP ) == c_Rem + QRYAB->PBS_MATEMP
				
				If PBS->( PBS_CODEMP + PBS_MATRIC + PBS_TIPREG  ) ==  QRYAB->(  PBS_CODEMP + PBS_MATRIC + PBS_TIPREG)
					
					If PBS_TIPMOV == 'M'
						
						PBS->(Reclock("PBS",.F.))
						
						PBS->PBS_MUDVAL := "S"
						
						PBS->(MsUnlock())
						
					EndIf
					
				EndIf
				
				PBS->( dbSkip() )
				
			EndDo
			
		EndIf
		
		
		QRYAB->( dbSkip() )
		
	EndDo
	
	RestArea( a_Area )
	
	QRYAB->(DBCLOSEAREA())
	
Return

***************************************************************************************************************

//Importa planilha com matriculas X TEC.
//Planilha deve ser baixada no site da Previ na opcao ACOMPANHAMENTO DE CONTRATO com data inicial em 01/01/2000

User Function ImpMatXTEC()
	
	Local l_Erro := .F.
	
	Private cTitRotina 		:= "Imp. Benef. (Plan. ACOMP. CONTRATO)"
	Private lLayout    		:= .T.
	Private oDlg
	Private c_dirimp   		:= space(100)
	Private _nOpc	  		:= 0
	Private c_Separador 	:= ""
	Private a_Erro 			:= {}
	Private l_Deleta 		:= .F.
	
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL
	
	@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
	@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg
	
	c_Separador := ';'
	
	@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
	@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg
	@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If _nOpc == 1
		Processa({||l_Erro := PImpMatXTEC()},"Importando beneficiários Previ...")
	EndIf
	
Return

***************************************************************************************************************

*------------------------------------------------------------------*
Static Function PImpMatXTEC()
	*------------------------------------------------------------------*
	
	Local c_Arq		:= c_dirimp
	Local n_QtdLin	:= 0
	Local n_TotLin	:= 0
	Local nInserido	:= 0
	Local aBuffer	:= {}
	Local l_Erro	:= .F.
	Local cMsg 		:= ''
	Local cBusca	:= ''
	Local cTEC		:= ''
	Local lHasFile	:= .T.
	Local cMatric	:= ''
	Local cNomePro	:= ''
	
	DbSelectArea('ZRL')
	
	If !Empty(c_Arq)
		
		ProcRegua(0)
		
		For n_TotLin := 1 to 5
			IncProc('Abrindo o arquivo...')
		Next
		
		FT_FUSE(c_Arq)
		FT_FGOTOP()
		
	Else
		
		cMsg := "Arquivo a ser importado não localizado!" + CRLF
		MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
		lHasFile	:= .F.
		
	EndIf
	
	If !l_Erro .and. lHasFile
		
		If !MsgYesNo('Esta rotina irá deletar TODOS os registros da tabela ZRL para importá-los novamente conforme o arquivo.' + CRLF + 'Confirma?',AllTrim(SM0->M0_NOMECOM))
			MsgStop('Abortado pelo operador',AllTrim(SM0->M0_NOMECOM))
			l_Erro := .T.
			Return l_Erro
		EndIf
		
		c_Script := "DECLARE MAX_ATU VARCHAR2(8);" 			+ 	CRLF
		c_Script += 											CRLF
		c_Script += "BEGIN" 								+ 	CRLF
		c_Script += 											CRLF
		c_Script += "  SELECT MAX(ZRL_ULATUA)" 				+ 	CRLF
		c_Script += "  INTO MAX_ATU" 						+ 	CRLF
		c_Script += "  FROM " + RetSqlName('ZRL') 			+ 	CRLF
		c_Script += "  WHERE D_E_L_E_T_ = ' ';" 			+ 	CRLF
		c_Script += 											CRLF
		c_Script += "  DELETE FROM " + RetSqlName('ZRL') 	+ 	CRLF
		c_Script += "  WHERE ZRL_ULATUA <> MAX_ATU"			+ 	CRLF
		c_Script += "    OR D_E_L_E_T_ = '*';"				+ 	CRLF
		c_Script += 											CRLF
		c_Script += "  UPDATE " + RetSqlName('ZRL') 		+ 	CRLF
		c_Script += "  SET D_E_L_E_T_ = '*'"				+ 	CRLF
		c_Script += "  WHERE ZRL_ULATUA = MAX_ATU;"			+ 	CRLF
		c_Script += 											CRLF
		c_Script += "END;" 									+ 	CRLF
		
		If TcSqlExec(c_Script) < 0
			LogErros("Falha ao limpar os registros na tabela " + RetSqlName('ZRL') + CRLF;
				+ "Script executado: " + CRLF + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)
			l_Erro := .T.
			Return l_Erro
		EndIf
		
		n_TotLin := FT_FLASTREC()
		c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))
		
		ProcRegua(n_TotLin)
		
		While !FT_FEOF()
			
			IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
			
			c_Buffer   := FT_FREADLN()
			
			aBuffer := Separa(c_Buffer,';',.T.)
			
			If n_QtdLin == 1 .or. empty(aBuffer)//Header
				FT_FSKIP()
				Loop
			EndIf
			
			cTEC		:= aBuffer[1]
			cMatric		:= aBuffer[2]
			cMatEmp		:= StrZero(Val(aBuffer[4]),8)
			
			cMatric := iif(substr(cMatric, 1, 4)== '0001', cMatric, '000' + trim(cMatric) )
			
			BA1->(DbSetOrder(2))
			If !empty(cMatric) .and. BA1->(DbSeek(xFilial('BA1') + cMatric))
				cMatric		:= cMatric + BA1->BA1_DIGITO
				cNomePro	:= BA1->BA1_NOMUSR
			Else
				
				cNomePro	:= 'MATRICULA NAO LOCALIZADA BA1'
				
			EndIf
			
			If Val(Replace(aBuffer[11],',','.')) <> 0
				
				ZRL->(Reclock('ZRL',.T.))
				
				ZRL->ZRL_MATEMP := cMatEmp
				ZRL->ZRL_MATRIC := cMatric
				ZRL->ZRL_NOMPRE	:= Left(AllTrim(Upper(aBuffer[5])),TamSX3('ZRL_NOMPRE')[1])
				ZRL->ZRL_NOMPRO	:= cNomePro
				ZRL->ZRL_TEC	:= cTEC
				ZRL->ZRL_VALOR	:= Val(Replace(aBuffer[11],',','.'))
				ZRL->ZRL_SITUAC := aBuffer[12]
				ZRL->ZRL_ULATUA := Date()
				
				ZRL->(MsUnlock())
				
			EndIf
			
			nInserido++
			
			FT_FSKIP()
			
		EndDo
		
		FT_FUSE()
		
	EndIf
	
	If !l_Erro .and. lHasFile
		MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('ZRL'),AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return l_Erro

***************************************************************************************************************

User Function BenefPRE
	
	Local cVldAlt := ".T." // Validacao para permitir a alteracao.
	Local cVldExc := ".T." // Validacao para permitir a exclusao.
	
	DbSelectArea("ZRL")
	DbSetOrder(1)
	
	AxCadastro('ZRL','Cadastro Beneficiarios PREVI',cVldExc,cVldAlt)
	
Return

***************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Jean Schulz          º Data ³ 26/10/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria / ajusta as perguntas da rotina                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AjustaSX1(cPerg)
	
	//	PutSx1(cPerg,"01",OemToAnsi("Arquivo a importar:"),"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	//  PutSx1(cPerg,"02",OemToAnsi("Movimento Bancário:"),"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Total","","","","Unitário","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"01",OemToAnsi("Data Baixa"),"","","mv_ch1","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	
Return

User Function BaixaTMP()
	/*
	c_Qry := " SELECT DISTINCT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_PARCELA, VALOR "
	c_Qry += " FROM                                                                       "
	c_Qry += " (                                                                          "
	c_Qry += "   select DISTINCT BA3_CODCLI, VALOR                                        "
	c_Qry += "   from (                                                                   "
	c_Qry += "         Select A1.MATRICULA, sum(valor) VALOR                              "
	c_Qry += "         from                                                               "
	c_Qry += "               (                                                            "
	c_Qry += "               SELECT MATRICULA MATRICULA                                   "
	c_Qry += "               FROM AN_PREVI                                                "
	c_Qry += "               WHERE ANOMES = '201503'                                      "
	c_Qry += "               GROUP BY MATRICULA                                           "
	c_Qry += "               MINUS                                                        "
	c_Qry += "               SELECT MATEMP MATRICULA                                      "
	c_Qry += "               FROM AN_PREVIA_BAIXA_PREVI                                   "
	c_Qry += "               GROUP BY MATEMP                                              "
	c_Qry += "               ) a1, AN_PREVI a2                                            "
	c_Qry += "         WHERE ANOMES = '201503'                                            "
	c_Qry += "         and a1.MATRICULA = a2.MATRICULA                                    "
	c_Qry += "         and not exists(select * from pbs010 where pbs_codrem = '00041' and pbs_matemp = a2.matricula and d_e_l_e_t_ = ' ') "
	c_Qry += "         group by A1.MATRICULA) M, BA1010, BA3010                                                                           "
	c_Qry += "       where trim(BA3_MATEMP) = M.MATRICULA                                                                                 "
	c_Qry += "             AND BA1_CODINT = BA3_CODINT                                                                                    "
	c_Qry += "             AND BA1_CODEMP = BA3_CODEMP                                                                                    "
	c_Qry += "             AND BA1_MATRIC = BA3_MATRIC                                                                                    "
	c_Qry += "             AND BA1010.D_E_L_E_T_ = ' '                                                                                    "
	c_Qry += "             AND BA3010.D_E_L_E_T_ = ' '                                                                                    "
	c_Qry += "             AND (BA1_DATBLO = ' ' OR BA1_DATBLO >= '20150301' )                                                            "
	c_Qry += "       ) B, SE1010                                                                                                          "
	c_Qry += "       WHERE E1_FILIAL = '01'                                                                                               "
	c_Qry += "       AND E1_EMISSAO >= '20150130'                                                                                         "
	c_Qry += "       AND E1_TIPO = 'DP'                                                                                                   "
	c_Qry += "       AND E1_PREFIXO = 'PLS'                                                                                               "
	c_Qry += "       AND E1_CLIENTE = BA3_CODCLI                                                                                          "
	c_Qry += "       AND E1_ANOBASE = '2015'                                                                                              "
	c_Qry += "       AND E1_MESBASE = '03'                                                                                                "
	c_Qry += "       AND exists (select * from se5010 where e5_filial = '01'  and e5_data = '20150413' and e5_lote = '00008874' and e5_numero = e1_num )  "
	*/
	
	
	c_Qry := "               Select distinct A1.MATRICULA, sum(valor) VALOR "
	c_Qry += "               from  "
	c_Qry += "                     (  "
	c_Qry += "                     SELECT MATRICULA MATRICULA "
	
	c_Qry += "                     FROM AN_PREVI  "
	c_Qry += "                     WHERE ANOMES = '201503'  "
	c_Qry += "                     GROUP BY MATRICULA  "
	
	c_Qry += "                     MINUS "
	
	c_Qry += "                     SELECT MATEMP MATRICULA "
	
	c_Qry += "                     FROM AN_PREVIA_BAIXA_PREVI "
	c_Qry += "                     GROUP BY MATEMP "
	c_Qry += "                     ) a1, AN_PREVI a2  "
	c_Qry += "               WHERE ANOMES = '201503' "
	c_Qry += "               and a1.MATRICULA = a2.MATRICULA "
	c_Qry += "               and not exists(select * from pbs010 where pbs_codrem = '00041' and pbs_matemp = a2.matricula and d_e_l_e_t_ = ' ') "
	c_Qry += "               group by A1.MATRICULA  "
	
	
	TcQuery c_Qry ALIAS "TMPBXTM" NEW
	
	dDataBase:= ctod("02/03/2015")
	
	While !TMPBXTM->( EOF() )
		
		c_Qry := "		select E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, sum(valor) valor "
		c_Qry += "		from ba3010 inner join ba1010 on ba1_filial = ' ' and ba1_codemp = ba3_codemp and ba1_matric = ba3_matric "
		c_Qry += "		            inner join se1010 on e1_filial = '01' and E1_CLIENTE = BA3_CODCLI AND BA1_CODEMP = E1_CODEMP AND BA1_MATRIC = E1_MATRIC "
		c_Qry += "		            INNER JOIN AN_PREVI ON MATRICULA = TRIM(BA3_MATEMP) AND SUBSTR(TEC, 3, 13) = TRIM(BA1_XTEC)       "
		//c_Qry += "
		c_Qry += "		where trim(ba3_matemp) = '" + TMPBXTM->MATRICULA + "' "
		c_Qry += "		      AND E1_ANOBASE = '2015' "
		c_Qry += "		      AND E1_MESBASE = '03'   "
		//	c_Qry += "		      and e1_saldo <> 0       "
		c_Qry += "		group by E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO     "
		c_Qry += "		order by 1                                          "
		
		TcQuery c_Qry ALIAS "TMPBTIT" NEW
		
		While !TMPBTIT->( EOF() )
			
			BaixaTitulo( "NOR",TMPBTIT->E1_PREFIXO, TMPBTIT->E1_NUM ,TMPBTIT->E1_PARCELA,TMPBTIT->E1_TIPO,dDataBase,"BX. AUTOM. RIO PREV",TMPBTIT->VALOR )
			
			TMPBTIT->( dbSkip() )
			
		EndDo
		
		TMPBTIT->( dbCloseArea() )
		
		TMPBXTM->( dbSkip() )
		
	EndDo
	
Return

uSER fUNCTION tMPBXPR()
	
	C:= 2
	
	/*
	c_Qry := " SELECT E5_PREFIXO, E5_NUMERO, E5_PARCELA,E5_TIPO,E5_VALOR VALOR "
	c_Qry += " FROM SE5010 e51 "
	c_Qry += " WHERE E5_FILIAL = '01'"
	c_Qry += " AND E5_DATA = '20150302'    "
	c_Qry += " AND E5_HISTOR = 'BX. AUTOM. RIO PREV' "
	c_Qry += " and d_e_l_e_t_ = ' '   "
	
	c_Qry += " group by E5_PREFIXO, E5_NUMERO, E5_PARCELA,E5_TIPO,E5_VALOR "
	
	TcQuery c_Qry ALIAS "TMPBTIT" NEW
	
	While !TMPBTIT->( EOF() )
		
		BaixaTitulo( "NOR",TMPBTIT->E5_PREFIXO, TMPBTIT->E5_NUMERO ,TMPBTIT->E5_PARCELA,TMPBTIT->E5_TIPO,dDataBase,"BX. AUTOM. RIO PREV",TMPBTIT->VALOR )
		
		TMPBTIT->( dbSkip() )
		
	EndDo
	
	TMPBTIT->( dbCloseArea() )
	
	*/
	
	
rETURN

/*
------------------------------
SCRIPT ANÁLISE PRÉVIA DA BAIXA
------------------------------
BEGIN
	ANALISE_BAIXA_PREVI('00041');
		END;
		------------------------------
	
	-------------------------------------
	CRIAÇÃO DE SEQUENCE, TABELA E ÍNDICES
	-------------------------------------
	
	CREATE SEQUENCE ID_PREVIA_BAIXA_PREVI
	START WITH     1
	INCREMENT BY   1;
		
	CREATE TABLE AN_PREVIA_BAIXA_PREVI
	(	ID NUMBER,
	DATA_PREVIA DATE,
	ANO_MES VARCHAR2(6),
	MATEMP VARCHAR2(8),
	PRETIT VARCHAR2(3),
	NUMTIT VARCHAR2(9),
	PARTIT VARCHAR2(1),
	TIPTIT VARCHAR2(3),
	VALOR_SE1 NUMBER,
	SALDO_SE1 NUMBER,
	VLR_BX_PREVIA NUMBER,
	VLR_DEBITO_USR NUMBER,
	VLR_INF_PREVI_FAM NUMBER,
	VLR_TOT_DETALHE NUMBER,
	VLR_AVERBADO_FAM NUMBER,
	VLR_DETALHE_M NUMBER,
	VLR_DETALHE_D NUMBER,
	OBS VARCHAR2(150)
	);
		
	CREATE INDEX ID_PREVIA ON AN_PREVIA_BAIXA_PREVI (ID);
		CREATE INDEX MATEMP_PREVIA ON AN_PREVIA_BAIXA_PREVI (MATEMP);
		CREATE INDEX TIT_PREVIA ON AN_PREVIA_BAIXA_PREVI (PRETIT,NUMTIT,PARTIT,TIPTIT);
		*/
	
User Function BAIXA2015( c_Opc )
	
	Local cPerg	       		:= "COMPFAI"
	
	AjustaSX1(cPerg)
	
	If !Pergunte(cPerg,.T.)
		Return
	End
	
	Pergunte(cPerg,.F.)
	
	dDataAnt := dDataBase
	dDataBase := mv_par01//stod(alltrim(str(mv_par01)   ))
	
	
	If c_Opc == '1'
		
		Processa({|| l_Erro := BX2015( c_Opc )},"Gerando " + iif(c_Opc == '1', "relatório de baixa", "baixa" ) + ". ", "", .T.)
		
	ElseIf MsgYesNo('A rotina irá realizar a BAIXA! Confirma?',AllTrim(SM0->M0_NOMECOM))
		
		Processa({|| l_Erro := BX2015( c_Opc )},"Gerando " + iif(c_Opc == '2', " baixa", "baixa" ) + ". ", "", .T.)
		
	EndIf
	
	dDataBase := dDataAnt
	
	
Return

Static Function BX2015(c_Opc)
	
	Local c_Qry 	:= ""
	Local a_Igual 	:= {}
	Local aEstrutura:= {;
		{'PBS_numtit','C', 9,0}, ;
		{'PBS_CODEMP','C', 4,0}, ;
		{'PBS_MATRIC','C', 6,0}, ;
		{'PBS_TIPREG','C', 2,0}, ;
		{'EVENTO'    ,'C', 3,0}, ;
		{'TIPO'      ,'C', 1,0}, ;
		{'VALOR'     ,'N',10,2}, ;// Cria a tabela com a RDD cormarcela.coirente
	{'recPBS'    ,'N',10,0}  }// Cria a tabela com a RDD corrente
	
	Local n_TotBx 	:= 0
	Local c_Lote 	:= ""
	Local c_MatTMP  := ""
	
	DBCREATE('\system\N2LGRIO.dbf', aEstrutura)
	dbUseArea(.T., NIL, '\system\N2LGRIO.dbf', "QRYNGL", .F.)
	
	
	c_Qry := " select max(E5_LOTE)  LOTE  "
	c_Qry += " from se5010            "
	c_Qry += " where e5_filial = '01' "
	c_Qry += " and E5_RECPAG = 'R'    "
	c_Qry += " and LENGTH(TRIM(E5_LOTE)) = 8 "
	c_Qry += " and d_e_l_e_t_ = ' ' "
	
	TcQuery c_Qry ALIAS "TMPLOTE" NEW
	
	While !tmplote->( EOF() )
		
		c_Lote := soma1( tmplote->LOTE )
		
		tmplote->( dbSkip() )
		
	EndDo
	
	//	alert(c_Opc)
	
	tmplote->( dbCloseArea() )
	/*
	dbSelectArea("PBR")
	dbSetOrder(1)
	DBsEEK(xFilial("PBR") + "REM" + PBR->PBR_CODREM)
	*/
	c_Qry := " SELECT MATRICULA, SUM(VALOR) VALOR , SUM(VALOR_PARCELA) VALOR_PARCELA FROM AN_PREVI WHERE ANOMES = '" + PBR->(PBR_ANOREM + PBR_MESREM) + "' AND coddes = '01' GROUP BY MATRICULA "
	// 	c_Qry := " SELECT MATRICULA, SUM(VALOR) VALOR FROM AN_PREVI WHERE ANOMES = '" + PBR->(PBR_ANOREM + PBR_MESREM) + "' AND MATRICULA = '04063178' AND coddes = '01' GROUP BY MATRICULA "
	
	TcQuery c_Qry ALIAS "TMPBTIT" NEW
	
	While !TMPBTIT->( EOF() )
		
		
		c_Matric := TMPBTIT->MATRICULA
		n_Recebi := TMPBTIT->VALOR
		
		c_Qry := " SELECT SUM(PBS_VLRDES) VALOR "
		c_Qry += " FROM PBS010 "
		c_Qry += " WHERE PBS_CODREM = '" + PBR->PBR_CODREM + "' "
		c_Qry += " AND PBS_MATEMP = '" + c_Matric +"' "
		
		//	c_Qry := " AND PBS_CODINT||PBS_CODEMP||PBS_MATRIC||PBS_TIPREG = '" + TMPBTIT->CGA + "' "
		
		TcQuery c_Qry ALIAS "TMPPBS" NEW
		
		n_Enviado := TMPPBS->VALOR
		
		TMPPBS->( dbCloseArea() )
		
		If .T.//n_Recebi == n_Enviado
			
			c_Qry := " SELECT PBS_NUMTIT, PBS_CODEMP, PBS_MATRIC, SUM(PBS_VLRDES) VALOR "
			
			c_Qry += " FROM PBS010 "
			c_Qry += " WHERE PBS_CODREM = '" + PBR->PBR_CODREM + "' "
			c_Qry += " AND PBS_MATEMP = '" + c_Matric +"' "
			c_Qry += " AND D_E_L_E_T_ = ' ' "
			
			c_Qry += " GROUP BY PBS_NUMTIT, PBS_CODEMP, PBS_MATRIC "
			
			//	c_Qry := " AND PBS_CODINT||PBS_CODEMP||PBS_MATRIC||PBS_TIPREG = '" + TMPBTIT->CGA + "' "
			
			TcQuery c_Qry ALIAS "TMPDPBS" NEW
			
			While !TMPDPBS->( EOF() )
				
				
				IF n_Recebi >= n_Enviado
					
					
					QRYNGL->(Reclock("QRYNGL",.T.))
					
					
					QRYNGL->PBS_numtit 	:= TMPDPBS->PBS_numtit
					QRYNGL->PBS_CODEMP 	:= TMPDPBS->PBS_CODEMP
					QRYNGL->PBS_MATRIC 	:= TMPDPBS->PBS_MATRIC
					QRYNGL->VALOR 		:= TMPDPBS->VALOR
					QRYNGL->TIPO 		:= IIF(n_Recebi == n_Enviado, "I", IIF( n_Recebi > n_Enviado , "A", "B" ))
					
					
					QRYNGL->(MsUnlock())
					
					AADD(a_Igual, {"'" + c_Matric, "'0001" + TMPDPBS->PBS_CODEMP + TMPDPBS->PBS_MATRIC, "PLS", "'" + TMPDPBS->PBS_numtit, TMPDPBS->VALOR, "Baixa Ok" })//IIF(n_Recebi == n_Enviado, "I", IIF( n_Recebi > n_Enviado , "A", "B" ))
					
					If c_Opc == '2'
						
						BaixaTitulo( "NOR","PLS", TMPDPBS->PBS_numtit ,' ','DP',dDataBase,"BX. AUTOM. RIO PREV",TMPDPBS->VALOR, @n_TotBx , c_Lote)
						
					EndIf
					
				Else
					
					If c_Matric <> c_MatTMP
						
						c_MatTMP := c_Matric
						
						c_Qry := " SELECT distinct pbs_codint||pbs_codemp||pbs_matric||pbs_tipreg, pbs_numtit, valor "
						c_Qry += " 						FROM AN_PREVI, pbs010  "
						c_Qry += " 						WHERE ANOMES = '" + PBR->(PBR_ANOREM + PBR_MESREM) + "' "
						c_Qry += " 						AND matricula = '" + c_Matric + "' "
						c_Qry += " 						and pbs_codrem = '" + PBR->PBR_CODREM + "' "
						c_Qry += " 						and cga = pbs_codint || pbs_codemp || pbs_matric || pbs_tipreg "
						c_Qry += " 						and coddes = '01' "
						c_Qry += " 						and d_e_l_e_t_ = ' '"
						
						c_Qry += " 						union  "
						
						c_Qry += " 						SELECT distinct pbs_codint||pbs_codemp||pbs_matric||pbs_tipreg, pbs_numtit, valor "
						c_Qry += " 						FROM AN_PREVI, pbs010 "
						c_Qry += " 						WHERE ANOMES = '" + PBR->(PBR_ANOREM + PBR_MESREM) + "' "
						c_Qry += " 						AND matricula = '" + c_Matric + "' "
						c_Qry += " 						and pbs_codrem = '" + PBR->PBR_CODREM + "' "
						c_Qry += " 						and cga = '0000000000000000' "
						c_Qry += " 						and pbs_vlrdes = valor   "
						c_Qry += " 						and coddes = '01'   "
						c_Qry += " 						and pbs_matemp = matricula   "
						c_Qry += " 						and d_e_l_e_t_ = ' ' "
						
						TcQuery c_Qry ALIAS "TMPPARC" NEW
						
						If !TMPPARC->( EOF() )
							
							While !TMPPARC->( EOF() )
								
								AADD(a_Igual, {"'" + c_Matric, "'0001" + TMPDPBS->PBS_CODEMP + TMPDPBS->PBS_MATRIC, "PLS", "'" + TMPPARC->PBS_numtit,  TMPPARC->VALOR, "Baixado Parcial" })//IIF(n_Recebi == n_Enviado, "I", IIF( n_Recebi > n_Enviado , "A", "B" ))
								
								If c_Opc == '2'
									
									BaixaTitulo( "NOR","PLS", TMPPARC->PBS_numtit ,' ','DP',dDataBase,"BX. AUTOM. RIO PREV",TMPPARC->VALOR, @n_TotBx , c_Lote)
									//	BaixaTitulo( "NOR","PLS", TMPPARC->PBS_numtit ,' ','DP',dDataBase,"BX. AUTOM. RIO PREV",TMPDPBS->VALOR, @n_TotBx , c_Lote)
									
								EndIf
								
								
								TMPPARC->( dbSkip() )
								
							EndDo
							
						Else
							
							AADD(a_Igual, {"'" + c_Matric, "'0001" + TMPDPBS->PBS_CODEMP + TMPDPBS->PBS_MATRIC, "PLS", "'" + TMPDPBS->PBS_numtit,  TMPDPBS->VALOR, "Não Baixado" })//IIF(n_Recebi == n_Enviado, "I", IIF( n_Recebi > n_Enviado , "A", "B" ))
							
							
						EndIf
						
						TMPPARC->( dbCloseArea() )
						
					Else
						
						AADD(a_Igual, {"'" + c_Matric, "'0001" + TMPDPBS->PBS_CODEMP + TMPDPBS->PBS_MATRIC, "PLS", "'" + TMPDPBS->PBS_numtit, TMPDPBS->VALOR, "Não Baixado" })//IIF(n_Recebi == n_Enviado, "I", IIF( n_Recebi > n_Enviado , "A", "B" ))
						
						
						
					EndIf
					Exit
				EndIf
				
				TMPDPBS->( dbSkip() )
				
			EndDo
			
			TMPDPBS->( dbCloseArea() )
			
		EndIf
		
		TMPBTIT->( dbSkip() )
		
	EndDo
	a_Cabec := {"Matricula Previ", "Matricula Caberj", "Prefixo", "Título", "Valor enviado" , "Status" }
	
	
	DlgToExcel({{"ARRAY","Gravações da Filial" ,a_Cabec,a_Igual}})
	
	If c_Opc == '2'
		
		Reclock( "SE5" , .T. )
		SE5->E5_FILIAL	:= xFilial()
		SE5->E5_BANCO	:= "341"
		SE5->E5_AGENCIA	:= "6015 "
		SE5->E5_CONTA	:= "017251"
		SE5->E5_VALOR	:= n_TotBx
		SE5->E5_RECPAG	:= "R"
		SE5->E5_HISTOR	:= "BX. AUTOM. RIO PREV. " + "00008881"
		SE5->E5_DTDIGIT	:= dDataBase
		SE5->E5_DATA	:= dDataBase
		SE5->E5_NATUREZ	:= "BX.RIOPR"
		SE5->E5_LOTE	:= c_Lote
		SE5->E5_TIPODOC := "BL"
		SE5->E5_DTDISPO	:= dDataBase
		
		MsUnlock()
		
	EndIf
	
Return


User Function NaoBxPrev()
	
	Local c_Qry := ''
	/*
	c_Qry += SELECT DISTINCT E1_NUM, E1_VALOR, E1_SALDO
	FROM PBS010 INNER JOIN SE1010
	ON E1_FILIAL = '01'
	AND E1_PREFIXO = 'PLS'
	AND E1_NUM = PBS_NUMTIT
	WHERE PBS_FILIAL = ' '
	AND PBS_CODREM = '00056'
	AND E1_SALDO > 0
	--AND E1_VALOR <> E1_SALDO
	AND PBS010.D_E_L_E_T_ = ' '
	
	
	*/
	
Return


User Function TMPEXCLUI()
	
	Local c_Qry := ""
	
	c_Qry += " SELECT e5_prefixo, e5_numero, e5_parcela, e5_tipo, e5_valor "
	c_Qry += " FROM SE5010 "
	c_Qry += " WHERE E5_FILIAL = '01' "
	c_Qry += " AND E5_DATA = '20150625' "
	c_Qry += " AND E5_LOTE = '00008884' "
	c_Qry += " AND E5_NATUREZ = '30'  "
	c_Qry += " AND E5_NUMERO >= '002410400' "    //9
	//c_Qry += " AND E5_NUMERO >= '002414000' "    //9
	//c_Qry += " AND E5_NUMERO >= '002414785' "  //5
	//c_Qry += " AND E5_NUMERO not in ('002409276' , '002409273', '002409274', '002409277', '002409276' ) "
	
	TcQuery c_Qry ALIAS "TMPEX" NEW
	
	wHILE !TMPEX->( EOF() )
		
		BaixaTitulo( "NOR","PLS", TMPEX->e5_numero ,' ','DP',dDataBase,"BX. AUTOM. RIO PREV",TMPEX->e5_valor,  , '00008884')
		TMPEX->( DBsKIP ()  )
		
	EndDo
	
	TMPEX->( dbCloseArea() )
	
	
Return


User Function GerRelPre()
	
	Processa({|| l_Erro := u_pGerRelPre(  )},"Gerando ... ", "", .T.)
	
Return


User Function pGerRelPre()
	
	Local aDados := {}
	
	c_Qry := "	SELECT * "
	c_Qry += " FROM (    "
	c_Qry += "       select matric, nome, matric_previ, grupo_de_cobranca, dt_bloqueio, (CASE WHEN  NVL(VALORBDK, 0 ) <> 0 THEN VALORBDK ELSE VALORBBU END) VALOR_DE_TABELA, "
	c_Qry += "       (SELECT zrl_VALOR FROM " + RETSQLNAME("ZRL") + " WHERE SUBSTR(zrl_MATRIC, 1, 16) = MATRIC AND D_E_L_E_T_ = ' ' AND zrl_MATRIC <> ' ' AND ROWNUM = 1) VALOR_SITE,           "
	c_Qry += "       (SELECT zrl_TEC FROM " + RETSQLNAME("ZRL") + " WHERE SUBSTR(zrl_MATRIC, 1, 16) = MATRIC AND D_E_L_E_T_ = ' ' AND zrl_MATRIC <> ' ' AND ROWNUM = 1) TEC                     "
	
	c_Qry += "       from ( select matric,  "
	c_Qry += "               ba1_nomusr nome, "
	c_Qry += "               ba3_matemp matric_previ, "
	c_Qry += "               ba3_grpcob grupo_de_cobranca, "
	c_Qry += "               to_date(trim(ba1_datblo), 'YYYYMMDD') dt_bloqueio, "
	c_Qry += "               ( SELECT BDK_VALOR                                 "
	c_Qry += "                                                     FROM " + RETSQLNAME("BDK") + " "
	c_Qry += "                                                     WHERE BDK_FILIAL = ' ' "
	c_Qry += "                                                       AND BDK_CODINT = BA1_CODINT "
	c_Qry += "                                                       AND BDK_CODEMP = BA1_CODEMP "
	c_Qry += "                                                       AND BDK_MATRIC = BA1_MATRIC "
	c_Qry += "                                                       AND BDK_TIPREG = BA1_TIPREG "
	c_Qry += "                                                       and d_e_l_e_t_ = ' '        "
	
	c_Qry += "                                                      AND ( ( BA1_MUDFAI = 0 and BA1_faicob = BDK_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BDK_IDAINI AND IDADE_S(BA1_DATNAS) <= BDK_IDAFIN  )) "
	
	c_Qry += "                                                       AND ROWNUM = 1) VALORBDK ,"
	c_Qry += "                                                            ( SELECT BBU_VALFAI  "
	c_Qry += "                     FROM " + RETSQLNAME("BBU") + " "
	c_Qry += "                     WHERE BBU_FILIAL = ' ' "
	c_Qry += "                       AND BBU_CODOPE = BA1_CODINT                                        "
	c_Qry += "                       AND BBU_CODEMP = BA1_CODEMP                                        "
	c_Qry += "                       AND BBU_MATRIC = BA1_MATRIC                                        "
	
	c_Qry += "                       AND D_E_L_E_T_ = ' '                                        "
	c_Qry += "                       AND ( ( BA1_MUDFAI = 0 and BA1_FAICOB = BBU_CODFAI) or (BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BBU_IDAINI AND IDADE_S(BA1_DATNAS)  <= BBU_IDAFIN  ))                                       "
	c_Qry += "                       AND ROWNUM = 1 ) VALORBBU    "
	c_Qry += "       from  "
	c_Qry += "       (
	
	c_Qry += "         select ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg matric "
	c_Qry += "         from " + RETSQLNAME("BA3") + ", " + RETSQLNAME("BA1") + " , " + RETSQLNAME("ZRL") + " "
	c_Qry += "         where ba3_filial = ' '                      "
	c_Qry += "         and ba3_codemp in ('0001', '0002', '0005')  "
	c_Qry += "         and ba3_grpcob  in ('1001', '1002', '1003') "
	c_Qry += "         and ba3_codint = ba1_codint "
	c_Qry += "         and ba3_codemp = ba1_codemp "
	c_Qry += "         and ba3_matric = ba1_matric "
	c_Qry += "         and ba1_datblo = ' '  "
	c_Qry += "         AND  ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg = SUBSTR(ZRL_MATRIC, 1, 16) "
	c_Qry += "         and " + RETSQLNAME("BA3") + ".d_e_l_e_t_ = ' ' "
	c_Qry += "         and " + RETSQLNAME("BA1") + ".d_e_l_e_t_ = ' ' "
	c_Qry += "         and " + RETSQLNAME("ZRL") + ".d_e_l_e_t_ = ' ' "
	c_Qry += "       ) d, " + RETSQLNAME("BA1") + ", " + RETSQLNAME("BA3") 
	c_Qry += "       where ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg = matric "
	c_Qry += "         and ba3_codint = ba1_codint "
	c_Qry += "         and ba3_codemp = ba1_codemp "
	c_Qry += "         and ba3_matric = ba1_matric "
	c_Qry += "         and " + RETSQLNAME("BA3") + ".d_e_l_e_t_ = ' '  "
	c_Qry += "         and " + RETSQLNAME("BA1") + ".d_e_l_e_t_ = ' '   "
	
	c_Qry += "         ) "
	c_Qry += "     ) "
	c_Qry += " WHERE VALOR_DE_TABELA <> VALOR_SITE "
	
	TcQuery c_Qry ALIAS "TMP001" NEW
	
	aCabec := {	"MATRIC",;
		"NOME",;
		"MATRIC_PREVI",;
		"GRUPO_DE_COBRANCA",;
		"DT_BLOQUEIO",;
		"VALOR_DE_TABELA",;
		"VALOR_SITE",;
		"TEC"}
	
	While !TMP001->(EOF())
		
		AADD(aDados,{	"'"+TMP001->MATRIC			, ;
			TMP001->NOME			, ;
			"'"+TMP001->MATRIC_PREVI	, ;
			TMP001->GRUPO_DE_COBRANCA,;
			TMP001->DT_BLOQUEIO		, ;
			TMP001->VALOR_DE_TABELA	, ;
			TMP001->VALOR_SITE		, ;
			"'"+TMP001->TEC}	)
		
		TMP001->( dbSkip() )
		
	EndDo
	
	
	aAdd(aDados ,{"Fim"} )
	//Abre excel
	DlgToExcel({{"ARRAY","Valor diferente do pagamento no site" ,aCabec,aDados}})
	
	TMP001->( dbCloseArea() )
	
	c_Qry := " select matric,RETORNA_DESC_PLANO_MS('C','0001',substr(matric, 5,4),substr(matric, 9,6),'00') PLANO, "
	c_Qry += " nome, matric_previ, grupo_de_cobranca, (CASE WHEN  NVL(VALORBDK, 0 ) <> 0 THEN VALORBDK ELSE VALORBBU END) VALOR_DE_TABELA "
	
	c_Qry += " from ( select matric,   "
	c_Qry += "         ba1_nomusr nome,  "
	c_Qry += "         ba3_matemp matric_previ, "
	c_Qry += "         ba3_grpcob grupo_de_cobranca, "
	c_Qry += "         ( SELECT BDK_VALOR           "
	c_Qry += "                                               FROM siga.bdk010  "
	c_Qry += "                                               WHERE BDK_FILIAL = ' ' "
	c_Qry += "                                                 AND BDK_CODINT = BA1_CODINT "
	c_Qry += "                                                 AND BDK_CODEMP = BA1_CODEMP "
	c_Qry += "                                                 AND BDK_MATRIC = BA1_MATRIC "
	c_Qry += "                                                 AND BDK_TIPREG = BA1_TIPREG "
	c_Qry += "                                                 and d_e_l_e_t_ = ' '        "
	
	c_Qry += "                                                AND ( ( BA1_MUDFAI = 0 and BA1_faicob = BDK_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BDK_IDAINI AND IDADE_S(BA1_DATNAS) <= BDK_IDAFIN  ))                             "
	
	c_Qry += "                                                 AND ROWNUM = 1) VALORBDK ,  "
	c_Qry += "                                                      ( SELECT BBU_VALFAI
	c_Qry += "               FROM bbu010    "
	c_Qry += "               WHERE BBU_FILIAL = ' '    "
	c_Qry += "                 AND BBU_CODOPE = BA1_CODINT  "
	c_Qry += "                 AND BBU_CODEMP = BA1_CODEMP  "
	c_Qry += "                 AND BBU_MATRIC = BA1_MATRIC  "
	
	c_Qry += "                 AND D_E_L_E_T_ = ' '         "
	c_Qry += "                 AND ( ( BA1_MUDFAI = 0 and BA1_FAICOB = BBU_CODFAI) or (BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BBU_IDAINI AND IDADE_S(BA1_DATNAS)  <= BBU_IDAFIN  ))                                       "
	c_Qry += "                 AND ROWNUM = 1 ) VALORBBU "
	c_Qry += " from      "
	c_Qry += " (  select ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg matric "
	c_Qry += "   from ba3010, ba1010 "
	c_Qry += "   where ba3_filial = ' ' "
	c_Qry += "   and ba3_codemp in ('0001', '0002', '0005') "
	c_Qry += "   and ba3_grpcob  in ('1001', '1002', '1003') "
	c_Qry += "   and ba3_codint = ba1_codint  "
	c_Qry += "   and ba3_codemp = ba1_codemp  "
	c_Qry += "   and ba3_matric = ba1_matric  "
	c_Qry += "   and ba1_datblo = ' '         "
	c_Qry += "   and ba3010.d_e_l_e_t_ = ' '  "
	c_Qry += "   and ba1010.d_e_l_e_t_ = ' '  "
	
	c_Qry += "   minus  "
	
	c_Qry += "   select substr(zrl_matric, 1, 16) matric "
	
	c_Qry += "   from zrl010 "
	c_Qry += "   where d_e_l_e_t_ = ' ' "
	c_Qry += "   and zrl_matric <> ' '  "
	c_Qry += " ) d, ba1010, ba3010     "
	c_Qry += " where ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg = matric "
	c_Qry += "   and ba3_codint = ba1_codint "
	c_Qry += "   and ba3_codemp = ba1_codemp "
	c_Qry += "   and ba3_matric = ba1_matric  "
	c_Qry += "   and ba3010.d_e_l_e_t_ = ' '  "
	c_Qry += "   and ba1010.d_e_l_e_t_ = ' '  "
	
	c_Qry += "   )   "
	
	c_Qry += " order by 3	"
	
	TcQuery c_Qry ALIAS "TMP001" NEW
	
	aCabec := {	"MATRIC",;
		"NOME",;
		"MATRIC_PREVI",;
		"GRUPO_DE_COBRANCA",;
		"VALOR_DE_TABELA"}
	aDados := {}
	While !TMP001->(EOF())
		
		AADD(aDados,{   "'"+TMP001->MATRIC			, ;
			TMP001->NOME			, ;
			"'"+TMP001->MATRIC_PREVI	, ;
			"'"+TMP001->GRUPO_DE_COBRANCA,;
			TMP001->VALOR_DE_TABELA	   }	)
		
		TMP001->( dbSkip() )
		
	EndDo
	
	
	aAdd(aDados ,{"Fim"} )
	//Abre excel
	DlgToExcel({{"ARRAY","Matrículas no grupo Previ que não possuem vínculo no consig ou o vínculo mudou" ,aCabec,aDados}})
	
	TMP001->( dbCloseArea() )
	
	c_Qry := "   select matric, nome, matric_previ, grupo_de_cobranca, dt_bloqueio, RETORNA_MOTIVO_BLOQ ( '0001',SUBSTR(matric, 5,4 ),SUBSTR(matric, 9,6 ) , SUBSTR(matric, 15,2 ), dt_bloqueio ,'C'), (CASE WHEN  NVL(VALORBDK, 0 ) <> 0 THEN VALORBDK ELSE VALORBBU END) VALOR_DE_TABELA, "
	c_Qry += "   (SELECT zrl_TEC FROM zrl010 WHERE SUBSTR(zrl_MATRIC, 1, 16) = MATRIC AND D_E_L_E_T_ = ' ' AND zrl_MATRIC <> ' ' and rownum = 1 ) TEC "
	
	c_Qry += "   from ( select matric, "
	c_Qry += "           ba1_nomusr nome, "
	c_Qry += "           ba3_matemp matric_previ, "
	c_Qry += "           ba3_grpcob grupo_de_cobranca,"
	c_Qry += "           to_date(trim(ba1_datblo), 'YYYYMMDD') dt_bloqueio,"
	c_Qry += "           ( SELECT BDK_VALOR                                 "
	c_Qry += "                                                 FROM siga.bdk010 "
	c_Qry += "                                                 WHERE BDK_FILIAL = ' ' "
	c_Qry += "                                                   AND BDK_CODINT = BA1_CODINT  "
	c_Qry += "                                                   AND BDK_CODEMP = BA1_CODEMP  "
	c_Qry += "                                                   AND BDK_MATRIC = BA1_MATRIC  "
	c_Qry += "                                                   AND BDK_TIPREG = BA1_TIPREG  "
	c_Qry += "                                                   and d_e_l_e_t_ = ' '         "
	
	c_Qry += "                                                  AND ( ( BA1_MUDFAI = 0 and BA1_faicob = BDK_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BDK_IDAINI AND IDADE_S(BA1_DATNAS) <= BDK_IDAFIN  ))                             "
	
	c_Qry += "                                                   AND ROWNUM = 1) VALORBDK ,                           "
	c_Qry += "                                                     ( SELECT BBU_VALFAI                                          "
	c_Qry += "                 FROM bbu010                                        "
	c_Qry += "                 WHERE BBU_FILIAL = ' '                             "
	c_Qry += "                   AND BBU_CODOPE = BA1_CODINT                      "
	c_Qry += "                   AND BBU_CODEMP = BA1_CODEMP                      "
	c_Qry += "                   AND BBU_MATRIC = BA1_MATRIC                      "
	
	c_Qry += "                   AND D_E_L_E_T_ = ' '                             "
	c_Qry += "                   AND ( ( BA1_MUDFAI = 0 and BA1_FAICOB = BBU_CODFAI) or (BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS)  >= BBU_IDAINI AND IDADE_S(BA1_DATNAS)  <= BBU_IDAFIN  ))                                       "
	c_Qry += "                   AND ROWNUM = 1 ) VALORBBU    "
	c_Qry += "   from                                         "
	c_Qry += "   (   select substr(zrl_matric, 1, 16) matric  "
	
	c_Qry += "     from zrl010                                "
	c_Qry += "     where d_e_l_e_t_ = ' '                      "
	c_Qry += "     and zrl_matric <> ' '                       "
	
	c_Qry += "     minus "
	
	c_Qry += "     select ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg matric  "
	c_Qry += "     from ba3010, ba1010  "
	c_Qry += "     where ba3_filial = ' ' "
	c_Qry += "     and ba3_codemp in ('0001', '0002', '0005')  "
	c_Qry += "     and ba3_grpcob  in ('1001', '1002', '1003') "
	c_Qry += "     and ba3_codint = ba1_codint "
	c_Qry += "     and ba3_codemp = ba1_codemp "
	c_Qry += "     and ba3_matric = ba1_matric "
	c_Qry += "     and ba1_datblo = ' '       "
	c_Qry += "     and ba3010.d_e_l_e_t_ = ' ' "
	c_Qry += "     and ba1010.d_e_l_e_t_ = ' ' "
	c_Qry += "   ) d, ba1010, ba3010           "
	c_Qry += "   where ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg = matric   "
	c_Qry += "     and ba3_codint = ba1_codint          "
	c_Qry += "     and ba3_codemp = ba1_codemp          "
	c_Qry += "     and ba3_matric = ba1_matric          "
	c_Qry += "     and ba3010.d_e_l_e_t_ = ' '          "
	c_Qry += "     and ba1010.d_e_l_e_t_ = ' '          "
	"
	c_Qry += "     )	                                "
	
	TcQuery c_Qry ALIAS "TMP001" NEW
	
	aCabec := {	"MATRIC",;
		"NOME",;
		"MATRIC_PREVI",;
		"DATA BLOQUEIO"     ,;
		"GRUPO_DE_COBRANCA",;
		"VALOR_DE_TABELA"}
	aDados := {}
	While !TMP001->(EOF())
		
		AADD(aDados,{	"'"+TMP001->MATRIC			, ;
			TMP001->NOME			, ;
			dt_bloqueio ,;
			"'"+	TMP001->MATRIC_PREVI	, ;
			"'"+	TMP001->GRUPO_DE_COBRANCA,;
			TMP001->VALOR_DE_TABELA	   }	)
		
		TMP001->( dbSkip() )
		
	EndDo
	
	
	aAdd(aDados ,{"Fim"} )
	//Abre excel
	DlgToExcel({{"ARRAY","Ativos no site e inativos no protheus" ,aCabec,aDados}})
	
	TMP001->( dbCloseArea() )
	
	
Return

User Function GerBolPrev()
	
	Processa({|| l_Erro := u_pGerBolPrev(  )},"Gerando ... ", "", .T.)
	
Return


User Function pGerBolPrev()
	
	Local aDados := {}
	
	c_Qry := " select e1_prefixo prefixo, "
	c_Qry += " e1_num numero,             "
	c_Qry += " e1_valor valor,            "
	c_Qry += " e1_saldo saldo,            "
	c_Qry += " e1_codint||e1_codemp||e1_matric mat_pro, "
	c_Qry += " pbs_matemp mat_previ ,                        "
	c_Qry += " to_date(e1_vencto, 'YYYYMMDD') vencimento,          "
	c_Qry += " to_date(e1_vencrea, 'YYYYMMDD') venc_real,    "
	c_Qry += " e1_formrec rece_titulo,                      "
	c_Qry += " ba3_vencto venc_familia,                      "
	c_Qry += " ba3_grpcob grpo_cob,                          "
	c_Qry += " ba3_tippag tip_paga,                          "
	c_Qry += " ba3_portad portador,                                "
	c_Qry += " ba3_agedep agencia,                                 "
	c_Qry += " ba3_ctacor conta                                    "
	c_Qry += " FROM " + RETSQLNAME("PBS") + " INNER JOIN " + RETSQLNAME("SE1") + " ON  "
	c_Qry += "             E1_FILIAL = '" + XFILIAL("SE1") + "' "
	c_Qry += "             AND E1_PREFIXO = 'PLS'  "
	c_Qry += "             AND E1_NUM = PBS_NUMTIT "
	
	c_Qry += "             INNER JOIN " + RETSQLNAME("BA3") + " ON       "
	c_Qry += "             BA3_FILIAL = ' '           "
	c_Qry += "             AND BA3_CODINT = E1_CODINT "
	c_Qry += "             AND BA3_CODEMP = E1_CODEMP "
	c_Qry += "             AND BA3_MATRIC = E1_MATRIC "
	c_Qry += " WHERE PBS_FILIAL = ' ' "
	c_Qry += "       AND PBS_CODREM = '" + PBR->PBR_CODREM + "' "
	c_Qry += "       AND SE1010.D_E_L_E_T_ = ' ' "
	c_Qry += "       AND PBS010.D_E_L_E_T_ = ' ' "
	
	c_Qry += "       AND E1_SALDO > 0 "
	
	TcQuery c_Qry ALIAS "TMP001" NEW
	
	aCabec := {	"PREFIXO",;
		"NUMERO",;
		"VALOR",;
		"SALDO",;
		"matricula_protheus",;
		"matricula_previ",;
		"vencimento",;
		"vencimento_real",;
		"recebimento_titulo",;
		"vencimento_familia",;
		"grupo_cobranca",;
		"tipo_pagamento",;
		"portador",;
		"agencia",;
		"conta"}
	
	While !TMP001->(EOF())
		
		AADD(aDados,{	TMP001->PREFIXO			, ;
			"'"+TMP001->NUMERO			, ;
			TMP001->VALOR	, ;
			TMP001->SALDO,;
			"'"+TMP001->mat_pro		, ;
			"'"+TMP001->mat_previ	, ;
			TMP001->vencimento		, ;
			TMP001->venc_real		, ;
			TMP001->rece_titulo		, ;
			TMP001->venc_familia		, ;
			"'"+TMP001->grpo_cob		, ;
			"'"+TMP001->tip_paga		, ;
			"'"+TMP001->portador		, ;
			"'"+TMP001->agencia		, ;
			"'"+TMP001->conta}	)
		
		TMP001->( dbSkip() )
		
	EndDo
	
	
	aAdd(aDados ,{"Fim"} )
	//Abre excel
	DlgToExcel({{"ARRAY","Valor diferente do pagamento no site" ,aCabec,aDados}})
	
	TMP001->( dbCloseArea() )
	
Return
