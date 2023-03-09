#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)


/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descri็ใo 	WebService criado para ser utilizado no processo de consulta CNS e CNES

---------------------------------------------------------------------------------- */
User Function WS008()
	
Return

WSSTRUCT tCRM
	
	WSDATA crm			AS STRING
	WSDATA especialidade AS STRING
	WSDATA nome 		AS STRING
	wsdata situacao 	as string
	wsdata uf			as string
	wsdata cpf			as string
	
ENDWSSTRUCT



WSSERVICE WS008 DESCRIPTION "Consulta CRM " NAMESPACE "WS008"
	
	//-----------------------------------------------------
	//Lista das estruturas de retorno do webservice
	//-----------------------------------------------------
	WSDATA tRet 		AS tCRM 	//Lista Tipos de Servi็os
	
	//-----------------------------------------------------
	//Parametros de entrada do servi็o
	//-----------------------------------------------------
	WSDATA _cEmp	AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado na Inclusใo de Protocolos
	WSDATA _cFil 	AS STRING	//Filial - Utilizado na Inclusใo de Protocolos
	WSDATA _CRM		AS integer   optional // CRM
	WSDATA _UF		AS STRING   optional // UNIDADE FEDERATIVA
	WSDATA _SIG		AS STRING   optional // SIGLA DO CONSELHO (EX: CRM, CRP, COREN E CREFITO) //Angelo Henrique - Data: 26/08/2019
	//------------------------------
	//Declara็ใo dos M้todos
	//------------------------------
	WSMETHOD WS008A	DESCRIPTION "M้todo - Consulta CRM."
	WSMETHOD WS008B	DESCRIPTION "M้todo - Consulta CRM - QUARTERIZADA."
	
ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta de tipo de servi็os - protocolo de    บฑฑ
ฑฑบ          ณ atendimento.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS008A WSRECEIVE _cEmp,_cFil, _CRM, _UF, _SIG WSSEND tRet WSSERVICE WS008
	
	Local lRet          := .T.
	Local oTemp			:= Nil
	Local oTel			:= Nil
	Local aDados 		:= {}
	Local _cAlias		:= GetNextAlias()
	Local cCpf 			:= ""
	
	conout("Entrada: "+time())
	//------------------
	//Nao consome licen็as
	//------------------
	RPCSetType(3) 
	
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	//RpcClearEnv()
	
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automแticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(self:_cEmp),cValToChar(self:_cFil))
		
		//-----------------------------------------------
		//Angelo Henrique - Data: 26/08/19
		//-----------------------------------------------
		//Acrescentando informa็๕es na busca
		//-----------------------------------------------
		If self:_SIG == "CRM"
			
			aDados := u_Conspf(self:_CRM,self:_UF)
			
			if len(aDados) > 0
				
				if len(aDados[1]) > 0
					
					_cQuery:= "	SELECT NVL(BB0_CGC,' ') BB0_CGC,														" + cEnt
					_cQuery+= "				(SELECT COUNT(BB0_CGC) FROM "+RetSqlName("BB0")+"							"+ cEnt
					_cQuery+= "						WHERE BB0_NUMCR   LIKE '%"+aDados[1][1][1]+"%' AND D_E_L_E_T_ = ' '	" + cEnt
					_cQuery += "AND BB0_FILIAL = '"+xFilial("BB0")+"' 													" + cEnt
					_cQuery += "AND BB0_CODBLO = ' ' AND BB0_DATBLO = ' '	AND BB0_CODBLO = ' ') CONT					" + cEnt
					_cQuery+= "						FROM "+RetSqlName("BB0")+" BB0										"+ cEnt
					_cQuery+= "						WHERE BB0_NUMCR   LIKE '%"+aDados[1][1][1]+"%' 						"+ cEnt
					_cQuery += "AND BB0_FILIAL = '"+xFilial("BB0")+"' AND BB0.D_E_L_E_T_ = ' ' 							" + cEnt
					_cQuery += "AND BB0_CODBLO = ' ' AND BB0_DATBLO = ' '	AND BB0_CODBLO = ' '                        " + cEnt
					
					MpSysOpenquery(_cQuery,_cAlias)
					
					
					if (_cAlias)->(!eof())
						
						Do While (_cAlias)->(!eof())
							
							if !Empty((_cAlias)->BB0_CGC)
								
								cCpf :=   (_cAlias)->BB0_CGC
								Exit
								
							endif
							
							(_cAlias)->(dbskip())
							
						EndDo
						
					endif
					
					if select(_cAlias)	> 0
						dbselectarea(_cAlias)
						dbclosearea()
					endif
					
					oTemp := WsClassNew("tCRM")
					oTemp:crm			:= cvaltochar(aDados[1][1][1])
					oTemp:especialidade := if(len(aDados[1][1][3]) > 0, aDados[1][1][3],'')
					oTemp:nome 			:= UPPER(aDados[1][1][4])
					oTemp:situacao 	    := aDados[1][1][5]
					oTemp:uf            := aDados[1][1][7]
					oTemp:cpf           := IIF(Empty(cCpf),IIF(TYPE('aDados[1][1][8]') = 'U', ' ', aDados[1][1][8]),cCpf)
					
					::tRet := oTemp
				else
					lRet          := .F.
					SetSoapFault( ProcName() , "Profissional nใo encontrado. ")
				endif
				
			EndIf
			
		Else
			
			//-----------------------------------------------------
			//Angelo Henrique - Data: 26/08/2019
			//-----------------------------------------------------
			//Caso nใo seja CRM deve-se olhar direto no PROTHEUS
			//-----------------------------------------------------
			
			_cQuery := " SELECT														" + cEnt
			_cQuery += " 	BB0.BB0_NUMCR,											" + cEnt
			_cQuery += " 	BB0.BB0_CODSIG,											" + cEnt
			_cQuery += " 	BB0.BB0_NOME,											" + cEnt
			_cQuery += " 	' ' SITUACAO,											" + cEnt
			_cQuery += " 	BB0.BB0_ESTADO,											" + cEnt
			_cQuery += " 	NVL(BB0.BB0_CGC,' ') BB0_CGC							" + cEnt
			_cQuery += " FROM														" + cEnt
			_cQuery += " 	" + RetSqlName("BB0") + " BB0							" + cEnt
			_cQuery += " WHERE														" + cEnt
			_cQuery += " 	BB0.BB0_NUMCR   LIKE '%" + cValToChar(self:_CRM) + "%'	" + cEnt
			_cQuery += " 	AND BB0.BB0_CODSIG  = '" + self:_SIG  			 + "' 	" + cEnt
			_cQuery += " 	AND BB0.BB0_ESTADO  = '" + self:_UF    			 + "' 	" + cEnt
			_cQuery += "	AND BB0.BB0_FILIAL	= '" + xFilial("BB0") 		 + "' 	" + cEnt
			_cQuery += "	AND BB0.BB0_CODBLO	= ' ' 								" + cEnt
			_cQuery += "	AND BB0.BB0_DATBLO	= ' '								" + cEnt
			_cQuery += "	AND BB0.BB0_CODBLO	= ' '                       		" + cEnt
			_cQuery += "	AND BB0.D_E_L_E_T_ 	= ' ' 								" + cEnt
			
			MpSysOpenquery(_cQuery,_cAlias)
			
			if (_cAlias)->(!eof())
				
				Do While (_cAlias)->(!eof())
					
					if !Empty((_cAlias)->BB0_CGC)
						
						oTemp := WsClassNew("tCRM")
						oTemp:crm			:= AllTrim((_cAlias)->BB0_NUMCR)
						oTemp:especialidade := AllTrim((_cAlias)->BB0_CODSIG)
						oTemp:nome 			:= AllTrim((_cAlias)->BB0_NOME)
						oTemp:situacao 	    := (_cAlias)->SITUACAO
						oTemp:uf            := AllTrim((_cAlias)->BB0_ESTADO)
						oTemp:cpf           := AllTrim((_cAlias)->BB0_CGC)
						
						::tRet := oTemp
						
						Exit
						
					endif
					
					(_cAlias)->(dbskip())
					
				EndDo
				
				if select(_cAlias)	> 0
					dbselectarea(_cAlias)
					dbclosearea()
				endif
				
			Else
				
				lRet          := .F.
				SetSoapFault( ProcName() , "Nใo possํvel encontrar o profissional")
				
			EndIf
			
		EndIf
		
	Else
		
		lRet          := .F.
		SetSoapFault( ProcName() , "Nใo possํvel conectar na empresa")
		
	EndIf
	
Return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consultar CRM							      บฑฑ
ฑฑบ          ณ atendimento.                                   			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
// Quarteirizando o servi็o
WSMETHOD WS008B WSRECEIVE _cEmp,_cFil, _CRM, _UF, _SIG  WSSEND tRet WSSERVICE WS008
	
	Local lRet          := .T.
	Local oTemp			:= Nil
	Local oTel			:= Nil
	Local aDados 		:= {}
	Local oDados 		:= Nil
	Local _cAlias		:= GetNextAlias()
	Local cCpf 			:= ""
	
	conout("Entrada: "+time())
	//------------------
	//Nao consome licen็as
	//------------------
	RPCSetType(3)  //
	//-------------------------------------------------------------------
	//Limpa Ambiente
	//-------------------------------------------------------------------
	RpcClearEnv()
	
	//-------------------------------------------------------------------
	//Abertura do ambiente em rotinas automแticas
	//-------------------------------------------------------------------
	if RpcSetEnv(cValToChar(self:_cEmp),cValToChar(self:_cFil))
		
		oDados := u_CRMWSDL(::_CRM,::_UF,::_SIG)
		
		If valtype(oDados) == "O"
			
			If valtype(oDados:cNome) != "U"
				
				oTemp := WsClassNew("tCRM")
				oTemp:crm			:= cvaltochar(oDados:cCRM)
				oTemp:especialidade := oDados:cEspecialidade
				oTemp:nome 			:= oDados:cNome
				oTemp:situacao 	    := oDados:cSituacao
				oTemp:uf            := oDados:cUf
				oTemp:cpf           := oDados:cCpf
				
				::tRet := oTemp
				
			Else
				
				lRet          := .F.
				SetSoapFault( ProcName() , "CRM nใo encontrado." )
				
			EndIf
						
		Else
		
			lRet          := .F.
			SetSoapFault( ProcName() , "CRM nใo encontrado." )
			
		EndIf
		
	EndIf
	
Return lRet