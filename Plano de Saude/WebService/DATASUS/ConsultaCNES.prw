#INCLUDE "PROTHEUS.CH"
#INCLUDE "XMLCSVCS.CH"

/*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | ConsCnes | Autor | Mateus Medeiros 						   |*
*+------------+------------------------------------------------------------+*
*|Data        | 12.09.2017                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Consome e consulta serviço DataSus, através de parâmetros  |*
*|            | passados - Consulta CNES                                   |*
*+------------+------------------------------------------------------------+*
*|Solicitante | 			                                               |*
*+------------+------------------------------------------------------------+*
*****************************************************************************/

User Function ConsCnes(cCNES,cCGC)
    
    Local	cQry		:= ""
    Private _aRet		:= {}
    
    Default cCGC		:= ""
    Default cCNES      	:= ""
    
    _aRet := GerWsdl(cCNES,cCGC)
    
Return _aRet

/*/{Protheus.doc} GerWsdl

@author Mateus Medeiros
@since 12/09/2017
@version 1.0
@description Consome e realiza a execução do webservice para integração com o DataSus CNES
@type function

/*/

Static function GerWsdl(_cCNES,_cCGC)
    
    Local oWsdl 	:= Nil
    
    Local cMetodo 	:= "ConsultarEstabelecimentoSaude" //Metodo Utilizado
    Local cEnd		:= SuperGetMv("MV_XWSNUC2",,"https://servicos.saude.gov.br/cnes/EstabelecimentoSaudeService/v1r0?wsdl")
    Local cErro		:= ""
    Local cAviso 	:= ""
    Local _cTmp 	:= ''
    Local lSend     := .F.
    Local aServico	:= {}
    Local aMetodos 	:= {}
    Local aDados	:= {}
    Local aTel 		:= {}
    Local lParse	:= .F.
    Local cFalha	:= ""
    
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
    
    // ----------------------------------------------------------------------------------------
    // Obtém status de sucesso (.T.) ou falha (.F.) da operação realizada.
    // ----------------------------------------------------------------------------------------
    If oWsdl:lStatus
        MsgAlert( "Erro ao instanciar Ws Endereço: "+cEnd,Funname() )
        Return _cTmp
    EndIf
    // ----------------------------------------------------------------------------------------
    // Faz o parse de uma URL
    // ----------------------------------------------------------------------------------------
    
    QOut("CNES Entrada PARSE: "+Time())
    //if !oWsdl:ParseURL( cEnd )
    
    if !oWsdl:ParseFile( "\datasus\cnes.wsdl" )
        //If !lParse
        _cTmp:= "Erro ao realizar ParseXml Endereço: "+cEnd+" - "+oWsdl:cError
        MsgAlert( "Erro ao realizar ParseXml Endereço: "+cEnd+" - "+oWsdl:cError,Funname() )
        Return _cTmp
    EndIf
    QOut("CNES FIM PARSE: "+Time())
    //--------------------------------------------------------
    // lista os serviços que tem no wsdl
    //--------------------------------------------------------
    aServico := oWsdl:GetServices()
    If Len(aServico) == 0
        MsgAlert("Erro ao listar serviços: "+cEnd,Funname())
        Return _cTmp
    Endif
    
    //--------------------------------------------------------
    // Lista as operações definidas. Passo opcional.
    //--------------------------------------------------------
    aMetodos := oWsdl:ListOperations()
    
    if Len( aMetodos ) == 0 .AND. Ascan(aMetodos, { |X| Upper(X[1]) == Upper(cMetodo)}) == 0
        _cTmp := oWsdl:cError
        MsgAlert( "Erro ao listar Métodos: " + oWsdl:cError,Funname() )
        Return _cTmp
    endif
    
    //--------------------------------------------------------
    // Define a operação / método
    //--------------------------------------------------------
    If  oWsdl:SetOperation( aMetodos[Ascan(aMetodos, { |X| upper(X[1]) == upper(cMetodo) })][1] )
        
        //--------------------------------------------------------
        //Monta XML para envio no método SendSoapMsg
        //--------------------------------------------------------
        //_cCGC 		:= '00634412000183' // comentar após virada
        //_cCNES 		:= '3296687'        // comentar
        
        cXml := MontaXml(_cCNES,_cCGC)
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
        
        /*If !lSend .and. nValid > 0
        MsgAlert( "Erro: " + oWsdl:cError,Funname() )
        Return _cTmp
    endif*/
    
    If !EMPTY(cSoapResp)
        //---------------------------------------------------
        // Bloco Abaixo fará o tratamento do xml retornado
        //---------------------------------------------------
        oXml := XmlParser(cSoapResp,"",@cErro,@cAviso)
        If ValType(oXml) == "O"
            oXml2 := XmlChildEx(oXml , "_SOAP_ENVELOPE")
            If ValType(oXml2)== "O"
                oXml3 := XmlChildEx(oXml2, "_S_BODY")
                If ValType(oXml3) == "O"
                    oXml2 := XmlChildEx(oXml3, "_EST_RESPONSECONSULTARESTABELECIMENTOSAUDE")
                    If ValType(oXml2) == "O"
                        oXml3 := XmlChildEx(oXml2, "_DAD_DADOSGERAISESTABELECIMENTOSAUDE")
                        If ValType(oXml3)== "O"
                            
                            //Realiza o Tratamento necessario
                            // Coloca em variaveis os dados retornados pelo serviço DataSus
                            // Início Validação Tag Endereço
                            oXml2 := XmlChildEx(oXml3, "_NS11_ENDERECO")
                            oXml := Nil
                            oXml := XmlChildEx(oXml2, "_NS11_BAIRRO")
                            If ValType(oXml) == "O"
                                _cBairro  := oXml3:_NS11_ENDERECO:_NS11_BAIRRO:_NS13_DESCRICAOBAIRRO:TEXT
                            else
                                _cBairro  := ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_COMPLEMENTO")
                            If ValType(oXml) == "O"
                                _cComplem := oXml3:_NS11_ENDERECO:_NS11_COMPLEMENTO:TEXT
                            else
                                _cComplem := ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_MUNICIPIO")
                            If ValType(oXml) == "O"
                                _cCodMunic:= oXml3:_NS11_ENDERECO:_NS11_MUNICIPIO:_NS15_CODIGOMUNICIPIO:TEXT
                            else
                                _cCodMunic:= ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_MUNICIPIO")
                            If ValType(oXml) == "O"
                                _cDscMunic:= oXml3:_NS11_ENDERECO:_NS11_MUNICIPIO:_NS15_NOMEMUNICIPIO:TEXT
                            else
                                _cDscMunic:= ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_MUNICIPIO")
                            If ValType(oXml) == "O"
                                _cSiglaUF := oXml3:_NS11_ENDERECO:_NS11_MUNICIPIO:_NS15_UF:_NS16_SIGLAUF:TEXT
                            else
                                _cSiglaUF := ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_NOMELOGRADOURO")
                            If ValType(oXml) == "O"
                                _cEnd     := oXml3:_NS11_ENDERECO:_NS11_NOMELOGRADOURO:TEXT
                            else
                                _cEnd     := ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_CEP")
                            If ValType(oXml) == "O"
                                _cCep    := oXml3:_NS11_ENDERECO:_NS11_CEP:_NS14_NUMEROCEP:TEXT
                            else
                                _cCep    := ''
                            endif
                            
                            oXml := XmlChildEx(oXml2, "_NS11_NUMERO")
                            If ValType(oXml) == "O"
                                _cNumero  := oXml3:_NS11_ENDERECO:_NS11_NUMERO:TEXT
                            else
                                _cNumero    := ''
                            endif
                            // Fim Validação Tag Endereço
                            oXml2 := XmlChildEx(oXml3, "_NS24_CODIGOUNIDADE")
                            If ValType(oXml2) == "O"
                                _cCodUni  := oXml3:_NS24_CODIGOUNIDADE:_NS24_CODIGO:TEXT
                            else
                                _cCodUni  := ''
                            endif
                            oXml2 := XmlChildEx(oXml3, "_NS25_DATAATUALIZACAO")
                            If ValType(oXml2) == "O"
                                _nDtAtua  := oXml3:_NS25_DATAATUALIZACAO:TEXT
                            else
                                _nDtAtua  := ''
                            endif
                            oXml2 := XmlChildEx(oXml3, "_NS25_EMAIL")
                            If ValType(oXml2) == "O"
                                _cEmail   := oXml3:_NS25_EMAIL:_NS20_DESCRICAOEMAIL:TEXT
                            else
                                _cEmail   := ''
                            endif
                            _cRazSoc  := oXml3:_NS25_NOMEEMPRESARIAL:_NS7_NOME:TEXT
                            _cNFantas := oXml3:_NS25_NOMEFANTASIA:_NS7_NOME:TEXT
                            _lSus  	  := IIF(oXml3:_NS25_PERTECESISTEMASUS:TEXT == "true",.T.,.F.)
                            // CPF Diretor
                            oXml2 := XmlChildEx(oXml3, "_NS26_DIRETOR")
                            If ValType(oXml2) == "O"
                                // CPF Diretor
                                _cDirCPf  := oXml3:_NS26_DIRETOR:_NS26_CPF:_NS5_NUMEROCPF:TEXT
                                // Nome Diretor
                                _cDirNome := oXml3:_NS26_DIRETOR:_NS26_NOME:_NS27_NOME:TEXT
                            else
                                _cDirCPf   := ''
                                _cDirNome := ''
                            endif
                            
                            // Tipo de Unidade Codigo
                            If Type("oXml3:_NS28_TIPOUNIDADE:_NS28_DESCRICAO:TEXT") == "C"
                            _cTpCodUni  := oXml3:_NS28_TIPOUNIDADE:_NS28_CODIGO:TEXT
                            else 
                            _cTpCodUni  := ""
                            endif 
                            // Tipo de Unidade Descrição
                            If Type("oXml3:_NS28_TIPOUNIDADE:_NS28_DESCRICAO:TEXT") == "C"
                            	_cTpUnid  := oXml3:_NS28_TIPOUNIDADE:_NS28_DESCRICAO:TEXT
                            else 
                            	_cTpUnid := ""
                            endif 
                            
                            // CNES
                            _cCNES    := oXml3:_NS2_CODIGOCNES:_NS2_CODIGO:TEXT
                            // CNPJ
                            _cCNPJ    := oXml3:_NS6_CNPJ:_NS6_NUMEROCNPJ:TEXT
                           	
                           	If Type("oXml3:_NS25_LOCALIZACAO:_NS30_LONGITUDE:TEXT") == "C" 
                            	cLatitude := oXml3:_NS25_LOCALIZACAO:_NS30_LONGITUDE:TEXT
                            else 
                            	cLatitude := ""
                            Endif 
                            
                            If Type("oXml3:_NS25_LOCALIZACAO:_NS30_LATITUDE:TEXT") == "C"
                            	cLongitude:= oXml3:_NS25_LOCALIZACAO:_NS30_LATITUDE:TEXT
                            else 
                            	cLongitude:= ""
                            endif 
                            // Telefone ou Fax
                            oXml2 := XmlChildEx(oXml3, "_NS25_TELEFONE")
                            if ValType(oXml2) == "A"
                                if len(oXml2) > 0
                                    aTel := {}
                                    For nX := 1 to len(oXML2)
                                        
                                        AAdd(aTel,{oXml2[nX]:_NS18_DDD:TEXT,oXml2[nX]:_NS18_NUMEROTELEFONE:TEXT,oXml2[nX]:_NS18_TIPOTELEFONE:_NS19_DESCRICAOTIPOTELEFONE:TEXT})
                                        //_cDDD	  := oXml2[1]:_NS18_DDD:TEXT
                                        //_cTel	  := oXml2[1]:_NS18_NUMEROTELEFONE:TEXT
                                        //_cTpTel := oXml2[1]:_NS18_TIPOTELEFONE:_NS19_DESCRICAOTIPOTELEFONE:TEXT
                                        
                                    Next nX
                                    
                                endif
                            elseif ValType(oXml2) == "O"
                                AAdd(aTel,{oXml2:_NS18_DDD:TEXT,oXml2:_NS18_NUMEROTELEFONE:TEXT,oXml2:_NS18_TIPOTELEFONE:_NS19_DESCRICAOTIPOTELEFONE:TEXT})
                            endif
                            
                            AAdd(aDados,{	_cBairro	,;//1
                            _cComplem	,;//2
                            _cCodMunic	,;//3
                            _cDscMunic	,;//4
                            _cSiglaUF	,;//5
                            _cEnd 		,;//6
                            _cNumero	,;//7
                            _cCep		,;//8
                            _cCodUni  	,;//9
                            _nDtAtua  	,;//10
                            _cEmail   	,;//11
                            _cRazSoc  	,;//12
                            _cNFantas 	,;//13
                            _lSus  	  	,;//14
                            _cDirCPf  	,;//15
                            _cDirNome 	,;//16
                            _cTpCodUni  ,;//17
                            _cTpUnid  	,;//18
                            _cCNES    	,;//19
                            _cCNPJ    	,;//20
                            aTel		,;//21
                            cLatitude   ,;//22
                            cLongitude})  //23
                            
                            //AAdd(aDados,{_cBairro,_cComplem,_cCodMunic,_cDscMunic,_cEnd,_cNumero,_cCep,_cCodUni,_nDtAtua,_lSus,_cDirCPf,_cDirNome,_cTpCodUni, _cTpUnid,_cCNES,_cCNPJ,_cSiglaUF,_cNFantas,aTel} )
                            
                        else
                            if nValid == 0
                                MsgAlert("Não foi possivel encontrar Nó _DAD_DADOSGERAISESTABELECIMENTOSAUDE")
                            else
                                //caso o serviço retorne erro
                                oXml2 := XmlChildEx(oXml3, "_S_FAULT")
                                If ValType(oXml2) == "O"
                                    lRet := .F.
                                    cFalha := oXml2:_S_DETAIL:_NS20_MSFALHA:_NS20_MENSAGEM:_NS21_DESCRICAO:TEXT
                                    
                                endif
                            endif
                            
                        Endif
                        
                    Else
                        if nValid == 0
                            //caso o serviço retorne erro
                            oXml2 := XmlChildEx(oXml3, "_S_FAULT")
                            If ValType(oXml2) == "O"
                                lRet := .F.
                                cFalha := oXml2:_S_DETAIL:_NS20_MSFALHA:_NS20_MENSAGEM:_NS21_DESCRICAO:TEXT
                                
                            endif
                            MsgAlert("Não foi possivel encontrar Nó _DAD_DADOSGERAISESTABELECIMENTOSAUDE")
                        else
                            //caso o serviço retorne erro
                            oXml2 := XmlChildEx(oXml3, "_S_FAULT")
                            If ValType(oXml2) == "O"
                                lRet := .F.
                                cFalha := oXml2:_S_DETAIL:_NS20_MSFALHA:_NS20_MENSAGEM:_NS21_DESCRICAO:TEXT
                                
                            endif
                        endif
                        //caso o serviço retorne erro
                        oXml2 := XmlChildEx(oXml3, "_S_FAULT")
                        If ValType(oXml2) == "O"
                            lRet := .F.
                            cFalha := oXml2:_S_DETAIL:_NS20_MSFALHA:_NS20_MENSAGEM:_NS21_DESCRICAO:TEXT
                            
                        endif
                        MsgAlert("Não foi possivel encontrar Nó _EST_RESPONSECONSULTARESTABELECIMENTOSAUDE")
                    Endif
                Else
                    //caso o serviço retorne erro
                    oXml2 := XmlChildEx(oXml3, "_S_FAULT")
                    If ValType(oXml2) == "O"
                        lRet := .F.
                        cFalha := oXml2:_S_DETAIL:_NS20_MSFALHA:_NS20_MENSAGEM:_NS21_DESCRICAO:TEXT
                        
                    endif
                    MsgAlert("Não foi possivel encontrar Nó _S_BODY")
                EndIf
            Else
                //caso o serviço retorne erro
                lRet := .F.
                cFalha := "Estabelecimento não encontrado com os parâmetros informados."
                
                MsgAlert("Não foi possivel encontrar Nó _SOAP_ENVELOPE")
            EndIf
        Else
            //caso o serviço retorne erro
            
            lRet := .F.
            cFalha := "Estabelecimento não encontrado com os parâmetros informados."
            
        EndIf
    Else
        //caso o serviço retorne erro
        lRet := .F.
        cFalha := "Estabelecimento não encontrado com os parâmetros informados."
        
        MsgAlert("Erro no Parser XML "+cErro)
    EndIf
    
Else
    MsgAlert("Erro ao Definir Método "+cMetodo)
Endif

Return {aDados,cFalha}


Static Function MontaXml(_cCnes,_cCNPJ)
    
    Local _cUsrCNES		:= SuperGetMv("MV_XCNUSR"  ,,"CADSUS.ANS.CABERJ.RJ")
    Local _cPassWd		:= SuperGetMv("MV_XPASUSR",,"Y_*27*uL87-9*5NvPn*uCW_53Kppjy")
    
    cMsg := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:est="http://servicos.saude.gov.br/cnes/v1r0/estabelecimentosaudeservice" xmlns:fil="http://servicos.saude.gov.br/wsdl/mensageria/v1r0/filtropesquisaestabelecimentosaude" xmlns:cod="http://servicos.saude.gov.br/schema/cnes/v1r0/codigocnes" xmlns:cnpj="http://servicos.saude.gov.br/schema/corporativo/pessoajuridica/v1r0/cnpj">'
    cMsg += '  <soap:Header>'
    cMsg += '      <wsse:Security soap:mustUnderstand="true" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">'
    cMsg += '         <wsse:UsernameToken wsu:Id="UsernameToken-5FCA58BED9F27C406E14576381084652">'
    cMsg += '            <wsse:Username>'+alltrim(_cUsrCNES)+'</wsse:Username>'
    cMsg += '            <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">'+alltrim(_cPassWd)+'</wsse:Password>'
    //cMsg += '            <wsse:Username>CNES.PUBLICO</wsse:Username>'
    //cMsg += '            <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">cnes#2015public</wsse:Password>'
    cMsg += '         </wsse:UsernameToken>'
    cMsg += '      </wsse:Security></soap:Header>'
    cMsg += '   <soap:Body>'
    cMsg += '      <est:requestConsultarEstabelecimentoSaude>'
    cMsg += '         <fil:FiltroPesquisaEstabelecimentoSaude>'
    if !Empty(_cCnes)
        cMsg += '        	<cod:CodigoCNES>'
        cMsg += '               <cod:codigo>'+_cCnes+'</cod:codigo>'
        cMsg += '            </cod:CodigoCNES>'
    endif
    if !Empty(_cCNPJ)
        cMsg += '            <cnpj:CNPJ>'
        cMsg += '               <cnpj:numeroCNPJ>'+_cCNPJ+'</cnpj:numeroCNPJ>'
        cMsg += '            </cnpj:CNPJ>'
    endif
    cMsg += '     </fil:FiltroPesquisaEstabelecimentoSaude>'
    cMsg += '    </est:requestConsultarEstabelecimentoSaude> '
    cMsg += '</soap:Body>	'
    cMsg += '</soap:Envelope> '
    
Return cMsg
