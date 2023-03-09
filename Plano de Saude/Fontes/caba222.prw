#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'

// +------------------------+------------------------------------+------------+
// | Programa : caba222.prw | Autor : Gustavo Thees              | 17/05/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : caba222                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86776 - Desativa  e Bloqueia Tabela Padrao (BR8).     |
// +--------------------------------------------------------------------------+
// -------------------------------
// [ tabelas ]
// -------------------------------
// BR8 -         Tabela Padrao
// BR4 - Tipo de Tabela Padrao
// -------------------------------

user function caba222()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   cMsg    := ''
    local   lRet    := .F.
    local   nRet    := 0
// -------------------------------
    private cTab    := ''
    private cDes    := ''
    private cArq    := 'C:\TEMP\CABA222_' + substr(  dtos( date() ) , 1 , 4 ) + ;
                                            substr(  dtos( date() ) , 5 , 2 ) + ;
                                            substr(  dtos( date() ) , 7 , 2 ) + ;
                                      '_' + strtran( time() , ':' , '' ) + '.csv'
    private nHdl    := 0
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
        lRet := msgyesno( 'Esta rotina tem como objetivo pesquisar ' + chr( 13 ) + chr( 10 ) + ;
                          'os registros Ativos e Não Bloqueados    ' + chr( 13 ) + chr( 10 ) + ;
                          'da Tabela Padrão (BR8) selecionada!     ' + chr( 13 ) + chr( 10 ) + ;
                                                                       chr( 13 ) + chr( 10 ) + ;
                          'Confirma o processamento?' , 'Pesquisar BR8' )
    endif
// -------------------------------
//  [ pergunte ]
// -------------------------------
    if lRet
        validperg( 'CABA222' )
        lRet := pergunte( 'CABA222' , .T. )
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
        processa( { || caba222a(0) } , 'Pesquisando! Aguarde...' , '' , .T. )
    endif

// -------------------------------
//  [ confirma desativacao / bloqueio ]
// -------------------------------
    if lRet
        if nTotBR8 > 0
            lRet := msgyesno( 'Esta rotina tem como objetivo Desativar e Bloquear ' + chr( 13 ) + chr( 10 ) + ;
                              'os registros da Tabela Padrão (BR8) selecionada!   ' + chr( 13 ) + chr( 10 ) + ;
                                                                                      chr( 13 ) + chr( 10 ) + ;
                              'Confirma o processamento?' , 'Desativar BR8' )
        endif
    endif
// -------------------------------
//  [ chama processamento desativa / bloqueia BR8 ]
// -------------------------------
    if lRet
        if nTotBR8 > 0
            processa( { || caba222a(1) } , 'Desativando / Bloqueando!!! Aguarde...' , '' , .T. )
        endif
    endif
// -------------------------------

return

// +--------------------------------------------------------------------------+
// | Funcao   : caba222a                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86776 - Desativa  e Bloqueia Tabela Padrao (BR8).     |
// +--------------------------------------------------------------------------+

static function caba222a( nAux )

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local cTxt    := ''
    local nRegBR8 := 0
    local cAtvBR8 := ''
    local cBlqBR8 := ''
    local nBR8AB  := 0
    local nBR8A   := 0
    local nBR8B   := 0
    local cBR8Des := ''
    local cAcao   := ''
// ----------------------------------------------
    nTotBR8 := 0
// ----------------------------------------------
//  [ imprime selecao ]
// ----------------------------------------------
    if nAux == 0
        cTxt := 'Tp. Pad. Saude: '  + cTab + ' - ' + cDes + chr(13) + chr(10)
        fwrite( nHdl , cTxt )
    endif
// ----------------------------------------------
// ----------------------------------------------
    procregua( 0 )
    dbselectarea( 'BR8' ) // Tabela Padrao
    dbsetorder( 1 )       // BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
    if ( dbseek(       xfilial( 'BR8' ) + cTab ))

        do while BR8->( ! eof() )                    .AND. ;
                 BR8->BR8_FILIAL == xfilial( 'BR8' ) .AND. ;
                 BR8->BR8_CODPAD == cTab

            cAtvBR8 := ''
            cBlqBR8 := ''
            cAcao   := ''

// ----------------------------------------------
//          if (( BR8->BR8_BENUTL == '1' ) .OR.  ; // ativo    ( 0-nao / 1-sim )
//              ( BR8->BR8_PROBLO == '0' ))        // bloqueio ( 0-nao / 1-sim )
//
//              nTotBR8 := nTotBR8 + 1
//
//                  if (( BR8->BR8_BENUTL == '1' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
//                      ( BR8->BR8_PROBLO == '0' ))         // bloqueio ( 0-nao / 1-sim )
//                  nBR8AB  := nBR8AB + 1
//                  cAtvBR8 := 'Sim'
//                  cBlqBR8 := 'Não'
//                  cAcao   := 'Desativar e Bloquear'
//
//              elseif (( BR8->BR8_BENUTL == '1' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
//                      ( BR8->BR8_PROBLO == '1' ))         // bloqueio ( 0-nao / 1-sim )
//                  nBR8A  := nBR8A + 1
//                  cAtvBR8 := 'Sim'
//                  cBlqBR8 := 'Sim'
//                  cAcao   := 'Só Desativar'
//
//              elseif (( BR8->BR8_BENUTL == '0' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
//                      ( BR8->BR8_PROBLO == '0' ))         // bloqueio ( 0-nao / 1-sim )
//                  nBR8B  := nBR8B + 1
//                  cAtvBR8 := 'Não'
//                  cBlqBR8 := 'Não'
//                  cAcao   := 'Só Bloquear'
//                    
//              endif
// ----------------------------------------------
            if (( BR8->BR8_BENUTL == '1' ) .OR.  ; // ativo    ( 0-nao / 1-sim )
                ( BR8->BR8_PROBLO <> '1' ))        // bloqueio ( 0-nao / 1-sim )

                nTotBR8 := nTotBR8 + 1

                    if (( BR8->BR8_BENUTL == '1' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
                        ( BR8->BR8_PROBLO <> '1' ))         // bloqueio ( 0-nao / 1-sim )
                    nBR8AB  := nBR8AB + 1
                    cAtvBR8 := 'Sim'
                    cBlqBR8 := 'Não'
                    cAcao   := 'Desativar e Bloquear'

                elseif (( BR8->BR8_BENUTL == '1' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
                        ( BR8->BR8_PROBLO == '1' ))         // bloqueio ( 0-nao / 1-sim )
                    nBR8A  := nBR8A + 1
                    cAtvBR8 := 'Sim'
                    cBlqBR8 := 'Sim'
                    cAcao   := 'Só Desativar'

                elseif (( BR8->BR8_BENUTL <> '1' ) .AND.  ; // ativo    ( 0-nao / 1-sim )
                        ( BR8->BR8_PROBLO <> '1' ))         // bloqueio ( 0-nao / 1-sim )
                    nBR8B  := nBR8B + 1
                    cAtvBR8 := 'Não'
                    cBlqBR8 := 'Não'
                    cAcao   := 'Só Bloquear'
                    
                endif
// ----------------------------------------------

                nRegBR8 := BR8->( recno() )
                cBR8Des := posicione( 'BR4' , 1 , xfilial( 'BR4' ) + BR8->BR8_CODPAD , 'BR4_DESCRI' )

// ----------------------------------------------
//              [ imprime cabecalho ]
// ----------------------------------------------
                if nAux == 0
                    if nTotBR8 == 1
                        cTxt := 'BR8.R_E_C_N_O_'              + ';'
                        cTxt += 'BR8_FILIAL'                  + ';'
                        cTxt += 'BR8_CODPAD'                  + ';'
                        cTxt += 'BR8_DESPAD'                  + ';'
                        cTxt += 'BR8_CODPSA'                  + ';'
                        cTxt += 'BR8_ANASIN'                  + ';'
                        cTxt += 'BR8_BENUTL'                  + ';'
                        cTxt += 'BR8_PROBLO'                  + chr(13) + chr(10)
                        fwrite( nHdl , cTxt )
// ----------------------------------------------
                        cTxt := 'Registro BR8'                + ';'
                        cTxt += 'Filial'                      + ';'
                        cTxt += 'Cod. Tipo Tabela'            + ';'
                        cTxt += 'Des. Tipo Tabela'            + ';'
                        cTxt += 'Cod. Tabela Padrao'          + ';'
                        cTxt += 'Tipo'                        + ';'
                        cTxt += 'Ativo Tab Padrao (Atual)'    + ';'
                        cTxt += 'Bloqueio Tab Padrao (Atual)' + ';'
                        cTxt += 'Ação'                        + chr(13) + chr(10)
                        fwrite( nHdl , cTxt )
                    endif
// ----------------------------------------------
//                  [ imprime corpo ]
// ----------------------------------------------
                    cTxt :=       transform(          nRegBR8         , '@E 999999999' ) + ' ;'
                    cTxt += "'" +   alltrim( strtran( BR8->BR8_FILIAL , ';' , ',' )    ) + ' ;'
                    cTxt += "'" +   alltrim( strtran( BR8->BR8_CODPAD , ';' , ',' )    ) + ' ;'
                    cTxt += "'" +                     cBR8Des                            + ' ;'
                    cTxt += "'" +   alltrim( strtran( BR8->BR8_CODPSA , ';' , ',' )    ) + ' ;'
                    cTxt += "'" +   alltrim( strtran( BR8->BR8_ANASIN , ';' , ',' )    ) + ' ;'
                    cTxt += "'" +                     cAtvBR8                            + ' ;'
                    cTxt += "'" +                     cBlqBR8                            + ' ;'
                    cTxt += "'" +                     cAcao                              + chr(13) + chr(10)
                    fwrite( nHdl , cTxt )

                endif

// ----------------------------------------------
//              [ desativa e bloqueia BR8 ]
// ----------------------------------------------
                if nAux == 1
                    reclock( 'BR8' , .F. )
                        BR8->BR8_BENUTL := '0'   // ativo    ( 0-nao / 1-sim )
                        BR8->BR8_PROBLO := '1'   // bloqueio ( 0-nao / 1-sim )
//                      BR8->BR8_DESLIM := cAcao // marcacao para desfazer. apenas para teste...
                    msunlock()

                endif
// ----------------------------------------------

            endif

            BR8->( dbskip() )

        enddo

    endif

// ----------------------------------------------
    if nAux == 0
        if nTotBR8 == 0
            cTxt := 'Nenhum registro encontrado com a seleção acima!' + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
        else
            cTxt := 'Total de registros para desativar (BR8) : '             + str( nBR8A  ) + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
            cTxt := 'Total de registros para bloquear  (BR8) : '             + str( nBR8B  ) + chr(13) + chr(10)
            fwrite( nHdl , cTxt )
            cTxt := 'Total de registros para desativar e bloquear  (BR8) : ' + str( nBR8AB ) + chr(13) + chr(10)
            fwrite( nHdl , cTxt )

        endif
// -------------------------------
//      [ encerra gravação no arquivo ]
// -------------------------------
        fclose( nHdl )
// -------------------------------
        if msgbox( 'Tabela Padrão (BR8) : '                          +      cTab     + chr(13) + chr(10) + ;
                                                                                       chr(13) + chr(10) + ;
                   'Total de registros para desativar : '            + str( nBR8A  ) + chr(13) + chr(10) + ;
                   'Total de registros para bloquear  : '            + str( nBR8B  ) + chr(13) + chr(10) + ;
                   'Total de registros para desativar e bloquear : ' + str( nBR8AB ) + chr(13) + chr(10) + ;
                                                                                       chr(13) + chr(10) + ;
                   'Arquivo salvo em: '                                              + chr(13) + chr(10) + ;
                   cArq                                                              + chr(13) + chr(10) + ;
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
        msgbox( 'Tabela Padrão (BR8) : '                 +      cTab     + chr(13) + chr(10) + ;
                                                                           chr(13) + chr(10) + ;
                'Total Reg Desativados : '               + str( nBR8A  ) + chr(13) + chr(10) + ;
                'Total Reg Bloqueados  : '               + str( nBR8B  ) + chr(13) + chr(10) + ;
                'Total Reg Desativados e Bloqueados  : ' + str( nBR8AB ) , 'Sucesso' , 'INFO' )
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
	u_cabasx1( cPerg , '01' , 'Tp. Pad. Saude?' , '' , '' , 'MV_CH01' , 'C' , tamsx3( 'BR8_CODPAD' )[1] , 0 , 0 , 'C' , '' , 'B41PLS' , '' , '' , 'MV_PAR01' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , {} , {} , {} )
return

// ----------------------------------------------------------------------------
// [ fim de caba222.prw ]
// ----------------------------------------------------------------------------
