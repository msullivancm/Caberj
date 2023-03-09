#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'

// +------------------------+------------------------------------+------------+
// | Programa : caba208.prw | Autor : Gustavo Thees              | 07/04/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : caba208                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85815 - Desativa Procedimentos Grupo Cobertura (BG8). |
// |                          - Bloqueia Tabela Padrao                 (BR8). |
// +--------------------------------------------------------------------------+
// -------------------------------
// [ tabelas ]
// -------------------------------
// BG7 - Cabecalhos Grupos de Cobertura
// BG8 - Itens  dos Grupos de Coberturas
// BR8 -         Tabela Padrao
// BR4 - Tipo de Tabela Padrao
// -------------------------------

user function caba208()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   cMsg    := ''
    local   lRet    := .F.
    local   nRet    := 0
// -------------------------------
    private cTab    := ''
    private cDes    := ''
    private cArq    := 'C:\TEMP\CABA208_' + substr(  dtos( date() ) , 1 , 4 ) + ;
                                            substr(  dtos( date() ) , 5 , 2 ) + ;
                                            substr(  dtos( date() ) , 7 , 2 ) + ;
                                      '_' + strtran( time() , ':' , '' ) + '.csv'
    private nHdl    := 0
    private nTotBG8 := 0
    private nTotBR8 := 0
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
//  [ confirma listagem ]
// -------------------------------
    if lRet
        lRet := msgyesno( 'Esta rotina tem como objetivo pesquisar os       ' + chr( 13 ) + chr( 10 ) + ;
                          'Procedimentos do Grupo de Cobertura (BG8)        ' + chr( 13 ) + chr( 10 ) + ;
                          'de acordo com a Tabela Padrão (BR8) selecionada! ' + chr( 13 ) + chr( 10 ) + ;
                                                                                chr( 13 ) + chr( 10 ) + ;
                          'Serão listados os Procedimentos Ativos (BG8)     ' + chr( 13 ) + chr( 10 ) + ;
                          'com a Tabela Padrão Inativa e/ou Bloqueada (BR8)!' + chr( 13 ) + chr( 10 ) + ;
                                                                                chr( 13 ) + chr( 10 ) + ;                          
                          'Confirma o processamento?' , 'Pesquisar BG8' )
    endif
// -------------------------------
//  [ pergunte ]
// -------------------------------
    if lRet
        validperg( 'CABA208' )
        lRet := pergunte( 'CABA208' , .T. )
        if lRet
            cTab := MV_PAR01
            cDes := posicione( 'BR4' , 1 , xfilial( 'BR4' ) + cTab + '01' , 'BR4_DESCRI' )
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
//  [ chama processamento pesquisa ]
// -------------------------------
    if lRet
        processa( { || caba208a(0) } , 'Pesquisando! Aguarde...' , '' , .T. )
    endif

// -------------------------------
//  [ confirma desativacao ]
// -------------------------------
    if lRet
        if nTotBG8 > 0
            lRet := msgyesno( 'Esta rotina tem como objetivo desativar os       ' + chr( 13 ) + chr( 10 ) + ;
                              'Procedimentos do Grupo de Cobertura (BG8)        ' + chr( 13 ) + chr( 10 ) + ;
                              'de acordo com a Tabela Padrão (BR8) selecionada! ' + chr( 13 ) + chr( 10 ) + ;
                                                                                    chr( 13 ) + chr( 10 ) + ;
                              'Serão desativados os Procedimentos Ativos (BG8)  ' + chr( 13 ) + chr( 10 ) + ;
                              'com a Tabela Padrão Inativa e/ou Bloqueada (BR8)!' + chr( 13 ) + chr( 10 ) + ;
                                                                                    chr( 13 ) + chr( 10 ) + ;
                              'Serão bloqueados na Tabela Padrão (BR8)          ' + chr( 13 ) + chr( 10 ) + ;
                              'os registros inativos na Tabela Padrão   (BR8)   ' + chr( 13 ) + chr( 10 ) + ;
                              'e  no Procedimento do Grupo de Cobertura (BG8),  ' + chr( 13 ) + chr( 10 ) + ;
                              'com o bloqueio na Tabela Padrão (BR8) em branco! ' + chr( 13 ) + chr( 10 ) + ;
                                                                                    chr( 13 ) + chr( 10 ) + ;
                              'Confirma o processamento?' , 'Desativar BG8' )
        endif
    endif
// -------------------------------
//  [ chama processamento desativa BG8 / bloqueia BR8 ]
// -------------------------------
    if lRet
        if nTotBG8 > 0
            processa( { || caba208a(1) } , 'Desativando! Aguarde...' , '' , .T. )
        endif
    endif
// -------------------------------

return

// +--------------------------------------------------------------------------+
// | Funcao   : caba208a                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85815 - Desativa Procedimentos Grupo Cobertura (BG8). |
// +--------------------------------------------------------------------------+

static function caba208a( nAux )

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local cTxt    := ''
    local cAtvBG8 := ''
    local cAtv    := ''
    local cBlq    := ''
    local cAtvOld := ''
    local aBR8    := {}
    local nRegBG8 := 0
    local nRegBR8 := 0
    local cRegBR8 := ''
    local cBlqBR8 := ''
// ----------------------------------------------
    nTotBG8 := 0
    nTotBR8 := 0
// ----------------------------------------------
//  [ imprime selecao ]
// ----------------------------------------------
    if nAux == 0
        cTxt := 'Tp. Pad. Saude: '  + cTab + ' - ' + cDes + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
    endif
// ----------------------------------------------
    dbselectarea( 'BG7' ) // Cabecalhos Grupos de Cobertura
    dbsetorder( 1 )       // BG7_FILIAL + BG7_CODINT + BG7_CODGRU
    dbgotop()
    procregua( BG7->( reccount() ))
    do while BG7->( ! eof() )

        incproc()

        if ( BG7_YATIVO == 'S' )

            dbselectarea( 'BG8' ) // Itens  dos Grupos de Coberturas
            dbsetorder( 1 )       // BG8_FILIAL +      BG8_CODINT +      BG8_CODGRU + BG8_CODPAD + BG8_CODPSA + BG8_NIVEL
            if dbseek(         xfilial( 'BG8' ) + BG7->BG7_CODINT + BG7->BG7_CODGRU )

                do while BG8->( ! eof() )                    .AND. ;
                         BG8->BG8_FILIAL == xfilial( 'BG8' ) .AND. ;
                         BG8->BG8_CODINT == BG7->BG7_CODINT  .AND. ;
                         BG8->BG8_CODGRU == BG7->BG7_CODGRU

                    if ( BG8_CODPAD == cTab )

                        dbselectarea( 'BR8' ) // Tabela Padrao
                        dbsetorder( 3 )       // BR8_FILIAL +      BR8_CODPSA +      BR8_CODPAD
                        if dbseek(         xfilial( 'BR8' ) + BG8->BG8_CODPSA + BG8->BG8_CODPAD )

                            if (( BR8->BR8_BENUTL == '0' )  .OR.  ; // ativo    ( 0-nao / 1-sim )
                                ( BR8->BR8_PROBLO == '1' )) .AND. ; // bloqueio ( 0-nao / 1-sim )
                                ( BG8->BG8_BENUTL == '1' )          // ativo    ( 0-nao / 1-sim )

// ----------------------------------------------
                                nTotBG8 := nTotBG8 + 1
                                nRegBG8 := BG8->( recno() )
                                nRegBR8 := 0
                                cRegBR8 := ''
                                cBlqBR8 := ''
                                if empty( alltrim( BR8->BR8_PROBLO ))
                                    if ascan( aBR8 , BR8->BR8_CODPSA ) == 0
                                        aadd( aBR8 , BR8->BR8_CODPSA )
                                        nTotBR8 := nTotBR8 + 1
                                        nRegBR8 := BR8->( recno() )
                                        cRegBR8 := transform( nRegBR8 , '@E 999999999' )
                                        cBlqBR8 := 'Sim'
                                    else
                                        cRegBR8 := '(Repetido)'
                                        cBlqBR8 := '(Repetido)'
                                    endif
                                endif
// ----------------------------------------------

// ----------------------------------------------
//                              [ imprime cabecalho ]
// ----------------------------------------------
                                if nAux == 0
                                    if nTotBG8 == 1
                                        cTxt := 'BG8.R_E_C_N_O_' + ';'
                                        cTxt += 'BG8_FILIAL'     + ';'
                                        cTxt += 'BG7_CODINT'     + ';'
                                        cTxt += 'BG7_CODGRU'     + ';'
                                        cTxt += 'BG7_DESCRI'     + ';'
                                        cTxt += 'BG8_CODPAD'     + ';'
                                        cTxt += 'BG8_CODPSA'     + ';'
                                        cTxt += 'BR8_DESCRI'     + ';'
                                        cTxt += 'BG8_BENUTL'     + ';'
                                        cTxt +=                    ';'
                                        cTxt += 'BR8.R_E_C_N_O_' + ';'
                                        cTxt += 'BR8_BENUTL'     + ';'
                                        cTxt += 'BR8_PROBLO'     + ';'
                                        cTxt +=                    ';' + chr(13) + chr(10)
                                        fwrite( nHdl , cTxt )
// ----------------------------------------------
                                        cTxt := 'Registro BG8'                + ';'
                                        cTxt += 'Filial'                      + ';'
                                        cTxt += 'Operadora'                   + ';'
                                        cTxt += 'Cod.Grupo'                   + ';'
                                        cTxt += 'Descricao Grupo'             + ';'
                                        cTxt += 'Tp.Pad.Saude'                + ';'
                                        cTxt += 'Cod.Proced.'                 + ';'
                                        cTxt += 'Descricao Proced.'           + ';'
                                        cTxt += 'Ativo Proced. (Atual)'       + ';'
                                        cTxt += 'Ativo Proced. (Novo)'        + ';'
                                        cTxt += 'Registro BR8'                + ';'
                                        cTxt += 'Ativo Tab Padrao'            + ';'
                                        cTxt += 'Bloqueio Tab Padrao (Atual)' + ';'
                                        cTxt += 'Bloqueio Tab Padrao (Novo)'  + ';' + chr(13) + chr(10)
                                        fwrite( nHdl , cTxt )
                                    endif
// ----------------------------------------------
//                                  [ imprime corpo ]
// ----------------------------------------------
                                    cAtvBG8 := ''
                                    cAtv    := ''
                                    cBlq    := ''
// ----------------------------------------------
                                        if ( BG8->BG8_BENUTL == '0' )
                                        cAtvBG8 := 'Nao'
                                    elseif ( BG8->BG8_BENUTL == '1' )
                                        cAtvBG8 := 'Sim'
                                    endif
// ----------------------------------------------
                                    cDes := BR8->BR8_DESCRI
// ----------------------------------------------
                                        if ( BR8->BR8_BENUTL == '0' )
                                        cAtv := 'Nao'
                                    elseif ( BR8->BR8_BENUTL == '1' )
                                        cAtv := 'Sim'
                                    endif
// ----------------------------------------------
                                        if ( BR8->BR8_PROBLO == '0' )
                                        cBlq := 'Nao'
                                    elseif ( BR8->BR8_PROBLO == '1' )
                                        cBlq := 'Sim'
                                    endif
// ----------------------------------------------
                                    cTxt :=       transform(          nRegBG8         , '@E 999999999' ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG8->BG8_FILIAL , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG7->BG7_CODINT , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG7->BG7_CODGRU , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG7->BG7_DESCRI , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG8->BG8_CODPAD , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( BG8->BG8_CODPSA , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( cDes            , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( cAtvBG8         , ';' , ',' )    ) + ' ;'
                                    cTxt += "'Nao"                                                       + ' ;'
                                    cTxt +=                           cRegBR8                            + ' ;'
                                    cTxt += "'" +   alltrim( strtran( cAtv            , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim( strtran( cBlq            , ';' , ',' )    ) + ' ;'
                                    cTxt += "'" +   alltrim(          cBlqBR8                          ) + ' ;' + chr(13) + chr(10)
                                    fwrite( nHdl , cTxt )

                                endif

// ----------------------------------------------
//                              [ desativa BG8 e bloqueia BR8 ]
// ----------------------------------------------
                                if nAux == 1
// ----------------------------------------------
                                    cAtvOld := BG8->BG8_BENUTL
                                    reclock( 'BG8' , .F. )
                                        BG8->BG8_BENUTL := '0'
//                                        BG8->BG8_APOSPE := cAtvOld // marcacao para desfazer. apenas para teste...
                                    msunlock()
// ----------------------------------------------
                                    if empty( alltrim( BR8->BR8_PROBLO ))
                                        reclock( 'BR8' , .F. )
                                            BR8->BR8_PROBLO := '1'
//                                            BR8->BR8_DESLIM := 'X' // marcacao para desfazer. apenas para teste...
                                        msunlock()
                                    endif
// ----------------------------------------------

                                endif

                            endif
                        endif
                    endif

                    BG8->( dbskip() )

                enddo

            endif

        endif

        BG7->( dbskip() )

    enddo

// ----------------------------------------------
//  aviso( 'Término' , 'Desativados ' + str( nTotBG8 ) , { 'OK' } )
// ----------------------------------------------
    if nAux == 0
        if nTotBG8 == 0
            cTxt := 'Nenhum registro encontrado com a seleção acima!' + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
        else
            cTxt := 'Total de registros para desativar (BG8) : ' + str(nTotBG8) + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
            cTxt := 'Total de registros para bloquear  (BR8) : ' + str(nTotBR8) + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
        endif
// -------------------------------
//      [ encerra gravação no arquivo ]
// -------------------------------
        fclose( nHdl )
// -------------------------------
        if msgbox( 'Total de registros para desativar (BG8) : ' + str(nTotBG8) + chr(13) + chr(10) + ;
                   'Total de registros para bloquear  (BR8) : ' + str(nTotBR8) + chr(13) + chr(10) + ;
                                                                                 chr(13) + chr(10) + ;
                   'Arquivo salvo em: '                                        + chr(13) + chr(10) + ;
                   cArq                                                        + chr(13) + chr(10) + ;
                                                                                 chr(13) + chr(10) + ;
                   'Deseja abrir o arquivo? ( S / N )' , 'Sucesso' , 'YESNO' )
            nRet := ShellExecute( 'Open' , cArq , '' , '' , 1 )
            if nRet <= 32
                msgstop( 'Não foi possível abrir o arquivo Excel!!! ' )
		    endif
        endif
	endif
// ----------------------------------------------
    if nAux == 1
        msgbox( 'Total de registros desativados (BG8) : ' + str(nTotBG8) + chr(13) + chr(10) + ;
                'Total de registros bloqueados  (BR8) : ' + str(nTotBR8) , 'Sucesso' , 'INFO' )
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
	u_cabasx1( cPerg , '01' , 'Tp. Pad. Saude?' , '' , '' , 'MV_CH01' , 'C' , tamsx3( 'BG8_CODPAD' )[1] , 0 , 0 , 'C' , '' , 'B41PLS' , '' , '' , 'MV_PAR01' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
return

// ----------------------------------------------------------------------------
// [ fim de caba208.prw ]
// ----------------------------------------------------------------------------
