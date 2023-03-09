#include "PLSMGER.CH"
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()        
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё CRJR009 Ё Autor Ё Geraldo Felix Junior   Ё Data Ё 24.11.00 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio de opcionais e debitos / creditos		          Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё CRJR0009                                                   Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
User Function CRJR009()

LOCAL aCampos	:= {	{"TR1_CODIGO"    	, "C", TamSX3("BI3_CODIGO")[1]	, 0 },;
						{"TR1_ANO" 			, "C", TamSX3("BM1_ANO")[1]		, 0 },;
						{"TR1_MES"			, "C", TamSX3("BM1_MES")[1]		, 0 },;
						{"TR1_TIPEVE"		, "C", 1						, 0 },;
						{"TR1_CODTIP"		, "C", TamSX3("BM1_CODTIP")[1]	, 0 },;
						{"TR1_CODEVE"		, "C", TamSX3("BM1_CODEVE")[1]	, 0 },;
						{"TR1_DESEVE"		, "C", TamSX3("BM1_DESEVE")[1]	, 0 },;
						{"TR1_TIPCOB"		, "C", TamSX3("E1_FORMREC")[1]	, 0 },;
						{"TR1_BAIXA"		, "D", 8						, 0 },;						
						{"TR1_VENCTO"		, "D", 8						, 0 },;
						{"TR1_VALOR"		, "N", TamSX3("BM1_VALOR")[1]	, 2 }}


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variavaoeis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR009"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de opcionais e debitos / creditos"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "CRJ009"
PRIVATE cRel        := "CRJR009"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := { "Codigo do plano" } 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cCodDB := StrTRan(cCodDB, ' ', '')

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
CriaSX1() 
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLastKey  == 27
   Return
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Recebe parametros                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)            

cOpe     	:= mv_par01
_cMes    	:= mv_par02
_cAno    	:= mv_par03
nTipCon  	:= mv_par04
cGrupIni 	:= mv_par05
cGrupFim 	:= mv_par06
cContDe  	:= mv_par07
cContAte 	:= mv_par08                              
cSubConI 	:= mv_par09
cSubConF 	:= mv_par10
cGrpCIni 	:= mv_par11
cGrpCFin 	:= mv_par12
cCodPlaI 	:= mv_par13
cCodPlaF 	:= mv_par14
nTipo	 	:= mv_par15
nLista	 	:= mv_par16
dBaixaDe	:= mv_par17
dBaixaAte	:= mv_par18
dVencDe		:= mv_par19
dVencAte	:= mv_par20
nConsid		:= mv_par21                                        
//ndebcred    := FormatIn(mv_par22, ",") 
ndebcred    := mv_par22
               
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta novo nome do titulo do relatorio mostrando mes/ano                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nTipo == 1
	cTexto := "Provisionamento"
	
Elseif nTipo == 2
    cTexto := "Pagamentos"
    
Else
	cTexto := "Saldo pendente"
          
Endif

cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(_cMes)) + "/" + _cAno + ' ' + cTexto

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura Impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)
                                                                              
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cArqTRB := CriaTrab(aCampos, .T.)
		
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Cria Indice 1 do Arquivo de Trabalho...                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cInd1TRB := CriaTrab(Nil, .F.)

If nTipo <> 2		// Provisionamento...
	IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPEVE + TR1_CODTIP + TR1_CODEVE",,,"Indexando Arquivo de Trabalho")
	cCabec1 := "Plano - Descricao                       Referencia     Tipo       Lancamento        Evento Descricao evento                         Valor"	
	
Elseif nTipo == 2	// Titulos pagos...
	IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO) + TR1_TIPEVE + TR1_CODTIP + TR1_CODEVE",,,"Indexando Arquivo de Trabalho")
	cCabec1 := "Plano - Descricao                       Referencia     Tipo de Cobrana                  Vencimento   Tipo Lanc.   Lancamento        Evento   Descricao                                  Valor"

Endif                                       
TRB1->( dbClearIndex() )	

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))

TRB1->( dbSetorder(01) )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta RptStatus...                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nTipo == 1
	Proc2BarGauge({|| aCriticas := RJ009aImp() }  , "Imprimindo provisionamento...") 

Elseif nTipo == 2
	Proc2BarGauge({|| aCriticas := RJ009bImp() }  , "Imprimindo pagamentos...") 

Else
	Proc2BarGauge({|| aCriticas := RJ009cImp() }  , "Imprimindo saldos pendentes...") 
	
Endif                                                                              
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina Principal...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RJ009aImpЁ Autor Ё Geraldo Felix Junior   Ё Data Ё 04.11.07 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio opcionais / debitos e credito - provisionamento  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RJ009aImp()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do IndRegua...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL i
LOCAL n
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPosTit	:= 0
LOCAL aPlanos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotal	:= 0
LOCAL nTotDeb	:= 0
LOCAL nTotCre	:= 0
LOCAL nTotOpc	:= 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Exibe mensagem informativa...                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Empresa...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Contrato...                                            Ё                                                     
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por SubContrato...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0
                                                    
cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, "
cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BA1_VERSAO "
cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 "
cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
cSql += "AND BM1.BM1_CODINT = '"+cOpe+"' "
cSql += "AND BM1.BM1_CODEMP >= '"+cGrupIni+"' "
cSql += "AND BM1.BM1_CODEMP <= '"+cGrupFim+"' "
cSql += "AND BM1.BM1_CONEMP >= '"+cContDe +"' "
cSql += "AND BM1.BM1_CONEMP <= '"+cContAte+"' "
cSql += "AND BM1.BM1_SUBCON >= '"+cSubConI+"' "
cSql += "AND BM1.BM1_SUBCON <= '"+cSubConF+"' "
cSql += "AND BM1.BM1_ANO = '"+ _cAno +"' "
cSql += "AND BM1.BM1_MES = '"+ _cMes +"' " 
if empty(mv_par22) 
    cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+cCodDB,",") // o 101 entra na query apenas para poder obter o produto original..
else         
    cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+ndebcred,",") // o 101 entra na query apenas para poder obter o produto original..
endIf 
cSql += " AND BM1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG	 "
cSql += "AND BA1_DIGITO = BM1.BM1_DIGITO "
cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "

PlsQuery(cSql, "TRB")

nQtd:=1
TRB->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRB->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define matriz de planos...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aPlanos := {}

While ! TRB->(Eof())

	// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
	If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
		TRB->( dbSkip() )
		Loop
	Endif
	
	cFam := TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC )
	aPlaUsr := {}
		
	While !TRB->( Eof() ) .and. TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC ) == cFam
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Apresenta mensagem em tela...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		IncProcG1("Familia ["+TRB->BM1_CODINT+"."+TRB->BM1_CODEMP+"."+TRB->BM1_MATRIC+"]")
		ProcessMessage()
		                                                                             
		// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
		If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
			TRB->( dbSkip() )
			Loop
		Endif
			
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciona a familia do usuario                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica tipo de contrato selecionado                              Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nTipCon <> 3 .and. ;
			BA3->BA3_TIPOUS <> strzero(nTipCon,1)
			TRB->(DbSkip())
			Loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Se for pessoa juridica, verifica se pertence ao grupo de           Ё
		//Ё    cobranca informado nos parametros                               Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  BA3->BA3_TIPOUS == "2" .And. Empty(BA3->BA3_GRPCOB) //nivel mais alto e o da familia.
			If  BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB) <> ;
				BQC->(BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)
				
				BQC->(msSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
				
			Endif
			If  BQC->BQC_GRPCOB < cGrpCIni .or. ;
				BQC->BQC_GRPCOB > cGrpCFin
				TRB->(DbSkip())
				Loop
			EndIf
		Else
			If  BA3->BA3_GRPCOB < cGrpCIni .or. ;
				BA3->BA3_GRPCOB > cGrpCFin
				TRB->(DbSkip())
				Loop
			EndIf
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Defini qual o plano do usuario...                                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(BM1->BM1_CODPLA) .and. !Empty(BM1->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB->BM1_CODEVE)})
		        
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| x[1] == TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif

		// O lancamento 101 sera utilizado apenas para obter o codigo do produto original 
		// e nao sera considerado no realtorio
		If TRB->BM1_CODTIP $ '101'		
			TRB->( dbSkip() )
			Loop
		Endif
						
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB->BA1_CODPLA)
				_cCodPla := TRB->BA1_CODPLA
				_cVerPla := TRB->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se pode considerar o plano, de acordo com parametros...   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  _cCodPla < cCodPlaI .or. ;
			_cCodPla > cCodPlaF
			TRB->(DbSkip())
			Loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se foi abortada a impressao...                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  Interrupcao(lAbortPrint)
			Exit
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Classifica o lancamento impresso em opcional, debito ou credito... Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды  
		cTipo := ''
		If TRB->BM1_CODTIP $ '102'
			cTipo := '1'  // Classifica como opcional...
			
		Elseif TRB->BM1_CODTIP $ cCodDB
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	
					cTipo := '3'	// Classifica como credito...

				Elseif BFQ->BFQ_DEBCRE == '1' 
					cTipo := '2'	// Classifica como debito...

				Endif
			Endif
		Else
			cTipo := '4' // Nao classificado..
		Endif
	                           
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Grava arquivo temporario...                                        Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды  						
		lFound := TRB1->( MsSeek(_cCodPla + TRB->BM1_ANO + TRB->BM1_MES + cTipo + TRB->BM1_CODTIP + Alltrim(TRB->BM1_CODEVE) ) )
		
		TRB1->( RecLock("TRB1", !lFound) )
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TR1_CODIGO	:= _cCodPla
			TRB1->TR1_ANO		:= TRB->BM1_ANO
			TRB1->TR1_MES		:= TRB->BM1_MES
			TRB1->TR1_TIPEVE	:= cTipo
			TRB1->TR1_CODTIP	:= TRB->BM1_CODTIP
			TRB1->TR1_CODEVE	:= TRB->BM1_CODEVE
			TRB1->TR1_DESEVE	:= TRB->BM1_DESEVE
			TRB1->TR1_VALOR		:= TRB->BM1_VALOR
		Else
			TRB1->TR1_VALOR		+= TRB->BM1_VALOR
		Endif
		
		TRB1->( MsUnlock() )
				
		TRB->(DbSkip())
	Enddo
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Fim do laco...                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Enddo

TRB1->( dbGotop() )
nLi := 1000

BI3->( dbSetorder(01) )
while !TRB1->( Eof() )

	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif                            
	
	// Posinciona o produto...
    BI3->( MsSeek(xFilial("BI3")+PlsIntPad()+TRB1->TR1_CODIGO) )
                              
    // imprime quebra...
	@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
	nLi ++
	cQbMaster := TRB1->TR1_CODIGO		
	
	@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQbMaster	
                                   
		// Quebra secundaria, por tipo de evento...
		cQuebra := TRB1->TR1_CODIGO + TRB1->TR1_ANO+TRB1->TR1_MES+TRB1->TR1_TIPEVE
		
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + TRB1->TR1_ANO + TRB1->TR1_MES + TRB1->TR1_TIPEVE == cQuebra
			// Controle de saldo de pagina...
			If  nli > nQtdLin
    			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    		nli++

			    // imprime quebra...
				@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
				nLi ++

				@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES	    		
			Endif                            
			           
			If TRB1->TR1_TIPEVE == '1'
				cTexto := "Opcional"
				nTotOpc += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '2'
				cTexto := "Debito"
				nTotDeb += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '3'
				cTexto := "Credito"
				nTotCre += TRB1->TR1_VALOR			
				
			Else
				cTexto := "NЦo classif."
			     
			Endif
			
			// Imprime a linha de detalhes...
			@ nLi, 055 Psay cTexto
	    	@ nLi, 069 Psay TRB1->TR1_CODTIP
	    	@ nLi, 085 Psay TRB1->TR1_CODEVE
		    @ nLi, 091 Psay Substr(TRB1->TR1_DESEVE,1,30)
    		@ nLi, 123 Psay Transform(TRB1->TR1_VALOR, pMoeda2)
			nLi++
			
			nTotal += TRB1->TR1_VALOR
			        	
			TRB1->( dbSkip() ) 
		Enddo
		
		// Imprime total da quebra por tipo de evento..
		nLi ++ 
		@ nLi, 055 Psay "Total"
		@ nLi, 123 Psay Transform(nTotal, pMoeda2)
		
		nLi++
		@ nLi, 055 Psay Replicate('-', (nLimite-55))
		
		nLi += 2
		nTotal := 0
	Enddo
	@ nLi, 000 Psay Replicate('-', nLimite)
		
	nLi ++
Enddo  		

@ nLi, 000 Psay "Total de opcionais: " + Transform(nTotOpc, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Debitos  : " + Transform(nTotDeb, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Creditos : " + Transform(nTotCre, pMoeda2)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRB->( dbClosearea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza e elimina o arquivo fisico do temporario...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return()

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RJ009aImpЁ Autor Ё Geraldo Felix Junior   Ё Data Ё 04.11.07 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio opcionais / debitos e credito - provisionamento  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RJ009bImp()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do IndRegua...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL i
LOCAL n
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPosTit	:= 0
LOCAL aPlanos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotal	:= 0
LOCAL nTotDeb	:= 0
LOCAL nTotCre	:= 0
LOCAL nTotOpc	:= 0

// Monta variaveis com os prefixo utilizados pelo SIGAPLS para gerar titulos no contas a receber...
SX5->( dbSetorder(01) )
cPrefixos := ''
If SX5->( dbSeek(xFilial("SX5")+"BK") )
	While SX5->( !Eof() ) .and. Alltrim(SX5->X5_TABELA) == 'BK'
		cPrefixos += IIf(Empty(cPrefixos), "", ";")+ Alltrim(SX5->X5_CHAVE)
		
		SX5->( dbSkip() )
	Enddo
Endif
	
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
/*
cQuery := "SELECT SE1.R_E_C_N_O_ SE1RECNO "
cQuery += "FROM " + RetSqlName("SE1")+" SE1 "
cQuery += "WHERE "
cQuery += "		E1_FILIAL = '" + xFilial("SE1") + "' "

// Expressao de filtro da data da baixa e do vencimento...
cQuery += " AND E1_BAIXA 	between '" + dTos(dBaixaDe) + "' AND '" + dTos(dBaixaAte)	+ "' "

cQuery += " AND E1_VENCTO	between '" + dTos(dVencDe) + "'  AND '" + dTos(dVencAte)	+ "' "

// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
cQuery += " AND E1_PREFIXO IN "+FormatIn(cPrefixos,";")

// Nao considera abatimentos
cQuery += " AND E1_TIPO NOT IN " + FormatIn(MVABATIM,"|")

// Apenas titulos com saldos, ou seja, nao foram totalmente baixados...
cQuery += " AND E1_SALDO = 0 "	

cQuery += " AND D_E_L_E_T_ = ' '  "

// seta a ordem de acordo com a opcao do usuario
cQuery += " ORDER BY E1_ANOBASE, E1_MESBASE"
PlsQuery(cQuery, "TRBSE1")
*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cQuery := "SELECT E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, "
cQuery += "E5_CLIFOR, E5_LOJA, E5_MOTBX, E5_DTDISPO, E5_VALOR, E5_DATA, E5_RECPAG, E5_SEQ "
cQuery += "FROM " + RetSqlName("SE5")+" SE5, " + RetSqlName("SE1")+" SE1 "
cQuery += "WHERE E5_FILIAL = E1_FILIAL "
cQuery += "AND E5_PREFIXO = E1_PREFIXO "
cQuery += "AND E5_NUMERO = E1_NUM "
cQuery += "AND E5_PARCELA = E1_PARCELA "
cQuery += "AND E5_TIPO = E1_TIPO "
cQuery += "AND E1_FILIAL = '" + xFilial("SE1") + "' "
cQuery += "AND E5_FILIAL = '" + xFilial("SE5") + "' "

If nConsid == 1
	cQuery += " AND ((E5_DATA 	between '" + dTos(dBaixaDe) 	+ "' AND '" + dTos(dBaixaAte)	+ "') "
	cQuery += " OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
//	cQuery += " AND E5_DATA  >= '"+dTos(dBaixaDe)+"'))"
Else
	cQuery += " AND ((E5_DTDISPO  between '" + dTos(dBaixaDe)+ "' AND '" + dTos(dBaixaAte)	+ "') "
	cQuery += " OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
//	cQuery += " AND E5_DTDISPO  >= '"+dTos(dBaixaDe)+"'))"
Endif

cQuery += " AND E1_VENCTO	between '" + dTos(dVencDe) + "'  AND '" + dTos(dVencAte)	+ "' "

// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
cQuery += " AND E5_PREFIXO IN "+FormatIn(cPrefixos,";")
cQuery += " AND E5_NUMERO >= '      ' AND E5_NUMERO <= 'ZZZZZZ' "   // Para utilizar o indice do SE5.
//cQuery += " AND E5_NUMERO = '059981' "   // Para utilizar o indice do SE5.

// Nao considera abatimentos
cQuery += " AND E5_TIPO NOT IN " + FormatIn(MVABATIM,"|")
cQuery += " AND E5_TIPODOC NOT IN ('DC','D2','JR','J2','TL','MT','M2','CM','C2','TR','TE') "

// Apenas titulos com saldos, ou seja, nao foram totalmente baixados...
cQuery += " AND SE1.D_E_L_E_T_ = ' '  "
cQuery += " AND SE5.D_E_L_E_T_ = ' '  "

// seta a ordem de acordo com a opcao do usuario
cQuery += " ORDER BY E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ" // 
PlsQuery(cQuery, "TRBSE1")

nQtd:=1
TRBSE1->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)

TRBSE1->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define matriz de planos...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aPlanos := {}

While ! TRBSE1->(Eof())         

	If TRBSE1->(E5_PREFIXO+E5_NUMERO) $ 'PLS059981'
		X:=1
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posicion o registro fisicamente no SE1...                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//	SE1->( dbGoto(TRBSE1->SE1RECNO) )

	If nConsid == 1 // Considera data da baixa
		dData := TRBSE1->E5_DATA
		
	Else // Considera data da disponibilizacao...
		dData := TRBSE1->E5_DTDISPO
		
	Endif

	lCanc 		:= .F.
	lDac			:= .F.
	nBaixa		:= 0
	cPrefix 		:= TRBSE1->E5_PREFIXO
	cNum			:= TRBSE1->E5_NUMERO
	cParcel		:= TRBSE1->E5_PARCELA
	cTipo			:= TRBSE1->E5_TIPO
	cCLi			:= TRBSE1->E5_CLIFOR
	cLoja			:= TRBSE1->E5_LOJA      
	cSeq			:= TRBSE1->E5_SEQ
				
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se o titulo sofreu movimentacao                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	While ! TRBSE1->(eof()) .and. 	xFilial("SE5") + cPrefix + cNum + cParcel + cTipo + cCli + cLoja + cSeq ==;
		TRBSE1->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ)
        	                       
		If TRBSE1->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN")
    		lCanc := .T. // indica que o titulo foi baixado por motivo de cancelamento

		Else
			// Tratar titulos baixados por DACAO...
			lDac	:= !(MovBcoBx( TRBSE1->E5_MOTBX, .F. )) // indica que o titulo foi baixado por motivo de DACAO
			
		Endif

		If TRBSE1->E5_RECPAG == 'R'
			nBaixa += TRBSE1->E5_VALOR
		Else
			nBaixa -= TRBSE1->E5_VALOR
		Endif
		    		
		TRBSE1->(dbSkip())
	Enddo 
	         
	// Titulo sera desconsiderado por ter sido baixado por cancelamento..
	If lCanc .or. lDac
    	Loop
  	Endif
      
	// Se nao houver baixas, volta ao topo...
	If nBaixa <= 0
		Loop
	Endif
	
	// Psiciona o SE1 novamente...
	SE1->( dbSeek(xFilial("SE1") + cPrefix + cNum + cParcel + cTipo) )
	
	_cAno := SE1->E1_ANOBASE
	_cMes := SE1->E1_MESBASE
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apresenta mensagem em tela...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncProcG1("Processando titulo - "+ SE1->(E1_PREFIXO + '.' + E1_NUM + '.' + E1_PARCELA + E1_TIPO))
	ProcessMessage()
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Seleciona a composicao do titulo...                                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
	cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, "
	cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BA1_VERSAO, BM1_ANO, BM1_MES "
	cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 "
	cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
	cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
	cSql += "AND BM1_PREFIX = '"+cPrefix+"' "
	cSql += "AND BM1_NUMTIT = '"+cNum+"' "
	cSql += "AND BM1_PARCEL = '"+cParcel+"' "
	cSql += "AND BM1_TIPTIT = '"+cTipo+"' " 
if empty(mv_par22) 
	cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+cCodDB,",") // o 101 entra na query apenas para poder obter o produto original..	
else                                                                                                                                        
cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+ndebcred,",") // o 101 entra na query apenas para poder obter o produto original..	
endIf 	
	cSql += "AND BM1.D_E_L_E_T_ = ' ' "
	cSql += "AND BA1.D_E_L_E_T_ = ' ' "
	cSql += "AND BA1_FILIAL = BM1.BM1_FILIAL "
	cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
	cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
	cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
	cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG "
	cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
	
	PlsQuery(cSql, "TRB")
	nQtd := 0
	TRB->(DBEval( { | | nQtd ++ }))
	BarGauge2Set(nQtd)
	
	TRB->(DbGoTop())
	aPlaUsr := {}
	While !TRB->( Eof() )
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Apresenta mensagem em tela...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		IncProcG2("Processando familia - "+ BA3->(BA3_CODINT+'.'+BA3_CODEMP+'.'+BA3_MATRIC))
		ProcessMessage()

		// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
		If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
			TRB->( dbSkip() )
			Loop
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciona a familia do usuario                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Defini qual o plano do usuario...                                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(BM1->BM1_CODPLA) .and. !Empty(BM1->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB->BM1_CODEVE)})
				
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| 	x[1] == TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif
		     
		// O lancamento 101 sera utilizado apenas para obter o codigo do produto original 
		// e nao sera considerado no realtorio
		If TRB->BM1_CODTIP $ '101'		
			TRB->( dbSkip() )
			Loop
		Endif
				
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB->BA1_CODPLA)
				_cCodPla := TRB->BA1_CODPLA
				_cVerPla := TRB->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se pode considerar o plano, de acordo com parametros...   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  _cCodPla < cCodPlaI .or. ;
			_cCodPla > cCodPlaF
			TRB->(DbSkip())
			Loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se foi abortada a impressao...                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  Interrupcao(lAbortPrint)
			Exit
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Classifica o lancamento impresso em opcional, debito ou credito... Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды  
		cTipo := ''
		If TRB->BM1_CODTIP $ '102'
			cTipo := '1'  // Classifica como opcional...
			
		Elseif TRB->BM1_CODTIP $ cCodDB
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	
					cTipo := '3'	// Classifica como credito...

				Elseif BFQ->BFQ_DEBCRE == '1' 
					cTipo := '2'	// Classifica como debito...

				Endif
			Endif
		Else
			cTipo := '4' // Nao classificado..
		Endif                              
		
		If TRB->BM1_CODTIP == '952'
			x:= 1 
		Endif
				
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Alimenta o arquivo temporario...                                   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cChave := _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) + cTipo + TRB->BM1_CODTIP + TRB->BM1_CODEVE

		lFound := TRB1->( MsSeek( cChave ) ) // Procura registro no arquivo temporario...

		TRB1->( RecLock("TRB1", !lFound) )
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TR1_CODIGO	:= _cCodPla
			TRB1->TR1_ANO		:= _cAno
			TRB1->TR1_MES		:= _cMes
			TRB1->TR1_TIPEVE	:= cTipo
			TRB1->TR1_CODTIP	:= TRB->BM1_CODTIP
			TRB1->TR1_CODEVE	:= TRB->BM1_CODEVE
			TRB1->TR1_DESEVE	:= TRB->BM1_DESEVE
			TRB1->TR1_BAIXA	:= SE1->E1_BAIXA
			TRB1->TR1_VENCTO	:= SE1->E1_VENCTO
			TRB1->TR1_TIPCOB	:= SE1->E1_FORMREC
			TRB1->TR1_VALOR	:= TRB->BM1_VALOR
		Else
			TRB1->TR1_VALOR		+= TRB->BM1_VALOR
		Endif
		
		TRB1->( MsUnlock() )
				
		TRB->(DbSkip())
	Enddo
	TRB->( dbCLoseArea() )
	
Enddo

TRB1->( dbGotop() )
nLi := 1000

BI3->( dbSetorder(01) )
while !TRB1->( Eof() )

	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif                            
	
	// Posinciona o produto...
    BI3->( MsSeek(xFilial("BI3")+PlsIntPad()+TRB1->TR1_CODIGO) )

    // imprime a primeira quebra...
	@ nLi, 000 Psay "==> "+TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
	nLi ++
	cQbMaster := TRB1->TR1_CODIGO		
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQbMaster	
	
		// Segunda quebra, por data de referencia.. ANO/MES
		cQuebra1 := TRB1->TR1_CODIGO + TRB1->TR1_ANO +TRB1->TR1_MES
	
		// Imprime a segunda quebra...	ANO/MES.
		@ nLi, 039 Psay '*** ' + TRB1->TR1_ANO + '/' + TRB1->TR1_MES
		nLi++
	
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + TRB1->TR1_ANO +TRB1->TR1_MES == cQuebra1
		                                                      
			// Imprime a terceira quebra, Tipo de cobranca...
			cDesTipCb := ''
			If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
				cDesTipCb := BQL->BQL_DESCRI
				
			Endif
			cTipCob := TRB1->TR1_TIPCOB
			@ nLi, 056 Psay Substr(cDesTipCb, 1, 25)

			// Terceira quebra, por tipo de cobranca...
			cQuebra := TRB1->TR1_CODIGO + TRB1->TR1_ANO+TRB1->TR1_MES+TRB1->TR1_TIPEVE				
			cVenc := ''
			While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + TRB1->TR1_ANO + TRB1->TR1_MES + TRB1->TR1_TIPEVE == cQuebra
			
				// Controle de saldo de pagina...
				If  nli > nQtdLin
    				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
		    		nli++

				    // imprime a primeira quebra, codigo do plano...
					@ nLi, 000 Psay "==> "+TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
					nLi ++
					cQbMaster := TRB1->TR1_CODIGO		
			 
					// Imprime a segunda quebra, referencia...
					@ nLi, 039 Psay '*** ' + TRB1->TR1_ANO + '/' + TRB1->TR1_MES
					nLi++
				
					// Imprime a terceira quebra, tipo de cobranca
					cDesTipCb := ''
					If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
						cDesTipCb := BQL->BQL_DESCRI
					Endif
					cTipCob := TRB1->TR1_TIPCOB
					@ nLi, 056 Psay Substr(cDesTipCb, 1, 25)

					// Imprime a quarta quebra, vencimento...
					nLi ++
					@ nLi, 090 Psay dToc(TRB1->TR1_VENCTO)
					
					cVenc := dTos(TRB1->TR1_VENCTO)					
				Endif                            
                
				If cTipCob <> TRB1->TR1_TIPCOB
					// Imprime a terceira quebra, Tipo de cobranca...
					nLi++
					cDesTipCb := ''
					If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
						cDesTipCb := BQL->BQL_DESCRI
					Endif
					cTipCob := TRB1->TR1_TIPCOB
					@ nLi, 056 Psay Substr(cDesTipCb, 1, 25)
				
					// Se trocar o tipo de cobranca, tem que imprimir tmb a data de vencimento...					
					nLi ++
					@ nLi, 090 Psay dToc(TRB1->TR1_VENCTO)
					
					cVenc := dTos(TRB1->TR1_VENCTO)
				Endif
										
				If cVenc <> dTos(TRB1->TR1_VENCTO)
					nLi ++
					@ nLi, 090 Psay dToc(TRB1->TR1_VENCTO)
					
					cVenc := dTos(TRB1->TR1_VENCTO)
				Endif
				
				If TRB1->TR1_TIPEVE == '1'
					cTexto := "Opcional"
					nTotOpc += TRB1->TR1_VALOR
				
				Elseif TRB1->TR1_TIPEVE == '2'
					cTexto := "Debito"
					nTotDeb += TRB1->TR1_VALOR
					
				Elseif TRB1->TR1_TIPEVE == '3'
					cTexto := "Credito"
					nTotCre += TRB1->TR1_VALOR			
					
				Else
					cTexto := "NЦo classif."
				     
				Endif
			
				// Imprime a linha de detalhes...
				@ nLi, 103 Psay cTexto
	    		@ nLi, 119 Psay TRB1->TR1_CODTIP
	    		@ nLi, 134 Psay TRB1->TR1_CODEVE
 		      @ nLi, 142 Psay Substr(TRB1->TR1_DESEVE,1,30)
    			@ nLi, 176 Psay Transform(TRB1->TR1_VALOR, pMoeda2)
				nLi++
			
				nTotal += TRB1->TR1_VALOR
			        	
				TRB1->( dbSkip() ) 
			Enddo
		
			// Imprime total da quebra por tipo de evento..
			nLi ++ 
			@ nLi, 103 Psay "Total"
			@ nLi, 175 Psay Transform(nTotal, pMoeda2)
		
			nLi++
			@ nLi, 103 Psay Replicate('-', (nLimite-103))
		
			nLi += 2
			nTotal := 0
		Enddo
		@ nLi, 000 Psay Replicate('-', nLimite)
		
		nLi ++
	Enddo  		
Enddo

@ nLi, 000 Psay "Total de opcionais: " + Transform(nTotOpc, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Debitos  : " + Transform(nTotDeb, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Creditos : " + Transform(nTotCre, pMoeda2)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBSE1->( dbClosearea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza e elimina o arquivo fisico do temporario...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return()


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RJ009aImpЁ Autor Ё Geraldo Felix Junior   Ё Data Ё 04.11.07 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio opcionais / debitos e credito - provisionamento  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RJ009cImp()
LOCAL cPrefixos := ''
LOCAL cSql 		:= ''
LOCAL nTotal 	:= 0
LOCAL nTotDeb	:= 0
LOCAL nTotCre	:= 0
LOCAL nTotOpc	:= 0
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL aParc		:= {}

// Monta variaveis com os prefixo utilizados pelo SIGAPLS para gerar titulos no contas a receber...
SX5->( dbSetorder(01) )
cPrefixos := ''
If SX5->( dbSeek(xFilial("SX5")+"BK") )
	While SX5->( !Eof() ) .and. Alltrim(SX5->X5_TABELA) == 'BK'
		cPrefixos += IIf(Empty(cPrefixos), "", ";")+ Alltrim(SX5->X5_CHAVE)
		
		SX5->( dbSkip() )
	Enddo
Endif
	
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cQuery := "SELECT SE1.R_E_C_N_O_ SE1RECNO "
cQuery += "FROM " + RetSqlName("SE1")+" SE1 "
cQuery += "WHERE "
cQuery += "		E1_FILIAL = '" + xFilial("SE1") + "' "

cQuery += " AND E1_ANOBASE + E1_MESBASE <= '" + _cAno + _cMes + "' "

// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
cQuery += " AND E1_PREFIXO IN "+FormatIn(cPrefixos,";")

// Nao considera abatimentos
cQuery += " AND E1_TIPO NOT IN " + FormatIn(MVABATIM,"|")

// Apenas titulos com saldos, ou seja, nao foram totalmente baixados...
cQuery += " AND E1_SALDO > 0 "	

cQuery += " AND D_E_L_E_T_ = ' '  "

// seta a ordem de acordo com a opcao do usuario
cQuery += " ORDER BY E1_ANOBASE, E1_MESBASE"
PlsQuery(cQuery, "TRBSE1")

nQtd:=1
TRBSE1->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRBSE1->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define matriz de planos...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aPlanos := {}

While ! TRBSE1->(Eof())
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posicion o registro fisicamente no SE1...                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	SE1->( dbGoto(TRBSE1->SE1RECNO) )
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apresenta mensagem em tela...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncProcG1("Processando titulo - "+ SE1->(E1_PREFIXO + '.' + E1_NUM + '.' + E1_PARCELA + E1_TIPO))
	ProcessMessage()

	// Primeiro imprime tudo que esta em aberto, com saldo = valor.
	If !(SE1->E1_VALOR = SE1->E1_SALDO)
	    // 
		Aadd( aParc, SE1->( Recno() ) )
		
		TRBSE1->( dbSkip() )
		Loop
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se o titulo sofreu movimentacao                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	SE5->(dbSetOrder(7))
	If  SE5->( MsSeek(xFilial("SE5")+SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA)) )
	    lCanc := .F.
    	While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == ;
        	                       xFilial("SE5")+SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA)
        	                       
		    If SE5->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN")
    			lCanc := .T. // indica que o titulo foi baixado por motivo de cancelamento
    			Exit
    		Endif
    		
    	   SE5->(dbSkip())
	    Enddo 
	         
	    // Titulo sera desconsiderado por ter sido baixado por cancelamento..
    	If lCanc
    		TRBSE1->( dbSkip() )
    		Loop
    	Endif
	Endif

	_cAno := SE1->E1_ANOBASE
	_cMes := SE1->E1_MESBASE
		                        
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Seleciona a composicao do titulo...                                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
	cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, "
	cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BA1_VERSAO, BM1_ANO, BM1_MES "
	cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 "
	cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
	cSql += "AND BM1_PREFIX = '"+SE1->E1_PREFIXO+"' "
	cSql += "AND BM1_NUMTIT = '"+SE1->E1_NUM+"' "
	cSql += "AND BM1_PARCEL = '"+SE1->E1_PARCELA+"' "
	cSql += "AND BM1_TIPTIT = '"+SE1->E1_TIPO+"' "
	if empty(mv_par22)  
       cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+cCodDB,",") // o 101 entra na query apenas para poder obter o produto original..		
    else                                                                                                                                            
       cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+ndebcred,",") // o 101 entra na query apenas para poder obter o produto original..		
    EndIf    
	cSql += "AND BM1.D_E_L_E_T_ = ' ' "
	cSql += "AND BA1.D_E_L_E_T_ = ' ' "
	cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
	cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
	cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
	cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG "
	cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
	
	PlsQuery(cSql, "TRB")
	nQtd := 0
	TRB->(DBEval( { | | nQtd ++ }))
	BarGauge2Set(nQtd)
	
	TRB->(DbGoTop())
	aPlaUsr := {}
	
	While !TRB->( Eof() )
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Apresenta mensagem em tela...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		IncProcG2("Processando Familia - "+ TRB->(BM1_CODINT + '.' + BM1_CODEMP + '.' + BM1_MATRIC))
		ProcessMessage()
		        
		// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
		If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
			TRB->( dbSkip() )
			Loop
		Endif
				
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciona a familia do usuario                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Defini qual o plano do usuario...                                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(BM1->BM1_CODPLA) .and. !Empty(BM1->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB->BM1_CODEVE)})
				
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| x[1] == TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif

		// O lancamento 101 sera utilizado apenas para obter o codigo do produto original 
		// e nao sera considerado no realtorio
		If TRB->BM1_CODTIP $ '101'		
			TRB->( dbSkip() )
			Loop
		Endif
				
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB->BA1_CODPLA)
				_cCodPla := TRB->BA1_CODPLA
				_cVerPla := TRB->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se pode considerar o plano, de acordo com parametros...   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  _cCodPla < cCodPlaI .or. ;
			_cCodPla > cCodPlaF
			TRB->(DbSkip())
			Loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se foi abortada a impressao...                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  Interrupcao(lAbortPrint)
			Exit
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Classifica o lancamento impresso em opcional, debito ou credito... Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды  
		cTipo := ''
		If TRB->BM1_CODTIP $ '102'
			cTipo := '1'  // Classifica como opcional...
			
		Elseif TRB->BM1_CODTIP $ cCodDB
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	
					cTipo := '3'	// Classifica como credito...

				Elseif BFQ->BFQ_DEBCRE == '1' 
					cTipo := '2'	// Classifica como debito...

				Endif
			Endif
		Else
			cTipo := '4' // Nao classificado..
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Alimenta o arquivo temporario...                                   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cChave := _cCodPla + _cAno + _cMes + cTipo + TRB->BM1_CODTIP + TRB->BM1_CODEVE

		lFound := TRB1->( MsSeek( cChave ) ) // Procura registro no arquivo temporario...

		TRB1->( RecLock("TRB1", !lFound) )
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TR1_CODIGO	:= _cCodPla
			TRB1->TR1_ANO		:= _cAno
			TRB1->TR1_MES		:= _cMes
			TRB1->TR1_TIPEVE	:= cTipo
			TRB1->TR1_CODTIP	:= TRB->BM1_CODTIP
			TRB1->TR1_CODEVE	:= TRB->BM1_CODEVE
			TRB1->TR1_DESEVE	:= TRB->BM1_DESEVE
			TRB1->TR1_VALOR		:= TRB->BM1_VALOR
		Else
			TRB1->TR1_VALOR		+= TRB->BM1_VALOR
		Endif
		
		TRB1->( MsUnlock() )
				
		TRB->(DbSkip())
	Enddo
	TRB->( dbCLoseArea() )

	TRBSE1->( dbSkip() )
Enddo

TRB1->( dbGotop() )
nLi := 1000

BI3->( dbSetorder(01) )
while !TRB1->( Eof() )

	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif                            
	
	// Posinciona o produto...
    BI3->( MsSeek(xFilial("BI3")+PlsIntPad()+TRB1->TR1_CODIGO) )
                              
    // imprime quebra...
	@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
	nLi ++
	cQbMaster := TRB1->TR1_CODIGO		
	
	@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES
	cMesAno := (TRB1->TR1_ANO + TRB1->TR1_MES)
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQbMaster	
                                   
		// Quebra secundaria, por tipo de evento...
		cQuebra := TRB1->TR1_CODIGO + TRB1->TR1_ANO+TRB1->TR1_MES+TRB1->TR1_TIPEVE
		
		If cMesAno <> TRB1->TR1_ANO + TRB1->TR1_MES
			@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES	    		
			cMesAno := (TRB1->TR1_ANO + TRB1->TR1_MES)
		
		Endif
		
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + TRB1->TR1_ANO + TRB1->TR1_MES + TRB1->TR1_TIPEVE == cQuebra
			// Controle de saldo de pagina...
			If  nli > nQtdLin
    			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    		nli++

			    // imprime quebra...
				@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
				nLi ++

				@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES	    		
			Endif                            
			           
			If TRB1->TR1_TIPEVE == '1'
				cTexto := "Opcional"
				nTotOpc += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '2'
				cTexto := "Debito"
				nTotDeb += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '3'
				cTexto := "Credito"
				nTotCre += TRB1->TR1_VALOR			
				
			Else
				cTexto := "NЦo classif."
			     
			Endif
			
			// Imprime a linha de detalhes...
			@ nLi, 055 Psay cTexto
	    	@ nLi, 069 Psay TRB1->TR1_CODTIP
	    	@ nLi, 085 Psay TRB1->TR1_CODEVE
		    @ nLi, 091 Psay Substr(TRB1->TR1_DESEVE,1,30)
    		@ nLi, 123 Psay Transform(TRB1->TR1_VALOR, pMoeda2)
			nLi++
			
			nTotal += TRB1->TR1_VALOR
			        	
			TRB1->( dbSkip() ) 
		Enddo
		
		// Imprime total da quebra por tipo de evento..
		nLi ++ 
		@ nLi, 055 Psay "Total"
		@ nLi, 122 Psay Transform(nTotal, pMoeda2)
		
		nLi++
		@ nLi, 055 Psay Replicate('-', (nLimite-55))
		
		nLi += 2
		nTotal := 0
	Enddo
	@ nLi, 000 Psay Replicate('-', nLimite)
		
	nLi ++
Enddo  		

@ nLi, 000 Psay "Total de opcionais: " + Transform(nTotOpc, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Debitos  : " + Transform(nTotDeb, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Creditos : " + Transform(nTotCre, pMoeda2)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBSE1->( dbClosearea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza e elimina o arquivo fisico do temporario...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return()



		
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CriaSX1   Ё Autor Ё Angelo Sperandio     Ё Data Ё 03.02.05 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function CriaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora ?                   ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes ?                         ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano ?                         ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","Tipo contrato ?               ","","","mv_ch4","N", 1,0,0,"C",""           ,"mv_par04","Fisica"      	,"","","","","Juridica"       	,"","","","","Ambas"         ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"05","Grupo/empresa de ?            ","","","mv_ch5","C", 4,0,0,"G",""           ,"mv_par05",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"06","Grupo/empresa ate ?           ","","","mv_ch6","C", 4,0,0,"G",""           ,"mv_par06",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"07","Contrato de ?                 ","","","mv_ch7","C",12,0,0,"G",""           ,"mv_par07",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"08","Contrato ate ?                ","","","mv_ch8","C",12,0,0,"G",""           ,"mv_par08",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"09","Subcontrato de ?              ","","","mv_ch9","C", 9,0,0,"G",""           ,"mv_par09",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"10","Subcontrato ate ?             ","","","mv_cha","C", 9,0,0,"G",""           ,"mv_par10",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"11","Grupo cobranca de ?           ","","","mv_chb","C", 4,0,0,"G",""           ,"mv_par11",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"12","Grupo cobranca ate ?          ","","","mv_chc","C", 4,0,0,"G",""           ,"mv_par12",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"13","Produto de                    ","","","mv_chd","C", 4,0,0,"G",""           ,"mv_par13",""         	,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"14","Produto ate                   ","","","mv_che","C", 4,0,0,"G",""           ,"mv_par14",""         	,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"15","Qual Relatorio ?              ","","","mv_chf","N", 1,0,0,"C",""           ,"mv_par15","Provisao" 	,"","","","","Pagamentos" 		,"","","","","Pendentes" 	 ,"","","","",""   		,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Listar ?              		   ","","","mv_chg","N", 1,0,0,"C",""           ,"mv_par16","Opcionais"    ,"","","","","Deb/Cred"			,"","","","","Ambos"		 ,"","","","",""   		,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"17","Baixa De ?      			   ","","","mv_chh","D", 8,0,0,"G",""           ,"mv_par17",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"18","Baixa Ate?      			   ","","","mv_chi","D", 8,0,0,"G",""           ,"mv_par18",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"19","Vencimento De ? 			   ","","","mv_chj","D", 8,0,0,"G",""           ,"mv_par19",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"20","Vencimento Ate? 			   ","","","mv_chl","D", 8,0,0,"G",""           ,"mv_par20",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"21","Considerar Data?			   ","","","mv_chm","N", 1,0,0,"C",""		     ,"mv_par21","Da Baixa"    	,"","","","","Da disponib."    	,"","","","",""              ,"","","","",""   	,"","","","","","","","",""   ,""})       
aadd(aRegs,{cPerg,"22","Deb/Cred a Listar             ","","","mv_chn","C", 40,0,0,"G",""           ,"mv_par22",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
       
       

PlsVldPerg( aRegs )
    
Return
