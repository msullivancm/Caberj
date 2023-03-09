#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'
#INCLUDE  'TOPCONN.CH'

// +------------------------+------------------------------------+------------+
// | Programa : cabr031.prw | Autor : Gustavo Thees              | 05/04/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : cabr031                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85176 - Gerar .CSV com Titulos do Contas a Pagar      |
// +--------------------------------------------------------------------------+

user function cabr031()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   cMsg    := ''
    local   lRet    := .F.
    local   nRet    := 0
// ----------------------------------------------
    private cArq    := 'C:\TEMP\CABR031_' + substr(  dtos( date() ) , 1 , 4 ) + ;
                                            substr(  dtos( date() ) , 5 , 2 ) + ;
                                            substr(  dtos( date() ) , 7 , 2 ) + ;
                                      '_' + strtran( time() , ':' , '' ) + '.csv'
//  private dEmiIni := ctod(space(10))
//  private dEmiFin := ctod(space(10))
    private dBaiIni := ctod(space(10))
    private dBaiFin := ctod(space(10))
//  private sEmiIni :=      space(10)
//  private sEmiFin :=      space(10)
    private sBaiIni :=      space(10)
    private sBaiFin :=      space(10)
    private nBaixa  := 0
    private nSaldo  := 0
    private nHdl    := 0
// -------------------------------
//  [ cria pasta c:\temp ]
// -------------------------------
    lRet := .T.
    if !existdir( 'C:\Temp' )
        nRet := makedir(  'C:\Temp' )
        if nRet != 0
            cMsg := 'C:\Temp'                                + chr(13) + chr(10) + ;
                    'Não foi possível criar a pasta! Erro #' + alltrim( str( FError() )) // + cvaltochar( FError() )
            msgbox( cMsg , 'AVISO!' , 'STOP' )
            lRet := .F.
        endif            
    endif
// -------------------------------
//  [ confirma processamento ]
// -------------------------------
    if lRet
        lRet := msgyesno( 'Este programa tem como objetivo gerar arquivo .CSV de ' + chr(13) + chr(10) + ;
                          'Titulos Financeiros do Contas a Pagar selecionados por' + chr(13) + chr(10) + ;
                          'Data de Baixa, Valor Liquido Baixado e Saldo.         ' + chr(13) + chr(10) + ;
                                                                                     chr(13) + chr(10) + ;
                          'Confirma o processamento?' , '.CSV Contas a Pagar' )
    endif
// -------------------------------
//  [ pergunte ]
// -------------------------------
    if lRet
        validperg( 'CABR031' )
        lRet := pergunte( 'CABR031' , .T. )
        if lRet
//          dEmiIni := MV_PAR01
//          dEmiFin := MV_PAR02
            dBaiIni := MV_PAR01
            dBaiFin := MV_PAR02
            nBaixa  := MV_PAR03
            nSaldo  := MV_PAR04
//          sEmiIni := dtos( dEmiIni )
//          sEmiFin := dtos( dEmiFin )
            sBaiIni := dtos( dBaiIni )
            sBaiFin := dtos( dBaiFin )

        endif
    endif
// -------------------------------
//  [ cria arquivo de saida ]
// -------------------------------
    if lRet
        nHdl := FCreate( cArq , FC_NORMAL )
        if nHdl == -1
            cMsg := cArq                                      + chr(13) + chr(10) + ;
                   'Não foi possível criar o arquivo! Erro #' + alltrim( str( FError() )) // + cvaltochar( FError() )
            msgbox( cMsg , 'AVISO!' , 'STOP' )
            lRet := .F.
        endif
    endif
// -------------------------------
//  [ chama processamento principal ]
// -------------------------------
    if lRet
        processa( { || cabr031a() } , 'Aguarde...' , '' , .T. )
    endif
// ----------------------------------------------

return

// +--------------------------------------------------------------------------+
// | Funcao   : cabr031a                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Gerar CSV                                                     |
// +--------------------------------------------------------------------------+

static function cabr031a()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local cAlias     := getnextalias()
    local cQry       := ''
    local cTxt       := ''
    local nRet       := 0
    local nTot       := 0
// ----------------------------------------------
    local cDatIncSis := ''
    local cDatDigNF  := ''
    local cDatEmi    := ''
    local cDatVct    := ''
    local cDatVctRea := ''
    local cDatAgenda := ''
    local cDatBaixa  := ''
// ----------------------------------------------
//  [ imprime selecao ]
// ----------------------------------------------
//  cTxt := 'De Emissao: '  + dtoc( dEmiIni ) + chr(13) + chr(10)
//  fwrite( nHdl , cTxt )
// ----------------------------------------------
//  cTxt := 'Ate Emissao: ' + dtoc( dEmiFin ) + chr(13) + chr(10)
//  fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := 'De Baixa: '    + dtoc( dBaiIni ) + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := 'Ate Baixa: '   + dtoc( dBaiFin ) + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if nBaixa = 1
        cTxt := 'Valor Liq Baixado: Maior que 0.00' + chr(13) + chr(10)
    elseif nBaixa = 2
        cTxt := 'Valor Liq Baixado: Igual a 0.00'   + chr(13) + chr(10)
    else
        cTxt := 'Valor Liq Baixado: Todos'          + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if nSaldo = 1
        cTxt := 'Saldo: Maior que 0.00' + chr(13) + chr(10)
    elseif nSaldo = 2
        cTxt := 'Saldo: Igual a 0.00'   + chr(13) + chr(10)
    else
        cTxt := 'Saldo: Todos'          + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
//  [ monta select ]
// ----------------------------------------------
    cQry    += " SELECT E2_PREFIXO , "
    cQry    += "        E2_NUM     , "
    cQry    += "        E2_TIPO    , "
    cQry    += "        E2_FORNECE , "
    cQry    += "        E2_NOMFOR  , "
    cQry    += "      ( E2_VALOR + E2_ISS + E2_IRRF + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_INSS ) VALOR_TIT , "
    cQry    += "        E2_VALOR   , "
    cQry    += "        E2_VALLIQ  , "
    cQry    += "        E2_SALDO   , "
    cQry    += "        E2_YDTSYST , "
    cQry    += "        E2_YDTDGNF , "
    cQry    += "        E2_EMISSAO , "
    cQry    += "        E2_VENCTO  , "
    cQry    += "        E2_VENCREA , "
    cQry    += "        E2_DATAAGE , "
    cQry    += "        E2_BAIXA   , "
    cQry    += "        ZUO_GRUPO    "
    cQry    += "   FROM " + retsqlname( 'SE2' ) + " SE2 , "
    cQry    +=              retsqlname( 'ZUO' ) + " ZUO   "
    cQry    += "  WHERE SE2.D_E_L_E_T_ <> '*' "
    cQry    += "    AND  E2_FILIAL      = '" + xfilial( 'SE2' ) + "' "
//  cQry    += "    AND  E2_EMISSAO    >= '" + sEmiIni          + "' "
//  cQry    += "    AND  E2_EMISSAO    <= '" + sEmiFin          + "' "
    cQry    += "    AND  E2_BAIXA      >= '" + sBaiIni          + "' "
    cQry    += "    AND  E2_BAIXA      <= '" + sBaiFin          + "' "
// ----------------------------------------------
        if nBaixa = 1
        cQry += "   AND SE2.E2_VALLIQ   > 0.00 "
    elseIf nBaixa = 2
        cQry += "   AND SE2.E2_VALLIQ   = 0.00 "
    endif
// ----------------------------------------------
        if nSaldo = 1
        cQry += "   AND SE2.E2_SALDO    > 0.00 "
    elseIf nSaldo = 2
        cQry += "   AND SE2.E2_SALDO    = 0.00 "
    endif
// ----------------------------------------------
    cQry     += "   AND ( ( E2_ORIGEM   = 'PLSMPAG' AND E2_TIPO IN ('DP','FT', 'NDF') ) OR ( E2_ORIGEM <> 'PLSMPAG' ) ) "
// ----------------------------------------------
    cQry     += "   AND ZUO.D_E_L_E_T_ <> '*' "
    cQry     += "   AND ZUO_PREF        = E2_PREFIXO "
    cQry     += "   AND ZUO_ORIGEM      = E2_ORIGEM  "
    cQry     += " ORDER BY 4 , 1 , 10 "
// ----------------------------------------------
	cQry     := changequery( cQry )
// ----------------------------------------------
    memowrite( 'C:\temp\cabr031.sql' , cQry )
// ----------------------------------------------
	if select(cAlias) > 0
		dbselectarea(cAlias)
		(cAlias)->(dbclosearea())
	endif
    dbusearea( .T. , 'TOPCONN' , tcgenqry( , , cQry ) , cAlias , .T. , .T. )
// ----------------------------------------------
	if !(cAlias)->( eof() )
        procregua( 0 )
// ----------------------------------------------
//      [ imprime cabecalho ]
// ----------------------------------------------
        cTxt := 'Prefixo           ;'
        cTxt += 'Titulo            ;'
        cTxt += 'Tipo              ;'
        cTxt += 'Cod_Fornecedor    ;'
        cTxt += 'Nome_Fornecedor   ;'
        cTxt += 'Valor_Titulo      ;'
        cTxt += 'Valor_Liquido     ;'
        cTxt += 'Valor_Liq_Baixado ;'
        cTxt += 'Saldo             ;'
        cTxt += 'Inclusao_Sistema  ;'
        cTxt += 'Digitacao_NF      ;'
        cTxt += 'Emissao           ;'
        cTxt += 'Vencimento        ;'
        cTxt += 'Vencimento_Real   ;'
        cTxt += 'Agendamento       ;'
        cTxt += 'Baixa             ;'
        cTxt += 'Grupo_Prefixo     ;' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        do while  !(cAlias)->( eof() )
//          incproc()
// ----------------------------------------------
            nTot       := nTot + 1
            cDatIncSis := ''
            cDatDigNF  := ''
            cDatEmi    := ''
            cDatVct    := ''
            cDatVctRea := ''
            cDatAgenda := ''
            cDatBaixa  := ''
// ----------------------------------------------
            if !empty( ( cAlias )->E2_YDTSYST )
                cDatIncSis := dtoc( stod( ( cAlias )->E2_YDTSYST ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_YDTDGNF )
                cDatDigNF  := dtoc( stod( ( cAlias )->E2_YDTDGNF ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_EMISSAO )
                cDatEmi    := dtoc( stod( ( cAlias )->E2_EMISSAO ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_VENCTO )
                cDatVct    := dtoc( stod( ( cAlias )->E2_VENCTO ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_VENCREA )
                cDatVctRea := dtoc( stod( ( cAlias )->E2_VENCREA ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_DATAAGE )
                cDatAgenda := dtoc( stod( ( cAlias )->E2_DATAAGE ))
            endif
// ----------------------------------------------
            if !empty( ( cAlias )->E2_BAIXA )
                cDatBaixa   := dtoc( stod( ( cAlias )->E2_BAIXA ))
            endif
// ----------------------------------------------
//          [ imprime corpo ]
// ----------------------------------------------
            cTxt := "'" +       (cAlias)->E2_PREFIXO                          + ';'
            cTxt += "'" +       (cAlias)->E2_NUM                              + ';'
            cTxt += "'" +       (cAlias)->E2_TIPO                             + ';'
            cTxt += "'" +       (cAlias)->E2_FORNECE                          + ';'
            cTxt += "'" +       (cAlias)->E2_NOMFOR                           + ';'
            cTxt += transform(( (cAlias)->VALOR_TIT  ) , '@E 99,999,999.99' ) + ';'
            cTxt += transform(( (cAlias)->E2_VALOR   ) , '@E 99,999,999.99' ) + ';'
            cTxt += transform(( (cAlias)->E2_VALLIQ  ) , '@E 99,999,999.99' ) + ';'
            cTxt += transform(( (cAlias)->E2_SALDO   ) , '@E 99,999,999.99' ) + ';'
            cTxt +=              cDatIncSis                                   + ';'
            cTxt +=              cDatDigNF                                    + ';'
            cTxt +=              cDatEmi                                      + ';'
            cTxt +=              cDatVct                                      + ';'
            cTxt +=              cDatVctRea                                   + ';'
            cTxt +=              cDatAgenda                                   + ';'
            cTxt +=              cDatBaixa                                    + ';'
            cTxt += "'" +      ( cAlias )->ZUO_GRUPO                          + ';' + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
// ----------------------------------------------
            ( cAlias )->( dbskip() )

        enddo
// ----------------------------------------------
    else
        cTxt := 'Nenhum registro encontrado com a seleção acima!' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
    endif
// ----------------------------------------------
    if select( cAlias ) > 0
        ( cAlias )->( dbclosearea() )
    endif

// -------------------------------
//  [ encerra gravação no arquivo ]
// -------------------------------
    fclose( nHdl )
    if MsgBox( 'Total de registros: ' + str(nTot) + chr(13) + chr(10) + ;
               'Arquivo salvo em: '               + chr(13) + chr(10) + ;
               cArq                               + chr(13) + chr(10) + ;
               'Deseja abrir o arquivo? ( S / N )' , 'Sucesso' , 'YESNO' )
        nRet := ShellExecute( 'Open' , cArq , '' , '' , 1 )
        if nRet <= 32
            msgstop( 'Não foi possível abrir o arquivo Excel!!! ' )
		endif
	endif
// ----------------------------------------------

return

// +--------------------------------------------------------------------------+
// | Funcao   : validperg                                                     |
// +--------------------------------------------------------------------------+
// | Descricao: Validar pergunte                                              |
// +--------------------------------------------------------------------------+

static function validperg( cPerg )
    cPerg := padr( cPerg , 10 )
//  u_cabasx1( cPerg , '01' , 'De Emissao?       ' , '' , '' , 'MV_CH1' , 'D' , 08 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR01' , ''            , '' , '' , '' , ''          , '' , '' , ''      , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
//  u_cabasx1( cPerg , '02' , 'Ate Emissao?      ' , '' , '' , 'MV_CH2' , 'D' , 08 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR02' , ''            , '' , '' , '' , ''          , '' , '' , ''      , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
    u_cabasx1( cPerg , '01' , 'De Baixa?         ' , '' , '' , 'MV_CH1' , 'D' , 08 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR01' , ''            , '' , '' , '' , ''          , '' , '' , ''      , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
    u_cabasx1( cPerg , '02' , 'Ate Baixa?        ' , '' , '' , 'MV_CH2' , 'D' , 08 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR02' , ''            , '' , '' , '' , ''          , '' , '' , ''      , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
    u_cabasx1( cPerg , '03' , 'Valor Liq Baixado?' , '' , '' , 'MV_CH3' , 'N' , 01 , 0 , 0 , 'C' , '' , '' , '' , '' , 'MV_PAR03' , 'Maior que 0' , '' , '' , '' , 'Igual a 0' , '' , '' , 'Todos' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
    u_cabasx1( cPerg , '04' , 'Valor do Saldo?'    , '' , '' , 'MV_CH4' , 'N' , 01 , 0 , 0 , 'C' , '' , '' , '' , '' , 'MV_PAR04' , 'Maior que 0' , '' , '' , '' , 'Igual a 0' , '' , '' , 'Todos' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
return

// ----------------------------------------------------------------------------
// [ fim de cabr031.prw ]
// ----------------------------------------------------------------------------
