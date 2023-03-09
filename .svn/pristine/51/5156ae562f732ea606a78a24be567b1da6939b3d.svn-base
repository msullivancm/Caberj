#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CABR016 ³ Autor ³ Luzio Tavares          ³ Data ³ 07.02.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio dos grupo empresas/contratos/sub-contratos que   ³±±±
±±³          | possuem cartao de identificacao com vencimento dentro do   ³±±±
±±³          | periodo informado.                                         ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ CABR016()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ CABERJ                                                     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR016()

	Private nQtdLin     := 58
	Private cNomeProg   := "CABR016"
	Private nLimite     := 132
	Private cTamanho    := "G"
	//Private cTitulo     := "Empresas com renovacao de carteiras no periodo"
	Private cTitulo     := "Previsao de impressao de cartoes"
	Private cDesc1      := "Empresas com renovacao de carteiras no periodo"
	Private cDesc2      := ""
	Private cDesc3      := ""
	Private cAlias      := "BA1"
	Private cPerg       := "CABR01"
	Private cRel        := "CABR016"
	Private nLi         := nQtdLin+1
	Private m_pag       := 1
	Private lCompres    := .F.
	Private lDicion     := .F.
	Private lFiltro     := .F. //.T.
	Private lCrystal    := .F.
	Private aOrderns    := {"Grupo/Empresa + Produto","Produto + Grupo/Empresa"} 
	Private aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
	//Private aReturn     := { "", 1,"", 1, 1, 1, "",1 } 
	Private lAbortPrint := .F.
	Private cCabec1     := "Grupo/Empresa    Quant." 
	Private cCabec2     := ""
	PRIVATE nColuna     := 1 
	Private dData1
	Private dData2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Dados do parametro...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private nTipPes     // (PF;PJ;Ambos)
	Private nTipo       // (Sintetico;Analitico)
	Private nResumo     // Imprime Resumo
	Private cOpeDe      // Codigo da Operadora de
	Private cGrupoDe    // Codigo do Grupo/Empresa de
	Private cGrupoAte   // Codigo do Grupo/Empresa ate
	Private cContrDe    // Codigo do Contrato de
	Private cContrAte   // Codigo do Contrato ate
	Private cSbConDe    // Codigo do Sub-contrato de
	Private cSbConAte   // Codigo do Sub-contrato ate
	Private dDatIni     // Data de referencia
	Private dDatFim     // Data de referencia

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa ambiente do relatorio somente top...                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! PLSRelTop()
		Return
	Endif    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta perguntas                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ValidPerg(cPerg)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa parametros do relatorio...                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama SetPrint                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

	//nTipo:=IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM"))
	nTipo := IIF(aReturn[4]==1,15,18)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a operacao                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLastKey  == 27
		Return
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Configura impressora                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault(aReturn,cAlias)

	//cCabec2   := "Periodo de : "+MV_PAR02 +" a "+MV_PAR03
	cTitulo     := "Previsao de impressao de cartoes" // no periodo de: "+dtoc(MV_PAR02) +" a "+dtoc(MV_PAR03)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite relat¢rio                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Processa({||CABR016Imp()}, cTitulo)
	//MsAguarde({|| CABR016Imp() }, cTitulo, "", .T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CABR016Imp  ³ Autor ³ Luzio Tavares      ³ Data ³ 07.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Emite relatorio das empresas que tem cartao a ser renovados³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function CABR016Imp()

	Local n 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local n_aImp 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cLinha		:= ""
	Local cDesCom		:= ""
	Local cDesPer1		:= ""
	Local cDesPer2		:= ""
	Local cSql			:= ""
	Local cArqTmp		:= ""
	Local cIndTmp		:= ""
	Local cEmpAnt		:= ""
	Local cEstCob   	:= ""
	Local nCont			:= 0
	Local nI		    := 0
	Local nPos		 	:= 0
	Local nTotal	 	:= 0
	Local nJ		    := 0
	Local nTotLin	 	:= 0
	Local nLin		 	:= 0
	Local aResp		 	:= {}
	Local aLin		 	:= {}
	Local aResumo	 	:= {}
	Local cConAnt   	:= ""
	Local cSubAnt   	:= ""
	Local nTotSub   	:= 0
	Local cGrpEmpIE 	:= GetNewPar("MV_PLSGEIN","0050")
	Local nOrdSel   	:= aReturn[8] 
	Local nQtd      	:= 0
	Local aPonto    	:= {}
	Local nCol      	:= 0     
	Local aCabec := {}
	Local aDados := {} 

	Local aImp 			:= {}

	ProcRegua(0)

	For nI := 1 to 5
		IncProc("Processando...")
	Next

	DbSelectArea("BPX")//Motivos de emissao da carteira
	DbSetOrder(1)  
	BPX->(dbGotop()) 

	nColuna := 62

	While ! BPX->(Eof())

		AADD( aPonto, {BPX->BPX_MOTIVO,BPX_DESCRI,nColuna,0})
		AADD( aImp	, {BPX->BPX_MOTIVO, 0} )

		nColuna := nColuna + 6
		DbSelectArea("BPX")
		DbSkip()
	End

	If Len(aPonto) == 0
		If  aReturn[5] == 1
			Set Printer To
			Commit
			Ourspool(cRel)
		Endif
		MS_FLUSH()             // Libera fila de relatorios em spool

		Aviso( cTitulo, "Nao existem motivos de emissao de cartao cadastrados", {"Ok"} )
		Return
	EndIf       

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³BQC -> SUBCONTRATO      ³
	//³BG9 -> GRUPOS EMPRESAS  ³
	//³BI3 -> PRODUTOS DE SAUDE³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	// Seleciona os beneficiarios que possuem vencimento de cartao no periodo informado no parametro
	cSQL := " SELECT '3' as MOTIVO, BA1_DTVLCR, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON,BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG," + CRLF
	cSQL += " 			BA1_DIGITO, BA1_NOMUSR, BA1_CODPLA, BA1_VERSAO, BA1_DATCAR, BA1_VIACAR, BA1_OPERES,BQC_DATCON, BQC_VALID, BG9_DESCRI," 	+ CRLF 
	cSQL += " 			BI3_DESCRI, BA3_CODPLA, BA3_VERSAO "																					+ CRLF
	cSQL += " FROM " + RetSQLName("BA1") + " BA1, " + RetSQLName("BA3") +" BA3, "+ RetSQLName("BTS") + " BTS," 								+ CRLF
	cSQL += RetSQLName("BQC") + " BQC, "+ RetSQLName("BG9") + " BG9, "+ RetSQLName("BI3") + " BI3 "											+ CRLF
	cSQL += " WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND " 																			+ CRLF
	cSQL += " BA3.BA3_FILIAL = '" + xFilial("BA3") + "' AND "																					+ CRLF
	cSQL += " BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "																					+ CRLF
	cSQL += " BQC.BQC_FILIAL = '" + xFilial("BQC") + "' AND "																					+ CRLF
	cSQL += " BG9.BG9_FILIAL = '" + xFilial("BG9") + "' AND "																					+ CRLF
	cSQL += " BA1.BA1_CODINT = '" + MV_PAR01 + "' AND "																							+ CRLF
	cSQL += " BA1.BA1_CODEMP >= '"+ MV_PAR04 + "' AND BA1.BA1_CODEMP <= '"+ MV_PAR05 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CONEMP >= '"+ MV_PAR06 + "' AND BA1.BA1_CONEMP <= '"+ MV_PAR07 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_SUBCON >= '"+ MV_PAR08 + "' AND BA1.BA1_SUBCON <= '"+ MV_PAR09 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CODPLA >= '"+ MV_PAR12 + "' AND BA1.BA1_CODPLA <= '"+ MV_PAR13 +"' AND "													+ CRLF

	If !Empty(MV_PAR02) .and. !Empty(MV_PAR03)
	
		//Data de validade da carteira
		cSQL +=  " BA1.BA1_DTVLCR >= '" + DtoS(MV_PAR02) + "' AND BA1.BA1_DTVLCR <= '" + DtoS(MV_PAR03) + "' AND "								+ CRLF
		
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de contratacao (PF/PJ)...					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If MV_PAR14 <> 3 
		//Tipo de contrato -> 1=Pessoa Fisica;2=Pessoa Juridica                                                                                               
		cSQL += " BA3.BA3_TIPOUS = '" + alltrim(Str(MV_PAR14)) + "' AND " 																		+ CRLF
	Endif

	//If MV_PAR16 = 1
	//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	//³ Filtra Somente o Grupo Empresa de Intercambio...			³
	//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	cSQL += " BA1.BA1_CODEMP = '" + cGrpEmpIE + "' AND "
	//Endif

	//cSQL += " BA1.BA1_VIACAR <> 0 AND "  // Somente para 1a. via de cartao

	//Emitir cartao -> 0=Nunca Emitir;1=Cad. Alterado;2=Cartao Preparado;3=Cartao Gerado                                                               
	cSQL += " BA1.BA1_EMICAR = ' ' AND " 																										+ CRLF

	//indica que nao deve gerar cartao para este subcontrato
	//Emitir cartao magnetico -> 1=Sim;0=Nao                                                                                                                     
	cSQL += " BQC.BQC_EMICAR <> '0' AND " 																										+ CRLF  

	cSQL += " BA3.BA3_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BA3.BA3_CODEMP = BA1.BA1_CODEMP AND "																								+ CRLF
	cSQL += " BA3.BA3_MATRIC = BA1.BA1_MATRIC AND "																								+ CRLF
	cSQL += " BTS.BTS_MATVID = BA1.BA1_MATVID AND "																								+ CRLF
	cSQL += " BG9.BG9_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BG9.BG9_CODIGO = BA1.BA1_CODEMP AND "																								+ CRLF
	//cSQL += " BI3.BI3_CODIGO = BA1.BA1_CODPLA AND "
	//cSQL += " BI3.BI3_VERSAO = BA1.BA1_VERSAO AND "
	//Considera  plano da familia, uma vez que o usuario pode nao ter o plano cadastro
	cSQL += " BI3.BI3_CODIGO = BA3.BA3_CODPLA AND "																								+ CRLF
	cSQL += " BI3.BI3_VERSAO = BA3.BA3_VERSAO AND "																								+ CRLF
	cSQL += " BQC.BQC_FILIAL = BA1.BA1_FILIAL AND "																								+ CRLF
	cSQL += " BQC.BQC_CODIGO = BA1.BA1_CODINT||BA1.BA1_CODEMP AND "																				+ CRLF
	cSQL += " BQC.BQC_NUMCON = BA1.BA1_CONEMP AND "																								+ CRLF
	cSQL += " BQC.BQC_VERCON = BA1.BA1_VERCON AND "																								+ CRLF
	cSQL += " BQC.BQC_SUBCON = BA1.BA1_SUBCON AND "																								+ CRLF
	cSQL += " BQC.BQC_VERSUB = BA1.BA1_VERSUB AND "																								+ CRLF
	cSQL += " BA3.BA3_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.BA1_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BA3.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BQC.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BTS.D_E_L_E_T_ <> '*' "																											+ CRLF                   

	cSQL += " UNION " 																															+ CRLF                  

	// Seleciona os beneficiarios que terao a emissao das 1a. via de cartao no periodo
	cSQL += " SELECT '4' as MOTIVO, BA1_DTVLCR, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG,"+ CRLF
	cSQL += " 		BA1_DIGITO, BA1_NOMUSR, BA1_CODPLA, BA1_VERSAO, BA1_DATCAR, BA1_VIACAR, BA1_OPERES, BQC_DATCON, BQC_VALID, BG9_DESCRI, "	+ CRLF
	cSQL += " 		BI3_DESCRI, BA3_CODPLA, BA3_VERSAO "																						+ CRLF
	cSQL += " FROM " + RetSQLName("BA1") + " BA1, " + RetSQLName("BA3") +" BA3, "+ RetSQLName("BTS") + " BTS, "								+ CRLF
	cSQL += RetSQLName("BQC") + " BQC, "+ RetSQLName("BG9") + " BG9, "+ RetSQLName("BI3") + " BI3 "											+ CRLF
	cSQL += " WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "																				+ CRLF
	cSQL += " BA3.BA3_FILIAL = '" + xFilial("BA3") + "' AND "																					+ CRLF
	cSQL += " BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "																					+ CRLF
	cSQL += " BQC.BQC_FILIAL = '" + xFilial("BQC") + "' AND "																					+ CRLF
	cSQL += " BG9.BG9_FILIAL = '" + xFilial("BG9") + "' AND "																					+ CRLF
	cSQL += " BA1.BA1_CODINT = '" + MV_PAR01 + "' AND "																							+ CRLF
	cSQL += " BA1.BA1_CODEMP >= '"+ MV_PAR04 + "' AND BA1.BA1_CODEMP <= '"+ MV_PAR05 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CONEMP >= '"+ MV_PAR06 + "' AND BA1.BA1_CONEMP <= '"+ MV_PAR07 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_SUBCON >= '"+ MV_PAR08 + "' AND BA1.BA1_SUBCON <= '"+ MV_PAR09 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CODPLA >= '"+ MV_PAR12 + "' AND BA1.BA1_CODPLA <= '"+ MV_PAR13 +"' AND "													+ CRLF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de contratacao (PF/PJ)...					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If MV_PAR14 <> 3
		//Tipo de contrato -> 1=Pessoa Fisica;2=Pessoa Juridica                                                                                               
		cSQL += " BA3.BA3_TIPOUS = '" + alltrim(Str(MV_PAR14)) + "' AND "																		+ CRLF
	Endif

	//If MV_PAR16 = 1
	//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	//³ Filtra Somente o Grupo Empresa de Intercambio...				 ³
	//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	cSQL += " BA1.BA1_CODEMP = '" + cGrpEmpIE + "' AND "
	//Endif

	//Data do Bloqueio         
	cSQL += " BA1.BA1_DATBLO = '       ' AND " 																									+ CRLF

	// Somente para 1a. via de cartao (Numero de Via da Carteira)
	cSQL += " BA1.BA1_VIACAR = 0 AND "  
	//cSQL += " BA1.BA1_EMICAR = '0' AND "

	//indica que nao deve gerar cartao para este subcontrato (Emitir Cartao Magnetico? 1=Sim;0=Nao)
	cSQL += " BQC.BQC_EMICAR <> '0' AND " 																										+ CRLF   

	cSQL += " BA3.BA3_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BA3.BA3_CODEMP = BA1.BA1_CODEMP AND "																								+ CRLF
	cSQL += " BA3.BA3_MATRIC = BA1.BA1_MATRIC AND "																								+ CRLF
	cSQL += " BTS.BTS_MATVID = BA1.BA1_MATVID AND "																								+ CRLF
	cSQL += " BG9.BG9_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BG9.BG9_CODIGO = BA1.BA1_CODEMP AND "																								+ CRLF
	//cSQL += " BI3.BI3_CODIGO = BA1.BA1_CODPLA AND "
	//cSQL += " BI3.BI3_VERSAO = BA1.BA1_VERSAO AND "

	//Considera  plano da familia, uma vez que o usuario pode nao ter o plano cadastro
	cSQL += " BI3.BI3_CODIGO = BA3.BA3_CODPLA AND "																								+ CRLF
	cSQL += " BI3.BI3_VERSAO = BA3.BA3_VERSAO AND "																								+ CRLF
	cSQL += " BQC.BQC_FILIAL = BA1.BA1_FILIAL AND "																								+ CRLF
	cSQL += " BQC.BQC_CODIGO = BA1.BA1_CODINT||BA1.BA1_CODEMP AND "																				+ CRLF
	cSQL += " BQC.BQC_NUMCON = BA1.BA1_CONEMP AND "																								+ CRLF
	cSQL += " BQC.BQC_VERCON = BA1.BA1_VERCON AND "																								+ CRLF
	cSQL += " BQC.BQC_SUBCON = BA1.BA1_SUBCON AND "																								+ CRLF
	cSQL += " BQC.BQC_VERSUB = BA1.BA1_VERSUB AND "																								+ CRLF
	cSQL += " BA3.BA3_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BA3.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BQC.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BTS.D_E_L_E_T_ <> '*' AND "                   																					+ CRLF
	cSQL += " TRIM(ba1_codint || ba1_codemp || ba1_matric || ba1_tipreg || ba1_digito) NOT IN (SELECT TRIM(bed_codint || bed_codemp || bed_matric || bed_tipreg || bed_digito) "+ CRLF
	cSQL += " FROM " + RetSQLName("BED") + " BED "																								+ CRLF
	cSQL += " WHERE bed.bed_filial = '" + xFilial("BED") + "' AND "																				+ CRLF
	cSQL += " BED.d_e_l_e_t_ <> '*' AND "																										+ CRLF
	cSQL += " BED.bed_codint = ba1.ba1_codint AND "																								+ CRLF
	cSQL += " bed.bed_codemp = ba1.ba1_codemp AND "																								+ CRLF
	cSQL += " bed.bed_matric = ba1.ba1_matric AND "																								+ CRLF
	cSQL += " bed.bed_tipreg = ba1.ba1_tipreg AND "																								+ CRLF

	//Status da emissao -> 1=Em aberto;2=Encerrado        
	cSQL += " bed.bed_stacar <> '2' AND "																										+ CRLF

	//Bloqueada? 1=Sim;0=Nao 
	cSQL += " (bed.bed_bloide = '0' OR bed.bed_bloide = ' '))"																					+ CRLF

	cSQL += " UNION "                   																										+ CRLF

	// Seleciona os beneficiarios que possuem alteracao cadastral identificada no cadastro
	cSQL += " SELECT '6' as MOTIVO, BA1_DTVLCR, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC,BA1_TIPREG,"	+ CRLF
	cSQL += " BA1_DIGITO, BA1_NOMUSR, BA1_CODPLA, BA1_VERSAO, BA1_DATCAR, BA1_VIACAR, BA1_OPERES, BQC_DATCON, BQC_VALID, BG9_DESCRI, " 			+ CRLF
	cSQL += " BI3_DESCRI, BA3_CODPLA, BA3_VERSAO "																								+ CRLF
	cSQL += " FROM " + RetSQLName("BA1") + " BA1, " + RetSQLName("BA3") +" BA3, "+ RetSQLName("BTS") + " BTS, "								+ CRLF
	cSQL += RetSQLName("BQC") + " BQC, "+ RetSQLName("BG9") + " BG9, "+ RetSQLName("BI3") + " BI3 "											+ CRLF
	cSQL += " WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "																				+ CRLF
	cSQL += " BA3.BA3_FILIAL = '" + xFilial("BA3") + "' AND "																					+ CRLF
	cSQL += " BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "																					+ CRLF
	cSQL += " BQC.BQC_FILIAL = '" + xFilial("BQC") + "' AND "																					+ CRLF
	cSQL += " BG9.BG9_FILIAL = '" + xFilial("BG9") + "' AND "																					+ CRLF
	cSQL += " BA1.BA1_CODINT = '" + MV_PAR01 + "' AND "																							+ CRLF
	cSQL += " BA1.BA1_CODEMP >= '"+ MV_PAR04 + "' AND BA1.BA1_CODEMP <= '"+ MV_PAR05 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CONEMP >= '"+ MV_PAR06 + "' AND BA1.BA1_CONEMP <= '"+ MV_PAR07 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_SUBCON >= '"+ MV_PAR08 + "' AND BA1.BA1_SUBCON <= '"+ MV_PAR09 +"' AND "													+ CRLF
	cSQL += " BA1.BA1_CODPLA >= '"+ MV_PAR12 + "' AND BA1.BA1_CODPLA <= '"+ MV_PAR13 +"' AND "													+ CRLF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de contratacao (PF/PJ)...					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If MV_PAR14 <> 3
		//Tipo de contrato -> 1=Pessoa Fisica;2=Pessoa Juridica    
		cSQL += " BA3.BA3_TIPOUS = '" + alltrim(Str(MV_PAR14)) + "' AND " 																		+ CRLF
	Endif

	//If MV_PAR16 = 1
	//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	//³ Filtra Somente o Grupo Empresa de Intercambio...				 ³
	//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	cSQL += " BA1.BA1_CODEMP = '" + cGrpEmpIE + "' AND "
	//Endif

	cSQL += " BA1.BA1_EMICAR = '1' AND "																										+ CRLF

	//indica que nao deve gerar cartao para este subcontrato (Emitir Cartao Magnetico? 1=Sim;0=Nao)
	cSQL += " BQC.BQC_EMICAR <> '0' AND " 																										+ CRLF
	cSQL += " BA3.BA3_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BA3.BA3_CODEMP = BA1.BA1_CODEMP AND "																								+ CRLF
	cSQL += " BA3.BA3_MATRIC = BA1.BA1_MATRIC AND "																								+ CRLF
	cSQL += " BTS.BTS_MATVID = BA1.BA1_MATVID AND "																								+ CRLF
	cSQL += " BG9.BG9_CODINT = BA1.BA1_CODINT AND "																								+ CRLF
	cSQL += " BG9.BG9_CODIGO = BA1.BA1_CODEMP AND "																								+ CRLF
	//cSQL += " BI3.BI3_CODIGO = BA1.BA1_CODPLA AND "
	//cSQL += " BI3.BI3_VERSAO = BA1.BA1_VERSAO AND "
	//Considera  plano da familia, uma vez que o usuario pode nao ter o plano cadastro
	cSQL += " BI3.BI3_CODIGO = BA3.BA3_CODPLA AND "																								+ CRLF
	cSQL += " BI3.BI3_VERSAO = BA3.BA3_VERSAO AND "																								+ CRLF
	cSQL += " BQC.BQC_FILIAL = BA1.BA1_FILIAL AND "																								+ CRLF
	cSQL += " BQC.BQC_CODIGO = BA1.BA1_CODINT||BA1.BA1_CODEMP AND "																				+ CRLF
	cSQL += " BQC.BQC_NUMCON = BA1.BA1_CONEMP AND "																								+ CRLF
	cSQL += " BQC.BQC_VERCON = BA1.BA1_VERCON AND "																								+ CRLF
	cSQL += " BQC.BQC_SUBCON = BA1.BA1_SUBCON AND "																								+ CRLF
	cSQL += " BQC.BQC_VERSUB = BA1.BA1_VERSUB AND "																								+ CRLF
	cSQL += " BA3.BA3_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.BA1_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BA3.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BQC.D_E_L_E_T_ <> '*' AND "																										+ CRLF
	cSQL += " BTS.D_E_L_E_T_ <> '*' "                   																						+ CRLF

	cSQL += " UNION "                   																										+ CRLF

	// Seleciona os beneficiarios que possuem solicitacao de novas vias de cartao cadastradas no cadastro BED (COBRANCAS VIAS DE CARTEIRINHAS) e que nao 
	// foram encerradas
	cSQL += " SELECT BED.BED_MOTIVO as MOTIVO, ba1_dtvlcr, ba1_codint, ba1_codemp, ba1_conemp, ba1_vercon, "									+ CRLF
	cSQL += " ba1_subcon, ba1_versub, ba1_matric, ba1_tipreg, ba1_digito, "																		+ CRLF
	cSQL += " ba1_nomusr, ba1_codpla, ba1_versao, ba1_datcar, ba1_viacar, ba1_operes, "															+ CRLF
	cSQL += " bqc_datcon, bqc_valid, bg9_descri, bi3_descri, BA3_CODPLA, BA3_VERSAO "															+ CRLF
	cSQL += " FROM " + RetSQLName("BA1") + " BA1, " + RetSQLName("BA3") +" BA3, "+ RetSQLName("BTS") + " BTS, "								+ CRLF
	cSQL += RetSQLName("BQC") + " BQC, "+ RetSQLName("BG9") + " BG9, "+ RetSQLName("BI3") + " BI3, "+ RetSQLName("BED") + " BED "				+ CRLF
	cSQL += " WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "																				+ CRLF
	cSQL += " BA3.BA3_FILIAL = '" + xFilial("BA3") + "' AND "																					+ CRLF
	cSQL += " BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "																					+ CRLF
	cSQL += " BQC.BQC_FILIAL = '" + xFilial("BQC") + "' AND "																					+ CRLF
	cSQL += " BG9.BG9_FILIAL = '" + xFilial("BG9") + "' AND "																					+ CRLF
	cSQL += " BED.BED_FILIAL = '" + xFilial("BED") + "' AND "																					+ CRLF
	cSQL += " BED.BED_CODINT = '" + MV_PAR01 + "' AND "																							+ CRLF
	cSQL += " BED.BED_CODEMP >= '"+ MV_PAR04 + "' AND BED.BED_CODEMP <= '"+ MV_PAR05 +"' AND "													+ CRLF
	cSQL += " BED.BED_CONEMP >= '"+ MV_PAR06 + "' AND BED.BED_CONEMP <= '"+ MV_PAR07 +"' AND "													+ CRLF
	cSQL += " BED.BED_SUBCON >= '"+ MV_PAR08 + "' AND BED.BED_SUBCON <= '"+ MV_PAR09 +"' AND "													+ CRLF

	If !Empty(MV_PAR02) .and. !Empty(MV_PAR03) 
		//Data Solicitacao
		cSQL +=  " BED.BED_DTSOLI >= '" + DtoS(MV_PAR02) + "' AND BED.BED_DTSOLI <= '" + DtoS(MV_PAR03) + "' AND "								+ CRLF
	Endif
	
	//cSQL += " bed.bed_numcob = 'AVULSA' AND "

	//Cd Expor/Emiss Identif.
	cSQL += " bed.bed_cdiden = 'AVULSA' AND "																									+ CRLF

	//Status da emissao -> 1=Em aberto;2=Encerrado        
	cSQL += " bed.bed_stacar <> '2' AND "																										+ CRLF

	//Bloqueada? 1=Sim;0=Nao 
	cSQL += " (bed.bed_bloide = '0' OR bed.bed_bloide = ' ' ) AND "																				+ CRLF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de contratacao (PF/PJ)...					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If MV_PAR14 <> 3
		//Tipo de contrato -> 1=Pessoa Fisica;2=Pessoa Juridica    
		cSQL += " BA3.BA3_TIPOUS = '" + alltrim(Str(MV_PAR14)) + "' AND "																		+ CRLF
	Endif

	//If MV_PAR16 = 1
	//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	//³ Filtra Somente o Grupo Empresa de Intercambio...			³
	//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	cSQL += " BA1.BA1_CODEMP = '" + cGrpEmpIE + "' AND "
	//Endif

	//indica que nao deve gerar cartao para este subcontrato (Emitir Cartao Magnetico? 1=Sim;0=Nao)
	cSQL += " BQC.BQC_EMICAR <> '0' AND " 																										+ CRLF  
	cSQL += " ba1.ba1_codint = bed.bed_codint AND "																								+ CRLF
	cSQL += " ba1.ba1_codemp = bed.bed_codemp AND "																								+ CRLF
	cSQL += " ba1.ba1_matric = bed.bed_matric AND "																								+ CRLF
	cSQL += " ba1.ba1_tipreg = bed.bed_tipreg AND "																								+ CRLF
	cSQL += " ba3.ba3_codint = ba1.ba1_codint AND "																								+ CRLF
	cSQL += " ba3.ba3_codemp = ba1.ba1_codemp AND "																								+ CRLF
	cSQL += " ba3.ba3_matric = ba1.ba1_matric AND "																								+ CRLF
	cSQL += " bts.bts_matvid = ba1.ba1_matvid AND "																								+ CRLF
	cSQL += " bg9.bg9_codint = ba1.ba1_codint AND "																								+ CRLF
	cSQL += " bg9.bg9_codigo = ba1.ba1_codemp AND "																								+ CRLF
	//cSQL += " bi3.bi3_codigo = ba1.ba1_codpla AND "
	//cSQL += " bi3.bi3_versao = ba1.ba1_versao AND "
	//Considera  plano da familia, uma vez que o usuario pode nao ter o plano cadastro
	cSQL += " BI3.BI3_CODIGO = BA3.BA3_CODPLA AND "																								+ CRLF
	cSQL += " BI3.BI3_VERSAO = BA3.BA3_VERSAO AND "																								+ CRLF
	cSQL += " bqc.bqc_filial = ba1.ba1_filial AND "																								+ CRLF
	cSQL += " bqc.bqc_codigo = ba1.ba1_codint || ba1.ba1_codemp AND "																			+ CRLF
	cSQL += " bqc.bqc_numcon = ba1.ba1_conemp AND "																								+ CRLF
	cSQL += " bqc.bqc_vercon = ba1.ba1_vercon AND "																								+ CRLF
	cSQL += " bqc.bqc_subcon = ba1.ba1_subcon AND " 																							+ CRLF
	cSQL += " bqc.bqc_versub = ba1.ba1_versub AND "																								+ CRLF
	cSQL += " BA3.BA3_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " BA1.BA1_DATBLO = '  ' AND "																										+ CRLF
	cSQL += " ba1.d_e_l_e_t_ <> '*' AND "																										+ CRLF
	cSQL += " ba3.d_e_l_e_t_ <> '*' AND "																										+ CRLF
	cSQL += " bqc.d_e_l_e_t_ <> '*' AND "																										+ CRLF
	cSQL += " bts.d_e_l_e_t_ <> '*' AND "																										+ CRLF
	cSQL += " bed.d_e_l_e_t_ <> '*' "																											+ CRLF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! Empty(aReturn[7])
		cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "																							+ CRLF
	Endif   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ De acordo com a ordem....                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdSel == 1 //Quebra por Grupo Empresa
		//    cSQL += "GROUP BY BA1_CODINT,BA1_CODEMP,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB,BA1_CODPLA,BA1_VERSAO "
		cSQL += "ORDER BY BA1_CODINT,BA1_CODEMP,BA3_CODPLA,BA1_VERSAO,MOTIVO,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB,BA1_MATRIC,BA1_TIPREG "+ CRLF
		cCabec1 := "Grupo/Empresa                                                  " 
	Elseif  nOrdSel == 2  //Quebra por Produto
		//    cSQL += "GROUP BY BA1_CODINT,BA1_CODPLA,BA1_VERSAO,BA1_CODEMP,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB "
		cSQL += "ORDER BY BA1_CODINT,BA3_CODPLA,BA1_VERSAO,BA1_CODEMP,MOTIVO,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB,BA1_MATRIC,BA1_TIPREG "+ CRLF

		// Altera o cabecalho do relatorio...'
		cCabec1 := "Produto                                                        "
		//              0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//              Produto                                                     "12[01]12[02]12[03]12[04]                                     Total
		//              Produto                                                      "
		//                   12345678901234567890123456789012345678901234567890123456 99999 99999 99999 99999 99999 99999 99999 99999 99999 99999 99999
		//                                                                            1234567
		//                   Produto                                                  99999 99999
	Endif                          
	For n=1 to len(aPonto)
		cCabec1 += "["+strzero(val(aPonto[n][1]),2)+"]"+space(2)
	Next
	cCabec1 += "Total"
	nCol := len(alltrim(cCabec1))-4

	If nLi > nQtdLin
		nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLi += 1
	Endif               

	memowrit("C:\TEMP\CABR016.SQL",cSQL)

	If Select("CABR016") > 0
		CABR016->(DbCloseArea())
	EndIf

	PLSQuery(cSQL,"CABR016")
	//cSQL := ChangeQuery(cSQL)
	dbSelectArea("CABR016")        

	//SERGIO CUNHA Chamado - ID: 21521 - EXCEL INICIO

	If mv_par15 == 1      

		For nI := 1 to 5
			IncProc('Processando Gerando arquivo Excel...')
		Next

		If ! CABR016->(Eof())
			nSucesso := 0
			// Monta Cabecalho "Fixo"
			aCabec := {"MOTIVO","BA1_DTVLCR","BA1_CODINT","BA1_CODEMP","BA1_CONEMP","BA1_VERCON","BA1_SUBCON","BA1_VERSUB","BA1_MATRIC",;
			"BA1_TIPREG","BA1_DIGITO","BA1_NOMUSR","BA1_CODPLA","BA1_VERSAO","BA1_DATCAR","BA1_VIACAR","BA1_OPERES","BA1_DTVLCR_1",;
			"BQC_DATCON","BQC_VALID","BG9_DESCRI","BI3_DESCRI","BA3_CODPLA","BA3_VERSAO"}


			CABR016->(DbGoTop())
			While ! CABR016->(Eof()) 
				IncProc()

				AADD(aDados,{CABR016->MOTIVO,CABR016->BA1_DTVLCR,CABR016->BA1_CODINT,CABR016->BA1_CODEMP,CABR016->BA1_CONEMP,CABR016->BA1_VERCON,CABR016->BA1_SUBCON,;
				CABR016->BA1_VERSUB,CABR016->BA1_MATRIC,CABR016->BA1_TIPREG,CABR016->BA1_DIGITO,CABR016->BA1_NOMUSR,CABR016->BA1_CODPLA,CABR016->BA1_VERSAO,;
				CABR016->BA1_DATCAR,CABR016->BA1_VIACAR,CABR016->BA1_OPERES,CABR016->BA1_DTVLCR_1,CABR016->BQC_DATCON,CABR016->BQC_VALID,CABR016->BG9_DESCRI,;
				CABR016->BI3_DESCRI,CABR016->BA3_CODPLA,CABR016->BA3_VERSAO})       


				CABR016->(DbSkip())
			End

			//Abre excel 
			DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

		EndIf	
	EndIf


	CABR016->(dbgotop())



	//SERGIO CUNHA Chamado - ID: 21521 - EXCEL FIM

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta regua                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	CABR016->(DBEval( { | | nQtd ++ }))
	nProc := 0
	CABR016->(dbGoTop())  

	ProcRegua(nQtd)

	While ! CABR016->(Eof())

		IncProc("Gerando " + AllTrim(Str(nProc)) + "  de  " + AllTrim(Str(nQtd))+ "  Layout  " )
		ProcessMessage()
		nProc++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLi,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//	//³ Posiciono e Imprime grupo/empresa...                               ³
		//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//	Posicione("BG9",1,xFilial("BG9")+CABR016->(BA1_CODINT+BA1_CODEMP),"BG9_DESCRI")

		//	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//	//³ Posiciono e Imprime Produto...                                     ³
		//	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//	Posicione("BI3",1,xFilial("BI3")+CABR016->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_DESCRI")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atribuo valor as variaveis de controle...                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOperad  := CABR016->BA1_CODINT
		cGrupEmp := CABR016->BA1_CODEMP
		cDescGru := alltrim(CABR016->BG9_DESCRI)
		cContrat := CABR016->(BA1_CONEMP+BA1_VERCON)
		cSubCon  := CABR016->(BA1_SUBCON+BA1_VERSUB)
		cCodPla  := CABR016->BA3_CODPLA   //BA1_CODPLA
		cDescPla := CABR016->BI3_DESCRI
		dDatCont := CABR016->BQC_DATCON

		nTotGrp  := 0
		If nLi > nQtdLin
			nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
			nLi += 1
		Endif
		@ nLi, 00 pSay Iif(nOrdSel = 1, ("Empresa : "+cGrupEmp+" - "+cDescGru), ("Produto : "+cCodPla+" - "+cDescPla))
		nLi += 2

		If nOrdSel == 1 //Quebra por Grupo Empresa
			While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODEMP) == cOperad+cGrupEmp

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atribuo valor as variaveis de controle...                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cCodPla  := CABR016->BA3_CODPLA      //CABR016->BA1_CODPLA
				cDescPla := CABR016->BI3_DESCRI

				If nLi > nQtdLin //.And. nTipo <> 2
					nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
					nLi += 2
				Endif
				@ nLi, 05 pSay cCodPla
				@ nLi, 13 pSay cDescPla

				aImp:= {}

				nTotGer := 0
				//			While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODEMP+BA1_CODPLA) == cOperad+cGrupEmp+cCodPla
				While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODEMP+BA3_CODPLA) == cOperad+cGrupEmp+cCodPla
					nTotMot := 0
					cMotivo := CABR016->MOTIVO
					//					While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODEMP+BA1_CODPLA+MOTIVO) == cOperad+cGrupEmp+cCodPla+cMotivo
					While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODEMP+BA3_CODPLA+MOTIVO) == cOperad+cGrupEmp+cCodPla+cMotivo
						nTotMot++
						CABR016->(DbSkip())
					EndDo             
					nElemento := aScan(aPonto,{ |x| x[1] == cMotivo}) 
					If nElemento > 0
						nColuna := aPonto[nElemento][3]                         

						**'Inicio Marcela Coimbra - Data : 25/03/2010 ------------'**

						//@ nLi, nColuna pSay nTotMot PICTURE "99999"  
						n_LinImp := aScan(aImp,{ |x| x[1] == nColuna})
						If n_LinImp > 0

							aImp[n_LinImp][2] += nTotMot

						Else

							aadd( aImp, {nColuna, nTotMot}) 

						EndIf
						aPonto[nElemento][4] += nTotMot
					EndIf   
					nTotGer += nTotMot		
				Enddo   

				aSort( aImp, , , { |x, y| x[1] < y[1] })

				For n_aImp:= 1 to Len (aImp)                             

					@ nLi, aImp[n_aImp][1] pSay aImp[n_aImp][2] PICTURE "99999"

				Next           

				**'Fim - Marcela Coimbra - Data : 25/03/2010 			

				@ nLi, nCol pSay nTotGer PICTURE "99999"
				nLi ++

				nTotGrp += nTotGer
			EndDo                                                           
			@ nLi, 05 pSay "Total de carteirinhas a serem emitidas do Grupo Empresa"
			@ nLi, nCol pSay nTotGrp PICTURE "99999"

		ElseIf nOrdSel == 2 //Quebra por Produto
			//		While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODPLA) == cOperad+cCodPla
			While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA3_CODPLA) == cOperad+cCodPla

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atribuo valor as variaveis de controle...                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cGrupEmp := CABR016->BA1_CODEMP
				cDescGru := alltrim(CABR016->BG9_DESCRI)
				cContrat := CABR016->(BA1_CONEMP+BA1_VERCON)
				cSubCon  := CABR016->(BA1_SUBCON+BA1_VERSUB)
				dDatCont := CABR016->BQC_DATCON

				If nLi > nQtdLin //.And. nTipo <> 2
					nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
					nLi += 2
				Endif
				@ nLi, 05 pSay cGrupEmp
				@ nLi, 13 pSay cDescGru

				nTotGer := 0                  
				aImp := {}
				//			While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODPLA+BA1_CODEMP) == cOperad+cCodPla+cGrupEmp
				While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA3_CODPLA+BA1_CODEMP) == cOperad+cCodPla+cGrupEmp
					nTotMot := 0
					cMotivo := CABR016->MOTIVO
					//					While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA1_CODPLA+BA1_CODEMP+MOTIVO) == cOperad+cCodPla+cGrupEmp+cMotivo
					While ! CABR016->(Eof()) .And. CABR016->(BA1_CODINT+BA3_CODPLA+BA1_CODEMP+MOTIVO) == cOperad+cCodPla+cGrupEmp+cMotivo
						nTotMot ++
						CABR016->(DbSkip())
					EndDo             
					nElemento := aScan(aPonto,{ |x| x[1] == cMotivo}) 
					If nElemento > 0
						nColuna := aPonto[nElemento][3]
						**'Inicio Marcela Coimbra - Data : 25/03/2010 ------------'**

						//@ nLi, nColuna pSay nTotMot PICTURE "99999"  
						n_LinImp := aScan(aImp,{ |x| x[1] == nColuna})
						If n_LinImp > 0

							aImp[n_LinImp][2] += nTotMot

						Else

							aadd( aImp, {nColuna, nTotMot}) 

						EndIf
						aPonto[nElemento][4] += nTotMot
					EndIf   
					nTotGer += nTotMot		
				Enddo   

				aSort( aImp, , , { |x, y| x[1] < y[1] })

				For n_aImp:= 1 to Len (aImp)                             

					@ nLi, aImp[n_aImp][1] pSay aImp[n_aImp][2] PICTURE "99999"

				Next           

				**'Fim - Marcela Coimbra - Data : 25/03/2010 
				@ nLi, nCol pSay nTotGer PICTURE "99999"
				nLi ++

				nTotGrp += nTotGer

			EndDo
			@ nLi, 05 pSay "Total de carteirinhas a serem emitidas do Produto "
			@ nLi, nCol pSay nTotGrp PICTURE "99999"
		EndIf
		nLi += 2

		nTotal += nTotGrp

	Enddo

	If nTotal > 0
		@ nLi, 05 pSay "TOTAL"
		For n=1 to len(aPonto)

			nColuna := aPonto[n,3]
			@ nLi, nColuna pSay aPonto[n,4] PICTURE "999999"

		Next
		@ nLi, nCol pSay nTotal PICTURE "999999"
		nLi ++
		@ nLi, 00 pSay replicate("-", 132)
		nLi ++
		nColuna := 0
		For n=1 to len(aPonto)
			@ nLi, nColuna pSay "["+aPonto[n,1]+"] - "+aPonto[n,2]
			If nColuna == 0
				nColuna := 60
			ElseIf nColuna == 60
				nColuna := 120
			Else
				nLi ++
				nColuna := 0
			EndIf
		Next
	EndIf
	CABR016->(DbCloseArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aReturn[5] == 1
		Set Printer To
		Ourspool(cRel)
	Endif
	//MS_FLUSH()             // Libera fila de relatorios em spool

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim do Relatorio                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ ValidPerg ³ Autor ³ Luzio Tavares        ³ Data ³ 08.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

Static Function ValidPerg()

	LOCAL aRegs	:= {}

	aadd(aRegs,{cPerg,"01","Operadora:                ","","","mv_ch1","C", 4,0,2,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
	aadd(aRegs,{cPerg,"02","Periodo De:               ","","","mv_ch2","D", 8,0,2,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"03","Periodo Ate:              ","","","mv_ch3","D", 8,0,2,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"04","Grupo/Empresa De:         ","","","mv_ch4","C", 4,0,2,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
	aadd(aRegs,{cPerg,"05","Grupo/Empresa Ate:         ","","","mv_ch5","C", 4,0,2,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
	aadd(aRegs,{cPerg,"06","Contrato De:              ","","","mv_ch6","C",12,0,2,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
	aadd(aRegs,{cPerg,"07","Contrato Ate:             ","","","mv_ch7","C",12,0,2,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
	aadd(aRegs,{cPerg,"08","Subcontrato De:           ","","","mv_ch8","C", 9,0,2,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
	aadd(aRegs,{cPerg,"09","Subcontrato Ate:          ","","","mv_ch9","C", 9,0,2,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
	aadd(aRegs,{cPerg,"10","Matricula De:             ","","","mv_cha","C", 6,0,2,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"11","Matricula Ate:            ","","","mv_chb","C", 6,0,2,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"12","Produto De:               ","","","mv_chc","C", 4,0,2,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","","BI3"})
	aadd(aRegs,{cPerg,"13","Produto Ate:              ","","","mv_chd","C", 4,0,2,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","","BI3"})
	aadd(aRegs,{cPerg,"14","Tipo de Contrato          ","","","mv_che","N", 1,0,2,"C","","mv_par14","Fisica","","","","","Juridica","","","","","Todas","","","","","","","","","","","","","","",""})
	//SERGIO CUNHA Chamado - ID: 21521  INICIO
	aadd(aRegs,{cPerg,"15","Gerar Excel				  ","","","mv_chi","N", 1,0,2,"C","","mv_par15","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
	//SERGIO CUNHA Chamado - ID: 21521  FIM
	//Aadd(aRegs,{cPerg,"15","Analitico/Sintetico     ","","","mv_chf","N", 1,0,0,"C","","mv_par15","Analítico","","","","","Sintético","","","","","","","","","","","","","","","","","","","","",""})
	//aadd(aRegs,{cPerg,"16","Motivo De:              ","","","mv_chg","C", 1,0,2,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	//aadd(aRegs,{cPerg,"17","Motivo Ate:             ","","","mv_chh","C", 1,0,2,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	//aadd(aRegs,{cPerg,"18","Usuario de Intercambio? ","","","mv_chi","N", 1,0,2,"C","","mv_par18","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})

	PlsVldPerg( aRegs )

Return





User Function AcertaVia

	Private cMatr      := Space(17)
	Private cNome      := Space(100)

	SetPrvt("oDlg1","oSay1","oSay2","oGet1","oGet2","oSBtn1","oSBtn2")

	oDlg1      := MSDialog():New( 095,232,281,784,"Acerta vias carteira",,,.F.,,,,,,.T.,,,.T. ) 

	oSay1      := TSay():New( 016,012,{||"Matr. Beneficiário"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
	oGet1      := TGet():New( 016,064,{|u| If(PCount()>0,cMatr:=u,cMatr)},oDlg1,196,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cMatr",,)

	oSBtn1     := SButton():New( 064,204,1,{|| processa({||ExecAcertVia(allTrim(cMatr))}) ,oDlg1:End()}	,oDlg1,,"", )
	oSBtn2     := SButton():New( 064,234,2,{|| oDlg1:End()}												,oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

Return


Static Function ExecAcertVia(cMatr)

	Local cEmpresa 		:= left(cMatr,4)
	Local cGrupo 		:= substr(cMatr,5,4)
	Local cMatricula 	:= substr(cMatr,9,6)
	Local cTipoReg		:= substr(cMatr,15,2)      
	Local cDigito		:= substr(cMatr,17,1)      
	Local cQuery		:= ""
	Local cAlias 		:= GetNextAlias()
	Local nRecBA1		:= 0  
	Local nCont 		:= 0      
	Local nTot			:= 0

	dbSelectArea('BA1')
	dbSetOrder(2) 

	If MsSeek(xFilial('BA1') + cMatr)

		If MsgYesNo('Confirma a atualização das vias do usuário ' + BA1->BA1_NOMUSR)

			nRecBA1 := BA1->(Recno())

			cQuery += "SELECT *" 																							+ CRLF
			cQuery += "FROM " + RetSqlName('BED') 																			+ CRLF
			cQuery += "WHERE D_E_L_E_T_ = ' '"																				+ CRLF
			cQuery += "  AND BED_FILIAL = '" + xFilial('BED') + "'"															+ CRLF 
			cQuery += "  AND BED_CODINT || BED_CODEMP || BED_MATRIC || BED_TIPREG || BED_DIGITO = '" + cMatr + "'"			+ CRLF
			cQuery += "ORDER BY BED_DTSOLI"

			TcQuery cQuery New Alias cAlias

			cAlias->(dbGoTop())

			cAlias->(dbEval({|| ++nTot}))

			cAlias->(dbGoTop())

			While !cAlias->(EOF())

				IncProc('Atualizando...')

				BED->(dbGoTo(cAlias->(R_E_C_N_O_)))

				RecLock('BED',.F.)

				BED->BED_VIACAR	:= ++nCont

				//Fecha todas e nao altera a ultima.
				If nCont < nTot		          
					BED->BED_STACAR := '2'
				EndIf

				MsUnlock()

				cAlias->(dbSkip())

			EndDo

			BA1->(dbGoTo(nRecBA1))

			RecLock('BA1',.F.)

			BA1->BA1_VIACAR := nTot

			MsUnlock()

		EndIf

	Else
		alert('Usuário não encontrado com a matrícula ' + cMatr)
	EndIf

Return
