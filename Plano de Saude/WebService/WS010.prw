#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS010    บAutor  ณAngelo Henrique     บ Data ณ  03/11/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para ser utilizado no processo de FALE    บฑฑ
ฑฑบDesc.     ณCONOSCO do protocolo de atendimento.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fabrica de Software                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WS010()
	
Return

//--------------------------------------------------------------
//Estrutura de retorno utilizada para o CEP (M้todo WS010CEP)
//--------------------------------------------------------------
WSSTRUCT StrCep
	
	WSDATA _cCep	AS String //01 - CEP
	WSDATA _cEnd	AS String //02 - Endere็o
	WSDATA _cCdMun	AS String //03 - Codigo do Municipio
	WSDATA _cMun	AS String //04 - Descri็ใo do Municipio
	WSDATA _cBair	AS String //05 - Bairro
	WSDATA _cEst	AS String //06 - Estado
	WSDATA _cCdLog	AS String //07 - Codigo do Logradouro
	WSDATA _cLog	AS String //08 - Logradouro
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do prestador(RDA) - (M้todo WS010RDA)
//--------------------------------------------------------------
WSSTRUCT StrRda
	
	WSDATA _cNome		AS String //01 - Nome
	WSDATA _cFantasia 	AS String //02 - Nome Fantasia
	WSDATA _cCpfcgc 	AS String //03 - CPF/CGC
	WSDATA _cNasci 		AS Date   //04 - Data de Nascimento
	WSDATA _cDtini 		AS Date   //05 - Data de Inicio
	WSDATA _cDtcon 		AS Date	  //06 - Data de Contrato
	WSDATA _cNacion  	AS String //07 - Nacionalidade
	WSDATA _cCep 		AS String //08 - CEP
	WSDATA _cLogra 		AS String //09 - Logradouro
	WSDATA _cEnder 		AS String //10 - Endere็o
	WSDATA _cNumero 	AS String //11 - Numero
	WSDATA _cComplem  	AS String //12 - Complemento
	WSDATA _cBairro 	AS String //13 - Bairro
	WSDATA _cMunic 		AS String //14 - Codigo do Municipio
	WSDATA _cDscmun 	AS String //15 - Descri็ใo do Municipio
	WSDATA _cEstado    	AS String //16 - Estado
	WSDATA _cEmail 		AS String //17 - E-mail
	WSDATA _cTelef 		AS String //18 - Telefone
	WSDATA _cSexo 		AS String //19 - Sexo
	WSDATA _cInss 		AS String //21 - INSS(NIS/PIS)
	WSDATA _cGrau 		AS String //22 - Grau de Instru็ใo
	WSDATA _cRaca 		AS String //23 - Ra็a/Cor
	WSDATA _cPais	 	AS String //24 - Paํs
	WSDATA _cSocia	 	AS String //25 - Nome Social
	WSDATA _cDtWeb	 	AS Date //26 - Data de Altera็ใo efetuada pelo prestador
	WSDATA _cDtNeg	 	AS Date //27 - Data em que o prestador Negou realizar a altera็ใo
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do prestador(RDA) - (M้todo WS010FIS)
//--------------------------------------------------------------
WSSTRUCT StrFis
	
	WSDATA _cRDA		AS String //01 - Codigo do Prestador
	WSDATA _cNacion  	AS String //02 - Nacionalidade
	WSDATA _cCep 		AS String //03 - CEP
	WSDATA _cEnder 		AS String //04 - Endere็o
	WSDATA _cNumero 	AS String //05 - Numero
	WSDATA _cComplem  	AS String //06 - Complemento
	WSDATA _cBairro 	AS String //07 - Bairro
	WSDATA _cMunic 		AS String //08 - Codigo do Municipio
	WSDATA _cEstado    	AS String //09 - Estado
	WSDATA _cEmail 		AS String //10 - E-mail
	WSDATA _cTelef 		AS String //11 - Telefone
	WSDATA _cSexo 		AS String //12 - Sexo
	WSDATA _cGrau 		AS String //13 - Grau de Instru็ใo
	WSDATA _cRaca 		AS String //14 - Ra็a/Cor
	WSDATA _cPais	 	AS String //15 - Codigo do Paํs
	WSDATA _cSocia	 	AS String //16 - Nome Social
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do prestador(RDA) - (M้todo WS010JUR)
//--------------------------------------------------------------
WSSTRUCT StrJur
	
	WSDATA _cRDA		AS String //01 - Codigo do Prestador
	WSDATA _cEmail 		AS String //10 - E-mail
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do Paํs - (M้todo WS010PAI)
//--------------------------------------------------------------
WSSTRUCT StrPai
	
	WSDATA _cCodigo		AS String
	WSDATA _cDescri		AS String
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do Grau de Parentesco - (M้todo WS010GRA)
//--------------------------------------------------------------
WSSTRUCT StrGra
	
	WSDATA _cCodigo		AS String
	WSDATA _cDescri		AS String
	
ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para retornar informa็๕es
//do prestador(RDA) que negou atualizar - (M้todo WS010NEG)
//--------------------------------------------------------------
WSSTRUCT StrNeg
	
	WSDATA _cRDA		AS String
	
ENDWSSTRUCT


WSSERVICE WS010 DESCRIPTION "Atualiza็ใo de Prestadores - <b>Recadastramento</b>" NAMESPACE "WS010"
	
	//-----------------------------------------------------
	//Lista das estruturas de retorno do webservice
	//-----------------------------------------------------
	WSDATA tRet 		AS Array of StrCep 	//Consulta CEP
	WSDATA tRda 		AS Array of StrRda 	//Consulta RDA (Prestador)
	WSDATA tPai 		AS Array of StrPai 	//Consulta Paํs
	WSDATA tGra 		AS Array of StrGra 	//Consulta Grau Parentesco
	
	//-----------------------------------------------------
	//Lista das estruturas de recebimento do webservice
	//-----------------------------------------------------
	WSDATA tFis 		AS StrFis 	//Altera RDA (Prestador)
	WSDATA tJur 		AS StrJur 	//Altera RDA (Prestador)
	WSDATA tNeg 		AS StrNeg 	//Consulta Grau Parentesco
	
	//-----------------------------------------------------
	//Lista dos parametros de recebimento
	//-----------------------------------------------------
	WSDATA _cEmpInc		AS STRING	//Empresa que o sistema irแ realizar login para buscar as informa็๕es
	WSDATA _cCep		AS STRING 	//CEP recebido para o m้todo WS010CEP (Consulta de CEP)
	WSDATA _cRda		AS STRING 	//Codigo do Prestador (RDA) recebido para o m้todo WS010RDA (Consulta de Prestador)
	WSDATA _cPais		AS STRING 	//Codigo do Paํs a ser consultado m้todo WS010PAI (Consulta Paํs)
	WSDATA _cGra 		AS STRING 	//Codigo do Paํs a ser consultado m้todo WS010GRA (Consulta Grau Parentesco)
	
	//-----------------------------------------------------
	//Lista dos parametros enviados
	//-----------------------------------------------------
	WSDATA _cRetFis		AS STRING 	//Cont้m o OK de que foi incluํdo com sucesso - WS010FIS
	WSDATA _cRetJur		AS STRING 	//Cont้m o OK de que foi incluํdo com sucesso - WS010JUR
	WSDATA _cRetNeg		AS STRING 	//Cont้m o OK de que foi incluํdo com sucesso - WS010NEG
	
	//-----------------------------------------------------
	//Declara็ใo dos M้todos
	//-----------------------------------------------------
	WSMETHOD WS010CEP	DESCRIPTION "M้todo - Consulta CEP."
	WSMETHOD WS010RDA	DESCRIPTION "M้todo - Consulta Prestador."
	WSMETHOD WS010FIS	DESCRIPTION "M้todo - Altera็ใo Prestador (Fisico)."
	WSMETHOD WS010JUR	DESCRIPTION "M้todo - Altera็ใo Prestador (Juridico)."
	WSMETHOD WS010PAI	DESCRIPTION "M้todo - Consulta Paํs."
	WSMETHOD WS010GRA	DESCRIPTION "M้todo - Consulta Grau Parentesco."
	WSMETHOD WS010NEG	DESCRIPTION "M้todo - Confirma que o prestador negou preencher os dados."
	
ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do CEP informado.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010CEP WSRECEIVE _cEmpInc, _cCep WSSEND tRet WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAlias1 := GetNextAlias()
		
		//----------------------------------------------------------
		//Traz as informa็๕es referente ao CEP consultado.
		//----------------------------------------------------------
		_cQuery := " SELECT 										" + cEnt
		_cQuery += "	BC9.BC9_CEP CEP,							" + cEnt
		_cQuery += "	TRIM(BC9.BC9_END) ENDER,					" + cEnt
		_cQuery += "	BC9.BC9_CODMUN CDMUNIC,						" + cEnt
		_cQuery += "	TRIM(BC9.BC9_MUN) MUNIC,					" + cEnt
		_cQuery += "	BC9.BC9_BAIRRO BAIRRO,						" + cEnt
		_cQuery += "	BC9.BC9_EST ESTADO,							" + cEnt
		_cQuery += "	NVL(B18.B18_CODIGO, ' ') CDLOG,				" + cEnt
		_cQuery += "	NVL(TRIM(B18.B18_DESCRI), ' ') LOGRAD		" + cEnt
		_cQuery += " FROM											" + cEnt
		_cQuery += " 	" + RetSqlName("BC9") + " BC9 				" + cEnt
		_cQuery += "	LEFT JOIN									" + cEnt
		_cQuery += " 		" + RetSqlName("B18") + " B18 			" + cEnt
		_cQuery += "	ON											" + cEnt
		_cQuery += "		B18_FILIAL = '" + xFilial("B18") + "'	" + cEnt
		_cQuery += "		AND B18_CODIGO = BC9.BC9_TIPLOG			" + cEnt
		_cQuery += "		AND B18.D_E_L_E_T_ = ' '				" + cEnt
		_cQuery += " WHERE											" + cEnt
		_cQuery += " 	BC9.BC9_FILIAL = '" + xFilial("BC9") + "'	" + cEnt
		_cQuery += " 	AND BC9.D_E_L_E_T_ = ' '					" + cEnt
		_cQuery += " 	AND BC9.BC9_CEP = '" + _cCep + "'			" + cEnt
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		PLSQuery(_cQuery,_cAlias1)
		
		If (_cAlias1)->(EOF())
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum CEP para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		While !(_cAlias1)->(EOF())
			
			oTemp := WsClassNew("StrCep")
			
			oTemp:_cCep 	:= Alltrim((_cAlias1)->CEP		)
			oTemp:_cEnd 	:= Alltrim((_cAlias1)->ENDER	)
			oTemp:_cCdMun	:= Alltrim((_cAlias1)->CDMUNIC	)
			oTemp:_cMun		:= Alltrim((_cAlias1)->MUNIC	)
			oTemp:_cBair	:= Alltrim((_cAlias1)->BAIRRO	)
			oTemp:_cEst		:= Alltrim((_cAlias1)->ESTADO	)
			oTemp:_cCdLog	:= Alltrim((_cAlias1)->CDLOG	)
			oTemp:_cLog		:= Alltrim((_cAlias1)->LOGRAD 	)
			
			aAdd( ::tRet , oTemp)
			
			(_cAlias1)->(DbSkip())
			
		EndDo
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
	EndIf
	
Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do Prestador informado.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010RDA WSRECEIVE _cEmpInc, _cRda WSSEND tRda WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAlias1 := GetNextAlias()
		
		//----------------------------------------------------------
		//Traz as informa็๕es referente ao CEP consultado.
		//----------------------------------------------------------
		_cQuery := " SELECT 															" + cEnt
		_cQuery += "	TRIM(BAU.BAU_NOME) NOME,										" + cEnt
		_cQuery += "	TRIM(BAU.BAU_NFANTA) FANTASIA,									" + cEnt
		_cQuery += "	BAU.BAU_CPFCGC CPFCGC,											" + cEnt
		_cQuery += "	BAU.BAU_NASFUN NASCI,											" + cEnt
		_cQuery += "	BAU.BAU_DTINSE DTINI,											" + cEnt
		_cQuery += "	BAU.BAU_DTINCT DTCON,											" + cEnt
		_cQuery += "	BAU.BAU_NACION NACION,											" + cEnt
		_cQuery += "	BAU.BAU_CEP CEP,												" + cEnt
		_cQuery += "	NVL(TRIM(B18.B18_DESCRI),' ') LOGRA,							" + cEnt
		_cQuery += "	BAU.BAU_END ENDER,												" + cEnt
		_cQuery += "	BAU.BAU_NUMERO NUMERO,											" + cEnt
		_cQuery += "	BAU.BAU_YCPEND COMPLEM,											" + cEnt
		_cQuery += "	BAU.BAU_BAIRRO BAIRRO,											" + cEnt
		_cQuery += "	BAU.BAU_MUN MUNIC,												" + cEnt
		_cQuery += "	TRIM(BID.BID_DESCRI) DSCMUN,									" + cEnt
		_cQuery += "	BAU.BAU_EST ESTADO,												" + cEnt
		_cQuery += "	BAU.BAU_EMAIL EMAIL,											" + cEnt
		_cQuery += "	BAU.BAU_TEL TELEF,												" + cEnt
		_cQuery += "	BAU.BAU_SEXO SEXO,												" + cEnt
		_cQuery += "	BAU.BAU_INSS INSS,												" + cEnt
		_cQuery += "	BAU.BAU_XGRAUI GRAU,											" + cEnt
		_cQuery += "	BAU.BAU_XRACAC RACA,											" + cEnt		
		_cQuery += "	BAU.BAU_XPAISO PAISORIG,										" + cEnt
		_cQuery += "	BAU.BAU_XSOCIA SOCIAL,											" + cEnt
		_cQuery += "	SIGA.FORMATA_DATA_MS(BAU.BAU_XDTWEB) DTWEB,						" + cEnt
		_cQuery += "	SIGA.FORMATA_DATA_MS(BAU.BAU_XDTNEG) DTNEG						" + cEnt
		_cQuery += " FROM																" + cEnt
		_cQuery += " 	" + RetSqlName("BAU") + " BAU 									" + cEnt
		_cQuery += "	INNER JOIN														" + cEnt
		_cQuery += " 	" + RetSqlName("BID") + " BID 									" + cEnt
		_cQuery += "	ON																" + cEnt
		_cQuery += "		BID.BID_FILIAL = '" + xFilial("BID") + "'					" + cEnt
		_cQuery += "	AND BID.BID_CODMUN = BAU.BAU_MUN								" + cEnt
		_cQuery += "	LEFT JOIN														" + cEnt
		_cQuery += " 	" + RetSqlName("BC9") + " BC9 									" + cEnt
		_cQuery += "	ON																" + cEnt
		_cQuery += "		BC9.BC9_FILIAL = '" + xFilial("BC9") + "'					" + cEnt
		_cQuery += "	AND BC9.BC9_CEP = BAU.BAU_CEP									" + cEnt
		_cQuery += "	AND BC9.D_E_L_E_T_ = ' '										" + cEnt
		_cQuery += "	LEFT JOIN														" + cEnt
		_cQuery += " 	" + RetSqlName("B18") + " B18 									" + cEnt
		_cQuery += "	ON																" + cEnt
		_cQuery += "		B18.B18_FILIAL = '" + xFilial("B18") + "'					" + cEnt
		_cQuery += "	AND B18.B18_CODIGO = BC9.BC9_TIPLOG								" + cEnt
		_cQuery += "	AND B18.D_E_L_E_T_ = ' '										" + cEnt
		_cQuery += " WHERE																" + cEnt
		_cQuery += "		BAU.BAU_FILIAL = '" + xFilial("BAU") + "'					" + cEnt
		_cQuery += "	AND BAU.D_E_L_E_T_ = ' '										" + cEnt
		_cQuery += "	AND BAU.BAU_CODIGO = '" + _cRda + "'							" + cEnt
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		PLSQuery(_cQuery,_cAlias1)
		
		If (_cAlias1)->(EOF())
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum tipo de servi็o para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		While !(_cAlias1)->(EOF())
			
			oTemp := WsClassNew("StrRda")
			
			oTemp:_cNome		:= Alltrim((_cAlias1)->NOME		) + " "
			oTemp:_cFantasia	:= Alltrim((_cAlias1)->FANTASIA	) + " "
			oTemp:_cCpfcgc 		:= Alltrim((_cAlias1)->CPFCGC	) + " "
			oTemp:_cNasci 		:= STOD((_cAlias1)->NASCI		)
			oTemp:_cDtini 		:= STOD((_cAlias1)->DTINI		)
			oTemp:_cDtcon 		:= STOD((_cAlias1)->DTCON		)
			oTemp:_cNacion  	:= Alltrim((_cAlias1)->NACION	) + " "
			oTemp:_cCep 		:= Alltrim((_cAlias1)->CEP		) + " "
			oTemp:_cLogra 		:= Alltrim((_cAlias1)->LOGRA	) + " "
			oTemp:_cEnder 		:= Alltrim((_cAlias1)->ENDER	) + " "
			oTemp:_cNumero 		:= Alltrim((_cAlias1)->NUMERO	) + " "
			oTemp:_cComplem		:= Alltrim((_cAlias1)->COMPLEM	) + " "
			oTemp:_cBairro		:= Alltrim((_cAlias1)->BAIRRO	) + " "
			oTemp:_cMunic 		:= Alltrim((_cAlias1)->MUNIC	) + " "
			oTemp:_cDscmun		:= Alltrim((_cAlias1)->DSCMUN	) + " "
			oTemp:_cEstado		:= Alltrim((_cAlias1)->ESTADO	) + " "
			oTemp:_cEmail 		:= Alltrim((_cAlias1)->EMAIL	) + " "
			oTemp:_cTelef 		:= Alltrim((_cAlias1)->TELEF	) + " "
			oTemp:_cSexo		:= Alltrim((_cAlias1)->SEXO		) + " "
			oTemp:_cInss 		:= Alltrim((_cAlias1)->INSS		) + " "
			oTemp:_cGrau 		:= Alltrim((_cAlias1)->GRAU		) + " "
			oTemp:_cRaca 		:= Alltrim((_cAlias1)->RACA		) + " "
			oTemp:_cPais	 	:= Alltrim((_cAlias1)->PAISORIG	) + " "
			oTemp:_cSocia	 	:= Alltrim((_cAlias1)->SOCIAL	) + " "
			oTemp:_cDtWeb	 	:= STOD((_cAlias1)->DTWEB		) 
			oTemp:_cDtNeg	 	:= STOD((_cAlias1)->DTNEG		) 
			
			aAdd( ::tRda , oTemp)
			
			(_cAlias1)->(DbSkip())
			
		EndDo
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
	EndIf
	
Return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para alterar o   Prestador informado.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010FIS WSRECEIVE _cEmpInc, tFis WSSEND _cRetFis WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cRda			:= tFis:_cRda
	Local _cNacion  	:= tFis:_cNacion
	Local _cCep 		:= tFis:_cCep
	Local _cEnder 		:= tFis:_cEnder
	Local _cNumero 		:= tFis:_cNumero
	Local _cComplem		:= tFis:_cComplem
	Local _cBairro		:= tFis:_cBairro
	Local _cMunic 		:= tFis:_cMunic
	Local _cEstado		:= tFis:_cEstado
	Local _cEmail 		:= tFis:_cEmail
	Local _cTelef		:= tFis:_cTelef
	Local _cSexo		:= tFis:_cSexo
	Local _cGrau 		:= tFis:_cGrau
	Local _cRaca 		:= tFis:_cRaca
	Local _cPais	 	:= tFis:_cPais
	Local _cSocia	 	:= tFis:_cSocia
	Local _cTpLog		:= ""
	Local _cAliBAU		:= ""
	Local _cAliBC9		:= ""
	Local _cAliB18		:= ""	
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAliBAU := BAU->(GetArea())
		
		DbSelectArea("BAU")
		DbSetOrder(1)
		If DbSeek(xFilial("BAU") + _cRda)
			
			//----------------------------------------------------------------------
			//Antes de atualizar as datas no Protheus, gravar na tabela de Log
			//as informa็๕es atuais do prestador
			//----------------------------------------------------------------------
			If GravaLog(_cEmpInc)
			
				//---------------------------------------------------------
				//Inicio - Pegando o tipo de logradouro cadastrado
				//---------------------------------------------------------				
				_cAliBC9 := BC9->(GetArea())
								
				DbSelectArea("BC9")
				DbSetOrder(1)
				If DbSeek(xFilial("BC9") + _cCep)
					
					_cAliB18 := B18->(GetArea())
									
					DbSelectArea("B18")
					DbSetOrder(1)
					If DbSeek(xFilial("B18") + BC9->BC9_TIPLOG)
						
						_cTpLog := B18->B18_CODIGO
					
					EndIf
					
					RestArea(_cAliB18)
				
				EndIf
				
				RestArea(_cAliBC9)
				//---------------------------------------------------------
				//Fim - Pegando o tipo de logradouro cadastrado
				//---------------------------------------------------------								
				
				//---------------------------------------------------------
				//Realizando a grava็ใo na tabela de prestadores
				//---------------------------------------------------------				
				RecLock("BAU", .F.)
				
				BAU->BAU_NACION := _cNacion
				BAU->BAU_CEP 	:= _cCep				
				BAU->BAU_END 	:= _cEnder
				BAU->BAU_TIPLOG	:= _cTpLog
				BAU->BAU_NUMERO := _cNumero
				BAU->BAU_YCPEND := _cComplem
				BAU->BAU_BAIRRO := _cBairro
				BAU->BAU_MUN 	:= _cMunic
				BAU->BAU_EST 	:= _cEstado
				BAU->BAU_EMAIL	:= _cEmail
				BAU->BAU_TEL 	:= _cTelef
				BAU->BAU_SEXO 	:= _cSexo
				BAU->BAU_XGRAUI	:= _cGrau
				BAU->BAU_XRACAC	:= _cRaca
				BAU->BAU_XPAISO	:= _cPais
				BAU->BAU_XSOCIA	:= _cSocia
				BAU->BAU_XDTWEB	:= dDataBase
				
				MsUnlock()
				
				GravaLog(_cEmpInc)
				
				::_cRetFis := "Alterado com sucesso."
				
			Else
				
				SetSoapFault( ProcName() , "Nใo foi possivel gravar informa็๕es na tabela de Log no Oracle." )
				lRet := .F.
				
			EndIf
			
		Else
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum prestador para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		RestArea(_cAliBAU)
		
	EndIf
	
Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para alterar o prestador (Juridico).                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010JUR WSRECEIVE _cEmpInc, tJur WSSEND _cRetJur WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cRda			:= tJur:_cRda
	Local _cEmail 		:= tJur:_cEmail
	Local _cAliBAU		:= ""
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAliBAU := BAU->(GetArea())
		
		DbSelectArea("BAU")
		DbSetOrder(1)
		If DbSeek(xFilial("BAU") + _cRda)
			
			//----------------------------------------------------------------------
			//Antes de atualizar as datas no Protheus, gravar na tabela de Log
			//as informa็๕es atuais do prestador
			//----------------------------------------------------------------------
			If GravaLog(_cEmpInc)
				
				RecLock("BAU", .F.)
				
				BAU->BAU_EMAIL	:= _cEmail
				BAU->BAU_XDTWEB	:= dDataBase
				
				MsUnlock()
				
				GravaLog(_cEmpInc)
				
				::_cRetJur := "Alterado com sucesso."
				
			Else
				
				SetSoapFault( ProcName() , "Nใo foi possivel gravar informa็๕es na tabela de Log no Oracle." )
				lRet := .F.
				
			EndIf
			
		Else
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum prestador para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		RestArea(_cAliBAU)
		
	EndIf
	
Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do paํs informado.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010PAI WSRECEIVE _cEmpInc, _cPais WSSEND tPai WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAlias1 := GetNextAlias()
		
		//----------------------------------------------------------
		//Traz as informa็๕es referente ao Paํs consultado.
		//----------------------------------------------------------
		
		_cQuery := " SELECT											" + cEnt
		_cQuery += "	SYA.YA_CODGI CODIGO,						" + cEnt
		_cQuery += "	TRIM(SYA.YA_DESCR) DESCR					" + cEnt
		_cQuery += " FROM											" + cEnt
		_cQuery += " 	" + RetSqlName("SYA") + " SYA 				" + cEnt
		_cQuery += " WHERE											" + cEnt
		
		If !Empty(_cPais)
			
			_cQuery += "		SYA.YA_CODGI = '" + _cPais + "'		" + cEnt
			_cQuery += "		AND SYA.D_E_L_E_T_ = ' '			" + cEnt
			
		Else
			
			_cQuery += "		SYA.D_E_L_E_T_ = ' '				" + cEnt
			
		EndIf
		
		_cQuery += "	ORDER BY									" + cEnt
		_cQuery += "		YA_DESCR								" + cEnt
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		PLSQuery(_cQuery,_cAlias1)
		
		If (_cAlias1)->(EOF())
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum Pais para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		While !(_cAlias1)->(EOF())
			
			oTemp := WsClassNew("StrPai")
			
			oTemp:_cCodigo 	:= Alltrim((_cAlias1)->CODIGO	)
			oTemp:_cDescri 	:= Alltrim((_cAlias1)->DESCR	)
			
			aAdd( ::tPai , oTemp)
			
			(_cAlias1)->(DbSkip())
			
		EndDo
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
	EndIf
	
Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do grau parentesco                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010GRA WSRECEIVE _cEmpInc, _cGra WSSEND tGra WSSERVICE WS010
	
	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAlias1 := GetNextAlias()
		
		//----------------------------------------------------------
		//Traz as informa็๕es referente ao Paํs consultado.
		//----------------------------------------------------------
		
		_cQuery := " SELECT											" + cEnt
		_cQuery += "	SX5.X5_CHAVE CODIGO,						" + cEnt
		_cQuery += "	TRIM(X5_DESCRI) DESCRI						" + cEnt
		_cQuery += " FROM											" + cEnt
		_cQuery += " 	" + RetSqlName("SX5") + " SX5 				" + cEnt
		_cQuery += " WHERE											" + cEnt
		
		If !Empty(_cGra)
			
			_cQuery += "		SX5.X5_CHAVE = '" + _cGra + "'		" + cEnt
			_cQuery += "		AND SX5.D_E_L_E_T_ = ' '			" + cEnt
			
		Else
			
			_cQuery += "		SX5.D_E_L_E_T_ = ' '				" + cEnt
			
		EndIf
		
		_cQuery += "	AND X5_TABELA = '26'						" + cEnt
		_cQuery += " ORDER BY										" + cEnt
		_cQuery += "		SX5.X5_CHAVE							" + cEnt
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		PLSQuery(_cQuery,_cAlias1)
		
		If (_cAlias1)->(EOF())
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum Pais para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		While !(_cAlias1)->(EOF())
			
			oTemp := WsClassNew("StrGra")
			
			oTemp:_cCodigo 	:= Alltrim((_cAlias1)->CODIGO	)
			oTemp:_cDescri 	:= Alltrim((_cAlias1)->DESCRI	)
			
			aAdd( ::tGra , oTemp)
			
			(_cAlias1)->(DbSkip())
			
		EndDo
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
	EndIf
	
Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para confirmar que o prestador optou por nใo        บฑฑ
ฑฑบ          ณatualizar seus dados cadastrais no site.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS010NEG WSRECEIVE _cEmpInc, tNeg WSSEND _cRetNeg WSSERVICE WS010
	
	Local lRet          := .T.
	Local oTemp			:= Nil
	Local _cRda			:= tNeg:_cRda
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	If Empty(AllTrim(_cEmpInc))
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	ElseIf !(AllTrim(_cEmpInc) $ "01|02")
		
		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema." )
		lRet := .F.
		
	Else
		
		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")
			
			WfPrepEnv(_cEmpInc,"01")
			
		Else
			
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
			
		EndIf
		
		_cAliBAU := BAU->(GetArea())
		
		DbSelectArea("BAU")
		DbSetOrder(1)
		If DbSeek(xFilial("BAU") + _cRda)
			
			RecLock("BAU", .F.)
			
			BAU->BAU_XDTNEG := dDatabase 
			
			MsUnlock()
			
			GravaLog(_cEmpInc,.T.)
			
			::_cRetNeg := "informa็ใo incluํda com sucesso"
			
		Else
			
			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum prestador para os dados enviados." )
			lRet := .F.
			
		EndIf
		
		RestArea(_cAliBAU)
		
	EndIf
	
Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para gravar na tabela de log a posi็ใo    บฑฑ
ฑฑบ          ณatual do prestador antes de atualizar no protheus.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GravaLog(_cEmp,_lNeg)
	
	Local _lRet 	:= .T.
	Local _cQuery	:= ""
	
	Default _cEmp 	:= "01"
	Default _lNeg 	:= .F.
	
	If _cEmp == "01"
	
		_cQuery := " INSERT INTO LOG_BAU_CABERJ						" + cEnt
	
	Else
	
		_cQuery := " INSERT INTO LOG_BAU_INTEGRAL					" + cEnt
	
	EndIf
			     	
	_cQuery += " (													" + cEnt
	_cQuery += " 	FILIAL      ,									" + cEnt
	_cQuery += " 	CODIGO      ,									" + cEnt
	_cQuery += " 	NOME        ,									" + cEnt
	_cQuery += " 	FANTASIA    ,									" + cEnt
	_cQuery += " 	CPFCGC      ,									" + cEnt
	_cQuery += " 	DTNASCI     ,									" + cEnt
	_cQuery += " 	NACIONAL    ,									" + cEnt
	_cQuery += " 	CEP         ,									" + cEnt
	_cQuery += " 	ENDERECO    ,									" + cEnt
	_cQuery += " 	NUMERO      ,									" + cEnt
	_cQuery += " 	COMPLEM     ,									" + cEnt
	_cQuery += " 	BAIRRO      ,									" + cEnt
	_cQuery += " 	MUNIC       ,									" + cEnt
	_cQuery += " 	ESTADO      ,									" + cEnt
	_cQuery += " 	EMAIL       ,									" + cEnt
	_cQuery += " 	TELEF       ,									" + cEnt
	_cQuery += " 	SEXO        ,									" + cEnt
	_cQuery += " 	INSS        ,									" + cEnt
	_cQuery += " 	GRAU        ,									" + cEnt
	_cQuery += " 	RACA        ,									" + cEnt
	_cQuery += " 	PAISORIG    ,									" + cEnt
	_cQuery += " 	SOCIAL      ,									" + cEnt
	_cQuery += " 	DTGRAVA     ,									" + cEnt	
	
	If !_lNeg
	
		_cQuery += " 	HRGRAVA     								" + cEnt
		
	Else
	
		_cQuery += " 	HRGRAVA,     								" + cEnt
		_cQuery += " 	DTNEGA	     								" + cEnt
	
	EndIf
		
	_cQuery += " )													" + cEnt
	_cQuery += " VALUES												" + cEnt
	_cQuery += " (													" + cEnt	
	_cQuery += " 	'" + BAU->BAU_FILIAL 					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_CODIGO 					+ "' ,	" + cEnt
	_cQuery += " 	'" + STRTRAN(BAU->BAU_NOME	,"'"," ")	+ "' ,	" + cEnt
	_cQuery += " 	'" + STRTRAN(BAU->BAU_NFANTA,"'"," ")	+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_CPFCGC  					+ "' ,	" + cEnt
	_cQuery += " 	'" + DTOS(BAU->BAU_NASFUN) 				+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_NACION  					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_CEP  						+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_END 						+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_NUMERO 					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_YCPEND    				+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_BAIRRO	 				+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_MUN 	 					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_EST   					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_EMAIL 					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_TEL      					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_SEXO 						+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_INSS 						+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_XGRAUI   					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_XRACAC  					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_XPAISO  					+ "' ,	" + cEnt
	_cQuery += " 	'" + BAU->BAU_XSOCIA 					+ "' ,	" + cEnt
	_cQuery += " 	'" + DTOS(DDATABASE) 					+ "' ,	" + cEnt
	
	If !_lNeg
	
		_cQuery += " 	'" + TIME() 						+ "' 	" + cEnt
	
	Else
	
		_cQuery += " 	'" + TIME() 						+ "' ,	" + cEnt
		_cQuery += " 	'" + DTOS(DDATABASE) 				+ "'	" + cEnt
	
	EndIf
		
	_cQuery += " )													" + cEnt
	_cQuery += " 													" + cEnt
		
	If TcSqlExec(_cQuery ) < 0
	
		_lRet := .F.
	
	EndIf
	
Return _lRet