#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)
/*
+===========================================================================+
+---------------------------------------------------------------------------+
|Programa   | CABR028	|Autor  | Luiz Otavio Campos  | Data |  03/03/21    |
+---------------------------------------------------------------------------+
|Descricao  | Relat?io de Log de Auditoria de Impressao de boletos.		 	|
|           | 																|
+---------------------------------------------------------------------------+
|Uso        | ESTOQUE									    |
+---------------------------------------------------------------------------+
+===========================================================================+
*/
User Function CABR029()

	Local oReport
	Local aArea := GetArea()
	Private cPerg  := "CABR029"

	AjustaSx1(cPerg)

	IF !Pergunte(cPerg, .T.)
		Return
	Endif

	oReport:= ReportDef()
	oReport:PrintDialog()

	RestArea(aArea)

Return
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportDef()

	Local oSection2		:= Nil
	Local oReport		:= Nil
	Local aAreaSM0  	:= SM0->(GetArea())
	Local cTit 			:= "Relatório de PA entre Áreas"
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
	cDesl:= "Este relatorio tem como objetivo imprimir o relatório de PAs entra Areas ."
	oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.T.)

	Pergunte(oReport:uParam,.F.)

	oSection2 := TRSection():New(oReport,"Protocolos",{}, , ,) //"Documento"
	// Colunas do relatório
	TRCell():New(oSection2,"PROTOCOLO"			    	,,"Protocolo"		 			, ""	,20	   ,  ,{|| (cAliasTRB)->PROTOCOLO          			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"SLA_TOTAL"		        	,,"Qtd SLA"		     			, ""	,10	   ,  ,{|| (cAliasTRB)->SLA_TOTAL          			} ,"RIGHT" , ,"RIGHT" )
	TRCell():New(oSection2,"DATA_ABERTURA"		    	,,"Dt.Abertura"  	 			, ""	,10	   ,  ,{|| (cAliasTRB)->DATA_ABERTURA      			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"HORARIO_ABERTURA"			,,"Hr.Abertura"		 			, ""	,10	   ,  ,{|| (cAliasTRB)->HORARIO_ABERTURA   			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DATA_FECHAMENTO"			,,"Dt.Fechamento"	 			, ""	,10	   ,  ,{|| (cAliasTRB)->DATA_FECHAMENTO    			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"HORARIO_FECHAMENTO"			,,"Hr.Fechamento" 	 			, ""	,10	   ,  ,{|| (cAliasTRB)->HORARIO_FECHAMENTO 			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"AREA_RESPONSAVEL"			,,"Area Responsavel" 			, ""	,15	   ,  ,{|| (cAliasTRB)->AREA_RESPONSAVEL   			} ,"LEFTR" , ,"LEFT"  )
	TRCell():New(oSection2,"DESCRICAO_AREA_RESPONSAVEL"	,,"Descricao Area Responsavel" 	, ""	,15	   ,  ,{|| (cAliasTRB)->DESC_RESP					} ,"LEFTR" , ,"LEFT"  )
	TRCell():New(oSection2,"DESCRICAO_AREA_ATUAL" 		,,"Area Atual"     	 			, ""	,15	   ,  ,{|| (cAliasTRB)->AREA_ATUAL					} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DESCRICAO_AREA_ATUAL" 		,,"Descricao Area Atual"     	, ""	,15	   ,  ,{|| (cAliasTRB)->DESC_ATUAL    				} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DATA_TRANSFERENCIA"		    ,,"Dt.Transferencia" 			, ""	,10	   ,  ,{|| (cAliasTRB)->DATA_TRANSFERENCIA 			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"QUANTIDADE_SLA_AREA"		,,"Qtd SLA Area"  	 			, ""  	,10	   ,  ,{|| (cAliasTRB)->QUANTIDADE_SLA_AREA			} ,"RIGHT" , ,"RIGHT" )
	TRCell():New(oSection2,"DT_FIM_AREA"				,,"Dt. Fim Area"  	 			, ""  	,10	   ,  ,{|| (cAliasTRB)->DT_FIM_AREA	  	   			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DIF"						,,"Dias Uteis " 	 			, ""	,10	   ,  ,{|| (cAliasTRB)->DIF			   	   			} ,"LEFT"  , ,"LEFT"  )

	//TRFunction():New(oSection2:Cell("USU_IMPRESSAO"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)

	RestArea( aAreaSM0 )

Return(oReport)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportPrint(oReport)

	Local oSection2		:= Nil
	Local cQry 			:= " "

	Private cAliasTRB  	:= "TRBX29"		
	Private aArea1  	:= {}


	oSection2 := oReport:Section(1)

	// Query para buscar os dados no banco
	cQry += "SELECT                                                                                           				" + CRLF
	cQry += "	DISTINCT                                                                                      				" + CRLF
	cQry += "    SZX.ZX_SEQ PROTOCOLO,                                                                        				" + CRLF
	cQry += "    SZX.ZX_SLA SLA_TOTAL,                                                                        				" + CRLF
	cQry += "    CASE                                                                                         				" + CRLF
	cQry += "        WHEN SZX.ZX_DATDE = ' '                                                                  				" + CRLF
	cQry += "        THEN ' '                                                                                 				" + CRLF
	cQry += "        ELSE SIGA.FORMATA_DATA_MS(SZX.ZX_DATDE)                                                  				" + CRLF
	cQry += "    END DATA_ABERTURA,                                                                           				" + CRLF
	cQry += "    CASE                                                                                         				" + CRLF
	cQry += "        WHEN SZX.ZX_HORADE = ' '                                                                 				" + CRLF
	cQry += "        THEN ' '                                                                                 				" + CRLF
	cQry += "        ELSE SUBSTR(SZX.ZX_HORADE,1,2)||':'||SUBSTR(SZX.ZX_HORADE,3,2)                           				" + CRLF
	cQry += "    END HORARIO_ABERTURA,                                                                        				" + CRLF
	cQry += "    CASE                                                                                         				" + CRLF
	cQry += "        WHEN SZX.ZX_DATATE = ' '                                                                 				" + CRLF
	cQry += "        THEN ' '                                                                                 				" + CRLF
	cQry += "        ELSE SIGA.FORMATA_DATA_MS(SZX.ZX_DATATE)                                                 				" + CRLF
	cQry += "    END DATA_FECHAMENTO,                                                                         				" + CRLF
	cQry += "    CASE                                                                                         				" + CRLF
	cQry += "        WHEN SZX.ZX_HORATE = ' '                                                                 				" + CRLF
	cQry += "        THEN ' '                                                                                 				" + CRLF
	cQry += "        ELSE SUBSTR(SZX.ZX_HORATE,1,2)||':'||SUBSTR(SZX.ZX_HORATE,3,2)                           				" + CRLF
	cQry += "    END HORARIO_FECHAMENTO,                                                                      				" + CRLF
	cQry += "    SZX.ZX_CODAREA AREA_RESPONSAVEL,                                                             				" + CRLF
	cQry += "    TRIM(PCF_RESP.PCF_DESCRI) DESC_RESP,                                        								" + CRLF
	cQry += "    SZX.ZX_AREATU AREA_ATUAL,                                                                    				" + CRLF
	cQry += "    TRIM(PCF_ATUAL.PCF_DESCRI) DESC_ATUAL,                                             						" + CRLF
	cQry += "    SIGA.FORMATA_DATA_MS(PDG.PDG_DTREG) DATA_TRANSFERENCIA,                                      				" + CRLF
	cQry += "    NVL(PDF.PDF_QTDSLA,0) QUANTIDADE_SLA_AREA,                                                   				" + CRLF
	cQry += "	CASE                                                                                          				" + CRLF
	cQry += "        WHEN DT_FIM = ' '                                                                        				" + CRLF
	cQry += "        THEN ' '                                                                                 				" + CRLF
	cQry += "        ELSE SIGA.FORMATA_DATA_MS(DT_FIM)                                                        				" + CRLF
	cQry += "    END DT_FIM_AREA,                                                                             				" + CRLF
	cQry += "    SIGA.N_DIAS_UTEIS_PERIODO(TO_DATE(PDG.PDG_DTREG,'YYYYMMDD'),TO_DATE(DT_FIM,'YYYYMMDD')) DIF  				" + CRLF
	cQry += "FROM                                                                                             				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "    " + RetSqlName("SZX") + " SZX  															  				" + CRLF
	cQry += "	                                                                                              				" + CRLF
	cQry += "    INNER JOIN                                                                                   				" + CRLF
	cQry += "			" + RetSqlName("PCF") + " PCF_RESP													  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PCF_RESP.PCF_FILIAL     = SZX.ZX_FILIAL                                                  				" + CRLF
	cQry += "        AND PCF_RESP.PCF_COD    = SZX.ZX_CODAREA                                                 				" + CRLF
	cQry += "        AND PCF_RESP.D_E_L_E_T_ = ' '                                                            				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "	INNER JOIN                                                                                    				" + CRLF
	cQry += "			" + RetSqlName("PCF") + " PCF_ATUAL													  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PCF_ATUAL.PCF_FILIAL = SZX.ZX_FILIAL                                                     				" + CRLF
	cQry += "        AND PCF_ATUAL.PCF_COD = SZX.ZX_AREATU                                                    				" + CRLF
	cQry += "        AND PCF_ATUAL.D_E_L_E_T_ = ' '                                                           				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "	INNER JOIN                                                                                    				" + CRLF
	cQry += "    (                                                                                            				" + CRLF
	cQry += "        SELECT                                                                                   				" + CRLF
	cQry += "            PDG.PDG_SEQ,                                                                         				" + CRLF
	cQry += "            PDG.PDG_AREATU,                                                                      				" + CRLF
	cQry += "            PDG.PDG_DTREG,                                                                       				" + CRLF
	cQry += "            (SELECT min(PDG2.PDG_DTREG)                                                          				" + CRLF
	cQry += "               FROM PDG010 PDG2                                                                  				" + CRLF
	cQry += "              WHERE PDG2.PDG_SEQ = PDG.PDG_SEQ                                                   				" + CRLF
	cQry += "                AND PDG2.D_E_L_E_T_ = ' '                                                        				" + CRLF
	cQry += "                AND PDG2.PDG_DTREG > PDG.PDG_DTREG                                               				" + CRLF
	cQry += "            ) DT_FIM                                                                             				" + CRLF
	cQry += "        FROM                                                                                     				" + CRLF
	cQry += "				" + RetSqlName("PDG") + " PDG													  				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "            INNER JOIN                                                                           				" + CRLF
	cQry += "            (                                                                                    				" + CRLF
	cQry += "                SELECT                                                                           				" + CRLF
	cQry += "                    PDG_INT.PDG_SEQ,                                                             				" + CRLF
	cQry += "                    PDG_INT.PDG_AREATU,                                                          				" + CRLF
	cQry += "                    MIN(PDG_INT.R_E_C_N_O_) INT_RECNO                                            				" + CRLF
	cQry += "                FROM                                                                             				" + CRLF
	cQry += "						" + RetSqlName("PDG") + " PDG_INT										  				" + CRLF
	cQry += "                WHERE                                                                            				" + CRLF
	cQry += "                    PDG_INT.PDG_FILIAL      = '" + xFilial("PDG") + "'                           				" + CRLF
	cQry += "                    AND PDG_INT.D_E_L_E_T_  = ' '                                                				" + CRLF
	cQry += "                GROUP BY                                                                         				" + CRLF
	cQry += "                    PDG_INT.PDG_SEQ,                                                             				" + CRLF
	cQry += "                    PDG_INT.PDG_AREATU                                                           				" + CRLF
	cQry += "            ) PDG_INT                                                                            				" + CRLF
	cQry += "            ON                                                                                   				" + CRLF
	cQry += "            PDG.PDG_SEQ         = PDG_INT.PDG_SEQ                                                				" + CRLF
	cQry += "            AND PDG.PDG_AREATU  = PDG_INT.PDG_AREATU                                             				" + CRLF
	cQry += "            AND PDG.PDG_AREANT <> PDG.PDG_AREATU                                                 				" + CRLF
	cQry += "            AND                                                                                  				" + CRLF
	cQry += "            (                                                                                    				" + CRLF
	cQry += "                SELECT                                                                           				" + CRLF
	cQry += "                    COUNT(*)                                                                     				" + CRLF
	cQry += "                FROM                                                                             				" + CRLF
	cQry += "						" + RetSqlName("PDG") + " PDG_EXT										  				" + CRLF
	cQry += "                WHERE                                                                            				" + CRLF
	cQry += "                    PDG_EXT.PDG_FILIAL      = PDG.PDG_FILIAL                                     				" + CRLF
	cQry += "                    AND PDG_EXT.PDG_SEQ     = PDG.PDG_SEQ                                        				" + CRLF
	cQry += "                    AND PDG_EXT.D_E_L_E_T_  = ' '                                                				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "            ) > 1                                                                                				" + CRLF
	cQry += "            AND PDG.R_E_C_N_O_  = PDG_INT.INT_RECNO                                              				" + CRLF
	cQry += "            AND PDG.D_E_L_E_T_  = ' '                                                            				" + CRLF
	cQry += "    ) PDG                                                                                        				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PDG.PDG_SEQ = SZX.ZX_SEQ                                                                 				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "    INNER JOIN                                                                                   				" + CRLF
	cQry += "			" + RetSqlName("PCF") + " PCF_TRANSF												  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PCF_TRANSF.PCF_FILIAL       = SZX.ZX_FILIAL                                              				" + CRLF
	cQry += "        AND PCF_TRANSF.PCF_COD      = PDG.PDG_AREATU                                             				" + CRLF
	cQry += "        AND PCF_TRANSF.D_E_L_E_T_   = ' '                                                        				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "    INNER JOIN                                                                                   				" + CRLF
	cQry += "			" + RetSqlName("SZY") + " SZY														  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        SZY.ZY_FILIAL       = SZX.ZX_FILIAL                                                      				" + CRLF
	cQry += "        AND SZY.ZY_SEQBA    = SZX.ZX_SEQ                                                         				" + CRLF
	cQry += "        AND SZY.D_E_L_E_T_  = ' '                                                                				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "    INNER JOIN                                                                                   				" + CRLF
	cQry += "			" + RetSqlName("PCG") + " PCG														  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PCG.PCG_FILIAL      = SZX.ZX_FILIAL                                                      				" + CRLF
	cQry += "        AND PCG.PCG_CDDEMA  = SZX.ZX_TPDEM                                                       				" + CRLF
	cQry += "        AND PCG.PCG_CDPORT  = SZX.ZX_PTENT                                                       				" + CRLF
	cQry += "        AND PCG.PCG_CDCANA  = SZX.ZX_CANAL                                                       				" + CRLF
	cQry += "        AND PCG.PCG_CDSERV  = SZY.ZY_TIPOSV                                                      				" + CRLF
	cQry += "        AND PCG.D_E_L_E_T_  = ' '                                                                				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "    INNER JOIN                                                                                   				" + CRLF
	cQry += "			" + RetSqlName("PDF") + " PDF														  				" + CRLF
	cQry += "    ON                                                                                           				" + CRLF
	cQry += "        PDF.PDF_FILIAL      = SZX.ZX_FILIAL                                                      				" + CRLF
	cQry += "        AND PDF.PDF_CODSLA  = PCG.PCG_CDDEMA||PCG.PCG_CDPORT||PCG.PCG_CDCANA||PCG.PCG_CDSERV     				" + CRLF
	cQry += "        AND PDF.PDF_CODARE  = PDG.PDG_AREATU                                                     				" + CRLF
	cQry += "        AND PDF.D_E_L_E_T_  = ' '                                                                				" + CRLF
	cQry += "WHERE                                                                                            				" + CRLF
	cQry += "    SZX.ZX_FILIAL = '" + xFilial("SZX") + "'                                                     				" + CRLF

	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		cQry += "	   AND SZX.ZX_SEQ BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'       				  				" + CRLF
	EndIf

	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
		cQry += "    AND SIGA.FORMATA_DATA_MS(PDG.PDG_DTREG) BETWEEN '" + DTOC(MV_PAR03) + "' AND '" + DTOC(MV_PAR04) + "'	" + CRLF
	EndIf

	If MV_PAR05 = 1
		cQry += "    AND SZX.ZX_TPINTEL <> '2'                                                        						" + CRLF
	ElseIf MV_PAR05 = 2
		cQry += "    AND SZX.ZX_TPINTEL = '2'                                                        						" + CRLF	
	EndIf

	cQry += "    AND SZX.D_E_L_E_T_ = ' '                                                                     				" + CRLF
	cQry += "                                                                                                 				" + CRLF
	cQry += "ORDER BY                                                                                         				" + CRLF
	cQry += "    DATA_TRANSFERENCIA                                                                           				" + CRLF

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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function AjustaSX1(cPerg)

	Local aHelpPor	:= {}

	aHelpPor := {}
	AADD(aHelpPor,"Informe o Protocolo:					")

	u_CABASX1(cPerg,"01","Protocolo De:"	,"Protocolo De"	,"a","MV_CH1"	,"C",TamSX3("ZX_SEQ")[1] 		,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"02","Protocolo Ate: "	,"Protocolo Ate","a","MV_CH2"	,"C",TamSX3("ZX_SEQ")[1] 		,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data de Transferencia:		")

	u_CABASX1(cPerg,"03","Data De: "	    ,"Data De"      ,"a","MV_CH3"	,"D",TamSX3("ZX_DATDE")[1]  	,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"04","Data.Ate:"	    ,"Data Ate"     ,"a","MV_CH4"	,"D",TamSX3("ZX_DATDE")[1]  	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Selecione o Status:					")

	u_CABASX1(cPerg,"05","Status   "		,"a"			,"a","MV_CH5"	,"N",TamSX3("ZX_TPINTEL")[1]	,0,0,"C","","","","","MV_PAR05","Aberto","","","","Encerrado","","","Ambos","","","","","","","","",aHelpPor,{},{},"")	

Return()
