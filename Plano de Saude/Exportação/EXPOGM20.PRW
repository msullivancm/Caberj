#include "protheus.ch"
#include "vkey.ch"
#include "topconn.ch"
#Include "rwmake.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ EXPORTGM º Autor ³MobileSaude         º Data ³  23/01/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ .T.                                                                                                                                                                                                                                                       v				   		      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus PLS                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function EXPOGM20(aEmp)
	
	Local aArea			:= GetArea()
	Local cMsgFim		:= ""
	
	Local nOpc			:= 0
	Local aSays			:= {}
	Local aButtons		:= {}
	Local lPerg			:= .F.
	Private cCadastro	:= "MobileSaude - Exportação de Guia Médico"
	Private cPerg       := "EXPORTGM"
	Private cVerLay		:= ""
	Private cHoraIni	:= ""
	Private cTempoTot	:= ""
	Private lSched		:= .F.
	
	Default aEmp        := {"01"}
	
	//verifica se a execucao e pelo menu ou pelo schedule
	
	If Select("SX6") == 0
		
		lSched := .T.
	
	EndIf
	
	If lSched
		
	//	For nX := 1 to len(aEmp) // For incluido para executar para as duas empresas ( Caber | Integral |)
			
			RPCSetType(3)  // Nao utiliza licenca
			RpcSetEnv(aEmp[1],"01")
			
		
			Pergunte(cPerg, .F.)
			cHoraIni	:= time()
			
			if alltrim(cEmpAnt) == "01"
				QOut("Job EXPOGM20-Inicio: "+cHoraIni+" CABERJ")
				mv_par07 :=  "/MobileSaude/Caberj/"
			else 
				QOut("Job EXPOGM20-Inicio: "+cHoraIni+" INTEGRAL")
				mv_par07 := "/MobileSaude/Integral/"
			endif 
			
			mv_par02 := ddatabase
			mv_par03 := 2 //nreduz Motta 27/1/21
			
			VarInfo("MV_PAR01",mv_par01)
			VarInfo("MV_PAR02",MV_PAR02)
			VarInfo("MV_PAR03",MV_PAR03)
			VarInfo("MV_PAR04",MV_PAR04)
			VarInfo("MV_PAR05",MV_PAR05)
			VarInfo("MV_PAR06",MV_PAR06)
			VarInfo("MV_PAR07",MV_PAR07)
			VarInfo("MV_PAR08",MV_PAR08)
			VarInfo("MV_PAR09",MV_PAR09)
			VarInfo("MV_PAR10",MV_PAR10)
			VarInfo("MV_PAR11",MV_PAR11)
			
				
			Processa( {|| GERAEXPGM() },"Exportando Guia Médico...")
			cTempoTot := elapTime(cHoraIni,time())
			
			if cEmpAnt == "01"
				QOut("Job EXPOGM20-FIM CABERJ")
			else 
				QOut("Job EXPOGM20-FIM INTEGRAL")
			endif 
			
			RpcClearEnv()
	//	Next nX 
	
	Else
		
		If PLSALIASEXI("B7O")
			If B7O->( FieldPos("B7O_CODRDA") ) <= 0
				MsgAlert("É necessário atualizar seu sistema com itens da RN 365 -> Chamados TSHJWM e TTGJJ4. Operacao abortada!")
				Return
			Endif
		Else
			MsgAlert("É necessário atualizar seu sistema com itens da RN 365 -> Chamados TSHJWM e TTGJJ4. Operacao abortada!")
			Return
		Endif
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza SX1                                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		CriaSX1()
		
		Pergunte(cPerg, .F.)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta texto para janela de processamento                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aAdd(aSays,"Esta rotina tem por objetivo gerar a exportação do Guia Médico - layout MobileSaude")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta botoes para janela de processamento                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aAdd(aButtons, { 5, .T., {|| lPerg := Pergunte(cPerg, .T.) } } )
		aAdd(aButtons, { 1, .T., {|| nOpc  := 1, If( ConaOk(), FechaBatch(), nOpc := 0 ) }} )
		aAdd(aButtons, { 2, .T., {|| FechaBatch() }} )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Exibe janela de processamento                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		FormBatch( cCadastro, aSays, aButtons,, 160 )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa Rotina                                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  nOpc == 1
			
			Pergunte(cPerg, .F.)
			cHoraIni	:= time()
			
			Processa( {|| GERAEXPGM() },"Exportando Guia Médico...")
			
			cMsgFim := "Geração dos arquivos de Guia Médico finalizada."			+ CHR(13)+CHR(10) + CHR(13)+CHR(10)
			cMsgFim += "Tempo Gasto: " + cTempoTot
			MsgInfo(cMsgFim)
			
		Endif
		
	Endif
	
	
	//finaliza a conexao
	If Select("SX6") == 0
		RESET ENVIRONMENT
	EndIf
	
	RestArea(aArea)
	
return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERAEXPGM ºAutor  ³ MobileSaude        º Data ³  21/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Rotina de exportação do Guia Medico		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Totvs                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GERAEXPGM()
	
	Local cNmArqPr		:= AllTrim(mv_par07) + "GM_MS_Redecred"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
	Local cNmArqCC		:= ""
	Local cNmArqAc		:= ""
	Local cNmArqEs		:= ""
	Local cNmArqPl		:= ""
	Local cNmArqTp		:= ""
	Local nHdl			:= FCREATE( cNmArqPr )
	Local cExtracao		:= ""
//	Local cEspec		:= ""
//	Local cSubEsp		:= ""
	Local cQuery 		:= ""
	Local lNomFanta		:= mv_par08 == 2
	Local lEmailRDA		:= mv_par09 == 1
	Local lDescPlano	:= mv_par03 == 1
	Local cClassesOk	:= mv_par04
	Local lExRdaCCRd 	:= mv_par12 == 2 //Se inclui no arquivo a RDA que exporta corpo clinico como RDAs
	Local lEnvMotBlq	:= mv_par16 == 1
	Local nDiBlqAnt		:= mv_par13
	Local nDiBlqPos		:= mv_par14
	Local lEspIguExc	:= mv_par15 == 1
	Local lExCCRda		:= .F.
	Local nExtrCnt		:= 0
	
	Local lFldFaceb		:= .F.
	Local nCont			:= 0
	Local lAcredit		:= .F.
	Local cNmCAcr			:= ""
	Local cNmQdMon		:= ""
	Local cNmLcGui		:= ""
	Local cNmCSbEQ		:= ""
	Local cObsEsp			:= ""
	Local cDesObsEsp		:= ""
	Local cNmResid		:= ""
//	Local lCabAcred		:= .T.
	Local nHdlAcr
	Local cChAcrAnt		:= ""
	Local lExpRDA			:= .F.
	LOCAL cSessaoRes		:= ""
	LOCAL aTelefones 		:= {}
	LOCAL lMaisDeUm 		:= .F.
	LOCAL cTel1			:= ""
	LOCAL cTel2			:= ""
	LOCAL cToken 			:= ""
	LOCAL nCtn1 			:= 0
	LOCAL cOrdemPla		:= ""
	LOCAL cLatRDA			:= ""
	LOCAL cLonRDA			:= ""
	LOCAL aExpRDA			:= {}
	Local cTpLogr			:= ""
	Local lUsaTpLog		:= .F.
	Local lLocalSubs		:= .F.
	Local cMsgAlert		:= ""
	Local lTemSubEsp		:= .F.
	Local cCodSubEsp	   := ""
	Local _lSx5			:= .T. //Angelo Henrique - Data: 06/02/2018
	Local _aClaMv 		:= strtokarr(AllTrim(cClassesOk),',') //Angelo Henrique - Data: 06/02/2018
	Local _ni 	:=0

	aErrosRDA := {}
	lUsaTpLog	:= GetNewPar("MV_XTPLMB","N")=="S"
	
	SX5->(DbSetOrder(1))
	BUL->(DbSetOrder(2))
	BC1->(DbSetOrder(1)) //BC1_FILIAL+BC1_CODIGO+BC1_CODLOC+BC1_CODESP+BC1_CODPRF
	BB0->(DbSetOrder(1)) //BB0_FILIAL+BB0_CODIGO
	cVerLay := "2.2"
	
	//------------------------------------------------------------------	
	//Inicio - Angelo Henrique - Data: 06/02/2018
	//------------------------------------------------------------------
	//Colocando aqui as classes selecionadas
	//------------------------------------------------------------------
	cClassesOk := ""
	
	For _ni := 1 To Len(_aClaMv)
		
		If _ni != Len(_aClaMv)
			
			cClassesOk += "'" + _aClaMv[_ni] + "',"
			
		Else
			
			cClassesOk += "'" + _aClaMv[_ni] + "'"
			
		EndIf
		
	Next _ni
	//------------------------------------------------------------------	
	//Fim - Angelo Henrique - Data: 06/02/2018
	//------------------------------------------------------------------
	
	if nHdl <> -1


		/* Alterado por Luiz Otavio * Correção de Especialidade X Sub-especialidade */
		cQuery  := " SELECT BAX_CODINT, BAX_CODESP, BAX_CODSUB, BAX_CODLOC, BAX_DATINC, BAX_DATBLO,  "
		cQuery  += " 		BAU_SECRES, BAU_CODIGO, BAU_NOME, BAU_NFANTA, BAU_PRDATN, BAU_TIPPRE, BAU_SEXO, "
		cQuery  += "		BAU_CPFCGC, BAU_SIGLCR, BAU_CONREG,  BAU_ESTCR, BAU_EMAIL,BAU_WEB,  BAU_TIPPE, BAU_DIRREG, "
		cQuery  += "		BAU_DIRTEC, BAU_DATBLO, BAU_CODBLO,  BAU_PRTACD, BAU_INSACR, BAU_NIVACR, BAU_NTVISA,  "
		cQuery  += "		BAU_QUAMON,  BAU_RESIDE,  BAU_INSCAC, BAQ_DESCRI,  BI3_CODIGO, BI3_VERSAO, BI3_SUSEP, BI3_TIPCON, BI3_ALLRED, "
		cQuery  += "		BI3_SITCOM, BI3_DESCRI, BI3_NREDUZ,  BB8_YMSGAL,  BB8_CODMUN, BB8_EMAIL, BB8_WEB, BB8_DATBLO,  BB8_YCDSBE,  "
		cQuery  += "		BB8_TIPLOG,BB8_END,BB8_NR_END, BB8_COMEND, BB8_BAIRRO, BB8_MUN, BB8_EST, BB8_CEP, BB8_DDD, "
		cQuery  += "		BB8_TEL, BB8_FAX   , BB8_YLATEN, BB8_YLONEN   , BB8_YTPESA  , BB8_NMLCGU  , BI3_SITANS , BAU_FACEBO, "
		cQuery  += "		BAU_TWITTE, BB8_OBS, BB8_ACESSI, BB8_DETACE, BB8_ATE24H, BAX_YSUBES, BAQ_ENVGUI, BAQ_DESGUI, BAQ_YGPESP, "
		cQuery  += "		DESSBES, BFN_CODESP, BFN_CODSUB  , BAX_OBSESP , BBF_POSGRA,  BBF_GRADU, BBF_PPRCER, "
		cQuery  += "		BBF_TITESP, BBF_LOCAL, BBF_RQE, BBF_NRESP, BBF_GUIESP, BBF_TITATU, BBF_GERPTU , "
		cQuery  += "		BAUCPFSB, BAUTPPSB, BAXESPSB, BAXLOCSB,  BAQDSGSB,  BAQDSCSB    "
		cQuery  += " FROM ( "


		//****************************************************************************

		
		cQuery  += " SELECT DISTINCT BAX.BAX_CODINT, BAX.BAX_CODESP, ' ' BAX_CODSUB, BAX.BAX_CODLOC, BAX.BAX_DATINC, BAX.BAX_DATBLO, "
		
		// Sessão do resultado.
		If BAU->( FieldPos("BAU_SECRES") ) > 0
			cQuery += " BAU.BAU_SECRES, "
		Endif
		
		cQuery  += " BAU.BAU_CODIGO, BAU.BAU_NOME, BAU.BAU_NFANTA, BAU.BAU_PRDATN, BAU.BAU_TIPPRE, BAU.BAU_SEXO, BAU.BAU_CPFCGC, BAU.BAU_SIGLCR, BAU.BAU_CONREG, "
		cQuery  += " BAU.BAU_ESTCR, BAU.BAU_EMAIL, BAU.BAU_WEB,  BAU.BAU_TIPPE, BAU.BAU_DIRREG, BAU.BAU_DIRTEC, BAU.BAU_DATBLO, BAU.BAU_CODBLO, "
		
		//Checa se o campo da RN 321 esta disponivel...
		If BAU->(FieldPos("BAU_PRTACD")) > 0
			lAcredit := .T.
			cNmCAcr := "QRYPRIN->BAU_INSACR"
			cQuery  += " BAU.BAU_PRTACD, BAU.BAU_INSACR, BAU.BAU_NIVACR, BAU.BAU_NTVISA, "
		Endif
		
		//Checa se novo campo de qualidade esta disponivel.
		If BAU->(FieldPos("BAU_QUAMON")) > 0
			lAcredit := .T.
			cNmQdMon := "QRYPRIN->BAU_QUAMON"
			cQuery  += " BAU.BAU_QUAMON, "
		Endif
		
		//Checa se novo campo de residencia esta disponivel.
		If BAU->(FieldPos("BAU_RESIDE")) > 0
			lAcredit := .T.
			cNmResid := "QRYPRIN->BAU_RESIDE"
			cQuery  += " BAU.BAU_RESIDE, "
		Endif
		
		
		If BAU->(FieldPos("BAU_INSCAC")) > 0
			cQuery  += " BAU.BAU_INSCAC, "
			cNmCAcr := "QRYPRIN->BAU_INSCAC"
		Endif
		
		cNmCSCom := "QRYPRIN->BI3_SITCOM"
		
		//Motta Duplicidade do Livro 2/5/19
		//cQuery  += " BAQ.BAQ_CBOS,  BAQ.BAQ_DESCRI, "
		cQuery  += "                BAQ.BAQ_DESCRI, "
		//Fim Motta Duplicidade do Livro 2/5/19
		cQuery  += " BI3_CODIGO, BI3_VERSAO, BI3_SUSEP, BI3_TIPCON, BI3_ALLRED, BI3_SITCOM, BI3_DESCRI, BI3_NREDUZ, "
		If BI3->( FieldPos("BI3_YORDEX") ) > 0
			cQuery +=  " BI3_YORDEX, "
		Endif
		
		If BB8->( FieldPos("BB8_YMSGAL") ) > 0
			cQuery +=  " BB8.BB8_YMSGAL,  "
		Else
			cQuery +=  " ' ' BB8_YMSGAL, "
		Endif
		cQuery  += " BB8.BB8_CODMUN, BB8.BB8_EMAIL, BB8.BB8_WEB, BB8.BB8_DATBLO, ' ' BB8_YCDSBE, "
		
		cQuery  += " BB8.BB8_TIPLOG, BB8.BB8_END, BB8.BB8_NR_END, BB8.BB8_COMEND, BB8.BB8_BAIRRO, BB8.BB8_MUN, BB8.BB8_EST, BB8.BB8_CEP, BB8.BB8_DDD, BB8.BB8_TEL, BB8.BB8_FAX  "
		
		If BB8->(FieldPos("BB8_YLATEN")) > 0
			cQuery  += " , BB8.BB8_YLATEN, BB8.BB8_YLONEN  "
		Else
			cQuery  += " , 	'' BB8_YLATEN, '' BB8_YLONEN  "
		Endif
		
		If BB8->(FieldPos("BB8_YTPESA")) > 0
			cQuery  += " ,  BB8.BB8_YTPESA "
		Else
			cQuery  += " , '' BB8_YTPESA "
		Endif
		
		If BB8->(FieldPos("BB8_NMLCGU")) > 0
			cQuery  += " , BB8.BB8_NMLCGU "
			cNmLcGui := "QRYPRIN->BB8_NMLCGU"
		Endif
		
		
		If BI3->(FieldPos("BI3_SITANS")) > 0
			cQuery  += " , BI3_SITANS "
			cNmCSCom := "QRYPRIN->BI3_SITANS"
		Endif
		
		If BAU->(FieldPos("BAU_FACEBO")) > 0
			lFldFaceb := .T.
			
			cNmCSbE := "QRYPRIN->BAX_YSUBES"
			cNmCSbEQ := "BAX.BAX_YSUBES"
			lTemSubEsp	:= .T.
			
			cQuery  += ", BAU.BAU_FACEBO, BAU.BAU_TWITTE, BB8.BB8_OBS, BB8.BB8_ACESSI, BB8.BB8_DETACE, BB8.BB8_ATE24H, BAX.BAX_YSUBES, BAQ.BAQ_ENVGUI, BAQ.BAQ_DESGUI, BAQ.BAQ_YGPESP"
			
			If BAU->(FieldPos("BAX_SBESP")) > 0
				cQuery  += ", BAX.BAX_SBESP "
				cNmCSbE := "QRYPRIN->BAX_SBESP"
				cNmCSbEQ := "BAX.BAX_SBESP"
				lTemSubEsp := .T.
			Endif
			
			cQuery  += ", CASE WHEN BFN.BFN_DESCRI IS NULL THEN BAQ.BAQ_DESCRI ELSE BFN.BFN_DESCRI END DESSBES, BFN.BFN_CODESP, BFN.BFN_CODSUB "
			
		Endif
		
		If BAX->(FieldPos("BAX_OBSESP")) > 0
			cQuery  += " , BAX.BAX_OBSESP "
			cObsEsp := "QRYPRIN->BAX_OBSESP"
		Endif
		
		If lAcredit
			cQuery  += ", BBF_POSGRA,  BBF_GRADU, BBF_PPRCER, BBF_TITESP, BBF_LOCAL, BBF_RQE, BBF_NRESP, BBF_GUIESP, BBF_TITATU, BBF_GERPTU "
		Endif
		
		cQuery  += ", CASE WHEN BAUSUB.BAU_CPFCGC IS NULL THEN '' ELSE BAUSUB.BAU_CPFCGC END BAUCPFSB, "
		cQuery  += " CASE WHEN BAUSUB.BAU_TIPPRE IS NULL THEN '' ELSE BAUSUB.BAU_TIPPRE END BAUTPPSB, "
		cQuery  += " CASE WHEN BAXSUB.BAX_CODESP IS NULL THEN '' ELSE BAXSUB.BAX_CODESP END BAXESPSB, "
		cQuery  += " CASE WHEN BAXSUB.BAX_CODLOC IS NULL THEN '' ELSE BAXSUB.BAX_CODLOC END BAXLOCSB, "
		cQuery  += " CASE WHEN BAQSUB.BAQ_DESGUI IS NULL THEN '' ELSE BAQSUB.BAQ_DESGUI END BAQDSGSB, "
		cQuery  += " CASE WHEN BAQSUB.BAQ_DESCRI IS NULL THEN '' ELSE BAQSUB.BAQ_DESCRI END BAQDSCSB "
		
		//cQuery  += " BAX.BAX_DATINC "
		
		cQuery  += " FROM  " +RetSqlName("BAX")  +" BAX "
		cQuery  += " INNER JOIN " +RetSqlName("BAQ")+" BAQ "
		cQuery  += " ON BAQ.BAQ_FILIAL = '"+xFilial("BAQ")+"' AND BAX.BAX_FILIAL = '"+xFilial("BAX")+"' AND BAX.BAX_CODINT = BAQ.BAQ_CODINT AND BAX.BAX_CODESP = BAQ.BAQ_CODESP AND BAQ.D_E_L_E_T_ = ' ' "
		
		If lFldFaceb
			cQuery  += " AND BAQ.BAQ_ENVGUI <> '0' "
		Endif
		
		cQuery  += " INNER JOIN  " +RetSqlName("BB8")+ " BB8 "
		cQuery  += " ON BB8_FILIAL = '"+xFilial("BB8")+"' AND BB8_CODINT = BAX.BAX_CODINT AND BB8_CODIGO = BAX.BAX_CODIGO AND BB8_CODLOC = BAX.BAX_CODLOC "
		cQuery  += " INNER JOIN  " +RetSqlName("BAU") + " BAU "
		cQuery  += " ON BAU.BAU_FILIAL = '"+xFilial("BAU")+"' AND BAX.BAX_CODIGO = BAU.BAU_CODIGO "
		
		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 02/02/2018
		//---------------------------------------------------------------------
		//Acrescentado mais um filtro para agilizar a query
		//---------------------------------------------------------------------
		cQuery  += "  	AND BAU.BAU_TIPPRE IN (" + cClassesOk + ")"
		
		If lAcredit
			cQuery  += " INNER JOIN  " +RetSqlName("BBF") + " BBF "
			cQuery  += " ON BBF_FILIAL = '"+xFilial("BBF")+"' AND BBF_CODIGO = BAU.BAU_CODIGO  AND SUBSTR(BBF_CODESP,1,4) = BAX.BAX_CODINT AND SUBSTR(BBF_CODESP,5,3) = BAX.BAX_CODESP AND BBF.D_E_L_E_T_ = ' ' "
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faco um produto cartesiano para todos os produtos que a RDA pode atender ³
		//³ (pois ela esta com a tabela de Redes VAZIA!!!							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQuery  += " INNER JOIN  " +RetSqlName("BI3") + " BI3 "
		cQuery  += " ON BI3_FILIAL = '"+xFilial("BI3")+"' AND BI3_CODINT = BAX.BAX_CODINT AND BI3_PORTAL <> '2' AND BI3.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT OUTER JOIN " +RetSqlName("BFN") + " BFN "
		cQuery  += " ON BFN.BFN_FILIAL = '"+xFilial("BFN")+"' "
		cQuery  += " AND BFN.BFN_CODINT = BAX.BAX_CODINT "
		cQuery  += " AND BFN.BFN_CODESP = BAX.BAX_CODESP "
		
		//Tratamento para funcoes exclusivas do Oracle e SQL Server.
		If lTemSubEsp
			If AllTrim( TCGetDB() ) $ "ORACLE,DB2"
				cQuery  += " AND instr(TRIM("+cNmCSbEQ+"),BFN.BFN_CODSUB) > 0 "
			Else
				cQuery  += " AND CHARINDEX(BFN.BFN_CODSUB, RTRIM(LTRIM("+cNmCSbEQ+"))) > 0 "
			Endif
		Endif
		
		cQuery  += " AND BFN.D_E_L_E_T_ = ' '	 "
		
		//Area da substituicao de rede...
		
		//Ver se cliente já possui campo de
		//local bloqueado (exclusivo V12
		If B7O->( FieldPos("B7O_LABBLO") ) > 0
			lLocalSubs := .T.
		Endif
		
		cQuery  += " LEFT OUTER JOIN "+RetSQLName("B7O")+" B7O "
		cQuery  += " 	ON B7O_FILIAL = '"+xFilial("B7O")+"' "
		cQuery  += " 	AND B7O_CODRDA = BAU_CODIGO "
		
		If lLocalSubs
			cQuery  += "	AND ( "
			cQuery  += "			( "
			cQuery  += "				B7O.B7O_LABBLO = ' ' AND BAU.BAU_DATBLO <> ' ' "
			cQuery  += " 			) "
			cQuery  += " 			OR "
			cQuery  += " 			( "
			cQuery  += " 				B7O.B7O_LABBLO = BB8.BB8_CODLOC AND BAU.BAU_DATBLO = ' ' "
			cQuery  += " 			) "
			cQuery  += " 		) "
		Endif
		
		cQuery  += " 	AND B7O.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT JOIN "+RetSQLName("BB8")+" BB8SUB "
		cQuery  += " 	ON BB8SUB.BB8_FILIAL = '"+xFilial("BB8")+"' "
		cQuery  += " 	AND BB8SUB.BB8_CODIGO = B7O.B7O_PRESUB "
		
		If lLocalSubs
			cQuery  += " 	AND BB8SUB.BB8_CODLOC = B7O.B7O_LABSUS "
		Endif
		cQuery  += " 	AND BB8SUB.D_E_L_E_T_ = ' ' "
		
		cQuery  += "  LEFT OUTER JOIN "+RetSQLName("BAX")+" BAXSUB "
		cQuery  += " 	ON BAXSUB.BAX_FILIAL = '"+xFilial("BAX")+"'  "
		cQuery  += " 	AND BAXSUB.BAX_CODIGO = BB8SUB.BB8_CODIGO "
		cQuery  += " 	AND BAXSUB.BAX_CODLOC = BB8SUB.BB8_CODLOC "
		If lEspIguExc
			cQuery  += " 	AND BAXSUB.BAX_CODESP = BAX.BAX_CODESP "
		Endif
		cQuery  += " 	AND BAXSUB.D_E_L_E_T_ = ' '  "
		cQuery  += " 	AND BAXSUB.BAX_GUIMED <> '0'  "
		cQuery  += " 	AND BAXSUB.D_E_L_E_T_ = ' '  "
		
		
		cQuery  += "  LEFT OUTER JOIN "+RetSQLName("BAU")+" BAUSUB  "
		cQuery  += "  	ON BAUSUB.BAU_FILIAL = '"+xFilial("BAU")+"'  "
		cQuery  += "  	AND BAUSUB.BAU_CODIGO = BAXSUB.BAX_CODIGO  "
		cQuery  += "  	AND BAUSUB.BAU_GUIMED <> '0'  "
		cQuery  += "  	AND BAUSUB.D_E_L_E_T_ = ' '  "
		
		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 02/02/2018
		//---------------------------------------------------------------------
		//Acrescentado mais um filtro para agilizar a query
		//---------------------------------------------------------------------
		cQuery  += "  	AND BAUSUB.BAU_TIPPRE IN (" + cClassesOk + ")"
		
		cQuery  += " LEFT OUTER JOIN "+RetSQLName("BFN")+" BFNSUB "
		cQuery  += " 	ON BFNSUB.BFN_FILIAL = '"+xFilial("BFN")+"' "
		cQuery  += " 	AND BFNSUB.BFN_CODINT = BAXSUB.BAX_CODINT "
		cQuery  += " 	AND BFNSUB.BFN_CODESP = BAXSUB.BAX_CODESP "
		cQuery  += " 	AND BFNSUB.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT OUTER JOIN " +RetSqlName("BAQ")+" BAQSUB "
		cQuery  += " ON BAQSUB.BAQ_FILIAL = '"+xFilial("BAQ")+"' AND BAXSUB.BAX_CODINT = BAQSUB.BAQ_CODINT AND BAXSUB.BAX_CODESP = BAQSUB.BAQ_CODESP AND BAQSUB.D_E_L_E_T_ = ' ' "
		
		If lFldFaceb
			cQuery  += " AND BAQSUB.BAQ_ENVGUI <> '0' "
		Endif
		
		/*
		//--REVER
		//Tratamento para funcoes exclusivas do Oracle e SQL Server.
		If AllTrim( TCGetDB() ) $ "ORACLE,DB2"
			cQuery  += " AND instr(TRIM("+cNmCSbEQ+"),BFNSUB.BFN_CODSUB) > 0 "
		Else
			cQuery  += " 	AND CHARINDEX(BFNSUB.BFN_CODSUB, RTRIM(LTRIM(BAXSUB.BAX_YSUBES))) > 0 "
		Endif
		
		*/
		
		//Fim da area de subst de rede...
		
		cQuery  += " WHERE BAX.D_E_L_E_T_ = ' ' AND BAQ.D_E_L_E_T_ = ' ' AND BB8.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = ' ' "
		cQuery  += " AND BAX.BAX_GUIMED <> '0' AND BAU.BAU_GUIMED <> '0' AND BB8.BB8_GUIMED <> '0' "
		//Adicionado por Luiz Otávio Campos  11/06/2021 * resolver problema de Especialidade X SubSpecialidade 
	    //	cQuery  += " AND BAX.BAX_CODSUB = ' ' "
		
		
		cQuery  += " AND BAX.BAX_DATINC <= '"+DtoS(dDataBase)+"' "
		cQuery  += " AND BAU.BAU_DTINCL BETWEEN '"+ DtoS(mv_par01)+"' AND '" +DtoS(mv_par02)+ "' "
		cQuery  += " AND BAU.BAU_CODIGO BETWEEN '"+ mv_par05+"' AND '" +mv_par06+ "' "
		
		cQuery  += " 	AND ( BI3_ALLRED = '1' OR "
		cQuery  += " ( "
		cQuery  += " 	SELECT COUNT(BB6.R_E_C_N_O_)  FROM "+RetSqlName("BB6")+" BB6, "+RetSqlName("BBK")+" BBK "
		cQuery  += " 	WHERE BB6_FILIAL = '"+xFilial("BD6")+"' "
		cQuery  += " 	AND BI3_CODINT = SUBSTR(BB6_CODIGO,1,4) "
		cQuery  += " 	AND BI3_CODIGO = SUBSTR(BB6_CODIGO,5,4) "
		cQuery  += " 	AND BI3_VERSAO = BB6_VERSAO "
		cQuery  += " 	AND BB6.D_E_L_E_T_ = ' ' "
		cQuery  += " 	AND BBK_FILIAL = '"+xFilial("BBK")+"' "
		cQuery  += " 	AND BBK_CODIGO = BAX.BAX_CODIGO "
		cQuery  += " 	AND BBK_CODLOC = BAX.BAX_CODLOC "
		cQuery  += " 	AND BBK_CODESP = BAX.BAX_CODESP "
		cQuery  += " 	AND BBK_CODSUB = BAX.BAX_CODSUB "
		If Existblock("MSBBKQRY")
			cQuery += Execblock("MSBBKQRY", .f., .f., {})
		Endif
		cQuery  += " 	AND BBK.BBK_CODRED = BB6.BB6_CODRED "
		//MOTTA 3/5/19 COMP COM LIVRO TOTVS
		cQuery  += " 	AND BBK_YDIVUL = '1' "
		//FIM MOTTA 3/5/19
		cQuery  += " 	AND BBK.D_E_L_E_T_ = ' '
		cQuery  += " 	) > 0 "
		cQuery  += " ) "
		
//************************** ALTERAÇÃO ADICIONADA * POR LUIZ OTAVIO 11/06/2021 ***********************/
// Motivo: Resolver problemas de Especialidade X Subespecialidade
//*****************************************************************************************************/
		cQuery  += " UNION "

		cQuery  += " SELECT DISTINCT BAX.BAX_CODINT, BAX.BAX_CODESP, BAX.BAX_CODSUB, BAX.BAX_CODLOC, BAX.BAX_DATINC, BAX.BAX_DATBLO, "
		
		// Sessão do resultado.
		If BAU->( FieldPos("BAU_SECRES") ) > 0
			cQuery += " BAU.BAU_SECRES, "
		Endif
		
		cQuery  += " BAU.BAU_CODIGO, BAU.BAU_NOME, BAU.BAU_NFANTA, BAU.BAU_PRDATN, BAU.BAU_TIPPRE, BAU.BAU_SEXO, BAU.BAU_CPFCGC, BAU.BAU_SIGLCR, BAU.BAU_CONREG, "
		cQuery  += " BAU.BAU_ESTCR, BAU.BAU_EMAIL, BAU.BAU_WEB,  BAU.BAU_TIPPE, BAU.BAU_DIRREG, BAU.BAU_DIRTEC, BAU.BAU_DATBLO, BAU.BAU_CODBLO, "
		
		//Checa se o campo da RN 321 esta disponivel...
		If BAU->(FieldPos("BAU_PRTACD")) > 0
			lAcredit := .T.
			cNmCAcr := "QRYPRIN->BAU_INSACR"
			cQuery  += " BAU.BAU_PRTACD, BAU.BAU_INSACR, BAU.BAU_NIVACR, BAU.BAU_NTVISA, "
		Endif
		
		//Checa se novo campo de qualidade esta disponivel.
		If BAU->(FieldPos("BAU_QUAMON")) > 0
			lAcredit := .T.
			cNmQdMon := "QRYPRIN->BAU_QUAMON"
			cQuery  += " BAU.BAU_QUAMON, "
		Endif
		
		//Checa se novo campo de residencia esta disponivel.
		If BAU->(FieldPos("BAU_RESIDE")) > 0
			lAcredit := .T.
			cNmResid := "QRYPRIN->BAU_RESIDE"
			cQuery  += " BAU.BAU_RESIDE, "
		Endif
		
		
		If BAU->(FieldPos("BAU_INSCAC")) > 0
			cQuery  += " BAU.BAU_INSCAC, "
			cNmCAcr := "QRYPRIN->BAU_INSCAC"
		Endif
		
		cNmCSCom := "QRYPRIN->BI3_SITCOM"
		
		cQuery  += "                BAQ.BAQ_DESCRI, "
	
		cQuery  += " BI3_CODIGO, BI3_VERSAO, BI3_SUSEP, BI3_TIPCON, BI3_ALLRED, BI3_SITCOM, BI3_DESCRI, BI3_NREDUZ, "
		If BI3->( FieldPos("BI3_YORDEX") ) > 0
			cQuery +=  " BI3_YORDEX, "
		Endif
		
		If BB8->( FieldPos("BB8_YMSGAL") ) > 0
			cQuery +=  " BB8.BB8_YMSGAL,  "
		Else
			cQuery +=  " ' ' BB8_YMSGAL, "
		Endif
		cQuery  += " BB8.BB8_CODMUN, BB8.BB8_EMAIL, BB8.BB8_WEB, BB8.BB8_DATBLO, ' ' BB8_YCDSBE, "
		
		cQuery  += " BB8.BB8_TIPLOG, BB8.BB8_END, BB8.BB8_NR_END, BB8.BB8_COMEND, BB8.BB8_BAIRRO, BB8.BB8_MUN, BB8.BB8_EST, BB8.BB8_CEP, BB8.BB8_DDD, BB8.BB8_TEL, BB8.BB8_FAX  "
		
		If BB8->(FieldPos("BB8_YLATEN")) > 0
			cQuery  += " , BB8.BB8_YLATEN, BB8.BB8_YLONEN  "
		Else
			cQuery  += " , 	'' BB8_YLATEN, '' BB8_YLONEN  "
		Endif
		
		If BB8->(FieldPos("BB8_YTPESA")) > 0
			cQuery  += " ,  BB8.BB8_YTPESA "
		Else
			cQuery  += " , '' BB8_YTPESA "
		Endif
		
		If BB8->(FieldPos("BB8_NMLCGU")) > 0
			cQuery  += " , BB8.BB8_NMLCGU "
			cNmLcGui := "QRYPRIN->BB8_NMLCGU"
		Endif
		
		
		If BI3->(FieldPos("BI3_SITANS")) > 0
			cQuery  += " , BI3_SITANS "
			cNmCSCom := "QRYPRIN->BI3_SITANS"
		Endif
		
		If BAU->(FieldPos("BAU_FACEBO")) > 0
			lFldFaceb := .T.
			
			cNmCSbE := "QRYPRIN->BAX_YSUBES"
			cNmCSbEQ := "BAX.BAX_YSUBES"
			lTemSubEsp	:= .T.
			
			cQuery  += ", BAU.BAU_FACEBO, BAU.BAU_TWITTE, BB8.BB8_OBS, BB8.BB8_ACESSI, BB8.BB8_DETACE, BB8.BB8_ATE24H, BAX.BAX_YSUBES, BAQ.BAQ_ENVGUI, BAQ.BAQ_DESGUI, BAQ.BAQ_YGPESP"
			
			If BAU->(FieldPos("BAX_SBESP")) > 0
				cQuery  += ", BAX.BAX_SBESP "
				cNmCSbE := "QRYPRIN->BAX_SBESP"
				cNmCSbEQ := "BAX.BAX_SBESP"
				lTemSubEsp := .T.
			Endif
			
			cQuery  += ", CASE WHEN BFN.BFN_DESCRI IS NULL THEN BAQ.BAQ_DESCRI ELSE BFN.BFN_DESCRI END DESSBES, BFN.BFN_CODESP, BFN.BFN_CODSUB "
			
		Endif
		
		If BAX->(FieldPos("BAX_OBSESP")) > 0
			cQuery  += " , BAX.BAX_OBSESP "
			cObsEsp := "QRYPRIN->BAX_OBSESP"
		Endif
		
		If lAcredit
			cQuery  += ", BBF_POSGRA,  BBF_GRADU, BBF_PPRCER, BBF_TITESP, BBF_LOCAL, BBF_RQE, BBF_NRESP, BBF_GUIESP, BBF_TITATU, BBF_GERPTU "
		Endif
		
		cQuery  += ", CASE WHEN BAUSUB.BAU_CPFCGC IS NULL THEN '' ELSE BAUSUB.BAU_CPFCGC END BAUCPFSB, "
		cQuery  += " CASE WHEN BAUSUB.BAU_TIPPRE IS NULL THEN '' ELSE BAUSUB.BAU_TIPPRE END BAUTPPSB, "
		cQuery  += " CASE WHEN BAXSUB.BAX_CODESP IS NULL THEN '' ELSE BAXSUB.BAX_CODESP END BAXESPSB, "
		cQuery  += " CASE WHEN BAXSUB.BAX_CODLOC IS NULL THEN '' ELSE BAXSUB.BAX_CODLOC END BAXLOCSB, "
		cQuery  += " CASE WHEN BAQSUB.BAQ_DESGUI IS NULL THEN '' ELSE BAQSUB.BAQ_DESGUI END BAQDSGSB, "
		cQuery  += " CASE WHEN BAQSUB.BAQ_DESCRI IS NULL THEN '' ELSE BAQSUB.BAQ_DESCRI END BAQDSCSB "
		
		
		cQuery  += " FROM  " +RetSqlName("BAX")  +" BAX "
		cQuery  += " INNER JOIN " +RetSqlName("BAQ")+" BAQ "
		cQuery  += " ON BAQ.BAQ_FILIAL = '"+xFilial("BAQ")+"' AND BAX.BAX_FILIAL = '"+xFilial("BAX")+"' AND BAX.BAX_CODINT = BAQ.BAQ_CODINT AND BAX.BAX_CODESP = BAQ.BAQ_CODESP AND BAQ.D_E_L_E_T_ = ' ' "
		
		If lFldFaceb
			cQuery  += " AND BAQ.BAQ_ENVGUI <> '0' "
		Endif
		
		cQuery  += " INNER JOIN  " +RetSqlName("BB8")+ " BB8 "
		cQuery  += " ON BB8_FILIAL = '"+xFilial("BB8")+"' AND BB8_CODINT = BAX.BAX_CODINT AND BB8_CODIGO = BAX.BAX_CODIGO AND BB8_CODLOC = BAX.BAX_CODLOC "
		cQuery  += " INNER JOIN  " +RetSqlName("BAU") + " BAU "
		cQuery  += " ON BAU.BAU_FILIAL = '"+xFilial("BAU")+"' AND BAX.BAX_CODIGO = BAU.BAU_CODIGO "
		
		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 02/02/2018
		//---------------------------------------------------------------------
		//Acrescentado mais um filtro para agilizar a query
		//---------------------------------------------------------------------
		cQuery  += "  	AND BAU.BAU_TIPPRE IN (" + cClassesOk + ")"
		
		If lAcredit
			cQuery  += " INNER JOIN  " +RetSqlName("BBF") + " BBF "
			cQuery  += " ON BBF_FILIAL = '"+xFilial("BBF")+"' AND BBF_CODIGO = BAU.BAU_CODIGO  AND SUBSTR(BBF_CODESP,1,4) = BAX.BAX_CODINT AND SUBSTR(BBF_CODESP,5,3) = BAX.BAX_CODESP AND BBF.D_E_L_E_T_ = ' ' "
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faco um produto cartesiano para todos os produtos que a RDA pode atender ³
		//³ (pois ela esta com a tabela de Redes VAZIA!!!							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQuery  += " INNER JOIN  " +RetSqlName("BI3") + " BI3 "
		cQuery  += " ON BI3_FILIAL = '"+xFilial("BI3")+"' AND BI3_CODINT = BAX.BAX_CODINT AND BI3_PORTAL <> '2' AND BI3.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT OUTER JOIN " +RetSqlName("BFN") + " BFN "
		cQuery  += " ON BFN.BFN_FILIAL = '"+xFilial("BFN")+"' "
		cQuery  += " AND BFN.BFN_CODINT = BAX.BAX_CODINT "
		cQuery  += " AND BFN.BFN_CODESP = BAX.BAX_CODESP "
		
		//Tratamento para funcoes exclusivas do Oracle e SQL Server.
		If lTemSubEsp
			If AllTrim( TCGetDB() ) $ "ORACLE,DB2"
				cQuery  += " AND instr(TRIM("+cNmCSbEQ+"),BFN.BFN_CODSUB) > 0 "
			Else
				cQuery  += " AND CHARINDEX(BFN.BFN_CODSUB, RTRIM(LTRIM("+cNmCSbEQ+"))) > 0 "
			Endif
		Endif
		
		cQuery  += " AND BFN.D_E_L_E_T_ = ' '	 "
		
		//Area da substituicao de rede...
		
		//Ver se cliente já possui campo de
		//local bloqueado (exclusivo V12
		If B7O->( FieldPos("B7O_LABBLO") ) > 0
			lLocalSubs := .T.
		Endif
		
		cQuery  += " LEFT OUTER JOIN "+RetSQLName("B7O")+" B7O "
		cQuery  += " 	ON B7O_FILIAL = '"+xFilial("B7O")+"' "
		cQuery  += " 	AND B7O_CODRDA = BAU_CODIGO "
		
		If lLocalSubs
			cQuery  += "	AND ( "
			cQuery  += "			( "
			cQuery  += "				B7O.B7O_LABBLO = ' ' AND BAU.BAU_DATBLO <> ' ' "
			cQuery  += " 			) "
			cQuery  += " 			OR "
			cQuery  += " 			( "
			cQuery  += " 				B7O.B7O_LABBLO = BB8.BB8_CODLOC AND BAU.BAU_DATBLO = ' ' "
			cQuery  += " 			) "
			cQuery  += " 		) "
		Endif
		
		cQuery  += " 	AND B7O.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT JOIN "+RetSQLName("BB8")+" BB8SUB "
		cQuery  += " 	ON BB8SUB.BB8_FILIAL = '"+xFilial("BB8")+"' "
		cQuery  += " 	AND BB8SUB.BB8_CODIGO = B7O.B7O_PRESUB "
		
		If lLocalSubs
			cQuery  += " 	AND BB8SUB.BB8_CODLOC = B7O.B7O_LABSUS "
		Endif
		cQuery  += " 	AND BB8SUB.D_E_L_E_T_ = ' ' "
		
		cQuery  += "  LEFT OUTER JOIN "+RetSQLName("BAX")+" BAXSUB "
		cQuery  += " 	ON BAXSUB.BAX_FILIAL = '"+xFilial("BAX")+"'  "
		cQuery  += " 	AND BAXSUB.BAX_CODIGO = BB8SUB.BB8_CODIGO "
		cQuery  += " 	AND BAXSUB.BAX_CODLOC = BB8SUB.BB8_CODLOC "
		If lEspIguExc
			cQuery  += " 	AND BAXSUB.BAX_CODESP = BAX.BAX_CODESP "
		Endif
		cQuery  += " 	AND BAXSUB.D_E_L_E_T_ = ' '  "
		cQuery  += " 	AND BAXSUB.BAX_GUIMED <> '0'  "
		cQuery  += " 	AND BAXSUB.D_E_L_E_T_ = ' '  "
		
		
		cQuery  += "  LEFT OUTER JOIN "+RetSQLName("BAU")+" BAUSUB  "
		cQuery  += "  	ON BAUSUB.BAU_FILIAL = '"+xFilial("BAU")+"'  "
		cQuery  += "  	AND BAUSUB.BAU_CODIGO = BAXSUB.BAX_CODIGO  "
		cQuery  += "  	AND BAUSUB.BAU_GUIMED <> '0'  "
		cQuery  += "  	AND BAUSUB.D_E_L_E_T_ = ' '  "
		
		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 02/02/2018
		//---------------------------------------------------------------------
		//Acrescentado mais um filtro para agilizar a query
		//---------------------------------------------------------------------
		cQuery  += "  	AND BAUSUB.BAU_TIPPRE IN (" + cClassesOk + ")"
		
		cQuery  += " LEFT OUTER JOIN "+RetSQLName("BFN")+" BFNSUB "
		cQuery  += " 	ON BFNSUB.BFN_FILIAL = '"+xFilial("BFN")+"' "
		cQuery  += " 	AND BFNSUB.BFN_CODINT = BAXSUB.BAX_CODINT "
		cQuery  += " 	AND BFNSUB.BFN_CODESP = BAXSUB.BAX_CODESP "
		cQuery  += " 	AND BFNSUB.D_E_L_E_T_ = ' ' "
		
		cQuery  += " LEFT OUTER JOIN " +RetSqlName("BAQ")+" BAQSUB "
		cQuery  += " ON BAQSUB.BAQ_FILIAL = '"+xFilial("BAQ")+"' AND BAXSUB.BAX_CODINT = BAQSUB.BAQ_CODINT AND BAXSUB.BAX_CODESP = BAQSUB.BAQ_CODESP AND BAQSUB.D_E_L_E_T_ = ' ' "
		
		If lFldFaceb
			cQuery  += " AND BAQSUB.BAQ_ENVGUI <> '0' "
		Endif
		
		
		//Fim da area de subst de rede...
		
		cQuery  += " WHERE BAX.D_E_L_E_T_ = ' ' AND BAQ.D_E_L_E_T_ = ' ' AND BB8.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = ' ' "
		cQuery  += " AND BAX.BAX_GUIMED <> '0' AND BAU.BAU_GUIMED <> '0' AND BB8.BB8_GUIMED <> '0' "
		
		// Adiciona filtro para buscar somente Sub-especialidade 
		cQuery  += " AND BAX.BAX_CODSUB <> ' ' "
	
		cQuery  += " AND BAX.BAX_DATINC <= '"+DtoS(dDataBase)+"' "
		cQuery  += " AND BAU.BAU_DTINCL BETWEEN '"+ DtoS(mv_par01)+"' AND '" +DtoS(mv_par02)+ "' "
		cQuery  += " AND BAU.BAU_CODIGO BETWEEN '"+ mv_par05+"' AND '" +mv_par06+ "' "
		
		cQuery  += " 	AND ( BI3_ALLRED = '1' OR "
		cQuery  += " ( "
		cQuery  += " 	SELECT COUNT(BB6.R_E_C_N_O_)  FROM "+RetSqlName("BB6")+" BB6, "+RetSqlName("BBK")+" BBK "
		cQuery  += " 	WHERE BB6_FILIAL = '"+xFilial("BD6")+"' "
		cQuery  += " 	AND BI3_CODINT = SUBSTR(BB6_CODIGO,1,4) "
		cQuery  += " 	AND BI3_CODIGO = SUBSTR(BB6_CODIGO,5,4) "
		cQuery  += " 	AND BI3_VERSAO = BB6_VERSAO "
		cQuery  += " 	AND BB6.D_E_L_E_T_ = ' ' "
		cQuery  += " 	AND BBK_FILIAL = '"+xFilial("BBK")+"' "
		cQuery  += " 	AND BBK_CODIGO = BAX.BAX_CODIGO "
		cQuery  += " 	AND BBK_CODLOC = BAX.BAX_CODLOC "
		cQuery  += " 	AND BBK_CODESP = BAX.BAX_CODESP "
		cQuery  += " 	AND BBK_CODSUB = BAX.BAX_CODSUB "
		If Existblock("MSBBKQRY")
			cQuery += Execblock("MSBBKQRY", .f., .f., {})
		Endif
		cQuery  += " 	AND BBK.BBK_CODRED = BB6.BB6_CODRED "
		//MOTTA 3/5/19 COMP COM LIVRO TOTVS
		cQuery  += " 	AND BBK_YDIVUL = '1' "
		//FIM MOTTA 3/5/19
		cQuery  += " 	AND BBK.D_E_L_E_T_ = ' '
		cQuery  += " 	) > 0 "
		cQuery  += " ) )"
		
//***************************** FIM DA ALETRAÇAO *******************************************************/
		
		
		If lNomFanta
			cQuery  += " ORDER BY BAU_NFANTA, BAX_CODESP, BAX_CODLOC, BI3_CODIGO "
		Else
			cQuery  += " ORDER BY BAU_NOME, BAX_CODESP, BAX_CODLOC, BI3_CODIGO "
		Endif
		
		//-------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data:06/02/2018
		//-------------------------------------------------------------------------------------------------------
		//Retirado o ChangeQuery para maximizar a rotina, a Query foi alterada para o ORACLE
		//-------------------------------------------------------------------------------------------------------  
		//cQuery := ChangeQuery(cQuery)
		
		MemoWrite("C:\MICROSIGA\QRYPRIN_MOBILESAUDE.SQL", cQuery)
		
		TcQuery cQuery Alias "QRYPRIN" New
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Preparo arrays para impressao de arquivos de detalhe... ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aPlanos := {}
		aClasses := {}
		aCorpoCli := {}
		
		BBI->(DbSetOrder(1)) //BBI_FILIAL + BBI_CODIGO + BBI_CODINT + BBI_CODLOC + BBI_CODESP + BBI_CODPRO + BBI_VERSAO
		BII->(DbSetOrder(1)) //BII_FILIAL + BII_CODIGO
		BFN->(DbSetOrder(1)) //BFN_FILIAL + BFN_CODINT + BFN_CODESP + BFN_CODSUB
		BAQ->(DbSetOrder(1)) //BAQ_FILIAL + BAQ_CODINT + BAQ_CODESP
		BAG->(DbSetOrder(1)) //BAG_FILIAL + BAG_CODIGO
		lPrima := .T.
		
		If lAcredit
			cNmArqAc := AllTrim(mv_par07) + "GM_MS_qualificacao"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
			nHdlAcr	:= FCREATE( cNmArqAc )
			cExtracao := CHR(34)+"cpf_cnpj"+CHR(34)+";"
			cExtracao += CHR(34)+"codigo_cbo"+CHR(34)+";"
			cExtracao += CHR(34)+"sequencial_endereco"+CHR(34)+";"
			cExtracao += CHR(34)+"codigo_acreditacao"+CHR(34)+";"
			cExtracao += CHR(34)+"resumo_qualificacao"+CHR(34)+";"
			cExtracao += CHR(34)+"detalhe_qualificacao"+CHR(34)+";"
			cExtracao += CHR(34)+"data_inicial"+CHR(34)+";"
			cExtracao += CHR(34)+"data_final"+CHR(34)+";"
			cExtracao += CHR(34)+"operacao"+CHR(34)+";"
			cExtracao += CHR(34)+"versao_layout"+CHR(34)+";"
			cExtracao += CHR(13)+CHR(10)
			FWRITE ( nHdlAcr , cExtracao )
		Endif
		
		cExtracao := ""
		
		While !QRYPRIN->(Eof())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Regras para evitar a exportacao de dados incorretos. Gerar CRIGEN com o resultado...   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			//---------------------------------------------------------------------
			//Inicio - Angelo Henrique - Data: 02/02/2018
			//---------------------------------------------------------------------
			//Retirado a validação abaixo e colocado na query
			//acelerando assim o processo
			//---------------------------------------------------------------------
			/*
			if !Empty(Alltrim(cClassesOk))
				If  ! QRYPRIN->BAU_TIPPRE $ cClassesOk
					QRYPRIN->(DbSkip())
					Loop
				Endif
			Endif
			*/
			//---------------------------------------------------------------------
			//Fim - Angelo Henrique - Data: 02/02/2018
			//---------------------------------------------------------------------
			
			lErroRDA := .F.
			If Empty(Alltrim(BB8_END))
				lErroRDA := .T.
				Aadd(aErrosRDA, {QRYPRIN->(BAU_CODIGO+"/"+BAX_CODLOC+"/"+BAX_CODESP), QRYPRIN->BAU_NOME, "Campo de endereço (BB8_END) em branco."})
				
			Endif
			
			If Empty(Alltrim(BB8_NR_END))
				lErroRDA := .T.
				Aadd(aErrosRDA, {QRYPRIN->(BAU_CODIGO+"/"+BAX_CODLOC+"/"+BAX_CODESP), QRYPRIN->BAU_NOME, "Campo de numero do endereço (BB8_NR_END) em branco."})
			Endif
			
			If Empty(Alltrim(BB8_BAIRRO))
				lErroRDA := .T.
				Aadd(aErrosRDA, {QRYPRIN->(BAU_CODIGO+"/"+BAX_CODLOC+"/"+BAX_CODESP), QRYPRIN->BAU_NOME, "Campo de bairro (BB8_BAIRRO) em branco."})
			Endif
			
			If Empty(Alltrim(BB8_MUN))
				lErroRDA := .T.
				Aadd(aErrosRDA, {QRYPRIN->(BAU_CODIGO+"/"+BAX_CODLOC+"/"+BAX_CODESP), QRYPRIN->BAU_NOME, "Campo de municipio (BB8_MUN) em branco."})
			Endif
			
			If Empty(Alltrim(BB8_EST))
				lErroRDA := .T.
				Aadd(aErrosRDA, {QRYPRIN->(BAU_CODIGO+"/"+BAX_CODLOC+"/"+BAX_CODESP), QRYPRIN->BAU_NOME, "Campo de estado (BB8_EST) em branco."})
			Endif
			
			
			//Se teve erro, skip e loop
			If lErroRDA
				QRYPRIN->(DbSkip())
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Tratar planos que estao excluidos do RDA diretamente, atraves da BBI e Redes Referenciadas ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//BBI_FILIAL + BBI_CODIGO + BBI_CODINT + BBI_CODLOC + BBI_CODESP + BBI_CODPRO + BBI_VERSAO
			lPassou := .F.
			
			//-------------------------------------------------------------------------------------------------------
			//Inicio - Angelo Henrique - Data:06/02/2018
			//-------------------------------------------------------------------------------------------------------
			//Validação retirada, pois já é feito na query, não perdendo tempo aqui
			//-------------------------------------------------------------------------------------------------------
			/*
			If QRYPRIN->BI3_ALLRED <> "1"
				
				BBI->(MsSeek(xFilial("BBI")+QRYPRIN->(BAU_CODIGO+BAX_CODINT+BAX_CODLOC+BAX_CODESP+BI3_CODIGO+BI3_VERSAO)))
				
				While !BBI->(Eof()) .And. QRYPRIN->(BAU_CODIGO+BAX_CODINT+BAX_CODLOC+BAX_CODESP+BI3_CODIGO+BI3_VERSAO) == BBI->(BBI_CODIGO + BBI_CODINT + BBI_CODLOC + BBI_CODESP + BBI_CODPRO + BBI_VERSAO)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Checa a validade e passa o registro principal caso plano nao permitido. ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If dDataBase < BBI->BBI_VIGATE .Or. Empty(BBI->BBI_VIGATE)
						If Empty(BBI->BBI_VIGDE) .Or. dDataBase > BBI->BBI_VIGDE
							If (BBI->BBI_ATIVO == "0")  .Or. (BBI->BBI_GUIMED == "0")
								QRYPRIN->(DbSkip())
								lPassou := .T.
								Exit
							Endif
						Endif
					Endif
					
					BBI->(DbSkip())
					
				Enddo
				
				If lPassou
					Loop
				Endif
				
			Endif
			*/
			//-------------------------------------------------------------------------------------------------------
			//Fim - Angelo Henrique - Data:06/02/2018
			//-------------------------------------------------------------------------------------------------------
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Remover registros que estejam fora do criterio de dias de bloqueio informados no parametro ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(QRYPRIN->BAU_DATBLO)
				dDatBlqTmp := StoD(QRYPRIN->BAU_DATBLO)
				If dDatBlqTmp < dDataBase-nDiBlqAnt .Or. dDatBlqTmp > dDataBase+nDiBlqPos
					QRYPRIN->(DbSkip())
					Loop
				Endif
				
			Endif
			
			If !Empty(QRYPRIN->BAX_DATBLO)
				dDatBlqTmp := StoD(QRYPRIN->BAX_DATBLO)
				If dDatBlqTmp < dDataBase-nDiBlqAnt .Or. dDatBlqTmp > dDataBase+nDiBlqPos
					QRYPRIN->(DbSkip())
					Loop
				Endif
			Endif
			
			If !Empty(QRYPRIN->BB8_DATBLO)
				dDatBlqTmp := StoD(QRYPRIN->BB8_DATBLO)
				If dDatBlqTmp < dDataBase-nDiBlqAnt .Or. dDatBlqTmp > dDataBase+nDiBlqPos
					QRYPRIN->(DbSkip())
					Loop
				Endif
			Endif
			
			cSexo := " "
			If QRYPRIN->BAU_SEXO == "0"
				cSexo := "M"
			ElseIf QRYPRIN->BAU_SEXO == "1"
				cSexo := "F"
			Endif
			
			cTpLogr	:= ""
			If !Empty(QRYPRIN->BB8_TIPLOG) .And. lUsaTpLog
				cTpLogr := Posicione("B18",1,xFilial("B18")+QRYPRIN->(BB8_TIPLOG),"B18_DESCRI")
			Endif
			
			cNomeRDA := QRYPRIN->BAU_NOME
			cNomeAux := Alltrim(QRYPRIN->BAU_NFANTA)
			cDatBlqRDA := Iif(!Empty(QRYPRIN->BAU_DATBLO),Substr(QRYPRIN->BAU_DATBLO,7,2)+"/"+Substr(QRYPRIN->BAU_DATBLO,5,2)+"/"+Substr(QRYPRIN->BAU_DATBLO,1,4),"")
			cDesBlqRDA := ""
			If lEnvMotBlq
				cDesBlqRDA := Iif(!Empty(cDatBlqRDA),Alltrim(Posicione("BAP",1,xFilial("BAP")+QRYPRIN->(BAU_CODBLO),"BAP_DESCRI")),"")
			Endif
			
			If Empty(cDatBlqRDA) .And. !Empty(QRYPRIN->BAX_DATBLO)
				cDatBlqRDA := Substr(QRYPRIN->BAX_DATBLO,7,2)+"/"+Substr(QRYPRIN->BAX_DATBLO,5,2)+"/"+Substr(QRYPRIN->BAX_DATBLO,1,4)
			Endif
			
			If Empty(cDatBlqRDA) .And. !Empty(QRYPRIN->BB8_DATBLO)
				cDatBlqRDA := Substr(QRYPRIN->BB8_DATBLO,7,2)+"/"+Substr(QRYPRIN->BB8_DATBLO,5,2)+"/"+Substr(QRYPRIN->BB8_DATBLO,1,4)
			Endif
			
			
			cCpfCnSubs	:= QRYPRIN->BAUCPFSB
			cCodEspSub	:= QRYPRIN->BAXESPSB
			cClaSubs	:= QRYPRIN->BAUTPPSB
			cSeqEndSub	:= QRYPRIN->BAXLOCSB
			cEmpID		:= ""
			cDtIniAte	:= Iif(!Empty(QRYPRIN->BAX_DATINC),Substr(QRYPRIN->BAX_DATINC,7,2)+"/"+Substr(QRYPRIN->BAX_DATINC,5,2)+"/"+Substr(QRYPRIN->BAX_DATINC,1,4),"")
			
			if lNomFanta .And. !Empty(QRYPRIN->BAU_NFANTA)
				cNomeRda := QRYPRIN->BAU_NFANTA
				cNomeAux := QRYPRIN->BAU_NOME
			Endif
			
			//Temos o campo de nome do local de atendimento para o guia
			If !Empty(cNmLcGui)
				If !Empty(&cNmLcGui)
					cNomeRDA :=  &cNmLcGui
				Endif
				
			Endif
			
			cCodEsp := QRYPRIN->(BAX_CODESP+BAX_CODSUB)
			cCodEsp := Alltrim(cCodEsp)
			cDescEsp := Alltrim(Iif(Empty(QRYPRIN->BAQ_DESGUI),QRYPRIN->BAQ_DESCRI,QRYPRIN->BAQ_DESGUI))
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso esteja preenchida a subesp, trocar o nome da especialidade³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(QRYPRIN->BAX_CODSUB)
				//BFN->(DbSetOrder(1)) //BFN_FILIAL + BFN_CODINT + BFN_CODESP + BFN_CODSUB
				cDescEsp := Alltrim(Posicione("BFN",1,xFilial("BFN")+QRYPRIN->(BAX_CODINT+BAX_CODESP+BAX_CODSUB),"BFN_DESCRI"))
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Traz o alerta do local de atendimento								³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cMsgAlert := QRYPRIN->BB8_YMSGAL
			
			cCodSubEsp := QRYPRIN->BB8_YCDSBE
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Tratamento de descricao de subespecialidade para o guia Mobile.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cDSubTmp := Alltrim(QRYPRIN->DESSBES)
			If !Empty(cDSubTmp) .And. !(cDSubTmp == cDescEsp) .And. !Empty(&cNmCSbE)
				cDescEsp := cDSubTmp
			Endif
			cDSubTmp := ""
			
			cDescEsp := Alltrim(cDescEsp)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Utilizar a especialidade EDI para gerar os codigos de esp. guia³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//Trocar especialidade principal...
			cCodEsp := TrcEspEDI(cCodEsp, cDescEsp)
			
			cCodEspSub := Iif(!Empty(Alltrim(cCpfCnSubs)),cCodEspSub,"")
			
			//Trocar especialidade do substituto...
			If !Empty(cCodEspSub)
				cDesEspSub := Iif(Empty(QRYPRIN->BAQDSGSB),QRYPRIN->BAQDSCSB,QRYPRIN->BAQDSGSB)
				cCodEspSub := TrcEspEDI(cCodEspSub, cDesEspSub)
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se espec substituta estiver vazia, nao manda o subst.   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Empty(cCodEspSub)
				cCpfCnSubs	:= ""
				cCodEspSub	:= ""
				cClaSubs	:= ""
				cSeqEndSub	:= ""
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inclui os registros de planos para futura exportacao... ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := Ascan( aPlanos, { |x| AllTrim(x[1]) == AllTrim(QRYPRIN->(BI3_CODIGO+BI3_VERSAO)) } )
			If nPos == 0
				cFieldDes := Iif(lDescPlano,"BI3_DESCRI","BI3_NREDUZ")
				cDesPla := Alltrim(QRYPRIN->(&cFieldDes))
				
				//Campos para a versao 2.0 do guia medico...
				//CAMPO CRIADO - BI3_SITCOM OU SITANS (PADRAO)
				cNmRegAns	:= Alltrim(QRYPRIN->BI3_SUSEP)
				cClasPla	:= Alltrim(Posicione("BII",1,xFilial("BII")+QRYPRIN->(BI3_TIPCON),"BII_DESCRI"))
				//Trata conforme padronizacao do campo...
				cSitCom 	:= "ATIVO"
				Do Case
					
				Case &cNmCSCom == "1"
					cSitCom		:= "ATIVO"
					
				Case &cNmCSCom == "2"
					cSitCom		:= "ATIVO COMER. SUSPENSA"
					
				Case &cNmCSCom == "3"
					cSitCom		:= 	"CANCELADO"
					
				EndCase
				
				cOrdemPla := ""
				If BI3->( FieldPos("BI3_YORDEX") ) > 0
					If Val(QRYPRIN->BI3_YORDEX) > 0
						cOrdemPla := QRYPRIN->BI3_YORDEX
					Endif
				Endif
				
				aAdd(aPlanos,{QRYPRIN->(BI3_CODIGO+BI3_VERSAO),cDesPla,'S','S',cNmRegAns,cClasPla,cSitCom,cOrdemPla})
				
			Endif
			
			//-----------------------------------------------------------------------------------------------------------
			//Inicio - Angelo Henrique - Data: 06/02/2018
			//-----------------------------------------------------------------------------------------------------------
			//Retirado a inclusão da classe de rede de atendimento e sua descrição para ser utilizado a tabela genérica
			//de agrupamento de livro. (SX5 - Tabela 97)
			//Seguindo chamado aberto pela Márcia Piumbim - Número: 46530
			//-----------------------------------------------------------------------------------------------------------
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inclui os registros de classes de RDA para futura exportacao... ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := Ascan( aClasses, { |x| AllTrim(x[1]) == AllTrim(QRYPRIN->BAU_TIPPRE) } )
			If nPos == 0
				cDesClasse := Alltrim(Posicione("BAG",1,xFilial("BAG")+QRYPRIN->BAU_TIPPRE,"BAG_DESCRI"))
				aAdd(aClasses,{QRYPRIN->BAU_TIPPRE,cDesClasse})
			Endif
			*/
			
			If _lSx5
				
				//----------------------------------------------------------------------------
				//Após passar a primeira vez, não há necesseidade de passar novamente.
				//----------------------------------------------------------------------------
				_lSx5 := .F.
				
				DbSelectArea("SX5")
				DbSetOrder(1) //X5_FILIAL+X5_TABELA+X5_CHAVE
				If DbSeek(xFilial("SX5") + "97")
					
					While SX5->(!EOF()) .And. AllTrim(SX5->X5_TABELA) == "97"
						
						aAdd(aClasses,{AllTrim(SX5->X5_CHAVE),AllTrim(SX5->X5_DESCRI)})
						
						SX5->(DbSkip())
						
					EndDo
					
				EndIf
				
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Linha responsavel pela exportacao dos RDAs...  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lPrima
				lPrima := .F.
				cExtracao := CHR(34)+"codigo_cbo"+CHR(34)+";"
				cExtracao += CHR(34)+"codigo_plano"+CHR(34)+";"
				cExtracao += CHR(34)+"classe_prestador"+CHR(34)+";"
				cExtracao += CHR(34)+"codigo_legado"+CHR(34)+";"
				cExtracao += CHR(34)+"nome_prestador"+CHR(34)+";"
				cExtracao += CHR(34)+"sexo"+CHR(34)+";"
				cExtracao += CHR(34)+"endereco"+CHR(34)+";"
				cExtracao += CHR(34)+"numero"+CHR(34)+";"
				cExtracao += CHR(34)+"complemento"+CHR(34)+";"
				cExtracao += CHR(34)+"bairro"+CHR(34)+";"
				cExtracao += CHR(34)+"codigo_municipio"+CHR(34)+";"
				cExtracao += CHR(34)+"codigo_uf"+CHR(34)+";"
				cExtracao += CHR(34)+"cep"+CHR(34)+";"
				cExtracao += CHR(34)+"telefone_primario"+CHR(34)+";"
				cExtracao += CHR(34)+"telefone_secundario"+CHR(34)+";"
				cExtracao += CHR(34)+"email"+CHR(34)+";"
				cExtracao += CHR(34)+"site_url"+CHR(34)+";"
				cExtracao += CHR(34)+"nome_logomarca"+CHR(34)+";"
				cExtracao += CHR(34)+"cpf_cnpj"+CHR(34)+";"
				cExtracao += CHR(34)+"prioridade"+CHR(34)+";"
				cExtracao += CHR(34)+"latitude"+CHR(34)+";"
				cExtracao += CHR(34)+"longitude"+CHR(34)+";"
				cExtracao += CHR(34)+"sequencial_endereco"+CHR(34)+";"
				cExtracao += CHR(34)+"data_bloqueio"+CHR(34)+";"
				cExtracao += CHR(34)+"motivo_bloqueio"+CHR(34)+";"
				cExtracao += CHR(34)+"operacao"+CHR(34)+";"
				
				If mv_par10 >= 0
					cExtracao += CHR(34)+"versao_layout"+CHR(34)+";"
					cExtracao += CHR(34)+"razao_social"+CHR(34)+";"
					cExtracao += CHR(34)+"sigla_conselho_regional"+CHR(34)+";"
					cExtracao += CHR(34)+"uf_conselho_regional"+CHR(34)+";"
					cExtracao += CHR(34)+"numero_conselho_regional"+CHR(34)+";"
					cExtracao += CHR(34)+"nome_responsavel_tecnico"+CHR(34)+";"
					cExtracao += CHR(34)+"facebook"+CHR(34)+";"
					cExtracao += CHR(34)+"twitter"+CHR(34)+";"
					cExtracao += CHR(34)+"observacoes"+CHR(34)+";"
					cExtracao += CHR(34)+"acessibilidade"+CHR(34)+";"
					cExtracao += CHR(34)+"detalhe_acessibilidade"+CHR(34)+";"
					cExtracao += CHR(34)+"atend_24_horas"+CHR(34)+";"
					cExtracao += CHR(34)+"link_agenda_online"+CHR(34)+";"
					cExtracao += CHR(34)+"secao_resultado"+CHR(34)+";"
					
					cExtracao += CHR(34)+"regime_atendimento"+CHR(34)+";"
					cExtracao += CHR(34)+"cpf_cnpj_subst"+CHR(34)+";"
					cExtracao += CHR(34)+"codigo_CBO_subst"+CHR(34)+";"
					cExtracao += CHR(34)+"classe_prestador_subst"+CHR(34)+";"
					cExtracao += CHR(34)+"sequencial_endereco_subst"+CHR(34)+";"
					cExtracao += CHR(34)+"empresa_id"+CHR(34)+";"
					cExtracao += CHR(34)+"tipo_estab"+CHR(34)+";"
					cExtracao += CHR(34)+"dt_inicio_atend"+CHR(34)+";"
					cExtracao += CHR(34)+"mensagem_alerta"+CHR(34)+";"
					cExtracao += CHR(34)+"codigo_subespecialidade"+CHR(34)+";"
					
				Endif
				cExtracao += CHR(13)+CHR(10)
				
				FWRITE ( nHdl , cExtracao )
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Tratamento dos dados da RDA...				  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aTelefones	:= {}
			lMaisDeUm	:= .F.
			cToken		:= ""
			If Empty(QRYPRIN->BB8_TEL)
				cTel1 := ""
			Else
				// Opa, possui delimitador separando dois ou mais telefones.
				If At("/",Alltrim(QRYPRIN->BB8_TEL)) > 0
					lMaisDeUm := .T.
					cToken := "/"
				Elseif At(";",Alltrim(QRYPRIN->BB8_TEL)) > 0
					lMaisDeUm := .T.
					cToken := ";"
				Else
					lMaisDeUm := .F.
					cToken := ""
				Endif
				
				// Verifica se tem mais de um telefone no mesmo campo
				If lMaisDeUm := .T.
					// Sim, tem mais de um. Separa os dois usando o delimitador como token.
					aTelefones := StrToArray(Alltrim(QRYPRIN->BB8_TEL), cToken)
					
					// Verifica se a sepração deu certo.
					If ValType(aTelefones) == "A" .and. Len(aTelefones) > 0
						// Sim, deu certo. Registra o telefone 1.
						cTel1 := Alltrim(aTelefones[1])
						
						// Verifica se tem mesmo o segundo telefone, pois pode existir o delimitador mas não o conteúdo pós token.
						If Len(aTelefones) > 1 .and. !Empty(aTelefones[2])
							// Sim, existe mesmo o segundo telefone. Registra ele.
							cTel2 := Alltrim(aTelefones[2])
						Else
							// Não existe o segundo. Registra vazio.
							cTel2 := ""
						Endif
					Endif
				Else
					// Não existe o segundo telefone ou não
					cTel1 := Alltrim(QRYPRIN->BB8_TEL)
					cTel2 := ""
				Endif
			Endif
			
			// Se algo improvável acontecer, tenta pegar o telefone de maneira primitiva.
			If Empty(cTel1)
				cTel1 := Alltrim(QRYPRIN->BB8_TEL)
			Endif
			// Adiciona o DDD
			If !Empty(cTel1)
				If !Empty(QRYPRIN->BB8_DDD)
					cTel1 := Alltrim(QRYPRIN->BB8_DDD)+Alltrim(cTel1)
				Endif
			Endif
			
			// Se não existir dois telefones no mesmo campo, utiliza o fax como telefone secundário
			If Empty(cTel2)
				cTel2 := QRYPRIN->BB8_FAX
			Endif
			// Adiciona o DDD ao segundo telefone.
			If !Empty(cTel2)
				If !Empty(QRYPRIN->BB8_DDD)
					cTel2 := Alltrim(QRYPRIN->BB8_DDD)+cTel2
				Endif
			Endif
			
			if SuperGetMv("MV_XEXPOGM",.F. /*lHelp*/,.T. /*Conteúdo*/ ,)
				cEmail := StrTran(StrTran(iif(lEmailRDA,QRYPRIN->BAU_EMAIL,QRYPRIN->BB8_EMAIL),';',','),'"','')
			else
				cEmail := Space(TamSx3("BAU_EMAIL")[1])
			endif
			
			cLatRDA := Alltrim(StrTran(QRYPRIN->BB8_YLATEN ,'.',','))
			cLonRDA := Alltrim(StrTran(QRYPRIN->BB8_YLONEN ,'.',','))
			
			cTpEstS := SX5->(Posicione("SX5",1,xFilial("SX5")+"_T"+QRYPRIN->BB8_YTPESA,"X5_DESCRI"))
			
			cSigCrGui	:= ""
			cEstCrGui	:= ""
			cNumCrGui	:= ""
			cNomDirTec	:= ""
			//Se for pessoa fisica, tem CR...
			If QRYPRIN->BAU_TIPPE == "F"
				
				cSigCrGui	:= AllTrim(QRYPRIN->BAU_SIGLCR)
				cEstCrGui	:= AllTrim(QRYPRIN->BAU_ESTCR)
				cNumCrGui	:= AllTrim(QRYPRIN->BAU_CONREG)
				
				//Se eh PJ pode ter diretor tecnico.
			Else
				cSigCrGui	:= GetNewPar("MV_YSCRGUI","CRM") //Nao tem campo para CR do diretor tecnico, nem UF do diretor tecnico...
				cNumCrGui	:= AllTrim(QRYPRIN->BAU_DIRREG)
				cNomDirTec	:= AllTrim(QRYPRIN->BAU_DIRTEC)
				
			Endif
			
			cFacebook	:= ""
			cTwitter	:= ""
			cObsLoc		:= ""
			cTemAcess	:= ""
			cDetAcess	:= ""
			cAte24H		:= ""
			cDesObsEsp  := ""
			
			cLinkAgOn	:= ""
			cRgAtend	:= ""
			
			If BAU->( FieldPos("BAU_SECRES") ) > 0
				cSessaoRes		:= QRYPRIN->BAU_SECRES
			Else
				cSessaoRes		:= ""
			Endif
			
			//Se existir o campo de FB, significa q o guia eh 2.0
			If lFldFaceb
				cFacebook	:= AllTrim(QRYPRIN->BAU_FACEBO)
				cTwitter	:= AllTrim(QRYPRIN->BAU_TWITTE)
				cObsLoc		:= AllTrim(QRYPRIN->BB8_OBS)
				cTemAcess	:= Alltrim(QRYPRIN->BB8_ACESSI)
				If cTemAcess == "1"
					cTemAcess := "S"
				Else
					If cTemAcess == "0"
						cTemAcess := "N"
					Endif
				Endif
				
				//Temos o campo de observacao de especialidade
				cDesObsEsp := ""
				If !Empty(cObsEsp)
					If !Empty(&cObsEsp)
						cDesObsEsp :=  &cObsEsp
					Endif
				Endif
				
				cObsCompl := cObsLoc+" "+cDesObsEsp
				
				cDetAcess	:= AllTrim(QRYPRIN->BB8_DETACE)
				cAte24H		:= QRYPRIN->BB8_ATE24H
				If cAte24H == "1"
					cAte24H := "S"
				Else
					If cAte24H == "0"
						cAte24H := "N"
					Endif
				Endif
				
			Endif
			
			//Exporta corpo clinico como uma RDA.
			lExCCRda := .F.
			
			If BC1->(FieldPos("BC1_YCCRDA")) > 0
				If BC1->(DbSeek(xFilial("BC1")+QRYPRIN->(BAU_CODIGO+BAX_CODLOC+BAX_CODESP)))
					
					While !BC1->(Eof()) .And. QRYPRIN->(BAU_CODIGO+BAX_CODLOC+BAX_CODESP) == BC1->(BC1_CODIGO+BC1_CODLOC+BC1_CODESP)
						
						If Val(BC1->BC1_YCCRDA) > 0 .and. !Empty(BC1->BC1_CODPRF) //Exporta CC como RDA.
							
							BC1tel		:= cTel1
							BC1email	:= cEmail
							BC1cpf		:= BC1->(BC1_CODIGO+BC1_CODLOC+BC1_CODESP+BC1_CODPRF)
							BC1cep		:= QRYPRIN->BB8_CEP
							BC1end		:= QRYPRIN->BB8_END
							BC1num		:= QRYPRIN->BB8_NR_END
							BC1compl	:= QRYPRIN->BB8_COMEND
							BC1bairro	:= QRYPRIN->BB8_BAIRRO
							BC1cidade	:= QRYPRIN->BB8_CODMUN
							BC1est		:= QRYPRIN->BB8_EST
							
							//BB0_FILIAL+BB0_CODIGO
							If BB0->(DbSeek(xFilial("BB0")+BC1->BC1_CODPRF))
								BC1cpf := Iif(!Empty(BB0->BB0_CGC),BB0->BB0_CGC,BC1cpf)
								
								If BC1->BC1_YCCRDA == "1"  //Somente se cadastro forcar dados do prof.saude
									BC1tel		:= Iif(!Empty(BB0->BB0_TEL),BB0->BB0_TEL,BC1tel)
									BC1email	:= Iif(!Empty(BB0->BB0_EMAIL),BB0->BB0_EMAIL,BC1email)
									BC1cep		:= Iif(!Empty(BB0->BB0_CEP),BB0->BB0_CEP,BC1cep)
									BC1end		:= Iif(!Empty(BB0->BB0_ENDERE),BB0->BB0_ENDERE,BC1end)
									BC1num		:= Iif(!Empty(BB0->BB0_NUMERO),BB0->BB0_NUMERO,BC1num)
									BC1compl	:= Iif(!Empty(BB0->BB0_COMPLE),BB0->BB0_COMPLE ,BC1compl)
									BC1bairro	:= Iif(!Empty(BB0->BB0_BAIRRO),BB0->BB0_BAIRRO,BC1bairro)
									BC1cidade	:= Iif(!Empty(BB0->BB0_CODMUN),BB0->BB0_CODMUN,BC1cidade)
									BC1est		:= UPPER(Iif(!Empty(BB0->BB0_UF),BB0->BB0_UF,BC1est))
								Endif
							Endif
							
							aExpRDA := {}
							aadd(aExpRDA,{"especialidade",Alltrim(cCodEsp)})
							aadd(aExpRDA,{"plano+versao",Alltrim(QRYPRIN->(BI3_CODIGO+BI3_VERSAO))})
							//aadd(aExpRDA,{"classe",Alltrim(QRYPRIN->BAU_TIPPRE)}) -- Angelo Henrique - Data: 06/02/2018
							aadd(aExpRDA,{"classe",Alltrim(QRYPRIN->BAQ_YGPESP)})
							aadd(aExpRDA,{"cod.legado","BC1"+Alltrim(BC1->BC1_CODPRF)})
							aadd(aExpRDA,{"nome",Alltrim(BC1->BC1_NOMPRF)})
							aadd(aExpRDA,{"sexo",Alltrim(cSexo)})
							aadd(aExpRDA,{"endereco",Alltrim(BC1end)})
							aadd(aExpRDA,{"num",Alltrim(BC1num)})
							aadd(aExpRDA,{"compl",Alltrim(BC1compl)})
							aadd(aExpRDA,{"bairro",Alltrim(BC1bairro)})
							aadd(aExpRDA,{"cod.cidade",Alltrim(BC1cidade)})
							aadd(aExpRDA,{"uf",Alltrim(BC1est)})
							aadd(aExpRDA,{"cep",Alltrim(BC1cep)})
							aadd(aExpRDA,{"tel",BC1tel})
							aadd(aExpRDA,{"tel2",cTel2})
							aadd(aExpRDA,{"email",Alltrim(BC1email)})
							aadd(aExpRDA,{"web",Alltrim(QRYPRIN->BB8_WEB)})
							aadd(aExpRDA,{"nomelogomarca",Alltrim("")})
							aadd(aExpRDA,{"cpf",Alltrim(BC1cpf)})
							aadd(aExpRDA,{"prioridade",Alltrim(QRYPRIN->BAU_PRDATN)})
							aadd(aExpRDA,{"lat",Alltrim("")})
							aadd(aExpRDA,{"lon",Alltrim("")})
							aadd(aExpRDA,{"seq.end",Alltrim(QRYPRIN->BAX_CODLOC)})
							aadd(aExpRDA,{"dt.blq.rda",Alltrim(cDatBlqRDA)})
							aadd(aExpRDA,{"des.blq.rda",Alltrim(cDesBlqRDA)})
							aadd(aExpRDA,{"operacao","0"})
							If mv_par10 >= 1
								aadd(aExpRDA,{"versaolayout",Alltrim(cVerLay)})
								aadd(aExpRDA,{"raz.social",Alltrim(cNomeAux)})
								aadd(aExpRDA,{"sigl.resp.tec",Alltrim(cSigCrGui)})
								aadd(aExpRDA,{"uf.resp.tec",Alltrim(cEstCrGui)})
								aadd(aExpRDA,{"nro.resp.tec",Alltrim(cNumCrGui)})
								aadd(aExpRDA,{"nm.resp.tec",Alltrim(cNomDirTec)})
								aadd(aExpRDA,{"facebook",Alltrim(cFacebook)})
								aadd(aExpRDA,{"twitter",Alltrim(cTwitter)})
								aadd(aExpRDA,{"obs.compl",Alltrim(cObsCompl)})
								aadd(aExpRDA,{"acessibilid",Alltrim(cTemAcess)})
								aadd(aExpRDA,{"det.acess",Alltrim(cDetAcess)})
								aadd(aExpRDA,{"atend.24h?",Alltrim(cAte24H)})
								aadd(aExpRDA,{"link agend.",Alltrim(cLinkAgOn)})
								aadd(aExpRDA,{"sessao result.",Alltrim(cSessaoRes)})
								aadd(aExpRDA,{"reg.atend.",Alltrim(cRgAtend)})
								aadd(aExpRDA,{"cpf/cnpj subst",Alltrim(cCpfCnSubs)})
								aadd(aExpRDA,{"espec.subst",Alltrim(cCodEspSub)})
								aadd(aExpRDA,{"classe subst.",Alltrim(cClaSubs)})
								aadd(aExpRDA,{"seq.end.subst",Alltrim(cSeqEndSub)})
								aadd(aExpRDA,{"id.do parceiro",Alltrim(cEmpID)})
								aadd(aExpRDA,{"tipo_estab",""})
								aadd(aExpRDA,{"dt.ini.atend.",Alltrim(cDtIniAte)})
								aadd(aExpRDA,{"mensagem_alerta",Alltrim(cMsgAlert)})
								aadd(aExpRDA,{"codigo_subespecialidade",Alltrim(cCodSubEsp)})
								
								
							Endif
							
							If Existblock("MBEXPRDA")
								aExpRDA := Execblock("MBEXPRDA",.F.,.F.,{aExpRDA,"BC1"})
							Endif
							
							for nExtrCnt := 1 to len(aExpRDA)
								If nExtrCnt == 1
									cExtracao := CHR(34)+aExpRDA[nExtrCnt,2]+CHR(34)+";"
								Else
									cExtracao += CHR(34)+aExpRDA[nExtrCnt,2]+CHR(34)+";"
								Endif
								
							Next
							
							cExtracao += CHR(13)+CHR(10)
							FWRITE ( nHdl , cExtracao )
							lExCCRda := .T.
							
						Endif
						
						BC1->(DbSkip())
						
					Enddo
					
				Endif
			Endif
			
			//Exportar RDA
			If  lExRdaCCRd .Or. (!lExRdaCCRd .And. !lExCCRda)
				
				aExpRDA := {}
				aadd(aExpRDA,{"especialidade",Alltrim(cCodEsp)})
				aadd(aExpRDA,{"plano+versao",Alltrim(QRYPRIN->(BI3_CODIGO+BI3_VERSAO))})
				//aadd(aExpRDA,{"classe",Alltrim(QRYPRIN->BAU_TIPPRE)}) -- Angelo Henrique - Data: 06/02/2018
				aadd(aExpRDA,{"classe",Alltrim(QRYPRIN->BAQ_YGPESP)})
				aadd(aExpRDA,{"cod.legado",Alltrim(QRYPRIN->BAU_CODIGO)})
				aadd(aExpRDA,{"nome",Alltrim(cNomeRDA)})
				aadd(aExpRDA,{"sexo",Alltrim(cSexo)})
				aadd(aExpRDA,{"endereco",Alltrim(cTpLogr)+IIf(Len(Alltrim(cTpLogr))>0,Space(1),"")+Alltrim(QRYPRIN->BB8_END)})
				aadd(aExpRDA,{"num",Alltrim(QRYPRIN->BB8_NR_END)})
				aadd(aExpRDA,{"compl",Alltrim(QRYPRIN->BB8_COMEND)})
				aadd(aExpRDA,{"bairro",Alltrim(QRYPRIN->BB8_BAIRRO)})
				aadd(aExpRDA,{"cod.cidade",Alltrim(QRYPRIN->BB8_CODMUN)})
				aadd(aExpRDA,{"uf",Alltrim(QRYPRIN->BB8_EST)})
				aadd(aExpRDA,{"cep",Alltrim(QRYPRIN->BB8_CEP)})
				aadd(aExpRDA,{"tel",cTel1})
				aadd(aExpRDA,{"tel2",cTel2})
				aadd(aExpRDA,{"email",Alltrim(cEmail)})
				aadd(aExpRDA,{"web",Alltrim(QRYPRIN->BB8_WEB)})
				aadd(aExpRDA,{"nomelogomarca",Alltrim("")})
				aadd(aExpRDA,{"cpf",Alltrim(QRYPRIN->BAU_CPFCGC)})
				aadd(aExpRDA,{"prioridade",Alltrim(QRYPRIN->BAU_PRDATN)})
				aadd(aExpRDA,{"lat",Alltrim(cLatRDA)})
				aadd(aExpRDA,{"lon",Alltrim(cLonRDA)})
				aadd(aExpRDA,{"seq.end",Alltrim(QRYPRIN->BAX_CODLOC)})
				aadd(aExpRDA,{"dt.blq.rda",Alltrim(cDatBlqRDA)})
				aadd(aExpRDA,{"des.blq.rda",Alltrim(cDesBlqRDA)})
				aadd(aExpRDA,{"operacao","0"})
				If mv_par10 >= 1
					aadd(aExpRDA,{"versaolayout",Alltrim(cVerLay)})
					aadd(aExpRDA,{"raz.social",Alltrim(cNomeAux)})
					aadd(aExpRDA,{"sigl.resp.tec",Alltrim(cSigCrGui)})
					aadd(aExpRDA,{"uf.resp.tec",Alltrim(cEstCrGui)})
					aadd(aExpRDA,{"nro.resp.tec",Alltrim(cNumCrGui)})
					aadd(aExpRDA,{"nm.resp.tec",Alltrim(cNomDirTec)})
					aadd(aExpRDA,{"facebook",Alltrim(cFacebook)})
					aadd(aExpRDA,{"twitter",Alltrim(cTwitter)})
					aadd(aExpRDA,{"obs.compl",Alltrim(cObsCompl)})
					aadd(aExpRDA,{"acessibilid",Alltrim(cTemAcess)})
					aadd(aExpRDA,{"det.acess",Alltrim(cDetAcess)})
					aadd(aExpRDA,{"atend.24h?",Alltrim(cAte24H)})
					aadd(aExpRDA,{"link agend.",Alltrim(cLinkAgOn)})
					aadd(aExpRDA,{"sessao result.",Alltrim(cSessaoRes)})
					aadd(aExpRDA,{"reg.atend.",Alltrim(cRgAtend)})
					aadd(aExpRDA,{"cpf/cnpj subst",Alltrim(cCpfCnSubs)})
					aadd(aExpRDA,{"espec.subst",Alltrim(cCodEspSub)})
					aadd(aExpRDA,{"classe subst.",Alltrim(cClaSubs)})
					aadd(aExpRDA,{"seq.end.subst",Alltrim(cSeqEndSub)})
					aadd(aExpRDA,{"id.do parceiro",Alltrim(cEmpID)})
					aadd(aExpRDA,{"tipo_estab",Alltrim(cTpEstS)})
					aadd(aExpRDA,{"dt.ini.atend.",Alltrim(cDtIniAte)})
					aadd(aExpRDA,{"mensagem_alerta",Alltrim(cMsgAlert)})
					aadd(aExpRDA,{"codigo_subespecialidade",Alltrim(cCodSubEsp)})
					
				Endif
				
				If Existblock("MBEXPRDA")
					aExpRDA := Execblock("MBEXPRDA",.F.,.F.,{aExpRDA,"QRYPRIN"})
				Endif
				
				for nExtrCnt := 1 to len(aExpRDA)
					If nExtrCnt == 1
						cExtracao := CHR(34)+aExpRDA[nExtrCnt,2]+CHR(34)+";"
					Else
						cExtracao += CHR(34)+aExpRDA[nExtrCnt,2]+CHR(34)+";"
					Endif
					
				Next
				
				cExtracao += CHR(13)+CHR(10)
				FWRITE ( nHdl , cExtracao )
				
				lExpRDA := .T.
				
			Endif
			
			//Somente exporta o corpo clinico como RDA se o campo estiver
			//BC1_FILIAL+BC1_CODIGO+BC1_CODLOC+BC1_CODESP+BC1_CODPRF
			
			//Incio da area de corpo clinico...
			
			cTel1 := ""
			cTel2 := ""
			
			cQuery  := " SELECT BC1.BC1_CODESP, BC1.BC1_CODSUB, BAU.BAU_NOME NOMERDA, BAU.BAU_NFANTA NOMFANTA, BAUCC.BAU_NOME NOMERDACC, "
			cQuery  += " BB0CC.BB0_CODIGO, BB0CC.BB0_NOME NOMEPROFCC, BC1_SIGLCR, BC1_NUMCR, BC1_ESTCR, BC1.BC1_CODRDA CODIGORDA, BC1.BC1_CODLOC "
			cQuery  += " FROM " +RetSqlName("BC1")+ " BC1 "
			cQuery  += " 					INNER JOIN  " +RetSqlName("BAU")+ " BAU "
			cQuery  += " 					ON BAU.BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.BAU_CODIGO = BC1.BC1_CODIGO AND BAU.D_E_L_E_T_ = ' ' "
			
			cQuery  += " 				LEFT OUTER JOIN  " +RetSqlName("BAU") + " BAUCC "
			cQuery  += " 					ON BAUCC.BAU_FILIAL = '"+xFilial("BAU")+"' AND BAUCC.BAU_CODIGO = BC1.BC1_CODRDA AND BAUCC.D_E_L_E_T_ = ' ' "
			cQuery  += " 				LEFT OUTER JOIN  " +RetSqlName("BB0") + " BB0CC "
			cQuery  += " 					ON BB0CC.BB0_FILIAL = '"+xFilial("BB0")+"' AND BB0CC.BB0_CODIGO = BC1.BC1_CODPRF AND BB0CC.D_E_L_E_T_ = ' ' "
			
			cQuery  += " 			WHERE BC1.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = ' ' "
			cQuery  += " 				AND BC1_CODIGO = '"+QRYPRIN->BAU_CODIGO+"' "
			cQuery  += " 				AND BC1_CODLOC = '"+QRYPRIN->BAX_CODLOC+"' "
			cQuery  += " 				AND BC1_CODESP = '"+QRYPRIN->BAX_CODESP+"' "
			cQuery  += " 				AND BC1_CODSUB = '"+QRYPRIN->BAX_CODSUB+"' "
			If BC1->(FieldPos("BC1_GIAMED")) > 0
				cQuery  += " 				AND BC1_GIAMED = '1' "
			Else
				If BC1->(FieldPos("BC1_YENVGU")) > 0
					cQuery  += " 				AND BC1_YENVGU = '1' "
				Endif
			Endif
			
			If lNomFanta
				cQuery  += " 			ORDER BY BAU.BAU_NFANTA "
			Else
				cQuery  += " 			ORDER BY BAU.BAU_NOME "
			Endif
			
			TcQuery cQuery Alias "QRYCC" New
			
			While !QRYCC->(Eof())
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Corpo Clinico...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cNomeCorpoCli := Iif(Empty(QRYCC->NOMEPROFCC),QRYCC->NOMERDACC,QRYCC->NOMEPROFCC)
				cCdCorpCli	  := Iif(Empty(QRYCC->BB0_CODIGO),'BAU'+QRYCC->CODIGORDA,'BB0'+QRYCC->BB0_CODIGO)
				
				cSgCorpCli	:= Alltrim(QRYCC->BC1_SIGLCR)
				cNrCorpCli	:= Alltrim(QRYCC->BC1_NUMCR)
				cUfCorpCli	:= UPPER(Alltrim(QRYCC->BC1_ESTCR))
				
				nPos := Ascan( aCorpoCli, { |x| AllTrim(x[1])+AllTrim(x[2])+AllTrim(x[3])+AllTrim(x[4]) == AllTrim(cCdCorpCli)+AllTrim(QRYPRIN->BAU_CPFCGC)+AllTrim(QRYPRIN->BAX_CODLOC)+Alltrim(cCodEsp)})
				If nPos == 0
					aAdd(aCorpoCli,{cCdCorpCli,Alltrim(QRYPRIN->BAU_CPFCGC),AllTrim(QRYPRIN->BAX_CODLOC),Alltrim(cCodEsp),;
						Alltrim(cNomeCorpoCli),cSgCorpCli,cUfCorpCli,cNrCorpCli,"0"})
				Endif
				
				QRYCC->(DbSkip())
			enddo
			
			QRYCC->(DbCloseArea())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acreditacao / Qualificacao, desde que seja referente ao Guia 2.0 ou superior...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par10 >= 1
				If lAcredit
					
					//Trava para imprimir mesmo registro para planos diferentes...
					If QRYPRIN->BAU_PRTACD == "S" .Or. QRYPRIN->BAU_NTVISA == "S" .Or. QRYPRIN->BBF_GUIESP == "1" .Or. !Empty(cNmQdMon) .Or. !Empty(cNmResid)
						
						If cChAcrAnt <> Alltrim(QRYPRIN->BAU_CPFCGC)+Alltrim(cCodEsp)+AllTrim(QRYPRIN->BAX_CODLOC)
							cChAcrAnt := Alltrim(QRYPRIN->BAU_CPFCGC)+Alltrim(cCodEsp)+AllTrim(QRYPRIN->BAX_CODLOC)
							
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Acreditacao ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If QRYPRIN->BAU_PRTACD == "S"
								If !Empty(&cNmCAcr) .And. (Empty(Alltrim(QRYPRIN->BAU_NIVACR)) .Or. (QRYPRIN->BAU_NIVACR >= StrZero(mv_par11,1)) )
									
									cSQLTmp := " SELECT DISTINCT RTRIM(X5_CHAVE) X5_CHV, RTRIM(X5_DESCRI) X5_DSC "
									cSQLTmp += " FROM "+RetSQLName("SX5")
									cSQLTmp += " WHERE X5_FILIAL = '"+xFilial("SX5")+"' "
									cSQLTmp += " AND X5_TABELA = 'TG' "
									
									//Tratamento para funcoes exclusivas do Oracle e SQL Server.
									If AllTrim( TCGetDB() ) $ "ORACLE,DB2"
										cSQLTmp += " AND instr(TRIM('"+Alltrim(&cNmCAcr)+"'),TRIM(X5_CHAVE)) > 0 "
									Else
										cSQLTmp += " AND CHARINDEX(RTRIM(X5_CHAVE), RTRIM(LTRIM('"+Alltrim(&cNmCAcr)+"')))>0
									Endif
									
									cSQLTmp += " AND D_E_L_E_T_ = ' ' "
									
									
									TcQuery cSQLTmp Alias "QRYSX5" New
									
									While !QRYSX5->(Eof())
										
										cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"
										cExtracao += CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"
										cExtracao += CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
										cExtracao += CHR(34)+Alltrim(QRYSX5->X5_CHV)+CHR(34)+";"
										cExtracao += CHR(34)+Alltrim(QRYSX5->X5_DSC)+CHR(34)+";"
										cExtracao += CHR(34)+""+CHR(34)+";"
										cExtracao += CHR(34)+""+CHR(34)+";"
										cExtracao += CHR(34)+""+CHR(34)+";"
										cExtracao += CHR(34)+"0"+CHR(34)+";"
										cExtracao += CHR(34)+cVerLay+CHR(34)+";"
										cExtracao += CHR(13)+CHR(10)
										FWRITE ( nHdlAcr , cExtracao )
										
										QRYSX5->(DbSkip())
									Enddo
									
									
									QRYSX5->(DbCloseArea())
								Endif
							Endif
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Notivisa? ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
							If QRYPRIN->BAU_NTVISA == "S"
								If SX5->(dbSeek(xFilial("SX5")+"ZJ"+"N "))
									cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"+CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"+CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
									cExtracao += CHR(34)+"N"+CHR(34)+";"+CHR(34)+Alltrim(SX5->X5_DESCRI)+CHR(34)+";"+CHR(34)+""+CHR(34)+";"
									cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)+""+CHR(34)+";"+CHR(34)+"0"+CHR(34)+";"
									cExtracao += CHR(34)+cVerLay+CHR(34)+";"
									cExtracao += CHR(13)+CHR(10)
									FWRITE ( nHdlAcr , cExtracao )
								Endif
							Endif
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Qualificacao ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Programa de qualificacao para prestadores: nao disponivel no Protheus. ³
							//³ Residencia: ainda nao disponivel no Protheus. 						   ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Pos-graduacao ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If QRYPRIN->BBF_POSGRA == "1" .And. QRYPRIN->BBF_GUIESP == "1"
								
								If SX5->(dbSeek(xFilial("SX5")+"ZJ"+"P "))
									cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"+CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"+CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
									cExtracao += CHR(34)+"P"+CHR(34)+";"+CHR(34)+Alltrim(SX5->X5_DESCRI)+CHR(34)+";"+CHR(34)+""+CHR(34)+";"
									cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)+""+CHR(34)+";"+CHR(34)+"0"+CHR(34)+";"
									cExtracao += CHR(34)+cVerLay+CHR(34)+";"
									cExtracao += CHR(13)+CHR(10)
									FWRITE ( nHdlAcr , cExtracao )
								Endif
								
							Endif
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Se nao vazio, temos campo de Qualificacao ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If !Empty(cNmQdMon)
								If QRYPRIN->BAU_QUAMON == "1"
									If SX5->(dbSeek(xFilial("SX5")+"ZJ"+"Q "))
										cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"+CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"+CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
										cExtracao +`= CHR(34)+"Q"+CHR(34)+";"+CHR(34)+Alltrim(SX5->X5_DESCRI)+CHR(34)+";"+CHR(34)+""+CHR(34)+";"
										cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)+""+CHR(34)+";"+CHR(34)+"0"+CHR(34)+";"
										cExtracao += CHR(34)+cVerLay+CHR(34)+";"
										cExtracao += CHR(13)+CHR(10)
										FWRITE ( nHdlAcr , cExtracao )
									Endif
								Endif
							Endif
							
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Se nao vazio, temos campo de Residencia   ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If !Empty(cNmResid)
								If QRYPRIN->BAU_RESIDE == "1"
									If SX5->(dbSeek(xFilial("SX5")+"ZJ"+"R "))
										cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"+CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"+CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
										cExtracao += CHR(34)+"R"+CHR(34)+";"+CHR(34)+Alltrim(SX5->X5_DESCRI)+CHR(34)+";"+CHR(34)+""+CHR(34)+";"
										cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)+""+CHR(34)+";"+CHR(34)+"0"+CHR(34)+";"
										cExtracao += CHR(34)+cVerLay+CHR(34)+";"
										cExtracao += CHR(13)+CHR(10)
										FWRITE ( nHdlAcr , cExtracao )
									Endif
								Endif
							Endif
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Titulo de especialista ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If QRYPRIN->BBF_TITESP == "1" .And. QRYPRIN->BBF_GUIESP == "1"
								
								If SX5->(dbSeek(xFilial("SX5")+"ZJ"+"E "))
									cExtracao := CHR(34)+Alltrim(QRYPRIN->BAU_CPFCGC)+CHR(34)+";"
									cExtracao += CHR(34)+Alltrim(cCodEsp)+CHR(34)+";"
									cExtracao += CHR(34)+AllTrim(QRYPRIN->BAX_CODLOC)+CHR(34)+";"
									cExtracao += CHR(34)+"E"+CHR(34)+";"
									cExtracao += CHR(34)+Alltrim(SX5->X5_DESCRI)+CHR(34)+";"
									cExtracao += CHR(34)+QRYPRIN->BBF_LOCAL+iif(!Empty(QRYPRIN->BBF_RQE)," RQE Nro: "+QRYPRIN->BBF_RQE,"")+CHR(34)+";"
									cExtracao += CHR(34)+""+CHR(34)+";"
									cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)
									cExtracao += "0"+CHR(34)+";"
									cExtracao += CHR(34)+cVerLay+CHR(34)+";"
									cExtracao += CHR(13)+CHR(10)
									FWRITE ( nHdlAcr , cExtracao )
								Endif
								
							Endif
							
						Endif
					Endif
					
				Endif
				
			Endif
			
			QRYPRIN->(DbSkip())
			
		EndDo
		
		cChAcrAnt := ""
		QRYPRIN->(DbCloseArea())
		
		FCLOSE ( nHdl )
		FCLOSE ( nHdlAcr )
		
	else
		Alert("O arquivo de exportação não pode ser criado. Entre em contato com o administrador do sistema.")
	endif
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exportar os arquivos auxiliares...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Especialidades...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNmArqEs := AllTrim(mv_par07) + "GM_MS_Espec"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
	nHdl := FCREATE( cNmArqEs )
	if nHdl <> -1
		
		cExtracao := CHR(34)+"codigo_CBO"+CHR(34)+";"+CHR(34)+"descricao"+CHR(34)+";"
		
		If mv_par10 >= 1
			cExtracao += CHR(34)+"versao_layout"+CHR(34)+";"
		Endif
		
		cExtracao+= CHR(13)+CHR(10)
		
		FWRITE ( nHdl , cExtracao )
		
		BUL->(DbSetOrder(1))
		BUL->(DbSeek(xfilial("BUL")+"M"))
		While !BUL->(Eof()) .And. Substr(BUL->BUL_CODESP,1,1)=="M"
			
			cExtracao := CHR(34)+Alltrim(BUL->BUL_CODESP)+CHR(34)+";"+CHR(34)+Alltrim(BUL->BUL_DESESP)+CHR(34)+";"
			
			If mv_par10 >= 1
				cExtracao+= CHR(34)+cVerLay+CHR(34)+";"
			Endif
			cExtracao+= CHR(13)+CHR(10)
			FWRITE ( nHdl , cExtracao )
			
			BUL->(DbSkip())
			
		Enddo
		FCLOSE ( nHdl )
	Else
		If lSched
			QOut("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Especialidade! Verifique!!!")
		Else
			MsgAlert("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Especialidade! Verifique!!!")
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄ¿
	//³ Planos...³
	//ÀÄÄÄÄÄÄÄÄÄÄÙ
	cNmArqPl := AllTrim(mv_par07) + "GM_MS_Planos"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
	nHdl := FCREATE(cNmArqPl )
	if nHdl <> -1
		
		cExtracao := CHR(34)+"codigo_legado"+CHR(34)+";"+CHR(34)+"descricao"+CHR(34)+";"
		cExtracao += CHR(34)+"eletivo"+CHR(34)+";"+CHR(34)+"emergencia"+CHR(34)+";"
		
		If mv_par10 >= 1
			cExtracao += CHR(34)+"versao_layout"+CHR(34)+";"
			cExtracao += CHR(34)+"registro_plano_ans"+CHR(34)+";"
			cExtracao += CHR(34)+"classificacao_para_fins_comercializacao"+CHR(34)+";"
			cExtracao += CHR(34)+"situacao_plano_comercializacao"+CHR(34)+";"
			cExtracao += CHR(34)+"ordem_apresentacao"+CHR(34)+";"
		Endif
		
		cExtracao += CHR(13)+CHR(10)
		
		FWRITE ( nHdl , cExtracao )
		
		For nCont := 1 to Len(aPlanos)
			cExtracao := CHR(34)+aPlanos[nCont,1]+CHR(34)+";"
			cExtracao += CHR(34)+aPlanos[nCont,2]+CHR(34)+";"
			cExtracao += CHR(34)+aPlanos[nCont,3]+CHR(34)+";"
			cExtracao += CHR(34)+aPlanos[nCont,4]+CHR(34)+";"
			
			If mv_par10 >= 1
				cExtracao += CHR(34)+cVerLay+CHR(34)+";"
				cExtracao += CHR(34)+aPlanos[nCont,5]+CHR(34)+";"
				cExtracao += CHR(34)+aPlanos[nCont,6]+CHR(34)+";"
				cExtracao += CHR(34)+aPlanos[nCont,7]+CHR(34)+";"
				cExtracao += CHR(34)+aPlanos[nCont,8]+CHR(34)+";"
			Endif
			
			cExtracao += CHR(13)+CHR(10)
			FWRITE ( nHdl , cExtracao )
		Next
		FCLOSE ( nHdl )
	Else
		If lSched
			QOut("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Planos! Verifique!!!")
		Else
			MsgAlert("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Planos! Verifique!!!")
		Endif
	Endif
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tipo Prestador...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNmArqTp := AllTrim(mv_par07) + "GM_MS_TpRede"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
	nHdl := FCREATE( cNmArqTp )
	if nHdl <> -1
		
		cExtracao := CHR(34)+"classe"+CHR(34)+";"+CHR(34)+"descricao"+CHR(34)+";"
		
		If mv_par10 >= 1
			cExtracao += CHR(34)+"versao_layout"+CHR(34)
		Endif
		
		cExtracao += CHR(13)+CHR(10)
		FWRITE ( nHdl , cExtracao )
		
		For nCont := 1 to Len(aClasses)
			cExtracao := CHR(34)+aClasses[nCont,1]+CHR(34)+";"+CHR(34)+aClasses[nCont,2]+CHR(34)+";"
			
			If mv_par10 >= 1
				cExtracao += CHR(34)+cVerLay+CHR(34)+";"
			Endif
			
			cExtracao += CHR(13)+CHR(10)
			FWRITE ( nHdl , cExtracao )
		Next
		FCLOSE ( nHdl )
	Else
		If lSched
			QOut("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Classes de RDA! Verifique!!!")
		Else
			MsgAlert("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Classes de RDA! Verifique!!!")
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Corpo Clinico... ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNmArqCC :=AllTrim(mv_par07) + "GM_MS_CorpoCli"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv"
	nHdl := FCREATE(cNmArqCC)
	
	if nHdl <> -1
		
		cExtracao := CHR(34)+"codigo_legado"+CHR(34)+";"+CHR(34)+"cpf_cnpj"+CHR(34)+";"+CHR(34)+"codigo_cbo"+CHR(34)+";"+CHR(34)+"nome"+CHR(34)+";"
		cExtracao += CHR(34)+"sequencial_endereco"+CHR(34)+";"
		cExtracao += CHR(34)+"data_bloqueio"+CHR(34)+";"+CHR(34)+"motivo_bloqueio"+CHR(34)+";"+CHR(34)+"operacao"+CHR(34)+";"
		
		If mv_par10 >= 1
			cExtracao += CHR(34)+"versao_layout"+CHR(34)+";"+CHR(34)+"sigla_conselho_regional"+CHR(34)+";"+CHR(34)+"uf_conselho_regional"+CHR(34)+";"
			cExtracao += CHR(34)+"numero_conselho_regional"+CHR(34)+";"
		Endif
		
		cExtracao += CHR(13)+CHR(10)
		FWRITE ( nHdl , cExtracao )
		
		For nCont := 1 to Len(aCorpoCli)
			cExtracao := CHR(34)+aCorpoCli[nCont,1]+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,2]+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,4]+CHR(34)+";"
			cExtracao += CHR(34)+aCorpoCli[nCont,5]+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,3]+CHR(34)+";"
			cExtracao += CHR(34)+""+CHR(34)+";"+CHR(34)+""+CHR(34)+";"+CHR(34)+"0"+CHR(34)+";"
			
			If mv_par10 >= 1
				cExtracao += CHR(34)+cVerLay+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,6]+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,7]+CHR(34)+";"+CHR(34)+aCorpoCli[nCont,8]+CHR(34)+";"
			Endif
			
			cExtracao += CHR(13)+CHR(10)
			FWRITE ( nHdl , cExtracao )
		Next
		FCLOSE ( nHdl )
	Else
		If lSched
			QOut("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Corpo Clinico! Verifique!!!")
		Else
			MsgAlert("Atencao! Não foi possível criar o arquivo de exportação de detalhes - Corpo Clinico! Verifique!!!")
		Endif
	Endif
	
	cTempoTot := elapTime(cHoraIni,time())
	
	If Len(aErrosRDA) > 0
		If lSched
			nHdltmp	:= FCREATE( AllTrim(mv_par07) + "GM_MS_Criticas"+DtoS(dDataBase)+"_"+StrTran(time(),":")+".csv" )
			
			cExtracao := "Codigo;Nome RDA;Falha encontrada;RDAs nao exportados;"+ CHR(13)+CHR(10)
			FWRITE ( nHdltmp , cExtracao )
			
			For nCtn1 := 1 to Len(aErrosRDA)
				cExtracao := aErrosRDA[nCtn1,1]+";"+aErrosRDA[nCtn1,2]+";"+aErrosRDA[nCtn1,3]+";"+CHR(13)+CHR(10)
				FWRITE ( nHdltmp , cExtracao )
			Next
			
		Else
			PLSCRIGEN(aErrosRDA,{ 	{"Codigo","@!", 70},{"Nome RDA","@!", 300 },{"Falha encontrada","@!", 300 }},"Prestadores que nao foram exportados")
		Endif
	Endif
	
	aErrosRDA := {}
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Zerar matrizes...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aPlanos := {}
	aClasses := {}
	aCorpoCli := {}
	
	If !lExpRDA
		FERASE(cNmArqPl)
		FERASE(cNmArqTp)
		FERASE(cNmArqEs)
		FERASE(cNmArqAc)
		FERASE(cNmArqCC)
		FERASE(cNmArqPr)
		If lSched
			QOut("Nenhum registro foi exportado.")
		Else
			MsgAlert("Nenhum registro foi exportado.")
		Endif
	Else
		nRetWin := 0
		cZNmArqPl	:= Substr(cNmArqPl,1,At(".",cNmArqPl)-1)
		cZNmArqTp	:= Substr(cNmArqTp,1,At(".",cNmArqTp)-1)
		cZNmArqEs	:= Substr(cNmArqEs,1,At(".",cNmArqEs)-1)
		cZNmArqAc	:= Substr(cNmArqAc,1,At(".",cNmArqAc)-1)
		cZNmArqCC	:= Substr(cNmArqCC,1,At(".",cNmArqCC)-1)
		cZNmArqPr	:= Substr(cNmArqPr,1,At(".",cNmArqPr)-1)
		
		cCmdTmp1 := "ZIP "+cZNmArqPl+" "+cNmArqPl
		cCmdTmp2 := "ZIP "+cZNmArqTp+" "+cNmArqTp
		cCmdTmp3 := "ZIP "+cZNmArqEs+" "+cNmArqEs
		cCmdTmp4 := "ZIP "+cZNmArqAc+" "+cNmArqAc
		cCmdTmp5 := "ZIP "+cZNmArqCC+" "+cNmArqCC
		cCmdTmp6 := "ZIP "+cZNmArqPr+" "+cNmArqPr
		
		nRetWin += WinExec(cCmdTmp1)
		nRetWin += WinExec(cCmdTmp2)
		nRetWin += WinExec(cCmdTmp3)
		nRetWin += WinExec(cCmdTmp4)
		nRetWin += WinExec(cCmdTmp5)
		nRetWin += WinExec(cCmdTmp6)
		
		If nRetWin > 0
			If lSched
				QOut("Um ou mais arquivos nao puderam ser compactados. Verifique!")
			Else
				MsgAlert("Um ou mais arquivos nao puderam ser compactados. Verifique!")
			Endif
		Endif
		
	Endif
	
	cQuery := ""
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EXPOGM20  ºAutor  ³Mobile Saude        º Data ³  05/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VldRDASbs(cCodRDA)
	Local lReturn := Empty(cCodRDA)
	Local cRdaPri := M->BC4_CODCRE
	
	If !Empty(cCodRDA)
		BAU->(DbSetOrder(1))
		lReturn := BAU->(DbSeek(xFilial("BAU")+cCodRDA))
	Endif
	
	//Retornar para RDA original, evitando problemas no sistema
	BAU->(DbSeek(xFilial("BAU")+cRdaPri))
	
Return lReturn


//Raios

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EXPOGM20  ºAutor  ³Mobile Saude        º Data ³  05/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TrcEspEDI(cCodEsp, cDescEsp)
	
	//BUL_FILIAL + BUL_DESESP
	BUL->(DbSetOrder(2))
	If BUL->(DbSeek(xFilial("BUL")+cDescEsp))
		While Alltrim(BUL->BUL_DESESP) == Alltrim(cDescEsp) .And. !BUL->(Eof())
			If (Substr(BUL->BUL_CODESP,1,1)=="M") //O espec. EDI eh da Mobile...
				cCodEsp	:= BUL->BUL_CODESP
				Exit
			Endif
			BUL->(DbSkip())
		Enddo
	Endif
	
	If !Substr(cCodEsp,1,1) == "M"
		BUL->(DbSetOrder(1))
		BUL->(DbGoBottom())
		If Empty(BUL->BUL_CODESP)
			cCodEsp := "M001"
		Else
			cCodEsp := "M"+StrZero(Val(Substr(BUL->BUL_CODESP,2,3))+1,3)
		Endif
		BUL->(RecLock("BUL",.T.))
		BUL->BUL_FILIAL := xFilial("BUL")
		BUL->BUL_SEQESP := GETSx8Num("BUL","BUL_SEQESP")
		BUL->BUL_CODESP := cCodEsp
		BUL->BUL_DESESP := cDescEsp
		BUL->(MsUnLock())
		ConfirmSX8()
	Endif
	
Return cCodEsp


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CriaSX1  ºAutor  ³ Mobile Saude		 º Data ³  21/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Criar parametros para a execução do programa             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Totvs                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1()
	
	PutSx1(cPerg,"01","Dt. Inclusão de:"	,"","","mv_ch1" ,"D",008,0,0,"G","",""			,"","","mv_par01","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"02","Dt. Inclusão ate:"	,"","","mv_ch2" ,"D",008,0,0,"G","",""			,"","","mv_par02","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"03","Descrição do plano:?","","","mv_ch3" ,"C",01,0,0,"C","","","",""	,"mv_par03","Descrição","","","","Nome Reduz.","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04","Exportar classes:"	,"","","mv_ch4" ,"C",080,0,0,"G","","BYTPLS"	,"","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05","Cod. RDA de:"		,"","","mv_ch5" ,"C",006,0,0,"G","","B36PLS"	,"","","mv_par05","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"06","Cod. RDA ate:"		,"","","mv_ch6" ,"C",006,0,0,"G","","B36PLS"	,"","","mv_par06","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"07","Salvar em:"			,"","","mv_ch7" ,"C",080,0,0,"G","","BB3PLS"	,"","","mv_par07","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"08","Nome da RDA?"		,"","","mv_ch8" ,"C",01,0,0,"C","","","",""	,"mv_par08","Raz.Social","","","","N.Fantasia","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"09","Email virá do:?"		,"","","mv_ch9" ,"C",01,0,0,"C","","","",""	,"mv_par09","Cadastro de RDA","","","","Local de Atend.","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"10","Versão do layout?"	,"","","mv_c10" ,"C",01,0,0,"C","","","",""	,"mv_par10","Versão 1.0","","","","Versão 2.0","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"11","Niv.Minimo Acred?"	,"","","mv_c11" ,"C",01,0,0,"C","","","",""	,"mv_par11","Simples","","","","Pleno","","","Excelência","","","","","","","","",{},{},{})
	PutSx1(cPerg,"12","Env.RDA se CC RDA ?","","","mv_c12" ,"C",01,0,0,"C","","","",""	,"mv_par12","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"13","Nro dias bloq ant?"	,"","","mv_c13" ,"N",05,0,0,"G","","","","" ,"mv_par13","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"14","Nro dias bloq fut?"	,"","","mv_c14" ,"N",05,0,0,"G","","","","" ,"mv_par14","","","","","","","","","","","","","","","","" )
	PutSx1(cPerg,"15","Mesma espec.Subst?"	,"","","mv_c15" ,"C",01,0,0,"C","","","",""	,"mv_par15","Só espec.iguais","","","","Espec.diferentes","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"16","Exporta Mot.Blq ?"	,"","","mv_c16" ,"C",01,0,0,"C","","","",""	,"mv_par16","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
	
	
Return
