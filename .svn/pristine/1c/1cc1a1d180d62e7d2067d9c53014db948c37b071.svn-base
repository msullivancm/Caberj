#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLBLQFAM  ºAutor  ³Jean Schulz         º Data ³  12/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada no bloqueio/desbloqueio de familia, para   º±±
±±º          ³realizar consistencias...                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function PLBLQFAM()
	
	LOCAL lRet		:= .T.
	LOCAL cBloq		:= PARAMIXB[1]
	Local aAreaBA1	:= BA1->(GetArea())
	Local aErrBlo	:= {}
	
	//Leonardo Portella - 28/10/11 - Inicio
	
	Local cMotBlq   := paramixb[2]
	Local dDatBlq   := paramixb[3]
	Local cAlias    := paramixb[4]
	Local dDatInc   := paramixb[5]
	Local dDatPed   := paramixb[6]
	Local cAlias	:= GetNextAlias()
	Local aArea		:= GetArea()	
	
	//Leonardo Portella - 28/10/11 - Fim
	
	If Empty(cBloq) // Se estiver em branco eh um bloqueio.
		
		//Leonardo Portella - 28/10/11 - Inicio
		
		cQuery := "SELECT BA1_NOMUSR, BA0_NOMINT" 										+ CRLF
		cQuery += "FROM " + RetSqlName('BA1') + " BA1" 									+ CRLF
		cQuery += "INNER JOIN " + RetSqlName('BA0') + " BA0 ON BA0.D_E_L_E_T_ = ' '" 	+ CRLF
		cQuery += "  AND BA0_FILIAL = '" + xFilial('BA0') + "'" 						+ CRLF
		cQuery += "  AND BA0_CODIDE||BA0_CODINT = BA1_OPEDES" 							+ CRLF
		cQuery += "WHERE BA1.D_E_L_E_T_ = ' '" 											+ CRLF
		cQuery += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 						+ CRLF
		cQuery += "  AND BA1_CODINT = '" + BA3->BA3_CODINT + "'" 						+ CRLF
		cQuery += "  AND BA1_CODEMP = '" + BA3->BA3_CODEMP + "'" 						+ CRLF
		cQuery += "  AND BA1_MATRIC = '" + BA3->BA3_MATRIC + "'" 						+ CRLF
		cQuery += "  AND BA1_LOCATE = '2'" 												+ CRLF
		
		cMsg := ""
		
		TcQuery cQuery New Alias cAlias
		
		While !cAlias->(EOF())
			
			cMsg += ' - Beneficiário: ' + AllTrim(Capital(Lower(cAlias->BA1_NOMUSR))) + ' - Grupo/Empresa: ' + AllTrim(Capital(Lower(cAlias->BA0_NOMINT))) + CRLF
			
			cAlias->(DbSkip())
			
		EndDo
		
		cAlias->(DbCloseArea())
		
		If !empty(cMsg)
			LogErros(cMsg,"Usuários de repasse",.T.)
			
			cMsg 	:= 'Favor bloquear as matrículas do repasse na operadora destino.' + CRLF
			cMsg	+= Replicate('_',50) + CRLF + 'Confirma o bloqueio da família, inclusive dos usuários de repasse?'
			
			nOpca 	:= Aviso('ATENÇÃO',cMsg,{'Sim','Não'})
			
			lRet 	:= ( nOpca == 1 )
		EndIf
		
		//Leonardo Portella - 28/10/11 - Fim
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nova implementacao: levar conteudo da matricula antiga para a matricula³
		//³bloqueada.                                       					  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		/*
		BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
		While !BA1->(Eof()) .And. BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
			
			BA1->(RecLock("BA1",.F.))
			BA1->BA1_MATUSB := BA1->BA1_MATANT
			BA1->BA1_MATANT := ""
			BA1->(MsUnlock())
			
			BA1->(DbSkip())
		Enddo
		
		BA3->(Reclock("BA3",.F.))
		BA3->BA3_MATANT = ""
		BA3->(MsUnlock())
		*/
		
	Else
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nova implementacao: So permite desbloquear se a consistencia executada ³
		//³esteja validada. Somente caso seja Caixa e bloqueio de familia...	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Substr(cNumEmp,1,2) == "01" .And. FunName() == "PLSA174" //Realizar validacao somente para Caixa,!!!!
			If !Empty(BA3->BA3_DATBLO) .And. BA3->BA3_CODEMP <> "0004" //Nao validar intercambio
				Processa({|| aErrBlo := U_VldCadast("BA3",.T.) }, "Consistindo desbloqueio...", "", .T.)
				If Len(aErrBlo) > 0
					**'Marcela Coimbra - Data: 26/08/2015'**
					lRet := .T.
					**'Marcela Coimbra - Data: 26/08/2015'**
					
					PLSCRIGEN(aErrBlo,{ {"Detalhe","@C",230},{"Ação","@C",230} },"Inconsistências encontradas no desbloqueio...",.T.)
					If upper(Alltrim(cUserName)) $ upper(Alltrim(GetNewPar("MV_YUDBLQ","Administrador")))
						If MsgYesNo("ATENÇÃO! Deseja confirmar o desbloqueio com dados faltantes/incompletos ?")
							lRet := .T.
						Endif
					Endif
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Nova implementacao: levar conteudo da matricula antiga bloqueada para a³
					//³matricula antiga, caso o desbloqueio tenha sido possivel.			  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					//Raios
					/*
					BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
					While !BA1->(Eof()) .And. BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
						
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_MATANT := BA1->BA1_MATUSB
						BA1->BA1_MATUSB := ""
						BA1->(MsUnlock())
						
						BA1->(DbSkip())
					Enddo
					*/
					
				Endif
			Endif
		Endif
		
	Endif
	
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Nova implementacao: Caso seja bloqueio, levar o conteudo do campo 	  ³
	//³TIPPAG para campo personalizado, e marcar o tippag como 00 (sem envio  ³
	//³de cobranca) - Data: 12/11/07.									      ³
	//³                              									      ³
	//³ Em Fev/09 - Alterar para nao gravar mais 00 se a forma de Cobrança 	  ³
	//³             for diferente de Boleto, fica como boleto a nao ser    	  ³
	//³             que esteja marcado como nao receber - 00               	  ³
	//³                                                                  	  ³
	//³ Em Ago/09 - Nao alterar forma de Cobrança se o Motivo estiver em lis- ³
	//|             ta especifica.                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lRet
		
		//-----------------------------------------------------------------------
		// Angelo Henrique - Data: 10/09/2019
		//-----------------------------------------------------------------------
		//Colocado nova validação no processo de mudança da forma de pagamento.
		//-----------------------------------------------------------------------
		//Quando não for bloqueio temporário deve-se mudar a forma 
		//-----------------------------------------------------------------------
		//If Empty(BA3->BA3_YTPPAG) .And. !Empty(BA3->BA3_TIPPAG)
		//-----------------------------------------------------------------------			
		
		If !(M->BC3_MOTBLO $ GetNewPar("MV_YNBQ00","028")) .And. !(M->BC3_MOTBLO $ GetNewPar("MV_XBLQSP","485")) .AND. Empty(cBloq)
		
			BA3->(RecLock("BA3",.F.))
			BA3->BA3_YTPPAG := BA3->BA3_TIPPAG
			
			//-----------------------------------------------------------------------	
			//Angelo Henrique - Data: 11/09/2019
			//-----------------------------------------------------------------------
			//Colocado a validação do motivo de bloqueio no inicio
			//-----------------------------------------------------------------------
			//If ((BA3->BA3_COBNIV == "1") .AND. (BA3->BA3_TIPPAG <> GetNewPar("MV_YRCCNAB","04")) .AND. (BA3->BA3_TIPPAG <> "00") .AND. !(M->BC3_MOTBLO $ GetNewPar("MV_YNBQ00","028")))
			//-----------------------------------------------------------------------
			
			If ((BA3->BA3_COBNIV == "1") .AND. (BA3->BA3_TIPPAG <> GetNewPar("MV_YRCCNAB","04")) .AND. (BA3->BA3_TIPPAG <> "00")) 
			
				BA3->BA3_TIPPAG := GetNewPar("MV_YRCCNAB","04") //boleto
				BA3->BA3_GRPCOB := Iif(BA3->BA3_CODEMP=="0001","0002","0003")
				
				//----------------------------------------------
				//Angelo Henrique - Data: 11/09/2019
				//----------------------------------------------
				//Acrescentando informações bancárias
				//----------------------------------------------
				BA3->BA3_VENCTO  := 10
				BA3->BA3_PORTAD := "237"
				BA3->BA3_AGEDEP  := "3369"
				BA3->BA3_CTACOR	 := "8895"
			
			Endif
			
			BA3->(MsUnlock())
			
			
			/*
			BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
			
			While
			U_PLS260ABLU()
			
			BA1->(DbSkip())
		Enddo
		*/
		
	ElseIf !Empty(BA3->BA3_YTPPAG) .And. BA3->BA3_TIPPAG == "00"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nova implementacao: Caso seja desbloqueio, levar o conteudo antigo para³
		//³o campo tippag, e liberar o campo personalizado.(12/11/07)			  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA3->(RecLock("BA3",.F.))
		BA3->BA3_TIPPAG := BA3->BA3_YTPPAG
		BA3->BA3_YTPPAG := ""
		BA3->(MsUnlock())
	Endif
Endif

RestArea(aArea)//Leonardo Portella - 28/10/11

Return(lRet)

