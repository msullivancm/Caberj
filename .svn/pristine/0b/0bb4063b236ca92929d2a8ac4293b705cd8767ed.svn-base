#include 'protheus.ch'
#include 'restful.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ WS013    ºAutor  ³ Frederico O. C. Jr º Data ³  11/11/2022 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  WebService para gravar log de e-mails disparados na web	  º±±
±±ºDesc.     ³										                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 					                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
WSRESTFUL email_caberj DESCRIPTION "Web Service para controle dos envios de e-mails ou seu log de envio" FORMAT "application/json"

	WSDATA Destinatario			AS CARACTER OPTIONAL
	WSDATA Copia				AS CARACTER OPTIONAL
	WSDATA CopiaOculta			AS CARACTER OPTIONAL
	WSDATA Assunto				AS CARACTER OPTIONAL
	WSDATA Mensagem				AS CARACTER OPTIONAL
	WSDATA DiretorioAnexo		AS CARACTER OPTIONAL
	WSDATA ListaAnexos			AS CARACTER OPTIONAL
	WSDATA Remetente			AS CARACTER OPTIONAL
	WSDATA Mascara				AS CARACTER OPTIONAL
	WSDATA UsaTLS				AS BOOLEAN	OPTIONAL
	WSDATA UsaSSL				AS BOOLEAN	OPTIONAL
	WSDATA RequerAutenticacao	AS BOOLEAN	OPTIONAL
	WSDATA Enviado				AS BOOLEAN	OPTIONAL
	WSDATA ErroEnvio			AS CARACTER OPTIONAL
	WSDATA Rotina				AS CARACTER OPTIONAL
	WSDATA Protocolo			AS CARACTER OPTIONAL
	WSDATA Matricula			AS CARACTER OPTIONAL
	WSDATA RDA					AS CARACTER OPTIONAL
	WSDATA GrupoEmpresa			AS CARACTER OPTIONAL
	WSDATA Fornecedor			AS CARACTER OPTIONAL
	WSDATA Corretor				AS CARACTER OPTIONAL
	
	WSMETHOD POST envia_email ;
		Description "Metodo para envio de e-mail atraves do Web Service Protheus";
		WSSYNTAX "/envia_email";
		PATH "/envia_email";
		PRODUCES APPLICATION_JSON

	WSMETHOD POST insere_log_email ;
		Description "Metodo para a criacao de um log de e-mail enviado pela web";
		WSSYNTAX "/insere_log_email";
		PATH "/insere_log_email";
		PRODUCES APPLICATION_JSON

END WSRESTFUL


//-------------------------------------------------------------------
// Método POST para incluir o log do e-mail
//-------------------------------------------------------------------
WSMETHOD POST envia_email WSREST email_caberj

Local aArea			:= GetArea()
Local lRet			:= .T.
Local oEmail		:= JsonObject():New()
Local uAux
Local aControle		:= {}
Local aAnexos		:= {}
Local cRestWS		:= ""
Local aRetMail		:= {}
Local nI			:= 0
Local lAnexo		:= .F.

Local cDestin		:= ""
Local cCopia		:= ""
Local cCopiaOc		:= ""
Local cAssunto		:= ""
Local cMensag		:= ""
Local cDirAnex		:= ""
Local cAuxAnex		:= ""
Local cRemete		:= ""
Local cMascara		:= ""
Local lUsaTLS		:= .T.
Local lUsaSSL		:= .T.
Local lReqAut		:= .T.
Local cRotina		:= ""
Local cProtoc		:= ""
Local cMatric		:= ""
Local cRDA			:= ""
Local cGrupo		:= ""
Local cFornec		:= ""
Local cCorretor		:= ""

Self:SetContentType("application/json")

uAux	:= oEmail:fromJson( self:getContent() )		// Converte o Json vindo do serviço

if valtype(uAux) == "U"								// Valida se a estrutura foi convertida

	//RpcSetType(3)
	//RpcSetEnv('01', '01',,,'PLS',,)

	cDestin		:= oEmail["Destinatario"]
	cCopia		:= oEmail["Copia"]
	cCopiaOc	:= oEmail["CopiaOculta"]
	cAssunto	:= oEmail["Assunto"]
	cMensag		:= oEmail["Mensagem"]
	cDirAnex	:= oEmail["DiretorioAnexo"]
	cAuxAnex	:= oEmail["ListaAnexos"]
	cRemete		:= oEmail["Remetente"]
	cMascara	:= oEmail["Mascara"]
	lUsaTLS		:= oEmail["UsaTLS"]
	lUsaSSL		:= oEmail["UsaSSL"]
	lReqAut		:= oEmail["RequerAutenticacao"]
	cRotina		:= oEmail["Rotina"]
	cProtoc		:= oEmail["Protocolo"]
	cMatric		:= oEmail["Matricula"]
	cRDA		:= oEmail["RDA"]
	cGrupo		:= oEmail["GrupoEmpresa"]
	cFornec		:= oEmail["Fornecedor"]
	cCorretor	:= oEmail["Corretor"]

	// Tratamento dos parametros de entrada (se vieram - se são válidos)
	if valtype(cDestin) == "C"
		if empty(cDestin)
			lRet	:= .F.
			cRestWS	:= "Destinatario nao informado"
		endif
	else
		lRet	:= .F.
		cRestWS	:= "Destinatario nao informado"
	endif

	if valtype(cAssunto) == "C"
		if empty(cAssunto)
			lRet	:= .F.
			cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Assunto nao informado"
		endif
	else
		lRet	:= .F.
		cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Assunto nao informado"
	endif

	if valtype(cMensag) == "C"
		if empty(cMensag)
			lRet	:= .F.
			cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Mensagem nao informada"
		endif
	else
		lRet	:= .F.
		cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Mensagem nao informada"
	endif

	if valtype(cDirAnex) == "C"
		cDirAnex	:= StrTran(cDirAnex, "/", "\")
	else
		cDirAnex	:= ""
	endif

	if valtype(cAuxAnex) == "C"
		aAnexos := StrTokArr2(cAuxAnex, ';')
	endif

	if !empty(cDirAnex) .and. len(aAnexos) > 0

		for nI := 1 to len(aAnexos)

			if file( cDirAnex + aAnexos[nI] )
				aAnexos[nI]	:= cDirAnex + aAnexos[nI]
			else
				lAnexo		:= .T.
			endif

		next

		if lAnexo
			lRet	:= .F.
			cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Arquivo(s) informado(s) nao localizados no diretorio"
		endif

	elseif !empty(cDirAnex) .and. len(aAnexos) == 0
		lRet	:= .F.
		cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Diretorio do anexo informado, mas sem arquivo(s)"
	elseif (empty(cDirAnex) .and. len(aAnexos) > 0)
		lRet	:= .F.
		cRestWS	+= iif( empty(cRestWS), "", CHR(13)+CHR(10) ) + "Diretorio do anexo nao informado, mas com arquivo(s)"
	endif

	if lRet

		aControle	:= {cRotina, cProtoc, cMatric, cRDA, cGrupo, cFornec, cCorretor}

		aRetMail := U_CabEmail(cDestin, cCopia, cCopiaOc, cAssunto, cMensag, aAnexos, cRemete, cMascara, .T., lUsaTLS, lUsaSSL, lReqAut, aControle)

		if aRetMail[1]
			cRestWS	:= "E-mail enviado com sucesso"
		else
			cRestWS	:= "E-mail nao pode ser enviado: " + AllTrim(aRetMail[2])
		endif

	endif

	//RpcClearEnv()

else
	cRestWS	:= "Erro na validacao da estrutura da requisicao"
endif

::SetResponse(EncodeUTF8( cRestWS ))

RestArea(aArea)

return .T.


//-------------------------------------------------------------------
// Método POST para incluir o log do e-mail
//-------------------------------------------------------------------
WSMETHOD POST insere_log_email WSREST email_caberj

Local aArea			:= GetArea()
Local lRet			:= .T.
Local oEmail		:= JsonObject():New()
Local uAux
Local aControle		:= {}
Local aAnexos		:= {}
Local cRestWS		:= ""

Local cDestin		:= ""
Local cCopia		:= ""
Local cCopiaOc		:= ""
Local cAssunto		:= ""
Local cMensag		:= ""
Local cAuxAnex		:= ""
Local cRemete		:= ""
Local lEnviado		:= ""
Local cErroEnv		:= ""
Local cRotina		:= ""
Local cProtoc		:= ""
Local cMatric		:= ""
Local cRDA			:= ""
Local cGrupo		:= ""
Local cFornec		:= ""
Local cCorretor		:= ""

Self:SetContentType("application/json")

uAux	:= oEmail:fromJson( self:getContent() )		// Converte o Json vindo do serviço

if valtype(uAux) == "U"								// Valida se a estrutura foi convertida

	cDestin		:= oEmail["Destinatario"]
	cCopia		:= oEmail["Copia"]
	cCopiaOc	:= oEmail["CopiaOculta"]
	cAssunto	:= oEmail["Assunto"]
	cMensag		:= oEmail["Mensagem"]
	cAuxAnex	:= oEmail["ListaAnexos"]
	cRemete		:= oEmail["Remetente"]
	lEnviado	:= oEmail["Enviado"]
	cErroEnv	:= oEmail["ErroEnvio"]
	cRotina		:= oEmail["Rotina"]
	cProtoc		:= oEmail["Protocolo"]
	cMatric		:= oEmail["Matricula"]
	cRDA		:= oEmail["RDA"]
	cGrupo		:= oEmail["GrupoEmpresa"]
	cFornec		:= oEmail["Fornecedor"]
	cCorretor	:= oEmail["Corretor"]

	// Tratamento dos parametros de entrada (se vieram - se são válidos)
	if valtype(cDestin) == "C"
		if empty(cDestin)
			lRet	:= .F.
		endif
	else
		lRet	:= .F.
	endif

	if valtype(cCopia) <> "C"
		cCopia		:= ""
	endif

	if valtype(cCopiaOc) <> "C"
		cCopiaOc	:= ""
	endif

	if valtype(cAssunto) == "C"
		if empty(cAssunto)
			lRet	:= .F.
		endif
	else
		lRet	:= .F.
	endif

	if valtype(cMensag) == "C"
		if empty(cMensag)
			lRet	:= .F.
		endif
	else
		lRet	:= .F.
	endif

	if valtype(cAuxAnex) == "C"
		aAnexos := StrTokArr2(cAuxAnex, ';')
	endif

	if valtype(cRemete) == "C"
		if empty(cRemete)
			lRet	:= .F.
		endif
	else
		lRet	:= .F.
	endif

	if valtype(cErroEnv) <> "C"
		cErroEnv	:= ""
	endif

	if valtype(lEnviado) <> "L"
		lEnviado	:= empty(cErroEnv)
	endif

	if valtype(cRotina) <> "C"
		cRotina		:= ""
	endif

	if valtype(cProtoc) <> "C"
		cProtoc		:= ""
	endif

	if valtype(cMatric) <> "C"
		cMatric		:= ""
	endif

	if valtype(cRDA) <> "C"
		cRDA		:= ""
	endif

	if valtype(cGrupo) <> "C"
		cGrupo		:= ""
	endif

	if valtype(cFornec) <> "C"
		cFornec		:= ""
	endif

	if valtype(cCorretor) <> "C"
		cCorretor	:= ""
	endif

	if lRet

		aControle	:= {cRotina, cProtoc, cMatric, cRDA, cGrupo, cFornec, cCorretor}

		U_CABA237B(cDestin, cCopia, cCopiaOc, cAssunto, cMensag, aAnexos, cRemete, aControle, lEnviado, cErroEnv)

		cRestWS	:= "Log gravado com sucesso"

	else
		cRestWS	:= "Dado obrigatorio nao informado"
	endif

else
	cRestWS	:= "Erro na validacao da estrutura da requisicao"
endif

::SetResponse(EncodeUTF8( cRestWS ))

RestArea(aArea)

return lRet
