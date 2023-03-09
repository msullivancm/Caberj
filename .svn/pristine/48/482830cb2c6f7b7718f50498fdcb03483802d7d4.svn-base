#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABR030
description Reltório de lançamento de baixas em atraso.
@author  author Angelo Henrique
@since   date 06/01/2022
@version version
/*/
//-------------------------------------------------------------------
User Function CABR030()

    Local oReport
    Local aArea := GetArea()
    Private cPerg  := "CABR030"

    AjustaSx1(cPerg)

    IF !Pergunte(cPerg, .T.)
        Return
    Endif

    oReport:= ReportDef()
    oReport:PrintDialog()

    RestArea(aArea)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function ReportDef
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

    Local oSection2		:= Nil
    Local oReport		:= Nil
    Local aAreaSM0  	:= SM0->(GetArea())
    Local cTit 			:= "Relatório de Lanc. de Baixas em Atraso"
    Private contador 	:= 1

    cDesCRel := cTit

    //??????????????????????????????????????
    //?Criacao do componente de impressao                                     ?
    //?oReport():New                                                          ?
    //?ExpC1 : Nome do relatorio                                              ?
    //?ExpC2 : Titulo                                                         ?
    //?ExpC3 : Pergunte                                                       ?
    //?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
    //?ExpC5 : Descricao                                                      ?
    //??????????????????????????????????????
    cDesl:= "Este relatorio tem como objetivo imprimir os lançamentos de baixa em atraso ."
    oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
    oReport:SetLandScape()
    oReport:SetTotalInLine(.T.)

    Pergunte(oReport:uParam,.F.)

    oSection2 := TRSection():New(oReport,"Lancamentos",{}, , ,) //"Documento"
    // Colunas do relatório
    TRCell():New(oSection2,"VENCORI"	    ,,"DATA_VENCIMENTO_REAL"    , ""	,14    ,  ,{|| (cAliasTRB)->VENCORI     } ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"DTBAIXAORI"		,,"DATA_BAIXA"		     	, ""	,14	   ,  ,{|| (cAliasTRB)->DTBAIXAORI  } ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"DIFDATA"		,,"DIFERENCA_DATA_DIAS"  	, ""	,5	   ,  ,{|| (cAliasTRB)->DIFDATA     } ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"MULTA"			,,"MULTA"		 			, ""	,10	   ,  ,{|| (cAliasTRB)->MULTA   	} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"JUROS"			,,"JUROS"	 			    , ""	,10	   ,  ,{|| (cAliasTRB)->JUROS    	} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"TOTJUROS"		,,"TOTAL_MULTA_JUROS" 	 	, ""	,10	   ,  ,{|| (cAliasTRB)->TOTJUROS 	} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"DIFVALOR"		,,"DIFERENCA_VALORES" 		, ""	,15	   ,  ,{|| (cAliasTRB)->DIFVALOR   	} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"ANALISE"	    ,,"ANALISE" 	            , ""	,15	   ,  ,{|| (cAliasTRB)->ANALISE		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"SEQDEB" 		,,"SEQUENCIAL_DEBITO"     	, ""	,15	   ,  ,{|| (cAliasTRB)->SEQDEB		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"TITORI" 		,,"TITULO_ORIGINAL"     	, ""	,15	   ,  ,{|| (cAliasTRB)->TITORI    	} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"MESORI"		    ,,"MES_TITULO_ORIGINAL" 	, ""	,10	   ,  ,{|| (cAliasTRB)->MESORI 		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"ANOORI"		    ,,"ANO_TITULO_ORIGINAL"  	, ""  	,10	   ,  ,{|| (cAliasTRB)->ANOORI		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"NUMFAT"			,,"NUMERO_FATURA"  	 		, ""  	,10	   ,  ,{|| (cAliasTRB)->NUMFAT	  	} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"COMPTFAT"		,,"COMPETENCIA_FATURA" 	 	, ""	,10	   ,  ,{|| (cAliasTRB)->COMPTFAT	} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"VALORBX"		,,"VALOR_BX_ATRASO" 	 	, ""	,10	   ,  ,{|| (cAliasTRB)->VALORBX		} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"SALDOORI"		,,"SALDO_TITULO_ORIGINAL" 	, ""	,10	   ,  ,{|| (cAliasTRB)->SALDOORI	} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"VLRPART"		,,"VALOR_PARTIDA " 	 		, ""	,10	   ,  ,{|| (cAliasTRB)->VLRPART		} ,"RIGHT" , ,"RIGHT" )
    TRCell():New(oSection2,"EMPRESA"		,,"EMPRESA " 	 			, ""	,10	   ,  ,{|| (cAliasTRB)->EMPRESA		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"MATRICULA"		,,"MATRICULA " 	 			, ""	,10	   ,  ,{|| (cAliasTRB)->MATRICULA	} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"MOTBX"			,,"MOTIVO_BAIXA " 	 		, ""	,10	   ,  ,{|| (cAliasTRB)->MOTBX		} ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"VBAIXA"			,,"VALOR_BAIXA " 	 		, ""	,10	   ,  ,{|| (cAliasTRB)->VBAIXA		} ,"RIGHT" , ,"RIGHT" )

    //TRFunction():New(oSection2:Cell("USU_IMPRESSAO"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)

    RestArea( aAreaSM0 )

Return(oReport)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportPrint(oReport)

    Local oSection2		:= Nil
    Local cQry 			:= " "

    Private cAliasTRB  	:= GetNextAlias()
    Private aArea1  	:= {}

    oSection2 := oReport:Section(1)

    // Query para buscar os dados no banco
    cQry += " SELECT                                                                                                                                                                                                                                                                    " + CRLF
    cQry += "     FORMATA_DATA_MS(SE1.E1_VENCREA) VENCORI,                                                                                                                                                                                                                              " + CRLF
    cQry += "     FORMATA_DATA_MS(SE1.E1_BAIXA) DTBAIXAORI,                                                                                                                                                                                                                             " + CRLF
    cQry += "     CASE                                                                                                                                                                                                                                                                  " + CRLF
    cQry += "         WHEN TRIM(SE1.E1_BAIXA) <> ' ' THEN TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')                                                                                                                                                       " + CRLF
    cQry += "         ELSE 0                                                                                                                                                                                                                                                            " + CRLF
    cQry += "     END DIFDATA,                                                                                                                                                                                                                                                          " + CRLF
    cQry += "     ROUND((NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2) MULTA,                                                                                                                                                                                          " + CRLF
    cQry += "     CASE                                                                                                                                                                                                                                                                  " + CRLF
    cQry += "          WHEN SE1.E1_BAIXA = ' ' THEN 0                                                                                                                                                                                                                                   " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) > 0                                                                                                " + CRLF
    cQry += "          THEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2)                                                                                                    " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) < 0                                                                                                " + CRLF
    cQry += "          THEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) * - 1                                                                                              " + CRLF    
    cQry += "     END JUROS,                                                                                                                                                                                                                                                            " + CRLF
    cQry += "     CASE                                                                                                                                                                                                                                                                  " + CRLF
    cQry += "          WHEN SE1.E1_BAIXA = ' ' THEN 0                                                                                                                                                                                                                                   " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) > 0                                                                                                " + CRLF
    cQry += "          THEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2)                                     " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) < 0																								" + CRLF
    cQry += "          THEN ROUND((((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) * - 1) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2)                             " + CRLF
    cQry += "         END TOTJUROS,                                                                                                                                                                                                                                                     " + CRLF
    cQry += "     CASE                                                                                                                                                                                                                                                                  " + CRLF
    cQry += "          WHEN SE1.E1_BAIXA = ' ' THEN 0                                                                                                                                                                                                                                   " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) > 0                                                                                                " + CRLF
    cQry += "          THEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2) - BSQ.BSQ_VALOR                     " + CRLF
    cQry += "          WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) < 0                                                                                                " + CRLF
    cQry += "          THEN ROUND((((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) * - 1) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2) - BSQ.BSQ_VALOR             " + CRLF
    cQry += "     END DIFVALOR,                                                                                                                                                                                                                                                         " + CRLF
    cQry += "     CASE                                                                                                                                                                                                                                                                  " + CRLF
    cQry += "         WHEN SE1.E1_BAIXA = ' ' THEN 'Juros indevidos - Titulo sem baixa'                                                                                                                                                                                                 " + CRLF
    cQry += "         WHEN SE1.E1_SALDO = SE1.E1_VALOR THEN 'Juros indevidos - Titulo sem baixa'                                                                                                                                                                                        " + CRLF
    cQry += "         WHEN SE1.E1_SALDO <> SE1.E1_VALOR AND NVL(SE5.E5_MOTBX,'NOR') <> 'NOR' THEN 'Juros indevidos - Baixa sem pagamento' -- se estiver sem baixa ele irá entrar na primeira regra                                                                                      " + CRLF
    cQry += "         WHEN(                                                                                                                                                                                                                                                             " + CRLF
    cQry += "                 CASE                                                                                                                                                                                                                                                      " + CRLF
    cQry += "                     WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) > 0                                                                                     " + CRLF
    cQry += "                     THEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2) - BSQ.BSQ_VALOR          " + CRLF
    cQry += "                     WHEN ROUND(((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))),2) < 0                                                                                     " + CRLF
    cQry += "                     THEN ROUND((((0.01/30) * (TO_DATE(SE1.E1_VENCREA, 'YYYYMMDD') - TO_DATE(SE1.E1_BAIXA, 'YYYYMMDD')) * (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR))) * - 1) + (NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) * 0.02),2) - BSQ.BSQ_VALOR	" + CRLF
    cQry += "                 END                                                                       " + CRLF
    cQry += "             ) <> 0 THEN 'Valor diferente no calculo de juros e multa x valor do debito'   " + CRLF
    cQry += "         ELSE                                                      						" + CRLF
    cQry += "             'OK'                                                  						" + CRLF
    cQry += "     END ANALISE,                                                  						" + CRLF
    cQry += "     BSQ.BSQ_CODSEQ SEQDEB,                                        						" + CRLF
    cQry += "     BSQ.BSQ_YNMSE1 TITORI,                                        						" + CRLF
    cQry += "     BSQ.BSQ_YMBASE MESORI,                                        						" + CRLF
    cQry += "     BSQ.BSQ_YABASE ANOORI,                                        						" + CRLF
    cQry += "     BSQ.BSQ_PREFIX||BSQ.BSQ_NUMTIT NUMFAT,                        						" + CRLF
    cQry += "     SE1.E1_MESBASE ||'/'||SE1.E1_ANOBASE COMPTFAT,                						" + CRLF
    cQry += "     BSQ.BSQ_VALOR VALORBX,                                        						" + CRLF
    cQry += "     SE1.E1_SALDO SALDOORI,                                        						" + CRLF
    cQry += "     NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) VLRPART,							" + CRLF
    cQry += "     BSQ.BSQ_CODEMP EMPRESA,                                       						" + CRLF
    cQry += "     BSQ.BSQ_CODINT||BSQ.BSQ_CODEMP||BSQ.BSQ_MATRIC MATRICULA,     						" + CRLF
    cQry += "     NVL(SE5.E5_MOTBX, ' ') MOTBX,                                  						" + CRLF
    cQry += "     NVL(SE5.E5_VALOR,0) VBAIXA                                      						" + CRLF
    cQry += " FROM                                                              						" + CRLF
    cQry += "     " + RetSqlName("BSQ") + " BSQ                                                    		" + CRLF
    cQry += "                                                                   						" + CRLF
    cQry += "     INNER JOIN                                                    						" + CRLF
    cQry += "     " + RetSqlName("SE1") + " SE1                                                    		" + CRLF
    cQry += "     ON                                                            						" + CRLF
    cQry += "         SE1.E1_FILIAL           = '" + xFilial("SE1") + "'                            	" + CRLF
    cQry += "         AND SE1.E1_PREFIXO      = SUBSTR(BSQ.BSQ_YNMSE1,1,3)	 							" + CRLF
    cQry += "         AND SE1.E1_NUM          = SUBSTR(BSQ.BSQ_YNMSE1,4,9)   							" + CRLF
    cQry += "         AND SE1.E1_PARCELA      = ' '                          							" + CRLF
    cQry += "         AND SE1.E1_TIPO         = 'DP'                         							" + CRLF
    cQry += "         AND SE1.D_E_L_E_T_      = ' '                          							" + CRLF
    cQry += "                                                                							" + CRLF
    cQry += "     LEFT JOIN                                                  							" + CRLF
    cQry += "     " + RetSqlName("SE1") + " SE1_NCC                                                    	" + CRLF
    cQry += "     ON                                                         							" + CRLF
    cQry += "         SE1_NCC.E1_FILIAL       = SE1.E1_FILIAL                							" + CRLF
    cQry += "         AND SE1_NCC.E1_PREFIXO  = SE1.E1_PREFIXO               							" + CRLF
    cQry += "         AND SE1_NCC.E1_NUM      = SE1.E1_NUM                   							" + CRLF
    cQry += "         AND SE1_NCC.E1_PARCELA  = SE1.E1_PARCELA               							" + CRLF
    cQry += "         AND SE1_NCC.E1_TIPO     = 'NCC'                        							" + CRLF
    cQry += "         AND SE1_NCC.E1_CLIENTE  = SE1.E1_CLIENTE               							" + CRLF
    cQry += "         AND SE1_NCC.E1_LOJA     = SE1.E1_LOJA                  							" + CRLF
    cQry += "         AND SE1_NCC.D_E_L_E_T_  = ' '                          							" + CRLF
    cQry += "                                                                							" + CRLF
    cQry += "     LEFT JOIN                                                  							" + CRLF
    cQry += "     " + RetSqlName("SE5") + " SE5                                                    		" + CRLF
    cQry += "     ON                                                         							" + CRLF
    cQry += "         SE5.E5_FILIAL           = SE1.E1_FILIAL                							" + CRLF
    cQry += "         AND SE5.E5_PREFIXO      = SE1.E1_PREFIXO               							" + CRLF
    cQry += "         AND SE5.E5_NUMERO       = SE1.E1_NUM                   							" + CRLF
    cQry += "         AND SE5.E5_PARCELA      = SE1.E1_PARCELA               							" + CRLF
    cQry += "         AND SE5.E5_TIPO         = SE1.E1_TIPO                  							" + CRLF
    cQry += "         AND SE5.D_E_L_E_T_      = ' '                          							" + CRLF
    cQry += "                                                                							" + CRLF
    cQry += " WHERE                                                          							" + CRLF
    cQry += "     BSQ.BSQ_FILIAL      = '" + xFilial("BSQ") + "'                                 		" + CRLF
    cQry += "     AND BSQ.BSQ_CODLAN  = '993'                                 							" + CRLF //-- BAIXA EM ATRASO
    cQry += "     AND BSQ.D_E_L_E_T_  = ' '                                  							" + CRLF

    If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
        cQry += "     AND BSQ.BSQ_ANO     BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'             " + CRLF
    EndIf

    If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
        cQry += "     AND BSQ.BSQ_MES     BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'             " + CRLF
    Endif

    If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
        cQry += "     AND BSQ.BSQ_NUMCOB  BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' 			" + CRLF
    Endif

    If !Empty(MV_PAR07) .And. !Empty(MV_PAR08)
        cQry += "     AND BSQ.BSQ_YABASE  BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'             " + CRLF
    EndIf

    If !Empty(MV_PAR09) .And. !Empty(MV_PAR10)
        cQry += "     AND BSQ.BSQ_YMBASE  BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "'				" + CRLF
    Endif

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

    dbSelectArea(cAliasTRB)
    (cAliasTRB)->(dbgotop())

    oReport:SetMeter((cAliasTRB)->(LastRec()))

    //Imprime os dados do relatorio
    If (cAliasTRB)->(Eof())
        Alert("Não foram encontrados dados!")
    Else

        oSection2:Init()

        While  !(cAliasTRB)->(Eof())

            oReport:IncMeter()
            oSection2:PrintLine()

            (cAliasTRB)->(DbSkip())

        Enddo

        oReport:FatLine()
        oReport:Section(1):Finish()

        (cAliasTRB)->(DbCloseArea())

    EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function AjustaSX1
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function AjustaSX1(cPerg)

    Local aHelpPor	:= {}

    aHelpPor := {}
    AADD(aHelpPor,"Informe o Ano do Lançamento:					")

    u_CABASX1(cPerg,"01","Ano Lanc. De:"	,"Ano Lanc. De"	    ,"a","MV_CH1"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"02","Ano Lanc. Ate: "	,"Ano Lanc. Ate"    ,"a","MV_CH2"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
    AADD(aHelpPor,"Informe o Mes do Lançamento:					")

    u_CABASX1(cPerg,"03","Mes Lanc. De:"	,"Mes Lanc. De"	    ,"a","MV_CH3"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"04","Mes Lanc. Ate: "	,"Mes Lanc. Ate"    ,"a","MV_CH4"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
    AADD(aHelpPor,"Informe o Numero do Lote de Cobrança:		")

    u_CABASX1(cPerg,"05","Lote De: "	    ,"Lote De"          ,"a","MV_CH5"	,"C",TamSX3("E1_PLNUCOB")[1]  	,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"06","Lote Ate:"	    ,"Lote Ate"         ,"a","MV_CH6"	,"C",TamSX3("E1_PLNUCOB")[1]  	,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
    AADD(aHelpPor,"Informe o Ano do Faturamento (PLS FATURADO)	")

    u_CABASX1(cPerg,"07","Ano Fatura De:"	,"Ano Fatura De"	,"a","MV_CH7"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"08","Ano Fatura Ate: "	,"Ano Fatura Ate"   ,"a","MV_CH8"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
    AADD(aHelpPor,"Informe o Mes do Faturamento (PLS FATURADO)	")

    u_CABASX1(cPerg,"09","Mes Fatura De:"	,"Mes Fatura De"	,"a","MV_CH9"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"10","Mes Fatura Ate: "	,"Mes Fatura Ate"   ,"a","MV_CHA"	,"C",4 		                    ,0,0,"G","","","","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")



Return()
