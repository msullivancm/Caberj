#include "topconn.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS180AC  ºAutor  ³Microsiga           º Data ³  27/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada que modifica o criterio de consolidacao    º±±
±±º          ³para somente guias ja faturadas serem cobradas.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PLS180AC()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Instrucoes - PE:                                                                                 ³
	//³Considere sempre o BD6 posicionado no momento da entrada no ponto de entrada                     ³
	//³Importante:                                                                                      ³
	//³Salvar e restaurar areas, ordens e recnos desposionados nesta rotina                             ³
	//³Altere lSuaRegra com a sua condicao, como por exemplo acessar alguma informacao em outra tabela e³
	//³devolver .T. ou .F. para esta variavel                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Local lConsolida 	:= .T.
	Local cCorteRepInt	:= GetNewPar('MV_XREPINT','201402')//Repasse Integral. Periodo de corte 2014/01 informado pelo Alan
	Local aArea			:= GetArea()
	Local aAreaBD7 		:= BD7->(GetArea())

	//Processo de Vacinas
	Local aCodProc		:= StrTokArr(GetNewPar("MV_XCODVAX","98;80190413|80190421"),";")     	// [ codtab ; codpro's ]

	//Regra Caberj: Somente guias ja faturadas (Fase = 4) podem ser cobradas...
	//Porem, se for guia de estorno, deve cobrar...
	//Em 27/01/09, necessario cobrar proc. OPME que nao esteja faturado (nunca sera pago, porem deve ser cobrado).
	If BD6->BD6_FASE <> "4" //Somente faturadas...

		lConsolida := .F.

	EndIf

	//--------------------------------
	//Reembolso
	//--------------------------------
	If BD6->BD6_CODLDP == '9000'
		lConsolida := .F.
	EndIf

	//Trata somente se a guia possuir um procedimento de OPME, e estiver ativa + pronta, e a RDA for GENERICA...
	If ( BD6->(BD6_SITUAC+BD6_FASE) == "13" ) .and. ( Alltrim(BD6->(BD6_CODPAD+BD6_CODPRO)) $ GetNewPar("MV_YPRCPOP","") )//Proc. OPME  //CAB.:0601990012,0602990016,0603990010    INT.:0701990012,0702990016,0703990010

		BD7->(DbSetOrder(1))

		If BD7->(MsSeek(xFilial("BD7") + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN)))

			If BD7->BD7_CODRDA == GetNewPar("MV_PLSRDAG","")  .OR. BD7->BD7_CODRDA $ GetNewPar("MV_YRDAMED","")
				lConsolida := .T.
			EndIf

		EndIf

		BD7->(RestArea(aAreaBD7))

	EndIf

	//Leonardo Portella - 23/03/14 - Inicio - Repasse para Integral. Periodo de corte 2014/01 informado pelo Alan
	If lConsolida .and. ( cEmpAnt == '01' ) .and. ( BD6->BD6_CODEMP == '0009' )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ANOPAG e MESPAG nao necessariamente batem com o NUMLOT pois sao a competencia e nao necessariamente o pagamento, por isso uso o NUMLOT.³
		//³O PLSM180 (Consolidacao) olha o BD6_ANOPAG e BD6_MESPAG em ate 6 meses anteriores ao parametro informado.                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		lConsolida :=  Left(BD6->BD6_NUMLOT,6) == cCorteRepInt


	ElseIf lConsolida  .and.  !(cEmpAnt == '01' .and. BD6->BD6_CODEMP $ '0013|0017')

		lConsolida :=  Left(BD6->BD6_NUMLOT,6) < mv_par04 + mv_par05

	EndIf

	//-----------------------------------------------------------------------------------
	//ANGELO HENRIQUE - Data: 13/01/2021
	//-----------------------------------------------------------------------------------
	//Conforme analisado estava consolidando um mês a frente, trazendo assim
	//inconsistência a validação
	//-----------------------------------------------------------------------------------
	If lConsolida  .and.  cEmpAnt == '01' .and. BD6->BD6_CODEMP $ '0013|0017'

		//--------------------------------------------------------------------------------------------
		// Angelo Henrique - 17/10/2022
		//--------------------------------------------------------------------------------------------
		//Conforme solicitado pela GEFIN deve sempre cobrar procedimentos após a data de 01/08/2021
		//Não entrando a regra utilizada de 6 meses para as demais empresas
		//--------------------------------------------------------------------------------------------
		If  BD6->BD6_DATPRO < STOD('20210801')

			lConsolida := .F.

		EndIf

	EndIf

	If lConsolida  .and.  cEmpAnt == '01' .and. BD6->BD6_CODEMP == '0004'

		lConsolida :=  Left(BD6->BD6_NUMLOT,6) < mv_par04 + mv_par05

	EndIf

	If lConsolida  .and.  cEmpAnt == '02' .and. BD6->BD6_CODEMP == '0325'

		lConsolida :=  Left(BD6->BD6_NUMLOT,6) < mv_par04 + mv_par05

	EndIf

	// altamiro 05/11/2021 - tratar valor de pagto = 0 mas com valor de participação preenchido
	If lConsolida .and. BD6->BD6_Vlrpag == 0

		lConsolida:= .F.

	EndIf

	//-----------------------------------------------------------
	//Angelo Henrique - Data: 04/01/2023
	//-----------------------------------------------------------
	//Processo de validação das vacinas
	//-----------------------------------------------------------
	If lConsolida  .and.  cEmpAnt == '01' .and. BD6->BD6_CODEMP $ "0001|0002|0003|0005"

		If BD6->BD6_CODPAD == aCodProc[1] .and. AllTrim(BD6->BD6_CODPRO) $ aCodProc[2]

			//-------------------------------------------------------------------------------------------------------------
			//Não permito que seja consolidado esse item e faço o processo de geração dos lançamentos de débito e crédito
			//-------------------------------------------------------------------------------------------------------------
			lConsolida := .F.

			//--------------------------------------------
			//Se reconsolidado excluir o que foi criado
			//--------------------------------------------
			If u180exc()

				//--------------------------------------------
				//Rotina que irá gerar os lançamentos
				//--------------------------------------------
				u180vac()

			EndIf

		EndIf

	EndIf

	RestArea(aArea)

Return lConsolida


/*/{Protheus.doc} u180vac
Rotina que irá gerar lançamentos de débito e crédito pertinentes as vacinas
@type function
@version  1.0
@author angelo.cassago
@since 04/01/2023
/*/
Static Function u180vac()

	Local _aAreBA1 	:= BA1->(GetArea())
	Local aDadUsr	:= {}
	Local nParVax	:= 4
	Local aParcela	:= {}
	Local aCodCrDb	:= { GetNewPar("MV_XCDCRTO","087"), GetNewPar("MV_XCDDETO","088") }
	Local cCodDebt	:= GetNewPar("MV_XCDDEBT","086")
	Local _nCont	:= 0
	Local cMsgObs	:= "PARCELAMENTO DE VACINAS: "
	Local _nMes		:= 0
	Local _cMes		:= ""
	Local _nAno		:= 0
	Local _cAviso 	:= ""

	DbSelectArea("BA1")
	DbSetOrder(2)
	If Dbseek(xFilial("BA1") + BD6->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO))

		_cAviso += "Favor rever essa consolidação. " + CRLF
		_cAviso += "Houve problema na consolidação da vacina. " + CRLF
		_cAviso += "Matricula: " + BD6->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) + "." + CRLF
		_cAviso += "Nome: " + AllTrim(BA1->BA1_NOMUSR) + "."

		aDadUsr := {BA1->BA1_CODINT,; //1
		BA1->BA1_CODEMP,; //2
		BA1->BA1_MATRIC,; //3
		BA1->BA1_CONEMP,; //4
		BA1->BA1_VERCON,; //5
		BA1->BA1_SUBCON,; //6
		BA1->BA1_VERSUB,; //7
		"",; //8
		BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO); //9
		}

		// Lancar debito total (informativo)
		aParcela	:= {}
		aAdd(aParcela, {MV_PAR04 + MV_PAR05		,;
			BD6->BD6_VLRTPF						,;
			MV_PAR05 + "/" + MV_PAR04			,;
			aCodCrDb[1]							,;
			""									,;
			""									,;
			"DEBITO DE PARCELAMENTO DE VACINAS"	})

		// Gerar credito atraves de funcao personalizada generica...
		if GerBSQVC(aParcela, aDadUsr)

			// Lancar credito total (informativo)
			aParcela	:= {}
			aAdd(aParcela, {MV_PAR04 + MV_PAR05		,;
				BD6->BD6_VLRTPF						,;
				MV_PAR05 + "/" + MV_PAR04			,;
				aCodCrDb[2]							,;
				""									,;
				""									,;
				"CREDITO DE PARCELAMENTO DE VACINAS"})

			// Gerar credito atraves de funcao personalizada generica...
			if !GerBSQVC(aParcela, aDadUsr)

				//Chama rotina para excluir o que foi criado caso de erro
				u180exc()

				Aviso("Atenção",_cAviso,{"OK"})
			endif

			// Gerar debitos do valor retirado referentes as vacinas
			nVlrParUsr	:= NoRound(BD6->BD6_VLRTPF / nParVax, 2)

			// Lancar debitos restantes, para proximos meses...
			for _nCont := 1 to nParVax

				aParcela := {}

				If _nCont == 1

					_nMes := Val(MV_PAR05)
					_cMes := MV_PAR04 + MV_PAR05

				Else

					//-------------------------------------------------------------------------------------
					//Se for dezembo necessário zerar o mês e somar um ano para as próximas parcelas
					//-------------------------------------------------------------------------------------
					If _nMes == 12

						_nAno := Val(MV_PAR04)

						_nMes := 1
						_nAno += 1

						_cMes := cValtoChar(_nAno) + StrZero(_nMes,2)

					Else

						If _nAno <> 0

							_cAno := cValtoChar(_nAno)

						Else

							_cAno := MV_PAR04

						Endif

						_nMes := _nMes + 1
						_cMes := _cAno + StrZero(_nMes,2)

					EndIf

				EndIf

				aAdd(aParcela, {_cMes										,;
					nVlrParUsr												,;
					MV_PAR04 + "/" + StrZero(_nMes,2)						,;
					cCodDebt												,;
					""														,;
					""														,;
					cMsgObs + StrZero(_nCont,2) + "/" + StrZero(nParVax,2)	})

				// Gerar debitos atraves de funcao personalizada generica...
				if !GerBSQVC(aParcela, aDadUsr)

					//Chama rotina para excluir o que foi criado caso de erro
					u180exc()

					Aviso("Atenção",_cAviso,{"OK"})

				endif

			next

		Else

			u180exc()

			Aviso("Atenção",_cAviso,{"OK"})

		endif

	EndIf

	RestArea(_aAreBA1)

Return


/*/{Protheus.doc} GerBSQVc
Rotina que irá gerar os lançamentos de vacina na BSQ
@type function
@version 1.0 
@author angelo.cassago
@since 04/01/2023
@param aDadosPar, array, Informações sobre o lançamento
@param aDadosUsr, array, Informações do usuário
@return variant, retorna verdadeiro ou falso 
/*/
Static Function GerBSQVC(aDadosPar,aDadosUsr)

	Local lRet			:= .F.
	Local nCont			:= 0
	Local cNivel		:= ""
	Local lCalcNivCob	:= .F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Legenda Matriz aDadosPar[N,X]                                         ³
	//³ 1-AnoMes - Caractere - 006 posicoes                                   ³
	//³ 2-VlrPar - Numerico  - 017,4                                          ³
	//³ 3-Mes/Ano- Caractere - 007 posicoes (MM/AAAA)                         ³
	//³ 4-CodLan - Caractere - 003 posicoes                                   ³
	//³ 5-CCusto - Numerico  - 009 posicoes                                   ³
	//³ 6-IteCta - Caractere - 009 posicoes                                   ³
	//³ 7-Observ - Caractere - 100 posicoes                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Legenda Vetor aDadosUsr[]                                             ³
	//³ 1-CodInt - Caractere - 04 posicoes                                    ³
	//³ 2-CodEmp - Caractere - 04 posicoes                                    ³
	//³ 3-Matric - Caractere - 06 posicoes                                    ³
	//³ 4-ConEmp - Caractere - 12 posicoes                                    ³
	//³ 5-VerCon - Caractere - 03 posicoes                                    ³
	//³ 6-SubCon - Caractere - 09 posicoes                                    ³
	//³ 7-VerSub - Caractere - 03 posicoes                                    ³
	//³ 8-NivCob - Caractere - 01 posicao (opcional)                          ³
	//³ 9-CodUsu - Caractere - 17 posicao (opcional - mat.completa usr)       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	BSQ->(DbSetOrder(1))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obtem nivel de cobranca, caso nao esteja na matriz de usuarios        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aDadosUsr) > 7
		If Empty(aDadosUsr[8])
			lCalcNivCob := .T.
		Endif
	Else
		lCalcNivCob := .T.
	Endif

	If lCalcNivCob
		If !Empty(aDadosUsr[3])
			cNivel := '5'
		Elseif !Empty(aDadosUsr[6])
			cNivel := '3'
		Elseif !Empty(aDadosUsr[4])
			cNivel := '2'
		Elseif !Empty(aDadosUsr[2])
			cNivel := '1'
		Endif
	Else
		cNivel := aDadosUsr[8]
	Endif

	For nCont := 1 to Len(aDadosPar)

		BSP->(DbSetOrder(1))
		If BSP->(MsSeek(xFilial("BSP")+aDadosPar[nCont,4]))

			If aDadosPar[nCont,2] > 0

				a_AreaBsq := GetArea("BSQ")

				BSQ->(Reclock("BSQ",.T.))
				BSQ->BSQ_FILIAL	:= xFilial("BSQ")
				BSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
				BSQ->BSQ_CODINT	:= aDadosUsr[1]
				BSQ->BSQ_CODEMP	:= aDadosUsr[2]
				BSQ->BSQ_MATRIC	:= aDadosUsr[3]
				BSQ->BSQ_CONEMP	:= aDadosUsr[4]
				BSQ->BSQ_VERCON	:= aDadosUsr[5]
				BSQ->BSQ_SUBCON	:= aDadosUsr[6]
				BSQ->BSQ_VERSUB	:= aDadosUsr[7]
				BSQ->BSQ_COBNIV	:= cNivel

				If Len(aDadosUsr) > 8
					BSQ->BSQ_USUARI	:= aDadosUsr[9]	// Conforme regra de inclusao de debito/credito, quando eh informado o campo BSQ_USUARI, o nivel devera sempre ser 5
					BSQ->BSQ_COBNIV := '5'
				Endif

				BSQ->BSQ_ANO	:= Substr(aDadosPar[nCont,1],1,4)
				BSQ->BSQ_MES	:= Substr(aDadosPar[nCont,1],5,2)
				BSQ->BSQ_CODLAN	:= aDadosPar[nCont,4]
				BSQ->BSQ_VALOR	:= aDadosPar[nCont,2]
				BSQ->BSQ_NPARCE	:= "1"
				BSQ->BSQ_CC		:= aDadosPar[nCont,5]
				BSQ->BSQ_ITECTA	:= aDadosPar[nCont,6]
				BSQ->BSQ_OBS	:= aDadosPar[nCont,7]
				BSQ->BSQ_AUTOMA	:= "1"
				BSQ->BSQ_TIPO	:= BSP->BSP_TIPSER
				BSQ->BSQ_TIPEMP	:= "2"
				BSQ->BSQ_ATOCOO	:= "1"

				BSQ->BSQ_ZHIST	:= cValtoChar(BD6->(RECNO()))

				BSQ->(MsUnlock())

				lRet := .T.

			Endif

		EndIf

	Next

Return lRet


/*/{Protheus.doc} u180exc
Rotina utilizada para limpar os lançamentos gerados pelo processo de vacina
caso seja efetuada a reconsolidação
@type function
@version  1.0
@author angelo.cassago
@since 06/01/2023
@return variant, retorna se conseguiu ou não
/*/
Static Function u180exc()

	Local cQuery 	:= ""
	Local _aAreBSQ	:= BSQ->(GetArea())
	Local _aAreBA1	:= BA1->(GetArea())
	Local _lRet		:= .T.
	Local cCodCred	:= GetNewPar("MV_XCDCRED","085")
	Local cCodDebt	:= GetNewPar("MV_XCDDEBT","086")
	Local aCodCrDb	:= { GetNewPar("MV_XCDCRTO","087"), GetNewPar("MV_XCDDETO","088") }

	Local cAliasQr2	:= GetNextAlias()

	DbSelectArea("BA1")
	DbSetOrder(2)
	If Dbseek(xFilial("BA1") + BD6->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO))

		cQuery := " SELECT 				" + CRLF
		cQuery += " 	BSQ.BSQ_CODSEQ 	" + CRLF
		cQuery += " FROM 				" + CRLF
		cQuery += " 	" + RetSqlName("BSQ") + " BSQ " + CRLF
		cQuery += " WHERE  " + CRLF
		cQuery += " 	BSQ.BSQ_FILIAL = '" + xFilial("BSQ") + "' 				" + CRLF
		cQuery += " 	AND BSQ.BSQ_ZHIST = '" + cValtoChar(BD6->(RECNO())) + "'" + CRLF
		cQuery += " 	AND 											" + CRLF
		cQuery += " 		(											" + CRLF
		cQuery += " 			BSQ.BSQ_CODLAN = '" + cCodCred + "' 	" + CRLF
		cQuery += " 			OR 										" + CRLF
		cQuery += " 			BSQ.BSQ_CODLAN = '" + cCodDebt + "'		" + CRLF
		cQuery += " 			OR										" + CRLF
		cQuery += " 			BSQ.BSQ_CODLAN = '" + aCodCrDb[1] + "'	" + CRLF
		cQuery += " 			OR										" + CRLF
		cQuery += " 			BSQ.BSQ_CODLAN = '" + aCodCrDb[2] + "' 	" + CRLF
		cQuery += " 		) 											" + CRLF
		cQuery += " 	AND BSQ.D_E_L_E_T_ = ' ' 						" + CRLF

		TcQuery cQuery New Alias (cAliasQr2)

		If (cAliasQr2)->(!EOF())

			//Primeiro Valido se tem algum utilizado
			//caso tenha, não pode consolidar e executar o processo
			(cAliasQr2)->(DbGoTop())

			while (cAliasQr2)->(!EOF())

				DbSelectArea("BSQ")
				DbSetOrder(1)
				If DbSeek(xFilial("BSQ") + (cAliasQr2)->BSQ_CODSEQ)

					If !Empty(BSQ->BSQ_NUMTIT) .OR. !Empty(BSQ->BSQ_NUMCOB)

						_lRet := .F.

						Exit

					EndIf

				EndIf

				(cAliasQr2)->(DbSkip())

			ENDDO

			If _lRet

				(cAliasQr2)->(DbGoTop())

				while (cAliasQr2)->(!EOF())

					DbSelectArea("BSQ")
					DbSetOrder(1)
					If DbSeek(xFilial("BSQ") + (cAliasQr2)->BSQ_CODSEQ)

						BSQ->(RecLock("BSQ",.F.))
						BSQ->(DbDelete())
						BSQ->(MsUnLock())

					EndIf

					(cAliasQr2)->(DbSkip())

				ENDDO

			EndIf

		EndIf

	EndIf

	RestArea(_aAreBA1)
	RestArea(_aAreBSQ)

Return _lRet
