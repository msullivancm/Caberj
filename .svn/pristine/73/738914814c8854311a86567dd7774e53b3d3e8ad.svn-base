#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'COLORS.CH'
#INCLUDE  'TBICONN.CH'
#INCLUDE     'FONT.CH'
#INCLUDE  'TOPCONN.CH'
#INCLUDE 'TCBROWSE.CH'
#INCLUDE  'PLSMGER.CH'

#DEFINE CRLF chr(13)+chr(10)

#xtranslate bSetGet(<uVar>) => {|u| if(PCount()== 0, <uVar>,<uVar> := u)}

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw      | Paulo Motta         | CABERJ / Integral   |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplência       |
// +--------------------------------------------------------------------------+
// | Alteração : Marcela Coimbra   | CABERJ                      | 21/03/2013 |
// +--------------------------------------------------------------------------+
// | Desc.     : Chamado GLPI 5069 - Inclusão de botão para geração de        |
// |             planilha a partir do grid.                                   |
// +--------------------------------------------------------------------------+
// | Alteração : Angelo Henrique   | CABERJ                      | 21/06/2016 |
// +--------------------------------------------------------------------------+
// | Desc.     : Alterações efetuadas no fonte para contemplar as novas       |
// |             solicitações para o projeto inadimplência 2.0.               |
// |             Atualizadas algumas informações na rotina e alguns           |
// |             comentários, auxiliando assim a leitura do fonte.            |
// +--------------------------------------------------------------------------+
// | Alteração : Gustavo Thees     | CABERJ / Integral           | 01/08/2022 |
// +--------------------------------------------------------------------------+
// | Desc.     : Alterações diversas Caberj / Integral.                       |
// |             Projeto Gestão de Inadimplência.                             |
// +--------------------------------------------------------------------------+

user function caba200()

// ------------------------------------
    local   iX          := 0
    local   _aSize      := MsAdvSize()
// ------------------------------------
    private oFntAri13N  := tfont():new( 'Arial' , , -13 , , .F. , , , , , .F. )
	private oFntAri11N 	:= tfont():new( 'Arial' , , -11 , , .F. , , , , , .F. )
// ------------------------------------
//  private _nDias      := getmv( 'MV_DIASPLS' )
    private cStatusAt   := space(25)
    private _cEmp       := space(25)
    private cOrderAt    := space(25)
    private cParceAt    := space(01)
    private dDtBloq     := ctod( '' )
    private dDtRef      := dDataBase
    private aTpPag      := { ' '         , ;
	                         'BOLETO'    , ;
							 'SISDEB'    , ;
							 'PREVI'     , ;
							 'EMPRESARIAL' }
    private cTpPag      := '' // space(01)        // gus
//  private nCombo      := ' '                    // gus
    private cAlias      := 'BA3'
    private cCampoOk    := 'XOK'
//  private aButtons    := {}                     // gus
    private bOk         := { || oDlgBord:End() }
    private bCancel     := { || oDlgBord:End() }
//  private cColunas    := ''                     // gus
    private aCampos     := {}
    private cAliasTmp   := getnextalias()
    private cAliasInd   := 'i_' + cAliasTmp
    private oOk         := loadbitmap( getresources() , 'LBOK_OCEAN' )
    private onOk        := loadbitmap( getresources() , 'LBNO_OCEAN' )
    private cChave      := 'NRECNO'
    private aStruct     := {}
    private nTotReg     := 0
    private nTotVlr     := 0
    private aFiltro     := { 'Marcados'            , ;
	                         'Carta/Etiq'          , ;
							 'Retorno AR'          , ;
							 'Desmarcados'         , ;
							 'Bloq/Reativ'         , ;
							 'Suspensos'           , ;
							 'Bloqueados Prefeitura' }
    private aOrdem      := { 'Matricula'           , ;
	                         'Nome'                , ;
							 'Parcelas'            , ;
							 'Valor'                 }
    private aParcela    := { '0' , ;
                             '1' , ;
							 '2' , ;
							 '3' , ;
							 '4' , ;
							 '5' , ;
							 '6' , ;
							 '7' , ;
							 '8' , ;
							 '9'   }
    private oBrwBord    := NIL
//  private lactive     := .T.
// ------------------------------------
    private areturn     := { 'Zebrado'       , ; // [1] Reservado para Formulario
                             1               , ; // [2] Reservado para N§ de Vias
                             'Administração' , ; // [3] Destinatario
                             2               , ; // [4] Formato => 1-Comprimido 2-Normal
                             1               , ; // [5] Midia   => 1-Disco 2-Impressora
                             1               , ; // [6] Porta ou Arquivo 1-LPT1... 4-COM1...
                             ''              , ; // [7] Expressao do Filtro
                             1               , ; // [8] Ordem a ser selecionada
                                               } // [9]..[10]..[n] // Campos a Processar (se houver)
// ------------------------------------
    private cTipImp     := 1
    private lSomTit     := .F.
    private cNomEtq     := ''
    private nPosCol     := 1
    private wnrel       := 'CABA200'
    private cString     := 'BA3'
    private cTitulo     := 'Etiquetas DESLIGAMENTO'
    private cDesc1      := 'Emissão Etiquetas DESLIGAMENTO'
    private cDesc2      := ''
    private cDesc3      := ''
    private m_pag       := 1
// ------------------------------------
    private a_ItLin     := {}
    private a_ItFim     := {}
    private a_Cab       := {}
// ------------------------------------
    private nHdl
    private cFlEmp      := ''
// ------------------------------------
    private _aFilEmp    := {}
	private nPos        := 0
    private aGEIN01     := &( getnewpar( 'MV_XGEIN01' , '{}' ))
    private cGEIN02     :=    getnewpar( 'MV_XGEIN02' , ''    )
    private cGEIN03     :=    getnewpar( 'MV_XGEIN03' , ''    )
    private cGEIN04     :=    getnewpar( 'MV_XGEIN04' , ''    ) //Aprovador 1
    private cGEIN05     :=    getnewpar( 'MV_XGEIN05' , ''    ) //Aprovador 2
    private aGrpUsr     := UsrRetGrp()
    private cCodUsr     := RetCodUsr()
    private cNomUsr     := UsrRetName( cCodUsr )
    private lButBlo     := .T.
    private lButMar     := .F.
    private lButAp1     := cCodUsr $ cGEIN04
    private lButAp2     := cCodUsr $ cGEIN05
// ------------------------------------
    for iX := 1 to len( aGEIN01 )
	    aadd( _aFilEmp , aGEIN01[iX][01] )
	next iX
// ------------------------------------
    for iX := 1 to len( aGrpUsr )
        if aGrpUsr[iX] $ cGEIN02
            lButBlo := .T.
        endif
        if aGrpUsr[iX] $ cGEIN03
            lButMar := .T.
        endif
	next iX
// ------------------------------------
    aadd( aStruct , { cCampoOk     , 'C' ,  1                        , 0 } ) // 01
    aadd( aStruct , { 'BA3_CODINT' , 'C' ,  4                        , 0 } ) // 02
    aadd( aStruct , { 'BA3_CODEMP' , 'C' ,  4                        , 0 } ) // 03
    aadd( aStruct , { 'BA3_MATRIC' , 'C' ,  6                        , 0 } ) // 04
    aadd( aStruct , { 'BA1_NOMUSR' , 'C' ,  6                        , 0 } ) // 05
    aadd( aStruct , { 'BA3_CODCLI' , 'C' ,  6                        , 0 } ) // 06
    aadd( aStruct , { 'XSITUACAO'  , 'C' , 15                        , 0 } ) // 07
    aadd( aStruct , { 'PARCELAS'   , 'N' ,  3                        , 0 } ) // 08
    aadd( aStruct , { 'SALDO'      , 'N' , 12                        , 2 } ) // 09
    aadd( aStruct , { 'BA3_TIPPAG' , 'C' , tamsx3( 'BA3_TIPPAG' )[1] , 0 } ) // 10
    aadd( aStruct , { 'FATURA'     , 'C' , tamsx3( 'E1_NUM'     )[1] , 0 } ) // 11
    aadd( aStruct , { 'DATA_FATUR' , 'C' , 12                        , 0 } ) // 12
    aadd( aStruct , { 'NRECNO'     , 'N' ,  8                        , 0 } ) // 13
    aadd( aStruct , { 'RUB_PARC'   , 'N' , 12                        , 2 } ) // 14
    aadd( aStruct , { 'RUB_MENS'   , 'N' , 12                        , 2 } ) // 15
    aadd( aStruct , { 'SIN_SEM'    , 'N' , 12                        , 2 } ) // 16
    aadd( aStruct , { 'SIN_ANO'    , 'N' , 12                        , 2 } ) // 17
    aadd( aStruct , { 'IDADE'      , 'C' , 10                        , 0 } ) // 18
    aadd( aStruct , { 'STATUS'     , 'C' , 10                        , 0 } ) // 19
    aadd( aStruct , { 'DT_BLOQ'    , 'D' , 10                        , 0 } ) // 20
    aadd( aStruct , { 'CONTRATO'   , 'C' , 15                        , 0 } ) // 21
    aadd( aStruct , { 'SUBCONTR'   , 'C' , 10                        , 0 } ) // 22
    aadd( aStruct , { 'COBNIV'     , 'C' , 01                        , 0 } ) // 23
    aadd( aStruct , { 'APROVA1'    , 'C' , 20                        , 0 } ) // 24 // criar campo BA3
    aadd( aStruct , { 'APROVA2'    , 'C' , 20                        , 0 } ) // 25 // criar campo BA3
// ------------------------------------

    aadd( aCampos , { ' '                 , cCampoOk     , 'C' ,  1                        , 0 ,                     } ) // 01
    aadd( aCampos , { 'Inst.'             , 'BA3_CODINT' , 'C' ,  4                        , 0 , ''                  } ) // 02
    aadd( aCampos , { 'Empresa'           , 'BA3_CODEMP' , 'C' ,  4                        , 0 , ''                  } ) // 03
    aadd( aCampos , { 'Matricula'         , 'BA3_MATRIC' , 'C' ,  6                        , 0 , ''                  } ) // 04
    aadd( aCampos , { 'Nome'              , 'BA1_NOMUSR' , 'C' , 50                        , 0 , ''                  } ) // 05
    aadd( aCampos , { 'Cliente'           , 'BA3_CODCLI' , 'C' ,  6                        , 0 , ''                  } ) // 06
    aadd( aCampos , { 'Situacao'          , 'XSITUACAO'  , 'C' , 15                        , 0 , ''                  } ) // 07
    aadd( aCampos , { 'Parcelas'          , 'PARCELAS'   , 'N' ,  3                        , 0 , ''                  } ) // 08
    aadd( aCampos , { 'Saldo'             , 'SALDO'      , 'N' , 12                        , 2 , '@E 999,999,999.99' } ) // 09
    aadd( aCampos , { 'Tp. Pagamento'     , 'BA3_TIPPAG' , 'C' , tamsx3( 'BA3_TIPPAG' )[1] , 0 , ''                  } ) // 10
    aadd( aCampos , { 'Fatura'            , 'FATURA'     , 'C' , tamsx3( 'E1_NUM'     )[1] , 0 , ''                  } ) // 11
    aadd( aCampos , { 'Venc. Fatura'      , 'DATA_FATUR' , 'C' , 12                        , 0 , ''                  } ) // 12
    aadd( aCampos , { 'Recno'             , 'NRECNO'     , 'N' ,  8                        , 0 , ''                  } ) // 13
    aadd( aCampos , { 'Rub. Parcela'      , 'RUB_PARC'   , 'N' , 12                        , 2 , '@E 999,999,999.99' } ) // 14
    aadd( aCampos , { 'Rub. Mensalidade'  , 'RUB_MENS'   , 'N' , 12                        , 2 , '@E 999,999,999.99' } ) // 15
    aadd( aCampos , { 'Sinist. Semestral' , 'SIN_SEM'    , 'N' , 12                        , 2 , '@E 999,999,999.99' } ) // 16
    aadd( aCampos , { 'Sinist. Anual'     , 'SIN_ANO'    , 'N' , 12                        , 2 , '@E 999,999,999.99' } ) // 17
    aadd( aCampos , { 'Idade'             , 'IDADE'      , 'C' , 10                        , 0 , ''                  } ) // 18
    aadd( aCampos , { 'Status'            , 'STATUS'     , 'C' , 10                        , 0 , ''                  } ) // 19
    aadd( aCampos , { 'Dt. Bloq'          , 'DT_BLOQ'    , 'D' , 10                        , 0 , ''                  } ) // 20
    aadd( aCampos , { 'Contrato'          , 'CONTRATO'   , 'C' , 15                        , 0 , ''                  } ) // 21
    aadd( aCampos , { 'SubContr'          , 'SUBCONTR'   , 'C' , 10                        , 0 , ''                  } ) // 22
    aadd( aCampos , { 'CobNiv'            , 'COBNIV'     , 'C' , 01                        , 0 , ''                  } ) // 23
    aadd( aCampos , { 'Aprov. 1'          , 'APROVA1'    , 'C' , 20                        , 0 , ''                  } ) // 24
    aadd( aCampos , { 'Aprov. 2'          , 'APROVA2'    , 'C' , 20                        , 0 , ''                  } ) // 25
// ------------------------------------
    if select(cAliasTmp) <> 0
        (cAliasTmp)->( dbclosearea() )
    endif
// ------------------------------------
    if tccanopen(cAliasTmp)
        tcdelfile(cAliasTmp)
    endif
// ------------------------------------
    dbcreate( cAliasTmp , aStruct , 'TopConn' )
// ------------------------------------
    if select(cAliasTmp) <> 0
        (cAliasTmp)->( dbclosearea() )
    endif
// ------------------------------------
    dbusearea( .T. , 'TopConn' ,  cAliasTmp , cAliasTmp , .T. , .F. )
    (cAliasTmp)->( dbcreateindex( cAliasInd , cChave, {|| &cChave}, .F. ) )
    (cAliasTmp)->( dbcommit()   )
    (cAliasTmp)->( dbclearind() )
    (cAliasTmp)->( dbsetindex( cAliasInd ) )
// ------------------------------------
	
    oDlgBord:=TDialog():New( _aSize[7] , _aSize[2] , _aSize[6] , _aSize[5] , 'Desligamento por inadimplência - Teste' ,,,,,,,,, .T. )

// ------------------------------------

    oDlgBord:nClrPane := RGB( 255 , 255 , 254 )
//  oDlgBord:bStart   := { || ( enchoicebar( oDlgBord , bOk , bCancel , , aButtons ) ) } // gus
    oDlgBord:bStart   := { || ( enchoicebar( oDlgBord , bOk , bCancel , , {}       ) ) } // gus

    oSay01 := tsay():new( 035 , 005 , { || 'Situação'        } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 030 , 010 )
    oSay02 := tsay():new( 035 , 090 , { || 'Ordem'           } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 025 , 010 )
    oSay03 := tsay():new( 035 , 170 , { || 'Parcelas'        } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 030 , 010 )
    oSay04 := tsay():new( 035 , 220 , { || 'Dt. Bloq '       } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 035 , 010 )
    oSay05 := tsay():new( 035 , 300 , { || 'Empresa'         } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 030 , 010 )
    oSay06 := tsay():new( 035 , 390 , { || 'Dt. Referencia ' } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 200 , 010 )
    oSay07 := tsay():new( 035 , 480 , { || 'Tp. Pagamento '  } , oDlgBord ,, oFntAri13N ,,,, .T. ,,, 200 , 010 )

    oCom02 := tcombobox():new( 045 , 005 , bSetGet( cStatusAt ) , aFiltro  , 060 , 010 , oDlgBord ,,,,,, .T. , oFntAri13N ,,, {||.T.} )
    oCom03 := tcombobox():new( 045 , 090 , bSetGet( cOrderAt  ) , aOrdem   , 060 , 010 , oDlgBord ,,,,,, .T. , oFntAri13N ,,, {||.T.} )
    oCom04 := tcombobox():new( 045 , 170 , bSetGet( cParceAt  ) , aParcela , 020 , 010 , oDlgBord ,,,,,, .T. , oFntAri13N ,,, {||.T.} )
    oCom05 := tcombobox():new( 045 , 300 , bSetGet( _cEmp     ) , _aFilEmp , 070 , 010 , oDlgBord ,,,,,, .T. , oFntAri13N ,,, {||.T.} )
    oCom06 := tcombobox():new( 045 , 480 , bSetGet( cTpPag    ) , aTpPag   , 060 , 010 , oDlgBord ,,,,,, .T. , oFntAri13N ,,, {||.T.} )

    oGet02 := tget():new( 045 , 220 , bSetGet( dDtBloq ) , oDlgBord , 050 , 010 , '' , {||.T.} ,,, oFntAri13N ,,, .T. ,,, {||.T.} ,,,, .F. ,, '' , 'dDtBloq' )
    oGet03 := tget():new( 045 , 390 , bSetGet( dDtRef  ) , oDlgBord , 050 , 010 , '' , {||.T.} ,,, oFntAri13N ,,, .T. ,,, {||.T.} ,,,, .F. ,, '' , 'dDtRef'  )

// ------------------------------------
//    tbutton():new(     285 , 010 , 'Pesquisar'            , oDlgBord , { || msgrun( 'Aguarde... Pesquisando'            ,, {|| fMontaBrowse()      , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//    tbutton():new(     285 , 080 , 'Gerar Planilha'       , oDlgBord , { || msgrun( 'Aguarde... Gerando Planilha'       ,, {|| fGreraPlan(aCampos) , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//    if lButMar
//        tbutton():new( 285 , 150 , 'Emitir Carta'         , oDlgBord , { || msgrun( 'Aguarde... Emitindo Cartas'        ,, {|| fGeraCarta()        , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//        tbutton():new( 285 , 220 , 'Emitir Etiqueta'      , oDlgBord , { || msgrun( 'Aguarde... Emitindo Etiquetas'     ,, {|| fGeraEtiq()                              } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//        tbutton():new( 285 , 290 , 'Marcar Carta/Etiq.'   , oDlgBord , { || msgrun( 'Aguarde... Marcando Cartas/Etiqs'  ,, {|| fMarcaCarta()       , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//        tbutton():new( 285 , 360 , 'Marcar Retorno AR'    , oDlgBord , { || msgrun( 'Aguarde... Marcando Retorno de AR' ,, {|| fRetAR()                                 } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//        tbutton():new( 285 , 430 , 'Marcar Inadimplentes' , oDlgBord , { || msgrun( 'Aguarde... Marcando Inadimplentes' ,, {|| u_cabx329()         , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//        tbutton():new( 285 , 500 , 'Desmarcar'            , oDlgBord , { || msgrun( 'Aguarde... Desmarcando  ......'    ,, {|| fDesMarca()         , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//    endif
//    if lButBlo
//        tbutton():new( 285 , 570 , 'Bloquear Definitivo'  , oDlgBord , { || msgrun( 'Aguarde... Bloqueando Familias'    ,, {|| fBloqFam()          , oBrwBord:Refresh() } ) } , 60 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
//    endif
// ------------------------------------
    tbutton():new(     285 , 010 , 'Pesquisar'           , oDlgBord , { || msgrun( 'Aguarde... Pesquisando'            ,, {|| fMontaBrowse()      , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    tbutton():new(     285 , 065 , 'Gerar Planilha'      , oDlgBord , { || msgrun( 'Aguarde... Gerando Planilha'       ,, {|| fGreraPlan(aCampos) , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    if lButMar
        tbutton():new( 285 , 120 , 'Emitir Carta'        , oDlgBord , { || msgrun( 'Aguarde... Emitindo Cartas'        ,, {|| fGeraCarta()        , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
        tbutton():new( 285 , 175 , 'Emitir Etiqueta'     , oDlgBord , { || msgrun( 'Aguarde... Emitindo Etiquetas'     ,, {|| fGeraEtiq()                              } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
        tbutton():new( 285 , 230 , 'Marcar Carta/Etiq.'  , oDlgBord , { || msgrun( 'Aguarde... Marcando Cartas/Etiqs'  ,, {|| fMarcaCarta()       , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
        tbutton():new( 285 , 285 , 'Marcar Retorno AR'   , oDlgBord , { || msgrun( 'Aguarde... Marcando Retorno de AR' ,, {|| fRetAR()                                 } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
        tbutton():new( 285 , 340 , 'Marcar Inadimplente' , oDlgBord , { || msgrun( 'Aguarde... Marcando Inadimplentes' ,, {|| u_caba329()         , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
        tbutton():new( 285 , 395 , 'Desmarcar'           , oDlgBord , { || msgrun( 'Aguarde... Desmarcando...'         ,, {|| fDesMarca()         , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    endif

    if lButAp1
        tbutton():new( 285 , 450 , 'Aprova 1'            , oDlgBord , { || msgrun( 'Aguarde... Aprovando Nível 1...'   ,, {|| fAprov(cNomUsr,1)    , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    endif
    if lButAp2
        tbutton():new( 285 , 505 , 'Aprova 2'            , oDlgBord , { || msgrun( 'Aguarde... Aprovando Nível 2...'   ,, {|| fAprov( cNomUsr,2 )    , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    endif
    if lButBlo  
          
        tbutton():new( 285 , 570 , 'Bloquear Definitivo' , oDlgBord , { || msgrun( 'Aguarde... Bloqueando Familias'    ,, {|| fBloqFam()          , oBrwBord:Refresh() } ) } , 50 , 10 ,, oDlgBord:oFont , .F. , .T. , .F. ,, .F. ,,, .F. )
    endif
// ------------------------------------

    fbrowse()

    if select(cAliasTmp) <> 0
        (cAliasTmp)->( dbclosearea() )
    endif

    if tccanopen(cAliasTmp)
        tcdelfile(cAliasTmp)
    endif

return( .T. )

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia       |
// +--------------------------------------------------------------------------+
// | Função    : fBrowse()                                                    |
// +--------------------------------------------------------------------------+

static function fBrowse()

// ------------------------------------
    local nIt := 0
// ------------------------------------
    dbselectarea(cAliasTmp)
    (cAliasTmp)->( dbgotop() )
// ------------------------------------

    oBrwBord := tcbrowse():new( 060 , 005 , 656 , 221 ,,,, oDlgBord ,,,,,,, oDlgBord:oFont ,,,,, .T. , cAliasTmp , .T. ,, .F. ,,, .F. )

// ------------------------------------

    for nIt := 1 to len( aCampos )

        c2 := if( nIt == 1 , ' ' , aCampos[nIt,1] )
        c3 := if( nIt == 1 , &('{|| if(empty(' + cAliasTmp + '->' + cCampoOk + '),onOk,oOk)}') , ;
                             &('{||'           + cAliasTmp + '->' + aCampos[nIt,2]     + ' }') )
        c4 := if( nIt == 1 , 5   , calcfieldsize( aCampos[nIt,3]  , aCampos[nIt,4] , aCampos[nIt,5] , '' , aCampos[nIt,1] ) )
        c5 := if( nIt == 1 , ''  , aCampos[nIt,6] )
        c6 := if( nIt == 1 , .T. , .F. )

        oBrwBord:addcolumn( tccolumn():new( c2 , c3 , c5 ,,, 'LEFT' , c4 , c6 , .F. ,,,, .F. ) )
        oBrwBord:bLDblClick := { || fAtuBrw( cAliasTmp , cCampoOk ) }

    next nIt

    oBrwBord:lHScroll := .T.
    oBrwBord:lVScroll := .T.

    oBrwBord:bHeaderClick := { || fAtuBrw( cAliasTmp , cCampoOK ,, .T. ) }

    oDlgBord:Activate( , , , .T. )

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia       |
// +--------------------------------------------------------------------------+
// | Função    : fMontaBrowse()                                               |
// +--------------------------------------------------------------------------+

static function fMontaBrowse()

// ------------------------------------
    local nI       := 0
    local lRet     := .T.
    local cQuery   := ''
    local cPesq    := ''
    local cOrder   := ''
    local _cEmpRot := ''
// ------------------------------------

//-------------------------------------------------------------------
//  Zerando Vetor para não dar erro de aumento nos registros
//-------------------------------------------------------------------
    a_ItFim := {}

// ------------------------------------
// Monta filtro de pesquisa
// ------------------------------------
        if alltrim( cStatusAt ) == 'Marcados'
//      cPesq := "'1' " // gus
        cPesq := "'1'"  // gus
    elseif alltrim( cStatusAt ) == 'Carta/Etiq'
//      cPesq := "'2' " // gus
        cPesq := "'2'"  // gus
    elseif alltrim( cStatusAt ) == 'Retorno AR'
//      cPesq := "'5' " // gus
        cPesq := "'5'"  // gus
    elseif alltrim( cStatusAt ) == 'Desmarcados'
//      cPesq := "'6' " // gus
        cPesq := "'6'"  // gus
    elseif alltrim( cStatusAt ) == 'Suspensos'
//      cPesq := "'8' " // gus
        cPesq := "'8'"  // gus
    else
//      cPesq := "'7' " // gus
        cPesq := "'7'"  // gus
    endif

// ------------------------------------
//  Monta "order by"
// ------------------------------------
        if alltrim( cOrderAt ) == 'Matricula'
//      cOrder := ' ORDER BY 2,3,4 '       // gus
        cOrder := ' ORDER BY 2,3,23,24,4 ' // BA3_CODINT , BA3_CODEMP , BA3_CONEMP , BA3_SUBCON , BA3_MATRIC
    elseif alltrim( cOrderAt ) == 'Nome'
        cOrder := ' ORDER BY 5 '           // BA1_NOMUSR
    elseif alltrim( cOrderAt ) == 'Parcelas'
        cOrder := ' ORDER BY 8 DESC,5 '    // BA3_YSITBQ DESC , BA1_NOMUSR
    else
        cOrder := ' ORDER BY 9 DESC,5 '    // BA3_MOTBLO DESC , BA1_NOMUSR
    endif

// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
    nPos   := ascan( aGEIN01 , { |x| x[1] == _cEmp } )
	cFlEmp := aGEIN01[nPos][02]
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

// ------------------------------------
//  cQuery += " SELECT "                                        + CRLF
    cQuery += " SELECT DISTINCT "                               + CRLF
    cQuery += "    ' ' " + cCampoOk +         ", "              + CRLF
    cQuery += "    BA3.BA3_CODINT              , "              + CRLF
    cQuery += "    BA3.BA3_CODEMP              , "              + CRLF
    cQuery += "    BA3.BA3_MATRIC              , "              + CRLF
    cQuery += "    BA1.BA1_NOMUSR              , "              + CRLF
    cQuery += "    BA3.BA3_CODCLI              , "              + CRLF
    cQuery += "    BA3.BA3_TIPPAG              , "              + CRLF
    cQuery += "    DECODE ( BA3.BA3_YSITBQ     , "              + CRLF
    cQuery += "             '1' , 'MARCADO'    , "              + CRLF
    cQuery += "             '2' , 'CARTA/ETIQ' , "              + CRLF
    cQuery += "             '5' , 'RETORNO AR' , "              + CRLF
    cQuery += "             '6' , 'DESMARCADO' , "              + CRLF
    cQuery += "             '7' , 'BLOQ/REATIV' ) XSITUACAO , " + CRLF
    cQuery += "    BA3.BA3_MOTBLO MTBLQ        , "              + CRLF

// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
// -[ Parcelas ]----------------------------
        if cEmpAnt = '01'
//      cQuery += " IND_RETORNA_SALDO_DEVIDO     ( "           + CRLF // gus
        cQuery += " IND_RETORNA_SLD_DEV_CAB ( "           + CRLF // gus
    elseif cEmpAnt = '02'
        cQuery += " IND_RETORNA_SLD_DEV_INT ( "           + CRLF
	endif
    cQuery += "         BA3.BA3_CODINT, "                      + CRLF
	cQuery += "         BA3.BA3_CODEMP, "                      + CRLF
	cQuery += "         BA3.BA3_MATRIC, "                      + CRLF
	if !empty( dDtRef )
		cQuery += "         '" + dtos( dDtRef ) + "', "        + CRLF
	else
		cQuery += "         TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
	endif
	cQuery += "         'P' ) PARCELAS, "                      + CRLF

// --------------------------------------------------------------------------------------
// -[ Saldo ]-------------------------------
        if cEmpAnt = '01'
//      cQuery += " IND_RETORNA_SALDO_DEVIDO     ( "           + CRLF // gus
        cQuery += " IND_RETORNA_SLD_DEV_CAB ( "           + CRLF // gus
    elseif cEmpAnt = '02'
        cQuery += " IND_RETORNA_SLD_DEV_INT ( "           + CRLF
	endif
	cQuery += "         BA3.BA3_CODINT, "                      + CRLF
	cQuery += "         BA3.BA3_CODEMP, "                      + CRLF
	cQuery += "         BA3.BA3_MATRIC, "                      + CRLF
	if !empty( dDtRef )
		cQuery += "         '" + dtos( dDtRef ) + "', "        + CRLF
	else
		cQuery += "         TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
	endif
	cQuery += "         'V' "                                  + CRLF
	cQuery += "         ) SALDO, "                             + CRLF

// --------------------------------------------------------------------------------------
// -[ xSaldo - PF ]--------------------------
    if cFlEmp <> "'PJ'"

            if cEmpAnt = '01'
            cQuery += " IND_RET_SLD_DET     ( "             + CRLF
        elseif cEmpAnt = '02'
            cQuery += " IND_RET_SLD_DET_INT ( "             + CRLF
        endif
	    cQuery += "         BA3.BA3_CODINT, "                     + CRLF
	    cQuery += "         BA3.BA3_CODEMP, "                     + CRLF
	    cQuery += "         BA3.BA3_MATRIC, "                     + CRLF
	    if !empty( dDtRef )
            cQuery += "         '" + dtos( dDtRef ) + "'  "       + CRLF
	    else
            cQuery += "         TO_CHAR(SYSDATE - 2,'YYYYMMDD') " + CRLF
        endif
        cQuery += "         ) XSALDO, "                           + CRLF

// -[ xSaldo - PJ ]--------------------------
    elseif cFlEmp == "'PJ'"

            if cEmpAnt = '01'
            cQuery += " IND_RET_SLD_DET_CAB_PJ ( "          + CRLF // gus confirmar Caberj PJ
        elseif cEmpAnt = '02'
            cQuery += " IND_RET_SLD_DET_INT_PJ ( "          + CRLF
        endif
	    cQuery += "         BA3.BA3_CODINT, "                     + CRLF
	    cQuery += "         BA3.BA3_CODEMP, "                     + CRLF
	    cQuery += "         BA3.BA3_CONEMP, "                     + CRLF
	    cQuery += "         BA3.BA3_SUBCON, "                     + CRLF
	    if !empty( dDtRef )
            cQuery += "         '" + dtos( dDtRef ) + "'  "       + CRLF
	    else
            cQuery += "         TO_CHAR(SYSDATE - 2,'YYYYMMDD') " + CRLF
        endif
        cQuery += "     ) XSALDO, "                               + CRLF

    endif

// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

    cQuery += "     NVL(FAT.E1_NUM, ' ') FATURA, "                                                        + CRLF
    cQuery += "     DECODE(FAT.E1_VENCREA, NULL, ' ', SIGA.FORMATA_DATA_MS(FAT.E1_VENCREA) )DATA_FATUR, " + CRLF
    cQuery += "     BA1.R_E_C_N_O_ NRECNO, "                                                              + CRLF

// ------------------------------------
    if cEmpAnt = '01'
        _cEmpRot := 'C'
    else
        _cEmpRot := 'I'
    endif
// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
    if cFlEmp <> "'PJ'"
        cQuery += "     IND_RETORNA_RUBRICA_PARCEL ( "     + CRLF
        cQuery += "     BA3.BA3_CODINT, "                  + CRLF
        cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
        cQuery += "     BA3.BA3_MATRIC, "                  + CRLF
        cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
        cQuery += "     '"+ _cEmpRot + "' "                + CRLF
        cQuery += "     ) RUB_PARC, "                      + CRLF
// ------------------------------------
        cQuery += "     IND_RETORNA_RUBRICA_MENSAL ( "     + CRLF
        cQuery += "     BA3.BA3_CODINT, "                  + CRLF
        cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
        cQuery += "     BA3.BA3_MATRIC, "                  + CRLF
        cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
        cQuery += "     '"+ _cEmpRot + "' "                + CRLF
        cQuery += "     ) RUB_MENS, "                      + CRLF
// ------------------------------------
    elseif cFlEmp == "'PJ'"
        cQuery += "     IND_RET_RUBRIC_PARCEL_PJ ( "  + CRLF
        cQuery += "     BA3.BA3_CODINT, "                  + CRLF
        cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
        cQuery += "     BA3.BA3_CONEMP, "                  + CRLF
        cQuery += "     BA3.BA3_SUBCON, "                  + CRLF
        cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
        cQuery += "     '"+ _cEmpRot + "' "                + CRLF
        cQuery += "     ) RUB_PARC, "                      + CRLF
// ------------------------------------
        cQuery += "     IND_RET_RUBRIC_MENSAL_PJ ( "  + CRLF
        cQuery += "     BA3.BA3_CODINT, "                  + CRLF
        cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
        cQuery += "     BA3.BA3_CONEMP, "                  + CRLF
        cQuery += "     BA3.BA3_SUBCON, "                  + CRLF
        cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
        cQuery += "     '"+ _cEmpRot + "' "                + CRLF
        cQuery += "     ) RUB_MENS, "                      + CRLF
    endif
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

// ------------------------------------
    cQuery += " NVL(CASE "                                        + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC)  = ' ' THEN "    + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC   = ' ' THEN "    + CRLF
    cQuery += "             RETORNA_SINISTRAL_CONTR_SUB("  + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODEMP,SE1.E1_CONEMP,SE1.E1_SUBCON, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-6), "             + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1)) "             + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN "    + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC  <> ' ' THEN "    + CRLF
    cQuery += "             RETORNA_SINISTRAL_FAM_MS_CAB(" + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODINT,SE1.E1_CODEMP,SE1.E1_MATRIC, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-6), "             + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1)) "             + CRLF
    cQuery += "     END,0) SIN_SEM, "                             + CRLF
// ------------------------------------
    cQuery += " NVL(CASE "                                        + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC)  = ' ' THEN "    + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC   = ' ' THEN "    + CRLF
    cQuery += "             RETORNA_SINISTRAL_CONTR_SUB("  + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODEMP,SE1.E1_CONEMP,SE1.E1_SUBCON, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-12), "            + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1))  "            + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN "    + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC  <> ' ' THEN "    + CRLF
    cQuery += "             RETORNA_SINISTRAL_FAM_MS_CAB(" + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODINT,SE1.E1_CODEMP,SE1.E1_MATRIC, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-12), "            + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1))  "            + CRLF
    cQuery += "     END,0) SIN_ANO, "                             + CRLF
// ------------------------------------
    cQuery += "     TO_CHAR(IDADE_S(BA1.BA1_DATNAS)) IDADE "      + CRLF
// ------------------------------------

// -[ Gestao Inadimplencia - Gus ini ]------------
// -[ Status e Bata de Bloqueio      ]------------
    cQuery += " ,   CASE "                                                         + CRLF
// ----------------------
    cQuery += "         WHEN ( BA3.BA3_MOTBLO = ' ' OR "                           + CRLF
	if !empty( dDtRef )
		cQuery += "            BA3.BA3_DATBLO > '" + dtos( dDtRef ) + "' "         + CRLF
	else
		cQuery += "            BA3.BA3_DATBLO > TO_CHAR(SYSDATE - 2,'YYYYMMDD') "  + CRLF
	endif
    cQuery += "       ) THEN 'ATIVO' "                                             + CRLF
// ----------------------
    cQuery += "         WHEN ( BA3.BA3_MOTBLO <> ' ' AND "                         + CRLF
	if !empty( dDtRef )
		cQuery += "            BA3.BA3_DATBLO <= '" + dtos( dDtRef ) + "' "        + CRLF
	else
		cQuery += "            BA3.BA3_DATBLO <= TO_CHAR(SYSDATE - 2,'YYYYMMDD') " + CRLF
	endif
    cQuery += "       ) THEN 'BLOQUEADO' "                                         + CRLF
// ----------------------
    cQuery += "     END STATUS, "                                                  + CRLF
// ----------------------
	cQuery += "     BA3.BA3_DATBLO DT_BLOQ  , "                                    + CRLF
	cQuery += "     BA3.BA3_CONEMP CONTRATO , "                                    + CRLF
   	cQuery += "     BA3.BA3_SUBCON SUBCONTR , "                                    + CRLF
	cQuery += "     BA3.BA3_COBNIV COBNIV,    "                                    + CRLF
   	//cQuery += "   BA3.BA3_XAPR1 APROVA1   , "                                    + CRLF
   	//cQuery += "   BA3.BA3_XAPR2 APROVA2     "                                    + CRLF
    cQuery += "     ' ' APROVA1, "                                    + CRLF
   	cQuery += "     ' ' APROVA2  "                                    + CRLF



// -[ Gestao Inadimplencia - Gus fim ]------------

    cQuery += " FROM "       + retsqlname( 'BA3' ) + " BA3 "      + CRLF
    cQuery += "	INNER JOIN " + retsqlname( 'BA1' ) + " BA1 "      + CRLF
    cQuery += " ON  BA1.BA1_FILIAL = '" + xfilial( 'BA1' ) + "' " + CRLF
    cQuery += "	AND BA1.BA1_CODINT = BA3.BA3_CODINT "             + CRLF
    cQuery += " AND BA1.BA1_CODEMP = BA3.BA3_CODEMP "             + CRLF
    cQuery += " AND BA1.BA1_MATRIC = BA3.BA3_MATRIC "             + CRLF
    cQuery += " AND BA1.BA1_TIPUSU = 'T' "                        + CRLF

//// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
//    if !empty( alltrim( cFlEmp ))        .AND. ;
//	                    cFlEmp <> "'PF'" .AND. ;
//	                    cFlEmp <> "'PJ'"
//        cQuery += " AND BA1.BA1_CODEMP IN (" + cFlEmp + ") " + CRLF
//    endif
//// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

    cQuery += "     AND BA1.D_E_L_E_T_ = ' ' " + CRLF

    if cPesq <> "'8'" .AND. ;
	   alltrim(cStatusAt) != 'Bloqueados Prefeitura'
        cQuery += "        AND ( "                                               + CRLF
        cQuery += "              BA1.BA1_MOTBLO in ( '   ' , '028' ) "           + CRLF
        cQuery += "        OR "                                                  + CRLF
        cQuery += "              BA1.BA1_DATBLO >= TO_CHAR(SYSDATE,'YYYYMMDD') " + CRLF
        cQuery += "        ) "                                                   + CRLF
    else
        cQuery += "        AND BA1.BA1_MOTBLO = '485' "                          + CRLF
    endif
// ------------------------------------
    cQuery += " INNER JOIN "                                        + CRLF
    cQuery += "            " + retsqlname( 'SE1' ) + " SE1 "        + CRLF
    cQuery += " ON "                                                + CRLF
    cQuery += "      SE1.E1_FILIAL  = '" + xfilial( 'SE1' ) + "' "  + CRLF
    cQuery += "  AND SE1.E1_CODINT  = BA1.BA1_CODINT "              + CRLF
    cQuery += "  AND SE1.E1_CODEMP  = BA1.BA1_CODEMP "              + CRLF
// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
    if cFlEmp <> "'PJ'"
        cQuery += "  AND SE1.E1_MATRIC  = BA1.BA1_MATRIC "          + CRLF
    else
        cQuery += "  AND SE1.E1_CONEMP  = BA1.BA1_CONEMP "          + CRLF
        cQuery += "  AND SE1.E1_SUBCON  = BA1.BA1_SUBCON "          + CRLF
    endif
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------
    cQuery += "  AND SE1.E1_TIPO   IN ('FT ','DP ') "               + CRLF
    cQuery += "  AND SE1.E1_SALDO   > 0 "                           + CRLF
// ------------------------------------
    cQuery += "  LEFT JOIN "                                        + CRLF
    cQuery += "            " + retsqlname( 'SE1' ) + " FAT "        + CRLF
    cQuery += "  ON "                                               + CRLF
    cQuery += "      FAT.E1_FILIAL   = '" + xfilial( 'SE1' ) + "' " + CRLF
    cQuery += "  AND FAT.E1_CODINT   = BA3.BA3_CODINT "             + CRLF
    cQuery += "  AND FAT.E1_CODEMP   = BA3.BA3_CODEMP "             + CRLF
// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
    if cFlEmp <> "'PJ'"
        cQuery += "  AND FAT.E1_MATRIC   = BA3.BA3_MATRIC "         + CRLF
    else
        cQuery += "  AND FAT.E1_CONEMP   = BA3.BA3_CONEMP "         + CRLF
        cQuery += "  AND FAT.E1_SUBCON   = BA3.BA3_SUBCON "         + CRLF
    endif
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------
    cQuery += "  AND FAT.E1_PREFIXO  = 'FAT' "                      + CRLF
    cQuery += "  AND FAT.E1_TIPO     = 'FT'  "                      + CRLF
//  cQuery += "  AND FAT.E1_HIST  LIKE '%VLR ORIG%' "               + CRLF
    cQuery += "  AND FAT.E1_HIST  LIKE  'VLR ORIG%' "               + CRLF
    cQuery += "  AND FAT.E1_SALDO    > 0 "                          + CRLF
    cQuery += "  AND FAT.D_E_L_E_T_  = ' ' "                        + CRLF
// ------------------------------------
    cQuery += "  WHERE "                                            + CRLF
    cQuery += "      BA3.BA3_FILIAL = '" + xfilial( 'BA3' ) + "' "  + CRLF
    cQuery += "  AND BA3.D_E_L_E_T_ = ' ' "                         + CRLF
// ------------------------------------
    if alltrim( cPesq ) <> "'8'"
        if alltrim(cStatusAt) <> 'Bloqueados Prefeitura'
            cQuery += " AND BA3.BA3_YSITBQ = " + cPesq + " " + CRLF
        endif
    endif
// ------------------------------------
    if cPesq <> "'8'"

        if alltrim(cStatusAt) == 'Bloqueados Prefeitura'
// ------------------------------------
//          [ Bloqueio Prefeitura ou transferência antes da migração ]
// ------------------------------------
            cQuery += "         AND BA3.BA3_CODEMP  = '0024' "     + CRLF
            cQuery += "	        AND ( "                            + CRLF
            cQuery += "             BA3.BA3_MOTBLO  = '007'  "     + CRLF
            cQuery += "         OR  ( "                            + CRLF
            cQuery += "             BA3.BA3_MOTBLO  = '019'  "     + CRLF
            cQuery += "         AND BA3.BA3_DATBLO <= '20160731' " + CRLF
            cQuery += "             ) "                            + CRLF
            cQuery += "             ) "                            + CRLF

        else

            cQuery += "         AND ( "                                             + CRLF
            cQuery += "             BA3.BA3_MOTBLO IN ( '   ' , '028' ) "           + CRLF
            cQuery += "         OR "                                                + CRLF
            cQuery += "             BA3.BA3_DATBLO >= TO_CHAR(SYSDATE,'YYYYMMDD') " + CRLF
            cQuery += "             ) "                                             + CRLF

        endif
    endif

// ------------------------------------

    if !empty( alltrim( cTpPag ))

            if cTpPag == 'BOLETO'      // Boleto      -- 04
            cQuery += "       AND BA3.BA3_TIPPAG = '04' "         + CRLF

        elseif cTpPag == 'SISDEB'      // SISDEB      -- 06
            cQuery += "       AND BA3.BA3_TIPPAG = '06' "         + CRLF

        elseif cTpPag == 'PREVI'       // PREVI       -- 01/08
            cQuery += "       AND BA3.BA3_TIPPAG IN ('01','08') " + CRLF

        elseif cTpPag == 'EMPRESARIAL' // EMPRESARIAL -- 03
            cQuery += "       AND BA3.BA3_TIPPAG = '03' "         + CRLF
        endif

    endif

// ------------------------------------------------------------------------
// -[ Gestao Inadimplencia - gus - fim ]-----------------------------------
// *[ gus - confirmar com carlos criterio para PF e PJ ]*******************
// ------------------------------------------------------------------------
        if cFlEmp == "'PF'"
        cQuery += " AND BA3.BA3_COBNIV  = '1' " + CRLF
        cQuery += " AND BA3.BA3_CODCLI <> ' ' " + CRLF
    elseif cFlEmp == "'PJ'"
        cQuery += " AND BA3.BA3_COBNIV  = '0' " + CRLF
        cQuery += " AND BA3.BA3_CODCLI  = ' ' " + CRLF
    elseif !empty( alltrim( cFlEmp ))        .AND. ;
	                        cFlEmp <> "'PF'" .AND. ;
	                        cFlEmp <> "'PJ'"
        cQuery += " AND BA3.BA3_CODEMP IN (" + cFlEmp + ") " + CRLF
    endif
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------
/*/
    cQuery += "   GROUP BY "                        + CRLF
    cQuery += "       ' ' , "                       + CRLF
    cQuery += "       BA3.BA3_CODINT, "             + CRLF
    cQuery += "       BA3.BA3_CODEMP, "             + CRLF
    cQuery += "       BA3.BA3_MATRIC, "             + CRLF
    cQuery += "       BA1_NOMUSR    , "             + CRLF
    cQuery += "       BA3.BA3_CODCLI, "             + CRLF
    cQuery += "       BA3.BA3_TIPPAG, "             + CRLF
    cQuery += "       DECODE( BA3.BA3_YSITBQ    , " + CRLF
    cQuery += "               '1' , 'MARCADO'   , " + CRLF
    cQuery += "               '2' , 'CARTA/ETIQ', " + CRLF
    cQuery += "               '5' , 'RETORNO AR', " + CRLF
    cQuery += "               '6' , 'DESMARCADO', " + CRLF
    cQuery += "               '7' , 'BLOQ/REATIV' " + CRLF
    cQuery += "             ) , "                   + CRLF
    cQuery += "       BA3.BA3_MOTBLO, "             + CRLF

// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
// -[ Parcelas ]----------------------------
        if cEmpAnt = '01'
        cQuery += " IND_RETORNA_SALDO_DET     ( " + CRLF
    elseif cEmpAnt = '02'
        cQuery += " IND_RETORNA_SALDO_DET_INT ( " + CRLF
	endif
    cQuery += "			BA3.BA3_CODINT,		       " + CRLF
	cQuery += "			BA3.BA3_CODEMP,		       " + CRLF
	cQuery += "			BA3.BA3_MATRIC, 		   " + CRLF
	if !empty( dDtRef )
		cQuery += "       '" + dtos( dDtRef ) + "' " + CRLF
	else
		cQuery += " TO_CHAR(SYSDATE - 2,'YYYYMMDD') " + CRLF
	endif
		cQuery += "		) , " + CRLF
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

    cQuery += "     FAT.E1_NUM    , " + CRLF
    cQuery += "     FAT.E1_VENCREA, " + CRLF
    cQuery += "     BA1.R_E_C_N_O_, " + CRLF

// ------------------------------------

    cQuery += "     IND_RETORNA_RUBRICA_PARCEL "       + CRLF
    cQuery += "     ( "                                + CRLF
    cQuery += "     BA3.BA3_CODINT, "                  + CRLF
    cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
    cQuery += "     BA3.BA3_MATRIC, "                  + CRLF
    cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
    cQuery += "     '" + _cEmpRot + "' "               + CRLF
    cQuery += "     ), "                               + CRLF

// ------------------------------------

    cQuery += "     IND_RETORNA_RUBRICA_MENSAL "       + CRLF
    cQuery += "     (  "                               + CRLF
    cQuery += "     BA3.BA3_CODINT, "                  + CRLF
    cQuery += "     BA3.BA3_CODEMP, "                  + CRLF
    cQuery += "     BA3.BA3_MATRIC, "                  + CRLF
    cQuery += "     TO_CHAR(SYSDATE - 2,'YYYYMMDD'), " + CRLF
    cQuery += "     '" + _cEmpRot + "' "               + CRLF
    cQuery += "     ), "                               + CRLF

// ------------------------------------

    cQuery += " NVL(CASE "                                     + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC)  = ' ' THEN " + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC   = ' ' THEN " + CRLF
    cQuery += "             RETORNA_SINISTRAL_CONTR_SUB("      + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODEMP,SE1.E1_CONEMP,SE1.E1_SUBCON, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-6), "          + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1)) "          + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN " + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC  <> ' ' THEN " + CRLF
    cQuery += "             RETORNA_SINISTRAL_FAM_MS_CAB("     + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODINT,SE1.E1_CODEMP,SE1.E1_MATRIC, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-6), "          + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1)) "          + CRLF
    cQuery += "     END,0) , "                                 + CRLF

// ------------------------------------

    cQuery += " NVL(CASE "                                     + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC)  = ' ' THEN " + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC   = ' ' THEN " + CRLF
    cQuery += "             RETORNA_SINISTRAL_CONTR_SUB("      + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODEMP,SE1.E1_CONEMP,SE1.E1_SUBCON, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-12), "         + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1))  "         + CRLF
//  cQuery += "         WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN " + CRLF
    cQuery += "         WHEN      SE1.E1_MATRIC  <> ' ' THEN " + CRLF
    cQuery += "             RETORNA_SINISTRAL_FAM_MS_CAB("     + iif( cEmpAnt == '01' , "'C'" , "'I'" ) + ",'S',SE1.E1_CODINT,SE1.E1_CODEMP,SE1.E1_MATRIC, " + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-12), "         + CRLF
    cQuery += "             ADD_MONTHS(SYSDATE,-1))  "         + CRLF
    cQuery += "     END,0) , "                                 + CRLF
    cQuery += "     TO_CHAR(IDADE_S(BA1.BA1_DATNAS)) "         + CRLF

// -[ Gestao Inadimplencia - Gus ini ]------------
// -[ Status e Bata de Bloqueio      ]------------
    cQuery += " ,   CASE "                                                         + CRLF
    cQuery += "         WHEN ( BA3.BA3_MOTBLO = ' ' OR "                           + CRLF
	if !empty( dDtRef )
		cQuery += "            BA3.BA3_DATBLO > '" + dtos( dDtRef ) + "' "         + CRLF
	else
		cQuery += "            BA3.BA3_DATBLO > TO_CHAR(SYSDATE - 2,'YYYYMMDD') "  + CRLF
	endif
    cQuery += "       ) THEN 'ATIVO' "                                             + CRLF
    cQuery += "         WHEN ( BA3.BA3_MOTBLO <> ' ' AND "                         + CRLF
	if !empty( dDtRef )
		cQuery += "            BA3.BA3_DATBLO <= '" + dtos( dDtRef ) + "' "        + CRLF
	else
		cQuery += "            BA3.BA3_DATBLO <= TO_CHAR(SYSDATE - 2,'YYYYMMDD') " + CRLF
	endif
    cQuery += "       ) THEN 'BLOQUEADO' "                                         + CRLF
    cQuery += "     END , "                                                        + CRLF
// ------------------------------------
	cQuery += "     BA3.BA3_DATBLO , "                                             + CRLF
	cQuery += "     BA3.BA3_CONEMP , "                                             + CRLF
	cQuery += "     BA3.BA3_SUBCON , "                                             + CRLF
	cQuery += "     BA3.BA3_COBNIV   "                                             + CRLF
// -[ Gestao Inadimplencia - Gus fim ]------------
/*/
// ------------------------------------
    cQuery += cOrder
// ------------------------------------
    memowrite( 'C:\temp\caba200.sql' , cQuery )
// ------------------------------------
    if tccanopen( cAliasTmp )
        tcdelfile( cAliasTmp )
    endif
// ------------------------------------
    if select( cAliasTmp ) <> 0
        dbselectarea( cAliasTmp )
        (cAliasTmp)->( dbclosearea() )
    endif
// ------------------------------------
    dbusearea( .T. , 'TopConn' , tcgenqry( , , cQuery ) , cAliasTmp , .T. , .T. )
// ------------------------------------
    for ni := 2 to len( aStruct )
        if aStruct[ni,2] != 'C'
            tcsetfield( cAliasTmp , aStruct[ni,1] , aStruct[ni,2] , aStruct[ni,3] , aStruct[ni,4] )
        endif
    next ni

    cTmp2 := criatrab( NIL , .F. )
    copy to &cTmp2

// -[ Gestao Inadimplencia - gus - ini ]-------------------------------------------------
// -[ verifica qtd parcelas ]
    dbclosearea()
    dbusearea(.T.,,cTmp2,cAliasTmp,.T.,.T.)
    begin sequence
      if cParceAt <> '0'
            (cAliasTmp)->( dbgotop() )
            do while !(cAliasTmp)->( eof() )
                if ( cAliasTmp )->PARCELAS < val( cParceAt )
                    reclock( cAliasTmp , .F. )
                        ( cAliasTmp )->( dbdelete() )
                    ( cAliasTmp )->( msunlock() )
                endif
			    ( cAliasTmp )->( dbskip() )
            enddo
      endif
	endsequence
// -[ Gestao Inadimplencia - gus - fim ]-------------------------------------------------

// ------------------------------------

    (cAliasTmp)->( dbgotop() )

    l_Primeira := .T.
    do while !(cAliasTmp)->( eof() )

        a_ItLin := {}

        for ni := 1 to len( aStruct )

            if !( alltrim( aStruct[ni][1] ) $ '|XOK' ) .AND. aStruct[ni,2] == 'C'

                aadd( a_ItLin , "'" + &( '(cAliasTmp)->( ' + aStruct[ni][1] + ') ' ) )
                if l_Primeira
                    aadd( a_Cab , aCampos[ni][1] )
                endif

            elseif !( alltrim( aStruct[ni][1] ) $ '|XOK' ) .AND.  aStruct[ni,2] != 'C'

                aadd( a_ItLin , &( '(cAliasTmp)->( ' + aStruct[ni][1] + ') ' ) )
                if l_Primeira
                    aadd( a_Cab , aCampos[ni][1] )
                endif

            endif

        next ni

        if l_Primeira
            l_Primeira := .F.
        endif

        aadd( a_ItFim , a_ItLin )

        (cAliasTmp)->( dbskip() )

    enddo

// ------------------------------------

    dbclosearea()
    dbUseArea( .T. , , cTmp2 , cAliasTmp , .T. )
    (cAliasTmp)->( dbgotop() )
    if (cAliasTmp)->( eof() )
        apmsginfo( 'Não foram encontrados registros com os parametros informados !' )
        lRet := .F.
    endif

    oBrwBord:Refresh()
    oDlgBord:Refresh()

return( lRet )

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia       |
// +--------------------------------------------------------------------------+
// | Função    : fAtuBrw( cTmpAlias , cCampoOk , cGet , lTodos )              |
// +--------------------------------------------------------------------------+

static function fAtuBrw( cTmpAlias , cCampoOk , cGet , lTodos )

// ------------------------------------
    local cMarca := ' '
// ------------------------------------

    SA1->( dbsetorder(1) )

    if lTodos <> NIL .AND. lTodos

        (cAliasTmp)->( dbgotop() )

        cMarca := if( empty( (cAliasTmp)->&(cCampoOk) ) , 'X' , '' )

        do while (cAliasTmp)->( !eof() )

            (cAliasTmp)->( reclock( cAliasTmp , .F. ) )
                (cAliasTmp)->&(cCampoOk) := cMarca
            (cAliasTmp)->( msunLock() )

            if empty( (cAliasTmp)->&(cCampoOk) )
                nTotReg --
            else
                nTotReg ++
            endif

            (cAliasTmp)->( dbskip() )

        enddo

        (cTmpAlias)->( dbgotop() )

    else

        (cAliasTmp)->( reclock( cAliasTmp , .F. ) )
            (cAliasTmp)->&(cCampoOk) := if( empty( (cAliasTmp)->&(cCampoOk) ) , 'X' , '' )
        (cAliasTmp)->( msunlock() )

        if empty( (cAliasTmp)->&(cCampoOk) )
            nTotReg --
        else
            nTotReg ++
        endif

    endif

    oBrwBord:Refresh()
    oDlgBord:Refresh()

return( .T. )

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fGeraCarta()                                                 |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para gerar a carta dos inadimplentes.       |
// +--------------------------------------------------------------------------+

static function fGeraCarta()

// ------------------------------------
    local   aArea    := getarea()
    local   aCarta   := {}
    local   dDataLim := ctod( '  /  /    ' )
// ------------------------------------
//  private cPerg    := 'CAB200'
// ------------------------------------

//	======================================
//	Layout Matriz aCarta (Dimensoes)
//	--------------------------------------
//	1-Nome Cliente
//	2-Logradouro + Numero + Complemento
//	3-Bairro
//	4-Cidade
//	5-Estado
//	6-Cep
//	7-Valor devido
//	8-Data limite para comparecimento
//	======================================

    if msgyesno( 'Confirma geração da Carta ?' )

//      pergunte( cPerg    , .T. )
        pergunte( 'CAB200' , .T. )

        dDataLim := MV_PAR01

        dbselectarea( cAliasTmp )
        dbgotop()

        do while !eof()

            if !empty( (cAliasTmp)->&(cCampoOk) )

                SA1->( dbsetorder(1) )
                SA1->( dbseek( xfilial( 'SA1' ) + (cAliasTmp)->BA3_CODCLI + '01' ) )

                if (cAliasTmp)->BA3_CODCLI == SA1->A1_COD

// ------------------------------------
//                  Angelo Henrique - Data:03/12/2015
//                  Chamado: 22414 - Solicitado que quando for Mater
//                  a carta será diferenciada, acrescentando no vetor
//                  a empresa 0001 (Mater) e 0002, 0005 (Afinidade)
// ------------------------------------
                    aadd( aCarta , { (cAliasTmp)->BA1_NOMUSR                                   , ;
                                     alltrim( SA1->A1_END ) + ' ' + alltrim( SA1->A1_COMPLEM ) , ;
                                     SA1->A1_BAIRRO                                            , ;
                                     SA1->A1_MUN                                               , ;
                                     SA1->A1_EST                                               , ;
                                     SA1->A1_CEP                                               , ;
                                     (cAliasTmp)->SALDO                                        , ;
                                     dDataLim                                                  , ;
                                     (cAliasTmp)->NRECNO                                       , ;
                                     (cAliasTmp)->BA3_CODEMP                                   , ;
                                     (cAliasTmp)->XSALDO,;
                                     (cAliasTmp)->BA3_CODINT+(cAliasTmp)->BA3_CODEMP+(cAliasTmp)->BA3_MATRIC  } )

// ------------------------------------

                endif

            endif

            dbselectarea(cAliasTmp)
            (cAliasTmp)->( dbskip() )

        enddo

// ------------------------------------
//      [ chama rotina emissao da cartas ]
// ------------------------------------

// -----[ Gestao Inadimplencia - gus - ini ]---------------------------------------------
// ------------------------------------
//      u_inadimp( aCarta , dtoc( dDtRef ) )
// ------------------------------------
// --------[ caberj ]------------------
            if cEmpAnt = '01'
            u_inadimp( aCarta , dtoc( dDtRef ) )
// --------[ integral ]----------------
        elseif cEmpAnt = '02'
//          u_xinadimp( aCarta , dtoc( dDtRef ) )
            u_inadimp( aCarta , dtoc( dDtRef ) , 'Integral' , cFlEmp )
        endif
// -----[ Gestao Inadimplencia - gus - fim ]---------------------------------------------

        restarea( aArea )

        apmsginfo( 'Geração de Cartas - Processamento Concluído!' )

    endif

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fGeraEtiq()                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para gerar as etiquetas das cartas.         |
// +--------------------------------------------------------------------------+

static function fGeraEtiq()

// ------------------------------------
    local k         := 0
    local aArea     := getarea()
// ------------------------------------
    local I         := 1
    local J         := 0
    local Lin       := array( 5 , 1 )
    local cCodigo   := ''
    local nLin      := 0
    local nColuna   := 3
// ------------------------------------
    local cNomTit   := space(42)
    local cNome     := space(42)
    local aResumo   := {}
    local lImprime  := .T.
// ------------------------------------
    local cNomeArq  := ''
    local cCpo      := ''
    local cLin      := space(1) + chr(13) + chr(10)
    local _cTime    := ''
// ------------------------------------

    if !msgyesno( 'Confirma geração do arquivo de Etiquetas ?' )
        return
    endif

// ------------------------------------

    _cTime   := '_' + strtran( time(), ':' , '' )
    cNomeArq := getnewpar( 'MV_YETIQD' , '\interface\Exporta\ETIQDESL\' ) + ;
	            'ETQ' + substr( dtos( dDataBase ) , 7 , 2 )               + ;
				        substr( dtos( dDataBase ) , 5 , 2 )               + ;
						substr( dtos( dDataBase ) , 3 , 2 )               + ;
				_cTime + '.PRN'

    if !( u_cria_txt( cNomeArq ) )
        msgalert( 'Erro criacao arquivo Etiquetas!' , 'Atencao...' )
        return
    endif

    dbselectarea( cAliasTmp )
    dbgotop()

    do while !eof()

        if !empty((cAliasTmp)->&(cCampoOk))

// ------------------------------------

            if cTipImp = 2
                nLin := pRow() + 2
            endif

// ------------------------------------
//          IncRegua()
// ------------------------------------

            nColuna := 0
            I       := 1
            J       := 0

// ------------------------------------
//          [ Monta array com etiquetas... ]
// ------------------------------------
//          Lin := array( 5 , 3 )
//          Lin := array( 5 , 2 )
// ------------------------------------
            Lin := array( 5 , 1 )

// ------------------------------------

            do while I <= 1  .AND. !(cAliasTmp)->( eof() )

                if empty( (cAliasTmp)->&(cCampoOk) )
                    (cAliasTmp)->( dbskip() )
                else

                    cMatric := (cAliasTmp)->BA3_CODINT + ;
                               (cAliasTmp)->BA3_CODEMP + ;
                               (cAliasTmp)->BA3_MATRIC

                    if lSomTit // Isso filtrará caso não seja solicitado a emissão de lotes
                        nPos := ascan( aResumo , {|x|x[1] == (cAliasTmp)->BA3_CODINT + ;
                                                             (cAliasTmp)->BA3_CODEMP + ;
                                                             (cAliasTmp)->BA3_MATRIC } )

                        if nPos == 0
                            aadd( aResumo , { (cAliasTmp)->BA3_CODINT + ;
                                              (cAliasTmp)->BA3_CODEMP + ;
                                              (cAliasTmp)->BA3_MATRIC } )
                            lImprime := .T.
                        else
                            lImprime := .F.
                        endif

                    endif

                    if lImprime

                        cNomTit := space(42)

                        SA1->( dbsetorder(1) )
                        SA1->( dbseek( xfilial( 'SA1' ) + (cAliasTmp)->BA3_CODCLI + '01' ) )

                        cNomTit := alltrim( substr( (cAliasTmp)->BA1_NOMUSR , 1 , 42 ) )
                        cCodigo :=                  (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC
                        cNome   := alltrim( substr( (cAliasTmp)->BA1_NOMUSR , 1 , 42 ) )
                        cEndere := alltrim( SA1->A1_END )
                        cCompl  := ' '
                        cBairro := alltrim( SA1->A1_BAIRRO )
                        cMunici := alltrim( SA1->A1_MUN )
                        cEstado :=          SA1->A1_EST
                        cCep    := substr(  SA1->A1_CEP , 1 , 5 ) + '-' + substr( SA1->A1_CEP , 6 , 3 )

// ------------------------------------
//                      [ Monto array com dados da etiqueta... ]
// ------------------------------------
//                      200 oficio Lin[1,I] := Padr(cNomTit,43)
//                      200 oficio Lin[2,I] := Padr(cEndere,43)
//                      200 oficio Lin[3,I] := Padr(iif(empty(alltrim(cCompl)),cBairro,cCompl+" - "+cBairro),43)
//                      200 oficio Lin[4,I] := Padr(cMunici+"-"+cEstado,43)
//                      200 oficio Lin[5,I] := Padr(cCep,43)
// ------------------------------------

                        Lin[1,I] := padr( 'Art. 13, inciso unico, II Lei 9656/98' , 43 )
                        Lin[2,I] := padr( cNomTit , 43 )
                        Lin[3,I] := padr( cEndere , 43 )
                        Lin[4,I] := padr( iif( empty( alltrim( cCompl  ) )  , ;
					                                  alltrim( cBairro )    , ;
                                     cCompl + ' - ' + alltrim( cBairro ) )  + ;
								              ' - ' + alltrim( cMunici )    + ;
										      '/'   + alltrim( cEstado )    , 43 )
// ------------------------------------
                        Lin[5,I] := padr( cCep , 9 ) + ' - ' + ;
                                    padr( 'OFICIO ' + substr( dtos( dDataBase ) , 4 , 2 )   + ;
								    strzero( (cAliasTmp)->NRECNO , 8 ) , 15 ) + '  Ref. ' + ;
								    substr( dtos( dDataBase ) , 5 , 2 ) + '/'               + ;
								    substr( dtos( dDataBase ) , 1 , 4 )+'  '

// ------------------------------------
//                      [ Monto array com dados da etiqueta... ]
// ------------------------------------

                        I += 1
                        if (cAliasTmp)->( eof() )
// ------------------------------------
//                          I = 3 + 1 -- Angelo Henrique - Data: 09/01/2017 - Fornecedor não faz mais etiquetas com 3 colunas
//                          I = 2 + 1 -- Angelo Henrique - Data: 15/09/2021 - Compraram errado essa merda
// ------------------------------------
                            I = 2 + 1 // ???
                        endif
                    endif

                    (cAliasTmp)->( dbskip() )

                    if cMatric != (cAliasTmp)->BA3_CODINT + ;
		    		              (cAliasTmp)->BA3_CODEMP + ;
			    				  (cAliasTmp)->BA3_MATRIC
                        aResumo := {}
                    endif
                endif
            enddo

// ------------------------------------
//          [ grava arquivo de etiq ]
// ------------------------------------

            for J := 1 to 6

                if J == 6
                    cCpo := space(132)
                else
                    cCpo := ''
// ------------------------------------
//                  for K := 1 to 3 //Angelo Henrique - Data: 09/01/2017 - Fornecedor não faz mais etiquetas com 3 colunas
//                  for K := 1 to 2 //Angelo Henrique - Data:15/09/2021
// ------------------------------------
                    for K := 1 to 1
                        if !empty( Lin[J,K] )
                            cCpo += Lin[J,K]
                        endif
                    next K

                endif

                if !( u_grlinha_txt( cCpo , cLin ) )
                    msgalert( 'Erro gravacao registro no arquivo Etiquetas!' , 'Atencao...' )
                    return
                endif

            next J

            nLin += 1

// ------------------------------------

        else
            (cAliasTmp)->( dbskip() )
        endif

        dbselectarea( cAliasTmp )

// ------------------------------------

    enddo

    u_fecha_txt()

    msgalert( 'Arquivo ' + cNomeArq + ' gerado ! Solicite impressão das etiquetas pelo HelpDesk !' , 'Atencao...' )

    restarea( aArea )

// ------------------------------------
//  fMontaBrowse()
// ------------------------------------

    apmsginfo( ' Fim do Processamento !!! ' )

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fMarcaCarta()                                                |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para marcar a situação como carta.          |
// +--------------------------------------------------------------------------+

static function fMarcaCarta()

// ------------------------------------
    if !msgyesno( 'Confirma marcação da Carta/Etiq ?' )
        return
    endif

    dbselectarea( cAliasTmp )
    dbgotop()

    do while !eof()

        if (!empty( (cAliasTmp)->&(cCampoOk) )              .AND. ;
		    ( trim( (cAliasTmp)->XSITUACAO ) == 'MARCADO' ) .OR.  ;
			        (cAliasTmp)->MTBLQ = '485' )

            BA3->( dbsetorder(1) )
            BA3->(dbseek( xfilial( 'BA3' ) + (cAliasTmp)->BA3_CODINT + ;
			                                 (cAliasTmp)->BA3_CODEMP + ;
											 (cAliasTmp)->BA3_MATRIC ) )

            if (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC == ;
			           BA3->BA3_CODINT +         BA3->BA3_CODEMP +         BA3->BA3_MATRIC
                BA3->( reclock( 'BA3' , .F. ) )
                    BA3->BA3_YSITBQ = '2'
                    BA3->( msunlock() )
            endif

        endif

        dbselectarea( cAliasTmp )
        (cAliasTmp)->( dbskip() )

    enddo

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fDesMarca()                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para desmarcar a situação de carta.         |
// +--------------------------------------------------------------------------+

static function fDesMarca()

    local nCont := 0

// ------------------------------------
    
	if msgyesno( 'Confirma Desmarcação?' )

        dbselectarea( cAliasTmp )
        dbgotop()

        do while !eof()

            if ( !empty( (cAliasTmp)->&(cCampoOk) ) .AND. ;
		           trim( (cAliasTmp)->XSITUACAO   ) $ 'MARCADO|CARTA/ETIQ|RETORNO AR|BLOQ/REATIV' )

                BA3->( dbsetorder(1) )
                BA3->( dbseek( xfilial( 'BA3' )       + ;
			                  (cAliasTmp)->BA3_CODINT + ;
						      (cAliasTmp)->BA3_CODEMP + ;
						      (cAliasTmp)->BA3_MATRIC ) )

                if (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC == ;
			               BA3->BA3_CODINT +         BA3->BA3_CODEMP + BA3->BA3_MATRIC

                    BA3->( reclock( 'BA3' , .F. ) )
                        BA3->BA3_YSITBQ = '6'
                    BA3->( msunlock() )

                    nCont := nCont + 1

                endif

            endif

            dbselectarea( cAliasTmp )
            (cAliasTmp)->( dbskip() )

        enddo

// ------------------------------------
//      fMontaBrowse()
// ------------------------------------

        apmsginfo( 'Fim do Processamento!' + chr(13) + chr(10) + ;
                   alltrim( str( nCont ))  + ' Desmarcados!'     )

    else

        apmsginfo( 'Desmarcação Não Confirmada! ' )

    endif

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fRetAr()                                                     |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para atualizar a situação de retorno de AR. |
// +--------------------------------------------------------------------------+

static function fRetAR()

// ------------------------------------

    if !msgyesno( 'Confirma marcação do Retorno do AR ?' )
        return
    endif

    dbselectarea( cAliasTmp )
    dbgotop()

    do while !eof()

        if ( !empty( (cAliasTmp)->&(cCampoOk) ) .AND. ;
		       trim( (cAliasTmp)->XSITUACAO   ) == 'CARTA/ETIQ' )

            BA3->( dbsetorder(1) )
            BA3->( dbseek( xfilial( 'BA3' )        + ;
			               (cAliasTmp)->BA3_CODINT + ;
						   (cAliasTmp)->BA3_CODEMP + ;
						   (cAliasTmp)->BA3_MATRIC ) )

            if (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC == ;
			           BA3->BA3_CODINT +         BA3->BA3_CODEMP +         BA3->BA3_MATRIC

                BA3->( reclock( 'BA3' , .F. ) )
                    BA3->BA3_YSITBQ = '5'
                BA3->( msunlock() )

            endif

        endif

        dbselectarea( cAliasTmp )
        dbskip()

    enddo

//-------------------------------------------------
// Aprovar Bloqueio de Inadimplentes
//------------------------------------------------
Static function fAprov(cUser, nOrigem)
// ------------------------------------

    if !msgyesno( 'Deseja realizar a aprovação do bloqueio por inadimplência ?' )
        return
    endif

    dbselectarea( cAliasTmp )
    dbgotop()

    do while !eof()

        if ( !empty( (cAliasTmp)->&(cCampoOk) ) .AND. ;
		       trim( (cAliasTmp)->XSITUACAO   ) = 'RETORNO AR' )

            BA3->( dbsetorder(1) )
            BA3->( dbseek( xfilial( 'BA3' )        + ;
			               (cAliasTmp)->BA3_CODINT + ;
						   (cAliasTmp)->BA3_CODEMP + ;
						   (cAliasTmp)->BA3_MATRIC ) )

            if (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC == ;
			           BA3->BA3_CODINT +         BA3->BA3_CODEMP +         BA3->BA3_MATRIC


                BA3->( reclock( 'BA3' , .F. ) )
                If nOrigem = 1
                    BA3->BA3_XAPR1 = cUser
                else
                    BA3->BA3_XAPR2 = cUser
                EndIf    
                BA3->( msunlock() )

            endif

        endif

        dbselectarea( cAliasTmp )
        dbskip()

    enddo






// ------------------------------------
//  fMontaBrowse()
// ------------------------------------

    apmsginfo( ' Fim do Processamento !!! ' )

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fBloqFam()                                                   |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para bloquear a familia.                    |
// +--------------------------------------------------------------------------+

static function fBloqFam()

// ------------------------------------
    local   cMotBlo  := ''
    local   aLog     := {}
    local   nTot     := 0
    local   nTotSld  := 0
    local   nomeprog := 'CABA200.PRW'
    local   cString  := ''
    local   cDesc1   := 'DESLIGAMENTO'
    local   cDesc2   := ''
    local   cDesc3   := ''
// ------------------------------------
    private Titulo   := 'Relação de Bloqueados'

    if !msgyesno( 'O Sistema ira disparar a rotina de Bloqueio ! O Desbloqueio depois disto só poderá ser feito manualmente ! Confirma Bloqueio ?' )
        return
    endif

    if empty( dDtBloq )
        msgalert( 'Informar a data de bloqueio!' , 'Atencao...' )
        return
    endif

    cMotBlo := getnewpar( 'MV_YBLQDEF' , '003' )

    dbselectarea( cAliasTmp )
    dbgotop()

    aadd( aLog , 'Bloqueio Automatico de Inadimplantes' )

    do while !eof()

        if ( !empty( (cAliasTmp)->&(cCampoOk) ) .AND. ;
		       trim( (cAliasTmp)->XSITUACAO   ) == 'RETORNO AR' )

            BG1->( dbsetorder(1) )
            BG1->( dbseek( xfilial( 'BG1' ) + cMotBlo ) )

            // ------------------------------------
            //          Posiciona BA3
            // ------------------------------------
            BA3->( dbsetorder(1) )
            BA3->( dbseek( xfilial( 'BA3' )        + ;
			               (cAliasTmp)->BA3_CODINT + ;
						   (cAliasTmp)->BA3_CODEMP + ;
						   (cAliasTmp)->BA3_MATRIC ) )

            if (cAliasTmp)->BA3_CODINT + (cAliasTmp)->BA3_CODEMP + (cAliasTmp)->BA3_MATRIC == ;
			           BA3->BA3_CODINT +         BA3->BA3_CODEMP +         BA3->BA3_MATRIC

                If !(Empty((cAliasTmp)->APROVA1) .OR. Empty((cAliasTmp)->APROVA2))

                    
                    BA3->( reclock( 'BA3' , .F. ) )
                    BA3->BA3_YSITBQ = '7'
                    BA3->( msunlock() )

                                    
                    // ------------------------------------
                    //              Posiciona BA1
                    // ------------------------------------
                    dbselectarea( 'BA1' )
                    dbgoto( (cAliasTmp)->NRECNO )

                    aadd( aLog , 'Matric ' + (cAliasTmp)->BA3_CODINT + ;
                                            (cAliasTmp)->BA3_CODEMP + ;
                                            (cAliasTmp)->BA3_MATRIC + ;
                                    ' ' + (cAliasTmp)->BA1_NOMUSR )

                    aadd( aLog , 'Saldo Devido ' + transform( (cAliasTmp)->SALDO , '@E 999,999.99' ) + ;
                                ' Parcelas '    + str( (cAliasTmp)->PARCELAS) )

                    aadd( aLog , ' ' )

                    // ------------------------------------
                    cQuery := " SELECT BA1_CODINT || '.'|| BA1_CODEMP || '.'|| BA1_MATRIC || '.'|| BA1_TIPREG || '-'||BA1_DIGITO|| ' - '|| BA1_NOMUSR USUARIO, BA0_CODIDE || BA0_CODINT || ' - ' || BA0_NOMINT RECIPRO "
                    cQuery +=   " FROM SIGA.BA1010 BA1 , "
                    cQuery +=        " SIGA.BA0010 BA0   "
                    cQuery +=  " WHERE BA0_FILIAL     = ' ' "
                    cQuery +=    " AND BA1.D_E_L_E_T_ = ' ' "
                    cQuery +=    " AND BA0.D_E_L_E_T_ = ' ' "
                    cQuery +=    " AND BA1_OPEDES    <> '0001' "
                    cQuery +=    " AND BA1_OPEORI     = '0001' "
                    cQuery +=    " AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC = '" + (cAliasTmp)->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC ) + "' "
                    cQuery +=    " AND BA1_OPEDES    <> '0001' "
                    cQuery +=    " AND BA1_OPEDES     = BA0_CODIDE || BA0_CODINT "
                    // ------------------------------------
                    if select( ('TMP') ) <> 0
                        ('TMP')->( dbclosearea() )
                    endif
                    tcquery cQuery Alias 'TMP' New

                    dbselectarea('TMP')
                    TMP->( dbgotop() )
                    do while !TMP->( eof() )
                        aadd( aLog , TMP->USUARIO + ' '  + TMP->RECIPRO )
                        TMP->( dbskip() )
                    enddo
                    aadd( aLog , ' ' )
                    // ------------------------------------

                    nTot += 1
                    nTotSld := nTotSld + (cAliasTmp)->SALDO

                    pl260bloco( 'BA1' , (cAliasTmp)->NRECNO , 4 , .T. , cMotBlo , dDtBloq , BG1->BG1_BLOFAT ) // ??

                Else
                    MsgAlert("Matrícula: "+(cAliasTmp)->BA3_MATRIC+ " não bloqueada!"+ CRLF+ "Necessário aprovação do gestor financeiro para prosseguir com o bloqueio deste cliente. " , "Bloqueio Não Executado!")
                                    
                EndIf    

            endif

        endif

        dbselectarea( cAliasTmp )
        dbskip()

    enddo

    aadd( aLog , ' ' )
    aadd( aLog , 'Total de Contratos ' + str( nTot ) + ;
	            ' Total Saldo Devido ' + transform( nTotSld , '@E 999,999,999.99' ) )
    aadd( aLog , ' ' )

    wnrel := setprint( cString , wnrel , '' , @cTitulo , cDesc1 , cDesc2 , cDesc3 , .F. , {} , .F. , 'G' , .F. )

    if ( nLastKey <> 27 )
        setdefault( areturn , cString )
    endif

    rptstatus( { |lEnd| implog( @lEnd , wnRel , cString , nomeprog , Titulo , aLog ) } , Titulo )

    if findfunction( 'U_PL770REL' )
        u_pl770rel( aLog )
    endif

    apmsginfo( ' Fim do Processamento !!! ' )

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : ImpLog()                                                     |
// +--------------------------------------------------------------------------+
// | Desc.     : Funcao que ira imprimir o arquivo de LOG.                    |
// +--------------------------------------------------------------------------+

static function ImpLog( lEnd , wnrel , cString , nomeprog , Titulo , aLog )

// ------------------------------------
// [ Variaveis utilizadas para Impressao Do Cabecalho e Rodape ]
// ------------------------------------
    local nLi     := 0                                            // Linha a ser impressa
    local nMax    := 58                                           // Maximo de linhas suportada pelo relatorio
    local cbCont  := 0                                            // Numero de Registros Processados
    local cbText  := space(10)                                    // Mensagem do Rodape
    local cCabec1 := 'Relatório de bloqueio de família e usuário' // Label dos itens
    local cCabec2 := ''                                           // Label dos itens
    local Tamanho := 'P'                                          // P/M/G
// ------------------------------------
//  [ Declaracao de variaveis especificas para este relatorio ]
// ------------------------------------
    local nI      := 0                                            // Controle de laco
// ------------------------------------

    setregua( len( aLog ) )

    for nI := 1 to len( aLog )

        incregua()

        if lEnd
            @ prow()+1 , 000 psay 'CANCELADO PELO OPERADOR...'
            exit
        endif

        incline( @nLi , 1 , nMax , titulo , cCabec1 , cCabec2 , nomeprog , tamanho )
        @ nLi , 000 psay aLog[nI]

    next nI

    if nLi == 0
        incline( @nLi , nMax + 1 , nMax , titulo , cCabec1 , cCabec2 , nomeprog , tamanho )
        @ nLi+1 , 000 psay 'Não há informações para imprimir este relatório'
    endif

    roda( cbCont , cbText , Tamanho )

    set device to screen

    if ( areturn[5] = 1 )
        set printer to
        dbcommitall()
        ourspool( wnrel )
    endif

    ms_flush()

return( .T. )

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : IncLine()                                                    |
// +--------------------------------------------------------------------------+
// | Desc.     : Incrementa o contador de linhas p/ impressão nos relatorios  |
// |             e verifica se uma nova pagina sera iniciada.                 |
// +--------------------------------------------------------------------------+
// | Parametros: nLi      - Numero da linha em que sera impresso              |
// |             nInc     - Quantidade de linhas a serem incrementadas        |
// |             nMax     - Numero maximo de linhas por pagina                |
// |             Titulo   - Titulo do cabecalho     do relatorio              |
// |             cCabec1  - Primeira linha do label do relatorio              |
// |             cCabec2  - Segunda  linha do label do relatorio              |
// |             NomeProg - Nome do programa que sera impresso no cabecalho   |
// |             Tamanho  - Tamanho de colunas do relatorio                   |
// +--------------------------------------------------------------------------+

static function IncLine( nLi  , nInc , nMax , Titulo , cCabec1 , cCabec2 , NomeProg , Tamanho )
// ------------------------------------
    local nChrComp := iif( areturn[4] == 1 , 15 , 18 ) // Define se o caracter sera comprimido ou normal
// ------------------------------------
    nLi += nInc
    if nLi > nMax .OR. nLi < 5
        nLi := cabec( titulo , cCabec1 , cCabec2 , nomeprog , tamanho , nChrComp )
        nLi++
    endif
return( .T. )

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : fGreraPlan()                                                 |
// +--------------------------------------------------------------------------+
// | Desc.     : Rotina utilizada para gerar planilha.                        |
// +--------------------------------------------------------------------------+

static function fGreraPlan( a_Campos )

    dlgtoexcel( { { 'ARRAY' , 'Inadimplentes - Emitido em: ' + dtoc( dDataBase ) , a_Cab , a_ItFim } } )

return

// +--------------------------------------------------------------------------+
// | Programa  : caba200.prw                                                  |
// +--------------------------------------------------------------------------+
// | Desc.     : Programa que controla o desligamento por inadimplencia.      |
// +--------------------------------------------------------------------------+
// | Função    : infFina()                                                   |
// +--------------------------------------------------------------------------+
// User Function  InfFina // gus
//<<<<<<< .mine
User function infFina // gus

// ------------------------------------
    local   nDias      := 0
    local   aItems     := { '3' , '30' , '45' , '60' }
    local   lOk        := .T.
// ------------------------------------
    private dReferenci := date()
    private cCombo
// ------------------------------------

    setprvt( 'oDlg1' , 'oGrp1' , 'oSay1' , 'oSay2' , 'oGet1' , 'oCBox1' , 'oSBtn1' , 'oSBtn2' )

    do while lOk

        DEFINE DIALOG oDlg1 TITLE 'Informações Financeiro' FROM 00,00 TO 180,350 PIXEL Style DS_MODALFRAME

//      oDlg1:lEscClose := .F.

        oGrp1   := TGroup():New( 004 , 008 , 060 , 168 , 'Referência Financeiro' , oDlg1 , CLR_BLACK , CLR_WHITE , .T. , .F. )

        oSay1   := TSay():New( 020 , 016 , { || 'Data Referência Financeiro' } , oGrp1 ,,, .F. , .F. , .F. , .T. , CLR_BLACK , CLR_WHITE , 068 , 008 )
        oSay2   := TSay():New( 040 , 016 , { || 'Dias'                       } , oGrp1 ,,, .F. , .F. , .F. , .T. , CLR_BLACK , CLR_WHITE , 016 , 008 )

        bSetGet := {|u| if( pcount()>0 , dReferenci:=u , dReferenci ) }
        oGet1   := TGet():New( 020 , 088 , bSetGet , oGrp1 , 060 , 008 , '' ,, CLR_BLACK , CLR_WHITE ,,,, .T. , '' ,,, .F. , .F. ,, .F. , .F. , '' , 'dReferenci' ,, )

        oCBox1  := TComboBox():New( 040 , 032 , {|u| if( pcount()>0 , cCombo:=u , cCombo ) } , aItems , 072 , 010 , oGrp1 ,,,, CLR_BLACK , CLR_WHITE , .T. ,, '' ,,,,,,, cCombo )

        oSBtn1  := SButton():New( 068 , 112 , 1 , { || lOk := .T. , oDlg1:End() } , oDlg1 ,, '' , )
        oSBtn2  := SButton():New( 068 , 142 , 2 , { || lOk := .F. , oDlg1:End() } , oDlg1 ,, '' , )

        ACTIVATE DIALOG oDlg1 CENTERED

        if !lOk
            exit
        else
            if dReferenci < date()
                msgstop( 'Data de referência [ ' + dtoc( dReferenci ) + ' ] não pode ser menor que a data atual [ ' + dtoc( date()) + ' ]' , alltrim( SM0->M0_NOMECOM ) )
            else
                exit
            endif
        endif

    enddo

    if lOk
        nDias := val( cCombo )
    endif

return { lOk , nDias , dReferenci }

// --------------------------------------------------------------------------------------
// [ fim de caba200.prw ]
// --------------------------------------------------------------------------------------
