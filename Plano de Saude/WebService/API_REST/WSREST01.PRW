#include 'totvs.ch'
#include "tbiconn.ch"
#include "tbicode.ch"
#include "topconn.CH"
#include 'restful.ch'
#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc}  WSREST01
    Rest para o CBI
@author  Angelo Henrique
@since   27/09/2021
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
user function WSREST01
return

	WSRESTFUL WSREST01 DESCRIPTION "Serviço REST 001 - Processos do CBI" FORMAT "application/json,text/html"

		WSDATA Page         AS INTEGER  OPTIONAL
		WSDATA Code         AS CARACTER OPTIONAL
		WSDATA CountPage    AS INTEGER  OPTIONAL
		WSDATA CodeCont     AS CARACTER OPTIONAL
		WSDATA CodeSubc     AS CARACTER OPTIONAL
		WSDATA CodeMat      AS CARACTER OPTIONAL
		WSDATA Bloqued      AS CARACTER OPTIONAL
		WSDATA CodePlan     AS CARACTER OPTIONAL

		WSMETHOD GET EmpList;
			Description "Retorno das Empresas" ;
			WSSYNTAX "/api/v1/enterprise" ;
			PATH "/api/v1/enterprise" ;
			PRODUCES APPLICATION_JSON

		WsMethod GET ContList;
			Description "Retorno dos Contratos da Empresa" ;
			WSSYNTAX "/api/v1/enterprise/contracts";
			PATH "/api/v1/enterprise/contracts";
			PRODUCES APPLICATION_JSON

		WsMethod GET ContSubc;
			Description "Retorno dos Subcontratos da Empresa" ;
			WSSYNTAX "/api/v1/enterprise/contracts/subcontract";
			PATH "/api/v1/enterprise/contracts/subcontract";
			PRODUCES APPLICATION_JSON

		WsMethod GET FamiList;
			Description "Retorno das familias" ;
			WSSYNTAX "/api/v1/enterprise/contracts/subcontract/family";
			PATH "/api/v1/enterprise/contracts/subcontract/family";
			PRODUCES APPLICATION_JSON

		WsMethod GET UsuaList;
			Description "Retorno dos usuarios" ;
			WSSYNTAX "/api/v1/enterprise/contracts/subcontract/family/user";
			PATH "/api/v1/enterprise/contracts/subcontract/family/user";
			PRODUCES APPLICATION_JSON

		WsMethod GET ProdList;
			Description "Retorno dos produtos de saude da empresa" ;
			WSSYNTAX "/api/v1/products";
			PATH "/api/v1/products";
			PRODUCES APPLICATION_JSON

	END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} GET EmpList
Método GET EmpList para retornar todas as empresas
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
	WSMETHOD GET EmpList QUERYPARAM WSREST WSREST01

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getEmpList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getEmpList
Função para tratamento da requisição GET EmpList
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function getEmpList( oWS )

	Local lRet as logical
	Local oEmp as object

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CountPage   := 20

	lRet := .T.

	//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
	// O primeiro parametro indica que iremos tratar o método GET
	oEmp := EmpAdapter():new( 'GET' )

	//o método setPage indica qual página deveremos retornar
	//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
	// a página 1 retorna os itens de 1 a 10
	// a página 2 retorna os itens de 11 a 20
	// e assim até chegar ao final de nossa listagem de 100 produtos
	oEmp:setPage(oWS:Page)

	// setPageSize indica que nossa página terá no máximo 100 itens
	oEmp:setPageSize(oWS:CountPage)

	// Esse método irá processar as informações
	oEmp:GetListEmp(oWS:Code)

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


//-------------------------------------------------------------------
/*/{Protheus.doc} GET ContList
Método GET ContList para listar todos os contratos de uma empresa
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
	WSMETHOD GET ContList QUERYPARAM WSREST WSREST01

	::SetContentType( 'application/json' )

	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")	
	::SetHeader('Access-Control-Allow-Origin', "*")	
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getConList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getConList
Função para tratamento da requisição GET getConList
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function getConList( oWS )

	Local lRet  as logical
	Local oCont as object

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CountPage   := 20

	lRet := .T.

	If !Empty(oWS:Code)

		//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
		// O primeiro parametro indica que iremos tratar o método GET
		oCont := ContAdapter():new( 'GET' )

		//o método setPage indica qual página deveremos retornar
		//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
		// a página 1 retorna os itens de 1 a 10
		// a página 2 retorna os itens de 11 a 20
		// e assim até chegar ao final de nossa listagem de 100 produtos
		oCont:setPage(oWS:Page)

		// setPageSize indica que nossa página terá no máximo 100 itens
		oCont:setPageSize(oWS:CountPage)

		// Esse método irá processar as informações
		oCont:GetListCont(oWS:Code)

		//Se tudo ocorreu bem, retorna os dados via Json
		If oCont:lOk
			oWS:SetResponse(oCont:getJSONResponse())
		Else
			//Ou retorna o erro encontrado durante o processamento
			SetRestFault(oCont:GetCode(),oCont:GetMessage())
			lRet := .F.
		EndIf
		//faz a desalocação de objetos e arrays utilizados
		oCont:DeActivate()
		oCont := nil

	Else
		//Ou retorna o erro encontrado durante o processamento
		SetRestFault(001,"Favor informar o codigo da empresa, parametro code")
		lRet := .F.
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GET ContSubc
Método GET ContList para listar todos os contratos de uma empresa
@author Angelo Henrique
@since 18/05/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
	WSMETHOD GET ContSubc QUERYPARAM WSREST WSREST01

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getSubList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getSubList
Função para tratamento da requisição GET SubList
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function getSubList( oWS )

	Local lRet  as logical
	Local oSubc as object

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CodeCont    := ""
	DEFAULT oWS:CountPage   := 20

	lRet := .T.

	If !Empty(oWS:Code) .and. !Empty(oWS:CodeCont)

		//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
		// O primeiro parametro indica que iremos tratar o método GET
		oSubc := SubcAdapter():new( 'GET' )

		//o método setPage indica qual página deveremos retornar
		//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
		// a página 1 retorna os itens de 1 a 10
		// a página 2 retorna os itens de 11 a 20
		// e assim até chegar ao final de nossa listagem de 100 produtos
		oSubc:setPage(oWS:Page)

		// setPageSize indica que nossa página terá no máximo 100 itens
		oSubc:setPageSize(oWS:CountPage)

		// Esse método irá processar as informações
		oSubc:GetListSubc(oWS)

		//Se tudo ocorreu bem, retorna os dados via Json
		If oSubc:lOk
			oWS:SetResponse(oSubc:getJSONResponse())
		Else
			//Ou retorna o erro encontrado durante o processamento
			SetRestFault(oSubc:GetCode(),oSubc:GetMessage())
			lRet := .F.
		EndIf
		//faz a desalocação de objetos e arrays utilizados
		oSubc:DeActivate()
		oSubc := nil

	Else

		If Empty(oWS:Code) .and. Empty(oWS:CodeCont)
			SetRestFault(001,"Favor informar o codigo da empresa e codigo do contrato, parametro code e codecont")
		ElseIf Empty(oWS:Code)
			SetRestFault(001,"Favor informar o codigo da empresa, parametro code")
		ElseIf Empty(oWS:CodeCont)
			SetRestFault(001,"Favor informar o contrato da empresa, parametro codecont")
		EndIf

		lRet := .F.

	EndIf

Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} GET FamiList
Método GET FamiList para listar todos os contratos de uma empresa
@author Angelo Henrique
@since 18/05/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
	WSMETHOD GET FamiList QUERYPARAM  WSREST WSREST01

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getFamList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getSubList
Função para tratamento da requisição GET getFamList
@author Angelo Henrique
@since 18/05/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function getFamList( oWS )

	Local lRet      as logical
	Local oFami     as object
	Local cMsg      as char
	Local cMsgInt   as char

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CodeCont    := ""
	DEFAULT oWS:CountPage   := 20
	DEFAULT oWS:CodeSubc    := ""
	DEFAULT oWS:CodeMat     := ""
	DEFAULT oWS:Bloqued     := ""
	DEFAULT oWS:CodePlan    := ""

	lRet    := .T.

	cMsg    := "Favor informar o(s) seguinte(s) parâmetros ou resolver o(s) problema(s) listado(s) "
	cMsgInt := ""

	If Empty(oWS:Code)
		cMsgInt += " - Codigo da Empresa, parâmetro Code "
	EndIf

	If Empty(oWS:CodeCont)
		cMsgInt += " - Codigo do Contrato, parâmetro CodeCont"
	EndIf

	If Empty(oWS:CodeSubc)
		cMsgInt += " - Codigo do Subcontrato, parâmetro CodeSubc"
	EndIf

	If !Empty(cMsgInt)

		cMsg += cMsgInt

		SetRestFault(001,cMsg)

		lRet := .F.

	EndIf

	If lRet

		//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
		// O primeiro parametro indica que iremos tratar o método GET
		oFami := FamiAdapter():new( 'GET' )

		//o método setPage indica qual página deveremos retornar
		//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
		// a página 1 retorna os itens de 1 a 10
		// a página 2 retorna os itens de 11 a 20
		// e assim até chegar ao final de nossa listagem de 100 produtos
		oFami:setPage(oWS:Page)

		// setPageSize indica que nossa página terá no máximo 100 itens
		oFami:setPageSize(oWS:CountPage)

		// Esse método irá processar as informações
		oFami:GetListFam(oWS)

		//Se tudo ocorreu bem, retorna os dados via Json
		If oFami:lOk
			oWS:SetResponse(oFami:getJSONResponse())
		Else
			//Ou retorna o erro encontrado durante o processamento
			SetRestFault(oFami:GetCode(),oFami:GetMessage())
			lRet := .F.
		EndIf
		//faz a desalocação de objetos e arrays utilizados
		oFami:DeActivate()
		oFami := nil

	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GET FamiList
Método GET FamiList para listar todos os contratos de uma empresa
@author Angelo Henrique
@since 18/05/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
	WSMETHOD GET UsuaList QUERYPARAM WSREST WSREST01

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getUsuList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getSubList
Função para tratamento da requisição GET getFamList
@author Angelo Henrique
@since 18/05/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function getUsuList( oWS )

	Local lRet      as logical
	Local oUsu      as object
	Local cMsg      as char
	Local cMsgInt   as char

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CodeCont    := ""
	DEFAULT oWS:CountPage   := 20
	DEFAULT oWS:CodeSubc    := ""
	DEFAULT oWS:CodeMat     := ""
	DEFAULT oWS:Bloqued     := ""
	DEFAULT oWS:CodePlan    := ""

	lRet    := .T.

	cMsg    := "Favor informar o(s) seguinte(s) parâmetros ou resolver o(s) problema(s) listado(s) "
	cMsgInt := ""

	If Empty(oWS:Code)
		cMsgInt += " - Codigo da Empresa, parâmetro Code "
	EndIf

	If !Empty(cMsgInt)

		cMsg += cMsgInt

		SetRestFault(001,cMsg)

		lRet := .F.

	EndIf

	If lRet

		//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
		// O primeiro parametro indica que iremos tratar o método GET
		oUsu := UsuAdapter():new( 'GET' )

		//o método setPage indica qual página deveremos retornar
		//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
		// a página 1 retorna os itens de 1 a 10
		// a página 2 retorna os itens de 11 a 20
		// e assim até chegar ao final de nossa listagem de 100 produtos
		oUsu:setPage(oWS:Page)

		// setPageSize indica que nossa página terá no máximo 100 itens
		oUsu:setPageSize(oWS:CountPage)

		// Esse método irá processar as informações
		oUsu:GetListUsu(oWS)

		//Se tudo ocorreu bem, retorna os dados via Json
		If oUsu:lOk
			oWS:SetResponse(oUsu:getJSONResponse())
		Else
			//Ou retorna o erro encontrado durante o processamento
			SetRestFault(oUsu:GetCode(),oUsu:GetMessage())
			lRet := .F.
		EndIf
		//faz a desalocação de objetos e arrays utilizados
		oUsu:DeActivate()
		oUsu := nil

	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GET ProdList
Método GET ProdList para retornar os produtos saude
@author Angelo Henrique
@since 01/07/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
	WSMETHOD GET ProdList QUERYPARAM  WSREST WSREST01

	::SetContentType( 'application/json' )

//::SetHeader('Access-Control-Allow-Origin', If(Empty(HTTPHeader("Access-Control-Allow-Origin-C")),"Vazio",HTTPHeader("Access-Control-Allow-Origin-C")))
	//::SetHeader('Access-Control-Allow-Origin', "http://localhost:8080")
	::SetHeader('Access-Control-Allow-Origin', "*")
	::SetHeader('Access-Control-Allow-Credentials', 'true')
	::SetHeader('Access-Control-Allow-Methods', '*')

Return getPrdList(self)

//-------------------------------------------------------------------
/*/{Protheus.doc} GET getPrdList
Função para tratamento da requisição GET ProdList
@author Angelo Henrique
@since 18/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function getPrdList( oWS )

	Local lRet      as logical
	Local oPrd      as object
	Local cMsg      as char
	Local cMsgInt   as char

	DEFAULT oWS:Page        := 1
	DEFAULT oWS:Code        := ""
	DEFAULT oWS:CodeCont    := ""
	DEFAULT oWS:CountPage   := 20
	DEFAULT oWS:CodeSubc    := ""

	lRet := .T.

	cMsg    := "Favor informar o(s) seguinte(s) parâmetros ou resolver o(s) problema(s) listado(s) "
	cMsgInt := ""

	If Empty(oWS:Code)
		cMsgInt += " - Codigo da Empresa, parâmetro Code "
	EndIf

	If !Empty(cMsgInt)

		cMsg += cMsgInt

		SetRestFault(001,cMsg)

		lRet := .F.

	EndIf

	If lRet

		//EmpAdapter será nossa classe que implementa fornecer os dados para o WS
		// O primeiro parametro indica que iremos tratar o método GET
		oPrd := PrdAdapter():new( 'GET' )

		//o método setPage indica qual página deveremos retornar
		//ex.: nossa consulta tem como resultado 100 produtos, e retornamos sempre uma listagem de 10 itens por página.
		// a página 1 retorna os itens de 1 a 10
		// a página 2 retorna os itens de 11 a 20
		// e assim até chegar ao final de nossa listagem de 100 produtos
		oPrd:setPage(oWS:Page)

		// setPageSize indica que nossa página terá no máximo 100 itens
		oPrd:setPageSize(oWS:CountPage)

		// Esse método irá processar as informações
		oPrd:GetListPrd(oWS)

		//Se tudo ocorreu bem, retorna os dados via Json
		If oPrd:lOk
			oWS:SetResponse(oPrd:getJSONResponse())
		Else
			//Ou retorna o erro encontrado durante o processamento
			SetRestFault(oPrd:GetCode(),oPrd:GetMessage())
			lRet := .F.
		EndIf
		//faz a desalocação de objetos e arrays utilizados
		oPrd:DeActivate()
		oPrd := nil

	EndIf

Return lRet
