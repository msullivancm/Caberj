#INCLUDE "PLSA960.ch"
#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "msmgadd.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} function UPLSA960
description Cadastro de profissional de saúde
A rotina esta sendo copiada do padrão PLSA960 para atender a algumas
validações solicitadas, pois na rotina padrão só existem 3 pontos
de entrada (Filtro , bloqueio e desbloqueio)
@author  Angelo Henrique
@since   date 24/01/2022
@version version
/*/
//-------------------------------------------------------------------

User Function UPLSA960

    Local cFiltro:=""
    PRIVATE cPrePRF   := "00"
    PRIVATE aRotina   := MenuDef()
    PRIVATE cAlias    := "BB0"
    PRIVATE cCadastro := PLSRetTit(cAlias)
    PRIVATE	aCdCores  := {	{ 'BR_VERDE'    ,OemtoAnsi(STR0014) },; //"Profissional de Saude Ativo"
        { 'BR_VERMELHO' ,OemtoAnsi(STR0015) } } //"Profissional de Saude Bloqueado"

    If ExistBlock('PLSA960FIL')
        cFiltro := Execblock('PLSA960FIL',.F.,.F.)
    Endif

    BB0->(DbSetOrder(1))
    If BB0->(FieldPos("BB0_CODBLO")) > 0 .And. PLSALIASEX("B17")
        BB0->(mBrowse(006,001,022,075,"BB0" , ,"BB0->BB0_CODBLO<>Space(03)" , , , Nil    ,, , , ,NIL,,,,cFiltro))
    Else
        BB0->(mBrowse(006,001,022,075,"BB0" , , , , , Nil    ,, , , ,NIL,,,,cFiltro))
    EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function U960MV
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function U960MV(cAlias,nReg,nOpc)

    Local lHomonim	:= SuperGetMV("MV_PLSHOMO",,.F.)  // parametro para Verificacao de Homonimo
    Local _lValid   := .T.
    Local cGETIN 	:= SuperGetMv('MV_XGETIN')
    Local cGERIN	:= SuperGetMv('MV_XGERIN')
    Local cPrfSD    := SuperGetMv('MV_XPRFSD')

    // Inicializa variavel cCadastro para compatibilizar a rotina para ser utilizada pela auditoria...
    If Type('cCadastro') == 'U'
        cCadastro := PLSRetTit(cAlias)
    Endif

    If nOpc == K_Incluir .Or. nOpc == K_Alterar

        If !(RetCodUsr() $ cGETIN) .and. !(RetCodUsr() $ cGERIN) .and. !(RetCodUsr() $ cPrfSD)

            _lValid := .F.

        EndIf

    EndIf

    If _lValid

        If nOpc == K_Incluir
            AxInclui(cAlias,nReg,K_Incluir,nil,nil,nil,'u_P960VLD("I")')
        Endif

        If nOpc == K_Alterar
            If BB0->BB0_VINC == "2"
                AxAltera(cAlias,nReg,K_Alterar,nil,nil,nil,nil,IIF(BB0->(FieldPos("BB0_MATVID")) >0 .and. lHomonim ,'PlsHomoni(M->BB0_NOME,M->BB0_CGC,M->BB0_NUMCR,"","","","",cAlias,M->BB0_MATVID,.F.)',NIL))
            Else

                Aviso("Atenção","Profissional esta vinculado a rede de atendimento, desta forma não pode ser alterado.",{"OK"})

            Endif
        Endif

    Else

        Aviso("Atenção","Usuário sem permissão a esta funcionalidade",{"OK"})

    EndIf

    If nOpc == K_Visualizar
        AxVisual(cAlias,nReg,K_Visualizar)
    Endif

Return

/*/
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??uncao    ?UPLSA960BLO ?Autor ?Sandro Hoffman      ?Data ?13.09.06 ??
???????????????????????????????????????
??escricao ?Bloquear/Desbloquear Profissional de Saude                 ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
/*/
User Function U960BO(cAlias,nReg,nOpc)

    Local oDlg          := Nil
    Local oEnch         := Nil
    Local aPos 	        := {000,000,400,600}        //posição da enchoice na tela
    Local cSvAlias 	    := Alias()
    LOCAL cTitulo       := PLSRetTit(cAlias)
    LOCAL aButtons      := {}
    LOCAL nOrdBB0       := BB0->(IndexOrd())
    LOCAL nRecBB0       := BB0->(Recno())
    LOCAL nOpca         := 0
    Local lBloq         := !Empty(BB0->BB0_CODBLO)
    Local cGETIN 	    := SuperGetMv('MV_XGETIN')
    Local cGERIN	    := SuperGetMv('MV_XGERIN')
    Local cPrfSD        := SuperGetMv('MV_XPRFSD')
    Local _lValid       := .T.

    Private M->BC4_TIPO := If(!Empty(BB0->BB0_CODBLO),"1","0") // Variavel criada para que a consulta padrao BB1PLS funcione

    If !(RetCodUsr() $ cGETIN) .and. !(RetCodUsr() $ cGERIN) .and. !(RetCodUsr() $ cPrfSD)

        _lValid := .F.

    EndIf

    If _lValid

        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 355,600 PIXEL

        oDlg:lMaximized := .T.
        RegToMemory("B17", .T. )

        aAdd(aButtons, {"HISTORIC",{|| U960HISBLO() },OemtoAnsi(STR0007),OemtoAnsi(STR0008)}) //"Historico de (Des)bloqueio"###"Historico"

        oEnch := B17->(MsMGet():New("B17",nReg,K_Alterar,,,,,aPos,,,,,,oDlg,,,.F.))

        oEnch:oBox:align := CONTROL_ALIGN_ALLCLIENT

        BB0->(DbSetOrder(nOrdBB0))
        BB0->(DbGoTo(nRecBB0))

        M->B17_CODPFS := BB0->BB0_CODIGO
        M->B17_NOMPFS := BB0->BB0_NOME
        M->B17_TIPO   := If(lBloq,"1","0")
        lRefresh      := .T.

        ACTIVATE MSDIALOG oDlg CENTER ON INIT EnchoiceBar(oDlg,{||IIF(U960Ok()  ,(nOpca:=1, oDlg:End()) ,nOpca:=0)}, {||oDlg:End()},,aButtons)

        If nOpca == 1

            PLUPTENC("B17",K_Incluir)

            If ! lBloq
                //????????????????????????????????????
                //?Bloqueio...                                                         ?
                //????????????????????????????????????
                BB0->(RecLock("BB0",.F.))
                BB0->BB0_CODBLO := M->B17_MOTBLO
                BB0->BB0_DATBLO := M->B17_DATA
                BB0->(MsUnLock())

                //????????????????????????????????????
                //?Ponto de entrada para o bloqueio...                                 ?
                //????????????????????????????????????
                If ExistBlock("PLS360BLQ")
                    ExecBlock("PLS360BLQ",.F.,.F.,{nOpc})
                Endif

            Else

                BB0->(RecLock("BB0",.F.))
                BB0->BB0_CODBLO := ""
                BB0->BB0_DATBLO := ctod("")
                BB0->(MsUnLock())

                //????????????????????????????????????
                //?Ponto de entrada para o desbloqueio...                              ?
                //????????????????????????????????????
                If ExistBlock("PLS360DSBLQ")
                    ExecBlock("PLS360DSBLQ",.F.,.F.,{nOpc})
                Endif

            Endif

        EndIf

        BB0->(DbCommitAll())

        BB0->(DbSetOrder(nOrdBB0))
        BB0->(DbGoTo(nRecBB0))

    Else

        Aviso("Atenção","Usuário sem permissão a esta funcionalidade",{"OK"})


    EndIf

    If !Empty(cSvAlias)
        DbSelectArea(cSvAlias)
    EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function U960HISBLO
description Consulta o historico de bloqueio do Profissional de Saude
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function U960HISBLO()

    Local aCabB17   := {}
    Local aDadB17   := {}
    Local aTrbB17   := {}
    Local nOpca     := 1
    Local oBrwB17   := Nil
    Local oDlg      := Nil

    B17->(DbSetOrder(1)) //B17_FILIAL + B17_CODPFS + DTOS(B17_DATA) + B17_HORA
    If  B17->(MsSeek(xFilial("B17")+M->B17_CODPFS))
        DEFINE MSDIALOG oDlg TITLE 'Historico (Des)bloqueio' FROM 009,010 TO 029,110 OF GetWndDefault()
        Store Header "B17" TO aCabB17 For .T. .and. SX3->X3_CAMPO <> "B17_CODPFS" .and. SX3->X3_CAMPO <> "B17_NOMPFS"
        Store COLS 	"B17" TO aDadB17 From aCabB17 VETTRAB aTrbB17 While xFilial("B17")+M->B17_CODPFS == B17->(B17_FILIAL+B17_CODPFS)
        oBrwB17  := TPLSBrw():New(030 ,001 ,395 ,150 ,nil ,oDlg ,nil ,{|| nil } ,nil ,nil  ,nil , .T., nil, .T. , nil ,aCabB17 ,aDadB17 ,.F. ,"B17" ,K_Visualizar,OemtoAnsi(STR0009),nil,nil,nil,aTrbB17,,,) //"Hist?ico (Des)bloqueio dos Profissionais de Sa?e"
        ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar( oDlg, {|| nOpca := 1,oDlg:End()}, {|| nOpca := 2,oDlg:End()} )
    Else
        Aviso( OemtoAnsi(STR0010),OemtoAnsi(STR0011),{ OemtoAnsi(STR0012) }, 2 )//"Profissional de Sa?e"###"N? existe Hist?ico de (Des)bloqueio para este Profissional de Sa?e."###"Ok"
    Endif

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function U960DEL
description Deleta o profissional de saude
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function U960DEL(cAlias,nReg,nOpc)

    Local lRet      := .T.
    Local cGETIN 	:= SuperGetMv('MV_XGETIN')
    Local cGERIN	:= SuperGetMv('MV_XGERIN')
    Local cPrfSD    := SuperGetMv('MV_XPRFSD')
    Local _lValid   := .T.

    If !(RetCodUsr() $ cGETIN) .and. !(RetCodUsr() $ cGERIN) .and. !(RetCodUsr() $ cPrfSD)

        _lValid := .F.

    EndIf

    If _lValid

        If BB0->BB0_VINC == "2"
            lRet:=u_P960VLD('D')
            if lRet
                AxDeleta(cAlias,nReg,K_Excluir)
            Endif
        Else
            Aviso("Atenção","Profissional esta vinculado a rede de atendimento, desta forma não pode ser excluido.",{"OK"})
        Endif

    Else

        Aviso("Atenção","Usuário sem permissão a esta funcionalidade",{"OK"})

    EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function UP960LG
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function U960LG()

    BrwLegenda(cCadastro,"Status" ,aCdCores)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function MenuDef
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function MenuDef()

    Private aRotina := {	{ STR0001 , 'AxPesqui' 	 , 0, K_Pesquisar     , 0, .F.},; //"Pesquisar"
        { STR0002 , 'U_U960MV'  , 0, K_Visualizar    , 0, Nil},; //"Visualizar"
        { STR0003 , 'U_U960MV'  , 0, K_Incluir       , 0, Nil},; //"Incluir"
        { STR0004 , 'U_U960MV'  , 0, K_Alterar       , 0, Nil},; //"Alterar"
        { STR0005 , 'U_U960DEL' , 0, K_Excluir       , 0, Nil},;
        { STR0006 , 'U_U960BO'  , 0, K_Excluir       , 0, Nil},;
        { STR0016 , 'U_U960LG'  , 0, 0               , 0, .F.}}

    AADD(aRotina,{ 'Especialidade'	, 'u_P960ESP' , 0, K_Alterar        , 0, .F.})

Return(aRotina)

//-------------------------------------------------------------------
/*/{Protheus.doc} function U960Ok
description Rotina responsavel por validar a inclusao do
            bloqueio/desbloqueio do profissional de saude
@author  author Angelo Henrique
@since   date 26/01/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function U960Ok

    Local _lRet := .T.

    If Empty(M->B17_DATA)

        _lRet := .F.

        Aviso("Atenção","Campo data não preenchido, favor preencher.",{"OK"})

    ElseIf Empty(M->B17_HORA)

        _lRet := .F.

        Aviso("Atenção","Campo hora não preenchido, favor preencher.",{"OK"})

    ElseIf Empty(M->B17_MOTBLO)

        _lRet := .F.

        Aviso("Atenção","Campo motivo do bloqueio não preenchido, favor preencher.",{"OK"})

    EndIf

Return _lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function p960VlEp
description Rotina copiada do padrão para validar a especialidade.
@author  author Angelo Henrique
@since   date 31/01/2022
@version version
/*/
//-------------------------------------------------------------------
User Function p960VlEp()

    LOCAL nOrdBQ1 := BQ1->(IndexOrd())
    LOCAL nRecBQ1 := BQ1->(Recno())
    LOCAL lRet := (Vazio() .or. ExistCpo("BAQ",M->BQ1_CODINT+M->BQ1_CODESP))
    If lRet
        BQ1->(DbSetORder(1))
        lRet := !BQ1->(MsSeek(xFilial("BQ1")+M->BQ1_CODIGO+M->BQ1_CODESP))
        If !lRet
            Aviso("Atenção","Já existe esta especialidade cadastrada para o profissinal selecionado.",{"OK"})
        Endif
    Endif
    BQ1->(DbGoTo(nRecBQ1))
    BQ1->(DbSetOrder(nOrdBQ1))
return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function P960VLD
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function P960VLD(cTp)

    Local lRet	    := .T.
    Local lHomonim	:= SuperGetMV("MV_PLSHOMO",,.F.)  // parametro para Verifica?o de Homonimo
    Local aChaves   :={}
    Local _cCHvBB0  := ""
    Local _cNome    := ""
    Local _cCGC     := ""
    Local _cNumCr   := ""
    Local _cMatVid  := ""
    Local _cCodig   := ""

    Default cTp     := ""

    If valtype(M->BB0_ESTADO) == "U"

        _cCHvBB0    := BB0->(BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE)
        _cNome      := BB0->BB0_NOME
        _cCGC       := BB0->BB0_CGC
        _cNumCr     := BB0->BB0_NUMCR
        _cMatVid    := BB0->BB0_MATVID
        _cCodig     := BB0->BB0_CODIGO

    Else

        _cCHvBB0    := M->(BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE)
        _cNome      := M->BB0_NOME
        _cCGC       := M->BB0_CGC
        _cNumCr     := M->BB0_NUMCR
        _cMatVid    := M->BB0_MATVID
        _cCodig     := M->BB0_CODIGO

    EndIf

    //????????????????????????????????????
    //?Validacao															?
    //????????????????????????????????????
    If cTp == 'I'
        BB0->(DbSetOrder(4)) //BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG + BB0_CODOPE
        If BB0->( MsSeek(xFilial("BB0") + _cCHvBB0) )
            MsgAlert('Profissional de Saude ja cadastrado')
            lRet := .F.
        EndIf
        If lRet .And. BB0->(FieldPos("BB0_MATVID")) >0 .And. lHomonim
            PlsHomoni(_cNome,_cCGC,_cNumCr,"","","","","BB0",_cMatVid,.T.)
        Endif

        If lRet
            BB0->(DbSetOrder(1)) //BB0_FILIAL + BB0_CODIGO
            If BB0->( MsSeek(xFilial("BB0")+_cCodig ) )
                MsgAlert('Codigo de Profissional de Saudee ja cadastrado')
                lRet := .F.
            EndIf

        Endif
    Else

        DbSelectArea("BAU")
        BAU->(DbSetOrder(5)) //BAU_FILIAL + BAU_CODBB0
        If BAU->( MsSeek(xFilial("BAU")+BB0->BB0_CODIGO ) )
            MsgAlert('Existe relacionamento deste Profissional de Saude com uma Rede de Atendimento')
            lRet := .F.
        EndIf

        If lRet
            //Procura por solicitante

            aadd(aChaves,{"B44","B44_CDPFSO",BB0->BB0_CODIGO})
            aadd(aChaves,{"BD5","BD5_CDPFSO",BB0->BB0_CODIGO})
            aadd(aChaves,{"BD6","BD6_CDPFSO",BB0->BB0_CODIGO})
            aadd(aChaves,{"BEA","BEA_CDPFSO",BB0->BB0_CODIGO})
            aadd(aChaves,{"BE2","BE2_CDPFSO",BB0->BB0_CODIGO})

            lRet := PLSCHKDEL(aChaves)

            If lRet
                //Procura por executate
                aChaves:={}
                aadd(aChaves,{"B44","B44_CDPFRE",BB0->BB0_CODIGO})
                aadd(aChaves,{"BD5","BD5_CDPFRE",BB0->BB0_CODIGO})
                aadd(aChaves,{"BD6","BD6_CDPFRE",BB0->BB0_CODIGO})
                aadd(aChaves,{"BC1","BC1_CODPRF",BB0->BB0_CODIGO})
                aadd(aChaves,{"BEA","BEA_CDPFRE",BB0->BB0_CODIGO})
                aadd(aChaves,{"BE2","BE2_CDPFRE",BB0->BB0_CODIGO})

                lRet := PLSCHKDEL(aChaves)
            Endif

        Endif
    EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function P960ESP
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function P960ESP

    Private aRotina := {	{ 'Pesquisar' 	, 'AxPesqui' 		, 0, K_Pesquisar , 0, .F.},; //"Pesquisar"
        { 'Incluir' 	, 'u_UPLSEPM' 	, 0, K_Incluir, 0, Nil},; //"Incluir"
        { 'Alterar' 	, 'AxAltera' 	, 0, K_Alterar   , 0, Nil},; //"Alterar"
        { 'Excluir' 	, 'AxDeleta' 	, 0, K_Excluir   , 0, Nil},; //'Excluir'
        { 'Visualizar' 	, 'AxVisual' 	, 0, K_Visualizar   , 0, Nil}}
    PRIVATE cAlias    := "BQ1"
    PRIVATE cCadastro := PLSRetTit(cAlias)


    cFiltro := "@BQ1_FILIAL = '"+xFilial("BQ1")+"' AND BQ1_CODIGO = '"+BB0->BB0_CODIGO+"' AND D_E_L_E_T_ = ' '"

    DbSelectArea("BQ1")
    SET FILTER TO &cFiltro
    MsSeek(xFilial("BQ1"))
    BQ1->(mBrowse(006,001,022,075,"BQ1" , , , , , Nil    ,, , , ,NIL))
    SET FILTER TO

return

//-------------------------------------------------------------------
/*/{Protheus.doc} function PLSESPMOV
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
User Function UPLSEPM(cAlias,nReg,nOpc)

    BAU->(DbSetORder(5))
    If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
        MsgStop('A manuten?o das especialidades deste profissional deve ser realizado pelo cadastro de RDA')
    else
        AxInclui(cAlias,nReg,K_Incluir,nil,nil,nil,'Iif(Empty(M->BQ1_CODESP),Eval({|| MsgStop("Informe a especialidade"),.F.}),.T.)')
    Endif

return