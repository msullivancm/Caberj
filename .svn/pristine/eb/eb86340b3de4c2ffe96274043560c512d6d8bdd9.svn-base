#Include "PLSR240.CH"
#Include "PROTHEUS.CH"
#Include "PLSMGER.CH"
#Include "rwmake.ch"   
#Include "Topconn.ch"        
#include "Msole.CH"
              
                 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ BOL_ITAU³ Autor ³ Jean Schulz            ³ Data ³ 10.10.04  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao do boleto bancario ITAU / BASEADO ROTINA PLSR240  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Advanced Protheus                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CABR166(nRegSE1)
					
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                     
	Private nQtdLin		:= 60
	Private cTamanho	:= "G"
	Private cTitulo		:= STR0001 //"Emissao dos boletos de cobranca"
	Private cDesc1		:= STR0002 //"Emissao dos boletos de cobranca de acordo com os parametros selecionados."
	Private cDesc2		:= ""
	Private cDesc3		:= ""
	Private cAlias		:= "SE1"
	Private cPerg		:= "CABR166"
	Private cRel		:= "CABR166"//"BOLITAU"
	Private nli			:= 80
	Private m_pag		:= 1
	Private lCompres	:= .F.
	Private lDicion		:= .F.
	Private lFiltro		:= .T.
	Private lCrystal	:= .F.
	Private aOrderns	:= {}
	Private aReturn		:= { "", 1,"", 1, 1, 1, "",1 }
	Private lAbortPrint	:= .F.
	Private aCritica	:= {}
	Private _cSeqNom	:= ""
	Private cNumProc	:= ""
    Private  cText      := "" 
   	Private cfamilia 	:= ""  
   	private cvalmat     := ""       
   	
    private c_LogGer    := ""
   	
	Default nRegSE1		:= 0             
	
	Private l_ImpSemFat := .T. // conselho
		   

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama Pergunte Invariavelmente                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1(cPerg)

	If nRegSE1 == 0        
	 
		Pergunte(cPerg,.T.)	
	
	EndIf

	cRel := SetPrint(	cAlias	, cRel		, cPerg		,  @cTitulo	,;
						cDesc1	, cDesc2	, cDesc3	, lDicion	,;
						aOrderns, lCompres	, cTamanho	, {}		,;
						lFiltro	, lCrystal)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ VerIfica se foi cancelada a operacao (padrao)                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLastKey  == 27
		Return
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao de variaveis a serem utilizadas no programa...                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRegSE1 > 0              
	
		SE1->(DbGoTo(nRegSE1))
	
		cCliDe		:= Space(6) 
		cLojDe		:= Space(2) 
		cCliAte		:= Replicate("Z",6)
		cLojAte		:= Replicate("Z",2)
		cOpeDe		:= Space(4)
		cOpeAte		:= Replicate("Z",4)
		cEmpDe		:= Space(4)
		cEmpAte		:= Replicate("Z",4)
		cConDe		:= Space(12)
		cConAte		:= Replicate("Z",12)
		cSubDe		:= Space(9)
		cSubAte		:= Replicate("Z",9)
		cMatDe		:= Space(6)
		cMatAte		:= Replicate("Z",6)
		cMesTit		:= SE1->E1_MESBASE
		cAnoTit		:= SE1->E1_ANOBASE
		nTipCob		:= 2
		cPrefDe		:= SE1->E1_PREFIXO
		cPrefAte	:= SE1->E1_PREFIXO
		cNumDe		:= SE1->E1_NUM
		cNumAte		:= SE1->E1_NUM                                                                     	
		cParcDe		:= SE1->E1_PARCELA
		cParcAte	:= SE1->E1_PARCELA
		cTipoDe		:= SE1->E1_TIPO
		cTipoAte	:= SE1->E1_TIPO
		cNmBorDe	:= Space(6)
		cNmBorAt	:= Replicate("Z",6)
	
	Else
	
		cCliDe		:= mv_par01 
		cLojDe		:= mv_par02
		cCliAte		:= mv_par03
		cLojAte		:= mv_par04
		cOpeDe		:= mv_par05
		cOpeAte		:= mv_par06
		cEmpDe		:= mv_par07
		cEmpAte		:= mv_par08
		cConDe		:= mv_par09
		cConAte		:= mv_par10
		cSubDe		:= mv_par11
		cSubAte		:= mv_par12
		cMatDe		:= mv_par13
		cMatAte		:= mv_par14
		cMesTit		:= mv_par15
		cAnoTit		:= mv_par16
		nTipCob		:= mv_par17
		cPrefDe		:= mv_par18
		cPrefAte	:= mv_par19
		cNumDe		:= mv_par20
		cNumAte		:= mv_par21
		cParcDe		:= mv_par22
		cParcAte	:= mv_par23
		cTipoDe		:= mv_par24
		cTipoAte	:= mv_par25
		cNmBorDe	:= mv_par27
		cNmBorAt	:= mv_par28
		cAnoCust	:= mv_par29
		cMesCust	:= mv_par30
	
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Configura impressora (padrao)                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault(aReturn,cAlias)     

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite relat¢rio                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Processa({|| GeraBol() }, cTitulo, "", .T.)

Return

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R240Imp  ³ Autor ³ Rafael M. Quadrotti   ³ Data ³ 14.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function GeraBol()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSQL			:= ""							// Select deste relatorio
Local cSE1Name 		:= SE1->(RetSQLName("SE1"))	// Retorna o nome do alias no TOP
Local cSA1Name 		:= SA1->(RetSQLName("SA1"))	// Retorna o nome do alias no TOP
Local cPrefixo 		:= ""							// Prefixo do titulo
Local cTitulo 		:= ""							// Titulo
Local cParcela 		:= ""							// Parcela do titulo
Local cTipo 		:= ""							// E1_TIPO
Local aDadosEmp		:= {}							// Array com os dados da empresa.
Local aDadosTit		:= {}							// Array com os dados do titulo
Local aDadosBanco   := {}							// Array com os dados do banco
Local aDatSacado	:= {}							// Array com os dados do Sacado.
Local CB_RN_NN  	:= {}							// Array com as informacoes do Nosso Numero, Codigo de Barras, e Linha digitavel.
Local aBmp			:= { "" }						// Vetor para Bmp.
Local cOperadora    := BX4->(PLSINTPAD())			// Retorna a operadora do usuario.
Local aBfq			:= {}
Local aDepEndentes	:= {}							// Array com os depEndentes do sacado.
Local aOpenMonth	:= {}							// Array com os meses em aberto.
Local aObservacoes  := {}							// Array com as observacoes do extrato.
Local aMsgBoleto    := {}							// Array com as mensagens do boleto.
Local nPos			:= 0							// Variavel auxiliar para ascan.
Local cCart		    := ""							// Carteira do titulo
Local cSA6Key		:= ""							// Chave de pesquisa do SA6 Cadastro de bancos,
Local aCobranca		:= {}
Local cUsuAnt       := ""
Local lNome			:= .T.
Local cNumAtu		:= ""
Local lPrima		:= .T.
Local cString		:= ""
Local _cNomRDA		:= ""
                    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis necessarias para a mensagem de reajuste / ANS...               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cPerRea		:= ""
Local cCodPla		:= ""
Local cNomPRe		:= ""
Local cNumANS		:= ""
Local cPatroc		:= ""
Local cContANS		:= ""				
Local aPlaRea		:= {}
Local cOfiANS		:= GetNewPar("MV_YPOFANS","")
Local cEleImp		:= ""
Local nReg			:= 0
Local nRegCab		:= 0
Local aMatExi		:= {}
Local _cSQLUti		:= ""
Local _cCodFamUti	:= ""
Local lIntegral		:= (cEmpAnt == '02')
Local _nPosTmp		:= 0
Local aNewBFQ		:= {}

Local _nRegPro		:= 0
Local _nTotSE1		:= 0

Local nVlrTotBol	:= 0

Private cSeqArq		:= "000001"
Private cEOL		:= CHR(13)+CHR(10)
Private nHdl

Private lMosRea		:= .F.

Private aMsgRea		:= {}
Private lFoundSE1	:= .F.
Private	cDirExp		:= "\interface\exporta\ANLGRAF\TMPTS\"//GETNEWPAR("MV_YBOLGR","\Exporta\ANLGRAF\TMPTST\")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array para impressao do analitico (opcao 3)...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private aImp 		:= {}
Private a1_40ca4	:= {}
Private a1_102ca3	:= {}
Private a1_102mca32	:= {}

Private a2_40ca4	:= {}
Private a2_102ca3	:= {}
Private a2_102mca32	:= {}
         
Private a3_40ca4	:= {}
Private a3_102ca3	:= {}
Private a3_102mca32	:= {}

Private a4_40ca4	:= {}
Private a4_102ca3	:= {}
Private a4_102mca32	:= {}
Private aMatUti		:= {}
Private cArray		:= ""
Private _aErrAnlt	:= {}         
Private cQtdEx      := '000000'
Private c_XTitulo := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³FazEndo a verIficacao da existencia do RDMAKE antes do processa-³
//³mento.                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ExistBlock("RETDADOS")
	MsgInfo(STR0056)
	Return NIL
EndIf

SE1->(DbSetOrder(1))
BAU->(DbSetOrder(1))

oPrint:= TMSPrinter():New( STR0003 ) //"Boleto Laser"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³VerIfica se as configuracoes de impressora foram definidas para ³
//³que o objeto possa ser trabalhado.                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !(oPrint:IsPrinterActive())
	Aviso(STR0041,STR0042,{"OK"})   //"Impressora"###"As configurações da impressora não foram encontradas. Por favor, verIfique as configurações para utilizar este relatório. "
	oPrint:Setup()
	Return (.F.)
EndIf
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nForC := 1 to 2

	If nForC == 1
		cSQL := 	"SELECT COUNT(SE1.R_E_C_N_O_) AS TOTSE1"
	Else	
		cSQL := 	"SELECT SE1.* , A1_CEP "
	EndIf

	cSQL += 	" FROM "+cSE1Name+" SE1, "+cSA1Name+" SA1, " + RetSqlName("BA3") + " BA3"
	cSQL += 	" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
	cSQL += 	" E1_CLIENTE||E1_LOJA >= '"+cCliDe+cLojDe+"' AND "
	cSQL += 	" E1_CLIENTE||E1_LOJA <= '"+cCliAte+cLojAte+"' AND "
	cSQL += 	" A1_FILIAL = '"+xFilial("SA1")+"' AND "
	cSQL += 	" E1_CLIENTE = A1_COD AND "
	cSQL += 	" E1_LOJA = A1_LOJA AND "
	cSQL += 	" E1_CODEMP = BA3_CODEMP AND "
	cSQL += 	" E1_MATRIC = BA3_MATRIC AND "
	
	If nTipCob == 1 // Previ	
		cSQL += 	" BA3_GRPCOB IN ('1001', '1002', '1003') AND "
	ElseIf  nTipCob == 2                                                      
		cSQL += 	" BA3_GRPCOB IN ('0002', '0003', '0005', '9998') AND " 
	ElseIf  nTipCob == 3                                                      
		cSQL += 	" BA3_GRPCOB = '0009' AND "
	EndIf 

	
	cSQL += 	" E1_PREFIXO >= '"+cPrefDe+"' AND E1_PREFIXO <= '"+cPrefAte+"' AND "
	cSQL += 	" E1_NUM >= '"+cNumDe+"' AND E1_NUM <= '"+cNumAte+"' AND "
	cSQL += 	" E1_PARCELA >= '"+cParcDe+"' AND E1_PARCELA <= '"+cParcAte+"' AND "
	cSQL += 	" E1_TIPO >= '"+cTipoDe+"' AND E1_TIPO <= '"+cTipoAte+"' AND "
	cSQL += 	" E1_CODINT >= '"+cOpeDe+"' AND E1_CODINT <= '"+cOpeAte+"' AND "
	cSQL += 	" E1_CODEMP >= '"+cEmpDe+"' AND E1_CODEMP <= '"+cEmpAte+"' AND "
	cSQL += 	" E1_CONEMP >= '"+cConDe+"' AND E1_CONEMP <= '"+cConAte+"' AND "
	cSQL += 	" E1_SUBCON >= '"+cSubDe+"' AND E1_SUBCON <= '"+cSubAte+"' AND "
	cSQL += 	" E1_MATRIC >= '"+cMatDe+"' AND E1_MATRIC <= '"+cMatAte+"' AND "
	cSQL += 	" E1_ANOBASE||E1_MESBASE = '"+cAnoTit+cMesTit+"' AND "
	cSQL += 	" E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND " 
	cSQL += 	" E1_NUMBOR >= '"+cNmBorDe+"' AND E1_NUMBOR <= '"+cNmBorAt+"' AND "  
    cSQL += 	" ( E1_FORMREC IN ('01','02','06','08') OR (E1_FORMREC = '04' AND E1_YEXANLT = '1' ) ) AND "
		
	
	If ! Empty(aReturn[7])
		cSQL += PLSParSQL(aReturn[7]) + " AND "    
	EndIf

	cSQL += "BA3.D_E_L_E_T_ = ' ' AND "
	cSQL += "SE1.D_E_L_E_T_ = ' ' AND "
	cSQL += "SA1.D_E_L_E_T_ = ' ' "
	
	If nForC == 1
		PLSQuery(cSQL,"R240Imp")
		_nTotSE1 := R240Imp->(TOTSE1)
		R240Imp->(DbCloseArea())	
	Else
		
		cSQL += "ORDER BY E1_FORMREC, A1_CEP "
		
	EndIf
	
Next
	               
MemoWrit("C:\TEMP\BORD.TXT", cSQL)
	
PLSQuery(cSQL,"R240Imp")

If R240Imp->(Eof())
	R240Imp->(DbCloseArea())
	Help("",1,"RECNO")
	Return                                                                                                                       
EndIf

BA0->(DbSeek(xFilial("BA0") + cOperadora))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SE1->(DbSetOrder(1))
BM1->(DbSetOrder(4))
BA1->(DbSetOrder(2))
SEE->(dbSetOrder(1))
SA1->(dbSetOrder(1))
BA3->(DbSetOrder(1))
BQC->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca Bmp da empresa.³// Logo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If File("lgrl" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".Bmp")
	aBMP := { "lgrl" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".Bmp" }
ElseIf File("lgrl" + SM0->M0_CODIGO + ".Bmp")
	aBMP := { "lgrl" + SM0->M0_CODIGO + ".Bmp" }
EndIf

ProcRegua(_nTotSE1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicia laco para a impressao  dos boletos.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lMosNumBco := .F.     
  alert("Voltar")
pCriaTmpCus( cAnoCust, cMesCust, cAnoTit, cMesTit )

While ! R240Imp->(Eof())

	_nRegPro++	
	IncProc("Registro: "+StrZero(_nRegPro,8)+"/"+StrZero(_nTotSE1,8))	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nova implementacao: Caso titulo cancelado, e extrato (999) nao considerar³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	 
		
	
		cSQLTMP := " SELECT MAX(R_E_C_N_O_) AS REGSE5 "
		cSQLTMP += " FROM "+RetSQLName("SE5")+" "
		cSQLTMP += " WHERE E5_FILIAL = '"+xFilial("SE5")+"' "
		cSQLTMP += " AND E5_PREFIXO = '"+R240Imp->E1_PREFIXO+"'"
		cSQLTMP += " AND E5_NUMERO = '"+R240Imp->E1_NUM+"' "
		cSQLTMP += " AND E5_PARCELA = '"+R240Imp->E1_PARCELA+"' "
		cSQLTMP += " AND E5_TIPO = '"+R240Imp->E1_TIPO+"' "
		cSQLTMP += " AND D_E_L_E_T_ = ' ' "
		
		PLSQuery(cSQLTMP,"TRBSE5")
		
		If TRBSE5->REGSE5 > 0	
			SE5->(DbGoTo(TRBSE5->REGSE5))
			
			If SE5->E5_MOTBX == "CAN"
				TRBSE5->(DbCloseArea())
				R240Imp->(DbSkip())
				Loop				
			EndIf
		EndIf
		
		TRBSE5->(DbCloseArea())
		
	
	aCobranca		:= {}
	cPrefixo		:= R240Imp->E1_PREFIXO      
	cTitulo			:= R240Imp->E1_NUM
	cParcela		:= R240Imp->E1_PARCELA
	cTipo			:= R240Imp->E1_TIPO
	aDepEndentes	:= {}
	
	BM1->(DbSeek(xFilial("BM1") + cPrefixo + cTitulo + cParcela + cTipo))
	BA3->(DbSeek(xFilial("BA3") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC))

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Em caso de pessoa juridica, nao emite os depEndentes.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("R240Imp")
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso nao exita o banco e agencia no SE1 busca informacoes do SEA.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ((Empty(R240Imp->E1_PORTADO) .OR. Empty(R240Imp->E1_AGEDEP)) .AND. !Empty(R240Imp->E1_NUMBOR) )
		SEA->(DbSeek(xFilial("SEA")+R240Imp->E1_NUMBOR+ cPrefixo + cTitulo + cParcela + cTipo      ))
	    cSA6Key:=SEA->EA_PORTADO+SEA->EA_AGEDEP+SEA->EA_NUMCON
	ElseIf !Empty(R240Imp->E1_PORTADO) .AND. !Empty(R240Imp->E1_AGEDEP)
		cSA6Key:=R240Imp->E1_PORTADO+R240Imp->E1_AGEDEP+R240Imp->E1_CONTA
	EndIf	

	SA6->(DbSetOrder(1))
	SA6->(MsSeek(xFilial("SA6")+cSA6Key,.T.))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados bancarios...         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("R240Imp")
	aDadosBanco  := {	SA6->A6_COD                                          	,;  //Numero do Banco
						SA6->A6_NOME                                        	,;  //Nome do Banco
						SA6->A6_AGENCIA					                       	,;  //Agencia
						Subs(SA6->A6_NUMCON,1,IIf(AT("-",SA6->A6_NUMCON)>0,AT("-",SA6->A6_NUMCON)-1,Len(AllTrim(SA6->A6_NUMCON))-1))	,; 	//Conta Corrente
						Subs(SA6->A6_NUMCON,IIf(AT("-",SA6->A6_NUMCON)>0,AT("-",SA6->A6_NUMCON)+1,Len(AllTrim(SA6->A6_NUMCON))))		}   //Dígito da conta corrente
						
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Retorna os meses em aberto do sacado.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If GetNewPar("MV_YIMMESA","1") == "1"//GetNewPar("MV_YIMMESA","0") == "1"
		aOpenMonth:=PLR240MES(R240Imp->E1_CLIENTE,R240Imp->E1_LOJA,R240Imp->E1_MESBASE,R240Imp->E1_ANOBASE)
	EndIf
	lFoundSE1 := SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
		
	lImpBM1 := .F.
	_cCodFamUti := ""
	//lIntegral := .F.
	aMsgRea := {}    
	cMsgRea := ""
	aMsgReaj := {}     
	lMosRea		:= .F.   
	cPerRea := ""
	lMosRea := .F.
			
	While 	!BM1->(Eof()) 					.And.;
			BM1->BM1_PREFIX = cPrefixo 		.And.;
			BM1->BM1_NUMTIT = cTitulo 		.And.;
			BM1->BM1_PARCEL = cParcela 		.And.;
			BM1->BM1_TIPTIT = cTipo           
			
		If BM1->BM1_CODTIP $ "127,116,104,117,120,121,122,123,124,125,141,151,152"
		   lImpBM1 := .F.
		Else
		   lImpBM1 := .T.
		EndIf   
	
		If BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG == cUsuAnt
			lNome := .F.
		Else
		    cUsuAnt := BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG
		    lNome:= .T.
		EndIf
		
		_cCodFamUti := BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC

		
		If lImpBM1 .And. Substr(cNumEmp,1,2) == "02" //VerIfica se eh integral, na variavel publica de numero de empresa...
			lIntegral := .T.
//			lNome := .F.  Altamiro em 17/11/09
		EndIf		

		l_FamBlo := !EMPTY(ba3->ba3_DATBLO)
			
		If lImpBM1                                       
/////////////////altmairo 03/12/2010 - solicitado keila - claudia vicente 
	
			If !lIntegral	
	   			Aadd(aCobranca,{IIf(lNome,BM1->BM1_NOMUSR,""),;
		  					"",;
		  					"",;
		  					"",;
		  					BM1->BM1_CODTIP,;
		  					BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
		  					IIf(BM1->BM1_CODTIP $ "104;116;120;121;123;124","",BM1->BM1_VALOR),; //135 Outros  ? Motta  
		  					"",;
		  					BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO),;
		  					'1',;
		  					0,;
		  					BM1->BM1_TIPO})
			Else                              
			    If BA3->BA3_COBNIV = '1' 
  			   // trecho de codigo replicado do de cima , ATENÇÃO AO ALTERAR//
			      Aadd(aCobranca,{IIf(lNome,BM1->BM1_NOMUSR,""),;
		  					"",;
		  					"",;
		  					"",;
		  					BM1->BM1_CODTIP,;
		  					BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
		  					IIf(BM1->BM1_CODTIP $ "104;116;120;121;123;124","",BM1->BM1_VALOR),; //135 Outros  ? Motta  
		  					"",;
		  					BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO),;
		  					'1',;
		  					0,;
		  					BM1->BM1_TIPO})  			   
			    Else 
				_nPosTmp := Ascan(aCobranca,{|x| x[5]==BM1->BM1_CODTIP})
				
			      If _nPosTmp == 0
		   		   	 Aadd(aCobranca,{"",;
			  					"",;
			  					"",;
			  					"",;
			  					BM1->BM1_CODTIP,;
			  				    BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
			  					BM1->BM1_VALOR,;
		  					"",;
			  					"",;
			  					'1',;
			  					0,;
			  					BM1->BM1_TIPO})							
				  Else
					aCobranca[_nPosTmp,7] += BM1->BM1_VALOR				
				  EndIf 
 			    EndIf	
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Obtencao de dados para impressao da mensagem de reajuste / ANS...                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
			BA3->(MsSeek(xFilial("BA3")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)))
				
			If R240Imp->E1_MESBASE <> '01'   
			
			
				c_AnoMes := R240Imp->E1_ANOBASE + ba3->ba3_mesrea
			
			Else                                                 
			
				c_AnoMes := str(val(R240Imp->E1_ANOBASE)- 1)  + ba3->ba3_mesrea
			
			EndIf     
			
		    If R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE == c_AnoMes
	
			   	//cPerRea := PercReajuste( c_AnoMes ,BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
				cPerRea := Perc2014( c_AnoMes ,BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC), BA3->BA3_INDREA)
	
			   	lMosRea := .T.//!Empty( cPerRea ) 
			    
			EndIf       
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Controle para imprimir msg. reaj. somente quando percentual > 0 e titulo de mensalidade	   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If lMosRea .AND. !lIntegral
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Montar matriz de produtos da PF, para utilizacao nas mensagens de reajuste. 	 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ										
				cCodPla := BA3->BA3_CODPLA
											
				aAreaBI3  := BI3->(GetArea())
				BI3->(DbSetOrder(1))
				BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+BA3->(BA3_CODPLA+BA3_VERSAO)))
				
				cNomPRe  := ALLTRIM( BI3->BI3_NREDUZ )
				cNumANS  := ALLTRIM( BI3->BI3_SUSEP  )
				cPatroc  := ""
				cContANS := ""				
							    
				If !Empty(BA3->BA3_SUBCON)
					cPatroc  := Posicione("BQC",1,xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB),"BQC_PATROC")
					cContANS := ALLTRIM( BA3->BA3_SUBCON )
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³LegEnda para matriz de produtos.								³
				//³1 - Codigo do Produto										³
				//³2 - Nome do Produto											³
				//³3 - Nro do Produto na ANS									³
				//³4 - Percentual reajustado									³
				//³5 - Nro oficio ANS que liberou o reajuste.					³
				//³6 - Nro do contrato ou apolice (nro subcontrato - PJ)		³
				//³7 - Plano coletivo com (1) ou sem (0) patrocinador - PJ)		³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Ascan(aPlaRea,{|x| x[1]==cCodPla}) = 0
					Aadd(aPlaRea,{cCodPla,cNomPRe,cNumANS,cPerRea,cOfiANS,cContANS,cPatroc})
				EndIf
	
				RestArea(aAreaBI3)    
				
				aAreaBa1A := GetArea("BA1")
				
				BA1->(MsSeek(xFilial("BA1")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)))
				
                **'Marcela Coimbra - Acerto da rotina'**
				While ! BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)==BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
	
					If !Empty(BA1->BA1_CODPLA) .AND. BA1->BA1_CODPLA <> cCodPla
					
						cPerRea := ""

					EndIf
					
					BA1->(DbSkip())
					
				Enddo
			
				If Empty( cPerRea )
				     
					cPerRea:= ". Em caso de dúvida ligue 3233-8888"
				
				Else   
				
					cPerRea := " " + cPerRea
				
				EndIf
				
				//cMsgRea := "Plano " + cNomPRe+ " -  Registro n° " + cNumANS + " - Contrato n° " + cContANS 
				//cMsgRea += " - Coletivo por adesão. Percentual de reajuste aplicado" + cPerRea 
				cMsgRea += "Percentual de reajuste aplicado" + cPerRea 
				cMsgRea += ". O reajuste será comunicado à ANS." 
				cMsgRea += space(300)
				
				aMsgReaj := JustificaTxt(cMsgRea, 100)
				
				aPlaRea := {}
				               
				
			EndIf
	    EndIf
		    
		BM1->(DbSkip())
	End

	 If !lIntegral //.AND. BA3->BA3_COBNIV <> '1'
	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nova implementacao em 8/11/07 - tratar geracao de ana- ³
		//³litico caso exista na utilizacao do beneficiario guias ³
		//³marcadas como bloqueio odontologico.                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
		_cSQLUti := " SELECT Sum(BD6_VLRTPF) AS VLRTOT FROM "+RetSQLName("BD6")+" "
		_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
		_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
		_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
		_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "                                     
                                                                                         
		**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
    
		_cSQLUti += " AND BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "
		
		**'-Fim Marcela Coimbra - Data: 17/03/09-'**
				
		//_cSQLUti += " AND BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' " //GEDILSON 24/02/2010       
		
		_cSQLUti += " AND BD6_NUMFAT = 'BLQODONT' "
		_cSQLUti += " AND D_E_L_E_T_ = ' ' "

		MemoWrit("C:\BORD2.TXT", _cSQLUti)

		PLSQUERY(_cSQLUti,"TRBUTI")
		
		If TRBUTI->VLRTOT > 0

	   			Aadd(aCobranca,{"",;
		  					"",;
		  					"",;
		  					"",;
		  					"952",;
		  					"LCTO CRED PARCEL. ODONTOLOGICO",; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
		  					TRBUTI->VLRTOT,;
		  					"",;
		  					_cCodFamUti+"00"+Modulo11(_cCodFamUti+"00"),;
		  					'1',;
		  					0,;
		  					"2"}) //CREDITO
		
		EndIf		
		TRBUTI->(DbCloseArea())
		
		cAnoMesPgt := PLSDIMAM(R240Imp->(E1_ANOBASE),R240Imp->(E1_MESBASE),"0")
		cAnoMesPgt := PLSDIMAM(Substr(cAnoMesPgt,1,4),Substr(cAnoMesPgt,5,2),"0")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Movido este trecho do fonte para evitar repeticao de   ³
		//³itens caso exista mais de um lancamento de faturamento ³
		//³do tipo de co-participacao.                z            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_cSQLUti := " SELECT * FROM "+RetSQLName("BD6")
		_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
		_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
		_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
		_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "     
		
		**'-Incicio Marcela Coimbra - Data: 13/04/09-'**
  
		_cSQLUti += " AND ( ( BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "	   

		**'-Fim Marcela Coimbra - Data: 13/04/09-'**
		_cSQLUti += " AND BD6_VLRTPF > 0 ) OR "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Em 28/08/08, modIficado este trecho para contemplar a  ³
		//³nova caracteristica de imprimir no extrato do benefici-³
		//³ario informacoes sobre o valor pago pela Caberj.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_cSQLUti += " ( (BD6_VLRTPF = 0 OR BD6_BLOCPA = '1' ) AND BD6_VLRPAG > 0 AND SUBSTR(BD6_NUMLOT,1,6) = '"+cAnoMesPgt+"' ) ) "

		_cSQLUti += " AND BD6_NUMFAT =  '" + R240Imp->E1_PLNUCOB  + "' "

		_cSQLUti += " AND "+RetSQLName("BD6")+".D_E_L_E_T_ <> '*' "
		_cSQLUti += " ORDER BY BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DATPRO"//, BD6_NOMRDA, BD6_CODPRO "
		               
			MemoWrit("C:\BORD3.TXT", _cSQLUti)


		PLSQUERY(_cSQLUti,"TRBUTI")   
		
		While !TRBUTI->(Eof())
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Para emissao Itau (112), deve-se sempre obter o nome do³
			//³usuario. Na reimpressao, nao eh necessario...          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ													
			nPosBD6 := 0

			If TRBUTI->BD6_CODLDP == '0012'
				_cNomRDA := TRBUTI->BD6_NOMSOL
			Else
				_cNomRDA := TRBUTI->BD6_NOMRDA
				If Empty(_cNomRDA)
					_cNomRDA := Posicione("BAU",1,xFilial("BD6")+TRBUTI->BD6_CODRDA,"BAU_NOME")
				EndIf
			EndIf	
			
			nVlrTotBol := TRBUTI->BD6_VLRBPF
			If TRBUTI->BD6_VLRTPF = 0 .Or. TRBUTI->BD6_BLOCPA = '1' 
				nVlrTotBol := TRBUTI->BD6_VLRPAG
			EndIf
			
			a_AreaBa3 := GetArea("BA3")
		    
		    dbSelectArea("BA3")
		    dbSetOrder(1)
		    IF dbSeek( xFilial("BA3") + "0001" + TRBUTI->BD6_CODEMP + TRBUTI->BD6_MATRIC  ) 
		     	Aadd(aCobranca,{  iif(BA3->BA3_COBNIV == '1',	IIf(nPosBD6==0,TRBUTI->BD6_NOMUSR,''), SE1->E1_NOMCLI ),;
									_cNomRDA,;					
									DtoS(TRBUTI->BD6_DATPRO),;
									TRBUTI->BD6_NUMERO,;
									TRBUTI->BD6_CODPRO,;
									TRBUTI->BD6_DESPRO,;
									IIf(TRBUTI->BD6_BLOCPA == "1",0,TRBUTI->BD6_VLRTPF),;
									TRBUTI->BD6_IDUSR ,;
									TRBUTI->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),;
									'2',;
									nVlrTotBol,;
									"1"}) //Atribuido fixo 1 pois sera sempre debito de co-part.
		    Else 
		    
		    		     	Aadd(aCobranca,{	IIf(nPosBD6==0,TRBUTI->BD6_NOMUSR,''),;
									_cNomRDA,;					
									DtoS(TRBUTI->BD6_DATPRO),;
									TRBUTI->BD6_NUMERO,;
									TRBUTI->BD6_CODPRO,;
									TRBUTI->BD6_DESPRO,;
									IIf(TRBUTI->BD6_BLOCPA == "1",0,TRBUTI->BD6_VLRTPF),;
									TRBUTI->BD6_IDUSR ,;
								TRBUTI->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),;
									'2',;
									nVlrTotBol,;
									"1"}) //Atribuido fixo 1 pois sera sempre debito de co-part.
  
		    
		    EndIf
		    
		    // EndIf
		    
		    RestArea( a_AreaBa3 )
		
			TRBUTI->(DbSkip())
		
		Enddo
		
		TRBUTI->(DbCloseArea())
	Else
	
		
		cAnoMesPgt := PLSDIMAM(R240Imp->(E1_ANOBASE),R240Imp->(E1_MESBASE),"0")
		cAnoMesPgt := PLSDIMAM(Substr(cAnoMesPgt,1,4),Substr(cAnoMesPgt,5,2),"0")
	
		_cSQLUti := " SELECT * FROM "+RetSQLName("BD6")
		_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
		_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
		_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
		_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "     
		_cSQLUti += " AND ( ( BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "	   
		_cSQLUti += " AND BD6_VLRTPF > 0 ) OR "

		_cSQLUti += " ( (BD6_VLRTPF = 0 OR BD6_BLOCPA = '1' ) AND BD6_VLRPAG > 0 AND SUBSTR(BD6_NUMLOT,1,6) = '"+cAnoMesPgt+"' ) ) "
		_cSQLUti += " AND BD6_NUMFAT =  '" + R240Imp->E1_PLNUCOB  + "' "
		_cSQLUti += " AND "+RetSQLName("BD6")+".D_E_L_E_T_ <> '*' "
		_cSQLUti += " ORDER BY BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DATPRO"//, BD6_NOMRDA, BD6_CODPRO "
		               
		MemoWrit("C:\BORD3.TXT", _cSQLUti)


		PLSQUERY(_cSQLUti,"TRBUTI")   
        
		If !TRBUTI->(  EOF() )
	
		  	Aadd(aCobranca,{  		R240Imp->E1_NOMCLI ,;
									" ",;					
									DtoS( R240Imp->E1_EMISSAO ),;
									" ",;
									" ",;
									"CO-PARTICIPACAO",;
									R240Imp->E1_VALOR,;
									" " ,;
									" ",;
									'2',;
									R240Imp->E1_VALOR,;
									"1"}) //Atribuido fixo 1 pois sera sempre debito de co-part.    
									
      EndIf     
       
       TRBUTI->(DbCloseArea())
	
	EndIf    
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ordena array pela matricula do usuario...            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort( aCobranca,,,{|x,y| x[9]+X[10]+x[3]+x[5]+x[12] < y[9]+Y[10]+y[3]+y[5]+y[12]} )

	aBfq := RetornaBfq(R240Imp->E1_CODINT, "199")    
	If R240Imp->E1_IRRF > 0
//altamiro  em 11/11/2009 - sujeira no campo despesa retirada a referencia aBfq[2] da possição 11 do vetor 
		Aadd(aCobranca,{	"",	"",	"", "",	aBfq[1],AllTrim(aBfq[3])+" (-) ", R240Imp->E1_IRRF,	"",	"",	"",	""})
	EndIf         
//altamiro  em 26/11/2009 - Inclusao no boleto das linhas referentes ao impostos , Iss , pis , cofins e csll se incidente
	If R240Imp->E1_ISS > 0
		Aadd(aCobranca,{	"",	"",	"",	"",	"199", "Iss" + " (-) ", R240Imp->E1_ISS, "", "", "",""})
	EndIf         	
	If R240Imp->E1_CSLL > 0                       
		Aadd(aCobranca,{	"",	"",	"",	"",	"199","Csll" +  " (-) ", R240Imp->E1_CSLL, "", "", "",""})
	EndIf         	
    If R240Imp->E1_COFINS > 0
		Aadd(aCobranca,{	"",	"",	"",	"",	"199","Cofins" + " (-) ", R240Imp->E1_COFINS, "", "", "",""})
	EndIf         	
	If R240Imp->E1_PIS > 0
		Aadd(aCobranca,{	"",	"",	"",	"",	"199", "Pis" + " (-) ", R240Imp->E1_PIS, "", "", "",""})
	EndIf
	
	aDadosEmp	:= {	BA0->BA0_NOMINT                                                           	,; //Nome da Empresa
						BA0->BA0_End                                                              	,; //Endereço
						AllTrim(BA0->BA0_BAIRRO)+", "+AllTrim(BA0->BA0_CIDADE)+", "+BA0->BA0_EST 	,; //Complemento
						STR0045+Subs(BA0->BA0_CEP,1,5)+"-"+Subs(BA0->BA0_CEP,6,3)             		,; //CEP //"CEP: "
						STR0046+BA0->BA0_TELEF1                                           		,; //Telefones //"PABX/FAX: "
						STR0047+Subs(BA0->BA0_CGC,1,2)+"."+Subs(BA0->BA0_CGC,3,3)+"."+; //"CNPJ.: "
						Subs(BA0->BA0_CGC,6,3)+"/"+Subs(BA0->BA0_CGC,9,4)+"-"+;
						Subs(BA0->BA0_CGC,13,2)                                                    	,; //CGC
						STR0043 + BA0->BA0_SUSEP }  //I.E //"ANS : "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega mensagens para boleto.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aObservacoes := {}
	//aObservacoes := PLR240TEXT(2 ,R240Imp->E1_CODINT	,R240Imp->E1_CODEMP,R240Imp->E1_CONEMP	,;
	//                             R240Imp->E1_SUBCON	,R240Imp->E1_MATRIC ,R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE)
	                                                                 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega mensagens de Ir     ano base 2009              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If .f. .and. cAnotit + cMesTit >= '201402' .and.  cAnotit + cMesTit <= '201402'  

	     c_IR := IR2009(aObservacoes) //  mbc

	EndIf	
	         
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega mensagens de reajuste para analitico do boleto.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	If Len(aMsgRea) > 0 // .And. nTipCob == 2   // Msg Rea Motta
		For nCont := 1 to Len(aMsgRea)
	   			Aadd(aObservacoes,Substr(aMsgRea[nCont],1,100))
		Next
  	EndIf
	                                                                                 
	aMsgBoleto   := PLR240TEXT(1					,R240Imp->E1_CODINT	,R240Imp->E1_CODEMP,R240Imp->E1_CONEMP	,;
	R240Imp->E1_SUBCON	,R240Imp->E1_MATRIC ,R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE)
	
	SA1->(DbSeek(xFilial("SA1") + R240Imp->E1_CLIENTE + R240Imp->E1_LOJA))
	
	If Subs(aDadosBanco[1],1,3) == '001' //Banco do Brasil
		cCart := '18'
	ElseIf Subs(aDadosBanco[1],1,3) == '104' //CEF
		cCart := '82' 
	ElseIf Subs(aDadosBanco[1],1,3) == '341' //Itau
		cCart := '175' 
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados do Titulo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


	aDadosTit   :=  {	AllTrim(R240Imp->E1_NUM)+AllTrim(R240Imp->E1_PARCELA),; 	//Numero do título
						R240Imp->E1_EMISSAO,;             				//Data da emissão do título
						dDataBase,;             				//Data da emissão do boleto
						R240Imp->E1_VENCTO,;             				//Data do vencimento
						R240Imp->E1_SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
						" " }							//Nosso numero (Ver fórmula para calculo)
			
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados Sacado   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 	
	aDatSacado   := {	AllTrim(SA1->A1_NOME)                            ,;      //Razão Social
						AllTrim(SA1->A1_COD )                            ,;      //Código
						AllTrim(SA1->A1_End ) 							 ,;		  //Endereco
						AllTrim(SA1->A1_BAIRRO)							 ,;      //Bairro
						AllTrim(SA1->A1_MUN )                            ,;      //Cidade
						SA1->A1_EST                                      ,;      //Estado
						SA1->A1_CEP                                      }       //CEP
    
	If l_ImpSemFat // Custo    
	
	c_Qry := " SELECT * "
	c_Qry += " FROM TMP_EXTRATO "
	c_Qry += "      WHERE BD6_CODEMP= '" + R240Imp->E1_CODEMP +  "'" "
	c_Qry += "      AND BD6_MATRIC= '" + R240Imp->E1_MATRIC +  "'" "

	c_Qry += "      ORDER BY 10,11 "        
	
	MemoWrit("C:\temp\custo_e.TXT", c_Qry)
	
	PLSQuery(c_Qry,"CUSTTMP")
	
	While !CUSTTMP->( EOF() )        
	
	
			Aadd(aCobranca,{	CUSTTMP->BD6_NOMUSR,;
								CUSTTMP->BD6_NOMRDA,;
								DtoS(CUSTTMP->BD6_DATPRO),;
								CUSTTMP->BD6_NUMERO,;
								CUSTTMP->BD6_CODPRO,;
								CUSTTMP->BD6_DESPRO,;
								CUSTTMP->BD6_VLRTPF,;
								CUSTTMP->BD6_IDUSR ,;
								CUSTTMP->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),;
								'2',;
								CUSTTMP->BD6_VLRPAG,;
								"4"}) //Atribuido fixo 4 pois sera sempre debito de co-part.
        
          c_Sql:= " insert into log_extrato_010 values  ( "
          c_Sql+= "'" + CUSTTMP->BD6_CODLDP + "',"
          c_Sql+= "'" + CUSTTMP->BD6_CODPEG + "',"
          c_Sql+= "'" + CUSTTMP->BD6_NUMERO + "',"
          c_Sql+= "'" + CUSTTMP->BD6_SEQUEN + "',"
          c_Sql+= "0,"
          c_Sql+= "'" + R240Imp->E1_ANOBASE  +  "',"
          c_Sql+= "'" + R240Imp->E1_MESBASE  +  "',"
          c_Sql+= "'" + cAnoCust +  "',"
          c_Sql+= "'" + cMesCust +  "')"    
          
          	If TcSqlExec(c_Sql) < 0  
	
		  //	l_Ret := .F.
	
			EndIf	 

           
          CUSTTMP->( dbSkip() )
                     
    EndDo  
    
    CUSTTMP->( dbCloseArea() )  
	
	EndIf // Fim custo
	
	
	ImpAnlt(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,.T.			,;
					aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
					aDatSacado	,aMsgBoleto					,""						,aOpenMonth		,;
					aDepEndentes,aObservacoes				,cCart 					,cPrefixo		,;
					cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC		,lPrima	)  
					
					
						

				
	R240Imp->(DbSkip())
End             

c_LogGer := ""

//Ú--------------------------------------------------------------------¿
//| Fecha arquivos...                                                  |
//À--------------------------------------------------------------------Ù
R240Imp->(DbCloseArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nova Critica: nao gerar arquivo caso existam   ³  
	//³ inconsistencias na geracao.(Data: 8/11/07)     ³  	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(_aErrAnlt) > 0 
		PLSCRIGEN(_aErrAnlt,{ {"Cod. Beneficiário","@C",150},{"Descrição","@C",300}},"Críticas encontradas na exportação! Arquivo exportação analítico não será gerado!",.T.)		
		_aErrAnlt := {}
	EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Definir nome do arquivo, cfme convencionado... ³  
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPCont := 1
		nPCont1 := 1   
		
		For nPCont := 1 to Len(aMatUti)
		        
			cNomeArq := cDirExp+"extat"+cMesTit+Substr(cAnoTit,3,2)+Substr(aMatUti[nPCont],2)+".TXT"
			nReg := 1
			nRegCab := 0
			
			cQtdEx := '000000'
			
			//Raios - modIficar este ponto para imprimir mais rapidamente, atraves de temporario...
			If U_Cria_TXT(cNomeArq)
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao das linhas do arquivo...   	  ³  
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cArray := aMatUti[nPCont]
				cLin := Space(1)+cEOL

				
				For nPCont1 := 1 to Len(&cArray)      
				
					cEleImp := cArray+"[nPCont1]"
					
					If !(U_GrLinha_TXT(&cEleImp+StrZero(nReg,5),cLin))
						MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
						Return
					EndIf
					nReg++
					
					If Substr(&cEleImp,1,1) == "1"
						nRegCab++          
						cQtdEx := soma1( cQtdEx )
					EndIf
					
				Next

				c_LogGer += "Arquivo " + "extat"+cMesTit+Substr(cAnoTit,3,2)+Substr(aMatUti[nPCont],2)+": Gerados " + cQtdEx + " extratos. " + cEOL
				c_LogGer += "________________________________________________________________________________" + cEOL
				c_LogGer += " " + cEOL
				c_LogGer += " " + cEOL


				U_Fecha_TXT()	
				
				aadd(aMatExi,{cNomeArq,Str(nRegCab)})
				
			EndIf
					
		Next
	
		If Len(aMatExi) > 0
			PLSCRIGEN(aMatExi,{ {"Nome Arquivo","@C",150},{"Qtd. Familias","@C",60} },"Exportação concluída! VerIfique os resultados.",.T.)
		EndIf
		
	//EndIf

If !Empty( c_LogGer )  

	cNomeArq := cDirExp+"LOG_EXTRATO"+cMesTit+Substr(cAnoTit,3,2)+".TXT"

	MemoWrit(cNomeArq,  c_LogGer)	     
	
EndIf

If Len(aCritica) > 0
	PLSCRIGEN(aCritica,{ {"Descrição da inconsistência","@C",200},{"Chave do título","@C",100}},"Críticas encontradas na exportação! Arquivo exportação CNAB não será gerado!",.T.)
   //	FErase(GETNEWPAR("MV_YDIBOL","\CNAB\Exporta\")+_cSeqNom+".txt")
	
	Libera_CNAB(_cSeqNom)		
	
EndIf

aCritica := {}

//Ú--------------------------------------------------------------------------¿
//| Fim do Relat¢rio                                                         |
//À--------------------------------------------------------------------------Ù
Return

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PLR240MES ºAutor  ³Rafael M. Quadrotti º Data ³  02/04/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna os meses em aberto do sacado.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLR240MES(cCliente,cLoja,cMesBase,cAnoBase)
Local aMeses 	:= {} 							//Retorno da funcao.
Local cSQL      := ""							//Query
Local cSE1Name 	:= SE1->(RetSQLName("SE1"))	//retorna o alias no TOP.

SE1->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * FROM "+cSE1Name+" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
cSQL += "			E1_CLIENTE = '"+cCliente+"' AND "
cSQL += "			E1_LOJA    = '"+cLoja+"' AND "
cSQL += "			E1_SALDO > 0 AND "  
cSQL += "			E1_PREFIXO IN ('ANT','PLS') AND "
cSQL += "			E1_TIPO <> 'PR ' AND "
cSQL += "			E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND " 
cSQL += "         E1_ANOBASE||E1_MESBASE < '" + cAnoBase+cMesBase + "' AND "// aberto
cSQL += cSE1Name+".D_E_L_E_T_ = ' ' "
cSQL += "ORDER BY 1,2,3,4,5,6" //+ SE1->(IndexKey())  //aberto

 PLSQuery(cSQL,STR0040) //"Meses"

If Meses->(Eof())
	Meses->(DbCloseArea())
Else
	While 	!Eof() .And.;
		Meses->E1_CLIENTE == cCliente .And.;
		Meses->E1_LOJA ==	cLoja
		//If (cMesBase<>E1_MESBASE .And. cAnoBase<>E1_ANOBASE) // aberto
		If ! empty (E1_ANOBASE+E1_MESBASE)  // altmairo - tratar tit de impostos que sao gerados sem mesbase , anobase
		   If (cAnoBase+cMesBase<>E1_ANOBASE+E1_MESBASE)
		       Aadd(aMeses,E1_MESBASE+"/"+E1_ANOBASE)
		   EndIf	
		EndIf   
		DbSkip()
	End
	Meses->(DbCloseArea())
EndIf
Return (aMeses)

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PLR240TEXTºAutor  ³Rafael M. Quadrotti º Data ³  02/04/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna as mensagens para impressao.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³ Esta funcao executa uma selecao em tres tabelas para       º±±
±±º          ³ encontrar a msg relacionada ao sacado.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PLR240TEXT(	nTipo	,cCodInt	,cCodEmp	,cConEmp,;
							cSubCon	,cMatric	,cBase	)//cBase = Ano+mes
Local cQuery	:= ""
Local cNTable1	:= "" // Nome da tabela no SQL
Local cNTable2	:= "" // Nome da tabela no SQL
Local cNTable3	:= "" // Nome da tabela no SQL
Local aMsg		:= {} // Array de mensagens
Local nCont		:= 0 
Local cMsg01    := ""
Local nLimite   := 100 // Motta 08/07/08 para agosto/08 // 90 // limite linha msg Motta 16/8/07        


If funname() ==  "PLSA730"
      
	nLimite   := 101

EndIf

DbSelectArea("BH1")
DbSetOrder(2)
cNTable1 := RetSqlName("BH1")
cNTable2 := RetSqlName("BA3")
cNTable3 := RetSqlName("BH2")

cQuery := "SELECT BH1.* ,BH2.* "
If !Empty(cMatric)
	cQuery += " ,BA3.BA3_CODPLA,BA3.BA3_FILIAL,BA3.BA3_CODINT,BA3.BA3_CODEMP,BA3.BA3_MATRIC,BA3.BA3_CONEMP,BA3.BA3_VERCON,BA3.BA3_SUBCON,BA3.BA3_VERSUB "
EndIf
cQuery += " FROM " +cNTable1+ " BH1 , " +cNTable3 +" BH2 "
If !Empty(cMatric)
	cQuery += " , "+cNTable2 +" BA3 " 
EndIf

//BH1
cQuery += "WHERE BH1.BH1_FILIAL='"	+	xFilial("BH1")		+	"'    AND "
cQuery += "		 BH1.BH1_CODINT='"	+	cCodInt				+	"'    AND "
cQuery += "		 BH1.BH1_TIPO='"	+	Transform(nTipo,"9")+	"'    AND "
If !Empty(cCodEmp)
	cQuery += "(('"+cCodEmp +"' BETWEEN BH1.BH1_EMPDE   AND BH1.BH1_EMPATE) OR (BH1.BH1_EMPATE='' AND BH1.BH1_EMPDE='') ) AND "
EndIf
If !Empty(cConEmp)
	cQuery += "(('"+cConEmp +"' BETWEEN BH1.BH1_CONDE   AND BH1.BH1_CONATE)  OR (BH1.BH1_CONATE='' AND BH1.BH1_CONDE='') ) AND "
EndIf
If !Empty(cSubCon)
	cQuery += "(('"+cSuBCon +"' BETWEEN BH1.BH1_SUBDE   AND BH1.BH1_SUBATE)  OR (BH1.BH1_SUBATE='' AND BH1.BH1_SUBDE='') ) AND "
EndIf
If !Empty(cMatric)
	cQuery += "(('"+cMatric +"' BETWEEN BH1.BH1_MATDE   AND BH1.BH1_MATATE)  OR (BH1.BH1_MATATE='' AND BH1.BH1_MATDE='') ) AND "
EndIf
If !Empty(cBase)
	cQuery += "(('"+cBase   +"' BETWEEN BH1.BH1_BASEIN AND BH1.BH1_BASEFI) OR (BH1.BH1_BASEIN='' AND BH1.BH1_BASEFI='') ) AND "
EndIf
//BA3 PARA ENCONTRAR O PLANO, CASO MATRICULA SEJA INFORMADA!
If !Empty(cMatric)
	cQuery += "		 BA3.BA3_FILIAL='"	+	xFilial("BA3")	+	"'    AND "
	cQuery += "		 BA3.BA3_CODINT='"	+	cCodInt  		+	"'    AND "
	cQuery += "		 BA3.BA3_CODEMP='"	+	cCodEmp  		+	"'    AND "
	cQuery += "		 BA3.BA3_MATRIC='"	+	cMatric  		+	"'    AND "
	cQuery += "		((BA3.BA3_CODPLA BETWEEN BH1.BH1_PLAINI AND BH1.BH1_PLAFIM) OR (BH1.BH1_PLAINI='' AND BH1.BH1_PLAFIM='') ) AND "
EndIf

//BH2 MENSAGENS PARA IMPRESSAO
cQuery += "		 BH2.BH2_FILIAL = '"	+	xFilial("BH2")	+	"'    AND "
cQuery += "		 BH2.BH2_CODIGO = BH1.BH1_CODIGO  AND "

cQuery += "		BH1.D_E_L_E_T_<>'*' AND BH2.D_E_L_E_T_<>'*' "

If !Empty(cMatric)
	cQuery += " AND BA3.D_E_L_E_T_<>'*' "
EndIf

cQuery += "ORDER BY " + BH1->(IndexKey())      


//fim mensagem cpf duplicidade 
PLSQuery(cQuery,"MSG")           

If MSG->(Eof())
	MSG->(DbCloseArea())
	Aadd(aMSG,"")
Else
	While !MSG->(Eof())
		If IIf(BH1->(FieldPos("BH1_CONDIC")) > 0 , (Empty(MSG->BH1_CONDIC) .or. (&(MSG->BH1_CONDIC))), .T.) 
		    If MSG->BH1_TIPO == '2' // Observacao   
		  	  cMsg01 := MSG->BH2_MSG01
		  	  Aadd(aMSG,Substr(cMsg01,1,nLimite)) // Paulo Motta 16/8/7
		  	  Aadd(aMSG,Substr(cMsg01,(nLimite + 1),nLimite))  
		  	  Aadd(aMSG,Substr(cMsg01,(2*nLimite + 1),nLimite))  
		  	  //Aadd(aMSG,Substr(cMsg01,(3*nLimite + 1),nLimite)) // Paulo Motta 8/7/08  
		  	  //Aadd(aMSG,Substr(cMsg01,(4*nLimite + 1),nLimite)) // Paulo Motta 8/7/08                 
		    Else
		      Aadd(aMSG,&(MSG->BH2_MSG01))
		    EndIf
		EndIf
		MSG->(DbSkip()) //DbSkip()
	Enddo
	If Len(aMSG) == 0
		Aadd(aMSG,"")
	EndIf			
	MSG->(DbCloseArea())
EndIf

Return aMsg

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ret_cBarra³ Autor ³ Rafael M. Quadrotti   ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ EspecIfico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Ret_cBarra(	cBanco	,cAgencia	,cConta		,cDacCC		,;
							cNroDoc	,nValor		,cPrefixo	,cNumero	,;
							cParcela	,cTipo	,cCart)
Local cMsg     := ""
Local aArea		:= GetArea()
Local aCodBar	:= {}
Local cMoeda	:= "9"

DbSelectArea("SE1")
DbSetOrder(1)
If MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)
	If !ExistBlock("RETDADOS")
	   MsgInfo(STR0056)  //"O RDMAKE, RETDADOS, referente ao layout do boleto, não foi encontrado no repositório"
	Else
	   aCodBar:=U_RetDados(	cPrefixo	,cNumero	,cParcela	,cTipo	,;
							cBanco		,cAgencia	,cConta		,cDacCC	,;
							cNroDoc		,nValor		,cCart		,cMoeda	)
	   If Len(aCodBar)=3
	      If Empty(aCodBar[1])
		      cMsg     += STR0057  		//"[1]codigo de barra "
	      EndIf
	      If Empty(aCodBar[2])
		      cMsg     += STR0058  		//"[2]linha digitavel "
	      EndIf
	      If Empty(aCodBar[3])
		      cMsg     += STR0059 		//"[3]nosso numero "
	      EndIf
          If !empty(cMsg)
             MsgInfo(STR0060+cMsg )  	//"Erro no(s) campo(s): "
	         aCodBar	:= {}   
          EndIf
	   EndIf			
	EndIf						
EndIf
RestArea(aArea)
Return aCodBar

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaSX1   ºAutor  ³ Jean Schulz        º Data ³  10/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria / atualiza parametros solicitados na geracao do boleto.º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Cliente De")			,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Loja De")				,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Cliente Ate")			,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Lota Ate")				,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Operadora De")			,"","","mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Operadora Ate")		,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Empresa De")			,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Empresa Ate")			,"","","mv_ch8","C",04,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Contrato De")			,"","","mv_ch9","C",12,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Contrato Ate")			,"","","mv_cha","C",12,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("SubContrato De")		,"","","mv_chb","C",09,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("SubContrato Ate")		,"","","mv_chc","C",09,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Matricula De?")		,"","","mv_chd","C",06,0,0,"G","","BA1NUS","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"14",OemToAnsi("Matricula Ate")		,"","","mv_che","C",06,0,0,"G","","BA1NUS","","","mv_par14","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"15",OemToAnsi("Mes Titulo")			,"","","mv_chf","C",02,0,0,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"16",OemToAnsi("Ano Titulo")			,"","","mv_chg","C",04,0,0,"G","","","","","mv_par16","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"17",OemToAnsi("Tipo de Cobrança")		,"","","mv_chh","N",01,0,0,"C","","","","","mv_par17","Previ","","","","112","","","Sisdeb","","","Todos","","","","","",{},{},{})
PutSx1(cPerg,"18",OemToAnsi("Prefixo De")			,"","","mv_chi","C",03,0,0,"G","","","","","mv_par18","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"19",OemToAnsi("Prefixo Ate")			,"","","mv_chj","C",03,0,0,"G","","","","","mv_par19","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"20",OemToAnsi("Numero De")			,"","","mv_chk","C",09,0,0,"G","","","","","mv_par20","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"21",OemToAnsi("Numero Ate")			,"","","mv_chl","C",09,0,0,"G","","","","","mv_par21","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"22",OemToAnsi("Parcela De")			,"","","mv_chm","C",01,0,0,"G","","","","","mv_par22","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"23",OemToAnsi("Parcela Ate")			,"","","mv_chn","C",01,0,0,"G","","","","","mv_par23","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"24",OemToAnsi("Tipo De")				,"","","mv_cho","C",03,0,0,"G","","","","","mv_par24","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"25",OemToAnsi("Tipo Ate")				,"","","mv_chp","C",03,0,0,"G","","","","","mv_par25","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"26",OemToAnsi("Data da instrução")	,"","","mv_chq","D",08,0,0,"G","","","","","mv_par26","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"27",OemToAnsi("Bordero De")			,"","","mv_chr","C",06,0,0,"G","","","","","mv_par27","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"28",OemToAnsi("Bordero Ate")			,"","","mv_chs","C",06,0,0,"G","","","","","mv_par28","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"29",OemToAnsi("Ano Custo")			,"","","mv_cht","C",04,0,0,"G","","","","","mv_par29","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"30",OemToAnsi("Mes Custo")			,"","","mv_chu","C",04,0,0,"G","","","","","mv_par30","","","","","","","","","","","","","","","","",{},{},{})

Return
*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MesExten  ºAutor  ³Jean Schulz         º Data ³  13/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Transforma o mes repassado por parametro para extenso...    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MesExt(cMes)
Local cString := Space(11)

Do case
	Case cMes == "01"
		cString := "Janeiro    "
	Case cMes == "02"
		cString := "Fevereiro  "
	Case cMes == "03"
		cString := "Marco      "
	Case cMes == "04"
		cString := "Abril      "
	Case cMes == "05"
		cString := "Maio       "
	Case cMes == "06"
		cString := "Junho      "
	Case cMes == "07"
		cString := "Julho      "
	Case cMes == "08"
		cString := "Agosto     "
	Case cMes == "09"
		cString := "Setembro   "
	Case cMes == "10"
		cString := "Outubro    "
	Case cMes == "11"
		cString := "Novembro   "
	Case cMes == "12"
		cString := "Dezembro   "																		
EndCase

Return cString

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UNIfUNC   ºAutor  ³ Jean Schulz        º Data ³  09/10/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para inclusao da mensagem do boleto de reajuste.    º±±
±±º          ³ Rotina reescrita em junho/09                          	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAPLS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NMenReaj(aProdutos,cTipPes, c_AnoMes, cPerRea, cIndRea)
Local aMsg		:= {}
Local nCont		:= 0
Local cMsgComp	:= GetNewPar("MV_PLYMSRE","Comunicação de reajuste será protocolada na ANS até trinta dias após aplicação, cfme RN 99/05.")    
Local cMsg     := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³LegEnda para matriz de produtos.	         						³
//³1 - Codigo do Produto									  				³
//³2 - Nome do Produto										  				³
//³3 - Nro do Produto na ANS								  				³
//³4 - Percentual reajustado								  				³
//³5 - Nro oficio ANS que liberou o reajuste.						³
//³6 - Nro do contrato ou apolice (nro subcontrato - PJ)			³
//³7 - Plano coletivo com (1) ou sem (0) patrocinador - PJ)		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ																					

// Obter mensagem do plano

If  cEmpAnt == "01" // Caberj
	SZI->(DbSetOrder(1)) 
	SZI->(MsSeek(xFilial("SZI")+BA3->BA3_CODINT+BA3->BA3_CODEMP))
	While ! SZI->(Eof()) 

 	If c_AnoMes >= SZI->ZI_REFDE .AND. c_AnoMes <= SZI->ZI_REFATE .AND. cIndRea == SZI->ZI_INDREA
   		If BA3->BA3_CODPLA >= SZI->ZI_PLADE .AND. BA3->BA3_CODPLA <= SZI->ZI_PLAATE .AND. cIndRea == SZI->ZI_INDREA 
     		Exit
   		EndIf
 	EndIf          
 	
 	**'-Marcela Coimbra - 05/07/2010 -----------------'**
 	**'-Inclusao de dbSkip para tratar loop infinito--'**
 	**'-Inicio ---------------------------------------'**  
 	
  	SZI->( dbSkip() )                                    
 	
 	**'-Marcela Coimbra - 05/07/2010 -----------------'**
  	**'-Fim ------------------------------------------'**
 	        
	Enddo               	

    If SZI->ZI_NPARCE > 1 
  		cNumProc := Str((Val(BA3->BA3_MESREA) + 1) - Val(BA3->BA3_YMESRE))
	EndIf

	If !Empty(SZI->ZI_MENSAGE)
	  cMsg := &(SZI->ZI_MENSAGE)  
	  cMsg := strTran( cMsg, 'XXX', cPerRea )
	EndIf	  
	nCont := 0 
                                       
	aMsg := justIficatxt(cMsg, 92 ) 

EndIf	                

Return aMsg

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PercReajuste ºAutor  ³Jean Schulz      º Data ³  02/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que busca o percentual de reajuste referente a comp. º±±
±±º          ³passada por parametro.                           			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PercReajuste(cAnoMes,cMatric)
Local nPerRea	:= 0
Local cTipPess	:= "J"

BHW->(DbSetOrder(2)) //Tabela de aplicacao de reajuste
BYC->(DbSetOrder(2)) //Reajustes Fx. Etaria X Subcontrato
BP7->(DbSetOrder(2)) //Reajustes Fx. Etaria X Familia
BYB->(DbSetOrder(2)) //Reajustes Fx. Etaria X Usuario

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Encarar como fisica todos que o nivel de cobranca seja na familia.	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If BA3->BA3_COBNIV == "1"
	cTipPess := "F"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Buscar reajustes aplicados no mes...                              	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If BHW->(MsSeek(xFilial("BHW")+cAnoMes+PLSINTPAD()))

	While ! BHW->(Eof()) .And. BHW->(BHW_ANOMES+BHW_CODINT) == cAnoMes+PLSINTPAD()
	
		If Substr(cMatric,5,4) >= BHW->(BHW_EMPDE) .And. Substr(cMatric,5,4) <= BHW->(BHW_EMPATE)
			If cTipPess == "J"
				//BYC_FILIAL+BYC_OPEREA+BYC_CODREA+BYC_CODOPE+BYC_CODEMP+BYC_CONEMP+BYC_CONEMP+BYC_VERCON+BYC_SUBCON+BYC_VERSUB+BYC_CODPRO+BYC_VERPRO+BYC_CODFOR
				If BYC->(MsSeek(xFilial("BYC")+PLSINTPAD()+BHW->BHW_CODREA+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)))
					nPerRea := BYC->BYC_PERREA
				EndIf
				
			Else			
				//BP7_OPEREA + BP7_CODREA + BP7_CODOPE + BP7_CODEMP + BP7_MATRIC + BP7_CODFAI
				If BP7->(MsSeek(xFilial("BP7")+PLSINTPAD()+BHW->BHW_CODREA+Substr(cMatric,1,14)))
					nPerRea := BP7->BP7_PERREA
				EndIf		
				
				//BYB_OPEREA + BYB_CODREA + BYB_CODOPE + BYB_CODEMP + BYB_MATRIC + BYB_TIPREG + BYB_CODFAI
				If BYB->(MsSeek(xFilial("BYB")+cMatric))	
					nPerRea := BYB->BYB_PERREA
				EndIf           			
				
			EndIf			
		EndIf
		
		BHW->(DbSkip())
		
	Enddo
	
EndIf

	
Return nPerRea

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ ImpAnlt  ³ Autor ³ Jean Schulz           ³ Data ³ 08.02.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime analitico para impressao em grafica.               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ImpAnlt(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
							aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
							aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
							aDepEndentes	,aObservacoes	,cCart			,cPrefixo	,;
							cTitulo			,cGrupoEmp 		,cMatric		,lPrima	 	)

Local nI		:= 0	// Contador do laco para impressao de depEndentes.
Local nMsg      := 0    // Contador para as mensagens
Local cMoeda	:= "9"  // Moeda do boleto.
Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = normal 2 = Grande.
Local nCob		:= 0	// Contador para for do extrato.
Local cString	:= ""
Local cNomeArq	:= ""

Local nPosC		:= At("-",aDatSacado[3])           
Local cEndereco	:= Substr(aDatSacado[3],1,IIf(nPosC>0,nPosC-1,Len(aDatSacado[3])))
//Local cBairro	:= IIf(nPosC>0,Substr(aDatSacado[4],nPosC+1),"")
Local cBairro	:= aDatSacado[4]
Local cMunici	:= aDatSacado[5]
Local cEstado	:= aDatSacado[6]
Local cCEP		:= aDatSacado[7]

Local cCpo 		:= ""
Local aNomeMes	:= { "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" }
Local aArBA1	:= BA1->(GetArea())
Local aArSA1	:= SA1->(GetArea())

Local nTotCopUsr := 0
Local _nPosTotC	:= 0

Local cTipLanAn	:= "" 
Local nTotRtContr := 0
Local nTotContr := 0
Local nTotCopar	:= 0
Local nTotBPF	:= 0
Local nTotOutr	:= 0
Local nRegBA1	:= 0
Local nRegTitu	:= 0
Local lEntrou	:= .F.
Local aTotUsr	:= {}
Local nTotContUsr := 0
Local nTotOutrUsr := 0
Local nTotCusto := 0

Private cMsg1	:= ""
Private cMsg2	:= ""
Private cMsg3	:= ""

Private nPCont 	:= 0
Private nPCont1	:= 0
Private nPass	:= 0


If Len(aCobranca) <= 0
	Return Nil
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Buscar dados do titular...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
BA1->(DbSetOrder(1))
BA1->(MsSeek(xFilial("BA1")+Substr(aCobranca[1,9],1,14)+"T"))
nRegTitu := BA1->(RecNo())                        
BA1->(DbSetOrder(2))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Somente exportar quando existir utilizacao...                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
//cEndereco := aDatSacado[3]
cEndereco := Substr(cEndereco,1,40)
cCompet := aNomeMes[Val(R240Imp->E1_MESBASE)]+" de "+R240Imp->E1_ANOBASE

BA3->(DbSetOrder(1))
BA3->(MsSeek(xFilial("BA3")+Substr(aCobranca[1,9],1,14)))

If BA3->BA3_COBNIV == "1"

	aArSA1 := SA1->(GetArea())
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial("BA3")+Substr(aCobranca[1,9],1,14)))
	//cEndereco := Substr(SA1->A1_End,1,40)
	RestArea(aArSA1)
EndIf

aadd(aImp,{Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3),aCobranca[1,9],"",{},{},R240Imp->E1_FORMREC})
BFQ->(DbSetOrder(1))

//Obter valor de coparticipacao individualizado...
//Montar array para impressao posterior
cMatAnt := aCobranca[1,9]

//PEndente: ordenar matriz...

For nPCont := 1 To Len(aCobranca)

	If aCobranca[nPCont,9] <> cMatAnt
		aadd(aTotUsr,{aCobranca[nPCont-1,9],nTotCopUsr,nTotContUsr,nTotOutrUsr, nTotRtContr})
		cMatAnt 	:= aCobranca[nPCont,9]
		nTotCopUsr 	:= 0
		nTotContUsr := 0
		nTotOutrUsr := 0     
	
	EndIf
	
	If substr(aCobranca[nPCont,9], 1, 14 ) <> substr(cMatAnt, 1, 14 ) 
	
		nTotCusto 	:= 0   
	
	
	EndIf
	
	If Len(AllTrim(aCobranca[nPCont,5])) == 3
		cTipLanAn := Posicione("BFQ",1,xFilial("BFQ")+PLSINTPAD()+aCobranca[nPCont,5],"BFQ_YTPANL")
	Else
		cTipLanAn := "C"
	EndIf
	

	If cTipLanAn == "M"	
		nTotContr	+= IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]	
		nTotContUsr += IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]		
	Else
	    
		If cTipLanAn == "C"	
		
		    VarTst := aCobranca[nPCont,11]
			nTotCopUsr	+= IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]	
			nTotCopar	+= IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]	
			nTotCusto	+= IIf(aCobranca[nPCont,12]=="4",(1),0)*aCobranca[nPCont,11]	
			If Type("VarTst") == "N"
				nTotBPF		+= IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,11]	
				nVlrBPF		:= IIf(aCobranca[nPCont,12]=="1",(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,11]	
			Else
				nVlrBPF 	:= 0
			EndIf
			
		Else
			nTotOutr	+= IIf(aCobranca[nPCont,12]=="1" ,(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]	
			nTotOutrUsr += IIf(aCobranca[nPCont,12]=="1" ,(1),iif(aCobranca[nPCont,12]=="2",(-1),0))*aCobranca[nPCont,07]	
		  //		nTotCusto	+= IIf(aCobranca[nPCont,12]=="4",(1),0)*aCobranca[nPCont,07]	
			nVlrBPF 	:= 0
		EndIf
		
		_cDatTmp	:= IIf(Empty(aCobranca[nPCont,3]),Space(10),Substr(aCobranca[nPCont,3],7,2)+"/"+Substr(aCobranca[nPCont,3],5,2)+"/"+Substr(aCobranca[nPCont,3],1,4))
	
		cCpo :=	"3"+;
				"2"+;
				Substr(aCobranca[nPCont,9],1,4)+"."+Substr(aCobranca[nPCont,9],5,4)+"."+Substr(aCobranca[nPCont,9],9,6)+"."+Substr(aCobranca[nPCont,9],15,2)+"-"+Substr(aCobranca[nPCont,9],17,1)+;
				_cDatTmp+;
				Space(20)+;
				AllTrim(Substr(aCobranca[nPCont,2],1,20))+Space(20-Len(AllTrim(Substr(aCobranca[nPCont,2],1,20))))+;
				AllTrim(Substr(aCobranca[nPCont,6],1,30))+Space(30-Len(AllTrim(Substr(aCobranca[nPCont,6],1,30))))+;
				IIf(nVlrBPF > 0.or.aCobranca[nPCont,12]=='4',Transform(aCobranca[nPCont,11],"@E 999,999.99"),Space(10))+;
				Transform(aCobranca[nPCont,07],"@E 999,999.99")+;
				Space(1)+;
				Space(428)	
				
		Aadd(aImp[1,5],cCpo)
	EndIf

Next

//Busca o ultimo registro.
If Len(aCobranca) > 0 .And. (nTotCopUsr<> 0 .Or. nTotContUsr <> 0 .Or. nTotOutrUsr <> 0 )
	aadd(aTotUsr,{aCobranca[Len(aCobranca),9],nTotCopUsr,nTotContUsr,nTotOutrUsr, nTotRtContr})
	nTotCopUsr := 0
	nTotContUsr := 0
	nTotOutrUsr := 0
EndIf

/*aberto*/

If Len(aOpenMonth) > 0
    cCpo :=	"4"+;
			   "MESES EM ABERTO"+Space(86)+;
			   Space(450)				
		Aadd(aImp[1,5],cCpo)
End If

For nAbcnt := 1 to Len(aOpenMonth)
    cCpo :=	"4"+;
			   aOPenMonth[nAbcnt]+Space((100-Length(aOPenMonth[nAbcnt])))+;
			   Space(451)	//Motta				
		Aadd(aImp[1,5],cCpo)
Next nAbcnt   
    
cMsqTmp := ""  

For nPCont := 1 to Len(aTotUsr)		

	nRegBa1 := BA1->(Recno())
	BA1->(MsSeek(xFilial("BA1")+aTotUsr[nPCont,1]))

		cCpo :=	"2"+;
				"1"+;
				BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
				Substr(BA1->BA1_NOMUSR,1,30)+;
				Space(10)+; //Nao enviar
				Space(2)+; //Nao enviar
				Space(12)+; //Nao enviar
				Transform(aTotUsr[nPCont,3],"@E 9,999.99")+; //Valor Contraprestacao - Motta Jan/2012
				Transform(aTotUsr[nPCont,2]+aTotUsr[nPCont,4],"@E 999,999.99")+; //Valor Coparticipacao + Valor Outros
				Space(443)

	Aadd(aImp[1,4],cCpo)	

Next



cContr := 0

For nPCont := 1 To Len(aObservacoes)

	cNomVar := "cMsg"+StrZero(nPCont,1)
		
	If !Empty(cMsqTmp)                  
	
		&cNomVar := cMsqTmp    
		cMsqTmp  := ""
		cContr   := 1
	
	Else		
    
		&cNomVar := aObservacoes[nPCont - cContr]

	EndIf
	
	If nPCont > 3
		Exit
	EndIf    
	
Next                
                   
If Len(aMsgReaj) > 1

	cMsg1 := strtran(aMsgReaj[1], '   ', ' ')
	cMsg2 := strtran(aMsgReaj[2], '   ', ' ')
	
EndIf

If Len(aMsgReaj) == 3
    
	cMsg3 := strtran(aMsgReaj[3], '   ', ' ')

EndIf   

If VerAdp(BA3->ba3_codcli) .and. .F.//GetNewPar("MV_YGRIMVZ","0") == "1"  

If EMpty(cMsg1)

	cMsg1 := "Declaramos a quitacao do ano de 2013, a mesma substitui todos os recibos de pagamento do ano de "
	cMsg2 := "2013. Debitos prorrogados ou negociados para períodos futuros não estao contemplados."
	
Else
	cMsg3 := strtran(cMsg1, '   ', ' ')
	cMsg1 := "Declaramos a quitacao do ano de 2013, a mesma substitui todos os recibos de pagamento do ano de"
	cMsg2 := "2013. Debitos prorrogados ou negociados para períodos futuros não estao contemplados."
	
EndIf

EndIf



BA1->(DbGoTo(nRegTitu))  
	
	cCpo :=	"1"+;    //1
			"2"+;    //2
			BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;  //20
			StrZero(Val(BA1->BA1_MATEMP),18)+; //38
			Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;//
			Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
			Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
			Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
			Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
			cEstado+;
			cCompet+Space(17-Len(cCompet))+;
			Transform(nTotCusto,"@E 9,999,999.99")+;
			Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao '+' + Transform(nTotRtContr,"@E 999.99")+; //Total Retroativo
			Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
			Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
			Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
			Space(3)+cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1       Space(4)+
			cMsg2+Space(100-Len(cMsg2))+;  //Mensagem 2
			cMsg3+Space(100-Len(cMsg3))+;  //Mensagem 3
			space(100)  

		
aImp[1,3] := cCpo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inserida validacao para criticar caso o valor do titulo	nao seja igual ao³
//³ valor total da exportacao... (Data: 8/11/07).                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTotContr+nTotCopar+nTotOutr <> R240Imp->E1_VALOR
	
	aadd(_aErrAnlt,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,"Tot. Analítico: "+Transform((nTotContr+nTotCopar+nTotOutr),"@E 999,999,999.99")+" Valor Título: "+Transform(R240Imp->E1_VALOR,"@E 999,999,999.99")})

EndIf

RestArea(aArBA1)

aSort(aImp,,, { |x,y| x[6]+x[1]+x[2] < y[6]+y[1]+y[2] })
nReg := 1
nPCont := 1

For nPCont := 1 to Len(aImp)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Somente exportar quando existir utilizacao...                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If !l_FamBlo .and.  ( ( ( Len(aImp[nPCont,5]) > 0 .Or. GetNewPar("MV_YGRIMVZ","0") == "1" )) ; // imprime_todos      )  
	                      .or. BA3->BA3_GRPCOB $ "1001|1002|1003"  )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Realizar controle de matriz x qtd linhas, necessario para o arquivo...   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		cNomArr := "a"
		
		Do Case
		   Case aImp[nPCont,6] == "01" //Arquivo Rio Previdencia...
				cNomArr += "1"
			
			Case aImp[nPCont,6] == "02" //Banco em liquidacao...
				cNomArr += "2"

			Case aImp[nPCont,6] == "06" //Debito em conta...
				cNomArr += "3"

			Case aImp[nPCont,6] == "04" //112
				cNomArr += "4"  
			
			Case aImp[nPCont,6] == "08" //Arquivo Rio Previdencia...
				cNomArr += "1"
		
		
		EndCase
		
		Do Case
		
			Case Len(aImp[nPCont,5]) <= 40
				cNomArr += "_40ca4"
			
			Case Len(aImp[nPCont,5]) > 40 .And. Len(aImp[nPCont,5]) <= 102
				cNomArr += "_102ca3"
			
			Case Len(aImp[nPCont,5]) > 102
				cNomArr += "_102mca32"
		
		EndCase						
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Incluir array utilizado na matriz de utilizacao...                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		If ascan(aMatUti,cNomArr) == 0
			aadd(aMatUti,cNomArr)
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atribuir conteudo da matriz para impressao posterior...                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Raios - modIficacao para geracao mais veloz utilizando arq. temporario...
		
		aadd(&cNomArr,aImp[nPCont,3])
	    
		nPCont1 := 1
		For nPCont1 := 1 To Len(aImp[nPCont,4])
			aadd(&cNomArr,aImp[nPCont,4,nPCont1])
		Next
	
		nPCont1 := 1
		For nPCont1 := 1 To Len(aImp[nPCont,5]) 
			aadd(&cNomArr,aImp[nPCont,5,nPCont1])
		Next  
		
	EndIf
		
Next    

aImp := {}

Return Nil
  
*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  | FRMMANT  ºAutor  ³Motta               º Data ³  08/24/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Formata Matricula antiga do Sistema                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß   
*/

Static Function FRMMANT(cMatAnt)

cMatAnt := Zeros(11 - Len(AllTrim(cMatAnt))) + AllTrim(cMatAnt)
cMatant := Substr(cMatant,1,3)+"."+Substr(cMatant,4,5)+"."+Substr(cMatant,9,2)+"-"+Substr(cMatant,11,1) 

Return cMatAnt

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BuscaDesBSQºAutor  ³Jean Schulz        º Data ³  11/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Melhoria para demonstrar a observacao do lancamento de debi-º±±
±±º          ³to/credito quando for originario de BSQ.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaDescr(cLanFat, cDesBM1, cAlias, cOrigem)

	Local cDescri	:= cDesBM1
	Local aAreaBSQ	:= BSQ->(GetArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso seja odonto, e origem BSQ, muda descricao...                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BM1->BM1_CODTIP $ GetNewPar("MV_YDESBSQ","939") .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS)
				cDescri := BSQ->BSQ_OBS
			EndIf
		EndIf
	EndIf

	// Parcelamento
	If BM1->BM1_CODTIP $ GetNewPar("MV_YPARBSQ","935") .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS) .And.;
				(BSQ->BSQ_CODLAN == SuperGetMv("MV_XXNEGDE",,"991") .Or.;
				 BSQ->BSQ_CODLAN == SuperGetMv("MV_XXNEGCR",,"990"))

				cDescri := FORMPARC(BSQ->BSQ_OBS)
			EndIf
		EndIf
	EndIf 

	//Mes e Ano Ref. Baixa em atraso.  Incluido por Gedilson Rangel
	If BM1->BM1_CODTIP == "937" .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS).And. BSQ->BSQ_CODLAN == GetNewPar("MV_YPAR2BSQ","993")
				cDescri := AllTrim(BM1->BM1_DESTIP)+"  REF:" + BSQ->BSQ_YMBASE + "/" +SUBSTR(BSQ->BSQ_YABASE,3,2)
			EndIf
		EndIf
	EndIf 

	RestArea(aAreaBSQ)

Return cDescri          

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FORMPARC  ºAutor  ³Microsiga           º Data ³  02/27/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FORMATA MENSAGEM DE PARCELAMENTO O NUMERO DA PARCELA       º±±
±±º          ³ PODE CONTER UM ALFA , ESTA FUNCAO AJUSTA ISTO              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/      
Static Function FormParc(cBsqObs)

	Local cRetObs		:= AllTrim(cBsqObs)
	Local cObs			:= Upper(cRetObs)
	Local nPosParc		:= At("PARCELA", cObs) + 8
	Local nPosDe		:= At("DE", cObs)
	Local cParc			:= SubStr(cRetObs, nPosParc, nPosDe - (nPosParc + 1))
	Local cTotParc		:= SubStr(cRetObs, nPosDe + 3)
	Local nPosSpace		:= At(" ", cTotParc) - 1

	nPosSpace	:= If(nPosSpace < 1, Len(cTotParc), nPosSpace)
	cTotParc	:= SubStr(cTotParc, 1, nPosSpace)
	nTotParc	:= Val(cTotParc)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Em alguns casos antigos as letras maisculas foram usadas antes³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotParc < 36
		cParc := Lower(cParc)
	EndIf

	If !(Len(cParc) > 1)
		cPesq := "123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
		cParc := AllTrim(StrZero(At(cParc, cPesq), 2))
		cRetObs := SubStr(cRetObs, 1, nPosParc - 1) + cParc + " DE " + StrZero(nTotParc, 2)
		cRetObs := StrTran(cRetObs, ":", "")
	EndIf

Return cRetObs

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MSREAFXET ºMotta  ³Caberj              º Data ³  julho/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Monta mensagem de mudança de faixa etária                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MSREAFXET

	Local cMsFxEtr := " "    
	
	cSQLFXE := " SELECT BM1A.BM1_TIPREG TIPREG "
    cSQLFXE += "         FROM   " + RetSqlName("BM1") +  " BM1A , " + RetSqlName("BM1") +  " BM1B "
    cSQLFXE += "        WHERE  BM1A.BM1_FILIAL = '" + XfILIAL("BM1") + "' "
    cSQLFXE += "        AND    BM1A.BM1_CODINT = '" + BA3->BA3_CODINT + "' "
    cSQLFXE += "        AND    BM1A.BM1_CODEMP = '" + BA3->BA3_CODEMP + "' "
    cSQLFXE += "        AND    BM1A.BM1_MATRIC = '" + BA3->BA3_MATRIC + "' "
    cSQLFXE += "        AND    BM1A.BM1_CODTIP = '101'   "
    cSQLFXE += "        AND    BM1A.BM1_ANO    = " + SE1->E1_ANOBASE + " "
    cSQLFXE += "        AND    BM1A.BM1_MES    = " + SE1->E1_MESBASE + " "
    cSQLFXE += "        AND    BM1B.BM1_FILIAL = BM1A.BM1_FILIAL "
    cSQLFXE += "        AND    BM1B.BM1_CODINT = BM1A.BM1_CODINT "
    cSQLFXE += "        AND    BM1B.BM1_CODEMP = BM1A.BM1_CODEMP "
    cSQLFXE += "        AND    BM1B.BM1_MATRIC = BM1A.BM1_MATRIC "
    cSQLFXE += "        AND    BM1B.BM1_TIPREG = BM1A.BM1_TIPREG "
    cSQLFXE += "        AND    BM1B.BM1_CODTIP = BM1A.BM1_CODTIP "
    cSQLFXE += "        AND    BM1B.BM1_ANO    = DECODE(BM1A.BM1_MES,'01',LPAD(BM1A.BM1_ANO-1,4,'0'),BM1A.BM1_ANO) "
    cSQLFXE += "        AND    BM1B.BM1_MES    = DECODE(BM1A.BM1_MES,'01','12',LPAD(BM1A.BM1_MES-1,2,'0'))  "
    cSQLFXE += "        AND    (BM1A.BM1_CODFAI > BM1B.BM1_CODFAI)    "
    cSQLFXE += "        AND    BM1A.D_E_L_E_T_ = ' '    "
    cSQLFXE += "        AND    BM1B.D_E_L_E_T_ = ' '    "
		
	PLSQuery(cSQLFXE,"TRBFXE")
		
	If !Empty(TRBFXE->TIPREG)	
		cMsFxEtr := "EM DECORRENCIA DE MUDANCA DE FAIXA ETARIA(" + AllTrim(TRBFXE->TIPREG) + ") SEU PLANO ESTA SEndO REAJUSTADO. LEI 9656/98" 
	EndIf
		
	TRBFXE->(DbCloseArea())

Return cMsFxEtr         

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IR2009    ºMotta  ³Caberj              º Data ³  11/01/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rETORNA A LINHA COM TOTAL DE IR 2007                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static  Function IR2009( a_Observacao )


Local cLinIR := " "
Local cSqlIR := " "  
Local a_ObsL := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0¿
//³Supõe que a BA3 já esteja ponteirada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0Ù

cSqlIR := "SELECT CODINT,CODEMP,MATRIC,TIPREG,BA1_NOMUSR,  sum(VALOR) VALOR "
cSqlIR += " FROM   ir_benef_separ_fat  , " + RetSqlName( "BA1" ) + " "
cSqlIR += " WHERE  CODINT = '" + BA3->BA3_CODINT + "' "  
cSqlIR += " AND    CODEMP = '" + BA3->BA3_CODEMP + "' "  
cSqlIR += " AND    MATRIC = '" + BA3->BA3_MATRIC + "' " 
cSqlIR += " AND    ANOBASEIR = '2013' "

cSqlIR += " AND D_E_L_E_T_ = ' ' "
cSqlIR += " AND BA1_FILIAL = ' ' "
cSqlIR += " AND BA1_CODINT = CODINT "
cSqlIR += " AND BA1_CODEMP = CODEMP "            
cSqlIR += " AND BA1_MATRIC = MATRIC "
cSqlIR += " AND BA1_TIPREG = TIPREG "

cSqlIR += " GROUP BY CODINT,CODEMP,MATRIC,TIPREG ,BA1_NOMUSR "

cSqlIR += " ORDER BY 4 "
	
PLSQuery(cSqlIR,"TIR")   

cLinIR := ""   

While !TIR->(EOF())      
If TIR->(VALOR) > 0 
		cLinIR += SUBSTR(TIR->BA1_NOMUSR, 1, 19) + " R$" + Transform(TIR->VALOR,"@E 99,999.99") + "; "
	
EndIf  	
	TIR->( dbSkip() )		   
	
EndDo		
If !Empty( cLinIR )
    
    If Val_cpf (BA3->BA3_CODINT+ BA3->BA3_CODEMP+ BA3->BA3_MATRIC )
    
        cLinIR := "IR CABERJ 2013= " + SubStr(cLinIR, 1, Len(cLinIR)-2 )        	
         
    Else
    	
	    cLinIR := "Prezado Associado, identIficamos duplicidade no cadastro de seu CPF em nosso sistema, impedindo a geração do Informe para fins de declaração do IR."
	    cLinIR += "Entre urgente em contato com nossa central de AtEndimento até e regularize seu cadastro. Tel 3233-8888"
    
    EndIf

	a_Observacao := justIficatxt(cLinIR, 100 ) 
		
	// 16 + 19 + 3 + 9 + 2 = 49 
    // 33               
EndIf  						

//Alert(cLinIR) 

TIR->(DbCloseArea())

Return cLinIR              

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³valcpf    ºaltamiro³Caberj             º Data ³  21/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ VerIfica se a duplicidade de CPF para matricula passada    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function Val_cpf( cFamilia )  

Local l_Ret := .F.   

 cQuery := "SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC MATRICULA1, B1.BA1_CPFUSR CPF , B1.BA1_DATNAS   " + CRLF 
 cQuery += "  FROM  BA1010 B11 ,  BA1010 B1 "                                                                       + CRLF  
 cQuery += " WHERE B11.BA1_FILIAL = ' ' "                                                                           + CRLF 
 cQuery += "   AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' ' "                              + CRLF  
 cQuery += "   AND ((IDADE_S(TRIM(B11.BA1_DATNAS),'20131231') >= 18 ) OR (IDADE_S(TRIM(B11.BA1_DATNAS),'20131231') < 18 AND B11.BA1_TIPUSU = 'T'))   " + CRLF
 cQuery += "   AND ((IDADE_S(TRIM(B1.BA1_DATNAS),'20131231')  >= 18 ) OR (IDADE_S(TRIM(B1.BA1_DATNAS),'20131231')  < 18 AND B1.BA1_TIPUSU  = 'T'))   " + CRLF
 cQuery += "   AND B11.BA1_MATVID <> B1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR "                             + CRLF  
 
 cQuery += "   AND (B1.BA1_CPFUSR <> ' ' " + CRLF
 cQuery += "    OR (IDADE_S(TRIM(B1.BA1_DATNAS),'20131231')  >= 18  AND B1.BA1_CPFUSR = ' ' ) " + CRLF
 cQuery += "    oR (IDADE_S(TRIM(B1.BA1_DATNAS),'20131231')  < 18 AND B1.BA1_TIPUSU  = 'T') " + CRLF
 cQuery += "        AND  B1.BA1_CPFUSR = ' 'AND (B1.BA1_NOMPRE = ' ' and  B1.BA1_CPFPRE =  ' ')) " + CRLF  
 
 cQuery += "   AND (B1.BA1_DATBLO = ' ' OR  B1.BA1_DATBLO > '20121231') AND (B11.BA1_DATBLO = ' ' OR  B11.BA1_DATBLO > '20121231')  "                     + CRLF
 cQuery += "   AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_TIPREG <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_TIPREG  " + CRLF  
 cQuery += "   AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  =   '" + cFamilia + "'"                                                                + CRLF 
 cQuery += "   AND B11.BA1_CODEMP NOT IN ('0004','0006','0010','0009')  AND B1.BA1_CODEMP NOT IN ('0004','0006','0010','0009')  ORDER BY  2,1"            + CRLF
 
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
EndIf

TcQuery cQuery Alias "TMP" New

TMP->( dbGoTop() )

If TMP->( EOF() )
     
	l_Ret := .T.

EndIf              

TMP->( dbCloseArea() )         

Return l_Ret

*****************************************************************************************************************************************************

**'Marcela Coimbra 12/06/12 - Termo de quitação de débito'**
Static Function VerAdp( c_Cliente )

Local l_Ret := .F.

c_Qry:= "SELECT E1_NUM "
c_Qry+= " FROM " + RETSQLNAME("SE1") + " "
c_Qry+= " WHERE E1_FILIAL = '" + xFilial("SE1") + "' "
c_Qry+= " AND E1_cliente = '" + c_Cliente + "' "
c_Qry+= " AND E1_vencrea >= '20130101' "
c_Qry+= " AND E1_vencrea <= '20131231' "
c_Qry+= " AND E1_SALDO > 0 "
c_Qry+= " AND D_E_L_E_T_ <> '*' "

PLSQuery(c_Qry, "QRYAD")   

If QRYAD->( eof() )
     
	l_Ret := .T.		

EndIf 
QRYAD->( dbCloseArea() )

Return l_Ret

      
/// Reajsute 2014
Static Function Perc2014(cAnoMes, cMatric )

	Local a_Area := GetArea('BA3')  
	Local c_Ret  := ""
	
	dbSelectArea("BA3")
	dbSetOrder(1) 
	If dbSeek(xFilial("BA3") + cMatric)  
	
		Do Case          
		
			Case BA3->BA3_INDREA == "000021" 
				
				c_Ret := "28,47%"	
				
			Case BA3->BA3_INDREA == "000022"
				
				c_Ret := " 9,60%"	
	
			Case BA3->BA3_INDREA == "000023"
				
				c_Ret := "12,66%"	
			
		EndCase
	
	EndIf
	
	RestArea(a_Area)

Return c_Ret

**'Funcção criada para criar tabela temporária para otimizar processo de varredura de custo'**
Static Function pCriaTmpCus(cAnoCust, cMesCust, cAnoTit, cMesTit)

	Local l_Ret := .T.      
	
	c_Qry := "DROP TABLE TMP_EXTRATO"  
	
	If TcSqlExec(c_Qry) < 0  
	
	  //	l_Ret := .F.
	
	EndIf	 

	
   	c_Qry := " CREATE TABLE TMP_EXTRATO AS SELECT BD6_NOMUSR, BD6_NOMRDA, BD6_DATPRO, BD6_CODPRO, BD6_DESPRO, BD6_VLRTPF, " 
	c_Qry += "        BD6_IDUSR,  BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_VLRPAG, " 
	c_Qry += "        BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_SEQUEN " 

	c_Qry += "       FROM "
	c_Qry += "      (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "
	c_Qry += "              BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
	c_Qry += "              BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, "
	c_Qry += "              BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,        "
	c_Qry += "              COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE"
	c_Qry += "      FROM BD7010 BD7     "
	c_Qry += "      WHERE BD7.BD7_FILIAL=' '   "
	c_Qry += "      AND BD7.BD7_CODOPE = '0001'   "
	c_Qry += "      AND BD7.BD7_SITUAC = '1'      "
	c_Qry += "      AND BD7.BD7_FASE = '4'  "
	c_Qry += "      AND BD7.BD7_BLOPAG <> '1'         "
	c_Qry += "      AND substr(BD7.BD7_NUMLOT, 1, 6) = '" + cAnoCust + cMesCust + "'  "
	c_Qry += "      AND BD7_CODEMP in ( '0001', '0002', '0005') "
	c_Qry += "      
	c_Qry += "      AND BD7.D_E_L_E_T_ = ' '     "
	c_Qry += "      GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO,"
	c_Qry += "               SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),   "
	c_Qry += "               BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, "
	c_Qry += "      BD6010 BD6F  "

	c_Qry += "    WHERE       "
	c_Qry += "      BD6F.BD6_FILIAL=' ' "
	c_Qry += "      AND substr(BD7F.BD7_NUMLOT, 1, 6) = '" + cAnoCust + cMesCust + "' "
	c_Qry += "      AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL  "
	c_Qry += "      AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE  "
	c_Qry += "      AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP  "
	c_Qry += "      AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG  "
	c_Qry += "      AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO  "
	c_Qry += "      AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV  "
	c_Qry += "      AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN  "
	c_Qry += "      AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO  "
	c_Qry += "      and BD6_NUMFAT = ' '    "
	c_Qry += "      and  BD7F.VLRPAG <> 0   "       
	c_Qry += "      and  BD6F.BD6_VLRTPF = 0   "       
	
	c_Qry += "      and  not exists (select codpeg from log_extrato_010 where codldp = BD6F.BD6_CODLDP AND CODPEG = BD6F.BD6_CODPEG AND NUMERO = BD6F.BD6_NUMERO AND SEQUEN = BD6F.BD6_SEQUEN AND ANOREC||MESREC <> '" + cAnoTit + cmESTit + "' ) "


	c_Qry += "      AND BD6F.D_E_L_E_T_ = ' ' "

	c_Qry += "      ORDER BY 1, 2             "        
	
	MemoWrit("C:\temp\custo_ee.TXT", c_Qry)
	
	If TcSqlExec(c_Qry) < 0  
	
		l_Ret := .F.
	
	EndIf	      
	
cRatCapta := "'80020020', '86000020', '86000748', '80010342', '10102019', '86000829'"	//Rateio CPPS - Informado por Paulo Motta
cRatCapta += "'82000271', '80020020', '86000020', '86000748', '80010342', '10102019', '86000829'"	//Rateio CPPS - Informado por Paulo Motta
/*	
c_Qry := "DELETE TMP_EXTRATO"
c_Qry += " WHERE BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_SEQUEN IN (SELECT CODLDP||CODPEG||NUMERO||SEQUEN FROM log_extrato_010 WHERE (anorec <> '" + cAnoTit + "' AND MESrec <> '" + cMesTit + "'))"

MemoWrit("C:\temp\custo_DEL.TXT", c_Qry)
	

If TcSqlExec(c_Qry) < 0  
	
ALERT("eRRO1")
	
EndIf	 
*/     

c_Qry := "DELETE TMP_EXTRATO "
c_Qry += " WHERE exists ( select br8_codpsa from br8010 where br8_codpsa = bd6_codpro and BR8_YCAPIT = '1' )"   
c_Qry += "       or BD6_CODPRO = '80170315'"   

MemoWrit("C:\temp\custo_DEL.TXT", c_Qry)
	

If TcSqlExec(c_Qry) < 0  
	
ALERT("eRRO2")
	
EndIf	      



         
Return l_Ret
