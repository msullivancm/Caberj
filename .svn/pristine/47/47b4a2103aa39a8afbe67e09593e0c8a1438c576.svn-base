/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS260VU  ºAutor  ³Microsiga           º Data ³  12/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado na confirmacao do cadastro de fami-º±±
±±º          ³lias (rotina PLSA260).                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS260VU()
Local lRet		:= .T.
Local nOpc		:= PARAMIXB[1] //K_Incluir / K_Alterar
Local aErros	:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Nova implementacao: So permite confirmar se a consistencia executada   ³
	//³esteja validada. Somente caso seja Caixa e bloqueio de familia...	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Substr(cNumEmp,1,2) == "01" .And. FunName() == "PLSA174" //Realizar validacao somente para Caixa,!!!!
		//If BA3->BA3_CODEMP <> "0004" //Nao validar intercambio
		If !BA3->BA3_CODEMP $ "0004|0009" //Nao validar intercambio
			Processa({|| aErros := U_VldCadast("M",.F.) }, "Consistindo cadastro...", "", .T.)			
			If Len(aErros) > 0
				lRet := .F.
				PLSCRIGEN(aErros,{ {"Detalhe","@C",230},{"Ação","@C",230} },"Inconsistências encontradas no desbloqueio...",.T.)
				/*
				If cUserName $ GetNewPar("MV_YUDBLQ","Administrador")
					If MsgYesNo("ATENÇÃO! Deseja confirmar o desbloqueio com dados faltantes/incompletos ?")
						lRet := .T.
					Endif
				Endif			
				*/
			Endif			
		Endif
	Endif     
	
	**'Marcela Coimbra - Validações Integral'**
	If Substr(cNumEmp,1,2) == "02" .And. FunName() == "PLSA174" //Realizar validacao somente para Caixa,!!!!
		//If BA3->BA3_CODEMP <> "0004" //Nao validar intercambio
			Processa({|| aErros := U_VldCadInt("M",.F.) }, "Consistindo cadastro...", "", .T.)			
			If Len(aErros) > 0
				lRet := .F.
				PLSCRIGEN(aErros,{ {"Detalhe","@C",230},{"Ação","@C",230} },"Inconsistências encontradas no desbloqueio...",.T.)
				/*
				If cUserName $ GetNewPar("MV_YUDBLQ","Administrador")
					If MsgYesNo("ATENÇÃO! Deseja confirmar o desbloqueio com dados faltantes/incompletos ?")
						lRet := .T.
					Endif
				Endif			
				*/
						
		Endif
  

	Endif

	
Return(lRet)

User Function Criativa( c_CodPla )

	m->ba3_codpla := c_CodPla

Return c_CodPla