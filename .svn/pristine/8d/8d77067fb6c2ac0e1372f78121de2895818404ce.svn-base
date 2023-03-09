//#INCLUDE  'PROTHEUS.CH'
//#INCLUDE  'GPEA1400.CH'
//#INCLUDE    'COLORS.CH'
//#INCLUDE  'HEADERGD.CH'
//#INCLUDE 'FWMBROWSE.CH'
//#INCLUDE  'FWMVCDEF.CH'

#INCLUDE  'PROTHEUS.CH'
#INCLUDE    'COLORS.CH'
#INCLUDE 'FWMBROWSE.CH'
#INCLUDE  'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : caba226.prw   | Autor : Gustavo Thees            | 20/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : caba226() ( adaptada da função padrão GPEA400() )             |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// +--------------------------------------------------------------------------+

//   Function GPEA400()
user function caba226()

// [ gus ]---------------------------------------
    local  aGPEUsu       := &( getnewpar( 'MV_XGPEUSU', '{}' ))
    local  cCodUsr       := retcodusr()
    local  nPos          := ascan( aGPEUsu , { |x| x[1] == cCodUsr } )
    local  lUsr          := nPos > 0
// ----------------------------------------------
    local  aCoors        := fwgetdialogsize( oMainWnd )
    local  cFTerRCJ      := ''
    local  cFTerRFQ      := ''
    local  oDlg
    local  oFWLayer
    local  oPanelUp
    local  oPanelDown
    local  cFtrModulo    := if( cModulo $ "GPE*GFP","GPE*GFP",cModulo )
// ----------------------------------------------
    static lValEnchoice        // Utilizado para o controle da Enchoice
    static lFirstDelOk         // Controle de Delecao de RCF
    static lPerMod2      := !( MV_MODFOL == '1' ) .AND. supergetmv( "MV_PERMOD2" , .F. , .F. ,  )	 // .T. = Usa cadastro de periodos simplificado para folha modelo 2 (valor padrao = .F.)
// ----------------------------------------------
    private aColsRCHSF   := {} // Vetor aCols sem Filtro
    private aHeaderRCHSF := {}
    private cCadastro    := oemtoansi( 'Calendário' )
    private lModPadrao   := ( MV_MODFOL == '1' ) // Modelo do SIGAGPE
    private cTpCalend    := supergetmv( 'MV_TPCALEN' , .F. , '1' ,  ) // 1 = Usa calendario Analitico           , 2 = Usa calendario Sintetico
    private cQtdeDPer    := supergetmv( 'MV_DIASPER' , .F. , '1' ,  ) // 1 = Usa qtde de dias do mes do periodo , 2 = Usa sempre 30
    private lF3Criter    := .F. // Variavel que verifica se a chamada da consulta do criterio foi efetuada a partir do F3
    private oMBrowseUp
    private oMBrowseDown
    private aRotina

//  Utilizacao do Cadastro simplificado para paises que utilizam a Folha Modelo 2
    if lPerMod2 .AND. findfunction( 'GPEA400A' )
        gpea400a()
        return( NIL )
    endif

//  Limpa variavel n(publica) se existir
    if !( Type( 'n' ) == 'NIL' )
        n := 0
    endif
       
//  Modo de compartilhamento da tabela RCJ
    cCpartRCJ := fwmodeaccess( 'RCJ' , 1 )
    cCpartRCJ += fwmodeaccess( 'RCJ' , 2 )
    cCpartRCJ += fwmodeaccess( 'RCJ' , 3 )

//  Modo de compartilhamento da tabela RCH
    cCpartRCH := fwmodeaccess( 'RCH' , 1 )
    cCpartRCH += fwmodeaccess( 'RCH' , 2 )
    cCpartRCH += fwmodeaccess( 'RCH' , 3 )

//  Modo de compartilhamento da tabela RFQ
    cCpartRFQ := fwmodeaccess( 'RFQ' , 1 )
    cCpartRFQ += fwmodeaccess( 'RFQ' , 2 )
    cCpartRFQ += fwmodeaccess( 'RFQ' , 3 )

//  Modo de compartilhamento da tabela RCF
    cCpartRCF := fwmodeaccess( 'RCF' , 1 )
    cCpartRCF += fwmodeaccess( 'RCF' , 2 )
    cCpartRCF += fwmodeaccess( 'RCF' , 3 )

//  Modo de compartilhamento da tabela RCG
    cCpartRCG := fwmodeaccess( 'RCG' , 1 )
    cCpartRCG += fwmodeaccess( 'RCG' , 2 )
    cCpartRCG += fwmodeaccess( 'RCG' , 3 )

//  Modo de compartilhamento da tabela RG3
    cCpartRG3 := fwmodeaccess( 'RG3' , 1 )
    cCpartRG3 += fwmodeaccess( 'RG3' , 2 )
    cCpartRG3 += fwmodeaccess( 'RG3' , 3 )

//  Verifica se as tabelas estao com o mesmo modo de compartilhamento
    if ( cCpartRCJ != cCpartRCH ) .OR. ;
       ( cCpartRCJ != cCpartRFQ ) .OR. ;
       ( cCpartRCJ != cCpartRCF ) .OR. ;
       ( cCpartRCJ != cCpartRCG ) .OR. ;
       ( cCpartRCJ != cCpartRG3 )
        help( , , 'HELP', , oemtoansi( 'Verifique o compartilhamento entre as tabelas RCJ, RCH, RFQ, RCF e RCG. O compartilhamento dessas tabelas deve ser idêntico.' ), 1, 0 )
        return ( .F. )
    endif

// [ gus ]---------------------------------------
////  Inicializa o filtro utilizando a funcao FilBrowse
//    cFTerRCJ := chkrh( funname() , 'RCJ' , '1' )
//    cFTerRFQ := " RFQ->RFQ_MODULO $ '" + cFtrModulo + "'"
// ----------------------------------------------
    if lUsr
        cFTerRCJ := " RCJ->RCJ_CODIGO $ '" + strtran( aGPEUsu[nPos][2] , "'" , "" ) + "' "
    else
        cFTerRCJ := chkrh( funname() , 'RCJ' , '1' )
    endif
    cFTerRFQ := " RFQ->RFQ_MODULO $ '" + cFtrModulo + "'"
// ----------------------------------------------

    DEFINE MSDIALOG oDlg TITLE 'Calendário' FROM aCoors[1] , aCoors[2] TO aCoors[3] , aCoors[4] PIXEL

    oFWLayer := FWLayer():New()
    oFWLayer:Init( oDlg , .F. , .T. )

//  Browse RCJ
    oFWLayer:AddLine( 'UP' , 35 , .F. )
    oFWLayer:AddCollumn( 'ALLRCJ' , 100 , .T. , 'UP' )
    oPanelUp := oFWLayer:GetColPanel( 'ALLRCJ' , 'UP' )

    oMBrowseUp := FWMBrowse():New()
    oMBrowseUp:SetOwner( oPanelUp )
    oMBrowseUp:SetDescription( 'Cadastro de Processos' )
    oMBrowseUp:SetAlias( 'RCJ' )
    oMBrowseUp:SetMenuDef( '' )
    oMBrowseUp:SetCacheView ( .F. )
    oMBrowseUp:SetProfileID( '1' )
    oMBrowseUp:SetFilterDefault( cFTerRCJ )
    oMBrowseUp:DisableDetails()
    oMBrowseUp:Activate()

    if cPaisLoc $ 'BRA|RUS'
//      Browse RFQ
        oFWLayer:AddLine( 'DOWN' , 65 , .F. )
        oFWLayer:AddCollumn( 'ALLRFQ' , 100 , .T. , 'DOWN' )
        oPanelDown := oFWLayer:GetColPanel( 'ALLRFQ', 'DOWN' )

        oMBrowseDown := FWMBrowse():New()
        oMBrowseDown:SetOwner( oPanelDown )
        oMBrowseDown:SetDescription( 'Cadastro de Períodos' )
        oMBrowseDown:SetMenuDef( 'GPEA400' )
        oMBrowseDown:DisableDetails()
        oMBrowseDown:SetAlias( 'RFQ' )
        oMBrowseDown:SetCacheView ( .F. )
        oMBrowseDown:SetProfileID( '2' )
        oMBrowseDown:ForceQuitButton()
        oMBrowseDown:AddLegend( "RFQ_STATUS == '1' .Or. RFQ_STATUS == ' ' " , "GREEN" , oemtoansi( 'Período Aberto'  ) )
        oMBrowseDown:AddLegend( "RFQ_STATUS == '2'"                         , "RED"   , oemtoansi( 'Período Fechado' ) )
        oMBrowseDown:Activate()
        oRelation := FWBrwRelation():New()

        oRelation:AddRelation( oMBrowseUp , oMBrowseDown , { { 'RFQ_FILIAL' , 'RCJ_FILIAL' } , ;
                                                             { 'RFQ_PROCES' , 'RCJ_CODIGO' } } )
    else
//      Browse RCH
        oFWLayer:AddLine( 'DOWN' , 65 , .F. )
        oFWLayer:AddCollumn( 'ALLRFQ' , 100 , .T. , 'DOWN' )
        oPanelDown := oFWLayer:GetColPanel( 'ALLRFQ' , 'DOWN' )

        oMBrowseDown := FWMBrowse():New()
        oMBrowseDown:SetOwner( oPanelDown )
        oMBrowseDown:SetDescription( 'Cadastro de Períodos' )
        oMBrowseDown:SetMenuDef( 'GPEA400' )
        oMBrowseDown:DisableDetails()
        oMBrowseDown:SetAlias( 'RCH' )
        oMBrowseDown:SetCacheView ( .F. )
        oMBrowseDown:SetProfileID( '2' )
        oMBrowseDown:ForceQuitButton()
        oMBrowseDown:Activate()
        oRelation := FWBrwRelation():New()

        oRelation:AddRelation( oMBrowseUp , oMBrowseDown , { { 'RCH_FILIAL' , 'RCJ_FILIAL' } , ;
                                                             { 'RCH_PROCES' , 'RCJ_CODIGO' } } )
        cFTerRFQ := " RCH->RCH_MODULO $ '" + cFtrModulo + "'"
    endif

    oRelation:Activate()

    oMBrowseDown:AddFilter( 'Filtro por Módulo' , cFTerRFQ , .T. , .T. )
    oMBrowseDown:ExecuteFilter()

    ACTIVATE MSDIALOG oDlg

    lValEnchoice := NIL
    lFirstDelOk  := NIL

return

// ----------------------------------------------------------------------------
// [ fim de caba226.prw ]
// ----------------------------------------------------------------------------
