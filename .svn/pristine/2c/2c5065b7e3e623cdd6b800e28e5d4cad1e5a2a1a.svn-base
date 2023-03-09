#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabv065.prw   | Autor : Gustavo Thees            | 26/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabv065() validacao de campo ZX_CANAL - Canal.                |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 87281 - Validacao de registros por usuário.           |
// +--------------------------------------------------------------------------+

user function cabv065()

    local cPLSUsu := getnewpar( 'MV_XPAUSU', '' )
    local cPLSCan := getnewpar( 'MV_XPACAN', '' )
    local cCodUsr := retcodusr()
    local lUsr    := ( cCodUsr $ cPLSUsu )
    local lRet    := .T.
    local cCanal  := padl( alltrim( M->ZX_CANAL ) , tamsx3( 'ZX_CANAL' )[1] , '0' )
// -----------------------------------------------
    if lUsr
//      lRet := M->ZX_CANAL $ cPLSCan
        lRet := cCanal      $ cPLSCan
    endif
// -----------------------------------------------

return lRet

// ----------------------------------------------------------------------------
// [ fim de cabv065.prw ]
// ----------------------------------------------------------------------------
