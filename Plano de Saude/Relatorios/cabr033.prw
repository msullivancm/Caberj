#INCLUDE  'RWMAKE.CH'
#INCLUDE  'FILEIO.CH'
#INCLUDE 'TOPCONN.CH'

// +------------------------+------------------------------------+------------+
// | Programa : cabr033.prw | Autor : Gustavo Thees              | 03/05/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : cabr033                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86502 - Relatorio de vacinas - Visao Cobranca.        |
// +--------------------------------------------------------------------------+

user function cabr033()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   lRet        := .F.
// -------------------------------
    local   cDesc1      := 'Este programa tem como objetivo imprimir '
    local   cDesc2      := 'o Relatório de Vacinas - Visão Cobrança  '
    local   cDesc3      := 'por intervalo de competência (mês/ano).  '
// -------------------------------
    local   cabec1      := ' Custo    Matrícula          Nome                                                                   Data Vacina     Valor Total($) Qtd Parcelas  Parcela  Sequencial  Valor Parcela($)   Ano / Mês    Faturado?      '
    local   cabec2      := ' Origem                                                                                                               da Vacina      Lançadas                                            Lançamento                  '
    local   titulo      := 'Relatório de Vacinas - Visão Cobrança'
    local   nLin        := 200
// -------------------------------
    private cArq        := 'C:\TEMP\CABR033_' + substr(  dtos( date() ) , 1 , 4 ) + ;
                                                substr(  dtos( date() ) , 5 , 2 ) + ;
                                                substr(  dtos( date() ) , 7 , 2 ) + ;
                                          '_' + strtran( time() , ':' , '' ) + '.csv'
    private cComIni     := ''
    private cComFin     := ''
    private sComIni     := ''
    private sComFin     := ''
    private nHdl        := 0
// -------------------------------
    private lAbortPrint := .F.
    private nTipo       := 15
    private aReturn     := { 'Zebrado' , 1 , 'Administracao' , 1 , 2 , 1 , '' , 1 }
    private nLastKey    := 0
    private wnrel       := 'CABR033'
    private cPerg       := 'CABR033   '
    private m_pag       := 1
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
//  [ pergunte ]
// -------------------------------
    if lRet
        validperg( cPerg )
        lRet := pergunte( cPerg , .T. )
        if lRet
            cComIni := MV_PAR01
            cComFin := MV_PAR02
            sComIni := substr( MV_PAR01 , 3 , 4 ) + substr( MV_PAR01 , 1 , 2 )
            sComFin := substr( MV_PAR02 , 3 , 4 ) + substr( MV_PAR02 , 1 , 2 )
        endif
    endif
// -------------------------------
//  [ cria arquivo de saida ]
// -------------------------------
    if lRet
        nHdl := fcreate( cArq , FC_NORMAL )
        if nHdl == -1
            cMsg := cArq                                      + chr(13) + chr(10) + ;
                   'Não foi possível criar o arquivo! Erro #' + alltrim( str( FError() )) // + cvaltochar( FError() )
            msgbox( cMsg , 'AVISO!' , 'STOP' )
            lRet := .F.
        endif
    endif
// -------------------------------
//  [ Monta a interface padrao com o usuario. ]
// -------------------------------
    if lRet
        wnrel := setprint( 'BD6' , 'CABR033' , '' , @titulo , cDesc1 , cDesc2 , cDesc3 , .F. , {} , .F. , 'G' , , .T. )
        if nLastKey == 27
            lRet := .F.
//          return
        endif
    endif
    if lRet
        setdefault( aReturn , 'BD6' )
        if nLastKey == 27
            lRet := .F.
//          return
        endif
    endif
// -------------------------------
//  [ Processamento. RPTSTATUS monta janela com a regua de processamento. ]
// -------------------------------
    if lRet
        nTipo := iif( aReturn[4]==1 , 15 , 18 )
        rptstatus({|| runreport( cabec1 , cabec2 , titulo , nLin ) } , titulo )
    endif

return

// +--------------------------------------------------------------------------+
// | Funcao   : runreport                                                     |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86502 - Relatorio de vacinas.                         |
// +--------------------------------------------------------------------------+

static function runreport( Cabec1 , Cabec2 , Titulo , nLin )

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local cTxt := ''
    local cQry := ''
    local nTot := 0

// ----------------------------------------------
//  [ imprime selecao ]
// ----------------------------------------------
    cTxt := 'Custo de: '    + substr( MV_PAR01 , 1 , 2 ) + '/' + substr( MV_PAR01 , 3 , 4 ) + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := 'Custo até: '   + substr( MV_PAR02 , 1 , 2 ) + '/' + substr( MV_PAR02 , 3 , 4 ) + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------

    setregua( 0 )

    cQry := " SELECT BD6_MESPAG||'/'||BD6_ANOPAG                                AS COMPETENCIA      , "
    cQry +=        " BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO AS MATRICULA        , "
    cQry +=        " BD6_NOMUSR                                                 AS NOME_BENEF       , "
    cQry +=        " BD6_DATPRO                                                 AS DATA_VACINA      , "
    cQry +=        " BD6_VLRPAG                                                 AS VALOR_VACINA     , "
    cQry +=        " 4                                                          AS PARCELAS         , "
    cQry +=        " SUBSTR(BSQ_OBS,26,2)                                       AS PARCELA          , "
    cQry +=        " BSQ_CODSEQ                                                 AS SEQUENCIAL       , "
    cQry +=        " BSQ_VALOR                                                  AS VALOR_PARCELA    , "
    cQry +=        " BSQ_MES||'/'||BSQ_ANO                                      AS COMPET_PRESTACAO , "
    cQry +=        " CASE "
    cQry +=            " WHEN BSQ_PREFIX <> ' ' THEN BSQ_PREFIX||BSQ_NUMTIT||BSQ_PARCEL||BSQ_TIPTIT "
    cQry +=            " ELSE                        'Não' "
    cQry +=        " END AS FATURADO , "
    cQry +=        " BD6_NUMFAT      , "
    cQry +=        " BSQ_NUMCOB      , "
    cQry +=        " BSQ_MATRIC      , "
    cQry +=        " BSQ_PREFIX      , "
    cQry +=        " BSQ_NUMTIT      , "
    cQry +=        " BSQ_PARCEL      , "
    cQry +=        " BSQ_TIPTIT "
    cQry +=   " FROM " + retsqlname( 'BD6' ) + " BD6 , "
    cQry +=              retsqlname( 'BSQ' ) + " BSQ "
    cQry +=  " WHERE BD6.D_E_L_E_T_         <> '*' "
    cQry +=    " AND BD6_FILIAL              = '" + xfilial( 'BD6' ) + "' "
    cQry +=    " AND BD6_CODOPE              =  '0001' "
    cQry +=    " AND BD6_CODLDP             IN ('0001','0002') "
    cQry +=    " AND BD6_CODEMP             IN ('0001','0002','0003','0005') "
    cQry +=    " AND BD6_CODPAD              = '98' "
    cQry +=    " AND BD6_CODPRO             IN ('80190421','80190413') "
    cQry +=    " AND BD6_ANOPAG||BD6_MESPAG >= '" + sComIni + "' "
    cQry +=    " AND BD6_ANOPAG||BD6_MESPAG <= '" + sComFin + "' "
    cQry +=    " AND BD6_OPELOT             <> ' ' "
    cQry +=    " AND BSQ.D_E_L_E_T_         <> '*' "
    cQry +=    " AND BSQ_FILIAL              = BD6_FILIAL "
    cQry +=    " AND BSQ_CODINT              = BD6_OPEUSR "
    cQry +=    " AND BSQ_USUARI              = BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO "
    cQry +=    " AND BSQ_CODLAN              = '086' "
    cQry +=    " ORDER BY 1 , 2 , 8 "
// ----------------------------------------------
	cQry     := changequery( cQry )
// ----------------------------------------------
    memowrite( 'C:\temp\cabr033.sql' , cQry )
// ----------------------------------------------
    if select('TMP') <> 0
        ('TMP')->( dbclosearea() )
    endif
    TcQuery cQry Alias 'TMP' New 
    dbselectarea( 'TMP' )
// ----------------------------------------------
	if !eof()
//      procregua( 0 )
// ----------------------------------------------
//      [ imprime cabecalho ]
// ----------------------------------------------
        cTxt := 'Custo_Origem          ;'
        cTxt += 'Matricula             ;'
        cTxt += 'Nome                  ;'
        cTxt += 'Data_Vacina           ;'
        cTxt += 'Valor_Total_Vacina    ;'
        cTxt += 'Qtd_Parcelas_Lancadas ;'
        cTxt += 'Parcela               ;'
        cTxt += 'Sequencial            ;'
        cTxt += 'Valor_Parcela         ;'
        cTxt += 'Ano_Mes_Lancamento    ;'
        cTxt += 'Faturado              ;' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        do while !eof()

//          if nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
//              nLin := cabec( Titulo , Cabec1 , Cabec2 , 'CABR033' , 'G' , nTipo )
//              nLin ++
//          endif

            if nLin > 78 // 70 registros por pagina
                if nLin < 150
                    @ nLin , 000 psay replicate( '_' , 220 )
                    nLin ++
                    @ nLin , 200 psay 'Continua...'
                    nLin ++
                endif
                nLin := cabec( Titulo , Cabec1 , Cabec2 , 'CABR033' , 'G' , nTipo )
                nLin ++
            endif

// ----------------------------------------------
//          [ Verifica o cancelamento pelo usuario. ]
// ----------------------------------------------
            if lAbortPrint
                @ nLin , 00 psay '*** CANCELADO PELO OPERADOR ***'
                exit
            endif
// ----------------------------------------------
//          [ imprime corpo planilha ]
// ----------------------------------------------
            cTxt := "'" +                  TMP->COMPETENCIA                             + ';'
            cTxt += "'" +                  TMP->MATRICULA                               + ';'
            cTxt += "'" +                  TMP->NOME_BENEF                              + ';'
            cTxt += "'" + dtoc( stod(      TMP->DATA_VACINA ) )                         + ';'
            cTxt +=       transform((      TMP->VALOR_VACINA  ) , '@E 999,999,999.99' ) + ';'
            cTxt +=       transform((      TMP->PARCELAS      ) , '@E 999'            ) + ';'
            cTxt +=       transform(( val( TMP->PARCELA     ) ) , '@E 999'            ) + ';'
            cTxt += "'" +                  TMP->SEQUENCIAL                              + ';'
            cTxt +=       transform((      TMP->VALOR_PARCELA ) , '@E 999,999,999.99' ) + ';'
            cTxt += "'" +                  TMP->COMPET_PRESTACAO                        + ';'
            cTxt += "'" +                  TMP->FATURADO                                + ';' + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
// ----------------------------------------------
//          [ Impressao do corpo do relatorio. ]
// ----------------------------------------------
            @ nLin , 001 psay       TMP->COMPETENCIA
            @ nLin , 010 psay       TMP->MATRICULA
            @ nLin , 029 psay       TMP->NOME_BENEF
            @ nLin , 100 psay stod( TMP->DATA_VACINA )
            @ nLin , 113 psay       TMP->VALOR_VACINA     picture '@E 999,999,999.99'
            @ nLin , 134 psay       TMP->PARCELAS         picture '@E 999'
            @ nLin , 146 psay  val( TMP->PARCELA )        picture '@E 999'
            @ nLin , 154 psay       TMP->SEQUENCIAL
            @ nLin , 165 psay       TMP->VALOR_PARCELA    picture '@E 999,999,999.99'
            @ nLin , 186 psay       TMP->COMPET_PRESTACAO
            @ nLin , 198 psay       TMP->FATURADO
// ----------------------------------------------
            nTot := nTot + TMP->VALOR_PARCELA
            nLin ++
            dbskip()

        enddo

// ----------------------------------------------
//      [ imprime total ]
// ----------------------------------------------
        cTxt := ';;;;;;;;' +  transform(( nTot ) , '@E 999,999,999.99' ) + ';' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        @ nLin , 000 psay replicate( '_' , 220 )
        nLin ++
        @ nLin , 164 psay nTot picture '@E 999,999,999.99'
        nLin ++
        @ nLin , 000 psay replicate( '_' , 220 )
// ----------------------------------------------
    else
        cTxt := 'Nenhum registro encontrado com a seleção acima!' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        nLin := cabec( Titulo , Cabec1 , Cabec2 , 'CABR033' , 'G' , nTipo )
        nLin ++
        @ nLin , 00 psay '*** NENHUM REGISTRO ENCONTRADO ***'
    endif

// ----------------------------------------------
//  [ Finaliza a execucao do relatorio. ]
// ----------------------------------------------
    set device to screen

// ----------------------------------------------
//  [ Se impressao em disco, chama o gerenciador de impressao. ]
// ----------------------------------------------

    if aReturn[5]==1
        dbcommitall()
        set printer to
        ourspool( wnrel )
    endif

    ms_flush()

// -------------------------------
//  [ encerra gravação no arquivo ]
// -------------------------------
    fclose( nHdl )
    if MsgBox( 'Arquivo salvo em: '               + chr(13) + chr(10) + ;
               cArq                               + chr(13) + chr(10) + ;
               'Deseja abrir o arquivo? ( S / N )' , 'Sucesso' , 'YESNO' )
        nRet := ShellExecute( 'Open' , cArq , '' , '' , 1 )
        if nRet <= 32
            msgstop( 'Não foi possível abrir o arquivo Excel!!! ' )
		endif
	endif

return

// +--------------------------------------------------------------------------+
// | Funcao   : validperg                                                     |
// +--------------------------------------------------------------------------+
// | Descricao: Validar pergunte                                              |
// +--------------------------------------------------------------------------+

static function validperg( cPerg )
    cPerg := padr( alltrim( cPerg ) , 10 )
	u_cabasx1( cPerg , '01' , 'Custo de '  , '' , '' , 'MV_CH1' , 'C' , 07 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR01' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
	u_cabasx1( cPerg , '02' , 'Custo até ' , '' , '' , 'MV_CH2' , 'C' , 07 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR02' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
return

// ----------------------------------------------------------------------------
// [ fim de cabr033.prw ]
// ----------------------------------------------------------------------------
