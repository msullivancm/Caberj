#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"
#INCLUDE "utilidades.ch"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³CADPROREM º Autor ³ Leandro            º Data ³  29/06/07   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDescricao ³ AxCadastro para protocolos de remessas das RDAs            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ CABERJ- Semelhante a guia capa remessa do Saude            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºOBS       ³ Leonardo Portella - 30/08/12 - Remodelagem do processo     º±±
±±º          ³ conforme solicitado por Dr. Giordano - chamado ID 3353     º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CADPROREM

	Local cAlias := "ZZP"
	Local aCores := {}

	Private cCadastro 	:= "Cadastro de Protocolo de capas remessas"
	Private aRotina 	:= {}
	Private cCampoCons	:= 'CTT_CUSTO,CTT_DESC01'
	private _cAliasTemp := GetNextAlias()

	aAdd(aRotina,{"Pesquisar" 					,"AxPesqui"		,0,1})
	aAdd(aRotina,{"Visualizar" 					,"AxVisual"		,0,2})
	aAdd(aRotina,{"Incluir" 					,"U_INCZZP"		,0,3})
	aAdd(aRotina,{"Alterar" 					,"U_ALTZZP"		,0,4})
	aAdd(aRotina,{"Mudar Status"				,"U_MUDZZP"		,0,4})
	aAdd(aRotina,{"Cancelar"					,"U_CANZZP"		,0,4})
	//aAdd(aRotina,{"Excluir" 					,"AxDeleta"		,0,5})
	aAdd(aRotina,{"Legenda" 					,"U_LegZZP" 	,0,3})
	aAdd(aRotina,{'Status RDA/ Lib. Excep.'		,'U_StatusRDA'	,0,3}) //Leonardo Portella - 30/09/16
	aAdd(aRotina,{"Compr. Indiv." 				,"U_nProtInd"	,0,4}) //Leonardo Portella - 30/09/16

	aAdd(aCores,{"ZZP->ZZP_STATUS == 'PPR'" ,"BR_AMARELO" 	})
	aAdd(aCores,{"ZZP->ZZP_STATUS == 'CPR'" ,"BR_VERDE" 	})
	aAdd(aCores,{"ZZP->ZZP_STATUS == 'CCA'" ,"BR_VERMELHO" 	})
	aAdd(aCores,{"ZZP->ZZP_STATUS == 'PCA'" ,"BR_PRETO" 	})

	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbGoTop()

	mBrowse(6,1,22,75,cAlias,,,,,2,aCores)

Return

*******************************************

//³Rotina que verifica se ja existe a remossa para o trio ANO/MES/RDA|

User Function VALZZP()

	Local lRet 		:= .T.
	Local cSQLTmp 	:= ""
	Local cNumOper 	:= ""
	Local cMsg		:= ''

	If INCLUI

		//Leonardo Portella - 13/10/16 - Início - Não permitir inclusão de comprovantes manuais se o prestador estiver habilitado na Operativa ou se já
		//existir um protocolo da Operativa na base.
		//Apenas alguns usuários terão autorização de fazer esta inclusão mesmo estando habilitado

		If lRet .and. ( M->ZZP_TIPPRO <> '1' ) //Crítica não se aplica ao Tipo 1: Recuperação/recurso de glosa

			cSQLTmp := " SELECT ZZP_NUMREM "
			cSQLTmp += " FROM "+RetSqlName("ZZP")+" ZZP "
			cSQLTmp += " WHERE ZZP_FILIAL = '"+xFilial("ZZP")+"' "
			cSQLTmp += " AND ZZP_CODRDA = '" + M->ZZP_CODRDA + "' "
			cSQLTmp += " AND ZZP_MESPAG = '" + M->ZZP_MESPAG + "' "
			cSQLTmp += " AND ZZP_ANOPAG = '" + M->ZZP_ANOPAG + "' "
			cSQLTmp += " AND ZZP_IDOPER > 0 "
			cSQLTmp += " AND ZZP_STATUS IN ('PPR','CPR')  "
			cSQLTmp += " AND D_E_L_E_T_ = ' ' "

			PLSQUERY(cSQLTmp,"TRBZZP")

			TRBZZP->(DbGoTop())

			If !TRBZZP->(Eof())
				cMsg += "J� existe um protocolo inclu��do pela Operativa para este ANO/MES/RDA [ Protocolo: " + cValToChar(TRBZZP->ZZP_NUMREM) + " ]" + CRLF
				lRet := .F.
			Endif

			TRBZZP->(DbCloseArea())

		EndIf

		If lRet .and. ( M->ZZP_TIPPRO <> '1' ) //Crítica não se aplica ao Tipo 1: Recuperação/recurso de glosa

			cSQLTmp := "SELECT BAU_XMEDLI" 								+ CRLF
			cSQLTmp += "FROM " + RetSqlName('BAU') 						+ CRLF
			cSQLTmp += "WHERE BAU_FILIAL = '" + xFilial('BAU') + "'" 	+ CRLF
			cSQLTmp += "  AND BAU_CODIGO = '" + M->ZZP_CODRDA + "'" 	+ CRLF
			cSQLTmp += "  AND D_E_L_E_T_ = ' '" 						+ CRLF

			TcQuery cSQLTmp New Alias "TRBBAU"

			If ( TRBBAU->BAU_XMEDLI == 'S' )

				cMsg += "Prestador habilitado [ status implantado ] para envio na Operativa/Medlink. Não será permitido incluir protocolo pois o mesmo deverá vir da Operativa." + CRLF
				lRet := .F.

				//Leonardo Portella - 24/10/16 - Conforme observação na RDM 225, foi solicitado pela Dra Carla que o prestador em
				//implantação seja tratado como "Não implantado"
				/*
			ElseIf TRBBAU->BAU_XMEDLI == 'I' //Em implantação

				cMsg += "Prestador em implantação para envio na Operativa/Medlink. Caso seja necessário, solicite liberação excepcional ao Contas Médicas" + CRLF
				lRet := .F.
				*/

			EndIf

			TRBBAU->(DbCloseArea())

			//Leonardo Portella - 13/10/16 - Fim

		EndIf

		//Leonardo Portella - 26/10/16 - As críticas acima podem ter autorização excepcional conforme solicitado por Max em 26/10/16 informando que
		//é solicitação da Diretoria

		If !lRet

			cSQLTmp := "SELECT 1"		 												+ CRLF
			cSQLTmp += "FROM " + RetSqlName('PB0') 										+ CRLF
			cSQLTmp += "WHERE PB0_FILIAL = '" + xFilial('PB0') + "'" 					+ CRLF
			cSQLTmp += "  AND PB0_CODRDA = '" + M->ZZP_CODRDA + "'" 					+ CRLF
			cSQLTmp += "  AND PB0_ANO = '" + M->ZZP_ANOPAG + "'"	 					+ CRLF
			cSQLTmp += "  AND PB0_MES = '" + M->ZZP_MESPAG + "'" 						+ CRLF
			cSQLTmp += "  AND PB0_REMESS = '" + cValToChar(M->ZZP_NUMREM) + "'" 		+ CRLF
			cSQLTmp += "  AND D_E_L_E_T_ = ' '" 										+ CRLF

			TcQuery cSQLTmp New Alias "TRBPB0"

			If !TRBPB0->(EOF())
				lRet := .T. //Autorizado excepcionalmente
			EndIf

			TRBPB0->(DbCloseArea())

		EndIf

		cSQLTmp := " SELECT ZZP_CODRDA, ZZP_ANOPAG, ZZP_MESPAG, ZZP_NUMREM"
		cSQLTmp += " FROM "+RetSqlName("ZZP")+" ZZP "
		cSQLTmp += " WHERE ZZP_FILIAL = '"+xFilial("ZZP")+"' "
		cSQLTmp += " AND ZZP_CODRDA = '" + M->ZZP_CODRDA + "' "
		cSQLTmp += " AND ZZP_NUMREM =  " + CVALTOCHAR(M->ZZP_NUMREM) + "  "
		cSQLTmp += " AND ZZP_STATUS IN ('PPR','CPR')  "
		cSQLTmp += " AND D_E_L_E_T_ = ' ' "
		cSQLTmp += " ORDER BY ZZP_ANOPAG || ZZP_MESPAG DESC "

		PLSQUERY(cSQLTmp,"TRBZZP")

		TRBZZP->(DbGoTop())

		cBuffer := ''

		While !TRBZZP->(Eof())

			cBuffer := "Protocolo [ " + cValtoChar(M->ZZP_NUMREM) + " ] já digitado para este RDA" 		+ CRLF
			lRet 	:= .F.

			If ( ( TRBZZP->ZZP_MESPAG == M->ZZP_MESPAG ) .and. ( TRBZZP->ZZP_ANOPAG == M->ZZP_ANOPAG ) )

				If M->ZZP_TIPPRO == '0' //Se o protocolo que está sendo incluído é do tipo Pagto Normal eu posso criticar

					cBuffer := "Protocolo [ " + cValtoChar(M->ZZP_NUMREM) + " ] já digitado para este ANO/MES/RDA" + CRLF
					lRet 	:= .F.

					Exit

				EndIf

			EndIf

			TRBZZP->(DbSkip())

		EndDo

		cMsg += cBuffer

		TRBZZP->(DbCloseArea())

	EndIf

	If lRet .and. ( INCLUI .OR. ALTERA )

		If ( M->ZZP_TIPPRO == '1' ) .and. empty(M->ZZP_REMORI) //Revisao e nao informou o numero da remessa original
			cMsg += "Numero da Remessa Origem obrigatorio para tipo de protocolo 'RECUPERACAO'" + CRLF + CRLF + "Preencha o campo [ Rem. Origem ] !" + CRLF
			lRet := .F.
		EndIf

	EndIf

	If empty(M->ZZP_MESPAG) .or. empty(M->ZZP_ANOPAG)
		cMsg += 'Ano e mes de competencia sao obrigatorios!' + CRLF
		lRet := .F.
	EndIf

	If !lRet
		MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	EndIf

	//Inicio Alteração Renato Peixoto em 06/08/12
	//Por algum motivo nao identificado, os novos campos totalizadores da ZZP estao ficando zerados. Este ponto força a totalizacao se isso ocorrer nessa rotina
	/*
	If M->ZZP_VLTGUI = 0

		M->ZZP_VLTGUI := M->(ZZP_VLRTOT+ZZP_VLTOTI+ZZP_VLRODN)
	EndIf

	If M->ZZP_QTOTGU = 0
		M->ZZP_QTOTGU := M->(ZZP_QTDTOT+ZZP_QTOTIN+ZZP_QTDODN)
	EndIf
	*/
	//Por via das duvidas, atualizo mais uma vez via fonte o conteudo de cada campo de memoria, para nao correr o risco de ficar com o campo totalizador zerado
	If INCLUI .OR. ALTERA
		M->ZZP_QTDTOT := M->(ZZP_QTDCON+ZZP_QTDSAD+ZZP_QTDAMB)
		M->ZZP_QTOTIN := M->(ZZP_QTDINT+ZZP_SADINT+ZZP_QTDHON+ZZP_QTDODS)
		M->ZZP_QTOTGU := M->(ZZP_QTDTOT+ZZP_QTOTIN+ZZP_QTDODN)

		M->ZZP_VLRTOT := M->(ZZP_VLRCON+ZZP_VLRSAD+ZZP_VLRAMB)
		M->ZZP_VLTOTI := M->(ZZP_VLRINT+ZZP_VLSDTI+ZZP_VLRHON+ZZP_VLRODS)
		M->ZZP_VLTGUI := M->(ZZP_VLRTOT+ZZP_VLTOTI+ZZP_VLRODN)
	EndIf
	//Fim alteração Renato Peixoto.

Return lRet

***********************************

User Function CANZZP

	Local aArea			:= GetArea()
	Local lUsrPodeCan 	:= ( AllTrim(Upper(cUserName)) $ GetNewPar('MV_XUSCARE','MARIANA.OLIVEIRA|DANIELLE|ANTONIOA|LEONARDO.PORTELLA') )//Usuarios que podem cancelar
	Local nDiasCan 		:= GetNewPar('MV_XDICARE',2)//Maximo de dias permitidos para cancelar a previa da remessa sem autorizacao especial
	Local cMsg	   		:= ""
	Local aRetCan		:= {}
	Local lCancelou		:= .F.
	Local cQuery		:= ""
	Local cAlias		:= GetNextAlias()

	BEGIN TRANSACTION

		Do Case

			Case ZZP->ZZP_STATUS == 'CPR'

				If lUsrPodeCan

					If MsgYesNo('Permissao de cancelamento da comprovante. ' + AllTrim(Upper(cUserName)) + ', confirma o cancelamento?',SM0->M0_NOMECOM)

						aRetCan := aMotCanc()

						If aRetCan[1]

							//Leonardo Portella - 18/06/13 - Inicio

							If ( Date() - ZZP->ZZP_DATDIG ) > 30
								MsgAlert('ATENÇÃO - Cancelamento de comprovante com mais de 30 dias',SM0->M0_NOMECOM)
								aRetCan[1] := MsgYesNo('Permissao de cancelamento da comprovante com mais de 30 dias. ' + AllTrim(Upper(cUserName)) + ', confirma o cancelamento?',SM0->M0_NOMECOM)
							EndIf

							If aRetCan[1]

								//Leonardo Portella - 18/06/13 - Fim

								Reclock('ZZP',.F.)
								ZZP->ZZP_STATUS := 'CCA'
								ZZP->ZZP_CODCAN := aRetCan[2]
								ZZP->ZZP_DESCAN := aRetCan[3]
								ZZP->ZZP_RESCAN := AllTrim(Upper(UsrFullName(RetCodUsr())))
								ZZP->ZZP_DTCANC := Date()
								MsUnlock()

								lCancelou := .T.

							EndIf//Leonardo Portella - 18/06/13

						EndIf

					EndIf

				Else
					MsgStop('Cancelamento NAO autorizado.' + CRLF + CRLF + ' Favor entrar em contato com o Contas Medicas.',SM0->M0_NOMECOM)
				EndIf

			Case ZZP->ZZP_STATUS == 'PPR'
				If lUsrPodeCan //sergio cunha Chamado - ID 62576
					If ( Date() - ZZP->ZZP_DATDIG ) > Val(nDiasCan)

						If lUsrPodeCan .and. MsgYesNo('Permissao de cancelamento da prévia. ' + AllTrim(Upper(cUserName)) + ', confirma o cancelamento?',SM0->M0_NOMECOM)
							aRetCan := aMotCanc()

							If aRetCan[1]

								//Leonardo Portella - 18/06/13 - Inicio

								If ( Date() - ZZP->ZZP_DATDIG ) > 30
									MsgAlert('ATENÇÃO - Cancelamento de protocolo com mais de 30 dias',SM0->M0_NOMECOM)
									aRetCan[1] := MsgYesNo('Permissao de cancelamento da prévia com mais de 30 dias. ' + AllTrim(Upper(cUserName)) + ', confirma o cancelamento?',SM0->M0_NOMECOM)
								EndIf

								If aRetCan[1]

									//Leonardo Portella - 18/06/13 - Fim

									Reclock('ZZP',.F.)
									ZZP->ZZP_STATUS := 'PCA'
									ZZP->ZZP_CODCAN := aRetCan[2]
									ZZP->ZZP_DESCAN := aRetCan[3]
									ZZP->ZZP_RESCAN := AllTrim(Upper(UsrFullName(RetCodUsr())))
									ZZP->ZZP_DTCANC := Date()
									MsUnlock()

									lCancelou := .T.

								EndIf//Leonardo Portella - 18/06/13

							EndIf

						Else

							cMsg := 'Prazo para cancelamento ultrapassado!' 			   									+ CRLF
							cMsg += '- Data digitacao [ ' + DtoC(ZZP->ZZP_DATDIG) + ' ]'  									+ CRLF
							cMsg += '- Data  [ ' + DtoC(Date()) + ' ]'					  				   					+ CRLF
							cMsg += '- Maximo de dias apos digitacao para cancelamento [ ' + cValToChar(nDiasCan) + ' ]' 	+ CRLF
							cMsg += CRLF + '- Favor entrar em contato com o Contas Medicas.'    							+ CRLF

							MsgStop(cMsg,SM0->M0_NOMECOM)
						EndIf

					ElseIf MsgYesNo('Confirma cancelamento da prévia?',SM0->M0_NOMECOM)

						aRetCan := aMotCanc()

						If aRetCan[1]

							Reclock('ZZP',.F.)

							/*
						ZZP->ZZP_STATUS := 'PCA'
						ZZP->ZZP_RESCAN := AllTrim(Upper(UsrFullName(RetCodUsr())))
						ZZP->ZZP_CODCAN := '-'
						ZZP->ZZP_DESCAN := 'CANCELAMENTO NORMAL SEM AUTORIZACAO'
						ZZP->ZZP_DTCANC := Date()
							*/

							ZZP->ZZP_STATUS := 'PCA'
							ZZP->ZZP_CODCAN := aRetCan[2]
							ZZP->ZZP_DESCAN := aRetCan[3]
							ZZP->ZZP_RESCAN := AllTrim(Upper(UsrFullName(RetCodUsr())))
							ZZP->ZZP_DTCANC := Date()

							MsUnlock()

							lCancelou := .T.

						EndIf

					EndIf
				Else //sergio cunha Chamado - ID 62576
					MsgStop('Cancelamento NAO autorizado.' + CRLF + CRLF + ' Favor entrar em contato com o Contas Medicas.',SM0->M0_NOMECOM)
				EndIf //sergio cunha Chamado - ID 62576
			Case ZZP->ZZP_STATUS == 'CCA'
				MsgStop('Comprovante já está cancelado!',SM0->M0_NOMECOM)

			Case ZZP->ZZP_STATUS == 'PCA'
				MsgStop('Prévia já está cancelada!',SM0->M0_NOMECOM)

		EndCase

		If lCancelou

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Ajusta a sequencia de remessa de sequencias superiores a que esta sendo cancelada.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			cQuery += "SELECT R_E_C_N_O_ RECZZP,ZZP_CODRDA,ZZP_NUMREM,ZZP_REMORI,ZZP_SEQORI" 	+ CRLF
			cQuery += "FROM " + RetSqlName('ZZP') 												+ CRLF
			cQuery += "WHERE D_E_L_E_T_ = ' '"  												+ CRLF
			cQuery += "  AND ZZP_FILIAL = '" + xFilial('ZZP') + "'"								+ CRLF
			cQuery += "  AND ZZP_CODRDA = '" + ZZP->ZZP_CODRDA + "'"							+ CRLF
			cQuery += "  AND ZZP_REMORI = " + cValToChar(ZZP->ZZP_REMORI)						+ CRLF
			cQuery += "  AND ZZP_SEQORI > " + cValToChar(ZZP->ZZP_SEQORI)						+ CRLF

			TcQuery cQuery New Alias cAlias

			While !cAlias->(EOF())

				ZZP->(DbGoTo(cAlias->(RECZZP)))

				ZZP->(Reclock('ZZP',.F.))

				ZZP->ZZP_REMORI := ( ZZP->ZZP_REMORI - 1 )

				ZZP->(MsUnlock())

				cAlias->(DbSkip())

			EndDo

			cAlias->(DbCloseArea())

		EndIf

	END TRANSACTION

	RestArea(aArea)

Return

*******************************************

User Function IncZZP

	Local nOpca 	:= 0
	Local aButtons	:= {}

	aAdd( aButtons, { "CAPTURAR",{|| CAPDOBAR() }, "Capturar Codigo de Barras", "Cod. Barras " } )

	//nOpca := AxInclui("ZZP",/*ZZP->(Recno())*/,3,,,,'U_VALZZP()')
	nOpca := AxInclui("ZZP",,3,,,,'U_VALZZP()',,,aButtons,,,.T.)

	If ( nOpca == 1 )
		GrvZZP()		
	EndIf

Return

*******************************************

User Function AltZZP

	Local nOpca

	Private dDatEnvAUD := ZZP->ZZP_DTEAUD

	nOpca 	:=  AxAltera("ZZP",ZZP->(Recno()),4, , , , ,'U_ValAltZZP()')

	If ( nOpca == 1 )
		GrvZZP()
	EndIf

Return

*******************************************

User Function ValAltZZP()

	Local lOk := .T.
	Local nIDProtRDA

	//Leonardo Portella - 05/08/14
	If ( M->ZZP_NUMLOT == 0 ) .and. ( M->ZZP_STATUS == 'CPR' )
		//If ( M->ZZP_NUMLOT == 0 )

		If ( M->ZZP_DTEAUD == dDatEnvAUD )//So obrigo a informar o lote quando nao for alteracao na data de envio
			MsgStop('Informe o numero do lote!!!',AllTrim(SM0->M0_NOMECOM))
			lOk := .F.
		EndIf

	EndIf

Return lOk

*******************************************

Static Function GrvZZP

	Local aStrZZP 		:= ZZP->(DbStruct('ZZP'))
	Local nI			:= 0
	Local cMacroGrv		:= ""

	BEGIN TRANSACTION

		//AxInclui ja incluiu um registro em branco que esta ponteirado ou AxAltera ja esta ponteirado
		ZZP->(Reclock('ZZP',.F.))

		ZZP->ZZP_FILIAL := xFilial('ZZP')

		For nI := 2 to len(aStrZZp)
			cMacroGrv := "ZZP->" + aStrZZP[nI][1] + ' := ' + aStrZZP[nI][1]
			&cMacroGrv
		Next

		//-----------------------------------------------------
		//Angelo Henrique - Data: 18/12/2020
		//-----------------------------------------------------
		//Após a inclusão, caso seja pela rotina de código de
		//barras, deve ser alterado o status
		//-----------------------------------------------------
		If !Empty(AllTrim(ZZP->ZZP_USRDIG))

			ZZP->ZZP_STATUS = 'CPR'

		EndIf

		ZZP->(MsUnlock())

		////
		//FAZ TESTE DE MEDIA ALTAMIRO
		////


	END TRANSACTION
	fTestMed()

Return
//aki altamiro
*******************************************

Static Function fTestMed()
	/*
	Local aRet			:= {.F.}
	Local aItens 		:= {}
	Local cQuery		:= ""
	Local cAlias		:= GetNextAlias()
	Local lConfirmou 	:= .F.
	Local nList			:= 1

	SetPrvt("oDlg1","oLBox1","oSBtn1","oSBtn2")
	*/

	Local cAlias1		:= GetNextAlias()

	cQuery := " SELECT zzp_tiprem tiprem ,  ZZP_ANOPAG||'/'||ZZP_MESPAG comp , "	+ CRLF
	cQuery += " zzp_codrda rda2 , bau_nome , bau_grppag , b16_descri , zzp_nomana NOMANA , "	+ CRLF

	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1') mediaformhos, " 	+ CRLF
	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2') mediaformamb, "	+ CRLF
	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3') mediaformodn, "	+ CRLF

	cQuery += " sum(zzp_vlinho) vlrhosp , "	+ CRLF
	cQuery += " sum(zzp_vlinam) vlramb  , "	+ CRLF
	cQuery += " sum(zzp_vlinod) vlrod     "	+ CRLF
	cQuery += " FROM " + RetSqlName('ZZP') +" ZZP  , " + RetSqlName('BAU') +" bau , " + RetSqlName('B16') +" b16 "	+ CRLF
	cQuery += " WHERE ZZP_FILIAL = '" + xFilial('ZZP') + "' and zzp.D_E_L_E_T_ = ' ' "	+ CRLF
	cQuery += "   and bau_filial = '" + xFilial('BAU') + "' and bau.D_E_L_E_T_ = ' ' "	+ CRLF
	cQuery += "   and b16_filial = '" + xFilial('B16') + "' and b16.D_E_L_E_T_ = ' ' "	+ CRLF
	cQuery += "   and bau_grppag = b16.B16_CODIGO "
	cQuery += "   and bau_codigo = '"+ZZP->zzp_codrda +"' " + CRLF
	cQuery += "   AND ZZP_ANOPAG||ZZP_MESPAG = '"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"' "+ CRLF
	//            AND ZZP_ANOPAG||ZZP_MESPAG <= '201508'
	cQuery += "   and zzp_status  not in ( 'PCA' , 'CCA' ) " + CRLF
	cQuery += "   and ZZP_CODRDA = '"+ZZP->ZZP_CODRDA +"' "	 + CRLF
	//            and bau_codigo <= ZZP_CODRAD

	cQuery += " group by zzp_tiprem , zzp_codrda, bau_nome , bau_grppag , b16_descri , zzp_nomana  , ZZP_ANOPAG,ZZP_MESPAG , " 	+ CRLF
	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1'), "	+ CRLF
	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2'), "	+ CRLF
	cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3')  "	+ CRLF

	cQuery += " having (TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1') < sum(zzp_vlinho) or "	+ CRLF
	cQuery += "         TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2') < sum(zzp_vlinam) or "	+ CRLF
	cQuery += "         TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3') < sum(zzp_vlinod) )  "	+ CRLF

	cQuery += " order by  zzp_codrda "	+ CRLF

	TcQuery cQuery New Alias (cAlias1)

	While !(cAlias1)->(EOF())

		if  ((cAlias1)->vlrhosp*1.1) < ZZP->zzp_vlinho .AND. ZZP->zzp_vlinho > 0
			Aviso("RESERVAR PARA ANALISE", "Valor do HOSPITALAR fora do desvio - " , {"Ok"})
		endIf
		if  ((cAlias1)->vlramb*1.1)  < ZZP->zzp_vlinam .AND. ZZP->zzp_vlinam > 0
			Aviso("RESERVAR PARA ANALISE", "Valor do AMBULATORIAL fora do desvio - " , {"Ok"})
		EndIf
		if  ((cAlias1)->vlrod*1.1)   < ZZP->zzp_vlinod .AND. ZZP->zzp_vlinod > 0
			Aviso("RESERVAR PARA ANALISE", "Valor do ODONTOLOGICO fora do desvio - " , {"Ok"})
		EndIf

		(cAlias1)->(DbSkip())

	EndDo

	(cAlias1)->(DbCloseArea())
	/*
	oDlg1      := MSDialog():New( 095,232,304,667,"Motivo de cancelamento",,,.F.,,,,,,.T.,,,.T. )

	oLBox1     := TListBox():New( 012,007,{|u|if(Pcount()>0,nList:=u,nList)},aItens,203,060,,oDlg1,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oSBtn1     := SButton():New( 080,156,1,{||lConfirmou := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     := SButton():New( 080,184,2,{||lConfirmou := .F.,oDlg1:End()},oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lConfirmou
		aRet := 	{.T.,;
			AllTrim(Left(aItens[nList],At('-',aItens[nList])-1)),;
			AllTrim(Substr(aItens[nList],At('-',aItens[nList])+2,len(aItens[nList]) - At('-',aItens[nList])+1));
			}
	EndIf
	*/
Return ()

*******************************************
*/
******************************************

User Function MUDZZP

	Local cOldStatus	:= ZZP->ZZP_STATUS
	Local cNewStatus 	:= IIf(cOldStatus == 'PPR','CPR','PPR')
	Local cAliasBau 	:= GetNextAlias()
	Local dDtEnt		:= stod('')
	Local lGrpPag		:= .F.
	Local cEmp          := iif(cempant=='01','C','I')
	// INICIO - Mateus Medeiros
	// Query para buscar o dia d
	BEGINSQL ALIAS cAliasBau

		select to_char(sysdate, 'YYYYMM') ||NVL(siga.RETORNA_DT_ENTREGA_FATURAMENTO(%exp:cEmp%,BAU_CODIGO,'2'),
		siga.RETORNA_DT_ENTREGA_FATURAMENTO(%exp:cEmp%,siga.LIMPA_9_GRPPAG(BAU_GRPPAG),'2'))DATA_ENTREGA,BAU_GRPPAG
		from %table:BAU%
		where bau_codigo =%exp:ZZP->ZZP_CODRDA%;

	ENDSQL

	if (cAliasBau)->(!Eof())
		dDtEnt  :=  datavalida(stod((cAliasBau)->DATA_ENTREGA))
		lGrpPag :=  iif((cAliasBau)->BAU_GRPPAG $ '3005|1001',.T.,.F.) // Grupo de pagamento reciprocidade e interior
	endif

	if select(cAliasBau)    > 0
		dbselectarea(cAliasBau)
		dbclosearea()
	endif
	// funcao datavalida - valida o proximo dia util - em caso de feriados e finais de semana.
	if ddatabase > dDtEnt .and. !lGrpPag .or.(U_COMPZZP( 'ZZP_MESPAG' ) > ZZP->ZZP_MESPAG .OR. U_COMPZZP( 'ZZP_ANOPAG' ) > ZZP->ZZP_ANOPAG )  // Validação para data de entrega depois do calendário de faturamento
		//If (U_COMPZZP( 'ZZP_MESPAG' ) > ZZP->ZZP_MESPAG .OR. U_COMPZZP( 'ZZP_ANOPAG' ) > ZZP->ZZP_ANOPAG )


		If AllTrim(Upper(cUserName)) $ Upper((GetNewPar('MV_XAUTPRO','leonardo.portella|roberto.meirelles|max.santos|sergio.cunha|')))

			A:= 'B'

		Else

			MsgAlert("Usuário sem permissão para recebimento de remessa fora do período de entrega do faturamento !!!!" ,"Atenção!")

			return()

		EndIf

		//EndIf
	Endif



	Do Case
		Case !lGrpPag .and. ddatabase > dDtEnt .and. !(AllTrim(Upper(cUserName)) $ Upper((GetNewPar('MV_XAUTPRO','leonardo.portella|roberto.meirelles|max.santos|'))) )// 05/09/18 - Mateus Medeiros
			MsgStop('Previa não terá fase mudada, pois a data de entrega foi ultrapassada!',AllTrim(SM0->M0_NOMECOM))
		Case cOldStatus == 'PCA'
			MsgStop('Previa cancelada - Nao sera permitido alterar o status!',AllTrim(SM0->M0_NOMECOM))

		Case cOldStatus == 'CCA'
			MsgStop('Comprovante cancelado - Nao sera permitido alterar o status!',AllTrim(SM0->M0_NOMECOM))

		Case cOldStatus == 'PPR'

			ZZP->(Reclock('ZZP',.F.))

			ZZP->ZZP_STATUS := cNewStatus

			ZZP->ZZP_USRRES := AllTrim(Upper(cUserName))
			ZZP->ZZP_DTRECB := date()

			//--------------------------------------------------------------------------
			//Angelo Henrique - Data:28/09/2018
			//--------------------------------------------------------------------------
			//Essa alteração será suspensa temporariamente para análise de
			//mudança de competência de custo
			//--------------------------------------------------------------------------
			/*
		If (U_COMPZZP( 'ZZP_MESPAG' ) > ZZP->ZZP_MESPAG .OR. ;
				U_COMPZZP( 'ZZP_ANOPAG' ) > ZZP->ZZP_ANOPAG )

			ZZP->ZZP_ANOORI := ZZP->ZZP_ANOPAG
			ZZP->ZZP_MESORI := ZZP->ZZP_MESPAG

			ZZP->ZZP_MESPAG := U_COMPZZP( 'ZZP_MESPAG' )
			ZZP->ZZP_ANOPAG := U_COMPZZP( 'ZZP_ANOPAG' )

			fEnvEmail(ZZP->ZZP_CodRda , ZZP->ZZP_NomRda , zzp->ZZP_ANOORI+zzp->ZZP_MESORI , ZZP->ZZP_ANOPAG+ZZP->ZZP_MESPAG , zzp->ZZP_USRRES )

		END
			*/
			ZZP->(MsUnlock())

			MsgInfo('Status alterado de ' + Upper(X3Combo('ZZP_STATUS',cOldStatus)) + ' para ' + Upper(X3Combo('ZZP_STATUS',cNewStatus)),AllTrim(SM0->M0_NOMECOM))

		Otherwise
			MsgStop('Status ' + Upper(X3Combo('ZZP_STATUS',cOldStatus)) + ' - Nao sera permitido alterar o status!',AllTrim(SM0->M0_NOMECOM))

	EndCase



Return

******************************************

User Function LegZZP

	BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"		, X3Combo('ZZP_STATUS','CPR')	},;
		{"BR_AMARELO"	, X3Combo('ZZP_STATUS','PPR')	},;
		{"BR_VERMELHO"	, X3Combo('ZZP_STATUS','CCA')	},;
		{"BR_PRETO"		, X3Combo('ZZP_STATUS','PCA')	}})

Return

*******************************************

User Function CompZZP(cCampo)

	Local cRet 		:= ' '
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()

	cQry := "SELECT MAX(Z9_ANOCTB||Z9_MESCTB) ANO_MES_COMP" 	+ CRLF
	cQry += "FROM " + RetSqlName('SZ9')  						+ CRLF
	cQry += "WHERE D_E_L_E_T_ = ' '" 							+ CRLF
	cQry += "   AND Z9_FILIAL = '" + xFilial('SZ9') + "'" 		+ CRLF
	cQry += "   AND Z9_STACOMP = 'A'" 							+ CRLF

	TcQuery cQry New Alias cAlias

	Do Case

		Case cAlias->(EOF()) .or. empty(cAlias->(ANO_MES_COMP))
			MsgStop('Não foi encontrado calendario contabil (SZ9) com Comprovante em aberto!!!',AllTrim(SM0->M0_NOMECOM))

		Case cCampo == 'ZZP_MESPAG'
			cRet := Substr(cAlias->(ANO_MES_COMP),5,2)

		Case cCampo == 'ZZP_ANOPAG'
			cRet := Substr(cAlias->(ANO_MES_COMP),1,4)

	EndCase

	cAlias->(DbCloseArea())

Return cRet

*******************************************

Static Function aMotCanc

	Local aRet			:= {.F.}
	Local aItens 		:= {}
	Local cQuery		:= ""
	Local cAlias		:= GetNextAlias()
	Local lConfirmou 	:= .F.
	Local nList			:= 1

	SetPrvt("oDlg1","oLBox1","oSBtn1","oSBtn2")

	cQuery := "SELECT X5_CHAVE,X5_DESCRI" 	+ CRLF
	cQuery += "FROM " + RetSqlName('SX5') 	+ CRLF
	cQuery += "WHERE X5_TABELA = '75'" 		+ CRLF
	cQuery += "and X5_CHAVE <> '05'" 		+ CRLF
	cQuery += "ORDER BY X5_CHAVE" 			+ CRLF

	TcQuery cQuery New Alias cAlias

	While !cAlias->(EOF())

		aAdd(aItens,cAlias->(X5_CHAVE) + ' - ' + cAlias->(X5_DESCRI))

		cAlias->(DbSkip())

	EndDo

	cAlias->(DbCloseArea())

	oDlg1      := MSDialog():New( 095,232,304,667,"Motivo de cancelamento",,,.F.,,,,,,.T.,,,.T. )

	oLBox1     := TListBox():New( 012,007,{|u|if(Pcount()>0,nList:=u,nList)},aItens,203,060,,oDlg1,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oSBtn1     := SButton():New( 080,156,1,{||lConfirmou := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     := SButton():New( 080,184,2,{||lConfirmou := .F.,oDlg1:End()},oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lConfirmou
		aRet := 	{.T.,;
			AllTrim(Left(aItens[nList],At('-',aItens[nList])-1)),;
			AllTrim(Substr(aItens[nList],At('-',aItens[nList])+2,len(aItens[nList]) - At('-',aItens[nList])+1));
			}
	EndIf

Return aRet

*******************************************

User Function CTTLocDig

	Local nOpc 		:= GD_INSERT + GD_DELETE + GD_UPDATE
	Local lConf		:= .F.
	Local cRet		:= M->ZZP_YLOCAL

	Private aCoBrw1 := {}
	Private aHoBrw1 := {}
	Private noBrw1  := 0

	Private cCampoCons	:= 'CTT_CUSTO,CTT_DESC01'

	SetPrvt("oDlg1","oBrw1","oSBtn1","oSBtn2")

	oDlg1      := MSDialog():New( 095,232,582,856,"Locais de Digitação de Remessa",,,.F.,,,,,,.T.,,,.T. )

	MHoBrw1()
	MCoBrw1()

	oBrw1      := MsNewGetDados():New(004,004,215,310,0,'AllwaysTrue()','AllwaysTrue()','1',,0,len(aCoBrw1),'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw1,aCoBrw1 )
	oBrw1:oBrowse:bLDBLClick := {||lConf := .T.,oDlg1:End()}

	oSBtn1     := SButton():New( 224,245,1,{||lConf := .T.,oDlg1:End()}	,oDlg1,,"", )
	oSBtn2     := SButton():New( 224,275,2,{||lConf := .F.,oDlg1:End()}	,oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lConf
		cRet := aCoBrw1[oBrw1:nAt][1]
	EndIf

Return cRet

*******************************************

Static Function MHoBrw1()

	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("CTT")

	While !Eof() .and. ( SX3->X3_ARQUIVO == "CTT" )

		If AllTrim(SX3->X3_CAMPO) $ cCampoCons

			noBrw1++

			aAdd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )

		EndIf

		DbSkip()

	End

Return

*******************************************

Static Function MCoBrw1()

	Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local aAux 		:= {}
	Local cAlias 	:= GetNextAlias()
	Local cQuery 	:= ""
	Local nCont		:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query para buscar os dados do centro de custo, todavia estes dados sao utilizados somente como informativo de quem digitou       ³
	//³o protocolo de remessa. Como os centros de custo na Caberj e Integral sao diferentes mas sao usados aqui somente como referencia ³
	//³de digitacao, uso a query abaixo com a tabela chumbada para Caberj.                                                              ³
	//³---------------------------------------------------------------------------------------------------------------------------------³
	//³Filtro SXB - CTTDIG: (CTT->CTT_CUSTO >= "4402".And. CTT->CTT_CUSTO <= "4413" ).Or.(CTT->CTT_CUSTO == "5501")                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cQuery += "SELECT " + cCampoCons 												+ CRLF
	cQuery += "FROM SIGA.CTT010" 													+ CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '" 												+ CRLF
	cQuery += "	AND ( CTT_CUSTO BETWEEN '4402' AND '4413' OR CTT_CUSTO = '5501' )" 	+ CRLF
	cQuery += "ORDER BY CTT_DESC01"											 		+ CRLF

	TcQuery cQuery New Alias cAlias

	While !cAlias->(EOF())

		aAdd(aCoBrw1,Array(noBrw1+1))
		nCont++

		For nI := 1 To noBrw1
			cCampo := aHoBrw1[nI][2]
			aCoBrw1[nCont][nI] := cAlias->(&cCampo)
		Next

		aCoBrw1[nCont][noBrw1+1] := .F.

		cAlias->(DbSkip())

	EndDo

	cAlias->(DbCloseArea())

	If empty(aCoBrw1)

		aAdd(aCoBrw1,Array(noBrw1+1))

		For nI := 1 To noBrw1
			aCoBrw1[1][nI] := CriaVar(aHoBrw1[nI][2])
		Next

		aCoBrw1[1][noBrw1+1] := .F.

	EndIf

Return

*******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Descricao do Centro de Custo da Caberj, independente da empresa logada. ³
//³Usado para a remessa, onde os centros de custo foram usados somente como³
//³informativo do local de digitacao da remessa.                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CTTCaberj(cCusto)

	Local cDesc 	:= " "
	Local aArea		:= GetArea()
	Local cAliasGat	:= GetNextAlias()
	Local cQuery	:= ""

	cQuery += "SELECT CTT_CUSTO,CTT_DESC01" 					+ CRLF
	cQuery += "FROM SIGA.CTT010" 								+ CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '" 							+ CRLF
	cQuery += "  AND CTT_FILIAL = '" + xFilial('CTT') + "'" 	+ CRLF
	cQuery += "  AND CTT_CUSTO = '" + cCusto + "'" 				+ CRLF

	TcQuery cQuery New Alias cAliasGat

	If !cAliasGat->(EOF())
		cDesc := cAliasGat->(CTT_DESC01)
	EndIf

	cAliasGat->(DbCloseArea())

	RestArea(aArea)

Return cDesc

*******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Proxima sequencia de revisao do protocolo informado.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function nSeqRemR(nRemessa,cRDA)

	Local nSeqRem 	:= 1
	Local aArea		:= GetArea()
	Local cAliasSeq	:= GetNextAlias()
	Local cQuery	:= ""

	cQuery += "SELECT COUNT(ZZP_REMORI) + 1 SEQREMREV" 	   			+ CRLF
	cQuery += "FROM " + RetSqlName('ZZP') 				   			+ CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '" 						 		+ CRLF
	cQuery += "  AND ZZP_FILIAL = '" + xFilial('ZZP') + "'" 		+ CRLF
	cQuery += "  AND ZZP_CODRDA = '" + AllTrim(cRDA) + "'" 			+ CRLF
	cQuery += "  AND ZZP_REMORI = '" + cValToChar(nRemessa) + "'" 	+ CRLF
	cQuery += "  AND ZZP_STATUS NOT IN ('CCA','PCA')" 		 		+ CRLF

	TcQuery cQuery New Alias cAliasSeq

	If !cAliasSeq->(EOF())
		nSeqRem := cAliasSeq->(SEQREMREV)
	EndIf

	cAliasSeq->(DbCloseArea())

	RestArea(aArea)

Return nSeqRem

*******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida se existe algum protocolo com o numero informado como origem.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function lSeqRemR(nRemessa,cRDA)

	Local lSeqRem 	:= .F.
	Local aArea		:= GetArea()
	Local cAliasSeq	:= GetNextAlias()
	Local cQuery	:= ""
	Local cMsg		:= "Nao foi encontrado Protocolo com o numero de Remessa [ " + cValToChar(nRemessa) + " ] para o RDA informado [ " + AllTrim(cRDA) + " ]"	+ CRLF

	cQuery += "SELECT DISTINCT ZZP_NUMREM,DECODE(ZZP_STATUS,'CCA','Compr. Cancelado','PCA','Previa Cancelada','-') CANCELADO"	+ CRLF
	cQuery += "FROM " + RetSqlName('ZZP') 				   																		+ CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '" 						 								  									+ CRLF
	cQuery += "  AND ZZP_FILIAL = '" + xFilial('ZZP') + "'" 										  							+ CRLF
	cQuery += "  AND ZZP_CODRDA = '" + AllTrim(cRDA) + "'" 		   																+ CRLF
	cQuery += "  AND ZZP_NUMREM = '" + cValToChar(nRemessa) + "'" 																+ CRLF
	cQuery += "  AND ZZP_STATUS NOT IN ('CCA','PCA')" 		 																	+ CRLF

	TcQuery cQuery New Alias cAliasSeq

	If cAliasSeq->(EOF())

		MsgStop(cMsg,SM0->M0_NOMECOM)

	Else

		While !cAliasSeq->(EOF())

			If AllTrim(cAliasSeq->(CANCELADO)) == '-'
				lSeqRem := .T.
				exit
			Else
				cMsg	+= CRLF + ' - ' + cValToChar(cAliasSeq->(ZZP_NUMREM)) + ' - ' + cAliasSeq->(CANCELADO)
			EndIf

			cAliasSeq->(DbSkip())

		EndDo

		If !lSeqRem
			LogErros(cMsg,SM0->M0_NOMECOM)
		EndIf

	EndIf

	cAliasSeq->(DbCloseArea())

	RestArea(aArea)

Return lSeqRem

***********************************

/*
User Function CADPROREM()
	Local cVldInc := ".T." // Validacao para permitir a exclusao.
	Local cVldExc := ".T." // Validacao para permitir a exclusao.
	Private cString := "ZZP"

	dbSelectArea("ZZP")
	dbSetOrder(1)

	AxCadastro(cString,"Cadastro de Protocolo de capas remessas.",cVldExc,cVldInc,,,{||U_VALZZP()})

Return
*/


*************************************************************************************************

//Leonardo Portella - 16/06/16 - Validação do campo BCI_YPTREM

User Function lProtRem(cRDA, nRemessa)

	Local lOk 		:= .T.
	Local aArea 	:= GetArea()
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()

	If empty(cRDA)

		MsgStop("Informe o código do RDA.",AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

	ElseIf !( M->BCI_CODLDP $ '0013|0017' ) //Leonardo Portella - 07/07/16

		If empty(nRemessa)

			MsgStop("Informe o número do comprovante de remessa.",AllTrim(SM0->M0_NOMECOM))
			lOk := .F.

		Else

			cQry := "SELECT 1"		 								+ CRLF
			cQry += "FROM " + RetsqlName('ZZP') 					+ CRLF
			cQry += "WHERE ZZP_FILIAL = '" + xFilial('ZZP') + "'" 	+ CRLF
			cQry += "  AND ZZP_CODRDA = '" + cRDA + "'" 			+ CRLF
			cQry += "  AND ZZP_NUMREM = " + cValToChar(nRemessa) 	+ CRLF
			cQry += "  AND ZZP_STATUS = 'CPR'" 						+ CRLF
			cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF

			TcQuery cQry New Alias cAlias

			If cAlias->(EOF())

				MsgStop("Não foi localizado comprovante de remessa com o número [ " + cValToChar(nRemessa) + " ] para o prestador [ " + cRDA + " ] [ " + AllTrim(Posicione('BAU',1,xFilial('BAU') + cRDA,'BAU_NOME')) + " ].",AllTrim(SM0->M0_NOMECOM))
				lOk := .F.

			EndIf

			cAlias->(DbCLoseArea())

		EndIf

	EndIf

	RestArea(aArea)

Return lOk

*************************************************************************************************

//Leonardo Portella - 03/10/16 - Cadastro do protocolo individual encaminhado pela Operativa/Medlink

User Function nProtInd(cTipo)

	Local aCores 	:= {}
	Local aArea		:= GetArea()
	Local cExprFil
	Local cNumRemT
	Local cID
	Default cTipo := 'TABELA'

	cNumRemT	:= If(cTipo == 'MEMO',M->ZZP_NUMREM,ZZP->ZZP_NUMREM)
	cID			:= If(cTipo == 'MEMO',M->ZZP_IDOPER,ZZP->ZZP_IDOPER)

	cExprFil	:= "ZRW->ZRW_IDTOTA = " + cValToChar(cID) + " .and. ZRW->ZRW_NUMREM = " + cValToChar(cNumRemT)

	Private nRet		:= 0
	Private cCadastro 	:= "Comprovante eletr�nico de entrega individual"
	Private aRotina 	:= {}

	aAdd(aRotina,{"Visualizar" 		,"AxVisual"		,0,3})
	aAdd(aRotina,{"Cancela lote" 	,"U_CANCLOT"	,0,5})

	aAdd(aCores,{"ZRW->ZRW_STATUS == 'CPR'" ,"BR_VERDE" 	})
	aAdd(aCores,{"ZRW->ZRW_STATUS == 'CCA'" ,"BR_VERMELHO" 	})

	DbSelectArea('ZRW')
	DbSetOrder(1)//ZRW_CODRDA+ZRW_ID+ZRW_ANO+ZRW_MES
	DbGoTop()

	SET FILTER TO &(cExprFil)

	mBrowse(,,,,'ZRW',,,,,1,aCores)

	SET FILTER TO

	If cTipo == 'MEMO'
		nRet := nSeqExiste()
	EndIf

	RestArea(aArea)

Return nRet

******************************************************************************************************************************************

USER FUNCTION CANCLOT
	Local aArea			:= GetArea()
	Local lUsrPodeCan 	:= .F.

	If (RetCodUsr() $ (SuperGetMv('MV_XGETIN') + '|' + SuperGetMv('MV_XGERIN') + '|' + SuperGetMv('MV_XGEARI')))
		lUsrPodeCan := .T.
	ENDIF

	BEGIN TRANSACTION

		Do Case

			Case ZRW->ZRW_STATUS == 'CPR'

				If lUsrPodeCan

					If MsgYesNo('Permissao de cancelamento de lote. ' + AllTrim(Upper(cUserName)) + ', confirma o cancelamento?',SM0->M0_NOMECOM)

						Reclock('ZRW',.F.)
						ZRW->ZRW_STATUS := 'CCA'
						ZRW->ZRW_LOGCAN := AllTrim(Upper(cUserName)) + ' - ' + (dtos(DATE()) + " - " + Time())
						MsUnlock()

					EndIf

				Else
					MsgStop('Cancelamento NAO autorizado.' + CRLF + CRLF + ' Favor entrar em contato com o Contas Medicas.',SM0->M0_NOMECOM)
				EndIf

			Case ZRW->ZRW_STATUS == 'CCA'
				MsgStop('Lote j� est� cancelado!',SM0->M0_NOMECOM)
		EndCase

	END TRANSACTION

	RestArea(aArea)


RETURN
*************************************************************************************************
*************************************************************************************************
*************************************************************************************************

//Função temporária para importar dados de um CSV nas tabelas Operativa. Esta necessidade existe
//pois a Operativa foi incapaz ou irresponsável (ou ambos) e não cumpriu o prometido em prazo
//aceitável.

User Function ImpCargaProt

	// Local nTipo				:= 1
	Local cTipo				:= ""

	//Variáveis de localização do protocolo TOTAL encaminhado pela Operativa (Tabela: OPERATIVA.PROTOCOLO_ENTREGA_TOTAL)

	Local nTEMPRESA			:= 2
	Local nTPROTOCOLO		:= 3
	Local nTSTATUS			:= 4
	Local nTRDA				:= 5
	Local nTNOME			:= 6
	Local nTANO				:= 7
	Local nTMES				:= 8
	Local nTDISPONIBI		:= 9
	Local nTTEL_CONTA		:= 10
	Local nTEMAIL			:= 11
	Local nTQT_A_CON		:= 12
	Local nTVL_A_CON 		:= 13
	Local nTQT_A_SAD 		:= 14
	Local nTVL_A_SAD 		:= 15
	Local nTQT_A_OUD 		:= 16
	Local nTVL_A_OUD 		:= 17
	Local nTQT_A_TOT 		:= 18
	Local nTVL_A_TOT 		:= 19
	Local nTQT_HSP_I 		:= 20
	Local nTVL_HSP_I 		:= 21
	Local nTQT_HSP_S 		:= 22
	Local nTVL_HSP_S 		:= 23
	Local nTQT_HSP_G 		:= 24
	Local nTVL_HSP_G 		:= 25
	Local nTQT_HSP_O 		:= 26
	Local nTVL_HSP_O 		:= 27
	Local nTQT_HSP_T 		:= 28
	Local nTVL_HSP_T 		:= 29
	Local nTQT_ODONT 		:= 30
	Local nTVL_ODONT 		:= 31
	Local nTQT_TOT_G 		:= 32
	Local nTVL_TOT_G 		:= 33

	Local cTEMPRESA			:= ""
	Local cTPROTOCOLO		:= ""
	Local cTSTATUS			:= ""
	Local cTRDA				:= ""
	Local cTNOME			:= ""
	Local cTANO				:= ""
	Local cTMES				:= ""
	Local cTDISPONIBI		:= ""
	Local cTTEL_COTA		:= ""
	Local cTEMAIL			:= ""
	Local cTQT_A_CON		:= ""
	Local cTVL_A_CON 		:= ""
	Local cTQT_A_SAD 		:= ""
	Local cTVL_A_SAD 		:= ""
	Local cTQT_A_OUD 		:= ""
	Local cTVL_A_OUD 		:= ""
	Local cTQT_A_TOT 		:= ""
	Local cTVL_A_TOT 		:= ""
	Local cTQT_HSP_I 		:= ""
	Local cTVL_HSP_I 		:= ""
	Local cTQT_HSP_S 		:= ""
	Local cTVL_HSP_S 		:= ""
	Local cTQT_HSP_G 		:= ""
	Local cTVL_HSP_G 		:= ""
	Local cTQT_HSP_O 		:= ""
	Local cTVL_HSP_O 		:= ""
	Local cTQT_HSP_T 		:= ""
	Local cTVL_HSP_T 		:= ""
	Local cTQT_ODONT 		:= ""
	Local cTVL_ODONT 		:= ""
	Local cTQT_TOT_G 		:= ""
	Local cTVL_TOT_G 		:= ""

	//Variáveis de localização do protocolo INDIVIDUAL encaminhado pela Operativa (Tabela: OPERATIVA.PROTOCOLO_ENTREGA_TOTAL)

	Local nIEMPRESA			:= 2
	Local nIPRO_TOTAL		:= 3
	Local nIPRO_INDIV		:= 4
	Local nISTATUS			:= 5
	Local nIXML				:= 6
	Local nIID_ARQUIV 		:= 7
	Local nIQT_A_CON 		:= 8
	Local nIVL_A_CON 		:= 9
	Local nIQT_A_SAD 		:= 10
	Local nIVL_A_SAD 		:= 11
	Local nIQT_A_OUD 		:= 12
	Local nIVL_A_OUD 		:= 13
	Local nIQT_A_TOT 		:= 14
	Local nIVL_A_TOT 		:= 15
	Local nIQT_HSP_I 		:= 16
	Local nIVL_HSP_I 		:= 17
	Local nIQT_HSP_S 		:= 18
	Local nIVL_HSP_S 		:= 19
	Local nIQT_HSP_G 		:= 20
	Local nIVL_HSP_G 		:= 21
	Local nIQT_HSP_O 		:= 22
	Local nIVL_HSP_O 		:= 23
	Local nIQT_HSP_T 		:= 24
	Local nIVL_HSP_T 		:= 25
	Local nIQT_ODONT 		:= 26
	Local nIVL_ODONT 		:= 27
	Local nIQT_TOT_G 		:= 28
	Local nIVL_TOT_G		:= 29

	Local cIEMPRESA			:= ""
	Local cIPRO_TOTAL		:= ""
	Local cIPRO_INDIV		:= ""
	Local cISTATUS			:= ""
	Local cIXML				:= ""
	Local cIID_ARQUIV 		:= ""
	Local cIQT_A_CON 		:= ""
	Local cIVL_A_CON 		:= ""
	Local cIQT_A_SAD 		:= ""
	Local cIVL_A_SAD 		:= ""
	Local cIQT_A_OUD 		:= ""
	Local cIVL_A_OUD 		:= ""
	Local cIQT_A_TOT 		:= ""
	Local cIVL_A_TOT 		:= ""
	Local cIQT_HSP_I 		:= ""
	Local cIVL_HSP_I 		:= ""
	Local cIQT_HSP_S 		:= ""
	Local cIVL_HSP_S 		:= ""
	Local cIQT_HSP_G 		:= ""
	Local cIVL_HSP_G 		:= ""
	Local cIQT_HSP_O 		:= ""
	Local cIVL_HSP_O 		:= ""
	Local cIQT_HSP_T 		:= ""
	Local cIVL_HSP_T 		:= ""
	Local cIQT_ODONT 		:= ""
	Local cIVL_ODONT 		:= ""
	Local cIQT_TOT_G 		:= ""
	Local cIVL_TOT_G		:= ""

	Local cLine				:= ''
	Local aLine				:= {}
	Local nHdl				:= 0
	Local cFile      		:= '\'
	Local cScript			:= ''
	Local nCont				:= 0
	Local nI
	Local nQtdTot			:= 0
	Local nLinTot			:= 0
	Local nQtdInd			:= 0
	Local nLinInd			:= 0
	Local cFileImp			:= ''
	Local cAlias			:= GetNextAlias()

	cFile 		:= AllTrim(cGetFile('','Selecione o diretório', 0, cFile, .F.,GETF_RETDIRECTORY + GETF_LOCALHARD))
	cFileImp 	:= cFile + 'Importados'

	aFile := Directory(cFile + '*.csv')

	If Len(aFile) == 0
		Alert('Nenhum arquivo .CSV encontrado no diretório [ ' + cFile  + ' ]')
		Return
	EndIf

	MakeDir(cFileImp)

	If !ExistDir(cFileImp)
		Alert('Não foi possível criar a pasta [ ' + cFileImp  + ' ]')
		Return
	EndIf

	aSort(aFile,,,{|x,y| x[1] > y[1]})

	For nI := 1 to len(aFile)

		// Abre o arquivo
		nHandle := FT_FUse(cFile + aFile[nI][1])

		If nHdl == -1
			Alert('Erro na abertura do arquivo [ ' + cFile + aFile[nI][1] + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
			Return
		EndIf

		If At('PROTOCOLO_INDIVIDUAL_', aFile[nI][1]) > 0
			cTipo := 'I'
			nQtdInd++
		ElseIf At('PROTOCOLO_TOTALIZADOR_', aFile[nI][1]) > 0
			cTipo := 'T'
			nQtdTot++
		Else
			Alert('Nome do arquivo não contém "PROTOCOLO_INDIVIDUAL_" ou "PROTOCOLO_TOTALIZADOR_"')
			FT_FUse()
			FClose(nHdl)
			Return
		EndIf

		// Posiciona na primeira linha
		FT_FGoTop()

		nCont := 0

		While !FT_FEOF()

			++nCont

			cLine := FT_FReadLn() // Retorna a linha corrente

			aLine := Separa(cLine,";",.T.)

			If cTipo == 'T' //Total

				If nCont == 1

					nTEMPRESA		:= aScan(aLine,'EMPRESA')
					nTPROTOCOLO		:= aScan(aLine,'PROTOCOLO')
					nTSTATUS		:= aScan(aLine,'STATUS')
					nTRDA			:= aScan(aLine,'RDA')
					nTNOME			:= aScan(aLine,'NOME')
					nTANO			:= aScan(aLine,'ANO')
					nTMES			:= aScan(aLine,'MES')
					nTDISPONIBI		:= aScan(aLine,'DISPONIBILIZADO')
					nTTEL_CONTA		:= aScan(aLine,'TEL_CONTATO')
					nTEMAIL			:= aScan(aLine,'EMAIL')
					nTQT_A_CON		:= aScan(aLine,'QTD_AMBUL_CONSULTA')
					nTVL_A_CON 		:= aScan(aLine,'VLR_AMBUL_CONSULTA')
					nTQT_A_SAD 		:= aScan(aLine,'QTD_AMBUL_SADT')
					nTVL_A_SAD 		:= aScan(aLine,'VLR_AMBUL_SADT')
					nTQT_A_OUD 		:= aScan(aLine,'QTD_AMBUL_OUTRAS_DESPESAS')
					nTVL_A_OUD 		:= aScan(aLine,'VLR_AMBUL_OUTRAS_DESPESAS')
					nTQT_A_TOT 		:= aScan(aLine,'QTD_AMBUL_TOTAL')
					nTVL_A_TOT 		:= aScan(aLine,'VLR_AMBUL_TOTAL')
					nTQT_HSP_I 		:= aScan(aLine,'QTD_HOSP_INTERNACAO')
					nTVL_HSP_I 		:= aScan(aLine,'VLR_HOSP_INTERNACAO')
					nTQT_HSP_S 		:= aScan(aLine,'QTD_HOSP_SADT')
					nTVL_HSP_S 		:= aScan(aLine,'VLR_HOSP_SADT')
					nTQT_HSP_G 		:= aScan(aLine,'QTD_HOSP_GHI')
					nTVL_HSP_G 		:= aScan(aLine,'VLR_HOSP_GHI')
					nTQT_HSP_O 		:= aScan(aLine,'QTD_HOSP_OUTRAS_DESPESAS')
					nTVL_HSP_O 		:= aScan(aLine,'VLR_HOSP_OUTRAS_DESPESAS')
					nTQT_HSP_T 		:= aScan(aLine,'QTD_HOSP_TOTAL')
					nTVL_HSP_T 		:= aScan(aLine,'VLR_HOSP_TOTAL')
					nTQT_ODONT 		:= aScan(aLine,'QTD_ODONTOLOGICO')
					nTVL_ODONT 		:= aScan(aLine,'VLR_ODONTOLOGICO')
					nTQT_TOT_G 		:= aScan(aLine,'QTD_TOTAL_GERAL')
					nTVL_TOT_G 		:= aScan(aLine,'VLR_TOTAL_GERAL')

				Else

					cTEMPRESA		:= AllTrim(aLine[nTEMPRESA]  )
					cTPROTOCOLO		:= AllTrim(aLine[nTPROTOCOL] )
					cTSTATUS		:= AllTrim(aLine[nTSTATUS]   )
					cTRDA			:= AllTrim(aLine[nTRDA]      )
					cTNOME			:= Replace(AllTrim(aLine[nTNOME]     ),"'"," ")
					cTANO			:= AllTrim(aLine[nTANO]      )
					cTMES			:= AllTrim(aLine[nTMES]      )
					cTDISPONIBI		:= DtoC(Date())//AllTrim(aLine[nTDISPONIB] )
					cTTEL_COTA		:= AllTrim(aLine[nTTEL_CONTA])
					cTEMAIL			:= AllTrim(aLine[nTEMAIL]    )
					cTQT_A_CON		:= Replace(AllTrim(aLine[nTQT_A_CON] ),',','.')
					cTVL_A_CON 		:= Replace(AllTrim(aLine[nTVL_A_CON] ),',','.')
					cTQT_A_SAD 		:= Replace(AllTrim(aLine[nTQT_A_SAD] ),',','.')
					cTVL_A_SAD 		:= Replace(AllTrim(aLine[nTVL_A_SAD] ),',','.')
					cTQT_A_OUD 		:= Replace(AllTrim(aLine[nTQT_A_OUD] ),',','.')
					cTVL_A_OUD 		:= Replace(AllTrim(aLine[nTVL_A_OUD] ),',','.')
					cTQT_A_TOT 		:= Replace(AllTrim(aLine[nTQT_A_TOT] ),',','.')
					cTVL_A_TOT 		:= Replace(AllTrim(aLine[nTVL_A_TOT] ),',','.')
					cTQT_HSP_I 		:= Replace(AllTrim(aLine[nTQT_HSP_I] ),',','.')
					cTVL_HSP_I 		:= Replace(AllTrim(aLine[nTVL_HSP_I] ),',','.')
					cTQT_HSP_S 		:= Replace(AllTrim(aLine[nTQT_HSP_S] ),',','.')
					cTVL_HSP_S 		:= Replace(AllTrim(aLine[nTVL_HSP_S] ),',','.')
					cTQT_HSP_G 		:= Replace(AllTrim(aLine[nTQT_HSP_G] ),',','.')
					cTVL_HSP_G 		:= Replace(AllTrim(aLine[nTVL_HSP_G] ),',','.')
					cTQT_HSP_O 		:= Replace(AllTrim(aLine[nTQT_HSP_O] ),',','.')
					cTVL_HSP_O 		:= Replace(AllTrim(aLine[nTVL_HSP_O] ),',','.')
					cTQT_HSP_T 		:= Replace(AllTrim(aLine[nTQT_HSP_T] ),',','.')
					cTVL_HSP_T 		:= Replace(AllTrim(aLine[nTVL_HSP_T] ),',','.')
					cTQT_ODONT 		:= Replace(AllTrim(aLine[nTQT_ODONT] ),',','.')
					cTVL_ODONT 		:= Replace(AllTrim(aLine[nTVL_ODONT] ),',','.')
					cTQT_TOT_G 		:= Replace(AllTrim(aLine[nTQT_TOT_G] ),',','.')
					cTVL_TOT_G 		:= Replace(AllTrim(aLine[nTVL_TOT_G] ),',','.')

					cQry := "SELECT ID" 								+ CRLF
					cQry += "FROM OPERATIVA.PROTOCOLO_ENTREGA_TOTAL" 	+ CRLF
					cQry += "WHERE PROTOCOLO = '" + cTPROTOCOLO + "'" 	+ CRLF
					cQry += "	AND EMPRESA = '" + cTEMPRESA + "'" 		+ CRLF

					TcQuery cQry New Alias cAlias

					lExiste := !cAlias->(EOF())

					If !lExiste

						cScript	:= "INSERT INTO PROTOCOLO_ENTREGA_TOTAL(EMPRESA,PROTOCOLO,STATUS,RDA,NOME,ANO,MES,DISPONIBILIZADO,TEL_CONTATO,EMAIL,QTD_AMBUL_CONSULTA,VLR_AMBUL_CONSULTA,QTD_AMBUL_SADT,VLR_AMBUL_SADT,QTD_AMBUL_OUTRAS_DESPESAS,VLR_AMBUL_OUTRAS_DESPESAS,QTD_AMBUL_TOTAL,VLR_AMBUL_TOTAL,QTD_HOSP_INTERNACAO,VLR_HOSP_INTERNACAO,QTD_HOSP_SADT,VLR_HOSP_SADT,QTD_HOSP_GHI,VLR_HOSP_GHI,QTD_HOSP_OUTRAS_DESPESAS,VLR_HOSP_OUTRAS_DESPESAS,QTD_HOSP_TOTAL,VLR_HOSP_TOTAL,QTD_ODONTOLOGICO,VLR_ODONTOLOGICO,QTD_TOTAL_GERAL,VLR_TOTAL_GERAL) " + CRLF
						cScript	+= "VALUES " + CRLF
						cScript	+= "("
						cScript	+= "'" + cTEMPRESA 						+ "'"
						cScript	+= "," + cTPROTOCOLO
						cScript	+= "," + "'" + cTSTATUS 				+ "'"
						cScript	+= "," + "'" + cTRDA 					+ "'"
						cScript	+= "," + "'" + cTNOME 					+ "'"
						cScript	+= "," + "'" + cTANO 					+ "'"
						cScript	+= "," + "'" + cTMES 					+ "'"
						cScript	+= "," + "TO_DATE('" + DtoS(CtoD(cTDISPONIBI)) 	+ "','YYYYMMDD')"
						cScript	+= "," + "'" + cTTEL_COTA 				+ "'"
						cScript	+= "," + "'" + cTEMAIL 					+ "'"
						cScript	+= "," + cTQT_A_CON
						cScript	+= "," + cTVL_A_CON
						cScript	+= "," + cTQT_A_SAD
						cScript	+= "," + cTVL_A_SAD
						cScript	+= "," + cTQT_A_OUD
						cScript	+= "," + cTVL_A_OUD
						cScript	+= "," + cTQT_A_TOT
						cScript	+= "," + cTVL_A_TOT
						cScript	+= "," + cTQT_HSP_I
						cScript	+= "," + cTVL_HSP_I
						cScript	+= "," + cTQT_HSP_S
						cScript	+= "," + cTVL_HSP_S
						cScript	+= "," + cTQT_HSP_G
						cScript	+= "," + cTVL_HSP_G
						cScript	+= "," + cTQT_HSP_O
						cScript	+= "," + cTVL_HSP_O
						cScript	+= "," + cTQT_HSP_T
						cScript	+= "," + cTVL_HSP_T
						cScript	+= "," + cTQT_ODONT
						cScript	+= "," + cTVL_ODONT
						cScript	+= "," + cTQT_TOT_G
						cScript	+= "," + cTVL_TOT_G
						cScript	+= ")"

					Else

						cScript := "UPDATE PROTOCOLO_ENTREGA_TOTAL SET "                      + CRLF
						cScript += "	STATUS = '" + cTSTATUS + "',"                         + CRLF
						cScript += "	TEL_CONTATO = '" + cTTEL_COTA + "',"                  + CRLF
						cScript += "	EMAIL = '" + cTEMAIL + "',"                           + CRLF
						cScript += "	QTD_AMBUL_CONSULTA = " + cTQT_A_CON + ","             + CRLF
						cScript += "	VLR_AMBUL_CONSULTA = " + cTVL_A_CON + ","             + CRLF
						cScript += "	QTD_AMBUL_SADT = " + cTQT_A_SAD + ","                 + CRLF
						cScript += "	VLR_AMBUL_SADT = " + cTVL_A_SAD + ","                 + CRLF
						cScript += "	QTD_AMBUL_OUTRAS_DESPESAS = " + cTQT_A_OUD + ","      + CRLF
						cScript += "	VLR_AMBUL_OUTRAS_DESPESAS = " + cTVL_A_OUD + ","      + CRLF
						cScript += "	QTD_AMBUL_TOTAL = " + cTQT_A_TOT + ","                + CRLF
						cScript += "	VLR_AMBUL_TOTAL = " + cTVL_A_TOT + ","                + CRLF
						cScript += "	QTD_HOSP_INTERNACAO = " + cTQT_HSP_I + ","            + CRLF
						cScript += "	VLR_HOSP_INTERNACAO = " + cTVL_HSP_I + ","            + CRLF
						cScript += "	QTD_HOSP_SADT = " + cTQT_HSP_S + ","                  + CRLF
						cScript += "	VLR_HOSP_SADT = " + cTVL_HSP_S + ","                  + CRLF
						cScript += "	QTD_HOSP_GHI = " + cTQT_HSP_G + ","                   + CRLF
						cScript += "	VLR_HOSP_GHI = " + cTVL_HSP_G + ","                   + CRLF
						cScript += "	QTD_HOSP_OUTRAS_DESPESAS = " + cTQT_HSP_O + ","       + CRLF
						cScript += "	VLR_HOSP_OUTRAS_DESPESAS = " + cTVL_HSP_O + ","       + CRLF
						cScript += "	QTD_HOSP_TOTAL = " + cTQT_HSP_T + ","                 + CRLF
						cScript += "	VLR_HOSP_TOTAL = " + cTVL_HSP_T + ","                 + CRLF
						cScript += "	QTD_ODONTOLOGICO = " + cTQT_ODONT + ","               + CRLF
						cScript += "	VLR_ODONTOLOGICO = " + cTVL_ODONT + ","               + CRLF
						cScript += "	QTD_TOTAL_GERAL = " + cTQT_TOT_G + ","                + CRLF
						cScript += "	VLR_TOTAL_GERAL = " + cTVL_TOT_G                      + CRLF
						cScript += "WHERE PROTOCOLO = '" + cTPROTOCOLO + "'"                  + CRLF
						cScript += "	AND EMPRESA = '" + cTEMPRESA + "'" 	                  + CRLF
						cScript += "	AND ID = '" + cValToChar(cAlias->ID) + "'"            + CRLF

					EndIf

					cAlias->(DbCloseArea())

					If TcSqlExec(cScript) < 0
						LogErros('Erro na linha [ ' + cValToChar(nCont) + ' do arquivo ' + aFile[nI][1] + ' ] tipo TOTAL. Descr.: ' + TcSqlError())
						FT_FUse()
						FClose(nHdl)
						Return
					EndIf

					nLinTot++

				EndIf

			ElseIf cTipo == 'I'	//Individual

				If nCont == 1

					nIEMPRESA		:= aScan(aLine,'EMPRESA')
					nIPRO_TOTAL		:= aScan(aLine,'PROTOCOLO_TOTAL')
					nIPRO_INDIV		:= aScan(aLine,'PROTOCOLO_INDIVIDUAL')
					nISTATUS		:= aScan(aLine,'STATUS')
					nIXML			:= aScan(aLine,'XML')
					nIID_ARQUIV 	:= aScan(aLine,'ID_ARQUIVO')
					nIQT_A_CON 		:= aScan(aLine,'QTD_AMBUL_CONSULTA')
					nIVL_A_CON 		:= aScan(aLine,'VLR_AMBUL_CONSULTA')
					nIQT_A_SAD 		:= aScan(aLine,'QTD_AMBUL_SADT')
					nIVL_A_SAD 		:= aScan(aLine,'VLR_AMBUL_SADT')
					nIQT_A_OUD 		:= aScan(aLine,'QTD_AMBUL_OUTRAS_DESPESAS')
					nIVL_A_OUD 		:= aScan(aLine,'VLR_AMBUL_OUTRAS_DESPESAS')
					nIQT_A_TOT 		:= aScan(aLine,'QTD_AMBUL_TOTAL')
					nIVL_A_TOT 		:= aScan(aLine,'VLR_AMBUL_TOTAL')
					nIQT_HSP_I 		:= aScan(aLine,'QTD_HOSP_INTERNACAO')
					nIVL_HSP_I 		:= aScan(aLine,'VLR_HOSP_INTERNACAO')
					nIQT_HSP_S 		:= aScan(aLine,'QTD_HOSP_SADT')
					nIVL_HSP_S 		:= aScan(aLine,'VLR_HOSP_SADT')
					nIQT_HSP_G 		:= aScan(aLine,'QTD_HOSP_GHI')
					nIVL_HSP_G 		:= aScan(aLine,'VLR_HOSP_GHI')
					nIQT_HSP_O 		:= aScan(aLine,'QTD_HOSP_OUTRAS_DESPESAS')
					nIVL_HSP_O 		:= aScan(aLine,'VLR_HOSP_OUTRAS_DESPESAS')
					nIQT_HSP_T 		:= aScan(aLine,'QTD_HOSP_TOTAL')
					nIVL_HSP_T 		:= aScan(aLine,'VLR_HOSP_TOTAL')
					nIQT_ODONT 		:= aScan(aLine,'QTD_ODONTOLOGICO')
					nIVL_ODONT 		:= aScan(aLine,'VLR_ODONTOLOGICO')
					nIQT_TOT_G 		:= aScan(aLine,'QTD_TOTAL_GERAL')
					nIVL_TOT_G		:= aScan(aLine,'VLR_TOTAL_GERAL')

				Else

					cIEMPRESA		:= AllTrim(aLine[nIEMPRESA]  )
					cIPRO_TOTAL		:= AllTrim(aLine[nIPRO_TOTAL])
					cIPRO_INDIV		:= AllTrim(aLine[nIPRO_INDIV])
					cISTATUS		:= AllTrim(aLine[nISTATUS]   )
					cIXML			:= AllTrim(aLine[nIXML]      )
					cIID_ARQUIV 	:= AllTrim(aLine[nIID_ARQUIV])
					cIQT_A_CON 		:= Replace(AllTrim(aLine[nIQT_A_CON] ),',','.')
					cIVL_A_CON 		:= Replace(AllTrim(aLine[nIVL_A_CON] ),',','.')
					cIQT_A_SAD 		:= Replace(AllTrim(aLine[nIQT_A_SAD] ),',','.')
					cIVL_A_SAD 		:= Replace(AllTrim(aLine[nIVL_A_SAD] ),',','.')
					cIQT_A_OUD 		:= Replace(AllTrim(aLine[nIQT_A_OUD] ),',','.')
					cIVL_A_OUD 		:= Replace(AllTrim(aLine[nIVL_A_OUD] ),',','.')
					cIQT_A_TOT 		:= Replace(AllTrim(aLine[nIQT_A_TOT] ),',','.')
					cIVL_A_TOT 		:= Replace(AllTrim(aLine[nIVL_A_TOT] ),',','.')
					cIQT_HSP_I 		:= Replace(AllTrim(aLine[nIQT_HSP_I] ),',','.')
					cIVL_HSP_I 		:= Replace(AllTrim(aLine[nIVL_HSP_I] ),',','.')
					cIQT_HSP_S 		:= Replace(AllTrim(aLine[nIQT_HSP_S] ),',','.')
					cIVL_HSP_S 		:= Replace(AllTrim(aLine[nIVL_HSP_S] ),',','.')
					cIQT_HSP_G 		:= Replace(AllTrim(aLine[nIQT_HSP_G] ),',','.')
					cIVL_HSP_G 		:= Replace(AllTrim(aLine[nIVL_HSP_G] ),',','.')
					cIQT_HSP_O 		:= Replace(AllTrim(aLine[nIQT_HSP_O] ),',','.')
					cIVL_HSP_O 		:= Replace(AllTrim(aLine[nIVL_HSP_O] ),',','.')
					cIQT_HSP_T 		:= Replace(AllTrim(aLine[nIQT_HSP_T] ),',','.')
					cIVL_HSP_T 		:= Replace(AllTrim(aLine[nIVL_HSP_T] ),',','.')
					cIQT_ODONT 		:= Replace(AllTrim(aLine[nIQT_ODONT] ),',','.')
					cIVL_ODONT 		:= Replace(AllTrim(aLine[nIVL_ODONT] ),',','.')
					cIQT_TOT_G 		:= Replace(AllTrim(aLine[nIQT_TOT_G] ),',','.')
					cIVL_TOT_G		:= Replace(AllTrim(aLine[nIVL_TOT_G] ),',','.')

					cQry := "SELECT ID_TOTAL ID"									+ CRLF
					cQry += "FROM OPERATIVA.PROTOCOLO_ENTREGA_INDIVIDUAL" 			+ CRLF
					cQry += "WHERE PROTOCOLO_TOTAL = '" + cIPRO_TOTAL + "'" 		+ CRLF
					cQry += "	AND PROTOCOLO_INDIVIDUAL = '" + cIPRO_INDIV + "'" 	+ CRLF
					cQry += "	AND EMPRESA = '" + cIEMPRESA + "'" 					+ CRLF

					TcQuery cQry New Alias cAlias

					lExiste := !cAlias->(EOF())

					If !lExiste

						cScript	:= "INSERT INTO PROTOCOLO_ENTREGA_INDIVIDUAL(EMPRESA,PROTOCOLO_TOTAL,PROTOCOLO_INDIVIDUAL,STATUS,XML,ID_ARQUIVO,QTD_AMBUL_CONSULTA,VLR_AMBUL_CONSULTA,QTD_AMBUL_SADT,VLR_AMBUL_SADT,QTD_AMBUL_OUTRAS_DESPESAS,VLR_AMBUL_OUTRAS_DESPESAS,QTD_AMBUL_TOTAL,VLR_AMBUL_TOTAL,QTD_HOSP_INTERNACAO,VLR_HOSP_INTERNACAO,QTD_HOSP_SADT,VLR_HOSP_SADT,QTD_HOSP_GHI,VLR_HOSP_GHI,QTD_HOSP_OUTRAS_DESPESAS,VLR_HOSP_OUTRAS_DESPESAS,QTD_HOSP_TOTAL,VLR_HOSP_TOTAL,QTD_ODONTOLOGICO,VLR_ODONTOLOGICO,QTD_TOTAL_GERAL,VLR_TOTAL_GERAL)
						cScript	+= "VALUES " + CRLF
						cScript	+= "("
						cScript	+= "'" + cIEMPRESA 				+ "'"
						cScript	+= "," + cIPRO_TOTAL
						cScript	+= "," + "'" + cIPRO_INDIV		+ "'"
						cScript	+= "," + "'" + cISTATUS			+ "'"
						cScript	+= "," + "'" + cIXML 			+ "'"
						cScript	+= "," + "'" + cIID_ARQUIV 		+ "'"
						cScript	+= "," + cIQT_A_CON
						cScript	+= "," + cIVL_A_CON
						cScript	+= "," + cIQT_A_SAD
						cScript	+= "," + cIVL_A_SAD
						cScript	+= "," + cIQT_A_OUD
						cScript	+= "," + cIVL_A_OUD
						cScript	+= "," + cIQT_A_TOT
						cScript	+= "," + cIVL_A_TOT
						cScript	+= "," + cIQT_HSP_I
						cScript	+= "," + cIVL_HSP_I
						cScript	+= "," + cIQT_HSP_S
						cScript	+= "," + cIVL_HSP_S
						cScript	+= "," + cIQT_HSP_G
						cScript	+= "," + cIVL_HSP_G
						cScript	+= "," + cIQT_HSP_O
						cScript	+= "," + cIVL_HSP_O
						cScript	+= "," + cIQT_HSP_T
						cScript	+= "," + cIVL_HSP_T
						cScript	+= "," + cIQT_ODONT
						cScript	+= "," + cIVL_ODONT
						cScript	+= "," + cIQT_TOT_G
						cScript	+= "," + cIVL_TOT_G
						cScript	+= ")"

					Else

						cScript := "UPDATE PROTOCOLO_ENTREGA_INDIVIDUAL SET "                 + CRLF
						cScript += "	STATUS = '" + cISTATUS + "',"                         + CRLF
						cScript += "	XML = '" + cIXML + "',"               	              + CRLF
						cScript += "	ID_ARQUIVO = '" + cIID_ARQUIV + "',"                  + CRLF
						cScript += "	QTD_AMBUL_CONSULTA = " + cIQT_A_CON + ","             + CRLF
						cScript += "	VLR_AMBUL_CONSULTA = " + cIVL_A_CON + ","             + CRLF
						cScript += "	QTD_AMBUL_SADT = " + cIQT_A_SAD + ","                 + CRLF
						cScript += "	VLR_AMBUL_SADT = " + cIVL_A_SAD + ","                 + CRLF
						cScript += "	QTD_AMBUL_OUTRAS_DESPESAS = " + cIQT_A_OUD + ","      + CRLF
						cScript += "	VLR_AMBUL_OUTRAS_DESPESAS = " + cIVL_A_OUD + ","      + CRLF
						cScript += "	QTD_AMBUL_TOTAL = " + cIQT_A_TOT + ","                + CRLF
						cScript += "	VLR_AMBUL_TOTAL = " + cIVL_A_TOT + ","                + CRLF
						cScript += "	QTD_HOSP_INTERNACAO = " + cIQT_HSP_I + ","            + CRLF
						cScript += "	VLR_HOSP_INTERNACAO = " + cIVL_HSP_I + ","            + CRLF
						cScript += "	QTD_HOSP_SADT = " + cIQT_HSP_S + ","                  + CRLF
						cScript += "	VLR_HOSP_SADT = " + cIVL_HSP_S + ","                  + CRLF
						cScript += "	QTD_HOSP_GHI = " + cIQT_HSP_G + ","                   + CRLF
						cScript += "	VLR_HOSP_GHI = " + cIVL_HSP_G + ","                   + CRLF
						cScript += "	QTD_HOSP_OUTRAS_DESPESAS = " + cIQT_HSP_O + ","       + CRLF
						cScript += "	VLR_HOSP_OUTRAS_DESPESAS = " + cIVL_HSP_O + ","       + CRLF
						cScript += "	QTD_HOSP_TOTAL = " + cIQT_HSP_T + ","                 + CRLF
						cScript += "	VLR_HOSP_TOTAL = " + cIVL_HSP_T + ","                 + CRLF
						cScript += "	QTD_ODONTOLOGICO = " + cIQT_ODONT + ","               + CRLF
						cScript += "	VLR_ODONTOLOGICO = " + cIVL_ODONT + ","               + CRLF
						cScript += "	QTD_TOTAL_GERAL = " + cIQT_TOT_G + ","                + CRLF
						cScript += "	VLR_TOTAL_GERAL = " + cIVL_TOT_G                      + CRLF
						cScript += "WHERE PROTOCOLO_TOTAL = '" + cIPRO_TOTAL + "'" 			  + CRLF
						cScript += "	AND PROTOCOLO_INDIVIDUAL = '" + cIPRO_INDIV + "'" 	  + CRLF
						cScript += "	AND EMPRESA = '" + cIEMPRESA + "'" 					  + CRLF
						cScript += "	AND ID_TOTAL = '" + cValToChar(cAlias->ID) + "'"      + CRLF

					EndIf

					cAlias->(DbCloseArea())

					If TcSqlExec(cScript) < 0
						LogErros('Erro na linha [ ' + cValToChar(nCont) + ' do arquivo ' + aFile[nI][1] + ' ] tipo INDIVIDUAL. Descr.: ' + TcSqlError())
						FT_FUse()
						FClose(nHdl)
						Return
					EndIf

					nLinInd++

				EndIf

			EndIf

			Ft_FSkip()

		EndDo

		FT_FUse()
		FClose(nHdl)

		MoveFile(cFile + aFile[nI][1],cFileImp + '/' + aFile[nI][1],.T.)

	Next

	cMsg := 'Processo finalizado!!!'												+ CRLF + CRLF
	cMsg += cValToChar(nQtdTot) + " arquivos TOTAIS processados" 					+ CRLF
	cMsg += cValToChar(nLinTot) + " linhas de arquivos TOTAIS processadas" 			+ CRLF
	cMsg += cValToChar(nQtdInd) + " arquivos INDIVIDUAIS processados" 				+ CRLF
	cMsg += cValToChar(nLinInd) + " linhas de arquivos INDIVIDUAIS processadas" 	+ CRLF

	MsgInfo(cMsg)

Return

****************************************************************************************************************************************

User Function StatusRDA

	Local aArea			:= GetArea()
	Local aArBAU		:= BAU->(GetArea())
	Local lOk			:= .F.
	Local bOk			:= {||lOk := .T., oDlg1:End()}
	Local bCancel		:= {||lOk := .F., oDlg1:End()}
	Local bConsulta		:= {||aArTmp := GetArea(),If(PLSPESCRE(), cRDA := BAU->BAU_CODIGO, cRDA := ''), ConsRDA(), RestArea(aArTmp)}
	Local aBut			:= {{"BUDGETY", bConsulta,"Nova consulta"}, {"BUDGETY", {||IncExcep()} , "Liberação excepcional" }  }

	Private aArTmp		:= {}
	Private cRDA		:= ''
	Private cNome		:= ''
	Private cNFanta		:= ''
	Private oDlg1

	SetPrvt("oGrp1","oSay1","oSay2","oSay3","oSay4","oGet1","oGet2","oGet3","oGrp2","oMGet1","oBtn1","oBtn2")

	oDlg1      := MSDialog():New( 092,232,393,840,"Consulta Status RDA",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 004,004,116,296,"RDA",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 016,012,{||"RDA"				},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      := TSay():New( 016,076,{||"Nome"				},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay3      := TSay():New( 037,012,{||"Nome Fantasia"	},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)

	oGet1      := TGet():New( 016,032,{|u| If(PCount()>0,cRDA:=u,cRDA)}			,oGrp1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,""	,"cRDA"		,,)
	oGet2      := TGet():New( 016,096,{|u| If(PCount()>0,cNome:=u,cNome)}		,oGrp1,192,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,""	,"cNome"	,,)
	oGet3      := TGet():New( 037,052,{|u| If(PCount()>0,cNFanta:=u,cNFanta)}	,oGrp1,236,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,""	,"cNFanta"	,,)

	oGrp2      := TGroup():New( 052,008,112,592,"Status",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oTBitmap1 	:= TBitmap():New(062,012,10,10,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.)
	oTBitmap1:Load("BR_BRANCO")

	oSay4      := TSay():New( 062,025,{||"- Consultar status do RDA"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,200,008)

	Eval(bConsulta)

	oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut))

	BAU->(RestArea(aArBAU))
	RestArea(aArea)

Return

****************************************************************************************************************************************

Static Function ConsRDA

	Local aArea 	:= GetArea()
	Local cRet		:= ''
	Local lOk		:= .T.
	Local lAchou	:= .F.
	Local nOpca		:= 0

	If empty(cRDA)
		MsgStop('Informe o RDA', AllTrim(SM0->M0_NOMECOM))
		lOk := .F.
	Else

		BAU->(DbSetOrder(1))

		If !BAU->(DbSeek(xFilial('BAU') + cRDA))
			MsgStop('RDA não localizado. Verifique e consulte novamente.', AllTrim(SM0->M0_NOMECOM))
			lOk 	:= .F.
			nOpca 	:= 1 //Desabilitado
		Else

			lAchou	:= .T.

			If BAU->BAU_XMEDLI == 'S'
				cRet 	:= 'Prestador habilitado para envio na Operativa/Medlink'
				lOk 	:= .T.
				nOpca 	:= 2 //Implantado
			ElseIf BAU->BAU_XMEDLI == 'I'
				cRet 	:= 'Prestador em implantação para envio na Operativa/Medlink'
				lOk 	:= .T.
				nOpca 	:= 3 //Em implantação
			Else
				cRet 	:= 'Prestador NÃO está habilitado para envio na Operativa/Medlink'
				lOk 	:= .F.
				nOpca 	:= 1 //Desabilitado
			EndIf

		EndIf

	EndIf

	RestArea(aArea)

	oSay4:SetText(cRet)

	If !lAchou

		oTBitmap1:Load("BR_AMARELO")
		cRDA		:= ''
		cNome		:= ''
		cNFanta		:= ''

	Else

		cNome		:= BAU->BAU_NOME
		cNFanta		:= BAU->BAU_NFANTA

		If lOk

			If nOpca == 1 		//Desabilitado
				oTBitmap1:Load("BR_VERMELHO")
			ElseIf nOpca == 2 	//Implantado
				oTBitmap1:Load("BR_VERDE")
			ElseIf nOpca == 3 	//Em implantação
				oTBitmap1:Load("BR_AMARELO")
			EndIf

		Else
			oTBitmap1:Load("BR_VERMELHO")
		EndIf

	EndIf

	oDlg1:Refresh()

Return cRet

*****************************************************************************************************

//Leonardo Portella - 07/10/16 - Validação dos campos de envio e retorno Audimed

User Function lEnvAudOk

	Local lOk 		:= .T.
	Local cUserLog	:= Upper(UsrRetName(RetCodUsr()))
	Local cUserAut	:= GetNewPar('MV_XENTAUD','MAX.SANTOS|DOUGLAS.FUTURO|MILENA.SILVA|VINICIUS.ALVES|FERNANDA.MIRANDA|DARIE.FAVORI|JOSE.GOMES')
	Local lForcar	:= ( cUserLog $ cUserAut ) .or. ( RetCodUsr() $ ( GetMV('MV_XGETIN') + GetMV('MV_XGERIN') ) )
	Local cMsg		:= "Autorização especial [ usuário: " + cUserLog + " - " + UsrFullName(RetCodUsr()) + " ]"
	Local cMsgCri	:= ''
	Local cCpoAtual	:= ReadVar()

	If ( cCpoAtual == 'M->ZZP_DTRAUD' ) .and. empty(M->ZZP_DTEAUD) .and. !empty(M->ZZP_DTRAUD)

		MsgStop('Não é possível informar a data de retorno se a data de recebimento está vazia!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

	EndIf

	If !empty(M->ZZP_DTEAUD) .and. !empty(M->ZZP_DTRAUD) .and. ( M->ZZP_DTEAUD > M->ZZP_DTRAUD )

		MsgStop('Data de recebimento [ ' + DtoC(M->ZZP_DTEAUD) + ' ] não pode ser maior que a data de retorno [ ' + DtoC(M->ZZP_DTRAUD) + ' ]!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

	EndIf

	If ALTERA .and. !empty(ZZP->ZZP_DTEAUD) .and. ( M->ZZP_DTEAUD <> ZZP->ZZP_DTEAUD )

		cMsgCri := 'Não é permitido alterar a data de recebimento! [ Conteúdo antigo: ' + DtoC(ZZP->ZZP_DTEAUD) + ' - Conteúdo novo: ' + DtoC(M->ZZP_DTEAUD) + ' ]'

		If lForcar
			lOk := MsgYesNo(cMsg + CRLF + CRLF + cMsgCri + CRLF + CRLF + "Deseja alterar mesmo assim?", AllTrim(SM0->M0_NOMECOM))
		Else
			MsgStop(cMsgCri,AllTrim(SM0->M0_NOMECOM))
			lOk := .F.
		EndIf

	EndIf

	If ALTERA .and. !empty(ZZP->ZZP_DTRAUD) .and. ( M->ZZP_DTRAUD <> ZZP->ZZP_DTRAUD )

		cMsgCri := 'Não é permitido alterar a data de retorno! [ Conteúdo antigo: ' + DtoC(ZZP->ZZP_DTRAUD) + ' - Conteúdo novo: ' + DtoC(M->ZZP_DTRAUD) + ' ]'

		If lForcar
			lOk := MsgYesNo(cMsg + CRLF + CRLF + cMsgCri + CRLF + CRLF + "Deseja alterar mesmo assim?", AllTrim(SM0->M0_NOMECOM))
		Else
			MsgStop(cMsgCri,AllTrim(SM0->M0_NOMECOM))
			lOk := .F.
		EndIf

	EndIf

Return lOk

***************************************************************************************************************************************************************

User Function aAutUsr(cUsers)

	Local aArea		:= GetArea()
	Local lAut		:= .F.
	Local cLogin 	:= UsrRetName(RetCodUsr())
	Local aDadUsr 	:= {}
	Local dValid
	Local lContinua	:= .F.
	Local _oDlgUsr
	Local oGrp1
	Local oSay1
	Local oSay2
	Local oGet1
	Local oGet2
	Local oSBtn1
	Local oSBtn2

	Private cLogBus	:= Space(30)
	Private cPswDig	:= Space(30)

	_oDlgUsr   := MSDialog():New( 092,232,240,465,"Autorização",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 004,004,044,112,"Usuário",_oDlgUsr,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 018,008,{||"Login"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      := TSay():New( 030,008,{||"Senha"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

	oGet1      := TGet():New( 018,028,{|u| If(PCount()>0,cLogBus:=u,cLogBus)	},oGrp1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLogBus",,)
	oGet2      := TGet():New( 030,028,{|u| If(PCount()>0,cPswDig:=u,cPswDig)	},oGrp1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.T.,"","cPswDig",,)

	oSBtn1     := SButton():New( 052,056,1,{||_oDlgUsr:End(), lContinua := .T.	},_oDlgUsr,,"", )
	oSBtn2     := SButton():New( 052,086,2,{||_oDlgUsr:End()					},_oDlgUsr,,"", )

	_oDlgUsr:Activate(,,,.T.)

	If lContinua

		cLogBus := AllTrim(cLogBus)
		cPswDig	:= AllTrim(cPswDig)

		If ( RetCodUsr() $ ( GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN') ) )
			lContinua := .T.
		ElseIf empty(cUsers)
			MsgStop('Não existem usuários habilitados para esta rotina!', AllTrim(SM0->M0_NOMECOM))
			lContinua := .F.
		ElseIf !( Upper(cLogBus) $ Upper(cUsers) )
			MsgStop('Usuário [ ' + cLogBus + ' ] não possui autorização para esta rotina!', AllTrim(SM0->M0_NOMECOM))
			lContinua := .F.
		EndIf

		If lContinua

			//1 - ID do usuário/grupo
			//2 - Nome do usuário/grupo
			//3 - Senha do usuário
			//4 - E-mail do usuário
			PswOrder(2)

			If !PswSeek(cLogBus)
				MsgStop('Usuário [ ' + cLogBus + ' ] não foi localizado no sistema!', AllTrim(SM0->M0_NOMECOM))
			Else

				aDadUsr := PswRet(1)
				dValid 	:= aDadUsr[1][6] //Data de validade

				If dValid < Date()
					MsgStop('Data de validade do usuário [ ' + cLogBus + ' ] encontra-se expirada [ ' + DtoC(dValid) + ' ]!', AllTrim(SM0->M0_NOMECOM))
				ElseIf !PswName(cPswDig)
					MsgStop('Senha inválida!', AllTrim(SM0->M0_NOMECOM))
				Else
					lAut := .T.
				EndIf

			EndIf

			PswOrder(2)
			PswSeek(cLogin) //Volta para o usuário original

		EndIf

	EndIf

	RestArea(aArea)

Return {lAut, cLogBus}

**************************************************************************************************************************************

Static Function IncExcep

	Local aAr 	:= GetArea()
	Local cAno	:= ''
	Local cMes	:= ''
	Local lOk	:= .F.

	Private cRem := Space(20)

	SetPrvt("oDlgIncExc","oGrp1","oSay1","oSay4","oSay5","oGet1","oSBtn1","oSBtn2")

	aAut := u_aAutUsr(GetNewPar('MV_XAUTPRO','leonardo.portella|roberto.meirelles|max.santos|'))

	If aAut[1]

		cMes := U_COMPZZP('ZZP_MESPAG')
		cAno := U_COMPZZP('ZZP_ANOPAG')

		oDlgIncExc := MSDialog():New( 092,232,278,809,"Liberação de inclusão excepcional",,,.F.,,,,,,.T.,,,.T. )

		oGrp1      := TGroup():New( 004,004,060,280,"Deseja realmente liberar a inclusão conforme a seguir?",oDlgIncExc,CLR_BLACK,CLR_WHITE,.T.,.F. )

		oSay1      := TSay():New( 016,012,{||"RDA: " + cRDA}						,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,264,008)
		oSay2      := TSay():New( 028,012,{||"Competência: " + cMes + '/' + cAno}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,264,008)
		oSay3      := TSay():New( 040,012,{||"Nº comprovante/protocolo"}			,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,084,008)

		oGet1      := TGet():New( 040,080,{|u| If(PCount()>0,cRem:=u,cRem)},oGrp1,100,008,'@9',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRem",,)

		oSBtn1     := SButton():New( 068,220,1,{||oDlgIncExc:End(), lOk := .T.},oDlgIncExc,,"", )
		oSBtn2     := SButton():New( 068,254,2,{||oDlgIncExc:End(), lOk := .F.},oDlgIncExc,,"", )

		oDlgIncExc:Activate(,,,.T.)

		If lOk

			If empty(cRem)
				MsgStop('Número do Protocolo em branco!',AllTrim(SM0->M0_NOMECOM))
			Else

				DbSelectArea('PB0')
				DbSetOrder(1) //PB0_FILIAL, PB0_CODRDA, PB0_ANO, PB0_MES, PB0_REMESS

				If !DbSeek(xFilial('PB0') + cRDA + cAno + cMes + AllTrim(cRem))

					Reclock('PB0',.T.)

					PB0_CODRDA	:= cRDA
					PB0_ANO   	:= cAno
					PB0_MES   	:= cMes
					PB0_REMESS	:= Val(cRem)
					PB0_DTLIB 	:= Date()
					PB0_NOMLIB	:= aAut[2]

					MsUnlock()

					MsgInfo('Liberação excepcional realizada com sucesso!',AllTrim(SM0->M0_NOMECOM))

				Else
					MsgStop('Já existe liberação para este Número do Protocolo [ RDA, Ano, Mês e Protocolo ]!',AllTrim(SM0->M0_NOMECOM))
				EndIf

			EndIf

		Else

			MsgInfo('Liberação excepcional realizada com sucesso!',AllTrim(SM0->M0_NOMECOM))

		EndIf

	EndIf

	RestArea(aAr)

Return


Static Function fEnvEmail(cCodRda , cNomRda , cComInc , cComAtu , cusuario )

	// Local lEmail     := .F.
	// Local c_CampAlt  := '  '
	// Local lExecuta   := .T.
	local cDest      := " "
	Local aArea      := GetArea() //Armazena a Area atual
	Local _cMensagem := " "

	_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)

	//_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Alteração da Competencia de Entrega "
	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"

	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Realizada alteração da competencia de entrega da remessa "+cValToChar(ZZP->ZZP_NUMREM) +" do RDA "+ cCodRda +" - " + cNomRda +" "
	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "de "+ cComInc+" Para "+ cComAtu + " "

	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Pelo Usuario  "+ cusuario + " Em  : " + DtoC( Date() )



	cDest:= "altamiro@caberj.com.br ; sergio.cunha@caberj.com.br"
	//cDest:= GetNewPar('MV_XAUTPRO','leonardo.portella|roberto.meirelles|max.santos|')
	EnvEmail1( _cMensagem , cDest)

	RestArea(aArea)

Return (.T.)
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
	*--------------------------------------*

	/*Local _cMailServer := GetMv( "MV_WFSMTP" )
	Local _cMailConta  := GetMv( "MV_WFAUTUS" )
	Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
	Local _cMailServer := GetMv( "MV_RELSERV" )
	Local _cMailConta  := GetMv( "MV_EMCONTA" )
	Local _cMailSenha  := GetMv( "MV_EMSENHA" )

	//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
	Local _cTo  	     := cDest //"altamiro@caberj.com.br "
	// Local _cCC         := " "  //GetMv( "MV_WFFINA" )
	Local _cAssunto    := oemtoansi("Alteração de competência de remessa "+cValToChar(ZZP->ZZP_NUMREM) +" entregue fora do prazo")
	Local _cError      := ""
	Local _lOk         := .T.
	Local _lSendOk     := .F.
	// local cto_         := ' '

	//_cTo+= cDest

	If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  )
		// Conecta uma vez com o servidor de e-mails
		CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk

		If _lOk
			SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
		Else
			//Erro na conexao com o SMTP Server
			GET MAIL ERROR _cError
			Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )
		EndIf

		If _lOk
			//Desconecta do Servidor
			DISCONNECT SMTP SERVER
		EndIf
	EndIf
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} function CAPDOBAR
Rortina utilizada para capturar o codigo de barras que irá vir na
entrega da remessa
@author  Angelo
@since   08/12/2020
@version version
/*/
//-------------------------------------------------------------------
Static Function CAPDOBAR

	Private _cCodBar1	 := SPACE(200)
	Private _cCodBar2	 := SPACE(200)
	Private _cCodBar3	 := SPACE(200)
	Private _cCodBar4	 := SPACE(200)

	Private _cCodRem	 := SPACE(TAMSX3("ZZP_NUMREM" )[1])

	Private _cCodRDA	 := SPACE(TAMSX3("ZZP_CODRDA" )[1])
	Private _cNomRda	 := SPACE(TAMSX3("ZZP_NOMRDA" )[1])

	//--------------------------------------------------------------
	//SERVÇOS AMBULATORIAIS
	//--------------------------------------------------------------
	Private _nQtdCon	 := SPACE(TAMSX3("ZZP_QTDCON" )[1])
	Private _nQtdSad 	 := SPACE(TAMSX3("ZZP_QTDSAD" )[1])
	Private _nQtdAmb	 := SPACE(TAMSX3("ZZP_QTDAMB" )[1])
	Private _nQtdTot	 := SPACE(TAMSX3("ZZP_QTDTOT" )[1]) //TOTAL QTD AMBULATORIAL
	Private _nVlrCon	 := SPACE(TAMSX3("ZZP_VLRCON" )[1])
	Private _nVlrSad	 := SPACE(TAMSX3("ZZP_VLRSAD" )[1])
	Private _nVlrAmb	 := SPACE(TAMSX3("ZZP_VLRAMB" )[1])
	Private _nVlrTot	 := SPACE(TAMSX3("ZZP_VLRTOT" )[1]) //TOTAL VLR AMBULATORIAL

	//--------------------------------------------------------------
	//SERVÇOS HOSPITALARES
	//--------------------------------------------------------------
	Private _nQtdInt	 := SPACE(TAMSX3("ZZP_QTDINT" )[1])
	Private _nSadInt	 := SPACE(TAMSX3("ZZP_SADINT" )[1])
	Private _nQtdHon	 := SPACE(TAMSX3("ZZP_QTDHON" )[1])
	Private _nQtdOds	 := SPACE(TAMSX3("ZZP_QTDODS" )[1])
	Private _nQtotIn	 := SPACE(TAMSX3("ZZP_QTOTIN" )[1]) //TOTAL QTD HOSPITALAR
	Private _nVlrInt	 := SPACE(TAMSX3("ZZP_VLRINT" )[1])
	Private _nVlsDti	 := SPACE(TAMSX3("ZZP_VLSDTI" )[1])
	Private _nVlrHon	 := SPACE(TAMSX3("ZZP_VLRHON" )[1])
	Private _nVlrOds	 := SPACE(TAMSX3("ZZP_VLRODS" )[1])
	Private _nVlToti	 := SPACE(TAMSX3("ZZP_VLTOTI" )[1]) //TOTAL VLR HOSPITALAR

	Private _lConf		 := .F.

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oCabec","oDlg1","oPanel1","oGrp1","oSay1","oSay2","oGrp2","oSay3","oGet1","oGrp3","oSay4","oSay5")
	SetPrvt("oGet3","oGrp4","oSay6","oSay7","oSay8","oSay9","oSay10","oSay11","oGet4","oGet5","oGet6","oGet7")
	SetPrvt("oGet9","oGet10","oGet11","oGrp5","oSay12","oGet12","oGrp6","oSay13","oSay14","oSay15","oSay16")
	SetPrvt("oSay18","oSay19","oGet13","oGet14","oGet15","oGet16","oGet17","oGet18","oGet19","oGet20","oGet21")
	SetPrvt("oBtn1","oBtn2","oGrp7","oSay20","oGet23","oGrp8","oSay21","oGet24")

	//--------------------------------------------------------------------------------
	//Inicio - Carregamento inicial dos campos na tela
	//--------------------------------------------------------------------------------
	_nQtdCon	 := 0
	_nQtdSad 	 := 0
	_nQtdAmb	 := 0
	_nQtdTot	 := 0
	_nVlrCon	 := 0
	_nVlrSad	 := 0
	_nVlrAmb	 := 0
	_nVlrTot	 := 0

	//--------------------------------------------------------------
	//SERVÇOS HOSPITALARES
	//--------------------------------------------------------------
	_nQtdInt	 := 0
	_nSadInt	 := 0
	_nQtdHon	 := 0
	_nQtdOds	 := 0
	_nQtotIn	 := 0
	_nVlrInt	 := 0
	_nVlsDti	 := 0
	_nVlrHon	 := 0
	_nVlrOds	 := 0
	_nVlToti	 := 0
	//--------------------------------------------------------------------------------
	//Fim - Carregamento inicial dos campos na tela
	//--------------------------------------------------------------------------------

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oCabec     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 091,232,755,1043,"     Entrega de Remessa     ",,,.F.,,,,,,.T.,,,.T. )

	oPanel1    := TPanel():New( 000,000,"",oDlg1,,.F.,.F.,,,400,324,.T.,.F. )

	oGrp1      := TGroup():New( 000,004,320,396,"",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 008,036,{||"Rotina utilizada para realizar  a captura do codigo de barras no processo de digitacao do"},oGrp1,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,320,012)
	oSay2      := TSay():New( 020,140,{||"comprovante de entrega de remessa"},oGrp1,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,136,012)

	oGrp2      := TGroup():New( 032,012,064,196,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay3      := TSay():New( 036,020,{||"Favor capturar o Primeiro Codigo de Barras"},oGrp2,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,156,012)
	//-------------------------------------
	//Primeiro Codigo de Barras
	//-------------------------------------
	oGet1      := TGet():New( 050,016,{|u| If(PCount()==0,_cCodBar1,_cCodBar1:=u)},oGrp2,176,008,'',{|| AtuBar("1",_cCodBar1)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cCodBar1",,)	

	oGrp7      := TGroup():New( 032,204,064,388,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay20     := TSay():New( 036,212,{||"Favor capturar o Segundo C�digo de Barras"},oGrp7,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,160,012)	
	//-------------------------------------
	//Segundo Codigo de Barras
	//-------------------------------------
	oGet23     := TGet():New( 048,210,{|u| If(PCount()==0,_cCodBar2,_cCodBar2:=u)},oGrp7,176,008,'',{|| AtuBar("2",_cCodBar2)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cCodBar2",,)		

	oGrp3      := TGroup():New( 068,012,100,388,"     Prestador de Servicos     ",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay4      := TSay():New( 084,016,{||"Codigo"						},oGrp3,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,012)
	oSay5      := TSay():New( 084,116,{||"Nome"							},oGrp3,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,012)

	oGet2      := TGet():New( 084,044,{|u| If(PCount()==0,_cCodRDA,_cCodRDA:=u)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_cCodRDA",,)
	oGet3      := TGet():New( 084,144,{|u| If(PCount()==0,_cNomRda,_cNomRda:=u)},oGrp3,232,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_cNomRda",,)

	oGrp4      := TGroup():New( 104,012,176,388,"     Servicos Ambulatoriais     ",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay6      := TSay():New( 124,016,{||"Consultas"					},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,040,012)
	oSay7      := TSay():New( 136,016,{||"Servicos Profissionais - SADT"},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,120,008)
	oSay8      := TSay():New( 148,016,{||"Outras despesas ambulatoriais"},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,112,008)
	oSay9      := TSay():New( 160,016,{||"Total"						},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oSay10     := TSay():New( 112,176,{||"Quantidade"					},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,060,012)
	oSay11     := TSay():New( 112,296,{||"Valor R$"						},oGrp4,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,009)

	//-------------------------------------------------------------------
	//Gets de quantidade Serviço Ambulatoriais
	//-------------------------------------------------------------------
	oGet4      := TGet():New( 124,176,{|u| If(PCount()==0,_nQtdCon,_nQtdCon:=u)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdCon",,)
	oGet5      := TGet():New( 136,176,{|u| If(PCount()==0,_nQtdSad,_nQtdSad:=u)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdSad",,)
	oGet6      := TGet():New( 148,176,{|u| If(PCount()==0,_nQtdAmb,_nQtdAmb:=u)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdAmb",,)

	//-------------------------------------------------------------------
	//Get de Total Quantidade Serviço Ambulatoriais
	//-------------------------------------------------------------------
	oGet7      := TGet():New( 160,176,{|u| If(PCount()==0,_nQtdTot,_nQtdTot:=u)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdTot",,)

	//-------------------------------------------------------------------
	//Gets de Valor Serviço Ambulatoriais
	//-------------------------------------------------------------------
	oGet8      := TGet():New( 124,256,{|u| If(PCount()==0,_nVlrCon,_nVlrCon:=u)},oGrp4,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrCon",,)
	oGet9      := TGet():New( 136,256,{|u| If(PCount()==0,_nVlrSad,_nVlrSad:=u)},oGrp4,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrSad",,)
	oGet10     := TGet():New( 148,256,{|u| If(PCount()==0,_nVlrAmb,_nVlrAmb:=u)},oGrp4,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrAmb",,)

	//-------------------------------------------------------------------
	//Get de Valor Total Serviço Ambulatoriais
	//-------------------------------------------------------------------
	oGet11     := TGet():New( 160,256,{|u| If(PCount()==0,_nVlrTot,_nVlrTot:=u)},oGrp4,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrTot",,)
			
	oGrp5      := TGroup():New( 176,012,212,196,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay12     := TSay():New( 180,020,{||"Favor capturar o Terceiro Codigo de Barras"},oGrp5,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,160,012)
	//-------------------------------------
	//Terceiro Codigo de Barras
	//-------------------------------------
	oGet12     := TGet():New( 196,016,{|u| If(PCount()==0,_cCodBar3,_cCodBar3:=u)},oGrp5,176,008,'',{|| AtuBar("3",_cCodBar3)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cCodBar3",,)		

	oGrp8      := TGroup():New( 176,204,212,388,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay21     := TSay():New( 180,216,{||"Favor capturar o Quarto C�digo de Barras"},oGrp8,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,160,008)
	//-------------------------------------
	//Quarto Codigo de Barras
	//-------------------------------------
	oGet24     := TGet():New( 196,210,{|u| If(PCount()==0,_cCodBar4,_cCodBar4:=u)},oGrp8,176,008,'',{|| AtuBar("4",_cCodBar4)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cCodBar4",,)		

	oGrp6      := TGroup():New( 216,012,300,388,"     Servicos Hospitalares     ",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay13     := TSay():New( 236,016,{||"Resumo da Internacao"			},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,148,008)
	oSay14     := TSay():New( 248,016,{||"SADT Paciente Internado"		},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,152,008)
	oSay15     := TSay():New( 260,016,{||"Honorario Individual"			},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,144,008)
	oSay16     := TSay():New( 272,016,{||"Outras Despesas Hospitalares"	},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,144,012)
	oSay17     := TSay():New( 284,016,{||"Total"						},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oSay18     := TSay():New( 224,176,{||"Quantidade"					},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,044,012)
	oSay19     := TSay():New( 224,300,{||"Valor R$"						},oGrp6,,oCabec,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,009)

	//-------------------------------------------------------------------
	//Gets de Quantidade Serviço Hospitalares
	//-------------------------------------------------------------------
	oGet13     := TGet():New( 236,176,{|u| If(PCount()==0,_nQtdInt,_nQtdInt:=u)},oGrp6,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdInt",,)
	oGet14     := TGet():New( 248,176,{|u| If(PCount()==0,_nSadInt,_nSadInt:=u)},oGrp6,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nSadInt",,)
	oGet15     := TGet():New( 260,176,{|u| If(PCount()==0,_nQtdHon,_nQtdHon:=u)},oGrp6,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdHon",,)
	oGet16     := TGet():New( 272,176,{|u| If(PCount()==0,_nQtdOds,_nQtdOds:=u)},oGrp6,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtdOds",,)

	//-------------------------------------------------------------------
	//Get de Total Quantidade Servico Hospitalares
	//-------------------------------------------------------------------
	oGet17     := TGet():New( 284,176,{|u| If(PCount()==0,_nQtotIn,_nQtotIn:=u)},oGrp6,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nQtotIn",,)

	//-------------------------------------------------------------------
	//Gets de Valor Servico Hospitalares
	//-------------------------------------------------------------------
	oGet18     := TGet():New( 236,256,{|u| If(PCount()==0,_nVlrInt,_nVlrInt:=u)},oGrp6,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrInt",,)
	oGet19     := TGet():New( 248,256,{|u| If(PCount()==0,_nVlsDti,_nVlsDti:=u)},oGrp6,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlsDti",,)
	oGet20     := TGet():New( 260,256,{|u| If(PCount()==0,_nVlrHon,_nVlrHon:=u)},oGrp6,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrHon",,)
	oGet21     := TGet():New( 272,256,{|u| If(PCount()==0,_nVlrOds,_nVlrOds:=u)},oGrp6,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlrOds",,)

	//-------------------------------------------------------------------
	//Get de Total Valor Servico Hospitalares
	//-------------------------------------------------------------------
	oGet22     := TGet():New( 284,256,{|u| If(PCount()==0,_nVlToti,_nVlToti:=u)},oGrp6,120,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,oCabec,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","_nVlToti",,)

	oBtn1      := TButton():New( 304,120,"OK"		,oGrp1,{||_lConf := .T., oDlg1:End()},065,012,,oCabec,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 304,216,"Cancelar"	,oGrp1,{||oDlg1:End()},065,012,,oCabec,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

	If _lConf

		AtuReemb()

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function AtuBar
Rotina responsável por atualizar os campos após preenchimento
dos campos de caodigo de barras
@Parametros:
	1 = Primeiro codigo de barras
	2 = Segundo  codigo de barras
	3 = Terceiro codigo de barras
	4 = Quarto   codigo de barras
@author  Angelo
@since   14/12/2020
@version version
/*/
//-------------------------------------------------------------------
Static Function AtuBar(_cParam, _cbarra)

	Local _lRet 	:= .T.
	Local _aArBAU	:= BAU->(GetArea())
	Local _aBarra	:= {}

	Default _cParam := "1"
	Default _cbarra := ""

	If !Empty(AllTrim(_cbarra))

		_aBarra := StrTokArr( AllTrim(_cbarra), ";" )

		If _cParam == "1"
						
			//-------------------------------------------------------------------------
			//Dados do Prestador
			//-------------------------------------------------------------------------
			DbSelectArea("BAU")
			DbSetOrder(1)
			If DbSeek(xFilial("BAU") + _aBarra[1])

				_cCodRDA := BAU->BAU_CODIGO
				_cNomRda := AllTrim(BAU->BAU_NOME)

			Else

				Aviso("Aten��o","Prestador n�o localizado no sistema",{"OK"})

			EndIf
			
			_nQtdCon	:= Val(_aBarra[2])
			_nQtdSad 	:= Val(_aBarra[3])
			_nQtdAmb	:= Val(_aBarra[4])
			_nQtdTot	:= _nQtdCon + _nQtdSad + _nQtdAmb			

		ElseIf _cParam == "2"

			_cCodRem 	:= Val(_aBarra[1])
			_nVlrCon	:= Val(_aBarra[2])
			_nVlrSad	:= Val(_aBarra[3])
			_nVlrAmb	:= Val(_aBarra[4])
			_nVlrTot	:= _nVlrCon + _nVlrSad + _nVlrAmb

			oDlg1:setfocus(oGet12)

		ElseIf _cParam == "3"

			_nQtdInt	 := Val(_aBarra[1])
			_nSadInt	 := Val(_aBarra[2])
			_nQtdHon	 := Val(_aBarra[3])
			_nQtdOds	 := Val(_aBarra[4])
			_nQtotIn	 := _nQtdInt + _nSadInt + _nQtdHon + _nQtdOds

		Else
			
			_nVlrInt	 := Val(_aBarra[1])
			_nVlsDti	 := Val(_aBarra[2])
			_nVlrHon	 := Val(_aBarra[3])
			_nVlrOds	 := Val(_aBarra[4])
			_nVlToti	 := _nVlrInt + _nVlsDti + _nVlrHon + _nVlrOds

		EndIf

	EndIf

	oDlg1:Refresh()

	RestArea(_aArBAU)

Return _lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function AtuReemb
Rotina que será responsável pela atualização da tela do reembolso
@author  Angelo
@since   18/12/2020
@version version
/*/
//-------------------------------------------------------------------
Static Function AtuReemb()

	M->ZZP_NUMREM := _cCodRem
	M->ZZP_CODRDA := _cCodRDA 
	M->ZZP_NOMRDA := _cNomRda
	M->ZZP_QTDCON := _nQtdCon 
	M->ZZP_QTDSAD := _nQtdSad 
	M->ZZP_QTDAMB := _nQtdAmb 
	M->ZZP_QTDTOD := _nQtdTot 
	M->ZZP_VLRCON := _nVlrCon 
	M->ZZP_VLRSAD := _nVlrSad 
	M->ZZP_VLRAMB := _nVlrAmb 
	M->ZZP_VLRTOT := _nVlrTot 
	M->ZZP_QTDINT := _nQtdInt 
	M->ZZP_SADINT := _nSadInt 
	M->ZZP_QTDHON := _nQtdHon 
	M->ZZP_QTDODS := _nQtdOds 	
	M->ZZP_QTOTIN := _nQtotIn 
	M->ZZP_VLRINT := _nVlrInt 
	M->ZZP_VLSDTI := _nVlsDti 
	M->ZZP_VLRHON := _nVlrHon 
	M->ZZP_VLRODS := _nVlrOds 	
	M->ZZP_VLTOTI := _nVlToti 											
	M->ZZP_QTINAM := _nQtdCon + _nQtdSad + _nQtdAmb 
	M->ZZP_VLINAM := _nVlrCon + _nVlrSad + _nVlrAmb 
	M->ZZP_QTINHO := _nQtdInt + _nSadInt + _nQtdHon + _nQtdOds
	M->ZZP_VLINHO := _nVlrInt + _nVlsDti + _nVlrHon + _nVlrOds 
	M->ZZP_QTOTGU := _nQtdCon + _nQtdSad + _nQtdAmb + _nQtdInt + _nSadInt + _nQtdHon + _nQtdOds
	M->ZZP_VLTGUI := _nVlrCon + _nVlrSad + _nVlrAmb + _nVlrInt + _nVlsDti + _nVlrHon + _nVlrOds 
		
	//--------------------------------------------------------------------------
	//Campos preenchidos de forma automática conforme orientação do Max
	//--------------------------------------------------------------------------
	M->ZZP_NUMLOT := 200
	M->ZZP_YLOCAL := "5501"
	M->ZZP_YDESLO := "GEASI"
	M->ZZP_TIPREM := IIF(cEmpAnt = "01", "1", "2")
	M->ZZP_CLACUS := "RED"
	M->ZZP_TIPPRO := "0"
	M->ZZP_USRDIG := "COD. BARRA - ROT. AUT. - " + AllTrim(cUserName)
	M->ZZP_CODANA := U_BUSCAANA()

Return
