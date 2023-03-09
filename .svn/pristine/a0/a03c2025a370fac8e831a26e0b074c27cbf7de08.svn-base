#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabf003.prw   | Autor : Gustavo Thees            | 25/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabf003() filtro da consulta padrao PCB - Canal.              |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 87281 - Filtro de registros por usuário.              |
// +--------------------------------------------------------------------------+

user function cabf003()

// [ gus ]---------------------------------------
    local cPLSUsu := getnewpar( 'MV_XPAUSU', '' )
    local cPLSCan := getnewpar( 'MV_XPACAN', '' )
    local cCodUsr := retcodusr()
    local lUsr    := ( cCodUsr $ cPLSUsu )
    local lFiltro := .T.
// -----------------------------------------------
    if lUsr
        lFiltro := PCB->PCB_COD $ cPLSCan
    endif
// -----------------------------------------------

return lFiltro

// ----------------------------------------------------------------------------
// [ fim de cabf003.prw ]
// ----------------------------------------------------------------------------

