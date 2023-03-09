#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR001 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 03.02.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Extrato de Movimentacao da RDA                             ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR673()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRJR001()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCentury      := __setcentury()
PRIVATE cRelDir     := GetMv("MV_RELT")
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR001"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Pagamentos"
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CRJ001"
PRIVATE nRel        := "CRJR001"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Codigo RDA","Nome da RDA","Data da baixa"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "RDA                                                Vlr Informado      Vlr Bruto               Tx Admin            IRRF         ISS Cr.           INSS           Vlr Adiant.           PIS         CSL         Cofins          Tarifa         Liquido"
PRIVATE cCabec2     := ""
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E 999,999.99"
PRIVATE pMoeda2     := "@E 999,999,999.99"
PRIVATE pMoeda3     := "@E 9,999,999.99"
PRIVATE nTamDes     := 35
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCodOpe
PRIVATE cRdaDe
PRIVATE cRdaAte
PRIVATE cAno
PRIVATE cMes
PRIVATE nTipRel
PRIVATE cClaPre
PRIVATE cNumFat
PRIVATE cGruPag

PRIVATE lImpZero
PRIVATE aRet := {.T.,""}

Set Century Off

If BD6->(FieldPos("BD6_PAGRDA")) == 0
	MsgStop("SIGAPLS - Campo BD6_PAGRDA nao criado, por favor entrar em contato com o Suporte.")
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1() //nova pergunta...
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRel := SetPrint(cAlias,nRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey  == 27
	If  lCentury
		set century on
	Endif
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini variaveis de parametros...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCodOpe   := mv_par01
cRdaDe    := mv_par02
cRdaAte   := mv_par03
cAno      := mv_par04
cMes      := mv_par05
nTipRel   := mv_par06
cClaPre   := mv_par07
cNumFat   := mv_par08
cGruPag   := mv_par09

If  nTipRel == 1
	lAnalitico := .T.
Else
	lAnalitico := .F.
Endif
cTitDem   += RetMesAno(cAno+cMes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

nTipQbc := aReturn[8]

If lAnalitico
	cCabec1 := "Codigo - Nome RDA.             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido           Saldo"
	
Else
	cCabec1 := "Grupo de pagamento             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido           Saldo"
		
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de processamento do relatorio...							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| RJ001Imp() }, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera filtro do BD7                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ms_flush()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lCentury
	set century on
Endif

Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ RJ001Imp ³ Autor ³ Geraldo Felix Junior  ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime o extrato mensal dos servicos prestados            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function RJ001Imp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nInd
LOCAL nFor
LOCAL nOrdem        := aReturn[8]
LOCAL i
LOCAL cSQL
LOCAL aRetAux		:= {}
LOCAL nPos
Local cLotBD7 	:= ""
Local cLotBMR 	:= ""
Local lContrRet	:=	!Empty(SE2->(FieldPos("E2_VRETPIS"))) .And. !Empty(SE2->(FieldPos("E2_VRETCOF"))) .And. ; 
					!Empty(SE2->(FieldPos("E2_VRETCSL"))) .And. !Empty(SE2->(FieldPos("E2_PRETPIS"))) .And. ;
					!Empty(SE2->(FieldPos("E2_PRETCOF"))) .And. !Empty(SE2->(FieldPos("E2_PRETCSL")))
Local nOutImp		:= 	0

LOCAL nTotInf	:= 0
LOCAL nTotBru	:= 0
LOCAL nTotTxa	:= 0
LOCAL nTotIrf 	:= 0
LOCAL nTotIss	:= 0
LOCAL nTotIns	:= 0
LOCAL nTotAdt	:= 0
LOCAL nTotPis	:= 0
LOCAL nTotCSL	:= 0
LOCAL nTotVlr 	:= 0
LOCAL nTotCof	:= 0
LOCAL nTotTar	:= 0
LOCAL nTotJud	:= 0
LOCAL nTotLiq 	:= 0
LOCAL nTotSal	:= 0

LOCAL nTotdInf	:= 0
LOCAL nTotdBru	:= 0
LOCAL nTotdTxa	:= 0
LOCAL nTotdIrf 	:= 0
LOCAL nTotdIss	:= 0
LOCAL nTotdIns	:= 0
LOCAL nTotdAdt	:= 0
LOCAL nTotdPis	:= 0
LOCAL nTotdCSL	:= 0
LOCAL nTotdVlr 	:= 0
LOCAL nTotdCof	:= 0
LOCAL nTotdTar	:= 0
LOCAL nTotdJud	:= 0
LOCAL nTotdLiq 	:= 0
LOCAL nTotdSal	:= 0
LOCAL nPsInf	:= 0
LOCAL aPsInf	:= {}
Local aCampoTRB := {	{ "TRB_CODIGO"    	, "C", TamSX3("BAU_CODIGO")[1]	, 0 },;
						{ "TRB_NOME" 		, "C", TamSX3("BAU_NOME")[1]	, 0 },;
						{ "TRB_GRPPAG"		, "C", TamSX3("BAU_GRPPAG")[1]	, 0 },;
						{ "TRB_DESGRP"		, "C", 20						, 0 },;
						{ "TRB_ANO" 		, "C", TamSX3("BM1_ANO" )[1]	, 0 },;
						{ "TRB_MES"			, "C", TamSX3("BM1_MES")[1]		, 0 },;
						{ "TRB_TIPO"		, "C", TamSX3("BAU_TIPPE")[1]	, 0 },;
						{ "TRB_BAIXA"		, "D", 8						, 0 },;
						{ "TRB_IRRF"		, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
						{ "TRB_INSS"		, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
						{ "TRB_ACRESC"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_DCRESC"		, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
						{ "TRB_PIS" 		, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
						{ "TRB_COFINS"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_CSLL" 		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_ISS"			, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRINF"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRBRT"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRTAX"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRADT" 		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRTAR" 		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_VLRJUD" 		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;						
						{ "TRB_VLRLIQ"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
						{ "TRB_SALDO"		, "N", TamSX3("BM1_VALOR")[1]	, 2	}}
						
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Matriz Principal														 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aTrbBD7 := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nDebFix     := 0
PRIVATE nCreFix     := 0
PRIVATE nDebVar     := 0
PRIVATE nCreVar     := 0
PRIVATE nDebApo     := 0
PRIVATE nCreApo     := 0

PRIVATE ntDebFix    := 0
PRIVATE ntCreFix    := 0
PRIVATE ntDebVar    := 0
PRIVATE ntCreVar    := 0
PRIVATE ntDebApo    := 0
PRIVATE ntCreApo    := 0

PRIVATE nCreTot     := 0
PRIVATE nDebTot     := 0
PRIVATE nVlrTot     := 0
PRIVATE nVlrIRF     := 0
PRIVATE nTotal      := 0
PRIVATE cRdaAnt
Private aRdas	    := {}
Private lTemLot     := .F.
Private lLotImp     := .F.    // indica que existe lote somente de impostos
Private cLotImp     := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ variaveis de trabalho...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cNomCre     //Nome do Credenciado completo...
PRIVATE cMovime     //Codigo do movimento
PRIVATE cEspecia
PRIVATE cOpeLot
PRIVATE cNumLot
PRIVATE cLotes      := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mensagem                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsProcTxt("Processando Dados...")
ProcessMessages()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(cMes)) + "/" + cAno + ' - '+Iif(lAnalitico, "Analitico", "Sintetico")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona indices                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(dbSetOrder(2))
BD5->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BR8->(DbSetOrder(1))
SA2->(dbSetOrder(1))
B16->(dbSetorder(1))
SE5->(dbSetorder(7))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra BAU-Rede de Atendimento                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT R_E_C_N_O_ BAU_RECNO FROM " + RetSQLName("BAU")
cSQL += " WHERE BAU_FILIAL  = '" + xFilial("BAU") + "' AND "
cSQL += "       BAU_CODIGO >= '" + cRdaDe    + "' AND BAU_CODIGO <= '" + cRdaAte    + "' AND "
If !Empty(cGruPag)
	cSql += " BAU_GRPPAG = '"+cGruPag+"' AND "
//	cSql += " (BAU_GRPPAG = '1001' or BAU_GRPPAG = '1002') AND "
Endif
	
cSQL += "D_E_L_E_T_ = ''"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena de acordo com a configuracao de impressao...                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If nTipRel == 1		// Analitico...
	If nOrdem == 1
		cSQL += "ORDER BY BAU_CODIGO "
	Else
		cSQL += "ORDER BY BAU_NOME "
	Endif
//Else
//	cSql += "ORDER BY BAU_GRPPAG"
//Endif

PLSQUERY(cSQL,"TrbBAU")

If nOrdem = 3  // Por quebra de data da baixa
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTRB := CriaTrab(aCampoTRB, .T.)
		
	dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cInd1TRB := CriaTrab(Nil, .F.)
		
	If nTipRel == 1		// Analitico...
		IndRegua("TRB1",cInd1TRB,"TRB_CODIGO + TRB_ANO + TRB_MES + TRB_TIPO + dTos(TRB_BAIXA)",,,"Indexando Arquivo de Trabalho")
		TRB1->( dbClearIndex() )		
		
		cInd2TRB := CriaTrab(Nil, .F.)
		
		IndRegua("TRB1",cInd2TRB,"dTos(TRB_BAIXA) + TRB_TIPO + TRB_CODIGO",,,"Indexando arquivo temporario...")  //"Indexando Arquivo de Trabalho"
		TRB1->( dbClearIndex() )
		
	Else  // Sintetico...
		IndRegua("TRB1",cInd1TRB,"TRB_GRPPAG + dTos(TRB_BAIXA)",,,"Indexando Arquivo de Trabalho") 
		TRB1->( dbClearIndex() )		
		
		cInd2TRB := CriaTrab(Nil, .F.)
		
		IndRegua("TRB1",cInd2TRB,"dTos(TRB_BAIXA) + TRB_TIPO + TRB_GRPPAG",,,"Indexando arquivo temporario...")  //"Indexando Arquivo de Trabalho"
		TRB1->( dbClearIndex() )
			
	EndIf

	TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
	TRB1->(dbSetIndex(cInd2TRB + OrdBagExt()))
	
	TRB1->( dbSetorder(01) )	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cada RDA                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! TrbBAU->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona BAU-Rede de Atendimento                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbGoTo(TrbBAU->BAU_RECNO))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Verificando... " + Left(AllTrim(BAU->BAU_NOME),30))
	ProcessMessages()
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona SA2-Fornecedores                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SA2->(msSeek(xFilial("SA2")+BAU->(BAU_CODSA2+BAU_LOJSA2)))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA pertence ao grupo informado                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  ! empty(cClaPre) .and. ! BAU->BAU_TIPPRE $ cClaPre
		TrbBAU->(DbSkip())
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA pertence ao grupo de pagamento                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  ! empty(cGruPag) .and. ! BAU->BAU_GRPPAG $ cGruPag
		TrbBAU->(DbSkip())
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA existe para a operadora desejada                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAW->(DbSetOrder(1))
	If  ! BAW->(msSeek(xFilial("BAW")+BAU->BAU_CODIGO+cCodOpe))
		TrbBAU->(DbSkip())
		Loop
	Endif
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Descricao do grupo de pagamento...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDesGrp := ''
	If B16->( MsSeek(xFilial("B16")+BAU->BAU_GRPPAG) )
		cDesGrp := B16->B16_DESCRI
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Imprimindo... " + Left(AllTrim(BAU->BAU_NOME),30))
	ProcessMessages()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta query para obter os lotes de pagamento da RDA no periodo...   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := " SELECT BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
	cSQL += "  FROM " + RetSQLName("BMR")
	cSQL += "  WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
	cSQL += "    AND BMR_CODRDA = '" + BAU->BAU_CODIGO + "' "
	cSQL += "    AND BMR_ANOLOT = '" + cAno    + "' "
	cSQL += "    AND BMR_MESLOT = '" + cMes    + "' "
	cSQL += "    AND D_E_L_E_T_ = ' ' "
	cSQL += " GROUP BY BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
	cSQL += " ORDER BY BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa query                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSQUERY(cSQL,"Trb")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa arquivo de trabalho, contruindo a variavel com os lotes envolvidos...  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cLotes := ""
	While ! Trb->( Eof() )
		cLotes += "'" + Trb->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "',"
		
		Trb->(dbSkip())
	Enddo
	Trb->(dbCloseArea())
	
	cLotes := alltrim(cLotes)
	If  right(cLotes,1) == ","
		clotes := "(" + substr(cLotes,1,len(cLotes)-1) + ")"
		
	Endif
	
	// busca Titulos da RDA no ano/mes
	If  empty(cLotes)
		cLotes := "('')"
	Endif
	
	cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
	cSQL += "  FROM " + RetSQLName("SE2")
	cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
	cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
	cSQL += "    AND E2_PLLOTE IN " + cLotes
	cSQL += "    AND D_E_L_E_T_ = ' ' "
	cSQL += " ORDER BY E2_BAIXA "
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa query                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSQUERY(cSQL,"Trb")
         
	// So ira processar o BD7 caso exista titulo a receber... ganho de performance...
	nVlrTax := 0
	If !Trb->( Eof() )
		cSql := "SELECT BD7_BLOPAG, BD7_SITUAC, BD7_FASE, BD7_VLTXPG FROM "+RetSqlName("BD7")+" WHERE BD7_FILIAL =  '"+xFilial("BD7")+"' "
		cSql += "AND BD7_CODOPE = '" + cCodOpe +"' "
		cSql += "AND BD7_OPELOT = '" + cCodOpe +"' "
		cSql += "AND BD7_NUMLOT LIKE '"+cAno+cMes+"%' "
		cSql += "AND BD7_CODRDA = '" + BAU->BAU_CODIGO + "' "
		cSql += "AND D_E_L_E_T_ = ' ' "
		PLSQUERY(cSQL,"TRBBD7")
		If !TRBBD7->( Eof() )
			TRBBD7->( DBEval({ | | Iif(	BD7_BLOPAG <> '1' .and.;
					 					!(BD7_SITUAC $ '3,2') .and.;
					 					BD7_FASE = '4' .and.;
					 					BD7_VLTXPG > 0, nVlrTax += BD7_VLTXPG,NIL) }) )
		Endif           	          	
		TRBBD7->( dbCloseArea() )	
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa arquivo de trabalho                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lLock := .F.
	While ! Trb->(eof())
		// Posiciona o titulo fisicamente no SE2.
		SE2->(dbGoTo(Trb->E2_RECNO))
/*		
		If dTos(SE2->E2_BAIXA) <> '20071119'
			Trb->( dbSkip() )
			Loop
		Endif
*/		
		// Ignora os titulos de impostos
		If (SE2->E2_TIPO == MVINSS .And. ;
			IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
			SE2->E2_TIPO == MVTAXA .or. SE2->E2_TIPO == 'PA'
			
			Trb->(dbSkip())
			Loop
		Endif

		If nOrdem == 3 	// Quebra por vencimento...
			If nTipRel == 1		// Analitico...
				lFound := TRB1->( MsSeek(BAU->BAU_CODIGO + cAno + cMes + BAU->BAU_TIPPE + dTos(SE2->E2_BAIXA)) )
				
			Else
				lFound := TRB1->( MsSeek(BAU->BAU_GRPPAG + dTos(SE2->E2_BAIXA)) )
				
			Endif
			
		Else
			If nTipRel == 1		// Analitico...
				nPos := aScan(aRdas,{|x| x[1] + x[17] + x[18] == BAU->BAU_CODIGO + cAno + cMes })
				
			Else
				nPos := aScan(aRdas,{|x| x[20]  == BAU->BAU_GRPPAG })
					
			Endif
		Endif
		
		// Cria matriz/registro do medico
		If  nPos == 0 .and. nOrdem <> 3
			aadd(aRdas,{	BAU->BAU_CODIGO,;		// 01 Codigo da RDA
							0,;						// 02 Valor
							0,;						// 03 IRRF
							0,;						// 04 INSS
							0,;						// 05 Acrescimos
							0,;						// 06 Descressimos
							0,;						// 07 PIS
							0,;						// 08 Cofins
							0,;						// 09 CSLL
							0,;						// 10 ISS
							0,;						// 11 Valor informado
							0,;						// 12 Valor Bruto
							nVlrTax,;				// 13 Taxa administrativa
							0,;						// 14 Valor adiantamento
							0,;						// 15 Tarifas
							0,;						// 16 Valor liquido
							cAno,;					// 17 Ano da competencia
							cMes,;					// 18 Mes da competencia
							BAU->BAU_NOME,;			// 19 Nome da RDA
							BAU->BAU_GRPPAG,;		// 20 Grupo de pagamento
							cDesGrp,;				// 21 Nome do grupo de pagamento
							0,;						// 22 Saldo do titulo
							0})						// 23 Valor judicial
			
			nPos := len(aRdas)
			
		Elseif nOrdem == 3
			TRB1->( RecLock("TRB1", !lFound) )
			lLock := .T.
			// Grava campos que compoem a chave de pesquisa.
			If !lFound
				TRB1->TRB_CODIGO 	:= BAU->BAU_CODIGO
				TRB1->TRB_NOME		:= BAU->BAU_NOME
				TRB1->TRB_GRPPAG	:= BAU->BAU_GRPPAG
				TRB1->TRB_DESGRP	:= cDesGrp
				TRB1->TRB_ANO		:= cAno
				TRB1->TRB_MES		:= cMes
				TRB1->TRB_TIPO		:= BAU->BAU_TIPPE
				TRB1->TRB_VLRTAX	:= nVlrTax
				TRB1->TRB_BAIXA		:= SE2->E2_BAIXA
			Endif

			If (nPsInf := Ascan(aPsInf,(BAU->BAU_CODIGO + cMes + cAno)) == 0)
				ZZP->( dbSetorder(01) )
				If ZZP->( dbSeek(xFilial("ZZP") + BAU->BAU_CODIGO + cMes + cAno) )
					While !ZZP->( Eof() ) .and. ZZP->ZZP_CODRDA == BAU->BAU_CODIGO .and. ZZP->ZZP_MESPAG == cMes .and. ZZP->ZZP_ANOPAG == cAno
            	
						If nOrdem == 3
							//Inicio alteração Renato Peixoto em 06/0812. Adaptação para tratar novo campo totalizador (ZZP_VLTGUI).
							If ZZP->ZZP_VLTGUI = 0
								TRB1->TRB_VLRINF += ZZP->ZZP_VLRTOT
							Else
								TRB1->TRB_VLRINF += ZZP->ZZP_VLTGUI
							EndIf
							
						Else
							
							If ZZP->ZZP_VLTGUI = 0
								aRdas[nPos, 11]	+= ZZP->ZZP_VLRTOT
							Else
								aRdas[nPos, 11] += ZZP->ZZP_VLTGUI
							EndIf
							//Fim Alteração Renato Peixoto.
						Endif
				
						ZZP->( dbSkip() )
					Enddo
				Endif
				
				Aadd(aPsInf, (BAU->BAU_CODIGO + cMes + cAno))
			Endif
		Endif
				
		// Processa as baixas.
		nVlrPA := 0
		nVlrBx := 0
		nVlrJd := 0
		If SE5->( MsSeek(xFilial("SE5")+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA) )
				
			While !SE5->( Eof() ) .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA ==;
										SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
		
				// Ignora descontos, juros, cancelamentos, recebimentos e outros tipos...
				If 	SE5->E5_RECPAG == 'R' .or.;
					SE5->E5_SITUACA == 'C' .or. ;
					SE5->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN") .or.;
					(SE5->E5_TIPODOC $ "DC, D2, JR, J2, TL, MT, M2, CM, C2, TR, TE")
			
					SE5->( dbSkip() )
					Loop
				Endif
						
				// Processa os estornos das baixas... se houverem.
			  	cQuery := "SELECT Sum(E5_VALOR) ESTORNO FROM "+RetSqlName("SE5")+" WHERE "
			   	cQuery += "E5_FILIAL='"+xFilial("SE5")+"' AND "
			   	cQuery += "E5_PREFIXO='"+SE5->E5_PREFIXO+"' AND "
				cQuery += "E5_NUMERO='"+SE5->E5_NUMERO+"' AND "
				cQuery += "E5_PARCELA='"+SE5->E5_PARCELA+"' AND "
				cQuery += "E5_TIPO='"+SE5->E5_TIPO+"' AND "
				cQuery += "E5_CLIFOR='"+SE5->E5_CLIFOR+"' AND "
				cQuery += "E5_LOJA='"+SE5->E5_LOJA+"' AND "
				cQuery += "E5_SEQ='"+SE5->E5_SEQ+"' AND "
				cQuery += "E5_TIPODOC='ES' AND "
				cQuery += "D_E_L_E_T_<>'*'"
				PlsQuery(cQuery, "EST")
				
				nVlrEst := EST->ESTORNO 
				EST->( dbCloseArea() )
				
				// Se for PA, acumular na matriz neste ponto e descarregar depois...
				If Alltrim(SE5->E5_TIPODOC) == 'CP' .and. Alltrim(SE5->E5_MOTBX) == 'CMP'
					nVlrPA += SE5->E5_VALOR
					nVlrPA -= nVlrEst // Diminui o valor do estorno se houver
					                                  
				// Desconto por motivo judicial..
				Elseif Alltrim(SE5->E5_MOTBX) == 'DPJ'
					nVlrJd += SE5->E5_VALOR
					nVlrJd -= nVlrEst // Diminui o valor do estorno se houver
									
				Else
					nVlrBx += SE5->E5_VALOR
					nVlrBx -= nVlrEst // Diminui o valor do estorno se houver
				Endif
				
				SE5->( dbSkip() )
			Enddo
		Endif

		nValor := SE2->E2_VALOR
		If  empty(SE2->E2_PARCELA) // indica que eh o titulo principal
			If  SE2->E2_TIPO == "NDF"
				nValor := nValor * -1
			Endif
			nOutImp := IIf(lContrRet, SE2->E2_VRETPIS + SE2->E2_VRETCOF + SE2->E2_VRETCSL, SE2->E2_PIS + SE2->E2_COFINS + SE2->E2_CSLL) + SE2->E2_ISS
			
			If nOrdem == 3
				TRB1->TRB_IRRF		+= SE2->E2_IRRF
				TRB1->TRB_INSS		+= IIf(SE2->E2_TIPO == MVINSS, nValor, SE2->E2_INSS)
				TRB1->TRB_ACRESC	+= SE2->E2_ACRESC
				TRB1->TRB_DCRESC	+= SE2->E2_DECRESC
				TRB1->TRB_PIS		+= IIf(lContrRet, SE2->E2_VRETPIS, SE2->E2_PIS)
				TRB1->TRB_COFINS	+= IIf(lContrRet, SE2->E2_VRETCOF, SE2->E2_COFINS)
				TRB1->TRB_CSLL		+= IIf(lContrRet, SE2->E2_VRETCSL, SE2->E2_CSLL)
				TRB1->TRB_ISS		+= SE2->E2_ISS
				TRB1->TRB_VLRBRT	+= nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp
				If nVlrBx > 0
					TRB1->TRB_VLRTAR	+= SE2->E2_DECRESC
				Endif
				TRB1->TRB_VLRADT 	+= nVlrPA
				TRB1->TRB_VLRJUD	+= nVlrJd
				TRB1->TRB_VLRLIQ	+= nVlrBx
				TRB1->TRB_SALDO		+= SE2->E2_SALDO				
			Else
				aRdas[nPos, 2] += nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp
				aRdas[nPos, 3] += SE2->E2_IRRF
				aRdas[nPos, 4] += IIf(SE2->E2_TIPO == MVINSS, nValor, SE2->E2_INSS)
				aRdas[nPos, 5] += SE2->E2_ACRESC
				aRdas[nPos, 6] += SE2->E2_DECRESC
				aRdas[nPos, 7] += IIf(lContrRet, SE2->E2_VRETPIS, SE2->E2_PIS)
				aRdas[nPos, 8] += IIf(lContrRet, SE2->E2_VRETCOF, SE2->E2_COFINS)
				aRdas[nPos, 9] += IIf(lContrRet, SE2->E2_VRETCSL, SE2->E2_CSLL)
				aRdas[nPos,10] += SE2->E2_ISS
				aRdas[nPos, 12] += SE2->E2_YVALBRU
				If nVlrBx > 0
					aRdas[nPos, 15] += SE2->E2_DECRESC
				Endif
				aRdas[nPos, 14] += nVlrPA
				aRdas[nPos, 16] += nVlrBx
				aRdas[nPos, 22] += SE2->E2_SALDO
				aRdas[nPos, 23] += nVlrJd

			Endif
			
		Endif
		Trb->(dbSkip())
	Enddo
	Trb->(dbCloseArea())
		
	// Libera registro do arquivo temporario...         
	If nOrdem == 3 .and. lLock
		TRB1->( MsUnlock() )
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa proximo registro                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TrbBAU->(DbSkip())
Enddo

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Analitico
Codigo - Nome RDA.             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL       Cofins       Tarifa       Bx Jud         Liquido           Saldo
000000-00000000000000000000   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   99,999,999.99   99,999,999.99

Sintetico
Tipo Principal                 Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL       Cofins       Tarifa       Bx Jud         Liquido           Saldo
000000-00000000000000000000   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   99,999,999.99   99,999,999.99

*/
    
// Inicio da impressao dos dados...
MsProcTxt("Aguarde... gerando impressao!")
ProcessMessages()

nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
If nOrdem == 3
	TRB1->(dbClearIndex())
	
	TRB1->(dbSetIndex(cInd2TRB + OrdBagExt()))
	
	TRB1->( dbSetorder(01) )	
	
	TRB1->( dbGotop() )
	          
	// Variavel que ira controlar quantas quebras por baixa foram impressas. Caso seja impresso apenas uma, nao sera 
	// preciso imprimir o total, pois o valor total sera o mesmo impresso no total da quebra do dia. Tendeu ?
	nDias := 0
	While !TRB1->( Eof() )
		cBaixa 	:= dTos(TRB1->TRB_BAIXA)
		cRDA	:= TRB1->TRB_CODIGO
		
		nDias ++
		lFirst := .T.
		While !TRB1->( Eof() ) .and. dTos(TRB1->TRB_BAIXA) == cBaixa
			If TRB1->(	TRB_IRRF   + TRB_INSS   + TRB_ACRESC + TRB_DCRESC +;
						TRB_PIS	  + TRB_COFINS + TRB_CSLL   + TRB_ISS    + TRB_VLRBRT +;
						TRB_VLRTAX+ TRB_VLRTAR + TRB_VLRADT + TRB_VLRLIQ + TRB_VLRINF ) > 0
			
				// Controle de saldo de pagina...
				If  nli > nLinPag
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nLi++ 
			
					@ nLi, 000 Psay "Data Pagamento: " + Iif(!Empty(TRB1->TRB_BAIXA), dToc(TRB1->TRB_BAIXA), "Em Abertos")
					nli += 2
					
					@ nLi, 005 Psay Iif(TRB1->TRB_TIPO =='J', "Pessoa Juridica", "Pessoa Fisica")
					nli++
					cTipo := TRB1->TRB_TIPO
					
					lFirst := .F.
				Endif
				     
				// Impressao dos detalhes de cabecalho
				If lFirst 
					// Controle de saldo de pagina...
					If  nli > (nLinPag - 4)
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nLi++ 			
					Endif

					@ nLi, 000 Psay "Data Pagamento: " + Iif(!Empty(TRB1->TRB_BAIXA), dToc(TRB1->TRB_BAIXA), "Em Abertos")
					nli += 2
					
					@ nLi, 005 Psay Iif(TRB1->TRB_TIPO =='J', "Pessoa Juridica", "Pessoa Fisica")
					nli++
					cTipo := TRB1->TRB_TIPO
					
					lFirst := .F.
				Endif
				
				If TRB1->TRB_TIPO <> cTipo // Quebra por tipo dentro da quebra por vencimento...
					nLi += 2  // Da saldo de linha.
					
					If nli > nLinPag // Preteje quebra de pagina...
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nLi++ 
					Endif
					
					@ nLi, 005 Psay Iif(TRB1->TRB_TIPO =='J', "Pessoa Juridica", "Pessoa Fisica")
					nli++
					cTipo := TRB1->TRB_TIPO
				Endif								
				
				If nTipRel == 1		// Analitico...
					@ nLi, 000 Psay TRB1->TRB_CODIGO + '-' + SubStr(TRB1->TRB_NOME, 1, 20)
				Else
					@ nLi, 000 Psay TRB1->TRB_GRPPAG + '-' + SubStr(TRB1->TRB_DESGRP, 1, 20)
				Endif

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Analitico
Codigo - Nome RDA.             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido          Saldo"
000000-00000000000000000000   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99  999,999.99  999,999.99  999,999.99  99,999,999.99  99,999,999.99
*/			
				@ nLi, 030 Psay Transform(TRB1->TRB_VLRINF	, pMoeda2); nTotInf	+= TRB1->TRB_VLRINF	; nTotdInf += TRB1->TRB_VLRINF
				@ nLi, 047 Psay Transform(TRB1->TRB_VLRBRT	, pMoeda2); nTotBru	+= TRB1->TRB_VLRBRT	; nTotdBru += TRB1->TRB_VLRBRT
				@ nLi, 064 Psay Transform(TRB1->TRB_VLRTAX	, pMoeda1); nTotTxa	+= TRB1->TRB_VLRTAX	; nTotdTxa += TRB1->TRB_VLRTAX
				@ nLi, 077 Psay Transform(TRB1->TRB_IRRF	, pMoeda1); nTotIrf	+= TRB1->TRB_IRRF	; nTotdIrf += TRB1->TRB_IRRF
				@ nLi, 090 Psay Transform(TRB1->TRB_ISS		, pMoeda1); nTotIss	+= TRB1->TRB_ISS	; nTotdIss += TRB1->TRB_ISS
				@ nLi, 103 Psay Transform(TRB1->TRB_INSS	, pMoeda1); nTotIns	+= TRB1->TRB_INSS	; nTotdIns += TRB1->TRB_INSS
				@ nLi, 116 Psay Transform(TRB1->TRB_VLRADT	, pMoeda1); nTotAdt	+= TRB1->TRB_VLRADT	; nTotdAdt += TRB1->TRB_VLRADT
				@ nLi, 129 Psay Transform(TRB1->TRB_PIS		, pMoeda1); nTotPis	+= TRB1->TRB_PIS	; nTotdPis += TRB1->TRB_PIS
				@ nLi, 144 Psay Transform(TRB1->TRB_CSLL	, pMoeda1); nTotCSL	+= TRB1->TRB_CSLL	; nTotdCsl += TRB1->TRB_CSLL
				@ nLi, 154 Psay Transform(TRB1->TRB_COFINS	, pMoeda1); nTotCof	+= TRB1->TRB_COFINS	; nTotdCof += TRB1->TRB_COFINS
				@ nLi, 166 Psay Transform(TRB1->TRB_VLRTAR	, pMoeda1); nTotTar	+= TRB1->TRB_VLRTAR	; nTotdTar += TRB1->TRB_VLRTAR
				@ nLi, 178 Psay Transform(TRB1->TRB_VLRJUD	, pMoeda1); nTotJud	+= TRB1->TRB_VLRJUD	; nTotdJud += TRB1->TRB_VLRJUD
				
				@ nLi, 190 Psay Transform(TRB1->TRB_VLRLIQ	, pMoeda2); nTotLiq	+= TRB1->TRB_VLRLIQ	; nTotdLiq += TRB1->TRB_VLRLIQ
				@ nLi, 205 Psay Transform(TRB1->TRB_SALDO	, pMoeda2); nTotSal	+= TRB1->TRB_SALDO	; nTotdSal += TRB1->TRB_SALDO

				nLi++
			Endif
			
			TRB1->( dbSkip() )
		Enddo
    	    
    	// Finaliza quebra por dia da baixa imprimindo os totais do dia...
    	If nOrdem == 3
    		If (nTotdInf + nTotdBru	+ nTotdTxa	+ nTotdIrf + nTotdIss +;
				nTotdIns + nTotdAdt	+ nTotdPis	+ nTotdCSL + nTotdVlr +;
				nTotdCof + nTotdTar	+ nTotdLiq + nTotdSal) > 0			
			
				@ nLi, 000 Psay Replicate('-', nLimite)
				nLi++    	
	
				If nli > nLinPag // Preteje quebra de pagina...
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nLi++ 
				Endif                                         
				
				If !Empty(cBaixa)
					@ nLi, 000 Psay "Totais do dia "+dToc(sTod(cBaixa))
				Else
					@ nLi, 000 Psay "Total de titulos em aberto "
				Endif
				@ nLi, 030 Psay Transform(nTotdInf	, pMoeda2)
				@ nLi, 047 Psay Transform(nTotdBru	, pMoeda2)
				@ nLi, 064 Psay Transform(nTotdTxa	, pMoeda1)
				@ nLi, 077 Psay Transform(nTotdIrf	, pMoeda1)
				@ nLi, 090 Psay Transform(nTotdIss	, pMoeda1)
				@ nLi, 103 Psay Transform(nTotdIns	, pMoeda1)
				@ nLi, 116 Psay Transform(nTotdAdt	, pMoeda1)
				@ nLi, 129 Psay Transform(nTotdPis	, pMoeda1)
				@ nLi, 144 Psay Transform(nTotdCsl	, pMoeda1)
				@ nLi, 154 Psay Transform(nTotdCof	, pMoeda1)
				@ nLi, 166 Psay Transform(nTotdTar	, pMoeda1)
				@ nLi, 178 Psay Transform(nTotdJud	, pMoeda1)
				@ nLi, 190 Psay Transform(nTotdLiq	, pMoeda2)
				@ nLi, 205 Psay Transform(nTotdSal	, pMoeda2)
			
				// Reset nas variaveis totalizadoras...
				nTotdInf := nTotdBru	:= nTotdTxa	:= nTotdIrf := nTotdIss	:= 0
				nTotdIns := nTotdAdt	:= nTotdPis	:= nTotdCSL	:= nTotdVlr := 0
				nTotdCof := nTotdTar	:= nTotdLiq := nTotdSal := nToddJud := 0
				nLi += 3
			Endif
		Endif
		
	Enddo
Else
	For i := 1 To Len(aRdas)
		If (aRdas[i, 11] + aRdas[i, 02] + aRdas[i, 13] + aRdas[i, 03] + aRdas[i, 10] +;
			aRdas[i, 04] + aRdas[i, 14] + aRdas[i, 07] + aRdas[i, 09] + aRdas[i, 08] +;
			aRdas[i, 15] + aRdas[i, 16] + aRdas[i, 22] + aRdas[i, 23]) > 0
			
			
			// Controle de saldo de pagina...
			If  nli > nLinPag
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
			Endif
			
			If nTipRel == 1		// Analitico...
				@ nLi, 000 Psay aRdas[i, 01] + '-' + Substr(aRdas[i, 19], 1, 20)
			Else
				@ nLi, 000 Psay aRdas[i, 20] + '-' + Substr(aRdas[i, 21], 1, 20)
			Endif

			@ nLi, 030 Psay Transform(aRdas[i, 11], pMoeda2); nTotInf	+= aRdas[i, 11]
			@ nLi, 047 Psay Transform(aRdas[i, 02], pMoeda2); nTotBru	+= aRdas[i, 02]
			@ nLi, 064 Psay Transform(aRdas[i, 13], pMoeda1); nTotTxa	+= aRdas[i, 13]
			@ nLi, 077 Psay Transform(aRdas[i, 03], pMoeda1); nTotIrf 	+= aRdas[i, 03]
			@ nLi, 090 Psay Transform(aRdas[i, 10], pMoeda1); nTotIss	+= aRdas[i, 10]
			@ nLi, 103 Psay Transform(aRdas[i, 04], pMoeda1); nTotIns	+= aRdas[i, 04]
			@ nLi, 116 Psay Transform(aRdas[i, 14], pMoeda1); nTotAdt	+= aRdas[i, 14]
			@ nLi, 129 Psay Transform(aRdas[i, 07], pMoeda1); nTotPis	+= aRdas[i, 07]
			@ nLi, 144 Psay Transform(aRdas[i, 09], pMoeda1); nTotCSL	+= aRdas[i, 09]
			@ nLi, 154 Psay Transform(aRdas[i, 08], pMoeda1); nTotCof	+= aRdas[i, 08]
			@ nLi, 166 Psay Transform(aRdas[i, 15], pMoeda1); nTotTar	+= aRdas[i, 15]
			@ nLi, 178 Psay Transform(aRdas[i, 23], pMoeda1); nTotJud	+= aRdas[i, 23]
			
			@ nLi, 190 Psay Transform(aRdas[i, 16], pMoeda2); nTotLiq 	+= aRdas[i, 16]
			@ nLi, 205 Psay Transform(aRdas[i, 22], pMoeda2); nTotSal 	+= aRdas[i, 22]
			nLi++
		Endif
	Next
Endif
         
// Impressao dos valores totais...
If nOrdem <> 3 .or. (nOrdem == 3 .and. nDias > 1)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais do relatorio...                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	@ nLi, 000 Psay Replicate('-', nLimite)
	nLi++

	@ nLi, 000 Psay "Totais Gerais"
	@ nLi, 030 Psay Transform(nTotInf, pMoeda2)
	@ nLi, 047 Psay Transform(nTotBru, pMoeda2)
	@ nLi, 064 Psay Transform(nTotTxa, pMoeda1)
	@ nLi, 077 Psay Transform(nTotIrf, pMoeda1)
	@ nLi, 090 Psay Transform(nTotIss, pMoeda1)
	@ nLi, 103 Psay Transform(nTotIns, pMoeda1)
	@ nLi, 116 Psay Transform(nTotAdt, pMoeda3)
	@ nLi, 129 Psay Transform(nTotPis, pMoeda1)
	@ nLi, 144 Psay Transform(nTotCSL, pMoeda1)
	@ nLi, 154 Psay Transform(nTotCof, pMoeda1)
	@ nLi, 166 Psay Transform(nTotTar, pMoeda1)
	@ nLi, 178 Psay Transform(nTotJud, pMoeda1)
	@ nLi, 190 Psay Transform(nTotLiq, pMoeda2)
	@ nLi, 205 Psay Transform(nTotSal, pMoeda2)
Endif
                                                                               	
If nOrdem == 3
	TRB1->( dbCloseArea() )
	
	FErase(cArqTRB  + ".DBF")
	FErase(cInd1TRB + OrdBagExt())
	FErase(cInd2TRB + OrdBagExt())
Endif
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodade padrao                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo de trabalho                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbBAU->(DbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	OurSpool(nrel)
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  admin	³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}

aadd(aRegs,{cPerg,"01","Operadora"              ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","RDA De"                 ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"03","RDA Ate"                ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"04","Ano Base"               ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"05","Mes Base"               ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"06","Tipo Relatorio"         ,"","","mv_ch6","N", 1,0,0,"C","","mv_par06","Analitico"   ,"","","","","Sintetico"      ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"07","Classes RDA"            ,"","","mv_ch7","C",30,0,0,"G","","mv_par07",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"08","Numero do Lote Pagto   ","","","mv_ch8","C",10,0,0,"G","","mv_par08",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"09","Grupo de pegamento"     ,"","","mv_ch9","C",30,0,0,"G","","mv_par09",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BRZPLS",""})
		                                                                                                                                                                   
PlsVldPerg( aRegs )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetMesAno      ºAutor ³Paulo Carnelossi  º Data ³ 09/01/04  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna Mes/Ano                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function	RetMesAno(cAnoMes)
Static aMeses := {"Jan","Fev","Mar","Abr","Mai","Jun",;
					"Jul", "Ago", "Set", "Out", "Nov", "Dez"}
Local cString := ""					

If Val(Right(cAnoMes,2)) > 0 .And. Val(Right(cAnoMes,2)) <= 12
    cString := aMeses[Val(Right(cAnoMes,2))]+"/"+Left(cAnoMes,4)
Else
    cString := Right(cAnoMes,2)+"/"+Left(cAnoMes,4)
EndIf

Return(cString) 