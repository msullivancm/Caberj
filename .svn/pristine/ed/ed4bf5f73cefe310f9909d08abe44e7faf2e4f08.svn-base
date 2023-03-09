#INCLUDE 'PROTHEUS.CH'
#INCLUDE  'PLSMGER.CH'
#INCLUDE "Plsa730.ch"

// +--------------------------+----------------------------------+------------+
// | Programa : caba227.prw   | Autor : Gustavo Thees            | 01/06/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : caba227() ( adaptada da rotina padrão PLSA730.PRW )           |
// +--------------------------------------------------------------------------+
// | Descricao: Chamado Fred                                                  |
// +--------------------------------------------------------------------------+

//   Function PLSA730
user function caba227()

// ----------------------------------------------
// [ variaveis local - gus ini ]
// ----------------------------------------------
    local aRegra    := strtokarr2( supergetmv( 'MV_XUSXEMP' , , '000000|001727-01+0001|0002|0003' ) , '-' )
    local cUsuarios := alltrim(  aRegra[1] )                                                                // Usuarios a restringir
    local aOpeEmp   := strtokarr2(  aRegra[2] , '+' )
    // local cEmpresa  := alltrim(          aOpeEmp[1] )                                                       // Caberj / Integral
//  local cGrpEmp   := alltrim( strtran( aOpeEmp[2] , '|' , "','" ) )                                       // Grupos/Empresas a apresentar
    local cFiltro   := ''
    Local lBiomet   := SuperGetMv("MV_BIOCONF",,.F.)
    LOCAL cCodUsr 	:= PLSRtCdUsr()
    Local cGrpEmp  := ""                                       // Grupos/Empresas a apresentar


// ----------------------------------------------
// [ variaveis local - gus fim ]
// ----------------------------------------------

// ----------------------------------------------
//  [ variaveis private ]
// ----------------------------------------------
    private cCadastro := 'Consulta Posição do Usuário'
    private aRotina   := {	{ STR0001	, 'AxPesqui'   ,  0, K_Pesquisar 	, 0, .F.},; //"Pesquisar"
                            { STR0002	, 'plSA730Mov' ,  0, K_Visualizar	, 0, Nil},; //"Contrato"
                            { STR0003	, 'pl700Mov'   ,  0, 3           	, 0, Nil},; //"Financeira"
                            { STR0004	, 'pl700Mov'   ,  0, 4           	, 0, Nil},; //"Movimentacao"
                            { STR0005	, 'pl700Mov'   ,  0, 5           	, 0, Nil},;
                            { STR0007	, 'PL700Mov'   ,  0, 6           	, 0, Nil},; //"Grupo Carencia"
                            { STR0008	, 'PL700Mov'   ,  0, 7           	, 0, Nil},; //"Classe Carencia"
                            { STR0009	, 'PLSC005'    ,  0, 8           	, 0, Nil},; //"Cobert/Carencia"
                            { STR0010	, 'PL700MOV'   ,  0, 9	          	, 0, Nil},; //"Grupo Cobert."
                            { STR0011	, 'PL700MOV'   ,  0, 10          	, 0, Nil},; //"Custo/Receita"
                            { STR0017	, 'PL730RDA'   ,  0, 11          	, 0, Nil} } //"Rede Atendimento"
    
    If lBiomet
        AaDd( aRotina,{ STR0020 ,'PLSBIOMET("BTS",BA1->BA1_MATVID,.T.,"2")' , 0 , 12 } )
        AaDd( aRotina,{ STR0021 ,'PLSBIOMET("BTS",BA1->BA1_MATVID,.T.,"1")' , 0 , 13 } )
    EndIf

// ----------------------------------------------
// [ filtro - gus ini ]
// ----------------------------------------------

    BX4->(DbSetOrder(1))
If BX4->(MsSeek(xFilial("BX4")+cCodUsr+PlsIntPad())) // BX4_FILIAL+BX4_CODOPE+BX4_CODINT

	IF !EMPTY(BX4->BX4_XEMP)
		cGrpEmp := Alltrim(StrTran(BX4->BX4_XEMP,",","|"))
	ENDIF

Endif

IF !EMPTY(cGrpEmp)
// if RetCodUsr() $ cUsuarios
        if cEmpAnt == "02"
//          cFiltro += iif( !empty( cFiltro ) , " AND" , "@" ) + " BE4_CODEMP IN ('" + cGrpEmp    + "')"
            cFiltro +=                                           " BA1_CODEMP $  ('" + cGrpEmp + "')"
        else
//          cFiltro += iif( !empty( cFiltro ) , " AND" , "@" ) + " BE4_FILIAL =  'ZZ'"
            cFiltro +=                                           " BA1_FILIAL == 'ZZ'"
        endif
    endif
    dbselectarea( 'BA1' )
    BA1->( dbsetorder( 1 ) )
    SET FILTER TO &cFiltro
// ----------------------------------------------
// [ filtro - gus fim ]
// ----------------------------------------------

    BA1->( dbgotop() )

    if existblock( 'PL730COR' )
        aAuxCor  := execblock( 'PL730COR' , .F. , .F. )
        aCores   := aAuxCor[1]
        aCdCores := aAuxCor[2]
    else

//      aCores := { { "(BA1->BA1_MOTBLO<>Space(03))" , 'BR_VERMELHO' } , ;
//                  {  "BA1->BA1_MOTBLO==Space(03)"  , 'BR_VERDE'    } }

        aCores := { { "(BA1->BA1_MOTBLO==Space(03) .AND. BA1->BA1_DATINC >  dDataBase )" , 'BR_BRANCO'   } , ;
                    { "(BA1->BA1_MOTBLO<>Space(03) .AND. BA1->BA1_DATBLO <= dDataBase )" , 'BR_VERMELHO' } , ;
                    {  "BA1->BA1_MOTBLO==Space(03)"                                      , 'BR_VERDE'    } , ;
                    { "(BA1->BA1_MOTBLO<>Space(03) .AND. BA1->BA1_DATBLO > dDataBase )"  , 'BR_AMARELO'  } }

        aCdCores := { { 'BR_VERDE'    , oemtoansi( 'Usuário Ativo'     ) } , ; //'Usuario ativo'
                      { 'BR_VERMELHO' , oemtoansi( 'Usuário Bloqueado' ) } }   //'Usuario Bloqueado'

    endif

    BA1->( mBrowse( 06 , 01 , 22 , 75 , 'BA1' , , , , , , aCores , , , , , .T. ) )

return

// ----------------------------------------------
// [ fim de caba227.prw ]
// ----------------------------------------------
