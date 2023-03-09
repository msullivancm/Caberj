#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR007 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 03.02.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Produção medica sem valorizacao                            ³±±±
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
User Function CRJR007()

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
PRIVATE aMesControl := {}
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR007"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Produção medica sem valorizacao"
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CRJ007"
PRIVATE nRel        := "CRJR007"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Grupo Pagto + Nome da RDA","Grupo Pagto + Codigo da RDA"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E  9999999999999"
PRIVATE pMoeda2     := "@E 99999999999999"
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
_cMes	:= mv_par02
_cAno	:= mv_par03
cRdaDe	:= mv_par04
cRdaAte	:= mv_par05
cGruPag := mv_par06
cLocal	:= mv_par07
nFase	:= mv_par08
lAnalit	:= (mv_par09 == 1)
lPegs	:= (mv_par10 == 1)

cCabec1 := "RDA - Nome"

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

// Sempre olha seis meses anteriores...
cAnoMes := _cAno+_cMes
nMeses  := 0
For n := 1 To 6

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta array de controle...                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd( aMesControl, cAnoMes )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula e trata o periodo solicitado...                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cMes := StrZero((Val(Substr(cAnoMes,5,2)) - 1),2)
	cAno := Substr(cAnoMes,1,4)
	If cMes < '01'
		cMes := '12'
		cAno := Alltrim(Str(Val(Substr(cAnoMes,1,4)) - 1))
	Endif
	cAnoMes := cAno+cMes
Next

// Ordena os meses do menor para o maior
Asort(aMesControl)


// Monta cabecalho dinamico
cCabec2 := ''
For n := 1 To Len(aMesControl)
             
	// O primeiro espacamento eh menor que os demais...
	If n == 1
		cCabec2 += Space(06)
	
	Else
		cCabec2 += Space(08)
	
	Endif
	// Incrementa cabecalho...
	cCabec2 +=	Substr(aMesControl[n],5,2)+'/'+Substr(aMesControl[n],1,4)

Next

// Incrementa as duas ultimas colunas do relatorio...
cCabec2 += Space(08)+"Total de guias da RDA"

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
LOCAL cQuebra	:= ''	
LOCAL aTotais	:= Array(Len(aMesControl))
Local aTotGRP	:= {}
LOCAL aGuias	:= {}
LOCAL cCodRda	:= ''
Local aCampoTRB := {	{ "TRB_CODIGO"    	, "C", TamSX3("BAU_CODIGO")[1]	, 0 },;
						{ "TRB_NOME" 		, "C", TamSX3("BAU_NOME")[1]	, 0 },;
						{ "TRB_GRPPAG"		, "C", TamSX3("BAU_GRPPAG")[1]	, 0 },;
						{ "TRB_DESGRP"		, "C", 20						, 0 },;
						{ "TRB_LOCAL"		, "C", 04						, 0 },;
						{ "TRB_FASE"		, "C", 01						, 0 },;						
						{ "TRB_TOTAL"		, "N", 13						, 0	}}

LOCAL aCampos	:= {	{"TR2_FASE"			, "C", 01						, 0 },;						
						{"TR2_CODIGO"    	, "C", TamSX3("BAU_CODIGO")[1]	, 0 },;
						{"TR2_CODOPE"		, "C", TamSX3("BD7_CODOPE")[1]	, 0 },;
						{"TR2_CODLDP"		, "C", TamSX3("BD7_CODLDP")[1]	, 0 },;
						{"TR2_CODPEG"		, "C", TamSX3("BD7_CODPEG")[1]	, 0 },;
						{"TR2_NUMERO"		, "C", TamSX3("BD7_NUMERO")[1]	, 0 },;
						{"TR2_ORIMOV"		, "C", TamSX3("BD7_ORIMOV")[1]	, 0 }}
						
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
MsProcTxt("Selecionando Dados...")
ProcessMessages()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(cMes)) + "/" + cAno +' a '+PLRETMES(Val(_cMes)) + "/" + _cAno
                         
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
		
If lAnalit
	IndRegua("TRB1",cInd1TRB,"TRB_FASE + TRB_GRPPAG + TRB_CODIGO + TRB_LOCAL",,,"Indexando Arquivo de Trabalho")
	TRB1->( dbClearIndex() )
	
Else
	IndRegua("TRB1",cInd1TRB,"TRB_FASE + TRB_GRPPAG + TRB_LOCAL ",,,"Indexando Arquivo de Trabalho")
	TRB1->( dbClearIndex() )
	
EndIf

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))

TRB1->( dbSetorder(01) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB2 := CriaTrab(aCampos, .T.)
		
dbUseArea(.T.,,cArqTRB2,"TRB2",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB2 := CriaTrab(Nil, .F.)
IndRegua("TRB2",cInd1TRB2,"TR2_FASE + TR2_CODIGO + TR2_CODOPE + TR2_CODLDP + TR2_CODPEG + TR2_NUMERO + TR2_ORIMOV",,,"Indexando Arquivo de Trabalho")
TRB2->( dbClearIndex() )
	
TRB2->(dbSetIndex(cInd1TRB2 + OrdBagExt()))

TRB2->( dbSetorder(01) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta  no BD7  			                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSql := " SELECT BD7_ORIMOV, BD7_NUMERO, BD7_CODPEG, BD7_CODOPE, BD7_CODRDA, BD7_CODLDP, BD7_FASE, BD7_ANOPAG, BD7_MESPAG "
cSql += "   FROM " + RetSQLName("BD7")
cSql += "  WHERE BD7_FILIAL = '" + xFilial("BD7") + "' And "

cSql += "BD7_ANOPAG+BD7_MESPAG BETWEEN '" + cAno+cMes + "' AND '"+ _cAno+_cMes +"' AND "
cSql += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "

If     nFase == 1 // Digitacao...
	cSql += "BD7_FASE = '1' AND BD7_SITUAC = '1' "
	
ElseIf nFase == 2 // conferencia...
	cSql += "BD7_FASE = '2' AND BD7_SITUAC <> '2' "
	
Else 	// Ambas..
	cSql += "(BD7_FASE = '2' AND BD7_SITUAC <> '2'  OR BD7_FASE = '1' AND BD7_SITUAC = '1')"
EndIf

If !Empty(cLocal)
	cSql += " AND BD7_CODLDP = '" + cLocal + "' "
Endif
cSql += " AND " + RetSQLName("BD7")+".D_E_L_E_T_ = ' '"

cSql += " ORDER BY BD7_CODRDA + BD7_CODLDP + BD7_FASE + BD7_ANOPAG + BD7_MESPAG "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta ordem                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSQuery(cSql,"TrbBD7")

BAU->( dbSetorder(01) )
While !TrbBD7->( Eof() )
                                                                                  
	cQuebra := TrbBD7->( BD7_CODRDA + BD7_CODLDP + BD7_FASE + BD7_ANOPAG + BD7_MESPAG )
	lLoop := .F.

	cCodRda := ''
	While !TrbBD7->( Eof() ) .and. TrbBD7->( BD7_CODRDA + BD7_CODLDP + BD7_FASE + BD7_ANOPAG + BD7_MESPAG ) == cQuebra
	    
	    // Algo deu errado, irei abandonar esta quebra...
	    If lLoop
	    	TRBBD7->( dbSkip() )
	    	Loop
	    Endif
	    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona BAU-Rede de Atendimento                                        ³	
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cCodRda <> TrbBD7->BD7_CODRDA
			cCodRda := TrbBD7->BD7_CODRDA
			If !BAU->( MsSeek(xFilial("BAU")+TrbBD7->BD7_CODRDA) )
				lLoop := .T.				
			
				TrbBD7->( dbSkip() )
				Loop
			Endif
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mensagem de processamento                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MsProcTxt("Processando... " + BAU->BAU_CODIGO+'-'+Left(AllTrim(BAU->BAU_NOME),30))
			ProcessMessages()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a RDA pertence ao grupo de pagamento                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  ! empty(cGruPag) .and. ! BAU->BAU_GRPPAG $ cGruPag
				lLoop := .T.
				
				TrbBD7->(DbSkip())
				Loop
			Endif
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a RDA existe para a operadora desejada                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BAW->(DbSetOrder(1))
			If  ! BAW->(msSeek(xFilial("BAW")+BAU->BAU_CODIGO+cCodOpe))
				lLoop := .T.
			
				TrbBD7->(DbSkip())
				Loop
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Descricao do grupo de pagamento...                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cDesGrp := ''
			If B16->( MsSeek(xFilial("B16")+BAU->BAU_GRPPAG) )
				cDesGrp := B16->B16_DESCRI
			Endif
		Endif
			
		If lAnalit
			lFound := TRB1->( MsSeek(TRBBD7->BD7_FASE + BAU->BAU_GRPPAG + BAU->BAU_CODIGO + TRBBD7->BD7_CODLDP ) )
			
		Else
			lFound := TRB1->( MsSeek(TRBBD7->BD7_FASE + BAU->BAU_GRPPAG + TRBBD7->BD7_CODLDP) )
			
		Endif
		
		TRB1->( RecLock("TRB1", !lFound) )
		
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TRB_CODIGO 	:= BAU->BAU_CODIGO
			TRB1->TRB_NOME		:= BAU->BAU_NOME
			TRB1->TRB_GRPPAG	:= BAU->BAU_GRPPAG
			TRB1->TRB_DESGRP	:= Iif(!Empty(BAU->BAU_GRPPAG), cDesGrp, "Nao classificados")
			TRB1->TRB_FASE		:= TRBBD7->BD7_FASE
			TRB1->TRB_LOCAL		:= TRBBD7->BD7_CODLDP
			
			// Soma guia no mes/ano
			If (nPos := Ascan(aMesControl, TRBBD7->(BD7_ANOPAG+BD7_MESPAG))) > 0
				&("TRB1->TRB_AM"+StrZero(nPos,2)) += 1
				TRB1->TRB_TOTAL ++
				
				// Grava a guia no arquivo temporario para informar que ela ja foi contada...
				TRB2->( RecLock("TRB2", .T.) )
					TRB2->TR2_FASE	 	:= TRBBD7->BD7_FASE
					TRB2->TR2_CODIGO 	:= BAU->BAU_CODIGO
					TRB2->TR2_CODOPE	:= TRBBD7->BD7_CODOPE
					TRB2->TR2_CODLDP	:= TRBBD7->BD7_CODLDP
					TRB2->TR2_CODPEG	:= TRBBD7->BD7_CODPEG
					TRB2->TR2_NUMERO	:= TRBBD7->BD7_NUMERO
					TRB2->TR2_ORIMOV	:= TRBBD7->BD7_ORIMOV
				TRB2->( MsUnlock() )
				
			Endif
		Else
			// Como uma guia possui varios BD7, verifico se a guia ja foi contata... a guia so entra uma vez na contagem...
			If !TRB2->( dbSeek(TRBBD7->BD7_FASE+;
								BAU->BAU_CODIGO+;
								TRBBD7->BD7_CODOPE+;
								TRBBD7->BD7_CODLDP+;
								TRBBD7->BD7_CODPEG+;
								TRBBD7->BD7_NUMERO+;
								TRBBD7->BD7_ORIMOV) )
								
				// Soma guia no mes/ano
				If (nPos := Ascan(aMesControl, TRBBD7->(BD7_ANOPAG+BD7_MESPAG))) > 0
					&("TRB1->TRB_AM"+StrZero(nPos,2)) += 1
					TRB1->TRB_TOTAL ++
				Endif
				
				// Adiciona a guia na matriz para informar que ela ja foi contada...
				TRB2->( RecLock("TRB2", .T.) )
					TRB2->TR2_FASE	 	:= TRBBD7->BD7_FASE
					TRB2->TR2_CODIGO 	:= BAU->BAU_CODIGO
					TRB2->TR2_CODOPE	:= TRBBD7->BD7_CODOPE
					TRB2->TR2_CODLDP	:= TRBBD7->BD7_CODLDP
					TRB2->TR2_CODPEG	:= TRBBD7->BD7_CODPEG
					TRB2->TR2_NUMERO	:= TRBBD7->BD7_NUMERO
					TRB2->TR2_ORIMOV	:= TRBBD7->BD7_ORIMOV
				TRB2->( MsUnlock() )
			Else
				TRB2->( MsUnlock() )
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa proximo registro                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TrbBD7->(DbSkip())
	Enddo
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho													 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbBD7->( DbCloseArea() )
                          
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

nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
TRB1->( dbSetorder(01) )
TRB1->( dbGotop() )

nTotLinha 	:= 0	          
cFase			:= ''
cCodRDA		:= ''
While !TRB1->( Eof() )
	// Controle de saldo de pagina...
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nLi++
	Endif
	
	// Define quebra por faze, caso seja definido ambas...
	cQuebra := TRB1->TRB_FASE + TRB1->TRB_GRPPAG	
	cCampo  := "TRB1->TRB_FASE + TRB1->TRB_GRPPAG"
                             
	If cFase <> TRB1->TRB_FASE   
		@ nLi, 000 Psay cFase 
		nLi++
		
		cFase	:= TRB1->TRB_FASE
	Endif

	@ nLi, 000 Psay cQuebra + ' - ' + TRB1->TRB_DESGRP
	nLi++
	
	While !TRB1->( Eof() ) .and. &cCampo == cQuebra
		// Controle de saldo de pagina...
		If  nli > nLinPag
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nLi++
			
			@ nLi, 000 Psay TRB1->TRB_CODIGO + '-' + TRB1->TRB_NOME
			cCodRDA := TRB1->TRB_CODIGO
			nLi++
			
		Endif
		
		// Imprime a rda...
		If cCodRDA <> TRB1->TRB_CODIGO 
			@ nLi, 000 Psay TRB1->TRB_CODIGO + '-' + TRB1->TRB_NOME
			cCodRDA := TRB1->TRB_CODIGO
			nLi++
		Endif
		
		// Imprime o local de digitação...                                                                    
		BCG->( dbSetorder(01) )
		cDescr := ''
		If BCG->( dbSeek(xFilial("BCG")+TRB1->TRB_LOCAL) )
			cDescr := BCG->BCG_DESCRI
		Else
			cDescr := "Local de digitação não encontrado"
		Endif
		
		@ nLi, 005 Psay '--> '+TRB1->TRB_LOCAL + '-' + Alltrim(cDescr)
		nLi++
				
		// Obtem a coordenada da coluna referente ao ano/mes do prestador...
		For n := 1 To Len(aMesControl)
			
			@ nLi, aCoordenadas[n] Psay Transform(&("TRB1->TRB_AM"+StrZero(n,2)),pMoeda1)
			
			// Total do relatorio
			aTotais[n] += &("TRB1->TRB_AM"+StrZero(n,2))
			
			// Total do grupo
			aTotGrp[n] += &("TRB1->TRB_AM"+StrZero(n,2))
			
		Next
		
		// Imprime as ultimas duas colunas do relatorio...
		@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(TRB1->TRB_TOTAL,pMoeda2)
		
		nLi += 2
		TRB1->( dbSkip() )
	Enddo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais do GRUPO...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
		@ nLi, aCoordenadas[n] Psay Transform(aTotGrp[n], pMoeda1)
	               
		// Totaliza a linha...
		nTotLinha += aTotGrp[n]
	
		// Zera matriz para ser utilizada pelo proximo grupo...
		aTotGrp[n] := 0
	Next

	// Imprime as ultimas duas colunas do relatorio...
	@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)
	nLi++
	@ nLi, 000 Psay Replicate('-', nLimite)
	
	nLi += 2
	
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os totais do relatorio...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
	@ nLi, aCoordenadas[n] Psay Transform(aTotais[n], pMoeda1)

	nTotLinha += aTotais[n]
Next

// Imprime as ultimas duas colunas do relatorio...
@ nLi, aCoordenadas[(Len(aMesControl)+1)] Psay Transform(nTotLinha,pMoeda2)

TRB1->( dbCloseArea() )

FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
                
TRB2->( dbCloseArea() )
FErase(cArqTRB2  + ".DBF")
FErase(cInd1TRB2 + OrdBagExt())
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodade padrao                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)

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

aadd(aRegs,{cPerg,"01","Operadora ?           ","","","mv_ch1","C", 4,0,0,"G",""				,"mv_par01",""      ,"","","","",""               	,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes Base ?              ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()"	,"mv_par02",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano Ano ?              ","","","mv_ch3","C", 4,0,0,"G",""           	,"mv_par03",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","RDA De ?              ","","","mv_ch4","C", 6,0,0,"G",""				,"mv_par04",""      ,"","","","",""               	,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"05","RDA Ate ?             ","","","mv_ch5","C", 6,0,0,"G",""				,"mv_par05",""      ,"","","","",""               	,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"06","Grupo de pegamento ?  ","","","mv_ch6","C", 4,0,0,"G",""				,"mv_par06",""      ,"","","","",""               	,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BRZPLS",""})
aadd(aRegs,{cPerg,"07","Local Digitacao ?     ","","","mv_ch7","C", 4,0,0,"G",""				,"mv_par07",""      ,"","","","",""               	,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BAZPLS",""})
aadd(aRegs,{cPerg,"08","Fase ?                ","","","mv_ch8","N", 1,0,0,"C",""				,"mv_par08","Digitacao"	,"","","","","Conferencia"	,"","","","","Ambas"    ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"09","Tipo de relatorio ?   ","","","mv_ch9","N", 1,0,0,"C",""				,"mv_par09","Analitico"	,"","","","","Sintetico" 	,"","","","",""           ,"","","","",""       			  ,"","","","","","","","",""   	,""})
//aadd(aRegs,{cPerg,"10","Listar PEGS ?         ","","","mv_cha","N", 1,0,0,"C",""				,"mv_par10","Sim"	,"","","","","Nao" 	,"","","","",""           ,"","","","",""       			  ,"","","","","","","","",""   	,""})
		                                                                                                                                                                   
PlsVldPerg( aRegs )

Return