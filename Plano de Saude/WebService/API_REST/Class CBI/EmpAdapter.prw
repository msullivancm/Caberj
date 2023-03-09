#include 'totvs.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} EmpAdapter
Classe Adapter para o servi�o
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
CLASS EmpAdapter FROM FWAdapterBaseV2
    METHOD New()
    METHOD GetListEmp()
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
M�todo construtor
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method New( cVerb ) CLASS EmpAdapter
    _Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListEmp
M�todo que retorna uma lista de produtos
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListEmp(cCode) CLASS EmpAdapter

    Local aArea 	AS ARRAY
    Local cWhere	AS CHAR

    aArea   := FwGetArea()

    //Adiciona o mapa de campos Json/ResultSet
    AddMapFields( self )

    //Informa a Query a ser utilizada pela API
    ::SetQuery( GetQuery() )

    //Informa a clausula Where da Query
    cWhere := " BG9.BG9_FILIAL = '" + FWxFilial('BG9') + "' " + CRLF
    cWhere += " AND BG9.BG9_CODINT = '0001'                 " + CRLF

    If !Empty(cCode)

        cWhere += " AND BG9.BG9_CODIGO = '" + cCode + "' " + CRLF

    EndIf

    cWhere += " AND BG9.D_E_L_E_T_ = ' '                    " + CRLF

    ::SetWhere( cWhere )

    //Informa a ordena��o a ser Utilizada pela Query
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
Fun��o para gera��o do mapa de campos
@param oSelf, object, Objeto da pr�rpia classe
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function AddMapFields( oSelf )

    oSelf:AddMapFields( 'CODIGO'    , 'BG9_CODIGO'  , .T., .T., { 'BG9_CODIGO', 'C', TamSX3( 'BG9_CODIGO' )[1], 0 } )
    oSelf:AddMapFields( 'DESCRICAO'	, 'BG9_DESCRI'  , .T., .T., { 'BG9_DESCRI', 'C', TamSX3( 'BG9_DESCRI' )[1], 0 } )
    oSelf:AddMapFields( 'NFANTASIA'	, 'BG9_NREDUZ'  , .T., .T., { 'BG9_NREDUZ', 'C', TamSX3( 'BG9_NREDUZ' )[1], 0 } )
    
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetQuery
Retorna a query usada no servi�o
@param oSelf, object, Objeto da pr�rpia classe
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function GetQuery()

    Local cQuery AS CHARACTER

    //Obtem a ordem informada na requisi��o, a query exterior SEMPRE deve ter o id #QueryFields# ao inv�s dos campos fixos
    //necess�riamente n�o precisa ser uma subquery, desde que n�o contenha agregadores no retorno ( SUM, MAX... )
    //o id #QueryWhere# � onde ser� inserido o clausula Where informado no m�todo SetWhere()
    cQuery := " SELECT #QueryFields#                    " + CRLF
    cQuery +=   " FROM " + RetSqlName( 'BG9' ) + " BG9  " + CRLF  
    cQuery += " WHERE #QueryWhere#                      " + CRLF

Return cQuery
