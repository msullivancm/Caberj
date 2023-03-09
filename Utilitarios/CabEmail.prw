#include "rwmake.ch"
#include "protheus.ch"
#include "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ EnvEmail ºAutor  ³ Fred Junior        º Data ³  08/11/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³    Programa generico para envio de e-mail			 	  º±±
±±º          ³										                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ	                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CabEmail(cPara, cCc, cBCC, cAssunto, cCorpo, aAnexos, cFrom, cMascara, lBkGr, lUsaTLS, lUsaSSL, lAutent, aControle)

//------------------------------------------//
// aControle:	1: Rotina					//
//				2: Protocolo				//
//				3: Matricula				//
//				4: Cod. RDA					//
//				5: Grupo/Empresa			//
//				6: Cod./Loja Fornecedor		//
//				7: Corretor					//
//------------------------------------------//

Local aArea			:= GetArea()
Local lRet			:= .T.
Local oMsg			:= Nil
Local oSrv			:= Nil
Local nRet			:= 0
Local cSrvFull		:= Alltrim(GetMV("MV_RELSERV"))
Local cServer		:= iif(':' $ cSrvFull, SubStr(cSrvFull, 1, At(':', cSrvFull)-1), cSrvFull)
Local nPort			:= iif(':' $ cSrvFull, Val(SubStr(cSrvFull, At(':', cSrvFull)+1, Len(cSrvFull))), 25)
Local cUser			:= Alltrim(GetMV("MV_RELACNT"))		// SubStr(cUser, 1, At('@', cUser) - 1)
Local cPass			:= Alltrim(GetMV("MV_RELPSW" ))
Local nTimeOut		:= GetMV("MV_RELTIME")
Local nI			:= 0
Local lAttAnexo		:= .T.
Local lExiAnexo		:= .T.
Local lEnvMail		:= AllTrim(GetNewPar("MV_XEMAIL", "1")) == "1"
Local cError		:= ""
Local aAuxCtr		:= {"","","","","","",""}

// Segundo server de e-mail para envio em contingência (zimbra)
Local cSrv2SMTP		:= Alltrim(GetMV("MV_XRELSER"))
Local cServer2		:= iif(':' $ cSrv2SMTP, SubStr(cSrv2SMTP, 1, At(':', cSrv2SMTP)-1), cSrv2SMTP)
Local nPort2		:= iif(':' $ cSrv2SMTP, Val(SubStr(cSrv2SMTP, At(':', cSrv2SMTP)+1, Len(cSrv2SMTP))), 25)
Local cUser2		:= Alltrim(GetMV("MV_XRELCNT"))		// SubStr(cUser, 1, At('@', cUser) - 1)
Local cPass2		:= Alltrim(GetMV("MV_XRELPSW" ))
Local lUsaTLS2		:= GetMV("MV_XRELTLS")
Local lUsaSSL2		:= GetMV("MV_ZRELSSL")
Local lAutent2		:= GetMV("MV_XRELAUT")
Local cError2		:= ""
Local lReenv		:= .F.

Default cCc			:= ""
Default cBCC		:= ""
Default aAnexos		:= {}
Default lBkGr		:= IsBlind()
Default cFrom		:= Alltrim(GetMV("MV_RELACNT"))
Default cMascara	:= iif(cEmpAnt == '01', 'Caberj', 'Integral Saúde')
Default lUsaTLS		:= GetMV("MV_RELTLS")
Default lUsaSSL		:= GetMV("MV_RELSSL")
Default lAutent		:= GetMV("MV_RELAUTH")
Default aControle	:= {"","","","","","",""}

// Tratamento para parametros enviados em branco (ao invés de nulo para entrar no default) e/ou tipagem incorreta (evitando erro no e-mail)
if valtype(cPara) <> "C"
	cPara		:= ""
endif

if valtype(cCc) <> "C"
	cCc			:= ""
endif

if valtype(cBCC) <> "C"
	cBCC		:= ""
endif

if valtype(cAssunto) <> "C"
	cAssunto	:= ""
endif

if valtype(cCorpo) <> "C"
	cCorpo		:= ""
endif

if valtype(aAnexos) <> "A"
	aAnexos		:= {}
endif

if valtype(cFrom) <> "C"
	cFrom		:= Alltrim(GetMV("MV_RELACNT"))
elseif empty(cFrom)
	cFrom		:= Alltrim(GetMV("MV_RELACNT"))
endif

if valtype(cMascara) <> "C"
	cMascara	:= iif(cEmpAnt == '01', 'Caberj', 'Integral')
elseif empty(cMascara)
	cMascara	:= iif(cEmpAnt == '01', 'Caberj', 'Integral')
endif

if valtype(lBkGr) <> "L"
	lBkGr		:= IsBlind()
endif

if valtype(lUsaTLS) <> "L"
	lUsaTLS		:= GetMV("MV_RELTLS")
endif

if valtype(lUsaSSL) <> "L"
	lUsaSSL		:= GetMV("MV_RELSSL")
endif

if valtype(lAutent) <> "L"
	lAutent		:= GetMV("MV_RELAUTH")
endif

if valtype(aControle) <> "A"
	aControle	:= {"","","","","","",""}
endif

cMascara	:= StrTran(StrTran(cMascara, '"',''), "'", "")
cMascara	:= iif(!empty(cMascara), '"' + AllTrim(cMascara) + '" <' + AllTrim(cFrom) + ">", AllTrim(cFrom) )

for nI := 1 to len(aControle)
	if nI <= 7								// se passou a mais (retirar)
		if valtype(aControle[nI]) == "C"
			aAuxCtr[nI]	:= aControle[nI]
		else
			aAuxCtr[nI]	:= ""
		endif
	endif
next
aControle	:= aAuxCtr						// vetor correto atribuido no aAuxCtr

cPara	:= AllTrim(lower( cPara ))
cCc		:= AllTrim(lower(  cCc  ))
cBCC	:= AllTrim(lower( cBCC  ))

//--------------------------------------------------------------------------------------------------------------------------//
//														IMPORTANTE															//
//--------------------------------------------------------------------------------------------------------------------------//
// O usuário/senha seguirá vindo do parametro, visto que pode ter contas distintas. Mas o envio não é obrigatório, tendo 	//
//		no envio a identificação do usuário/senha generica de envio (MV_RELACNT/MV_RELPSW).									//
// As informações de necessita autenticação, usa TLS e SSL também não serão de envio obrigatório, vindo considera, senão	//
//		buscará dos parametros padrões do sistema (MV_RELAUTH, MV_RELTLS, MV_RELSSL)										//
//--------------------------------------------------------------------------------------------------------------------------//

if lEnvMail

	// Verifica se os parametros de envio de e-mail estão preenchidos
	if empty(cServer) .or. nPort == 0 .or. empty(cUser) .or. empty(cPass)
		lRet	:= .F.
		cError	:= "Não foram definidos os parâmetros do server do Protheus para envio de e-mail."
		if !lBkGr
			alert(cError)
		endif
	endif
	
	if lRet
	
		// Se tiver em branco os destinatários
		if empty(cPara)
			lRet	:= .F.
			cError	:= "Não foi definido nenhum destinatário para o envio do e-mail."
			if !lBkGr
				alert(cError)
			endif
		endif
		
		if lRet
		
			if empty(cAssunto) .or. empty(cCorpo)
				lRet	:= .F.
				cError	:= "Não foram definidos o Assunto e/ou o Corpo para o envio do e-mail."
				if !lBkGr
					alert(cError)
				endif
			endif
			
			if lRet

				oSrv	:= nil
				oMsg	:= nil
				
				// Cria servidor para disparo do e-Mail
				oSrv := TMailManager():New()
				
				// Define se irá utilizar o TLS
				if lUsaTLS
					oSrv:SetUseTLS( .T. )
				endif
				
				// Define se irá utilizar o SSL
				if lUsaSSL
					oSrv:SetUseSSL( .T. )
				endif
				
				// Inicializa conexão
				nRet := oSrv:Init("", cServer, cUser, cPass, 0, nPort)
				
				if nRet <> 0
					lRet	:= .F.
					cError	:= "Não foi possível inicializar o servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
					if !lBkGr
						alert(cError)
					endif
				endif
				
				if lRet
				
					// Define o time out
					nRet := oSrv:SetSMTPTimeout(nTimeOut)
					
					// Conecta no servidor
					nRet := oSrv:SMTPConnect()
					
					if nRet <> 0
						lRet	:= .F.
						cError	:= "Não foi possível conectar no servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
						if !lBkGr
							alert(cError)
						endif
					endif
					
					if lRet
					
						if lAutent	// Se o servidor necessita autenticação
						
							// Realiza a autenticação do usuário e senha
							nRet := oSrv:SmtpAuth(cUser, cPass)
							if nRet <> 0
								lRet	:= .F.
								cError	:= "Não foi possível autenticar no servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
								if !lBkGr
									alert(cError)
								endif
							endif
						
						endif
						
						if lRet
						
							// Cria a nova mensagem
							oMsg := TMailMessage():New()
							oMsg:Clear()
							
							// Define os atributos da mensagem
							oMsg:cFrom		:= cMascara
							oMsg:cTo		:= cPara
							oMsg:cCc		:= cCc
							oMsg:cBCC		:= cBCC
							oMsg:cSubject	:= cAssunto
							oMsg:cBody		:= cCorpo
							
							// Percorre os anexos
							for nI := 1 to len(aAnexos)

								lAttAnexo	:= .T.
								lExiAnexo	:= .T.

								// Se o arquivo existir
								if file( aAnexos[nI] )

									// Anexa o arquivo na mensagem de e-mail
									nRet := oMsg:AttachFile( aAnexos[nI] )

									if nRet <> 0
										lAttAnexo	:= .F.
									endif
								
								else
									lExiAnexo := .F.
								endif
							
							next

							if !lAttAnexo .or. !lExiAnexo
								lRet	:= .F.
								cError	:= "Houveram anexos que não foram encontrados e/ou não puderam ser anexados neste e-mail."

								/*
								if !lBkGr
									lRet := MsgYesNo("Houve(ram) problema(s) na inclusão de anexo(s). Deseja enviar o e-mail mesmo assim?")
								endif
								*/
							
							endif

							if lRet
							
								// Envia a mensagem
								nRet := oMsg:Send(oSrv)
								
								if nRet == 0

									U_CABA237B(cPara, cCc, cBCC, cAssunto, cCorpo, aAnexos, cFrom, aControle, .T., "1", cError, cError2)
								
								else

									lRet	:= .F.
									lReenv	:= .T.
									cError	:= "Não foi possível enviar a mensagem: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
									if !lBkGr
										alert(cError)
									endif
								
								endif
							
							endif
						
						endif
					
					endif
					
					// Disconecta do servidor
					nRet := oSrv:SMTPDisconnect()
				
				endif
			
			endif
		
		endif
	
	endif

	if !lRet .and. lReenv

		if !lBkGr
			MsgInfo("Houve um problema na tentativa de envio do e-mail. O sistema fará uma nova tentativa!")
		endif

		// Nova tentativa de envio do e-mail usando SMTP secundário
		lRet	:= .T.
		oSrv	:= nil
		oMsg	:= nil

		// Cria servidor para disparo do e-Mail
		oSrv := TMailManager():New()
		
		// Define se irá utilizar o TLS
		if lUsaTLS2
			oSrv:SetUseTLS( .T. )
		endif
		
		// Define se irá utilizar o SSL
		if lUsaSSL2
			oSrv:SetUseSSL( .T. )
		endif
		
		// Inicializa conexão
		nRet := oSrv:Init("", cServer2, cUser2, cPass2, 0, nPort2)
		
		if nRet <> 0
			lRet	:= .F.
			cError2	:= "Não foi possível inicializar o servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
			if !lBkGr
				alert(cError2)
			endif
		endif
		
		if lRet
		
			// Define o time out
			nRet := oSrv:SetSMTPTimeout(nTimeOut)
			
			// Conecta no servidor
			nRet := oSrv:SMTPConnect()
			
			if nRet <> 0
				lRet	:= .F.
				cError2	:= "Não foi possível conectar no servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
				if !lBkGr
					alert(cError2)
				endif
			endif
			
			if lRet
			
				if lAutent2	// Se o servidor necessita autenticação
				
					// Realiza a autenticação do usuário e senha
					nRet := oSrv:SmtpAuth(cUser2, cPass2)
					if nRet <> 0
						lRet	:= .F.
						cError2	:= "Não foi possível autenticar no servidor SMTP: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
						if !lBkGr
							alert(cError2)
						endif
					endif
				
				endif
				
				if lRet

					// Cria a nova mensagem
					oMsg := TMailMessage():New()
					oMsg:Clear()
					
					// Define os atributos da mensagem
					oMsg:cFrom		:= cMascara
					oMsg:cTo		:= cPara
					oMsg:cCc		:= cCc
					oMsg:cBCC		:= cBCC
					oMsg:cSubject	:= cAssunto
					oMsg:cBody		:= cCorpo
					
					// Percorre os anexos
					for nI := 1 to len(aAnexos)

						lAttAnexo	:= .T.
						lExiAnexo	:= .T.

						// Se o arquivo existir
						if file( aAnexos[nI] )

							// Anexa o arquivo na mensagem de e-mail
							nRet := oMsg:AttachFile( aAnexos[nI] )

							if nRet <> 0
								lAttAnexo	:= .F.
							endif
						
						else
							lExiAnexo := .F.
						endif
					
					next

					if !lAttAnexo .or. !lExiAnexo
						lRet	:= .F.
						cError	:= "Houveram anexos que não foram encontrados e/ou não puderam ser anexados neste e-mail."

						/*
						if !lBkGr
							lRet := MsgYesNo("Houve(ram) problema(s) na inclusão de anexo(s). Deseja enviar o e-mail mesmo assim?")
						endif
						*/
					
					endif

					if lRet

						// Toda a montagem da mensagem já foi feita no primeiro passo (não preciso efetuar de novo) - somente tento o envio usando o novo server
						nRet := oMsg:Send(oSrv)
						
						if nRet == 0

							U_CABA237B(cPara, cCc, cBCC, cAssunto, cCorpo, aAnexos, cFrom, aControle, .T., "2", cError, cError2)
						
						else

							lRet	:= .F.
							cError2	:= "Não foi possível enviar a mensagem: " + AllTrim(oSrv:GetErrorString(nRet)) + "."
							if !lBkGr
								alert(cError2)
							endif
						
						endif

					endif
				
				endif
			
			endif
			
			// Disconecta do servidor
			nRet := oSrv:SMTPDisconnect()
		
		endif
	
	endif

else

	lRet	:= .F.
	cError	:= "O envio de e-mails pelo Protheus foi desativado. Por favor entrar em contato com o Suporte Protheus!"
	if !lBkGr
		MsgInfo(cError, "Alert: MV_XEMAIL")
	endif

endif

if !lRet

	// Grava log do envio sem sucesso (nas 2 tentativas)
	U_CABA237B(cPara, cCc, cBCC, cAssunto, cCorpo, aAnexos, cFrom, aControle, .F., "0", cError, cError2)

endif

RestArea(aArea)

return {lRet, cError}
