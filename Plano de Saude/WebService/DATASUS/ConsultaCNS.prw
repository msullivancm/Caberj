#INCLUDE "PROTHEUS.CH"
#INCLUDE "XMLCSVCS.CH"

/*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | ConDtSus | Autor | Mateus Medeiros 						   |*
*+------------+------------------------------------------------------------+*
*|Data        | 05.09.2017                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Consome ws e consulta serviço DataSus, através de parâmetros  |*
*|            | passados - Consulta CNS                                    |*
*+------------+------------------------------------------------------------+*
*|Solicitante | 			                                               |*
*+------------+------------------------------------------------------------+*
*****************************************************************************/

/*/{Protheus.doc} Nucleo
//TODO Descrição Consome e realiza a execução do webservice para integração com o DataSus
@author mateus.muniz
@since 06/09/2017
@version 1.0

@type function
/*/

User function ConsCNS(_cCpf,_cNome,_cMae)
    
	Local oWsdl 	:= Nil
    
//    Local cMetodo := "pesquisar" //Metodo Utilizado
	Local cMetodo   := "pesquisar" //Metodo Utilizado
	Local cEnd	    := "https://servicos.saude.gov.br/cadsus/CadsusService/v5r0?wsdl" // SuperGetMv("MV_XWSNUC1",,"https://servicos.saude.gov.br/cadsus/CadsusService/v5r0?wsdl")
	Local cErro		:= ""
	Local cAviso 	:= ""
	Local _cTmp 	:= ''
	Local lSend     := .F.
	Local aServico	:= {}
	Local aMetodos 	:= {}
	Local aRet		:= {}
	Local cFalha    := ""
	Local __XMLHeadRet  := nil
    
	Default _cNome 		:= Nil
	Default  _cCpf  	:= Nil
	Default  _cMae   	:= Nil
    
	//RpcSetEnv("01")
    // ----------------------------------------------------------------------------------------
    // Cria o objeto da classe TWsdlManager
    // ----------------------------------------------------------------------------------------
	oWsdl := TWsdlManager():New()
    // oWsdl:lProcResp := .F.
    // ----------------------------------------------------------------------------------------
    //Habilita no comando SOAP de envio os atributos opcionais.
    // ----------------------------------------------------------------------------------------
	oWsdl:lEnableOptAttr := .T.
    // ----------------------------------------------------------------------------------------
    // Define se vai usar prefixo de namespace antes dos nomes das tags na mensagem
    // SOAP que será enviada.
    // ----------------------------------------------------------------------------------------
	oWsdl:lUseNSPrefix   := .T.
    // ----------------------------------------------------------------------------------------
    // Define se vai verificar as ocorrências dos parâmetros de entrada
    // da mensagem SOAP que será enviada, quando essa não for uma mensagem personalizada.
    // ----------------------------------------------------------------------------------------
	oWsdl:lCheckInput := .T.
    // ----------------------------------------------------------------------------------------
    //Define se fará a conexão SSL com o servidor de forma anônima, ou seja,
    // sem verificação de certificados ou chaves.
    // ----------------------------------------------------------------------------------------
	oWsdl:lSSLInsecure := .T.
    
    //oWsdl:nTimeout :=  5
    
	ProcRegua(2)
    // ----------------------------------------------------------------------------------------
    // Obtém status de sucesso (.T.) ou falha (.F.) da operação realizada.
    // ----------------------------------------------------------------------------------------
	If oWsdl:lStatus
		MsgAlert( "Erro ao instanciar Ws Endereço: "+cEnd,Funname() )
		Return {aRet,cFalha}
	EndIf
    
    // ----------------------------------------------------------------------------------------
    // Faz o parse de uma URL
    // ----------------------------------------------------------------------------------------
    //If !oWsdl:ParseURL( cEnd )// == .F.
	QOut("Parse Entrada "+Time())
    
	if !oWsdl:ParseFile( "\datasus\cns.wsdl" )
		MsgAlert( "Erro ao realizar ParseXml Endereço: "+cEnd+" - "+oWsdl:cError,Funname() )
		Return {aRet,cFalha}
	EndIf
    
	QOut("Parse Saída"+Time())
    
    /*oWsdl:SetAuthentication("CADSUS.CNS.PDQ.PUBLICO","kUXNmiiii#RDdlOELdoe00966" )
    oWsdl:SetCredentials("CADSUS.CNS.PDQ.PUBLICO","kUXNmiiii#RDdlOELdoe00966" )
    oWsdl:GetAuthentication( "CADSUS.CNS.PDQ.PUBLICO", "kUXNmiiii#RDdlOELdoe00966" )
    */
	IncProc("Conectando ao Nucleo... Aguarde...")
    //--------------------------------------------------------
    // lista os serviços que tem no wsdl
    //--------------------------------------------------------
	aServico := oWsdl:GetServices()
	If Len(aServico) == 0
		MsgAlert("Erro ao listar serviços: "+cEnd,Funname())
		Return {aRet,cFalha}
	Endif
    
    //--------------------------------------------------------
    // Lista as operações definidas. Passo opcional.
    //--------------------------------------------------------
	aMetodos := oWsdl:ListOperations()
    
	if Len( aMetodos ) == 0 .AND. Ascan(aMetodos, { |X| X[1] == cMetodo}) == 0
		MsgAlert( "Erro ao listar Métodos: " + oWsdl:cError,Funname() )
		Return {aRet,cFalha}
	endif
//    /PRPA_IN201305UV02
    //--------------------------------------------------------
    // Define a operação / método
    //--------------------------------------------------------
	If  oWsdl:SetOperation( aMetodos[Ascan(aMetodos, { |X| X[1] == cMetodo})][1] )
        
        //--------------------------------------------------------
        //Monta XML para envio no método SendSoapMsg
        //--------------------------------------------------------
      	/*_cNome 		:= 'MATEUS MEDEIROS MUNIZ' // comentar após virada
		_cCpf  		:= ''                // comentar
        _cMae       := 'LUCIMAR DE MEDEIROS MUNIZ'*/
		cXml := MontaXml(_cNome,_cCpf,_cMae)
        //--------------------------------------------------------
        //Envio o documento SOAP gerado ao WS.
        //--------------------------------------------------------
		lSend  		:= oWsdl:SendSoapMsg(cXml)
        //--------------------------------------------------------
        //Retorno no formato XML
        //--------------------------------------------------------
		cSoapResp   := oWsdl:GetSoapResponse()
        //   teste := oWsdl:GetParsedResponse()
        //--------------------------------------------------------
        // Valida a ocorrencia de Erro na Resposta do XML
        // devido a inconsistência na montagem de retorno da  WSDL
        //--------------------------------------------------------
		nValid 		:= at("fault", lower(cSoapResp) )
        
        //	If !lSend .and. nValid > 0
        //		MsgAlert( "Erro: " + oWsdl:cError,Funname() )
        //		Return _cTmp
        //	endif
        
		If !EMPTY(cSoapResp)
         //   cSoapResp := strtran(cSoapResp,"!","")
         //   cSoapResp := alltrim(strtran(cSoapResp,'<?xml version="1.0" encoding="UTF-8"?>',''))
            //---------------------------------------------------
            // Bloco Abaixo fará o tratamento do xml retornado
            //---------------------------------------------------
			oXml := XmlParser(cSoapResp,"",@cErro,@cAviso)
			If ValType(oXml) == "O"
				oXml2 := XmlChildEx(oXml , "_SOAP_ENVELOPE")
				If ValType(oXml2)== "O"
					oXml3 := XmlChildEx(oXml2, "_S_BODY")
					If ValType(oXml3) == "O"
						oXml2 := XmlChildEx(oXml3, "_CAD_RESPONSEPESQUISAR")
						If ValType(oXml2) == "O"
							oXml3 := XmlChildEx(oXml2, "_RES_RESULTADOPESQUISA")
							If ValType(oXml3)== "O"
                                //Realiza o Tratamento necessario
                                // Coloca em variaveis os dados retornados pelo serviço DataSus
								_cCNS 	  := iif(TYPE("oXml3:_NS18_CNS:_NS4_NUMEROCNS:TEXT") <> 'U',oXml3:_NS18_CNS:_NS4_NUMEROCNS:TEXT,'')  
								_cDtNasc  := iif(TYPE("oXml3:_NS18_DATANASCIMENTO:TEXT") <> 'U',oXml3:_NS18_DATANASCIMENTO:TEXT,'') 
								_nPGrauQld:= iif(TYPE("oXml3:_NS18_GRAUQUALIDADE:_NS21_PERCENTUALQUALIDADE:TEXT") <> 'U',oXml3:_NS18_GRAUQUALIDADE:_NS21_PERCENTUALQUALIDADE:TEXT,'')  
								_cNumIdCrp:= iif(TYPE("oXml3:_NS18_IDENTIFICADORCORPORATIVO:_NS2_NUMEROIDENTIFICADORCORPORATIVO:TEXT") <> 'U',oXml3:_NS18_IDENTIFICADORCORPORATIVO:_NS2_NUMEROIDENTIFICADORCORPORATIVO:TEXT,'') 
								_cNomeMae := iif(TYPE("oXml3:_NS18_MAE:_NS11_NOME:TEXT") <> 'U',oXml3:_NS18_MAE:_NS11_NOME:TEXT,'') 
								_cCodMun  := iif(TYPE("oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_CODIGOMUNICIPIO:TEXT") <> 'U',oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_CODIGOMUNICIPIO:TEXT,'') 
								_cNomeMun := iif(TYPE("oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_NOMEMUNICIPIO:TEXT") <> 'U',oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_NOMEMUNICIPIO:TEXT,'')  
								_cCodUF	  := iif(TYPE("oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_UF:_NS16_CODIGOUF:TEXT") <> 'U',oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_UF:_NS16_CODIGOUF:TEXT,'') 
								_cUF	  := iif(TYPE("oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_UF:_NS16_SIGLAUF:TEXT") <> 'U',oXml3:_NS18_MUNICIPIONASCIMENTO:_NS15_UF:_NS16_SIGLAUF:TEXT,'')
								_cNmComple:= iif(TYPE("oXml3:_NS18_NOMECOMPLETO:_NS11_NOME:TEXT") <> 'U',oXml3:_NS18_NOMECOMPLETO:_NS11_NOME:TEXT,'') 
								_cNomePai := iif(TYPE("oXml3:_NS18_PAI:_NS11_NOME:TEXT") <> 'U',oXml3:_NS18_PAI:_NS11_NOME:TEXT,'') 
								_cPais    := iif(TYPE("oXml3:_NS18_PAISNASCIMENTO:_NS20_CODIGOPAIS:TEXT") <> 'U',oXml3:_NS18_PAISNASCIMENTO:_NS20_CODIGOPAIS:TEXT,'') 
								_cDescPais:= iif(TYPE("oXml3:_NS18_PAISNASCIMENTO:_NS20_NOMEPAIS:TEXT") <> 'U',oXml3:_NS18_PAISNASCIMENTO:_NS20_NOMEPAIS:TEXT,'') 
								_cCodSexo := iif(TYPE("oXml3:_NS18_SEXO:_NS19_CODIGOSEXO:TEXT") <> 'U',oXml3:_NS18_SEXO:_NS19_CODIGOSEXO:TEXT,'') 
								_cSituacao:= iif(TYPE("oXml3:_NS18_SITUACAO:TEXT") <> 'U',oXml3:_NS18_SITUACAO:TEXT,'') 
                                
								AAdd(aRet,{_cCNS		,; // 1
								_cDtNasc 	,; // 2
								_nPGrauQld	,; // 3
								_cNumIdCrp	,; // 4
								_cNomeMae	,; // 5
								_cCodMun	,; // 6
								_cNomeMun	,; // 7
								_cCodUF		,; // 8
								_cUF		,; // 9
								_cNmComple	,; // 10
								_cNomePai	,; // 11
								_cPais		,; // 12
								_cDescPais	,; // 13
								_cCodSexo	,; // 14
								_cSituacao	;  // 15
								})
							else
								MsgAlert("Não foi possivel encontrar Nó _RES_RESULTADOPESQUISA")
							Endif
                            
						Else
                            
							if nValid == 0
								lRet := .F.
								cFalha := "Não foi possivel encontrar dados de CNS com os parâmetros informados."
								MsgAlert("Não foi possivel encontrar dados de CNS com os parâmetros informados.")
							else
                                //caso o serviço retorne erro
								oXml2 := XmlChildEx(oXml3, "_S_FAULT")
								If ValType(oXml2) == "O"
									lRet := .F.
									cFalha := iif(TYPE("oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT") <> 'U',oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT,'')  
									MsgAlert(iif(TYPE("oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT") <> 'U',oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT,''))
								endif
							endif
                            
						Endif
					Else
                        
                        //caso o serviço retorne erro
						oXml2 := XmlChildEx(oXml3, "_S_FAULT")
						If ValType(oXml2) == "O"
							lRet := .F.
							cFalha := iif(TYPE("oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT") <> 'U',oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT,'') 
							MsgAlert(iif(TYPE("oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT") <> 'U',oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT,''))
						endif
                        //  MsgAlert("Não foi possivel encontrar Nó _S_BODY")
					EndIf
				Else
                    //caso o serviço retorne erro
					lRet := .F.
					cFalha := "CNS não encontrado com os parâmetros informados."
                    
					MsgAlert("Não foi possivel encontrar Nó _SOAP_ENVELOPE")
				EndIf
			Else
				lRet := .F.
				cFalha := "Estabelecimento não encontrado com os parâmetros informados."
                
				MsgAlert("Não foi possivel encontrar Nó _SOAP_ENVELOPE")
			EndIf
		Else
			lRet := .F.
			cFalha := "Estabelecimento não encontrado com os parâmetros informados."
            
			MsgAlert("Erro no Parser XML "+cErro)
		EndIf
        
	Else
		MsgAlert("Erro ao Definir Método "+cMetodo)
	Endif
   
   oXml := nil
   oXml2 := nil  
   oXml3 := nil
    
Return {aRet,cFalha}


Static Function MontaXml(cNome,_cCpf,_cMae)
    
	Local _cUsrCNS		:= SuperGetMv("MV_XCNUSR"  ,,"CADSUS.ANS.CABERJ.RJ")
	Local _cPassWd		:= SuperGetMv("MV_XPASUSR",,"Y_*27*uL87-9*5NvPn*uCW_53Kppjy")
    Local cMsg   		:= ''
    
    
	cMsg += '     <soap:Envelope
	cMsg += ' xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
	cMsg += ' xmlns:cad="http://servicos.saude.gov.br/cadsus/v5r0/cadsusservice"
	cMsg += ' xmlns:cnes="http://servicos.saude.gov.br/wsdl/mensageria/v5r0/cnesusuario"
	cMsg += ' xmlns:fil="http://servicos.saude.gov.br/wsdl/mensageria/v5r0/filtropesquisa"
	cMsg += ' xmlns:nom="http://servicos.saude.gov.br/schema/corporativo/pessoafisica/v1r2/nomecompleto"
	cMsg += ' xmlns:nom1="http://servicos.saude.gov.br/schema/corporativo/pessoafisica/v1r0/nomefamilia"
	cMsg += ' xmlns:cpf="http://servicos.saude.gov.br/schema/corporativo/documento/v1r2/cpf"
	cMsg += ' xmlns:mun="http://servicos.saude.gov.br/schema/corporativo/v1r2/municipio"
	cMsg += ' xmlns:uf="http://servicos.saude.gov.br/schema/corporativo/v1r1/uf"
	cMsg += ' xmlns:tip="http://servicos.saude.gov.br/schema/corporativo/documento/v5r0/tipodocumento">
	cMsg += ' 	<soap:Header>
	cMsg += ' 	  <wsse:Security soap:mustUnderstand="1"
	cMsg += ' 	  xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
	cMsg += ' 	  xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
	cMsg += ' 	  <wsse:UsernameToken wsu:Id="UsernameToken-F6C95C679D248B6E3F143032021465917">
	cMsg += ' 	  <wsse:Username>CADSUS.ANS.CABERJ.RJ</wsse:Username>
	cMsg += ' 	  <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">Y_*27*uL87-9*5NvPn*uCW_53Kppjy</wsse:Password>
	cMsg += ' 	  </wsse:UsernameToken>
	cMsg += ' 	  </wsse:Security>
	cMsg += '   </soap:Header>
	cMsg += '  <soap:Body>
	cMsg += '    <cad:requestPesquisar>
	cMsg += '       <cnes:CNESUsuario>
	cMsg += '        <cnes:CNES>6963447</cnes:CNES>
	cMsg += '       <cnes:Usuario>LEONARDO</cnes:Usuario>
	cMsg += '       <!--Optional:-->
	cMsg += '       <cnes:Senha>?</cnes:Senha>
	cMsg += '   </cnes:CNESUsuario>
	cMsg += '   <fil:FiltroPesquisa>
	if !Empty(_cCpf)
		cMsg += '            <fil:CPF>
		cMsg += '               <cpf:numeroCPF>'+cvaltochar(_cCpf)+'</cpf:numeroCPF>
		cMsg += '            </fil:CPF>
	endif
	cMsg += '   <!--Optional:-->
           
	if !Empty(cNome)
		cMsg += '   		<fil:nomeCompleto>
		cMsg += '            <nom:Nome>'+cvaltochar(cNome)+'</nom:Nome>
		cMsg += '         </fil:nomeCompleto>
	endif
            
	if !Empty(_cMae)
		cMsg += '          <fil:Mae>'
		cMsg += '    		    <nom:Nome>'+cvaltochar(_cMae)+'</nom:Nome> '
		cMsg += '          </fil:Mae> '
	endif
	cMsg += '             <fil:tipoPesquisa>IDENTICA</fil:tipoPesquisa>
	cMsg += '          </fil:FiltroPesquisa>
	cMsg += '          <cad:higienizar>0</cad:higienizar>
	cMsg += '       </cad:requestPesquisar>
	cMsg += '    </soap:Body>
	cMsg += ' </soap:Envelope>
    
    
Return cMsg
