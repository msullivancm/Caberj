#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabf004.prw   | Autor : Gustavo Thees            | 26/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabf004() filtro da consulta padrao PCA - Porta de Entrada.   |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 87281 - Filtro de registros por usuário.              |
// +--------------------------------------------------------------------------+

user function cabf004()

// [ gus ]---------------------------------------
    local cPLSUsu := getnewpar( 'MV_XPAUSU', '' )
    local cPLSPen := getnewpar( 'MV_XPAPEN', '' )
    local cCodUsr := retcodusr()
    local lUsr    := ( cCodUsr $ cPLSUsu )
    local lFiltro := .T.
// -----------------------------------------------
    if lUsr
        lFiltro := PCA->PCA_COD $ cPLSPen
    endif
// -----------------------------------------------

return lFiltro

// ----------------------------------------------------------------------------
// [ fim de cabf004.prw ]
// ----------------------------------------------------------------------------

