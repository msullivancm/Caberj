//#INCLUDE 'PROTHEUS.CH'
//#INCLUDE 'SCOPECNT.CH'
//#INCLUDE 'GPEM1120.CH'
//#INCLUDE 'FWMVCDEF.CH'

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

Static __aRotErr  := {}
Static aProcRet   := {}
Static __lMemCalc

// +--------------------------+----------------------------------+------------+
// | Programa : caba218.prw   | Autor : Gustavo Thees            | 11/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : caba218() ( adaptada da função padrão GPEM120() )             |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// +--------------------------------------------------------------------------+

//   Function GPEM120( cProcAut , cRotAut )
user function caba218( cProcAut , cRotAut )

    local   aArea           := getarea()
    local   aColsMark       := {}
    local   aAdvSize        := {}
    local   aInfoAdvSize    := {}
    local   aObjSize        := {}
    local   aObjCoords      := {}
    local   aOfusca         := if( findfunction( 'ChkOfusca' ) , ChkOfusca() , { .T. , .F. } ) // [2]Ofuscamento
    local   aFldRel         := if( aOfusca[2] , fwprotecteddatautil():UsrNoAccessFieldsInList( { 'RA_NOME' } ) , {} )
// ----------------------------------------------
//  local   cNotInt         := fgetrotnotint()                                                 // Obtem roteiros que nao necessitam ser integrados // gus
    local   cNotInt         := fgetrotnotint () // staticcall( gpem120 , fgetrotnotint )                           // Obtem roteiros que nao necessitam ser integrados // gus
// ----------------------------------------------    
    local   lBlind          := isblind()
    local   lMarcar         := .F.
    local   cProcesTit      := ''
    local   cPeriodTit      := ''
    local   cNumPagTit      := ''
    local   cProcedTit      := ''
// ------------------------------------
    local   oPanelUp
    local   oTela
    local   oPanelDown
    local   oGroup
    local   oFont
// ------------------------------------
    private bTemAcesso      := { |x| ( empty( TAB_FIL ) .OR. alltrim( TAB_FIL ) $ fValidFil() ) }
//  private aLogErros       := array( 13 , 0 )                                     // Log de Erros dos periodos que houveram inconsistencias // gus
    private aLogErros       := array( 20 , 0 )                                     // Log de Erros dos periodos que houveram inconsistencias // gus
    private cAliasMark      := getnextalias()
    private cCadastro       := oemtoansi( 'Fechamento de Periodos' )
    private cProcesso       := space( getsx3cache( 'RCH_PROCES' , 'X3_TAMANHO' ) ) // Codigo  do Processo
    private cPeriodo        := space( getsx3cache( 'RCH_PER'    , 'X3_TAMANHO' ) ) // Codigo  do Periodo
    private cRoteiro        := space( getsx3cache( 'RCH_ROTEIR' , 'X3_TAMANHO' ) ) // Roteiro de Calculo
    private cNumPag         := space( getsx3cache( 'RCH_NUMPAG' , 'X3_TAMANHO' ) ) // Numero  de Pagamento
    private cTpRoteir       := ''                                                  // Tipo    de Roteiro
    private cPaisFol1       := 'VEN/PER'
    private cAtualSit       := getmvrh( 'MV_SITRES' , .F. , '2' )
    private cSRCDesc        := ''
    private cSRDDesc        := ''
    private oMark
    private oDlg
    private oTmpTable
    private lModPadrao      := !( MV_MODFOL == '2' )                                 // 1-Modelo padrao ; 2- Novo Modelo Mexico
    private lPerMod2        := !lModPadrao .AND. getmvrh( 'MV_PERMOD2' , .F. , .F. ) // Usa cadastro de periodos simplificado para folha modelo 2 (valor padrao = .F.)
    private lFilComp        := empty( xfilial( 'RCH' ))
    private lOfusca         := len( aFldRel ) > 0
    private lGestPubl       := iif( existfunc( 'fUsaGFP' ) , if( cModulo=='GPE' , .F. , fUsaGFP() ) , .F. )
// ------------------------------------
    private lGeraAcumulador := .F.
// ------------------------------------
    aProcRet                := {}
// ------------------------------------
    Default cRotAut         := ''
    Default __lMemCalc      := cPaisLoc == 'BRA' .AND. findfunction( 'fMemCalc' ) .AND. fMemCalc() // Memória de cálculo
// ------------------------------------
    if findfunction( 'fValidFun' )

        if !( fvalidfun( { 'SRA' , 'SRV' , 'SRC' , 'SRD' , ;
                           'SRK' , 'SR8' , 'SRF' , 'RG1' , ;
                           'RCI' , 'SR3' , 'SRM' , 'RG9' , ;
                           'RG7' , 'RG8' , 'RGB' , 'SRH' , 'RCM' } ) )
            restarea( aArea )
            return( NIL )
        endif

    endif

    if empty( fgetrotordinar() )
        help( ' ' , 1 , 'M120ROTORD' ) // Nenhum Roteiro foi definido como Ordinario! - Solucao: No cadastro de Roteiro de Calculo informe um roteiro como Ordinario.
        return( NIL )
    endif

    if !pgsexclusive()
        help( ' ' , 1 , 'PGSEXC' )
    endif

// -[ gus - ini ]----------------------
//  if !fcriatmp()                                    // gus
//      Help( ,, 'HELP',, STR0004                                                                   , 1 , 0 ) //"Nenhum dos roteiros aptos a integraçŽ¢o possuem peréŸ”do de cé† culo ativo."
//  endif
//  aColsMark := fMntColsMark()                       // gus
// ------------------------------------

    
/*
    if !staticcall( gpem120 , fcriatmp )              // gus
        Help( ,, 'HELP',, 'Nenhum dos roteiros aptos a integração possui período de cálculo ativo.' , 1 , 0 )
    endif
*/

    if !fcriatmp()               // gus
        Help( ,, 'HELP',, 'Nenhum dos roteiros aptos a integração possui período de cálculo ativo.' , 1 , 0 )
    endif


    //aColsMark := staticcall( gpem120 , fMntColsMark ) // gus

    aColsMark := fMntColsMark() // TRR


// ------------------------------------

    dbselectarea( cAliasMark )
    if lBlind
        if !empty( cRotAut )
            SET FILTER TO TAB_PROC == cProcAut .AND. TAB_ROT == cRotAut
        else
            SET FILTER TO TAB_PROC == cProcAut
        endif
        gpm120inimark()
    else

        SET FILTER TO TAB_PROC  == space( tamsx3( 'RCH_PROCES' )[1] )

        dbselectarea( 'SX3' )
        SX3->( dbsetorder( 2 )) // X3_CAMPO

        if SX3->( dbseek( 'RCH_PROCES' ))
            cProcesTit := x3titulo()
        endif
        if SX3->( dbseek( 'RCH_PER'    ))
            cPeriodTit := x3titulo()
        endif
        if SX3->( dbseek( 'RCH_NUMPAG' ))
            cNumPagTit := x3titulo()
        endif
        if SX3->( dbseek( 'RCH_ROTEIR' ))
            cProcedTit := x3titulo()
        endif

        aAdvSize     := msadvsize( , .T. , 500 )
        aInfoAdvSize := { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 15 , 5 }
        aadd( aObjCoords , { 000 , 000 , .T. , .T. } )
        aObjSize     := msobjsize( aInfoAdvSize , aObjCoords )

        Define MsDialog oDlg FROM aAdvSize[7] , 0 TO aAdvSize[6] , aAdvSize[5] Title 'Fechamento de Períodos' Pixel

// -----[ Cria o conteiner onde serao colocados os paineis ]----
        oTela   := fwformcontainer():New( oDlg )
        cIdCab  := oTela:CreateHorizontalBox( 15 )
        cIdGrid := oTela:CreateHorizontalBox( 80 )

        oTela:Activate( oDlg , .F. )

// -----[ Cria os paineis onde serao colocados os browses ]-----
        oPanelUp   := oTela:GeTPanel( cIdCab  )
        oPanelDown := oTela:GeTPanel( cIdGrid )

        @ 3 , 3 GROUP oGroup TO aObjSize[1,3]*0.16 , aObjSize[1,4] LABEL OemToAnsi( 'Selecione os filtros para fechamento' ) OF oPanelUp PIXEL
        oGroup:oFont := oFont

// -----[ gus - ini ]--------------------------------------------------------------------
//      @  aObjSize[1,1]*0.5    , aObjSize[1,2]+1   SAY   OemToAnsi(cProcesTit) SIZE 038,007 OF oPanelUp PIXEL
//      @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+1   MSGET cProcesso             SIZE 010,007 OF oPanelUp F3 'XRCHFE' PIXEL WHEN .T. VALID ( Vazio() .OR. ExistCpo('RCJ') ) .AND. ;
//                                                                                                                                          Gp120VldGrid()
//
//      @  aObjSize[1,1]*0.5    , aObjSize[1,2]+80  SAY   OemToAnsi(cPeriodTit) SIZE 038,007 OF oPanelUp PIXEL
//      @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+80  MSGET cPeriodo              SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID Gp120VldGrid()
//
//      @  aObjSize[1,1]*0.5    , aObjSize[1,2]+160 SAY   OemToAnsi(cNumPagTit) SIZE 038,007 OF oPanelUp PIXEL
//      @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+160 MSGET cNumPag               SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID Gp120VldGrid()
//
//      @  aObjSize[1,1]*0.5    , aObjSize[1,2]+240 SAY   OemToAnsi(cProcedTit) SIZE 038,007 OF oPanelUp PIXEL
//      @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+240 MSGET cRoteiro              SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID Gp120VldGrid()
// --------------------------------------------------------------------------------------
        @  aObjSize[1,1]*0.5    , aObjSize[1,2]+1   SAY   OemToAnsi(cProcesTit) SIZE 038,007 OF oPanelUp PIXEL
        @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+1   MSGET cProcesso             SIZE 010,007 OF oPanelUp F3 'XRCHFE' PIXEL WHEN .T. VALID ( Vazio() .OR. ExistCpo('RCJ') ) .AND. ;
		                                                                                                                                    xGp120VldGrid()

        @  aObjSize[1,1]*0.5    , aObjSize[1,2]+80  SAY   OemToAnsi(cPeriodTit) SIZE 038,007 OF oPanelUp PIXEL
        @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+80  MSGET cPeriodo              SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID xGp120VldGrid()

        @  aObjSize[1,1]*0.5    , aObjSize[1,2]+160 SAY   OemToAnsi(cNumPagTit) SIZE 038,007 OF oPanelUp PIXEL
        @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+160 MSGET cNumPag               SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID xGp120VldGrid()

        @  aObjSize[1,1]*0.5    , aObjSize[1,2]+240 SAY   OemToAnsi(cProcedTit) SIZE 038,007 OF oPanelUp PIXEL
        @ (aObjSize[1,1]*0.5)+6 , aObjSize[1,2]+240 MSGET cRoteiro              SIZE 010,007 OF oPanelUp PIXEL WHEN .T. VALID xGp120VldGrid()
// --------------------------------------------------------------------------------------

        oMark := fwmarkbrowse():New()

        oMark:SetAlias( (cAliasMark) )
        oMark:SetFields( aColsMark )

// -----[ Indica o container onde sera criado o browse ]--------
        oMark:SetOwner( oPanelDown )

        oMark:bAllMark := { || setmarkall( oMark:Mark() , lMarcar := !lMarcar ) , oMark:Refresh(.T.) }

// -----[ Define o campo que sera utilizado para a marcação ]---
        oMark:SetFieldMark( 'TAB_OK')

// -----[ So permite o fechamento de registros integrados ]-----
        oMark:SetValid({|| ( !lModPadrao    .OR. !empty(TAB_INTEG) .OR. TAB_ROT          $ cNotInt ) .AND. ;
                                                ( empty(TAB_FIL  ) .OR. alltrim(TAB_FIL) $ fValidFil() ) } )
        oMark:SetMenuDef( 'GPEM120' )

        oMark:AddLegend( "lModPadrao .AND. empty(TAB_INTEG) .AND. !(TAB_ROT $ " + cNotInt + ")", "RED"   , 'Falta Integrar'       )
        oMark:AddLegend( "!lModPadrao .OR. !empty(TAB_INTEG) .OR. TAB_ROT $ "   + cNotInt      , "GREEN" , 'Apto para Fechamento' )

        oMark:Activate()

        ACTIVATE MSDIALOG oDlg CENTERED

    endif

    PgsShared()

    if oTmpTable <> Nil
        oTmpTable:Delete()
        oTmpTable := Nil
    endif

    restarea( aArea )

return( NIL )

// +--------------------------------------------------------------------------+
// | Funcao   : xgp120ini() ( adaptada da função padrão Gp120IniSXB() )       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// |            Função chamado pela consulta padrão XRCHFEC (sxb)             |
// +--------------------------------------------------------------------------+

user function xgp120ini()

// -----------------------------------------------
    local aArea        := getarea()
    local cAliasQry    := 'QRCH'
    local cWhere       := ''
    local cKeyAux      := ''
    local lOK          := .F.
    local nPosLbxA     := 0.00
    local oDlg         := NIL
    local oLbxA        := NIL
    local nOpca        := 0
// -----------------------------------------------
    local aAdvSize     := {}
    local aInfoAdvSize := {}
    local aObjCoords   := {}
    local aObjSize     := {}
// -----------------------------------------------
    local lGestPubl    := iif( existfunc( 'fUsaGFP' ) , fUsaGFP() , .F. )
    local cJoinModl    := ''
    local lRCJModulo   := RCJ->( columnpos( 'RCJ_MODULO' )) > 0
// -----------------------------------------------
    local bSet15       := { || NIL }
    local bSet24       := { || NIL }
// [ gus ]---------------------------------------
    local aGPEUsu      := &( getnewpar( 'MV_XGPEUSU', '{}' ))
    local cCodUsr      := retcodusr()
    local nPos         := ascan( aGPEUsu , { |x| x[1] == cCodUsr } )
    local lUsr         := nPos > 0
// -----------------------------------------------
    aLbxA              := {}
    VAR_IXB            := { '' , '' , '' }
// -----------------------------------------------
    cWhere             := "%"
    cWhere             += " RCH.RCH_PERSEL = '1' AND "
    cWhere             += " RCH.RCH_DTFECH = '' "
// -[ gus - inicio ]------------------------------
    if lUsr
//      cWhere         += " AND RCH.RCH_PROCES IN ('" + aGPEUsu[nPos][2] + "') "
        cWhere         += " AND RCH.RCH_PROCES IN ( " + aGPEUsu[nPos][2] + " ) "
    endif
// -----------------------------------------------
    cWhere             += GPEFilQry( 'RCH_FILIAL' )
    cWhere             += "%"
// -----------------------------------------------
    cJoinModl          := "%"
// -----------------------------------------------
    if lGestPubl .AND. lRCJModulo
	    cJoinModl += "JOIN " + retsqlname( 'RCJ' ) + " RCJ  ON "
	    cJoinModl += fwjoinfilial( 'RCH' , 'RCJ' )
	    cJoinModl += " AND RCH.RCH_PROCES = RCJ.RCJ_CODIGO "
	    cJoinModl += " AND RCJ.RCJ_MODULO IN ('" + if( cModulo $ 'GFP*VDF' , 'GFP' , " ','GPE" ) + "')"
    endif
    cJoinModl     += "%"
// -----------------------------------------------
    BeginSql alias cAliasQry
        SELECT RCH_FILIAL, RCH_PROCES, RCH_PER, RCH_NUMPAG
          FROM %table:RCH% RCH
               %exp:cJoinModl%
         WHERE %exp:cWhere% AND
               RCH.%NotDel%
      ORDER BY RCH_FILIAL, RCH_PROCES, RCH_PER, RCH_NUMPAG
    EndSql
// -----------------------------------------------
    do while (cAliasQry)->( !eof() )
        if cKeyAux <> (cAliasQry)->( RCH_FILIAL + RCH_PROCES + RCH_PER + RCH_NUMPAG )
            if lFilComp
                (cAliasQry)->( aadd( aLbxA, {              RCH_PROCES , RCH_PER , RCH_NUMPAG } ) )
            else
                (cAliasQry)->( aadd( aLbxA, { RCH_FILIAL , RCH_PROCES , RCH_PER , RCH_NUMPAG } ) )
            endif
            cKeyAux := (cAliasQry)->( RCH_FILIAL + RCH_PROCES + RCH_PER + RCH_NUMPAG )
        endif
        (cAliasQry)->( dbskip() )
    enddo
// -----------------------------------------------
    if empty(aLbxA)
        if lFilComp
            aadd( aLbxA , { '' , '' , ''      } )
        else
            aadd( aLbxA , { '' , '' , '' , '' } )
        endif
    endif

    ( cAliasQry )->( dbclosearea() )

    aAdvSize     := msadvsize( , .T. , 390 )
    aInfoAdvSize := { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 15 , 5 }
    aadd( aObjCoords , { 000 , 000 , .T. , .T. } )
    aObjSize     := msobjsize( aInfoAdvSize , aObjCoords )

// -[ gus - inicio ]------------------------------------------------------------
//  DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD                                                                           // gus
//  DEFINE MSDIALOG oDlg FROM aAdvSize[7],0 TO aAdvSize[6],aAdvSize[5] TITLE OemToAnsi(STR0001) PIXEL                        // gus
// ----------------------------------------------------------------------------
    DEFINE FONT     oFont NAME 'Arial' SIZE 0 , -11 BOLD                                                                     // gus
    DEFINE MSDIALOG oDlg FROM aAdvSize[7] , 0 TO aAdvSize[6] , aAdvSize[5] TITLE OemToAnsi( 'Fechamento de Periodos' ) PIXEL // gus
// ----------------------------------------------------------------------------

    if lFilComp
        @ aObjSize[1,1] , aObjSize[1,2] LISTBOX oLbxA FIELDS HEADER getsx3cache( 'RCH_PROCES' , 'X3_TITULO' ) , ;
		                                                            getsx3cache( 'RCH_PER'    , 'X3_TITULO' ) , ;
                                                                    getsx3cache( 'RCH_NUMPAG' , 'X3_TITULO' ) SIZE 290 , 130 ;
        OF oDlg PIXEL ON DBLCLICK ( lOk := .T. , nPosLbxA := oLbxA:nAt , oDlg:End() )
    else
        @ aObjSize[1,1] , aObjSize[1,2] LISTBOX oLbxA FIELDS HEADER getsx3cache( 'RCH_FILIAL' , 'X3_TITULO' ) , ;
		                                                            getsx3cache( 'RCH_PROCES' , 'X3_TITULO' ) , ;
																    getsx3cache( 'RCH_PER'    , 'X3_TITULO' ) , ;
                                                                    getsx3cache( 'RCH_NUMPAG' , 'X3_TITULO' ) SIZE 290 , 130 ;
        OF oDlg PIXEL ON DBLCLICK ( lOk := .T., nPosLbxA := oLbxA:nAt , oDlg:End() )
    endif

    oLbxA:SetArray(aLbxA)
    if lFilComp
        oLbxA:bLine := { || { aLbxA[oLbxA:nAt,1] , aLbxA[oLbxA:nAt,2] , aLbxA[oLbxA:nAt,3]                      }}
    else
        oLbxA:bLine := { || { aLbxA[oLbxA:nAt,1] , aLbxA[oLbxA:nAt,2] , aLbxA[oLbxA:nAt,3] , aLbxA[oLbxA:nAt,4] }}
    endif

    bSet15 := { || nOpca := 1 , lOk := .T. , nPosLbxA:=oLbxA:nAt , oDlg:End() }
    bSet24 := { || nOpca := 0 , lOk := .F. ,                       oDlg:End() }

    ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar( oDlg , bSet15 , bSet24 ))

    if ( lOk )
        if lFilComp
            VAR_IXB[1] := aLbxA[nPosLbxA,1]
            VAR_IXB[2] := aLbxA[nPosLbxA,2]
            VAR_IXB[3] := aLbxA[nPosLbxA,3]
        else
            VAR_IXB[1] := aLbxA[nPosLbxA,2]
            VAR_IXB[2] := aLbxA[nPosLbxA,3]
            VAR_IXB[3] := aLbxA[nPosLbxA,4]
        endif
    endif

    restarea( aArea )

return lOk

// +--------------------------------------------------------------------------+
// | Funcao   : xGp120VldGrid() ( adaptada da função padrão Gp120VldGrid() )  |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// |            Valid da enchoice                                             |
// +--------------------------------------------------------------------------+

static function xGp120VldGrid()

// [ gus ]---------------------------------------
    local aGPEUsu := &( getnewpar( 'MV_XGPEUSU', '{}' ))
    local cCodUsr := retcodusr()
    local nPos    := ascan( aGPEUsu , { |x| x[1] == cCodUsr } )
    local lUsr    := nPos > 0
// -----------------------------------------------

//  [ Se nao executou consulta padrao, obtem o periodo atual para carregr os demais campos ]
    dbselectarea( cAliasMark )

    if !empty( cProcesso ) .AND. ;
       !empty( cPeriodo  ) .AND. ;
       !empty( cNumPag   ) .AND. ;
       !empty( cRoteiro  )

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_PER  == cPeriodo         .AND. ;
                          TAB_NPAG == cNumPag          .AND. ;
                          TAB_ROT  == cRoteiro         .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_PER  == cPeriodo  .AND. ;
                          TAB_NPAG == cNumPag   .AND. ;
                          TAB_ROT  == cRoteiro  .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
           !empty( cPeriodo  ) .AND. ;
           !empty( cNumPag   ) .AND. ;
            empty( cRoteiro  )         // <== vazio

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_PER  == cPeriodo         .AND. ;
                          TAB_NPAG == cNumPag          .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_PER  == cPeriodo  .AND. ;
                          TAB_NPAG == cNumPag   .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
           !empty( cPeriodo  ) .AND. ;
            empty( cNumPag   ) .AND. ; // <== vazio
           !empty( cRoteiro  )

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_PER  == cPeriodo         .AND. ;
                          TAB_ROT  == cRoteiro         .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_PER  == cPeriodo  .AND. ;
                          TAB_ROT  == cRoteiro  .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
            empty( cPeriodo  ) .AND. ; // <== vazio
           !empty( cNumPag   ) .AND. ;
           !empty( cRoteiro  )

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_NPAG == cNumPag          .AND. ;
                          TAB_ROT  == cRoteiro         .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_NPAG == cNumPag   .AND. ;
                          TAB_ROT  == cRoteiro  .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
            empty( cPeriodo  ) .AND. ; // <== vazio
           !empty( cNumPag   ) .AND. ;
            empty( cRoteiro  )         // <== vazio

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_NPAG == cNumPag          .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_NPAG == cNumPag   .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
            empty( cPeriodo  ) .AND. ; // <== vazio
            empty( cNumPag   ) .AND. ; // <== vazio
           !empty( cRoteiro  )

        if lUsr
            SET FILTER TO TAB_PROC $ aGPEUsu[nPos][2]                 .AND. ;
                          TAB_PROC + TAB_ROT  == cProcesso + cRoteiro .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC + TAB_ROT  == cProcesso + cRoteiro .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
           !empty( cPeriodo  ) .AND. ;
            empty( cNumPag   ) .AND. ; // <== vazio
            empty( cRoteiro  )         // <== vazio

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. ;
                          TAB_PER  == cPeriodo         .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. ;
                          TAB_PER  == cPeriodo  .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif !empty( cProcesso ) .AND. ;
            empty( cPeriodo  ) .AND. ; // <== vazio
            empty( cNumPag   ) .AND. ; // <== vazio
            empty( cRoteiro  )         // <== vazio

        if lUsr
            SET FILTER TO TAB_PROC  $ aGPEUsu[nPos][2] .AND. ;
                          TAB_PROC == cProcesso        .AND. eval( bTemAcesso )
        else
            SET FILTER TO TAB_PROC == cProcesso .AND. eval( bTemAcesso )
        endif

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
          !empty( cPeriodo  ) .AND. ;
           empty( cNumPag   ) .AND. ; // <== vazio
           empty( cRoteiro )          // <== vazio

        SET FILTER TO TAB_PER == cPeriodo .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
          !empty( cPeriodo  ) .AND. ;
          !empty( cNumPag   ) .AND. ;
          !empty( cRoteiro  )
        
        SET FILTER TO TAB_PER + TAB_NPAG + TAB_ROT  == cPeriodo + cNumPag + cRoteiro .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
          !empty( cPeriodo  ) .AND. ;
          !empty( cNumPag   ) .AND. ;
           empty( cRoteiro  )         // <== vazio

        SET FILTER TO TAB_PER + TAB_NPAG  == cPeriodo + cNumPag .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
          !empty( cPeriodo  ) .AND. ;
           empty( cNumPag   ) .AND. ; // <== vazio
          !empty( cRoteiro  )

        SET FILTER TO TAB_PER == cPeriodo .AND. ;
                      TAB_ROT == cRoteiro .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
           empty( cPeriodo  ) .AND. ; // <== vazio
          !empty( cNumPag   ) .AND. ;
          !empty( cRoteiro  )

        SET FILTER TO TAB_NPAG == cNumPag  .AND. ;
                      TAB_ROT  == cRoteiro .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
           empty( cPeriodo  ) .AND. ; // <== vazio
          !empty( cNumPag   ) .AND. ;
           empty( cRoteiro  )         // <== vazio

        SET FILTER TO TAB_NPAG == cNumPag .AND. eval( bTemAcesso )

// -----------------------------------------------

    elseif empty( cProcesso ) .AND. ; // <== vazio
           empty( cPeriodo  ) .AND. ; // <== vazio
           empty( cNumpag   ) .AND. ; // <== vazio
          !empty( cRoteiro  )

        SET FILTER TO TAB_ROT == cRoteiro .AND. eval( bTemAcesso )

    endif

// -----------------------------------------------

    oMark:refresh( .T. )

return .T.

// ----------------------------------------------------------------------------
// [ fim de caba218.prw ]
// ----------------------------------------------------------------------------


/*/
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
??un?o    ?GetRotNotInt?Autor ?Leandro Drumond      ?Data ?16/04/14 ??
????????????????????????????????????????
??escri?o ?Obte os roteiros que nao necessitam  de integracao	        ??
????????????????????????????????????????
??intaxe   ?fGetRotNotInt()                                              ??
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
/*/
Static Function fGetRotNotInt()
Local cNotInt 	:= "'"
Local cAliasQry := GetNextAlias()

BeginSql alias cAliasQry
	SELECT 		RY_CALCULO
	FROM 		%table:SRY% SRY
	WHERE 		RY_INTEGRA = '2' AND
				SRY.%NotDel%
EndSql

While (cAliasQry)->( !Eof() )
	cNotInt += (cAliasQry)->RY_CALCULO + "*"
	(cAliasQry)->( dbSkip() )
EndDo
cNotInt += "'"

( cAliasQry )->( dbCloseArea() )

Return cNotInt


/*/
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
??un?o    ?CriaTmp       ?Autor ?Leandro Drumond    ?Data ?17/10/13 ??
????????????????????????????????????????
??escri?o ?ria tabela temporaria para uso no FWMarkBrowse      			??
????????????????????????????????????????
??intaxe   ?CriaTmp()				                                    ??
????????????????????????????????????????
??so       ?PEM120					                                    ??
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
/*/
Static Function fCriaTmp()
Local aArea		 := GetArea()
Local aColumns	 := {}
Local cQuery	 := ''
Local cAliasRCH	 := 'QRCH'
Local cKeyAux	 := ""
Local cAcessaRCH := ChkRH( "GPEM120" , "RCH" , "1" )
Local cAcessaSRY := ChkRH( "GPEM120" , "SRY" , "1" )
Local lRet		 := .F.

cAcessaRCH := If(!Empty(cAcessaRCH),StrTran(cAcessaRCH, "RCH->", "QRCH->"),".T.")
cAcessaSRY := If(!Empty(cAcessaSRY),StrTran(cAcessaSRY, "SRY->", "QRCH->"),".T.")

If Select(cAliasMark) > 0
	DbSelectArea(cAliasMark)
	DbCloseArea()
EndIf

aAdd( aColumns, { "TAB_OK"		,"C",02,00 })
aAdd( aColumns, { "TAB_FIL"		,"C",TAMSX3("RCH_FILIAL")[1],TAMSX3("RCH_FILIAL")[2]})
aAdd( aColumns, { "TAB_ROT"		,"C",TAMSX3("RY_CALCULO")[1],TAMSX3("RY_CALCULO")[2]})
aAdd( aColumns, { "TAB_DESC"	,"C",TAMSX3("RY_DESC")[1],TAMSX3("RY_DESC")[2]})
aAdd( aColumns, { "TAB_PROC"	,"C",TAMSX3("RCH_PROCES")[1],TAMSX3("RCH_PROCES")[2]})
aAdd( aColumns, { "TAB_PER"		,"C",TAMSX3("RCH_PER")[1],TAMSX3("RCH_PER")[2]})
aAdd( aColumns, { "TAB_NPAG"	,"C",TAMSX3("RCH_NUMPAG")[1],TAMSX3("RCH_NUMPAG")[2]})
aAdd( aColumns, { "TAB_TPROT"	,"C",TAMSX3("RY_TIPO")[1],TAMSX3("RY_TIPO")[2]})
aAdd( aColumns, { "TAB_INTEG"	,"D",8,0})
aAdd( aColumns, { "TAB_DTREF"	,"D",8,0})
aAdd( aColumns, { "TAB_DTPAG"	,"D",8,0})

//Efetua a criacao do arquivo temporario
oTmpTable := FWTemporaryTable():New(cAliasMark)
oTmpTable:SetFields( aColumns )
oTmpTable:Create()

dbSelectArea( "RCH" )
DbSetOrder(RetOrdem("RCH","RCH_FILIAL+RCH_PROCES+RCH_ROTEIR+RCH_PER+RCH_NUMPAG"))

cQuery := "SELECT * "
cQuery += 		" FROM " + RetSqlName("RCH") + " RCH"
cQuery +=			" INNER JOIN " + RetSqlName("SRY") + " SRY"
cQuery +=			" ON RCH_ROTEIR = RY_CALCULO AND " + FWJoinFilial( "RCH", "SRY" )
cQuery +=		" WHERE RCH_PERSEL = '1' AND"
If FunName() == "GPEA001" .Or. FunName() == "GP001FECH"
	cQuery +=	" SRY.RY_TIPO = 'C' AND"
ElseIf FunName() == "GP068FECH"
	cQuery +=	" SRY.RY_TIPO = 'I' AND"
ElseIf FunName() == "GP131FECH"
	cQuery +=	" SRY.RY_TIPO IN ('8','D','E') AND"
EndIf
cQuery +=			" SRY.D_E_L_E_T_ = ' ' AND RCH.D_E_L_E_T_ = ' '"
cQuery += 		" ORDER BY " + SqlOrder(RCH->(IndexKey()))

cQuery := ChangeQuery( cQuery )

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasRCH)

TcSetField(cAliasRCH,"RCH_DTINTE","D",8,0)

DbSelectArea(cAliasRCH)

DbSelectArea(cAliasMark)

While (cAliasRCH)->(!Eof())
	//Se n? satisfizer os filtros do controle de usu?ios, pula registro.
	If !(&(cAcessaSRY)) .or. !(&(cAcessaRCH))
		(cAliasRCH)->(DbSkip())
		Loop
	EndIf

	If cKeyAux <> (cAliasRCH)->RCH_FILIAL + (cAliasRCH)->RCH_PROCES + (cAliasRCH)->RCH_ROTEIR + (cAliasRCH)->RCH_PER
		lRet := .T.

		RecLock(cAliasMark,.T.)
		(cAliasMark)->TAB_FIL	:= (cAliasRCH)->RCH_FILIAL
		(cAliasMark)->TAB_ROT 	:= (cAliasRCH)->RCH_ROTEIR
		(cAliasMark)->TAB_DESC 	:= (cAliasRCH)->RY_DESC
		(cAliasMark)->TAB_PROC	:= (cAliasRCH)->RCH_PROCES
		(cAliasMark)->TAB_PER	:= (cAliasRCH)->RCH_PER
		(cAliasMark)->TAB_NPAG	:= (cAliasRCH)->RCH_NUMPAG
		(cAliasMark)->TAB_INTEG	:= (cAliasRCH)->RCH_DTINTE
		(cAliasMark)->TAB_TPROT	:= (cAliasRCH)->RY_TIPO
		(cAliasMark)->TAB_DTREF	:= StoD((cAliasRCH)->RCH_DTINI)
		(cAliasMark)->TAB_DTPAG	:= StoD((cAliasRCH)->RCH_DTPAGO)

		MsUnLock()

		cKeyAux := (cAliasRCH)->RCH_FILIAL + (cAliasRCH)->RCH_PROCES + (cAliasRCH)->RCH_ROTEIR + (cAliasRCH)->RCH_PER
	EndIf

	(cAliasRCH)->(DbSkip())

EndDo

( cAliasRCH )->( dbCloseArea() )

RestArea(aArea)

Return lRet


/*/
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
??un?o    ?MntColsMark?Autor ?Leandro Drumond       ?Data ?17/10/13 ??
????????????????????????????????????????
??escri?o ?Monta dados dos campos da tabela temporaria                  ??
????????????????????????????????????????
??intaxe   ?fMntColsMark()                                               ??
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
/*/
Static Function fMntColsMark()
Local aArea		:= GetArea()
Local aColsAux 	:=`{}
Local aColsSX3	:= {}
Local aCampos  	:= {}
Local aDados	:= {}
Local nX		:= 0

If lFilComp
	aCampos  	:= {"RY_CALCULO","RY_DESC","RCH_PROCES","RCH_PER","RCH_NUMPAG","RCH_DTINTE"}
	aDados		:= {{||(cAliasMark)->TAB_ROT}, {||(cAliasMark)->TAB_DESC},{||(cAliasMark)->TAB_PROC},{||(cAliasMark)->TAB_PER},{||(cAliasMark)->TAB_NPAG},{||(cAliasMark)->TAB_INTEG}}
Else
	aCampos  	:= {"RCH_FILIAL","RY_CALCULO","RY_DESC","RCH_PROCES","RCH_PER","RCH_NUMPAG","RCH_DTINTE"}
	aDados		:= {{||(cAliasMark)->TAB_FIL},{||(cAliasMark)->TAB_ROT}, {||(cAliasMark)->TAB_DESC},{||(cAliasMark)->TAB_PROC},{||(cAliasMark)->TAB_PER},{||(cAliasMark)->TAB_NPAG},{||(cAliasMark)->TAB_INTEG}}
EndIf

DbSelectArea("SX3")
DbSetOrder(2)

For nX := 1 to Len(aCampos)
	If SX3->( dbSeek(aCampos[nX]) )
	    aColsSX3 := {X3Titulo(),aDados[nX], SX3->X3_TIPO, SX3->X3_PICTURE,1,SX3->X3_TAMANHO,SX3->X3_DECIMAL,.F.,,,,,,,,1}
	    aAdd(aColsAux,aColsSX3)
	    aColsSX3 := {}
	EndIf
Next nX

RestArea(aArea)

Return aColsAux
