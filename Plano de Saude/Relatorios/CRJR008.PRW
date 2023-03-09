#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR008 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 03.02.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Custo por evento por tipo de beneficiario                  ³±±±
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
User Function CRJR008()
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
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CRJR008"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Custo por Evento - ANS - Visão Contabil"
PRIVATE cTitDem     := " "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CRJ008"
PRIVATE nRel        := "CRJR008"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Tipo de Beneficiario + Codigo do plano + Evento","Tipo de Beneficiario + Codigo do plano + Grupo de Eventos"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Tipo de beneficiario       Plano                                    Evento                           Vlr. Apresentado            Glosa    Vlr Analisado  Co-Participacao    Vlr Pagamento"
PRIVATE cCabec2     := ""
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E  9,999,999.99"
PRIVATE pMoeda2     := "@E 999,999,999.99"
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
cMes		:= mv_par02
cAno		:= mv_par03
cRdaDe	:= mv_par04
cRdaAte	:= mv_par05
cGruPag 	:= mv_par06

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montar grade dinamica com os meses envolvidos...						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/* 
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220         232
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Tipo de beneficiario       Plano                                    Evento                           Vlr. Apresentado            Glosa    Vlr Analisado  Co-Participacao    Vlr Pagamento
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
==> Beneficiario Exposto   
                           0001 - 0123456789012345678901234567890   012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    ---------------------------------------------------------------------------------------------------------------------
                                                                    Total do plano                     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                           
                           0002 - 0123456789012345678901234567890   012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    ---------------------------------------------------------------------------------------------------------------------
                                                                    Total do plano                     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99

   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   Total de Beneficiario Exposto                                                                       999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total Geral                                                                                            999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de processamento do relatorio...							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Proc2BarGauge({|| aCriticas := RJ001Imp()() }  , "Imprimindo...                                    Inicio: "+Time()) 

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
LOCAL nTotApr 	:= 0
LOCAL nTotGlo 	:= 0
LOCAL nTotPag 	:= 0
LOCAL nTotCop 	:= 0
LOCAL nTotGCop 	:= 0
LOCAL nTotGPag	:= 0
LOCAL nTotGGlo  := 0
LOCAL nTotGApr  := 0

LOCAL nTotBCop 	:= 0
LOCAL nTotBPag	:= 0
LOCAL nTotBGlo  := 0
LOCAL nTotBApr  := 0

LOCAL nTotLinha := 0
LOCAL nTotGeral := 0
LOCAL nTotGrupo := 0
LOCAL aEventos	:= {}
LOCAL nTotPla	:= 0
LOCAL nTotBPla	:= 0
LOCAL nTotGPla	:= 0
LOCAL aCampos	:= {	{"TR1_TIPBEN"		, "C", 01						, 0 },;						
						{"TR1_CODIGO"    	, "C", TamSX3("BI3_CODIGO")[1]	, 0 },;
						{"TR1_TIPEVE"		, "C", TamSX3("BR8_YEVENT")[1]	, 0 },;
						{"TR1_VLRAPR"		, "N", TamSX3("BD7_VLRPAG")[1]	, 2 },;
						{"TR1_VLRGLO"		, "N", TamSX3("BD7_VLRPAG")[1]	, 2 },;
						{"TR1_VLRPAG"		, "N", TamSX3("BD7_VLRPAG")[1]	, 2 },;
						{"TR1_VLRCOP"		, "N", TamSX3("BD7_VLRPAG")[1]	, 2 }}

LOCAL nL := 0
LOCAL aLotes := {}
LOCAL nQtd	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Matriz Principal														 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aTrbBD7 := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotal      := 0
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
//³ Exibe mensagem informativa...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(cMes)) + "/" + cAno
                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampos, .T.)
		
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)
		
IndRegua("TRB1",cInd1TRB,"TR1_TIPBEN + TR1_CODIGO + TR1_TIPEVE",,,"Indexando Arquivo de Trabalho")
TRB1->( dbClearIndex() )	

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))

TRB1->( dbSetorder(01) )
                                      
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra BAU-Rede de Atendimento                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT R_E_C_N_O_ BAU_RECNO FROM " + RetSQLName("BAU")
cSQL += " WHERE BAU_FILIAL  = '" + xFilial("BAU") + "' AND "
cSQL += "       BAU_CODIGO >= '" + cRdaDe    + "' AND BAU_CODIGO <= '" + cRdaAte    + "' AND "
If !Empty(cGruPag)
	cSql += " BAU_GRPPAG = '"+cGruPag+"' AND "
Endif
cSQL += "D_E_L_E_T_ = ' '"
cSQL += "ORDER BY BAU_NOME "

// Cria arquivo de trabalho...
PLSQUERY(cSQL,"TrbBAU")
TrbBAU->(DBEval( { | | nQtd ++ }))

// Define tamanho da primeira para de processo...
BarGauge1Set(nQtd)

TrbBAU->( dbGotop() )
While !TrbBAU->( Eof() )
	BAU->( dbGoto(TrbBAU->BAU_RECNO) )
	IncProcG1("RDA - " + BAU->BAU_CODIGO + " - " + BAU->BAU_NOME )
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta  no BD7  			                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSql := "SELECT BD7_ORIMOV, BD7_NUMERO, BD7_CODPEG, BD7_CODOPE, BD7_CODRDA, BD7_CODLDP, BD7_FASE, BD7_ANOPAG, "
	cSql += "BD7_MESPAG, BD7_CODEMP, BD7_MATRIC, BD7_TIPREG, BD7_CODPAD, BD7_CODPRO, BD7_CODPLA, BD7_VLRMAN, "
	cSql += "BD7_VLRGLO, BD7_VLRPAG, BD7_VLRTPF, BD6_BLOCPA, BD6_OPELOT, BD6_NUMLOT, BD6_CODRDA, BD6_ANOPAG, "
	cSql += "BA1_OPEDES, BA1_OPEORI, BD6_MESPAG "
	cSql += "   FROM " + RetSQLName("BD7")+","+RetSQLName("BD6")+","+RetSQLName("BA1")
	cSql += "  	WHERE BD7_FILIAL = '" + xFilial("BD7") + "' "
	cSql += "AND BD6_FILIAL = '" + xFilial("BD6") + "' "
	cSql += "AND BA1_FILIAL = '" + xFilial("BA1") + "' "
	cSql += "AND BD7_FILIAL = BD6_FILIAL "
	cSql += "AND BD7_CODOPE = BD6_CODOPE "
	cSql += "AND BD7_CODLDP = BD6_CODLDP "
	cSql += "AND BD7_CODPEG = BD6_CODPEG "
	cSql += "AND BD7_NUMERO = BD6_NUMERO "
	cSql += "AND BD7_ORIMOV = BD6_ORIMOV "
	cSql += "AND BD7_SEQUEN = BD6_SEQUEN "
	cSql += "AND BD7_CODPAD = BD6_CODPAD "
	cSql += "AND BD7_CODPRO = BD6_CODPRO "
	cSql += "AND BD7_FILIAL = BA1_FILIAL "
	cSql += "AND BD7_CODOPE = BA1_CODINT "
	cSql += "AND BD7_CODEMP = BA1_CODEMP "
	cSql += "AND BD7_MATRIC = BA1_MATRIC "
	cSql += "AND BD7_TIPREG = BA1_TIPREG "
	cSql += "AND BD7_CODOPE = '"+cCodOpe+"' "
	cSql += "AND BD7_ANOPAG = '"+cAno+"' "
	cSql += "AND BD7_MESPAG = '"+cMes+"' "
	cSql += "AND BD7_SITUAC = '1' "
	cSql += "AND BD7_FASE = '4' "
	cSql += "AND BD7_CODRDA = '"+BAU->BAU_CODIGO+"' "
	cSql += "AND " + RetSQLName("BD7")+".D_E_L_E_T_ = ' '"
	cSql += "AND " + RetSQLName("BD6")+".D_E_L_E_T_ = ' '"
	cSql += "AND " + RetSQLName("BA1")+".D_E_L_E_T_ = ' '"
	
	cSql += "ORDER BY BD7_CODOPE, BD7_CODEMP, BD7_MATRIC, BD7_TIPREG"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta ordem                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSQuery(cSql,"TrbBD7")
	
	// Define tamanho da segunda para de processo...
	nQtd:=1                    	
//	TRBBD7->(DBEval( { | | nQtd ++ }))
	BarGauge2Set(nQtd)
	
	BAU->( dbSetorder(01) )
	BR8->( dbSetorder(01) )
	ZZT->( dbSetorder(01) )
//	TRBBD7->( dbGotop() )
	While !TrbBD7->( Eof() )
		
		// Armazena os numeros dos lotes envolvidos para buscar os lancamentos de debito/credito das RDAS
		If ( nL := Ascan(aLotes, {|x|	x[1] == TrbBD7->BD6_OPELOT .and.;
			x[2] == TrbBD7->BD6_NUMLOT .and.;
			x[3] == TrbBD7->BD6_MESPAG .and.;
			x[4] == TrbBD7->BD6_ANOPAG .and.;
			x[5] == TrbBD7->BD6_CODRDA}) ) == 0
			Aadd(aLotes, {TrbBD7->BD6_OPELOT, TrbBD7->BD6_NUMLOT, TrbBD7->BD6_MESPAG, TrbBD7->BD6_ANOPAG, TrbBD7->BD6_CODRDA})
		Endif
		
		cQuebra := TrbBD7->( BD7_CODOPE + BD7_CODEMP + BD7_MATRIC + BD7_TIPREG )
		
		// Verifica o tipo de usuario
		cTipoUsr := ''
		If TRBBD7->BA1_OPEORI == '0001' .and. TRBBD7->BA1_OPEDES == '0001' // Usuario Exposto.
			cTipoUsr := '1' // 1 = Exposto
			
		Elseif TRBBD7->BA1_OPEORI == '0001' .and. TRBBD7->BA1_OPEDES <> '0001' // Usuario Nao Exposto.
			cTipoUsr := '2' // 2 = Nao exposto
			
		Elseif TRBBD7->BA1_OPEORI <> '0001' .and. TRBBD7->BA1_OPEDES == '0001' // Exposto nao beneficiario.
			cTipoUsr := '3' // 3 = Exposto nao beneficiario.
			
		Endif
		
		// Processamento por usuarios...
		While !TrbBD7->( Eof() ) .and. TrbBD7->( BD7_CODOPE + BD7_CODEMP + BD7_MATRIC + BD7_TIPREG ) == cQuebra
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apresenta mensagem em tela...                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProcG2("Processando as guias da RDA..." )
			ProcessMessage()
			
			// Verifica o tipo de evento no procedimento...
			cTipoEve := ''
			If (nPos := Ascan(aEventos, {|x| x[1] == TRBBD7->( BD7_CODPAD + BD7_CODPRO )}) ) == 0
				If BR8->( dbSeek(xFilial("BR8")+TRBBD7->( BD7_CODPAD + BD7_CODPRO )) )
					cTipoEve := Alltrim(STR(BR8->BR8_YEVENT))
					
					If nOrdem == 2
						If cTipoEve $ '1,4'
							cTipoEve := '1' 	// consultas e honorários médicos
							
						Elseif cTipoEve $ '2,20'
							cTipoEve := '2'		// exames e terapias
							
						Elseif cTipoEve $ '0,7'	// demais despesas assistenciais
							cTipoEve := '3'
							
						Else					// Outras despesas...
							cTipoEve := '4'
							
						Endif
					Endif
					
					Aadd(aEventos, {TRBBD7->( BD7_CODPAD + BD7_CODPRO ), cTipoEve})
				Endif
			Else
				cTipoEve := aEventos[nPos, 2]
			Endif
			
			lFound := TRB1->( MsSeek(cTipoUsr + TRBBD7->BD7_CODPLA + cTipoEve ) )
			
			TRB1->( RecLock("TRB1", !lFound) )
			// Grava campos que compoem a chave de pesquisa.
			If !lFound
				TRB1->TR1_CODIGO := TRBBD7->BD7_CODPLA
				TRB1->TR1_TIPBEN := cTipoUsr
				TRB1->TR1_TIPEVE := cTipoEve
				
				TRB1->TR1_VLRAPR := TRBBD7->BD7_VLRMAN // Valor base do pagamento...
				TRB1->TR1_VLRGLO := TRBBD7->BD7_VLRGLO // Valor da glosa
				TRB1->TR1_VLRPAG := TRBBD7->BD7_VLRPAG // Valor de pagamento
				
				// Desconsidera a co-participacao caso a cobranca esteja bloqueada...
				If TRBBD7->BD6_BLOCPA <> '1'
					TRB1->TR1_VLRCOP := TRBBD7->BD7_VLRTPF // Valor da participacao
				Endif
			Else
				TRB1->TR1_VLRAPR += TRBBD7->BD7_VLRMAN // Valor base do pagamento...
				TRB1->TR1_VLRGLO += TRBBD7->BD7_VLRGLO // Valor da glosa
				TRB1->TR1_VLRPAG += TRBBD7->BD7_VLRPAG // Valor de pagamento
				
				// Desconsidera a co-participacao caso a cobranca esteja bloqueada...
				If TRBBD7->BD6_BLOCPA <> '1'
					TRB1->TR1_VLRCOP += TRBBD7->BD7_VLRTPF // Valor da participacao
				Endif
			Endif
			
			TRB1->( MsUnlock() )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa proximo registro                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			TrbBD7->(DbSkip())
		Enddo
	EndDo
	TrbBD7->( dbCloseArea() )
	
	TrbBAU->( dbSkip() )
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho													 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbBAU->( DbCloseArea() )

// Apura todos os debitos e creditos de acordo com os lotes das guias faturadas apuradas acima...
BI3->( dbSetorder(01) )
For nL := 1 To Len(aLotes)

	cSql := "SELECT * FROM "+RetSqlName("BGQ")+" BGQ, "+RetSqlName("BBB")+" BBB "
	cSql += "WHERE BGQ_FILIAL = BBB_FILIAL "
	cSql += "AND BGQ_CODLAN = BBB_CODSER "          
	CSQL += "AND BGQ_FILIAL = '"+XFILIAL("BGQ")+"' "
	cSql += "AND BBB_FILIAL = '"+xFilial("BBB")+"' "
	cSql += "AND BGQ_CODLAN <> '050' "                         	
	cSql += "AND BGQ_CODOPE = '"+aLotes[nL][1]+"' "
	cSql += "AND BGQ_NUMLOT = '"+aLotes[nL][2]+"' "
	cSql += "AND BGQ_MES = '"+aLotes[nL][3]+"' "
	cSql += "AND BGQ_ANO = '"+aLotes[nL][4]+"' "
	cSql += "AND BGQ_CODIGO = '"+aLotes[nL][5]+"' "
	cSql += "AND BGQ.D_E_L_E_T_ = ' ' "
	cSql += "AND BBB.D_E_L_E_T_ = ' ' "
	PlsQuery(cSql, "TRDC")
	
	While !TRDC->( Eof() )
		cTipoEve := Alltrim(Str(TRDC->BBB_YEVENT))
		
		If cTipoEve $ '1,4'
			cTipoEve := '1' 	// consultas e honorários médicos
					
		Elseif cTipoEve $ '2,20' 
			cTipoEve := '2'		// exames e terapias
						
		Elseif cTipoEve $ '0,7'	// demais despesas assistenciais
			cTipoEve := '3'
					
		Else					// Outras despesas...
			cTipoEve := '4'
				
		Endif                                          
		
		lFound := TRB1->( MsSeek('2' + TRDC->BBB_YCODPL + cTipoEve ) ) // Sempre sera 
		
		TRB1->( RecLock("TRB1", !lFound) )
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TR1_CODIGO := TRDC->BBB_YCODPL
			TRB1->TR1_TIPBEN := '2'
			TRB1->TR1_TIPEVE := cTipoEve
			TRB1->TR1_VLRPAG := Iif(TRDC->BBB_TIPSER == '1', -1*TRDC->BGQ_VALOR, TRDC->BGQ_VALOR)

		Else
			TRB1->TR1_VLRPAG := Iif(TRDC->BBB_TIPSER == '1', -1*TRDC->BGQ_VALOR, TRDC->BGQ_VALOR)
		
		Endif
		
	   TRDC->( dbSkip() )
	Enddo
	TRDC->( dbCloseArea() )
	
Next

nLi := 1000 // Estipula valor para imprimir cabecalho ao iniciar a impressao.
TRB1->( dbSetorder(01) )
TRB1->( dbGotop() )

nTotLinha 	:= 0	          
While !TRB1->( Eof() )
                                         
	// Define texto da quebra
	If TRB1->TR1_TIPBEN == '1'
		cTextBen := "Beneficiario Exposto"
		
	Elseif TRB1->TR1_TIPBEN == '2'
		cTextBen := "Beneficiario nao Exposto"

	Elseif TRB1->TR1_TIPBEN == '3'
		cTextBen := "Exposto nao Beneficiario"
	
	Else
		cTextBen := "Beneficiario nao Classificado"
	Endif
	
	// Controle de saldo de pagina...	
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nLi++

		@ nLi, 000 Psay "==> "+cTextBen
		nLi++
		cTipoBen := TRB1->TR1_TIPBEN		
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Montar grade dinamica com os meses envolvidos...						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipoBen <> TRB1->TR1_TIPBEN
		@ nLi, 000 Psay "==> "+cTextBen
		nLi++
		
		cTipoBen := TRB1->TR1_TIPBEN
	Endif

	// Posiciona o produto..                               
	BI3->( msSeek(xFilial("BI3")+PlsIntPad() + TRB1->TR1_CODIGO) )
	
	// imprime o produto..	
	@ nLi, 027 Psay TRB1->TR1_CODIGO + ' - ' + Substr(BI3->BI3_DESCRI,1,30)
	cQuebra := TRB1->TR1_TIPBEN + TRB1->TR1_CODIGO

	While !TRB1->( Eof() ) .and. TRB1->TR1_TIPBEN + TRB1->TR1_CODIGO == cQuebra
		// Controle de saldo de pagina...
		If  nli > nLinPag
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nLi++
		
			// Reimprime o tipo de beneficiario quando houver salto de pagina...	
			@ nLi, 000 Psay "==> "+cTextBen
			nLi++
	
			// Reimprime o produto quando houver salto de pagina...
			@ nLi, 027 Psay TRB1->TR1_CODIGO + ' - ' + Substr(BI3->BI3_DESCRI,1,30)
		Endif
		
		cEvento := ''
		If nOrdem == 1
			If ZZT->( dbSeek(xFilial("ZZT")+TRB1->TR1_TIPEVE) )
				cEvento := TRB1->TR1_TIPEVE+'-'+Substr(ZZT->ZZT_EVENTO, 1,25)
			Endif
		Else
    		// Define texto dos grupos de eventos...
			If Alltrim(TRB1->TR1_TIPEVE) == '1'	
				cEvento := "CONSULTAS E HONORáRIOS MéDICOS"
					
			Elseif Alltrim(TRB1->TR1_TIPEVE) == '2'	
				cEvento := "EXAMES E TERAPIAS"
		
			Elseif Alltrim(TRB1->TR1_TIPEVE) == '3'
				cEvento := "DEMAIS DESPESAS ASSISTENCIAIS"

			Else
				cEvento := "OUTRAS DESPESAS"
	
			Endif
		Endif
    
    		
/* 
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220         232
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Tipo de beneficiario       Plano                                    Evento                           Vlr. Apresentado            Glosa    Vlr Analisado  Co-Participacao    Vlr Pagamento
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
==> Beneficiario Exposto   
                           0001 - 0123456789012345678901234567890   012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    ---------------------------------------------------------------------------------------------------------------------
                                                                    Total do plano                     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                           
                           0002 - 0123456789012345678901234567890   012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    012345678901234567890123456789     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
                                                                    ---------------------------------------------------------------------------------------------------------------------
                                                                    Total do plano                     999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99

   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   Total de Beneficiario Exposto                                                                       999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total Geral                                                                                            999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
*/		
		@ nLi, 068 Psay cEvento
		@ nLi, 103 Psay Transform(TRB1->TR1_VLRAPR, pMoeda2); nTotApr += TRB1->TR1_VLRAPR; nTotBApr += TRB1->TR1_VLRAPR; nTotGApr += TRB1->TR1_VLRAPR
		@ nLi, 120 Psay Transform(TRB1->TR1_VLRGLO, pMoeda2); nTotGlo += TRB1->TR1_VLRGLO; nTotBGlo += TRB1->TR1_VLRGLO; nTotGGlo += TRB1->TR1_VLRGLO
		@ nLi, 137 Psay Transform(TRB1->TR1_VLRPAG, pMoeda2); nTotPag += TRB1->TR1_VLRPAG; nTotBPag += TRB1->TR1_VLRPAG; nTotGPag += TRB1->TR1_VLRPAG
		@ nLi, 154 Psay Transform(TRB1->TR1_VLRCOP, pMoeda2); nTotCop += TRB1->TR1_VLRCOP; nTotBCop += TRB1->TR1_VLRCOP; nTotGCop += TRB1->TR1_VLRCOP
		
		//Calcula total pago...
		nTotLinha := (TRB1->TR1_VLRAPR-(TRB1->TR1_VLRGLO+TRB1->TR1_VLRCOP))
		
		@ nLi, 171 Psay Transform(nTotLinha, pMoeda2); nTotPla += nTotLinha; nTotBPla += nTotLinha; nTotGPla += nTotLinha
		              
		// Reseta variaval de total da linha...
		nTotLinha := 0

		nLi++
		TRB1->( dbSkip() )
	Enddo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os totais do GRUPO...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nli > (nLinPag-5)
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif

	@ nLi, 068 Psay Replicate('-', (nLimite-68))
	nLi++
	
	@ nLi, 068 Psay "Total do plano"
	@ nLi, 103 Psay Transform(nTotApr, pMoeda2)
	@ nLi, 120 Psay Transform(nTotGlo, pMoeda2)
	@ nLi, 137 Psay Transform(nTotPag, pMoeda2)
	@ nLi, 154 Psay Transform(nTotCop, pMoeda2)
	@ nLi, 171 Psay Transform(nTotPla, pMoeda2)
	nTotApr := nTotGlo := nTotPag := nTotCop := nTotPla := 0

	If cTipoBen <> TRB1->TR1_TIPBEN
		nLi += 2
		@ nLi, 003 Psay Replicate('-', (nLimite-3))
		nLi++
		
		@ nLi, 003 Psay "Total "+cTextBen
		@ nLi, 103 Psay Transform(nTotBApr, pMoeda2)
		@ nLi, 120 Psay Transform(nTotBGlo, pMoeda2)
		@ nLi, 137 Psay Transform(nTotBPag, pMoeda2)
		@ nLi, 154 Psay Transform(nTotBCop, pMoeda2)
		@ nLi, 171 Psay Transform(nTotBPla, pMoeda2)
		nTotBApr := nTotBGlo := nTotBPag := nTotBCop := nTotBPla := 0
	Endif
		
	nLi += 2
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os totais do relatorio...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nli > nLinPag
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

@ nLi, 000 Psay "Total Geral"
nLi++

@ nLi, 000 Psay Replicate('-', nLimite)
nLi++

@ nLi, 103 Psay Transform(nTotGApr, pMoeda2)
@ nLi, 120 Psay Transform(nTotGGlo, pMoeda2)
@ nLi, 137 Psay Transform(nTotGPag, pMoeda2)
@ nLi, 154 Psay Transform(nTotGCop, pMoeda2)
@ nLi, 171 Psay Transform(nTotGPla, pMoeda2)

TRB1->( dbCloseArea() )

FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
		
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
aadd(aRegs,{cPerg,"02","Mes Base ?            ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()"		,"mv_par02",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano Ano ?             ","","","mv_ch3","C", 4,0,0,"G",""           		,"mv_par03",""      ,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","RDA De ?              ","","","mv_ch4","C", 6,0,0,"G",""				,"mv_par04",""      ,"","","","",""               	,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"05","RDA Ate ?             ","","","mv_ch5","C", 6,0,0,"G",""				,"mv_par05",""      ,"","","","",""               	,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"06","Grupo de pegamento ?  ","","","mv_ch6","C", 4,0,0,"G",""				,"mv_par06",""      ,"","","","",""               	,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BRZPLS",""})
		                                                                                                                                                                   
PlsVldPerg( aRegs )

Return