#include 'totvs.ch'
#include "tbiconn.ch"
#include "tbicode.ch"
#include "topconn.CH"
#include 'restful.ch'
#include 'protheus.ch'
#include 'PRTOPDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc}  WSREST02
    Rest para o Mobile
@author  Angelo Henrique
@since   23/01/2023
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
user function WSREST02
return

	WSRESTFUL WSREST02 DESCRIPTION "Serviço REST 002 - Processos do Mobile - (WS002)" FORMAT "application/json,text/html"

		WSDATA Page       	AS INTEGER  OPTIONAL
		WSDATA Matric       AS CARACTER OPTIONAL
		WSDATA CountPage    AS INTEGER  OPTIONAL

		WSMETHOD GET ListBol;
			Description "Lista Boletos" ;
			WSSYNTAX "/api/v1/boletos" ;
			PATH "/api/v1/boletos" ;
			PRODUCES APPLICATION_JSON
		/*
		WsMethod GET ContList;
			Description "Retorno dos Detalhes do Boleto" ;
			WSSYNTAX "/api/v1/boletos/detalhes";
			PATH "/api/v1/boletos/detalhes";
			PRODUCES APPLICATION_JSON

		WsMethod GET ContSubc;
			Description "Retorno Extrato da Fatura" ;
			WSSYNTAX "/api/v1/Extrato";
			PATH "/api/v1/Extrato";
			PRODUCES APPLICATION_JSON
		*/
	END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} GET ListBol
Método GET ListBol para retornar os boletos abertos do beneficiário
@author Angelo Henrique
@since 23/01/2023
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
	WSMETHOD GET ListBol QUERYPARAM WSREST WSREST02

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getListBol(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getBolList
Função para tratamento da requisição GET ListBol
@author Angelo Henrique
@since 23/01/2023
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function getListBol( oWS )

	Local lRet as logical
	Local oEmp as object

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Matric   	:= ""
	DEFAULT oWS:CountPage   := 20

	lRet := .T.

	//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
	// O primeiro parametro indica que iremos tratar o método GET
	oEmp := BolAdapter():new( 'GET' )

	//o método setPage indica qual página deveremos retornar
	//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
	// a página 1 retorna os itens de 1 a 10
	// a página 2 retorna os itens de 11 a 20
	// e assim até chegar ao final de nossa listagem de 100 produtos
	oEmp:setPage(oWS:Page)

	// setPageSize indica que nossa página terá no máximo 100 itens
	oEmp:setPageSize(oWS:CountPage)

	// Esse método irá processar as informações
	oEmp:GetListBol(oWS:Matric)

	//Se tudo ocorreu bem, retorna os dados via Json
	If oEmp:lOk
		oWS:SetResponse(oEmp:getJSONResponse())
	Else
		//Ou retorna o erro encontrado durante o processamento
		SetRestFault(oEmp:GetCode(),oEmp:GetMessage())
		lRet := .F.
	EndIf
	//faz a desalocação de objetos e arrays utilizados
	oEmp:DeActivate()
	oEmp := nil

Return lRet
