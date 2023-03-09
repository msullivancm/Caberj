#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ WS011    ºAutor  ³Mateus Medeiros     º Data ³  26/09/2018 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³WebService criado para ser utilizado no processo boleto     º±±
±±ºDesc.     ³CABERJ                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Fabrica de Software                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function WS011()
	
Return

//--------------------------------------------------------------
//Estrutura de retorno utilizada para o CEP (Método WS010CEP)
//--------------------------------------------------------------
WSSTRUCT StrDBanco
	
	WSDATA CodCart	AS String //01 - Carteira
	WSDATA CodBanco	AS String //02 - Banco
	WSDATA CodAge	AS String //03 - Agencia
	WSDATA CodDvAge	AS String //04 - Digito Agencia
	WSDATA CodConta	AS String //04 - Conta
	WSDATA CodDvCnt	AS String //04 - Descrição do Municipio
	
ENDWSSTRUCT

//
WSSERVICE WS011 DESCRIPTION "Serviço para retornar dados bancários " NAMESPACE "WS011"
	
	//-----------------------------------------------------
	//Variaveis Utilizadas no método como parametros 
	//-----------------------------------------------------
	WSDATA Empresa 		AS  STRING  	// Empresa
	WSDATA Filial 		AS  STRING  	// Filial 
	WSDATA NossoNum		AS  STRING  	// Nosso Número 
	WSDATA Numero 		AS  STRING  	// Número do Título
	WSDATA Prefixo		AS  STRING      // PREFIXO 
	WSDATA Parcela		AS  STRING      // PREFIXO
	WSDATA Tipo			AS  STRING      // PREFIXO
	
	//-----------------------------------------------------
	//Lista das estruturas de retorno do webservice
	//-----------------------------------------------------
	WSDATA tRet 		AS  StrDBanco 	//Estrutura Banco
	
	//-----------------------------------------------------
	//Declaração dos Métodos
	//-----------------------------------------------------
	WSMETHOD WS011DCTA	DESCRIPTION "Método - Boleto Conta Caberj."
	
ENDWSSERVICE

/*
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Metodo para consulta de dados Bancarios CABERJ/Integral    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ - WebService                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

WSMETHOD WS011DCTA WSRECEIVE Empresa, Filial,NossoNum,Numero,Prefixo,Tipo,Parcela WSSEND tRet WSSERVICE WS011
	
	Local lRet          := .T.
	Local _cAlias1      := Nil		
	Local oTemp			:= Nil
	
	Local cEmp			:= self:Empresa	
	Local cFil			:= self:Filial
	Local cNosNum		:= self:NossoNum
	Local cNumTit 		:= self:Numero	
	Local cPREFIXO		:= self:Prefixo
	Local cTipo 		:= self:Tipo
	Local cParcela		:= self:Parcela
	
	Local _aArea		:= {}
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que será efetuado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	
	//::tRet := {}
	
	RpcSetType(3)
	if RpcSetenv(cEmp,cFil)
		_aArea   := GetArea()	
		_cAlias1 := GetNextAlias()
		
		//----------------------------------------------------------------------------------
		//Traz as informações referente aos dados bancários do título a receber consultado.
		//----------------------------------------------------------------------------------
		BeginSql Alias _cAlias1
			
			SELECT SA6.A6_COD,
			  SA6.A6_AGENCIA,
			  SA6.A6_DVAGE,
			  SA6.A6_NUMCON,
			  SA6.A6_DVCTA,
			  SEE.EE_CODCART 
			FROM %table:SE1% SE1, 
				 %table:SA6% SA6 ,
			  	 %table:SEE% SEE
			WHERE E1_FILIAL    = %xFilial:SE1%
				AND E1_PREFIXO     = %exp:cPREFIXO%
				AND E1_NUM         = %exp:cNumTit%
				AND E1_TIPO        = %exp:cTipo%
				AND E1_PARCELA     = %exp:cParcela%
				AND SA6.A6_FILIAL  = %xFilial:SA6%
				AND SA6.A6_COD     = SE1.E1_PORTADO
				AND SA6.A6_AGENCIA = SE1.E1_AGEDEP
				AND SA6.A6_NUMCON  = SE1.E1_CONTA
				AND SEE.EE_FILIAL  = SE1.E1_FILIAL
				AND SEE.EE_CODIGO  = SA6.A6_COD
				AND SEE.EE_AGENCIA = SA6.A6_AGENCIA
				AND SEE.EE_CONTA   = SA6.A6_NUMCON
				AND SEE.EE_DVCTA   = SA6.A6_DVCTA
				AND SEE.EE_SUBCTA  = '001' ;

		EndSql
		
		If (_cAlias1)->(!EOF())
			
			
			While !(_cAlias1)->(EOF())
				
				oTemp := WsClassNew("StrDBanco")
				
				oTemp:CodCart 	:= Alltrim((_cAlias1)->EE_CODCART		)
				oTemp:CodBanco 	:= Alltrim((_cAlias1)->A6_COD		)
				oTemp:CodAge 	:= Alltrim((_cAlias1)->A6_AGENCIA		)
				oTemp:CodDvAge 	:= Alltrim((_cAlias1)->A6_DVAGE		)
				oTemp:CodConta 	:= Alltrim((_cAlias1)->A6_NUMCON		)
				oTemp:CodDvCnt 	:= Alltrim((_cAlias1)->A6_DVCTA		)
			
				 ::tRet  := oTemp
				
				(_cAlias1)->(DbSkip())
				
			EndDo
			
		Else 
			oTemp := WsClassNew("StrDBanco")	
			
			oTemp:CodCart 	:= '09'
			oTemp:CodBanco 	:= '237'
			oTemp:CodAge 	:= '3369'
			oTemp:CodDvAge 	:= '3'
			oTemp:CodConta 	:= '8895'
			oTemp:CodDvCnt 	:= '1'
			
			aAdd( ::tRet , oTemp)
				
		Endif
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		RestArea(_aArea)
	
	EndIf
	
Return lRet
