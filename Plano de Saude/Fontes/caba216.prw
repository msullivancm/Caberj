#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'

// +------------------------+------------------------------------+------------+
// | Programa : caba216.prw | Autor : Gustavo Thees              | 14/04/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : caba216                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85815 - Desfaz alterações do caba208 a partir         |
// |                            do arquivo .CSV informado.                    |
// +--------------------------------------------------------------------------+
// -------------------------------
// [ tabelas ]
// -------------------------------
// BG7 - Cabecalhos Grupos de Cobertura
// BG8 - Itens  dos Grupos de Coberturas
// BR8 -         Tabela Padrao
// BR4 - Tipo de Tabela Padrao
// -------------------------------

user function caba216()

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
	SetPrvt( 'oDlg01','oPanel','oGrp01','oGrp02','oGrp03' )
	SetPrvt( 'oSay01','oSay02','oSay03','oSay04','oSay05','oSay06','oSay07' )
	SetPrvt( 'oGet01','oGet02','oGet03','oBtn01','oBtn02','oBtn03' )
// -------------------------------
    private cArq    := space( 250 )
    private cBG8    := ''
    private cBR8    := ''
    private nHdl    := 0
    private nTotBG8 := 0
    private nTotBR8 := 0
// -------------------------------

// ------------------------------------------------------------------
// [ Definição do Dialog e todos os seus componentes ]
// ------------------------------------------------------------------
	oDlg01 :=    MSDialog():New( 088,232,450,927,'Desfaz CABA208 - Reativa BG8 e Desbloqueia BR8',,,.F.,,,,,,.T.,,,.T. )
	oPanel :=      TPanel():New( 000,000,'',oDlg01,,.F.,.F.,,,344,250,.T.,.F. )
// ------------------------------------------------------------------
	oGrp01 :=      TGroup():New( 004,004,048,340,'Desfaz CABA208',oPanel,CLR_BLUE,CLR_WHITE,.T.,.F. )
// --------------------------
	oSay01 :=        TSay():New( 011,009,{||replicate( '-' , 80 )                               },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
	oSay02 :=        TSay():New( 020,009,{||'Esta rotina vai desfazer as alterações do CABA208' },oGrp01,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,156,008)
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
	oGrp03 :=      TGroup():New( 116,004,177,340,'Status do Processamento',oPanel,CLR_BLUE,CLR_WHITE,.T.,.F. )
// --------------------------
	oSay06 :=        TSay():New( 134,009,{||'Reativados    BG8:'         },oGrp03,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,060,008)
	oSay07 :=        TSay():New( 156,009,{||'Desbloqueados BR8:'         },oGrp03,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,060,008)
// --------------------------
	oGet02 :=        TGet():New( 132,070,{|u|if(pcount()>0,cBG8:=u,cBG8) },oGrp03,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.F.},.F.,.F.,,.F.,.F.,'','cBG8'    ,,)
	oGet03 :=        TGet():New( 154,070,{|u|if(pcount()>0,cBR8:=u,cBR8) },oGrp03,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,'',,{||.F.},.F.,.F.,,.F.,.F.,'','cBR8'    ,,)
// --------------------------
	oBtn02 :=     TButton():New( 152,220,'Ok'        ,oGrp02,{||iif(fVerArq(),oDlg01:End(),.F.) },037,012,,,,.T.,,'',,,,.F. )
    oBtn03 :=     TButton():New( 152,287,'Cancelar'  ,oGrp03,{||              oDlg01:End()      },037,012,,,,.T.,,'',,,,.F. )
// ------------------------------------------------------------------
	oDlg01:Activate( , , , .T. )
//  oDlg01:Activate( , , , .T. , /*{|| msgstop( 'validou!' ) , .T. }*/ , , {|| msgstop( 'iniciando' ) } )
//  oDlg01:Activate( , , , .T. , , , {||iif(!fAcesso(),oDlg01:End(),) } )
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
            Processa( {|| lRet := caba216a() } , 'Aguarde...' , 'Processando arquivo...' , .F. )
			cBG8 := str( nTotBG8 )
			cBR8 := str( nTotBR8 )
			oGet02:refresh()
			oGet03:refresh()
			fClose( nHdl )
            if lRet
			    MsgBox( 'Processamento concluído com sucesso!' , 'SUCESSO' , 'INFO' )
                Close( oDlg01 )
// -------------------------------
//			    if MsgBox( 'Deseja abrir o arquivo? ( S / N )' , 'ATENÇÃO!' , 'YESNO' )
//    				nRet := ShellExecute( 'Open' , cArq , '' , '' , 1 )
//				    if nRet <= 32
//    					MsgStop( 'Não foi possível abrir o arquivo excel!!! ' )
//	    			endif
//	    		endif
// -------------------------------
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
// | Funcao   : caba216a                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 85815 - Resativa Procedimentos Grupo Cobertura (BG8). |
// +--------------------------------------------------------------------------+

static function caba216a()
    
    local lRet    := .T.
    local nUlt    := ft_flastrec()
    local cLin    := ''
    local nLin    := 0
    local aLin    := {}
    local nRecBG8 := 0
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
            nRecBG8 := val( aLin[01] )
            nRecBR8 := val( aLin[11] )

// ----------------------------------------------
            nTotBG8 := nTotBG8 + 1
            dbselectarea( 'BG8' ) // Itens  dos Grupos de Coberturas
            BG8->( dbgoto( nRecBG8 ))
            reclock( 'BG8' , .F. )
                BG8->BG8_BENUTL := '1'
            msunlock()
// ----------------------------------------------
            if nRecBR8 <> 0
                nTotBR8 := nTotBR8 + 1
                dbselectarea( 'BR8' ) // Tabela Padrao
                BR8->( dbgoto( nRecBR8 ))
                reclock( 'BR8' , .F. )
                    BR8->BR8_PROBLO := ''
                msunlock()
            endif
// ----------------------------------------------

        endif

        ft_fskip()

    enddo
// -------------------------------

return( lRet )

// ----------------------------------------------------------------------------
// [ fim de caba216.prw ]
// ----------------------------------------------------------------------------
