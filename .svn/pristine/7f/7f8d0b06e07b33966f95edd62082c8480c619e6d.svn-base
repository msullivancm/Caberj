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
CLASS UsuAdapter FROM FWAdapterBaseV2
	METHOD New()
	METHOD GetListUsu()
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
Method New( cVerb ) CLASS UsuAdapter
	_Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListUsu
Método que retorna uma lista de familias
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListUsu(oWs) CLASS UsuAdapter

	Local aArea 	AS ARRAY
	Local cWhere	AS CHAR

	aArea   := FwGetArea()

	//Adiciona o mapa de campos Json/ResultSet
	AddMapFields( self )

	//Informa a Query a ser utilizada pela API
	::SetQuery( GetQuery() )

	//Informa a clausula Where da Query
	cWhere := " BA1.BA1_FILIAL = '" + FWxFilial('BA1') + "'     " + CRLF
	cWhere += " AND BA1.BA1_CODINT = '0001'                     " + CRLF
	cWhere += " AND BA1.BA1_CODEMP = '" + oWS:Code  + "'        " + CRLF

	If !Empty( AllTrim(oWS:CodeMat))
		cWhere += " AND BA1.BA1_MATRIC = '" + oWS:CodeMat + "   " + CRLF
	EndIf

	If !Empty( AllTrim(oWS:CodeCont))
		cWhere += " AND BA1.BA1_CONEMP = '" + oWS:CodeCont + "' " + CRLF
	ENDIF

	If !Empty( AllTrim(oWS:CodeSubc))
		cWhere += " AND BA1.BA1_SUBCON = '" + oWS:CodeSubc + "' " + CRLF
	ENDIF

	If Upper(AllTrim(oWS:Bloqued)) == "S"
		cWhere += " AND BA1.BA1_DATBLO <> ' '                   " + CRLF
	ElseIf Upper(AllTrim(oWS:Bloqued)) = "N"
		cWhere += " AND BA1.BA1_DATBLO = ' '                    " + CRLF
	EndIf

	If !Empty( AllTrim(oWS:CodePlan))
		cWhere += " AND BA1.BA1_CODPLA = '" + oWS:CodePlan + "' " + CRLF
	EndIf

	cWhere += " AND BA1.D_E_L_E_T_ = ' '                        " + CRLF

	::SetWhere( cWhere )

	//Informa a ordenação a ser Utilizada pela Query
	::SetOrder( "BA1_MATRIC" )

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

	oSelf:AddMapFields( 'CODINT'    , 'BA1_CODINT'  , .T., .T., { 'BA1_CODINT'  , 'C', TamSX3( 'BA1_CODINT' )[1], 0 })
	oSelf:AddMapFields( 'CODEMP'    , 'BA1_CODEMP'  , .T., .T., { 'BA1_CODEMP'  , 'C', TamSX3( 'BA1_CODEMP' )[1], 0 })
	oSelf:AddMapFields( 'MATRIC'    , 'BA1_MATRIC'  , .T., .T., { 'BA1_MATRIC'  , 'C', TamSX3( 'BA1_MATRIC' )[1], 0 })
	oSelf:AddMapFields( 'TIPREG'    , 'BA1_TIPREG'  , .T., .T., { 'BA1_TIPREG'  , 'C', TamSX3( 'BA1_TIPREG' )[1], 0 })
	oSelf:AddMapFields( 'DIGITO'    , 'BA1_DIGITO'  , .T., .T., { 'BA1_DIGITO'  , 'C', TamSX3( 'BA1_DIGITO' )[1], 0 })
	oSelf:AddMapFields( 'NOME'      , 'BA1_NOMUSR'  , .T., .T., { 'BA1_NOMUSR'  , 'C', TamSX3( 'BA1_NOMUSR' )[1], 0 })
	oSelf:AddMapFields( 'TIPO'      , 'BA1_TIPUSU'  , .T., .T., { 'BA1_TIPUSU'  , 'C', TamSX3( 'BA1_TIPUSU' )[1], 0 })
	oSelf:AddMapFields( 'CPF'       , 'BA1_CPFUSR'  , .T., .T., { 'BA1_CPFUSR'  , 'C', TamSX3( 'BA1_CPFUSR' )[1], 0 })
	oSelf:AddMapFields( 'PLANO'     , 'BA1_CODPLA'  , .T., .T., { 'BA1_CODPLA'  , 'C', TamSX3( 'BA1_CODPLA' )[1], 0 })
	oSelf:AddMapFields( 'DESCPLANO' , 'BI3_DESCRI'  , .T., .T., { 'BI3_DESCRI'  , 'C', TamSX3( 'BI3_DESCRI' )[1], 0 })
	oSelf:AddMapFields( 'MATVID'    , 'BA1_MATVID'  , .T., .T., { 'BA1_MATVID'  , 'C', TamSX3( 'BA1_MATVID' )[1], 0 })
	oSelf:AddMapFields( 'MAE'       , 'BA1_MAE'     , .T., .T., { 'BA1_MAE'     , 'C', TamSX3( 'BA1_MAE'    )[1], 0 })
	oSelf:AddMapFields( 'DATABLO'   , 'BA1_DATBLO'  , .T., .T., { 'BA1_DATBLO'  , 'C', 15, 0 } )
	oSelf:AddMapFields( 'DATAINC'   , 'BA1_DATINC'  , .T., .T., { 'BA1_DATINC'  , 'C', 15, 0 } )
	oSelf:AddMapFields( 'DATANASC'  , 'BA1_DATNAS'  , .T., .T., { 'BA1_DATNAS'  , 'C', 15, 0 } )
	oSelf:AddMapFields( 'CEP'       , 'BA1_MAE'     , .T., .T., { 'BA1_MAE'     , 'C', TamSX3( 'BA1_MAE'    )[1], 0 })
	oSelf:AddMapFields( 'CEPUSR'    , 'BA1_CEPUSR'  , .T., .T., { 'BA1_CEPUSR'  , 'C', TamSX3( 'BA1_CEPUSR' )[1], 0 })
	oSelf:AddMapFields( 'ENDERE'    , 'BA1_ENDERE'  , .T., .T., { 'BA1_ENDERE'  , 'C', TamSX3( 'BA1_ENDERE' )[1], 0 })
	oSelf:AddMapFields( 'NR_END'    , 'BA1_NR_END'  , .T., .T., { 'BA1_NR_END'  , 'C', TamSX3( 'BA1_NR_END' )[1], 0 })
	oSelf:AddMapFields( 'COMPLEM'	, 'BA1_COMEND'  , .T., .T., { 'BA1_COMEND'  , 'C', TamSX3( 'BA1_COMEND' )[1], 0 })
	oSelf:AddMapFields( 'BAIRRO'    , 'BA1_BAIRRO'  , .T., .T., { 'BA1_BAIRRO'  , 'C', TamSX3( 'BA1_BAIRRO' )[1], 0 })
	oSelf:AddMapFields( 'CODMUN'    , 'BA1_CODMUN'  , .T., .T., { 'BA1_CODMUN'  , 'C', TamSX3( 'BA1_CODMUN' )[1], 0 })
	oSelf:AddMapFields( 'MUNICI'    , 'BA1_MUNICI'  , .T., .T., { 'BA1_MUNICI'  , 'C', TamSX3( 'BA1_MUNICI' )[1], 0 })
	oSelf:AddMapFields( 'ESTADO'    , 'BA1_ESTADO'  , .T., .T., { 'BA1_ESTADO'  , 'C', TamSX3( 'BA1_ESTADO' )[1], 0 })
	oSelf:AddMapFields( 'DDD'    	, 'BA1_DDD'  	, .T., .T., { 'BA1_DDD'  	, 'C', TamSX3( 'BA1_DDD' 	)[1], 0 })
	oSelf:AddMapFields( 'TELEFO'    , 'BA1_TELEFO'  , .T., .T., { 'BA1_TELEFO'  , 'C', TamSX3( 'BA1_TELEFO' )[1], 0 })
	oSelf:AddMapFields( 'YTEL2'    	, 'BA1_YTEL2'  	, .T., .T., { 'BA1_YTEL2'  	, 'C', TamSX3( 'BA1_YTEL2' 	)[1], 0 })
	oSelf:AddMapFields( 'YCEL'    	, 'BA1_YCEL'  	, .T., .T., { 'BA1_YCEL'  	, 'C', TamSX3( 'BA1_YCEL' 	)[1], 0 })
    oSelf:AddMapFields( 'FUNCIONAL'	, 'BA1_MATEMP'	, .T., .T., { 'BA1_MATEMP'  , 'C', TamSX3( 'BA1_MATEMP' )[1], 0 })
    oSelf:AddMapFields( 'GRAUPARE'	, 'BA1_GRAUPA'	, .T., .T., { 'BA1_GRAUPA'  , 'C', TamSX3( 'BA1_GRAUPA' )[1], 0 })
    oSelf:AddMapFields( 'PARENTES'	, 'BRP_DESCRI'	, .T., .T., { 'BRP_DESCRI'  , 'C', TamSX3( 'BRP_DESCRI' )[1], 0 })

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
	cQuery := " SELECT #QueryFields#                            " + CRLF
	cQuery += " FROM " + RetSqlName( 'BA1' ) + " BA1            " + CRLF
	cQuery += "     INNER JOIN                                  " + CRLF
	cQuery += "     " + RetSqlName( 'BI3' ) + " BI3             " + CRLF
	cQuery += "     ON                                          " + CRLF
	cQuery += "         BI3.BI3_FILIAL = BA1.BA1_FILIAL         " + CRLF
	cQuery += "         AND BI3.BI3_CODINT = BA1.BA1_CODINT     " + CRLF
	cQuery += "         AND BI3.BI3_CODIGO = BA1.BA1_CODPLA     " + CRLF
	cQuery += "         AND BI3.D_E_L_E_T_ = BA1.D_E_L_E_T_     " + CRLF
    cQuery += "     INNER JOIN                                  " + CRLF
	cQuery += "     " + RetSqlName( 'BRP' ) + " BRP             " + CRLF
	cQuery += "     ON                                          " + CRLF
	cQuery += "         BRP.BRP_FILIAL = BA1.BA1_FILIAL         " + CRLF
	cQuery += "         AND BRP.BRP_CODIGO = BA1.BA1_GRAUPA     " + CRLF
	cQuery += "         AND BRP.D_E_L_E_T_ = BA1.D_E_L_E_T_     " + CRLF
	cQuery += " WHERE #QueryWhere#                              " + CRLF

Return cQuery
