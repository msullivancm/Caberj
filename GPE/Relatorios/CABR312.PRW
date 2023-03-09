
#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR312
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 03/06/2022
@return variant, return_description
/*/
USER FUNCTION CABR312()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR312"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                      
Local oSection2
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTipo := ""
Local cTit := "Aprovação para Pagamento de "
Public cAnoVerba492
Public cTabela := ""
Public cCodverba := ""
Public cPeriodo := ""
Public cValor := ""
Public cMatricula := ""
Public cFil := ""
Public cCentroCusto := ""
Private contador := 1

// cDesCRel := cTit
cDesCRel := "Aprovação para Pagamento"
IF MV_PAR03 = 1
	cTipo := "INSS"
ELSEIF MV_PAR03 = 2 
	cTipo:= "FGTS"
ELSEIF MV_PAR03 = 3 
	cTipo:= "GRRF/FGTS"
ELSEIF MV_PAR03 = 4 
	cTipo:= "IRRF"
	IF SUBSTR(cValToChar(MV_PAR01),5,2) = '12' 
		cAnoVerba492 := MV_PAR01+89
	ELSE
		cAnoVerba492 := MV_PAR01+1
	ENDIF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 1
	cTipo:= "PIS"
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 2
	cTipo:= "LÍQUIDOS"
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 3
	cTipo:= "PENSÕES"
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 4
	cTipo:= "PENSÕES S/ FÉRIAS"
 ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 1
 	cTipo:= "LÍQUIDO DE FÉRIAS"
 ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 2
 	cTipo:= "LÍQUIDO DE RESCISÃO"
 ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 3
 	cTipo:= "VALE TRANSPORTE"
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 4
 	cTipo:= "13º SALÁRIO"
ENDIF

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= ""
oReport:= TReport():New(cPerg,cTit+cTipo,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
//oReport:SetLandScape(.F.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"Aprovação para Pagamento de "+cValToChar(cTipo),) 

		// Colunas do relatorio
		IF MV_PAR03 = 3  // GRRF/FGTS
			TRCell():New(oSection2,""    	,,"CENTRO DE CUSTO"  	, ""	,20	   ,.F.,{|| (cAliasBOL)->CENTROCUSTO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"MATRICULA"  	, ""	,30	   ,.F.,{|| (cAliasBOL)->MATRICULA}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VALOR"  	    , ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )
		ELSEIF MV_PAR03 = 5 .AND. (MV_PAR04 = 3 .OR. MV_PAR04 = 4)
			TRCell():New(oSection2,""    	,,"CENTRO DE CUSTO"  	, ""	,35	   ,.F.,{|| (cAliasBOL)->CENTROCUSTO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"MATRICULA"  			, ""	,30	   ,.F.,{|| (cAliasBOL)->MATRICULA}  		,"LEFT"  ,.T. ,"LEFT" )
			//TRCell():New(oSection2,""    	,,"FUNCIONARIO"  		, ""	,50	   ,.F.,{|| (cAliasBOL)->FUNCIONARIO}  			,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  			, ""	,40	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"BENEFICIARIO"  		, ""	,50	   ,.F.,{|| (cAliasBOL)->BENEFICIARIO}  			,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VALOR"  	    		, ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )
		ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND.(MV_PAR05 = 1 .OR. MV_PAR05 = 2)
			TRCell():New(oSection2,""    	,,"CENTRO DE CUSTO"  	, ""	,30	   ,.F.,{|| (cAliasBOL)->CENTROCUSTO}  			,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"MATRICULA"  			, ""	,30	   ,.F.,{|| (cAliasBOL)->MATRICULA}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  			, ""	,40	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VALOR"  	    		, ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )
		ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 3
			TRCell():New(oSection2,""    	,,"VT FUNCIONARIO"  	, ""	,30	   ,.F.,{|| (cAliasBOL)->VALE_TRANSPORTE}  			,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VT EMPRESA" 			, ""	,30	   ,.F.,{|| (cAliasBOL)->VT_EMPRESA}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"TOTAL"  				, ""	,40	   ,.F.,{|| (cAliasBOL)->TOTAL}  		,"LEFT"  ,.T. ,"LEFT" )
		ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 4
			TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VALOR"  	    , ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )
		ELSE 
			TRCell():New(oSection2,""    	,,"VERBAS"  	, ""	,35	   ,.F.,{|| (cAliasBOL)->VERBAS}  			,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
			TRCell():New(oSection2,""    	,,"VALOR"  	    , ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )
		ENDIF

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
//Local oSection1 
Local oSection2 
//Local aUser 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 

oSection2 := oReport:Section(1)
If MV_PAR02 = 1
	cTabela := "SRC"
	cCodverba := "RC_PD"
	cPeriodo := "RC_PERIODO"
	cValor := "RC_VALOR"
	cMatricula := "RC_MAT"
	cFil := "RC_FILIAL"
	cCentroCusto := "RC_CC"
	cVTFunc := "R0_VLRFUNC"
	cVTEmp := "R0_VLREMP"
	cVTTotal := "R0_VALCAL"
	cVTTabela := "SR0"
	cVTPeriodo := "R0_PERIOD"
ELSE
	cTabela := "SRD"
	cCodverba := "RD_PD"
	cPeriodo := "RD_PERIODO"
	cValor := "RD_VALOR"
	cMatricula := "RD_MAT"
	cFil := "RD_FILIAL"
	cCentroCusto := "RD_CC"
	cVTFunc := "RG2_CUSFUN"
	cVTEmp := "RG2_CUSEMP"
	cVTTotal := "RG2_VALCAL"
	cVTTabela := "RG2"
	cVTPeriodo := "RG2_PERIOD"
endif

// Query para buscar os dados no banco

IF MV_PAR03 = 1    // INSS
	cQry:="	SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		 TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     														" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="						FROM "+cTabela+"010 "+cTabela+"   																					" + CRLF
	cQry+="		        		WHERE "+cTabela+".D_E_L_E_T_=' '     																				" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('403')     																					" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     															" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('403')      																								" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')    	 													" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="						FROM "+cTabela+"010 "+cTabela+"   																					" + CRLF
	cQry+="		        		WHERE "+cTabela+".D_E_L_E_T_=' '     																				" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('430')     																					" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     															" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '    																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('430')      																								" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     														" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="						FROM "+cTabela+"010 "+cTabela+"   																					" + CRLF
	cQry+="		        		WHERE "+cTabela+".D_E_L_E_T_=' '     																				" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('491')     																					" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     															" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('491')      																								" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '1' SECAO,'TOTAL' VERBAS, 'TOTAL INSS EMPREGADOS'  DESCRICAO, 																	" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  											" + CRLF
	cQry+="	FROM (SELECT SUM("+cValor+") TOTAL     																									" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     																						" + CRLF
	cQry+="		        	AND "+cCodverba+" IN ('403','430','491')    																			" + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																					" + CRLF
	cQry+="		        GROUP BY "+cCodverba+" ) TOTAL1  																							" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '2' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     														" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   																									" + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     																						" + CRLF
	cQry+="		        	AND "+cCodverba+" IN ('715','716','717')     																			" + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																					" + CRLF
	cQry+="				GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     																" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('715','716','717')  																						" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '2' SECAO,'TOTAL' VERBAS, 'TOTAL INSS EMPRESA' DESCRICAO, 																		" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ')     												" + CRLF
	cQry+="	FROM (SELECT SUM("+cValor+") TOTAL     																									" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="			WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="				AND "+cCodverba+" IN ('715','716','717')     																				" + CRLF
	cQry+="		        AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="		    GROUP BY "+cCodverba+" ) TOTAL1  																								" + CRLF
    cQry+="UNION ALL  																																" + CRLF
    cQry+="	SELECT '3' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     														" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="					FROM "+cTabela+"010 "+cTabela+"   																						" + CRLF
	cQry+="		        	WHERE "+cTabela+".D_E_L_E_T_=' '     																					" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('883','490')     																				" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     															" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('883','490')      																						" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '3' SECAO,'TOTAL' VERBAS, 'TOTAL DISSIDIO' DESCRICAO,																			" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ')     												" + CRLF
	cQry+="	FROM (SELECT SUM("+cValor+") TOTAL     																									" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="			WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="				AND "+cCodverba+" IN ('883','490')     																						" + CRLF
	cQry+="				AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="			GROUP BY "+cCodverba+" ) TOTAL1  																								" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '4' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR    												" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																										" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     														" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="					FROM "+cTabela+"010 "+cTabela+"   																						" + CRLF
	cQry+="		        	WHERE "+cTabela+".D_E_L_E_T_=' '     																					" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('220','108','111','712', '363')     															" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     															" + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="			AND "+cCodverba+" IN ('220','108','111','712','363')     																		" + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																						" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '4' SECAO,'TOTAL' VERBAS, 'TOTAL DEDUÇÕES' DESCRICAO , 																			" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  											" + CRLF
	cQry+="	FROM (SELECT SUM("+cValor+") TOTAL     																									" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="		    WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="		    	AND "+cCodverba+" IN ('220','108','111','712','363')     																	" + CRLF
	cQry+="		        AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="		    GROUP BY "+cCodverba+" ) TOTAL1  																								" + CRLF
    cQry+="UNION ALL     																															" + CRLF
	cQry+="	SELECT '5' SECAO,'INSS' VERBAS, 'TOTAL DA GUIA INSS' DESCRICAO , 																		" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     																			" + CRLF
	cQry+="										FROM 																								" + CRLF
	cQry+="										(SELECT SUM("+cValor+") TOTAL     																	" + CRLF
	cQry+="											FROM "+cTabela+"010 "+cTabela+"   																" + CRLF
	cQry+="	                                        WHERE "+cTabela+".D_E_L_E_T_=' '     															" + CRLF
	cQry+="	                                        	AND "+cCodverba+" IN ('220','108','111','712','363')										" + CRLF
	cQry+="	                                           	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     														" + CRLF
	cQry+="	                                       GROUP BY "+cCodverba+" ) TOTAL2),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR	" + CRLF
	cQry+="	FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																					" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="		    	WHERE "+cTabela+".D_E_L_E_T_=' '     																						" + CRLF
	cQry+="		        	AND "+cCodverba+" IN ('403','430','491','490','883','715','717','716')     												" + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																					" + CRLF
	cQry+="		        GROUP BY "+cCodverba+" ) TOTAL1     																						" + CRLF
	cQry+="	GROUP BY 'TOTAL'  																														" + CRLF
ELSEIF MV_PAR03 = 2  //FGTS
	cQry:="	SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 'BASE FGTS FUNCIONÁRIOS (720+721)' DESCRICAO,   															" + CRLF
    cQry+="		TO_CHAR((SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     																					" + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="														FROM "+cTabela+"010 "+cTabela+"   																	" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        		WHERE "+cTabela+".D_E_L_E_T_=' '     																" + CRLF
	cQry+="		                                         			AND "+cCodverba+" IN ('720','721')     																" + CRLF
	cQry+="		                                           			AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     															" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       			GROUP BY "+cCodverba+" ) TOTAL2) VALOR     															" + CRLF
	cQry+="					FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																					" + CRLF
	cQry+="							FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="		       				 WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="		        				AND "+cCodverba+" IN ('720','721')     																						" + CRLF
	cQry+="		            			AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="		            		GROUP BY "+cCodverba+" ) TOTAL1     																							" + CRLF
	cQry+="		            GROUP BY 'TOTAL'),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  														" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 																											" + CRLF
	cQry+="		'BASE FGTS DIF DISSIDIO E DIF DISS 13º SAL (878+880)' DESCRICAO,																					" + CRLF
	cQry+="		TO_CHAR((SELECT SUM(TOTAL1.TOTAL) VALOR     																										" + CRLF
	cQry+="					FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																					" + CRLF
	cQry+="							FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="							WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="								AND "+cCodverba+" IN ('878','880')     																						" + CRLF
	cQry+="								AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="							GROUP BY "+cCodverba+" ) TOTAL1     																							" + CRLF
	cQry+="					GROUP BY 'TOTAL'),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  														" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 'FGTS CALCULO DEPOSITO DO MÊS (8%)' DESCRICAO,															" + CRLF
	cQry+="		TO_CHAR(CAST(0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     																		" + CRLF
	cQry+="		                                        		FROM (SELECT SUM("+cValor+") TOTAL     																" + CRLF
	cQry+="																FROM "+cTabela+"010 "+cTabela+"   															" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                       					 WHERE "+cTabela+".D_E_L_E_T_=' '   														" + CRLF
	cQry+="		                                         					AND "+cCodverba+" IN ('720','721')    														" + CRLF
	cQry+="		                                           					AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'														" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       				GROUP BY "+cCodverba+" ) TOTAL2) VALOR  														" + CRLF
	cQry+="							FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																			" + CRLF
	cQry+="									FROM "+cTabela+"010 "+cTabela+"   																						" + CRLF
	cQry+="		        					WHERE "+cTabela+".D_E_L_E_T_=' '     																					" + CRLF
	cQry+="		        						AND "+cCodverba+" IN ('720','721', '878','880')     																" + CRLF
	cQry+="		            					AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            			GROUP BY "+cCodverba+" ) TOTAL1     																						" + CRLF
	cQry+="		            		GROUP BY 'TOTAL') AS DECIMAL(10,2)),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR								" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '10' SECAO,'BASE FGTS' VERBAS, 'BASE FGTS APRENDIZES (720+721)' DESCRICAO,																	" + CRLF
	cQry+="		TO_CHAR(CAST((SELECT SUM(TOTAL1.TOTAL) VALOR     																									" + CRLF
	cQry+="						FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																				" + CRLF
	cQry+="								FROM "+cTabela+"010 "+cTabela+"   																							" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="								WHERE "+cTabela+".D_E_L_E_T_=' '     																						" + CRLF
	cQry+="									AND "+cCodverba+" IN ('720', '721')     																						" + CRLF
	cQry+="							        AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																					" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="							    GROUP BY "+cCodverba+" ) TOTAL1     																						" + CRLF
	cQry+="						GROUP BY 'TOTAL') AS DECIMAL(10,2)),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     								" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '10' SECAO,'BASE FGTS' VERBAS, 'FGTS CALCULO DEPÓSITO DO MÊS (2%)' DESCRICAO, 															" + CRLF
	cQry+="		TO_CHAR(0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     																									" + CRLF
	cQry+="						FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																				" + CRLF
	cQry+="								FROM "+cTabela+"010 "+cTabela+"   																							" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="						        WHERE "+cTabela+".D_E_L_E_T_=' '     																						" + CRLF
	cQry+="						        	AND "+cCodverba+" IN ('720', '721')     																						" + CRLF
	cQry+="						            AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																					" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="						        GROUP BY "+cCodverba+" ) TOTAL1     																						" + CRLF
	cQry+="						GROUP BY 'TOTAL'),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     													" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '11' SECAO,'BASE FGTS' VERBAS, 'TOTAL BASE FGTS' DESCRICAO,																				" + CRLF
	cQry+="		TO_CHAR((SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     																					" + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     																		" + CRLF
	cQry+="														FROM "+cTabela+"010 "+cTabela+"   																	" + CRLF
	cQry+="		                                        		WHERE "+cTabela+".D_E_L_E_T_=' '     																" + CRLF
	cQry+="		                                         		AND "+cCodverba+" IN ('FDB')     																	" + CRLF
	cQry+="		                                           		AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																" + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     																	" + CRLF
	cQry+="				FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																						" + CRLF
	cQry+="						FROM "+cTabela+"010 "+cTabela+"   																									" + CRLF
	cQry+="		        		WHERE "+cTabela+".D_E_L_E_T_=' '     																								" + CRLF
	cQry+="		        			AND "+cCodverba+" IN ('720','721','878','880','FDB')     																		" + CRLF
	cQry+="		            		AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																							" + CRLF
	cQry+="		            	GROUP BY "+cCodverba+" ) TOTAL1     																								" + CRLF
	cQry+="		            GROUP BY 'TOTAL'),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     														" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL     																																			" + CRLF
	cQry+="	SELECT DISTINCT '11' SECAO,'BASE FGTS' VERBAS, 'TOTAL DEPOSITO FGTS' DESCRICAO,																			" + CRLF
	cQry+="		TO_CHAR(CAST((0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     																		" + CRLF
	cQry+="		                                        			FROM (SELECT SUM("+cValor+") TOTAL     															" + CRLF
	cQry+="																	FROM "+cTabela+"010 "+cTabela+"   														" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        					WHERE "+cTabela+".D_E_L_E_T_=' '     													" + CRLF
	cQry+="		                                         						AND "+cCodverba+" IN ('720','721')     													" + CRLF
	cQry+="		                                           						AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     												" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       						GROUP BY "+cCodverba+" ) TOTAL2) VALOR     												" + CRLF
	cQry+="							FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																			" + CRLF
	cQry+="									FROM "+cTabela+"010 "+cTabela+"   																						" + CRLF
	cQry+="		        						WHERE "+cTabela+".D_E_L_E_T_=' '     																				" + CRLF
	cQry+="		        							AND "+cCodverba+" IN ('720','721', '878','880')     															" + CRLF
	cQry+="		            						AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																			" + CRLF
	cQry+="		            				GROUP BY "+cCodverba+" ) TOTAL1     																					" + CRLF
	cQry+="		            		GROUP BY 'TOTAL'))+(0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     																	" + CRLF
	cQry+="														FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL   												" + CRLF
	cQry+="																FROM "+cTabela+"010 "+cTabela+"   															" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        												WHERE "+cTabela+".D_E_L_E_T_=' '     														" + CRLF
	cQry+="		        													AND "+cCodverba+" IN ('720','721')     														" + CRLF
	cQry+="		            												AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     													" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            											GROUP BY "+cCodverba+" ) TOTAL1     														" + CRLF
	cQry+="		            									GROUP BY 'TOTAL') ) AS DECIMAL(10,2)),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  " + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL  																																				" + CRLF
    cQry+="	SELECT DISTINCT '12' SECAO,'BASE FGTS' VERBAS, 'PREVISAO RECOLHIMENTO FGTS (725+726+882+884)' DESCRICAO,												" + CRLF
	cQry+="		TO_CHAR((SELECT SUM(TOTAL1.TOTAL) VALOR   																											" + CRLF
	cQry+="					FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																					" + CRLF
	cQry+="							FROM "+cTabela+"010 "+cTabela+"   																								" + CRLF
	cQry+="		        			WHERE "+cTabela+".D_E_L_E_T_=' '     																							" + CRLF
	cQry+="		        				AND "+cCodverba+" IN ('725','726','882','884')     																			" + CRLF
	cQry+="		        			    AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																						" + CRLF
	cQry+="		        			GROUP BY "+cCodverba+" ) TOTAL1     																							" + CRLF
	cQry+="		            GROUP BY 'TOTAL'),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     														" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
    cQry+="UNION ALL  																																				" + CRLF
    cQry+="	SELECT DISTINCT '12' SECAO,'BASE FGTS' VERBAS, 'DIFERENÇA' DESCRICAO,																					" + CRLF
	cQry+="		TO_CHAR(CAST((0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)    																		" + CRLF
	cQry+="		                                        			FROM (SELECT SUM("+cValor+") TOTAL     															" + CRLF
	cQry+="																	FROM "+cTabela+"010 "+cTabela+"   														" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        					WHERE "+cTabela+".D_E_L_E_T_=' '     													" + CRLF
	cQry+="		                                         						AND "+cCodverba+" IN ('720','721')     													" + CRLF
	cQry+="		                                           						AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     												" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       						GROUP BY "+cCodverba+" ) TOTAL2) VALOR     												" + CRLF
	cQry+="							FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     																			" + CRLF
	cQry+="									FROM "+cTabela+"010 "+cTabela+"   																						" + CRLF
	cQry+="		        					WHERE "+cTabela+".D_E_L_E_T_=' '     																					" + CRLF
	cQry+="		        						AND "+cCodverba+" IN ('720','721', '878','880')     																" + CRLF
	cQry+="		            					AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																				" + CRLF
	cQry+="		            				GROUP BY "+cCodverba+" ) TOTAL1     																					" + CRLF
	cQry+="		            			GROUP BY 'TOTAL'))+(0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     																" + CRLF
	cQry+="															FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     											" + CRLF
	cQry+="																	FROM "+cTabela+"010 "+cTabela+"   														" + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        													WHERE "+cTabela+".D_E_L_E_T_=' '     													" + CRLF
	cQry+="		        														AND "+cCodverba+" IN ('720','721')     													" + CRLF
	cQry+="		            													AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     												" + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            												GROUP BY "+cCodverba+" ) TOTAL1     													" + CRLF
	cQry+="		            										GROUP BY 'TOTAL') )- ((SELECT SUM(TOTAL1.TOTAL) VALOR     										" + CRLF
	cQry+="																					FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     					" + CRLF
	cQry+="																							FROM "+cTabela+"010 "+cTabela+"   								" + CRLF
	cQry+="		        																			WHERE "+cTabela+".D_E_L_E_T_=' '     							" + CRLF
	cQry+="		        																				AND "+cCodverba+" IN ('725','726','882','884')     			" + CRLF
	cQry+="		        																			    AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     						" + CRLF
	cQry+="		            																GROUP BY "+cCodverba+" ) TOTAL1     									" + CRLF
	cQry+="		            	GROUP BY 'TOTAL')) AS DECIMAL(10,2)),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     								" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"  																														" + CRLF
ELSEIF MV_PAR03 = 3 // GRRF/FGTS
	cQry:="  SELECT '1' SECAO, RR_CC CENTROCUSTO, TO_CHAR(RR_MAT) MATRICULA, CONCAT(RR_PD, CONCAT(' - ', RV_DESC)) DESCRICAO,	" + CRLF
	cQry+=" 	TO_CHAR(RR_VALOR,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR 							" + CRLF
	cQry+="	FROM SRR010 SRR    																							" + CRLF
    cQry+="		INNER JOIN SRV010 SRV ON ( RR_PD = RV_COD AND SRV.D_E_L_E_T_=' ')  										" + CRLF
    cQry+="	WHERE SRR.D_E_L_E_T_=' '      																				" + CRLF
    cQry+="		AND RR_PD IN ('730','731','732','733','739','882','884')      											" + CRLF
    cQry+="		AND RR_PERIODO = '"+cValToChar(MV_PAR01)+"'      																	" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" AND RR_MAT = '"+MV_PAR06+"' 																			" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR07)
		cQry+=" AND RR_DATAPAG = '"+cValToChar(MV_PAR01)+MV_PAR07+"' 																			" + CRLF
	ENDIF
	cQry+="UNION ALL 																									" + CRLF
 	cQry+="	SELECT '2' SECAO,'' CENTROCUSTO, '' MATRICULA, 'TOTAL'  DESCRICAO,													" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.TOTAL),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR      			" + CRLF
	cQry+="	FROM (SELECT SUM(RR_VALOR) TOTAL      																		" + CRLF
	cQry+="			FROM SRR010 SRR    																					" + CRLF
	cQry+=" 		WHERE SRR.D_E_L_E_T_=' '      																		" + CRLF
	cQry+=" 			AND RR_PD IN ('730','731','732','733','739','882','884')      									" + CRLF
	cQry+=" 			AND RR_PERIODO= '"+cValToChar(MV_PAR01)+"'      															" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" 		AND RR_MAT = '"+MV_PAR06+"' 																	" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR07)
		cQry+=" AND RR_DATAPAG = '"+cValToChar(MV_PAR01)+MV_PAR07+"' 																			" + CRLF
	ENDIF
	cQry+=" 		GROUP BY RR_PD ) TOTAL1 																			" + CRLF
    cQry+="		     ORDER BY SECAO, MATRICULA, DESCRICAO																		" + CRLF
	ELSEIF MV_PAR03 = 4  //IRRF
	cQry:="	SELECT '14' SECAO,'IRRF' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO, 						" + CRLF
	cQry+="		TO_CHAR(TOTAL.TOTAL,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR   							" + CRLF  
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																				" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     								" + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     												" + CRLF
	cQry+="					FROM "+cTabela+"010 "+cTabela+"   																" + CRLF
	cQry+="		        	WHERE "+cTabela+".D_E_L_E_T_=' '     															" + CRLF
	cQry+="		        		AND "+cCodverba+" IN ('404','431','493')     												" + CRLF
	cQry+="		            	AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     														" + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     									" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '     																			" + CRLF
	cQry+="		AND "+cCodverba+" IN ('404','431','493')      																" + CRLF
	cQry+="	GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  																	" + CRLF
    cQry+="UNION ALL  																										" + CRLF
	cQry+="	SELECT '14' SECAO, 'IRRF' VERBAS, CONCAT(RR_PD, CONCAT(' - ',CONCAT(TRIM(RV_DESC), ' PRÓX. MÊS'))) DESCRICAO,	" + CRLF
	cQry+=" 	TO_CHAR(SUM(RR_VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR  						" + CRLF
	cQry+="	FROM SRR010 SRR  																								" + CRLF
	cQry+="		INNER JOIN SRV010 SRV ON ( RR_PD = RV_COD AND SRV.D_E_L_E_T_=' ')  											" + CRLF
	cQry+="	WHERE RR_PD IN ('492') 																							" + CRLF
	cQry+="		AND RR_DATA LIKE '"+cValToChar(cAnoVerba492)+"%'  																			" + CRLF
	cQry+="		AND SRR.D_E_L_E_T_ = ' ' 																					" + CRLF
	cQry+="	GROUP BY RR_PD, RV_DESC 																						" + CRLF
    cQry+="UNION ALL  																										" + CRLF
    cQry+="	SELECT '13' SECAO,'IRRF' VERBAS, 'TOTAL'  DESCRICAO,															" + CRLF
	cQry+="		TO_CHAR(SUM(TOTAL1.VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR     					" + CRLF
	cQry+="	FROM (SELECT SUM("+cValor+") VALOR   							  " + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"   																				" + CRLF								
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '     																			" + CRLF
	cQry+="		AND RD_PD IN ('404','431','493')  " + CRLF
    cQry+="        AND RD_PERIODO= '"+cValToChar(MV_PAR01)+"'  																	" + CRLF
    cQry+="UNION ALL  																										" + CRLF
	cQry+="	SELECT SUM(RR_VALOR) VALOR  						" + CRLF
	cQry+="	FROM SRR010 SRR  																								 " + CRLF											
	cQry+="	WHERE RR_PD IN ('492') 																							" + CRLF
	cQry+="		AND RR_DATA LIKE '"+cValToChar(cAnoVerba492)+"%'  															" + CRLF				
	cQry+="		AND SRR.D_E_L_E_T_ = ' '  ) TOTAL1  																		" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 1 //PIS
	cQry:="	SELECT '5' SECAO, 'PIS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO, 						" + CRLF
	cQry+="		TO_CHAR(SUM("+cValor+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR      					" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"    																				" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')      								" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '      																			" + CRLF
	cQry+="		AND "+cCodverba+" IN ('189')   																				" + CRLF
    cQry+="		AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'     																		" + CRLF
	cQry+="	GROUP BY "+cCodverba+", RV_DESC 																				" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 2 //LÍQUIDOS
	cQry:="	SELECT '4' SECAO, 'LIQUIDOS' VERBAS, " + CRLF
	cQry+="		CONCAT("+cCodverba+", CONCAT(' - ',CONCAT(TRIM(RV_DESC), CONCAT(' - ', 																						" + CRLF
	cQry+="															CASE WHEN "+cMatricula+" < '600000' THEN 'FUNCIONÁRIOS'													" + CRLF
	cQry+="															WHEN "+cMatricula+" BETWEEN '600000' AND '799999' THEN 'ESTAGIÁRIOS' 									" + CRLF
	cQry+="															END)))) DESCRICAO, TO_CHAR(SUM("+cValor+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR " + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"       																															" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')         																			" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '         																														" + CRLF
	cQry+="		AND "+cCodverba+" IN ('600')         																														" + CRLF
    cQry+="     AND "+cMatricula+" < '799999'    																															" + CRLF
    cQry+="     AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'    																														" + CRLF
	cQry+="	GROUP BY  CONCAT("+cCodverba+", CONCAT(' - ',CONCAT(TRIM(RV_DESC), CONCAT(' - ', 																				" + CRLF
	cQry+="																		CASE WHEN "+cMatricula+" < '600000' THEN 'FUNCIONÁRIOS' 									" + CRLF
	cQry+="																		WHEN "+cMatricula+" BETWEEN '600000' AND '799999' THEN 'ESTAGIÁRIOS' END))))    			" + CRLF
	cQry+="UNION ALL    																																					" + CRLF
	cQry+="	SELECT '5' SECAO, 'LIQUIDOS' VERBAS, 'TOTAL' DESCRICAO, 																										" + CRLF
	cQry+="		TO_CHAR(SUM("+cValor+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ')  VALOR  																		" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"       																															" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')         																			" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '         																														" + CRLF
	cQry+="		AND "+cCodverba+" IN ('600')         																														" + CRLF
    cQry+="     AND "+cMatricula+" < '799999'    																															" + CRLF
    cQry+="     AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'    																														" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 3 //PENSÕES
	cQry:="	SELECT '4' SECAO, "+cCentroCusto+" CENTROCUSTO, "+cMatricula+" MATRICULA, TRIM(RA_NOME) FUNCIONARIO,	" + CRLF
	cQry+="		CONCAT("+cCodverba+", CONCAT(' - ',TRIM(RV_DESC))) DESCRICAO, RQ_NOME BENEFICIARIO,					" + CRLF
	cQry+=" 	TO_CHAR("+cValor+",'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR   					" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"        																	" + CRLF
	cQry+="		INNER JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')      						" + CRLF
	cQry+="		INNER JOIN SRA010 SRA ON (RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_=' ') 							" + CRLF
	cQry+="		INNER JOIN SRQ010 SRQ ON ("+cMatricula+" = RQ_MAT AND SRQ.D_E_L_E_T_=' ') 							" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '          																" + CRLF
	cQry+="		AND "+cCodverba+" IN ('410','437','462')             												" + CRLF
	cQry+="		AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'  																	" + CRLF
	cQry+="UNION ALL     																							" + CRLF
	cQry+="	SELECT '5' SECAO, '' CENTROCUSTO, '' MATRICULA, '' FUNCIONARIO, 'TOTAL' DESCRICAO, '' BENEFICIARIO,		" + CRLF
	cQry+=" 	TO_CHAR(SUM(VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR 					" + CRLF
	cQry+="	FROM ( 																									" + CRLF
	cQry+="		SELECT  "+cValor+" VALOR    																		" + CRLF
	cQry+="			FROM "+cTabela+"010 "+cTabela+"        															" + CRLF
	cQry+="			WHERE "+cTabela+".D_E_L_E_T_=' '          														" + CRLF
	cQry+="				AND "+cCodverba+" IN ('410','437','462')             										" + CRLF
	cQry+="				AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'  															" + CRLF
	cQry+="	) 																										" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 4  //PENSÕES S/ FÉRIAS
	cQry:="	SELECT '4' SECAO, RR_CC CENTROCUSTO, RR_MAT MATRICULA, TRIM(RA_NOME) FUNCIONARIO,						" + CRLF
	cQry+="		CONCAT(RR_PD, CONCAT(' - ',TRIM(RV_DESC))) DESCRICAO, RQ_NOME BENEFICIARIO,							" + CRLF
	cQry+="		TO_CHAR(RR_VALOR,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR,    					" + CRLF
	cQry+="		TO_CHAR(TO_DATE(RR_DATAPAG,'YYYY-MM-DD')) DATA_PAGAMENTO    										" + CRLF
	cQry+="	FROM SRR010 SRR        																					" + CRLF
	cQry+="		INNER JOIN SRV010 SRV ON (RR_PD = RV_COD AND SRV.D_E_L_E_T_=' ')      								" + CRLF
	cQry+="		INNER JOIN SRA010 SRA ON (RA_MAT = RR_MAT AND SRA.D_E_L_E_T_=' ') 									" + CRLF
	cQry+="		INNER JOIN SRQ010 SRQ ON (RR_MAT = RQ_MAT AND SRQ.D_E_L_E_T_=' ') 									" + CRLF
	cQry+="	WHERE SRR.D_E_L_E_T_=' '          																		" + CRLF
	cQry+="		AND RR_PD IN ('495')             																	" + CRLF
	cQry+="		AND RR_PERIODO= '"+cValToChar(MV_PAR01)+"'  														" + CRLF
	cQry+="UNION ALL     																							" + CRLF
	cQry+="	SELECT '5' SECAO, '' CENTROCUSTO, '' MATRICULA, '' FUNCIONARIO, 'TOTAL' DESCRICAO, '' BENEFICIARIO,		" + CRLF
	cQry+=" 	TO_CHAR(SUM(RR_VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR, 				" + CRLF
	cQry+=" 	' ' DATA_PAGAMENTO																					" + CRLF
	cQry+="	FROM SRR010 SRR        																					" + CRLF
	cQry+="	WHERE SRR.D_E_L_E_T_=' '          																		" + CRLF
	cQry+="		AND RR_PD IN ('495')             																	" + CRLF
	cQry+="		AND RR_PERIODO= '"+cValToChar(MV_PAR01)+"' 															" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 1  //LÍQUIDO DE FÉRIAS
	cQry:="	SELECT 																									" + CRLF
   	cQry+="		'1' SECAO, RR_CC CENTROCUSTO, RR_MAT MATRICULA,  CONCAT(RR_PD,CONCAT(' - ', RV_DESC)) DESCRICAO,	" + CRLF
	cQry+="		TO_CHAR(TO_DATE(RR_DATAPAG,'YYYY-MM-DD')) DATA_PAGAMENTO,											" + CRLF
	cQry+="		TO_CHAR(RR_VALOR,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR						" + CRLF
	cQry+="	FROM SRR010 SRR																							" + CRLF
    cQry+="		INNER JOIN SRV010 SRV ON (RV_COD = RR_PD AND SRV.D_E_L_E_T_ = ' ')									" + CRLF
	cQry+="	WHERE																									" + CRLF
    cQry+="		SRR.D_E_L_E_T_ = ' '																				" + CRLF
	cQry+="		AND RR_PERIODO= '"+cValToChar(MV_PAR01)+"' 															" + CRLF
    cQry+="		AND RR_PD IN ('499')																				" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" 		AND RR_MAT = '"+MV_PAR06+"' 																	" + CRLF
	ENDIF
	cQry+="UNION ALL																								" + CRLF
	cQry+="	SELECT 																									" + CRLF
   	cQry+="		'2' SECAO, ' ' CENTROCUSTO, ' ' MATRICULA, 'TOTAL' DESCRICAO,' ' DATA_PAGAMENTO,					" + CRLF
	cQry+="   	TO_CHAR(SUM(RR_VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR					" + CRLF
	cQry+="	FROM SRR010 SRR																							" + CRLF
	cQry+="	WHERE																									" + CRLF
    cQry+="		SRR.D_E_L_E_T_ = ' '																				" + CRLF
	cQry+="		AND RR_PERIODO= '"+cValToChar(MV_PAR01)+"' 															" + CRLF
    cQry+="		AND RR_PD IN ('499')																				" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" 		AND RR_MAT = '"+MV_PAR06+"' 																	" + CRLF
	ENDIF
    cQry+="		     ORDER BY SECAO, MATRICULA																		" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 2 //LÍQUIDO DE RESCISÃO
	cQry:="SELECT  																									" + CRLF
	cQry+="		'1' SECAO, RR_CC CENTROCUSTO, RR_MAT MATRICULA,  CONCAT(RR_PD,CONCAT(' - ', RV_DESC)) DESCRICAO,	" + CRLF
	cQry+="   TO_CHAR(RR_DATAPAG) DATA_PAGAMENTO,																	" + CRLF
	cQry+="   TO_CHAR(RR_VALOR,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR 						" + CRLF
	cQry+="FROM SRR010 SRR 																							" + CRLF
	cQry+="    INNER JOIN SRV010 SRV ON (RV_COD = RR_PD AND SRV.D_E_L_E_T_ = ' ') 									" + CRLF
	cQry+="WHERE 																									" + CRLF
	cQry+="    SRR.D_E_L_E_T_ = ' ' 																				" + CRLF
	cQry+="    AND RR_DATAPAG LIKE '"+cValToChar(MV_PAR01)+MV_PAR07+"' 												" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" 		AND RR_MAT = '"+MV_PAR06+"' 																" + CRLF
	ENDIF
	cQry+="    AND RR_PD IN ('599') 																				" + CRLF
	cQry+="UNION ALL 																								" + CRLF
	cQry+="SELECT  																									" + CRLF
	cQry+="		'2' SECAO, ' ' CENTROCUSTO, ' ' MATRICULA, 'TOTAL' DESCRICAO,' ' DATA_PAGAMENTO,					" + CRLF
	cQry+="   TO_CHAR(SUM(RR_VALOR),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR 					" + CRLF
	cQry+="FROM SRR010 SRR 																							" + CRLF
	cQry+="WHERE 																									" + CRLF
	cQry+="    SRR.D_E_L_E_T_ = ' ' 																				" + CRLF
	cQry+="    AND RR_DATAPAG LIKE '"+cValToChar(MV_PAR01)+MV_PAR07+"' 												" + CRLF
	IF !EMPTY(MV_PAR06)
		cQry+=" 		AND RR_MAT = '"+MV_PAR06+"' 																" + CRLF
	ENDIF
	cQry+="    AND RR_PD IN ('599') 																				" + CRLF
    cQry+="		     ORDER BY SECAO, MATRICULA																		" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 3 //VALE TRANSPORTE
	cQry:="SELECT  																									" + CRLF
	cQry+="		'1' SECAO, ' ' DESCRICAO, 																			" + CRLF
	cQry+="		TO_CHAR(SUM("+cVTFunc+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALE_TRANSPORTE, 	" + CRLF
	cQry+="		TO_CHAR(SUM("+cVTEmp+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VT_EMPRESA,			" + CRLF
	cQry+="		TO_CHAR(SUM("+cVTTotal+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') TOTAL				" + CRLF
	cQry+="FROM 																									" + CRLF
	cQry+="    SIGA."+cVTTabela+"010 "+cVTTabela+"																	" + CRLF
	cQry+="WHERE 																									" + CRLF
	cQry+="    "+cVTTabela+".D_E_L_E_T_ = ' ' 																		" + CRLF
	cQry+="    AND "+cVTPeriodo+" LIKE '"+cValToChar(MV_PAR01)+"' 													" + CRLF
ELSEIF MV_PAR03 = 5 .AND. MV_PAR04 = 5 .AND. MV_PAR05 = 4 // 13 SALARIO
	cQry:="	SELECT '4' SECAO,  " + CRLF
	cQry+="		CONCAT("+cCodverba+", CONCAT(' - ',CONCAT(TRIM(RV_DESC), CONCAT(' - ', 																						" + CRLF
	cQry+="															CASE WHEN "+cMatricula+" < '600000' THEN 'FUNCIONÁRIOS'													" + CRLF
	cQry+="															WHEN "+cMatricula+" BETWEEN '600000' AND '799999' THEN 'ESTAGIÁRIOS' 									" + CRLF
	cQry+="															END)))) DESCRICAO, TO_CHAR(SUM("+cValor+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ') VALOR " + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"       																															" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')         																			" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '         																														" + CRLF
	cQry+="		AND ("+cCodverba+" IN ('200', '308') OR "+cCodverba+" IN ('444'))        																														" + CRLF
    cQry+="     AND "+cMatricula+" < '799999'    																															" + CRLF
    cQry+="     AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'    																														" + CRLF
	cQry+="	GROUP BY  CONCAT("+cCodverba+", CONCAT(' - ',CONCAT(TRIM(RV_DESC), CONCAT(' - ', 																				" + CRLF
	cQry+="																		CASE WHEN "+cMatricula+" < '600000' THEN 'FUNCIONÁRIOS' 									" + CRLF
	cQry+="																		WHEN "+cMatricula+" BETWEEN '600000' AND '799999' THEN 'ESTAGIÁRIOS' END))))    			" + CRLF
	cQry+="UNION ALL    																																					" + CRLF
	cQry+="	SELECT '5' SECAO,  'TOTAL' DESCRICAO, 																										" + CRLF
	cQry+="		TO_CHAR(SUM("+cValor+"),'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ')  VALOR  																		" + CRLF
	cQry+="	FROM "+cTabela+"010 "+cTabela+"       																															" + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')         																			" + CRLF
	cQry+="	WHERE "+cTabela+".D_E_L_E_T_=' '         																														" + CRLF
	cQry+="		AND ("+cCodverba+" IN ('200', '308') OR "+cCodverba+" IN ('444'))         																														" + CRLF
    cQry+="     AND "+cMatricula+" < '799999'    																															" + CRLF
    cQry+="     AND "+cPeriodo+"= '"+cValToChar(MV_PAR01)+"'    																														" + CRLF
ENDIF

//cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)


dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection2:Init()
	cSecao := (cAliasBOL)->SECAO
	cDescricao := (cAliasBOL)->DESCRICAO

	While  !(cAliasBOL)->(Eof())       
		
		oReport:IncMeter()
		oSection2:PrintLine()
		
		cDescricao := (cAliasBOL)->DESCRICAO
		(cAliasBOL)->(DbSkip())

		IF cSecao <> (cAliasBOL)->SECAO
			oReport:SkipLine(1) 			
			cSecao := (cAliasBOL)->SECAO
		ENDIF
	Enddo   
	
	oReport:FatLine()
	IF MV_PAR03 = 5 .AND. (MV_PAR04 = 4 .OR. (MV_PAR04 = 5 .AND. (MV_PAR05 = 1 .OR. MV_PAR05 = 2)))
		(cAliasBOL)->(dbgotop())
		cData := (cAliasBOL)->DATA_PAGAMENTO
		oReport:PrtLeft("Data de Pagamento: "+SUBSTR(cData,7,2)+"/"+SUBSTR(cData,5,2)+"/"+SUBSTR(cData,1,4))
		oReport:SkipLine(1) 
	ENDIF
	oReport:SkipLine(1) 
	oReport:PrtCenter("Autorização para Pagamento:")
	oReport:SkipLine(5) 			
	oReport:PrtCenter("Produzido por:____________________________________     Conferido por:____________________________________")
	oReport:SkipLine(8) 			
	oReport:PrtCenter("Aprovações:")
	oReport:SkipLine(5) 			
	oReport:PrtCenter("GEADM:____________________________________     DIADM:____________________________________     DIEGE:____________________________________")
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe:			")

 u_CABASX1(cPerg,"01","Ano/Mês:"	        	,"","",	"MV_CH1" ,"N",6  	                    ,0,0,"G","","",	"","","MV_PAR01",""			,""			,""			,"","","","","","","","","","","","","",aHelpPor,{},{},"")		
 u_CABASX1(cPerg,"02","Tipo"    				,"","", "MV_CH2" ,"N",1   						,0,0,"C","","", "","","MV_PAR02","1 - Prévia",,,,"2 - Fechamento")
 u_CABASX1(cPerg,"03","Verbas"    				,"","", "MV_CH3" ,"N",1   						,0,5,"C","","", "","","MV_PAR03","1 - INSS",,,,"2 - FGTS",,,"3 - GRRF/FGTS",,,"4 - IRRF",,,"5 - OUTROS")
 u_CABASX1(cPerg,"04","Verbas2"    				,"","", "MV_CH4" ,"N",1   						,0,0,"C","","", "","","MV_PAR04","1 - PIS",,,,"2 - LÍQUIDOS",,,"3 - PENSÕES",,,"4 - PENS. S/ FÉRIAS",,,"5 - OUTROS")
 u_CABASX1(cPerg,"05","Verbas3"    				,"","", "MV_CH5" ,"N",1   						,0,0,"C","","", "","","MV_PAR05","1 - LIQ. FERIAS",,,,"2 - LIQ. RESCISÃO",,,"3 - VALE TRANSPORTE",,,"4 - 13 SALARIO")
 u_CABASX1(cPerg,"06","Matrícula"    			,"","", "MV_CH6" ,"C",6   						,0,0,"G","","", "","","MV_PAR06","",,,,"")
 u_CABASX1(cPerg,"07","Dia Pagamento"    		,"","", "MV_CH7" ,"C",2   						,0,0,"G","","", "","","MV_PAR07","",,,,"")
Return()
