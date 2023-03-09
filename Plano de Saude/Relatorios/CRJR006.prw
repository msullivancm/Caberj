#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR006 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 03.02.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Pagamentos por RDA                                         ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³                                                            ³±±±
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
User Function CRJR006()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCentury      := __setcentury()
LOCAL aMeses	:= {{'01','JAN'},;
					{'02','FEV'},;
					{'03','MAR'},;
					{'04','ABR'},;
					{'05','MAI'},;
					{'06','JUN'},;
					{'07','JUL'},;
					{'08','AGO'},;
					{'09','SET'},;
					{'10','OUT'},;
					{'11','NOV'},;
					{'12','DEZ'}}

LOCAL n                                                                                               
// Coordenadas para impressao das colunas dinamicas do relatorio...
PRIVATE ACoordenadas := {000, 015, 030, 045, 060, 075, 090, 105, 120, 135, 150, 165, 180, 196}
PRIVATE ACoorExcel	:= {027, 041, 055, 069, 083, 097, 111, 125, 139, 153, 167, 181, 195, 209}
PRIVATE aMesControl := {}
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR006"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Pagamentos por RDA"
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CRJ006"
PRIVATE nRel        := "CRJR006"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Grupo Pagto + Maior para o menor","Grupo Pagto + Nome da RDA","Grupo Pagto + Codigo da RDA"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E  99,999,999.99"
PRIVATE pMoeda2     := "@E  99,999,999.99"
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
cCodOpe	:= mv_par01
cMesDe	:= mv_par02
cAnoDe	:= mv_par03
cMesAte	:= mv_par04
cAnoAte	:= mv_par05
cRdaDe	:= mv_par06
cRdaAte	:= mv_par07
cGruPag	:= mv_par08
lAglut	:= (mv_par09 == 1)
lZero		:= (mv_par10 == 1)
lExcel	:= mv_par11==1

If !lAglut
	cCabec1 := "RDA - Nome"
Else
	cCabec1 := "Grupo de Pagamento"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

cCabec := ''

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montar grade dinamica com os meses envolvidos...						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/* - Definicao das colunas do relatorio... as colunas dos meses serao dinamicas e a sua posicao podera varias de acordo com o intervalo informado nos parametros...
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220         232
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
RDA - Nome                                  
      01/2007        02/2007        03/2007        04/2007        05/2007        06/2007        07/2007        08/2007        09/2007        10/2007        11/2007        12/2007       Total RDA       Media RDA                    
999999-999999999999999999999999999   
99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  99,999,999.99  999,999,999.99  999,999,999.99

*/
cAnoMes := cAnoDe+cMesDe
nMeses  := 0
While (cAnoMes <= (cAnoAte+cMesAte))

	// Serao considerados apenas 12 meses
	nMeses ++
	If nMeses > 12
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula e trata o periodo solicitado...                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cMes := StrZero((Val(Substr(cAnoMes,5,2)) - 1),2)
		cAno := Substr(cAnoMes,1,4)
		If cMes < '01'
			cMes := '12'
			cAno := Alltrim(Str(Val(Substr(cAnoMes,1,4))-1))
		Endif
		cMesAte := cMes
		cAnoAte := cAno
		
		MsgInfo("O intervalo informado é superior a 12 meses. O relatorio ira considerar o periodo entre "+PLRETMES(Val(cMesDe)) + "/" + cAnoDe + '  a  ' + PLRETMES(Val(cMesAte)) + "/" + cAnoAte+". ")
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta array de controle...                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd( aMesControl, cAnoMes )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula e trata o periodo solicitado...                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cMes := StrZero((Val(Substr(cAnoMes,5,2)) + 1),2)
	cAno := Substr(cAnoMes,1,4)
	If cMes > '12'
		cMes := '01'
		cAno := Alltrim(Str(Val(Substr(cAnoMes,1,4))+1))
	Endif
	cAnoMes := cAno+cMes
Enddo

// Monta cabecalho dinamico
cCabec2 := Iif(lExcel,"GRP  Rede de Atendimento"+space(9),"")
For n := 1 To Len(aMesControl)
             
	// O primeiro espacamento eh menor que os demais...
	If lExcel
		cCabec2 += Substr(aMesControl[n],5,2)+'/'+Substr(aMesControl[n],1,4)+Iif(n==Len(aMesControl),Space(5),Space(7))
	Else	
		If n == 1
			cCabec2 += Space(06)
		
		Else
			cCabec2 += Space(08)
		
		Endif
		// Incrementa cabecalho...
		cCabec2 += Substr(aMesControl[n],5,2)+'/'+Substr(aMesControl[n],1,4)
		
	Endif	
	
Next

// Incrementa as duas ultimas colunas do relatorio...
If lExcel
	cCabec2 += "Total RDA"+Space(5)+"Media RDA"
Else
	If !lAglut
		cCabec2 += Space(08)+"Total RDA"+Space(8)+"Media RDA"
	Else
		cCabec2 += Space(08)+"Total GRP"+Space(8)+"Media GRP"
	Endif
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
LOCAL nOrdem	:= aReturn[8]
LOCAL cSQL
LOCAL n
local ni
local nj
local nL
LOCAL nPos		:= 0
LOCAL cQuebra	:= ''	
LOCAL aTotais	:= Array(Len(aMesControl))
Local aTotGRP	:= {} 
Local aGrp		:= {}
LOCAL cCodRda	:= ''
Local aCampoTRB := {	{ "TRB_CODIGO"    	, "C", TamSX3("BAU_CODIGO")[1]	, 0 },;
						{ "TRB_NOME" 		, "C", TamSX3("BAU_NOME")[1]	, 0 },;
						{ "TRB_GRPPAG"		, "C", TamSX3("BAU_GRPPAG")[1]	, 0 },;
						{ "TRB_DESGRP"		, "C", 20						, 0 },;
						{ "TRB_TOTAL"		, "N", TamSX3("BM1_VALOR")[1]	, 2	}}						

// Monta campos dinamicos de acordo com a quantidade de meses que serao listados no relatorio...
For n := 1 To Len(aMesControl)
	Aadd(aCampoTRB, {("TRB_AM"+StrZero(n,2)),"N", TamSX3("BM1_VALOR")[1]	, 2})
Next

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
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(cMesDe)) + "/" + cAnoDe + '  a  ' + PLRETMES(Val(cMesAte)) + "/" + cAnoAte

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
Endif
	
cSQL += "D_E_L_E_T_ = ''"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena de acordo com a configuracao de impressao...                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If nOrdem == 1
//	cSQL += "ORDER BY BAU_CODIGO "
//Elseif nOrdem == 1
	cSQL += "ORDER BY BAU_NOME "
//Else
//	cSql += "ORDER BY BAU_GRPPAG"
//Endif

PLSQUERY(cSQL,"TrbBAU")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define valor padrao para os elementos da matriz totalizadora...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For n := 1 To Len(aTotais)
	aTotais[n] := 0
Next
                          
// A definicao de aTotGrp eh a mesma de aTotais... aTotGrp = Totais do grupo e aTotais = Total geral do relatorio...                    
aTotGrp := aClone(aTotais)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampoTRB, .T.)
		
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)
		
If !lAglut
	IndRegua("TRB1",cInd1TRB,"TRB_GRPPAG + TRB_CODIGO",,,"Indexando Arquivo de Trabalho")
	TRB1->( dbClearIndex() )
	
Else
	IndRegua("TRB1",cInd1TRB,"TRB_GRPPAG",,,"Indexando Arquivo de Trabalho")
	TRB1->( dbClearIndex() )
	
EndIf

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))

TRB1->( dbSetorder(01) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cada RDA                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! TrbBAU->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Verificando... " + Left(AllTrim(BAU->BAU_NOME),30))
	ProcessMessages()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona BAU-Rede de Atendimento                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbGoTo(TrbBAU->BAU_RECNO))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona SA2-Fornecedores                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SA2->(msSeek(xFilial("SA2")+BAU->(BAU_CODSA2+BAU_LOJSA2)))
	
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
	
	For n := 1 To Len(aMesControl)
		cMes := Substr(aMesControl[n],5,2)
		cAno := Substr(aMesControl[n],1,4)
		
		// Primeiro dia do mes
//		dInicio := cTod("01/"+cMes+"/"+cAno)
		
		// Ultimo dia do mes...
//		dFinal	:= LastDay(cTod("01/"+cMes+"/"+cAno))
		
		cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
		cSQL += "  FROM " + RetSQLName("SE2")
		cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
		cSql += "	 AND E2_ANOBASE+E2_MESBASE = '"+cAno+cMes+"' "
		cSQL += "    AND D_E_L_E_T_ = ' ' "
		cSQL += " ORDER BY E2_VENCTO "
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Executa query                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		PLSQUERY(cSQL,"Trb")
	
		If !lAglut
			lFound := TRB1->( MsSeek(BAU->BAU_GRPPAG + BAU->BAU_CODIGO) )
			
		Else
			lFound := TRB1->( MsSeek(BAU->BAU_GRPPAG) )
			
		Endif
		
		TRB1->( RecLock("TRB1", !lFound) )
		
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TRB_CODIGO 	:= BAU->BAU_CODIGO
			TRB1->TRB_NOME		:= BAU->BAU_NOME
			TRB1->TRB_GRPPAG	:= BAU->BAU_GRPPAG
			TRB1->TRB_DESGRP	:= Iif(!Empty(BAU->BAU_GRPPAG), cDesGrp, "Nao classificados")
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa arquivo de trabalho                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While ! Trb->(eof())
			// Posiciona o titulo fisicamente no SE2.
			SE2->(dbGoTo(Trb->E2_RECNO))
		
			// Ignora os titulos de impostos
			If (SE2->E2_TIPO == MVINSS .And. ;
				IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
				SE2->E2_TIPO == MVTAXA
				Trb->(dbSkip())
				Loop
			Endif
		
			If  empty(SE2->E2_PARCELA) // indica que eh o titulo principal
			                             
				// Não considera mais os titulos pela baixa e sim pela geração...
				// Solicitação de Paulo Auriemma realizada em 13-03-08.
				/*
				// Processa as baixas. - 
				nVlrBx := 0
				If SE5->( MsSeek(xFilial("SE5")+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA) )
				
					While !SE5->( Eof() ) .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA ==;
												SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
		
						// Ignora descontos, juros, cancelamentos, recebimentos e outros tipos...
						If 	SE5->E5_RECPAG == 'R' .or.;
							SE5->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN") .or.;
							(SE5->E5_TIPODOC $ "DC, D2, JR, J2, TL, MT, M2, CM, C2, TR, TE")
			
							SE5->( dbSkip() )
							Loop
						Endif
						
						// Desconsidera adiantamentos no mes...
						If !(Alltrim(SE5->E5_TIPODOC) == 'CP' .and. Alltrim(SE5->E5_MOTBX) == 'CMP')
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
										
							nVlrBx += SE5->E5_VALOR
							nVlrBx -= nVlrEst
							
						Endif
				
						SE5->( dbSkip() )
					Enddo
				Endif	   
				*/
				// Acumula no campo referente ao mes do titulo
				&("TRB1->TRB_AM"+StrZero(n,2)) += SE2->E2_VALOR
				
				// Totaliza
				TRB1->TRB_TOTAL += SE2->E2_VALOR
				
			Endif
			
			Trb->(dbSkip())			
		Enddo
		Trb->( dbCloseArea() )
	Next

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa proximo registro                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TrbBAU->(DbSkip())
Enddo

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220         232
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
RDA - Nome                                  
      01/2007         02/2007         03/2007         04/2007         05/2007         06/2007         07/2007         08/2007         09/2007         10/2007         11/2007         12/2007        Total RDA        Media RDA
999999-999999999999999999999999999   
99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   99,999,999.99   999,999,999.99   999,999,999.99
*/
    
// Inicio da impressao dos dados...
MsProcTxt("Aguarde... gerando impressao!")
ProcessMessages()

// Descarrega os valores mensais da RDA...
If !lAglut
	TRB1->( dbClearIndex() )
	
	cInd1TRB := CriaTrab(Nil, .F.)	
	dbSelectArea("TRB1")
	If nOrdem == 1
	    // Grupo + maior para o menor
	    cChave := "TRB_GRPPAG + DESCEND(STR(TRB_TOTAL))"
		IndRegua("TRB1",cInd1TRB,cChave,,,"Indexando Arquivo de Trabalho")		    
		
	Elseif nOrdem == 2
		// Grupo + nome da RDA
		IndRegua("TRB1",cInd1TRB,"TRB_GRPPAG + TRB_NOME",,,"Indexando Arquivo de Trabalho")		    
			
	Else
		// Grupo + codigo da RDA.
		IndRegua("TRB1",cInd1TRB,"TRB_GRPPAG + TRB_CODIGO",,,"Indexando Arquivo de Trabalho")		    
				
	Endif

	TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
Endif

nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
TRB1->( dbSetorder(01) )
TRB1->( dbGotop() )             

nTotLinha := 0	          
aTest := {}

While !TRB1->( Eof() )
	// Controle para nao imprimir os zerados...
	If !lZero .and. TRB1->TRB_TOTAL  <= 0
		TRB1->( dbSkip() )
		Loop
	Endif
	
	If nOrdem == 1
		If (nPos := Ascan(aGrp, {|x| x[1] == TRB1->TRB_GRPPAG}) )  == 0
			Aadd(aGrp, { TRB1->TRB_GRPPAG, TRB1->TRB_DESGRP, {{TRB1->TRB_CODIGO, TRB1->TRB_NOME,0,Array(Len(aMesControl))}} })
			nPos := Len(aGrp)
			
			Afill(aGrp[nPos][3][1][4], 0) // Define 0 para os novos itens criados na matriz
		Endif
		
	Endif

	// Define quebra
	cQuebra := TRB1->TRB_GRPPAG
	cCampo  := "TRB1->TRB_GRPPAG"
	
	// Controle de saldo de pagina...
	If nOrdem <> 1
		If  nli > nLinPag
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nLi++
		Endif
		
		@ nLi, 000 Psay cQuebra + '-' + TRB1->TRB_DESGRP
		nLi++
	Endif
	
	While !TRB1->( Eof() ) .and. &cCampo == cQuebra
		// Controle para nao imprimir os zerados...
		If !lZero .and. TRB1->TRB_TOTAL  <= 0
			TRB1->( dbSkip() )
			Loop
			
		Endif
		
		// Controle de saldo de pagina...
		If nOrdem <> 1
			If  nli > nLinPag
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nLi++
				
				// Imprime a rda...
				If !lAglut
					@ nLi, 000 Psay TRB1->TRB_CODIGO + '-' + TRB1->TRB_NOME
					cCodRDA := TRB1->TRB_CODIGO
					nLi++
				Endif
			Endif
			
			// Imprime a rda...
			If !lAglut .and. cCodRDA <> TRB1->TRB_CODIGO
				@ nLi, 000 Psay TRB1->TRB_CODIGO + '-' + TRB1->TRB_NOME
				cCodRDA := TRB1->TRB_CODIGO
				nLi++
			Endif

		Endif

		// Atualiza o codigo e o nome do medico      
		If nOrdem == 1
			If (nPsRda := Ascan(aGrp[nPos][3], {|x| x[1] == TRB1->TRB_CODIGO})) == 0
				Aadd(aGrp[nPos][3], {TRB1->TRB_CODIGO,TRB1->TRB_NOME,0,Array(Len(aMesControl))})
				
				nPsRda := Len(aGrp[nPos][3])
				Afill(aGrp[nPos][3][nPsRda][4], 0) // Define 0 para os novos itens criados na matriz
			Endif
		Endif
		
		// Obtem a coordenada da coluna referente ao ano/mes do prestador...
		For n := 1 To Len(aMesControl)
			
			If nOrdem <> 1
				If lExcel
					@ nLi, ACoorExcel[n] Psay Transform(&("TRB1->TRB_AM"+StrZero(n,2)),pMoeda1)
				Else
					@ nLi, aCoordenadas[n] Psay Transform(&("TRB1->TRB_AM"+StrZero(n,2)),pMoeda1)
				Endif
				
				// Total do relatorio
				aTotais[n] += &("TRB1->TRB_AM"+StrZero(n,2))
				
				// Total do grupo
				aTotGrp[n] += &("TRB1->TRB_AM"+StrZero(n,2))
				
			Else
				// Acumula totais
				aGrp[nPos][3][nPsRda][4][n] += &("TRB1->TRB_AM"+StrZero(n,2))
				aGrp[nPos][3][nPsRda][3] += &("TRB1->TRB_AM"+StrZero(n,2))				
				
				// Total do relatorio
				aTotais[n] += &("TRB1->TRB_AM"+StrZero(n,2))
			Endif
			
		Next
		
		// Imprime as ultimas duas colunas do relatorio...
		If nOrdem <> 1

			If lExcel
				@ nLi, ACoorExcel[(Len(aMesControl)+1)] Psay Transform(TRB1->TRB_TOTAL,pMoeda2)
				@ nLi, ACoorExcel[(Len(aMesControl)+2)] Psay Transform((TRB1->TRB_TOTAL/Len(aMesControl)),pMoeda2)
			Else
				@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(TRB1->TRB_TOTAL,pMoeda2)
				@ nLi, aCoordenadas[(Len(aMesControl)+2)] Psay Transform((TRB1->TRB_TOTAL/Len(aMesControl)),pMoeda2)
			Endif
			
			nLi += 2
		Endif
		TRB1->( dbSkip() )
	Enddo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais do GRUPO...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lAglut
		IF nOrdem <> 1
			If  nli > nLinPag
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
			Endif
			
			@ nLi, 000 Psay Replicate('-', nLimite)
			nLi++
			
			@ nLi, 000 Psay "Totais do grupo"
			nLi++
			
			nTotLinha := 0
			For n := 1 To Len(aTotGrp)
				// Imprime a linha
				If lExcel
					@ nLi, ACoorExcel[n] Psay Transform(aTotGrp[n], pMoeda1)				
				Else
					@ nLi, aCoordenadas[n] Psay Transform(aTotGrp[n], pMoeda1)
				Endif
				
				// Totaliza a linha...
				nTotLinha += aTotGrp[n]
				
				// Zera matriz para ser utilizada pelo proximo grupo...
				aTotGrp[n] := 0
			Next
			
			// Imprime as ultimas duas colunas do relatorio...
			If lExcel
				@ nLi, ACoorExcel[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)
				@ nLi, ACoorExcel[(Len(aMesControl)+2)] Psay Transform((nTotLinha/Len(aMesControl)),pMoeda2)			
			Else			
				@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)
				@ nLi, aCoordenadas[(Len(aMesControl)+2)] Psay Transform((nTotLinha/Len(aMesControl)),pMoeda2)
			Endif
			
			nLi++
			@ nLi, 000 Psay Replicate('-', nLimite)
			
			nLi += 2
		Endif
	Else
		nLi += 1
	Endif
	
Enddo

// Ordena o grupo..
aSort(aGrp,,,{|x,y| x[1] < y[1]})

For n := 1 To Len(aGrp)
	aAuxGrp := aClone( aGrp[n][3] )

	// Controle de saldo de pagina...
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,Iif(lExcel,"Relatorio modelo integraçÃo Excel",cCabec2),cNomeProg,cTamanho,nCaracter)
		nLi++
		
		//Em Excel, deve-se mprimir o cabecalho como linha, para facilitar a integracao...
		If lExcel
			@ nLi, 000 Psay cCabec2
			nLi++		
		Endif
	Endif

	//Caso seja excel, mudar o layout do arquivo de saida...
	If !lExcel
		@ nLi, 000 Psay aGrp[n][1] + '-' + aGrp[n][2]
		nLi++
	Endif
		
	aSort(aAuxGrp,,,{|x, y| x[3] > y[3]} ) // Ordena do maior para o menor
	aTotGrp := Array(Len(aTotais))

	Afill(aTotGrp, 0) // Define 0 para os novos itens criados na matriz	
	For nI := 1 To Len(aAuxGrp)
		If  nli > nLinPag
			nli := Cabec(cTitulo,cCabec1,Iif(lExcel,"Relatorio modelo integraçÃo Excel",cCabec2),cNomeProg,cTamanho,nCaracter)
			nLi++				
			
			// Imprime a rda...
			If lExcel
				@ nLi, 000 Psay cCabec2
				nLi++					
				@ nLi, 000 Psay aGrp[n][1] + '-' + aAuxGrp[nI][1] + '-' + Substr(aAuxGrp[nI][2],1,15)
			Else
				@ nLi, 000 Psay aAuxGrp[nI][1] + '-' + aAuxGrp[nI][2]
				nLi++
			Endif
			cCodRDA := aAuxGrp[nI][1]
			
		Endif
			
		// Imprime a rda...
		If !lAglut .and. cCodRDA <> aAuxGrp[nI][1]

			// Imprime a rda...
			If lExcel
				@ nLi, 000 Psay aGrp[n][1] + '-' + aAuxGrp[nI][1] + '-' + Substr(aAuxGrp[nI][2],1,15)
			Else
				@ nLi, 000 Psay aAuxGrp[nI][1] + '-' + aAuxGrp[nI][2]
				nLi++				
			Endif
			cCodRDA := aAuxGrp[nI][1]			
				
		Endif	

		For nJ := 1 To Len(aAuxGrp[nI][4])
			
			If lExcel
				@ nLi, ACoorExcel[nJ] Psay Transform(aAuxGrp[nI][4][nJ],pMoeda1)
			Else
				@ nLi, aCoordenadas[nJ] Psay Transform(aAuxGrp[nI][4][nJ],pMoeda1)
			Endif
	
			If nJ <= Len(aTotGrp)
				aTotGrp[nJ] += aAuxGrp[nI][4][nJ]
			Endif
		Next 

		// Imprime as ultimas duas colunas do relatorio...
		If lExcel
			@ nLi, aCoorExcel[(Len(aMesControl)+1)] Psay Transform(aAuxGrp[nI][3],pMoeda2)
			@ nLi, aCoorExcel[(Len(aMesControl)+2)] Psay Transform((aAuxGrp[nI][3]/Len(aMesControl)),pMoeda2)
		Else
			@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(aAuxGrp[nI][3],pMoeda2)
			@ nLi, aCoordenadas[(Len(aMesControl)+2)] Psay Transform((aAuxGrp[nI][3]/Len(aMesControl)),pMoeda2)
		Endif
	
		nLi += Iif(lExcel,1,2)
		
	Next
	
	//Caso seja excel, nao imprime os totais...
	If !lExcel

		@ nLi, 000 Psay "Totais do grupo"
		nLi++
	
		@ nLi, 000 Psay Replicate('-', nLimite)
		nLi++
		
		nTotLinha := 0
		For nL := 1 To Len(aTotGrp)
			If lExcel
				@ nLi, aCoorExcel[nL] Psay Transform(aTotais[nL], pMoeda1)
			Else
				@ nLi, aCoordenadas[nL] Psay Transform(aTotais[nL], pMoeda1)
			Endif
			nTotLinha += aTotais[nL]
		Next
	
		// Imprime as ultimas duas colunas do relatorio...
		@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)
		@ nLi, aCoordenadas[(Len(aMesControl)+2)] Psay Transform((nTotLinha/Len(aMesControl)),pMoeda2)			      
		nLi++
		@ nLi, 000 Psay Replicate('-', nLimite)
		
		nLi+=2	
		
	Endif
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os totais do relatorio (caso nao seja excel)               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lExcel

	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	@ nLi, 000 Psay "Totais do relatorio"
	nLi++
	
	@ nLi, 000 Psay Replicate('-', nLimite)
	nLi++
	
	nTotLinha := 0
	For n := 1 To Len(aTotais)
		If lExcel
			@ nLi, aCoorExcel[n] Psay Transform(aTotais[n], pMoeda1)
		Else
			@ nLi, aCoordenadas[n] Psay Transform(aTotais[n], pMoeda1)
			nTotLinha += aTotais[n]
		Endif
	Next
	
	// Imprime as ultimas duas colunas do relatorio...
	@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)
	@ nLi, aCoordenadas[(Len(aMesControl)+2)] Psay Transform((nTotLinha/Len(aMesControl)),pMoeda2)
	
Endif
	
TRB1->( dbCloseArea() )

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
Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}

aadd(aRegs,{cPerg,"01","Operadora ?           ","","","mv_ch1","C", 4,0,0,"G",""				,"mv_par01",""      ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes De ?              ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()"	,"mv_par02",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano De ?              ","","","mv_ch3","C", 4,0,0,"G",""           	,"mv_par03",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","Mes Ate ?             ","","","mv_ch4","C", 2,0,0,"G","PlsVldMes()"	,"mv_par04",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"05","Ano Ate ?             ","","","mv_ch5","C", 4,0,0,"G",""				,"mv_par05",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"06","RDA De ?              ","","","mv_ch6","C", 6,0,0,"G",""				,"mv_par06",""      ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"07","RDA Ate ?             ","","","mv_ch7","C", 6,0,0,"G",""				,"mv_par07",""      ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"08","Grupo de pegamento ?  ","","","mv_ch8","C", 4,0,0,"G",""				,"mv_par08",""      ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BRZPLS",""})
aadd(aRegs,{cPerg,"09","Aglutina por Grupo ?  ","","","mv_ch9","N", 1,0,0,"C",""				,"mv_par09","Sim"	,"","","","","Nao"      ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"10","Imprimir zerados   ?  ","","","mv_cha","N", 1,0,0,"C",""				,"mv_par10","Sim"	,"","","","","Nao"      ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"11","Ajusta para Excel  ?  ","","","mv_chb","N", 1,0,0,"C",""				,"mv_par11","Sim"	,"","","","","Nao"      ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
		                                                                                                                                                                   
PlsVldPerg( aRegs )
Return