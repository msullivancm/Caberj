#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Método      | WS009        | Autor | Mateus Medeiros 				  	   |*
*+------------+------------------------------------------------------------+*
*|Data        | 05.10.2017                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Serviço de consulta de Redes Credenciadas MetLife  		   |*
*+------------+------------------------------------------------------------+*
*|Solicitante | 			                                               |*
*+------------+------------------------------------------------------------+*
*****************************************************************************/

/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descrição 	WebService criado para ser utilizado no processo de consulta CNS e CNES

---------------------------------------------------------------------------------- */
User Function WS009()
	
Return

// Estrutura de enderecos 
WSSTRUCT tEndereco
	WSDATA adressLine1  AS STRING
	WSDATA adressLine2  AS STRING
	WSDATA numero       AS STRING
	WSDATA city		    AS STRING
	WSDATA zipCode	    AS STRING
	WSDATA state	    AS STRING
	WSDATA country	    AS STRING
	WSDATA neighborhood AS STRING
	WSDATA latitude		AS STRING
	WSDATA longitude	AS STRING
	
ENDWSSTRUCT

// Estrutura de Telefone
WSSTRUCT tTelef
	
	WSDATA number  	 AS STRING
	WSDATA areaCode  AS STRING
	
ENDWSSTRUCT

// Estrutura de Qualificacao RDA 
WSSTRUCT tQualificacao
	
	WSDATA qualifica AS STRING
   
ENDWSSTRUCT

// Estrutura de Qualificacao Rede 
WSSTRUCT tRede
	
	WSDATA name AS STRING
   
ENDWSSTRUCT


// Estrutura de Qualificacao Rede 
WSSTRUCT tEspecialidades
	
	WSDATA name AS STRING
   
ENDWSSTRUCT

// Estrutura principal do serviço
WSSTRUCT tRda

	WSDATA email		 	AS STRING
	WSDATA providerName	 	AS STRING
	WSDATA providerTypeCode AS STRING
	WSDATA providerRating   AS STRING
	WSDATA croNumber		AS STRING
	WSDATA cpf_cnpjNumber   AS STRING
	WSDATA addresses 	 	AS array of tEndereco		optional
	WSDATA phonenumbers  	AS array of tTelef			optional
	WSDATA network 		 	AS array of tRede			optional
	WSDATA specialties   	AS array of tEspecialidades optional

ENDWSSTRUCT

// Encapsulando a estrutura de retorno 
WSSTRUCT tStrRda
	
	WSDATA totalCount	AS STRING // Total de Dados no Serviço MetLife
	WSDATA Limit  		AS STRING // Limite para retorno
	WSDATA Offset 		AS STRING // De onde a busca iniciou
	WSDATA StrRDA       AS array of tRDA

ENDWSSTRUCT

WSSERVICE WS009 DESCRIPTION "Consulta MetLife " NAMESPACE "WS009"

	//-----------------------------------------------------
	//Lista das estruturas de retorno do webservice
	//-----------------------------------------------------
	WSDATA tGetRDA      AS tStrRda //AS tStrRda
	wsdata tretorno as string
	//-----------------------------------------------------
	//Parametros de entrada do serviço
	//-----------------------------------------------------
	WSDATA _cEmp	AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado na Inclusão de Protocolos
	WSDATA _cFil 	AS STRING	//Filial - Utilizado na Inclusão de Protocolos
	
	WSDATA State		AS STRING // Latitude
	WSDATA Bairro		AS STRING // Longitude
	WSDATA Cidade		AS STRING // Radius
	WSDATA Plano		AS STRING // Plano
	WSDATA providerName AS STRING
	WSDATA speciality   AS STRING
	WSDATA Limit  		AS STRING // Limite para retorno
	WSDATA Offset 		AS STRING // de onde deve iniciar
	
	//------------------------------
	//Declaração dos Métodos
	//------------------------------
	WSMETHOD WS009A	DESCRIPTION "Método - Consulta MetLife."
	WSMETHOD WS009B	DESCRIPTION "Método - Consulta MetLife - Terceirização do Serviço devido incompatibilidade de Build."
		
ENDWSSERVICE

/*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Método      | WS009A        | Autor | Mateus Medeiros 				   |*
*+------------+------------------------------------------------------------+*
*|Data        | 05.10.2017                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Método de consulta de Redes Credenciadas MetLife  |*
*+------------+------------------------------------------------------------+*
*|Solicitante | 			                                               |*
*+------------+------------------------------------------------------------+*
*****************************************************************************/
WSMETHOD WS009A WSRECEIVE _cEmp,_cFil,State,Bairro,Cidade,Plano,Limit,Offset,providerName,speciality WSSEND tGetRDA WSSERVICE WS009

	Local lRet          := .T.
	Local aDados 		:= {} // Array que receberá as informações da função de consumo de serviço rest
	Local aRedeCred		:= {}
	//-------------------------------------------------------------
	// Atribuição dos parâmetros do serviço para variáveis locais 
	//-------------------------------------------------------------
	Local cEmp  		:= self:_cEmp
	Local cFil  		:= self:_cFil
	Local cPlano 		:= self:Plano
	Local cBairro  		:= self:Bairro
	Local cEst		 	:= self:State
	Local cMun		 	:= self:Cidade
	Local nLimit  		:= cvaltochar(self:Limit)
	Local nOffSet  		:= cvaltochar(self:OffSet)
	Local cName 		:= cvaltochar(self:providerName)
	Local cEspec 		:= cvaltochar(self:speciality)

	//--------------------------------------------------------------------
	// Objetos que serão utilizados para instaciar as classes de retorno   
	//--------------------------------------------------------------------
	Local oTemp			:= Nil // Instanciará a classe principal de retorno
	Local oTel 			:= Nil
	Local oEnd 			:= Nil
	Local oQualify		:= Nil
	Local oRede			:= Nil
	Local oEspecial		:= Nil
	Local oRedeCred		:= Nil
	
	::tGetRDA:StrRda	:= {}
	//----------------------
	//Nao consome licenças
	//----------------------
	RPCSetType(3)
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	RpcClearEnv()
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automáticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(cEmp),cValToChar(cFil))
		
		cMun := strtran(cMun,'ç','c')
		cMun := strtran(cMun,'Ç','c')
		cMun := strtran(cMun,'á','a')
		cMun := strtran(cMun,'é','e')
		cMun := strtran(cMun,'í','i')
		cMun := strtran(cMun,'ó','o')
		cMun := strtran(cMun,'ú','u')

		
		aDados := u_Nucleo2(cEst,UPPER(cMun),cplano,cBairro,nLimit,nOffSet,nil,nil,nil,cName,cEspec)
		
		//::tretorno := DecodeUtf8(aDados) //strtran(strtran(substr(aDados,1,144),'"',""),"'","")) //substr(aDados,1,100)
		if valtype(aDados) == "A"
			if len(aDados) > 0
			// --------------------------------------------------------------------------
			// Instancia classe principal retorno e atrubui as informações para retorno
			// --------------------------------------------------------------------------
				if len(aDados[1]) > 0
					For nX := 1 to len(aDados[1])
				
				//varinfo("",aDados)
						For nK := 1 to Len(aDados[1][nX])
							oRedeCred := WsClassNew("tRda")
			
							oRedeCred:email		 		:= aDados[1][nX][nK]:EMAIL
							oRedeCred:providerName	 	:= aDados[1][nX][nK]:providerName
							oRedeCred:providerTypeCode  := aDados[1][nX][nK]:providerTypeCode
							oRedeCred:providerRating 	:= aDados[1][nX][nK]:providerRating
							oRedeCred:croNumber		 	:= cValToChar(aDados[1][nX][nK]:croNumber)
							oRedeCred:cpf_cnpjNumber 	:= aDados[1][nX][nK]:cpf_cnpjNumber
				
				// Enderecos
							oRedeCred:addresses 	:= {}

				
							For nY := 1 to Len(aDados[1][nX][nK]:ADDRESSES)
					
								oEnd := WsClassNew("tEndereco")
						
								oEnd:adressLine1    := aDados[1][nX][nK]:ADDRESSES[nY]:ADDRESSLINE1
								oEnd:adressLine2  	:= aDados[1][nX][nK]:ADDRESSES[nY]:ADDRESSLINE2
								oEnd:numero         := aDados[1][nX][nK]:ADDRESSES[nY]:NUM
								oEnd:city		    := aDados[1][nX][nK]:ADDRESSES[nY]:CITY
								oEnd:zipCode	    := aDados[1][nX][nK]:ADDRESSES[nY]:ZIPCODE
								oEnd:state	    	:= aDados[1][nX][nK]:ADDRESSES[nY]:STATE
								oEnd:country	    := aDados[1][nX][nK]:ADDRESSES[nY]:COUNTRY
								oEnd:neighborhood 	:= aDados[1][nX][nK]:ADDRESSES[nY]:NEIGHBORHOOD
								oEnd:latitude		:= aDados[1][nX][nK]:ADDRESSES[nY]:LOCATIONCOORDINATE:LATITUDE
								oEnd:longitude		:= aDados[1][nX][nK]:ADDRESSES[nY]:LOCATIONCOORDINATE:LONGITUDE
						
								AAdd(oRedeCred:addresses,oEnd)
					
							Next
				
				// Telefones
							oRedeCred:phonenumbers  := {}
				 
							For nY := 1 to Len(aDados[1][nX][nK]:PHONENUMBERS)
								oTel := WsClassNew("tTelef")
								oTel:number 	:= aDados[1][nX][nK]:PHONENUMBERS[nY]:NUMBER
								oTel:areaCode  	:= aDados[1][nX][nK]:PHONENUMBERS[nY]:AREACODE
								AAdd(oRedeCred:phonenumbers,oTel)
							Next
				
				// Qualificacao
					/*oRedeCred:qualification := {}
				 
					For nY := 1 to Len(aDados[1][nX][nK]:QUALIFICATION)
						oQualify := WsClassNew("tQualificacao")
						oQualify:qualifica := ''
						AAdd(oRedeCred:qualification,oQualify)
					Next */
				
				// Rede
							oRedeCred:network 		:= {}
				 
							For nY := 1 to Len(aDados[1][nX][nK]:NETWORK)
								oRede := WsClassNew("tRede")
								oRede:name := aDados[1][nX][nK]:NETWORK[nY]
								AAdd(oRedeCred:network,oRede)
							Next
				
				// Especialidades 
							oRedeCred:specialties 	:= {}
					
							For nY := 1 to Len(aDados[1][nX][nK]:SPECIALTIES)
								oEspecial := WsClassNew("tEspecialidades")
								oEspecial:name := aDados[1][nX][nK]:SPECIALTIES[1]:NAME
								AAdd(oRedeCred:specialties,oEspecial)
							Next
			      
							AAdd(::tGetRDA:StrRda,oRedeCred)
					
						Next nK
				
					// ---------------------------------------------------------------
			// Atribui ao objeto de retorno a estrutura pertinente de retorno
			// ---------------------------------------------------------------
					Next nX
				
					::tGetRDA:LIMIT 		 := cValToChar(aDados[3]) // aDados[len(adados)][1]
					::tGetRDA:OFFSET		 := cValToChar(aDados[2])
					::tGetRDA:TOTALCOUNT	 := cValToChar(aDados[4])//aDados[len(adados)][2]
				else
					lRet          := .F.
					SetSoapFault( ProcName() , "Não há Rede Credenciada com os filtros informados.")
				endif
		
			else
				lRet          := .F.
				SetSoapFault( ProcName() , "Não há Rede Credenciada com os filtros informados.")
			endif
		else
			lRet          := .F.
			SetSoapFault( ProcName() , "Não há Rede Credenciada com os filtros informados.")
		endif
	else
		lRet          := .F.
		SetSoapFault( ProcName() , "Problema ao iniciar o ambiente." )
	EndIf


Return lRet

/****************************************************************************
*+-------------------------------------------------------------------------+*
*|Método      | WS009B       | Autor | Mateus Medeiros 				   	   |*
*+------------+------------------------------------------------------------+*
*|Data        | 05.10.2017                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Método de consulta de Redes Credenciadas MetLife  		   |*
*|            | Criado para ser consumido da Build antiga				   |*	 
*+------------+------------------------------------------------------------+*
*|Solicitante | 			                                               |*
*+------------+------------------------------------------------------------+*
*****************************************************************************/
WSMETHOD WS009B WSRECEIVE _cEmp,_cFil,State,Bairro,Cidade,Plano,Limit,Offset,providerName,speciality  WSSEND tGetRDA WSSERVICE WS009
	
	Local lRet          := .T.
	Local oDados 		:= Nil // Array que receberá as informações da função de consumo de serviço rest
	Local aRedeCred		:= {}
	//-------------------------------------------------------------
	// Atribuição dos parâmetros do serviço para variáveis locais 
	//-------------------------------------------------------------
	Local cEmp  		:= self:_cEmp
	Local cFil  		:= self:_cFil
	Local cPlano 		:= self:Plano
	Local cBairro  		:= self:Bairro
	Local cEst		 	:= self:State
	Local cMun		 	:= self:Cidade
	Local nLimit  		:= cvaltochar(self:Limit)
	Local nOffSet  		:= cvaltochar(self:OffSet)
	Local cName 		:= 	cvaltochar(self:providerName)
	Local cEspec 		:= 	cvaltochar(self:speciality)
	//--------------------------------------------------------------------
	// Objetos que serão utilizados para instaciar as classes de retorno   
	//--------------------------------------------------------------------
	Local oTemp			:= Nil // Instanciará a classe principal de retorno
	Local oTel 			:= Nil
	Local oEnd 			:= Nil
	Local oQualify		:= Nil
	Local oRede			:= Nil
	Local oEspecial		:= Nil
	Local oRedeCred		:= Nil
	
	::tGetRDA:StrRda	:= {}
	//----------------------
	//Nao consome licenças
	//----------------------
	RPCSetType(3)
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	RpcClearEnv()
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automáticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(cEmp),cValToChar(cFil))

		oDados := u_ConWsMet(cEst,cMun,cplano,cBairro,nLimit,nOffSet,cName,cEspec)
		
		if ValType(oDados) == "O"
			// --------------------------------------------------------------------------
			// Instancia classe principal retorno e atrubui as informações para retorno
			// --------------------------------------------------------------------------
			aDados := ClassDataArr( oDados:OWSSTRRDA, .f. ) // converte objeto em array
				
			For nX := 1 to len(aDados[1][2])
				
				oRedeCred := WsClassNew("tRda")
			
				oRedeCred:email		 		:= aDados[1][2][nX]:cemail
				oRedeCred:providerName	 	:= aDados[1][2][nX]:cproviderName
				oRedeCred:providerTypeCode  := aDados[1][2][nX]:cproviderTypeCode
				oRedeCred:providerRating 	:= aDados[1][2][nX]:cproviderRating
				oRedeCred:croNumber		 	:= cValToChar(aDados[1][2][nX]:cCroNumber)
				oRedeCred:cpf_cnpjNumber 	:= aDados[1][2][nX]:cCPF_CNPJNUMBER
				
				// Enderecos
				oRedeCred:addresses 	:= {}
				
				For nY := 1 to Len(aDados[1][2][nX]:OWSADDRESSES:oWStendereco)
					
					oEnd := WsClassNew("tEndereco")
	
					oEnd:adressLine1    := aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cadressLine1
					oEnd:adressLine2  	:= aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cadressLine2
					oEnd:numero         := aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cnumero
					oEnd:city		    := aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:ccity
					oEnd:zipCode	    := aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cZIPCODE
					oEnd:state	    	:= aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cSTATE
					oEnd:country	    := aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cCOUNTRY
					oEnd:neighborhood 	:= aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cNEIGHBORHOOD
					oEnd:latitude		:= aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cLATITUDE
					oEnd:longitude		:= aDados[1][2][nX]:OWSADDRESSES:oWStendereco[nY]:cLONGITUDE
						
					AAdd(oRedeCred:addresses,oEnd)
					
				Next
				
				// Telefones
				oRedeCred:phonenumbers  := {}
				 
				For nY := 1 to Len(aDados[1][2][nX]:oWSPHONENUMBERS:oWsTtelef)
					oTel := WsClassNew("tTelef")
					oTel:number 	:= aDados[1][2][nX]:oWSPHONENUMBERS:oWsTtelef[nY]:cNUMBER
					oTel:areaCode  	:= aDados[1][2][nX]:oWSPHONENUMBERS:oWsTtelef[nY]:cAREACODE
					AAdd(oRedeCred:phonenumbers,oTel)
				Next
				
				// Qualificacao
					/*oRedeCred:qualification := {}
				 
					For nY := 1 to Len(aDados[nX][nK]:QUALIFICATION)
						oQualify := WsClassNew("tQualificacao")
						oQualify:qualifica := ''
						AAdd(oRedeCred:qualification,oQualify)
					Next */
				
				// Rede
				oRedeCred:network 		:= {}
				 
				For nY := 1 to Len( aDados[1][2][nX]:oWSNETWORK:oWsTREDE)
					oRede := WsClassNew("tRede")
					oRede:name := aDados[1][2][nX]:oWSNETWORK:oWsTREDE[nY]:cName
					AAdd(oRedeCred:network,oRede)
				Next
				
				// Especialidades 
				oRedeCred:specialties 	:= {}
					
				For nY := 1 to Len(aDados[1][2][nX]:oWSSPECIALTIES:oWsTESPECIALIDADES)
					oEspecial := WsClassNew("tEspecialidades")
					oEspecial:name :=  aDados[1][2][nX]:oWSSPECIALTIES:oWsTESPECIALIDADES[nY]:cName
					AAdd(oRedeCred:specialties,oEspecial)
				Next
			      
				AAdd(::tGetRDA:StrRda,oRedeCred)
			
			Next nX
			
			// ---------------------------------------------------------------
			// Atribui ao objeto de retorno a estrutura pertinente de retorno
			// ---------------------------------------------------------------
			::tGetRDA:LIMIT 		 := oDados:cLIMIT
			::tGetRDA:OFFSET		 := oDados:cOFFSET
			::tGetRDA:TOTALCOUNT	 := oDados:cTOTALCOUNT
			
		else
			lRet          := .F.
			SetSoapFault( ProcName() , "Não há Rede Credenciada com os filtros informados.")
		endif
	else
		lRet          := .F.
		SetSoapFault( ProcName() , "Problema ao iniciar o ambiente." )
	EndIf


Return lRet
