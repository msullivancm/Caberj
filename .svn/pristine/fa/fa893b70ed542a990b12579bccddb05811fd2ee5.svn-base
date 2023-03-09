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
CLASS FamiAdapter FROM FWAdapterBaseV2
    METHOD New()
    METHOD GetListFam()
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
Method New( cVerb ) CLASS FamiAdapter
    _Super:New( cVerb, .T. )
return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetListFam
Método que retorna uma lista de familias
@author  Angelo Henrique
@since   19/05/2022
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
Method GetListFam(oWs) CLASS FamiAdapter

    Local aArea 	AS ARRAY
    Local cWhere	AS CHAR

    aArea   := FwGetArea()

    //Adiciona o mapa de campos Json/ResultSet
    AddMapFields( self )

    //Informa a Query a ser utilizada pela API
    ::SetQuery( GetQuery() )

    //Informa a clausula Where da Query
    cWhere := " BA3.BA3_FILIAL = '" + FWxFilial('BA3') + "'     " + CRLF
    cWhere += " AND BA3.BA3_CODINT = '0001'                     " + CRLF
    cWhere += " AND BA3.BA3_CODEMP = '" + oWS:Code  + "'        " + CRLF

    If !Empty( AllTrim(oWS:CodeMat))        
        cWhere += " AND BA3.BA3_MATRIC = '" + oWS:CodeMat + "   " + CRLF
    EndIf

    cWhere += " AND BA3.BA3_CONEMP = '" + oWS:CodeCont + "'     " + CRLF
    cWhere += " AND BA3.BA3_SUBCON = '" + oWS:CodeSubc + "'     " + CRLF
    
    If Upper(AllTrim(oWS:Bloqued)) == "S"
        cWhere += " AND BA3.BA3_DATBLO <> ' '                   " + CRLF
    ElseIf Upper(AllTrim(oWS:Bloqued)) = "N" 
        cWhere += " AND BA3.BA3_DATBLO = ' '                    " + CRLF
    EndIf

    If !Empty( AllTrim(oWS:CodePlan))        
        cWhere += " AND BA3.BA3_CODPLA = '" + oWS:CodePlan + "' " + CRLF
    EndIf
    
    cWhere += " AND BA3.D_E_L_E_T_ = ' '                        " + CRLF

    ::SetWhere( cWhere )

    //Informa a ordenação a ser Utilizada pela Query
    ::SetOrder( "BA3_MATRIC" )

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

    oSelf:AddMapFields( 'CODINT'    , 'BA3_CODINT'  , .T., .T., { 'BA3_CODINT', 'C', TamSX3( 'BA3_CODINT' )[1], 0 })    
    oSelf:AddMapFields( 'CODEMP'    , 'BA3_CODEMP'  , .T., .T., { 'BA3_CODEMP', 'C', TamSX3( 'BA3_CODEMP' )[1], 0 })
    oSelf:AddMapFields( 'MATRIC'    , 'BA3_MATRIC'  , .T., .T., { 'BA3_MATRIC', 'C', TamSX3( 'BA3_MATRIC' )[1], 0 })    
    oSelf:AddMapFields( 'TITULAR'   , 'BA1_NOMUSR'  , .T., .T., { 'BA1_NOMUSR', 'C', TamSX3( 'BA1_NOMUSR' )[1], 0 })
    oSelf:AddMapFields( 'PLANO'     , 'BA3_CODPLA'  , .T., .T., { 'BA3_CODPLA', 'C', TamSX3( 'BA3_CODPLA' )[1], 0 })
    oSelf:AddMapFields( 'DESCPLANO' , 'BI3_DESCRI'  , .T., .T., { 'BI3_DESCRI', 'C', TamSX3( 'BI3_DESCRI' )[1], 0 })
    oSelf:AddMapFields( 'DATABLO'   , 'BA1_DATBLO'  , .T., .T., { 'BA1_DATBLO', 'C', 15, 0 } )
    oSelf:AddMapFields( 'DATAINC'   , 'BA1_DATINC'  , .T., .T., { 'BA1_DATINC', 'C', 15, 0 } )

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
    cQuery += " FROM " + RetSqlName( 'BA3' ) + " BA3            " + CRLF
    cQuery += "     INNER JOIN                                  " + CRLF
    cQuery += "     " + RetSqlName( 'BA1' ) + " BA1             " + CRLF
    cQuery += "     ON                                          " + CRLF
    cQuery += "         BA1.BA1_FILIAL      = BA3.BA3_FILIAL    " + CRLF
    cQuery += "         AND ba1.ba1_codint  = ba3.ba3_codint    " + CRLF
    cQuery += "         AND ba1.ba1_codemp  = ba3.ba3_codemp    " + CRLF
    cQuery += "         AND BA1.BA1_MATRIC  = ba3.ba3_matric    " + CRLF
    cQuery += "         AND ba1.ba1_tipusu  = 'T'               " + CRLF
    cQuery += "         AND ba1.d_e_l_e_t_  = ba3.d_e_l_e_t_    " + CRLF
    cQuery += "     INNER JOIN                                  " + CRLF
    cQuery += "     " + RetSqlName( 'BI3' ) + " BI3             " + CRLF
    cQuery += "     ON                                          " + CRLF
    cQuery += "         BI3.BI3_FILIAL = BA3.BA3_FILIAL         " + CRLF
    cQuery += "         AND BI3.BI3_CODINT = BA3.BA3_CODINT     " + CRLF
    cQuery += "         AND BI3.BI3_CODIGO = BA3.BA3_CODPLA     " + CRLF
    cQuery += "         AND BI3.D_E_L_E_T_ = BA3.D_E_L_E_T_     " + CRLF
    cQuery += " WHERE #QueryWhere#                              " + CRLF

Return cQuery
