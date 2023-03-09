#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabf002.prw   | Autor : Gustavo Thees            | 19/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabf002() filtro da consulta padrao RCJ.                      |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// +--------------------------------------------------------------------------+

user function cabf002()

// [ gus ]---------------------------------------
    local aGPEUsu      := &( getnewpar( 'MV_XGPEUSU', '{}' ))
    local cCodUsr      := retcodusr()
    local nPos         := ascan( aGPEUsu , { |x| x[1] == cCodUsr } )
    local lUsr         := nPos > 0
    local cFiltro      := .T.
// -----------------------------------------------
    if lUsr
        cFiltro := RCJ->RCJ_CODIGO $ aGPEUsu[nPos][2]
    endif
// -----------------------------------------------

return cFiltro

// ----------------------------------------------------------------------------
// [ fim de cabf002.prw ]
// ----------------------------------------------------------------------------

