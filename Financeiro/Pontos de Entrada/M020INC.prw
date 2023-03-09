/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função	 ³ M020INC	³ Autor ³ ANTONIO MELO            DATA ³ 30.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Ponto de Entrada após a inclusão do FORNECEDOR -    	  ³±±
±±³          ³ Envio de WorkFlow após a inlusão do FORNECEDOR para equipe ³±±
±±³          ³ do financeiro.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATA020()Generico 						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "RwMake.Ch"
#Include "Ap5Mail.Ch"
#Include 'PROTHEUS.CH'  
*----------------------*
User Function M020INC()
*----------------------*
	Local _aArea     := GetArea() //Armazena a Area atual
	Local _cMensagem := ""

	If !(AllTrim(FUNNAME()) == "CAB007")
	
		_cMensagem := DtoC( Date() ) + Chr(13) + Chr(10) + Chr(13) + Chr(10)
		_cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +'Empresa : '+(iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" )) + ' - ' + Iif (AllTrim(FunName()) = "CAB007" , "Reembolso" , "Financeiro")
		_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) + "    Para seu Conhecimento foi incluido no sistema pelo usuario " + AllTrim( SubStr( cUsuario, 07, 15 ) )
		_cMensagem +=  Chr(13) + Chr(10) + " o Fornecedor " + AllTrim( SA2->A2_COD ) + " - "
		_cMensagem += AllTrim( SA2->A2_NOME ) + " - "
		_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Obs.: Este e-mail foi enviado automaticamente pelo Protheus. Por favor não responder"

		EnviaEmail( _cMensagem )
	
	EndIf
	
	RestArea( _aArea )
Return

*--------------------------------------*
Static Function EnviaEmail( _cMensagem )
*--------------------------------------*
	Local _cMailServer := GetMv(  "MV_RELSERV" )
	Local _cMailConta  := GetMv( "MV_EMCONTA")
	Local _cMailSenha  := GetMv( "MV_EMSENHA" )
	Local _cTo  	   := "esther.melo@caberj.com.br "
	//Local _cCC         := " "  //GetMv( "MV_WFFINA" )
	Local _cAssunto    := "Inclusao do Cadastro de Fornecedor"
	Local _cError      := ""
	Local _lOk         := .T.
	Local _lSendOk     := .F.
	If !(AllTrim(FUNNAME()) $ "CAB007|CABA347")
		If !Empty( _cMailServer ) .And. !Empty( _cMailConta  ) .and. inclui .AND. !Empty( _cTo )
			CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk
			If _lOk
				SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
			Else
				GET MAIL ERROR _cError
				Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )
			EndIf
		EndIf
		If _lOk
			DISCONNECT SMTP SERVER
		EndIf
	EndIf

Return