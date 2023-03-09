#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS500OK  ºAutor  ³Renato Peixoto      º Data ³  13/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para não permitir a digitação de mais de  º±±
±±º          ³ uma consulta em uma mesma guia a pedido do Dr. Jose Paulo. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteração ³ Tratamento para não permitir a inclusão de guais mistas    º±±
±±º          ³ (consulta+exame). Isso deverá ocorrer, exceto para         º±±
±±º          ³ prestadores que sejam do tipo OPE                          º±±
±±º          ³ (Operadoras - Reciprocidade).                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS500OK()
	
	Local lRet      := .T.
	Local nContCons := 0 //Contador para a consulta
	Local i         := 0
	Local j         := 0
	Local cCodPad   := ""
	Local cCodPro   := ""
	Local cTpGui    := paramixb[1]
	Local cCodRDA   := ""
	Local cTipoRDA  := ""
	Local lConsulta := .F.
	Local lExame    := .F.
	Local cRDALib   := GETMV("MV_XRDALIB") //RDAs que estão temporariamente autorizados a incluir mais de uma consulta na mesma guia, bem como consultas e exames na mesma guia. Autorizado pelo Dr. Jose Paulo em reunião comigo e Leandro do contas médicas em Julho de 2011
	
	//Leonardo Portella - 26/04/12 - Inicio
	//Nao permitir que sejam incluidas guias nos locais de digitacao da importacao de guias TISS.
	
	Local cMsg 		:= ""
	//Local aArea		:= GetArea()
	//Local aAreaBCG	:= BCG->(GetArea())
	Local aArea		:= NIL
	Local aAreaBCG	:= NIL
	Local cQry
	Local c_Alias
	Local cHorPro
	Local cDatPro
	Local _lLocal	:= IIF(BCI->BCI_CODLDP == '0010', .T., .F.) //Angelo Henrique - Data:19/05/2016 - Autorização Local 0010 (PEG Recurso de GLOSA)
	Local lFim     := .F.
	//-------------------------------------------------------------------------------------------------------
	// Angelo Henrique - Data:19/05/2016
	//-------------------------------------------------------------------------------------------------------
	//Conforme alinhado com Roberto e Marcia Piumbim
	//quando o local for de 0010 de recurso de glosa o processo deverá seguir normalmente sem bloqueios
	//-------------------------------------------------------------------------------------------------------
	If !(_lLocal)
		aArea		:= GetArea()
		aAreaBCG	:= BCG->(GetArea())
		
		//Leonardo Portella - 28/03/16 - Inicio - Não permitir incluir guias em local de digitação comum (0001) a menos que
		//autorizado pelo Coordenador
		
		//If INCLUI .and. !U_lDigMedlink('GUIA')
		If GetNewPar("MV_XVALDIG",1) == 1 .AND. INCLUI .and. !U_lDigMedlink('GUIA') //GetNewPar("MV_XVALDIG",1) == 1 .AND. Incluido por marcela coimbra
			lRet := .F.
		EndIf
		
		//Leonardo Portella - 28/03/16 - Fim
		
		
		//Leonardo Portella - 24/07/14 - Inicio - Validar a data de inclusao. Chamado - ID: 12503
		
		If INCLUI .and. ( dDataBase > Date() )
			lRet 	:= .F.
			cMsg 	:= 'Não será possível incluir guias com data no sistema maior que a data atual.' 	+ CRLF
			cMsg	+= 'Data no sistema: [ ' + DtoC(dDataBase) + ' ]' 									+ CRLF
			cMsg	+= 'Data atual: [ ' + DtoC(Date()) + ' ]' 											+ CRLF
			
			MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
		EndIf
		
		//Leonardo Portella - 24/07/14 - Fim
		
		
		// INÍCIO MATEUS MEDEIROS - PROJETO PREECHIMENTO CBOS - 11/01/19
		If ( INCLUI .or. ALTERA ) .and. ( BCI->BCI_CODLDP == '0001' ) .and. ( BCL->BCL_ALIAS == 'BD5' )
			if cTpGui $ "01|02|06"
				if cTpGui $ "01|06|"
					
					if empty(alltrim(M->BD5_CBOS))
						alert("Preenchimento do campo CBO-S solicitante/executante é obrigatório, favor realizar o preenchimento.")
						lFim := .T.
						lRet := .F.
					else
						M->BD5_XCBOE :=  	BD5->BD5_CBOS
						M->BD5_XCBOS :=  	BD5->BD5_CBOS
					endif
					
				elseif cTpGui == "02" // SADT
					if M->BD5_TIPATE  $ '|02|03|04|05|'
						if (empty(alltrim(M->BD5_CBOS)) .or. empty(alltrim(M->BD5_XCBOE)))
							alert("Para o tipo de atendimento informado, é obrigatório informar o CBO-S do solicitante executante.")
							lFim := .T.
							lRet := .F.
						else
							if alltrim(M->BD5_CBOS) == "999999" .or. alltrim(M->BD5_XCBOE) ==  "999999"
								alert("Para o tipo de atendimento informado, CBO-S do executante e/ou do solicitante inválido.")
								lFim := .T.
								lRet := .F.
							else
								M->BD5_XCBOS :=  	M->BD5_CBOS
							endif
						endif
					endif
					
				EndIf
			Endif
		endif
		if !lFim
			// FIM MATEUS MEDEIROS - PROJETO PREENCHIMENTO CBOS - 11/01/2019
			
			//Leonardo Portella - 19/04/16 - Inicio - Ajuste da data/hora das guias de resumo de internação no momento da inclusão/alteração de guia de OPME
			
			If ( INCLUI .or. ALTERA ) .and. ( BCI->BCI_CODLDP == '0013' ) .and. ( BCL->BCL_ALIAS == 'BD5' )
				
				aArBE4	:= BE4->(GetArea())
				
				c_Alias := GetNextAlias()
				
				cQry := "SELECT  SOLICITACAO.BE4_DATPRO DATSOL, SOLICITACAO.BE4_HORPRO HORSOL, SOLICITACAO.BE4_DTALTA ALTSOL, SOLICITACAO.BE4_HRALTA HRALSOL, SOLICITACAO.R_E_C_N_O_ RECSOL, SOLICITACAO.BE4_TIPGUI TIPOSOL," 	+ CRLF
				cQry += "        RESUMO.BE4_DATPRO DATRES, RESUMO.BE4_HORPRO HORRES, RESUMO.BE4_DTALTA ALTRES, RESUMO.BE4_HRALTA HRALRES, RESUMO.R_E_C_N_O_ RECRES, RESUMO.BE4_TIPGUI TIPORES" 									+ CRLF
				cQry += "FROM " + RetSqlName('BE4') + " SOLICITACAO" 															+ CRLF
				cQry += "INNER JOIN " + RetSqlName('BE4') + " RESUMO ON RESUMO.BE4_FILIAL = '" + xFilial('BE4') + "'" 			+ CRLF
				cQry += "  AND RESUMO.BE4_OPEUSR = SOLICITACAO.BE4_OPEUSR" 														+ CRLF
				cQry += "  AND RESUMO.BE4_CODEMP = SOLICITACAO.BE4_CODEMP" 														+ CRLF
				cQry += "  AND RESUMO.BE4_MATRIC = SOLICITACAO.BE4_MATRIC" 														+ CRLF
				cQry += "  AND RESUMO.BE4_TIPREG = SOLICITACAO.BE4_TIPREG" 														+ CRLF
				cQry += "  AND RESUMO.BE4_DATPRO <> ' '" 																		+ CRLF
				cQry += "  AND '" + DtoS(M->BD5_DATPRO) + "' >= RESUMO.BE4_DATPRO" 												+ CRLF
				cQry += "  AND ( '" + DtoS(M->BD5_DATPRO) + "' <= RESUMO.BE4_DTALTA OR RESUMO.BE4_DTALTA = ' ' )" 				+ CRLF
				cQry += "  AND RESUMO.BE4_SITUAC = '1'" 																		+ CRLF
				cQry += "  AND RESUMO.D_E_L_E_T_ = ' '" 																		+ CRLF
				cQry += "  AND RESUMO.BE4_TIPGUI = '05'" 																		+ CRLF
				cQry += "  AND RESUMO.BE4_DATPRO || RESUMO.BE4_HORPRO <= SOLICITACAO.BE4_DATPRO || SOLICITACAO.BE4_HORPRO"		+ CRLF
				cQry += "WHERE SOLICITACAO.BE4_FILIAL = '" + xFilial('BE4') + "'" 												+ CRLF
				cQry += "  AND SOLICITACAO.BE4_OPEUSR = '" + M->BD5_OPEUSR + "'" 												+ CRLF
				cQry += "  AND SOLICITACAO.BE4_CODEMP = '" + M->BD5_CODEMP + "'" 												+ CRLF
				cQry += "  AND SOLICITACAO.BE4_MATRIC = '" + M->BD5_MATRIC + "'" 												+ CRLF
				cQry += "  AND SOLICITACAO.BE4_TIPREG = '" + M->BD5_TIPREG + "'" 												+ CRLF
				cQry += "  AND SOLICITACAO.BE4_DATPRO <> ' '" 																	+ CRLF
				cQry += "  AND '" + DtoS(M->BD5_DATPRO) + "' >= SOLICITACAO.BE4_DATPRO" 										+ CRLF
				cQry += "  AND ( '" + DtoS(M->BD5_DATPRO) + "' <= SOLICITACAO.BE4_DTALTA OR SOLICITACAO.BE4_DTALTA = ' ' )" 	+ CRLF
				cQry += "  AND SOLICITACAO.BE4_SITUAC = '1'" 																	+ CRLF
				cQry += "  AND SOLICITACAO.D_E_L_E_T_ = ' '" 																	+ CRLF
				cQry += "  AND SOLICITACAO.BE4_TIPGUI = '03'" 																	+ CRLF
				
				TcQuery cQry New Alias c_Alias
				
				If !c_Alias->(EOF())
					
					cDatPro := c_Alias->DATSOL
					cHorPro	:= c_Alias->HORSOL
					
				EndIf
				
				While !c_Alias->(EOF())
					
					u_Soma1DtHr(@cDatPro, @cHorPro)
					
					BE4->(DbGoTo( c_Alias->RECRES ))
					
					BE4->(Reclock('BE4',.F.))
					
					BE4->BE4_DATPRO := StoD(cDatPro)
					BE4->BE4_HORPRO := cHorPro
					
					BE4->(Msunlock())
					
					c_Alias->(DbSkip())
					
				EndDo
				
				c_Alias->(DbCloseArea())
				
				BE4->(RestArea(aArBE4))
				
				RestArea(aArea)
				
			EndIf
			
			//Leonardo Portella - 19/04/16 - Fim
			
			If INCLUI .and. ( BCI->BCI_CODLDP $ '0002|0011|0015' )
				
				lRet := .F.
				
				Do Case
					
				Case BCI->BCI_CODLDP == '0002'
					cMsg := 'Local de digitação 0002 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + BCI->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
						'Local exclusivo para importacao de guias TISS'
					
				Case BCI->BCI_CODLDP == '0011'
					cMsg := 'Local de digitação 0011 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + BCI->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
						'Local exclusivo para importacao de guias verdes TISS'
					
				Case BCI->BCI_CODLDP == '0015'
					cMsg := 'Local de digitação 0015 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + BCI->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
						'Local exclusivo para importacao de guias TISS digitadas pela Medlink'
					
				EndCase
				
				cMsg += CRLF + CRLF + 'Nao sera permitida a inclusao de novas guias nesta PEG.'
				
				MsgStop(cMsg,'Grupo Caberj')
				
				//Leonardo Portella - 24/06/13 - Inicio
				
				If RetCodUsr() $ GetMV('MV_XGETIN')
					lRet := MsgYesNo('TI - Deseja incluir a guia mesmo assim???','TI - Permissao especial para incluir guias')
				Endif
				
				//Leonardo Portella - 24/06/13 - Fim
				
				//If AllTrim(cTpGui) <> "03" .AND. AllTrim(cTpGui) <> "01"
			ElseIf AllTrim(cTpGui) <> "03" .AND. AllTrim(cTpGui) <> "01"
				
				//Leonardo Portella - 26/04/12 - Fim
				
				If !(ParamIxb[4][3][1][4] $(cRDALib)) //se o RDA não for um dos autorizados a incluir mais de uma consulta ou consultas e exames juntos
					For i := 1 To Len(paramixb[4][2])
						If !(paramixb[4][2][i][len(paramixb[4][2][i])])//se a linha não estiver deletada...
							cCodPad := paramixb[4][2][i][2]
							cCodPro := paramixb[4][2][i][4]
							DbSelectArea("BR8")
							DbSetOrder(1)
							If DbSeek(XFILIAL("BR8")+cCodPad+cCodPro)
								If SubStr(BR8->BR8_CLASIP,1,1) = "A"
									nContCons++
									lConsulta := .T. //marco que existe uma consulta na guia
								EndIf
							EndIf
						EndIf
					Next i
					
					
					If nContCons > 1
						lRet := .F.
						APMSGINFO("Atenção, não é possível incluir mais de uma consulta em uma mesma guia. Favor incluir uma nova guia para uma nova consulta.","Não é possível incluir mais de uma consulta!")
					EndIf
					
				EndIf
				
				//					 Validação retirada por enquanto, conforme acertado com leandro do contas médicas e Dr. Jose paulo, pq departamento contas médiacs estava parado. 19/07/11
				//					cCodRDA := M->BD5_CODRDA
				//					DbSelectArea("BAU")
				//					DbSetOrder(1)
				//					If DbSeek(XFILIAL("BAU")+cCodRDA)
				//						cTipoRDA := BAU->BAU_TIPPRE
				//					EndIf
				//
				//					If AllTrim(cTipoRDA) <> "OPE" //se o prestador for diferente do tipo OPE (operadora), significa que é reciprocidade, então devo restringir a digitação de consulta + exame na mesma guia...
				//
				//						For j := 1 To Len(paramixb[4][2])
				//							If !(paramixb[4][2][j][len(paramixb[4][2][j])])//se a linha não estiver deletada...
				//								cCodPad := paramixb[4][2][j][2]
				//								cCodPro := paramixb[4][2][j][4]
				//								DbSelectArea("BR8")
				//								DbSetOrder(1)
				//								If DbSeek(XFILIAL("BR8")+cCodPad+cCodPro)
				//									If SubStr(BR8->BR8_CLASIP,1,1) = "C"
				//										lExame := .T. //marco que existe um exame na guia
				//									EndIf
				//								EndIf
				//							EndIf
				//						Next j
				//
				//					EndIf
				
			EndIf
			/*
			If lConsulta .AND. lExame //se tiver consulta e exame na mesma guia, nego a inclusão
				APMSGINFO("Atenção, não é permitido incluir consultas e exames na mesma guia, favor incluir o exame + seus materiais/medicamentos relacionados em uma guia separada.","Validação de consistência.")
				lRet := .F.
			EndIf
			*/
			
			//Leonardo Portella - 26/04/12 - Inicio
			
		endif

		BCG->(RestArea(aAreaBCG))
		RestArea(aArea)
		//Leonardo Portella - 26/04/12 - Fim
	EndIf
	
	// Fim - Angelo Henrique - Data:19/05/2016 -- Validação de Recurso de Glosa
Return(lRet)

*******************************************************************************************************************************

User Function Soma1DtHr(cData, cHora, cTipoRet)
	
	Local cRet := ''
	
	Default cTipoRet := 'HORA'
	
	cHora := PadR(AllTrim(Replace(cHora,':','')),6,'0')
	cData := AllTrim(cData)
	
	If Soma1(Right(cHora,2)) >= '60'
		
		If Soma1(Substr(cHora,3,2)) >= '60'
			
			If Soma1(Left(cHora,2)) >= '24'
				cData 	:= DtoS(StoD(cData) + 1)
				cHora	:= '000000'
			Else
				cHora 	:= Soma1(Left(cHora,2)) + '0000'
			EndIf
			
		Else
			cHora := Left(cHora,2) + Soma1(Substr(cHora,3,2)) + '00'
		EndIf
		
	Else
		cHora := Left(cHora,4) + Soma1(Right(cHora,2))
	EndIf
	
	If cTipoRet == 'HORA'
		cRet := cHora
	Else
		cRet := cData
	EndIf
	
Return cRet
