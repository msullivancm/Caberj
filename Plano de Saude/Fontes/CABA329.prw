#INCLUDE  'PLSMGER.CH'
#INCLUDE 'TCBROWSE.CH'
#INCLUDE  'TOPCONN.CH'

#DEFINE CRLF CHR(13)+CHR(10)

// +--------------------------------------------------------------------------+
// | Programa  : cabx329.prw      | Raquel                        | 24/04/07  |
// +--------------------------------------------------------------------------+
// | Desc.     : Separa bloqueio financeiro.                                  |
// +--------------------------------------------------------------------------+
// |             ADAPTAÇÃO DO BLOQFAMLIM, POIS ELE É USADO NA ROTINA          |
// |             DE DATA LIMITE E FORAM FEITAS ALTERAÇÕES QUE PREJUDICARAM    |
// |             O BLOQUEIO POR INADIMPLENCIA.                                |
// +--------------------------------------------------------------------------+

user function caba329()

// ------------------------------------
//  [ Define variaveis dos parametros ]
// ------------------------------------
    private nTipo    := 0
    private cIntDe   := ''              // cMV_PAR02
    private cIntAte  := ''              // cMV_PAR03
    private cGruDe   := ''              // cMV_PAR04
    private cGruAte  := ''              // cMV_PAR05
    private cMatrDe  := ''              // cMV_PAR06
    private cMatrAte := ''              // cMV_PAR07
    private dRefFin  := ctod(space(10)) // cMV_PAR08
    private cMotFin  := ''              // cMV_PAR09
    private nDias    := 0               // iif( valtype( cMV_PAR10 ) == 'C' , val( cMV_PAR10 ) , cMV_PAR10 )
// ------------------------------------
    private nBloFin  := 1
    private cA770ret := ''
    private lAmbos   := .T.
    private aUsrBlo  := {}
    private aBlqFin  := {}
// ------------------------------------
    private cQryOld  := ''
    private aRetOld  := {}
// ------------------------------------
//  [ perguntas ]
// ------------------------------------
    if pergunte( 'CABX329' , .T. )
// ------------------------------------
//      [ Parametros cadastrais. ]
// ------------------------------------
        nTipo    := MV_PAR01
        cIntDe   := MV_PAR02
        cIntAte  := MV_PAR03
        cGruDe   := MV_PAR04
        cGruAte  := MV_PAR05
        cMatrDe  := MV_PAR06
        cMatrAte := MV_PAR07
// ------------------------------------
//      [ Relativos ao financeiro ]
// ------------------------------------
        dRefFin  := MV_PAR08
        cMotFin  := MV_PAR09
        nDias    := MV_PAR10 // iif( valtype( MV_PAR10 ) == 'C' , val( MV_PAR10 ) , MV_PAR10 )
// ------------------------------------
//      [ Limite de permanencia no plano apos demissao ou aposentadoria. ]
// ------------------------------------
        nBloLim  := 0
        cMotLim  := ' '
// ------------------------------------
//      [ Relativos a maioridade. ]
// ------------------------------------
        nBloMai  := 0
        cMotMai  := ' '
        cGrauPa  := ' '
        nIdaMai  := ' '
        nIdaUni  := ' '
        dDatDe   := ' '
        dDatAte  := ' '
// ------------------------------------
//      Angelo Henrique - data:08/07/2016
// ------------------------------------
//      Chamado: 12642 - Colocando os dias para efetuar a marcação
// ------------------------------------
            if nDias == 1
            nDias := 30
        elseif nDias == 2
            nDias := 45
        elseif nDias == 3
            nDias := 60
        endif

// ------------------------------------	
//      [ Leonardo Portella - 01/08/16 - Início - Solicitado por Alan e Esther ]
// ------------------------------------
        if alltrim( upper( _cEmp )) == 'PREFEITURA'
// ------------------------------------
//          Bloqueio Prefeitura ou transferência antes da migração
// ------------------------------------
            aRef := u_inffina()

            if !aRef[1]
                return
            else
                nDias   := aRef[2]
                dRefFin := aRef[3]
            endif

        endif

// ------------------------------------
//      [ Leonardo Portella - 01/08/16 - Fim - Solicitado por Alan e Esther ]
// ------------------------------------

// ------------------------------------
//      [ Executa funcao que ira bloquear os contratos ]
// ------------------------------------
        processa( {|| a770blo( nTipo     , ;
                               cIntDe    , ;
	                           cIntAte   , ;
						       cGruDe    , ;
						       cGruAte   , ;
						       cMatrDe   , ;
						       cMatrAte  , ;
						       dDataBase , ;
						       'CABX329' , ;  // 'BLOFIN'  , ;
						                 , ;
                               dRefFin   , ;
						       nDias     ) } , 'Processando...' )

// ------------------------------------
    endif

return( .T. )
// ------------------------------------
// [ FIM BLOQUEIO FINANCEIRO ]
// ------------------------------------

// +--------------------------------------------------------------------------+
// | Programa  : cabx329.prw  | Tulio Cesar                      | 14/09/2000 |
// +--------------------------------------------------------------------------+
// | Função    : a770blo()                                                    |
// +--------------------------------------------------------------------------+
// | Desc.     : Bloqueia familias automaticamente de acordo com regras.      |
// +--------------------------------------------------------------------------+

static function a770blo( nTipo     , ;
                         cIntDe    , ;
                         cIntAte   , ;
						 cGruDe    , ;
						 cGruAte   , ;
						 cMatrDe   , ;
						 cMatrAte  , ;
						 dDatBlo   , ;
						 cPergunta , ;
						 dBloIni   , ;
						 dBloFin   , ;
						 nDias       )
	
// ------------------------------------
//  [ Define variaveis ]
// ------------------------------------
//  local   cInd      := criarrab( NIL , .F. ) // gus never used
//  local   cOrdem    := ''                    // gus never used
//  local   cFor      := ''                    // gus never used
//  local   nQtdMes   := 0                     // gus never used
    local   lBloqFam  := .F.
    local   nRecBA3   := BA3->( recno() )
    local   nRecBA1   := BA1->( recno() )
    local   cTitular  := supergetmv( 'MV_PLCDTIT' )
//  local   nIdade    := 0                     // gus never used
    local   aDadUsr   := {}
    local   aPosFin   := {}
    local   __cNivBlq := '0'
    local   cMotBlo   := ''
    local   aRet      := {}
    local   aLog      := {}
    local   aAreaSA1  := SA1->( getarea() )
//  local   aAreaSE1  := SE1->( getarea() )    // gus never used
//  local   dDataBloq := ''                    // gus never used
    local   cAcao     := 'FAMILIA BLOQUEADA!'
// ------------------------------------
//  [ Definicao de variaveis utilizadas no relatorio de emissao do LOG ]
// ------------------------------------
    local   wnrel     := 'PLSA770'             // Nome do Arquivo utilizado no Spool
    local   Titulo    := 'Relatorio de análise de bloqueio de Família/Usuário'
    local   cDesc1    := 'Este programa irá emitir uma relação famílias e usuários encontradas'
    local   cDesc2    := 'no arquivo que atendam as regras dos parametros informados e'
    local   cDesc3    := 'serão posteriormente bloqueados.'
    local   nomeprog  := 'PLSA770.PRW'         // nome do programa
    local   cString   := ''                    // Alias utilizado na Filtragem
    local   lDic      := .F.                   // Habilita/Desabilita Dicionario
    local   lComp     := .F.                   // Habilita/Desabilita o Formato Comprimido/Expandido
    local   lFiltro   := .F.                   // Habilita/Desabilita o Filtro
// ------------------------------------
    local   nQtd      := 0
    local   cAlias    := getnextalias()
// ------------------------------------
    private Tamanho   := 'P'                   // P/M/G
    private Limite    := 80                    // 80/132/220
    private aReturn   := { 'Zebrado'       , ; // [1] Reservado para Formulario
                           1               , ; // [2] Reservado para N§ de Vias
                           'Administração' , ; // [3] Destinatario
                           2               , ; // [4] Formato => 1-Comprimido 2-Normal
                           2               , ; // [5] Midia   => 1-Disco 2-Impressora
                           1               , ; // [6] Porta ou Arquivo 1-LPT1... 4-COM1...
                           ''              , ; // [7] Expressao do Filtro
                           1                 } // [8] Ordem a ser selecionada
                                               // [9]..[10]..[n] Campos a Processar (se houver)
// ------------------------------------	
    private m_pag     := 1                     // Contador de Paginas
    private nLastKey  := 0                     // Controla o cancelamento da SetPrint e SetDefault
    private cPerg     := cPergunta             // Pergunta do Relatorio
    private aOrdem    := {}                    // Ordem do Relatorio
    private nQtdLin   := 0                     // Qtd de bloqueados
// ------------------------------------	
//	default dBloIni   := stod( '' )
// ------------------------------------
	
// ------------------------------------
//  [ Define ordem default no arquivo de contas a receber ]
// ------------------------------------
    SE1->( dbsetorder( getmv( 'MV_PLORDE1' )))
    BA1->( dbsetorder( 2 ) )
    SA1->( dbsetorder( 1 ) )

// -[ gus - ini ]----------------------------------------------------
    cQuery := " SELECT COUNT(*) TOT "                                     + CRLF
    cQuery += "   FROM "                     + retsqlname( 'BA3 ') + "  " + CRLF
    cQuery += "  WHERE BA3_FILIAL = '"       +    xfilial( 'BA3' ) + "' " + CRLF
    cQuery += "    AND BA3_CODINT BETWEEN '" + cIntDe              + "' " + CRLF
    cQuery += "                       AND '" + cIntAte             + "' " + CRLF
    cQuery += "    AND BA3_CODEMP BETWEEN '" + cGruDe              + "' " + CRLF
    cQuery += "                       AND '" + cGruAte             + "' " + CRLF
    cQuery += "    AND BA3_MATRIC BETWEEN '" + cMatrDe             + "' " + CRLF
    cQuery += "                       AND '" + cMatrAte            + "' " + CRLF
    cQuery += "    AND ( BA3_MOTBLO     = ' ' "                           + CRLF
    cQuery += "     OR   BA3_DATBLO     > '" + dtos( dRefFin ) + "' ) "   + CRLF
// ------------------------------------
        if nTipo == 1 // Empresarial PF
        cQuery += "    AND BA3_COBNIV  = '1' " + CRLF
        cQuery += "    AND BA3_CODCLI <> ' ' " + CRLF
    elseif nTipo == 2 // Empresarial PJ
        cQuery += "    AND BA3_COBNIV  = '0' " + CRLF
        cQuery += "    AND BA3_CODCLI  = ' ' " + CRLF
    endif
// ------------------------------------
    cQuery += "    AND BA3_CODEMP  NOT IN ('0004','0009') " + CRLF
    cQuery += "    AND ( BA3_YSITBQ     = ' ' OR "          + CRLF
    cQuery += "          BA3_YSITBQ     = '1' OR "          + CRLF
    cQuery += "          BA3_YSITBQ     = '6' )  "          + CRLF
    cQuery += "    AND D_E_L_E_T_      <> '*' "             + CRLF
// ------------------------------------
//  memowrit( 'c:\TEMP\Cabx329_0.TXT' , cQuery )
// ------------------------------------
//  cAlias := getnextalias()
    if tccanopen( cAlias )
        tcdelfile( cAlias )
    endif
    if select( ( cAlias ) ) <> 0
        ( cAlias )->( dbclosearea() )
    endif
    tcquery cQuery New Alias cAlias
// ------------------------------------
    nQtd := cAlias->( TOT )
    if nQtd == 0
        aviso( 'Atenção' , 'Nenhum registro encontrado para os parâmetros informados!' , { 'OK' } )
        cAlias->( dbclosearea() )
        return( .F. )
    endif
    cAlias->( dbclosearea() )
// -[ gus - fim ]----------------------------------------------------

// ------------------------------------
//  [ Leonardo Portella - 22/03/13      ]
//  [ Inicio - Melhoria de performance. ]
//  [ Ao inves de varrer toda a BA3, seleciono os R_e_c_n_o_ via SQL e ponteiro nela. ]
// ------------------------------------
    cQuery := " SELECT R_E_C_N_O_ , "                                     + CRLF
    cQuery += "        BA3_CODINT , "                                     + CRLF
    cQuery += "        BA3_CONEMP , "                                     + CRLF
    cQuery += "        BA3_SUBCON , "                                     + CRLF
    cQuery += "        BA3_CODEMP , "                                     + CRLF
    cQuery += "        BA3_MATRIC , "                                     + CRLF
    cQuery += "        BA3_MOTBLO , "                                     + CRLF
    cQuery += "        BA3_DATBLO , "                                     + CRLF
    cQuery += "        BA3_YSITBQ , "                                     + CRLF
    cQuery += "        BA3_COBNIV , "                                     + CRLF
    cQuery += "        BA3_CODCLI   "                                     + CRLF
    cQuery += "   FROM "                     + retsqlname( 'BA3 ') + "  " + CRLF
    cQuery += "  WHERE BA3_FILIAL = '"       +    xfilial( 'BA3' ) + "' " + CRLF
    cQuery += "    AND BA3_CODINT BETWEEN '" + cIntDe              + "' " + CRLF
    cQuery += "                       AND '" + cIntAte             + "' " + CRLF
    cQuery += "    AND BA3_CODEMP BETWEEN '" + cGruDe              + "' " + CRLF
    cQuery += "                       AND '" + cGruAte             + "' " + CRLF
    cQuery += "    AND BA3_MATRIC BETWEEN '" + cMatrDe             + "' " + CRLF
    cQuery += "                       AND '" + cMatrAte            + "' " + CRLF
// ---------------------------------------------------------------------------------
// -[ Gestao Inadimplencia - Ini Gus ]----------------------------------------------
// -[ Selecionar bloqueio futuro     ]----------------------------------------------
// ---------------------------------------------------------------------------------
//  cQuery += "    AND BA3_MOTBLO       = ' ' "                           + CRLF
// ---------------------------------------------------------------------------------
    cQuery += "    AND ( BA3_MOTBLO     = ' ' "                           + CRLF
    cQuery += "     OR   BA3_DATBLO     > '" + dtos( dRefFin ) + "' ) "   + CRLF
// -[ Gestao Inadimplencia - Fim Gus ]----------------------------------------------
// *[ gus - confirmar com carlos criterio para PF e PJ ]****************************
// ------------------------------------
        if nTipo == 1 // Empresarial PF
        cQuery += "    AND BA3_COBNIV  = '1' " + CRLF
        cQuery += "    AND BA3_CODCLI <> ' ' " + CRLF
    elseif nTipo == 2 // Empresarial PJ
        cQuery += "    AND BA3_COBNIV  = '0' " + CRLF
        cQuery += "    AND BA3_CODCLI  = ' ' " + CRLF
    endif
// ------------------------------------
    cQuery += "    AND BA3_CODEMP  NOT IN ('0004','0009') "               + CRLF
    cQuery += "    AND ( BA3_YSITBQ     = ' ' OR "                        + CRLF
    cQuery += "          BA3_YSITBQ     = '1' OR "                        + CRLF
    cQuery += "          BA3_YSITBQ     = '6' )  "                        + CRLF
    cQuery += "    AND D_E_L_E_T_       = ' ' "                           + CRLF
    cQuery += "    ORDER BY 2 , 3 , 4 , 5 , 6 "                           + CRLF
// ------------------------------------
//  memowrit( 'c:\TEMP\Cabx329_1.TXT' , cQuery )
// ------------------------------------
//  cAlias := getnextalias()
    if tccanopen( cAlias )
        tcdelfile( cAlias )
    endif
    if select( cAlias ) <> 0
        ( cAlias )->( dbclosearea() )
    endif
    tcquery cQuery New Alias cAlias
// ------------------------------------
    if cAlias->( eof() )
//      help( '' , 1 , 'RECNO' )
        aviso( 'Atenção' , 'Nenhum registro encontrado para os parâmetros informados!' , { 'OK' } )
        cAlias->( dbclosearea() )
        return( .F. )
    endif
// ------------------------------------	
//    cAlias->( dbeval( {|| nQtd += 1 } ) )
//    cAlias->( dbgotop() )
    procregua( nQtd )
// ------------------------------------
//  [ Inicia a verificacao das familias selecionadas ]
// ------------------------------------
    do while !cAlias->( eof() )

        BA3->( dbgotop() )
        BA3->( dbgoto( cAlias->( R_E_C_N_O_ ) ) )

        IncProc( 'Analisando familia - ' + ;
		         transform( (BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC) , __cPictFam ) )

        cAcao := 'FAMILIA BLOQUEADA!'
		
// ------------------------------------
//      [ Posiciona o grupo empresa. ]
// ------------------------------------
//      BG9->( dbsetorder( 1 ) ) // BG9_FILIAL + BG9_CODINT + BG9_CODIGO + BG9_TIPO
//      BG9->( dbseek(        xfilial( 'BG9' ) + BA3->BA3_CODEMP )) // errado! codint + codigo
// ------------------------------------
        BG9->( dbsetorder( 1 ) ) // BG9_FILIAL +      BG9_CODINT +      BG9_CODIGO + BG9_TIPO
        BG9->( dbseek(        xfilial( 'BG9' ) + BA3->BA3_CODINT + BA3->BA3_CODEMP ))
// ------------------------------------
//      [ Posiciono o contrato. ]
// ------------------------------------
        if !empty( BA3->BA3_CONEMP )
            BT5->( dbsetorder( 1 ) ) // BT5_FILIAL + BT5_CODINT + BT5_CODIGO + BT5_NUMCON + BT5_VERSAO
            BT5->( dbseek( xfilial( 'BT5' ) + ;
			               BA3->BA3_CODINT  + ;
						   BA3->BA3_CODEMP  + ;
						   BA3->BA3_CONEMP  + ;
						   BA3->BA3_VERCON  ) )
        endif

// ------------------------------------
//      [ Posiciono o sub contrato. ]
// ------------------------------------
        if !empty( BA3->BA3_SUBCON )
            BQC->( dbsetorder( 1 ) ) // BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
            BQC->( dbseek( xfilial( 'BT5' ) + ;
			               BA3->BA3_CODINT  + ;
						   BA3->BA3_CODEMP  + ;
						   BA3->BA3_CONEMP  + ;
						   BA3->BA3_VERCON  + ;
						   BA3->BA3_SUBCON  + ;
						   BA3->BA3_VERSUB  ) )
        endif

// ------------------------------------

        if nBloLim == 1
// ------------------------------------
//          [ Posiciona o titular da familia. ]
// ------------------------------------
            BA1->( dbgotop() )      // Usuarios
            BA1->( dbsetorder( 1 )) // BA1_FILIAL +        BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPUSU + BA1_TIPREG + BA1_DIGITO
            BA1->( dbseek(       xfilial( 'BA1' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )))

            if BA1->( fieldpos( 'BA1_YDTLIM' ) ) > 0

// ------------------------------------
//              [ Verifica se houve desligamento do titular por demissao ou aposentadoria ]
// ------------------------------------
                if !empty( BA1->BA1_YDTLIM )

                    if ( dtos( BA1->BA1_YDTLIM ) >= dtos( dDatDe  ) .AND.;
                         dtos( BA1->BA1_YDTLIM ) <= dtos( dDatAte ) )
                        lBloqFam  := .T.
                        __cNivBlq := '1'
                    endif

                endif

            endif

        endif
// ------------------------------------
        if cAlias->( R_E_C_N_O_ ) == 20847
            _a := 'entrou'
        endif
// ------------------------------------

// ------------------------------------
//      [ Valida situacao financeira. ]
// ------------------------------------
        if nBloFin == 1 .AND. !lBloqFam

// ------------------------------------
//          [ Posiciona o titular da familia. ]
// ------------------------------------
            BA1->( dbgotop() )      // Usuarios
            BA1->( dbsetorder( 1 )) // BA1_FILIAL +       BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPUSU + BA1_TIPREG + BA1_DIGITO
            x := BA1->( dbseek(  xfilial( 'BA1' ) + BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC )))

//// ---------------------------------------------------------------------------------
//// ---------[ Gestao Inadimplencia - Ini Gus ]--------------------------------------
//// ---------------------------------------------------------------------------------
//            if x
//                cMatric  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC )
//                aCliente := plsretncb( BA1->BA1_CODINT , BA1->BA1_CODEMP , BA1->BA1_MATRIC , NIL )
//                nDiasDB  := plsdiain( aCliente[5] , cMatric )
//            endif
//// ---------------------------------------------------------------------------------
//// ---------[ Gestao Inadimplencia - Fim Gus ]--------------------------------------
//// ---------------------------------------------------------------------------------

// ------------------------------------
//          [ Monta matriz padrao com os dados do usuario. ]
// ------------------------------------
            aRet := plsdadusr( BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) , ;
			                   '1'                                                                     , ;
							   .F.                                                                     , ;
							   dDataBase                                                               , ;
							   NIL                                                                     , ;
							   NIL                                                                     , ;
							   NIL                                                                       )

            if aRet[1]
                aDadUsr := plsgetusr()
            else
                cAlias->( dbskip() )
                lBloqFam := .F.
                loop
            endif

// ------------------------------------
//          [ Avalia a posicao financeira da familia usando funcao generica. ]
// ------------------------------------
//          aPosFin := plsvldfin( BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) , dRefFin , '' , '' , '1' , aDadUsr )
// ------------------------------------
//          aPosFin := vertitab( BA1->BA1_CODEMP , BA1->BA1_MATRIC , dRefFin , nDias ) // gus
            aPosFin := vertitab( BA1->BA1_CODEMP , ;
                                 BA1->BA1_MATRIC , ;
                                 dRefFin         , ;
                                 nDias           , ;
                                 BA1->BA1_CODINT , ;
                                 BA1->BA1_CONEMP , ;
                                 BA1->BA1_SUBCON   ) // gus
            if len( aPosFin ) <> 0
                lBloqFam  := .T.
                __cNivBlq := '2'
            endif

        endif
		
// ------------------------------------
//      [ A familia nao foi bloqueada, agora analiza regras individuais ]
//      [ para ver se algum usuario sera bloqueado.                     ]
// ------------------------------------
        if !lBloqFam

// ------------------------------------
//          [ Regra 1 - Data Limite. Caso seja considerado via perguntas. ]
// ------------------------------------
            if nBloLim == 1
				
// ------------------------------------
//              [ Processa todos os usuarios da familia, exceto Titular. ]
// ------------------------------------
                BA1->( dbgotop() )      // Usuarios
                BA1->( dbsetorder( 1 )) // BA1_FILIAL +        BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPUSU + BA1_TIPREG + BA1_DIGITO
                if BA1->( msseek(    xfilial( 'BA1' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )))

                    do while BA1->( !eof() )                     .AND. ;
                             BA1->BA1_FILIAL == xfilial( 'BA1' ) .AND. ;
                             BA1->BA1_CODINT == BA3->BA3_CODINT	 .AND. ;
                             BA1->BA1_CODEMP == BA3->BA3_CODEMP	 .AND. ;
                             BA1->BA1_MATRIC == BA3->BA3_MATRIC

// ------------------------------------
//                      [ Caso seja um dependente selecionado. ]
// ------------------------------------					
                        if !empty( BA1->BA1_YDTLIM )           .AND. ;
						           BA1->BA1_TIPUSU  # cTitular .AND. ;
                                 ( BA1->BA1_MOTBLO  = ' '      .AND. ;
								 ( BA1->BA1_MOTBLO  = '028'    .OR.  ;
								   BA1->BA1_DATBLO >= dBloFin  .OR.  ;
							empty( BA1->BA1_DATBLO ) ) )

// ------------------------------------
// [ BIANCHINI - 13/06/2013 - Nao tratava os associados que deveriam ser bloqueados que estivessem ativos
// [ (BA1->BA1_MOTBLO = ' ' .AND. (BA1->BA1_MOTBLO = '028' .OR. BA1->BA1_DATBLO >= dBloFin ) )
// ------------------------------------
                            if ( dtos( BA1->BA1_YDTLIM ) >= dtos( dDatDe  ) .AND. ;
                                 dtos( BA1->BA1_YDTLIM ) <= dtos( dDatAte ))

                                __cNivBlq     := '1'
                                dDataBloqueio := dDatblo

                                if empty( dDataBloqueio )
                                    dDataBloqueio := BA1->BA1_YDTLIM
                                endif
// ------------------------------------
//                              [ Analisa e nao bloqueia ]
// ------------------------------------
                                if cMotFin == 1
                                    aadd( aLog , " -----------> BLOQUEIO POR DATA LIMITE" )
                                    aadd( aLog , " Matricula--> " + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) )
                                    aadd( aLog , " Nome-------> " + BA1->BA1_NOMUSR  )
                                    aadd( aLog , " Cd.Cliente-> " + BA3->BA3_CODCLI  )
                                    aadd( aLog , " Motivo-----> " + cMotLim          )
                                    aadd( aLog , " Nascimento-> " + dtoc( BA1->BA1_DATNAS ) )
                                    aadd( aLog , " Bloqueio---> " + dtoc( dDataBloqueio   ) )
                                    aadd( aLog , " Idade Hoje-> " + alltrim( strzero((( dDataBase     - BA1->BA1_DATNAS) / 365.25 ) , 3 )))
                                    aadd( aLog , " Idade Bloq-> " + alltrim( strzero((( dDataBloqueio - BA1->BA1_DATNAS) / 365.25 ) , 3 )))
                                    aadd( aLog , " " )
                                    nQtdLin := nQtdLin + 1
                                endif
// ------------------------------------
//                              [ Efetua o bloqueio ]
// ------------------------------------
                                if cMotFin == 2

                                    if alltrim( cPerg ) == 'BLOLIM' .OR. ;
									   alltrim( cPerg ) == 'PLA770'
                                        pl260blous( 'BA1'            , ;
										            BA1->( recno() ) , ;
													4                , ;
													.T.              , ;
													cMotLim          , ;
													dDataBloqueio    , ;
													BG1->BG1_BLOFAT    )
                                    else
                                        reclock( 'BA3' , .F. )
                                            BA3->BA3_YSITBQ := '1' // MARCADO PARA BLOQUEIO
                                            cMatMarq        := (BA3->BA3_CODEMP + BA3->BA3_MATRIC + ';' )
                                        BA3->( msunlock() )
                                    endif

                                    aadd( aUsrBlo , { BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) , ;
									                  substr( BA1->BA1_NOMUSR , 1 , 30 )                                     , ;
													  cMotLim                                                                , ;
													  dtoc( dDataBloqueio )                                                  } )
                                    nQtdLin := nQtdLin + 1

                                endif
// ------------------------------------
                                if cMotFin == 3
                                    aadd( aLog , { 'BA1' , BA1->( recno() ) } )
                                endif

                                dDataBloqueio := ctod( '//' )

                            endif

                        endif

                        BA1->( dbskip() )

                    enddo

                endif

            endif

// ------------------------------------
//      [ Testa se a familia deve ser marcada para bloqueio ]
// ------------------------------------
        else

// ------------------------------------
//      [ Verifica origem do bloqueio e posiciona o cadastro. ]
// ------------------------------------
                if __cNivBlq == '1'
                cMotBlo := cMotLim
            elseif __cNivBlq == '2'
                cMotBlo := ''  // cMotFin
            endif
            BG1->( dbsetorder( 1 ))
            BG1->( dbseek( xfilial( 'BG1' ) + cMotBlo ))

// ------------------------------------
//          [ Posiciona o titular da familia. ]
// ------------------------------------
            BA1->( dbseek( xfilial( 'BA1' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )))

// ------------------------------------
//          [ Para cada familia lida verifico bloqueio. ]
// ------------------------------------
            dDataBloqueio := dDatBlo
            if empty( dDataBloqueio )

                if __cNivBlq == '2'
                    dDataBloqueio := dDataBase // Finaneiro
                endif
                if __cNivBlq == '1'
                    dDataBloqueio := BA1->BA1_YDTLIM
                endif

// ------------------------------------
//              [ Analisa e nao bloqueia ]
// ------------------------------------
                if cMotFin == 1

                        if __cNivBlq == '1'
                        aadd( aLog , ' -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE'       )
                    elseif __cNivBlq == '2'
                        aadd( aLog , ' -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO' )
                    endif
                    aadd( aLog , ' Matricula--> ' + BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) + ' ' + ' Cd.Cliente-> ' + BA3->BA3_CODCLI )
                    aadd( aLog , ' Nome-------> ' + BA1->BA1_NOMUSR   + ' ' + ' Idade Hoje-> '  + alltrim( strzero((( dDataBase - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
// ------------------------------------
//                  aadd( aLog , ' Cd.Cliente-> ' + BA3->BA3_CODCLI )
//                  aadd( aLog , ' Motivo-----> ' + cMotBlo         )
//                  aadd( aLog , ' Nascimento-> ' + dtoc( BA1->BA1_DATNAS ))
//                  aadd( aLog , ' Bloqueio---> ' + dtoc( dDataBloqueio   ))
//                  aadd( aLog , ' Idade Hoje-> ' + alltrim( strzero((( dDataBase     - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
//                  aadd( aLog , ' Idade Bloq-> ' + alltrim( strzero((( dDataBloqueio - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
// ------------------------------------

                    if __cNivBlq == '2'
                        aadd( aLog , ' Prc aberto-> ' + '???' + ' ' + ' Vlr aberto-> ' + transform( aPosFin[3] , '999,999.99' ) + ;
						                                        ' ' + ' Dia aberto-> ' + transform( aPosFin[4] , '999,999.99' ) )
// ------------------------------------
//                      aadd( aLog , ' Prc aberto-> ' + aPosFin[2,2,3] + ' ' + ' Vlr aberto-> ' + aPosFin[2,4,3] + ' ' + ' Dia aberto-> ' + aPosFin[2,3,3] )
//                      aadd( aLog , ' Prc aberto-> ' + aPosFin[2,2,3] + ' ' + ' Vlr aberto-> ' + aPosFin[2,4,3] + ' ' + ' Dia aberto-> ' + aPosFin[2,3,3] )
//                      aadd( aLog , ' Vlr aberto-> ' + aPosFin[2,4,3] )
//                      aadd( aLog , ' Dia aberto-> ' + aPosFin[2,3,3] )
// ------------------------------------
                    endif

                    aadd( aLog , ' ' )
                    nQtdLin := nQtdLin + 1

                endif

// ------------------------------------
//              [ Efetua o bloqueio ]
// ------------------------------------
                if cMotFin == 2

// ------------------------------------				
//                  [ Trecho de codigo modificado em 02/12/2009 por Luzio.                         ]
//                  [ Esta condicao foi criada para que execute o bloqueio efetivo do beneficiario ]
//                  [ no caso de data limite. Atender a INTEGRAL                                   ]
// ------------------------------------
                    if alltrim( cPerg ) == 'BLOLIM' .OR. ;
					   alltrim( cPerg ) == 'PLA770'

// ------------------------------------
//                      [ Leonardo Portella - 22/03/13 ]
// ------------------------------------
//                      pl260bloco( 'BA3' , BA3->( recNo() ) , 4 , .T. , cMotBlo , dDataBloqueio , BG1->BG1_BLOFAT )
// ------------------------------------
                        bloqfamusr( 'BA3'             , ;
						             BA3->( recno() ) , ;
									 4                , ;
									 .T.              , ;
									 cMotBlo          , ;
									 dDataBloqueio    , ;
									 BG1->BG1_BLOFAT    )
                    else

                        reclock( 'BA3' , .F. )
                            BA3->BA3_YSITBQ := '1' // MARCADO PARA BLOQUEIO
                            cMatMarq        := ( BA3->BA3_CODEMP + BA3->BA3_MATRIC + ';' )
                        BA3->( msunlock() )
                        cAcao := 'FAMILIA MARCADA!'

                    endif

                    aadd( aUsrBlo , { BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC ) , ;
					                  cAcao                                         , ;
									  cMotBlo                                       , ;
									  dtoc( dDataBloqueio )                         } )
                    nQtdLin := nQtdLin + 1

                    if len( aPosFin ) > 0
                        alimcarta( BA3->BA3_CODCLI , BA3->BA3_LOJA , @aBlqFin , aPosFin,BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) )
                    endif

                endif

                if cMotFin == 3
                    aadd( aLog , { 'BA1' , BA1->( eecno() )})
                endif

                dDataBloqueio := ctod( '//' )

            else

// ------------------------------------
//              [ Analisa e nao bloqueia ]
// ------------------------------------
                if cMotFin == 1

                        if __cNivBlq == '1'
                        aadd( aLog , ' -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE'       )
                    elseif __cNivBlq == '2'
                        aadd( aLog , ' -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO' )
                    endif
                    aadd( aLog , ' Matricula--> ' + BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) + ;
                           ' ' + ' Cd.Cliente-> ' + BA3->BA3_CODCLI  )
                    aadd( aLog , ' Nome-------> ' + BA1->BA1_NOMUSR   + ;
				           ' ' + ' Idade Hoje-> ' + alltrim( strzero((( dDataBase - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
// ------------------------------------
//                  aadd( aLog , ' Cd.Cliente-> ' + BA3->BA3_CODCLI )
//                  aadd( aLog , ' Motivo-----> ' + cMotBlo         )
//                  aadd( aLog , ' Nascimento-> ' + dtoc( BA1->BA1_DATNAS ))
//                  aadd( aLog , ' Bloqueio---> ' + dtoc( dDataBloqueio   ))
//                  aadd( aLog , ' Idade Hoje-> ' + alltrim( strzero((( dDataBase     - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
//                  aadd( aLog , ' Idade Bloq-> ' + alltrim( strzero((( dDataBloqueio - BA1->BA1_DATNAS ) / 365.25 ) , 3 )))
// ------------------------------------

                    if __cNivBlq == '2'

// ------------------------------------
//                  mbc aadd( a_Ret , stod( (c_Alias)->VENCIMENTO ) , ;
//                                          (c_Alias)->QUANTIDADE   , ;
//                                          (c_Alias)->SALDO        , ;
//                                    stod( (c_Alias)->VENCIMENTO ) - Date() )
// ------------------------------------
                        aadd( aLog , ' Prc aberto-> ' + '???' + ' ' + ' Vlr aberto-> ' + transform( aPosFin[3] , '999,999.99' ) + ;
	    			                                            ' ' + ' Dia aberto-> ' + transform( aPosFin[4] , '999,999.99' ))
// ------------------------------------
//                  mbc aadd( aLog , ' Prc aberto-> ' + aPosFin[2,2,3] + ' ' + ;
//                                   ' Vlr aberto-> ' + aPosFin[2,4,3] + ' ' + ;
//                                   ' Dia aberto-> ' + aPosFin[2,3,3] )
//                      aadd( aLog , ' Vlr aberto-> ' + aPosFin[2,4,3] )
//                      aadd( aLog , ' Dia aberto-> ' + aPosFin[2,3,3] )
// ------------------------------------
                    endif

                    aadd( aLog , ' ' )
                    nQtdLin := nQtdLin + 1

                endif

// ------------------------------------
//              [ Efetua o bloqueio ]
// ------------------------------------

                if cMotFin == 2
// ------------------------------------
//                  [ Trecho de codigo modificado em 02/12/2009 por Luzio.                         ]
//                  [ Esta condicao foi criada para que execute o bloqueio efetivo do beneficiario ]
//                  [ no caso de data limite. Atender a INTEGRAL                                   ]
// ------------------------------------
                    if alltrim( cPerg ) == 'BLOLIM' .OR. ;
                       alltrim( cPerg ) == 'PLA770'

                        if cMotBlo == getnewpar( 'MV_YBLQFPR' , '024' )

                            reclock( 'BA3' , .F. )                 // Gedilson
                                BA3->BA3_YTPPAG := BA3->BA3_TIPPAG // Guardo o tipo de pagamento da familia bloqueada.
                                BA3->BA3_TIPPAG := '00'            // Altera tipo de pagto da familia - Sem Envio de cobrança
                            BA3->( msunlock() )                    // Gedilson

                        endif

// ------------------------------------
//                      [ Leonardo Portella - 22/03/13 ]
// ------------------------------------/
//                      pl260bloco( 'BA3' , BA3->( recno() ) , 4 , .T. , cMotBlo , dDataBloqueio , BG1->BG1_BLOFAT )
// ------------------------------------
                        bloqfamusr( 'BA3'             , ;
	    				             BA3->( recno() ) , ;
		    						 4                , ;
			    					 .T.              , ;
				    				 cMotBlo          , ;
					    			 dDataBloqueio    , ;
						    		 BG1->BG1_BLOFAT    )
                    else

                        reclock( 'BA3' , .F. )
                            BA3->BA3_YSITBQ := '1' // MARCADO PARA BLOQUEIO
                            cMatMarq        := ( BA3->BA3_CODEMP + BA3->BA3_MATRIC + ';' )
                        BA3->( msunlock() )

                        cAcao := 'FAMILIA MARCADA!'

                    endif

                    aadd( aUsrBlo , { BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC ) , ;
                                      cAcao                                         , ;
                                      cMotBlo                                       , ;
                                dtoc( dDataBloqueio )                               } )
                    nQtdLin := nQtdLin + 1

                    if len( aPosFin ) > 0
                        alimcarta( BA3->BA3_CODCLI , BA3->BA3_LOJA , @aBlqFin , aPosFin, BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) )
                    endif

                endif

                if cMotFin == 3
                    aadd( aLog , { 'BA1' , BA1->( recno() ) } )
                endif

            endif

        endif

        cAlias->( dbskip() )
//         BA3->( dbskip() )

        lBloqFam := .F.

    enddo

    cAlias->( dbclosearea() )

// ------------------------------------
//  [ Leonardo Portella - 22/03/13 - Fim                      ]
//  [ Melhoria de performance. Ao inves de varrer toda a BA3, ]
//  [ seleciono os R_e_c_n_o_ via SQL e ponteiro nela.        ]
// ------------------------------------

    cMatMarq := ( BA3->BA3_CODEMP + BA3->BA3_MATRIC + ';' )
//  memowrit( '\marcela\BORD.TXT' , cMatMarq )
    
    cMatMarq := ( BA3->BA3_CODEMP + BA3->BA3_MATRIC + ';' )

// ------------------------------------
//  [ Totaliza rel ]
// ------------------------------------
    aadd( aLog , ' ' )
    aadd( aLog , ' ' )
    aadd( aLog , 'Quantidade ===========>      ' + strzero( nQtdLin , 6 ))
    aadd( aLog , ' ' )

// ------------------------------------
//  [ Atualiza dados em disco. ]
// ------------------------------------
    BA3->( dbcommitall() )
    BA3->( dbclearfilter() )
    BA3->( dbgoto( nRecBA3 ) )

    BA1->( dbcommitall() )
    BA1->( dbgoto( nRecBA1 ))

    BE7->( dbcommitall() )

    restarea( aAreaSA1 )

// ------------------------------------
//  [ Atualiza dados em disco. ]
// ------------------------------------
    if len( aUsrBlo ) > 0
        plscrigen( aUsrBlo ,{ { 'Matric. Usuario' , '@C' ,  50 } , ;
		                      { 'Nome do Usuario' , '@C' , 100 } , ;
							  { 'Mot.Bx.'         , '@C' ,  10 } , ;
							  { 'Dat.Bloq.'       , '@C' ,  15 } } , 'Usuários Bloqueados' , .T. )

// ------------------------------------
//  [ Angelo Henrique - Data:08/06/2016 - Chamado: 12642  ]
//  [ Aviso quando nenhuma familia forMarcada / Bloqueada ]
// ------------------------------------
    else
        aviso( 'Atenção' , 'Nenhuma família encontrada para os parâmetros informados!' , { 'OK' } )
    endif

    aUsrBlo := {}

// ------------------------------------
//  [ Apenas avaliacao ]
// ------------------------------------
    if cMotFin == 1
        pergunte( cPerg , .F. )
        wnrel := setprint( cString , ;
		                   wnrel   , ;
						   cPerg   , ;
						   @titulo , ;
						   cDesc1  , ;
						   cDesc2  , ;
						   cDesc3  , ;
						   lDic    , ;
						   aOrdem  , ;
						   lComp   , ;
						   Tamanho , ;
						   lFiltro   )

        if ( nLastKey <> 27 )
            setdefault( aReturn , cString )
        endif

        rptstatus( { |lEnd| ImpLog( @lEnd , wnRel , cString , nomeprog , Titulo , aLog ) } , Titulo )

    endif

// ------------------------------------
//  [ Executa o rdmake de emissao do relatorio especifico ]
// ------------------------------------
    if cMotFin == 3
        if findfunction( 'U_PL770REL' )
            u_pl770rel( aLog )
        endif
    endif

// ------------------------------------
//  [ Emite carta de bloqueio. ]
// ------------------------------------
//  200 if cMotFin == 2  .And. __cNivBlq == '2'
//  200     u_inadimp( aBlqFin )
//  200 endif
// ------------------------------------

return( .T. )

// +--------------------------------------------------------------------------+
// | Função    : ImpLog    | Armando M. Tessaroli                | 10/11/2005 |
// +--------------------------------------------------------------------------+
// | Desc.     : Funcao que ira imprimir o arquivo de LOG.                    |
// +--------------------------------------------------------------------------+

static function implog( lEnd , wnrel , cString , nomeprog , Titulo , aLog )
	
// ------------------------------------
// [ Variaveis utilizadas para Impressao Do Cabecalho e Rodape ]
// ------------------------------------
    local nLi     := 0           // Linha a ser impressa
    local nMax    := 58          // Maximo de linhas suportada pelo relatorio
    local cbCont  := 0           // Numero de Registros Processados
    local cbText  := space( 10 ) // Mensagem do Rodape
    local cCabec1 := ''          // Label dos itens
    local cCabec2 := ''          // Label dos itens
// ------------------------------------	
//  [ Declaracao de variaveis especificas para este relatorio ]
// ------------------------------------
    local nI       := 0          // Controle de laco
// ------------------------------------
    cCabec1 := 'Relatório de análise do bloqueio de família e usuário'

    setregua( len( aLog ))

    for nI := 1 to len( aLog )

        incregua()

        if lEnd
            @ Prow() + 1 , 000 psay 'CANCELADO PELO OPERADOR...'
            exit
        endif

        incline( @nLi , 1 , nMax , titulo , cCabec1 , cCabec2 , nomeprog , tamanho )
        @ nLi , 000 psay aLog[ nI ]

    next nI

    if nLi == 0
        incline( @nLi , nMax + 1 , nMax , titulo , cCabec1 , cCabec2 , nomeprog , tamanho )
        @ nLi + 1 , 000 psay 'Não há informações para imprimir este relatório'
    endif

    roda( cbCont , cbText , Tamanho )

    set device to screen

    if ( aReturn[5] = 1 )
        set printer to
        dbcommitall()
        ourspool( wnrel )
    endif

    ms_flush()
	
return( .T. )

// +--------------------------------------------------------------------------+
// | Função    : IncLine    | Armando M. Tessaroli               | 06/02/2003 |
// +--------------------------------------------------------------------------+
// | Desc.     : Incrementa o contador de linhas para impressão nos           |
// |             relatorios e verifica se uma nova pagina sera iniciada.      |
// +--------------------------------------------------------------------------+
// | Parametros: nLi      - Numero da linha em que sera impresso              |
// |             nInc     - Quantidade de linhas a serem incrementadas        |
// |             nMax     - Numero maximo de linhas por pagina                |
// |             Titulo   - Titulo do cabecalho do relatorio                  |
// |             cCabec1  - Primeira linha do lalbel do relatorio             |
// |             cCabec2  - Segunda linha do label do relatorio               |
// |             NomeProg - Nome do programa que sera impresso no cabecalho   |
// |             Tamanho  - Tamanho de colunas do relatorio                   |
// +--------------------------------------------------------------------------+

static function incline( nLi , nInc , nMax , Titulo , cCabec1 , cCabec2 , NomeProg , Tamanho )

// ------------------------------------
    local nChrComp := iif( aReturn[4] == 1 , 15 , 18 ) // Define se o caracter sera comprimido ou normal
// ------------------------------------	
    nLi += nInc
    if nLi > nMax .OR. ;
	   nLi < 5

        nLi := cabec( titulo , cCabec1 , cCabec2 , nomeprog , tamanho , nChrComp )
        nLi++

    endif
	
return( .T. )

// +--------------------------------------------------------------------------+
// | Função    : AlimCarta    | Microsiga                        | 27/02/2007 |
// +--------------------------------------------------------------------------+
//	====================================================================
//	Layout Matriz aCarta (Dimensoes) (emissao da carta de inadimplentes)
//	--------------------------------------------------------------------
//	1-Nome Cliente
//	2-Logradouro + Numero + Complemento
//	3-Bairro
//	4-Cidade
//	5-Estado
//	6-Cep
//	7-Valor devido
//	8-Data limite para comparecimento
//	====================================================================

static function alimcarta( cCodCli , cLoja , aCarta , aPosFin,cMatric )
// ------------------------------------
    local aAreaSA1 := SA1->( getarea() )
    local aAreaSE1 := SE1->( getarea() )
    local nVlrDeb  := 0
// ------------------------------------
    if SA1->( msseek( xfilial( 'SA1' ) + cCodCli + cLoja ))

// ------------------------------------
// mbc	if !aPosFin[1]
// ------------------------------------

        if len( aPosFin ) > 0

// ------------------------------------
// mbc  if alltrim( aPosFin[2,1,1]) == '004'
// ------------------------------------

            nVlrDeb := val( transform( aPosFin[3] , '999,999.99' ))

            aadd( aCarta , { SA1->A1_NOME         , ;
			                 SA1->A1_END          , ;
							 SA1->A1_BAIRRO       , ;
							 SA1->A1_MUN          , ;
							 SA1->A1_EST          , ;
							 SA1->A1_CEP          , ;
							 nVlrDeb              , ;
                           ( dDataBloqueio + 60 ),;
                           cMatric } ) 

// ------------------------------------
// mbc  endif
// ------------------------------------

        endif

    endif

    restarea( aAreaSA1 )
    restarea( aAreaSE1 )

return .T.

// +--------------------------------------------------------------------------+
// | Função    : VerTitAb  | Microsiga                           | 27/02/2007 |
// +--------------------------------------------------------------------------+

//static function vertitab( c_CodEmp , c_Matric , dRefFin , nDias )
  static function vertitab( c_CodEmp , c_Matric , dRefFin , nDias , c_CodInt , c_ConEmp , c_SubCon )
// ------------------------------------	
    local c_Alias := getnextalias()
    local c_Qry   := ''
    local a_Ret   := {}
// ------------------------------------	
    c_Qry += " SELECT MIN( E1_VENCREA ) VENCIMENTO , " + CRLF
    c_Qry += "        COUNT(*)          QUANTIDADE , " + CRLF
    c_Qry += "        SUM( E1_SALDO )   SALDO "        + CRLF
    c_Qry += "   FROM "               + retsqlname( 'SE1' ) + " E1 "  + CRLF
    c_Qry += "  WHERE E1_FILIAL  = '" +    xfilial( 'SE1' ) + "' "    + CRLF
//  c_Qry += "    AND E1_CODINT  = '0001' "                           + CRLF // gus
    c_Qry += "    AND E1_CODINT  = '" + c_CodInt + "' "               + CRLF // gus
    c_Qry += "    AND E1_CODEMP  = '" + c_CodEmp + "' "               + CRLF
// ---------------------------------------------------------------------------------
// -[ Gestao Inadimplencia - Ini Gus ]----------------------------------------------
// ---------------------------------------------------------------------------------
//  if ( BA3->BA3_COBNIV  = '1' .AND. ;
//       BA3->BA3_CODCLI <> ' '       )
//      c_Qry += "    AND E1_MATRIC  = '" + c_Matric + "' "
//    endif
// ---------------------------------------------------------------------------------
        if nTipo == 1
        c_Qry += "    AND E1_MATRIC  = '" + c_Matric + "' " + CRLF
    elseif nTipo == 2
        c_Qry += "    AND E1_CONEMP  = '" + c_ConEmp + "' " + CRLF
        c_Qry += "    AND E1_SUBCON  = '" + c_SubCon + "' " + CRLF
    endif
// ---------------------------------------------------------------------------------
// -[ Gestao Inadimplencia - Fim Gus ]----------------------------------------------
// ---------------------------------------------------------------------------------
//  c_Qry += "    AND TRIM( E1_TIPO ) NOT IN ( 'PR', 'NCC') " + CRLF
    c_Qry += "    AND TRIM( E1_TIPO )     IN ( 'FT', 'DP' ) " + CRLF
    c_Qry += "    AND E1_SALDO    > 0 "    + CRLF
    c_Qry += "    AND D_E_L_E_T_ <> '*' "  + CRLF
// ------------------------------------
//  memowrit( 'c:\TEMP\Cabx329_2.TXT' , c_Qry )
// ------------------------------------
    if c_Qry <> cQryOld

        cQryOld := c_Qry

        if tccanopen( c_Alias )
            tcdelfile( c_Alias )
        endif
// ------------------------------------	
        if select( c_Alias ) <> 0
            (c_Alias)->( dbclosearea() )
        endif
// ------------------------------------	
        dbusearea( .T. , 'TopConn' , tcgenqry( , , c_Qry ) , c_Alias , .T. , .T. )

//-------------------------------------------------------------
//      Angelo Henrique - Data: 05/07/2016
//-------------------------------------------------------------
//      Colocado para abrir mais opções além dos 60 dias
//-------------------------------------------------------------
//      if !(c_Alias)->( eof() )                          .AND. ;
//          dRefFin - stod( (c_Alias)->VENCIMENTO ) >= 60 .AND. ;
//          (c_Alias)->QUANTIDADE                   <> 0
// ------------------------------------	

        if !(c_Alias)->( eof() )                            .AND. ;
            (c_Alias)->QUANTIDADE                  <> 0     .AND. ;
	       dRefFin - stod( (c_Alias)->VENCIMENTO ) >= nDias

            a_Ret := { stod( (c_Alias)->VENCIMENTO ) , ;
	                         (c_Alias)->QUANTIDADE   , ;
                             (c_Alias)->SALDO        , ;
             dRefFin - stod( (c_Alias)->VENCIMENTO)    }

//          aRetOld := a_Ret

        endif

        aRetOld := a_Ret

        (c_Alias)->( dbclosearea() )

    else
        a_Ret := aRetOld
    endif

return a_Ret

// +--------------------------------------------------------------------------+
// | Função    : BloqFamUsr   | Leonardo Portella                | 22/03/2013 |
// +--------------------------------------------------------------------------+
// | Desc.     : Chama a PL260BLOCO para bloquear familia e usuario.          |
// | A funcao padrao PL260BLOCO ja estava neste programa. Criei esta funcao   |
// | para verificar se a familia ja estava bloqueada, pois a PL260BLOCO tb    |
// | funciona para desbloquear, que nao e a finalidade desta rotina, exceto   |
// | quando for motivo de viagem ao exterior, quando deve ser desbloqueado    |
// | e bloqueado com o motivo definitivo.                                     |
// +--------------------------------------------------------------------------+

static function BloqFamUsr( cAliasTab , nReg , nOpc , lDireto , cMotivo , dData , cBloFat )
// ------------------------------------
    local aArea := getarea()
// ------------------------------------
    if cAliasTab == 'BA3'

        BA3->( dbgoto( nReg ))

        if ( BA3->BA3_MOTBLO == '028' ) // Bloqueio por viagem ao exterior
// ------------------------------------
//          [ Rotina padrao no PLSA260 que bloqueia familia e usuario incluindo seus historicos na BCA e BC3 ]
//          [ Caso o beneficiario esteja bloqueado por viagem ao exterior a rotina ira desbloquear ]
// ------------------------------------
            pl260bloco( cAliasTab , ;
	    	            nReg      , ;
		    			nOpc      , ;
			    		lDireto   , ;
				    	'029'     , ; // 029 Motivo: Retorno do exterior - Combinado com Ana Paula em 09/04/13
    					dData     , ;
	    				cBloFat     )
        endif

        if empty( BA3->BA3_MOTBLO )
// ------------------------------------
//      [ Caso beneficiario esteja bloqueado por viagem ao exterior a rotina ira bloquear c/ motivo certo. ]
//      [ Rotina padrao no PLSA260 que bloqueia familia e usuario incluindo seus historicos na BCA e BC3 ]
// ------------------------------------
            pl260bloco( cAliasTab , ;
			            nReg      , ;
						nOpc      , ;
						lDireto   , ;
						cMotivo   , ;
						dData     , ;
						cBloFat     )
        endif

    endif

    restarea( aArea )

return

// --------------------------------------------------------------------------------------
// [ fim de cabx329.prw ]
// --------------------------------------------------------------------------------------
