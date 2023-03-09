#include 'totvs.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} PrdAdapter
Classe Adapter para o serviço
@author  Angelo Henrique
@since   19/05/2022
@Type function
@version 1.0
/*/
//-------------------------------------------------------------------
CLASS ContAdapter FROM FWAdapterBaseV2
    METHOD New()
    METHOD GetListCont()
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
Método construtor
@author  Angelo Henrique
@since   19/05/2022
@Type function
@version 1.0
/*/
//-------------------------------------------------------------------
Method New( cVerb ) CLASS ContAdapter
    _Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListCont
Método que retorna uma lista de produtos
@author  Angelo Henrique
@since   19/05/2022
@Type function
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListCont(cCode) CLASS ContAdapter

    Local aArea 	AS ARRAY
    Local cWhere	AS CHAR

    aArea   := FwGetArea()

    //Adiciona o mapa de campos Json/ResultSet
    AddMapFields( self )

    //Informa a Query a ser utilizada pela API
    ::SetQuery( GetQuery() )

    //Informa a clausula Where da Query
    cWhere := " BT5.BT5_FILIAL = '" + FWxFilial('BT5') + "' " + CRLF
    cWhere += " AND BT5.BT5_CODINT = '0001'                 " + CRLF
    cWhere += " AND BT5.BT5_CODIGO = '" + cCode + "'        " + CRLF
    cWhere += " AND BT5.D_E_L_E_T_ = ' '                    " + CRLF

    ::SetWhere( cWhere )

    //Informa a ordenação a ser Utilizada pela Query
    ::SetOrder( "BT5_CODIGO" )

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
@Type function
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function AddMapFields( oSelf )

    oSelf:AddMapFields( 'CODIGO'        , 'BT5_CODIGO'  , .T., .T., { 'BT5_CODIGO', 'C', TamSX3( 'BT5_CODIGO' )[1], 0 } )
    oSelf:AddMapFields( 'NUMCONTRATO'	, 'BT5_NUMCON'  , .T., .T., { 'BT5_NUMCON', 'C', TamSX3( 'BT5_NUMCON' )[1], 0 } )
    oSelf:AddMapFields( 'VERSAO'	    , 'BT5_VERSAO'  , .T., .T., { 'BT5_VERSAO', 'C', TamSX3( 'BT5_VERSAO' )[1], 0 } )
    oSelf:AddMapFields( 'DATCON'	    , 'BT5_DATCON'  , .T., .T., { 'BT5_DATCON', 'C', TamSX3( 'BT5_DATCON' )[1], 0 } )
    
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetQuery
Retorna a query usada no serviço
@param oSelf, object, Objeto da prórpia classe
@author  Angelo Henrique
@since   19/05/2022
@Type function
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function GetQuery()

    Local cQuery AS CHARACTER

    //Obtem a ordem informada na requisição, a query exterior SEMPRE deve ter o id #QueryFields# ao invés dos campos fixos
    //necessáriamente não precisa ser uma subquery, desde que não contenha agregadores no retorno ( SUM, MAX... )
    //o id #QueryWhere# é onde será inserido o clausula Where informado no método SetWhere()
    cQuery := " SELECT #QueryFields#                    " + CRLF
    cQuery +=   " FROM " + RetSqlName( 'BT5' ) + " BT5  " + CRLF  
    cQuery += " WHERE #QueryWhere#                      " + CRLF

Return cQuery
