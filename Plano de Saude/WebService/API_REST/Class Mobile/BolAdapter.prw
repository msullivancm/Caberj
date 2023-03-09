#include 'totvs.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} BolAdapter
Classe Adapter para o serviço
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
CLASS BolAdapter FROM FWAdapterBaseV2
	METHOD New()
	METHOD GetListBol()
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
Método construtor
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method New( cVerb ) CLASS BolAdapter
	_Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListEmp
Método que retorna uma lista de produtos
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListBol(cMatric) CLASS BolAdapter

	Local aArea 	AS ARRAY
	Local cWhere	AS CHAR

	aArea   := FwGetArea()

	//Adiciona o mapa de campos Json/ResultSet
	AddMapFields( self )

	//Informa a Query a ser utilizada pela API
	::SetQuery( GetQuery() )	

	cWhere := "	SE1.E1_FILIAL 		= '" + FWxFilial("SE1") 			+ "'" + CRLF	
	cWhere += "	AND SE1.E1_CODINT 	= '" + SUBSTR(AllTrim(cMatric),1,4)	+ "'" + CRLF
	cWhere += "	AND SE1.E1_CODEMP 	= '" + SUBSTR(AllTrim(cMatric),5,4)	+ "'" + CRLF
	cWhere += "	AND SE1.E1_MATRIC 	= '" + SUBSTR(AllTrim(cMatric),9,6)	+ "'" + CRLF
	cWhere += "	AND SE1.E1_PREFIXO 	= 'PLS' 								" + CRLF
	cWhere += "	AND SE1.E1_PORTADO  = '237' 								" + CRLF
	cWhere += "	AND SE1.E1_TIPO NOT IN ('PR','RA') 							" + CRLF
	cWhere += "	AND SE1.E1_YTPEXP IN ('L','D') 								" + CRLF
	cWhere += "	AND SE1.E1_SALDO 	> 0 									" + CRLF
	cWhere += "	AND SE1.E1_NUMBCO 	<> ' '									" + CRLF
	cWhere += "	AND SE1.D_E_L_E_T_ 	= ' ' 									" + CRLF

	::SetWhere( cWhere )

	//Informa a ordenação a ser Utilizada pela Query
	::SetOrder( "E1_NUM" )

	//Executa a consulta, se retornar .T. tudo ocorreu conforme esperado
	If ::Execute()
		// Gera o arquivo Json com o retorno da Query
		// Pode ser reescrita, iremos ver em outro artigo de como fazer
		::FillGetResponse()
	EndIf
	FwrestArea(aArea)
RETURN

//-------------------------------------------------------------------
/*/{Protheus.doc} AddMapFields
Função para geração do mapa de campos
@param oSelf, object, Objeto da prórpia classe
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function AddMapFields( oSelf )

	oSelf:AddMapFields( 'MATRICULA'	, 'BA3_MATRIC'  , .T., .T., { 'BA3_MATRIC'	, 'C', 17						, 0 } )
	oSelf:AddMapFields( 'NOME'      , 'BA1_NOME'  	, .T., .T., { 'BA1_NOMUSR'	, 'C', TamSX3( 'BA1_NOMUSR' )[1], 0 } )    
	oSelf:AddMapFields( 'PREFIXO'   , 'E1_PREFIXO'  , .T., .T., { 'E1_PREFIXO'	, 'C', TamSX3( 'E1_PREFIXO' )[1], 0 } )	
	oSelf:AddMapFields( 'NUMERO'    , 'E1_NUM'  	, .T., .T., { 'E1_NUM'		, 'C', TamSX3( 'E1_NUM' 	)[1], 0 } )	
	/*
	oSelf:AddMapFields( 'PARCELA'   , 'E1_PARCELA'  , .T., .T., { 'E1_PARCELA'	, 'C', TamSX3( 'E1_PARCELA' )[1], 0 } )
	oSelf:AddMapFields( 'VALOR'     , 'E1_SALDO'  	, .T., .T., { 'E1_SALDO'	, 'N', TamSX3( 'E1_SALDO' 	)[1], 0 } )
	oSelf:AddMapFields( 'EMISSAO' 	, 'E1_EMISSAO'  , .T., .T., { 'E1_EMISSAO'	, 'D', 10						, 0 } )
	oSelf:AddMapFields( 'VENCIMENTO', 'E1_VENCREA'  , .T., .T., { 'E1_VENCREA'	, 'D', 10						, 0 } )*/

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetQuery
Retorna a query usada no serviço
@param oSelf, object, Objeto da prórpia classe
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function GetQuery()

	Local cQuery AS CHARACTER

	//Obtem a ordem informada na requisição, a query exterior SEMPRE deve ter o id #QueryFields# ao invés dos campos fixos
	//necessáriamente não precisa ser uma subquery, desde que não contenha agregadores no retorno ( SUM, MAX... )
	//o id #QueryWhere# é onde será inserido o clausula Where informado no método SetWhere()
	cQuery := " SELECT           										" + CRLF	
	cQuery += " 	#QueryFields#            							" + CRLF	
    cQuery += " FROM                            						" + CRLF
	cQuery += "		" + RetSqlName("SE1") + " SE1  						" + CRLF
	cQuery += "															" + CRLF
	cQuery += "		INNER JOIN											" + CRLF
	cQuery += "			" + RetSqlName("BA3") + " BA3 					" + CRLF
	cQuery += "		ON													" + CRLF	
	cQuery += "			BA3.BA3_FILIAL 		= '" + xFilial("BA3") + "' 	" + CRLF
	cQuery += "			AND BA3.BA3_CODINT 	= SE1.E1_CODINT 			" + CRLF
	cQuery += "			AND BA3.BA3_CODEMP 	= SE1.E1_CODEMP 			" + CRLF
	cQuery += "			AND BA3.BA3_MATRIC 	= SE1.E1_MATRIC 			" + CRLF			
	cQuery += "			AND BA3.D_E_L_E_T_ 	= ' ' 						" + CRLF
	cQuery += "															" + CRLF	
	cQuery += "		INNER JOIN											" + CRLF
	cQuery += "			" + RetSqlName("BA1") + " BA1 					" + CRLF
	cQuery += "		ON													" + CRLF	
	cQuery += "			BA1.BA1_FILIAL 		= '" + xFilial("BA1") + "' 	" + CRLF		
	cQuery += "			AND BA1.BA1_CODINT 	= SE1.E1_CODINT 	 		" + CRLF
	cQuery += "			AND BA1.BA1_CODEMP 	= SE1.E1_CODEMP 			" + CRLF
	cQuery += "			AND BA1.BA1_MATRIC 	= SE1.E1_MATRIC 			" + CRLF
	cQuery += "			AND BA1.BA1_TIPUSU 	= 'T' 						" + CRLF
	cQuery += "			AND BA1.BA1_DATBLO 	= ' '       				" + CRLF	
	cQuery += "			AND BA1.D_E_L_E_T_ 	= ' ' 						" + CRLF
	cQuery += " WHERE #QueryWhere#              						" + CRLF

Return cQuery
