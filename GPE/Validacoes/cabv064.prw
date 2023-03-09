#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabv064.prw   | Autor : Gustavo Thees            | 19/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabv064() validação de pergunte. ( GPEM020/01/Processo ? )    |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// +--------------------------------------------------------------------------+

user function cabv064()

// [ gus ]---------------------------------------
    local aGPEUsu := &( getnewpar( 'MV_XGPEUSU', '{}' ))
    local cCodUsr := retcodusr()
    local nPos    := ascan( aGPEUsu , { |x| x[1] == cCodUsr } )
    local lUsr    := nPos > 0
    local lRet    := .T.
    local cProc   := &( readvar() )
// -----------------------------------------------
    if lUsr
        lRet := cProc $ aGPEUsu[nPos][2]
    endif
// -----------------------------------------------

return lRet

// ----------------------------------------------------------------------------
// [ fim de cabv064.prw ]
// ----------------------------------------------------------------------------

