#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR299
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 22/03/2022
@return variant, return_description
/*/
USER FUNCTION CABR299()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR299"

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
Local cTit := "Relatório Gerencial de Conferência da Folha e Encargos"
Public cTabela := ""
Public cCodverba := ""
Public cPeriodo := ""
Public cValor := ""
Public cMatricula := ""
Public cFil := ""
Private contador := 1

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
cDesl:= ""
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
//oReport:SetLandScape(.F.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"Relatório Gerencial de Conferência da Folha e Encargos",) 

		// Colunas do relatorio
		TRCell():New(oSection2,""    	,,"VERBAS"  	, ""	,35	   ,.F.,{|| (cAliasBOL)->VERBAS}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->DESCRICAO}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,""    	,,"VALOR"  	    , ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR}  			,"RIGHT"  ,.T. ,"LEFT" )

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
ELSE
	cTabela := "SRD"
	cCodverba := "RD_PD"
	cPeriodo := "RD_PERIODO"
	cValor := "RD_VALOR"
	cMatricula := "RD_MAT"
	cFil := "RD_FILIAL"
endif


// Query para buscar os dados no banco

	cQry:="SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('403')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('403')      " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('430')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('430')      " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="SELECT '1' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('491')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('491')      " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '1' SECAO,'TOTAL' VERBAS, 'TOTAL INSS EMPREGADOS'  DESCRICAO, SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('403','430','491')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '2' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('715','716','717')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('715','716','717')  " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '2' SECAO,'TOTAL' VERBAS, 'TOTAL INSS EMPRESA' DESCRICAO, SUM(TOTAL1.TOTAL)     " + CRLF
	cQry+="		FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('715','716','717')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1  " + CRLF
    cQry+="                    UNION ALL  " + CRLF
    cQry+="                    SELECT '3' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('883','490')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('883','490')      " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '3' SECAO,'TOTAL' VERBAS, 'TOTAL DISSIDIO' DESCRICAO, SUM(TOTAL1.TOTAL)     " + CRLF
	cQry+="		FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('883','490')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '4' SECAO,'INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('220','108','111','712', '363')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('220','108','111','712','363')     " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '4' SECAO,'TOTAL' VERBAS, 'TOTAL DEDUÇÕES' DESCRICAO , SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('220','108','111','712','363')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '5' SECAO,'INSS' VERBAS, 'TOTAL DA GUIA INSS' DESCRICAO , SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('220','108','111','712','363')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('403','430','491','490','883','715','717','716')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
   	cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '6' SECAO,'BASES INSS' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '6' SECAO,'COMPENSAÇÃO' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '6' SECAO,'BASE CORRIGIDA' VERBAS, 'BASE INSS' DESCRICAO , SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'                          " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO, 'CÁLCULO' VERBAS, 'INSS EMPRESA - 20%' DESCRICAO , CAST(0.2*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                     UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '% TERCEIROS - "+CValToChar((MV_PAR03+MV_PAR04+MV_PAR05+MV_PAR06+MV_PAR07))+"%' DESCRICAO , CAST((CAST( '"+CValToChar((MV_PAR03+MV_PAR04+MV_PAR05+MV_PAR06+MV_PAR07))+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                                 UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '          SALARIO EDUCAÇÃO (0001 - "+CValToChar(MV_PAR03)+"%)' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR03)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                                 UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '          INCRA(0002 - "+CValToChar(MV_PAR04)+"%)' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR04)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                     UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '          SENAC(0016 - "+CValToChar(MV_PAR05)+"%)' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR05)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '          SESC(0032 - "+CValToChar(MV_PAR06)+"%)' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR06)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, '          SEBRAE(0064 - "+CValToChar(MV_PAR07)+"%)' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR07)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '7' SECAO,'CÁLCULO' VERBAS, 'SEG AC TRAB - GILRAT' DESCRICAO , CAST((CAST( '"+CValToChar(MV_PAR08)+"' AS NUMBER)/100)*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'  " + CRLF
    cQry+="                    UNION ALL     " + CRLF
	cQry+="		SELECT '8' SECAO,'DIFERENÇAS' VERBAS, '715 X INSS EMPRESA' DESCRICAO,CAST(TOTAL.TOTAL AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") - (SELECT 0.2*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('715')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('715')  " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '8' SECAO,'DIFERENÇAS' VERBAS, '716 X % TERCEIROS' DESCRICAO,CAST(TOTAL.TOTAL AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") - (SELECT 0.058*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('716')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('716')  " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT '8' SECAO,'DIFERENÇAS' VERBAS, '717 X SEG AC TRAB' DESCRICAO,CAST(TOTAL.TOTAL AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") - (SELECT 0.01*(SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('108')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2)) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('700','701','702','703','879','881')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('717')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('717')  " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 'BASE FGTS FUNCIONÁRIOS (720+721)' DESCRICAO,(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
    cQry+="          " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('720','721')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 'BASE FGTS DIF DISSIDIO E DIF DISS 13º SAL (878+880)' DESCRICAO,(SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('878','880')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '9' SECAO,'BASE FGTS' VERBAS, 'FGTS CALCULO DEPOSITO DO MÊS (8%)' DESCRICAO, CAST(0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
    cQry+="          " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('720','721')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721', '878','880')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="          " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '10' SECAO,'BASE FGTS' VERBAS, 'BASE FGTS APRENDIZES (720+721)' DESCRICAO,CAST((SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720', '721')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="          " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '10' SECAO,'BASE FGTS' VERBAS, 'FGTS CALCULO DEPÓSITO DO MÊS (2%)' DESCRICAO,CAST((0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720', '721')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') ) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '11' SECAO,'BASE FGTS' VERBAS, 'TOTAL BASE FGTS' DESCRICAO,(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
    cQry+="          " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('FDB')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721','878','880','FDB')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL     " + CRLF
	cQry+="		SELECT DISTINCT '11' SECAO,'BASE FGTS' VERBAS, 'TOTAL DEPOSITO FGTS' DESCRICAO,CAST((0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
    cQry+="          " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('720', '721')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721', '878','880')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'))+(0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720', '721')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') ) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL  " + CRLF
    cQry+="        SELECT DISTINCT '12' SECAO,'BASE FGTS' VERBAS, 'PREVISAO RECOLHIMENTO FGTS (725+726+882+884)' DESCRICAO,(SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('725','726','882','884')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL  " + CRLF
    cQry+="        SELECT DISTINCT '12' SECAO,'BASE FGTS' VERBAS, 'DIFERENÇA' DESCRICAO,CAST((0.08*(SELECT SUM(TOTAL1.TOTAL) - (SELECT SUM(TOTAL2.TOTAL)     " + CRLF
    cQry+="          " + CRLF
	cQry+="		                                        FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		                                        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		                                         AND "+cCodverba+" IN ('720','721')     " + CRLF
	cQry+="		                                           AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		                                       GROUP BY "+cCodverba+" ) TOTAL2) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721', '878','880')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL'))+(0.02*(SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="			INNER JOIN SRA010 SRA ON ("+cFil+" = RA_FILIAL AND RA_MAT = "+cMatricula+" AND SRA.D_E_L_E_T_ = ' ') " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('720','721')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            AND RA_TPCONTR = '2'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL') )- ((SELECT SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT "+cCodverba+", SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('725','726','882','884')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1     " + CRLF
	cQry+="		            GROUP BY 'TOTAL')) AS DECIMAL(10,2)) VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"  " + CRLF
    cQry+="        UNION ALL  " + CRLF
    cQry+="        SELECT '13' SECAO,'FGTS RESCISÓRIO' VERBAS, CONCAT("+cCodverba+", CONCAT(' - ',RV_DESC)) DESCRICAO,TOTAL.TOTAL VALOR     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		LEFT JOIN SRV010 SRV ON ( "+cCodverba+" = RV_COD AND SRV.D_E_L_E_T_=' ')     " + CRLF
	cQry+="		LEFT JOIN (SELECT "+cCodverba+" COD, SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('730','731','732','733','739','882','884')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+") TOTAL ON TOTAL.COD = "+cCodverba+"     " + CRLF
	cQry+="		WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		AND "+cCodverba+" IN ('730','731','732','733','739','882','884')      " + CRLF
	cQry+="		GROUP BY "+cCodverba+", RV_DESC, TOTAL.TOTAL  " + CRLF
    cQry+="        UNION ALL  " + CRLF
    cQry+="                    SELECT '13' SECAO,'FGTS RESCISÓRIO' VERBAS, 'TOTAL'  DESCRICAO, SUM(TOTAL1.TOTAL) VALOR     " + CRLF
	cQry+="		FROM (SELECT SUM("+cValor+") TOTAL     " + CRLF
	cQry+="		FROM "+cTabela+"010 "+cTabela+"   " + CRLF
	cQry+="		        WHERE "+cTabela+".D_E_L_E_T_=' '     " + CRLF
	cQry+="		        AND "+cCodverba+" IN ('730','731','732','733','739','882','884')     " + CRLF
	cQry+="		            AND "+cPeriodo+"= '"+MV_PAR01+"'     " + CRLF
	cQry+="		            GROUP BY "+cCodverba+" ) TOTAL1  " + CRLF

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
	//lcVerba := (cAliasBOL)->VERBAS

	While  !(cAliasBOL)->(Eof())       
		
		oReport:IncMeter()
		oSection2:PrintLine()
		
		cDescricao := (cAliasBOL)->DESCRICAO
		(cAliasBOL)->(DbSkip())


		IF ALLTRIM(cSecao) = '5' .OR. (ALLTRIM(cSecao) = '8' .AND. cDescricao = '717 X SEG AC TRAB' ) .OR. (ALLTRIM(cSecao) = '12' .AND. cDescricao = 'DIFERENÇA')
			oReport:FatLine()
			oReport:SkipLine(1) 			
		ENDIF
		IF cSecao <> (cAliasBOL)->SECAO
			oReport:SkipLine(1) 			
			cSecao := (cAliasBOL)->SECAO
		ENDIF
	Enddo   
		
	//oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe qual especialidade deseja exibir:			")

 u_CABASX1(cPerg,"01","Ano/Mês:"	        	,"","",	"MV_CH1" ,"C",6  	                    ,0,0,"G","","",	"","","MV_PAR01",""			,""			,""			,"","","","","","","","","","","","","",aHelpPor,{},{},"")		
 u_CABASX1(cPerg,"02","Tipo"    				,"","", "MV_CH2" ,"N",1   						,0,0,"C","","", "","","MV_PAR02","1 - Prévia",,,,"2 - Fechamento")
 u_CABASX1(cPerg,"03","% de Salário Educação"   ,"","", "MV_CH3" ,"N",5   						,1,0,"G","","", "","","MV_PAR03","",,,,"")
 u_CABASX1(cPerg,"04","% Incra"				   	,"","", "MV_CH4" ,"N",5   						,1,0,"G","","", "","","MV_PAR04","",,,,"")
 u_CABASX1(cPerg,"05","% Senac"				   	,"","", "MV_CH5" ,"N",5   						,1,0,"G","","", "","","MV_PAR05","",,,,"")
 u_CABASX1(cPerg,"06","% Sesc"				   	,"","", "MV_CH6" ,"N",5   						,1,0,"G","","", "","","MV_PAR06","",,,,"")
 u_CABASX1(cPerg,"07","% Sebrae"				,"","", "MV_CH7" ,"N",5   						,1,0,"G","","", "","","MV_PAR07","",,,,"")
 u_CABASX1(cPerg,"08","% Seg Ac. Trab"			,"","", "MV_CH8" ,"N",5   						,1,0,"G","","", "","","MV_PAR08","",,,,"")
Return()

