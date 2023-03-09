#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA086
description
    Rotina respons√°vel pelas integra√ß√µes com UNIMED S√£o Jose do
    Rio Preto
@author  Luiz Ot·vio Campos
@since   23/03/2021
@version 1.0
/*/
//-------------------------------------------------------------------

User Function CABA086

    Private aCabec    := {}
    Private aDados    := {}
    Private a_ItFim     := {}
    Private _cAlias2  := GetNextAlias()
    Private cPerg  := "CABX086"
    Private oOk       		:= LoadBitmap( GetResources() , "LBOK" 	   ) // Marcado
    Private oNo       		:= LoadBitmap( GetResources() , "LBNO" 	   ) // Desmarcado
    Private oVerde      	:= LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
    Private oVermelho   	:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
    Private aListBenefic	:= {}
    Private aTitListBenefic := {}
    Private aSizeListBenefic:= {}
    Private bLinesBenefic	:= { || }
    Private lMarcaDesmarca  := .T.

    Private lExec           :=.F.
    Private nPosMarcado		:= 01
    Private nPosInt		    := 02
    Private nPosEmpr	    := 03
    Private nPosMatr		:= 04
    Private nPosTpReg		:= 05
    Private nPosDgto		:= 06
    Private nPosNome		:= 07
    Private nPosMatVd		:= 08
    Private nPosBA1		    := 09
    Private nPosBTS		    := 10

    AjustaSx1(cPerg)

    IF !Pergunte(cPerg, .T.)
        Return
    Endif


    //-----------------------------------------
    //Monta Cabe√ßalho
    //-----------------------------------------
    CABA086A()

    //-----------------------------------------
    //Monta Query
    //-----------------------------------------
    DbSelectArea( "BA1" )
    MsgRun( "Carregando Beneficiarios, aguarde...", "Carregando Beneficiarios, aguarde...", { || CABA086B( ) } )



    //------------------------------------------------
    // Monta a Tela de Sele√ß√£o dos beneficiarios
    //-------------------------------------------------
    CABA086C()


    //------------------------------------------------------------
    // Monta array com os dados selecionados e faz a impress√£o
    //-----------------------------------------------------------

    If lExec
        MsgRun( "Extraindo Beneficiarios, aguarde...", "Extraindo Beneficiarios, aguarde...", { || CABA086D()} )
    EndIF
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA086A
description Monta o cabe√ßalho
@author  Angelo
@since   05/04/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA086A

    aAdd(aCabec, "MIGRA«√O")
    aAdd(aCabec, "TIPO DE OPERACAO")
    aAdd(aCabec, "NOME")
    aAdd(aCabec, "COD CARTEIRA BENEFICIARIO")
    aAdd(aCabec, "TITULAR")
    aAdd(aCabec, "COD CARTEIRA TITULAR")
    aAdd(aCabec, "DATA NASC")
    aAdd(aCabec, "ESTADO CIVIL")
    aAdd(aCabec, "NACIONALIDADE")
    aAdd(aCabec, "SEXO")
    aAdd(aCabec, "NOME DA MAE")
    aAdd(aCabec, "CPF")
    aAdd(aCabec, "RG")
    aAdd(aCabec, "DATA EMISSAO RG")
    aAdd(aCabec, "UF EMISSOR")
    aAdd(aCabec, "ORGAO EMISSOR")
    aAdd(aCabec, "PAIS EMISSOR")
    aAdd(aCabec, "RG ESTRANGEIRO")
    aAdd(aCabec, "EMAIL")
    aAdd(aCabec, "CEP")
    aAdd(aCabec, "ENDERECO")
    aAdd(aCabec, "NUMERO")
    aAdd(aCabec, "COMPLEMENTO")
    aAdd(aCabec, "BAIRRO")
    aAdd(aCabec, "CIDADE")
    aAdd(aCabec, "ESTADO")
    aAdd(aCabec, "TELEFONE")
    aAdd(aCabec, "CELULAR")
    aAdd(aCabec, "CODIGO CBO")
    aAdd(aCabec, "MATRICULA")
    aAdd(aCabec, "DATA ADMISSAO")
    aAdd(aCabec, "NR CTPS")
    aAdd(aCabec, "SERIE CTPS")
    aAdd(aCabec, "UF EMISSOR CTPS")
    aAdd(aCabec, "GRAU PARENTESCO")
    aAdd(aCabec, "VINCULO ESTIPULANTE")
    aAdd(aCabec, "LOCAL REPASSE")
    aAdd(aCabec, "NR MOTIVO RESCISAO")
    aAdd(aCabec, "NR CARTAO SUS")
    aAdd(aCabec, "COD DECLARACAO NASC VIVO")
    aAdd(aCabec, "OBSERVACOES")
    aAdd(aCabec, "PLANO")
    aAdd(aCabec, "MATRICULA FAMILIA")
    aAdd(aCabec, "PIS")
    aAdd(aCabec, "TITULO DE ELEITOR")
    aAdd(aCabec, "TIPO LOGRADOURO")
    aAdd(aCabec, "NOME DO PAI")
    aAdd(aCabec, "MUNICIPIO NASC")
    aAdd(aCabec, "ESTADO NASC")
    aAdd(aCabec, "DT RESCISAO")
    aAdd(aCabec, "SCA")
    aAdd(aCabec, "FAIXA SALARIAL")
    aAdd(aCabec, "LOCALIZACAO")
    aAdd(aCabec, "TABELA PRECO")
    aAdd(aCabec, "DT ADESAO")
    aAdd(aCabec, "DATA ADOCAO")
    aAdd(aCabec, "NR MOTIVO INCLUSAO")
    aAdd(aCabec, "NR CODIGO EXTERNO")
    aAdd(aCabec, "NR SUBESTIPULANTE")

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA086B()
description Rotina par amontar a query
@author  Angelo Henrique
@since   05/04/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA086B()

    Local  cAliasTRB    := GetNextAlias()
    Local _cQuery       := ""
    Local cCodIntDe     := Substr(MV_PAR01,1,4)
    Local cCodEmpDe     := Substr(MV_PAR01,5,4)
    Local cMatricDe     := Substr(MV_PAR01,9,6)
    Local cCodIntAte    := Substr(MV_PAR02,1,4)
    Local cCodEmpAte    := Substr(MV_PAR02,5,4)
    Local cMatricAte    := Substr(MV_PAR02,9,6)

    _cQuery     += " SELECT                                                                     " + CRLF
    _cQuery     += "     BA1.*, BTS.R_E_C_N_O_ AS BTSREC                                        " + CRLF
    _cQuery     += " FROM                                                                       " + CRLF
    _cQuery     += "     " + RetSQLName("BA1") + " BA1                                          " + CRLF
    _cQuery     += "     INNER JOIN                                                             " + CRLF
    _cQuery     += "         " + RetSQLName("BTS") + " BTS                                      " + CRLF
    _cQuery     += "     ON                                                                     " + CRLF
    _cQuery     += "         BTS.BTS_FILIAL = BA1.BA1_FILIAL                                    " + CRLF
    _cQuery     += "         AND BTS.BTS_MATVID = BA1.BA1_MATVID                                " + CRLF
    _cQuery     += "     INNER JOIN                                                             " + CRLF
    _cQuery     += "         " + RetSQLName("BI3") + " BI3                                      " + CRLF
    _cQuery     += "     ON                                                                     " + CRLF
    _cQuery     += "         BI3.BI3_CODIGO = BA1.BA1_CODPLA                                    " + CRLF
    _cQuery     += "         AND BI3.BI3_VERSAO = BA1.BA1_VERSAO                                " + CRLF
    _cQuery     += " WHERE BA1.D_E_L_E_T_ = ' '                                                 " + CRLF
    _cQuery     += "    AND BTS.D_E_L_E_T_ = ' '                                                " + CRLF
    _cQuery     += "    AND BTS.BTS_FILIAL = '"+XFilial("BTS")+"'                               " + CRLF
    _cQuery     += "    AND BA1.BA1_FILIAL = '"+XFilial("BA1")+"'                               " + CRLF
    _cQuery     += "    AND BI3_CODSEG <> '004' " + CRLF


    If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)

        _cQuery     += "    AND BA1_CODINT >= '"+cCodIntDe+"'  AND BA1_CODINT <= '"+cCodIntAte+"'   " + CRLF
        _cQuery     += "    AND BA1_CODEMP >= '"+cCodEmpDe+"' AND BA1_CODEMP <= '"+cCodEmpAte+"'   " + CRLF
        _cQuery     += "    AND BA1_MATRIC >= '"+cMatricDe+"' AND  BA1_MATRIC <= '"+cMatricAte+"'   " + CRLF

    EndIf
    //----------------------------------------------
    //Empresa
    //----------------------------------------------
    If !Empty(MV_PAR03)

        _cQuery     += "    AND BA1_CODEMP = '" + MV_PAR03 + "' " + CRLF

    EndIf

    //----------------------------------------------
    //Contrato
    //----------------------------------------------
    If !Empty(MV_PAR04) .And. !Empty(MV_PAR05)

        _cQuery     += "    AND BA1_CODEMP BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "'" + CRLF

    EndIf

    //----------------------------------------------
    //SubContrato
    //----------------------------------------------
    If !Empty(MV_PAR06) .And. !Empty(MV_PAR07)

        _cQuery     += "    AND BA1_SUBCON BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "'" + CRLF

    EndIf


     //----------------------------------------------
    //Se Exclus„o
    //----------------------------------------------
    If MV_PAR08 = 2 

        If !Empty(MV_PAR09)
           _cQuery     += "    AND BA1_DATBLO BETWEEN '" + DTOS(MV_PAR09) + "' AND '" + DTOS(MV_PAR10) + "'" + CRLF
        EndIf   
    else
        If !Empty(MV_PAR09)
            _cQuery     += "    AND BA1_DATINC BETWEEN '" + DTOS(MV_PAR09) + "' AND '" + DTOS(MV_PAR10) + "'" + CRLF
        EndIf

         _cQuery     += "    AND BA1_DATBLO = ' '"   

    EndIf



    _cQuery    := ChangeQuery(_cQuery)
    dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),cAliasTRB,.T.,.T.)


    aListBenefic := {}
    Do While !( cAliasTRB )->( Eof() )

        aAdd( aListBenefic, { .T.						,; // 01- Marcado
            ( cAliasTRB )->BA1_CODINT 	,; // 02- Inst
            ( cAliasTRB )->BA1_CODEMP	,; // 03- Empresa
            ( cAliasTRB )->BA1_MATRIC	,; // 04- Matricula
            ( cAliasTRB )->BA1_TIPREG  ,; // 05- Tipo Registro
            ( cAliasTRB )->BA1_DIGITO	,; // 06- Digito
            ( cAliasTRB )->BA1_NOMUSR  ,;  // 07- Nome
            ( cAliasTRB )->BA1_MATVID  ,;// 08- RECNO BA1
            ( cAliasTRB )->R_E_C_N_O_ ,;  // 09- RECNO BA1
            ( cAliasTRB )->BTSREC })      // 10- RECNO BTS

        DbSelectArea( cAliasTRB )
        ( cAliasTRB )->( DbSkip() )
    EndDo
    ( cAliasTRB )->( DbCloseArea() )

    If Len( aListBenefic ) == 0

        aAdd( aListBenefic, { .F.		 ,;
            "" 		 ,;
            ""		 ,;
            ""		 ,;
            ""		 ,;
            ""		 ,;
            ""		 ,;
            ""		 ,;
            0 		 ,;
            0 		 ,;
            })
    EndIf

Return _cQuery



/************************************************************************************************************************/
/* Monta a tela de sele√ß√£o dos beneficiarios                                                                            */
/************************************************************************************************************************/

Static Function CABA086C

    lExec := .F.
    SetPrvt("oDlgExport","oGrpBenefic","oBtnOk","oBtnSair","oSayF7","oListBenefic")
    oDlgExport 		:= MSDialog():New( 138,254,695,1270,"Exportacao de Dados - Beneficiario",,,.F.,,,,,,.T.,,,.F. )
    oGrpBenefic     := TGroup():New( 003,007,266,456," Beneficiarios ",oDlgExport,CLR_HBLUE,CLR_WHITE,.T.,.F. )
    oBtnOk     		:= TButton():New( 004,460,"Confirmar",oDlgExport,,037,012,,,,.T.,,"",,,,.F. )
    oBtnOk:bAction 	:= { || lExec := .T., oDlgExport:End() }
    oBtnSair      	:= TButton():New( 020,460,"Sair",oDlgExport,,037,012,,,,.T.,,"",,,,.F. )
    oBtnSair:bAction:= { || lExec := .F., oDlgExport:End() }

    //oSayF7     		:= TSay():New( 252,458,{||"<F7>=Pesquisar"},oDlgExport,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,041,008)
    //SetKey (VK_F7,{|| fPesqBenf()}) //Pesquisa beneficiario no brwose de selecao


    aTitListBenefic  := {}
    aSizeListBenefic := {}
    aAdd( aTitListBenefic , "" 			)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "B"	   ) )
    aAdd( aTitListBenefic , "INST." 			)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BB" 	   ) )
    aAdd( aTitListBenefic , "EMPRESA" 		)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BB" 	   ) )
    aAdd( aTitListBenefic , "MATRICULA" 	)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BBB" ) )
    aAdd( aTitListBenefic , "TP.REGISTRO" 	)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BB" ) )
    aAdd( aTitListBenefic , "DIGITO" 	)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "B" ) )
    aAdd( aTitListBenefic , "NOME" 	)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBB" ) )
    aAdd( aTitListBenefic , "MAT.VIDA" 	)
    aAdd( aSizeListBenefic, GetTextWidth( 0, "BBBBBBBBB" ) )

    //oListBenefic	:= TListBox():New( 012,012,,,437,249,,oGrpBenefic,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
    oListBenefic 	:= TwBrowse():New( 012, 012, 437, 249,, aTitListBenefic , aSizeListBenefic, oGrpBenefic,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
    oListBenefic:SetArray( aListBenefic )

    bLinesBenefic	:= 				{ || { 	If( aListBenefic[oListBenefic:nAt][nPosMarcado], oOk, oNo )	,; // Marcado
        AllTrim( aListBenefic[oListBenefic:nAt][nPosInt]   ) 			,; // Filial
        AllTrim( aListBenefic[oListBenefic:nAt][nPosEmpr]  ) 			,; // Filial
        AllTrim( aListBenefic[oListBenefic:nAt][nPosMatr]     ) 			,; // Filial
        AllTrim( aListBenefic[oListBenefic:nAt][nPosTpReg]   ) 			,; // Filial
        AllTrim( aListBenefic[oListBenefic:nAt][nPosDgto]  ) 			,; // Filial
        AllTrim( aListBenefic[oListBenefic:nAt][nPosNome]     ) 			,;
        AllTrim( aListBenefic[oListBenefic:nAt][nPosMatVd]     )      }} // Filial

    oListBenefic:bLine 	   		:= bLinesBenefic
    oListBenefic:bLDblClick 	:= { || FSeleciona( oListBenefic, @aListBenefic, nPosMatVd, nPosMarcado, 0 ) }
    oListBenefic:bHeaderClick 	:= { || FSelectAll( oListBenefic, @aListBenefic, nPosMatVd, nPosMarcado, @lMarcaDesmarca ) }
    oListBenefic:Refresh()

    oDlgExport:Activate( ,,, .T. )



Return




/************************************************************************************************************************/
/* FunÁ„o para exportar os dados em arquvivo excel                                                                      */
/************************************************************************************************************************/

Static Function CABA086D
    
    Local aItem :={}
    Local nT    := 0

    //exporta
    ProcRegua( Len( aListBenefic )  )
    For nT := 01 To Len( aListBenefic )

        IncProc( "Gerando arquivo, aguarde..." )

        //Adiciona Registros flegados para exporta√ß√£o
        If aListBenefic[nT][nPosMarcado]

            DbSelectArea("BA1")
            DbGoTo(aListBenefic[nT,nPosBA1])

            aItem :={}
            DbSelectArea("BTS")
            DbGoTo(aListBenefic[nT,nPosBTS])

            If cEmpant = "01" //Caberj
                cEmail:= "cadastro@caberj.com.br"
            Else //Integral
                cEmail:= "movimentacao@caberj.com.br"
            EndIf   


            If MV_PAR08 <> 2

                aAdd(aItem, "'"+BA1->BA1_TRAORI )                                //"TIPO DE OPERA√á√ÉO"
                aAdd(aItem,"I" )                                //"TIPO DE OPERA√á√ÉO"
                aAdd(aItem,BA1->BA1_NOMUSR )                    //"NOME"
                aAdd(aItem, "" )                                //"COD CARTEIRA BENEFICIARIO"
                aAdd(aItem,BA1->BA1_NOMUSR )                    //"TITULAR"
                aAdd(aItem, "")                                 //"COD CARTEIRA TITULAR"
                aAdd(aItem, BTS->BTS_DATNAS)                    //"DATA NASC"
                aAdd(aItem, IIF(BTS->BTS_ESTCIV="S","1","2"))   //"ESTADO CIVIL"
                aAdd(aItem, "10")                               //"NACIONALIDADE"
                aAdd(aItem, Iif(BTS->BTS_SEXO="1","M","F"))     //"SEXO"
                aAdd(aItem, BTS->BTS_MAE)                       //"NOME DA MAE"
                aAdd(aItem, "'"+BTS->BTS_CPFUSR)                //"CPF"
                aAdd(aItem, "'"+BTS->BTS_DRGUSR)                //"RG"
                aAdd(aItem, "")                                 //"DATA EMISSAO RG"
                aAdd(aItem, BTS->BTS_RGEST)                     //"UF EMISSOR"
                aAdd(aItem, BTS->BTS_ORGEM)                     //"ORGAO EMISSOR"
                aAdd(aItem, "")                                 //"PAIS EMISSOR"
                aAdd(aItem, "")                                 //"RG ESTRANGEIRO"
                aAdd(aItem, cEmail)                             //"EMAIL"
                aAdd(aItem, "'"+BTS->BTS_CEPUSR)                //"CEP"
                aAdd(aItem, BTS->BTS_ENDERE)                    //"ENDERECO"
                aAdd(aItem, "'"+BTS->BTS_NR_END)                //"NUMERO"
                aAdd(aItem, BTS->BTS_COMEND)                    //"COMPLEMENTO"
                aAdd(aItem, BTS->BTS_BAIRRO)                    //"BAIRRO"
                aAdd(aItem, "'"+BTS->BTS_CODMUN)                //"CIDADE"
                aAdd(aItem, BTS->BTS_ESTADO)                    //"ESTADO"
                aAdd(aItem, "")                                 //"TELEFONE"
                aAdd(aItem, "")                                 //"CELULAR"
                aAdd(aItem, "")                                 //"CODIGO CBO"
                aAdd(aItem, "'"+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BA1->BA1_DIGITO) //"MATRICULA"
                aAdd(aItem, "")                                 //"DATA ADMISSAO"
                aAdd(aItem, "")                                 //"NR CTPS"
                aAdd(aItem, "")                                 //"SERIE CTPS"
                aAdd(aItem, "")                                 //"UF EMISSOR CTPS"
                aAdd(aItem, "41")                               //"GRAU PARENTESCO"
                aAdd(aItem, "")                                 //"VINCULO ESTIPULANTE"
                aAdd(aItem, "")                                 //"LOCAL REPASSE"
                aAdd(aItem, "")                                 //"NR MOTIVO RESCISAO"
                aAdd(aItem,"'"+BTS->BTS_NRCRNA )                //"NR CARTAO SUS"
                aAdd(aItem, "")                                 //"COD DECLARACAO NASC VIVO"
                aAdd(aItem, "")                                 //"OBSERVACOES"
                aAdd(aItem, "'"+BA1->BA1_CODPLA)                //"PLANO"
                aAdd(aItem, "")                                 //"MATRICULA FAMILIA"
                aAdd(aItem, "")                                 //"PIS"
                aAdd(aItem, "")                                 //"TITULO DE ELEITOR"
                aAdd(aItem, "")                                 //"TIPO LOGRADOURO"
                aAdd(aItem, "")                                 //"NOME DO PAI"
                aAdd(aItem, "")                                 //"MUNICIPIO NASC"
                aAdd(aItem, "")                                 //"ESTADO NASC"
                aAdd(aItem, "")                                 //"DT RESCISAO"
                aAdd(aItem, "")                                 //"SCA
                aAdd(aItem, "")                                 //"FAIXA SALARIAL"
                aAdd(aItem, "")                                 //"LOCALIZACAO"
                aAdd(aItem, "")                                 //"TABELA PRECO"
                aAdd(aItem, "")                                 //"DT ADESAO"
                aAdd(aItem, "")                                 //"DATA ADOCAO"
                aAdd(aItem, "")                                 //"NR MOTIVO INCLUSAO"
                aAdd(aItem, "")                                 //"NR CODIGO EXTERNO"
                aAdd(aItem, "")                                 //"NR SUBESTIPULANTE"

            Else
                aAdd(aItem,Iif( BA1->BA1_MOTBLO $ "019|007","'"+BA1->BA1_MOTBLO,""))      //"MIGRA«√O"
                aAdd(aItem,"E")                                 //"TIPO DE OPERA√á√ÉO"
                aAdd(aItem, BA1->BA1_NOMUSR )                   //"NOME"
                aAdd(aItem, BA1->BA1_YMTREP )                   //"COD CARTEIRA BENEFICIARIO"
                aAdd(aItem, BA1->BA1_NOMUSR )                   //"TITULAR"
                aAdd(aItem, "" )                                //"COD CARTEIRA TITULAR"
                aAdd(aItem, BTS->BTS_DATNAS )                   //"DATA NASC"
                aAdd(aItem, "")                                 //"ESTADO CIVIL"
                aAdd(aItem, "")                                 //"NACIONALIDADE"
                aAdd(aItem, "")                                 //"SEXO"
                aAdd(aItem, "")                                 //"NOME DA MAE"
                aAdd(aItem, "")                                 //"CPF"
                aAdd(aItem, "")                                 //"RG"
                aAdd(aItem, "")                                 //"DATA EMISSAO RG"
                aAdd(aItem, "")                                 //"UF EMISSOR"
                aAdd(aItem, "")                                 //"ORGAO EMISSOR"
                aAdd(aItem, "")                                 //"PAIS EMISSOR"
                aAdd(aItem, "")                                 //"RG ESTRANGEIRO"
                aAdd(aItem, "")                                 //"EMAIL"
                aAdd(aItem, "")                                 //"CEP"
                aAdd(aItem, "")                                 //"ENDERECO"
                aAdd(aItem, "")                                 //"NUMERO"
                aAdd(aItem, "")                                 //"COMPLEMENTO"
                aAdd(aItem, "")                                 //"BAIRRO"
                aAdd(aItem, "")                                 //"CIDADE"
                aAdd(aItem, "")                                 //"ESTADO"
                aAdd(aItem, "")                                 //"TELEFONE"
                aAdd(aItem, "")                                 //"CELULAR"
                aAdd(aItem, "")                                 //"CODIGO CBO"
                aAdd(aItem, "")                                 //"MATRICULA"
                aAdd(aItem, "")                                 //"DATA ADMISSAO"
                aAdd(aItem, "")                                 //"NR CTPS"
                aAdd(aItem, "")                                 //"SERIE CTPS"
                aAdd(aItem, "")                                 //"UF EMISSOR CTPS"
                aAdd(aItem, "")                                 //"GRAU PARENTESCO"
                aAdd(aItem, "")                                 //"VINCULO ESTIPULANTE"
                aAdd(aItem, "")                                 //"LOCAL REPASSE"
                aAdd(aItem, Iif(BA1->BA1_MOTBLO $ '019|007|020|001|RN412',"'13","") )         //"NR MOTIVO RESCISAO"
                aAdd(aItem, "")                                 //"NR CARTAO SUS"
                aAdd(aItem, "")                                 //"COD DECLARACAO NASC VIVO"
                aAdd(aItem, "")                                 //"OBSERVACOES"
                aAdd(aItem, "")                                 //"PLANO"
                aAdd(aItem, "")                                 //"MATRICULA FAMILIA"
                aAdd(aItem, "")                                 //"PIS"
                aAdd(aItem, "")                                 //"TITULO DE ELEITOR"
                aAdd(aItem, "")                                 //"TIPO LOGRADOURO"
                aAdd(aItem, "")                                 //"NOME DO PAI"
                aAdd(aItem, "")                                 //"MUNICIPIO NASC"
                aAdd(aItem, "")                                 //"ESTADO NASC"
                aAdd(aItem,  DTOC(BA1->BA1_DATBLO)  )      //"DT RESCISAO"
                aAdd(aItem, "")                                 //"SCA
                aAdd(aItem, "")                                 //"FAIXA SALARIAL"
                aAdd(aItem, "")                                 //"LOCALIZACAO"
                aAdd(aItem, "")                                 //"TABELA PRECO"
                aAdd(aItem, "")                                 //"DT ADESAO"
                aAdd(aItem, "")                                 //"DATA ADOCAO"
                aAdd(aItem, "")                                 //"NR MOTIVO INCLUSAO"
                aAdd(aItem, "")                                 //"NR CODIGO EXTERNO"
                aAdd(aItem, "")                                 //"NR SUBESTIPULANTE"

            EndIf

            aAdd(aDados,aItem) //Adiciona Item
        EndIf
    Next nT

    If len(aItem)> 0

        MsgRun("Favor Aguardar.....", "Exportando os Registros para o Excel",;
            {||DlgToExcel({{"ARRAY","Beneficiarios Caberj X UNIMED SJRP",aCabec,aDados}})})
    Else
        MsgAlert("N„o h· dados correspondente a consulta selecionada. ", "A T E N « √ O !")
    EndIf


Return




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Monta a pergunta                                                                                                                                  */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function AjustaSX1(cPerg)

    Local aHelpPor	:= {}

    nTamMat := TamSX3("BA1_CODINT")[1]+TamSX3("BA1_CODEMP")[1]+TamSX3("BA1_MATRIC")[1]+TamSX3("BA1_TIPREG")[1]+TamSX3("BA1_DIGITO")[1]

    aHelpPor := {}
    AADD(aHelpPor,"Informe a Matricula:			")

    u_CABASX1(cPerg,"01","Matricula De: "	    ,"Matricula:"       ,"a","MV_CH1"	,"C",nTamMat                    ,0,0,"G","","CABC03","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"02","Matricula Ate: "	    ,"Matricula:"       ,"a","MV_CH2"	,"C",nTamMat                    ,0,0,"G","","CABC03","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"03","Empresa: "	        ,"Empresa: "        ,"a","MV_CH3"	,"C",TamSX3("BA1_CODEMP")[1]    ,0,0,"G","",""      ,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"04","Contrato De: "	    ,"Contrato De:"     ,"a","MV_CH4"	,"C",TamSX3("BA1_CONEMP")[1]    ,0,0,"G","",""      ,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"05","Contrato Ate: "	    ,"Contrato Ate:"    ,"a","MV_CH5"	,"C",TamSX3("BA1_CONEMP")[1]    ,0,0,"G","",""      ,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"06","SubContrato De: "	    ,"SubContrato De:"  ,"a","MV_CH6"	,"C",TamSX3("BA1_SUBCON")[1]    ,0,0,"G","",""      ,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"07","SubContrato Ate: "	,"SubContrato Ate:" ,"a","MV_CH7"	,"C",TamSX3("BA1_SUBCON")[1]    ,0,0,"G","",""      ,"","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"08","Tipo: "	            ,"Tipo:"            ,"a","MV_CH8"	,"N",01                         ,0,0,"C","",""      ,"","","MV_PAR08","Inclusao","","","","Exclusao","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"09","PerÌodo De : "	    ,"PerÌodo De:"      ,"a","MV_CH9"	,"D",8                         ,0,0,"G","",""      ,"","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"10","PerÌodo Ate: "	    ,"PerÌodo Ate: "    ,"a","MV_CHA"	,"D",8                         ,0,0,"G","",""      ,"","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return()



*----------------------------------------------------------------------------------------------------------------*
Static Function FSeleciona( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, nParamPosLegenda )
    *----------------------------------------------------------------------------------------------------------------*
    Local nLinhaGrid 			:= oParamListObject:nAt
    Local lTemMarcado   		:= 0
    Local lTemLegenda           := 0
    Default nParamPosMarcado    := 0
    Default nParamPosLegenda 	:= 0
    lTemMarcado   				:= ( nParamPosMarcado > 0 )
    lTemLegenda         		:= ( nParamPosLegenda > 0 )

    // Linha precisa ser maior que zero
    If nLinhaGrid == 0
        Return
    EndIf

    If Len( aParamListObject ) == 00
        Return
    EndIf

    If ( oParamListObject:nColPos == nParamPosLegenda .And. lTemLegenda )

        FLegenda()

    Else

        If lTemMarcado

            If Len( aParamListObject ) == 01 .And. nLinhaGrid == 01
                If AllTrim( aParamListObject[nLinhaGrid][nParamPosCpo] ) == ""
                    Return
                EndIf
            EndIf
            aParamListObject[nLinhaGrid][nParamPosMarcado] := !aParamListObject[nLinhaGrid][nParamPosMarcado]
            oParamListObject:Refresh()

        EndIf

    EndIf

Return

*-------------------------------------------------------------------------------------------------------------------*
Static Function FSelectAll( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, lParamMarcaDesmarca )
    *-------------------------------------------------------------------------------------------------------------------*
    Local nY := 0

    If Len( aParamListObject ) == 00
        Return
    EndIf

    If Len( aParamListObject ) == 01
        If AllTrim( aParamListObject[01][nParamPosCpo] ) == ""
            Return
        EndIf
    EndIf

    lParamMarcaDesmarca := !lParamMarcaDesmarca
    For nY := 01 To Len( aParamListObject )
        aParamListObject[nY][nParamPosMarcado] := !lParamMarcaDesmarca
    Next nY

    oParamListObject:Refresh()

Return

/*-------------------------------------------------------------------------------------------

*-------------------------------------------------------------------------------------------
User Function fPesqBenf

    SetPrvt("oDlgPesq","oGrpBenefic","oBtnPesq")
    oDlgPesq     := MSDialog():New( 092,232,380,750,"oDlgPesq",,,.F.,,,,,,.T.,,,.T. )
	oGrpBenefic  := TGroup():New( 003,007,266,456," Benefici√°rios ",oDlgPesq,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay1        := TSay():New( 008,008,{||"Nome:"},oDlgPesq,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
    oGet1        := TGet():New( 016,008,,oDlgPesq,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)




	oDlgExport 		:= MSDialog():New( 138,254,695,1270,"Pesqisa - Beneficiario",,,.F.,,,,,,.T.,,,.F. )
	oGrpBenefic     := TGroup():New( 003,007,266,456," Benefici√°rios ",oDlgExport,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oBtnOk     		:= TButton():New( 004,460,"Confirmar",oDlgExport,,037,012,,,,.T.,,"",,,,.F. )
	oBtnOk:bAction 	:= { || lExec := .T., oDlgExport:End() }
	oBtnSair      	:= TButton():New( 020,460,"Sair",oDlgExport,,037,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction:= { || lExec := .F., oDlgExport:End() }


Return */
