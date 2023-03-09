#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)


/* ----------------------------------------------------------------------------------
Funcao		WS007(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descrição 	WebService criado para ser utilizado no processo de consulta CNS e CNES

---------------------------------------------------------------------------------- */
User Function WS007()
	
Return

WSSTRUCT tTelefone
	
	//    WSDATA codigoTipoTelefone 			AS STRING
	WSDATA descricaoTipoTelefone 		AS STRING
	WSDATA ddd							AS STRING
	WSDATA numeroTelefone				AS STRING
	
ENDWSSTRUCT


//--------------------------------------------------------------
//Estrutura de retorno utilizada para lista de serviço
//--------------------------------------------------------------
WSSTRUCT StrRetCnes
	
	WSDATA codigoCNES					AS STRING
	WSDATA codigoUnidade				AS STRING
	WSDATA nomeFantasia					AS STRING
	WSDATA nomeEmpresarial				AS STRING
	WSDATA cnpj							AS STRING
	WSDATA nomeLogradouro 				AS STRING
	WSDATA numeroLogradouro 			AS STRING
	WSDATA complemento					AS STRING
	WSDATA bairro						AS STRING
	WSDATA nDtAtua						AS STRING
	WSDATA cep							AS STRING
	WSDATA codigoMunicipio				AS STRING
	WSDATA nomeMunicipio				AS STRING
	WSDATA codigoUF						AS STRING
	WSDATA siglaUF			 			AS STRING
	WSDATA diretorCPF					AS STRING
	WSDATA diretorNome					AS STRING
	WSDATA tipoUnidadecodigo			AS STRING
	WSDATA tipoUnidadedescricao			AS STRING
	WSDATA email 						AS String
	WSDATA Sus							AS BOOLEAN
	WSDATA Latitude 					AS STRING 
	WSDATA Longitude 					AS STRING
	WSDATA telefone       	 			AS array of tTelefone optional
	
	
ENDWSSTRUCT
//--------------------------------------------------------------
//Estrutura de retorno utilizada para o método CNS
//--------------------------------------------------------------
WSSTRUCT StrRetCns
	
	WSDATA CNS				AS STRING
	WSDATA DTNASC 			AS STRING
	WSDATA PGrauQld			AS STRING
	WSDATA NumIdCrp			AS STRING
	WSDATA NomeMae			AS STRING
	WSDATA CodMun 			AS STRING
	WSDATA NomeMun 			AS STRING
	WSDATA CodUF			AS STRING
	WSDATA UF				AS STRING
	WSDATA NmComple			AS STRING
	WSDATA NomePai			AS STRING
	WSDATA Pais				AS STRING
	WSDATA DescPais			AS STRING
	WSDATA CodSexo			AS STRING
	WSDATA Situacao			AS STRING
		
ENDWSSTRUCT

WSSERVICE WS007 DESCRIPTION "Consultas CADSUS - CNS e CNES " NAMESPACE "WS007"
	
	//-----------------------------------------------------
	//Lista das estruturas de retorno do webservice
	//-----------------------------------------------------
	WSDATA tRet 		AS StrRetCnes 	//Lista Tipos de Serviços
	WSDATA tRetCNS 		AS StrRetCns 	//Lista Tipos de Serviços
	//-----------------------------------------------------
	//Parametros de entrada do serviço
	//-----------------------------------------------------
	WSDATA _cEmp		AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado na Inclusão de Protocolos
	WSDATA _cFil 		AS STRING	//Filial - Utilizado na Inclusão de Protocolos
	WSDATA _CNES		AS STRING   optional // Código CNES
	WSDATA _CNPJ		AS STRING   optional // Código CNPJ
	WSDATA _CNS			AS STRING   optional // Código CNES
	WSDATA _CPF			AS STRING   optional // Código CPF
	WSDATA _MAE			AS STRING   optional // Código Mãe
	WSDATA _NOMECOMP	AS STRING   optional // Nome Completo
	//------------------------------
	//Declaração dos Métodos
	//------------------------------
	WSMETHOD WS007A	DESCRIPTION "Método - Consulta CNES."
	WSMETHOD WS007B	DESCRIPTION "Método - Consulta CNS."
	
ENDWSSERVICE

/*
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Metodo para consulta de CNES								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ - WebService                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
WSMETHOD WS007A WSRECEIVE _cEmp,_cFil, _CNES, _CNPJ WSSEND tRet WSSERVICE WS007
	
	Local lRet          := .T.
	Local oTemp			:= Nil
	Local oTel			:= Nil
	Local aDados 		:= {}
	Local _cAlias		:= GetNextAlias()
	
	conout("Entrada: "+time())
	//------------------
	//Nao consome licenças
	//------------------
	RPCSetType(3)  //
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	RpcClearEnv()
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automáticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(self:_cEmp),cValToChar(self:_cFil))
		
		//-------------------------------------------------------------------
		// Retorna os dados da empresa de acordo com o cnpj ou cnes passado
		// Localizada no PRW ConsultaCNES
		//-------------------------------------------------------------------
		aDados := u_ConsCnes(cValToChar(::_CNES),cValtoChar(::_CNPJ))
		
		if valtype(aDados) == "A" .and. len(aDados[1]) > 0 .and. Empty(aDados[2])
			//-------------------------------------------
			// Atribui a informação a variavel
			// da classe que será montada para retorno
			//-------------------------------------------
			oTemp := WsClassNew("StrRetCnes")
			
			oTemp:bairro					:= aDados[1][1][1]
			oTemp:complemento				:= aDados[1][1][2]
			oTemp:codigoMunicipio			:= aDados[1][1][3]
			oTemp:nomeMunicipio				:= aDados[1][1][4]
			oTemp:codigoUF					:= aDados[1][1][5]
			
			BeginSql Alias _cAlias
				
				SELECT X5_DESCRI
				FROM %table:SX5% SX5
				WHERE
				X5_TABELA = '12'
				AND X5_CHAVE = %exp:aDados[1][1][5]%
				AND SX5.D_E_L_E_T_ = ' '
			EndSql
			
			if (_cAlias)->(!Eof())
				oTemp:siglaUF			 	:= (_cAlias)->X5_DESCRI
			else
				oTemp:siglaUF			 	:= ' '
			endif
			
			oTemp:nomeLogradouro 			:= aDados[1][1][6]
			oTemp:numeroLogradouro 			:= aDados[1][1][7]
			oTemp:cep						:= aDados[1][1][8]
			oTemp:codigoUnidade 			:= aDados[1][1][9]
			
			oTemp:nDtAtua					:= aDados[1][1][10]
			oTemp:email						:= aDados[1][1][11]
			oTemp:nomeEmpresarial			:= aDados[1][1][12]
			oTemp:nomeFantasia				:= aDados[1][1][13]
			oTemp:Sus						:= aDados[1][1][14]
			oTemp:diretorCPF				:= aDados[1][1][15]
			oTemp:diretorNome				:= aDados[1][1][16]
			oTemp:tipoUnidadecodigo			:= aDados[1][1][17]
			oTemp:tipoUnidadedescricao		:= aDados[1][1][18]
			oTemp:codigoCNES				:= aDados[1][1][19]
			oTemp:cnpj						:= aDados[1][1][20]
			
			oTemp:telefone       := {}
			
			For nX := 1 to len(aDados[1][1][21])
				
				oTel 				 := WsClassNew("tTelefone")
				
				oTel:ddd					:=	aDados[1][1][21][nX][1]
				oTel:numeroTelefone			:=	aDados[1][1][21][nX][2]
				oTel:descricaoTipoTelefone 	:= 	aDados[1][1][21][nX][3]
				
				AAdd(oTemp:telefone,oTel)
				
			Next nX
			
			oTemp:Latitude 					:= aDados[1][1][22]
			oTemp:Longitude 				:= aDados[1][1][23]
			//---------------------------------------
			// Atribui Objeto da classe StrRetCnes
			// ao objeto de retorno tRet
			//---------------------------------------
			::tRet := oTemp
		else
			lRet          := .F.
			SetSoapFault( ProcName() , "Descrição: "+cvaltochar(aDados[2]) )
		EndIf
	else
		lRet          := .F.
		SetSoapFault( ProcName() , "Não foi possível iniciar o ambiente." )
	endif
	
Return lRet


/*
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Metodo para consulta de CNS							      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ - WebService                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/	
WSMETHOD WS007B WSRECEIVE _cEmp,_cFil, _CPF,_MAE,_NOMECOMP WSSEND tRetCNS WSSERVICE WS007
	
	Local lRet          := .T.
	Local oTemp			:= Nil
	Local oTel			:= Nil
	Local aDados 		:= {}
	Local _cAlias		:= GetNextAlias()
	
	conout("Entrada: "+time())
	//------------------
	//Nao consome licenças
	//------------------
	  //
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	RpcClearEnv()
	RPCSetType(3)
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automáticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(self:_cEmp),cValToChar(self:_cFil))
		
		//-------------------------------------------------------------------
		// Retorna os dados da empresa de acordo com o cnpj ou cnes passado
		// Localizada no PRW ConsultaCNES
		//-------------------------------------------------------------------
		aDados := u_ConsCNS(cValToChar(::_CPF),cValToChar(::_NOMECOMP),cValToChar(::_MAE))
		
		if valtype(aDados) == "A" .and. len(aDados[1]) > 0 
			//-------------------------------------------
			// Atribui a informação a variavel
			// da classe que será montada para retorno
			//-------------------------------------------
			oTemp := WsClassNew("StrRetCns")
			
				oTemp:CNS 		:= aDados[1][1][1]
				oTemp:DTNASC 	:= aDados[1][1][2]
				oTemp:PGrauQld	:= aDados[1][1][3]
				oTemp:NumIdCrp	:= aDados[1][1][4]
				oTemp:NomeMae	:= aDados[1][1][5]
				oTemp:CodMun 	:= aDados[1][1][6]
				oTemp:NomeMun 	:= aDados[1][1][7]
				oTemp:CodUF		:= aDados[1][1][8]
				oTemp:UF		:= aDados[1][1][9]
				oTemp:NmComple	:= aDados[1][1][10]
				oTemp:NomePai	:= aDados[1][1][11]
				oTemp:Pais		:= aDados[1][1][12]
				oTemp:DescPais	:= aDados[1][1][13]
				oTemp:CodSexo	:= aDados[1][1][14]
				oTemp:Situacao	:= aDados[1][1][15]
			
			//---------------------------------------
			// Atribui Objeto da classe StrRetCnes
			// ao objeto de retorno tRet
			//---------------------------------------
			::tRetCNS := oTemp
		else
			lRet          := .F.
			SetSoapFault( ProcName() , "Descrição: "+cvaltochar(aDados[2]) )
		EndIf
	else
		lRet          := .F.
		SetSoapFault( ProcName() , "Não foi possível iniciar o ambiente." )
	endif
	
Return lRet