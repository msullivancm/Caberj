#INCLUDE  'RWMAKE.CH'
#INCLUDE  'FILEIO.CH'
#INCLUDE 'TOPCONN.CH'

// +------------------------+------------------------------------+------------+
// | Programa : cabr034.prw | Autor : Gustavo Thees              | 04/05/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : cabr034                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86502 - Relatorio de vacinas - Visao Custo.           |
// +--------------------------------------------------------------------------+

user function cabr034()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   lRet        := .F.
// -------------------------------
    local   cDesc1      := 'Este programa tem como objetivo imprimir '
    local   cDesc2      := 'o Relatório de Vacinas - Visão Custo     '
    local   cDesc3      := 'por intervalo de competência (mês/ano).  '
// -------------------------------
    local   cabec1      := ' Custo    Matrícula          Nome                                                                   Data Vacina     Valor Total($) Qtd Parcelas  Sequecial   Sequencial  Valor Parcela($)   Ano / Mês    '
    local   cabec2      := '                                                                                                                      da Vacina      Lançadas    Inicial     Final                          Lançamento   '
    local   titulo      := 'Relatório de Vacinas - Visão Custo'
    local   nLin        := 200 // 80
// -------------------------------
    private cArq        := 'C:\TEMP\CABR034_' + substr(  dtos( date() ) , 1 , 4 ) + ;
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
    private wnrel       := 'CABR034'
    private cPerg       := 'CABR034   '
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
        wnrel := setprint( 'BD6' , 'CABR034' , '' , @titulo , cDesc1 , cDesc2 , cDesc3 , .F. , {} , .F. , 'G' , , .T. )
        if nLastKey == 27
            lRet := .F.
//          return
        endif
    endif
    if lRet
        setdefault( areturn , 'BD6' )
        if nLastKey == 27
            lRet := .F.
//          return
        endif
    endif
// -------------------------------
//  [ Processamento. RPTSTATUS monta janela com a regua de processamento. ]
// -------------------------------
    if lRet
        nTipo := iif( areturn[4]==1 , 15 , 18 )
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
    local cTxt     := ''
    local cQry     := ''
    local nQtd     := 0
    local nTot     := 0
// -------------------------------
    local cCompet  := ''
    local cMatric  := ''
    local cNome    := ''
    local dDtVac   := ctod( space(10) )
    local nValVac  := 0
    local nParc    := 0
    local cSeqIni  := ''
    local cSeqFin  := ''
    local nValParc := 0
    local cAnoMes  := ''

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

    cQry :=    " SELECT BD6_MESPAG||'/'||BD6_ANOPAG                                AS COMPETENCIA      , "
    cQry +=           " BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO AS MATRICULA        , "
    cQry +=           " BD6_NOMUSR                                                 AS NOME_BENEF       , "
    cQry +=           " BD6_DATPRO                                                 AS DATA_VACINA      , "
    cQry +=           " BD6_VLRPAG                                                 AS VALOR_VACINA     , "
    cQry +=           " 4                                                          AS PARCELAS         , "
    cQry +=           " SUBSTR(BSQ_OBS,26,2)                                       AS PARCELA          , "
    cQry +=           " BSQ_CODSEQ                                                 AS SEQUENCIAL       , "
    cQry +=           " BSQ_VALOR                                                  AS VALOR_PARCELA    , "
    cQry +=           " BSQ_MES||'/'||BSQ_ANO                                      AS COMPET_PRESTACAO , "
    cQry +=           " CASE "
    cQry +=               " WHEN BSQ_PREFIX <> ' ' THEN BSQ_PREFIX||BSQ_NUMTIT||BSQ_PARCEL||BSQ_TIPTIT "
    cQry +=               " ELSE                        'Não' "
    cQry +=           " END AS FATURADO , "
    cQry +=           " BD6_NUMFAT      , "
    cQry +=           " BSQ_NUMCOB      , "
    cQry +=           " BSQ_MATRIC      , "
    cQry +=           " BSQ_PREFIX      , "
    cQry +=           " BSQ_NUMTIT      , "
    cQry +=           " BSQ_PARCEL      , "
    cQry +=           " BSQ_TIPTIT "
    cQry +=      " FROM " + retsqlname( 'BD6' ) + " BD6 "
    cQry += " LEFT JOIN " + retsqlname( 'BSQ' ) + " BSQ "
    cQry +=        " ON BSQ.D_E_L_E_T_         <> '*' "
    cQry +=       " AND BSQ.BSQ_FILIAL          = BD6.BD6_FILIAL "
    cQry +=       " AND BSQ.BSQ_CODINT          = BD6.BD6_OPEUSR "
    cQry +=       " AND BSQ.BSQ_USUARI          = BD6.BD6_OPEUSR||BD6.BD6_CODEMP||BD6.BD6_MATRIC||BD6.BD6_TIPREG||BD6.BD6_DIGITO "
    cQry +=       " AND BSQ_CODLAN              = '086' "
    cQry +=     " WHERE BD6.D_E_L_E_T_         <> '*' "
//  cQry +=       " AND BD6_FILIAL              = ' ' "
    cQry +=       " AND BD6_FILIAL              = '" + xfilial( 'BD6' ) + "' "
    cQry +=       " AND BD6_CODOPE              =  '0001' "
    cQry +=       " AND BD6_CODLDP             IN ('0001','0002') "
    cQry +=       " AND BD6_CODEMP             IN ('0001','0002','0003','0005') "
    cQry +=       " AND BD6_CODPAD              = '98' "
    cQry +=       " AND BD6_CODPRO             IN ('80190421','80190413') "
    cQry +=       " AND BD6_ANOPAG||BD6_MESPAG >= '" + sComIni + "' "
    cQry +=       " AND BD6_ANOPAG||BD6_MESPAG <= '" + sComFin + "' "
    cQry +=       " AND BD6_OPELOT             <> ' ' "
    cQry +=  " ORDER BY 1 , 2 , 8 "
// ----------------------------------------------
	cQry := changequery( cQry )
// ----------------------------------------------
    memowrite( 'C:\temp\cabr034.sql' , cQry )
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
        cTxt := 'Custo                 ;'
        cTxt += 'Matricula             ;'
        cTxt += 'Nome                  ;'
        cTxt += 'Data_Vacina           ;'
        cTxt += 'Valor_Total_Vacina    ;'
        cTxt += 'Qtd_Parcelas_Lancadas ;'
        cTxt += 'Sequencial_Inicial    ;'
        cTxt += 'Sequencial_Final      ;'
        cTxt += 'Valor_Parcela         ;'
        cTxt += 'Ano_Mes_Lancamento    ;' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        do while !eof()

            if nLin > 78 // 70 registros por pagina
                if nLin < 150
                    @ nLin , 000 psay replicate( '_' , 220 )
                    nLin ++
                    @ nLin , 200 psay 'Continua...'
                    nLin ++
                endif
                nLin := cabec( Titulo , Cabec1 , Cabec2 , 'CABR034' , 'G' , nTipo )
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
            if TMP->COMPETENCIA   <> cCompet .OR. ;
               TMP->MATRICULA     <> cMatric .OR. ;
               TMP->NOME_BENEF    <> cNome   .OR. ;
         stod( TMP->DATA_VACINA ) <> dDtVac  .OR. ;
               TMP->VALOR_VACINA  <> nValVac

                cCompet  :=       TMP->COMPETENCIA
                cMatric  :=       TMP->MATRICULA
                cNome    :=       TMP->NOME_BENEF
                dDtVac   := stod( TMP->DATA_VACINA )
                nValVac  :=       TMP->VALOR_VACINA
                nParc    :=       TMP->PARCELAS
                cSeqIni  :=       TMP->SEQUENCIAL
                nValParc :=       TMP->VALOR_PARCELA
                cAnoMes  :=       TMP->COMPET_PRESTACAO

                do while !eof()                        .AND. ;
                         TMP->COMPETENCIA   == cCompet .AND. ;
                         TMP->MATRICULA     == cMatric .AND. ;
                         TMP->NOME_BENEF    == cNome   .AND. ;
                   stod( TMP->DATA_VACINA ) == dDtVac  .AND. ;
                         TMP->VALOR_VACINA  == nValVac

                    cSeqFin := TMP->SEQUENCIAL
                    dbskip()

                enddo

            endif

// ----------------------------------------------
//          [ imprime corpo planilha ]
// ----------------------------------------------
            cTxt := "'" +           cCompet                            + ';'
            cTxt += "'" +           cMatric                            + ';'
            cTxt += "'" +           cNome                              + ';'
            cTxt += "'" +     dtoc( dDtVac   )                         + ';'
            cTxt +=     transform(( nValVac  ) , '@E 999,999,999.99' ) + ';'
//          cTxt +=     transform(( nParc    ) , '@E 999'            ) + ';'
            if !empty( alltrim( cSeqIni ))
                cTxt += transform(( nParc    ) , '@E 999'            ) + ';'
                cTxt += "'" +       cSeqIni                            + ';'
                cTxt += "'" +       cSeqFin                            + ';'
                cTxt += transform(( nValParc ) , '@E 999,999,999.99' ) + ';'
                cTxt += "'" +       cAnoMes                            + ';'
            endif
            cTxt += chr(13) + chr(10)
            fwrite( nHdl , cTxt )
// ----------------------------------------------
//          [ impressao do corpo do relatorio. ]
// ----------------------------------------------
            @ nLin , 001 psay cCompet
            @ nLin , 011 psay cMatric
            @ nLin , 030 psay cNome
            @ nLin , 101 psay dDtVac
            @ nLin , 114 psay nValVac      picture '@E 999,999,999.99'
//          @ nLin , 134 psay nParc        picture '@E 999'
            if !empty( alltrim( cSeqIni ))
                @ nLin , 134 psay nParc    picture '@E 999'
                @ nLin , 146 psay cSeqIni
                @ nLin , 158 psay cSeqFin 
                @ nLin , 169 psay nValParc picture '@E 999,999,999.99'
                @ nLin , 189 psay cAnoMes
            endif
// ----------------------------------------------
            nQtd := nQtd + 1
            nTot := nTot + nValVAc
            nLin ++
//          dbskip()

        enddo

// ----------------------------------------------
//      [ imprime total ]
// ----------------------------------------------
        cTxt := ';;;;' +  transform(( nTot ) , '@E 999,999,999.99' ) + ';' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        @ nLin , 000 psay replicate( '_' , 220 )
        nLin ++
        @ nLin , 001 psay nQtd picture '@E 999,999'
        @ nLin , 010 psay 'Linha(s)'
        @ nLin , 113 psay nTot picture '@E 999,999,999.99'
        nLin ++
        @ nLin , 000 psay replicate( '_' , 220 )

// ----------------------------------------------
    else
        cTxt := 'Nenhum registro encontrado com a seleção acima!' + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
// ----------------------------------------------
        nLin := cabec( Titulo , Cabec1 , Cabec2 , 'CABR034' , 'G' , nTipo )
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

    if areturn[5]==1
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
	u_cabasx1( cPerg , '01' , 'Competência de '  , '' , '' , 'MV_CH1' , 'C' , 07 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR01' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
	u_cabasx1( cPerg , '02' , 'Competência até ' , '' , '' , 'MV_CH2' , 'C' , 07 , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR02' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
return

// ----------------------------------------------------------------------------
// [ fim de cabr034.prw ]
// ----------------------------------------------------------------------------
