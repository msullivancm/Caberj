#INCLUDE "PLSMGER.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF chr(13) + chr(10)

Static nTamChave	:= 	TamSx3('BD6_CODOPE')[1] + TamSx3('BD6_CODLDP')[1] + TamSx3('BD6_CODPEG')[1] + TamSx3('BD6_NUMERO')[1] + TamSx3('BD6_CODRDA')[1] + ;
	TamSx3('BD6_TIPGUI')[1]

Static cChaveGrp 	:= Space(nTamChave)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSRETCP  ºAutor  ³Microsiga           º Data ³  06/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Modifica co-participacao padrao calculada pelo sistema.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSRETCP()

	Local nx := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local aIXBOri 		:= aClone(PARAMIXB)
	//Dados que serao retornados ao PLS
	Local nPerCop  := paramixb[1]  //Percentual (ou e percentual ou e o valor (abaixo), nunca os dois)
	Local nValCop  := paramixb[2]  //Percentual (ou e valor ou e o percentual (acima), nunca os dois)
	Local nTaxa    := paramixb[3]  //Taxa administrativa
	Local nValUs   := paramixb[4]  //Valor da U.S especIfica (se for o caso)
	Local cAlias   := paramixb[5]  //Alias de onde vou encontrado o nivel
	Local lExistia := paramixb[6]  //Tera Co-Participacao ? .T. ou .F.
	Local cPgNoAto := paramixb[7]  //Devera ser pago no ato da emissao da guia (0 ou 1)
	Local cPgDrRDA := paramixb[8]  //Devera ser pago diretamente a RDA (0 ou 1)
	Local nLimFra  := paramixb[9]  //Limite de Franquia

	//Dados para ajudar o analista a implementar suas regras especIficas
	Local cCodInt	:= paramixb[10] //Codigo de sua operadora padrao
	Local cCodEmp	:= paramixb[11] //Empresa do usuario
	Local cMatric	:= paramixb[12] //Matricula do usuario
	Local cTipReg	:= paramixb[13] //Tipo de registro (00,01,02, etc)
	Local cCodPla	:= paramixb[14] //Codigo do plano
	Local cVerPla	:= paramixb[15] //Versao do plano
	Local cOpeOri	:= paramixb[16] //Operadora origem do usuario (dIf de cCodInt quando for atEndimento de intercambio eventual)
	Local dDatPro	:= paramixb[17] //Data do Evento
	Local nQtd		:= paramixb[18] //Quantidade solicitada
	Local cCodPad	:= paramixb[19] //Codigo tipo do procedimento (01,02)  ø
	Local cCodPro	:= paramixb[20] //Codigo do procedimento
	//Local cCodLoc	:= paramixb[21] //Codigo do Local de atEndimento
	Local cCodRda	:= paramixb[22] //Codigo da Rda
	Local lCompra	:= paramixb[23] //Se e uma tentativa de comprar ou nao
	Local cRegAte	:= paramixb[24] //Regime de atEndimento
	Local cCodTabCop:= paramixb[25]  //Codigo da tabela de cobranca especIfica (tde)
	Local bRetorno  := { || {nPerCop,nValCop,nTaxa,nValUs,cAlias,lExistia,cPgNoAto,cPgDrRDA,nLimFra,lCompra,cRegAte,cCodTabCop} }
	//Local cVal     	:= 0
	Local aBA0     	:= BA0->(GetArea())
	Local aBI3     	:= BI3->(GetArea())  //Produtos
	Local aBB2	   	:= BB2->(GetArea())  //Produto x procedimentos autorizados
	Local aBHD	   	:= BHD->(GetArea())  //Copart x procedimentos x produto
	Local aBD6	   	:= BD6->(GetArea())  //Procs x cts medicas
	Local aBE4	   	:= BE4->(GetArea())  //Cabecalho Internacoes
	Local aBHG     	:= BHG->(GetArea())
	Local aBHJ     	:= BHJ->(GetArea())
	Local aBAU		:= BAU->(GetArea()) //RDA
	//Local nDiasBloq  := GetNewPar("MV_PLDIABL",0)

	//Variaveis Caberj...
	Local cDigito  	:= Modulo11(cOpeOri+cCodEmp+cMatric+cTipReg)
	Local nQtdUti  	:= 0
	Local nCont	   	:= 0
	Local aQtd	   	:= {}
	//Local aUtiliza 	:= {}
	//Local lAlterou 	:= .F.
	Local cLDPAtu  	:= BD6->BD6_CODLDP
	Local cPEGAtu  	:= BD6->BD6_CODPEG
	Local cNumAtu  	:= BD6->BD6_NUMERO
	//Local cAnoAtu  	:= BD6->BD6_ANOPAG
	//Local cMesAtu  	:= BD6->BD6_MESPAG
	//Local cHorAtu  	:= BD6->BD6_HORPRO
	Local cCodSol  	:= BD6->BD6_CDPFSO
	//Local cNumGuia 	:= AllTrim(str(val(BD6->BD6_NUMIMP)))
	//Local cOpeRDA  	:= BD6->BD6_OPERDA               //14/04/2011
	Local cCodOpe  	:= BD6->BD6_CODOPE               //28/04/2011
	//Local nPos	   	:= 0
	Local cProBus  	:= cCodPro
	//Local cNivel   	:= 3
	Local nI	   	:= 1
	Local lSolREF  	:= .F.
	Local lGuiVERDE := .F.
	Local lTemCoPF 	:= .T.
	Local lTemAED 	:= .F.
	Local lTemAAG 	:= .F.
	Local lTemMAT 	:= .F.
	Local lTemPGD 	:= .F.
	Local lTemPAL   := .F.
	//Local cPlaAnt	:= "9999"
	//Local cVerAnt	:= "999"
	Local nTamSub	:= 16
	Local nNivel	:= 3
	Local lPFPadrao := .T.
	Local lAltPrc 	:= .F.
	Local aVetCri 	:= {}
	Local aVetTmp	:= {}
	Local nTmpFor 	:= 0
	Local nTmpCri 	:= 0
	Local cCriPrc 	:= GetNewPar("MV_YALTPPF","002,037,035,505,506")
	Local cNovCod 	:= Space(0)
	Local cSQL 		:= ""
	Local cAliasPF 	:= Space(0)
	Local nPerNov 	:= 0
	Local nValNov 	:= 0
	Local bCond1    := { || AnaDataCOP(dDatPro,cAliasPF) }
	Local dDatAnalise
	Local cPLSREGANVE  	:= GetNewPar("MV_PLSRADP","1")
	//Local nVlrMaPF 		:= 0
	//Local lPagDIf 		:= .F.
	Local cGruCob 		:= ""
	//Local cSQL2 		:= ""
	//Local cSQL3 		:= ""
	Local lMedEspec 		:= .F.
	Local lLimpCop 		:= .F.
	//Local _cAlias2		:= GetNextAlias() //Angelo Henrique - Data:11/09/2015
	Local _nVlDias		:= GetMv("MV_XVLDIAS") //Angelo Henrique - Data:10/11/2015
	Local cAlias1 		:= GetNextAlias() //Angelo Henrique - Data:10/11/2015
	Local _lAtuZRT 		:= .F. //Angelo Henrique - Data:10/11/2015
	Local _cMatBa1		:= "" //Angelo Henrique - Data:10/11/2015
	Local _cMatBF4		:= "" //Angelo Henrique - Data:10/11/2015
	Local _aArBA1 		:= BA1->(GetArea()) //Angelo Henrique - Data:10/11/2015
	Local _aArBD6 		:= BD6->(GetArea()) //Angelo Henrique - Data:10/11/2015
	Local _aArBB0 		:= BB0->(GetArea()) //Angelo Henrique - Data:10/11/2015
	Local _aArBF4 		:= BF4->(GetArea()) //Angelo Henrique - Data:10/11/2015
	Local _lNtAtd 		:= .F. //Angelo Henrique - Data:27/01/2016

	Local _lVlDT		:= .F. //Angelo Henrique - Data:08/04/2019
	Local _lVlEx		:= .F. //Angelo Henrique - Data:08/04/2019
	Local _cCodLoc		:= ""  //Angelo Henrique - Data:08/04/2019

	Local cTpSolRef		:= ''//Leonardo Portella - 04/08/14

	//Variaveis Integral
	Local lIntNupre 	 := .F. // Empresas da Integral que tem isenção no Nupre, mas que nao isenta Copart em outros prestadores //Motta mar/12

	//**'INICIO - Marcela Coimbra - Definir como 100% a co-participação para convenio de reciprocidade'**//
	//Local nVlrApr	:= BD6->BD6_VLRPAG

	//**'FIM    - Marcela Coimbra - Definir como 100% a co-participação para convenio de reciprocidade'**//

	Local nVlrBPF	:= BD6->BD6_VLRBPF

	Local _cOrimov := BD6->BD6_ORIMOV
	Local _cSeq	 := BD6->BD6_SEQUEN
	Local _cPad	 := BD6->BD6_CODPAD

	//Leonardo Portella	- 26/02/14 - Inicio
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Chamado ID 10400                                                                                                        ³
	//³Verificar se existe algum procedimento do Grupo 006 e, em caso positivo, NAO coparticipar NENHUM procedimento da guia.  ³
	//³Fiz deste modo preocupado com  a performance e usando a variavel estatica para verificar todos os procedimentos da guia ³
	//³somente 1 vez.                                                                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Local lGrupCopart	:= .T.//Indica se deve coparticipar conforme a regra de grupo
	Local _lAed  := .F. //Angelo Henrique - Data: 27/04/2016 - Validação AED
	Local cProjetos := ""
	Local lIsentou	:= .F. //Bianchini - 29/08/2019 - Variavel criada para impedir de uma regra sobrepor a outra
	Local _cNumCr := ''
	Local cTIPPRE := ""
	Local lTpGuiCp	:= .F.
	Local nRecBD5	:= 0

	If Left(cChaveGrp,nTamChave) == BD6->( BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_CODRDA + BD6_TIPGUI )
		lGrupCopart := ( Right(cChaveGrp,1) == 'S' )
	Else
		lGrupCopart := lCobGrupCop(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_CODRDA,BD6->BD6_TIPGUI)
		cChaveGrp 	:= BD6->( BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_CODRDA + BD6_TIPGUI ) + IIF(lGrupCopart,'S','N')
	EndIf

	//Isentar Guiasdo tipo: 08=Quimioterapia; 09=Radioterapia; 10=TR
	// FRED: incluído a empresa 0402 na regra para não isentar
	If !lIsentou .and. (!lGrupCopart .or. ( ( BCL->BCL_ALIAS == 'BD5' ) .and. ( BD5->BD5_TIPATE $ '08|09|10' ) ) ) .and. !(BD6->BD6_CODEMP $ '0004|0009|0402')
		aQtd 		:= {}
		cAlias		:= "BRV"
		nPerCop		:= 0
		nValCop		:= 0
		nValUs		:= 0
		nTaxa   	:= 0
		nLimFra		:= 0
		lExistia 	:= .F.
		lIsentou	:= .T.
	EndIf

	/*** ISENTAR 80 ANOS E ACIMA ***/
	If !lIsentou .and. ;
			( BD6->BD6_CODEMP $ "0001|0002|0005" .or. (BD6->BD6_CODEMP =="0003" .and. BD6->BD6_CONEMP = '000000000001' .and. BD6->BD6_SUBCON = '000000002' ) ) .and.;
			u_IdadeBen(BD6->BD6_DATPRO,BA1->BA1_DATNAS) >= 80  .and.;
			BD6->BD6_DATPRO >= STOD('20210101');
			.and. !(AllTrim(BD6->BD6_CODPRO) $ '80190421|80190413')		// FRED: tem que coparticipar codigos das vacinas
		lTemCoPF 	:= .F.
		lPFPadrao 	:= .F.
		aQtd     	:= {}
		cAlias	 	:= "BHI"
		nPerCop	 	:= 0
		nValCop	 	:= 0
		nValUs	 	:= 0
		nTaxa  	 	:= 0
		nLimFra	 	:= 0
		lExistia 	:= .F.
		lIsentou	:= .T.
	Endif

	/*** ISENTAR PRESTADORES DA CLASSE DE REDE ESP ***/
	BAU->(DbSetOrder(1))
	DbSelectArea("BAU")
	If DbSeek(xFilial("BAU")+BD6->BD6_CODRDA)
		cTIPPRE := BAU->BAU_TIPPRE
	Endif
	RestArea(aBAU)

	//-------------------------------------------------------------------------
	//Angelo Henrique - Data: 23/09/2021
	//-------------------------------------------------------------------------
	//Acrescentando empresa 0004 e 0009 para não serem zeradas
	//-------------------------------------------------------------------------
	// FRED: não zerar também empresa 0402
	If !lIsentou .and. cTIPPRE == "ESP" .And. !(BD6->BD6_CODEMP $ "0004|0009|0402")
		lTemCoPF 	:= .F.
		lPFPadrao 	:= .F.
		aQtd 		:= {}
		cAlias		:= "BHI"
		nPerCop		:= 0
		nValCop		:= 0
		nValUs		:= 0
		nTaxa   	:= 0
		nLimFra		:= 0
		lExistia 	:= .F.
		lIsentou	:= .T.
	EndIf

	If AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSRETCP - 1")
		EndIf
	EndIf

	lIntNupre	:= (cEmpAnt == "02") .and. !(cCodEmp $ GetNewPar("MV_YINTNP","0109"))  //Motta mar/12

	BI3->(DbSetOrder(1))
	BB2->(DbSetOrder(1))
	BHD->(DbSetOrder(1))
	BD6->(DbSetOrder(7))
	BE4->(DbSetOrder(2))

	//tratamento para medicamentos especiais dos grupos de cobertura 017 e 018(OPME), coparticipam 100%/////á analisar
	If BD6->BD6_CODPAD = '06'
		lMedEspec := .T.
	EndIf

	//**'INICIO - Marcela Coimbra - Definir como 100% a co-participação para convenio de reciprocidade'**//
	//**'BIANCHINI - Acrescentada a seguinte regra dentro do OR: A gui de consulta somente entrará no criterio de Isencao de COPART caso os codigos sejam os do NUPRE (86)//
/*
	If 	(!lMedEspec) .and. ;
		( BD6->BD6_TIPGUI == '02' .or. (BD6->BD6_TIPGUI == '01' .and. BD6->(BD6_CODPAD+substr(BD6_CODPRO,1,2)) $ '0186') ) .and.;
		( ( cEmpAnt == '01' .and. !(cCodEmp $ '0004||0009|5000|5001|5002') ) .or. ;
		  ( cEmpAnt == '02' .and. !(cCodEmp $ GetNewPar('MV_XEMPEST','0180|0183|0188|0189|0190')) ) ) 
*/
	if BD6->BD6_TIPGUI $ '01|02'	// consulta e SADT
		lTpGuiCp := .T.
	elseif BD6->BD6_TIPGUI == '10'	// recurso de glosa

		nRecBD5 := BD5->(RECNO())

		BD5->(DbSetOrder(1))	// BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_SITUAC+BD5_FASE+dtos(BD5_DATPRO)+BD5_OPERDA+BD5_CODRDA
		if BD5->(DbSeek( xFilial("BD5") + SubStr(BD5->BD5_GUIORI,1,24) ))

			if BD5->BD5_TIPGUI $ '01|02'	// consulta e SADT
				lTpGuiCp := .T.
			endif

		endif

		BD5->(DBGoTo(nRecBD5))

	endif

	If 	!lMedEspec .and. lTpGuiCp .and.;
			( ( cEmpAnt == '01' .and. !(cCodEmp $ '0004||0009|5000|5001|5002|0402') ) .or. ;
			( cEmpAnt == '02' .and. !(cCodEmp $ GetNewPar('MV_XEMPEST','0180|0183|0188|0189|0190'))) )
		//***** LOCALIZAR PROFISSIONAL DE SAUDE + SOLICITANTE REFERENCIADO - INICIO *****//

		aStatTmp := U_StatBB0(BD6->BD6_REGSOL,dDatPro,nil,nil,BD6->BD6_SIGLA, BD6->BD6_ESTSOL)

		Do Case
		Case (aStatTmp[3]) .and. (cEmpAnt == "01" .or. (cEmpAnt == "02" .and. lIntNupre))
			cCodSol   	:= aStatTmp[1]
			lSolREF 	:= .T.
			cTpSolRef	:= aStatTmp[4] //Aqui pega em qual projeto o Solicitante pode Atuar
		Otherwise
			cCodSol     := ''
			lSolREF 	:= .F.
			cTpSolRef	:= ''
		EndCase
		//***** LOCALIZAR PROFISSIONAL DE SAUDE + SOLICITANTE REFERENCIADO - FIM *****//

		//-------------------------------------------------------------------------
		//Angelo Henrique - Data: 24/06/2022
		//-------------------------------------------------------------------------
		//Isentar quando o solicitante for do centro médico
		//-------------------------------------------------------------------------		
		If !lIsentou .and. cTpSolRef = '7'
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd 		:= {}
			cAlias		:= "BHI"
			nPerCop		:= 0
			nValCop		:= 0
			nValUs		:= 0
			nTaxa   	:= 0
			nLimFra		:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		EndIf

		//***** LOCALIZAR EXECUTANTE REFERENCIADO - INICIO *****//
		lExeREF := .F.

		//So vale Executante para Beneficiarios da INTEGRAL SAUDE, quando o mesmo for um dos NUPREs ( TERAPIAS, MILHAS E MAZZAS, NA SEQUENCIA DOS CODIGOS )
		lExeREF := (cEmpAnt == "02" .and. lIntNupre .and. cCodRda $ '125970|136204|131903')
		//***** LOCALIZAR EXECUTANTE REFERENCIADO - FIM *****//

		//MV_YPLAED esta setado com 0024(AED),0038(AED),0041(AAG),0083(MAT), 0137 (PGD), 0138 (PALLIARE) na operadora CABERJ
		If cEmpAnt == "01"
			cProjetos := GetNewPar("MV_YPLAED","0024,0038,0041,0083,0137,0138")
		Else
			//MV_YPLAED esta setado com 0116 (PGD), 0129 (PALLIARE), 0130 (MATURIDADE) na operadora INTEGRAL
			cProjetos := GetNewPar("MV_YPLAED","0116,0129,0130")
		Endif

		//***** LOCALIZAR PROJETOS - INICIO *****//
		If BF4->(MsSeek(xFilial("BF4")+cCodInt+cCodEmp+cMatric+cTipReg)) .and. (lSolREF .or. lGuiVERDE .or. cCodRda == '125970')

			While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cCodInt+cCodEmp+cMatric+cTipReg .and. !BF4->(Eof())

				//EM NOVAS MUDANCAS DEFINIDAS EM 13/02/2015, COM DR SANDRO ENTENDEMOS QUE A UNICA ISENCAO DE COPART OCORRERA QUANDO
				//O ASSISTIDO FOR AAG E SEU SOLICITANTE FOR CADASTRADO NO PROJETO. NOS DEMAIS TEM COPART REDUZIDA NOS CENTROS MEDICOS
				//If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0024,0038")  //MV_YPLAED esta setado com 0024(AED),0038(AED),0041(AAG),0083(MAT), operadora CABERJ
				If BF4->BF4_CODPRO $ cProjetos
					If dDatPro >= BF4->BF4_DATBAS
						If Empty(BF4->BF4_DATBLO) .Or. ( !Empty(BF4->BF4_DATBLO) .and. dDatPro <= BF4->BF4_DATBLO )

							cCodPla := BF4->BF4_CODPRO
							cVerPla := BF4->BF4_VERSAO

							If cEmpAnt == "01"

								IF (BF4->BF4_CODPRO $ '0038|0024') .AND. lSolREF .AND. (cTpSolRef $ '1|3') //SOMENTE AED OU AMBOS
									lTemAED 	:= .T.
									//ELSEIF (BF4->BF4_CODPRO = '0041')  .AND. lSolREF .AND. (cTpSolRef $ '2|3') //SOMENTE AAG OU AMBOS
								ELSEIF (BF4->BF4_CODPRO = '0041')  .AND. ( (lSolREF .AND. cTpSolRef $ '2|3') .OR. cCodRda == '125970')
									lTemAAG 	:= .T.
								ELSEIF (BF4->BF4_CODPRO = '0083')  .AND. lSolREF .AND. (cTpSolRef $ '3|4')//SOMENTE MAT OU AMBOS
									lTemMAT 	:= .T.
								ELSEIF (BF4->BF4_CODPRO = '0137')  .AND. lSolREF .AND. (cTpSolRef $ '1|3|5') //PGD LÊ COMO SOMENTE AED OU AMBOS
									lTemPGD 	:= .T.
								ELSEIF (BF4->BF4_CODPRO = '0138')  .AND. lSolREF .AND. (cTpSolRef $ '3|6')   //SOMENTE PAL   BIANCHINI   05/12/2019
									lTemPAL 	:= .T.
								ENDIF

							Else

								//BIANCHINI - 08/11/2018
								//Conforme conversado com Marcus Vinicius - GEPRE, a Isenção de Copart também ocorrerá na Integral
								//Para o Projeto PGD (0116).  testar com BB0 - 00181 e 00182
								IF (BF4->BF4_CODPRO = '0116')  .AND. lSolREF .AND. (cTpSolRef $ '1|3|5') 	//PGD LÊ COMO SOMENTE AED OU AMBOS
									lTemPGD 	:= .T.
								ELSEIF (BF4->BF4_CODPRO = '0129')  .AND. lSolREF .AND. (cTpSolRef $ '3|6') 	//SOMENTE PAL   BIANCHINI   05/12/2019
									lTemPAL 	:= .T.
								ELSEIF (BF4->BF4_CODPRO = '0130')  .AND. lSolREF .AND. (cTpSolRef $ '3|4') 	//SOMENTE MAT
									lTemMAT 	:= .T.
								ENDIF

							Endif

							lTemCoPF 	:= .T.
							lPFPadrao	:= .T.

							//---------------------------------------
							//Angelo Henrique - Data:27/04/2016
							//---------------------------------------
							//validação para o AED
							//---------------------------------------
							If BF4->BF4_CODPRO $ '0038|0024'

								_lAed := .T.

							EndIf

							Exit
						EndIf
					Endif
				Else

					lTemAED 	:= .F.
					lTemAAG 	:= .F.
					lTemMAT 	:= .F.
					lTemPGD		:= .F.
					lTemPAL		:= .F.

					lTemCoPF 	:= .T.
					lPFPadrao 	:= .T.

				EndIf

				BF4->(DbSkip())

			EndDo

		Else
			lTemCoPF := .T.
			lPFPadrao := .T.
		EndIf
		//***** LOCALIZAR PROJETOS - FIM *****

		//***** CHECAGEM DE REGRAS - INICIO *****

		//*** AAG - ISENTAR COPART ***//
		If !lIsentou .and. lTemAAG .and. cCodRda == '125970' .and. cEmpAnt == "01" //Niteroi(terapias)
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		ElseIf  !lIsentou .and. lTemAAG .and. cEmpAnt == "01"
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
			//REDUZIR COPART
		ElseIf !lIsentou .and. lTemAAG .and. cCodRda $ '136204|131946' .and. cEmpAnt == "01" //Tijuca(Milhas e Prevenir)
			//Aplica o Percentual AAG, identico ao Maturidade
			nPercAAG	:= ( GetNewPar('MV_XPERMT',50)/100 )
			lTemCoPF 	:= .T.
			lPFPadrao 	:= .T.
			aQtd 		:= {}
			cAlias   	:= aIXBOri[5]
			nPerCop  	:= aIXBOri[1]*nPercAAG
			nValCop  	:= aIXBOri[2]*nPercAAG
			nValUs   	:= aIXBOri[4]
			nTaxa    	:= aIXBOri[3]
			nLimFra  	:= aIXBOri[9]
			lExistia 	:= aIXBOri[6]
			lIsentou	:= .F.
			//*** AED - ISENTAR COPART ***//
		ElseIf !lIsentou .and. lTemAED .and. !cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01" .and. ;
				u_BuscaGrupCob(cCodInt,cCodpad,cCodpro) $ '011|012|016|038|039' .and. 'DOMIC' $ AllTrim(BD6->BD6_DESPRO)
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
			//*** AED ***//
		ElseIf !lIsentou .and. lTemAED .and. !cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01"
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
			//REDUZIR COPART
		ElseIf !lIsentou .and. lTemAED .and. cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01" //Tijuca(Milhas e Prevenir),Niteroi(terapias) e Bangu (Mazza)
			//Aplica o Percentual AED, identico ao Maturidade
			nPercAED	:= ( GetNewPar('MV_XPERMT',50)/100 )
			lTemCoPF 	:= .T.
			lPFPadrao 	:= .T.
			aQtd 		:= {}
			cAlias   	:= aIXBOri[5]
			nPerCop  	:= aIXBOri[1]*nPercAED
			nValCop  	:= aIXBOri[2]*nPercAED
			nValUs   	:= aIXBOri[4]
			nTaxa    	:= aIXBOri[3]
			nLimFra  	:= aIXBOri[9]
			lExistia 	:= aIXBOri[6]
			lIsentou	:= .F.
			//*** MAT ***//
		ElseIf !lIsentou .and. lTemMAT
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
			//**************************************************************
			//*** Demais Beneficiarios no NUPRE, inclusive COLABORADORES ***
			//*** REDUZIR COPART										 ***
			//**************************************************************
			//ElseIf !lIsentou .and. !lTemAED .and. !lTemAAG .and. !lTemMAT .and. cCodRda $ '136204|131946|125970|127654' //Tijuca(Milhas e Prevenir),Niteroi(terapias) e Bangu (Mazza)
		ElseIf !lIsentou .and. !lTemAED .and. !lTemAAG .and. !lTemMAT .and. !lTemPGD .and. !lTemPAL .and. cCodRda $ '136204|131946|125970|127654' //Tijuca(Milhas e Prevenir),Niteroi(terapias) e Bangu (Mazza)
			nPercNUP	:= ( GetNewPar('MV_XPERMT',50)/100 )
			lTemCoPF 	:= .T.
			lPFPadrao 	:= .T.
			aQtd 		:= {}
			cAlias   	:= aIXBOri[5]
			nPerCop  	:= aIXBOri[1]*nPercNUP
			nValCop  	:= aIXBOri[2]*nPercNUP
			nValUs   	:= aIXBOri[4]
			nTaxa    	:= aIXBOri[3]
			nLimFra  	:= aIXBOri[9]
			lExistia 	:= aIXBOri[6]
			lIsentou	:= .F.
			//*** PGD - ISENTAR COPART ***//
		ElseIf !lIsentou .and. lTemPGD //.and. cEmpAnt == "01"  ///BIANCHINI 08/11/2018
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		ElseIf !lIsentou .and. lTemPAL  //BIANCHINI 05/12/2019
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BF4"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
			//****************//
			//*** FARMACIA ***//
			//****************//
		ElseIf !lIsentou .and. AllTrim(BD6->BD6_CODLDP) == "0013" .AND. ( (BD6->BD6_CODPAD <> "06" .AND. cEmpAnt == "01") .OR. (BD6->BD6_CODPAD <> "07" .AND. cEmpAnt == "02"))  ///BIANCHINI 28/05/2019 - Guias de Farmacia passaram usar tabelas que coparticipam
			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BHI"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		EndIf

		//Localiza parametrizacoes tanto para procedimentos agrupados, como para atribuicoes diretas...
		If cCodPad == "01"  //Somente para CIEFAS/AMB...
			nCont := 1
			nTamSub := 16

			While nCont <= 3

				If nCont == 1
					cProBus := cCodPro
					nNivel := 3
					nTamSub := 16

				ElseIf nCont == 2
					cProBus := Substr(cProBus,1,4)+Replicate("0",3)
					nNivel := 2
					nTamSub := 4

				ElseIf nCont == 3
					cProBus := Substr(cProBus,1,2)+Replicate("0",5)
					nNivel := 1
					nTamSub := 2

				EndIf

				If BB2->(MsSeek(xFilial("BB2")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
					cProBus := BB2->BB2_CODPSA

					If BHD->(MsSeek(xFilial("BHD")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))

						aQtd := {}

						// Comentado por Luzio em 25/09/08, para que considere apenas os procedimenos relamente identicos e no mesmo nivel, pois da forma
						// como estava, o array era alimentado com todos os procedimentos caso o parametrizado fosse niveis 1 e 2,
						// e com procedimentos fora de veigencia. Dessa forma se nao encontrar um procedimento de nivel 3, ira considerar
						// pesquisar pelo sub-grupo ou grupo e alimentara a array somente com o procedimento grupo.
						//					While !BHD->(Eof()) .and. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+Substr(BHD->BHD_CODPSA,1,nTamSub)==PLSINTPAD()+cCodPla+cVerPla+cCodPad+Substr(cProBus,1,nTamSub)
						While !BHD->(Eof()) .and. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+BHD->BHD_CODPSA == PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus
							If Empty(BHD->BHD_VIGATE) .or. (DtoS(dDatPro) <= DtoS(BHD->BHD_VIGATE) .and. DtoS(dDatPro) >= DtoS(BHD->BHD_VIGDE))
								aadd(aQtd,{BHD->BHD_TIPO,BHD->BHD_QTD,BHD->BHD_PERCOP,BHD->BHD_VLRCOP,BHD->BHD_VALUS, BHD->BHD_TXADM,BHD->BHD_LIMFRA,BHD->BHD_SOMCOM,IIf(nI==2,"0","1"),BHD->BHD_CODIGO, BHD->BHD_VERSAO, BHD->BHD_CODPAD, BHD->BHD_CODPSA})
							Endif
							BHD->(DbSkip())
							nCont := 3
						EndDo

					EndIf
				EndIf

				nCont++

			EndDo

		ElseIf cCodPad == "16"  //Somente para TUSS...	 //Alterado por Bianchini em 01/03/2012 porque a mascara da TUSS foi corrigida e usa 4 niveis
			nCont := 1                                   //inserido este trecho de If para tratar este caso.
			nTamSub := 16

			While nCont <= 4

				If nCont == 1
					cProBus := cCodPro
					nNivel := 4
					nTamSub := 16

				ElseIf nCont == 2
					cProBus := Substr(cProBus,1,5)+Replicate("0",2)
					nNivel := 3
					nTamSub := 5

				ElseIf nCont == 3
					cProBus := Substr(cProBus,1,3)+Replicate("0",4)
					nNivel := 2
					nTamSub := 3

				ElseIf nCont == 4
					cProBus := Substr(cProBus,1,1)+Replicate("0",6)
					nNivel := 1
					nTamSub := 1
				EndIf

				If BB2->(MsSeek(xFilial("BB2")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
					cProBus := BB2->BB2_CODPSA

					If BHD->(MsSeek(xFilial("BHD")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))

						aQtd := {}

						// BIANCHINI em 01/03/2012. Trecho originalmente comentado pelo LUZIO em 25/09/08, onde tratava codigos ciefas. Estou
						// tratando o mesmo código adequando para códigos da tabela 16 - TUSS
						While !BHD->(Eof()) .and. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+BHD->BHD_CODPSA == PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus
							If Empty(BHD->BHD_VIGATE) .or. (DtoS(dDatPro) <= DtoS(BHD->BHD_VIGATE) .and. DtoS(dDatPro) >= DtoS(BHD->BHD_VIGDE))
								aadd(aQtd,{BHD->BHD_TIPO,BHD->BHD_QTD,BHD->BHD_PERCOP,BHD->BHD_VLRCOP,BHD->BHD_VALUS, BHD->BHD_TXADM,BHD->BHD_LIMFRA,BHD->BHD_SOMCOM,IIf(nI==2,"0","1"),BHD->BHD_CODIGO, BHD->BHD_VERSAO, BHD->BHD_CODPAD, BHD->BHD_CODPSA})
							EndIf
							BHD->(DbSkip())
							nCont := 4
						EndDo

					EndIf
				EndIf

				nCont++

			EndDo
		EndIf


		If cCodPad == "01"  //Somente para CIEFAS/AMB...

			If nNivel == 3
				cProBus := cCodPro
			ElseIf nNivel == 2
				cProBus := Substr(cProBus,1,4)
			ElseIf nNivel == 1
				cProBus := Substr(cProBus,1,2)
			EndIf

		ElseIf cCodPad == "16"  //Somente para TUSS...  //BIANCHINI 01/03/2012 - Outro tratamento para nova máscara da TUSS

			If nNivel == 4
				cProBus := cCodPro
			ElseIf nNivel == 3
				cProBus := Substr(cProBus,1,5)
			ElseIf nNivel == 2
				cProBus := Substr(cProBus,1,3)
			ElseIf nNivel == 1
				cProBus := Substr(cProBus,1,1)
			EndIf

		EndIf

		//Levantamento da quantidade utilizada...
		//Obter tanto atEndimentos ambulatoriais (BD6_ATEAMB = "1") como nao ambulatoriais (BD6_ATEAMB = "0")...
		If Len(aQtd) > 0 //.and. !lTemAED    //.and. lTemCoPF     ///BIANCHINI - REVER

			a_ArBE4 := BE4->(GetArea())//Leonardo Portella - 04/08/14 - Manter o BE4 ponteirado.
			a_ArBD6 := BD6->(GetArea())//Leonardo Portella - 04/08/14 - Manter o BD6 ponteirado.

			For nCont := 0 to 1

				BD6->(MsSeek(xFilial("BD6")+cOpeOri+cCodEmp+cMatric+cTipReg+cDigito+StrZero(nCont,1)+cProBus))

				While BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_ATEAMB) + Substr(BD6->BD6_CODPRO,1,nTamSub) == cOpeOri+cCodEmp+cMatric+cTipReg+cDigito+StrZero(nCont,1)+Substr(cProBus,1,nTamSub)

					//If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0023,0024") 	//BIANCHINI - REPENSAR SE PEGA HISTORICO TODO OU SOMENTE DA DATA DE INCLUSAO EM DIANTE

					//Consistencia do LDP 0003 devido ao historico ser posterior as guias digitadas. Demais deve observar a logica padrao do sistema.
					//If BD6->BD6_SITUAC == "1" .and. BD6->BD6_FASE $ "3,4" .and. (BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) < cCodInt+cLDPAtu+cPEGAtu+cNumAtu .Or. BD6->BD6_CODLDP == "0003" )
					If BD6->BD6_SITUAC == "1" .and. BD6->BD6_FASE $ "3,4" .and. BD6->BD6_DATPRO >= BF4->BF4_DATBAS .and.(BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) <> cCodInt+cLDPAtu+cPEGAtu+cNumAtu .Or. BD6->BD6_CODLDP == "0003" )

						nQtdUti += BD6->BD6_QTDPRO

						If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+BD6->(BD6_ANOPAG+BD6_MESPAG)))

							//VerIficar se o procedimento esta em internacao...
							While !BE4->(Eof()) .and. BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == PLSINTPAD()+BD6->(BD6_ANOPAG+BD6_MESPAG)
								If BE4->BE4_SITUAC == "1" .and. BE4->BE4_FASE $ "3,4"
									If BD6->BD6_DATPRO >= BE4->BE4_DATPRO .and. BD6->BD6_DATPRO <= BE4->BE4_DTALTA
										nQtdUti := IIf(cRegAte=="1",nQtdUti,nQtdUti-BD6->BD6_QTDPRO)   //Regime de atEndimento INTERNACAO
									EndIf
								EndIf
								BE4->(DbSkip())
							EndDo

						EndIf

					EndIf

					BD6->(DbSkip())

				EndDo

			Next

			BE4->(RestArea(a_ArBE4))//Leonardo Portella - 04/08/14 - Manter o BE4 ponteirado.
			BD6->(RestArea(a_ArBD6))//Leonardo Portella - 04/08/14 - Manter o BD6 ponteirado.

		ElseIf !lIsentou .and. (;
				(((!lTemCoPF .and. lSolREF ) ) .and. dDatPro < CTOD('01/08/2012')) .OR.;   // 28/04/11 - Regra Antiga
			(   !lTemCoPF .and. ;
				(	((lTemAAG .or. lTemAED .or. lTemMAT .or. lTemPGD .or. lTemPAL) .and. lSolREF .and. dDatPro >= CTOD('01/08/2012') .and. cEmpAnt == "01") .OR. ;      //Regra Nova
			(lSolREF .and. cEmpAnt == '02' .and. lIntNupre .and. lExeREF) ) )  )
			aQtd 		:= {}
			cAlias		:= "BF4"
			nPerCop		:= 0
			nValCop		:= 0
			nValUs		:= 0
			nTaxa   	:= 0
			nLimFra		:= 0
			lExistia 	:= .F.
			lIsentou 	:= .T.
		EndIf

		//Obtem a regra por quantidade... mais especIfica...
		//Ordem da matriz aQtd: Regime de atEndimento + quantidade...
		aSort(aQtd,,, { |x,y| x[9]+x[1]+StrZero(x[2],3) < y[9]+y[1]+StrZero(y[2],3) })

		// 28/04/2011
		// Se existe procedimento parametrizado no produto AED/AAG e o solicitante pertence ao projeto AED e/ou a Guia eh do AED/AAG
		// E o executante pertencer a rede de referencia para atEndimento aos NUPRES, caso contrario,
		// a cobranca da co-participação segue normalmente o padrao do sistema
		If ((Len(aQtd) > 0 .and. lSolREF ) .and. dDatPro < CTOD('01/08/2012')) .OR.;  // Regra Antiga
			(Len(aQtd) > 0 .and.;
				(	((lTemAAG .or. lTemAED .or. lTemMAT .or. lTemPGD .or. lTemPAL ) .and. lSolREF .and. dDatPro >= CTOD('01/08/2012') .and. cEmpAnt == "01") .OR. ;
				(lSolREF .and. cEmpAnt == '02' .and. lIntNupre .and. lExeREF)  ) )

			For nCont := 1 to Len(aQtd)

				If aQtd[nCont,1] == cRegAte .Or. aQtd[nCont,1] == "3" //Ou igual ao parametrizado, ou Ambos...

					If nCont == 1

						If !lIsentou .and. nQtdUti < aQtd[nCont,2] //.and. !lAlterou
							cAlias	:= "BHD"
							nPerCop	:= aQtd[nCont,3]
							nValCop	:= aQtd[nCont,4]
							nValUs	:= aQtd[nCont,5]
							nTaxa	:= aQtd[nCont,6]
							nLimFra	:= aQtd[nCont,7]
							// Trecho de codigo inserido por Luzio em 01/07/08 para que nao devolva como falso a cobranca da coparticipacao,
							//caso o percentual encontrado seja zero, pois retornando apenas o percentual zero, a rotina mantinha a
							//cobranca do valor calculado na origem.
							If nPerCop = 0
								lExistia := .F.
							EndIf
							If nPerCop == 0 .and. nValCop == 0
								lIsentou	:= .T.
							Else
								lIsentou	:= .F.
							Endif
						EndIf

					Else

						If !lIsentou .and. aQtd[nCont-1,2] < nQtdUti .and. nQtdUti < aQtd[nCont,2] //.and. !lAlterou
							cAlias	:= "BHD"
							nPerCop	:= aQtd[nCont,3]
							nValCop	:= aQtd[nCont,4]
							nValUs	:= aQtd[nCont,5]
							nTaxa	:= aQtd[nCont,6]
							nLimFra	:= aQtd[nCont,7]
							// Trecho de codigo inserido por Luzio em 01/07/08 para que nao devolva como falso a cobranca da coparticipacao,
							//caso o percentual encontrado seja zero, pois retornando apenas o percentual zero, a rotina mantinha a
							//cobranca do valor calculado na origem.
							If nPerCop = 0
								lExistia := .F.
							EndIf
							If nPerCop == 0 .and. nValCop == 0
								lIsentou	:= .T.
							Else
								lIsentou	:= .F.
							Endif
						EndIf

					EndIf

				EndIf

			Next

		EndIf

		If AllTrim(FunName()) <> "RPC"  //HAT
			//Cobranca de co-participacao dIferenciada para determinados codigos de criticas (carencia, bloqueio, etc.)
			If Len(paramixb) >= 32

				aVetCri := aClone(paramixb[32])

				For nTmpFor := 1 to Len(aVetCri)

					aVetTmp := aClone(aVetCri[nTmpFor])

					For nTmpCri := 1 to Len(aVetTmp)

						//Leonardo Portella - 10/11/14 - Inicio - Existem criticas em que nao traz a tabela e código do procedimentos pois são
						//criticas em niveis diferentes, como por exemplo a "047 - Especialidade bloqueada para este RDA". Nestes casos passou
						//a dar erro apos a virada da TISS3.
						//Inclui a validacao do tamanho dos campo ser maior ou igual a 7

						//If ! Empty(aVetTmp[nTmpCri][1]) .and. aVetTmp[nTmpCri][6]==BD6->BD6_CODPAD .and. aVetTmp[nTmpCri][7]==BD6->BD6_CODPRO

						If 	!Empty(aVetTmp[nTmpCri][1]) 				.and. ;
								( len(aVetTmp[nTmpCri]) >= 7 ) 				.and. ;
								( aVetTmp[nTmpCri][6] == BD6->BD6_CODPAD )	.and. ;
								( aVetTmp[nTmpCri][7] == BD6->BD6_CODPRO )

							//Leonardo Portella - 10/11/14 - Fim

							If aVetTmp[nTmpCri][1] $ cCriPrc
								lAltPrc := .T.
							EndIf
						EndIf

					Next

				Next

				If !lAltPrc
					// Se nao encontrou a critica no vetor acima e for oriundo da funcao de ANALISE DE GLOSA e a variavel
					// lCompra ja estiver setada como verdadeira (signIfica que ja executou a rotina anteriormente achando o valor da co-participacao
					// para compra. Se for passagem pela rotina de mudanca de fase, nao vai entrar nessa rotina pois a variavel lCompra vai estar como
					// falsa.
					// Posiciono no arquivo de critica do BDX desse procedimento

					For nX = 1 to Len(AllTrim(cCriPrc)) step 4
						cNovCod += "'"+AllTrim(SubStr(cCriPrc,nX,3))+"',"
					Next

					If At(",",cNovCod) > 0
						cNovCod := SubStr(AllTrim(cNovCod),1,Len(AllTrim(cNovCod))-1)
					EndIf

					cSQL := " SELECT BDX_CODOPE, BDX_CODLDP, BDX_CODPEG, BDX_NUMERO, BDX_SEQUEN, BDX_ORIMOV, "
					cSQL += " BDX_CODPAD, BDX_CODPRO, BDX_CODGLO, COUNT(R_E_C_N_O_) AS NROREG "
					cSQL += " FROM "+RetSQLName("BDX")+" BDX "
					cSQL += " WHERE BDX_FILIAL = '"+xFilial("BDX")+"' "
					cSQL += " AND BDX_CODOPE = '"+PLSINTPAD()+"' "
					cSQL += " AND BDX_CODLDP = '"+BD6->BD6_CODLDP+"' "
					cSQL += " AND BDX_CODPEG = '"+BD6->BD6_CODPEG+"' "
					cSQL += " AND BDX_NUMERO = '"+BD6->BD6_NUMERO+"' "
					cSQL += " AND BDX_ORIMOV = '"+BD6->BD6_ORIMOV+"' "
					cSQL += " AND BDX_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
					//		cSQL += " AND BDX_NIVEL = '1' "
					cSQL += " AND BDX_CODPAD = '"+AllTrim(cCodPad)+"' "
					cSQL += " AND BDX_CODPRO = '"+AllTrim(cCodPro)+"' "
					cSQL += " AND BDX_CODGLO IN ("+cNovCod+") "
					cSQL += " AND BDX_TIPREG = '1' "
					cSQL += " AND BDX.D_E_L_E_T_ = ' ' "
					cSQL += " GROUP BY BDX_CODOPE, BDX_CODLDP, BDX_CODPEG, BDX_NUMERO, BDX_SEQUEN, BDX_ORIMOV, "
					cSQL += " BDX_CODPAD, BDX_CODPRO, BDX_CODGLO "

					PlsQuery(cSQL,"TRB1")

					If TRB1->NROREG > 0
						lAltPrc := .T.
					EndIf

					TRB1->(DbCloseArea())

				EndIf

			EndIf
		Endif

		If lAltPrc

			nPerNov := 0

			If BB2->(MsSeek(xFilial("BB2")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cCodPro))
				cProBus := BB2->BB2_CODPSA

				If BHD->(MsSeek(xFilial("BHD")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))

					aQtd := {}

					// Comentado por Luzio em 25/09/08, para que considere apenas os procedimenos relamente identicos e no mesmo nivel, pois da forma
					// como estava, o array era alimentado com todos os procedimentos caso o parametrizado fosse niveis 1 e 2,
					// e com procedimentos fora de veigencia. Dessa forma se nao encontrar um procedimento de nivel 3, ira considerar
					// pesquisar pelo sub-grupo ou grupo e alimentara a array somente com o procedimento grupo.
					//					While !BHD->(Eof()) .and. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+Substr(BHD->BHD_CODPSA,1,nTamSub)==PLSINTPAD()+cCodPla+cVerPla+cCodPad+Substr(cProBus,1,nTamSub)
					While !BHD->(Eof()) .and. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+BHD->BHD_CODPSA == PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus
						If Empty(BHD->BHD_VIGATE) .or. (DtoS(dDatPro) <= DtoS(BHD->BHD_VIGATE) .and. DtoS(dDatPro) >= DtoS(BHD->BHD_VIGDE))
							aadd(aQtd,{BHD->BHD_TIPO,BHD->BHD_QTD,BHD->BHD_PERCOP,BHD->BHD_VLRCOP,BHD->BHD_VALUS, BHD->BHD_TXADM,BHD->BHD_LIMFRA,BHD->BHD_SOMCOM,IIf(nI==2,"0","1"),BHD->BHD_CODIGO, BHD->BHD_VERSAO, BHD->BHD_CODPAD, BHD->BHD_CODPSA})
						EndIf

						If BHD->BHD_SOMCOM == '1'

							If BHD->BHD_PERCOP > 0
								nPerNov := BHD->BHD_PERCOP
								nValNov := 0
								cAliasPF := "BHD"
							ElseIf BHD->BHD_VLRCOP > 0
								nPerNov := 0
								nValNov := BHD->BHD_VALCOP
								cAliasPF := "BHD"
							EndIf
						Endif

						BHD->(DbSkip())

					EndDo

				EndIf
			EndIf
			//BIANCHINI - FIM

			If nPerNov == 0 .and. nValNov == 0

				BHG->(DbSetOrder(1))
				BHG->(MsSeek(xFilial("BHG")+BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_CONEMP+BD6_VERCON+BD6_SUBCON+BD6_VERSUB)+cCodPla))

				While BHG->(BHG_FILIAL+BHG_CODINT+BHG_CODIGO+BHG_NUMCON+BHG_VERCON+BHG_SUBCON+BHG_VERSUB+BHG_CODPRO) == (xFilial("BHG")+BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_CONEMP+BD6_VERCON+BD6_SUBCON+BD6_VERSUB)+cCodPla) .and. ! BHG->(Eof())

					If (BHG->BHG_TIPO == cRegAte) .or. (BHG->BHG_TIPO == "3")
						If (BHG->BHG_PERCOP > 0 .or. BHG->BHG_VALCOP > 0) .and. BHG->BHG_SOMCOM == "1"
							If BHG->BHG_PERCOP > 0
								nPerNov := BHG->BHG_PERCOP
								nValNov := 0
								cAliasPF := "BHG"
							Else
								nPerNov := 0
								nValNov := BHG->BHG_VALCOP
								cAliasPF := "BHG"
							EndIf
							Exit
						EndIf
					EndIf

					BHG->(DbSkip())

				EndDo

			EndIf

			If nPerNov == 0 .and. nValNov == 0

				BHJ->(DbSetOrder(1))
				BHJ->(MsSeek(xFilial("BHJ")+cCodInt+cCodPla+cVerPla))

				While BHJ->(BHJ_FILIAL+BHJ_CODINT+BHJ_CODPLA+BHJ_VERSAO) == (xFilial("BHJ")+cCodInt+cCodPla+cVerPla) .and. ! BHJ->(Eof())

					If (BHJ->BHJ_TIPO == cRegAte) .or. (BHJ->BHJ_TIPO == "3")
						If (BHJ->BHJ_PERCOP > 0 .or. BHJ->BHJ_VALCOP > 0) .and. BHJ->BHJ_SOMCOM == "1"
							If BHJ->BHJ_PERCOP > 0
								nPerNov := BHJ->BHJ_PERCOP
								nValNov := 0
								cAliasPF := "BHJ"
							Else
								nPerNov := 0
								nValNov := BHJ->BHJ_VALCOP
								cAliasPF := "BHJ"
							EndIf
							Exit
						EndIf
					EndIf

					BHJ->(DbSkip())
				EndDo

			EndIf

			If !lIsentou .and. (nPerNov > 0 .or. nValNov > 0) .and. ( Eval(bCond1))

				If ExistBlock("PLSDATAN")
					cPLSREGANVE := ExecBlock("PLSDATAN",.F.,.F.,{cTipoGuia,cPLSREGANVE})
				EndIf

				If cPLSREGANVE == "1"
					dDatAnalise := dDatPro
				Else
					dDatAnalise := dDataBase
				EndIf

				If nPerNov > 0
					nPerCop  := nPerNov
					nValCop	 := 0
				ElseIf nValNov > 0
					nPerCop  := 0
					nValCop	 := nValNov
				EndIf

				nTaxa	   := &(cAliasPF+"->"+cAliasPF+"_TXADM")
				nValUs	   := &(cAliasPF+"->"+cAliasPF+"_VALUS")
				cAlias     := cAliasPF
				lExistia   := .T.
				cPgNoAto   := &(cAliasPF+"->"+cAliasPF+"_PAGATO")
				cPgDrRDA   := &(cAliasPF+"->"+cAliasPF+"_PAGRDA")
				nLimFra	   := &(cAliasPF+"->"+cAliasPF+"_LIMFRA")
				lCompra	   := .F.
				cRegAte    := &(cAliasPF+"->"+cAliasPF+"_TIPO")
				cCodTabCop := &(cAliasPF+"->"+cAliasPF+"_CODTAB")

				If &(cAliasPF)->( FieldPos(cAliasPF+"_ANOMES") ) > 0 .and. &(cAliasPF)->( FieldPos(cAliasPF+"_VLRANT") ) > 0
					If Substr(DtoS(dDatAnalise),1,6) < &(cAliasPF+"->"+cAliasPF+"_ANOMES")
						nLimFra := &(cAliasPF+"->"+cAliasPF+"_VLRANT")
					Else
						If &(cAliasPF)->(FieldPos(cAliasPF+"_LIMFRA")) > 0
							nLimFra := &(cAliasPF+"->"+cAliasPF+"_LIMFRA")
						EndIf
					EndIf
				Else
					If &(cAliasPF)->(FieldPos(cAliasPF+"_LIMFRA")) > 0
						nLimFra := &(cAliasPF+"->"+cAliasPF+"_LIMFRA")
					EndIf
				EndIf
				If nPerCop == 0 .and. nValCop == 0
					lIsentou	:= .T.
				Else
					lIsentou	:= .F.
				Endif
			EndIf
		EndIf

	EndIf

	//**'Marcela Coimbra - 01/09/2015 - Zerar copart para prefeitura'**//
	If !lIsentou .and. (cCodEmp $ '0024||0025||0026||0027||0028') .and. cEmpAnt == '01'// .and. nPerCop <> 100 //TRATAR APENAS GUIAS DE SADT, VISTO QUE OS NUMEROS DE GUIAS DE CONSULTA ENTRARAM NO MESMO INTERVALO QUE SADT.
		aQtd := {}
		cAlias	:= "BGH"
		nPerCop	:= 0
		nValCop	:= 0
		nValUs	:= 0
		nTaxa   := 0
		nLimFra	:= 0
		lExistia := .T.
		lIsentou := .T.
		//*** FARMACIA - ISENTAR COPART ***//
	ElseIf !lIsentou .and. AllTrim(BD6->BD6_CODLDP) == "0013" .AND. ( (BD6->BD6_CODPAD <> "06" .AND. cEmpAnt == "01") .OR. (BD6->BD6_CODPAD <> "07" .AND. cEmpAnt == "02"))  ///BIANCHINI 28/05/2019 - Guias de Farmacia passaram usar tabelas que coparticipam
		lTemCoPF 	:= .F.
		lPFPadrao 	:= .F.
		aQtd     	:= {}
		cAlias	 	:= "BHI"
		nPerCop	 	:= 0
		nValCop	 	:= 0
		nValUs	 	:= 0
		nTaxa  	 	:= 0
		nLimFra	 	:= 0
		lExistia 	:= .F.
		lIsentou	:= .T.
	EndIf

	//-----------------------------------------------------------------------
	//Angelo Henrique - 09/11/2015 - Chamado 19190
	//-----------------------------------------------------------------------
	//Tela para digitação de exames e procedimentos
	//-----------------------------------------------------------------------
	//Como estava sendo cobrado coparticipação errada dos beneficiários,
	//por causa de erros na hora de verificar o solicitante, uma vez que
	//em algum momento no atendimento a solicitante pode ser cadastrado
	//incorreto
	//-----------------------------------------------------------------------

	_aArBA1 := BA1->(GetArea())
	_aArBD6 := BD6->(GetArea())
	_aArBB0 := BB0->(GetArea())
	_aArBF4 := BF4->(GetArea())

	//------------------------------------------------------------------------------
	//Ponterando na BA1 para pegar o DIGITO utilizado na tabela customizada (ZRS)
	//------------------------------------------------------------------------------
	DbSelectArea("BA1")
	DbSetORder(2)
	If DbSeek(xFilial("BA1")+ BD5->BD5_CODOPE + BD5->BD5_CODEMP + BD5->BD5_MATRIC + BD5->BD5_TIPREG)

		_cMatBa1 := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
		_cMatBF4 := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
		_lAtuZRT := .F. //Forçando atualização da variável

		While BD6->(!EOF()) .And. BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD) == cCodOpe + cLDPAtu + cPEGAtu + cNumAtu + _cOrimov + _cSeq + _cPad

			_cQuery := " SELECT ZRS.ZRS_SOLICI, ZRS.ZRS_MATRIC, ZRS.ZRS_CODPLA, ZRS.ZRS_DATSOL, ZRS.ZRS_CODRDA, ZRS.ZRS_NUMCR, "
			_cQuery += "        ZRT.ZRT_SEQ, ZRT.ZRT_TABELA, ZRT.ZRT_CODPRO, ZRT.ZRT_ATEND "
			_cQuery += " FROM " + RetSQLName("ZRS") + " ZRS, " + RetSQLName("ZRT") + " ZRT "
			_cQuery += " WHERE ZRS.D_E_L_E_T_ = ' ' "
			_cQuery += " AND ZRT.D_E_L_E_T_ = ' ' "
			_cQuery += " AND ZRS.ZRS_MATRIC = '" + _cMatBa1 + "' "
			/// Altamiro 10/05/2022 - tratamento para não considerar
			/// convenios de reciprocidade e a integral quando for na caberj
			If cEmpAnt == "01"
				_cQuery += " AND substr(ZRS.ZRS_MATRIC,5,4) not in  ('0004','0009') "
			EndIf
			_cQuery += " AND ZRS.ZRS_SOLICI = ZRT.ZRT_SOLICI "
			_cQuery += " AND ZRT.ZRT_CODPRO = '" + BD6->BD6_CODPRO + "' "

			If Select(cAlias1)>0
				(cAlias1)->(DbCloseArea())
			EndIf

			DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cQuery),cAlias1, .F., .T.)

			DbSelectArea(cAlias1)

			(cAlias1)->(DbGoTop())

			While (cAlias1)->(!EOF())

				//---------------------------------------------------
				//Validação dos dias, para saber se a solicitação
				//esta ou não ativa(Dentro do prazo definido)
				//---------------------------------------------------
				If BD5->BD5_DATPRO - STOD((cAlias1)->ZRS_DATSOL) < _nVlDias

					_cNumCr := (cAlias1)->ZRS_NUMCR

					//Validação do NUPRE TIJUCA
					_lVlDT  := STOD((cAlias1)->ZRS_DATSOL) >= CTOD("2019/04/08")
					_lVlEx	:= STOD((cAlias1)->ZRS_DATSOL) <= BD6->BD6_DATPRO

					DbSelectArea("ZRT")
					DbSetOrder(6)  //ZRT_FILIAL + ZRT_CHVBD6
					If !DbSeek(xFilial("ZRT") + BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO))

						DbSelectArea("ZRT")
						DbSetOrder(1)
						If DbSeek(xFilial("ZRT") + (cAlias1)->ZRT_SEQ + (cAlias1)->ZRS_SOLICI + (cAlias1)->ZRS_MATRIC + (cAlias1)->ZRS_NUMCR)

							If Empty(ZRT->ZRT_CHVBD6)

								RecLock("ZRT", .F.)

								ZRT->ZRT_ATEND 	:= "S"
								ZRT->ZRT_DTCONS	:= dDataBase
								ZRT->ZRT_CHVBD6	:= BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO)

								ZRT->(MsUnLock())

							EndIf

						EndIf

					EndIf

					_lAtuZRT := .T.
					_lNtAtd := .F.

				Else

					//Validar aqui caso o procedimento tenha expirado na tela, porém não foi consumido
					//Sendo assim deve-se coparticipar
					DbSelectArea("ZRT")
					DbSetOrder(1)
					If DbSeek(xFilial("ZRT") + (cAlias1)->ZRT_SEQ + (cAlias1)->ZRS_SOLICI + (cAlias1)->ZRS_MATRIC + (cAlias1)->ZRS_NUMCR)

						If ZRT->ZRT_ATEND != "S"

							_lNtAtd := .T.
							_lAtuZRT := .T.

						EndIf

					EndIf

				EndIf

				(cAlias1)->(DbSkip())

			EndDo

			If Select(cAlias1)>0
				(cAlias1)->(DbCloseArea())
			EndIf

			BD6->(DbSkip())

		EndDo

		//------------------------------------------------------------------------
		//Pegando o solicitante atualizado caso tenha atualizado a ZRT
		//------------------------------------------------------------------------
		If _lAtuZRT

			//-----------------------------------------------------------------------
			//Angelo Henrique - Data: 27/01/2016
			//-----------------------------------------------------------------------
			//Incluído validação pois caso tenha sido incluído na tela
			//de procedimentos e exames porém tenha expirado e não foi utilizado
			//deve-se cobrar a coparticipação nesta situação.
			//A coparticipação será cobrada conforme parametrizado.
			//Logo restauro as parametrizações que são recebidas no inicio do
			//Ponto de Entrada.
			//-----------------------------------------------------------------------
			If !lIsentou .and. _lNtAtd
				nPerCop  := paramixb[1]  //Percentual (ou e percentual ou e o valor (abaixo), nunca os dois)
				nValCop  := paramixb[2]  //Percentual (ou e valor ou e o percentual (acima), nunca os dois)
				nTaxa    := paramixb[3]  //Taxa administrativa
				nValUs   := paramixb[4]  //Valor da U.S especIfica (se for o caso)
				lExistia := paramixb[6]  //Tera Co-Participacao ? .T. ou .F.
				nLimFra  := paramixb[9]  //Limite de Franquia
				If nPerCop == 0 .and. nValCop == 0
					lIsentou	:= .T.
				Else
					lIsentou	:= .F.
				Endif
			Else
				DbSelectArea("BB0")
				DbSetOrder(7)
				//If  DbSeek(xFilial("BB0")+PADR(AllTrim(_cNumCr),TAMSX3("BB0_NUMCR")[1]))
				If DbSeek(xFilial("BB0")+RIGHT(AllTrim(_cNumCr),TAMSX3("BB0_NUMCR")[1]-9))  //BB0_NUMCR com 6 Digitos
					If EMPTY(BB0->BB0_DATBLO)
						//-----------------------------------------------------------
						//Angelo Henrique - Data:08/04/2019
						//-----------------------------------------------------------
						//Validação para o novo NUPRE TIJUCA (CENTRO MEDICO)
						//-----------------------------------------------------------
						DbSelectArea("BB8")
						DbSetOrder(1)
						If DbSeek(xFilial("BB8")+BB0->BB0_YCDRDA)
							_cCodLoc := BB8->BB8_LOCAL
						EndIf
						//-----------------------------------------------------------
					Else
						If DbSeek(xFilial("BB0")+RIGHT(AllTrim(_cNumCr),TAMSX3("BB0_NUMCR")[1]-7))  //BB0_NUMCR com 8 Digitos
							If EMPTY(BB0->BB0_DATBLO)
								DbSelectArea("BB8")
								DbSetOrder(1)
								If DbSeek(xFilial("BB8")+BB0->BB0_YCDRDA)
									_cCodLoc := BB8->BB8_LOCAL
								EndIf
							Else
								If DbSeek(xFilial("BB0")+RIGHT(AllTrim(_cNumCr),TAMSX3("BB0_NUMCR")[1]-6))  //BB0_NUMCR com 9 Digitos
									If EMPTY(BB0->BB0_DATBLO)
										DbSelectArea("BB8")
										DbSetOrder(1)
										If DbSeek(xFilial("BB8")+BB0->BB0_YCDRDA)
											_cCodLoc := BB8->BB8_LOCAL
										EndIf
									Else
										If DbSeek(xFilial("BB0")+RIGHT(AllTrim(_cNumCr),TAMSX3("BB0_NUMCR")[1]-5))  //BB0_NUMCR com 10 Digitos
											If EMPTY(BB0->BB0_DATBLO)
												DbSelectArea("BB8")
												DbSetOrder(1)
												If DbSeek(xFilial("BB8")+BB0->BB0_YCDRDA)
													_cCodLoc := BB8->BB8_LOCAL
												EndIf
											Endif
										Endif
									Endif
								Endif
							Endif
						Endif
					Endif

					aStatTmp := U_StatBB0(_cNumCr,dDatPro,nil,nil,BB0->BB0_CODSIG, BB0->BB0_ESTADO)

					If aStatTmp[3]
						cCodSol   := aStatTmp[1]
					EndIf

					Do Case

					Case (aStatTmp[3]) .and. (cEmpAnt == "01" .or. (cEmpAnt == "02" .and. lIntNupre ))
						lSolREF 	:= .T.
						cTpSolRef	:= aStatTmp[4] //Aqui pega em qual projeto o Solicitante pode Atuar
					Otherwise
						lSolREF 	:= .F.
						cTpSolRef	:= ''

					EndCase

					//-----------------------------------------------------------------------------------
					//Inicio - Varrendo novamente a BF4, agora contendo o solicitando da tela de exames
					//-----------------------------------------------------------------------------------

					//***** LOCALIZAR PROJETOS - INICIO *****//
					If BF4->(MsSeek(xFilial("BF4")+_cMatBF4)) .and. (lSolREF .or. lGuiVERDE .or. cCodRda == '125970')

						While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == _cMatBF4 .and. !BF4->(Eof())

							//EM NOVAS MUDANCAS DEFINIDAS EM 13/02/2015, COM DR SANDRO ENTENDEMOS QUE A UNICA ISENCAO DE COPART OCORRERA QUANDO
							//O ASSISTIDO FOR AAG E SEU SOLICITANTE FOR CADASTRADO NO PROJETO. NOS DEMAIS TEM COPART REDUZIDA NOS CENTROS MEDICOS
							//If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0024,0038")  //MV_YPLAED esta setado com 0024(AED),0038(AED),0041(AAG),0083(MAT), operadora CABERJ
							If BF4->BF4_CODPRO $ cProjetos
								If dDatPro >= BF4->BF4_DATBAS
									If Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .and. (dDatPro < BF4->BF4_DATBLO))

										cCodPla := BF4->BF4_CODPRO
										cVerPla := BF4->BF4_VERSAO

										If cEmpAnt == "01"

											IF (BF4->BF4_CODPRO $ '0038|0024') .AND. lSolREF .AND. (cTpSolRef $ '1|3') //SOMENTE AED OU AMBOS
												lTemAED 	:= .T.
												//ELSEIF (BF4->BF4_CODPRO = '0041')  .AND. lSolREF .AND. (cTpSolRef $ '2|3') //SOMENTE AAG OU AMBOS
											ELSEIF (BF4->BF4_CODPRO = '0041')  .AND. ( (lSolREF .AND. cTpSolRef $ '2|3') .OR. cCodRda == '125970')
												lTemAAG 	:= .T.
											ELSEIF (BF4->BF4_CODPRO = '0083')  .AND. lSolREF .AND. (cTpSolRef $ '3|4')//SOMENTE MAT OU AMBOS
												lTemMAT 	:= .T.
											ELSEIF (BF4->BF4_CODPRO = '0137')  .AND. lSolREF .AND. (cTpSolRef $ '1|3|5') //PGD LÊ COMO SOMENTE AED OU AMBOS
												lTemPGD 	:= .T.
											ELSEIF (BF4->BF4_CODPRO = '0138')  .AND. lSolREF .AND. (cTpSolRef $ '3|6')   //SOMENTE PAL   BIANCHINI   05/12/2019
												lTemPAL 	:= .T.
											ENDIF

										Else

											//BIANCHINI - 08/11/2018
											//Conforme conversado com Marcus Vinicius - GEPRE, a Isenção de Copart também ocorrerá na Integral
											//Para o Projeto PGD (0116).  testar com BB0 - 00181 e 00182
											IF (BF4->BF4_CODPRO = '0116')  .AND. lSolREF .AND. (cTpSolRef $ '1|3|5') 	//PGD LÊ COMO SOMENTE AED OU AMBOS
												lTemPGD 	:= .T.
											ELSEIF (BF4->BF4_CODPRO = '0129')  .AND. lSolREF .AND. (cTpSolRef $ '6') 	//SOMENTE PAL   BIANCHINI   05/12/2019
												lTemPAL 	:= .T.
											ELSEIF (BF4->BF4_CODPRO = '0130')  .AND. lSolREF .AND. (cTpSolRef $ '4') 	//SOMENTE MAT
												lTemMAT 	:= .T.
											ENDIF

										Endif

										lTemCoPF 	:= .T.
										lPFPadrao	:= .T.

										//---------------------------------------
										//Angelo Henrique - Data:27/04/2016
										//---------------------------------------
										//validação para o AED
										//---------------------------------------
										If BF4->BF4_CODPRO $ '0038|0024'

											_lAed := .T.

										EndIf

										Exit
									EndIf
								Endif
							Else

								lTemAED 	:= .F.
								lTemAAG 	:= .F.
								lTemMAT 	:= .F.
								lTemPGD		:= .F.
								lTemPAL		:= .F.

								lTemCoPF 	:= .T.
								lPFPadrao 	:= .T.

							EndIf

							BF4->(DbSkip())

						EndDo

					Else
						lTemCoPF := .T.
						lPFPadrao := .T.
					EndIf
					//***** LOCALIZAR PROJETOS - FIM *****

					If cEmpAnt == "01"
						//*** AAG - ISENTAR COPART ***//
						If  !lIsentou .and. lTemAAG .and. cCodRda $ '125970|127653' .and. cEmpAnt == "01" //Niteroi(terapias) e Bangu (Mazza)
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
						ElseIf !lIsentou .and. lTemAAG .and. cEmpAnt == "01"
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//REDUZIR COPART
						ElseIf !lIsentou .and. lTemAAG .and. cCodRda $ '136204|131946' .and. cEmpAnt == "01" //Tijuca(Milhas e Prevenir)
							//Aplica o Percentual AAG, identico ao Maturidade
							nPercAAG	:= ( GetNewPar('MV_XPERMT',50)/100 )
							lTemCoPF 	:= .T.
							lPFPadrao 	:= .T.
							aQtd 		:= {}
							cAlias   	:= aIXBOri[5]
							nPerCop  	:= aIXBOri[1]*nPercAAG
							nValCop  	:= aIXBOri[2]*nPercAAG
							nValUs   	:= aIXBOri[4]
							nTaxa    	:= aIXBOri[3]
							nLimFra  	:= aIXBOri[9]
							lExistia 	:= aIXBOri[6]
							lIsentou	:= .F.
							//***********
							//*** AED ***
							//***********
							//ISENTAR COPART
						ElseIf !lIsentou .and. lTemAED .and. !cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01" .and. ;
								u_BuscaGrupCob(cCodInt,cCodpad,cCodpro) $ '011|012|016|038|039' .and. 'DOMIC' $ AllTrim(BD6->BD6_DESPRO)
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
						ElseIf !lIsentou .and. lTemAED .and. !cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01"
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//REDUZIR COPART
						ElseIf !lIsentou .and. lTemAED .and. cCodRda $ '136204|131946|125970|127654' .and. cEmpAnt == "01" //Tijuca(Milhas e Prevenir),Niteroi(terapias) e Bangu (Mazza)
							//Aplica o Percentual AED, identico ao Maturidade
							nPercAED	:= ( GetNewPar('MV_XPERMT',50)/100 )
							lTemCoPF 	:= .T.
							lPFPadrao 	:= .T.
							aQtd 		:= {}
							cAlias   	:= aIXBOri[5]
							nPerCop  	:= aIXBOri[1]*nPercAED
							nValCop  	:= aIXBOri[2]*nPercAED
							nValUs   	:= aIXBOri[4]
							nTaxa    	:= aIXBOri[3]
							nLimFra  	:= aIXBOri[9]
							lExistia 	:= aIXBOri[6]
							lIsentou	:= .F.
							//**************************************************************
							//*** Demais Beneficiarios no NUPRE, inclusive COLABORADORES ***
							//*** REDUZIR COPART										 ***
							//**************************************************************
						ElseIf !lIsentou .and. !lTemAED .and. !lTemAAG .and. !lTemMAT .and. cCodRda $ '136204|131946|125970|127654' //Tijuca(Milhas e Prevenir),Niteroi(terapias) e Bangu (Mazza)
							nPercNUP	:= ( GetNewPar('MV_XPERMT',50)/100 )
							lTemCoPF 	:= .T.
							lPFPadrao 	:= .T.
							aQtd 		:= {}
							cAlias   	:= aIXBOri[5]
							nPerCop  	:= aIXBOri[1]*nPercNUP
							nValCop  	:= aIXBOri[2]*nPercNUP
							nValUs   	:= aIXBOri[4]
							nTaxa    	:= aIXBOri[3]
							nLimFra  	:= aIXBOri[9]
							lExistia 	:= aIXBOri[6]
							lIsentou	:= .F.
							//*** MAT - ISENTAR COPART ***//
						ElseIf !lIsentou .and. lTemMAT
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//***********//
							//*** PGD ***//
							//***********//
						ElseIf !lIsentou .and. lTemPGD  ///BIANCHINI 08/11/2018
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//***********//
							//*** PAL ***//
							//***********//
						ElseIf !lIsentou .and. lTemPAL
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//*********************************************//
							//*** Tem que zerar nesse novo NUPRE TIJUCA ***//
							//*********************************************//
						ElseIf !lIsentou .and. _lVlDT .And. _lVlEx //.And. _cCodLoc $ "057|056"  //RDA TIJUCA NOVO
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//*** FARMACIA - ISENTAR COPART***//
						ElseIf !lIsentou .and. AllTrim(BD6->BD6_CODLDP) == "0013" .AND. ( (BD6->BD6_CODPAD <> "06" .AND. cEmpAnt == "01") .OR. (BD6->BD6_CODPAD <> "07" .AND. cEmpAnt == "02") )  ///BIANCHINI 28/05/2019 - Guias de Farmacia passaram usar tabelas que coparticipam
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BHI"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
						EndIf
					Else
						//Integral
						//BIANCHINI - 08/11/2018
						//Conforme conversado com Marcus Vinicius - GEPRE, a Isenção de Copart também ocorrerá na Integral
						//Para o Projeto PGD (0116).  testar com BB0 - 00181 e 00182
						If !lIsentou .and. lTemMAT
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//***********//
							//*** PGD ***//
							//***********//
						ElseIf !lIsentou .and. lTemPGD  ///BIANCHINI 08/11/2018
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//***********//
							//*** PAL ***//
							//***********//
						ElseIf !lIsentou .and. lTemPAL
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//*********************************************//
							//*** Tem que zerar nesse novo NUPRE TIJUCA ***//
							//*********************************************//
						ElseIf !lIsentou .and. _lVlDT .And. _lVlEx //.And. _cCodLoc $ "057|056"  //RDA TIJUCA NOVO
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BF4"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
							//*** FARMACIA - ISENTAR COPART***//
						ElseIf !lIsentou .and. AllTrim(BD6->BD6_CODLDP) == "0013" .AND. ( (BD6->BD6_CODPAD <> "06" .AND. cEmpAnt == "01") .OR. (BD6->BD6_CODPAD <> "07" .AND. cEmpAnt == "02"))  ///BIANCHINI 28/05/2019 - Guias de Farmacia passaram usar tabelas que coparticipam
							lTemCoPF 	:= .F.
							lPFPadrao 	:= .F.
							aQtd     	:= {}
							cAlias	 	:= "BHI"
							nPerCop	 	:= 0
							nValCop	 	:= 0
							nValUs	 	:= 0
							nTaxa  	 	:= 0
							nLimFra	 	:= 0
							lExistia 	:= .F.
							lIsentou	:= .T.
						EndIf
					Endif
					//-----------------------------------------------------------------------------------
					//Fim  - Varrendo novamente a BF4, agora contendo o solicitando da tela de exames
					//-----------------------------------------------------------------------------------

				EndIf

			EndIf

		EndIf

	EndIf

	RestArea(_aArBA1)
	RestArea(_aArBD6)
	RestArea(_aArBB0)
	RestArea(_aArBF4)

	//-----------------------------------------------------------------------
	//Angelo Henrique - Data:09/11/2015 - Chamado 19190
	//-----------------------------------------------------------------------


	//-----------------------------------------------------------------------
	//Angelo Henrique - Inicio - Data: 03/07/2019 - RDM 346
	//-----------------------------------------------------------------------
	//Zera Copart quando for utilizada a CTICOR
	//-----------------------------------------------------------------------
	//SOMENTE MATER E AFINIDADE (0001,0002 E 0005)
	//-----------------------------------------------------------------------
	If !lIsentou .and. BD5->BD5_CODEMP $ ("0001,0002,0005")

		_cQuery := " SELECT 																											" 	+ CRLF
		_cQuery += "     BEA.BEA_OPEUSR||BEA.BEA_CODEMP||BEA.BEA_MATRIC||BEA.BEA_TIPREG MATRICULA,										" 	+ CRLF
		_cQuery += "     BEA.BEA_CODRDA CODRDA,    																						" 	+ CRLF
		_cQuery += "     BEA.BEA_CDPFRE EXECUTANTE																						" 	+ CRLF
		_cQuery += " FROM     																											" 	+ CRLF
		_cQuery += "     " + RETSQLNAME("BEA") + " BEA																					" 	+ CRLF
		_cQuery += "     																												" 	+ CRLF
		_cQuery += "     INNER JOIN 																									" 	+ CRLF
		_cQuery += "         " + RETSQLNAME("BE2") + " BE2																				" 	+ CRLF
		_cQuery += "     ON 																											" 	+ CRLF
		_cQuery += "         BE2.BE2_FILIAL = BEA.BEA_FILIAL																			" 	+ CRLF
		_cQuery += "         AND BE2.BE2_OPEMOV = BEA.BEA_OPEMOV																		" 	+ CRLF
		_cQuery += "         AND BE2.BE2_ANOAUT = BEA.BEA_ANOAUT																		" 	+ CRLF
		_cQuery += "         AND BE2.BE2_MESAUT = BEA.BEA_MESAUT																		" 	+ CRLF
		_cQuery += "         AND BE2.BE2_NUMAUT = BEA.BEA_NUMAUT																		" 	+ CRLF
		_cQuery += "         AND BE2.D_E_L_E_T_ = BEA.D_E_L_E_T_																		" 	+ CRLF
		_cQuery += "         AND BE2.BE2_CODPRO IN ('" + REPLACE(GetNewPar("MV_XEVEAMB","60020849,60021080,60018682"),",","','") + "')	" 	+ CRLF
		_cQuery += "             																										" 	+ CRLF
		_cQuery += " WHERE 																												" 	+ CRLF
		_cQuery += "     BEA.BEA_FILIAL = '" + xFilial("BEA") + "'																		" 	+ CRLF
		_cQuery += "     AND BEA.BEA_OPEUSR = '" + BD5->BD5_CODOPE + "'																	" 	+ CRLF
		_cQuery += "     AND BEA.BEA_CODEMP = '" + BD5->BD5_CODEMP + "' 																" 	+ CRLF
		_cQuery += "     AND BEA.BEA_MATRIC = '" + BD5->BD5_MATRIC + "'																	" 	+ CRLF
		_cQuery += "     AND BEA.BEA_TIPREG = '" + BD5->BD5_TIPREG + "'    																" 	+ CRLF
		_cQuery += "     AND BEA.BEA_TIPO = '2' 																						" 	+ CRLF
		_cQuery += "     AND BEA.BEA_CODRDA = '" + GETNEWPAR("MV_XCTICOR","123625")  + "'												" 	+ CRLF
		_cQuery += "     AND BEA.BEA_CDPFRE =																							" 	+ CRLF
		_cQuery += "     (																												" 	+ CRLF
		_cQuery += "         SELECT 																									" 	+ CRLF
		_cQuery += "             BAU.BAU_CODBB0																							" 	+ CRLF
		_cQuery += "         FROM 																										" 	+ CRLF
		_cQuery += "             " + RETSQLNAME("BAU") + " BAU																			" 	+ CRLF
		_cQuery += "         WHERE																										" 	+ CRLF
		_cQuery += "             BAU.BAU_FILIAL = '" + xFilial("BAU") + "'																" 	+ CRLF
		_cQuery += "             AND BAU.BAU_CODIGO = '" + BD5->BD5_CODRDA + "'															" 	+ CRLF
		_cQuery += "             AND BAU.D_E_L_E_T_ = ' '																				" 	+ CRLF
		_cQuery += "     )																												" 	+ CRLF
		_cQuery += "     AND BEA.BEA_DATPRO BETWEEN '" + DTOS(DaySub(BD5->BD5_DATPRO,1)) + "' AND '" + DTOS(BD5->BD5_DATPRO) + "'		" 	+ CRLF
		_cQuery += "     AND BEA.D_E_L_E_T_ = ' '																						" 	+ CRLF

		If Select(cAlias1)>0
			(cAlias1)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cQuery),cAlias1, .F., .T.)

		DbSelectArea(cAlias1)

		(cAlias1)->(DbGoTop())

		If (cAlias1)->(!EOF())

			lTemCoPF 	:= .F.
			lPFPadrao 	:= .F.
			aQtd     	:= {}
			cAlias	 	:= "BHI"
			nPerCop	 	:= 0
			nValCop	 	:= 0
			nValUs	 	:= 0
			nTaxa  	 	:= 0
			nLimFra	 	:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		EndIf

		If Select(cAlias1)>0
			(cAlias1)->(DbCloseArea())
		EndIf

	EndIf
	//-----------------------------------------------------------------------
	//Angelo Henrique - Fim - Data: 03/07/2019- RDM 346
	//-----------------------------------------------------------------------


	//Leonardo Portella - 13/04/14 - Inicio
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Chamado - ID: 10682- Se nao tiver sido criticado pela regra de grupo de cobertura definida pelo Dr Jose Paulo,          ³
	//³entrara na regra do Dr Sandro, conforme abaixo:                                                                         ³
	//³- Obs: Mudanca de nomenclatura de NUPRE para Centros Medicos.                                                           ³
	//³  Nova forma de coparticipacao dos Centros Medicos e projeto Maturidade:                                                |
	//³- REGR 1 - Regras abaixo validas somente para a Caberj. Sem alteracoes na Integral. Obs: Reembolso (LDP 9000) nao copar-|
	//|  ticipa. - TST 1: OK                                                                                                   ³
	//³- REGR 2 - Regras abaixo serao aplicadas a partir de uma data de corte a ser informada pelo Dr. Sandro. - TST 2: OK     |
	//³- REGR 3 - Procedimento maturidade (86000829) NUNCA devera coparticipar (0% coparticipacao). - TST 3: OK                |
	//³- REGR 4 - Para os RDAs Milhas (136204) e Prevenir (131946) devera coparticipar 50% do percentual padrao, independente  |
	//³  do beneficiario estar ou nao no AAG. (Ex: Se estiver parametrizado para coparticipar 30%, devera coparticipar 15%)    |
	//³  - TST 4: OK                                                                                                           |
	//³- REGR 5 - Quando for o RDA do projeto Maturidade (BOAS - 139700) ou solicitado por algum CRM vinculado ao RDA BOAS nao |
	//³  devera coparticipar. Coparticipacao = 0% - TST 5: OK                                                                  |
	//³- REGR 6 - Quando for algum dos Centros Medicos, exceto Milhas (136204) e Prevenir (131946), devera verificar se o      |
	//³  beneficiario esta no projeto AAG (0041) ou Maturidade CABERJ (0083) e em caso positivo coparticipar 0%, caso contrario|
	//³  devera coparticipar 50% do percentual padrao. (Ex: Se estiver parametrizado para coparticipar 30% e o beneficiario    |
	//³  esta no projeto AAG (0041) ou Maturidade CABERJ (0083), devera zerar - coparticipar 0% -, caso contrario devera       |
	//³  coparticipar 15%). - TST 6: OK                                                                                        |
	//³- REGR 7 - Valido na regra do solicitante: Se for solicitado por um Centros Medicos mas executado por outro RDA aplica  |
	//³  as regras acima. - TST 7: OK                                                              							   ³
	//³- REGR 8 - Valido na regra da guia verde: Caso alguma guia antiga esteja perdida e ainda venha a chegar no faturamento  ³
	//³  do RDA. - TST 8: OK                                                                                                   |
	//³- Nos outros casos devera coparticipar normalmente conforme o parametrizado.                                            |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//lGrupCopart: Crivo do Dr. Jose Paulo. !lGrupCopart => Nao eh para cobrar coparticipacao. Mais forte que a regra dos Centros Medicos

	//Leonardo Portella - 14/10/14 - Chamado - ID: 13954 - Incluido o trecho [ !lTemAED .and. ]
	//If !lTemAED .and. lGrupCopart .and. ( cEmpAnt == '01' ) .and. !( cCodEmp $ '0004|0009' ) .and. ( BD6->BD6_CODLDP <> '9000' )//REGR 1
	//If !lTemAED .and. !lTemAAG .and. lTemMAT .and. lGrupCopart .and. ( cEmpAnt == '01' ) .and. !( cCodEmp $ '0004|0009' ) .and. ( BD6->BD6_CODLDP <> '9000' )//REGR 1
	If !lTemAED .and. !lTemAAG .and. lTemMAT .and. lGrupCopart .and. ( (  cEmpAnt == '01'  .and. !cCodEmp $ '0004|0009' ) .or. (cEmpAnt == '02') ) .and. ( BD6->BD6_CODLDP <> '9000' )//REGR 1
		//Obs: NUPRE nao estara internado e internacao ja nao coparticipa
		cAliasBCL 	:= GetAliasBCL(BD6->BD6_CODOPE,BD6->BD6_TIPGUI)
		lLimpCop 	:= .F.
		lAplicPerc	:= .F.
		c_RDAsMatu	:= GetNewPar('MV_XRDAMT','139700')

		//Data de corte do projeto Maturidade. Informado pela Marcia: 01/07/14
		cCorte := GetNewPar('MV_XCORMT','20140701')

		//lAltPrc - Cobranca de co-participacao diferenciada para determinados codigos de criticas (carencia, bloqueio, etc.)
		If ( cAliasBCL == 'BD5' ) .and. !lAltPrc .and. ( BD5->BD5_DATPRO >= StoD(cCorte) )//REGR 2

			c_RDAsNupre	:= GetRDAsNupre(BD5->BD5_DATPRO)

			Do Case

			Case Alltrim(BD6->BD6_CODPRO) $ GetNewPar('MV_XPROMT','86000829')//REGR 3 (Procedimento Maturidade)

				lLimpCop := .T.

			Case ( BD5->BD5_CODRDA $ '136204|131946' )//REGR 4 (Milhas (136204) e Prevenir (131946) coparticipam 50%.)

				lAplicPerc := .T.

			Case ( BD5->BD5_CODRDA $ c_RDAsMatu ) .or. ( lSolREF .and. ( cTpSolRef == '4' ) ) .or. lProfVinRDA(cCodSol,c_RDAsMatu)//REGR 5 -- cTpSolRef 4 = Maturidade

				lLimpCop := .T.

			Case ( BD5->BD5_CODRDA $ c_RDAsNupre )//REGR 6 (exceto Milhas (136204) e Prevenir (131946) que ja foram no Case da REGR 4)

				IIf(lAAGouMAT(BD5->BD5_DATPRO,BD5->BD5_CODOPE,BD5->BD5_CODEMP,BD5->BD5_MATRIC,BD5->BD5_TIPREG), lLimpCop := .T., lAplicPerc := .T.)

			Case lSolREF//REGR 7

				IIf(lAAGouMAT(BD5->BD5_DATPRO,BD5->BD5_CODOPE,BD5->BD5_CODEMP,BD5->BD5_MATRIC,BD5->BD5_TIPREG), lLimpCop := .T., lAplicPerc := .T.)

			Case lGuiVERDE//REGR 8

				IIf(lAAGouMAT(BD5->BD5_DATPRO,BD5->BD5_CODOPE,BD5->BD5_CODEMP,BD5->BD5_MATRIC,BD5->BD5_TIPREG), lLimpCop := .T., lAplicPerc := .T.)

			End Case

		EndIf

		If !lIsentou .and. lLimpCop
			//Limpa a cobranca da coparticipacao
			aQtd 		:= {}
			cAlias		:= "BRV"
			nPerCop		:= 0
			nValCop		:= 0
			nValUs		:= 0
			nTaxa   	:= 0
			nLimFra		:= 0
			lExistia 	:= .F.
			lIsentou	:= .T.
		ElseIf !lIsentou .and. lAplicPerc
			//Aplica o Percentual Maturidade
			nPercAAG	:= ( GetNewPar('MV_XPERMT',50)/100 )
			aQtd 		:= {}
			cAlias   	:= aIXBOri[5]
			nPerCop  	:= aIXBOri[1]*nPercAAG
			nValCop  	:= aIXBOri[2]*nPercAAG
			nValUs   	:= aIXBOri[4]
			nTaxa    	:= aIXBOri[3]
			nLimFra  	:= aIXBOri[9]
			lExistia 	:= aIXBOri[6]
			lIsentou	:= .F.
		EndIf

	EndIf

	//Leonardo Portella - 13/04/14 - Fim

	_cGrpCb := u_BuscaGrupCob(cCodint, cCodpad, cCodpro)

	//Angelo Henrique - data:01/09/2015
	//Colocado validação para atender CABERJ e INTEGRAL
	//Pois em cada uma muda a emresa
	If cEmpAnt == "01"

		_cEmpX := GetNewPar('MV_XEMPEST','5000|5001|5002')

	ElseIf cEmpAnt == "02"

		_cEmpX 		:= GetNewPar('MV_XEMPEST2','0180|0183|0188|0189|0190')

		//Leonardo Portella - 16/08/16 - Início - Regras do Estaleiro Maua

		//---------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 04/08/2017 - Nova Regra Estaleiro Empresa: 0285 - Regra 2017 - Inicio
		//---------------------------------------------------------------------------------------------------------
		//If ( cCodEmp == '0259' ) .and. ( BD6->BD6_DATPRO >= CTOD("15/06/2016") ) .and. ( BD6->BD6_DATPRO <= CTOD("15/06/2017") )
		//---------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 04/08/2017 - Nova Regra Estaleiro Empresa: 0285 - Regra 2017 - Fim
		//---------------------------------------------------------------------------------------------------------
		If ((( cCodEmp == '0285' ) .and. ( BD6->BD6_DATPRO >= CTOD("01/07/2017") ) .And. ( BD6->BD6_DATPRO <= CTOD("30/06/2018")));
				.or. (cEmpAnt == '02' .and. bd6->bd6_codrda == '999997'))   // incluido por altamiro em 21/03/2018 - tratamento do repasse caberj -> integral
			lExistia := .T. //Garante que passará pelo PLSRETC2, onde estão as validações
		EndIf

		//Leonardo Portella - 16/08/16 - Fim

	EndIf

	If !lIsentou .and. (cCodEmp $ _cEmpX)
		If cRegAte == '2'
			If !empty(cCodTabCop)
				BA8->(DbSetOrder(1))
				BA8->(MsSeek(xFilial('BA8')+cCodInt+cCodTabCop+cCodPad+cCodPro))
				If !BA8->(EOF())
					BD4->(DbSetOrder(1))
					BD4->(MsSeek(xFilial('BD4')+cCodInt+cCodTabCop+cCodPad+cCodPro))
					If (!BD4->(EOF())) .and. (BD4->BD4_CODIGO == 'REA') .and. (nVlrBPF * nQtd <> BD4->BD4_VALREF * nQtd)

						//-----------------------------------------------------------------------	//
						// Inicio - Angelo Henrique - Data: 28/08/2015								//
						//-----------------------------------------------------------------------	//
						//Conforme solicitado, a regra irá mudar caso a data seja igual ou maior	//
						// que 01/06/2015, caso contrário a regra de 40% irá permanecer.			//
						//-----------------------------------------------------------------------	//
						//Irá ser cobrado o valor 7 para consulta das RDAS abaixo:					//
						//		- Hospital ST Maria Madalena											//
						//		- HOSP DE CLINS DR BALBINO LT											//
						//		- CENTROMEDE CTO DE MEDICINA ESPECIALIZADA							//
						//		- NANCI CIA																//
						// e 3.50 RDAS CABERJ															//
						//-----------------------------------------------------------------------	//
						//Quando for exame deverá executar a regra de porcentagem:					//
						//	-- Para os RDA's abaixo será 10%											//
						//		- Hospital ST Maria Madalena											//
						//		- HOSP DE CLINS DR BALBINO LT											//
						//		- CENTROMEDE CTO DE MEDICINA ESPECIALIZADA							//
						//		- NANCI CIA																//
						//	-- Para as RDA's CABERJ será 40%											//
						//-----------------------------------------------------------------------	//

						If _cGrpCb $ "003|004" .And. ;
								( ( (BD6->BD6_DATPRO > CTOD("01/08/2015") .Or. BD6->BD6_DATPRO == CTOD("01/08/2015") ) .And. cCodEmp $ _cEmpX ) )

							If 	cCodRda $ '125970|136204|131903' //Centros Médicos CABERJ
								nPercop 	:= 40
								nBPF    	:= (BD4->BD4_VALREF * (nPerCop/100)) * nQtd
								nVlrBPF 	:= nBPF
								nValCop 	:= nBPF
								nValUs		:= 0
								nTaxa   	:= 0
								nLimFra	:= 0
								lExistia 	:= .T.
								lIsentou	:= .F.
							ElseIf cCodRda $ '009989|011100|118923|044237'
								nPercop 	:= 10
								nBPF    	:= (BD4->BD4_VALREF * (nPerCop/100)) * nQtd
								nVlrBPF 	:= nBPF
								nValCop 	:= nBPF
								nValUs		:= 0
								nTaxa   	:= 0
								nLimFra	:= 0
								lExistia 	:= .T.
								lIsentou	:= .F.
							EndIf

							//---------------------------------------------------------	//
							//Angelo Henrique - Data:31/08/2015							//
							//---------------------------------------------------------	//
							//Retirado a validação de multiplicação, uma vez que a		//
							//regra informada seria o valor pago até 236.40				//
							//---------------------------------------------------------	//
							//(nValCop > (112.82 * nQtd))								//
							//---------------------------------------------------------	//
							If (nValCop > (236.40 * nQtd ))
								nPerCop	:= 0
								nValCop	:= 0
								nValUs		:= 0
								nTaxa  	:= 0
								nLimFra	:= 0
								lExistia 	:= .F.
								lIsentou := .T.
							Endif

						ElseIf !lIsentou .and. _cGrpCb $ "002" .And. ;
								( ( (BD6->BD6_DATPRO > CTOD("01/08/2015") .Or. BD6->BD6_DATPRO = CTOD("01/08/2015")) .And. cCodEmp $ _cEmpX ) )

							If cCodRda $ '009989|011100|118923|044237'

								nValCop := 7
								nVlrBPF	:= 7

							ElseIf cCodRda $ '125970|136204|131903' //Centros Médicos CABERJ

								nValCop := 3.50
								nVlrBPF	:= 3.50

							EndIf

							nValUs		:= 0
							nTaxa   	:= 0
							nLimFra		:= 0
							lExistia 	:= .T.
							lIsentou	:= .F.
						EndIf

						//-----------------------------------------------------------------------
						// Fim - Angelo Henrique - Data: 28/08/2015
						//-----------------------------------------------------------------------

					Endif
					BD4->(dbCloseArea())
				Else

					nPerCop	:= 0
					nValCop	:= 0
					nValUs	:= 0
					nTaxa   := 0
					nLimFra	:= 0
					lExistia := .F.
					lIsentou	:= .T.
				Endif
				BA8->(dbCloseArea())

			ElseIf Empty(cCodTabCop) .And. ( cCodEmp $ _cEmpX )

				//-----------------------------------------------------------------------	//
				// Inicio - Angelo Henrique - Data: 28/08/2015								//
				//-----------------------------------------------------------------------	//
				//Conforme solicitado, a regra irá mudar caso a data seja igual ou maior	//
				// que 01/06/2015, caso contrário a regra de 40% irá permanecer.			//
				//-----------------------------------------------------------------------	//
				//Irá ser cobrado o valor 7 para consulta das RDAS abaixo:					//
				//		- Hospital ST Maria Madalena											//
				//		- HOSP DE CLINS DR BALBINO LT											//
				//		- CENTROMEDE CTO DE MEDICINA ESPECIALIZADA							//
				//		- NANCI CIA																//
				// e 3.50 RDAS CABERJ															//
				//-----------------------------------------------------------------------	//
				//Duplicado aqui pois la em cima a variável cCodTabCop (Codigo da tabela 	//
				//de cobranca especIfica (TDE)) esta vazia em alguns casos, e por isso 	//
				//foi necessário acrescentar mais esta validação, fechando dessa forma	//
				//o processo por completo.														//
				//-----------------------------------------------------------------------	//

				If 	_cGrpCb $ "003|004" .And. ;
						( ( ( BD6->BD6_DATPRO > CTOD("01/08/2015") .Or. BD6->BD6_DATPRO = CTOD("01/08/2015") ) .And. cCodEmp $ _cEmpX ) )

					If 	cCodRda $ '125970|136204|131903' //Centros Médicos CABERJ
						nPercop 	:= 40
						nBPF    	:= (BD4->BD4_VALREF * (nPerCop/100)) * nQtd
						nVlrBPF 	:= nBPF
						nValCop 	:= nBPF
						nValUs		:= 0
						nTaxa   	:= 0
						nLimFra		:= 0
						lExistia 	:= .T.
						lIsentou	:= .F.
					ElseIf ( cCodRda $ '009989|011100|118923|044237' )
						nPercop 	:= 10
						nBPF    	:= (BD4->BD4_VALREF * (nPerCop/100)) * nQtd
						nVlrBPF 	:= nBPF
						nValCop 	:= nBPF
						nValUs		:= 0
						nTaxa   	:= 0
						nLimFra		:= 0
						lExistia 	:= .T.
						lIsentou	:= .F.
					EndIf

					//---------------------------------------------------------	//
					//Angelo Henrique - Data:31/08/2015							//
					//---------------------------------------------------------	//
					//Retirado a validação de multiplicação, uma vez que a		//
					//regra informada seria o valor pago até 236.40				//
					//---------------------------------------------------------	//
					//(nValCop > (112.82 * nQtd))								//
					//---------------------------------------------------------	//
					If (nValCop > (236.40 * nQtd))
						nPerCop		:= 0
						nValCop		:= 0
						nValUs		:= 0
						nTaxa  		:= 0
						nLimFra		:= 0
						lExistia 	:= .F.
						lIsentou	:= .T.
					Endif

				ElseIf 	_cGrpCb $ "002" .And. ;
						( ( (BD6->BD6_DATPRO > CTOD("01/08/2015") .Or. BD6->BD6_DATPRO = CTOD("01/08/2015")) .And. cCodEmp $ _cEmpX ) )

					If ( cCodRda $ '009989|011100|118923|044237' )

						nValCop := 7
						nVlrBPF	:= 7

					ElseIf cCodRda $ '125970|136204|131903' //Centros Médicos CABERJ

						nValCop := 3.50
						nVlrBPF	:= 3.50

					EndIf

					nPercop		:= 0
					nValUs		:= 0
					nTaxa   	:= 0
					nLimFra		:= 0
					lExistia 	:= .T.
					lIsentou	:= .F.

				EndIf

			Else
				//Quando nao há tabela de coparts definida, atenderá ao caso das consultas, pois possuem parametrizacao no sistema
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Chamado - ID: -            																							    ³
				//³Mudancas de regras de COPART dos Estaleiros em 10/02/2015, conforme email abaixo, vindo do GEREM(Armando) em 09/02/2015  ³
				//³																							                                ³
				//³Lucia,																												    ³
				//³ 																													    ³
				//³Os estaleiros sofreram alteracoes nas coparticipacoes a partir deste mes conforme a seguir:							    ³
				//³ 																													    ³
				//³1) Vard - Consultas: R$ 24,00 de coparticipacoes nas consultas na rede e R$ 55,00 de coparticipacoes nas consultas	    ³
				//³          realizadas nos prestadores: HOSPITAL DE CLINICAS DE SAO GONCALO(044369); SAMCORDIS (082660) E				    ³
				//³			 HOSPITAL ICARAI (137510);																					    ³
				//³																														    ³
				//³2) Estaleiros: Maua; Eisa Ilha e Eisa Petro Um = Consultas: R$ 48,00 de coparticipacoes nas consultas na rede e R$ 55,00 ³
				//³			 de coparticipacoes nas consultas realizadas nos prestadores: HOSPITAL DE CLINICAS DE SAO GONCALO(044369);      ³
				//³			 SAMCORDIS (082660) E HOSPITAL ICARAI (137510);																	³
				//³																															³
				//³																															³
				//³Att.																														³
				//³Armando																													³
				//³																															³
				//³OBS.: Por telefone o Armando me passou que as consultas dos Centros Medicos seguirao a mesma regra das consultas			³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cGruCob := u_BuscaGrupCob(cCodint, cCodpad, cCodpro)
				If (!Empty(cGruCob)) .and. (cGruCob $ '002') .and. (cCodRda $ '044369|082660|137510')
					nPerCop	:= 0
					nValCop	:= 55 * nQtd
					nValUs	:= 0
					nTaxa   := 0
					nLimFra	:= 0
					lExistia := .T.
					lIsentou	:= .F.
				Endif
			Endif
		Else
			nPerCop	:= 0
			nValCop	:= 0
			nValUs	:= 0
			nTaxa   := 0
			nLimFra	:= 0
			lExistia := .F.
			lIsentou	:= .T.
		Endif
	Endif

	If !lIsentou .and. cCodEmp $ "0006|0010"  //Limpar co-participação caso seja ITAU. IndepEndente de regra. FABIO BIANCHINI  13/04/2012
		//Limpa a cobranca da co-participacao
		aQtd := {}
		cAlias	:= "BRV"
		nPerCop	:= 0
		nValCop	:= 0
		nValUs	:= 0
		nTaxa   := 0
		nLimFra	:= 0
		lExistia := .F.
		lIsentou := .T.
	EndIf

	//-------------------------------------
	//Validação do AED
	//-------------------------------------
	If !lIsentou .and. _lAed .And. !lTemAED
		nPercAED	:= ( GetNewPar('MV_XPERMT',50)/100 )
		lTemCoPF 	:= .T.
		lPFPadrao 	:= .T.
		aQtd 		:= {}
		cAlias   	:= aIXBOri[5]
		nPerCop  	:= aIXBOri[1]*nPercAED
		nValCop  	:= aIXBOri[2]*nPercAED
		nValUs   	:= aIXBOri[4]
		nTaxa    	:= aIXBOri[3]
		nLimFra  	:= aIXBOri[9]
		lExistia 	:= aIXBOri[6]
		lIsentou	:= .F.
	EndIf

	RestArea(aBA0)
	RestArea(aBI3)
	RestArea(aBB2)
	RestArea(aBHD)
	RestArea(aBE4)
	RestArea(aBD6)
	RestArea(aBHG)
	RestArea(aBHJ)

	If AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSRETCP - 2")
		EndIf
	EndIf

Return(Eval(bRetorno))

//*****************************************************************************************************************************************************

Static Function AnaDataCOP(dDatPro,cAliasPF)

	Local lRet := .F.
	Local dCpoDat1
	Local dCpoDat2

	DbSelectArea(cAliasPF)

	If FieldPos(cAliasPF+"_VIGDE") == 0 .Or. FieldPos(cAliasPF+"_VIGATE") == 0
		lRet := .T.
	Else
		dCpoDat1 := &(cAliasPF+"->"+cAliasPF+"_VIGDE")
		dCpoDat2 := &(cAliasPF+"->"+cAliasPF+"_VIGATE")

		If     Empty(dCpoDat1) .and. Empty(dCpoDat2)
			lRet := .T.
		ElseIf DtoS(dDatPro) >= DtoS(dCpoDat1) .and. DtoS(dDatPro) <= DtoS(dCpoDat2)
			lRet := .T.
		EndIf
	EndIf

Return(lRet)


	//*****************************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 26/02/14                                          ³
//³Verifica se ALGUM procedimento da guia esta no grupo de cobertura 006.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function lCobGrupCop(cOpeAtu,cLDPAtu,cPEGAtu,cNumAtu,cCodRda,cTipGui)

	Local aArea			:= GetArea()
	Local lCobCopart 	:= .F.
	Local cQry 			:= ''
	Local cAlias		:= GetNextAlias()
	Local cGrpCopart	:= GetNewPar('MV_XGRCOP','006')
	Local cAliasBCL		:= GetAliasBCL(cOpeAtu,cTipGui)
	Local aInter		:= {}

	If ( cAliasBCL == 'BE4' )
		//Internacao nao tem coparticipacao, exceto Reciprocidade. Coloco como coparticipar e deixo o resto do PE calcular, pois ele ja tem tratamento para zerar.
		//A parametrizacao para nao coparticipar na internacao eh feita no produto
		lCobCopart := .T.

	ElseIf ( cAliasBCL == 'BD5' )
		aInter := PLSUSRINTE(BD5->BD5_MATRIC,BD5->BD5_DATPRO,BD5->BD5_HORPRO,.T.,.F.,"BD5", .T.)

		//Se nao esta internado
		lCobCopart :=  !( ( len(aInter) > 0 ) .and. aInter[1] )

	EndIf

	//If !lCobCopart  //BIANCHINI - 05/05/2014 - Modificacao provisoria nas Ferias do Portella.  SEMPRE VINHA .T.  Precisamos reanalisar.
	If !lCobCopart .or. !( ( len(aInter) > 0 ) .and. aInter[1] )

		cQry := " SELECT COUNT(BG8_CODGRU) QTD" 													 + CRLF
		cQry += " FROM " + RetSqlName('BG8') + " BG8" 												 + CRLF
		cQry += " INNER JOIN " + RetSqlName('BD6') + " BD6 ON BD6_FILIAL = '" + xFilial('BD6') + "'" + CRLF
		cQry += "   AND BD6_CODOPE = BG8_CODINT" 													 + CRLF
		cQry += "   AND BD6_CODLDP = '" + cLDPAtu + "'" 											 + CRLF
		cQry += "   AND BD6_CODPEG = '" + cPEGAtu + "'" 											 + CRLF
		cQry += "   AND BD6_NUMERO = '" + cNumAtu + "'" 											 + CRLF
		cQry += "   AND BD6.D_E_L_E_T_ = ' '" 														 + CRLF
		cQry += "   AND BD6_CODRDA = '" + cCodRda + "'" 											 + CRLF
		cQry += "   AND BD6_CODPAD = BG8_CODPAD" 													 + CRLF
		cQry += "   AND BD6_CODPRO = BG8_CODPSA" 													 + CRLF
		cQry += " WHERE BG8_FILIAL = '" + xFilial('BG8') + "'" 										 + CRLF
		cQry += "   AND BG8_CODINT = '" + cOpeAtu + "'" 											 + CRLF
		cQry += "   AND BG8_CODGRU IN ('" + cGrpCopart + "')" 										 + CRLF
		cQry += "   AND BG8_BENUTL = '1' "															 + CRLF   //BIANCHINI - 27/11/2018 - Faltava esta linha para pegar somente se ativo
		cQry += "   AND BG8.D_E_L_E_T_ = ' '" 														 + CRLF

		TcQuery cQry New Alias cAlias

		lCobCopart := ( cAlias->QTD == 0 )

		cAlias->(DbCloseArea())

	EndIf

	RestArea(aArea)

Return lCobCopart

	//*****************************************************************************************************************************************************

Static Function GetAliasBCL(cOpeAtu,cTipGui)

	Local aArea 		:= GetArea()
	Local aAreaBCL		:= BCL->(GetArea())
	Local cAliasBCL		:= ''

	BCL->(DbSetOrder(1))//BCL_FILIAL+BCL_CODOPE+BCL_TIPGUI

	If BCL->(DbSeek(xFilial('BCL') + cOpeAtu + cTipGui))
		cAliasBCL := BCL->BCL_ALIAS
	EndIf

	BCL->(RestArea(aAreaBCL))
	RestArea(aArea)

Return cAliasBCL

	//*****************************************************************************************************************************************************

Static Function GetRDAsNupre(dEvento)

	Local aArea 		:= GetArea()
	Local cRDAsNupre	:= ''
	Local cQuery		:= ''
	Local cAlias 		:= GetNextAlias()

	cQuery := "SELECT DISTINCT PA6_CODRDA" 										   						+ CRLF
	cQuery += "FROM " + RetSqlName('PA6') + " PA6" 														+ CRLF
	cQuery += "INNER JOIN " + RetSqlName('BAU') + " BAU ON BAU_FILIAL = '" + xFilial('BAU') + "'" 		+ CRLF
	cQuery += "  AND BAU_CODIGO = PA6_CODRDA" 											   				+ CRLF
	cQuery += "  AND ( BAU_DATBLO = ' ' OR BAU_DATBLO > '" + DtoS(dEvento) + "' )" 						+ CRLF
	cQuery += "  AND BAU.D_E_L_E_T_ = ' '" 																+ CRLF
	cQuery += "WHERE PA6_FILIAL = '" + xFilial('PA6') + "'"  						   					+ CRLF
	cQuery += "  AND PA6_DTINI <= '" + DtoS(dEvento) + "'" 							   					+ CRLF
	cQuery += "  AND ( PA6_DTBLOQ = ' ' OR PA6_DTBLOQ > '" + DtoS(dEvento) + "' )" 	  					+ CRLF
	cQuery += "  AND PA6.D_E_L_E_T_ = ' '" 											  					+ CRLF

	TcQuery cQuery New Alias cAlias

	While !cAlias->(EOF())

		cRDAsNupre += cAlias->PA6_CODRDA + ','

		cAlias->(DbSkip())

	EndDo

	cAlias->(DbCloseArea())

	If Len(cRDAsNupre) > 0
		cRDAsNupre := Left(cRDAsNupre,Len(cRDAsNupre) - 1)
	EndIf

	RestArea(aArea)

Return cRDAsNupre

	//*****************************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Retorna se o beneficiario esta no projeto AAG ou Maturidade na data informada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function lAAGouMAT(dEvento,c_CodInt,c_CodEmp,c_Matric,c_TipReg)

	Local lAAGMAT 	:= .F.
	Local aArea 	:= GetArea()
	Local cAlias	:= GetNextAlias()
	Local cQuery	:= ''
	Local cProjs 	:= FormatIn('0041,' + GetNewPar("MV_XCODMT","0083"),',')

	cQuery := "SELECT *" 																+ CRLF
	cQuery += "FROM " + RetSqlName('BF4') 												+ CRLF
	cQuery += "WHERE BF4_FILIAL = '" + xFilial('BF4') + "'" 							+ CRLF
	cQuery += "   AND BF4_CODINT = '" + c_CodInt + "'" 		   							+ CRLF
	cQuery += "   AND BF4_CODEMP = '" + c_CodEmp + "'" 		  							+ CRLF
	cQuery += "   AND BF4_MATRIC = '" + c_Matric + "'" 		  							+ CRLF
	cQuery += "   AND BF4_TIPREG = '" + c_TipReg + "'" 		  							+ CRLF
	cQuery += "   AND BF4_CODPRO IN " + cProjs 				   							+ CRLF
	cQuery += "   AND BF4_DATBAS <= '" + DtoS(dEvento) + "'"  							+ CRLF
	cQuery += "   AND ( BF4_DATBLO = ' ' OR BF4_DATBLO >= '" + DtoS(dEvento) + "' )" 	+ CRLF
	cQuery += "   AND D_E_L_E_T_ = ' '" 												+ CRLF

	TcQuery cQuery New Alias cAlias

	lAAGMAT := !cAlias->(EOF())

	cAlias->(DbCloseArea())

	RestArea(aArea)

Return lAAGMAT

	//*******************************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o profissional esta vinculado a pelo menos um dos RDAs informados.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function lProfVinRDA(c_CodSol,c_RDAs)

	Local cQry 			:= ''
	Local aArProf		:= GetArea()
	Local cAlProfVin	:= GetNextAlias()

	cQry := "SELECT COUNT(BAU_CODBB0) QTD" 															+ CRLF
	cQry += "FROM " + RetSqlName('BAU') + " BAU" 													+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BB0') + " BB0 ON BB0_FILIAL = '" + xFilial('BB0') + "'" 	+ CRLF
	cQry += "  AND BB0_VINC = '1'" 																	+ CRLF
	cQry += "  AND BB0_CODIGO = BAU_CODBB0" 														+ CRLF
	cQry += "  AND BB0.D_E_L_E_T_ = ' '" 															+ CRLF
	cQry += "WHERE BAU_FILIAL = '" + xFilial('BAU') + "'" 											+ CRLF
	cQry += "  AND BAU_CODIGO IN " + FormatIn(c_RDAs,',')											+ CRLF
	cQry += "  AND BAU_CODBB0 = '" + c_CodSol + "'"													+ CRLF
	cQry += "  AND BAU.D_E_L_E_T_ = ' '" 															+ CRLF

	TcQuery cQry New Alias cAlProfVin

	lVincRDA := ( cAlProfVin->QTD > 0 )

	cAlProfVin->(DbCloseArea())

	RestArea(aArProf)

Return lVincRDA
