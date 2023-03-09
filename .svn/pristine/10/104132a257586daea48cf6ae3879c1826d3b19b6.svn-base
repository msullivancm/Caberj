#include "PROTHEUS.CH"
#include "PLSMGER.CH"                                                                                                                        



#Define CRLF Chr(13)+Chr(10)
//#include "rwmake.ch"
//#include "TopConn.ch"
//#Include "Fileio.ch"
//#Include "Colors.ch"
//#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}
                                   
/*
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
*/
User Function CRJR016e()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     

Local lCentury      := __setcentury()
PRIVATE cRelDir     := GetMv("MV_RELT")
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR016c"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Eventos a Liquidar "
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CR116e" 
Private cFilePath   := GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\")+cPerg+".Xls"   
PRIVATE nRel        := "CRJR016e"
PRIVATE m_pag       := 1
PRIVATE lprim       := .T.
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {} //"Codigo RDA","Nome da RDA","Data da baixa"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "RDA                                                Vlr Informado      Vlr Bruto               Tx Admin            IRRF         ISS Cr.           INSS           Vlr Adiant.           PIS         CSL         Cofins          Tarifa         Liquido"
PRIVATE cCabec2     := " "
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E 999,999.99"
PRIVATE pMoeda2     := "@E 999,999,999.99"
PRIVATE pMoeda3     := "@E 9,999,999.99"
PRIVATE nTamDes     := 35
PRIVATE stop        := " "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCodOpe
PRIVATE cForDe
PRIVATE cForAte
PRIVATE cAno
PRIVATE cMes
PRIVATE nTipRel
PRIVATE cClaPre
PRIVATE cNumFat
PRIVATE cGruPag
PRIVATE nTipRel
PRIVATE cComp 		:= ""
private cEmpresa 	:= iif (SubStr(cNumEmp,1,2) = "01","C", "I")
private nTotInfc 	:= 0
private nTotBruc 	:= 0
private nTotTxac 	:= 0
private nTotIrfc 	:= 0
private nTotIssc 	:= 0
private nTotInsc 	:= 0
private nTotAdtc 	:= 0
private nTotPisc 	:= 0
private nTotCofc 	:= 0
private nTotTarc 	:= 0
private nTotJudc 	:= 0
private nTotLiqc 	:= 0
private nTotSalc 	:= 0
private nTotCSLc 	:= 0

private nOutImp		:= 	0

private nTotInf		:= 0
private nTotBru		:= 0
private nTotTxa		:= 0
private nTotIrf 	:= 0
private nTotIss		:= 0
private nTotIns		:= 0
private nTotAdt		:= 0
private nTotPis		:= 0
private nTotCSL		:= 0
private nTotVlr 	:= 0
private nTotCof		:= 0
private nTotTar		:= 0
private nTotJud		:= 0
private nTotLiq 	:= 0
private nTotSal		:= 0

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
private  aArray     := {}  

PRIVATE lImpZero
PRIVATE aRet 		:= {.T.,""}

private cMotBx      := ' '

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
cForDe    := mv_par02
cForAte   := mv_par03
dDataDe   := cTod("01/01/01")
dDataAte  := mv_par04
cCompDe   := substr(mv_par05,3,4)+substr(mv_par05,1,2) 
cCompAte  := substr(mv_par06,3,4)+substr(mv_par06,1,2)
nTipRel	  := mv_par07 //1=em aberto
nSintAnl  := mv_par08 //1=Sintetico / 2=Analitico / 3=SuperAnalitico
nConRda   := mv_par09 // 1 = sim / 2 = nao - considerar RDA no Relatorio
nConOpme  := mv_par10 // 1 = sim / 2 = nao - considerar Opme no Relatorio
nConRemb  := mv_par11 // 1 = sim / 2 = nao - considerar Remb no Relatorio
nConFin   := mv_par12 // 1 = sim / 2 = nao - considerar Financeiro no Relatorio   
//nConOpmS  := mv_par13 // 1 = sim / 2 = nao - considerar Opme do saude   
dDtEmiDe  := mv_par13 // data de emisao De     
dDtEmiAt  := mv_par14 // data de emisao ate    
                                                        
nGeraXls  := mv_par15 // 1 = sim / 2 = nao - Gera Xls - Arq. em Excel  

nCustrda  := mv_par16 // 1 = sim / 2 = nao - Conferir Custo  RDA 
nCustree  := mv_par17 // 1 = sim / 2 = nao - Conferir Custo  reemb   
nCustope  := mv_par18 // 1 = sim / 2 = nao - Conferir Custo  opme 

dDtvecDe  := mv_par19 // data de Vencimento  De     
dDtvecAt  := mv_par20 // data de Vencimento  Ate    
nBaixado  := mv_par21 // 1 - baixado , 2 - nao baixado , 3 - todos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

nTipQbc := aReturn[8]


If nSintAnl == 1 .AND. !empty (dDtvecDe)                                                                                                                                                                                                                                         
	cCabec1 := "                                Dt. Vencto          Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Desconto    Bx Jud        Liquido           Saldo"
ELSE	
	cCabec1 := "                                Dt. Emissao         Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Desconto    Bx Jud        Liquido           Saldo"
eNDiF

If nSintAnl <>  1 .AND. !empty (dDtvecDe)
    cCabec1 := "Cod.For Prf. Num.  Parc. Tipo   Dt. Vencto          Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Desconto    Bx Jud        Liquido           Saldo"
Else                                                                                                                                                                                                                                         
    cCabec1 := "Cod.For Prf. Num.  Parc. Tipo   Dt. Emissao         Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Desconto    Bx Jud        Liquido           Saldo"    
EndIf  

If empty (cCompAte) .and. ! empty (dDtEmiAt)                  
   MsgAlert("Relatorio Considerara a Data de Emissão  !!!!!")
   cTitulo := AllTrim(cTitulo) + " - De  Emissao " +  dtoc(dDtEmiDe) +  " - Ate a Emissao " +  dtoc(dDtEmiAt) + " e em aberto Em "+dtoc(dDataAte) 
elseIf ! empty (cCompAte)                   
   MsgAlert("Relatorio Considerara a Competencia  !!!!!") 
   cTitulo := AllTrim(cTitulo) + " - De Competencia " + substr(mv_par05,1,2)+ "/" + substr(mv_par05,3,4) +  " - Ate a Competencia " + substr(mv_par06,1,2)+ "/" + substr(mv_par06,3,4)+ " e em aberto em " + dtoc(dDataAte)
elseIf empty (cCompAte) .and. empty (dDtEmiAt)                                 
   MsgAlert("Relatorio Considerara a Competencia , mas ela esta em branco !!!!")                      
   cTitulo := AllTrim(cTitulo) + " - De Competencia " + substr(mv_par05,1,2)+ "/" + substr(mv_par05,3,4) +  " - Ate a Competencia " + substr(mv_par06,1,2)+ "/" + substr(mv_par06,3,4)+ " e em aberto em " + dtoc(dDataAte)
elseIf ! empty (cCompAte) .and. ! empty (dDtEmiAt)                  
   MsgAlert("Relatório Considerara a Competência , mesmo a data de emissão estando preenchida  !!!!!")    
   cTitulo := AllTrim(cTitulo) + " - De Competencia " + substr(mv_par05,1,2)+ "/" + substr(mv_par05,3,4) +  " - Ate a Competencia " + substr(mv_par06,1,2)+ "/" + substr(mv_par06,3,4)+ " e em aberto em " + dtoc(dDataAte)
EndIf                                                                                                     
If nConFin = 1 
   cTitulo     := "Titulos em Aberto " 
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
						{ "TRB_NOME" 		, "C", TamSX3("BAU_NOME")[1]    , 0 },;
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
   					    { "TRB_BAIXA1"		, "D", 8						, 0 },; 
	               		{ "TRB_EMIS"		, "D", 8						, 0 },; 
						{ "TRB_VENCR"		, "D", 8						, 0 },;
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
						{ "TRB_SALDO"		, "N", TamSX3("BM1_VALOR")[1]	, 2	},;
                		{ "TRB_BANCO" 		, "C", 4	                    , 0 },;
                		{ "TRB_YLIBPL"  	, "C", 3	                    , 0 },;
                		{ "TRB_MOTBX"       , "C", 3                     	, 0	}}

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
//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampoTRB, .T.)
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)   
//if nCustrda = 1 
//	IndRegua("TRB1",cInd1TRB,"TRB_CODIGO + TRB_PREF + TRB_NUM + TRB_PARC + TRB_TIPOE2",,,"Indexando Arquivo de Trabalho") 
//	nSintAnl:=3
If nSintAnl = 1
	IndRegua("TRB1",cInd1TRB,"dTos(TRB_BAIXA) + TRB_ANO + TRB_MES",,,"Indexando Arquivo de Trabalho")
ElseIf nSintAnl = 2
	IndRegua("TRB1",cInd1TRB," TRB_CODIGO + TRB_ANO + TRB_MES + dTos(TRB_BAIXA)",,,"Indexando Arquivo de Trabalho")
else
	IndRegua("TRB1",cInd1TRB,"dTos(TRB_BAIXA) + TRB_ANO + TRB_MES + TRB_CODIGO + TRB_PREF + TRB_NUM + TRB_PARC + TRB_TIPOE2",,,"Indexando Arquivo de Trabalho")
EndIf

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
TRB1->( dbSetorder(01) ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionada fornecedores por suas caracteristicas de faturamento         ³
//³ a saber :RDA  , OPME  ,  REEMBOLSO                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

 If (nConRemb = 2 .and. nConOpme = 2 .and. nConRda = 2 .and. nConFin = 2 .and. ;
     nCustrda = 2 .and. nCustree = 2 .and. nCustope = 2)  
     MsgAlert("Não foi selecionado  Relatorio E Não foi selecionada a conferencia!!!!!") 
     TRB1->( dbCloseArea() )
     FErase(cArqTRB  + ".DBF")
     FErase(cInd1TRB + OrdBagExt())
     Return()
     Return(aRet)
 ElseIf ((nConRemb = 1 .or. nConOpme = 1 .or. nConRda = 1 .or. nConFin = 1) .and.  ;
         (ncustrda = 1 .or. nCustree = 1 .or. nCustope = 1))                                    
          MsgAlert("Foi selecionado o Relatorio e Foi selecionada a conferencia ...  Sera processado o Relatorio , a Conferencia NÃO sera realizada !!!!!")
 ElseIf (ncustrda = 1 .or. nCustree = 1 .or. nCustope = 1 )                                    
         MsgAlert("Foi selecionada a conferencia!!!!!")
         FConfCusto()
         TRB1->( dbCloseArea() )
         FErase(cArqTRB  + ".DBF")
         FErase(cInd1TRB + OrdBagExt())
         Return(aRet)
 //ElseIf  nCustrda = 1                                               
 //        MsgAlert("Foi selecionada a conferencia!!!!!")                    
 //        nConRda := 1
    Else   
           MsgAlert("Foi selecionada a relatorio !!!!!")    
    EndIf   

cSQL := " "
If nConRemb = 1
	cSQL += "SELECT DISTINCT SE2.R_E_C_N_O_  AS E2_RECNO , a2_nome ,'R' FORNECEDORE , "
//	cSQL += " DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,1,4),SubStr(E2_VENCREA,1,4))  ANOBASE, "
//	cSQL += " DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,5,2),SubStr(E2_VENCREA,5,2))  MESBASE " 
	cSQL += " DECODE(E2_EMISSAO,NULL,SubStr(E1_EMISSAO,1,4),SubStr(E2_EMISSAO,1,4))  ANOBASE, "
	cSQL += " DECODE(E2_EMISSAO,NULL,SubStr(E1_EMISSAO,5,2),SubStr(E2_EMISSAO,5,2))  MESBASE , E2_CODRDA CODRDA , E2_YLIBPLS YLIBPL "
	cSQL += "  FROM " + RetSQLName("SE2") + " SE2, "+ RetSQLName("SE1") + " SE1, "+ RetSQLName("SA2") + " SA2 "
	cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' AND E1_FILIAL = '" + xFilial("SE1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
   
//	cSQL +=  " and E2_FILIAL between  '01' AND '02' "    
// conferencia do custo em 03/2011
//    csql += " AND e1_num in ('001012063' , '001012064')
///////////	
	cSQL += " AND SE2.d_e_l_e_t_ = ' ' "
	cSQL += " AND e2_prefixo = 'RLE'   "
	cSQL += " AND SE1.d_e_l_e_t_ = ' ' "
	cSQL += " AND SA2.d_e_l_e_t_ = ' ' "
	cSQL += " AND e1_prefixo = e2_prefixo"
    cSQL += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	cSQL += " AND e1_tipo    = 'NCC'  "
	cSQL += " AND e1_num     = e2_num "
	cSQL += " AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' "
	cSQL += " AND e2_fornece = a2_cod "    
	
	if !empty (cCompAte)  
	   //cSQL += " AND DECODE(E2_emissao ,NULL,SubStr(E1_emissao ,1,6),SubStr(E2_emissao ,1,6))>= '" + cCompDe     + "' "
	   //cSQL += " AND DECODE(E2_VENCREA ,NULL,SubStr(E1_VENCREA ,1,6),SubStr(E2_VENCREA,1,6))<= '" + cCompAte     + "' " 
	   cSQL += " AND SubStr(E1_emissao ,1,6)>= '" + cCompDe + "' AND SubStr(E1_EMISSAO,1,6) <= '" + cCompAte + "' "
	else                                                                                                              
       cSQL += " AND E1_emissao >= '" +  dTos( dDtEmiDe  )      + "' " 
       cSQL += " AND E1_emissao <= '" +  dTos( dDtEmiAt  )      + "' "
    EndIf 
    if !empty (dDtvecDe)
        cSQL += " AND E2_vencrea  >= '" + dTos( dDtvecDe  )  + "' "             
        cSQL += " AND E2_Vencrea  <= '" + dTos( dDtvecAt  )  + "' "              
    EndIf  

If nBaixado == 1
 
        cSQL += " AND E2_saldo = 0  "

ElseIf	nBaixado == 2

        cSQL += " AND E2_saldo > 0  "	

EndIf  

endif 


if nConOpme = 1
	If nConRemb = 1
		cSQL += " UNION "
	EndIf
	cSQL += "SELECT DISTINCT SE2.R_E_C_N_O_  AS E2_RECNO , a2_nome , 'M' FORNECEDORE , SubStr(F1_EMISSAO,1,4) ANOBASE, SubStr(F1_EMISSAO,5,2) MESBASE, E2_CODRDA CODRDA , E2_YLIBPLS YLIBPL "
	cSQL += "  FROM " + RetSQLName("SE2") + " SE2, "+ RetSQLName("SF1") + " SF1, " + RetSQLName("SA2") + " SA2 "
	cSQL += "WHERE e2_filial = '"+xFilial("SE2")+"' "
	cSQL += "AND   f1_filial = '"+xFilial("SF1")+"' "
	cSQL += "AND SE2.d_e_l_e_t_ = ' '    "
	cSQL += "AND SF1.d_e_l_e_t_ = ' '    "
	cSQL += "AND SA2.d_e_l_e_t_ = ' '    "
	cSQL += "AND F1_SERIE = E2_PREFIXO   "
	cSQL += "AND F1_DOC = E2_NUM         "
	cSQL += "AND F1_FORNECE = E2_FORNECE "
    cSQL += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	cSQL += "AND E2_NATUREZ = 'OPME'     "
	cSQL += "AND e2_fornece = a2_cod     "
	cSQL += "AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' "
	          
	if ! empty (cCompAte)                                             
	   cSQL += "AND SubStr(F1_EMISSAO,1,6) >= '" + cCompDe      + "' "
	   cSQL += "AND SubStr(F1_EMISSAO,1,6) <= '" + cCompAte     + "' "
	else                                                                    
	   cSQL += "AND F1_EMISSAO >= '" +  dTos( dDtEmiDe  )      + "' "
       cSQL += "AND F1_EMISSAO <= '" +  dTos( dDtEmiAt  )      + "' "
    EndIf  
    if !empty (dDtvecDe)
        cSQL += " AND E2_vencrea  >= '" + dTos( dDtvecDe  )  + "' "             
        cSQL += " AND E2_Vencrea  <= '" + dTos( dDtvecAt  )  + "' "             
    EndIf

	If nBaixado == 1
 
        cSQL += " AND E2_saldo = 0  "

    ElseIf	nBaixado == 2

        cSQL += " AND E2_saldo > 0  "	

EndIf  
EndIf
If nConRda = 1
	if (nConOpme = 1 .or. nConRemb = 1)
		cSQL += "UNION "
	EndIf
	cSQL += "SELECT DISTINCT SE2.R_E_C_N_O_  AS E2_RECNO , a2_nome, 'P' FORNECEDORE ,E2_ANOBASE ANOBASE , E2_MESBASE MESBASE , E2_CODRDA CODRDA , E2_YLIBPLS YLIBPL "
	cSQL += "  FROM " + RetSQLName("SE2") + " SE2, " + RetSQLName("SA2") + " SA2 "
	cSQL += " WHERE e2_filial = '"+xFilial("SE2")+"' "
	cSQL += " AND SE2.d_e_l_e_t_ = ' ' "
	cSQL += " AND SA2.d_e_l_e_t_ = ' ' "
	cSQL += " AND e2_codrda <> ' ' "  
	cSQL += " AND e2_origem = 'PLSMPAG' "
	cSQL += " AND e2_fornece = a2_cod "    
    cSQL += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	cSQL += " AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' "        
	
	// altamiro -17/03/2011 - inclusao de um titulo unico para depurar situaçoes adversas - deve ser habilitado e desabilitado conforme necessidade 
  //  cSQL += " AND e2_num = '000004576' " 
  //  cSQL += " AND e2_prefixo  = 'CLI'  "
   ///////////////////    
    
	if ! empty (cCompAte)                                                               
	   cSQL += " AND (E2_ANOBASE || E2_MESBASE) >= '" + cCompDe     + "' "             
	   cSQL += " AND (E2_ANOBASE || E2_MESBASE) <= '" + cCompAte    + "' "             
	else                                                                        
	   cSQL += " AND E2_emissao  >= '" +  dTos( dDtEmiDe  )   + "' "             
	   cSQL += " AND E2_emissao  <= '" +  dTos( dDtEmiAt  )   + "' "             
	EndIf 
	if !empty (dDtvecDe)
        cSQL += " AND E2_vencrea  >= '" + dTos( dDtvecDe  )  + "' "             
        cSQL += " AND E2_Vencrea  <= '" + dTos( dDtvecAt  )  + "' "             
    EndIf  

    If nBaixado == 1
 
        cSQL += " AND E2_saldo = 0  "

    ElseIf	nBaixado == 2

        cSQL += " AND E2_saldo > 0  "	

    EndIf  

EndIf
If nConFin = 1
	If (nConOpme == 1 .or. nConRemb == 1 .or. nConRda == 1)
		cSQL += "UNION "
	EndIf
	cSQL += "SELECT DISTINCT SE2.R_E_C_N_O_  AS E2_RECNO , a2_nome, 'F' FORNECEDORE ,SubStr(E2_emissao,1,4)  ANOBASE ,SubStr(E2_emissao,5,2)  MESBASE , E2_CODRDA CODRDA , E2_YLIBPLS YLIBPL "
	cSQL += "  FROM " + RetSQLName("SE2") + " SE2, " + RetSQLName("SA2") + " SA2 "
	cSQL += " WHERE e2_filial = '"+xFilial("SE2")+"' "
	cSQL += " AND SE2.d_e_l_e_t_ = ' ' "
	cSQL += " AND SA2.d_e_l_e_t_ = ' ' "   
	// cSQL += " AND e2_origem  = 'FINA290' "
	cSQL += " AND e2_origem  <> 'PLSMPAG' "
	cSQL += " AND e2_prefixo <> 'GPE' "   
	cSQL += " AND e2_prefixo <> 'AXF' "
	cSQL += " AND e2_prefixo <> 'RLE' "
	cSQL += " AND E2_NATUREZ <> 'OPME' " 
	cSQL += " AND e2_fornece = a2_cod "
	cSQL += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	cSQL += " AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' " 
	if ! empty (cCompAte)                                                        
	   cSQL += " AND SubStr(E2_Emissao,1,6) >= '" + cCompDe     + "' "           
	   cSQL += " AND SubStr(E2_Emissao,1,6) <= '" + cCompAte     + "' "             
	else                                                                      
	   cSQL += " AND E2_emissao  >= '" + dTos( dDtEmiDe  )  + "' "             
	   cSQL += " AND E2_emissao  <= '" + dTos( dDtEmiAt)  + "' "             
	EndIf
	if !empty (dDtvecDe)
        cSQL += " AND E2_vencrea  >= '" + dTos( dDtvecDe  )  + "' "             
        cSQL += " AND E2_Vencrea  <= '" + dTos( dDtvecAt  )  + "' "             
    EndIf   

    If nBaixado == 1
 
        cSQL += " AND E2_saldo = 0  "

    ElseIf	nBaixado == 2

        cSQL += " AND E2_saldo > 0  "	

    EndIf  

EndIf                                                                          

If (nConRemb = 1 .or. nConOpme = 1 .or. nConRda = 1 .or. nConFin = 1 )                   
	cSQL += " ORDER BY 2               "
EndIf

//memowrite("C:\TEMP\sqlcrjr016.sql",cSQL) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa query                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nConRemb = 2 .and. nConOpme = 2 .and.  nConRda = 2 .and. nConFin = 2 )

    MsgAlert("Não foi selecionado nenhum Relatorio !!!!!")

	TRB1->( dbCloseArea() )
	FErase(cArqTRB  + ".DBF")
	FErase(cInd1TRB + OrdBagExt())
	Return()
	Return(aRet)
Else
	PLSQUERY(cSQL,"Trb")
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
	nVlrDes		:= 0
	nVlrDesA	:= 0
	
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
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	    MsProcTxt("Imprimindo... " + Left(AllTrim(Trb->a2_nome),30))
	    ProcessMessages()
	If SE5->( MsSeek(xFilial("SE5")+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA) )
		
		While !SE5->( Eof() ) .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA ==;
			SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
			
			// Ignora descontos, juros, cancelamentos, recebimentos e outros tipos...
			If SE5->E5_RECPAG == 'R' .or.;
				SE5->E5_SITUACA == 'C' .or. (SE5->E5_TIPODOC $ "D2, JR, J2, TL, MT, M2, CM, C2, TR, TE") 
			 //	SE5->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN") .or.;  EM 06/09/2009 ATENDER AO TITULO 2719 BAXADO POR CAN
		   	 //(SE5->E5_TIPODOC $ "DC, D2, JR, J2, TL, MT, M2, CM, C2, TR, TE") EM 06/09/2009
				
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
			cQuery += "E5_DATA < '"+DtoS(dDataAte)+"' AND "
			cQuery += "D_E_L_E_T_<>'*'"
			PlsQuery(cQuery, "EST")
			
			nVlrEst := EST->ESTORNO

			EST->( dbCloseArea() )
			
			// Filtra datas dos parametros...
			If !(dTos(SE5->E5_DATA) >=  dTos(dDataDe) .and. dTos(SE5->E5_DATA) <=  dTos(dDataAte))
				
				// Se a data da baixa for posterior a data final do relatorio, o titulo sera considerado como em aberto.
				If SE5->E5_DATA > dDataAte //.and. SE2->E2_EMISSAO <= dDataAte
					nVlrAberto += SE5->E5_VALOR
					nVlrAberto -= nVlrEst
				Endif
				
				
				//Jean - Criado novo trecho para permitir obter valores anteriores as datas
				// Se for PA, acumular na matriz neste ponto e descarregar depois...
				If SE5->E5_DATA < dDataDe
					If Alltrim(SE5->E5_TIPODOC) == 'CP' .and. Alltrim(SE5->E5_MOTBX) == 'CMP'
						nVlrPAAnt += SE5->E5_VALOR
						nVlrPAAnt -= nVlrEst // Diminui o valor do estorno se houver
						nVlrPA    += SE5->E5_VALOR                           
						cMotbx    := SE5->E5_MOTBX
						//Somar valor desconto  parcial, caso ocorra... 	 
					Elseif Alltrim(SE5->E5_TIPODOC) == 'DC'
						nVlrDesA += SE5->E5_VALOR
						nVlrDesA -= nVlrEst //' Diminui o valor do estorno se houve
						nVlrDes  += SE5->E5_VALOR 
						cMotbx    := SE5->E5_MOTBX
						// Desconto por motivo judicial..
					Elseif Alltrim(SE5->E5_MOTBX) == 'DPJ'
						nVlrJdAnt += SE5->E5_VALOR
						nVlrJdAnt -= nVlrEst //' Diminui o valor do estorno se houver
						nVlrJd    += SE5->E5_VALOR
 						cMotbx    := SE5->E5_MOTBX
						//Somar valor desconto  parcial, caso ocorra... 	 
					Elseif Alltrim(SE5->E5_MOTBX) == 'DC'
						nVlrDesA += SE5->E5_VALOR
						nVlrDesA -= nVlrEst //' Diminui o valor do estorno se houve
						nVlrDes  += SE5->E5_VALOR
 						cMotbx    := SE5->E5_MOTBX
						//Somar valor baixado parcial, caso ocorra... 
					Else
						nVlrBxAnt += SE5->E5_VALOR
						nVlrBxAnt -= nVlrEst
						dDatBxAnt := Iif(dDatBxAnt <= SE5->E5_DATA .And. SE5->E5_DATA <= dDataAte,SE5->E5_DATA,dDatBxAnt)
						nVlrBx    += SE5->E5_VALOR
 						cMotbx    := SE5->E5_MOTBX						
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
			Elseif Alltrim(SE5->E5_TIPODOC) == 'DC'
                nVlrDes += SE5->E5_VALOR
				nVlrDes -= nVlrEst //' Diminui o valor do estorno se houve	
				// Desconto por motivo judicial..
			Elseif Alltrim(SE5->E5_MOTBX) == 'DPJ'
				nVlrJd += SE5->E5_VALOR
				nVlrJd -= nVlrEst // Diminui o valor do estorno se houver
			Else
				nVlrBx += SE5->E5_VALOR
				nVlrBx -= nVlrEst // Diminui o valor do estorno se houver
			Endif
			if (nVlrBx <> 0 .or. nVlrJd <> 0 .or. nVlrPA <> 0 ) .AND. ;
				((Alltrim(SE5->E5_TIPODOC) <> 'CP'  .or. Alltrim(SE5->E5_TIPODOC) <> 'DC')  .and.;
			      Alltrim(SE5->E5_MOTBX)   <> 'CMP' .and. ;
			      Alltrim(SE5->E5_MOTBX)   <> 'BNF' .and. Alltrim(SE5->E5_MOTBX) <> 'DPJ')
				nDtBx := SE5->E5_DATA
				// FGravaTrb()
				nVlrBx := (nVlrBx + nVlrJd + nVlrPA + nVlrDes )
				if  (nVlrBx + SE2->E2_DECRESC) < se2->e2_valor
					nVlrPA := (nVlrBx - nVlrJd )
					nVlrBx := 0
					nVlrAberto := 0
				endif
			Endif
			SE5->( dbSkip() )
			nVlrEst:=0
		Enddo
		FGravaTrb()
	Else	// Se entrar aqui, eh porque nao existe baixa, consequentemente o titulo esta em aberto.
		/*
		Jota! diz:
		se o titulo estiver em aberto, o que devo considerar mesmo ?
		A data de emissao deve estar entre a data "de/ate"  ?
		e isso mesmo ?
		
		Jean diz:
		se estiver em aberto, deve-se verificar se a emissão foi ATE a data final
		*/
		
 //		If SE2->E2_EMISSAO <= dDataAte
			nVlrAberto += SE2->(E2_VALOR)
			FGravaTrb()
   //		Endif
	Endif
	
	Trb->(dbSkip())
	
Enddo


Trb->(dbCloseArea())

// Libera registro do arquivo temporario...
TRB1->( MsUnlock() )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa proximo registro                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	TrbBAU->(DbSkip())
//Enddo           
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

// Inicio da impressao dos dados...
MsProcTxt("Aguarde... gerando impressao!")
ProcessMessages()
lMostraImp := .T.
nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
TRB1->( dbSetorder(01) )
TRB1->( dbGotop() )

// Variavel que ira controlar quantas quebras por baixa foram impressas. Caso seja impresso apenas uma, nao sera
// preciso imprimir o total, pois o valor total sera o mesmo impresso no total da quebra do dia. Tendeu ?
nDias := 0
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
			
			// Controle de saldo de pagina...
			If  nli > nLinPag
			    nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nLi++
                If empty (cCompAte) 
                   @ nLi, 000 Psay "Data Pagamento: " + Iif(dTos(TRB1->TRB_BAIXA)<>"19600101", dToc(TRB1->TRB_BAIXA), "Em Abertos - Considerando titulos com Emissao de " + Dtoc(dDtEmiDe) + "ate " + Dtoc(dDtEmiAt))                
                Else                     				
			       @ nLi, 000 Psay "Data Pagamento: " + Iif(dTos(TRB1->TRB_BAIXA)<>"19600101", dToc(TRB1->TRB_BAIXA), "Em Abertos - Considerando titulos com competencia  até  "+substr(mv_par06,1,2)+"/"+substr(mv_par06,3,4))
			    Endif   
				nli += 2
			EndIf	
			If !lFirst
				    If nSintAnl = 2
					   If cComp <> (Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21))) // quebra por FORNECEDOR ....
					      nLi ++
						  FTotComp()
				          @ nLi, 005 Psay "Fornecedor : "+(Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
					      nli++
					      cComp := (Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
					      lFirst := .F.
					   endif
				    Else
					   If cComp <> Alltrim(TRB1->(TRB_ANO+TRB_MES)) // quebra por FORNECEDOR ....
					      nLi ++
						  FTotComp()
  					      @ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
					      nli++
					      cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES))
					      lFirst := .F. 
				       Endif
			        Endif
			Else
			// Impressao dos detalhes de cabecalho
			//If lFirst
				
				// Controle de saldo de pagina...
				If  nli > (nLinPag - 4)
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nLi++
				Endif
				nli += 1                                                   

				If nSintAnl = 2 
				    cComp := (Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
					@ nLi, 005 Psay "Fornecedor : "+(Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
					nli++
					lFirst := .F.
				Else                                             
				    cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES))
					@ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
					nli++
					lFirst := .F.
				Endif
				
			Endif
			If nSintAnl = 2
				If cComp <> (Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21))) // quebra por FORNECEDOR ....
					nLi ++
					If nli > nLinPag // Preteje quebra de pagina...
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nLi++
					Endif
					FTotComp()
					@ nLi, 005 Psay "Fornecedor : "+(Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
					nli++
					cComp := (Alltrim (SUBSTR (TRB1->TRB_NOME, 1, 21)))
				Endif
			Else
				If cComp <> Alltrim(TRB1->(TRB_ANO+TRB_MES)) // quebra por competencia...
					nLi ++
					If nli > nLinPag // Preteje quebra de pagina...
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nLi++
					Endif
					FTotComp()
					@ nLi, 005 Psay "Competencia "+RetMesAno(Alltrim(TRB1->(TRB_ANO+TRB_MES)))
					nli++
					cComp := Alltrim(TRB1->(TRB_ANO+TRB_MES))
				Endif
			Endif
		Endif
		
		/*
		10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
		012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		Analitico
		Codigo - Nome RDA.             Vlr Informado        Vlr Bruto     Tx Admin         IRRF      ISS Cr.         INSS   Vlr Adiant          PIS         CSLL      Cofins      Tarifa      Bx Jud        Liquido          Saldo"
		000000-00000000000000000000   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999.99  999,999.99  999,999.99  999,999.99  99,999,999.99  99,999,999.99
		*/
		if  ((nSintAnl == 3) .or. (nSintAnl == 2))
   			@ nLi, 001 Psay TRB1->TRB_CODIGO
			@ nLi, 009 Psay TRB1->TRB_PREF
			@ nLi, 014 Psay TRB1->TRB_NUM
			@ nLi, 023 Psay TRB1->TRB_PARC
			@ nLi, 023 Psay	TRB1->TRB_TIPO
			@ nLi, 029 Psay TRB1->TRB_TIPOE2
            if empty (dDtvecDe)            
               @ nLi, 035 PSAY TRB1->TRB_EMIS 
            else
		       @ nLi, 035 PSAY TRB1->TRB_VENCR 
            EndIf
            If nGeraXls == 1              
            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³ Cria e grava cabecalho do Xls...							             ³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
               if lprim                  
                  lprim := .F.           
                  aArray := { {"Cod.Forn"      ,;
                               "Prefixo "      ,;
                               "Numero"        ,;
                               "Parcela"       ,;
                               "Tipo"          ,;
                               "Origem "       ,;
                               "Dt Emissao  "  ,;
                               "Vlr Bruto   "  ,;   
                               "Vlr Liquido "  ,;
                               "Vlr do IRRF "  ,;
                               "Vlr do INSS "  ,;
                               "Vlr do PIS "   ,;
                               "Vlr do COFINS ",;
                               "Vlr do CSLL "  ,;
                               "Vlr do ISS  "  ,;                           
                               "Vlr SALDO   "  ,;
                               "Dt. Vencimento",;
                               "Dt. Pagto"     ,;
                               "BANCO  "       ,;
                               "Cod  Grp Pagto" ,; 
                               "Nome Grp Pagto ",;
                               "comptencia"     ,;
                                "Nf Entr."      ,;
                                "Mot Bx" }  }  
               EndIf                
             
      
            EndIf
    
        EndIf                                  
                 
	  	 //	@ nLi, 030 Psay Transform(TRB1->TRB_INSSEM	, pMoeda2); nTotInf	+= TRB1->TRB_INSSEM; nTotInfc	+= TRB1->TRB_INSSEM; nTotdInf += TRB1->TRB_INSSEM
			@ nLi, 050 Psay Transform(TRB1->TRB_VLRBRT	, pMoeda2); nTotBru	+= TRB1->TRB_VLRBRT; nTotBruc	+= TRB1->TRB_VLRBRT; nTotdBru += TRB1->TRB_VLRBRT
			@ nLi, 067 Psay Transform(TRB1->TRB_VLRTAX	, pMoeda1); nTotTxa	+= TRB1->TRB_VLRTAX; nTotTxac	+= TRB1->TRB_VLRTAX; nTotdTxa += TRB1->TRB_VLRTAX
			@ nLi, 080 Psay Transform(TRB1->TRB_IRRF	, pMoeda1); nTotIrf	+= TRB1->TRB_IRRF  ; nTotIrfc	+= TRB1->TRB_IRRF  ; nTotdIrf += TRB1->TRB_IRRF
			@ nLi, 093 Psay Transform(TRB1->TRB_ISS		, pMoeda1); nTotIss	+= TRB1->TRB_ISS   ; nTotIssc	+= TRB1->TRB_ISS   ; nTotdIss += TRB1->TRB_ISS
			@ nLi, 106 Psay Transform(TRB1->TRB_INSS	, pMoeda1); nTotIns	+= TRB1->TRB_INSS  ; nTotInsc	+= TRB1->TRB_INSS  ; nTotdIns += TRB1->TRB_INSS
			@ nLi, 119 Psay Transform(TRB1->TRB_VLRADT	, pMoeda1); nTotAdt	+= TRB1->TRB_VLRADT; nTotAdtc	+= TRB1->TRB_VLRADT; nTotdAdt += TRB1->TRB_VLRADT
			@ nLi, 132 Psay Transform(TRB1->TRB_PIS		, pMoeda1); nTotPis	+= TRB1->TRB_PIS   ; nTotPisc	+= TRB1->TRB_PIS   ; nTotdPis += TRB1->TRB_PIS
			@ nLi, 147 Psay Transform(TRB1->TRB_CSLL	, pMoeda1); nTotCSL	+= TRB1->TRB_CSLL  ; nTotCSLc   += TRB1->TRB_CSLL  ; nTotdCsl += TRB1->TRB_CSLL
			@ nLi, 157 Psay Transform(TRB1->TRB_COFINS	, pMoeda1); nTotCof	+= TRB1->TRB_COFINS; nTotCofc	+= TRB1->TRB_COFINS; nTotdCof += TRB1->TRB_COFINS
			@ nLi, 169 Psay Transform(TRB1->TRB_VLRTAR	, pMoeda1); nTotTar	+= TRB1->TRB_VLRTAR; nTotTarc	+= TRB1->TRB_VLRTAR; nTotdTar += TRB1->TRB_VLRTAR
			@ nLi, 181 Psay Transform(TRB1->TRB_VLRJUD	, pMoeda1); nTotJud	+= TRB1->TRB_VLRJUD; nTotJudc	+= TRB1->TRB_VLRJUD; nTotdJud += TRB1->TRB_VLRJUD
	
			@ nLi, 193 Psay Transform(TRB1->TRB_VLRLIQ	, pMoeda2); nTotLiq	+= TRB1->TRB_VLRLIQ	; nTotLiqc  += TRB1->TRB_VLRLIQ	; nTotdLiq += TRB1->TRB_VLRLIQ
			@ nLi, 208 Psay Transform(TRB1->TRB_SALDO	, pMoeda2); nTotSal	+= TRB1->TRB_SALDO	; nTotSalc  += TRB1->TRB_SALDO	; nTotdSal += TRB1->TRB_SALDO
	 	    nLi++    
	 	   	If  ((nSintAnl == 3) .or. (nSintAnl == 2))
                If nGeraXls == 1  
              /*    aAdd(aArray,{TRB1->TRB_CODIGO + ' - ' + TRB1->TRB_NOME,;
                               TRB1->TRB_PREF  ,;
                               TRB1->TRB_NUM   ,;
                               TRB1->TRB_PARC  ,;
                               TRB1->TRB_TIPO  ,;
                               TRB1->TRB_TIPOE2,;
                               TRB1->TRB_EMIS ,;
                     Transform(TRB1->TRB_VLRBRT , pMoeda2)  ,;
                     Transform(TRB1->TRB_IRRF	, pMoeda1)  ,;
                     Transform(TRB1->TRB_INSS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_PIS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_COFINS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_CSLL	, pMoeda1)  ,;
                     Transform(TRB1->TRB_ISS	, pMoeda1)  ,;                      
                     Transform(TRB1->TRB_ACRESC	, pMoeda1)  ,;
                     Transform(TRB1->TRB_DCRESC	, pMoeda1)  ,;                     
                     Transform(TRB1->TRB_VLRLIQ	, pMoeda2)  ,;
                     Transform(TRB1->TRB_SALDO	, pMoeda2)  ,;
                               TRB1->TRB_VENCR              ,; 
                               TRB1->TRB_BAIXA1             ,;  
                               TRB1->TRB_BANCO              ,;  
                               TRB1->TRB_GRPPAG	            ,;           
                               TRB1->TRB_DESGRP	            ,;                               
                               TRB1->TRB_ANO+"/"+TRB1->TRB_MES})      */
                               
                 aAdd(aArray,{TRB1->TRB_CODIGO + ' - ' + TRB1->TRB_NOME,;
                               TRB1->TRB_PREF  ,;
                               TRB1->TRB_NUM   ,;
                               TRB1->TRB_PARC  ,;
                               TRB1->TRB_TIPO  ,;
                               TRB1->TRB_TIPOE2,;
                               TRB1->TRB_EMIS ,;
                     Transform(TRB1->TRB_VLRBRT , pMoeda2)  ,;
                     Transform(TRB1->TRB_vlrliq	, pMoeda2)  ,;
                     Transform(TRB1->TRB_IRRF	, pMoeda1)  ,;
                     Transform(TRB1->TRB_INSS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_PIS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_COFINS	, pMoeda1)  ,;
                     Transform(TRB1->TRB_CSLL	, pMoeda1)  ,;
                     Transform(TRB1->TRB_ISS	, pMoeda1)  ,;                      
                     Transform(TRB1->TRB_SALDO	, pMoeda2)  ,;
                               TRB1->TRB_VENCR              ,; 
                               TRB1->TRB_BAIXA1             ,;  
                               TRB1->TRB_BANCO              ,;  
                               TRB1->TRB_GRPPAG	            ,;           
                               TRB1->TRB_DESGRP	            ,;                               
                               TRB1->TRB_ANO+"/"+TRB1->TRB_MES,;
                               TRB1->TRB_YLIBPL             ,;
                               TRB1->TRB_MOTBX})                               
                               
                EndIf  
            EndIf
    TRB1->( dbSkip() )            
	Enddo
	
	// Finaliza quebra por dia da baixa imprimindo os totais do dia...
	If (nTotdInf + nTotdBru	+ nTotdTxa	+ nTotdIrf + nTotdIss +;
		nTotdIns + nTotdAdt	+ nTotdPis	+ nTotdCSL + nTotdVlr +;
		nTotdCof + nTotdTar	+ nTotdJud + nTotdLiq + nTotdSal) > 0
		nLi++
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
		
	//	@ nLi, 030 Psay Transform(nTotdInf	, pMoeda2)

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
//	@ nLi, 030 Psay Transform(nTotInf, pMoeda2)
	@ nLi, 047 Psay Transform(nTotBru, pMoeda2)
	@ nLi, 064 Psay Transform(nTotTxa, pMoeda1)
	@ nLi, 077 Psay Transform(nTotIrf, pMoeda1)
	@ nLi, 090 Psay Transform(nTotIss, pMoeda1)
	@ nLi, 103 Psay Transform(nTotIns, pMoeda1)
	@ nLi, 116 Psay Transform(nTotAdt, pMoeda1)
	@ nLi, 129 Psay Transform(nTotPis, pMoeda1)
	@ nLi, 144 Psay Transform(nTotCSL, pMoeda1)
	@ nLi, 154 Psay Transform(nTotCof, pMoeda1)
	@ nLi, 166 Psay Transform(nTotTar, pMoeda1)
	@ nLi, 178 Psay Transform(nTotJud, pMoeda1)
	@ nLi, 190 Psay Transform(nTotLiq, pMoeda2)
	@ nLi, 205 Psay Transform(nTotSal, pMoeda2)
Endif

TRB1->( dbCloseArea() )
//TRB2->( DbCloseArea())

If nGeraXls == 1   
   If Len(aArray) > 1
      DlgToExcel({{"ARRAY","","",aArray}})  
   EndIf 
EndIf


FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodade padrao                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo de trabalho                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//TrbBAU->(DbCloseArea())
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
±±³Descricao  |admin	  ³ Atualiza SX1                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}
aadd(aRegs,{cPerg,"01","Operadora"              ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})

aadd(aRegs,{cPerg,"02","Fornecedor De"          ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","","FOR1"   ,""})
aadd(aRegs,{cPerg,"03","Fornecedor Ate"         ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","","FOR1"   ,""})
aadd(aRegs,{cPerg,"04","Abertos(Não Pag.)ate"   ,"","","mv_ch4","D", 8,0,0,"G","","mv_par04",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})
aadd(aRegs,{cPerg,"05","Competencia de"         ,"","","mv_ch5","C", 6,0,0,"G","","mv_par05",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","","99/9999",""})
aadd(aRegs,{cPerg,"06","Competencia Ate"        ,"","","mv_ch6","C", 6,0,0,"G","","mv_par06",""            ,"","","","",""               ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","","99/9999",""})

Aadd(aRegs,{cPerg,"07","Tipo Relatorio?  "		 ,"","","mv_ch7","N",01,0,0,"C","","mv_par07","Em Aberto"   ,"","","","",""           	,"","","","",""           ,"","","","",""					  ,"","","","","","","","",""	     ,""})
Aadd(aRegs,{cPerg,"08","Sintet/Analit.?  "		 ,"","","mv_ch8","N",01,0,0,"C","","mv_par08","Sintetico"   ,"","","","","Anal.Fornecedor","","","","","Anal.comp"    ,"","","","",""					  ,"","","","","","","","",""		 ,""})

Aadd(aRegs,{cPerg,"09","Considerar RDA ?  "		 ,"","","mv_ch9","N",01,0,0,"C","","mv_par09","Sim"         ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})
Aadd(aRegs,{cPerg,"10","Considerar OPME?  "		 ,"","","mv_ch10","N",01,0,0,"C","","mv_par10","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})
Aadd(aRegs,{cPerg,"11","Considerar Remb?  "		 ,"","","mv_ch11","N",01,0,0,"C","","mv_par11","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})
Aadd(aRegs,{cPerg,"12","Considerar Financeiro? " ,"","","mv_ch12","N",01,0,0,"C","","mv_par12","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})
//Aadd(aRegs,{cPerg,"13","Considerar OPME Saude? " ,"","","mv_ch13","N",01,0,0,"C","","mv_par13","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})

aadd(aRegs,{cPerg,"13","Data Emissão De "        ,"","","mv_ch13","D", 8,0,0,"G","","mv_par13",""           ,"","","","",""              ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})
aadd(aRegs,{cPerg,"14","Data Emissão Ate"        ,"","","mv_ch14","D", 8,0,0,"G","","mv_par14",""           ,"","","","",""              ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})
aadd(aRegs,{cPerg,"15","Gerar Xls(Excel)"        ,"","","mv_ch15","N", 1,0,0,"C","","mv_par15","Sim"        ,"","","","","Não"           ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})

aadd(aRegs,{cPerg,"16","Conf. Custo RDA   ? "    ,"","","mv_ch16","N",01,0,0,"C","","mv_par16","Sim"        ,"","","","","Não"           ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})
Aadd(aRegs,{cPerg,"17","Conf. Custo Reemb ? "	 ,"","","mv_ch17","N",01,0,0,"C","","mv_par17","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})
Aadd(aRegs,{cPerg,"18","Conf. Custo OPME  ? "	 ,"","","mv_ch18","N",01,0,0,"C","","mv_par18","Sim"        ,"","","","","Nao"           	,"","","","",""              ,"","","","",""					  ,"","","","","","","","",""		 ,""})

aadd(aRegs,{cPerg,"19","Data Vencto De "        ,"","","mv_ch19","D", 8,0,0,"G","","mv_par19",""           ,"","","","",""              ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})
aadd(aRegs,{cPerg,"20","Data Vencto Ate"        ,"","","mv_ch20","D", 8,0,0,"G","","mv_par20",""           ,"","","","",""              ,"","","","",""              ,"","","","",""    			      ,"","","","","","","","",""   	 ,""})


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
///////////////////////////////////////////////

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
	If (nTotBruc <> 0)
		
		If nSintAnl = 2
			@ nLi, 000 Psay "Totais do Fornecedor  "
		Else
			@ nLi, 000 Psay "Totais da competencia "
		EndIf
   //		@ nLi, 030 Psay Transform(nTotInfc, pMoeda2)
		@ nLi, 047 Psay Transform(nTotBruc, pMoeda2)
		@ nLi, 064 Psay Transform(nTotTxac, pMoeda1)
		@ nLi, 077 Psay Transform(nTotIrfc, pMoeda1)
		@ nLi, 090 Psay Transform(nTotIssc, pMoeda1)
		@ nLi, 103 Psay Transform(nTotInsc, pMoeda1)
		@ nLi, 116 Psay Transform(nTotAdtc, pMoeda1)
		@ nLi, 129 Psay Transform(nTotPisc, pMoeda1)
		@ nLi, 144 Psay Transform(nTotCSLc, pMoeda1)
		@ nLi, 154 Psay Transform(nTotCofc, pMoeda1)
		@ nLi, 166 Psay Transform(nTotTarc, pMoeda1)
		@ nLi, 178 Psay Transform(nTotJudc, pMoeda1)
		@ nLi, 190 Psay Transform(nTotLiqc, pMoeda2)
		@ nLi, 205 Psay Transform(nTotSalc, pMoeda2)
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
    

   dbselectarea("SA2")
   dbsetorder(1)     
   dbseek(xFilial("SA2")+SE2->E2_FORNECE )      
   
if trim(trb->fornecedore) == 'P'    

   dbselectarea("BAU")
   dbsetorder(1)     
   dbseek(xFilial("BAU")+SE2->E2_CODRDA )
   
   dbselectarea("B16")
   dbsetorder(1)    
   dbseek(xFilial("B16")+bau->bau_grppag )
   _cDesGrP := B16->B16_DESCRI
   _cCabGrp := bau->bau_grppag 
Else                           
  _cDesGrP := 'SEM Grp Pagto "
   _cCabGrp := '9999' 
EndIf
If !(Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrJd - nVlrBxAnt - nVlrDes - (SE2->E2_DECRESC)) > 0 ))
	Return()
//Endif


// Se o titulo não for considerado um titulo em aberto e tambem não estiver baixado, devo ignorar este
// titulo no relatorio.
// Em 23/03/09, alterado para demonstrar tambem titulos baixados por compensacao...
//If (nVlrAberto + nVlrBx) <= 0
//If (nVlrAberto + nVlrBx + nVlrDes + nVlrPA + nVlrJd ) == 0
//	return ()
//		Trb->(dbSkip())
//	    Loop
ELSE
	//Jean - somar o valor das baixas PA anteriores e baixas judiciais anteriores...
	//	   nVlrPAA += nVlrPA
	//	   nVlrPA  += nVlrPAAnt
	//	   nVlrJd  += nVlrJdAnt
	// So ira processar o BD7 caso exista titulo a receber... ganho de performance...
	nVlrTax := 0
	IF Trb->FORNECEDORE == 'P'
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
	Endif
	dDataBaixa := cTod('') // Data da baixa
	
	//Jean - em 09/04/09, alterada a linha para interpretar que
	//titulos baixados por adiantamento ou em aberto...
	//Jean - cfme solicitacao de Bira, alterar o relatorio para apresentar
	//titulos com baixa parcial tanto no relatorio em aberto qto no baixados..
	//If Empty(dTos(SE2->E2_BAIXA)) .or. nVlrAberto > 0
	
	If nTipRel == 1 //Mostrar os em aberto...
		If Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrDes - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 )
			dDataBaixa := cTod("01/01/60")
		Else
			Return()
			dDataBaixa := SE2->E2_BAIXA
		Endif
	Else
		//Caso houver alguma baixa, e o parametro for para listar os baixados,
		//deve-se demonstrar o titulo como dt de baixa parcial.
		If Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrDes - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 )
			///altamiro 24-07-09
			if  nVlrAberto = 0
				nVlrAberto := ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrDes - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC))
			endif
			///////////////////
			
			If !Empty(dTos(nDtBx)) .And. (nDtBx >= dDataDe .And. nDtBx <= dDataAte )
				Return()
				dDataBaixa := nDtBx
				
			Else
				dDataBaixa := cTod("01/01/60")
			Endif
		Else
			Return()
			dDataBaixa := SE2->E2_BAIXA
		Endif
		
		
	Endif     
//	if ncustrda = 1 
//	lFound := TRB1->( MsSeek (se2->e2_fornece + SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO) )
	If nSintAnl = 1
		lFound := TRB1->( MsSeek(dTos(dDataBaixa) + Trb->ANOBASE + Trb->MESBASE ) )
	ElseIf nSintAnl = 2
		lFound := TRB1->( MsSeek(dTos(dDataBaixa) + Trb->ANOBASE + Trb->MESBASE + se2->e2_fornece ) )
	Else
		lFound := TRB1->( MsSeek(dTos(dDataBaixa) + Trb->ANOBASE + Trb->MESBASE + se2->e2_fornece + SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO) )
	Endif
endif
TRB1->( RecLock("TRB1", !lFound) )

// Grava campos que compoem a chave de pesquisa.
If !lFound              
   


	TRB1->TRB_CODIGO 	:= se2->e2_fornece     
//	TRB1->TRB_CODIGO 	:= se2->e2_codrda    
	TRB1->TRB_NOME		:= Trb->a2_nome
	TRB1->TRB_GRPPAG	:= bau->bau_grppag           
    TRB1->TRB_DESGRP	:= _cDesGrP 
	TRB1->TRB_ANO		:= Trb->ANOBASE
	TRB1->TRB_MES		:= Trb->MESBASE
	TRB1->TRB_TIPO		:= Trb->FORNECEDORE
	TRB1->TRB_BAIXA	    := dDataBaixa                      
    TRB1->TRB_EMIS      := SE2->E2_EMISSAO
    TRB1->TRB_VENCR     := SE2->E2_VENCREA
	TRB1->TRB_PREF      := SE2->E2_PREFIXO
	TRB1->TRB_NUM 	    := SE2->E2_NUM
	TRB1->TRB_PARC      := SE2->E2_PARCELA
	TRB1->TRB_TIPOE2    := SE2->E2_TIPO 
	TRB1->TRB_BAIXA1	:= SE2->E2_baixa  
	TRB1->TRB_BANCO     := SA2->A2_BANCO               
	
	TRB1->TRB_MOTBX     := cMOTBX              
	
	TRB1->TRB_YLIBPL    := iif (se2->e2_codret == '0588', 'N/D', SE2->E2_ylibpls)
Endif
//Jean - alterado linha para testar E2_BAIXA, e resolver o problema
//relativo aos NDFs duplicados...

nValor := SE2->E2_VALOR


//If  (empty(SE2->E2_PARCELA) .or. (se2->e2_naturez = "OPME")) 			// indica que eh o titulo principal
	
	If  SE2->E2_TIPO == "NDF" // .And. !Empty(SE2->(E2_BAIXA))
		nValor := nValor * -1
	Endif                                     
	
	
	nOutImp := IIf(lContrRet, SE2->(E2_VRETPIS+E2_VRETCOF+E2_VRETCSL), SE2->(E2_PIS+E2_COFINS+E2_CSLL) ) + SE2->E2_ISS
	
	//JEAN - Conforme Ubiratan em 07/04/09, nao deverao ser apresentados os impostos
	//para titulos baixados parcialmente.
	//lMostraImp := Iif(nVlrAberto > 0, .F., .T.)
	
//	lMostraImp := Iif (Empty(dTos(SE2->E2_BAIXA)) .or. ( nVlrAberto > 0 .or. ( SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrDes - nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 ), .F., .T.)
     lMostraImp := .T.	
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
		.and. ((SE2->(E2_VALOR) - nVlrPA - nVlrBx - nVlrDes -nVlrJd - nVlrBxAnt - (SE2->E2_DECRESC)) > 0 );
		.and. (Alltrim(SE5->E5_TIPODOC) <> 'CP' .and. Alltrim(SE5->E5_MOTBX) <> 'CMP') )
		//                     TRB1->TRB_VLRBRT	+= nVlrBx
		TRB1->TRB_VLRBRT	+= SE2->E2_Valor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp
		lparc := .T.
	else
		TRB1->TRB_VLRBRT	+= nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp
	endif
	TRB1->TRB_VLRTAX	:= nVlrTax  
	IF Trb->FORNECEDORE <> 'P'
	   TRB1->TRB_VLRTAR	+= (SE2->E2_DECRESC + nVlrDes)
	EndIf                                 
	
	TRB1->TRB_VLRADT 	+= nVlrPA
	TRB1->TRB_VLRJUD	+= nVlrJd
	nVlrAberto += SE2->E2_IRRF + SE2->E2_INSS + nOutImp
	////////////////////////////////////
	If  SE2->E2_TIPO == "NDF"
		nVlrBx     += (nVlrBx * -1)
		nVlrAberto += (nVlrAberto * -1)
	endif 
	
	TRB1->TRB_SALDO := SE2->E2_saldo                
	TRB1->TRB_VLRLIQ:= SE2->E2_VALOR     
		
/*	If dDataBaixa == cTod("01/01/60")
		TRB1->TRB_SALDO  := (TRB1->TRB_VLRBRT -TRB1->TRB_VLRADT -	TRB1->TRB_VLRJUD - TRB1->TRB_VLRTAR )
	elseif  lparc
		TRB1->TRB_SALDO += 0
	else
		TRB1->TRB_SALDO += (TRB1->TRB_VLRBRT  - nVlrBx - TRB1->TRB_VLRADT - TRB1->TRB_VLRTAR - SE2->E2_IRRF - SE2->E2_INSS - nOutImp - TRB1->TRB_VLRJUD)
	EndIf
*/	
	
 	If Alltrim(BAU->BAU_TIPPE) == "F" .and. SE2->E2_TIPO <> "NDF"  .and.  dDataBaixa <> cTod("01/01/60")	// Estrai 20% do valor total.
		// Extrai 20 do valor bruto do pagamento / Chumbado no fonte.
		nInssVal := Iif(lMostraImp,(((nValor + SE2->E2_IRRF + SE2->E2_INSS + nOutImp) * 20) / 100),0)
		TRB1->TRB_INSSEM	+= nInssVal
	Endif
	


Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Conferencia do custo                ºAutor ³altamiro          º Data ³ 17/09/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Conf. valores do custo por evento contra os titulo a pagar no financeiro         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Contabilidade / auditoria / informatica / financeiro                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*********************************/
Static Function	FConfCusto()         
/*********************************/
//      REEMBOLSO MICROSIGA      //
/*********************************/            
Local cAnoBase:= substr(cCompDe,1,4) 
Local cMesBase:= substr(cCompDe,5,2)
Local Chavetrb1:=' ' 
Local Chavetrb7:=' '


If nCustree = 1
   MsProcTxt("Preparando a consulta em  Sql do Reembolso ....... " )
   ProcessMessages()   
aArray := { {"Cod.Forn",;
              "Prefixo ",;
              "Numero"  ,;
              "Parcela" ,;
              "Tipo",;
              "Vlr. Financeiro",;
              "Vlr Custo        "}  }   
 
   cSQL := "SELECT  e2_fornece  , e2_prefixo ,e2_num , e2_parcela ,  e2_tipo ,  e2_valor as Vl_Financeiro , Sum(B45_VLRPAG) as Vl_Custo "
   cSQL += " FROM " + RetSQLName("B44") + " C, "+ RetSQLName("B45") + " D, " + RetSQLName("SE1") + " T, " 
   cSQL += + RetSQLName("BA1") + " U, " + RetSQLName("BA3") + " F, " + RetSQLName("BI3") + " BI3, " 
   cSQL += + RetSQLName("BG9") + " BG9, "+ RetSQLName("ZZT") + " ZZT, " + RetSQLName("SE2") + " SE2 " 

   cSQL += "WHERE E2_FILIAL = '" + xFilial("SE2") + "' AND B45_FILIAL=' ' AND B44_FILIAL=' ' AND BI3_FILIAL=' ' "
   cSQL += "AND E1_FILIAL = '" + xFilial("SE1") + "' AND BA3_FILIAL=' ' AND BA1_FILIAL=' ' AND BG9_FILIAL=' ' AND ZZT_FILIAL=' '" 

   cSQL += " AND E1_PREFIXO = 'RLE' AND B44_CODLDP = B45_CODLDP AND B44_CODPEG = B45_CODPEG AND B44_NUMAUT = B45_NUMAUT"
   cSQL += " AND B44_PREFIX = E1_PREFIXO  AND B44_NUM = E1_NUM  AND BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP"
   cSQL += " AND BA1_MATRIC = BA3_MATRIC  AND BA1_CODINT = B44_OPEUSR AND BA1_CODEMP = B44_CODEMP AND BA1_MATRIC = B44_MATRIC"
   cSQL += " AND BA1_TIPREG = B44_TIPREG  AND BI3_CODINT = BA1_CODINT AND B44_OPEUSR = BG9_CODINT AND B44_CODEMP = BG9_CODIGO"
   cSQL += " AND BI3_CODIGO = Nvl(Trim(BA1_CODPLA),BA3_CODPLA) AND SubStr(e1_emissao ,1,6) = '" + cCompDe+ "' AND SubStr(e1_emissao ,1,6) = '" + cCompAte + "'"
   cSQL += " AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO = E2_TITORIG(+) AND siga.RETORNA_EVENTO_BD5 (B44_OPEUSR,B45_CODLDP,"
   cSQL += " B45_CODPEG,B45_NUMERO,B45_ORIMOV,B45_CODPAD,B45_CODPRO,BA1_MATVID,'C' ) = ZZT_CODEV"

   cSQL += " AND C.D_E_L_E_T_ = ' ' AND D.D_E_L_E_T_ = ' ' AND T.D_E_L_E_T_ = ' ' AND SE2.D_E_L_E_T_ = ' ' AND U.D_E_L_E_T_ = ' ' "
   cSQL += " AND F.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' "

   cSQL += " GROUP BY e2_fornece,e2_prefixo, e2_num, e2_parcela ,  e2_tipo, e2_valor, Nvl(Trim(BA1_CODPLA),BA3_CODPLA) , "
   cSQL += " DECODE (BI3_YGRPLA,'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') ,"
   cSQL += " Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ),"
   cSQL += " siga.SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')),B44_ANOAUT,B44_MESAUT,"
   cSQL += " ZZT_EVENTO,ZZT_TPCUST  , "

   cSQL += " siga.RETORNA_EVENTO_BD5 (B44_OPEUSR,B45_CODLDP,B45_CODPEG,B45_NUMERO,B45_ORIMOV,B45_CODPAD,B45_CODPRO,BA1_MATVID,'C' )"

   cSQL += "ORDER BY e2_num"

   PLSQUERY(cSQL,"Trb5")
 
   	DbSelectArea("Trb5") 
	trb5->(dbGoTop())
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa arquivo de trabalho                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
   While ! Trb5->(eof())  
      If  trb5->Vl_Financeiro  <> Trb5->Vl_custo 
          aAdd(aArray,{ Trb5->e2_fornece ,;
                        Trb5->e2_prefixo ,;
                        Trb5->e2_num     ,;
                         Trb5->e2_parcela ,;
                        Trb5->e2_tipo    ,;
                        Transform(trb5->Vl_Financeiro, pMoeda2),;
                        Transform(trb5->Vl_custo, pMoeda2)})
      
      EndIf
      Trb5->(dbSkip())  
   EndDo
   TRB5->( dbCloseArea() )
  If Len(aArray) > 1
        DlgToExcel({{"ARRAY","","",aArray}}) 
  EndIf  
EndIf                                                   

/*********************************/
//          OPME MICROSIGA       //
/*********************************/


if nCustope = 1    
   MsProcTxt("Preparando a consulta em  Sql do OPME ....... " )
   ProcessMessages()   
aArray := { {"Cod.Forn",;
              "Prefixo ",;
              "Numero"  ,;
              "Parcela" ,;
              "Tipo",;
              "Vlr. Financeiro",;
              "Vlr Custo        "}  }   
              
   cSQL := "SELECT fornecedor , prefixo, num , PARCELA , tipo , valor , SUM(VL_APROV) as VL_APROV "
   cSQL += " FROM (SELECT e2_fornece fornecedor , e2_prefixo prefixo , e2_num num , E2_PARCELA PARCELA , e2_tipo tipo , e2_valor valor , Sum(D1_TOTAL)- max(F1_descont) as Vl_Aprov"

   cSQL += " FROM " + RetSQLName("B19") + " B19 , "+ RetSQLName("SD1") + " SD1, " + RetSQLName("SF1") + " SF1 , " 
   cSQL += + RetSQLName("BD6") + " BD6, " + RetSQLName("SA2") + " SA2, " + RetSQLName("ZZT") + " ZZT, " 
   cSQL += + RetSQLName("BI3") + " BI3, " + RetSQLName("SE2") + " SE2 "  

   cSQL += " WHERE BI3_FILIAL = ' ' AND A2_FILIAL = ' ' AND F1_EMISSAO LIKE '" + cCompDe + "'||'%' AND A2_COD = B19_FORNEC "
   cSQL += " AND D1_FORNECE = A2_COD AND f1_FORNECE = A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM "
   cSQL += " AND BD6_FILIAL = ' ' AND ZZT_FILIAL = ' ' AND BD6_CODPLA = BI3_CODIGO AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "
   cSQL += " AND BD6_CODLDP = SubStr(B19_GUIA,05,04)   AND BD6_CODPEG = SubStr(B19_GUIA,09,08) AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "
   cSQL += " AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)   AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) AND BD6_FASE IN (3,4) AND BD6_CODLDP = '0013' "   
   
   cSQL += " AND BD6_SITUAC = 1 AND siga.RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'C' ) = ZZT_CODEV "
   cSQL += " AND F1_FORNECE = e2_fornece (+) AND F1_LOJA = e2_loja (+) AND F1_SERIE = e2_prefixo (+) AND F1_DOC = e2_Num (+) "
   cSQL += " AND Trim (se2.d_e_l_e_t_) IS NULL AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND SF1.D_E_L_E_T_ = ' '"
   cSQL += " AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' "

   cSQL += " GROUP BY e2_fornece , e2_prefixo , e2_num , E2_PARCELA , e2_tipo , e2_valor )
  
   cSQL += " GROUP BY   fornecedor , prefixo , num , PARCELA , tipo , valor "

   cSQL += "ORDER BY num"

   PLSQUERY(cSQL,"Trb6")

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa arquivo de trabalho                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
    DbSelectArea("Trb6") 
	trb6->(dbGoTop())
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa arquivo de trabalho                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
   While ! Trb6->(eof())  
      If  Trb6->valor <> trb6->VL_APROV
          aAdd(aArray,{ Trb6->fornecedor  ,;
                        Trb6->prefixo     ,;
                        Trb6->num    ,;
                        Trb6->parcela ,;
                        Trb6->tipo     ,;
                        Transform(Trb6->valor , pMoeda2),;
                        Transform(trb6->VL_APROV , pMoeda2)})
      
      EndIf
      Trb6->(dbSkip())  
   EndDo
   TRB6->( dbCloseArea() )
 //  FErase(cArqTRB5 + ".DBF")
 //  FErase(cInd1TRB5 + OrdBagExt()) 
   If Len(aArray) > 1
        DlgToExcel({{"ARRAY","","",aArray}}) 
     EndIf                      
EndIf                                  
                 



  
//*****************************
//Conferencia RDA              
//*****************************  
if nCustrda = 1    
    MsProcTxt("Preparando a consulta em  Sql do Financeiro ....... " )
	ProcessMessages()

       
aArray := { { "Cod.Forn",;
              "Prefixo ",;
              "Numero"  ,;
              "Parcela" ,;
              "Tipo",;
              "Vlr Custo      ",;
              "Vlr Financeiro " ,;
              "Cod.Forn",;
              "Prefixo ",;
              "Numero"  ,;
              "Parcela" ,;
              "Tipo" }  }   
              
  	cSQL1 := " SELECT  e2_fornece fornecedor , e2_prefixo prefixo , e2_num num , e2_parcela parcela , e2_tipo tipo ,  "
   	cSQL1 += " e2_valor , E2_VRETPIS , E2_VRETCOF , E2_VRETCSL , e2_inss , e2_irrf , E2_ISS" 	

	cSQL1 += "  FROM " + RetSQLName("SE2") + " SE2, " + RetSQLName("SA2") + " SA2 "
	cSQL1 += " WHERE e2_filial = '01' "
	cSQL1 += " AND SE2.d_e_l_e_t_ = ' ' "
	cSQL1 += " AND SA2.d_e_l_e_t_ = ' ' "  
	
	cSQL1 += " AND e2_codrda <> ' ' "  
	cSQL1 += " AND e2_origem = 'PLSMPAG' "
	cSQL1 += " AND e2_fornece = a2_cod "    
	cSQL1 += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS')"
	cSQL1 += " AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' " 
	
	if ! empty (cCompAte)                                                               
	   cSQL1 += " AND (E2_ANOBASE || E2_MESBASE) >= '" + cCompDe     + "' "             
	   cSQL1 += " AND (E2_ANOBASE || E2_MESBASE) <= '" + cCompAte     + "' "             
	else                                                                        
	   cSQL1 += " AND E2_emissao  >= '" +  dTos( dDtEmiDe  )   + "' "             
	   cSQL1 += " AND E2_emissao  <= '" +  dTos( dDtEmiAt  )   + "' "             
	EndIf               
   cSQL1 +=" GROUP BY e2_fornece  , e2_prefixo , e2_num , e2_parcela , e2_tipo, e2_valor , E2_VRETPIS , E2_VRETCOF , E2_VRETCSL , e2_inss , e2_irrf , E2_ISS "
   cSQL1 +=" ORDER BY 1 , 2, 3, 4, 5 "
              
   PLSQUERY(cSQL1,"Trb8")         
                     
   MsProcTxt("Preparando a consulta em  Sql do Custo ....... " )
   ProcessMessages()                 
                 
   cSQL :=" SELECT e2_fornece fornecedor , e2_prefixo prefixo , e2_num num , e2_parcela parcela , e2_tipo tipo , Sum(BD7F.VLRPAG) as Vl_Aprov"
   cSQL +=" FROM ("  
          cSQL +=" SELECT BD7.BD7_FILIAL, BD7_CODPLA, SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP, BD7_MATRIC, BD7_TIPREG, sysdate) EXPOS,"
          cSQL +=" BD7.BD7_OPELOT, BD7.BD7_NUMLOT, BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, "
          cSQL +=" BD7.BD7_ORIMOV, BD7_CODPRO, BD7.BD7_SEQUEN, BD6.BD6_QTDPRO, Sum(BD7.BD7_VLRPAG) AS VLRPAG, "
          cSQL +=" COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE"     
          cSQL +=" FROM " + RetSQLName("BD7") + " BD7, " + RetSQLName("BAU") + " BAU, " + RetSQLName("BD6") + " BD6 "
          cSQL +=" WHERE BD7.BD7_FILIAL = ' '"
          cSQL +=" AND BAU_FILIAL = ' '"
          cSQL +=" AND BD6.BD6_FILIAL = ' '"
          cSQL +=" AND BD7.BD7_CODOPE = '0001'"
          cSQL +=" AND BD7.BD7_SITUAC = '1'"
          cSQL +=" AND BD7.BD7_FASE = '4' "
          cSQL +=" AND BD7.BD7_BLOPAG <> '1'"
          cSQL +=" AND BAU.BAU_CODIGO = BD7.BD7_CODRDA"
          cSQL +=" AND BD6.BD6_CODOPE = BD7.BD7_CODOPE"
          cSQL +=" AND BD6.BD6_CODLDP = BD7.BD7_CODLDP"
          cSQL +=" AND BD6.BD6_CODPEG = BD7.BD7_CODPEG"
          cSQL +=" AND BD6.BD6_NUMERO = BD7.BD7_NUMERO"
          cSQL +=" AND BD6.BD6_ORIMOV = BD7.BD7_ORIMOV"
          cSQL +=" AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN"
          cSQL +=" AND BD6.BD6_CODPRO = BD7.BD7_CODPRO" 
          
/*     If cEmpresa  = "I"   
          cSQL +=" AND BD6.BD6_CODPAD<>'07'" 
     ElseIf cEmpresa  = "C"   
          cSQL +=" AND BD6.BD6_CODPAD<>'06'"
     EndIf           
  */      cSQL +=" AND BD6.D_E_L_E_T_ = ' '"
          cSQL +=" AND BD7.D_E_L_E_T_ = ' '"
          cSQL +=" AND BAU.D_E_L_E_T_ = ' '"
          cSQL +=" GROUP BY BD7_FILIAL, BD7_CODPLA,BD7_CODRDA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
          cSQL +=" SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate)"
   cSQL +=" ,BD7_CODPRO, BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, "
   cSQL +=" BD6.BD6_QTDPRO) BD7F,"                      
   cSQL += + RetSQLName("BD6") + " BD6F, " + RetSQLName("BR8") + " BR8, " + RetSQLName("BI3") + " BI3, " + RetSQLName("ZZT") + " ZZT, "  + RetSQLName("SE2") + " SE2 "
   cSQL +=" WHERE E2_FILIAL = '01'"
   cSQL +=" AND ZZT_FILIAL=' '"
   cSQL +=" AND BR8_FILIAL=' '"
   cSQL +=" AND BI3_FILIAL=' '"
   cSQL +=" AND BD6F.BD6_FILIAL = ' ' "
   cSQL +=" AND E2_ANOBASE = '" + cAnobase + "'"    
   cSQL +=" AND E2_MESBASE = '" + cMesbase + "'"  
   cSQL +=" AND E2_ORIGEM = 'PLSMPAG'"
   cSQL +=" AND E2_PLOPELT = BD7F.BD7_OPELOT"
   cSQL +=" AND E2_PLLOTE =  BD7F.BD7_NUMLOT"
   cSQL +=" AND E2_CODRDA = BD7F.BD7_CODRDA "       
                   
   cSQL +=" AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' " 
   
   cSQL +=" AND SE2.D_E_L_E_T_ = ' '"
   cSQL +=" AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL"
   cSQL +=" AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE"
   cSQL +=" AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP"
   cSQL +=" AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG"
   cSQL +=" AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO"
   cSQL +=" AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV"
   cSQL +=" AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN"
   cSQL +=" AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO"
   cSQL +=" AND BR8_FILIAL = BD6_FILIAL"
   cSQL +=" AND BR8_CODPAD = BD6_CODPAD"
   cSQL +=" AND BR8_CODPSA = BD6_CODPRO"
   cSQL +=" AND BI3_FILIAL = BD7_FILIAL"
   cSQL +=" AND BI3_CODINT = BD7_CODOPE"
   cSQL +=" AND BI3_CODIGO = BD7_CODPLA"
   cSQL +=" AND RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,"
   cSQL += "'" + cEmpresa  + "' )=ZZT_CODEV "
   cSQL +=" AND BD6F.D_E_L_E_T_ = ' ' "
   cSQL +=" AND BR8.D_E_L_E_T_ = ' ' "
   cSQL +=" AND BI3.D_E_L_E_T_ = ' ' "
   cSQL +=" AND ZZT.D_E_L_E_T_ = ' ' "
   cSQL +=" GROUP BY e2_fornece , e2_prefixo , e2_num , e2_parcela , e2_tipo   "

   cSQL +=" UNION ALL "

   cSQL +=" SELECT  e2_fornece fornecedor , e2_prefixo prefixo , e2_num num , e2_parcela parcela , e2_tipo tipo , " 
   cSQL +=" Sum(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) as Vl_Aprov "
   cSQL +=" FROM " + RetSQLName("BGQ") + "," + RetSQLName("BBB") + "," + RetSQLName("SE2") + "," + RetSQLName("BI3") + " BI3 , " + RetSQLName("ZZT") + " ZZT "
   cSQL +=" WHERE BGQ_FILIAL = ' ' "
   cSQL +=" AND BGQ_CODLAN <> '050' "
   cSQL +=" AND BBB_FILIAL = ' ' "
   cSQL +=" AND BBB_CODSER = BGQ_CODLAN "
   cSQL +=" AND E2_FILIAL  = '01' "           
   
   cSQL +=" AND e2_fornece >= '" + cForDe + "' AND e2_fornece <= '" + cForAte    + "' " 
   
   cSQL +=" AND BGQ_NUMLOT = E2_PLLOTE "
   cSQL +=" AND ZZT_FILIAL = '  ' "
   cSQL +=" AND BBB_YEVENT = ZZT_CODEV "
   cSQL +=" AND BI3_FILIAL = '  ' "
  // cSQL +=" AND BI3_CODIGO = BBB_YCODPL "
   cSQL +=" AND BI3_CODIGO=NVL( RETORNA_PLANO_USU_MS ('I',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) "
   cSQL +=" AND BGQ_CODIGO = E2_CODRDA "
   cSQL +=" AND E2_ANOBASE||E2_MESBASE = '" + cCompDe + "'" 
   cSQL +=" AND Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)<>0 "
   cSQL +=" AND BI3.D_E_L_E_T_ = ' '"
   cSQL +=" AND ZZT.D_E_L_E_T_ = ' ' "
   cSQL +=" AND " + RetSQLName("BGQ") + ".D_E_L_E_T_ = ' ' "
   cSQL +=" AND " + RetSQLName("BBB") + ".D_E_L_E_T_ = ' '"
   cSQL +=" AND " + RetSQLName("SE2") + ".D_E_L_E_T_ = ' ' "
   cSQL +=" GROUP BY e2_fornece  , e2_prefixo , e2_num , e2_parcela , e2_tipo "
   cSQL +=" ORDER BY 1 , 2, 3, 4 , 5"
   
   PLSQUERY(cSQL,"Trb7")

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa arquivo de trabalho                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    DbSelectArea("Trb7") 
    DbSelectArea("Trb8")
    trb8->(dbGoTop())
    trb7->(dbGoTop())
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa arquivo de trabalho                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	 MsProcTxt("Comparando  Dados....... ")
   	 ProcessMessages() 
   While ( ( ! Trb7->(eof() )) .or. (! TRB8->(Eof() ) ) )
  //   Chavetrb1:=(TRB8->(fornecedor + prefixo  + num     + parcela  + tipo)) 
  //   Chavetrb7:=(trb7->(fornecedor + prefixo  + num     + parcela  + tipo))              
       Vl_Tit :=  (trb8->(e2_valor + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + e2_inss + e2_irrf + E2_ISS)) 	

   
     //if ((TRB1->(TRB_CODIGO + TRB_PREF + TRB_NUM + TRB_PARC + TRB_TIPOE2)) == (trb7->(fornecedor + prefixo  + num     + parcela  + tipo))) 
     if ( (TRB8->(fornecedor + prefixo  + num     + parcela  + tipo)) == (trb7->(fornecedor + prefixo  + num     + parcela  + tipo)))
        If  VL_TIT <> trb7->VL_APROV
            aAdd(aArray,{ Trb7->fornecedor,;
                          Trb7->prefixo   ,;
                          Trb7->num       ,;
                          Trb7->parcela   ,;
                          Trb7->tipo      ,;
                          Transform(trb7->VL_APROV , pMoeda2),;
                          Transform(VL_tit , pMoeda2),;
                          Trb8->fornecedor,;
                          Trb8->prefixo   ,;
                          Trb8->num       ,;
                          Trb8->parcela   ,;
                          Trb8->tipo      })
      
        EndIf
        Trb8->(dbSkip())   
        Trb7->(dbSkip())
     elseif ((TRB8->(fornecedor + prefixo  + num     + parcela  + tipo)) > (trb7->(fornecedor + prefixo  + num + parcela + tipo)))
            aAdd(aArray,{ Trb7->fornecedor,;
                              Trb7->prefixo   ,;
                              Trb7->num       ,;
                              Trb7->parcela   ,;
                              Trb7->tipo      ,;
                              Transform(trb7->VL_APROV , pMoeda2),; 
                              " "," " ," ", " ", " " ," "})
                              
                Trb7->(dbSkip())                                    
     else                                 
            aAdd(aArray,{ " "," " ," ", " ", " " ," ",;
                          Transform(VL_tit , pMoeda2),;
                          Trb8->fornecedor,;
                          Trb8->prefixo   ,;
                          Trb8->num       ,;
                          Trb8->parcela   ,;
                          Trb8->tipo      })
                Trb8->(dbSkip()) 
     EndIf 
   EndDo
   TRB7->( dbCloseArea() )    
   TRB8->( dbCloseArea() )               
  If Len(aArray) > 1
      DlgToExcel({{"ARRAY","","",aArray}}) 
  EndIf
EndIf                                  
                 
Return()

