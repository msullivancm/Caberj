#Include "topconn.ch"

#Define CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS180DELºAutor  ³Microsiga           º Data ³  10/09/19    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para exclusão da Conta Corrente            º±±
±±º          ³												              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³												              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PLS180DEL

	Local lRet 			:= .T.
	Local aAreaBA1		:=	BA1->(GetArea())
	Local aAreaBSQ		:=	BSQ->(GetArea())
	Local aMatrics		:= {}
	Local cQryCC		:= ""
	Local cAliasCC    	:= GetNextAlias()
	Local lCobrancaCC 	:= .F.
	Local cCodEmpCMB  	:= GetNewPar("MV_XCOBRCC",'0325')

	Private cDataFatTMP := ' '
	Private cMesFt	  	:= ' '
	Private cAnoFt	  	:= ' '

	cDataFatTMP := DTOS(MonthSub(STOD(MV_PAR04 + MV_PAR05 + '01'),1))
	cMesFt		:= SUBS(cDataFatTMP,5,2)
	cAnoFt		:= SUBS(cDataFatTMP,1,4)

	//************************************************************//
	//*** VERIFICAR SE A EMPRESA UTILIZA MODELO CONTA CORRENTE ***//
	//************************************************************//

	If ( (cEmpAnt == '02') .and. (cCodEmpCMB >= MV_PAR02) .and. (cCodEmpCMB <= MV_PAR03) )

		DbSelectArea("PDD")
		DbSetOrder(1) //Buscar Parametros na Matriz de Cobrança/Copart
		If DbSeek(xFilial("PDD")+cCodEmpCMB)
			While !PDD->(EOF()) .AND. PDD->PDD_CODEMP == cCodEmpCMB

				If cAnoFt+cMesFt >= SUBS(DTOS(PDD->PDD_VIGINI),1,6) .AND. (cAnoFt+cMesFt <= SUBS(DTOS(PDD->PDD_VIGFIN),1,6) .or. EMPTY(PDD->PDD_VIGFIN))
					lCobrancaCC	:= PDD->PDD_COBRCC == '1'
				Endif

				PDD->(DbSkip())

			Enddo
		Endif

		PDD->(DbCloseArea())

	Endif

	//********************************************************//
	//*** INÍCIO DA EXCLUSÃO DE QUEM TEVE MOVIMENTO NO MES ***//
	//********************************************************//
	If lCobrancaCC

		aAdd(aMatrics,BDH->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG))

		DelPdnBsq(BDH->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG))

		//*****************************************************//
		//*** FIM DA EXCLUSÃO DE QUEM TEVE MOVIMENTO NO MES ***//
		//*****************************************************//

		//*****************************************************************************************//
		//*** VERIFICACAO DA EXISTENCIA DE MATRICULAS QUE NAO FIZERAM PARTE DESTA CONSOLIDAÇAO, ***//
		//*** MAS QUE POSSUEM SALDO A SER COBRADO. 												***//
		//*****************************************************************************************//

		//VERIFICAR SE PARA ESTAS MATRICULAS SELECIONADAS EXISTE ALGUM SALDO REMANESCENTE
		cQryCC	:= " SELECT * "
		cQryCC	+= "   FROM "+RetSqlName("PDN")+" PDN " 										+ CRLF
		cQryCC	+= "  WHERE PDN_FILIAL = '"+xFilial("PDN")+"' " 								+ CRLF
		cQryCC	+= "    AND D_E_L_E_T_ = ' ' " 													+ CRLF
		cQryCC	+= "    AND PDN_SEQUEN IN (SELECT MAX(PDN_SEQUEN) " 							+ CRLF
		cQryCC	+= "                        FROM "+RetSqlName("PDN")+" PDN2 " 					+ CRLF
		cQryCC	+= "                        WHERE PDN2.PDN_FILIAL = '"+xFilial("PDN")+"' " 		+ CRLF
		cQryCC	+= "                          AND PDN2.PDN_MATRIC = PDN.PDN_MATRIC " 			+ CRLF
		cQryCC	+= "    					  AND D_E_L_E_T_ = ' ' )"   			 			+ CRLF
		cQryCC	+= " ORDER BY PDN_MATRIC, PDN_COMPET,PDN_SEQUEN "								+ CRLF

		If Select(cAliasCC) > 0
			(cAliasCC)->(DbCloseArea())
			cAliasCC := GetNextAlias()
		Endif

		PLSQuery(cQryCC,cAliasCC)

		While !(cAliasCC)->(EOF())
		
			If EMPTY((cAliasCC)->PDN_LOTCOB)
				nPos := 0
				nPos := ASCAN(aMatrics, (cAliasCC)->PDN_MATRIC)
				If nPos == 0
					DelPdnBsq((cAliasCC)->PDN_MATRIC)
				Endif
			Endif
			(cAliasCC)->(DbSkip())
		Enddo

		If Select(cAliasCC) > 0
			(cAliasCC)->(DbCloseArea())
		Endif
	Endif

	RestArea(aAreaBA1)
	RestArea(aAreaBSQ)

Return lRet

//**********************************************************//
//*** FUNÇÃO: DelPdnBsq  - Deleta PDN e BSQ não cobrados ***//
//*** Função que deleta o Conta Corrente e Débitos e     ***// 
//*** Creditos ao assistido sem cobrança ao reconsolidar ***//
//**********************************************************//
Static Function DelPdnBsq(cMatric)

	DbSelectArea("BA1")
	DbSetOrder(2) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO + R_E_C_N_O_ + D_E_L_E_T_
	If DbSeek( xFilial("BA1") + cMatric )
		
		DbSelectArea("PDN")
		DbSetOrder(1)
		If DbSeek(xFilial("PDN") + cMatric)
			
			While !PDN->(EOF()) .AND. PDN->(PDN_FILIAL+PDN_MATRIC) == xFilial("PDN") + cMatric
				If EMPTY(PDN->PDN_LOTCOB)
					
					//BUSCANDO LANÇAMENTO A CREDITO
					DbSelectArea("BSQ")
					DbSetOrder(2) //BSQ_FILIAL + BSQ_USUARI + BSQ_CONEMP + BSQ_VERCON + BSQ_SUBCON + BSQ_VERSUB + BSQ_ANO + BSQ_MES + BSQ_CODLAN + BSQ_COBNIV
					If DbSeek(xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANCRE)
						While !BSQ->(EOF()) .AND. BSQ->(BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN) == xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANCRE
							If EMPTY(BSQ->BSQ_NUMCOB) .AND. EMPTY(BSQ->BSQ_PREFIX) .AND. EMPTY(BSQ->BSQ_NUMTIT) .AND. EMPTY(BSQ->BSQ_PARCEL) .AND. EMPTY(BSQ->BSQ_TIPTIT)
								Reclock("BSQ",.F.)
								DbDelete()
								MsUnlock()
							Endif
							BSQ->(DbSkip())
						Enddo
					Endif
					//BUSCANDO LANÇAMENTO A DEBITO
					If DbSeek(xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANDEB)
						While !BSQ->(EOF()) .AND. BSQ->(BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN) == xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANDEB
							If EMPTY(BSQ->BSQ_NUMCOB) .AND. EMPTY(BSQ->BSQ_PREFIX) .AND. EMPTY(BSQ->BSQ_NUMTIT) .AND. EMPTY(BSQ->BSQ_PARCEL) .AND. EMPTY(BSQ->BSQ_TIPTIT)
								Reclock("BSQ",.F.)
								DbDelete()
								MsUnlock()
							Endif
							BSQ->(DbSkip())
						Enddo
					Endif
					//BUSCANDO LANÇAMENTO DE SALDO
					If DbSeek(xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANSLD)
						While !BSQ->(EOF()) .AND. BSQ->(BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN) == xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+SUBS(PDN->PDN_COMPET,1,4)+SUBS(PDN->PDN_COMPET,5,2)+PDN->PDN_LANSLD
							If EMPTY(BSQ->BSQ_NUMCOB) .AND. EMPTY(BSQ->BSQ_PREFIX) .AND. EMPTY(BSQ->BSQ_NUMTIT) .AND. EMPTY(BSQ->BSQ_PARCEL) .AND. EMPTY(BSQ->BSQ_TIPTIT)
								Reclock("BSQ",.F.)
								DbDelete()
								MsUnlock()
							Endif
							BSQ->(DbSkip())
						Enddo
					Endif

					BSQ->(DbCloseArea())
					//DELETO PDN AQUI PORQUE PRECISO DELA ANTES PARA PONTEIRAR OS LANÇAMENTOS DE BSQ
					Reclock("PDN",.F.)
					PDN->(DbDelete())
					PDN->(MsUnlock())
				Endif
				PDN->(DbSkip())
			Enddo
		Endif
		PDN->(DbCloseArea())
	Endif
	
	BA1->(DbCloseArea())

Return
