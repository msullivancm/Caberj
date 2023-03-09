#include "totvs.ch"

#INCLUDE "TOTVS.CH"
//#INCLUDE "RESTFUL.CH"
#INCLUDE "FWMVCDEF.CH"
//#INCLUDE "FWSCIMUSERS.CH"

/*/{Protheus.doc} Token
//TODO Descrição auto-gerada.
@author vitor.duarte
@since 07/08/2017
@version undefined

@type class
/*/

User Function Nucleo2(cState,cCity,cplano,cBairro,cLimit,cOffset,nSum,aProviders,cJson,cName,cEspec)

	Local aRet			:= {}
	Local cHost 		:= SuperGetMv("MV_XWSRNUC",,"https://www6.metlife.com.br")
	//Local cHost 		:= SuperGetMv("MV_XWSRNUC",,"http://209.164.220.71") // teste
	Local cRotaBusca	:= "/metservices/api/providers"
	Local oRestClient 	:= FWRest():New(cHost)
	Local aHeader 		:= {}
	Local oJson			:= Nil
	Local cToken 		:= ""
	Local cQryString	:= "q=languages==br"
	Local aRetorno      := {}
	Local cPswAut   		:= SuperGetMv("MV_XPSWMTL",,"usr_caberj:H9c4$s1k0m")
	//Local cPswAut   		:= SuperGetMv("MV_XPSWMTL",,"usr_caberj:V9Jh$hgn1") // teste
	
	
	Default cCity		:= "APARECIDA"
	Default cplano		:= "gold"
	Default cState		:= "SP"
	Default cLimit 		:= "1"
	Default cBairro		:= "CENTRO"
	Default cOffset  	:= "0"
	Default nSum		:= 0
	Default aProviders  := {}
	Default cJson		:= ""
	
	cOffset := iif(!empty(nSum),cvaltochar(nSum+1),cOffset) // devido a chamada recursiva defino em qual posição começará a busca
	//	Header do Requisição Rest
	// inclui o campo Authorization no formato <usuario>:<senha> na base64
	Aadd(aHeader, "Authorization: Basic " + Encode64(cPswAut)				)
	Aadd(aHeader, "Content-Type: application/x-www-form-urlencoded"			)
	Aadd(aHeader, "Accept:application/json"								)
	//Aadd(aHeader, "Accept-Encoding:*"										)
	Aadd(aHeader, "API-Version: 1"											)
	Aadd(aHeader, "TenantId: 1"												)


	//Parametros via QueryString
	If !Empty(cState)
		If !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "state=="+cState+""
	EndIf

	If !Empty(cCity)
		If !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "city==%22"+escape(alltrim(cCity))+"%22"
	EndIf
	
	If !Empty(cPlano)
		if !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "planNickName==%22"+escape(alltrim(cPlano))+"%22"
	EndIf
	
	If !Empty(cBairro)
		if !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "neighborhood==%22"+escape(alltrim(cBairro))+"%22"
	EndIf
		
	If !Empty(cLimit)
		if !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "limit=="+cLimit
	EndIf
	
	If !Empty(cOffset)
		if !EMPTY(cQryString)
			cQryString += ";"
		EndIf
		cQryString += "offset=="+cOffset
	EndIf
		
	If !Empty(cName)
		if !EMPTY(cName)
			cQryString += ";"
		EndIf
		cQryString += "providerName==%22"+escape(alltrim(cName)) +"%22"
	EndIf

	If !Empty(cEspec)
		if !EMPTY(cEspec)
			cQryString += ";"
		EndIf
		cQryString += "speciality==%22"+escape(alltrim(cEspec)) +"%22"
	EndIf
	
	
	/*cHtmlPage := Httpget(cHost+cRotaBusca,cQryString,120,aHeader)
  	conout("WebPage", OemtoAnsi(cHtmlPage))
	*/
	oRestClient:SetPath(cRotaBusca+"?"+cQryString)
	conout(cHost+cRotaBusca+"?"+cQryString)
	If !oRestClient:GET(aHeader)
		Conout("GET "+ oRestClient:GetLastError())
	Else
		Conout(oRestClient:GetResult())
		//Converte o retorno em objeto
		if At("metadata",lower(oRestClient:cResult)) > 0
			FWJsonDeserialize(DecodeUtf8(oRestClient:cResult), @oJson)
			IF At("providers",DecodeUtf8(oRestClient:cResult)) > 0
				AAdd(aProviders,oJson:Providers)
		
				nSum += oJson:METADATA:LIMIT
				If nSum < oJson:METADATA:TOTALCOUNT .and. Empty(cLimit)  // retorna a quantidade de dados
					
				// faço a chamada recursiva, caso ainda tenha dados para retornar no serviço da metlife	
					u_Nucleo2(nil,nil,nil,nil,nil,nil,nSum,aProviders)
				 
				endif
		 
			ENDIF
		  
			aRetorno :=  {aProviders,oJson:METADATA:OFFSET,oJson:METADATA:LIMIT,oJson:METADATA:TOTALCOUNT}
		else
			aRetorno :=  {{},0,0,0}
		endif
	
	Endif
	
Return aRetorno
