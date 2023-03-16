#include 'protheus.ch'
#include 'parmtype.ch'

/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descri��o 	Realiza a chamada do Servico do CFM (Conselho Federal de Medicina),
j� alimentando as variav�is e retornando um vetor

---------------------------------------------------------------------------------- */
user function Conspf(nCRM,cUF)
    
	Local oWsdl 	:= Nil
    
//    Local cMetodo := "pesquisar" //Metodo Utilizado
	Local cMetodo   := "consultar" //Metodo Utilizado
	Local cEnd	    := "https://ws.cfm.org.br:8080/WebServiceConsultaMedicos/ServicoConsultaMedicos?wsdl" // SuperGetMv("MV_XWSNUC1",,"https://servicos.saude.gov.br/cadsus/CadsusService/v5r0?wsdl")
	Local cErro		:= ""
	Local cAviso 	:= ""
	Local _cTmp 	:= ''
	Local lSend     := .F.
	Local aServico	:= {}
	Local aMetodos 	:= {}
	Local aRet		:= {}
	Local cFalha    := ""
	Local __XMLHeadRet  := nil
    Local cChave := '' // SuperGetMv("MV_XCHVWS",,"VLAEI9WT"	) 
    
	Default nCRM 		:= Nil
	Default cUF  	:= Nil
	
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
    // SOAP que ser� enviada.
    // ----------------------------------------------------------------------------------------
	oWsdl:lUseNSPrefix   := .T.
    // ----------------------------------------------------------------------------------------
    // Define se vai verificar as ocorr�ncias dos par�metros de entrada
    // da mensagem SOAP que ser� enviada, quando essa n�o for uma mensagem personalizada.
    // ----------------------------------------------------------------------------------------
	oWsdl:lCheckInput := .T.
    // ----------------------------------------------------------------------------------------
    //Define se far� a conex�o SSL com o servidor de forma an�nima, ou seja,
    // sem verifica��o de certificados ou chaves.
    // ----------------------------------------------------------------------------------------
	oWsdl:lSSLInsecure := .T.
    
    //oWsdl:nTimeout :=  5
    
	ProcRegua(2)
    // ----------------------------------------------------------------------------------------
    // Obt�m status de sucesso (.T.) ou falha (.F.) da opera��o realizada.
    // ----------------------------------------------------------------------------------------
	If oWsdl:lStatus
		MsgAlert( "Erro ao instanciar Ws Endere�o: "+cEnd,Funname() )
		Return {aRet,cFalha}
	EndIf
    
    // ----------------------------------------------------------------------------------------
    // Faz o parse de uma URL
    // ----------------------------------------------------------------------------------------
    //If !oWsdl:ParseURL( cEnd )// == .F.
	QOut("Parse Entrada "+Time())
    
	if !oWsdl:ParseFile( "\datasus\crm.wsdl" )
		MsgAlert( "Erro ao realizar ParseXml Endere�o: "+cEnd+" - "+oWsdl:cError,Funname() )
		Return {aRet,cFalha}
	EndIf
    
	QOut("Parse Sa�da"+Time())
    
  	IncProc("Conectando ao Nucleo... Aguarde...")
    //--------------------------------------------------------
    // lista os servi�os que tem no wsdl
    //--------------------------------------------------------
	aServico := oWsdl:GetServices()
	If Len(aServico) == 0
		MsgAlert("Erro ao listar servi�os: "+cEnd,Funname())
		Return {aRet,cFalha}
	Endif
    
    //--------------------------------------------------------
    // Lista as opera��es definidas. Passo opcional.
    //--------------------------------------------------------
	aMetodos := oWsdl:ListOperations()
    
	if Len( aMetodos ) == 0 .AND. Ascan(aMetodos, { |X| Upper(X[1]) == Upper(cMetodo)}) == 0
		MsgAlert( "Erro ao listar M�todos: " + oWsdl:cError,Funname() )
		Return {aRet,cFalha}
	endif
//    /PRPA_IN201305UV02
    //--------------------------------------------------------
    // Define a opera��o / m�todo
    //--------------------------------------------------------
	If  oWsdl:SetOperation( aMetodos[Ascan(aMetodos, { |X| Upper(X[1]) == upper(cMetodo)})][1] )
        
        //--------------------------------------------------------
        //Monta XML para envio no m�todo SendSoapMsg
        //--------------------------------------------------------
        cCrm := cvaltochar(nCRM)
        //cUf := "RJ"
        cChave :=  SuperGetMv("MV_XCHVWS",,"VLAEI9WT"	)
		cXml := MontaXml(cCrm,cChave,cUf)
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
        // devido a inconsist�ncia na montagem de retorno da  WSDL
        //--------------------------------------------------------
		nValid 		:= at("fault", lower(cSoapResp) )
        
        //	If !lSend .and. nValid > 0
        //		MsgAlert( "Erro: " + oWsdl:cError,Funname() )
        //		Return _cTmp
        //	endif
        
		If !EMPTY(cSoapResp)
            //---------------------------------------------------
            // Bloco Abaixo far� o tratamento do xml retornado
            //---------------------------------------------------
			oXml := XmlParser(cSoapResp,"",@cErro,@cAviso)
			If ValType(oXml) == "O"
				oXml2 := XmlChildEx(oXml , "_SOAP_ENVELOPE")
				If ValType(oXml2)== "O"
					oXml3 := XmlChildEx(oXml2, "_SOAP_BODY")
					If ValType(oXml3) == "O"
						oXml2 := XmlChildEx(oXml3, "_NS2_CONSULTARRESPONSE")
						If ValType(oXml2) == "O"
							oXml3 := XmlChildEx(oXml2, "_DADOSMEDICO")
							If ValType(oXml3)== "O"
                                //Realiza o Tratamento necessario
                                // Coloca em variaveis os dados retornados pelo servi�o DataSus
								_cCRM 	  := iif(type("oXml3:_CRM:TEXT") == "C",oXml3:_CRM:TEXT,"") 
								_cDtAtua  := iif(type("oXml3:_DATAATUALIZACAO:TEXT") == "C",oXml3:_DATAATUALIZACAO:TEXT,"")  
								_cEspecial:= iif(type("oXml3:_ESPECIALIDADE:TEXT") == "C",oXml3:_ESPECIALIDADE:TEXT,"")
								_cNome    := iif(type("oXml3:_NOME:TEXT") == "C",upper(oXml3:_NOME:TEXT),"") 
								_cSITUACAO:= iif(type("oXml3:_SITUACAO:TEXT") == "C",oXml3:_SITUACAO:TEXT,"")
								_cTIPINSCR:= iif(type("oXml3:_TIPOINSCRICAO:TEXT") == "C",oXml3:_TIPOINSCRICAO:TEXT,"") 
								_cUF	  := iif(type("oXml3:_UF:TEXT") == "C",oXml3:_UF:TEXT,"") 
								_cCPF	  := iif(type("oXml3:_CPF:TEXT") == "C",oXml3:_CPF:TEXT,"")
								
								AAdd(aRet,{_cCRM		,; // 1
								_cDtAtua 	,; // 2
								_cEspecial	,; // 3
								_cNome	,; // 4
								_cSITUACAO	,; // 5
								_cTIPINSCR	,; // 6
								_cUF	,; // 7
								_cCPF	,; //8
								})
							else
								MsgAlert("N�o foi possivel encontrar N� _DADOSMEDICO")
							Endif
                            
						Else
                            
							if nValid == 0
								lRet := .F.
								cFalha := "N�o foi possivel encontrar dados de CNS com os par�metros informados."
								MsgAlert("N�o foi possivel encontrar dados de CNS com os par�metros informados.")
							else
                                //caso o servi�o retorne erro
								oXml2 := XmlChildEx(oXml3, "_S_FAULT")
								If ValType(oXml2) == "O"
									lRet := .F.
									cFalha := oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT
									MsgAlert(oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT)
								endif
							endif
                            
						Endif
					Else
                        
                        //caso o servi�o retorne erro
						oXml2 := XmlChildEx(oXml3, "_S_FAULT")
						If ValType(oXml2) == "O"
							lRet := .F.
							cFalha := oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT
							MsgAlert(oXml2:_S_DETAIL:_NS4_MSFALHA:_NS4_MENSAGEM:_NS5_DESCRICAO:TEXT)
						endif
                        //  MsgAlert("N�o foi possivel encontrar N� _S_BODY")
					EndIf
				Else
                    //caso o servi�o retorne erro
					lRet := .F.
					cFalha := "CRM n�o encontrado com os par�metros informados."
                    
					MsgAlert("N�o foi possivel encontrar N� _SOAP_ENVELOPE")
				EndIf
			Else
				lRet := .F.
				cFalha := "Estabelecimento n�o encontrado com os par�metros informados."
                
				MsgAlert("N�o foi possivel encontrar N� _SOAP_ENVELOPE")
			EndIf
		Else
			lRet := .F.
			cFalha := "Estabelecimento n�o encontrado com os par�metros informados."
            
			MsgAlert("Erro no Parser XML "+cErro)
		EndIf
        
	Else
		MsgAlert("Erro ao Definir M�todo "+cMetodo)
	Endif
    
    
Return {aRet,cFalha}


Static Function MontaXml(cCrm,_cChave,cUf)
    
	Local cMsg   		:= ''
    
    
	cMsg := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://servico.cfm.org.br/">'
  	cMsg += ' <soapenv:Header/>
   	cMsg += ' <soapenv:Body>
   	cMsg += ' <ser:Consultar><crm>'+cCrm+'</crm>
 	cMsg += '         <!--Optional:-->
  	cMsg += '        <uf>'+cUf+'</uf>
  	cMsg += '        <!--Optional:-->
  	cMsg += '       <chave>'+_cChave+'</chave>
   	cMsg += '   </ser:Consultar>
  	cMsg += '  </soapenv:Body>
	cMsg += ' </soapenv:Envelope>
    
Return cMsg


Static Function Status(cSituac)

	Local aStatus := {}

	if cSituac == "A"
		cSituac := "A - ativo"
	elseif 	cSituac == "T"
		cSituac := "T - ativo"
	elseif 		cSituac == "A"
		cSituac := "C - cassado"
	elseif 	cSituac == "A"
		cSituac := "S - suspenso"
	elseif cSituac == "P"
		cSituac := "P - aposentado"
	elseif 	cSituac == "F"
		cSituac == "F - falecido"
	elseif 	cSituac == "L"
		cSituac := "L - cancelado"
	elseif 		cSituac == "D"
		cSituac := "D - d�vida ativa"
	elseif 		cSituac == "O"
		cSituac := "O - suspenso por ordem judicial"
	elseif cSituac == "A"
		cSituac :="X - afastado"
	elseif 		cSituac == "I"
		cSituac :="I - Interditado cautelarmente"
	elseif cSituac == "N"
		cSituac := "N - Interditado parcialmente"
	endif

Return cSituac
