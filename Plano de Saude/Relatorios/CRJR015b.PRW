#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR014 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 17.03.09 ³±±±
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
±±³CRJR014   ³      ³Jean         ³Criado relatorio baseado no CRJR012    ³±±±
±±³          ³      ³             ³para corrigir problemas no original.   ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRJR015b()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCentury      := __setcentury()
PRIVATE cRelDir     := GetMv("MV_RELT")
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR015"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Pagamentos"
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CR0115"
PRIVATE nRel        := "CRJR015"
PRIVATE m_pag       := 1      

PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {} //"Codigo RDA","Nome da RDA","Data da baixa"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "RDA                                                Vlr Informado      Vlr Bruto               Tx Admin            IRRF         ISS Cr.           INSS           Vlr Adiant.           PIS         CSL         Cofins          Tarifa         Liquido"
PRIVATE cCabec2     := ""
PRIVATE nLi         := 0
PRIVATE nLinPag     := 60
PRIVATE pMoeda1     := "@E 9,999,999.99"
PRIVATE pMoeda2     := "@E 999,999,999.99"
PRIVATE pMoeda3     := "@E 9,999,999.99"
PRIVATE nTamDes     := 35  
PRIVATE stop        := " "
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
PRIVATE nTipRel
   

private nTotInfc := 0
private nTotBruc := 0
private nTotTxac := 0
private nTotIrfc := 0
private nTotIssc := 0
private nTotInsc := 0
private nTotAdtc := 0
private nTotPisc := 0
private nTotCofc := 0
private nTotTarc := 0
private nTotJudc := 0
private nTotLiqc := 0
private nTotSalc := 0
private nTotCSLc := 0

private nOutImp	:= 	0

private nTotInf	:= 0
private nTotBru	:= 0
private nTotTxa	:= 0
private nTotIrf := 0
private nTotIss	:= 0
private nTotIns	:= 0
private nTotAdt	:= 0
private nTotPis	:= 0
private nTotCSL	:= 0
private nTotVlr := 0
private nTotCof	:= 0
private nTotTar	:= 0
private nTotJud	:= 0
private nTotLiq := 0
private nTotSal	:= 0

private nTotdInf	:= 0
private nTotdBru	:= 0
private nTotdTxa	:= 0
private nTotdIrf    := 0
private nTotdIss	:= 0
private nTotdIns	:= 0
private nTotdAdt	:= 0
private nTotdPis	:= 0
private nTotdCSL	:= 0
private nTotdVlr    := 0
private nTotdCof	:= 0
private nTotdTar	:= 0
private nTotdJud	:= 0
private nTotdLiq    := 0
private nTotdSal	:= 0
private nPsInf	    := 0

private nTotGer     := 0
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
dDataDe   := mv_par04
dDataAte  := mv_par05
cClaPre   := mv_par06
cNumFat   := mv_par07
cGruPag   := mv_par08
nTipRel	  := mv_par09 //1=baixados
nSintAnl  := mv_par10 //1=Sintetico / 2=Analitico / 3 = Sup.Analitico
nTipRel   := 2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

nTipQbc := aReturn[8]

cTitulo := AllTrim(cTitulo) + " - " + "De "+dtoc(dDataDe) + " Ate "+dtoc(dDataAte)
If nSintAnl = 1
   cCabec1 := "Grupo de pagamento           INSS Empresa           Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS        CSLL        Cofins       Tarifa       Bx Jud         Liquido      Saldo"
ElseIf nSintAnl = 2
   cCabec1 := "Codigo Nome                  INSS Empresa           Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS        CSLL        Cofins       Tarifa       Bx Jud         Liquido      Saldo"    
    Else
   cCabec1 := "Cd.Rda Prf.  Num.    Parc.   Tipo   INSS Empresa      Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL       Cofins       Tarifa       Bx Jud         Liquido      Saldo"
// cCabec1 := "Cod.Rda Prf. Num.  Parc. Tipo  INSS Empresa         Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido           Saldo"
   EndIf   
//EndIf   
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

LOCAL aPsInf	:= {}
Local aCampoTRB := {	{ "TRB_CODIGO"   	, "C", TamSX3("BAU_CODIGO")[1]  , 0 },;
					    { "TRB_NOME" 		, "C", TamSX3("BAU_NOME")[1]	, 0 },;   	 
					   	{ "TRB_PREF"        , "C", TamSX3("E2_PREFIXO")[1]  , 0 },;
					    { "TRB_NUM" 		, "C", TamSX3("E2_NUM")[1]	    , 0 },;
				      	{ "TRB_PARC"	    , "C", TamSX3("E2_PARCELA")[1]  , 0 },;
				        { "TRB_TIPOE2"		, "C", TamSX3("E2_TIPO")[1]	    , 0 },;
						{ "TRB_GRPPAG"		, "C", TamSX3("BAU_GRPPAG")[1]  , 0 },;
						{ "TRB_DESGRP"		, "C", 20						, 0 },;
						{ "TRB_ANO" 		, "C", 4	                    , 0 },;
						{ "TRB_MES"			, "C", 2	                    , 0 },;
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
		   				{ "TRB_INSSEM"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
			   			{ "TRB_VLRBRT"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
				   		{ "TRB_VLRTAX"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
					   	{ "TRB_VLRADT" 	    , "N", TamSX3("BM1_VALOR")[1]	, 2	},;
   						{ "TRB_VLRTAR" 	    , "N", TamSX3("BM1_VALOR")[1]	, 2	},;
	   					{ "TRB_VLRJUD" 	    , "N", TamSX3("BM1_VALOR")[1]	, 2	},;						
		   				{ "TRB_VLRLIQ"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
			   			{ "TRB_SALDO"		, "N", TamSX3("BM1_VALOR")[1]	, 2	}}

/*
Local aCmpTRB2:={	    { "TR2_PREFIXO"     , "C", TamSX3("E2_PREFIXO")	, 0 },;
						{ "TR2_NUM" 		, "C", TamSX3("E2_NUM")	    , 0 },;
						{ "TR2_PARCELA"	    , "C", TamSX3("E2_PARCELA")	, 0 },;
						{ "TR2_TIPO"		, "C", TamSX3("E2_TIPO")	, 0 },;
						{ "TR2_IRRF"		, "N", TamSX3("E2_VALOR")	, 2 },;
						{ "TR2_INSS"		, "N", TamSX3("E2_VALOR")	, 2 },;
						{ "TR2_ACRESC"		, "N", TamSX3("E2_VALOR")	, 2	},;
						{ "TR2_DCRESC"		, "N", TamSX3("E2_VALOR")	, 2 },;
						{ "TR2_PIS" 		, "N", TamSX3("E2_VALOR")	, 2 },;
						{ "TR2_COFINS"		, "N", TamSX3("E2_VALOR")	, 2	},;
						{ "TR2_CSLL" 		, "N", TamSX3("E2_VALOR")	, 2	},;
						{ "TR2_ISS"			, "N", TamSX3("E2_VALOR")	, 2	},;
						{ "TR2_VLRBRT"		, "N", TamSX3("E2_VALOR")	, 2	},;
						{ "TR2_SALDO"		, "N", TamSX3("E2_VALOR")	, 2	}}
						
*/
						
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
PRIVATE cRdaAnt     := ""
Private aRdas       := {}
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
cTitulo := AllTrim(cTitulo)
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

cSQL := " SELECT bau.R_E_C_N_O_ BAU_RECNO FROM " + RetSQLName("BAU") +" BAU  " 
cSQL += "  WHERE BAU_FILIAL  = '" + xFilial("BAU") + "' "
cSQL += "    AND BAU_CODIGO >= '" + cRdaDe    + "' AND BAU_CODIGO <= '" + cRdaAte    + "'"   
If !Empty(cGruPag)
	cSql += " AND  BAU_GRPPAG = '"+cGruPag+"' "
Endif                                                   
cSQL += " AND BAU.D_E_L_E_T_ = ' ' "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena de acordo com a configuracao de impressao...                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL += "ORDER BY BAU_NOME "

PLSQUERY(cSQL,"TrbBAU")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampoTRB, .T.)
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

/*
cArqTRB2 := CriaTrab(aCmpTRB2, .T.)
dbUseArea(.T.,,cArqTRB2,"TRB2",.F.)

MsgAlert(cArqTRB2)
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)
If nSintAnl = 1
   IndRegua("TRB1",cInd1TRB,"dTos(TRB_BAIXA) + TRB_ANO + TRB_MES",,,"Indexando Arquivo de Trabalho")
ElseIf nSintAnl = 2
      IndRegua("TRB1",cInd1TRB,"dTos(TRB_BAIXA) + TRB_ANO + TRB_MES + TRB_CODIGO",,,"Indexando Arquivo de Trabalho")
   else    
      IndRegua("TRB1",cInd1TRB,"dTos(TRB_BAIXA) + TRB_ANO + TRB_MES + TRB_CODIGO + TRB_PREF + TRB_NUM + TRB_PARC + TRB_TIPOE2",,,"Indexando Arquivo de Trabalho")
   EndIf
//EndIf
TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
TRB1->( dbSetorder(01) )
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
	If  !Empty(cClaPre) .and. ! BAU->BAU_TIPPRE $ cClaPre
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

	
	cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
	cSQL += "  FROM " + RetSQLName("SE2")
	cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
	// Indica que o titulo eh originado de pagamento medico.
	cSQL += "    AND E2_PLOPELT = '" + cCodOpe + "' "
	cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
	cSQL += "    AND E2_baixa <> ' ' "
	cSQL += "    AND E2_baixa >=  '" + DtoS(dDataDe) + "'" 
	
	//Pesquiza de erro por titulos                  
   //	cSQL += "    AND E2_PREFIXO = 'HOS' AND E2_NUM IN ('000000805' , '000000807')
    //

	// ordens pela data da baixa.
	cSQL += "    AND D_E_L_E_T_ = ' ' "
	cSQL += " ORDER BY E2_BAIXA "
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa query                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSQUERY(cSQL,"Trb") 
	If ! Trb->(eof())
     	MsProcTxt("Imprimindo... " + Left(AllTrim(BAU->BAU_NOME),30))
	    ProcessMessages()    
    EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa arquivo de trabalho                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lLock := .F.
	While ! Trb->(eof())     
	

		// Posiciona o titulo fisicamente no SE2.
		SE2->(dbGoTo(Trb->E2_RECNO))

		// Ignora os titulos de impostos
		If (SE2->E2_TIPO == MVINSS .And. ;
			IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
			SE2->E2_TIPO == MVTAXA .or. SE2->E2_TIPO == 'PA'
			
			Trb->(dbSkip())
			Loop
		Endif
		// Processa as baixas.  
		nVlrPAA		:= 0
		nVlrPA 		:= 0
		nVlrJd 		:= 0
		nVlrBx 		:= 0 
		nVlrAberto	:= 0
		nVlrBxAnt	:= 0
		nVlrPAAnt	:= 0
		nVlrJdAnt	:= 0        
		dDatBxAnt	:= cTod('') 
		nDtBx		:= cTod('') 
		nVlrbxPar	:= 0
		nVlrPAPar 	:= 0
		nVlrJdPar 	:= 0
		
		
		
		If SE5->( MsSeek(xFilial("SE5")+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA) )
				
			While !SE5->( Eof() ) .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA ==;
										SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
		
				// Ignora descontos, juros, cancelamentos, recebimentos e outros tipos...
				If SE5->E5_RECPAG == 'R' .or.;
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
				cQuery += "E5_DATA <= '"+DtoS(dDataAte)+"' AND "
				cQuery += "D_E_L_E_T_<>'*'"
				PlsQuery(cQuery, "EST")
				                                                            
                nVlrEst := EST->ESTORNO 
    			EST->( dbCloseArea() )

				// Filtra datas dos parametros...			
				If !(dTos(SE5->E5_DATA) >=  dTos(dDataDe) .and. dTos(SE5->E5_DATA) <=  dTos(dDataAte))
				
					// Se a data da baixa for posterior a data final do relatorio, o titulo sera considerado como em aberto.
					If SE5->E5_DATA > dDataAte .and. SE2->E2_EMISSAO <= dDataAte
						nVlrAberto += SE5->E5_VALOR
						nVlrAberto -= nVlrEst
					Endif               
					

					//Jean - Criado novo trecho para permitir obter valores anteriores as datas
					// Se for PA, acumular na matriz neste ponto e descarregar depois...
					If SE5->E5_DATA < dDataDe 
						If Alltrim(SE5->E5_TIPODOC) == 'CP' .and. Alltrim(SE5->E5_MOTBX) == 'CMP' 
							nVlrPAAnt += SE5->E5_VALOR
							nVlrPAAnt -= nVlrEst // Diminui o valor do estorno se houver
							                                  
						// Desconto por motivo judicial..
						Elseif Alltrim(SE5->E5_MOTBX) == 'DPJ'
							nVlrJdAnt += SE5->E5_VALOR
							nVlrJdAnt -= nVlrEst //' Diminui o valor do estorno se houver
	
						//Somar valor baixado parcial, caso ocorra...
						Else
							nVlrBxAnt += SE5->E5_VALOR
							nVlrBxAnt -= nVlrEst
							dDatBxAnt := Iif(dDatBxAnt < SE5->E5_DATA .And. SE5->E5_DATA <= dDataAte,SE5->E5_DATA,dDatBxAnt)
						Endif	
					Endif
		
					SE5->( dbSkip() )
					nVlrEst:=0
					Loop     
					
				Endif				
								
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
//   tratamento para considerar liquidaçoes por compensacoes e/ou baixa                      
//	if  (nVlrBx <> 0 .AND. (Alltrim(SE5->E5_TIPODOC) <> 'CP'  .and. Alltrim(SE5->E5_MOTBX) <> 'CMP' .and. ;
//     			    Alltrim(SE5->E5_MOTBX)   <> 'BNF' .and. Alltrim(SE5->E5_MOTBX) <> 'DPJ')) .or. ;
//     			    ((nVlrBx + nVlrJd + nVlrPA + nVlrPAAnt + nVlrJdAnt + nVlrBxAnt ) < se2->e2_valor)

				if  (nVlrBx <> 0 .AND. (Alltrim(SE5->E5_TIPODOC) <> 'CP'  .and. Alltrim(SE5->E5_MOTBX) <> 'CMP' .or. ;
     			    Alltrim(SE5->E5_MOTBX)   <> 'BNF' .or. Alltrim(SE5->E5_MOTBX) <> 'DPJ')) .or. ;
     			    ((nVlrBx + nVlrJd + nVlrPA + nVlrPAAnt + nVlrJdAnt + nVlrBxAnt + SE2->E2_DECRESC ) >= se2->e2_valor) 
     			    if (nVlrBx +  nVlrPA + nVlrPAAnt +  nVlrBxAnt + nVlrJd) > 0
  				        nDtBx := SE5->E5_DATA                                   
  				        FGravaTrb()                             
                        nVlrBx := (nVlrBx + nVlrJd + nVlrPA)
  					    if  nVlrBx  < se2->e2_valor 
  					        nVlrPA := (nVlrBx - nVlrJd ) 
  					        nVlrBx := 0 
  					        nVlrAberto := 0
  					    endif 
  					endif       
				Endif
				SE5->( dbSkip() )
				nVlrEst:=0
			Enddo
            //   FGravaTrb()                             
		Else	// Se entrar aqui, eh porque nao existe baixa, consequentemente o titulo esta em aberto.
			/*
			Jota! diz:
				se o titulo estiver em aberto, o que devo considerar mesmo ?
				A data de emissao deve estar entre a data "de/ate"  ?
				e isso mesmo ?
				
			Jean diz:
				se estiver em aberto, deve-se verificar se a emissão foi ATE a data final
			*/

			If SE2->E2_EMISSAO <= dDataAte
				nVlrAberto += SE2->(E2_VALOR)
			Endif
		   // FGravaTrb()                         
		Endif
     
    Trb->(dbSkip())
	
	Enddo
	
	Trb->(dbCloseArea())
		
	// Libera registro do arquivo temporario...         
	TRB1->( MsUnlock() )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa proximo registro                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TrbBAU->(DbSkip())
Enddo
FImprime()

Static Function	FImprime()
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

Local cComp := " " //  Marcela Coimbra - Ajuste de Impressao. Data 08/04/10
    
// Inicio da impressao dos dados...
MsProcTxt("Aguarde... gerando impressao!")
ProcessMessages()
lMostraImp := .F.
nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
TRB1->( dbSetorder(01) )	
TRB1->( dbGotop() )
	     
// Variavel que ira controlar quantas quebras por baixa foram impressas. Caso seja impresso apenas uma, nao sera 
// preciso imprimir o total, pois o valor total sera o mesmo impresso no total da quebra do dia. Tendeu ?
nDias := 0

cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES))// Marcela Coimbra - Ajuste de Impressao. Data 08/04/10

While !TRB1->( Eof() )

	//Jean - controle para evitar impressao de titulos que nao atendam ao 
	//novo parametro do relatorio (1-abertos/2-baixados)
	
	If nTipRel == 1
		If dTos(TRB1->TRB_BAIXA)<> "19600101" 
			TRB1->(DbSkip())
			Loop
		Endif
	Else
		If dTos(TRB1->TRB_BAIXA)== "19600101" 
			TRB1->(DbSkip())
			Loop
		Endif	
	Endif
	
	cBaixa 	:= dTos(TRB1->TRB_BAIXA)
	cRDA	:= TRB1->TRB_CODIGO
	
	nDias ++
	lFirst := .T.                                              
	
	While !TRB1->( Eof() ) .and. dTos(TRB1->TRB_BAIXA) == cBaixa
		If TRB1->(	TRB_IRRF   + TRB_INSS   + TRB_ACRESC + TRB_DCRESC +;
					TRB_PIS	  + TRB_COFINS + TRB_CSLL   + TRB_ISS    + TRB_VLRBRT +;
					TRB_VLRTAX+ TRB_VLRTAR + TRB_VLRADT + TRB_VLRLIQ + TRB_INSSEM ) <> 0
					
	 /*		if dTos(TRB1->TRB_BAIXA)	= "20090831'
			   ok:= ' ' 
			endif   	   
	 */	
			// Controle de saldo de pagina...
			If  nli > nLinPag
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nLi++ 
		
				@ nLi, 000 Psay "Data Pagamento: " + Iif(dTos(TRB1->TRB_BAIXA)<>"19600101", dToc(TRB1->TRB_BAIXA), "Em Abertos - Considerando titulos com data de emissão até o dia: "+dToc(dDataAte))
				nli += 2
				                                            
				@ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
				nli++                                   
				 
				// cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES)) //  Marcela Coimbra - Ajuste de Impressao. Data 08/04/10
				lFirst := .F.
			Endif
			     
			// Impressao dos detalhes de cabecalho
			If lFirst 
				// Controle de saldo de pagina...
				If  nli > (nLinPag - 4)
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nLi++ 			
				Endif
				@ nLi, 000 Psay "Data Pagamento: " + Iif(dTos(TRB1->TRB_BAIXA)<>"19600101", dToc(TRB1->TRB_BAIXA), "Em Abertos - Considerando titulos com data de emissão até o dia: "+dToc(dDataAte))
				nli += 1
            
				@ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
				nli++                                   
				
				lFirst := .F.
			Endif
			
			If cComp <> Alltrim(TRB1->(TRB_ANO+TRB_MES)) // quebra por competencia...
				nLi ++
				
				If nli > nLinPag // Preteje quebra de pagina...
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nLi++ 
				Endif                        
				
			 //	If cComp <> Alltrim(TRB1->(TRB_ANO+TRB_MES)) 
			 
			    FTotComp()

				@ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
				  nli++                                   
					
				cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES))
			Endif								
		Endif			
			
//			@ nLi, 000 Psay TRB1->(TRB_ANO+"-"+TRB_MES)	//TRB1->TRB_GRPPAG + '-' + SubStr(TRB1->TRB_DESGRP, 1, 20)

/*
         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Analitico
Codigo - Nome RDA.             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido          Saldo"
000000-00000000000000000000   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99  999,999.99  999,999.99  999,999.99  99,999,999.99  99,999,999.99
*/			
//Jean - comentado para testes..
/*
			@ nLi, 030 Psay Transform(Iif(lMostraImp,TRB1->TRB_INSSEM,0)	, pMoeda2); nTotInf	+= Iif(lMostraImp,TRB1->TRB_INSSEM,0); nTotdInf += Iif(lMostraImp,TRB1->TRB_INSSEM,0)
			@ nLi, 047 Psay Transform(TRB1->TRB_VLRBRT	, pMoeda2); nTotBru	+= TRB1->TRB_VLRBRT	; nTotdBru += TRB1->TRB_VLRBRT
			@ nLi, 064 Psay Transform(TRB1->TRB_VLRTAX	, pMoeda1); nTotTxa	+= TRB1->TRB_VLRTAX	; nTotdTxa += TRB1->TRB_VLRTAX
			@ nLi, 077 Psay Transform(Iif(lMostraImp,TRB1->TRB_IRRF,0)	, pMoeda1); nTotIrf	+= Iif(lMostraImp,TRB1->TRB_IRRF,0)	; nTotdIrf += Iif(lMostraImp,TRB1->TRB_IRRF,0)
			@ nLi, 090 Psay Transform(Iif(lMostraImp,TRB1->TRB_ISS,0)		, pMoeda1); nTotIss	+= Iif(lMostraImp,TRB1->TRB_ISS,0)	; nTotdIss += Iif(lMostraImp,TRB1->TRB_ISS,0)
			@ nLi, 103 Psay Transform(Iif(lMostraImp,TRB1->TRB_INSS,0)	, pMoeda1); nTotIns	+= Iif(lMostraImp,TRB1->TRB_INSS,0)	; nTotdIns += Iif(lMostraImp,TRB1->TRB_INSS,0)
			@ nLi, 116 Psay Transform(TRB1->TRB_VLRADT	, pMoeda1); nTotAdt	+= TRB1->TRB_VLRADT	; nTotdAdt += TRB1->TRB_VLRADT
			@ nLi, 129 Psay Transform(Iif(lMostraImp,TRB1->TRB_PIS,0)		, pMoeda1); nTotPis	+= Iif(lMostraImp,TRB1->TRB_PIS,0)	; nTotdPis += Iif(lMostraImp,TRB1->TRB_PIS,0)
			@ nLi, 144 Psay Transform(Iif(lMostraImp,TRB1->TRB_CSLL,0)	, pMoeda1); nTotCSL	+= Iif(lMostraImp,TRB1->TRB_CSLL,0)	; nTotdCsl += Iif(lMostraImp,TRB1->TRB_CSLL,0)
			@ nLi, 154 Psay Transform(Iif(lMostraImp,TRB1->TRB_COFINS,0)	, pMoeda1); nTotCof	+= Iif(lMostraImp,TRB1->TRB_COFINS,0)	; nTotdCof += Iif(lMostraImp,TRB1->TRB_COFINS,0)
			@ nLi, 166 Psay Transform(TRB1->TRB_VLRTAR	, pMoeda1); nTotTar	+= TRB1->TRB_VLRTAR	; nTotdTar += TRB1->TRB_VLRTAR
			@ nLi, 178 Psay Transform(TRB1->TRB_VLRJUD	, pMoeda1); nTotJud	+= TRB1->TRB_VLRJUD	; nTotdJud += TRB1->TRB_VLRJUD
*/          
nCol := 32                                          

      If nSintAnl == 2  
           
           	@ nLi, 000 Psay TRB1->TRB_CODIGO 	
			@ nLi, 008 Psay SUBSTR (TRB1->TRB_NOME, 1, 21) 
			
      Elseif nSintAnl == 3  
           	@ nLi, 000 Psay Alltrim(TRB1->TRB_CODIGO) 	
			@ nLi, 007 Psay Alltrim(TRB1->TRB_PREF)
  			@ nLi, 013 Psay Alltrim( TRB1->TRB_NUM ) 		
			@ nLi, 023 Psay Alltrim(TRB1->TRB_PARC)
			@ nLi, 026 Psay Alltrim(TRB1->TRB_TIPOE2) 				
		
			nCol := 30             
			
      nTotGer:= (TRB1->TRB_VLRBRT -TRB1->TRB_IRRF - TRB1->TRB_ISS - TRB1->TRB_INSS - TRB1->TRB_VLRADT -TRB1->TRB_PIS - TRB1->TRB_CSLL - TRB1->TRB_COFINS - TRB1->TRB_VLRTAR - TRB1->TRB_VLRJUD - TRB1->TRB_VLRLIQ - TRB1->TRB_SALDO )
     
      Endif	
			@ nLi, nCol Psay Transform(TRB1->TRB_INSSEM	, pMoeda2); nTotInf	+= TRB1->TRB_INSSEM; nTotInfc	+= TRB1->TRB_INSSEM; nTotdInf += TRB1->TRB_INSSEM
		  	nCol := nCol + 15
		  	@ nLi, nCol Psay Transform(TRB1->TRB_VLRBRT	, pMoeda2); nTotBru	+= TRB1->TRB_VLRBRT; nTotBruc	+= TRB1->TRB_VLRBRT; nTotdBru += TRB1->TRB_VLRBRT
		  	nCol := nCol + 15
		   	@ nLi, nCol Psay Transform(TRB1->TRB_VLRTAX	, pMoeda1); nTotTxa	+= TRB1->TRB_VLRTAX; nTotTxac	+= TRB1->TRB_VLRTAX; nTotdTxa += TRB1->TRB_VLRTAX
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_IRRF	, pMoeda1); nTotIrf	+= TRB1->TRB_IRRF  ; nTotIrfc	+= TRB1->TRB_IRRF  ; nTotdIrf += TRB1->TRB_IRRF
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_ISS		, pMoeda1); nTotIss	+= TRB1->TRB_ISS   ; nTotIssc	+= TRB1->TRB_ISS   ; nTotdIss += TRB1->TRB_ISS
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_INSS	, pMoeda1); nTotIns	+= TRB1->TRB_INSS  ; nTotInsc	+= TRB1->TRB_INSS  ; nTotdIns += TRB1->TRB_INSS
		  	nCol := nCol + 13
		  	@ nLi, nCol Psay Transform(TRB1->TRB_VLRADT	, pMoeda1); nTotAdt	+= TRB1->TRB_VLRADT; nTotAdtc	+= TRB1->TRB_VLRADT; nTotdAdt += TRB1->TRB_VLRADT
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_PIS		, pMoeda1); nTotPis	+= TRB1->TRB_PIS   ; nTotPisc	+= TRB1->TRB_PIS   ; nTotdPis += TRB1->TRB_PIS
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_CSLL	, pMoeda1); nTotCSL	+= TRB1->TRB_CSLL  ; nTotCSLc   += TRB1->TRB_CSLL  ; nTotdCsl += TRB1->TRB_CSLL
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_COFINS	, pMoeda1); nTotCof	+= TRB1->TRB_COFINS; nTotCofc	+= TRB1->TRB_COFINS; nTotdCof += TRB1->TRB_COFINS
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRTAR	, pMoeda1); nTotTar	+= TRB1->TRB_VLRTAR; nTotTarc	+= TRB1->TRB_VLRTAR; nTotdTar += TRB1->TRB_VLRTAR
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRJUD	, pMoeda1); nTotJud	+= TRB1->TRB_VLRJUD; nTotJudc	+= TRB1->TRB_VLRJUD; nTotdJud += TRB1->TRB_VLRJUD
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRLIQ	, pMoeda2); nTotLiq	+= TRB1->TRB_VLRLIQ	; nTotLiqc  += TRB1->TRB_VLRLIQ	; nTotdLiq += TRB1->TRB_VLRLIQ
		  	nCol := nCol + 15
			@ nLi, nCol Psay Transform(TRB1->TRB_SALDO	, pMoeda1); nTotSal	+= TRB1->TRB_SALDO	; nTotSalc  += TRB1->TRB_SALDO	; nTotdSal += TRB1->TRB_SALDO
			                                                   
		if nTotGer	> 0 
		 	@ nLi, nCol Psay Transform(TRB1->TRB_INSSEM	, pMoeda2)
		  	nCol := nCol + 15
		  	@ nLi, nCol Psay Transform(TRB1->TRB_VLRBRT	, pMoeda2)
		  	nCol := nCol + 15
		   	@ nLi, nCol Psay Transform(TRB1->TRB_VLRTAX	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_IRRF	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_ISS	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_INSS	, pMoeda1)
		  	nCol := nCol + 13
		  	@ nLi, nCol Psay Transform(TRB1->TRB_VLRADT	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_PIS	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_CSLL	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_COFINS	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRTAR	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRJUD	, pMoeda1)
		  	nCol := nCol + 13
			@ nLi, nCol Psay Transform(TRB1->TRB_VLRLIQ	, pMoeda2)
		  	nCol := nCol + 15
			@ nLi, nCol Psay Transform(TRB1->TRB_SALDO	, pMoeda1)
			nTotGer := 0
        EndIf
		nLi++ 
		 
		 
		 
		 
		 
		TRB1->( dbSkip() ) 
	
	Enddo
   	    
	// Finaliza quebra por dia da baixa imprimindo os totais do dia...
   If (nTotdInf + nTotdBru	+ nTotdTxa	+ nTotdIrf + nTotdIss +;
		nTotdIns + nTotdAdt	+ nTotdPis	+ nTotdCSL + nTotdVlr +;
		nTotdCof + nTotdTar	+ nTotdJud + nTotdLiq + nTotdSal) > 0
		nLi++ 			

		If  nli > (nLinPag - 4)
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nLi++
		Endif

    	FTotComp()
		@ nLi, 000 Psay Replicate('-', nLimite)
		nLi++    	

		If nli > nLinPag // Preteje quebra de pagina...
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nLi++ 
		Endif                                         
	    
		If cBaixa <> "19600101"
			@ nLi, 000 Psay "Totais do dia "+dToc(sTod(cBaixa))
		Else
			@ nLi, 000 Psay "Total de titulos em aberto "
		Endif           
		
		If nSintAnl == 3  
			nCol := 34
		Else
			nCol := 32
		EndIf
  
				
		@ nLi, nCol Psay Transform(nTotdInf	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotdBru	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotdTxa	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdIrf	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdIss	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdIns	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdAdt	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdPis	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdCsl	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdCof	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdTar	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdJud	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotdLiq	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotdSal	, pMoeda1)
		
		//Jean - Total geral nao deve conter o valor do total em aberto...
		If cBaixa == "19600101"
			nTotInf := nTotBru := nTotTxa := nTotIrf := nTotIss := 0
			nTotIns := nTotAdt := nTotPis := nTotCSL := nTotCof := 0
			nTotTar := nTotJud := nTotLiq := nTotSal := 0		
		Endif
	
		// Reset nas variaveis totalizadoras...
		nTotdInf := nTotdBru	:= nTotdTxa	:= nTotdIrf := nTotdIss	:= 0
		nTotdIns := nTotdAdt	:= nTotdPis	:= nTotdCSL	:= nTotdVlr := 0
		nTotdCof := nTotdTar	:= nTotdLiq := nTotdSal := nTotdJud := 0
		nLi += 3
	Endif

Enddo
         
// Impressao dos valores totais...
If nDias > 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais do relatorio...                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
    FTotComp()  
	@ nLi, 000 Psay Replicate('-', nLimite)
	nLi++

	@ nLi, 000 Psay "Totais Gerais - baixados"
	
	If nSintAnl == 3  
		nCol := 34
	Else
		nCol := 32
	EndIf
		
		@ nLi, nCol Psay Transform(nTotInf	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotBru	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotTxa	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotIrf	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotIss	, pMoeda1)  
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotIns	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotAdt	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotPis	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotCSL	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotCof	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotTar	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotJud	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotLiq	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotSal	, pMoeda1)
		
Endif
                                                                               	
TRB1->( dbCloseArea() )
//TRB2->( DbCloseArea())  



FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
		
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
Return()

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
aadd(aRegs,{cPerg,"04","Data Pagamento De"      ,"","","mv_ch4","D", 8,0,0,"G","","mv_par04",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",""   	    ,""})
aadd(aRegs,{cPerg,"05","Data Pagamento Ate"     ,"","","mv_ch5","D", 8,0,0,"G","","mv_par05",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",""   	    ,""})
aadd(aRegs,{cPerg,"06","Classes RDA"            ,"","","mv_ch6","C",30,0,0,"G","","mv_par06",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   		,""})
aadd(aRegs,{cPerg,"07","Numero do Lote Pagto"	,"","","mv_ch7","C",10,0,0,"G","","mv_par07",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   		,""})
aadd(aRegs,{cPerg,"08","Grupo de pegamento"     ,"","","mv_ch8","C",30,0,0,"G","","mv_par08",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BRZPLS"     ,""})
Aadd(aRegs,{cPerg,"09","Tipo Relatorio?  "		,"","","mv_ch9","N",01,0,0,"C","","mv_par09","Baixados"    ,"","","","",""               ,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""			,""})      
Aadd(aRegs,{cPerg,"10","Sintet/Analit.?  "		,"","","mv_ch10","N",01,0,0,"C","","mv_par10","Sintetico"  ,"","","","","Analitico"      ,"","","","","Sup. Analitico" ,"","","","",""					  ,"","","","","","","","",""			,""})
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

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³tot_competencia Autor ³altamiro          º Data ³ 09/01/04  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna Mes/Ano                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function	FTotComp()

If nSintAnl <> 1
   If (nTotBruc > 0) 
   
     @ nLi, 000 Psay "Totais da competencia "   

	If nSintAnl == 3  
		nCol := 34
	Else
		nCol := 32
	EndIf                          

		@ nLi, nCol Psay Transform(nTotInfc	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotBruc	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotTxac	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotIrfc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotIssc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotInsc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotAdtc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotPisc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotCSLc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotCofc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotTarc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotJudc	, pMoeda1)
		nCol := nCol + 13
		@ nLi, nCol Psay Transform(nTotLiqc	, pMoeda2)
		nCol := nCol + 15
		@ nLi, nCol Psay Transform(nTotSalc	, pMoeda1)
		
	 nli++   
	 nli++       
	 
	 nTotInfc := 0
     nTotBruc := 0
     nTotTxac := 0
     nTotIrfc := 0
     nTotIssc := 0
     nTotInsc := 0
     nTotAdtc := 0
	 nTotPisc := 0
	 nTotCofc := 0
	 nTotTarc := 0
	 nTotJudc := 0
	 nTotLiqc := 0
	 nTotSalc := 0
	 nTotCSLc := 0

   EndIf
EndIf                             
Return()                   

Static Function	FGravaTrb()      
Local lContrRet	:=	!Empty(SE2->(FieldPos("E2_VRETPIS"))) .And. !Empty(SE2->(FieldPos("E2_VRETCOF"))) .And. ; 
					!Empty(SE2->(FieldPos("E2_VRETCSL"))) .And. !Empty(SE2->(FieldPos("E2_PRETPIS"))) .And. ;
					!Empty(SE2->(FieldPos("E2_PRETCOF"))) .And. !Empty(SE2->(FieldPos("E2_PRETCSL")))
Local lparc 	:= .F.						
/* 
If nTipRel == 3 //Mostrar os com baixa parcial .. 
   If (!(dTos(SE2->E2_BAIXA) >=  dTos(dDataDe) .and. dTos(SE2->E2_BAIXA) <=  dTos(dDataAte)) .or. ((SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) <= 0 ) .or. (Alltrim(SE5->E5_TIPODOC) == 'CP' .and. Alltrim(SE5->E5_MOTBX) == 'CMP') )
      return ()
	//		Loop	     		
   endif 
else
   If nTipRel == 2
      if(SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 
		return () 
      endif    
   endif    
endif        
*/
// Pra agilizar.  
/*                          
If !Empty(DTOS(SE2->E2_BAIXA)) .OR. (SE2->E2_ANOBASE + SE2->E2_MESBASE)<> '200708'
  	Trb->(dbSkip())
	Loop
Endif
*/
// Se o titulo não for considerado um titulo em aberto e tambem não estiver baixado, devo ignorar este
// titulo no relatorio.         
// Em 23/03/09, alterado para demonstrar tambem titulos baixados por compensacao...
//If (nVlrAberto + nVlrBx) <= 0
  If (nVlrAberto + nVlrBx + nVlrPA + nVlrJd) <= 0 
      return ()
//		Trb->(dbSkip())
//	    Loop
  ELSE	                   		
//Jean - somar o valor das baixas PA anteriores e baixas judiciais anteriores...
	   nVlrPAA += nVlrPA
	   nVlrPA  += nVlrPAAnt
	   nVlrJd  += nVlrJdAnt
// So ira processar o BD7 caso exista titulo a receber... ganho de performance...
       nVlrTax := 0
	   If !Trb->( Eof() )
	       cSql := "SELECT BD7_BLOPAG, BD7_SITUAC, BD7_FASE, BD7_VLTXPG FROM "+RetSqlName("BD7")+" WHERE BD7_FILIAL =  '"+xFilial("BD7")+"' "
		   cSql += "AND BD7_CODOPE = '" + cCodOpe +"' "
	       cSql += "AND BD7_OPELOT = '" + cCodOpe +"' "
		   cSql += "AND BD7_NUMLOT = '"+SE2->E2_PLLOTE+"' "
		   cSql += "AND BD7_CODRDA = '" + BAU->BAU_CODIGO + "' "
		   cSql += "AND D_E_L_E_T_ = ' ' "
		   PLSQUERY(cSQL,"TRBBD7")      
	       While !TRBBD7->( Eof() )
   	     	  IF (TRBBD7->BD7_BLOPAG <> '1' .and. !(TRBBD7->BD7_SITUAC $ '3,2') .and. TRBBD7->BD7_FASE = '4' .and. TRBBD7->BD7_VLTXPG > 0)
			      nVlrTax += TRBBD7->BD7_VLTXPG
			  Endif 
		          TRBBD7->(dbSkip())          	          	
		   enddo	
		   TRBBD7->( dbCloseArea() )	
		      Endif
	       dDataBaixa := cTod('') // Data da baixa

		//Jean - em 09/04/09, alterada a linha para interpretar que 
		//titulos baixados por adiantamento ou em aberto...
		//Jean - cfme solicitacao de Bira, alterar o relatorio para apresentar
		//titulos com baixa parcial tanto no relatorio em aberto qto no baixados..
		//If Empty(dTos(SE2->E2_BAIXA)) .or. nVlrAberto > 0
    	 		
		   If nTipRel == 1 //Mostrar os em aberto...
		      If Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 ) 
			     dDataBaixa := cTod("01/01/60")			
		      Else
				dDataBaixa := SE2->E2_BAIXA
		      Endif
	       Else
			    //Caso houver alguma baixa, e o parametro for para listar os baixados,
			    //deve-se demonstrar o titulo como dt de baixa parcial.
		    	If Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 ) 
	 		   ///altamiro 24-07-09             
                   if  nVlrAberto = 0   
                       nVlrAberto := ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC))               
                   endif
               ///////////////////    

					If !Empty(dTos(nDtBx)) .And. (nDtBx >= dDataDe .And. nDtBx <= dDataAte )
						dDataBaixa := nDtBx     
						
					Else		
						dDataBaixa := cTod("01/01/60")			
					Endif
		     	Else
				    dDataBaixa := SE2->E2_BAIXA
		     	Endif

		
		   Endif
   	    If nSintAnl = 1
			lFound := TRB1->( MsSeek(dTos(dDataBaixa)+SE2->E2_ANOBASE+SE2->E2_MESBASE ) ) 
		ElseIf nSintAnl = 2
		       lFound := TRB1->( MsSeek(dTos(dDataBaixa)+SE2->E2_ANOBASE+SE2->E2_MESBASE+BAU->BAU_CODIGO) )
		    Else                                                                                           
		       lFound := TRB1->( MsSeek(dTos(dDataBaixa)+SE2->E2_ANOBASE+SE2->E2_MESBASE+BAU->BAU_CODIGO+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO) )
		    Endif	       
        endif
	    	TRB1->( RecLock("TRB1", !lFound) )
			
			// Grava campos que compoem a chave de pesquisa.
			If !lFound
				TRB1->TRB_CODIGO 	:= BAU->BAU_CODIGO
				TRB1->TRB_NOME		:= BAU->BAU_NOME
				TRB1->TRB_GRPPAG	:= BAU->BAU_GRPPAG
				TRB1->TRB_DESGRP	:= cDesGrp
				TRB1->TRB_ANO		:= SE2->E2_ANOBASE
				TRB1->TRB_MES		:= SE2->E2_MESBASE
				TRB1->TRB_TIPO		:= BAU->BAU_TIPPE
				TRB1->TRB_BAIXA	    := dDataBaixa
                TRB1->TRB_PREF      := SE2->E2_PREFIXO
                TRB1->TRB_NUM 		:= SE2->E2_NUM
				TRB1->TRB_PARC      := SE2->E2_PARCELA
				TRB1->TRB_TIPOE2    := SE2->E2_TIPO				
			Endif
			//Jean - alterado linha para testar E2_BAIXA, e resolver o problema
			//relativo aos NDFs duplicados...

			nValor := SE2->E2_VALOR 

			If  empty(SE2->E2_PARCELA) // indica que eh o titulo principal
				
				If  SE2->E2_TIPO == "NDF" // .And. !Empty(SE2->(E2_BAIXA))
					nValor := nValor * -1
				Endif          
				
			nOutImp := IIf(lContrRet, SE2->(E2_VRETPIS+E2_VRETCOF+E2_VRETCSL), SE2->(E2_PIS+E2_COFINS+E2_CSLL) ) + SE2->E2_ISS
				
				//JEAN - Conforme Ubiratan em 07/04/09, nao deverao ser apresentados os impostos
 				//para titulos baixados parcialmente. 				
            	//lMostraImp := Iif(nVlrAberto > 0, .F., .T.)
			  
				lMostraImp := Iif (Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 ), .F., .T.) 
			
				TRB1->TRB_IRRF		+= Iif(lMostraImp,SE2->E2_IRRF,0)
				TRB1->TRB_INSS		+= Iif(lMostraImp,IIf(SE2->E2_TIPO == MVINSS, nValor, SE2->E2_INSS),0)
				TRB1->TRB_ACRESC	+= SE2->E2_ACRESC
				TRB1->TRB_DCRESC	+= SE2->E2_DECRESC
				TRB1->TRB_PIS		+= Iif(lMostraImp,IIf(lContrRet, SE2->E2_VRETPIS, SE2->E2_PIS),0)
				TRB1->TRB_COFINS	+= Iif(lMostraImp,IIf(lContrRet, SE2->E2_VRETCOF, SE2->E2_COFINS),0)
				TRB1->TRB_CSLL		+= Iif(lMostraImp,IIf(lContrRet, SE2->E2_VRETCSL, SE2->E2_CSLL),0)
				TRB1->TRB_ISS		+= Iif(lMostraImp,SE2->E2_ISS,0)
///altamiro		TRB1->TRB_VLRBRT	+= nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp  
//////  baixa parcial  ///// altmairo
                If   ((dTos(SE2->E2_BAIXA) >=  dTos(dDataDe) .and. dTos(SE2->E2_BAIXA) <=  dTos(dDataAte));
                       .and. ((SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 );
                       .and. (Alltrim(SE5->E5_TIPODOC) <> 'CP' .and. Alltrim(SE5->E5_MOTBX) <> 'CMP') )              	          	
                     TRB1->TRB_VLRBRT	:= nVlrBx     
                     lparc := .T. 
                else     
                     TRB1->TRB_VLRBRT	+= nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp       
                endif           	
				TRB1->TRB_VLRTAX	:= nVlrTax
				TRB1->TRB_VLRTAR	+= SE2->E2_DECRESC
				TRB1->TRB_VLRADT 	+= nVlrPA
				TRB1->TRB_VLRJUD	+= nVlrJd
				/*
				//Jean - Modificada a logica para obtencao de valor liquido x valor
				//baixado, devido a entrada da possibilidade de baixa parcial.
				If nVlrAberto > 0
					TRB1->TRB_VLRLIQ	+= nVlrAberto
				Else
					TRB1->TRB_VLRLIQ	+= nVlrBx
				Endif
				TRB1->TRB_SALDO	+= SE2->E2_SALDO				
				*/        
//				altamiro 29/07/09      
				nVlrAberto += SE2->E2_IRRF + SE2->E2_INSS + nOutImp                        
////////////////////////////////////				
				If  SE2->E2_TIPO == "NDF"      
				  nVlrBx     += (nVlrBx * -1)
				  nVlrAberto += (nVlrAberto * -1)
				endif
				
 				TRB1->TRB_VLRLIQ += nVlrBx 
 				
              
				If dDataBaixa == cTod("01/01/60")
				   TRB1->TRB_SALDO  += (TRB1->TRB_VLRBRT - TRB1->TRB_VLRADT - TRB1->TRB_VLRJUD)
				elseif  lparc
				   TRB1->TRB_SALDO  := 0
				   TRB1->TRB_VLRBRT := nVlrBx  
				 else
			       TRB1->TRB_SALDO += (TRB1->TRB_VLRBRT  - nVlrBx - TRB1->TRB_VLRADT - SE2->E2_IRRF - SE2->E2_INSS - nOutImp - TRB1->TRB_VLRJUD - TRB1->TRB_VLRTAR)
              	EndIf 

			
				If Alltrim(BAU->BAU_TIPPE) == "F" .and. SE2->E2_TIPO <> "NDF"  .and.  dDataBaixa <> cTod("01/01/60")	// Estrai 20% do valor total.
					// Extrai 20 do valor bruto do pagamento / Chumbado no fonte.
					nInssVal := Iif(lMostraImp,(((nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp) * 20) / 100),0)
					TRB1->TRB_INSSEM	+= nInssVal
				Endif
					
			Endif 
	
Return()
