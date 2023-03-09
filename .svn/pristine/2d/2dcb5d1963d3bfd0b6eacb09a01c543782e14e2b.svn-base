#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'

// +------------------------+------------------------------------+------------+
// | Programa : caba223.prw | Autor : Gustavo Thees              | 17/05/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : caba223                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 86776 - Desfaz alterações do caba222 a partir         |
// |                            do arquivo .CSV informado.                    |
// +--------------------------------------------------------------------------+
// -------------------------------
// [ tabelas ]
// -------------------------------
// BR8 -         Tabela Padrao
// BR4 - Tipo de Tabela Padrao
// -------------------------------

user function caba223()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
	SetPrvt( 'oDlg01','oPanel','oGrp01','oGrp02','oGrp03' )
	SetPrvt( 'oSay01','oSay02','oSay03','oSay04','oSay05','oSay06','oSay07','oSay08' )
	SetPrvt( 'oGet01','oGet02','oGet03','oGet04','oBtn01','oBtn02','oBtn03' )
// -------------------------------
    private cArq    := space( 250 )
    private cBR8A   := ''
    private cBR8B   := ''
    private cBR8AB  := ''
    private nBR8A   := 0
    private nBR8B   := 0
    private nBR8AB  := 0
    private nHdl    := 0
    private nTotBR8 := 0
// -------------------------------

// ------------------------------------------------------------------
// [ Definição do Dialog e todos os seus componentes ]
// ------------------------------------------------------------------
	oDlg01 :=    MSDialog():New( 088,232,500,927,'Desfaz CABA222 - Reativa e Desbloqueia BR8',,,.F.,,,,,,.T.,,,.T. )
	oPanel :=      TPanel():New( 000,000,'',oDlg01,,.F.,.F.,,,344,250,.T.,.F. )
// ------------------------------------------------------------------
	oGrp01 :=      TGroup():New( 004,004,048,340,'Desfaz CABA222',oPanel,CLR_BLUE,CLR_WHITE,.T.,.F. )
// --------------------------
	oSay01 :=        TSay():New( 011,009,{||replicate( '-' , 80 )                               },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
	oSay02 :=        TSay():New( 020,009,{||'Esta rotina vai desfazer as alterações do CABA222' },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
	oSay03 :=        TSay():New( 029,009,{||'a partir do arquivo .CSV informado.'               },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
	oSay04 :=        TSay():New( 038,009,{||replicate( '-' , 80 )                               },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
// ------------------------------------------------------------------
    oGrp02 :=      TGroup():New( 050,004,114,340,'Arquivo CSV',oPanel,CLR_BLUE,CLR_WHITE,.T.,.F. )
// --------------------------
	oSay05 :=        TSay():New( 077,009,{||'Arquivo: '   },oGrp02,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,040,008)
// --------------------------
	oGet01 :=        TGet():New( 075,035,{|u|if(pcount()>0,cArq:=u,cArq)},oGrp02,250,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.T.},.F.,.F.,,.F.,.F.,'','cArq',,)
// --------------------------
	oBtn01 :=     TButton():New( 073,287,'Selecionar',oGrp02,{|| fSelArq() },037,012,,,,.T.,,'',,,,.F. )
// ------------------------------------------------------------------
	oGrp03 :=      TGroup():New( 116,004,200,340,'Status do Processamento',oPanel,CLR_BLUE,CLR_WHITE,.T.,.F. )
// --------------------------
	oSay06 :=        TSay():New( 134,009,{||'Reativados                 :' },oGrp03,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,100,008)
	oSay07 :=        TSay():New( 156,009,{||'Desbloqueados              :' },oGrp03,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,100,008)
	oSay08 :=        TSay():New( 178,009,{||'Reativados e Desbloqueados :' },oGrp03,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,100,008)
// --------------------------
	oGet02 :=        TGet():New( 132,100,{|u|if(pcount()>0,cBR8A :=u,cBR8A ) },oGrp03,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.F.},.F.,.F.,,.F.,.F.,'','cBR8A'  ,,)
	oGet03 :=        TGet():New( 154,100,{|u|if(pcount()>0,cBR8B :=u,cBR8B ) },oGrp03,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.F.},.F.,.F.,,.F.,.F.,'','cBR8B'  ,,)
	oGet04 :=        TGet():New( 178,100,{|u|if(pcount()>0,cBR8AB:=u,cBR8AB) },oGrp03,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.F.},.F.,.F.,,.F.,.F.,'','cBR8AB' ,,)
// --------------------------
	oBtn02 :=     TButton():New( 176,220,'Ok'        ,oGrp03,{||iif(fVerArq(),oDlg01:End(),.F.) },037,012,,,,.T.,,'',,,,.F. )
    oBtn03 :=     TButton():New( 176,287,'Cancelar'  ,oGrp03,{||              oDlg01:End()      },037,012,,,,.T.,,'',,,,.F. )
// ------------------------------------------------------------------
	oDlg01:Activate( , , , .T. )
return

// ------------------------------------------------------------------
static function fSelArq()
	cArq := upper( cGetFile( 'Arquivos CSV |*.CSV' , 'Arquivo Destino' , , , .F. , , ))
	if !empty( cArq )
	    cArq := alltrim( upper( cArq ))
	    if right( cArq , 4 ) <> '.CSV'
	        cArq := cArq + '.CSV'
	    endif
		cArq := cArq + space( 250 - len( cArq ))
	else
		alert( 'Nenhum arquivo selecionado!' )
	endif
return
// ------------------------------------------------------------------

static function fVerArq()
// --------------------------
    local lRet  := .F.
// --------------------------
    if empty( alltrim( cArq ))
        msgalert( 'Nenhum arquivo informado!' , 'Atenção!' )
		lRet := .F.
    else
	    cArq := alltrim( upper( cArq ))
	    if right( cArq , 4 ) <> '.CSV'
	        cArq := cArq + '.CSV'
	    endif
		cArq := cArq + space( 250 - len( cArq ))
		lRet := .T.
    endif
// --------------------------
	if lRet
	    if !file( cArq )
		    lRet := MsgBox( 'Arquivo não encontrado!' , 'ATENÇÃO!' , 'STOP' )
	        lRet := .F.
	    endif
	endif
// --------------------------
	if lRet
		nHdl := ft_fuse( cArq )
		if nHdl <> -1
			lRet := .T.
		else
			MsgAlert( 'Arquivo ' + cArq + ' não pode ser aberto!' , 'Atenção!' )
			fClose( nHdl )
			lRet := .F.
		endif
	endif
// -[ confirma processamento ]---------------------------------------
	if lRet
		if MsgBox( 'Confirma o processamento? ( S / N )' , 'ATENÇÃO!' , 'YESNO' )
// ----------------------------------------------
            Processa( {|| lRet := caba223a() } , 'Aguarde...' , 'Processando arquivo...' , .F. )

// -------------------------------
            cBR8A  := str( nBR8A   )
            cBR8B  := str( nBR8B   )
            cBR8AB := str( nBR8AB  )
// -------------------------------
			oGet02:refresh()
			oGet03:refresh()
			oGet04:refresh()
			fClose( nHdl )
            if lRet
			    MsgBox( 'Processamento concluído com sucesso!' , 'SUCESSO' , 'INFO' )
                Close( oDlg01 )
			endif
// -------------------------------
		else
			MsgAlert( 'Processamento não confirmado!' , 'Atenção!' )
			fClose( nHdl )
			lRet := .F.
		endif
	endif
// -------------------------------

return( lRet )


// +--------------------------------------------------------------------------+
// | Funcao   : caba223a                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85815 - Resativa Procedimentos Grupo Cobertura (BG8). |
// +--------------------------------------------------------------------------+

static function caba223a()
    
    local lRet    := .T.
    local nUlt    := ft_flastrec()
    local cLin    := ''
    local nLin    := 0
    local aLin    := {}
    local nRecBR8 := 0
// -------------------------------
    procregua( nUlt )
    ft_fgotop()
// -------------------------------
    nLin := nLin + 3
    ft_fskip()
    ft_fskip()
    ft_fskip()
// -------------------------------
    do while !ft_feof()

        nLin := nLin + 1
        cLin := ft_freadln()

        if substr( cLin , 1 , 5 ) <> 'Total'

            incproc( 'Lendo arquivo CSV - Linha ' + cvaltochar( nLin ) )

// -------------------------------
            aLin    := separa( cLin , ';' , .F. )
            nRecBR8 := val( aLin[01] )
// ----------------------------------------------
            if nRecBR8 <> 0

                    if aLin[09] == "'Só Desativar"
                    nBR8A       := nBR8A  + 1
				elseif aLin[09] == "'Só Bloquear"
                    nBR8B       := nBR8B  + 1
				elseif aLin[09] == "'Desativar e Bloquear"
                    nBR8AB      := nBR8AB + 1
                endif

                dbselectarea( 'BR8' ) // Tabela Padrao
                BR8->( dbgoto( nRecBR8 ))
                reclock( 'BR8' , .F. )

                        if aLin[09] == "'Só Desativar"
                        BR8->BR8_BENUTL := '1'         // ativo    ( 0-nao / 1-sim )
				    elseif aLin[09] == "'Só Bloquear"
                        BR8->BR8_PROBLO := '0'         // bloqueio ( 0-nao / 1-sim )
				    elseif aLin[09] == "'Desativar e Bloquear"
                        BR8->BR8_BENUTL := '1'         // ativo    ( 0-nao / 1-sim )
                        BR8->BR8_PROBLO := '0'         // bloqueio ( 0-nao / 1-sim )
                    endif

                msunlock()
            endif
// ----------------------------------------------

        endif

        ft_fskip()

    enddo
// -------------------------------

return( lRet )

// ----------------------------------------------------------------------------
// [ fim de caba223.prw ]
// ----------------------------------------------------------------------------
