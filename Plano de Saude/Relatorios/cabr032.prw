#INCLUDE  'PLSMGER.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE   'RWMAKE.CH'
#INCLUDE   'FILEIO.CH'
#INCLUDE  'TOPCONN.CH'

#DEFINE  cCodigosPF  '104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155'
#DEFINE  PLSVALOR    '@E 99,999,999,999.99'

Static objCENFUNLGP := CENFUNLGP():New()

// +------------------------+------------------------------------+------------+
// | Programa : cabr032.prw | Autor : Gustavo Thees              | 26/04/2022 |
// +------------------------+------------------------------------+------------+
// | Funcao   : cabr032                                                       |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 80612 - Rotina adaptada do fonte padrão PLSR256.PRW   |
// |            Relatorio de Usuarios por Grupo/Emresa gerando .CSV           |
// +--------------------------------------------------------------------------+

//   Function PLSR256() // gus
user function cabr032() // gus

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
    local   aCriticas   := {}
// -------------------------------
    local   cMsg        := ''  // gus
    local   lRet        := .F. // gus
    local   nRet        := 0   // gus
// ----------------------------------------------------------------------------
// [ Define variavaoeis ]
// ----------------------------------------------------------------------------
    private nQtdLin     := 58
    private cNomeProg   := 'PLSR256'
    private nCaracter   := 15
    private nLimite     := 152
    private cTamanho    := 'G'
    private cTitulo     := FunDesc() // 'Valor de Cobrança'
    private cDesc1      := FunDesc() // 'Valor de Cobrança'
    private cDesc2      := ''                         
    private cDesc3      := ''
    private cCabec1     := '                                                                                                      '
    private cCabec2     := ''
    private cAlias      := 'BA3'
    private cPerg       := 'PLR256'
    private cRel        := 'PLR256'
    private nLi         := 01
    private m_pag       := 1
    private aReturn     := { 'Zebrado' , 1 , 'Administracao' , 1 , 1 , 1 , '' , 1 }
    private lAbortPrint := .F.                                                                       
    private aOrdens     := { 'Operadora+Empresa+Contrato+SubContrato+Matricula' , 'Operadora+Empresa+Contrato+SubContrato+Nome' }
    private lDicion     := .F.
    private lCompres    := .F.
    private lCrystal    := .F.
    private lFiltro     := .T.
// ----------------------------------------------------------------------------
//  [ gus - inicio ]
// ----------------------------------------------------------------------------
    private cArq        := 'C:\TEMP\CABR032_' + substr(  dtos( date() ) , 1 , 4 ) + ;
                                                substr(  dtos( date() ) , 5 , 2 ) + ;
                                                substr(  dtos( date() ) , 7 , 2 ) + ;
                                          '_' + strtran( time() , ':' , '' ) + '.csv'
    private nHdl        := 0
	private cTxt        := ''
// -------------------------------
    private cEmpx       := '' // empresa
    private cConx       := '' // contrato
    private cSubx       := '' // subcontrato
    private cMt1x       := '' // matricula 1
    private cMt2x       := '' // Matricula 2
    private cTipx       := '' // tipo
    private cNomx       := '' // nome
    private cNasx       := '' // nascimento
    private cIdax       := '' // idade
    private cPlax       := '' // plano
    private cRubx       := '' // rubrica
    private cValx       := '' // valor
    private cPrex       := '' // previsto
    private cDifx       := '' // diferenca
    private nValx       := 0  // valor
    private nPrex       := 0  // previsto
    private nDifx       := 0  // diferenca
    private cEmpresa    := iif( cEmpAnt == '01' , 'C' , 'I' )
    private cComp       := ''
// -------------------------------
//  [ cria pasta c:\temp ]
// -------------------------------
    lRet := .T.
    if !existdir( 'C:\Temp' )
        nRet := makedir(  'C:\Temp' )
        if nRet != 0
            cMsg := 'C:\Temp'                                + chr(13) + chr(10) + ;
                    'Não foi possível criar a pasta! Erro #' + alltrim( str( FError() ))
            msgbox( cMsg , 'AVISO!' , 'STOP' )
            lRet := .F.
        endif            
    endif
// -------------------------------
//  [ cria arquivo de saida ]
// -------------------------------
    if lRet
        nHdl := fcreate( cArq , FC_NORMAL )
        if nHdl == -1
            cMsg := cArq                                      + chr(13) + chr(10) + ;
                   'Não foi possível criar o arquivo! Erro #' + alltrim( str( FError() ))
            msgbox( cMsg , 'AVISO!' , 'STOP' )
            lRet := .F.
        endif
    endif
// ----------------------------------------------------------------------------
//  [ gus - fim ]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
    if lRet // gus

// ----------------------------------------------------------------------------
//                          10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
//                  1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// ----------------------------------------------------------------------------
        cCabec1 := '                  Matricula Usuario    Tp Nome Usuario                                     Cod  Descricao                  Mat. Antiga                     Valor'
        cCabec2 := 'Data     Nome do Prestador               Proced            Descrição AMB    Idade                   Dente   Face       L.Dg. PEG      Numero             Valor'
        cRel    := SetPrint( cAlias , cRel , cPerg , @cTitulo , cDesc1 , cDesc2 , cDesc3 , lDicion , aOrdens , lCompres , cTamanho , {} , lFiltro , lCrystal )
	    aAlias  := { 'BA1' , 'BA3' , 'BI3' , 'BD6' }
	    objCENFUNLGP:setAlias(aAlias)

// ----------------------------------------------------------------------------
//      [ Verifica se foi cancelada a operacao ]
// ----------------------------------------------------------------------------
        if nLastKey  == 27
//          return      // gus
            lRet := .F. // gus
        endif

	endif // gus
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
    if lRet // gus

// ----------------------------------------------------------------------------
//      [ parametros ]
// ----------------------------------------------------------------------------
        pergunte( cPerg , .F. )

        nCompara :=          MV_PAR01
        _cMes    :=          MV_PAR02
        _cAno    :=          MV_PAR03
        cOpe     :=          MV_PAR04
        nTipCon  :=          MV_PAR05
        cGrupIni :=          MV_PAR06
        cGrupFim :=          MV_PAR07
        cContDe  :=          MV_PAR08
        cContAte :=          MV_PAR09                              
        cSubConI :=          MV_PAR10
        cSubConF :=          MV_PAR11
        cMatrIni :=          MV_PAR12
        cMatrFin :=          MV_PAR13
        cMtAnIni :=          MV_PAR14
        cMtAnFin :=          MV_PAR15
        cDatFin  :=          MV_PAR16
        cGrpCIni :=          MV_PAR17
        cGrpCFin :=          MV_PAR18
        nTipRel  :=          MV_PAR19
        nFamZer  :=          MV_PAR20
        lDetCO   :=          MV_PAR21
        cCodPlaI :=          MV_PAR23
        cCodPlaF :=          MV_PAR24
        nModPag  :=          MV_PAR25
        nMatAnt  :=          MV_PAR26
        cVencTo  :=          MV_PAR27
        cLancFt  := alltrim( MV_PAR28 )
        lLisMat  :=          MV_PAR29 == 1
        lVlrTx   :=          MV_PAR30 == 1

        cComp    := _cAno + _cMes + '01' // gus

        if nTipRel == 2
            cCabec1 := '   Contrato '
            cCabec2 := '      Subcontrato             Descricao                                                                                  Valor'
        endif

// ----------------------------------------------------------------------------
//      [ Configura Impressora ]
// ----------------------------------------------------------------------------
        setdefault( aReturn , cAlias )

// ----------------------------------------------------------------------------
//      [ rptstatus ]
// ----------------------------------------------------------------------------
//      Proc2BarGauge( { || aCriticas :=    RImp256() }  , 'Imprimindo...' )
        Proc2BarGauge( { || aCriticas := u_xRImp256() }  , 'Imprimindo...' ) // gus
                                                                              
// ----------------------------------------------------------------------------
//      [ Caso tenha critica ]
// ----------------------------------------------------------------------------
        if len( aCriticas ) > 0
	        PLSCRIGEN( aCriticas , { { 'Matricula' , '@C' , 70 } , { 'Critica' , '@C' , 170 } } , 'Criticas do relatorio.' )
        endif

// ----------------------------------------------------------------------------
//      [ gus - inicio ]
// ----------------------------------------------------------------------------
// -------------------------------
//      [ encerra gravação no arquivo ]
// -------------------------------
        fclose( nHdl )
        if msgbox( 'Arquivo salvo em: ' + chr(13) + chr(10) + ;
                   cArq                 + chr(13) + chr(10) + ;
                   'Deseja abrir o arquivo? ( S / N )' , 'Sucesso' , 'YESNO' )
            nRet := shellexecute( 'Open' , cArq , '' , '' , 1 )
            if nRet <= 32
                msgstop( 'Não foi possível abrir o arquivo Excel!!! ' )
            endif
        endif

    endif
// ----------------------------------------------------------------------------
//      [ gus - fim ]
// ----------------------------------------------------------------------------

return

// +--------------------------------------------------------------------------+
// | Funcao   : xRImp256 ( adaptada da funcao padrao RImp256 )                |
// +--------------------------------------------------------------------------+
// | Descricao: Relatorio de contratos adaptado para gerar .CSV               |
// +--------------------------------------------------------------------------+

//   Function  RImp256() // gus
user function xRImp256() // gus

// -------------------------------
//  [ declaracao de variaveis ]
// -------------------------------
//  [ Variaveis do IndRegua ]
// -------------------------------
    local   nFor
    local   n
    local   lTemUsr
    local   lPrimeiro  := .T.
    local   aVlrFam    := {}
    local   aVlrCO     := {}
    local   aCriticas  := {}
    local   aUsuarios  := {}
    local   nColCO     := 0
    local   lImp       := .T.
//  local   lAchou     := .F. // gus
    local   aValAcu    := {}
    local   nTotFaA    := 0
    local   lPrSubCon  := .F.
    local   cMatricFam := ''
    local   cChave     := ''
    local   nVlrDBSub  := 0
    local   nVlrDBCon  := 0
//  local   nVlrDBEmp  := 0   // gus
    local   aCobUsr    := {}
//  local   cCodint    := ''  // gus
// ------------------------------------
    private cFor
    private cOrdem
    private cInd       := criatrab( NIL , .F. )
// ------------------------------------
//  [ Inicios de colunas ]
// ------------------------------------
    private nColEmp    := 00
    private nColCon    := 03
    private nColSub    := 06
    private nColuna    := 00
    private nColUsr    := 09
// ------------------------------------
//  [ Controles de quebras ]
// ------------------------------------
    private cCodEmp    := ''
    private cCodCon    := ''
    private cCodSub    := ''
// ------------------------------------
//  [ Variaveis de uso generico ]
// ------------------------------------
    private cLinha     := space( 00 )
    private pMoeda     := '@E 99,999,999,999.99'
    private aValor
    private lPF        := .F.
// ------------------------------------
//  [ Exibe mensagem informativa ]
// ------------------------------------
//  MsProcTXT( "Aguarde. Buscando dados no servidor..." )
    incprocg1( 'Aguarde. Buscando dados no servidor...' )
    processmessage()
// ------------------------------------
//  [ Totalizadores por Empresa ]
// ------------------------------------
    private nTotCobEmp := 0
    private nTotRegEmp := 0
    private aQtdusrEmp := 0
// ------------------------------------
//  [ Totalizadores por Contrato ]
// ------------------------------------
    private nTotCobCon := 0
    private nTotRegCon := 0
    private aQtdusrCon := 0
// ------------------------------------
//  [ Totalizadores por SubContrato ]
// ------------------------------------
    private nTotCobSub := 0
    private nTotRegSub := 0
    private nVlrCob    := 0
    private aQtdusrSub := 0
// ------------------------------------

// ----------------------------------------------------------------------------
//  [ gus - inicio ]
// ----------------------------------------------------------------------------
// ----------------------------------------------
//  [ imprime selecao ]
// ----------------------------------------------
        if MV_PAR01 = 1
        cTxt := 'Comparar Valor ?;Sim'  + chr(13) + chr(10)
    elseif MV_PAR01 = 2
        cTxt := 'Comparar Valor ?;Não'  + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Mes ?;'"       + MV_PAR02   + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Ano ?;'"       + MV_PAR03   + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Operadora ?;'" + MV_PAR04   + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR05 = 1
        cTxt := 'Tipo Contrato ?;Física'      + chr(13) + chr(10)
    elseif MV_PAR05 = 2
        cTxt := 'Tipo Contrato ?;Jurídica'    + chr(13) + chr(10)
    else
        cTxt := 'Tipo Contrato ?;Ambas'       + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Grupo/Empresa De ?;'"   + MV_PAR06 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Grupo/Empresa Ate ?;'"  + MV_PAR07 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Contrato De ?;'"        + MV_PAR08 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Contrato Ate ?;'"       + MV_PAR09 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "SubContrato De ?;'"     + MV_PAR10 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "SubContrato Ate ?;'"    + MV_PAR11 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Matricula De ?;'"       + MV_PAR12 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Matricula Ate ?;'"      + MV_PAR13 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Matr Antiga De ?;'"     + MV_PAR14 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Matr Antiga Ate ?;'"    + MV_PAR15 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Data Referencia ?;'"    + dtoc( MV_PAR16 ) + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Grupo Cobranca de ?;'"  + MV_PAR17 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Grupo Cobranca ate ?;'" + MV_PAR18 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR19 = 1
        cTxt := 'Tipo Relatorio ?;Analítico' + chr(13) + chr(10)
    elseif MV_PAR19 = 2
        cTxt := 'Tipo Relatorio ?;Sintético' + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR20 = 1
        cTxt := 'Lista Fam s/vlr ?;Sim'      + chr(13) + chr(10)
    elseif MV_PAR20 = 2
        cTxt := 'Lista Fam s/vlr ?;Não'      + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR21 = 1
        cTxt := 'Lista movimentação ?;Sim'   + chr(13) + chr(10)
    elseif MV_PAR21 = 2
        cTxt := 'Lista movimentação ?;Não'   + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR22 = 1
        cTxt := 'Lista Demitidos ?;Sim'      + chr(13) + chr(10)
    elseif MV_PAR22 = 2
        cTxt := 'Lista Demitidos ?;Não'      + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Produto De ?;'"       + MV_PAR23 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Produto Ate ?;'"      + MV_PAR24 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR25 = 1
        cTxt := 'Modalidade de cobrança ?;Pre-Pagamento' + chr(13) + chr(10)
    elseif MV_PAR25 = 2
        cTxt := 'Modalidade de cobrança ?;C. O.'         + chr(13) + chr(10)
    else
        cTxt := 'Modalidade de cobrança ?;Ambos'         + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR26 = 1
        cTxt := 'Imprime matricula antiga ?;Sim'         + chr(13) + chr(10)
    elseif MV_PAR26 = 2
        cTxt := 'Imprime matricula antiga ?;Não'         + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Vencimentos pessoa fisica(,) ?;'" + MV_PAR27 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
    cTxt := "Lancamentos de faturamento ?;'"   + MV_PAR28 + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR29 = 1
        cTxt := 'Listar matric empresa ?;Sim'            + chr(13) + chr(10)
    elseif MV_PAR29 = 2
        cTxt := 'Listar matric empresa ?;Não'            + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
        if MV_PAR30 = 1
        cTxt := 'Aglutina valor da taxa ?;Sim'           + chr(13) + chr(10)
    elseif MV_PAR30 = 2
        cTxt := 'Aglutina valor da taxa ?;Não'           + chr(13) + chr(10)
    endif
    fwrite( nHdl , cTxt )
// ----------------------------------------------
//  [ imprime cabecalho ]
// ----------------------------------------------
    cTxt := 'Empresa           ;'
    cTxt += 'Nº Contrato       ;'
    cTxt += 'Nº Subcontrato    ;'
    cTxt += 'Matricula         ;'
    cTxt += 'Matricula Empresa ;'
    cTxt += 'Tipo              ;'
    cTxt += 'Nome              ;'
    cTxt += 'Nascimento        ;'
    cTxt += 'Idade             ;'
    cTxt += 'Plano             ;'
    cTxt += 'Rubrica           ;'
    cTxt += 'Valor a cobrar    ;'
    cTxt += 'Valor previsto    ;'
    cTxt += 'Diferença         ;' + chr(13) + chr(10)
    fwrite( nHdl , cTxt )
// ----------------------------------------------

// ----------------------------------------------------------------------------
//  [ gus - fim ]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//  [ Monta Expressao de filtro ]
// ----------------------------------------------------------------------------
//  cFor :=          " SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP    , BA3_GRPCOB, BA3_MATANT, "
//  cFor +=                 " BA3_MATEMP, BA3_MATRIC, BA3_SUBCON    , BA3_TIPOUS, BA3_VALANT, "
//  cFor +=                 " BA3_VERCON, BA3_VERSUB, BA3.R_E_C_N_O_, BA1_NOMUSR, BA1_TIPREG, "
//  cFor +=                 " (RETORNA_VALOR_FAIXA_PRXRE_ALTA('" + cEmpresa + "',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,BA1_TIPREG,'" + cComp + "'                   )) PREVISTO , "
//  cFor +=                 " (RETORNA_VALOR_DE_OPCIONAIS(                       BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cComp + "','" + cEmpresa + "')) OPCIONAL   "
//  cFor +=            " FROM " + retsqlname( 'BA3' ) + " BA3 "
//  cFor += " LEFT OUTER JOIN " + retsqlname( 'BA1' ) + " BA1 "
//  cFor +=              " ON BA1_FILIAL = '" + xfilial( 'BA1' ) + "' "
//  cFor +=             " AND BA1_CODINT = BA3_CODINT "
//  cFor +=             " AND BA1_CODEMP = BA3_CODEMP "
//  cFor +=             " AND BA1_MATRIC = BA3_MATRIC "
//  cFor +=             " AND BA1_TIPUSU = 'T' "
//  cFor +=             " AND BA1.D_E_L_E_T_ <> '*' "
//  cFor +=           " WHERE BA3_FILIAL  = '" + xfilial( 'BA3' ) + "' "
//  cFor +=             " AND BA3_CODINT  = '" +       cOpe       + "' "
//  cFor +=             " AND BA3_CODEMP >= '" +       cGrupIni   + "' "
//  cFor +=             " AND BA3_CODEMP <= '" +       cGrupFim   + "' "
//  cFor +=             " AND BA3_DATBAS <= '" + dtos( cDatFin )  + "' "
//  cFor +=             " AND BA3_CONEMP >= '" +       cContDe    + "' "
//  cFor +=             " AND BA3_CONEMP <= '" +       cContAte   + "' "
//  cFor +=             " AND BA3_MATRIC >= '" +       cMatrIni   + "' "
//  cFor +=             " AND BA3_MATRIC <= '" +       cMatrFin   + "' "
//  cFor +=             " AND BA3_MATANT >= '" +       cMtAnIni   + "' "
//  cFor +=             " AND BA3_MATANT <= '" +       cMtAnFin   + "' "
//  cFor +=             " AND BA3_SUBCON >= '" +       cSubConI   + "' "
//  cFor +=             " AND BA3_SUBCON <= '" +       cSubConF   + "' "
//  cFor +=             " AND BA3_CODPLA >= '" +       cCodPlaI   + "' "
//  cFor +=             " AND BA3_CODPLA <= '" +       cCodPlaF   + "' "
// ----------------------------------------------------------------------------
    cFor :=          " SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP    , BA3_GRPCOB, BA3_MATANT, "
    cFor +=                 " BA3_MATEMP, BA3_MATRIC, BA3_SUBCON    , BA3_TIPOUS, BA3_VALANT, "
    cFor +=                 " BA3_VERCON, BA3_VERSUB, BA3.R_E_C_N_O_, BA1_NOMUSR, BA1_TIPREG  "
    cFor +=            " FROM " + retsqlname( 'BA3' ) + " BA3 "
    cFor += " LEFT OUTER JOIN " + retsqlname( 'BA1' ) + " BA1 "
    cFor +=              " ON BA1_FILIAL = '" + xfilial( 'BA1' ) + "' "
    cFor +=             " AND BA1_CODINT = BA3_CODINT "
    cFor +=             " AND BA1_CODEMP = BA3_CODEMP "
    cFor +=             " AND BA1_MATRIC = BA3_MATRIC "
    cFor +=             " AND BA1_TIPUSU = 'T' "
    cFor +=             " AND BA1.D_E_L_E_T_ <> '*' "
    cFor +=           " WHERE BA3_FILIAL  = '" + xfilial( 'BA3' ) + "' "
    cFor +=             " AND BA3_CODINT  = '" +       cOpe       + "' "
    cFor +=             " AND BA3_CODEMP >= '" +       cGrupIni   + "' "
    cFor +=             " AND BA3_CODEMP <= '" +       cGrupFim   + "' "
    cFor +=             " AND BA3_DATBAS <= '" + dtos( cDatFin )  + "' "
    cFor +=             " AND BA3_CONEMP >= '" +       cContDe    + "' "
    cFor +=             " AND BA3_CONEMP <= '" +       cContAte   + "' "
    cFor +=             " AND BA3_MATRIC >= '" +       cMatrIni   + "' "
    cFor +=             " AND BA3_MATRIC <= '" +       cMatrFin   + "' "
    cFor +=             " AND BA3_MATANT >= '" +       cMtAnIni   + "' "
    cFor +=             " AND BA3_MATANT <= '" +       cMtAnFin   + "' "
    cFor +=             " AND BA3_SUBCON >= '" +       cSubConI   + "' "
    cFor +=             " AND BA3_SUBCON <= '" +       cSubConF   + "' "
    cFor +=             " AND BA3_CODPLA >= '" +       cCodPlaI   + "' "
    cFor +=             " AND BA3_CODPLA <= '" +       cCodPlaF   + "' "

    if MV_PAR22 == 2 //Lista demitidos ? 1=Sim 2=Nao
        cFor +=         " AND (BA3_DESLIG = ' ' OR BA3_DATDES > '" + dtos( cDatFin ) + "') "
    endif

    if !empty(MV_PAR27) // Vencimento pessoa fisica
        cFor +=         " AND BA3_VENCTO IN (" + alltrim( MV_PAR27 ) + ") "
    endif

    cFor +=             " AND BA3.D_E_L_E_T_ = ' ' "

    if aReturn[8] == 1
        cFor += " Order by BA3_CODINT,BA3_CODEMP,BA3_CONEMP,BA3_SUBCON,BA3_MATRIC "
    else
        cFor += " Order by BA3_CODINT,BA3_CODEMP,BA3_CONEMP,BA3_SUBCON,BA1_NOMUSR "
    endif

    plsquery( cFor , 'TRBBA3' )

// ----------------------------------------------
    memowrite( 'C:\temp\cabr032.sql' , cFor ) // gus
// ----------------------------------------------

    nQtd := 1
    TRBBA3->( dbeval( { | | nQtd ++ } ) )
    BarGauge1Set( nQtd )

    TRBBA3->( dbgotop() )

// ----------------------------------------------
//  [ Monta chaves de quebra ]
// ----------------------------------------------
    cCodEmp := ''
    cCodCon := ''
    cCodSub := ''

    BQC->( dbsetorder( 1 ))

    do while ! TRBBA3->( eof() )

// ----------------------------------------------------------------------------
//      [ Apresenta mensagem em tela ]
// ----------------------------------------------------------------------------
	    incprocg1( 'Familia [' + objCENFUNLGP:verCamNPR( 'BA3_CODINT' , TRBBA3->BA3_CODINT ) + '.' + ;
                                 objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , TRBBA3->BA3_CODEMP ) + '.' + ;
                                 objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , TRBBA3->BA3_MATRIC ) + ']' )
        processmessage()

// ----------------------------------------------------------------------------
//      [ Posiciona o BA3. ]
// ----------------------------------------------------------------------------
        BA3->( dbgoto( TRBBA3->R_E_C_N_O_ ))

// ----------------------------------------------------------------------------
//      [ Verifica tipo de contrato selecionado ]
// ----------------------------------------------------------------------------
        if  nTipCon         <> 3                      .AND. ; // 1=Fisica 2=Juridica 3=Ambas
            BA3->BA3_TIPOUS <> strzero( nTipCon , 1 )

            cMatricFam := BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
            cChave     := BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
            TRBBA3->( dbskip() )
            loop

        endif

// ----------------------------------------------------------------------------
//      [ Se for pessoa juridica, verifica se pertence ao grupo de ]
//      [ cobranca informado nos parametros                        ]
// ----------------------------------------------------------------------------
        if BA3->BA3_TIPOUS == '2'      .AND. ;
		   empty( TRBBA3->BA3_GRPCOB )         // nivel mais alto e o da familia.

            if BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB ) <> ;
               BQC->( BQC_CODIGO + BQC_NUMCON +              BQC_VERCON + BQC_SUBCON + BQC_VERSUB )

                if !BQC->( msseek( xfilial( 'BQC' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )))

                    aadd( aCriticas , { BA3->BA3_CODINT + '.' + BA3->BA3_CODEMP + '.' + BA3->BA3_MATRIC , 'Subcontrato nao encontrado' } )
				
                    cMatricFam := BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
                    cChave     := BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
                    TRBBA3->( dbskip() )
                    loop

                endif

            endif

            if BQC->BQC_GRPCOB < cGrpCIni .OR. ; // Grupo de cobranca inicial
               BQC->BQC_GRPCOB > cGrpCFin        // Grupo de cobranca final

                cMatricFam := BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
                cChave     := BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
                TRBBA3-> ( dbskip() )
                loop

            endif

        else

            if TRBBA3->BA3_GRPCOB < cGrpCIni .OR. ; // Grupo de cobranca inicial
               TRBBA3->BA3_GRPCOB > cGrpCFin        // Grupo de cobranca final

                cMatricFam := BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
                cChave     := BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
                TRBBA3->(dbskip())
                loop

            endif

        endif

// ----------------------------------------------------------------------------
//      [ Verifica se foi abortada a impressao ]
// ----------------------------------------------------------------------------
        if interrupcao( lAbortPrint )
            exit
        endif
	
        if lPrimeiro
            a256cab( .T. , BA3->BA3_CODINT , .T. , BA3->BA3_CODEMP , .T. , BA3->( BA3_CONEMP + BA3_VERCON ) , .T. , BA3->( BA3_SUBCON + BA3_VERSUB ))
            lPrimeiro := .F.
        endif

// ----------------------------------------------------------------------------
//      [ Trata quebras de instituicao ]
// ----------------------------------------------------------------------------
        if BA3->BA3_CODEMP <> cCodEmp

            nVlrDBSub := r256db( cMatricFam , _cAno , _cMes , '3' , cChave , .T. )

// ----------------------------------------------------------------------------
//          [ Imprime totais gerais ]
// ----------------------------------------------------------------------------
            if nTipRel == 2 .AND. lPrSubCon
                @ nLi , 111 pSay transform( nTotCobSub + nVlrDBSub , PLSVALOR )
                lPrSubCon := .F.
            endif

            if ( nTotRegSub > 0 .OR. nVlrDBSub <> 0 ) .AND. !lPF

                if nTipRel == 1
                    r256tot( nColSub , nTotCobSub + nVlrDBSub , 'Total do Subcontrato' )
                endif

                nTotCobSub := 0
                nTotRegSub := 0

            endif

            nTotCobCon += nVlrDBSub
            nTotCobEmp += nVlrDBSub
            nVlrDBCon  := r256db( cMatricFam , _cAno , _cMes , '2' , cChave , .T. )

            if (nTotRegCon > 0 .OR. nVlrDBCon <> 0 .OR. nTotCobCon <> 0) .AND. !lPF

                nLi-- ; r256tot( nColCon , nTotCobCon + nVlrDBCon , 'Total do Contrato' )
                nTotCobEmp += nVlrDBCon
                nTotCobCon := 0
                nTotRegCon := 0

            endif

            if nTotRegEmp > 0 .OR. nTotCobEmp <> 0

                r256tot( nColEmp , nTotCobEmp , 'Total do Grupo/Empresa' )
                nLi ++ ; @ nLi, 0 pSay replicate( '-' , nLimite ) ; nLi++
                a256cab( .F. , BA3->BA3_CODINT , .T. , BA3->BA3_CODEMP , .T. , BA3->( BA3_CONEMP + BA3_VERCON ) , .T. , BA3->( BA3_SUBCON + BA3_VERSUB ))

            endif

// ----------------------------------------------------------------------------
//          [ Remonta dados de quebra ]
// ----------------------------------------------------------------------------
            nTotRegEmp := 0 ; nTotCobEmp := 0
            nTotRegCon := 0 ; nTotCobCon := 0
            nTotRegSub := 0 ; nTotCobSub := 0 ; nVlrDBSub := 0

        endif

// ----------------------------------------------------------------------------
//      [ Trata quebras de empresas ]
// ----------------------------------------------------------------------------
        if BA3->( BA3_CONEMP + BA3_VERCON ) <> cCodCon .AND. BA3->BA3_TIPOUS == '2'

            nVlrDBSub := r256db( cMatricFam , _cAno , _cMes , '3' , cChave , .T. )

// ----------------------------------------------------------------------------
//          [ Imprime totais gerais ]
// ----------------------------------------------------------------------------
            if nTipRel == 2 .AND. lPrSubCon
                @ nLi , 111 pSay transform( nTotCobSub + nVlrDBSub , PLSVALOR )
                lPrSubCon := .F.
            endif

            if ( nTotRegSub > 0 .OR. nVlrDBSub <> 0 ) .AND. !lPF
                if nTipRel == 1
                    r256tot( nColSub , nTotCobSub + nVlrDBSub , 'Total do Subcontrato' )
                endif
                nTotCobSub := 0
                nTotRegSub := 0
            endif

            nTotCobCon += nVlrDBSub
            nTotCobEmp += nVlrDBSub
            nVlrDBCon  := r256db( cMatricFam , _cAno , _cMes , '2' , cChave , .T. )

            if ( nTotRegCon > 0 .OR. nVlrDBCon <> 0 .OR. nTotCobCon <> 0 ) .AND. !lPF

                nLi-- ; r256tot( nColCon , nTotCobCon + nVlrDBCon , 'Total do Contrato' )
                nTotCobEmp += nVlrDBCon
                nTotCobCon := 0
                nTotRegCon := 0
                lPF        := .F.

            endif

// ----------------------------------------------------------------------------
//          [ Remonta dados da quebra ]
// ----------------------------------------------------------------------------
            nTotCobCon := 0 ; nTotRegCon := 0
            nTotCobSub := 0 ; nTotRegSub := 0 ; nVlrDBSub := 0

        endif

// ----------------------------------------------------------------------------
//      [ Trata quebras de Sub-Contrato ]
// ----------------------------------------------------------------------------
        if ( BA3->( BA3_SUBCON + BA3_VERSUB ) <> cCodSub   .AND. ;
		     BA3->BA3_TIPOUS                  == '2'       .AND. ;
			 BA3->BA3_CODEMP                  == cCodEmp ) .OR.  ; // Quebra de subcontrato mesma empresa e mesmo contrato
           ( BA3->( BA3_CONEMP + BA3_VERCON ) != cCodCon   .AND. ;
		     BA3->( BA3_SUBCON + BA3_VERSUB ) == cCodSub   .AND. ;
			 BA3->BA3_TIPOUS                  == '2'       .AND. ;
			 BA3->BA3_CODEMP                  == cCodEmp )         // Quebra de subcontrato mesma empresa e contrato diferente

            nVlrDBSub := r256db( cMatricFam , _cAno , _cMes , '3' , cChave , .T. )

// ----------------------------------------------------------------------------
//          [ Imprime totais gerais ]
// ----------------------------------------------------------------------------
            if nTipRel == 1                             .AND. ;
			   (((nTotRegSub > 0 .OR. nVlrDBSub <> 0  ) .OR.  ;
			   BA3->(BA3_CONEMP+BA3_VERCON) != cCodCon) .AND. !lPF ) .OR. ;
			 ( BA3->(BA3_SUBCON+BA3_VERSUB) <> cCodSub)

                if !empty(cCodSub) .AND. BA3->(BA3_CONEMP+BA3_VERCON) == cCodCon
                    r256tot( nColSub , nTotCobSub + nVlrDBSub , 'Total do Subcontrato' )
                endif

                nTotCobSub := 0
                nTotRegSub := 0
                lPF        := .F.

// ----------------------------------------------------------------------------
//              [ Remonta dados de quebra ]
// ----------------------------------------------------------------------------
                nTotCobSub := 0
                nTotRegSub := 0

                a256cab( .F.                                                                                            , ;
				         cOpe                                                                                           , ;
						 iif(BA3->BA3_CODEMP<>cCodEmp,.T.,.F.)                                                          , ;
						     BA3->BA3_CODEMP                                                                            , ;
						 iif(BA3->(BA3_CONEMP+BA3_VERCON )<>cCodCon,.T.,.F.)                                            , ;
						     BA3->(BA3_CONEMP+BA3_VERCON )                                                              , ;
						 iif(BA3->(BA3_SUBCON+BA3_VERSUB )<>cCodSub .OR. BA3->(BA3_CONEMP+BA3_VERCON)<>cCodCon,.T.,.F.) , ;
						     BA3->(BA3_SUBCON+BA3_VERSUB ))

            elseif nTipRel == 2

                if lPrSubCon .AND. (nTotCobSub > 0 .OR. nVlrDBSub <> 0)
                    @ nLi , 111 pSay transform( nTotCobSub + nVlrDBSub , PLSVALOR )
                endif

                nTotCobSub := 0
                nTotRegSub := 0
                lPF        := .F.
                lPrSubCon  := .T.

                A256Cab( .F. , cOpe , .F. , cCodEmp , .F. , BA3->(BA3_CONEMP+BA3_VERCON) , .T. , BA3->(BA3_SUBCON+BA3_VERSUB) )

            endif

            nTotCobCon += nVlrDBSub
            nTotCobEmp += nVlrDBSub

        endif

// ----------------------------------------------------------------------------
//      [ Incrementa a regua ]
// ----------------------------------------------------------------------------
        bargauge2set( 3 )
        incprocg2( 'Carregando usuarios [' + objCENFUNLGP:verCamNPR( 'BA3_CODINT' , BA3->BA3_CODINT ) + '.' + ;
                                             objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , BA3->BA3_CODEMP ) + '.' + ;
                                             objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , BA3->BA3_MATRIC ) + ']' )
        processmessage()

// ----------------------------------------------------------------------------
//      [ Posiciona o usuario ]
// ----------------------------------------------------------------------------
        BA1->( dbsetorder( 2 ))
        BA1-> (msSeek( xfilial( 'BA1' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )))

        aUsuarios := PLSLOADUSR( TRBBA3->BA3_CODINT , TRBBA3->BA3_CODEMP , TRBBA3->BA3_MATRIC , _cAno , _cMes )

        if len( aUsuarios ) == 0
            cMatricFam := BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
            cChave     := BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
            TRBBA3->( dbskip() )
            loop
        endif

        incprocg2( 'Valor de cobranca [' + objCENFUNLGP:verCamNPR( 'BA3_CODINT' , BA3->BA3_CODINT ) + '.' + ;
                                           objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , BA3->BA3_CODEMP ) + '.' + ;
                                           objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , BA3->BA3_MATRIC ) + ']' )
        processmessage()

// ----------------------------------------------------------------------------
//      [ Apura o valor de cobranca da familia ]
// ----------------------------------------------------------------------------
        aVlrFam := PLSVLRFAM( BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC ) , _cAno , _cMes , , , .T. , aUsuarios , , .T. )

        incprocg2( 'Imprimindo dados [' + objCENFUNLGP:verCamNPR( 'BA3_CODINT' , BA3->BA3_CODINT ) + '.' + ;
                                          objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , BA3->BA3_CODEMP ) + '.' + ;
                                          objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , BA3->BA3_MATRIC ) + ']' )
        processmessage()

// ----------------------------------------------------------------------------
//      [ Monta matriz com valor de cobranca total. ]
// ----------------------------------------------------------------------------
        aValor := aClone( aVlrFam[1] )

// ----------------------------------------------------------------------------
//      [ Matriz que vem lah do vlrfam que contem o total ]
//      [ a ser acumulado na competencia                  ]
// ----------------------------------------------------------------------------
        if len( aVlrFam ) >= 4
            aValAcu := aClone( aVlrFam[4] )
        endif

// ----------------------------------------------------------------------------
//      [ Monta matriz com o detalhe da movimentacao ]
// ----------------------------------------------------------------------------
        if len( aVlrFam ) >= 3 // Se o retorno for apenas criticas, nao sera feito o aClone (tratamento de estouro de array).
            aVlrCO := aClone( aVlrFam[3] )
        endif

        if type( 'aValor' ) <> 'A'
            FWLogMsg('WARN',, 'SIGAPLS', funName(), '', '01', "[SIGAPLS] Retorno da funcao PLSVLRFAM invalida matricula "+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) , 0, 0, {})
            cMatricFam :=  BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
            cChave     :=  BA3->(BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
            lPF        := (BA3->BA3_TIPOUS == '1' )
            TRBBA3->( dbskip() )
            loop
        endif

        if aValor[1] .AND. len( aValor[2] ) > 0
            aValor     := aValor[2]
        else
            cMatricFam :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
            cChave     :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
            lPF        := ( BA3->BA3_TIPOUS == '1' )
            TRBBA3->( dbskip() )
            loop
        endif

        if nCompara == 1

            nValAux := 0

            for n := 1 to len( aValor )
                if ! aValor[n,9]
                    nValAux += aValor[n,2]
                endif
            next n

            if nValAux == BA3->BA3_VALANT
                cMatricFam :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
                cChave     :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
                lPF        := ( BA3->BA3_TIPOUS == '1' )
                TRBBA3->( dbskip() )
                loop
            endif

        endif

        nTotFam := 0
        nTotFaA := 0
        nTotFa2	:= 0
        lTemUsr := .F.

        if lLisMat
            cLinFam := substr( objCENFUNLGP:verCamNPR( 'BA3_MATEMP' , BA3->BA3_MATEMP ) , 1 , 8 )  + ' ' + ;
                               objCENFUNLGP:verCamNPR( 'BA3_CODINT' , BA3->BA3_CODINT )            + '.' + ;
                               objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , BA3->BA3_CODEMP )            + '-' + ;
                               objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , BA3->BA3_MATRIC )            + '-'
        else
            cLinFam := space(9) + objCENFUNLGP:verCamNPR( 'BA3_CODINT' , BA3->BA3_CODINT ) + '.' + ;
                                  objCENFUNLGP:verCamNPR( 'BA3_CODEMP' , BA3->BA3_CODEMP ) + '-' + ;
                                  objCENFUNLGP:verCamNPR( 'BA3_MATRIC' , BA3->BA3_MATRIC ) + '-'
        endif

        BA1->( msseek( xfilial( 'BA1' ) + BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC ) ))

        do while (!BA1->( eof() )) .AND. ( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC == BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC )

            if  nLi > nQtdLin
                a256cab( .T. , BA3->BA3_CODINT , .T. , BA3->BA3_CODEMP , .T. , BA3->( BA3_CONEMP + BA3_VERCON ) , .T. , BA3->( BA3_SUBCON + BA3_VERSUB ))
            endif

// ----------------------------------------------------------------------------
//          [ Verifica as regras de cobranca para usuarios bloqueados ]
// ----------------------------------------------------------------------------
            aCobUsr := AnalisaUsr( _cAno , _cMes )

            if ! aCobUsr[1]
                BA1->( dbskip() )
                loop
            endif

            cLinUsr := objCENFUNLGP:verCamNPR( 'BA1_TIPREG' , BA1->BA1_TIPREG )                                               + space( 02 ) + ;
                       objCENFUNLGP:verCamNPR( 'BA1_TIPUSU' , BA1->BA1_TIPUSU )                                               + space( 02 ) + ;
               substr( objCENFUNLGP:verCamNPR( 'BA1_NOMUSR' , BA1->BA1_NOMUSR ) , 1 , 30 )                                    + space( 02 ) + ;
                       objCENFUNLGP:verCamNPR( 'BA1_DATNAS' , str( calc_Idade( dDataBase , BA1->BA1_DATNAS ) , 2 )) + ' Anos' + space( 10 )
            nTotUsr := 0

            for nFor := 1 to len( aValor )

// ----------------------------------------------------------------------------
//              [ Verifica se o lancamento de faturamento esta na lista dos parametros ]
// ----------------------------------------------------------------------------
                if !empty( cLancFt )
                    if !( aValor[nFor][3] $ cLancFt )
                        loop
                    endif
                endif

// ----------------------------------------------------------------------------
//              [ Tratamento para verificar se o deb/cred pertence a essa familia ]
// ----------------------------------------------------------------------------
                if aValor[nFor,16] = 'BSQ'
                    dbselectarea( 'BSQ' )
                    dbgoto( aValor[nFor,27] )
                    if !BSQ->BSQ_USUARI = aValor[nFor,7]
                        loop
                    endif
                    dbselectarea( 'BA1' )
                endif

                if aValor[nFor,7] == BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) .AND. ! aValor[nFor,9]

                    if nTipRel == 1 // relatorio analitico

                        if (nModPag == 1 .AND. !(aValor[nFor, 3] $ cCodigosPF)) .OR.;
                           (nModPag == 2 .AND.   aValor[nFor, 3] $ cCodigosPF)  .OR.;
                            nModPag == 3

                            if nFor==1
                                aValor[nFor,4] := objCENFUNLGP:verCamNPR( 'BI3_CODIGO' , aValor[nFor,4] )
                                aValor[nFor,5] := objCENFUNLGP:verCamNPR( 'BI3_DESCRI' , aValor[nFor,5] )
                            endif

                            if nMatAnt == 1
                                cLinAux :=    substr( aValor[nFor,4] + '-' + left( aValor[nFor,5] , 25 ) + space(80) , 1 , 22 ) + space(02) + ;
                                           objCENFUNLGP:verCamNPR( 'BA1_MATANT' , BA1->BA1_MATANT )                             + space(13) + ;
                                           transform( aValor[nFor,2] , PLSVALOR )                                               + space(01)
                            else
                                cLinAux :=    substr( aValor[nFor,4] + '-' + aValor[nFor,5] + space(80) , 1 , 41 ) + space(13) + ;
                                           transform( aValor[nFor,2] , PLSVALOR )                                  + space(01)
                            endif

                            nLi ++
                            @ nLi , nColUsr pSay cLinFam + cLinUsr + cLinAux

// ----------------------------------------------------------------------------
//                          [ gus - inicio ]
// ----------------------------------------------------------------------------
// ----------------------------------------------
//                          [ imprime cabecalho ]
// ----------------------------------------------
//                          cTxt := 'Empresa           ;'
//                          cTxt += 'Nº Contrato       ;'
//                          cTxt += 'Nº Subcontrato    ;'
//                          cTxt += 'Matricula         ;'
//                          cTxt += 'Matricula Empresa ;'
//                          cTxt += 'Tipo              ;'
//                          cTxt += 'Nome              ;'
//                          cTxt += 'Idade             ;'
//                          cTxt += 'Plano             ;'
//                          cTxt += 'Rubrica           ;'
//                          cTxt += 'Valor a cobrar    ;'
//                          cTxt += 'Valor previsto    ;'
//                          cTxt += 'Diferença         ;' + chr(13) + chr(10)
//                          fwrite( nHdl , cTxt )
// ----------------------------------------------
// ----------------------------------------------
//                          [ imprime corpo ]
// ----------------------------------------------
                            nValx := aValor[ nFor , 2 ]       // valor
//                          nPrex := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4]),TRBBA3->PREVISTO + TRBBA3->OPCIONAL,0) // previsto
//                          nPrex := u_fPre( aValor[nFor,7] )                                                                    // previsto
                            nPrex := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4]), u_fPre( aValor[nFor,7] ),0)           // previsto
                            nDifx := nValx - nPrex            // diferenca
//                          cRubx := u_fRub( BA1->BA1_CODINT , BA1->BA1_CODEMP )
// ----------------------------------------------
                            cEmpx := "'" + BA3->BA3_CODEMP                      // empresa
                            cConx := "'" + BA3->BA3_CONEMP // + BA3->BA3_VERCON // contrato
                            cSubx := "'" + BA3->BA3_SUBCON // + BA3->BA3_VERSUB // subcontrato
                            cMt1x := "'" + BA3->BA3_MATEMP                      // matricula 1
//                          cMt2x := "'" + BA1->BA1_CODINT + '.' + BA1->BA1_CODEMP + '-' + BA1->BA1_MATRIC + '-' + BA1->BA1_TIPREG                    // Matricula 2
                            cMt2x := "'" + BA1->BA1_CODINT +       BA1->BA1_CODEMP +       BA1->BA1_MATRIC +       BA1->BA1_TIPREG +  BA1->BA1_DIGITO // Matricula 2
                            cTipx := "'" + BA1->BA1_TIPUSU                      // tipo
                            cNomx := "'" + BA1->BA1_NOMUSR                      // nome
                            cNasx := "'" + dtoc( BA1->BA1_DATNAS )              // nascimento
                            cIdax := "'" + str( calc_idade( dDataBase , BA1->BA1_DATNAS ) , 2 ) + " Ano(s)"                        // idade

//                          cPlax := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4])   ,aValor[nFor,4]+'-'+aValor[nFor,5],'') // plano
//                          cRubx := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4]),'',aValor[nFor,4]+'-'+aValor[nFor,5]   ) // rubrica
                            
//                          cPlax := aValor[nFor,4]+'-'+aValor[nFor,5] // plano
//                          cRubx := aValor[nFor,3]+'-'+posicione( 'BM1' , 6 , xfilial( 'BM1' ) + aValor[nFor,7] + aValor[nFor,42] + aValor[nFor,41] + aValor[nFor,3] , 'BM1_DESTIP' ) // rubrica

//                            cPlax := aValor[nFor,4]+'-'+aValor[nFor,5] // plano
////                          cRubx := aValor[nFor,3]+'-'+u_fRub( aValor[nFor,7] , aValor[nFor,3] ) // rubrica
//                            cRubx := aValor[nFor,3]+'-'+posicione( 'BFQ' , 1 , xfilial( 'BFQ' ) + subtr(aValor[nFor,7],1,4) + aValor[nFor,3] , 'BFQ_DESCRI' ) // rubrica


                            cPlax := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4])   ,aValor[nFor,4]+'-'+aValor[nFor,5],'') // plano
                            cRubx := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4]),;
                                                                  aValor[nFor,3]+'-'+posicione( 'BFQ' , 1 , xfilial( 'BFQ' ) + substr(aValor[nFor,7],1,4) + aValor[nFor,3] , 'BFQ_DESCRI' ),; // rubrica
                                                                  aValor[nFor,4]+'-'+aValor[nFor,5]   ) // rubrica


                            cValx := transform( nValx , PLSVALOR ) // valor
                            cPrex := transform( nPrex , PLSVALOR ) // previsto
                            cDifx := transform( nDifx , PLSVALOR ) // diferenca
// -------------------------------
//                          cValx := transform( aValor[ nFor , 2 ] , PLSVALOR ) // valor
//                          cPrex := iif(alltrim(BA1->BA1_CODPLA)=alltrim(aValor[nFor,4]),transform(TRBBA3->PREVISTO + TRBBA3->OPCIONAL,PLSVALOR),transform(0,PLSVALOR)) // previsto
// -------------------------------
                            cTxt := cEmpx + ';'
                            cTxt += cConx + ';'
                            cTxt += cSubx + ';'
                            cTxt += cMt1x + ';'
                            cTxt += cMt2x + ';'
                            cTxt += cTipx + ';'
                            cTxt += cNomx + ';'
                            cTxt += cNasx + ';'
						    cTxt += cIdax + ';'
                            cTxt += cPlax + ';'
                            cTxt += cRubx + ';'
                            cTxt += cValx + ';'
                            cTxt += cPrex + ';'
                            cTxt += cDifx + ';' + chr(13) + chr(10)
                            fwrite( nHdl , cTxt )
// ----------------------------------------------
//                            cTxt := "'" +                              BA3->BA3_CODEMP                                                                         + ';'
//                            cTxt += "'" +                              BA3->BA3_CONEMP + BA3->BA3_VERCON                                                       + ';'
//                            cTxt += "'" +                              BA3->BA3_SUBCON + BA3->BA3_VERSUB                                                       + ';'
//                            cTxt += "'" +                              BA3->BA3_MATEMP                                                                         + ';'
//                            cTxt += "'" +                              BA1->BA1_CODINT + '.' + BA1->BA1_CODEMP + '-' + BA1->BA1_MATRIC + '-' + BA1->BA1_TIPREG + ';'
//                            cTxt += "'" +                              BA1->BA1_TIPUSU                                                                         + ';'
//                            cTxt += "'" +                              BA1->BA1_NOMUSR                                                                         + ';'
//                            cTxt += "'" +                        dtoc( BA1->BA1_DATNAS )                                                                       + ';'
//                            cTxt += "'" + str( calc_idade( dDataBase , BA1->BA1_DATNAS ) , 2 ) + " Anos"                                                       + ';'
//                            cTxt += "'" +                              BA1->BA1_CODPLA + '-' + left( aValor[ nFor , 5 ] , 25 )                                 + ';'
//                            cTxt += "'" +                              'Rubrica?'                                                                              + ';'
//                            cTxt +=                                                       transform( aValor[ nFor , 2 ] , PLSVALOR )                           + ';' + chr(13) + chr(10)
//                            fwrite( nHdl , cTxt )
// ----------------------------------------------
//                          cTxt += transform(( (cAlias)->VALOR_TIT  ) , '@E 99,999,999.99' ) + ';'
//                          cTxt += transform(( (cAlias)->E2_VALOR   ) , '@E 99,999,999.99' ) + ';'
//                          cTxt += transform(( (cAlias)->E2_VALLIQ  ) , '@E 99,999,999.99' ) + ';'
//                          cTxt += transform(( (cAlias)->E2_SALDO   ) , '@E 99,999,999.99' ) + ';'
//                          cTxt +=              cDatIncSis                                   + ';'
//                          cTxt +=              cDatDigNF                                    + ';'
//                          cTxt +=              cDatEmi                                      + ';'
//                          cTxt +=              cDatVct                                      + ';'
//                          cTxt +=              cDatVctRea                                   + ';'
//                          cTxt +=              cDatAgenda                                   + ';'
//                          cTxt +=              cDatBaixa                                    + ';'
//                          cTxt += "'" +      ( cAlias )->ZUO_GRUPO                          + ';' + chr(13) + chr(10)
//                          fwrite( nHdl , cTxt )
// ----------------------------------------------------------------------------
//                          [ gus - fim ]
// ----------------------------------------------------------------------------

                            cLinFam := space(26)
                            cLinUsr := space(56)

                            if aValor[nFor,1] == '1'
                                nTotUsr += aValor[nFor,2]
                            else
                                nTotUsr -= aValor[nFor,2]
                            endif

                        endif

                    else // Relatorio sintetico

                        if (nModPag == 1 .AND. !(aValor[nFor, 3] $ cCodigosPF)) .OR. ;
                           (nModPag == 2 .AND.   aValor[nFor, 3] $ cCodigosPF)  .OR. ;
                            nModPag == 3

                            if aValor[nFor,1] == '1'
                                nTotUsr += aValor[nFor,2]
                            else
                                nTotUsr -= aValor[nFor,2]
                            endif

                        endif

                    endif

                endif

            next nFor

            for nFor := 1 to len( aValAcu )

                if !empty( cLancFt )
                    if !( aValAcu[nFor][3] $ cLancFt )
                        loop
                    endif
                endif

                if aValAcu[nFor,7] == BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) .AND. ! aValAcu[nFor,9]

                    if nTipRel == 1 // relatorio analitico

                        if (nModPag == 1 .AND. !(aValAcu[nFor, 3] $ cCodigosPF)) .OR. ;
                           (nModPag == 2 .AND.   aValAcu[nFor, 3] $ cCodigosPF)  .OR. ;
                            nModPag == 3

                            if nMatAnt == 1
                                cLinAux :=    substr( aValAcu[nFor, 4] + '-' + left( aValAcu[nFor,5] , 25 ) + space(100) , 1 , 22 ) + space(02) + BA1->BA1_MATANT + space(13) + ;
                                           transform( aValAcu[nFor,24] , PLSVALOR ) + space(01)
                            else
                                cLinAux :=    substr( aValAcu[nFor, 4] + '-' + aValAcu[nFor,5] + space(100) , 1 , 41 ) + space(13) + ;
                                           transform( aValAcu[nFor,24] , PLSVALOR ) + space(01)
                            endif

                            nLi ++
                            @ nLi , nColUsr pSay cLinFam + '                **** ACUMULADO 1 ****  ' + cLinAux
                            cLinFam := space(26) // (17)
                            cLinUsr := space(56)

                            if aValAcu[nFor,25] > 0

                                if nMatAnt == 1
                                    cLinAux :=    substr( aValAcu[nFor, 4] + '-' + left( aValAcu[nFor,5] , 25 ) + space(100) , 1 , 22 ) + space(02) + BA1->BA1_MATANT + ;
                                               transform( aValAcu[nFor,25] , PLSVALOR ) + space(01)
                                else
                                    cLinAux :=    substr( aValAcu[nFor, 4] + '-' + aValAcu[nFor,5] + space(100) , 1 , 41 ) + ;
                                               transform( aValAcu[nFor,25] , PLSVALOR ) + space(01)
                                endif

                                nLi ++
                                @ nLi , nColUsr pSay cLinFam + '                **** ACUMULADO 2 ****  ' + cLinAux

                            endif

                            cLinFam := space(26) // (17)
                            cLinUsr := space(56)
                            nTotFaA += aValAcu[nFor,24]
                            nTotFa2 += aValAcu[nFor,25]

                        endif

                    else

                        if (nModPag == 1 .AND. !(aValAcu[nFor, 3] $ cCodigosPF)) .OR. ;
                           (nModPag == 2 .AND.   aValAcu[nFor, 3] $ cCodigosPF)  .OR. ;
                            nModPag == 3

                            nTotFaA += aValAcu[nFor,24]
                            nTotFa2 += aValAcu[nFor,25]

                        endif

                    endif

                endif

            next nFor

// ----------------------------------------------------------------------------
//          [ Imprime a utilizacao em CO do usuario ]
// ----------------------------------------------------------------------------
            if lDetCO == 1 .AND. ( nModPag == 2 .OR. nModPag == 3 ) .AND. empty( cLancFt )

                for nFor := 1 to len( aVlrCO )

                    if aVlrCO[nFor][2] == BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //.AND. ! aValor[nFor,9]

                        if nTipRel == 1 // relatorio analitico

                            if nLi > nQtdLin
                                a256cab( .T. , BA1->BA1_CODINT , .T. , BA1->BA1_CODEMP , .T. , BA1->( BA1_CONEMP + BA1_VERCON ) , .T. , BA1->( BA1_SUBCON + BA1_VERSUB ))
                            endif

// ----------------------------------------------------------------------------
//                          [ Posiciona o BD6 ]
// ----------------------------------------------------------------------------
                            BD6->( dbgoto( aVlrCO[nFor][1] ))

// ----------------------------------------------------------------------------
//                          [ Imprime os detalhes ]
// ----------------------------------------------------------------------------
                            nLi ++
                            @ nLi , nColCO pSay objCENFUNLGP:verCamNPR( 'BD6_DATPRO' ,        dtoc( BD6->BD6_DATPRO ))                                   + ' '       + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_NOMRDA' ,      substr( BD6->BD6_NOMRDA , 1 , 30 ))                          + ' '       + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_CODPRO' ,   transform( BD6->BD6_CODPRO , pesqpict( 'BD6' , 'BD6_CODPRO' ))) + ' '       + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_DESPRO' ,      substr( BD6->BD6_DESPRO , 1 , 40 ))                          + ' '       + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_DENREG' ,              BD6->BD6_DENREG )                                    + space(05) + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_FADENT' , pad( substr( BD6->BD6_FADENT , 1 , 05 ) , 05 ))                   + ' '       + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_CODLDP' ,              BD6->BD6_CODLDP )                                    + space(01) + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_CODPEG' ,              BD6->BD6_CODPEG )                                    + space(03) + ;
                                                objCENFUNLGP:verCamNPR( 'BD6_NUMERO' ,              BD6->BD6_NUMERO )                                    + space(02) + ;
                                                                           iif( lVlrTx , transform( BD6->BD6_VLRTPF , PLSVALOR )                                     , ;
                                                                                         transform( BD6->BD6_VLRPF  , PLSVALOR ) )
                        endif
                    endif
                next nFor
            endif

            nTotFam += nTotUsr
            lTemUsr := .T.
            lImp    := .T.
            BA1->( dbskip() )

        enddo

        if nTipRel == 1 // relatorio analitico

            if lTemUsr  // tem usuario na familia
                if nTotFam > 0 .OR. nFamZer == 1 // Familia tem valor ou eh para imprimir familia sem valor
                    nLi ++
                    @ nLi , 0 pSay cLinFam + space(07) + 'Total da Familia' + replicate( '.' , 96 ) + transform( nTotFam , PLSVALOR )
                endif

                if nTotFaA > 0
                    nLi ++
                    @ nLi , 0 pSay cLinFam + space(07) + 'Total da Familia  **** ACUMULADO 1 ****' + replicate( '.' , 73 ) + transform( nTotFaA , PLSVALOR )
                endif

                if nTotFa2 > 0
                    nLi ++
                    @ nLi , 0 pSay cLinFam + space(07) + 'Total da Familia  **** ACUMULADO 2 ****' + replicate( '.' , 73 ) + transform( nTotFa2 , PLSVALOR )
                endif
            endif

            if nCompara == 1
                nLi ++
                @ nLi , 0       pSay cLinFam   + space(07) + 'TOTAL SIST ANTIGO:' + space(64) + transform( BA3->BA3_VALANT           , PLSVALOR )
                nLi ++
                @ nLi , nColUsr pSay space(17) + space(07) + 'DIFERENCA        :' + space(64) + transform( (nTotFam-BA3->BA3_VALANT) , PLSVALOR )
                nLi ++
                @ nLi , nColUsr pSay space(17) + space(07) + 'MATRICULA ANTIGA :' + space(64) + objCENFUNLGP:verCamNPR( 'BA3_MATANT' , BA3->BA3_MATANT )
            endif

        endif

        nTotCobEmp += nTotFam
        nTotCobCon += nTotFam
        nTotCobSub += nTotFam
        nTotRegEmp += 1
        nTotRegCon += 1
        nTotRegSub += 1

// ----------------------------------------------------------------------------
//      [ Reimprime cabecalho se necessario ]
// ----------------------------------------------------------------------------
        if nLi > nQtdLin
            a256cab( .T. , BA3->BA3_CODINT , .T. , BA3->BA3_CODEMP , .T. , BA3->( BA3_CONEMP + BA3_VERCON ) , .T. , BA3->( BA3_SUBCON + BA3_VERSUB ))
        endif

// ----------------------------------------------------------------------------
//      [ Proxima familia ]
// ----------------------------------------------------------------------------
        cMatricFam :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_MATRIC )
        cChave     :=   BA3->( BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB )
        lPF        := ( BA3->BA3_TIPOUS == '1' )
        TRBBA3->( dbskip() )
        cCodEmp    := BA3->BA3_CODEMP

// ----------------------------------------------------------------------------
//      [ Fim do laco ]
// ----------------------------------------------------------------------------
    enddo

// ----------------------------------------------------------------------------
//  [ Imprime totais ]
// ----------------------------------------------------------------------------
    nVlrDBSub := r256db( cMatricFam , _cAno , _cMes , '3' , cChave , .T. )

    if nTipRel == 1
        if !lPF
            r256tot( nColSub , nTotCobSub + nVlrDBSub , 'Total do Subcontrato' )
        endif
    else
        if lPrSubCon
            @ nLi , 111 pSay transform( nTotCobSub + nVlrDBSub , PLSVALOR )
        endif
    endif

    nTotCobCon += nVlrDBSub
    nTotCobEmp += nVlrDBSub

    if !lPF
        nVlrDBCon := r256db( cMatricFam , _cAno , _cMes , '2' , cChave , .T. )
        nLi-- ; r256tot( nColCon , nTotCobCon + nVlrDBCon , 'Total do Contrato' )
        nTotCobEmp += nVlrDBCon
    endif

    r256tot( nColEmp , nTotCobEmp , 'Total do Grupo/Empresa' )

// ----------------------------------------------------------------------------
//  [ Imprime rodape ]
// ----------------------------------------------------------------------------
    roda( 0 , space(10) )

// ----------------------------------------------------------------------------
//  [ Fecha area de trabalho ]
// ----------------------------------------------------------------------------
    BA3->( dbclearfilter() )
    BA3->( retindex( 'BA3' ))
    TRBBA3->( dbclosearea() )

// ----------------------------------------------------------------------------
//  [ Libera impressao ]
// ----------------------------------------------------------------------------
    if aReturn[5] == 1
        set printer to
        ourspool( crel )
    endif

// ----------------------------------------------------------------------------
//  [ Fim da impressao do relatorio ]
// ----------------------------------------------------------------------------

return( aCriticas )

// +--------------------------------------------------------------------------+
// | Funcao   : r256tot()                                                     |
// +--------------------------------------------------------------------------+
// | Descricao: Imprime totais.                                               |
// +--------------------------------------------------------------------------+
static function r256tot( nColImp , nTotCob , cTit )
    nLi ++
    @ nLi , nColImp pSay cTit
    @ nLi , 144     pSay transform( nTotCob , '@E 999,999,999,999.99' )
return

// +--------------------------------------------------------------------------+
// | Funcao   : r256db()                                                      |
// +--------------------------------------------------------------------------+
// | Descricao: Imprime Débitos e Créditos.                                   |
// +--------------------------------------------------------------------------+
static function r256db( cMatricFam , cAno , cMes , cNivel , cChave , lConsNiv )

    local aVlrDB  := {}
    local nRet    := 0
    local nI      := 0
    local cLinAux := ''
    local cLin    := '(D)ébitos e (C)réditos'
    local cTip    := ''

    cLin   := cLin + space( 63 - len(cLin) )
    aVlrDB := PLSSLDDCF( cMatricFam , cAno , cMes , NIL , NIL , .T. , cNivel , cChave , , lConsNiv )

    for nI := 1 to len( aVlrDB )
	
// ----------------------------------------------------------------------------
//      [ Tratamento para que não calcule os deb/cred dos itens ja calculados na falimilia ]
// ----------------------------------------------------------------------------
        if cNivel $ '1,2'
            if !empty( aVlrDB[nI,13] ) // se pertece a uma familia
                loop
            endif
        endif

        if cNivel == '3'
            BSQ->( dbgoto( aVlrDB[nI,8] )) // se pertece a um usuario já foi considerado na familia
            if !empty( BSQ->BSQ_MATRIC )
                loop
            endif
        endif

        if aVlrDB[nI,5] == '1'
            nRet += aVlrDB[nI,6]
            cTip := '(D)'
        elseif aVlrDB[nI,5] == '2'
            nRet -= aVlrDB[nI,6]
            cTip := '(C)'
        endif

        if nTipRel == 1
            nLi++
            cLinAux := cTip + substr( aVlrDB[nI,3] + '-' + aVlrDB[nI,4] + space(100) , 1 , 40 ) + ;
                           transform( aVlrDB[nI,6] , PLSVALOR )         + space(001)
            if nLi > nQtdLin
//              r256cab( .T. )  // gus
                a256cab( .T. )  // gus
            endif
            @ nLi , nColUsr pSay cLin + cLinAux
            cLin := space(63)
        endif
    next nI

    nLi ++

return( nRet )

// +--------------------------------------------------------------------------+
// | Funcao   : a256cab()                                                     |
// +--------------------------------------------------------------------------+
// | Descricao: Imprime o cabecalho dos grupos empresa/contrato/subcontrato.  |
// +--------------------------------------------------------------------------+
static function a256cab( lCabRel , cOpe , lEmp , cEmp , lCon , cCon , lSub , cSub )

    if lCabRel
        nLi := cabec( cTitulo , cCabec1 , cCabec2 , cNomeProg , cTamanho , iif( aReturn[4]==1 , getmv( 'MV_COMP' ) , getmv( 'MV_NORM' )))
    endif

    if lEmp .AND. !empty(cEmp) // Grupo empresa
        nLi ++ ; @ nLi , nColEmp pSay 'Empresa: ' + objCENFUNLGP:verCamNPR( 'BA1_CODEMP' , cEmp ) + ' - ' + posicione( 'BG9' , 1 , xfilial( 'BG9' ) + ;
                                                    objCENFUNLGP:verCamNPR( 'BA1_CODINT' , cOpe )                                                   + ;
                                                    objCENFUNLGP:verCamNPR( 'BA1_CODEMP' , cEmp ) , 'BG9_DESCRI' )
        cCodEmp := cEmp
    endif

    if ( lCon .OR. lEmp ) .AND. !empty(cCon) // Contrato
        nLi ++ ; @ nLi , nColCon pSay 'Contrato: ' + objCENFUNLGP:verCamNPR( 'BA1_CONEMP' , objCENFUNLGP:verCamNPR( 'BA1_VERCON' , cCon ))
        cCodCon := cCon
    endif

    if ( lSub .OR. lEmp ) .AND. !empty(cSub) // Subcontrato
        nLi ++ ; @ nLi , nColSub pSay 'Subcontrato: ' + objCENFUNLGP:verCamNPR( 'BA1_SUBCON' , objCENFUNLGP:verCamNPR( 'BA1_VERSUB' , cSub )) + ' - ' + posicione( 'BQC' , 1 , xfilial( 'BQC' ) + ;
                                                        objCENFUNLGP:verCamNPR( 'BA1_CODINT' , cOpe ) + ;
                                                        objCENFUNLGP:verCamNPR( 'BA1_CODEMP' , cEmp ) + ;
                                                        objCENFUNLGP:verCamNPR( 'BA1_CONEMP' , objCENFUNLGP:verCamNPR( 'BA1_VERCON' , cCon )) + ;
                                                        objCENFUNLGP:verCamNPR( 'BA1_SUBCON' , objCENFUNLGP:verCamNPR( 'BA1_VERSUB' , cSub )) , 'BQC_DESCRI' )
        cCodSub := cSub
    endif

return NIL

// ----------------------------------------------------------------------------

user function fRub( cxMat , cxTip )

    local cRubAux
    local cQry := ''

    cQry := " SELECT DISTINCT BM1_DESTIP "
    cQry +=   " FROM " + retsqlname( 'BM1' ) + " BM1 "
    cQry +=  " WHERE BM1.D_E_L_E_T_         <> '*' "
    cQry +=    " AND BM1_FILIAL              = '" + xfilial( 'BM1' )         + "' "
    cQry +=    " AND BM1_CODINT              = '" + substr( cxMat , 1 , 4 ) + "' "
    cQry +=    " AND BM1_CODEMP              = '" + substr( cxMat , 5 , 4 ) + "' "
    cQry +=    " AND BM1_MATUSU              = '" +         cxMat           + "' "
    cQry +=    " AND BM1_CODTIP              = '" +         cxTip           + "' "
// ----------------------------------------------
	cQry     := changequery( cQry )
// ----------------------------------------------
    memowrite( 'C:\temp\cabr032_0.sql' , cQry )
// ----------------------------------------------
    if select('TMP0') <> 0
        ('TMP0')->( dbclosearea() )
    endif
    TcQuery cQry Alias 'TMP0' New 
    dbselectarea( 'TMP0' )
// ----------------------------------------------
	if !eof()
        cRubAux := TMP0->BM1_DESTIP
    else
        cRubAux := 'Nao encontrado'
    endif

return cRubAux

// ----------------------------------------------------------------------------

user function fPre( cxMat )

    local nPreAux
    local cQry := ''

    cQry := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, "
    if cEmpresa == 'I'
//      cQry +=    " (RETORNA_VALOR_FAIXA_PRXRE_ALTA('I',TAB1.CODINT                      ,TAB1.CODEMP                      ,TAB1.MATRIC                     ,TAB1.TIPREG                       ,'"+ cCompteI+"01')) COTRPREST ,"
        cQry +=    " (RETORNA_VALOR_FAIXA_PRXRE_ALTA('I','" + substr( cxMat , 1 , 4 ) + "','" + substr( cxMat , 5 , 4 ) + "','" + substr( cxMat , 9 , 6 )+ "','" + substr( cxMat , 15 , 2 ) + "','"+ cComp    + "')) PREVISTO   "
    else
//      cQuery +=  " (RETORNA_VALOR_FAIXA (TAB1.CODINT                      ,TAB1.CODEMP                      ,TAB1.MATRIC                     ,TAB1.TIPREG                       ,'"+cCompteI+ "01')) COTRPREST ,"
        cQuery +=  " (RETORNA_VALOR_FAIXA ('" + substr( cxMat , 1 , 4 ) + "','" + substr( cxMat , 5 , 4 ) + "','" + substr( cxMat , 9 , 6 )+ "','" + substr( cxMat , 15 , 2 ) + "','"+ cComp    + "')) PREVISTO   "
    endif
    cQry +=   " FROM " + retsqlname( 'BA1' ) + " BA1 "
    cQry +=  " WHERE BA1_FILIAL = '" + xfilial( 'BA1' )         + "' "
    cQry +=    " AND BA1_CODINT = '" + substr( cxMat , 01 , 4 ) + "' "
    cQry +=    " AND BA1_CODEMP = '" + substr( cxMat , 05 , 4 ) + "' "
    cQry +=    " AND BA1_MATRIC = '" + substr( cxMat , 09 , 6 ) + "' "
    cQry +=    " AND BA1_TIPREG = '" + substr( cxMat , 15 , 2 ) + "' "
    cQry +=    " AND BA1.D_E_L_E_T_ <> '*' "
// ----------------------------------------------
	cQry     := changequery( cQry )
// ----------------------------------------------
    memowrite( 'C:\temp\cabr032_1.sql' , cQry )
// ----------------------------------------------
    if select('TMP1') <> 0
        ('TMP1')->( dbclosearea() )
    endif
    TcQuery cQry Alias 'TMP1' New 
    dbselectarea( 'TMP1' )
// ----------------------------------------------
	if !eof()
        nPreAux := TMP1->PREVISTO
    else
        nPreAux := 0
    endif

return nPreAux

// ----------------------------------------------------------------------------
// [ fim de cabr032.prw ]
// ----------------------------------------------------------------------------
