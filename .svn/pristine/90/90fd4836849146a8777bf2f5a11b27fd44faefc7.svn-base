#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 

#DEFINE CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR318  ºAutor  ³ Frederico O. C. Jr º Data ³  19/09/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de conf. das vacinas                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAPLS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR318()

Local aArea         := GetArea()
Local oReport

Private cPerg       := "CABR318"

AjustaSX1_2(cPerg)

if !Pergunte(cPerg, .T.)
    return
endif

oReport := ReportH()
oReport:PrintDialog()

RestArea(aArea)

return


//**********************************************************//
//                  Geração do relatório                    //
//**********************************************************//
Static Function ReportH()

Local aAreaSM0      := SM0->(GetArea())
Local oSection2
Local oReport
Local cTit          := "Relatório de Conferencia das Vacinas"

oReport := TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cTit)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)

oSection2 := TRSection():New(oReport,"Relatório de Conferencia das Vacinas",)

    TRCell():New(oSection2,"",,"Competencia"    , "", 007, .F., {|| (cAliasVAX)->COMPETENCIA    }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Matricula"      , "", 022, .F., {|| (cAliasVAX)->MATRICULA      }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Nome"           , "", 080, .F., {|| (cAliasVAX)->NOME_BENEF     }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Procedimento"   , "", 060, .F., {|| (cAliasVAX)->PROCEDIMENTO   }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Data Vacina"    , "", 010, .F., {|| (cAliasVAX)->DATA_VACINA    }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Valor Vacina"   , "", 015, .F., {|| (cAliasVAX)->VALOR_VACINA   }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Perc. Copart."  , "", 005, .F., {|| (cAliasVAX)->PERC_COPART    }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Valor Copart."  , "", 015, .F., {|| (cAliasVAX)->VALOR_COPART   }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Bloq. Copart."  , "", 003, .F., {|| (cAliasVAX)->COPART_BLOQ    }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Mot. Blqqueio"  , "", 040, .F., {|| (cAliasVAX)->MOT_BLOQ       }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Consolidado"    , "", 003, .F., {|| (cAliasVAX)->CONSOLIDADO    }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Qtde Parcelas"  , "", 003, .F., {|| (cAliasVAX)->PARCELAS       }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Total Parcelas" , "", 015, .F., {|| (cAliasVAX)->VLR_PARCELAS   }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Primeira Comp." , "", 015, .F., {|| (cAliasVAX)->PRIMEIRA_COMP  }, "LEFT", .T., "LEFT" )
    TRCell():New(oSection2,"",,"Sequenciais"    , "", 200, .F., {|| (cAliasVAX)->SEQUENCIAIS    }, "LEFT", .T., "LEFT" )

RestArea( aAreaSM0 )

Return(oReport)



//**********************************************************//
//                   Query do relatório                     //
//**********************************************************//
Static Function ReportPrt(oReport)

Local oSection2
Local cQuery        := ""

Private cAliasVAX   := GetnextAlias()

oSection2   := oReport:Section(1)

cQuery := " SELECT BD6_MESPAG||'/'||BD6_ANOPAG                                                     AS COMPETENCIA,"
cQuery +=        " BD6_OPEUSR||'.'||BD6_CODEMP||'.'||BD6_MATRIC||'-'||BD6_TIPREG||'.'||BD6_DIGITO  AS MATRICULA,"
cQuery +=        " TRIM(BD6_NOMUSR)                                                                AS NOME_BENEF,"
cQuery +=        " SUBSTR(BD6_CODPAD||'-'||TRIM(BD6_CODPRO)||' - '||BD6_DESPRO,1,60)               AS PROCEDIMENTO,"
cQuery +=        " TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD')                                            AS DATA_VACINA,"
cQuery +=        " BD6_VLRPAG                                                                      AS VALOR_VACINA,"
cQuery +=        " TO_CHAR(BD6_PERCOP)||'%'                                                        AS PERC_COPART,"
cQuery +=        " BD6_VLRPF                                                                       AS VALOR_COPART,"
cQuery +=        " CASE WHEN BD6_MOTBPF <> ' ' THEN BD6_MOTBPF||'-'||TRIM(BD6_DESBPF) ELSE ' ' END AS MOT_BLOQ,"
cQuery +=        " CASE WHEN BD6_SEQPF  = ' ' THEN 'NAO' ELSE 'SIM' END                            AS CONSOLIDADO,"
cQuery +=        " CASE WHEN TO_CHAR(SEQUENCIAIS) <> ' ' THEN 'NAO'"
cQuery +=             " WHEN BD6_BLOCPA = '1' THEN 'SIM' ELSE 'NAO' END                            AS COPART_BLOQ,"
cQuery +=        " PARCELAS,"
cQuery +=        " VLR_PARCELAS,"
cQuery +=        " CASE WHEN PRIMEIRA_COMP <> ' ' THEN SUBSTR(PRIMEIRA_COMP,6,2)||'/'||SUBSTR(PRIMEIRA_COMP,1,4) ELSE ' ' END AS PRIMEIRA_COMP,"
cQuery +=        " TO_CHAR(SEQUENCIAIS)                                                            AS SEQUENCIAIS"
cQuery +=       " FROM " + RetSqlName("BD6") + " BD6"
cQuery +=         " LEFT JOIN ( SELECT BDH_FILIAL, BDH_CODINT, BDH_CODEMP, BDH_MATRIC, BDH_TIPREG, BDH_ANOFT, BDH_MESFT, BDH_SEQPF,"
cQuery +=                            " COUNT(BSQ_CODSEQ)           AS PARCELAS,"
cQuery +=                            " WM_CONCAT(BSQ_CODSEQ)       AS SEQUENCIAIS,"
cQuery +=                            " SUM(BSQ_VALOR)              AS VLR_PARCELAS,"
cQuery +=                            " MIN(BSQ_ANO||'/'||BSQ_MES)  AS PRIMEIRA_COMP"
cQuery +=                     " FROM " + RetSqlName("BDH") + " BDH"
cQuery +=                       " INNER JOIN " + RetSqlName("BSQ") + " BSQ"
cQuery +=                         " ON (    BSQ_FILIAL = BDH_FILIAL"
cQuery +=                             " AND BSQ_CODINT = BDH_CODINT"
cQuery +=                             " AND SUBSTR(BSQ_USUARI,1,16) = BDH_CODINT||BDH_CODEMP||BDH_MATRIC||BDH_TIPREG"
cQuery +=                             " AND BSQ_CODLAN = '086'"
cQuery +=                             " AND INSTR(BSQ_ZHIST, TO_CHAR(BDH.R_E_C_N_O_)) <> 0 )"
cQuery +=                     " WHERE BSQ.D_E_L_E_T_ = ' '"     // AND BDH.D_E_L_E_T_ = ' '
cQuery +=                     " GROUP BY BDH_FILIAL, BDH_CODINT, BDH_CODEMP, BDH_MATRIC, BDH_TIPREG, BDH_ANOFT, BDH_MESFT, BDH_SEQPF)"
cQuery +=           " ON (    BDH_FILIAL = BD6_FILIAL"
cQuery +=               " AND BDH_CODINT = BD6_OPEUSR"
cQuery +=               " AND BDH_CODEMP = BD6_CODEMP"
cQuery +=               " AND BDH_MATRIC = BD6_MATRIC"
cQuery +=               " AND BDH_TIPREG = BD6_TIPREG"
cQuery +=               " AND BDH_ANOFT  = BD6_ANOPAG"
cQuery +=               " AND BDH_MESFT  = BD6_MESPAG"
cQuery +=               " AND BDH_SEQPF  = BD6_SEQPF )"
cQuery += " WHERE BD6.D_E_L_E_T_ = ' '"
cQuery +=   " AND BD6_FILIAL = '" + xFilial("BD6") + "'"
cQuery +=   " AND BD6_CODOPE = '" +   PlsIntPad()  + "'"
cQuery +=   " AND BD6_CODLDP IN ('0001','0002')"
cQuery +=   " AND BD6_CODPAD = '98'"
cQuery +=   " AND BD6_CODPRO IN ('80190421','80190413')"
cQuery +=   " AND BD6_CODEMP IN ('0001','0002','0003','0005')"

if !empty(mv_par01)
    cQuery += " AND BD6_MESPAG||'/'||BD6_ANOPAG >= '" + mv_par01 + "'"
endif

if !empty(mv_par02)
    cQuery += " AND BD6_MESPAG||'/'||BD6_ANOPAG <= '" + mv_par02 + "'"
endif

cQuery += " ORDER BY 1, 2"

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVAX,.T.,.T.)

dbSelectArea(cAliasVAX)
(cAliasVAX)->(dbgotop())

oReport:SetMeter((cAliasVAX)->(LastRec()))

//Imprime os dados do relatorio
if (cAliasVAX)->(EOF())
    MsgInfo("Nao foram encontrados dados!")
else

    oSection2:Init()

    while !(cAliasVAX)->(EOF())

        oReport:IncMeter()
        oSection2:PrintLine()

        (cAliasVAX)->(DbSkip())
    end

    oReport:FatLine()
    oReport:Section(1):Finish()

    (cAliasVAX)->(DbCloseArea())

endif

return



//**********************************************************//
//                     Criar parametros                     //
//**********************************************************//
Static Function AjustaSX1_2(cPerg)

U_CABASX1(cPerg,"01","Competencia de (MM/AAAA):" ,"","","MV_CH1" ,"C",7,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"02","Competencia ate (MM/AAAA):","","","MV_CH2" ,"C",7,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})

return
