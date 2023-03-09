//#INCLUDE 'PROTHEUS.CH'
//#INCLUDE  'GPEA011.CH'
//#INCLUDE 'FWMVCDEF.CH'
//#INCLUDE 'FWBROWSE.CH'

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'FWBROWSE.CH'

Static lGPE11ROT := existblock( 'GPE11ROT' )

// +--------------------------+----------------------------------+------------+
// | Programa : caba225.prw   | Autor : Gustavo Thees            | 20/05/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : caba225() ( adaptada da função padrão GPEA011() )             |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado 72261 - Filtro de registros por usuário / processo    |
// +--------------------------------------------------------------------------+

//   Function GPEA011
user function caba225()

// [ gus ]---------------------------------------
    local   aGPEFun   := &( getnewpar( 'MV_XGPEFUN', '{}' ))
    local   cCodUsr   := retcodusr()
    local   nPos      := ascan( aGPEFun , { |x| x[1] == cCodUsr } )
    local   lUsr      := nPos > 0
    local   cFiltro   := ''
// ----------------------------------------------
    local   cFiltraRh
    local   aIndexSRA := {}
// ----------------------------------------------
//  Funcionarios
    private aFuncion
//  Dependentes
    private aDependen
//  Beneficiarios
    private aBenefic
//  Programacao de Ferias
    private aProgFer
//  Afastamento
    private aAfastam
//  Historico Salario
    private aHistor
//  Transferencia
    private aTransf
//  Periodos de Estabilidade
    private aPerEstab
//  Func. Temporarios
    private aFuncTemp
// ----------------------------------------------
//  Criar a opcao de menu Trajetoria Laboral somente se o pais for o Mexico
    if cPaisLoc $ 'MEX|COS'
//      Trajetoria Laboral
        private aTrajet
//      Turnos -- Troca de Turnos
        private aTurno
    endif
// ----------------------------------------------
//  Lancamentos Mensais
    private aMensais
//  Lancamentos Futuros
    private aFuturos
//  Acumulados
    private aAcumul
//  Recibo de Pgto
    private aRecibo
//  Tarefas
    private aTarefas
    private aVal13
    private aFunc
    private aLancam
//  private aRotina    := menudef()                       // gus
    private aRotina    := FWLoadMenuDef("gpea011") //staticcall( gpea011 , menudef ) // gus

    private bFiltraBrw := { || NIL }

//  Define o cabecalho da tela de atualizacoes
//  private cCadastro  := OemToAnsi( STR0032          )  //"Cadastro Geral"
    private cCadastro  := OemToAnsi( 'Cadastro Geral - Teste' )

    private lGPEA011   := .F.

    private aDep                                         // Vetor para armazenar dados dos Dependentes   , utilizado qdo nOpc = 7
    private aBenef                                       // Vetor para armazenar dados dos Beneficiarios , utilizado qdo nOpc = 7

// [ gus ]---------------------------------------
////  Inicializa o filtro utilizando a funcao FilBrowse
//    cFiltraRh  := chkrh( 'GPEA011' , 'SRA' , '1' )
//    bFiltraBrw := {|| filbrowse( 'SRA' , @aIndexSRA , @cFiltraRH ) }
//    eval( bFiltraBrw )
// ----------------------------------------------
    if lUsr
        cFiltro := "SRA->RA_MAT >= '" + aGPEFun[nPos][2] + "' .AND. SRA->RA_MAT <= '" + aGPEFun[nPos][3] + "' "
        dbselectarea( 'SRA' )
        SET FILTER TO &cFiltro
    else
        cFiltraRh  := chkrh( 'GPEA011' , 'SRA' , '1' )
        bFiltraBrw := {|| filbrowse( 'SRA' , @aIndexSRA , @cFiltraRH ) }
        eval( bFiltraBrw )
    endif
// ----------------------------------------------

//  Endereca a funcao de BROWSE
    dbselectarea( 'SRA' )
    mbrowse( 06 , 01 , 22 , 75 , 'SRA' , , , , , , fcriacor() )

//  Deleta o filtro utilizando a funcao FilBrowse
    endfilbrw( 'SRA' , aIndexSra )

//  Retorna o SET EPOCH padrao do framework
    if( findfunction( 'RetPadEpoch' ))
        retpadepoch()
    endif

return

// ----------------------------------------------------------------------------
// [ fim de caba225.prw ]
// ----------------------------------------------------------------------------
