#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabv066.prw   | Autor : Gustavo Thees            | 27/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabv066() validacao de campo ZX_PTENT - Porta Entrada.        |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 87281 - Validacao de registros por usuário.           |
// +--------------------------------------------------------------------------+

user function cabv066()

    local cPLSUsu := getnewpar( 'MV_XPAUSU', '' )
    local cPLSPen := getnewpar( 'MV_XPAPEN', '' )
    local cCodUsr := retcodusr()
    local lUsr    := ( cCodUsr $ cPLSUsu )
    local lRet    := .T.
    local cPorta  := padl( alltrim( M->ZX_PTENT ) , tamsx3( 'ZX_PTENT' )[1] , '0' )
// -----------------------------------------------
    if lUsr
//      lRet := M->ZX_PTENT $ cPLSPen
        lRet := cPorta      $ cPLSPen
    endif
// -----------------------------------------------

return lRet

// ----------------------------------------------------------------------------
// [ fim de cabv066.prw ]
// ----------------------------------------------------------------------------
