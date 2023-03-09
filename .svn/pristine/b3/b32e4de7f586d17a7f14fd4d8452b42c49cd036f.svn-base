#Include "PLSR240.CH"
#Include "PROTHEUS.CH"
#Include "PLSMGER.CH"
#Include "rwmake.ch"
#Include "Topconn.ch"
#include "Msole.CH"

#DEFINE c_ent CHR(13) + CHR(10)

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
User Function BOL_ITAU(nRegSE1)
	
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
	Private cPerg		:= "BOLITAU"
	Private cRel		:= "BOL_ITAU"//"BOLITAU"
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
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama Pergunte Invariavelmente                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1(cPerg)
	
	If nRegSE1 == 0
		Pergunte(cPerg,.T.)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Opcao de impressao por Faturas.                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR29 == 2 // Fatura
			If MV_PAR17 == 2  // 175 - Reimpressão
				// Boletos tipo fatura são emitidos por outro programa.
				U_CABBOLFT()
				Return
			Else
				Aviso( "Tipo de Impresso Incorreto!", "Boleto Tipo Fatura apenas pode ser emitido para Tipo de Impresso = 175!", {"Ok"} )
				Return
			EndIf
		EndIf
		
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
		nTipCob		:= IIf(FunName() == "PLSA730",2,mv_par17)
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
	//Local \		:= ""
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
	Private	cDirExp		:= GETNEWPAR("MV_YBOLGR","\Exporta\ANLGRAF\")
	
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
	
	Private a5_40ca4	:= {}
	Private a5_102ca3	:= {}
	Private a5_102mca32	:= {}
	
	Private aMatUti		:= {}
	Private cArray		:= ""
	Private _aErrAnlt	:= {}
	Private cQtdEx      := '000000'
	Private c_XTitulo := ""
	
	/*
	Private nForc 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Private nCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Private nPCont1 := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Private nPCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	*/
	
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
	
	If nTipCob <> 1
		
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
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta query...                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nForC := 1 to 2
		
		If nForC == 1
			cSQL := 	"SELECT COUNT(SE1.R_E_C_N_O_) AS TOTSE1"
		Else
			cSQL := 	"SELECT SE1.*, E1_SALDO SALDO, A1_CEP "
			//		cSQL := 	"SELECT SE1.*, DECODE( E1_CODEMP, '0024', (SELECT SALDO FROM tmpsalse1 WHERE tmpsalse1.E1_NUM = SE1.E1_NUM and rownum = 1), E1_SALDO) SALDO, A1_CEP "
		EndIf
		
		cSQL += 	" FROM "+cSE1Name+" SE1, "+cSA1Name+" SA1 "
		cSQL += 	" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
		cSQL += 	" E1_CLIENTE||E1_LOJA >= '"+cCliDe+cLojDe+"' AND "
		cSQL += 	" E1_CLIENTE||E1_LOJA <= '"+cCliAte+cLojAte+"' AND "
		cSQL += 	" A1_FILIAL = '"+xFilial("SA1")+"' AND "
		cSQL += 	" E1_CLIENTE = A1_COD AND "
		cSQL += 	" E1_LOJA = A1_LOJA AND "
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
		//Incluido por Rafael Fernandes - 15/10/2013
		
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nova regra: caso seja analitico, permitir impressao mesmo com saldo 0 e  ³
		//³ titulos nao transferidos (carteira). Data: 8/11/07.                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipCob <> 3
			
			cSQL += 	" E1_PORTADO = '341' AND "
			
			cSQL += 	" ( E1_SITUACA <> '0' OR E1_TIPO = 'RA' )AND "
			//cSQL += 	" E1_PLNUCOB in( '000100011792', '000100011794', '000100011795' ) AND "
			cSQL += 	" E1_SALDO > 0 AND "
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Nova regra: detectada inconsistencia na consolidacao (consolidado, re-   ³
			//³ valorizado e nao re-consolidado). Nestes casos, os extratos estao        ³
			//³ dIferentes do valor cobrado. Nao imprimir extrato de utilizacao.         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cSQL += " E1_NUM NOT IN ('006216','006250','006256','006261','006262','006450','006436') AND "
		EndIf
		
		//VerIficado que usuarios do financeiro estavam imprimindo titulos
		//migrados, e esta impressao nao eh suportada. Inserida validacao
		//para negar tais situacoes (fixo prefixo PLS).
		//	cSQL += 	" E1_ORIGEM = 'PLSA510' AND "
		
		If nTipCob == 1 //CNAB 112
			
			cSQL += 	" E1_SALDO = E1_VALOR AND " // Motta Julho09 evitar erro dIferença caso o título seja movimentado
			cSQL += 	" E1_FORMREC = '"+GetNewPar("MV_YRCCNAB","04")+"' AND " //Inserido para evitar re-impressao em tipo dIferente...
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Evitar Reimpressao de titulos - 112. Inserir regra neste ponto.			 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//If RegraFinanceira - reemissao
			
			
			//EndIf
		Else
			If nTipCob == 3 //Somente Analitico.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Regras repassadas para emissao dos analiticos complementares...			 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//	    cSQL += 	" ( E1_FORMREC IN ('01','02','06','08', '04')) AND "
				cSQL += 	" ( E1_FORMREC IN ('01','02','06','08') OR (E1_FORMREC = '04' AND E1_YEXANLT = '1' ) ) AND "
				
			EndIf
		EndIf
		
		If ! Empty(aReturn[7])
			cSQL += PLSParSQL(aReturn[7]) + " AND "
		EndIf
		
		//	cSQL += 	" E1_XSERNF = 'FIL' AND "  + CRLF
		cSQL += "SE1.D_E_L_E_T_ = ' ' AND "
		cSQL += "SA1.D_E_L_E_T_ = ' ' "
		
		If nForC = 1
			
			//-------------------------------------------------------------------
			//Angelo Henrique - Data: 23/01/2020
			//-------------------------------------------------------------------
			//PLSQuery(cSQL,"R240Imp")
			//-------------------------------------------------------------------
			
			DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSQL),"R240Imp",.T.,.T.)
			
			_nTotSE1 := R240Imp->(TOTSE1)
			
			R240Imp->(DbCloseArea())
			
		Else
			If nTipCob == 3
				cSQL += "ORDER BY E1_FORMREC, A1_CEP "
			Else
				cSQL += "ORDER BY " + SE1->(IndexKey())
			EndIf
		EndIf
		
	Next
	
	MemoWrit("C:\temp\BORD.TXT", cSQL)
	
	//-------------------------------------------------------------------
	//Angelo Henrique - Data: 23/01/2020
	//-------------------------------------------------------------------
	//PLSQuery(cSQL,"R240Imp")
	//-------------------------------------------------------------------
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSQL),"R240Imp",.T.,.T.)
	
	If R240Imp->(Eof())
		R240Imp->(DbCloseArea())
		Help("",1,"RECNO")
		Return
	EndIf
	
	If nTipCob == 2
		oPrint:SetPortrait() // ou SetLandscape()
		oPrint:StartPage()   // Inicia uma nova página
	EndIf
	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe mensagem...                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt(PLSTR0001)//#include "PLSMGER.CH"
	*/
	
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
	
	While ! R240Imp->(Eof())
		
		_nRegPro++
		IncProc("Registro: "+StrZero(_nRegPro,8)+"/"+StrZero(_nTotSE1,8))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nova implementacao: Caso titulo cancelado, e extrato (999) nao considerar³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		lIntegral := ( cEmpAnt == '02' ) .or. ( R240Imp->E1_CODEMP > '0010' )
		
		If nTipCob == 3
			
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
			
		EndIf
		
		
		aCobranca		:= {}
		cPrefixo		:= R240Imp->E1_PREFIXO
		cTitulo			:= R240Imp->E1_NUM
		cParcela		:= R240Imp->E1_PARCELA
		cTipo			:= R240Imp->E1_TIPO
		aDepEndentes	:= {}
		
		BM1->(DbSeek(xFilial("BM1") + cPrefixo + cTitulo + cParcela + cTipo))
		BA3->(DbSeek(xFilial("BA3") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Questionar a impressao caso Tipo de Pagto <> "05" e tp.cobr = 175...	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Reativado em 31/1/08
		/*
		If R240Imp->E1_FORMREC <> "05" .And. nTipCob == 2
			If !MsgBox("Título: "+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+" possui forma de cobrança "+R240Imp->E1_FORMREC+" O modelo de impressão selecionado é o 175. Possível duplicidade de cobrança. Deseja continuar?", "CONFIRMA O PROCESSAMENTO?","YESNO")
				R240Imp->(DbSkip())
				Loop
			EndIf
		EndIf
		*/
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nova implementacao: evitar que o sistema imprima titulos com numero do	 ³
		//³ banco igual a 15 sejam impressos (regra para 175).                    	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipCob == 2 .And. Len(AllTrim(R240Imp->E1_NUMBCO)) = 15
			If !lMosNumBco
				MsgAlert("Atencao! Número do banco inválido no título em questão! VerIfique titulo de SISDEB ! Esta mensagem será demonstrada apenas 1 vez!")
				lMosNumBco := .T.
			EndIf
			R240Imp->(DbSkip())
			Loop
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao imprimir caso existam mais de 2 debitos pEndentes para 112...		 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nContPar := 0
		If nTipCob == 1
			
			SE1->(DbSetOrder(8)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS+DTOS(E1_VENCREA)
			SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_CLIENTE+E1_LOJA)+"A"))
			
			nContPar := 0
			While ! SE1->(Eof()) .And. SE1->(E1_CLIENTE+E1_LOJA)+"A" == R240Imp->(E1_CLIENTE+E1_LOJA)+"A"
				If SE1->E1_VENCREA < dDataBase .And. SE1->E1_SALDO > 0
					nContPar++
				EndIf
				SE1->(DbSkip())
			Enddo
			SE1->(DbSetOrder(1))
			
			If nContPar > 2
				R240Imp->(DbSkip())
				Loop
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Em caso de pessoa juridica, nao emite os depEndentes.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BA3->BA3_TIPOUS == '1' //Pessoa Fisica
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Busca de depEndentes para impressao dos dados.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("BA1")
			If DbSeek(xFilial("BA1") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC)
				
				While 	(BA1->(!EOF()) .And.;
						xFilial("BA1")  == BA1->BA1_FILIAL .And.;
						BA1->BA1_CODINT == BM1->BM1_CODINT .And.;
						BA1->BA1_CODEMP == BM1->BM1_CODEMP .And.;
						BA1->BA1_MATRIC == BM1->BM1_MATRIC)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³IdentIfica os usuarios que fazem parte do titulo posicionado. ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If 	(SubStr(DtoS(BA1->BA1_DATINC),1,6) <= R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE) .and. ;
							(Empty(BA1->BA1_MOTBLO))
						
						Aadd(aDepEndentes, {BA1->BA1_TIPREG,BA1->BA1_NOMUSR})
					EndIf
					
					BA1->(DbSkip())
				End
			EndIf
		EndIf
		//DbSelectArea("R240Imp")
		
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
		//DbSelectArea("R240Imp")
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
		
		If lFoundSE1 .And. nTipCob == 2
			//If GetNewPar("MV_YFLGBL","N") = "S"
			U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
			//EndIf
			SE1->(RecLock("SE1",.F.))
			SE1->E1_YTPEXP := "D" //IMPRESSO 175 - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"D", "X5_DESCRI")
			SE1->(MsUnlock())
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Caso necessario, grava nro do banco no titulo... ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(R240Imp->(E1_NUMBCO))
			
			If lFoundSE1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³VerIfica se deve observar cadastros de banco, somente se for 175...  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nTipCob == 2
					
					If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+aDadosBanco[5]+"006"))
						
						//Leonardo Portella - 01/04/16 - Início - Em casos de 2ª via esta rotina pode ser concorrente com outras e gerar anomalia de nosso
						//número duplicado por banco. Desloco a busca e atualização na SEE (parâmetros bancários) para dentro do Reclock na tabela visando
						//garantir o controle de transação e consequentemente da numeração.
						
						//cNumAtu := SEE->EE_FAXATU
						
						SEE->(RecLock("SEE",.F.))
						
						cNumAtu := SEE->EE_FAXATU
						
						SEE->EE_FAXATU := soma1(Substr(SEE->EE_FAXATU,1,Len(AllTrim(SEE->EE_FAXATU))))
						
						SEE->(MsUnlock())
						
						SE1->(RecLock("SE1",.F.))
						SE1->E1_NUMBCO 		:= cNumAtu
						SE1->E1_FORMREC 	:= "05"
						SE1->(MsUnlock())
						
						/*
						//INCREMENTA O NOSSO NUMERO
						cNumAtu := soma1(Substr(SEE->EE_FAXATU,1,Len(AllTrim(SEE->EE_FAXATU))))
						
						SEE->(RecLock("SEE",.F.))
						SEE->EE_FAXATU := cNumAtu
						SEE->(MsUnlock())
						*/
						
						//Leonardo Portella - 01/04/16 - Fim
						
					EndIf
					
				EndIf
				
			EndIf
			
		EndIf
		
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
			
			If BM1->BM1_CODTIP $ "127,116,104,117,120,121,122,123,124,125,141,151,152,149,139"
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
			
			//Se for CNAB, sempre enviar nome do usuario...
			If nTipCob == 1
				lNome := .T.
			EndIf
			
			If lImpBM1 .And. Substr(cNumEmp,1,2) == "02" //VerIfica se eh integral, na variavel publica de numero de empresa...
				lIntegral := .T.
				//			lNome := .F.  Altamiro em 17/11/09
			EndIf
			// alterado para conteplar emissao de coparte da integral
			//		If Substr(cNumEmp,1,2) == "02"
			
			l_FamBlo := !EMPTY(ba3->ba3_DATBLO)
			
			
			
			
			
			
			
			If lImpBM1  .and. BM1->BM1_VALOR <> 0
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
						"",;
						BM1->BM1_TIPO})
				Else
					If BA3->BA3_COBNIV = '1' .and. BM1->BM1_VALOR <> 0
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
							"",;
							BM1->BM1_TIPO})
					Else
						_nPosTmp := Ascan(aCobranca,{|x| x[5]==BM1->BM1_CODTIP})
						
						If _nPosTmp == 0 .and. BM1->BM1_VALOR <> 0
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
								"",;
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
				
				//	If R240Imp->E1_MESBASE <> '01'
				
				
				c_AnoMes := R240Imp->E1_ANOBASE + ba3->ba3_mesrea
				
				//	Else
				
				//	c_AnoMes := str(val(R240Imp->E1_ANOBASE)- 1)  + ba3->ba3_mesrea
				
				//EndIf
				
				lMosRea:=.F.
				
				//		    If (R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE $ '201709' .and. c_AnoMes $ '201707||201708||201709' ) //.and. GetNewPar("MV_YMSREA","0") == "1"
				If (R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE == c_AnoMes ) .and. GetNewPar("MV_YMSREA","0") == "1"
					
					cPerRea := Perc2014( c_AnoMes ,BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC), BA3->BA3_INDREA)
					
					lMosRea := .T.//!Empty( cPerRea )
					
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Controle para imprimir msg. reaj. somente quando percentual > 0 e titulo de mensalidade	   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lMosRea .AND. !lIntegral //.and. GetNewPar("MV_YMSREA","0") == "1"
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
					
					//				While ! BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)==BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
					**'Marcela Coimbra - Acerto da rotina'**
					While ! BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)==BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
						
						If !Empty(BA1->BA1_CODPLA) .AND. BA1->BA1_CODPLA <> cCodPla
							
							cPerRea := ""
							
						EndIf
						
						BA1->(DbSkip())
						
					Enddo
					
					If Empty( cPerRea )
						
						cPerRea:= ". Em caso de duvida ligue 3233-8855"
						
					Else
						
						cPerRea := " " + cPerRea
						
					EndIf
					
					//cMsgRea := "Plano " + cNomPRe+ " -  Registro n° " + cNumANS + " - Contrato n° " + cContANS
					//cMsgRea += " - Coletivo por adesão. Percentual de reajuste aplicado" + cPerRea
					cMsgRea := "Percentual de reajuste aplicado" + cPerRea
					cMsgRea += ". O reajuste sera comunicado a ANS."
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
			_cSQLUti := " SELECT NVL(Sum(BD6_VLRTPF),0) AS VLRTOT FROM "+RetSQLName("BD6")+" "
			_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
			_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
			_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
			_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "
			
			**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
			
			_cSQLUti += " AND BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "
			
			**'-Fim Marcela Coimbra - Data: 17/03/09-'**
			
			
			/*
			**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
			
			_cSQLUti += " AND ( BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' "
			_cSQLUti += "       OR 	 BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"') "
			
			//_cSQLUti += " AND BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' " //GEDILSON
			
			**'-Fim Marcela Coimbra - Data: 17/03/09-'**
			*/
			
			//_cSQLUti += " AND BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' " //GEDILSON 24/02/2010
			
			_cSQLUti += " AND BD6_NUMFAT = 'BLQODONT' "
			_cSQLUti += " AND D_E_L_E_T_ = ' ' "
			
			MemoWrit("C:\temp\BORD2.TXT", _cSQLUti)
			
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
					"",;
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
			/*
			
			**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
			
			_cSQLUti += " AND ( ( ( BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' "
			_cSQLUti += "           OR BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' )"
			//		_cSQLUti += " AND ( ( BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' "
			
			**'-Fim Marcela Coimbra - Data: 17/03/09-'**
			*/
			
			//	_cSQLUti += " AND ( ( BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' " //GEDILSON 24/02/2010
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
			
			MemoWrit("C:\Temp\BORD3.TXT", _cSQLUti)
			
			
			PLSQUERY(_cSQLUti,"TRBUTI")
			
			While !TRBUTI->(Eof())
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Para emissao Itau (112), deve-se sempre obter o nome do³
				//³usuario. Na reimpressao, nao eh necessario...          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nPosBD6 := 0
				If nTipCob == 2
					nPosBD6 := Ascan(aCobranca, {|x| x[09] == TRBUTI->BD6_CODOPE+TRBUTI->BD6_CODEMP+;
						TRBUTI->BD6_MATRIC+TRBUTI->BD6_TIPREG+;
						TRBUTI->BD6_DIGITO} )
				EndIf
				
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
				/*
				//Altamiro - Ajuste para nao sair copart para cobrança na integral
				If ( (Substr(cNumEmp,1,2) == "02" ) .and. (BM1->BM1_CODTIP $ "127,116,104,117,120,121,122,123,124,125,141,151,152")) ;
						.AND. BA3->(MsSeek(xFilial("BA3")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC))) .AND. BA3->BA3_COBNIV == "0"
					
					aa:= " "
					
				Else
					// Fim - Altamiro
					*/
					
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
			aSort( aCobranca,,,{|x,y| x[9]+X[10]+x[3]+x[5] < y[9]+Y[10]+y[3]+y[5]} )
			
			//aBfq := RetornaBfq(R240Imp->E1_CODINT, "199")
			If R240Imp->E1_IRRF > 0
				//altamiro  em 11/11/2009 - sujeira no campo despesa retirada a referencia aBfq[2] da possição 11 do vetor
				Aadd(aCobranca,{	"",	"",	"", "",	"199", "IR",	R240Imp->E1_IRRF,	"",	"",	"", "", "2", BA3->BA3_COBNIV})
				//Aadd(aCobranca,{	"",	"",	"", "",	aBfq[1],AllTrim(aBfq[3])+" (-) ", R240Imp->E1_IRRF,	"",	"",	"",	""})
				
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
			//If  cAnotit + cMesTit >= '201903' .and.  cAnotit + cMesTit <= '201803'
			If cAnotit + cMesTit == '202003'
				//   If .f. .and. cAnotit + cMesTit >= '201503' .and.  cAnotit + cMesTit <= '201503'
				//       cText:= u_IR2007()
				c_IR := IR2009(aObservacoes) //  mbc
				/*ALTAMIRO INCLUISAO MENSAGEM DE IR NO BOLETO - 02/2013 */
				//		If !Empty( c_IR )
				
				//		   Aadd(aObservacoes, c_IR )
				
				//		EndIf 
				// ATE AKI 02/2013
				//       Alert(aObservacoes[4])
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
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Somente verIficar codigo de barras, se nao for 175 (modelo <> 1)		 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nTipCob == 2
				
				CB_RN_NN    := 	Ret_cBarra(	Subs(aDadosBanco[1],1,3),;
					aDadosBanco[3],;
					aDadosBanco[4],;
					aDadosBanco[5],;
					Strzero(Val(AllTrim(R240Imp->E1_NUM)),6)+StrZERO(Val(AllTrim(R240Imp->E1_PARCELA)),2),;
					R240Imp->SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,; //1
				R240Imp->E1_PREFIXO,;
					R240Imp->E1_NUM,;
					R240Imp->E1_PARCELA,;
					R240Imp->E1_TIPO,;
					cCart)
				
				///R240Imp->E1_SALDO - R240Imp->E1_IRRF,; //1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Testar o retorno do rdmake de layout do boleto...                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Empty(CB_RN_NN)
					If !MsgYesNo(STR0055) // //"Deseja continuar ?"
						Return NIL
					Else
						R240Imp->(DbSkip())
						Loop
					EndIf
				EndIf
				
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Dados do Titulo³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			**'Marcela Coimbra - Ajuste da montagem do aDadosTit para acertar o valor do boleto'**
			
			**'Marcela Coimbra - Inicio do Bloco Comentado'**
			/*
			aDadosTit   :=  {	AllTrim(R240Imp->E1_NUM)+AllTrim(R240Imp->E1_PARCELA),; 	//Numero do título
			R240Imp->E1_EMISSAO,;             				//Data da emissão do título
			dDataBase,;             				//Data da emissão do boleto
			R240Imp->E1_VENCTO,;             				//Data do vencimento
			R240Imp->E1_VALOR - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
			IIf(nTipCob==1,"",IIf(nTipCob==2,CB_RN_NN[3],"")) }							//Nosso numero (Ver fórmula para calculo)
			*/
			**'Marcela Coimbra - Fim do Bloco Comentado'**
			
			//				R240Imp->E1_SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
			
			aDadosTit   :=  {	AllTrim(R240Imp->E1_NUM)+AllTrim(R240Imp->E1_PARCELA),; 	//Numero do título
			R240Imp->E1_EMISSAO,;             				//Data da emissão do título
			dDataBase,;             				//Data da emissão do boleto
			R240Imp->E1_VENCREA,;             				//Data do vencimento
			R240Imp->SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
			IIf(nTipCob==1,"",IIf(nTipCob==2,CB_RN_NN[3],"" )) }							//Nosso numero (Ver fórmula para calculo)
			
			**'Marcela Coimbra - Ajuste da montagem do aDadosTit para acertar o valor do boleto'**
			
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
			
			If nTipCob == 1
				
				// Preencher SE1->E1_YTPEXP com "B"
				
				ImpCNAB(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,.T.			,;
					aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
					aDatSacado	,aMsgBoleto					,""						,aOpenMonth		,;
					aDepEndentes,aObservacoes				,cCart 					,cPrefixo		,;
					cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC		,lPrima			)
				
				If lPrima
					lPrima := .F.
				EndIf
				
			ElseIf nTipCob == 2
				
				// Preencher SE1->E1_YTPEXP com "D"
				
				ImpGraf(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,oPrint			,;
					aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
					aDatSacado	,aMsgBoleto					,CB_RN_NN				,aOpenMonth		,;
					aDepEndentes,aObservacoes				,cCart 					,cPrefixo		,;
					cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC)
				
			ElseIf nTipCob == 3
				ImpAnlt(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,.T.			,;
					aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
					aDatSacado	,aMsgBoleto					,""						,aOpenMonth		,;
					aDepEndentes,aObservacoes				,cCart 					,cPrefixo		,;
					cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC		,lPrima	)
				
				
			EndIf
			
			R240Imp->(DbSkip())
		End
		
		c_LogGer := ""
		
		//Ú--------------------------------------------------------------------¿
		//| Fecha arquivos...                                                  |
		//À--------------------------------------------------------------------Ù
		R240Imp->(DbCloseArea())
		
		If nTipCob == 1
			
			If Type("nHdl") <> "U"
				
				cString := CNABTRAILLER()
				
				cLin := Space(1)+cEOL
				cCpo := cString
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O TRAILLER! OPERAÇÃO ABORTADA!")
					Return Nil
				EndIf
				
				U_Fecha_TXT()
				
			Else
				MsgAlert("Nenhum registro gerado no arquivo CNAB!","Atenção!")
			EndIf
			
		ElseIf nTipCob == 2
			
			//Ú--------------------------------------------------------------------------¿
			//| Libera impressao                                                         |
			//À--------------------------------------------------------------------------Ù
			oPrint:EndPage()     // Finaliza a página
			//	oPrint:Setup()
			//	oPrint:Print()
			oPrint:Preview()     // Visualiza antes de imprimir
			
		ElseIf nTipCob == 3
			
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
			
		EndIf
		
		If !Empty( c_LogGer )
			
			cNomeArq := cDirExp+"LOG_EXTRATO"+cMesTit+Substr(cAnoTit,3,2)+".TXT"
			
			MemoWrit(cNomeArq,  c_LogGer)
			
		EndIf
		
		If Len(aCritica) > 0
			PLSCRIGEN(aCritica,{ {"Descrição da inconsistência","@C",200},{"Chave do título","@C",100}},"Críticas encontradas na exportação! Arquivo exportação CNAB não será gerado!",.T.)
			//	FErase(GETNEWPAR("MV_YDIBOL","\CNAB\Exporta\")+_cSeqNom+".txt")
			
			Libera_CNAB(_cSeqNom)
			
		Else
			If nTipCob == 1
				MsgAlert("Arquivo gerado com sucesso! VerIfique o resultado.","Atenção!")
			EndIf
		EndIf
		aCritica := {}
		
		//Ú--------------------------------------------------------------------------¿
		//| Fim do Relat¢rio                                                         |
		//À--------------------------------------------------------------------------Ù
		Return
		
		*****************************************************************************************************************************************************
		
		/*/
		ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
		±±³Programa   ³ ImpGraf  ³ Autor ³ Rafael M. Quadrotti   ³ Data ³ 08.10.03 ³±±
		±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
		±±³Descricao  ³ Imprime Boleto modo grafico                                ³±±
		±±ÚÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
		±±³Alteracoes ³ Data     ³Motivo                                           ³±±
		±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
		±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		/*/
		
	Static Function ImpGraf(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
			aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
			aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
			aDepEndentes	,aObservacoes	,cCart			,cPrefixo	,;
			cTitulo			,cGrupoEmp 		,cMatric)
		
		Local oFont8	// --¿
		Local oFont10	// 	 |
		Local oFont11n	// 	 |
		Local oFont13	// 	 |
		Local oFont13n	// 	 |
		Local oFont15n	// 	 Ã- Fontes para impressao do relatorio grafico.
		Local oFont16	// 	 |
		Local oFont16n	// 	 |
		Local oFont21	// --Ù
		Local aCoords1 	:= {2000,1900,2100,2300}
		Local aCoords2 	:= {2270,1900,2340,2300}
		Local oBrush
		// 17 linha de extrato
		Local aLinhas	:= {}
		Local aLin1 	:= { 805, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250 ,1300 ,1350 ,1400 ,1450 ,1500 ,1550 ,1600 }
		Local aLin2		:= { 805, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250 ,1300 ,1350 ,1400 ,1450 ,1500 ,1550 ,1600,;
			1650,1700,1750,1800,1850,1900,1950, 2000, 2050, 2100 ,2150 ,2200 , 2250 , 2300 , 2350 ,2400 ,2450}
		
		Local nI		:= 0	// Contador do laco para impressao de depEndentes.
		Local nMsg      := 0    // Contador para as mensagens
		Local cMoeda	:= "9"  // Moeda do boleto.
		Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = noraml 2 = Grande.
		Local nCob		:= 0	// Contador para for do extrato.
		Local lNovaPg	:= .F.	// Nova pagina. Controle de quebra do extrato.
		Local nLin		:= 1	// Linha atual da impressao
		
		//Parâmetros de TFont.New()
		//1.Nome da Fonte (Windows)
		//3.Tamanho em Pixels
		//5.Bold (T/F)
		oFont8  := TFont():New("Arial",9,8 ,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont10 := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont11 := TFont():New("Courier",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
		
		oFont11n:= TFont():New("Arial",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
		
		oFont13 := TFont():New("Arial",9,13,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont13n:= TFont():New("Arial",9,13,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont15n:= TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont16 := TFont():New("Arial",9,16,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont16n:= TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont21 := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
		
		oBrush := TBrush():New("",4)
		
		oPrint:StartPage()   // Inicia uma nova página
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Analiza se sera necessario usar mais de um pagina... ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aCobranca) <= 17
			aLinhas 	:= aClone(aLin1)
			nTamCorp    := 1
		Else
			aLinhas 	:= aClone(aLin2)
			nTamCorp    := 2
			lNovaPg 	:= .T.
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime o cabecalho do boleto...               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDepEndentes, aOPenMonth, oBrush, nTamCorp)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime detalhes do extratos com dados para cobranca.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotLin := 1600 //Ultima linha do extrato padrao. A partir desta linha sera adicionada + 50 pixeis e a
		//ficha de compensacao sera gerada em uma nova pagina.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime detalhes do extrato...                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nCob := 1 To Len(aCobranca)
			If IIf(nTamCorp == 1, nLin > 17, nLin > 34)
				oPrint:EndPage()			// Finaliza a pagina
				oPrint:StartPage()			// Inicializo nova pagina
				
				nTamCorp := IIf(((Len(aCobranca)-nCob) <= 17), 1, 2)
				aLinhas	 := IIf(nTamCorp == 1, aClone(aLin1), aClone(aLin2) )
				
				R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDepEndentes, aOPenMonth, oBrush)
				
				oPrint:Say (aLinhas[1],0110 ,SubStr(AllTrim(aCobranca[nCob][1]),1,21),oFont8 )
				oPrint:Say (aLinhas[1],0510 ,Substr(AllTrim(aCobranca[nCob][2]),1,30),oFont8 )
				oPrint:Say (aLinhas[1],1060 ,IIf(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
				oPrint:Say (aLinhas[1],1260 ,SubStr(AllTrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,30),oFont8 )
				oPrint:Say (aLinhas[1],1810 ,IIf(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 999,999.99")),oFont8 )
				oPrint:Say (aLinhas[1],2110 ,IIf(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
				
				nLin := 2
			Else
				oPrint:Say (aLinhas[nLin],0110 ,SubStr(AllTrim(aCobranca[nCob][1]),1,21),oFont8 )
				oPrint:Say (aLinhas[nLin],0510 ,Substr(AllTrim(aCobranca[nCob][2]),1,30),oFont8 )
				oPrint:Say (aLinhas[nLin],1060 ,IIf(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
				oPrint:Say (aLinhas[nLin],1260 ,SubStr(AllTrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,30),oFont8 )
				oPrint:Say (aLinhas[nLin],1830 ,IIf(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 999,999.99")),oFont8 )
				oPrint:Say (aLinhas[nLin],2110 ,IIf(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
				
				nLin ++
			EndIf
		Next
		
		If SE1->E1_PREFIXO = 'FIN'
			dbSelectArea("SEV")
			dbSetOrder(1)
			If dbSeek(xFilial("SEV") + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO)
				
				While !SEV->( EOF() ) .and. SEV->( EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO) == xFilial("SE1") + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
					
					c_DescEv := ALLTRIM( POSICIONE("SED", 1, XFILIAL("SED") + SEV->EV_NATUREZ, "ED_DESCRIC") )
					
					oPrint:Say (aLinhas[nLin],0110 , c_DescEv + space(50 - LEN(c_DescEv))  ,oFont8 )
					oPrint:Say (aLinhas[nLin],0450 , "R$ " + Transform(SEV->EV_VALOR,"@E 999,999,999.99") ,oFont8 )
					
					nLin ++
					
					SEV->( dbSkip() )
					
				EndDo
				
			EndIf
			
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Caso tenha ocorrido a quebra de pagina emite a³
		//³ficha de compensacao em uma nova folha.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lNovaPg
			oPrint:EndPage()			// Finaliza a pagina
			oPrint:StartPage()			// Inicializo nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime novo cabecalho de pagina³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDepEndentes, aOPenMonth, oBrush)
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Impressao da observacao.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nMsg:=1650
		oPrint:Say  (1625,105,STR0014                ,oFont8 ) //"Observação"
		For nI := 1 To len(aObservacoes)
			oPrint:Say  (nMsg,105,aObservacoes[nI]        ,oFont11 )
			
			nMsg+=31
			If nI > 5
				Exit
			EndIf
		Next nI
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Emissao da ficha de compensacao.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Demonstrar vencimento e valor do titulo.
		//oPrint:FillRect(aCoords1,oBrush)
		//oPrint:FillRect(aCoords2,oBrush)
		
		oPrint:Line (2000,100,2000,2300)
		oPrint:Line (2000,550,1920,550 )
		oPrint:Line (2000,770,1920,770 )
		oPrint:Say  (1934,100,Substr(aDadosBanco[2],1,14),oFont13n )
		oPrint:Say  (1912,567,aDadosBanco[1]+"-"+Modulo11(aDadosBanco[1]),oFont21 )
		oPrint:Say  (1934,790,CB_RN_NN[2],oFont13n)
		
		oPrint:Line (2100,100,2100,2300 )
		oPrint:Line (2200,100,2200,2300 )
		oPrint:Line (2270,100,2270,2300 )
		oPrint:Line (2340,100,2340,2300 )
		
		oPrint:Line (2200,500,2340,500)
		oPrint:Line (2270,750,2340,750)
		oPrint:Line (2200,1000,2340,1000)
		oPrint:Line (2200,1350,2270,1350)
		oPrint:Line (2200,1550,2340,1550)
		
		oPrint:Say  (2000,100 ,STR0015                             ,oFont8) //"Local de Pagamento"
		oPrint:Say  (2040,100 ,"Até o vencimento, preferencialmente no Itaú. Após o vencimento, somente no Itaú"        ,oFont10) //"Qualquer banco até a data do vencimento"
		
		oPrint:Say  (2000,1910,STR0008                                     ,oFont8) //"Vencimento"
		oPrint:Say  (2040,2010,Substr(DTOS(aDadosTit[4]),7,2)+"/"+Substr(DTOS(aDadosTit[4]),5,2)+"/"+Substr(DTOS(aDadosTit[4]),1,4)  ,oFont10)
		
		oPrint:Say  (2100,100 ,STR0017                                        ,oFont8) //"Cedente"
		oPrint:Say  (2140,100 ,aDadosEmp[1]                                     ,oFont10)
		
		oPrint:Say  (2100,1910,STR0012                         ,oFont8) //"Agência/Código Cedente"
		oPrint:Say  (2140,2010,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
		
		oPrint:Say  (2200,100 ,STR0018                              ,oFont8) //"Data do Documento"
		oPrint:Say  (2230,100 ,DTOC(aDadosTit[3])                               ,oFont10)
		
		oPrint:Say  (2200,505 ,STR0019                                  ,oFont8) //"Nro.Documento"
		oPrint:Say  (2230,605 ,aDadosTit[1]                                     ,oFont10)
		
		oPrint:Say  (2200,1005,STR0020                                   ,oFont8) //"Espécie Doc."
		
		oPrint:Say  (2200,1355,STR0021                                         ,oFont8) //"Aceite"
		oPrint:Say  (2230,1455,"N"                                             ,oFont10)
		
		oPrint:Say  (2200,1555,STR0022                          ,oFont8) //"Data do Processamento"
		oPrint:Say  (2230,1655,DTOC(aDadosTit[2])                               ,oFont10)
		
		oPrint:Say  (2200,1910,STR0013                                   ,oFont8) //"Nosso Número"
		oPrint:Say  (2230,2010,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6])                ,oFont10)
		
		oPrint:Say  (2270,100 ,STR0023                                   ,oFont8) //"Uso do Banco"
		
		oPrint:Say  (2270,505 ,STR0024                                       ,oFont8) //"Carteira"
		oPrint:Say  (2300,555 ,cCart                                   ,oFont10)
		
		oPrint:Say  (2270,755 ,STR0025                                        ,oFont8) //"Espécie"
		oPrint:Say  (2300,805 ,STR0026                                             ,oFont10) //"R$"
		
		oPrint:Say  (2270,1005,STR0027                                     ,oFont8) //"Quantidade"
		oPrint:Say  (2270,1555,STR0028                                          ,oFont8) //"Valor"
		
		oPrint:Say  (2270,1910,STR0029                          ,oFont8) //"(=)Valor do Documento"
		oPrint:Say  (2300,2010,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
		
		oPrint:Say  (2340,100 ,"Instruções (Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8) //"Instruções/Texto de responsabilidade do cedente"
		
		nMsg:=2390
		For nI := 1 To len(aMsgBoleto)
			oPrint:Say  (nMsg,120,aMsgBoleto[nI]                ,oFont10 )
			nMsg+=50
			If nI > 6
				Exit
			EndIf
		Next nI
		
		oPrint:Say  (2340,1910,STR0031                         ,oFont8) //"(-)Desconto/Abatimento"
		oPrint:Say  (2370,2010,AllTrim(Transform(nAbatim,"@ZE 999,999,999.99")),oFont10)
		
		oPrint:Say  (2410,1910,STR0032                             ,oFont8) //"(-)Outras Deduções"
		oPrint:Say  (2480,1910,STR0033                                  ,oFont8) //"(+)Mora/Multa"
		oPrint:Say  (2550,1910,STR0034                           ,oFont8) //"(+)Outros Acréscimos"
		oPrint:Say  (2570,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10)
		// oPrint:Say  (2240,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10) // Marcela coimbra - Alterada Posição - Chamado GLPI 2813
		oPrint:Say  (2620,1910,STR0035                               ,oFont8) //"(-)Valor Cobrado"
		
		oPrint:Say  (2690,100 ,STR0036                                         ,oFont8) //"Sacado"
		oPrint:Say  (2720,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
		oPrint:Say  (2773,400 ,aDatSacado[3]                                    ,oFont10)
		oPrint:Say  (2826,400 ,aDatSacado[4]+" - "+aDatSacado[5]+" - "+aDatSacado[6] ,oFont10)
		oPrint:Say  (2879,400 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3)  ,oFont10)
		
		oPrint:Say  (2895,100 ,STR0037                               ,oFont8) //"Sacador/Avalista"
		oPrint:Say  (2935,1500,STR0038                        ,oFont8) //"Autenticação Mecânica -"
		oPrint:Say  (2935,1850,STR0039                           ,oFont10) //"Ficha de Compensação"
		
		oPrint:Line (2000,1900,2690,1900 )
		oPrint:Line (2410,1900,2410,2300 )
		oPrint:Line (2480,1900,2480,2300 )
		oPrint:Line (2550,1900,2550,2300 )
		oPrint:Line (2620,1900,2620,2300 )
		oPrint:Line (2690,100 ,2690,2300 )
		oPrint:Line (2930,100,2930,2300  )
		
		
		//MSBAR("INT25",36,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
		//MSBAR3("INT25",21.5,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
		cNmPrnTmp := UPPER(PrnGetName())
		cNomePrint := ""
		nCtNome := Len(AllTrim(cNmPrnTmp))
		
		While .T.
			If Substr(cNmPrnTmp,nCtNome,1) $ "\:"
				cNomePrint := AllTrim(Substr(cNmPrnTmp,nCtNome+1,Len(AllTrim(cNmPrnTmp))))
				nCtNome := 0
			EndIf
			nCtNome--
			
			If nCtNome <= 0
				Exit
			EndIf
		Enddo
		
		//junho 2009 tratar "lixo" no nome da printer - Motta
		nCtNome := Len(AllTrim(cNmPrnTmp))
		cNmPrnTmp := cNomePrint
		
		While .T.
			If Substr(cNmPrnTmp,nCtNome,1) $ "["
				cNomePrint := AllTrim(Substr(cNmPrnTmp,1,nCtNome-1))
				nCtNome := 0
			EndIf
			nCtNome--
			
			If nCtNome <= 0
				Exit
			EndIf
		Enddo
		
		Do case
		Case cNomePrint $ Upper(AllTrim(GetNewPar("MV_YPRINTP","4050_OPERACAO1"))) .or.;
				cNomePrint $ Upper(AllTrim(GetNewPar("MV_YPRINT2"," "))) .OR.  ;
				cNomePrint $ Upper(AllTrim(GetNewPar("MV_YPRINT3"," ")))
			MSBAR3("INT25",25,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //4050
		OtherWise
			MSBAR3("INT25",12.6,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //SEATE2 - em testes (Jean - 05/12/07)
		EndCase
		
		oPrint:EndPage() // Finaliza a página
		
		Return Nil
		
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
		Local cSE1   	:= ""
		
		Local aAreaSE1 := SE1->(getArea())
		
		cSE1 := RetSQLName("SE1")	//retorna o alias no TOP.
		
		//SE1->(DbSetOrder(1))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta query...                                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSQL := "SELECT * FROM "+cSE1+" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
		cSQL += "			E1_CLIENTE = '"+cCliente+"' AND "
		cSQL += "			E1_LOJA    = '"+cLoja+"' AND "
		cSQL += "			E1_SALDO > 0 AND "
		cSQL += "			E1_PREFIXO IN ('ANT','PLS') AND "
		cSQL += "			E1_TIPO <> 'PR ' AND "
		cSQL += "			E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND "
		cSQL += "         E1_ANOBASE||E1_MESBASE < '" + cAnoBase+cMesBase + "' AND "// aberto
		cSQL += cSE1+".D_E_L_E_T_ = ' ' "
		cSQL += "ORDER BY 1,2,3,4,5,6" //+ SE1->(IndexKey())  //aberto
		
		//PLSQuery(cSQL,STR0040) //"Meses"
		PLSQuery(cSQL,'Meses') //"Meses"
		
		If Meses->(Eof())
			Meses->(DbCloseArea())
		Else
			While 	Meses->(!Eof()) .And.;
					Meses->E1_CLIENTE == cCliente .And.;
					Meses->E1_LOJA ==	cLoja
				//If (cMesBase<>E1_MESBASE .And. cAnoBase<>E1_ANOBASE) // aberto
				if !empty(Meses->(E1_ANOBASE+E1_MESBASE))  // altmairo - tratar tit de impostos que sao gerados sem mesbase , anobase
					If (cAnoBase+cMesBase<>Meses->(E1_ANOBASE+E1_MESBASE))
						Aadd(aMeses,Meses->E1_MESBASE+"/"+Meses->E1_ANOBASE)
					EndIf
				EndIf
				Meses->(DbSkip())
			End
			Meses->(DbCloseArea())
		EndIf
		RestArea(aAreaSE1)
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
		±±ºFuncao    ³R240HeaderºAutor  ³Rafael M. Quadrotti º Data ³  03/11/04   º±±
		±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
		±±ºDesc.     ³Emite um novo cabecalho devido a quebra de pagina.          º±±
		±±º          ³                                                            º±±
		±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
		±±ºUso       ³ AP6 PLS                                                    º±±
		±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
		*/
	Static Function R240HEADER(oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBitMap, aDadosTit, aDadosBanco, aDatSacado, aDepEndentes, aOPenMonth, oBrush, nTamCorp)
		Local ni
		
		DEFAULT nTamCorp := 1
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Dados da empresa....                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Jean - modIficado em 06/12/07 para contemplar todas as impressoras...
		/*
		oPrint:Say  (050	,500	,aDadosEmp[1]	,oFont11n)
		oPrint:Say  (090	,500	,aDadosEmp[2] 	,oFont8 )
		oPrint:Say  (125	,500	,aDadosEmp[3] 	,oFont8 )
		oPrint:Say  (160	,500	,aDadosEmp[4] 	,oFont8 )
		oPrint:Say  (195	,500	,aDadosEmp[5] 	,oFont8 )
		oPrint:Say  (230	,500	,aDadosEmp[6] 	,oFont8 )
		*/
		//oPrint:Say  (050	,500	,	,oFont11n)
		oPrint:Say  (090	,500	,aDadosEmp[1] 	,oFont11n )
		oPrint:Say  (125	,500	,aDadosEmp[2]+"- "+aDadosEmp[3] 	,oFont8 )
		oPrint:Say  (160	,500	,aDadosEmp[4] 	,oFont8 )
		oPrint:Say  (195	,500	,aDadosEmp[5] 	,oFont8 )
		oPrint:Say  (230	,500	,aDadosEmp[6] 	,oFont8 )
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄ¿
		//³Bmp da ANS³
		//ÀÄÄÄÄÄÄÄÄÄÄÙ
		If File(SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"))
			oPrint:SayBitmap (050 ,1825,SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"),470 ,150)
		Else
			oPrint:Say  (250,500,aDadosEmp[7] ,oFont10)
		EndIf
		
		oPrint:Say  (250,1780,STR0044 + R240Imp->E1_MESBASE+" / "+R240Imp->E1_ANOBASE ,oFont10) //"Mês de competência: "
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Logo tipo da empresa...                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:SayBitmap (50 ,100,aBitMap[1],350 ,200 ) //coluna inicial / linha inical, bitmap,  coluna final / linha final.
		
		//Linhas do extrato.
		If nTamCorp = 1
			oPrint:Box  (300,100,1852,2300)
			oPrint:Line (400,0100,400,2300)
			oPrint:Line (700,0100,700,2300)
			oPrint:Line (300,0400,400,0400)
			oPrint:Line (300,0800,400,0800)
			oPrint:Line (300,1150,700,1150)
			oPrint:Line (300,1500,400,1500)
			oPrint:Line (300,1900,700,1900)
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao das colunas do extrato de utilizacao.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Line (750,0100,750,2300) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
			If SE1->E1_PREFIXO == 'PLS'
				
				oPrint:Line (750,0500,1625,0500) // Linha divisória de colunas //usuario/prestador
				oPrint:Line (750,1050,1625,1050) // Linha divisória de colunas //prestador/data
				oPrint:Line (750,1250,1625,1250) // Linha divisória de colunas //data/lote
				//	oPrint:Line (750,1550,1625,1550) // Linha divisória de colunas //lote/nro guia
				oPrint:Line (750,1800,1625,1800) // Linha divisória de colunas //lote/nro guia
				oPrint:Line (750,2100,1625,2100) // Linha divisória de colunas //nro guia/vlr total
				oPrint:Line (800,0100,800,2300) // Linha horizontal do cabecalho do extrato.
				
			EndIf
			
			oPrint:Line  (1902,100,1902,2300)// Tracejado para destaque do boleto.
			oPrint:Line (1625,100,1625,2300)// Limite para observacao
			
		Else
			oPrint:Box  (300,100,3200,2300)		// Caixa principal do corpo do boleto
			oPrint:Line (400,0100,400,2300)		// Cabecalho 1                                                         1
			oPrint:Line (700,0100,700,2300)		// Cabecalho 2
			
			oPrint:Line (300,0400,400,0400)
			oPrint:Line (300,0800,400,0800)
			
			oPrint:Line (300,1150,700,1150)
			oPrint:Line (300,1500,400,1500)
			oPrint:Line (300,1900,700,1900)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao das colunas do extrato de utilizacao.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Line (750,0100,750,2300) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
			oPrint:Line (800,0100,800,2300) // Linha horizontal do cabecalho do extrato.
			oPrint:Line (750,0500,3200,0500) // Linha divisória de colunas
			oPrint:Line (750,1050,3200,1050) // Linha divisória de colunas
			oPrint:Line (750,1250,3200,1250) // Linha divisória de colunas
			//	oPrint:Line (750,1550,3200,1550) // Linha divisória de colunas
			oPrint:Line (750,1800,3200,1800)
			oPrint:Line (750,2100,3200,2100) // Linha divisória de colunas
			
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Textos  das colunas do extrato de utilizacao.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SE1->E1_PREFIXO == 'PLS'
			
			oPrint:Say  (760,0110,STR0049      ,oFont8 )
			oPrint:Say  (760,0510,STR0054      ,oFont8 )
			oPrint:Say  (760,1060,STR0052      ,oFont8 )
			//oPrint:Say  (760,1260,STR0053      ,oFont8 )
			oPrint:Say  (760,1260,"Descrição do serviço",oFont8 )
			//oPrint:Say  (760,1560,STR0061      ,oFont8 )
			oPrint:Say  (760,1810,"Despesa    " ,oFont8 )
			oPrint:Say  (760,2110,"A Pagar"      ,oFont8 )
			oPrint:Say  (710,((2300-21)/2),STR0048      ,oFont8 ) //21 = Len de "Extrato de utilizacao"  Calculo para centralizar //"Extrato de utilização"
			oPrint:FillRect({705,100,750,2300},oBrush)
			
		Else
			
			oPrint:Say  (760,0110,"Descrição"      ,oFont8 )
			oPrint:FillRect({705,100,750,2300},oBrush)
			
		EndIf
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime os dados do cabecalho...               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Say  (300,105,STR0008                   		,oFont8 ) //"Vencimento"
		oPrint:Say  (345,205,DTOC(aDadosTit[4])             ,oFont10)
		
		oPrint:Say  (300,405,STR0009                     	,oFont8 ) //"Valor R$"
		oPrint:Say  (345,505,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
		
		oPrint:Say  (300,805,STR0010             			,oFont8 ) //"Data de Emissão"
		oPrint:Say  (345,905,DTOC(aDadosTit[3])             ,oFont10)
		
		oPrint:Say  (300,1155,STR0011            			,oFont8 ) //"Nro.do Documento"
		oPrint:Say  (345,1255,aDadosTit[1]                  ,oFont10)
		
		oPrint:Say  (300,1505,STR0012      					,oFont8 ) //"Agência/Código Cedente"
		oPrint:Say  (345,1555,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
		
		oPrint:Say  (300,1905,STR0013                		,oFont8 ) //"Nosso Numero"
		oPrint:Say  (345,1950,aDadosTit[6]                  ,oFont10)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Emissao dos dados do sacado.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Say  (400,105 ,STR0004             					,oFont8 ) //"Dados do Sacado"
		oPrint:Say  (470,115 ,aDatSacado[1]+" ("+aDatSacado[2]+")"	,oFont10)
		oPrint:Say  (505,115 ,aDatSacado[3]                     	,oFont10)
		oPrint:Say  (540,115 ,aDatSacado[4]                      	,oFont10)
		oPrint:Say  (540,700 ,aDatSacado[5]+"   "+aDatSacado[6]	,oFont10)
		oPrint:Say  (575,115 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3) ,oFont10)
		
		If se1->e1_prefixo == 'PLS'
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Em pessoa fisica, imprime os depEndentes da familia..|
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Say  (400,1155 ,STR0005+IIf(BA3->BA3_TIPOUS == '1',(" ("+R240Imp->E1_CODINT+"."+R240Imp->E1_CODEMP+"."+R240Imp->E1_MATRIC+")"),"") ,oFont8 ) //"Usuários"
			nContLn := 455
			For nI := 1 To Len(aDepEndentes)
				If nI == 1
					oPrint:Say  (nContLn,1165 ,aDepEndentes[nI,1]+" - "+AllTrim(aDepEndentes[nI,2])+STR0006		      ,oFont8) //" (Titular)"
				Else
					oPrint:Say  (nContLn,1165 ,aDepEndentes[nI,1]+" - "+aDepEndentes[nI,2]			      ,oFont8)
				EndIf
				nContLn+=25
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Emite somente os 5 primeiros depEndentes devido ao espaco no boleto.³
				//³Foi utilizado for e estrutura de array para facilitar a customizacao³
				//³para impressao de mais depEndentes.								   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  nI > 9
					Exit
				EndIf
			Next nI
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime os meses em aberto deste cliente/contrato... ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Say  (400,1905 ,STR0007                  ,oFont8 ) //"Meses em aberto"
			nContLn := 455
			nColuna := 1905
			For nI := 1 To Len(aOpenMonth)
				oPrint:Say  (nContLn,nColuna ,aOPenMonth[nI] ,oFont8)
				nContLn+=25
				
				//Alterna as colunas
				/*If nColuna == 1905
				nColuna := 1955
			ElseIf nColuna == 1955
				nColuna := 1905
			EndIf
			
			If nI > 18
				Exit
			EndIf aberto */
			
			If nI > 10
				Exit
			EndIf
		Next nI
		
	EndIf
	
Return .T.

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ ImpCNAB  ³ Autor ³ Jean Schulz           ³ Data ³ 12.10.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime Boleto / Exportacao CNAB Itau - Caberj.            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ImpCNAB(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
		aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
		aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
		aDepEndentes	,aObservacoes	,cCart			,cPrefixo	,;
		cTitulo			,cGrupoEmp 		,cMatric		,lPrima		)
	
	
	Local nI		:= 0	// Contador do laco para impressao de depEndentes.
	Local nMsg      := 0    // Contador para as mensagens
	Local cMoeda	:= "9"  // Moeda do boleto.
	Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = normal 2 = Grande.
	Local nCob		:= 0	// Contador para for do extrato.
	Local cString	:= ""
	Local cNomeArq	:= ""
	Local _cSQLTmp	:= ""
	
	
	If lPrima
		_cSQLTmp := " SELECT Substr(MAX(E1_YAREXPO),9,8) AS MAXCNAB "
		_cSQLTmp += " FROM "+RetSQLName("SE1")+" SE1 "
		_cSQLTmp += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
		_cSQLTmp += " AND E1_YTPEXP = 'B' " //CNAB 112 - ENVIO
		_cSQLTmp += " AND SE1.D_E_L_E_T_ = ' ' "
		PLSQuery(_cSQLTmp,"TRBCNA")
		
		_cSeqNom := DtoS(dDataBase)+StrZero(Val(TRBCNA->MAXCNAB)+1,8)
		
		TRBCNA->(DbCloseArea())
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Seta tabelas e indices a serem utilizados...             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SEE->(DbSetOrder(1))
	BA0->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Cria arquivo no Local padrao CNAB...                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lPrima
		cNomeArq := GETNEWPAR("MV_YDIBOL","\CNAB\Exporta\")+_cSeqNom+".txt"
		
		If !U_Cria_TXT(cNomeArq)
			Return Nil
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Cria o Header do arquivo...                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cString := CNABHEADER(aDadosBanco)
		
		cLin := Space(1)+cEOL
		cCpo := cString
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
			Return Nil
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Cria registros do tipo 1 / CNAB.               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cString := CNABTIPO1(aDadosBanco)
	
	cLin := Space(1)+cEOL
	cCpo := cString
	
	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
		Return Nil
	EndIf
	
	///CNABTIPO7(aCobranca) //
	CNABTIPO7(aCobranca,aObservacoes,aOpenMonth) //Paulo Motta //aberto
	
Return Nil

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNABHEADERºAutor  ³ Jean Schulz        º Data ³  11/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria Header para arquivo CNAB Itau.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CNABHEADER(aDadosBanco)
	Local cString	:= ""
	Local cCodBan	:= aDadosBanco[1]
	Local cAgencia	:= Transform(Val(aDadosBanco[3]),"9999")
	Local cConta	:= StrZero(Val(aDadosBanco[4]),5)
	Local cDigit	:= AllTrim(aDadosBanco[5])// Marcela Coimbra
	Local cDiaGer	:= DtoS(dDataBase)
	
	cString := "01REMESSA01COBRANCA       "
	
	cDiaGer := Substr(cDiaGer,7,2)+Substr(cDiaGer,5,2)+Substr(cDiaGer,3,2)
	
	cString += cAgencia+"00"+cConta+cDigit+Space(8)+Substr(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT"),1,30)
	// cString += cAgencia+"00"+cConta+Substr(SEE->EE_CONTA,6,1)+Space(8)+Substr(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT"),1,30) Marcela Coi
	cString += aDadosBanco[1]+Substr(aDadosBanco[2],1,15)+cDiaGer+Space(294)+cSeqArq
	
	cSeqArq := Soma1(cSeqArq)
	
Return cString

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNABTIPO1 ºAutor  ³Jean Schulz         º Data ³  11/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime registro detalhe CNAB Tipo 1                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CNABTIPO1(aDadosBanco)
	Local cString	:= ""
	Local cDatEmi	:= DtoS(R240Imp->E1_EMISSAO)
	Local cDatVen	:= DtoS(R240Imp->E1_VENCREA)
	Local cValor	:= StrZero(R240Imp->(SALDO-E1_IRRF)*100,13)
	
	cDatVen	:= Substr(cDatVen,7,2)+Substr(cDatVen,5,2)+Substr(cDatVen,3,2)
	cDatEmi := Substr(cDatEmi,7,2)+Substr(cDatEmi,5,2)+Substr(cDatEmi,3,2)
	
	SA1->(MsSeek(xFilial("SA1")+R240Imp->(E1_CLIENTE+E1_LOJA)))
	
	//Informacoes "amarradas" em codigo foram confirmadas por Sr. Paulo Motta (Caberj)...
	
	cString := "1" //TIPO DE REGISTRO
	cString += "02"  //CODIGO DE INSCRICAO
	cString += BA0->BA0_CGC //NUMERO DE INSCRICAO
	cString += Transform(Val(aDadosBanco[3]),"9999") //AGENCIA
	cString += Replicate("0",2) //ZEROS
	cString += StrZero(Val(Substr(aDadosBanco[4],1,5)),5) //CONTA
	cString += trim( aDadosBanco[5] ) //Marcela Coimbra
	//cString += Substr(SEE->EE_CONTA,6,1) //DAC
	cString += Space(4) //BRANCOS
	cString += Replicate("0",4) //INSTRUCAO/ALEGACAO
	//Alteração do tamanho do titulo.
	If len(AllTrim(R240Imp->E1_NUM)) == 9
		cString += R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+Space(9) //USO DA EMPRESA / Livre utilizacao... Enviar codigo do titulo completo...
	Else
		cString += R240Imp->(E1_PREFIXO+AllTrim(E1_NUM)+E1_PARCELA+E1_TIPO)+Space(12) //USO DA EMPRESA / Livre utilizacao... Enviar codigo do titulo completo...
	EndIf
	
	//cString += Replicate("0",2)+R240Imp->E1_NUM //NOSSO NUMERO
	If len(AllTrim(R240Imp->E1_NUM)) == 9
		cString += substr(R240Imp->E1_NUM,2,8) //NOSSO NUMERO
	Else
		cString += Replicate("0",2)+AllTrim(R240Imp->E1_NUM)
	EndIf
	cString += Replicate("0",13) //QTDE DE MOEDA
	cString += "112" //NRO DA CARTEIRA
	cString += Space(21) //USO DO BANCO
	cString += "I" //CARTEIRA
	cString += "01" //CODIGO DE OCORRENCIA
	//cString += Replicate("0",4)+R240Imp->E1_NUM //NRO DOCUMENTO
	cString += Replicate("0",1)+R240Imp->E1_NUM //NRO DOCUMENTO -- Alteração do tamanho do titulo.
	cString += cDatVen //VENCIMENTO
	cString += cValor //VALOR DO TITULO
	cString += "341" //CODIGO DO BANCO
	cString += Replicate("0",5) //AGENCIA COBRADORA
	cString += "01" //ESPECIE
	cString += "A" //ACEITE
	cString += cDatEmi //DATA DE EMISSAO
	cString += Replicate("0",2) //INSTRUCAO 1
	cString += Replicate("0",2) //INSTRUCAO 2
	cString += Replicate("0",13) //JUROS DE 1 DIA
	cString += Replicate("0",6) //DESCONTO ATE
	cString += Replicate("0",13) //VALOR DO DESCONTO
	cString += Replicate("0",13) //VALOR DO IOF
	cString += Replicate("0",13) //ABATIMENTO
	cString += IIf(SA1->A1_PESSOA =="F","01","02") //CODIGO DE INSCRICAO
	cString += Replicate("0",14-Len(AllTrim(SA1->A1_CGC)))+AllTrim(SA1->A1_CGC) //NUMERO DE INSCRICAO
	cString += Substr(SA1->A1_NOME,1,30) //NOME
	cString += Substr(SA1->A1_NOME,31,10) //BRANCOS
	cString += SA1->A1_End //LOGRADOURO
	cString += Substr(SA1->A1_BAIRRO,1,12) //BAIRRO
	cString += SA1->A1_CEP //CEP
	cString += Substr(SA1->A1_MUN,1,15) //CIDADE
	cString += SA1->A1_EST //ESTADO
	cString += Space(30) //SACADOR/AVALISTA
	cString += Space(4) //BRANCOS
	cString += Replicate("0",6) //DATA DE MORA
	cString += Replicate("0",2) //PRAZO
	cString += Space(1) //BRANCOS
	cString += cSeqArq //NUMERO SEQUENCIAL
	
	cSeqArq := Soma1(cSeqArq)
	
Return cString

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
	PutSx1(cPerg,"17",OemToAnsi("Tipo de Impresso")		,"","","mv_chh","N",01,0,0,"C","","","","","mv_par17","112-CNAB Itau","","","","175-Reimpressao","","","999-Analítico","","","","","","","","",{},{},{})
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
	PutSx1(cPerg,"29",OemToAnsi("Boleto Tipo Fatura ?")	,"","","mv_cht","N",01,0,0,"C","","","","","mv_par29","Nao","","","","Sim","","","","","","","","","","","",{},{},{})
	
Return

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNABTRAILLERºAutor  ³Jean Schulz       º Data ³  12/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria registro Trailler para arquivo CNAB Itau - Caberj.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CNABTRAILLER()
	Local cString := ""
	
	cString := "9"+Replicate(" ",393)+cSeqArq
	
Return cString

*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNABTIPO7   ºAutor  ³Jean Schulz       º Data ³  13/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime detalhamento de fatura CABERJ - Itau.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CNABTIPO7(aCobranca,aObservacoes,aOpenMonth)  //aberto
	
	//Local nAbcnt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local cCodUsu	:= ""
	Local cDatPro	:= ""
	Local cNomUsu	:= ""
	Local cDesPro	:= ""
	Local cVlrBPF	:= ""
	Local cVlrMen	:= ""
	Local cVlrTPF	:= ""
	Local nCont		:= 0
	Local nCont2	:= 0
	Local cString	:= ""
	Local aTexto	:= {}
	Local aTextoCmp	:= {} // MBC Projeto Extrato
	Local aMensa	:= {}
	Local nVlrTPF	:= 0
	Local nPos		:= 0
	Local nLinha	:= 6
	Local nTexto	:= 0
	Local lPrima	:= .T.
	Local nVlrMen	:= 0
	Local nVlrOut	:= 0
	Local cTipLanAn	:= ""
	Local lExt112	:= .F.
	Local nVlrTmp	:= 0
	
	Local aArSE1	:= {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definir matriz com espacos em branco e numero de linhas...               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCont := 1 to 57
		aadd(aTexto,{Space(100),nCont})
		aadd(aTextoCmp,{Space(100),nCont,.F.})
	Next
	
	BFQ->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprimir neste laco somente quando for co-participacao e afins...        ³ // Outros (parcelamento etc) Motta
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCont := 1 to Len(aCobranca)
		
		//Nova implementacao - Inverter sinal caso lancamento seja de credito...
		If !Empty(aCobranca[nCont,02]) //LegEnda: se for co-participacao...
			
			cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
			cDatPro	:= DtoC(StoD(aCobranca[nCont,03]))
			//cNomUsu	:= Substr(aCobranca[nCont,01],1,25)
			cNomUsu	:= Substr(aCobranca[nCont,02],1,25)
			cDesPro	:= Substr(aCobranca[nCont,06],1,24)
			cVlrBPF	:= Transform(aCobranca[nCont,11],"@E 99,999.99")
			cVlrTPF	:= Transform(aCobranca[nCont,07],"@E 99,999.99")
			
			nVlrTPF += aCobranca[nCont,07]
			
			If !lExt112
				
				//aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+Space(1)+cVlrTPF,1,100)
				aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
				aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
				aTextoCmp[nLinha,3] :=  .T.
				nLinha++
				
				If nLinha > 24 .And. !lExt112
					lExt112 := .T.
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Marcar caso estoure o limite de linhas no boleto 112...                  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aArSE1 := SE1->(GetArea())
					SE1->(DbSetOrder(1))
					SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
					//    SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)))
					If SE1->E1_YEXANLT <> "1"
						SE1->(RecLock("SE1",.F.))
						SE1->E1_YEXANLT := "1"
						SE1->(MsUnlock())
					EndIf
					
					RestArea(aArSE1)
				EndIf
				
			EndIf
			
			nPos := Ascan( aMensa, { |x| x[1] == aCobranca[nCont,09] } )
			If nPos = 0
				aadd(aMensa,{aCobranca[nCont,09],"",aCobranca[nCont,01],0,aCobranca[nCont,07]})
			Else
				aMensa[nPos,05] += aCobranca[nCont,07]
			EndIf
			
		Else //LegEnda: se for mensalidade...
			
			
			//Nova implementacao - Inserir linhas para outros debitos/creditos...
			If aCobranca[nCont,05] $ PLSRETLADC()
				
				cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
				cDatPro	:= Space(08)
				cNomUsu	:= Substr(aCobranca[nCont,01],1,25)
				cDesPro	:= Substr(aCobranca[nCont,06],1,24)
				cVlrBPF	:= Space(09)
				cVlrTPF	:= Transform(aCobranca[nCont,07],"@E 99,999.99")
				
				If ! lExt112
					//aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+Space(1)+cVlrTPF,1,100)
					aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					nLinha++
					
					If nLinha > 24 .And. !lExt112
						
						lExt112 := .T.
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Marcar caso estoure o limite de linhas no boleto 112...                  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aArSE1 := SE1->(GetArea())
						SE1->(DbSetOrder(1))
						//SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						If SE1->E1_YEXANLT <> "1"
							SE1->(RecLock("SE1",.F.))
							SE1->E1_YEXANLT := "1"
							SE1->(MsUnlock())
						EndIf
						
						RestArea(aArSE1)
					EndIf
					
				EndIf
				
			EndIf
			//Fim - nova implementacao / Debitos/Creditos no corpo do 112
			
			cTipLanAn := Posicione("BFQ",1,xFilial("BFQ")+PLSINTPAD()+aCobranca[nCont,5],"BFQ_YTPANL")
			
			If cTipLanAn == "M"
				nVlrMen += IIf(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
				
			ElseIf cTipLanAn == "C"
				nVlrTPF += IIf(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
			Else
				nVlrOut += IIf(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
			EndIf
			
			//Ajuste: somar conforme definicao do tipo de lancamento.
			nPos := Ascan( aMensa, { |x| x[1] == aCobranca[nCont,09] } )
			
			nVlrTmp := IIf(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
			
			If nPos = 0
				aadd(aMensa,{aCobranca[nCont,09],"",aCobranca[nCont,01],IIf(cTipLanAn <> "C",nVlrTmp,0),IIf(cTipLanAn == "C",nVlrTmp,0)})
			Else
				aMensa[nPos,IIf(cTipLanAn <> "C",04,05)] += nVlrTmp
			EndIf
			
			
			//Fim da nova implementacao - Inverter sinal caso lancamento seja de credito...
			
		EndIf
		
	Next
	
	nEntrou := 0
	/*     mbc
	If nLinha > 24
		
		For n_Msg := 1 to Len ( aTexto )
			
			If aTextoCmp[ n_Msg ][ 3 ]
				
				aTexto[ n_Msg ][1] := space(100)
				nEntrou++
				
			EndIf
			
		Next
		
		aTexto[24,1] :=  GetNewPar("MV_YMSGAN", 'M E N S A G E M ')
		
	EndIf
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finalizar matriz aTexto com valores de mensalidade...                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLinha := 41
	lExt112 := .F.
	For nCont := 1 to Len(aMensa)
		
		If !lExt112
			cCodUsu := Substr(aMensa[nCont,1],1,4)+"."+Substr(aMensa[nCont,1],5,4)+"."+Substr(aMensa[nCont,1],9,6)+"."+Substr(aMensa[nCont,1],15,2)+"-"+Substr(aMensa[nCont,1],17,1)
			cNomUsu := Substr(aMensa[nCont,3],1,38)
			
			//Jean - Alterado conforme questionamento Paulo Motta.
			//Segundo argumentacao, o valor deveria ser mensalidade e valor da copart.
			cVlrMen := Transform(aMensa[nCont,04],"@E 99,999.99")
			cVlrTPF := Transform(aMensa[nCont,05],"@E 99,999.99")
			
			aTexto[nLinha,1] := Substr(cCodUsu+Space(1)+cNomUsu+Space(1)+cVlrMen+Space(1)+cVlrTPF,1,100)
			aTexto[nLinha,1] += Space(100-Len(aTexto[nLinha,1]))
			nLinha++
			
			If nLinha > 55 .And. !lExt112
				MsgAlert("Impossivel inserir mais linhas neste boleto! Enviar via relatorio analítico!","Atenção")
				lExt112 := .T.
			EndIf
		EndIf
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acertos gerais nas linhas a serem impressas                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aTexto[1,1] := Space(74)+MesExt(R240Imp->E1_MESBASE)+ "    "+R240Imp->E1_ANOBASE
	aTexto[1,1] += Space(100-Len(aTexto[1,1]))
	aTexto[37,1] := Transform(nVlrMen,"@E 99,999.99")+Space(15)+Transform(nVlrTPF,"@E 99,999.99")+Space(15)+Transform(nVlrOut,"@E 99,999.99")+Space(15)+Transform(nVlrMen+nVlrTPF+nVlrOut,"@E 99,999.99")
	aTexto[37,1] += Space(100-Len(aTexto[37,1]))
	
	If Len(aMensa) > 0
		aTexto[57,1] := Substr(aMensa[1,1],1,4)+"."+Substr(aMensa[1,1],5,4)+"."+Substr(aMensa[1,1],9,6)+"."+Substr(aMensa[1,1],15,2)+"-"+Substr(aMensa[1,1],17,1)
	EndIf
	
	aTexto[57,1] += Space(7)+Substr(R240Imp->E1_NUMBCO,1,8)+Space(14)+DtoC(R240Imp->E1_VENCREA)+Space(16)+Transform(R240Imp->(SALDO-E1_IRRF),"@E 99,999.99")
	aTexto[57,1] += Space(100-Len(aTexto[57,1]))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obter linhas livres no boleto X faixa repassada para msg reajuste...     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nCont := 41
	While nCont <= 55 //Linhas 41 X 55 - Faixa de usuarios (Mensalidade)
		If Empty(AllTrim(aTexto[nCont,1]))
			Exit
		EndIf
		nCont++
	Enddo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inserir mensagem de reajuste no boleto a ser impresso...                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nCont := 32
	
	cMsgAbt := ""
	For nAbcnt := 1 to Len(aOpenMonth)
		If nAbcnt == 1
			cMsgAbt := "MES(ES) EM ABERTO : "
		End If
		cMsgAbt += AllTrim(aOPenMonth[nAbcnt]) + " "
	Next nAbcnt
	If cMsgAbt <> ""
		aTexto[nCont,1] := cMsgAbt+Space(100-Len(cMsgAbt))
		nCont++
	End If
	
	For nCont2 := 1 to Len(aObservacoes)  // Paulo Motta
		aTexto[nCont,1] := aObservacoes[nCont2]
		aTexto[nCont,1] += Space(100-Len(aTexto[nCont,1]))
		If nCont >= 33  // - Faixa de usuarios (Mensalidade)
			nCont2 := Len(aObservacoes)
		EndIf
		
		nCont++
		
	Next
	
	
	/*BEGINDOC
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Mensagem de títulos em aberto - em teste ABERTO³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
EndDOC*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nova implementacao: validacao do boleto gerado X base de dados. Soh      ³
//³ exportar caso nao haja inconsistencia...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nVlrMen+nVlrTPF+nVlrOut <> R240Imp->E1_VALOR
	Aadd(aCritica,{"Valor do Saldo do título não confere com o total do analítico! Arquivo não deverá ser enviado!",R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)})
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravar registro como enviado CNAB, e amarrar o nome do arquivo...        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
If GetNewPar("MV_YFLGBL","N") = "S"
	U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
EndIf
SE1->(RecLock("SE1",.F.))
SE1->E1_YTPEXP	:= "B" //CNAB 112 - ENVIO - TABELA K1
SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"B", "X5_DESCRI")
SE1->E1_YAREXPO	:= _cSeqNom
SE1->(MsUnlock())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gerar linhas ja tratadas no .TXT                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTexto := 1
For nCont := 1 to Len(aTexto)
	
	If nTexto == 1
		
		If lPrima
			lPrima := .F.
		Else
			
			cString += cSeqArq
			cSeqArq := Soma1(cSeqArq)
			
			cLin := Space(1)+cEOL
			cCpo := cString
			
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A MENSAGEM! OPERAÇÃO ABORTADA!")
				Return Nil
			EndIf
		EndIf
		
		cString := "7" //Codigo do registro
		cString += "KAZ" //Flash
		
	EndIf
	
	cString += StrZero(aTexto[nCont,2],2) //Numero da linha
	cString += aTexto[nCont,1] //Texto
	
	cString += Space(28) //Brancos
	
	If nTexto <= 2
		nTexto++
	Else
		nTexto := 1
	EndIf
	
Next

cString += cSeqArq
cSeqArq := Soma1(cSeqArq)

cLin := Space(1)+cEOL
cCpo := cString

If !(U_GrLinha_TXT(cCpo,cLin))
	MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A MENSAGEM! OPERAÇÃO ABORTADA!")
Return Nil
EndIf

Return Nil

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

User Function NMenReaj(aProdutos,cTipPes, c_AnoMes, cPerRea, cIndRea)
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
		
		/*
		
		While (Len(Trim(cMsg)) > 0)
			Aadd(aMsg,{Substr(cMsg,1,92),"","","","","",""}) //Motta jun/2009
			nCont++
			cMsg := Trim(Substr(cMsg,93,100))
			
		Enddo  */
		
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
	/*
	Local nPCont1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nPCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nAbcnt 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	*/
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
			cMatAnt := aCobranca[nPCont,9]
			nTotCopUsr := 0
			nTotContUsr := 0
			nTotOutrUsr := 0
		EndIf
		
		If Len(AllTrim(aCobranca[nPCont,5])) == 3
			cTipLanAn := Posicione("BFQ",1,xFilial("BFQ")+PLSINTPAD()+aCobranca[nPCont,5],"BFQ_YTPANL")
		Else
			cTipLanAn := "C"
		EndIf
		
		
		If cTipLanAn == "M"
			nTotContr	+= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
			nTotContUsr += IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
		Else
			
			If cTipLanAn == "C"
				
				VarTst := aCobranca[nPCont,11]
				nTotCopUsr	+= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				nTotCopar	+= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				If Type("VarTst") == "N"
					nTotBPF		+= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,11]
					nVlrBPF		:= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,11]
				Else
					nVlrBPF 	:= 0
				EndIf
				
			Else
				nTotOutr	+= IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				nTotOutrUsr += IIf(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
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
				IIf(nVlrBPF > 0,Transform(aCobranca[nPCont,11],"@E 999,999.99"),Space(10))+;
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
		
		/*
		cCpo :=	"2"+;
			"1"+;
			BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
			Substr(BA1->BA1_NOMUSR,1,30)+;
			Space(10)+; //Nao enviar
		Space(2)+; //Nao enviar
		Space(20)+; //Nao enviar
		Transform(aTotUsr[nPCont,3],"@E 9,999,999.99")+; //Valor Contraprestacao
		Transform(aTotUsr[nPCont,2]+aTotUsr[nPCont,4],"@E 9,999,999.99")+; //Valor Coparticipacao + Valor Outros
		Space(443)       */
		
		Aadd(aImp[1,4],cCpo)
		
	Next
	
	
	//For nPCont := 1 To Len(aMsgBoleto)
	//	cNomVar := "cMsg"+StrZero(nPCont,1)
	//	&cNomVar := aMsgBoleto[nPCont]
	//	If nPCont > 3
	//		Exit
	//	EndIf
	//Next   Paulo Motta -- Reajuste
	
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
	/*
	If Len(aMsgReaj) == 1
		
		cMsg1 := strtran(aMsgReaj[1], '   ', ' ')
		
	EndIf
	
	If Len(aMsgReaj) == 2
		
		
		cMsg2 := strtran(aMsgReaj[2], '   ', ' ')
		
	EndIf
	
	If Len(aMsgReaj) == 3
		
		cMsg3 := strtran(aMsgReaj[3], '   ', ' ')
		
	EndIf
	*/
	
	For n_Count:= 1 to Len( aMsgReaj )
		
		&("cMsg"+ alltrim(str(n_Count))) := strtran(aMsgReaj[n_Count ], '   ', ' ') + ' '
		
	Next
	
	
	If VerAdp(R240Imp->E1_CODEMP, R240Imp->E1_MATRIC) .and. GetNewPar("MV_YGRIMVZ","0") == "1" .AND. R240Imp->E1_MESBASE = '05'
		
		If EMpty(cMsg1)
			
			cMsg1 := "Declaramos a quitacao do ano de " + cvaltochar(year(ddatabase)-1) + ", a mesma substitui todos os recibos de pagamento do ano de "
			cMsg2 := "" + cvaltochar(year(ddatabase)-1) + ". Debitos prorrogados ou negociados para periodos futuros nao estao contemplados."
			
		Else
			cMsg3 := strtran(cMsg1, '   ', ' ')
			cMsg1 := "Declaramos a quitacao do ano de " + cvaltochar(year(ddatabase)-1) + ", a mesma substitui todos os recibos de pagamento do ano de"
			cMsg2 := "" + cvaltochar(year(ddatabase)-1) + ". Debitos prorrogados ou negociados para periodos futuros nao estao contemplados."
			
		EndIf
		
	EndIf
	
	
	
	BA1->(DbGoTo(nRegTitu))
	
	**'Marcela Coimbra em 04/10/2016 - Acerto de layout'**
	
	cCpo :=	"1"+;    //1
	"2"+;   //2
	BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;  //20
	StrZero(Val(BA1->BA1_MATEMP),18)+; //38
	Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;//
	Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
		Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
		Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
		Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
		cEstado+;
		cCompet+Space(29-Len(cCompet))+;
		Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao '+' + Transform(nTotRtContr,"@E 999.99")+; //Total Retroativo
	Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
	Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
	Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
	Space(3)+cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1       Space(4)+
	cMsg2+Space(100-Len(cMsg2))+;  //Mensagem 2
	cMsg3+Space(100-Len(cMsg3))+;  //Mensagem 3
	space(100)
	/*
	
	cCpo :=	"1"+;    //1
	"2"+;   //2
	BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;  //20
	StrZero(Val(BA1->BA1_MATEMP),18)+; //38
	Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;//
	Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
		Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
		Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
		Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
		cEstado+;
		cCompet+Space(19-Len(cCompet))+;
		Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao '+' + Transform(nTotRtContr,"@E 999.99")+; //Total Retroativo
	space(2)+;
		Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
	Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
	Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
	Space(3)+cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1       Space(4)+
	cMsg2+Space(100-Len(cMsg2))+;  //Mensagem 2
	cMsg3+Space(100-Len(cMsg3))+;  //Mensagem 3
	space(100)
	*/
	**'Marcela Coimbra em 04/10/2016 - Fim do Acerto de layout'**
	**'Marcela Coimbra     - Log de mensagens'**
	
	If trim( cMsg1 + cMsg2 + cMsg3 ) <> ''
		
		cQuery  := " insert into log_imp_extrato values ( '" + BA1->BA1_CODINT + "', '" + BA1->BA1_CODEMP + "', '" + BA1->BA1_MATRIC + "', "
		cQuery  += " '" + BA1->BA1_TIPREG + "', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cMsg1 + cMsg2 + cMsg3 + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
		
		TcSqlExec(cQuery) >= 0
		
	EndIf
	
	
	**'Marcela Coimbra FIm - Log de mensagens'**
	/*
	cCpo :=	"1"+;
		"2"+;
		BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
		StrZero(Val(BA1->BA1_MATEMP),18)+;
		Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;
		Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
		Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
		Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
		Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
		cEstado+;
		cCompet+Space(30-Len(cCompet))+;
		Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao
	Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
	Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
	Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
	cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1
	cMsg2+Space(100-Len(cMsg2))+; //Mensagem 2
	cMsg3+Space(100-Len(cMsg3))+; //Mensagem 3
	Transform(nTotBPF,"@E 9,999,999.99") //Total Base Part. Financeira
	*/
	
	
	
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
			.or. BA3->BA3_GRPCOB $ "1001|1002|1003"  .or. se1->e1_formrec = '06' )
			//	If !l_FamBlo .and.  (lMosRea  .OR. ( Len(aImp[nPCont,5]) > 0 .Or. GetNewPar("MV_YGRIMVZ","0") == "1" ))  // imprime_todos      )
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
				
			Case aImp[nPCont,6] == "05" //Arquivo Rio Previdencia...
				cNomArr += "5"
				
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
			
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria arquivo de trabalho conforme layout...								 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Do Case
			Case cLayOut $ "400/500/600"
				aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
					{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
					{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
					{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
					{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
					{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
					{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
					{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
					{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
					{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
					{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
					{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
					{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
					{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
					{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
					{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"TIPPAC","C",  1,0},;
					{"RESERV","C", 29,0},{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},;
					{"MOEDA" ,"C",  2,0},{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},;
					{"CODANT","C",  7,0},{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
			Case cLayOut == "301" .and. nTamLin > 290
				aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
					{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
					{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
					{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
					{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
					{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
					{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
					{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
					{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
					{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
					{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
					{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
					{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
					{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
					{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
					{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"QTDFIL","C",  6,0},;
					{"VLRFIL","N",  8,0},{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},;
					{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},;
					{"GLOSA" ,"N",  8,0},{"TMPCIR","C",  7,0},{"CODUSR","C",  3,0},;
					{"CODANT","C",  7,0},{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
			Case cLayOut == "301"
				aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
					{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
					{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
					{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
					{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
					{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
					{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
					{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
					{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
					{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
					{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
					{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
					{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
					{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
					{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
					{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"QTDFIL","C",  6,0},;
					{"VLRFIL","N",  8,0},{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},;
					{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},;
					{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},{"CODANT","C",  7,0},;
					{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
			Otherwise
				aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
					{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
					{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
					{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
					{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
					{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
					{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
					{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
					{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
					{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
					{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
					{"TIPINT","C",  1,0},{"NASVIV","N",  1,0},{"NASMOR","N",  1,0},;
					{"NASVIP","N",  1,0},{"CIDNA1","C",  7,0},{"CIDNA2","C",  7,0},;
					{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
					{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
					{"SENHA" ,"C",  9,0},{"QTDFIL","C",  7,0},{"VLRFIL","N",  8,0},;
					{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},{"SEXO"  ,"C",  1,0},;
					{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},{"GLOSA" ,"N",  8,0},;
					{"CODUSR","C",  3,0},{"CODANT","C",  7,0},{"CODPAD","C",  2,0},;
					{"CHAGUI","C", 25,0}}
			EndCase
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ VerIfica se eh layout proprio...									³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cLayOut == "301" .and. nTamLin > 290
				lLayPro := .T.
			Else
				lLayPro := .F.
			EndIf
			
			cTRB := CriaTrab(aStruc,.T.)
			DbUseArea(.T.,,cTRB,"TRB",.T.)
			DbSelectArea("TRB")
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Copia arquivo da origem para o SigaAdv para usar o AppEnd...		³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FT_FUse()
			nH := FCreate("P:\AP7\TMP\"+cNomArq)
			
			For nLinTmp := 1 to Len(aArqTmp)
				FWrite(nH,aArqTmp[nLinTmp],Len(aArqTmp[nLinTmp]))
			Next
			
			FClose(nH)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Joga arquivo em area de trabalho...                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cArquivo := "P:\AP7\TMP\"+cNomArq
			
			AppEnd From &cArquivo SDF
			
			*/
			
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
±±ºPrograma  |Libera_CNABºAutor  ³Jean Schulz        º Data ³  27/10/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Libera campo personalizado da exportacao CNAB.             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Libera_CNAB(cArqCNAB)
	Local cSQLTmp := ""
	Local aAreaSE1 := SE1->(GetArea())
	
	cSQLTmp := " SELECT R_E_C_N_O_ REGSE1"
	cSQLTmp += " FROM "+RetSQLName("SE1")
	cSQLTmp += " WHERE E1_YTPEXP = 'B' " //CNAB 112 ENVIO - TABELA K1
	cSQLTmp += " AND E1_YAREXPO = '"+cArqCNAB+"' "
	cSQLTmp += " AND D_E_L_E_T_ = ' ' "
	
	PLSQuery(cSQLTmp,"TRBLIB")
	
	While !TRBLIB->(Eof())
		
		SE1->(DbGoTo(TRBLIB->REGSE1))
		If GetNewPar("MV_YFLGBL","N") = "S"
			U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
		EndIf
		SE1->(RecLock("SE1",.F.))
		SE1->E1_YTPEXP	:= "" // CNAB 112 - TABELA K1
		SE1->E1_YTPEDSC	:= ""
		SE1->E1_YAREXPO	:= ""
		SE1->(MsUnlock())
		TRBLIB->(DbSkip())
		
	Enddo
	
	TRBLIB->(DbCloseArea())
	
	RestArea(aAreaSE1)
	
Return

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
	/*
	cSQLFXE := " SELECT TRIM(SUBSTR(VERIfICA_REAJ_FX_ETARIA('"
	cSQLFXE += BA3->BA3_CODINT + "','"
	cSQLFXE += BA3->BA3_CODEMP + "','"
	cSQLFXE += BA3->BA3_MATRIC + "','"
	cSQLFXE += SE1->E1_ANOBASE + "','"
	cSQLFXE += SE1->E1_MESBASE + "'),1,20)) TIPREG "
	cSQLFXE += " FROM DUAL "
	*/
	
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


Local cLinIR 	:= " "
Local cSqlIR 	:= " "
Local a_ObsL 	:= {}
Local nI 		:= 1 //Leonardo Portella - 20/02/15

Local a_AreaBa1 := GetArea("BA1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0¿
//³Supõe que a BA3 já esteja ponteirada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0Ù

cSqlIR := "SELECT CODINT,CODEMP,MATRIC,TIPREG,BA1_NOMUSR, BA1_DATINC,  sum(VALOR) VALOR "
cSqlIR += " FROM   ir_benef_separ_fat  , " + RetSqlName( "BA1" ) + " "
cSqlIR += " WHERE  CODINT = '" + BA3->BA3_CODINT + "' "
cSqlIR += " AND    CODEMP = '" + BA3->BA3_CODEMP + "' "
cSqlIR += " AND    MATRIC = '" + BA3->BA3_MATRIC + "' "
cSqlIR += " AND    ANOBASEIR = 2019 "

cSqlIR += " AND D_E_L_E_T_ = ' ' "
cSqlIR += " AND BA1_FILIAL = ' ' "
cSqlIR += " AND BA1_CODINT = CODINT "
cSqlIR += " AND BA1_CODEMP = CODEMP "
cSqlIR += " AND BA1_MATRIC = MATRIC "
cSqlIR += " AND BA1_TIPREG = TIPREG "

cSqlIR += " GROUP BY CODINT,CODEMP,MATRIC,TIPREG ,BA1_NOMUSR, BA1_DATINC "

cSqlIR += " ORDER BY 4 "

PLSQuery(cSqlIR,"TIR")

cLinIR := ""
  
While !TIR->(EOF())
	If TIR->(VALOR) > 0
		cLinIR += SUBSTR(TIR->BA1_NOMUSR, 1, 19) + " R$" + Transform(TIR->VALOR,"@E 99,999.99") + "; "
		
	endif
	TIR->( dbSkip() )
	
EndDo
If !Empty( cLinIR )
	
	If Val_cpf (BA3->BA3_CODINT+ BA3->BA3_CODEMP+ BA3->BA3_MATRIC )
		
		IF DTOS(POSICIONE("BA1", 1, XFILIAL("BA1") + BA3->BA3_CODINT+ BA3->BA3_CODEMP+ BA3->BA3_MATRIC + 'T', "BA1_DATINC")) < '20190101'
			
			cLinIR := "IR 2019: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
			cLinIR += " -informacoes sobre reembolso disponiveis no site"
			
		ELSE
			
			c_Qry:= " Select BA12.BA1_matric "
			c_Qry+= " from ba1010 ba11 inner join ba1010 ba12 on ba12.ba1_filial = ' '  "
			c_Qry+= "                           and BA12.BA1_CPFUSR = BA11.BA1_CPFUSR "
			c_Qry+= "                            and BA12.BA1_TIPUSU = 'T'       "
			c_Qry+= "                            and BA12.BA1_codemp in ('0001', '0002', '0005')"
			c_Qry+= "                            and BA12.BA1_matric < BA11.BA1_matric  "
			c_Qry+= "                            AND BA12.BA1_DATBLO >= '20190101' "
			c_Qry+= "                            and BA12.D_E_L_E_T_ = ' '   "
			c_Qry+= "	where ba11.ba1_filial = ' ' "
			c_Qry+= "	and ba11.ba1_codint = '" + BA3->BA3_CODINT + "' "
			c_Qry+= "   and ba11.ba1_codemp = '" + BA3->BA3_CODEMP + "' "
			c_Qry+= "   AND BA11.BA1_MATRIC = '" + BA3->BA3_MATRIC + "' "
			c_Qry+= "   and BA11.BA1_TIPUSU = 'T' "
			c_Qry+= "   and ba11.ba1_datinc >= '20190101' "
			c_Qry+= "   and ba11.d_e_l_e_t_ = ' ' "
			
			TCQuery c_Qry Alias "TMPDUPMAT" New
			
			If TMPDUPMAT->( EOF() )
				
				cLinIR := "IR 2019: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
				cLinIR += " -informacoes sobre reembolso disponiveis no site"
				
			Else
				
				cLinIR := "Para obtencao do informe de Imposto de Renda 2019, acesse o site www.caberj.com.br"
				
			EndIf
			
			TMPDUPMAT->( dbCloseArea() )
			
			
		ENDIF
		
		//cLinIR += " As informações sobre reembolso de despesas médicas estão disponíveis no site na área restrita ao associado www.caberj.com.br"
	Else
		
		cLinIR := "Identificamos duplicidade no cadastro de seu CPF em nosso sistema, impedindo a geracao do Informe do IR. Entre em contato para atualizacao cadastral."
		
	EndIf
	
	//Leonardo Portella - 20/02/15 - Inicio - Acertar espacos entre fim de uma linha e espaco de outra, visto que no demonstrativo
	//a ultima letra da da linha superior concatena com a primeira da linha posterior
	
	//a_Observacao := justIficatxt(cLinIR, 100 )
	If len(trim( cLinIR ) ) > 297
		
		cLinIR := "Identificamos duplicidade no cadastro de seu CPF em nosso sistema, impedindo a "
		cLinIR += "geracao do Informe do IR. Entre em contato para atualizacao cadastral"
		
	EndIf
	
	a_Observacao := justIficatxt(cLinIR, 99 )
	
	For nI := 1 to len(a_Observacao)
		a_Observacao[nI] := PadR(a_Observacao[nI],100)
	Next
	
	cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
	cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cLinIR + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
	
	TcSqlExec(cQuery) >= 0
	
	//Leonardo Portella - 20/02/15 - Fim
	
	// 16 + 19 + 3 + 9 + 2 = 49
	// 33
	
Else
	
	//------------------------------------------------------------------------------------------
	// Angelo Henrique - Data: 22/02/2019
	//------------------------------------------------------------------------------------------
	// Vasculhar se o beneficiário não trocou de plano na virada do ano ou algo do tipo
	//------------------------------------------------------------------------------------------
	c_Qry := " SELECT     													 " + c_ent
	c_Qry += "     CODINT,													 " + c_ent
	c_Qry += "     CODEMP,                                                   " + c_ent
	c_Qry += "     MATRIC,                                                   " + c_ent
	c_Qry += "     TIPREG,                                                   " + c_ent
	c_Qry += "     BA12.BA1_NOMUSR,                                          " + c_ent
	c_Qry += "     SUM(VALOR) VALOR                                          " + c_ent
	c_Qry += " FROM                                                          " + c_ent
	c_Qry += "     BA1010 BA11                                               " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     INNER JOIN                                                " + c_ent
	c_Qry += "         BA1010 BA12                                           " + c_ent
	c_Qry += "     ON                                                        " + c_ent
	c_Qry += "         BA12.BA1_FILIAL = ' '                                 " + c_ent
	c_Qry += "         AND BA12.BA1_CPFUSR = BA11.BA1_CPFUSR                 " + c_ent
	c_Qry += "         AND BA12.BA1_TIPUSU = 'T'                             " + c_ent
	c_Qry += "         AND BA12.BA1_CODEMP IN ('0001', '0002', '0005')       " + c_ent
	c_Qry += "         AND BA12.BA1_MATRIC < BA11.BA1_MATRIC                 " + c_ent
	c_Qry += "         AND BA12.BA1_DATBLO BETWEEN '20190101' AND '20191231' " + c_ent
	c_Qry += "         AND BA12.D_E_L_E_T_ = ' '                             " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     INNER JOIN                                                " + c_ent
	c_Qry += "         IR_BENEF_SEPAR_FAT                                    " + c_ent
	c_Qry += "     ON                                                        " + c_ent
	c_Qry += "         CODINT          = BA12.BA1_CODINT                     " + c_ent
	c_Qry += "         AND CODEMP      = BA12.BA1_CODEMP                     " + c_ent
	c_Qry += "         AND MATRIC      = BA12.BA1_MATRIC                     " + c_ent
	c_Qry += "         AND ANOBASEIR   = '2019'                              " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += " WHERE                                                         " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     BA11.BA1_FILIAL = ' ' 	                                 " + c_ent
	c_Qry += "     AND BA11.BA1_CODINT = '" + BA3->BA3_CODINT + "'           " + c_ent
	c_Qry += "     AND BA11.BA1_CODEMP = '" + BA3->BA3_CODEMP + "'			 " + c_ent
	c_Qry += "     AND BA11.BA1_MATRIC = '" + BA3->BA3_MATRIC + "'           " + c_ent
	c_Qry += "     AND BA11.BA1_TIPUSU = 'T'                                 " + c_ent
	c_Qry += "     AND BA11.D_E_L_E_T_ = ' '                                 " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += " GROUP BY                                                      " + c_ent
	c_Qry += "     BA11.BA1_MATRIC,                                          " + c_ent
	c_Qry += "     BA12.BA1_MATRIC,                                          " + c_ent
	c_Qry += "     CODINT,                                                   " + c_ent
	c_Qry += "     CODEMP,                                                   " + c_ent
	c_Qry += "     MATRIC,                                                   " + c_ent
	c_Qry += "     TIPREG,                                                   " + c_ent
	c_Qry += "     BA12.BA1_NOMUSR                                           " + c_ent
	
	PLSQuery(c_Qry,"TAR")
	
	While !TAR->(EOF())
		
		If TAR->(VALOR) > 0
			
			cLinIR := SUBSTR(TAR->BA1_NOMUSR, 1, 19) + " R$" + Transform(TAR->VALOR,"@E 99,999.99") + "; "
			cLinIR := "IR 2019: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
			
		Endif
		
		TAR->( DbSkip() )
		
	EndDo
	
	TAR->(DbCloseArea())
	
	
	a_Observacao := justIficatxt(cLinIR, 99 )
	
	For nI := 1 to len(a_Observacao)
		a_Observacao[nI] := PadR(a_Observacao[nI],100)
	Next
	
	cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
	cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cLinIR + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
	
	TcSqlExec(cQuery) >= 0
	
endif

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
	cQuery :=" SELECT B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC || B1.BA1_TIPREG MATRICULA1 "
	cQuery +="      , B1.BA1_CPFUSR CPF "
	cQuery +="      , B1.BA1_DATNAS     "
	cQuery +="   from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1 "
	cQuery +="  WHERE B1.BA1_FILIAL=' ' "
	cQuery +="    AND B3.BA3_FILIAL = ' '"
	cQuery +="    AND BTS_FILIAL=' ' "
	cQuery +="    AND A1_FILIAL = ' ' "
	cQuery +="    AND B1.D_E_L_E_T_=' '"
	cQuery +="    AND B2.D_E_L_E_T_=' ' "
	cQuery +="    AND B3.D_E_L_E_T_=' ' "
	cQuery +="    AND SA1.D_E_L_E_T_=' ' "
	
	cQuery += "   AND b1.BA1_CPFUSR <> ' '    "
	cQuery += "   AND VAL_CPF(TRIM(b1.BA1_CPFUSR)) = 1   "
	
	cQuery +="    AND IDADE_S(TRIM(B1.BA1_DATNAS),'20191231') < 0 "
	cQuery +="    AND B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC = '" + cFamilia + "'" // &PARAM
	cQuery +="    AND BA1_MATVID=BTS_MATVID AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO> TO_CHAR (SYSDATE,'yyyymmdd'))  "
	cQuery +="    AND B1.BA1_CODINT = B3.BA3_CODINT AND B1.BA1_CODEMP = B3.BA3_CODEMP AND B1.BA1_MATRIC = B3.BA3_MATRIC AND BA3_CODCLI = A1_COD  "
	cQuery +="    AND B1.BA1_CPFUSR IN (SELECT BA1_CPFUSR FROM  BA1010 B1 WHERE B1.BA1_FILIAL=' ' AND B1.D_E_L_E_T_=' '  "
	cQuery +="    						AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO > TO_CHAR (SYSDATE,'yyyymmdd')) AND B1.BA1_CPFUSR<>' ' "
	cQuery +="    						AND IDADE_S(TRIM(B1.BA1_DATNAS),'20191231') < 0 "
	cQuery +="    						AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009') GROUP BY BA1_CPFUSR HAVING COUNT(*)>1 )  "
	cQuery +="    AND B1.BA1_CPFUSR<>' ' AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009')  "
	cQuery +="  ORDER BY  2,1"
	
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
Static Function VerAdp( c_CodEmp, c_Matric )
	
	Local l_Ret := .F.
	**'Marcela Coimbra 17/04/2018 - Alteração da regra conforme chamado GLPI 48772'**
	/*
	c_Qry:= "SELECT E1_NUM "
	c_Qry+= " FROM " + RETSQLNAME("SE1") + " "
	c_Qry+= " WHERE E1_FILIAL = '" + xFilial("SE1") + "' "
	c_Qry+= " AND E1_cliente = '" + c_Cliente + "' "
	c_Qry+= " AND E1_vencrea >= '20160101' "
	c_Qry+= " AND E1_vencrea <= '20161231' "
	c_Qry+= " AND E1_SALDO > 0 "
	c_Qry+= " AND E1_TIPO NOT IN ('RA') "
	c_Qry+= " AND D_E_L_E_T_ <> '*' "
	*/
	/*
	c_Qry := " Select  DISTINCT ba1_cpfusr CPF_TITULAR, "
	c_Qry += "         BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG MATRICULA, "
	c_Qry += "         BA1_NOMUSR NOME, "
	c_Qry += "         TO_DATE(TRIM(BA1_DATINC), 'YYYYMMDD') INCLUSAO, "
	c_Qry += "         TO_DATE(TRIM(BA1_DATBLO), 'YYYYMMDD') BLOQUEIO "
	c_Qry += " from ba1010 ba1 inner join ba3010 ba3 on ba3_filial = ' ' "
	c_Qry += "                             and ba3_codint = ba1_codint "
	c_Qry += "                             and ba3_codemp = ba1_codemp "
	c_Qry += "                             and ba3_matric = ba1_Matric "
	c_Qry += "                             and BA3.D_E_L_E_T_ = ' ' "
	c_Qry += " where ba3_filial = ' ' "
	c_Qry += " and ba3_codint = '0001' "
	c_Qry += " and ba3_codemp = '" + c_CodEmp + "' "
	c_Qry += " and ba3_matric = '" + c_Matric + "' "
	c_Qry += " and (ba1_datblo = ' ' or ba1_datblo >= '20180401') "
	c_Qry += " and BA1.D_E_L_E_T_ = ' ' "
	c_Qry += " and ba1_cpfusr <> ' ' "
	c_Qry += " AND ba1_cpfusr NOT IN ( select * from cpf_quitacao ) "
	
	c_Qry += "                     SELECT DISTINCT BA1.ba1_cpfusr "
	c_Qry += "                     FROM SE1010 SE1DP INNER JOIN SE1010 SE1FT ON SE1FT.E1_FILIAL = '01' "
	c_Qry += "                                               AND SE1FT.E1_NUM = SE1DP.E1_FATURA "
	c_Qry += "                                               AND SE1FT.D_E_L_E_T_ = ' ' "
	c_Qry += "                   INNER JOIN BM1010 BM1 ON BM1_FILIAL = ' '  "
	c_Qry += "                                       AND BM1_PREFIX = SE1DP.E1_PREFIXO "
	c_Qry += "                                       AND BM1_NUMTIT = SE1DP.E1_NUM "
	c_Qry += "                                       AND BM1.D_E_L_E_T_ = ' ' "
	
	c_Qry += "                   INNER JOIN BA1010 BA1 ON BA1.BA1_FILIAL = ' ' "
	c_Qry += "                                       AND BA1.BA1_CODINT = BM1_CODINT "
	c_Qry += "                                       AND BA1.BA1_CODEMP = BM1_CODEMP "
	c_Qry += "                                       AND BA1.BA1_MATRIC = BM1_MATRIC "
	c_Qry += "                                       AND BA1.BA1_TIPREG = '00'      "
	c_Qry += "                                       AND BA1.D_E_L_E_T_ = ' ' "
	c_Qry += " WHERE SE1DP.E1_FILIAL = '01' "
	c_Qry += "       AND SE1DP.E1_VENCREA BETWEEN '20170101' AND '20171231' "
	
	c_Qry += "       AND SE1DP.E1_SALDO = 0 "
	c_Qry += "       AND SE1FT.E1_SALDO <> 0 "
	c_Qry += "       AND SE1DP.E1_TIPO = 'DP' "
	c_Qry += "       AND SE1DP.D_E_L_E_T_ = ' ' "
	
	c_Qry += "       AND EXISTS (  SELECT * "
	c_Qry += "                     FROM SE5010 SE5  "
	c_Qry += "                     WHERE E5_FILIAL = '01' "
	c_Qry += "                             AND E5_PREFIXO = SE1DP.E1_PREFIXO "
	c_Qry += "                             AND E5_NUMERO  = SE1DP.E1_NUM "
	c_Qry += "                             AND E5_PARCELA = SE1DP.E1_PARCELA "
	c_Qry += "                             AND E5_MOTBX IN ('FAT')  "
	c_Qry += "                             AND SE5.D_E_L_E_T_ = ' '  "
	c_Qry += "                             AND NOT EXISTS (  SELECT *  "
	c_Qry += "                                           FROM SE5010 SE51  "
	c_Qry += "                                           WHERE SE51.E5_FILIAL =  '01' "
	c_Qry += "                                                 AND SE51.D_E_L_E_T_ = ' ' "
	c_Qry += "                                                 AND se5.E5_PREFIXO = se51.e5_PREFIXO "
	c_Qry += "                                                 AND se51.E5_NUMERO = se5.E5_NUMERO  "
	c_Qry += "                                                 and se51.e5_tipo = se5.e5_tipo  "
	c_Qry += "                                                 and se51.e5_seq = se5.e5_seq  "
	c_Qry += "                                                 AND se51.E5_CLIFOR  = se5.E5_CLIFOR  "
	c_Qry += "                                                 and (SE51.e5_tipodoc = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C')  "
	c_Qry += "                                           ))  "
	
	c_Qry += " union	 "
	
	
	c_Qry += " SELECT DISTINCT ba1_cpfusr "
	c_Qry += " FROM SE1010 SE1DP INNER JOIN BM1010 BM1 ON BM1_FILIAL = ' '  "
	c_Qry += "                                       AND BM1_PREFIX = SE1DP.E1_PREFIXO "
	c_Qry += "                                       AND BM1_NUMTIT = SE1DP.E1_NUM "
	c_Qry += "                                       AND BM1.D_E_L_E_T_ = ' ' "
	
	c_Qry += "                   INNER JOIN BA1010 ON BA1_FILIAL = ' ' "
	c_Qry += "                                       AND BA1_CODINT = BM1_CODINT "
	c_Qry += "                                       AND BA1_CODEMP = BM1_CODEMP "
	c_Qry += "                                       AND BA1_MATRIC = BM1_MATRIC "
	c_Qry += "                                       AND BA1_TIPREG = '00' "
	
	c_Qry += " WHERE SE1DP.E1_FILIAL = '01' "
	c_Qry += "       AND SE1DP.E1_VENCREA BETWEEN '20170101' AND '20171231'     "
	c_Qry += "       AND SE1DP.E1_PREFIXO = 'PLS'     "
	c_Qry += "       AND E1_CODEMP IN ('0001', '0002', '0005') "
	c_Qry += "       AND SE1DP.E1_SALDO <> 0     "
	c_Qry += "       AND SE1DP.E1_TIPO = 'DP' "
	
	c_Qry += "       AND SE1DP.D_E_L_E_T_ = ' '  ) "
	*/
	
	c_Qry := " SELECT * "
	c_Qry += " FROM MATRICULA_QUITACAO"
	c_Qry += " WHERE codint = '0001' "
	c_Qry += " and codemp = '" + c_CodEmp + "' "
	c_Qry += " and matric = '" + c_Matric + "' "
	c_Qry += " and tipreg = '00' "
	
	PLSQuery(c_Qry, "QRYAD")
	
	If !(QRYAD->( eof() ))
		
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
		
		/*
		Do Case
			
		Case BA3->BA3_INDREA == '000047' //BA3->BA3_XGRPR == "0042"
			
			c_Ret := " 18,81%"
			
		Case BA3->BA3_INDREA == '000048'
			
			c_Ret := " 13,35%"
			
		Case BA3->BA3_INDREA == '000049'
			
			c_Ret := " 13,15%"
			
		EndCase
		*/
		
		DbSelectArea("AAE")
		DbSetOrder(1) //AAE_FILIAL+AAE_CODIND+DTOS(AAE_DATA)
		If DbSeek(xFilial("AAE") + BA3->BA3_INDREA)
			
			c_Ret := cValToChar(AAE->AAE_INDICE) + " %"
			
		EndIf
		
	EndIf
	
	RestArea(a_Area)
	
Return c_Ret