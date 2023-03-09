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
CLASS SubcAdapter FROM FWAdapterBaseV2
    METHOD New()
    METHOD GetListSubc()
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} New
Método construtor
@param cVerb, character, verbo HTTP utilizado
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method New( cVerb ) CLASS SubcAdapter
    _Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListSubc
Método que retorna uma lista de produtos
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListSubc(oWs) CLASS SubcAdapter

    Local aArea 	AS ARRAY
    Local cWhere	AS CHAR

    aArea   := FwGetArea()

    //Adiciona o mapa de campos Json/ResultSet
    AddMapFields( self )

    //Informa a Query a ser utilizada pela API
    ::SetQuery( GetQuery() )

    //Informa a clausula Where da Query
    cWhere := " BQC.BQC_FILIAL = '" + FWxFilial('BQC') + "' " + CRLF
    cWhere += " AND BQC.BQC_CODINT = '0001'                 " + CRLF
    cWhere += " AND BQC.BQC_CODEMP = '" + oWS:Code + "'     " + CRLF
    cWhere += " AND BQC.BQC_NUMCON = '" + oWS:CodeCont + "' " + CRLF
    cWhere += " AND BQC.BQC_DATBLO = ' '                    " + CRLF
    cWhere += " AND BQC.D_E_L_E_T_ = ' '                    " + CRLF

    ::SetWhere( cWhere )

    //Informa a ordenação a ser Utilizada pela Query
    ::SetOrder( "BQC_CODIGO" )

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
    
    oSelf:AddMapFields( 'EMPRESA'	    , 'BQC_CODEMP'  , .T., .T., { 'BQC_CODEMP', 'C', TamSX3( 'BQC_CODEMP' )[1], 0 } )
    oSelf:AddMapFields( 'CONTRATO'	    , 'BQC_NUMCON'  , .T., .T., { 'BQC_NUMCON', 'C', TamSX3( 'BQC_NUMCON' )[1], 0 } )
    oSelf:AddMapFields( 'SUBCONTRATO'	, 'BQC_SUBCON'  , .T., .T., { 'BQC_SUBCON', 'C', TamSX3( 'BQC_SUBCON' )[1], 0 } )
    oSelf:AddMapFields( 'DATCON'	    , 'BQC_DATCON'  , .T., .T., { 'BQC_DATCON', 'C', TamSX3( 'BQC_DATCON' )[1], 0 } )
    oSelf:AddMapFields( 'DESCRI'	    , 'BQC_DESCRI'  , .T., .T., { 'BQC_DESCRI', 'C', TamSX3( 'BQC_DESCRI' )[1], 0 } )
    oSelf:AddMapFields( 'NREDUZ'	    , 'BQC_NREDUZ'  , .T., .T., { 'BQC_NREDUZ', 'C', TamSX3( 'BQC_NREDUZ' )[1], 0 } )
    
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
    cQuery := " SELECT #QueryFields#                    " + CRLF
    cQuery +=   " FROM " + RetSqlName( 'BQC' ) + " BQC  " + CRLF  
    cQuery += " WHERE #QueryWhere#                      " + CRLF

Return cQuery
