#include 'totvs.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} PrdAdapter
Classe Adapter para o serviço
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
CLASS PrdAdapter FROM FWAdapterBaseV2
	METHOD New()
	METHOD GetListPrd()
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
Method New( cVerb ) CLASS PrdAdapter
	_Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListPrd
Método que retorna uma lista de familias
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListPrd(oWs) CLASS PrdAdapter

	Local aArea 	AS ARRAY
	Local cWhere	AS CHAR

	aArea   := FwGetArea()

	//Adiciona o mapa de campos Json/ResultSet
	AddMapFields( self )

	//Informa a Query a ser utilizada pela API
	::SetQuery( GetQuery(oWs) )
    
	//Informa a clausula Where da Query
	cWhere := " BG9.BG9_FILIAL = '" + FWxFilial('BG9') + "'	" + CRLF
	cWhere += " AND BG9.BG9_CODINT = '0001'					" + CRLF
	cWhere += " AND BG9.BG9_CODIGO = '" + oWS:Code  + "'    " + CRLF
	cWhere += " AND BG9.D_E_L_E_T_ = ' '					" + CRLF

	::SetWhere( cWhere )

	//Informa a ordenação a ser Utilizada pela Query
	::SetOrder( "BG9_CODIGO" )

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

	oSelf:AddMapFields( 'EMPRESA'  	, 'BG9_CODIGO'  , .T., .T., { 'BG9_CODIGO', 'C', TamSX3( 'BG9_CODIGO')[1], 0 })
	oSelf:AddMapFields( 'DESC_EMP'  , 'BG9_DESCRI'  , .T., .T., { 'BG9_DESCRI', 'C', TamSX3( 'BG9_DESCRI')[1], 0 })
	oSelf:AddMapFields( 'REDUZ_EMP' , 'BG9_NREDUZ'  , .T., .T., { 'BG9_NREDUZ', 'C', TamSX3( 'BG9_NREDUZ')[1], 0 })
	oSelf:AddMapFields( 'CONTRATO' 	, 'BT5_NUMCON'  , .T., .T., { 'BT5_NUMCON', 'C', TamSX3( 'BT5_NUMCON')[1], 0 })
	oSelf:AddMapFields( 'DATA_CONT' , 'BT5_DATCON'  , .T., .T., { 'BT5_DATCON', 'C', TamSX3( 'BT5_DATCON')[1], 0 })
	oSelf:AddMapFields( 'SUBCONT'   , 'BQC_SUBCON'  , .T., .T., { 'BQC_SUBCON', 'C', TamSX3( 'BQC_SUBCON')[1], 0 })
	oSelf:AddMapFields( 'DESCSUBC'  , 'BQC_DESCRI'  , .T., .T., { 'BQC_DESCRI', 'C', TamSX3( 'BQC_DESCRI')[1], 0 })
	oSelf:AddMapFields( 'REDUZ_SUBC', 'BQC_NREDUZ'  , .T., .T., { 'BQC_NREDUZ', 'C', TamSX3( 'BQC_NREDUZ')[1], 0 })	
	oSelf:AddMapFields( 'VALID_SUBC', 'BQC_VALID '  , .T., .T., { 'BQC_VALID ', 'C', 15						 , 0 })
	oSelf:AddMapFields( 'PRODUTO'   , 'BT6_CODPRO'  , .T., .T., { 'BT6_CODPRO', 'C', TamSX3( 'BT6_CODPRO')[1], 0 })
	oSelf:AddMapFields( 'DESC_PROD' , 'BI3_DESCRI'  , .T., .T., { 'BI3_DESCRI', 'C', TamSX3( 'BI3_DESCRI')[1], 0 })
	oSelf:AddMapFields( 'REDUZ_PROD', 'BI3_NREDUZ'  , .T., .T., { 'BI3_NREDUZ', 'C', TamSX3( 'BI3_NREDUZ')[1], 0 })

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
Static Function GetQuery(oWs)

	Local cQuery AS CHARACTER

	//Obtem a ordem informada na requisição, a query exterior SEMPRE deve ter o id #QueryFields# ao invés dos campos fixos
	//necessáriamente não precisa ser uma subquery, desde que não contenha agregadores no retorno ( SUM, MAX... )
	//o id #QueryWhere# é onde será inserido o clausula Where informado no método SetWhere()
	cQuery := " SELECT #QueryFields#                                " + CRLF
	cQuery += " FROM                                                " + CRLF
	cQuery += "     " + RetSqlName('BG9') + " BG9                   " + CRLF
	cQuery += "                                                     " + CRLF
	cQuery += "     INNER JOIN                                      " + CRLF
	cQuery += "         " + RetSqlName('BT5') + " BT5               " + CRLF
	cQuery += "     ON                                              " + CRLF
	cQuery += "         BT5.BT5_FILIAL      = BG9.BG9_FILIAL	    " + CRLF
	cQuery += "         AND BT5.BT5_CODINT  = BG9.BG9_CODINT        " + CRLF
	cQuery += "         AND BT5.BT5_CODIGO  = BG9.BG9_CODIGO        " + CRLF

	If !Empty(oWs:CodeCont)
		cQuery += "     AND BT5.BT5_NUMCON  = '" + oWs:CodeCont + "'" + CRLF
	EndIf

	cQuery += "         AND BT5.D_E_L_E_T_  = BG9.D_E_L_E_T_        " + CRLF
	cQuery += "                                                     " + CRLF
	cQuery += "      INNER JOIN                                     " + CRLF
	cQuery += "         " + RetSqlName('BQC') + " BQC               " + CRLF
	cQuery += "     ON                                              " + CRLF
	cQuery += "         BQC.BQC_FILIAL      = BG9.BG9_FILIAL        " + CRLF
	cQuery += "         AND BQC.BQC_CODINT  = BG9.BG9_CODINT        " + CRLF
	cQuery += "         AND BQC.BQC_CODEMP  = BG9.BG9_CODIGO        " + CRLF
	cQuery += "         AND BQC.BQC_NUMCON  = BT5.BT5_NUMCON        " + CRLF

	If !Empty(oWs:CodeSubc)
		cQuery += "     AND BQC.BQC_SUBCON  = '" + oWS:CodeSubc + "'" + CRLF
	EndIf

	cQuery += "         AND BQC.BQC_CODBLO  = ' '                   " + CRLF
	cQuery += "         AND BQC.BQC_DATBLO  = ' '                   " + CRLF
	cQuery += "         AND BQC.D_E_L_E_T_  = BG9.D_E_L_E_T_        " + CRLF
	cQuery += "                                                     " + CRLF
	cQuery += "     INNER JOIN                                      " + CRLF
	cQuery += "         " + RetSqlName('BT6') + " BT6               " + CRLF
	cQuery += "     ON                                              " + CRLF
	cQuery += "         BT6.BT6_FILIAL      = BQC.BQC_FILIAL        " + CRLF
	cQuery += "         AND BT6.BT6_CODINT  = BQC.BQC_CODINT        " + CRLF
	cQuery += "         AND BT6.BT6_CODIGO  = BQC.BQC_CODEMP        " + CRLF
	cQuery += "         AND BT6.BT6_NUMCON  = BQC.BQC_NUMCON        " + CRLF
	cQuery += "         AND BT6.BT6_SUBCON  = BQC.BQC_SUBCON        " + CRLF
	cQuery += "         AND BT6.D_E_L_E_T_  = BQC.D_E_L_E_T_        " + CRLF
	cQuery += "                                                     " + CRLF
	cQuery += "     INNER JOIN                                      " + CRLF
	cQuery += "         " + RetSqlName('BI3') + " BI3               " + CRLF
	cQuery += "     ON                                              " + CRLF
	cQuery += "         BI3.BI3_FILIAL      = BT6.BT6_FILIAL        " + CRLF
	cQuery += "         AND BI3.BI3_CODINT  = BT6.BT6_CODINT        " + CRLF
	cQuery += "         AND BI3.BI3_CODIGO  = BT6.BT6_CODPRO        " + CRLF
	cQuery += "         AND BI3.D_E_L_E_T_  = BT6.D_E_L_E_T_        " + CRLF
	cQuery += "                                                     " + CRLF
	cQuery += " WHERE #QueryWhere#                                  " + CRLF

Return cQuery
