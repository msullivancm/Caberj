/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função	 ³ M020ALT	³ Autor ³ ALTAMIRO            DATA ³ 14.10.11     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Ponto de Entrada após o ok da alteração  do FORNECEDOR -   ³±±
±±³          ³ Envio de WorkFlow após a alteração do FORNECEDOR para equipe³±±
±±³          ³ do financeiro.                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATA020()Generico 						                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "RwMake.Ch"
#Include "Ap5Mail.Ch"

User Function MA020ALT()
	
	Local lEmail     := .F.
	Local c_CampAlt := '  '
	Local lExecuta := .T.
	//Local _aArea    := GetArea() //Armazena a Area atual
	Local aArea     := GetArea() //Armazena a Area atual
	Local _cMensagem := ""
	
	If sa2->A2_NOME   != M->A2_NOME
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10) + '      Nome Anterior :  '   +sa2->A2_NOME +'------> Nome Atual  :  '   + M->A2_NOME
	EndIf
	If sa2->A2_CGC     != M->A2_CGC
		lEmail        := .T.
		c_CampAlt +=  Chr(13) + Chr(10)
		c_CampAlt += '      Cnpj/Cpf  Anterior :  ' + sa2->A2_CGC +'------> Cnpj/Cpf  Atual  :  ' + M->A2_CGC
	EndIf
	If sa2->A2_BANCO      != M->A2_BANCO
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10)
		c_CampAlt += '      Banco  Anterior :  '   +  sa2->A2_BANCO   +'------>  Banco  Atual  :  '   +  M->A2_BANCO
	EndIf
	If sa2->A2_AGENCIA    != M->A2_AGENCIA
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10)
		c_CampAlt += '      Agencia  anterior :  '  + sa2->A2_AGENCIA + '------>  Agencia  Atual  :  ' + M->A2_AGENCIA
	EndIf
	If sa2->A2_NUMCON    != M->A2_NUMCON
		lEmail        := .T.
		c_CampAlt +=Chr(13) + Chr(10)
		c_CampAlt += '      Conta Anterior :  '   +  sa2->A2_NUMCON    + '------>  Conta Atual :  '   + M->A2_NUMCON
	EndIf
	If sa2->A2_YDAC    != M->A2_YDAC
		lEmail        := .T.
		c_CampAlt +=Chr(13) + Chr(10)
		c_CampAlt += '      Dv Conta Anterior :  '   +  sa2->A2_YDAC    + '------>  Dv Conta Atual :  '   + M->A2_YDAC
	EndIf
	
	If sa2->A2_NATUREZ     != M->A2_NATUREZ
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10)
		c_CampAlt += '      Natureza Anterior :  '   +  sa2->A2_NATUREZ    + '------>  Natureza Atual :  '   + M->A2_NATUREZ
		
	EndIf
	If sa2->A2_RECISS     != M->A2_RECISS
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10)
		c_CampAlt += '      Retenção de Iss Anterior :  '   +  sa2->A2_RECISS    + '------>  Retenção de Iss  Atual :  '   + M->A2_RECISS
		
	EndIf
	If sa2->A2_RECINSS     !=  M->A2_RECINSS
		lEmail        := .T.
		c_CampAlt +=Chr(13) + Chr(10)
		c_CampAlt += '      Retenção de Inss Anterior :  '   +  sa2->A2_RECINSS    + '------>  Retenção de Inss  Atual :  '   + M->A2_RECINSS
		
	EndIf
	If sa2->A2_RECPIS      !=   M->A2_RECPIS
		lEmail        := .T.
		c_CampAlt += Chr(13) + Chr(10)
		c_CampAlt += '      Retenção de Pis Anterior :  '   +  sa2->A2_RECPIS    + '------>  Retenção de Pis  Atual :  '   + M->A2_RECPIS
		
	EndIf
	If sa2->A2_RECCOFI    !=  M->A2_RECCOFI
		lEmail        := .T.
		c_CampAlt +=Chr(13) + Chr(10)
		c_CampAlt += '      Retenção de Cofins  Anterior :  '   +  sa2->A2_RECCOFI    + '------>  Retenção de Cofins  Atual :  '   + M->A2_RECCOFI
		
	EndIf
	If sa2->A2_RECCSLL     !=  M->A2_RECCSLL
		lEmail        := .T.
		c_CampAlt +=Chr(13) + Chr(10)
		c_CampAlt += '      Retenção de Csll  Anterior :  '   +  sa2->A2_RECCSLL    + '------>  Retenção de Csll  Atual :  '   + M->A2_RECCSLL
		
	EndIf
	
	if lEmail
		_cMensagem := DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)
		_cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +'Empresa : '+(iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" ))+ ' - ' + Iif (AllTrim(FunName()) = "CAB007" , "Reembolso" , "Financeiro")
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "    Foi Alterado  no sistema pelo usuario " + AllTrim( SubStr( cUsuario, 07, 15 ) )
		_cMensagem += " o Fornecedor " + AllTrim( SA2->A2_COD ) + " - "
		_cMensagem += AllTrim( SA2->A2_NOME ) + Chr(13) + Chr(10) +  " os Campos : " +Chr(13) + Chr(10) + c_CampAlt
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +"Para seu conhecimento."+Chr(13) + Chr(10)+Chr(13) + Chr(10)+" Obs.: Este e-mail foi enviado automaticamente pelo Protheus. Por favor não responder"
		EnviaEmail( _cMensagem )
	EndIf
	
	//-----------------------------------------------------
	//Inicio - Angelo Henrique - Data: 04/10/2016
	//-----------------------------------------------------
	//Rotina que irá atualizar alguns campos da BAU
	//pois o padrão estava cadastradando errado.
	//-----------------------------------------------------
	AtuFrnBAU()
	//-----------------------------------------------------
	//Fim - Angelo Henrique - Data: 04/10/2016
	//-----------------------------------------------------
	
	RestArea(aArea)
	
Return (.T.)
*--------------------------------------*
Static Function EnviaEmail( _cMensagem )
	*--------------------------------------*
	
	/*Local _cMailServer := GetMv( "MV_WFSMTP" )
	Local _cMailConta  := GetMv( "MV_WFAUTUS" )
	Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
	Local _cMailServer := GetMv(  "MV_RELSERV" )
	Local _cMailConta  := GetMv( "MV_EMCONTA")
	Local _cMailSenha  := GetMv( "MV_EMSENHA" )
	
	//Local _cTo  	   := "alan.jefferson@caberj.com.br, esther.melo@caberj.com.br, piumbim@caberj.com.br"
	//Local _cTo  	   := "alan.jefferson@caberj.com.br, esther.melo@caberj.com.br" // a pedido da Marcia Piumbim
	// comentado para exexcutar GLPI 54408 - Mateus Medeiros - 03/12/18
	//Local _cTo  	   := alan.jefferson@caberj.com.br, esther.melo@caberj.com.br "
    Local _cTo  	   := "esther.melo@caberj.com.br" //"monique.goncalves@caberj.com.br"
	//Local _cTo  	   := "altamiro@caberj.com.br "
	Local _cCC         := " "  //GetMv( "MV_WFFINA" )
	Local _cAssunto    := "Alteração do Cadastro de Fornecedor"
	Local _cError      := ""
	Local _lOk         := .T.
	Local _lSendOk     := .F.
	
	/*If !Empty( _cMailServer ) .And. ;
		!Empty( _cMailConta  ) .And. ;
		!Empty( _cMailSenha  )
	*/
	If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  ) .And. altera .and. !Empty( _cTo )
		// Conecta uma vez com o servidor de e-mails
		CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk
		
		If _lOk
			SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
			
			/*		If !_lSendOk
			//Erro no Envio do e-mail
			GET MAIL ERROR _cError
			Aviso("Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )
		Else
			//DbSelectArea("SA1")
			RecLock("SA1",.F.)
			SB1->B1_XEMAIL := "1" //e-mail não enviado
			MsUnlock()
			
		EndIf
		*/
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



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³ AtuFrnBAU	³ Autor ³ Angelo Henrique     DATA ³ 04/10/16	     ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Rotina utilizada para atualizar informações na tabela BAU   ±±
±±³          ³ RDA, pois na alteração a rotina estava atualizando campos de±±
±±³          ³ forma indevida.                                             ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Inclusão/Alteração de fornecedores				           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuFrnBAU
	
	Local _aArea 	:= GetArea()
	Local _aArBAU	:= BAU->(GetArea())
	Local _aArSA2	:= SA2->(GetArea())
	
	//-----------------------------------------------------
	//Conforme visto, a rotina padrão esta incluindo
	//de forma errada o CPF na BAU
	//-----------------------------------------------------
	DbSelectArea("BAU")
	DbSetOrder(6) //BAU_FILIAL+BAU_CODSA2+BAU_LOJSA2
	If DbSeek(xFilial("BAU") + M->A2_COD + M->A2_LOJA)
		
		Reclock("BAU", .F.)
		
		BAU->BAU_CPFCGC := M->A2_CGC
		
		BAU->(MsUnLock())
		
	EndIf
	
	RestArea(_aArSA2)
	RestArea(_aArBAU)
	RestArea(_aArea)
	
Return
