#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR300
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 22/03/2022
@return variant, return_description
/*/
USER FUNCTION CABR300()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR300"

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
Local cTit := "Relatório de Alteração de Cadastro"
Public cTabela := ""
Public cCodverba := ""
Public cPeriodo := ""
Public cValor := ""
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
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"Relatório de Alteração de Cadastro",) 

		// Colunas do relatorio
		TRCell():New(oSection2,""    	,,"OPERADORA"  		, ""	,25	   ,.F.,{|| (cAliasBOL)->OPERADORA} ,"LEFT"  ,.T. ,"LEFT" )
    IF MV_PAR01 = 1
        TRCell():New(oSection2,""    	,,"CLIENTE	"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->CLIENTE}  	,"LEFT"  ,.T. ,"LEFT" )
    ENDIF
    IF MV_PAR01 = 2
        TRCell():New(oSection2,""    	,,"FORNECEDOR	"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->FORNEC}  	,"LEFT"  ,.T. ,"LEFT" )
    ENDIF
    IF MV_PAR01 = 3
        TRCell():New(oSection2,""    	,,"VENDEDOR	"  	, ""	,60	   ,.F.,{|| (cAliasBOL)->VENDEDOR}  	,"LEFT"  ,.T. ,"LEFT" )
    ENDIF
		TRCell():New(oSection2,""    	,,"DATA"  	   		, ""	,10	   ,.F.,{|| (cAliasBOL)->DATAHORA}  ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,""    	,,"USUARIO"  		, ""	,25	   ,.F.,{|| (cAliasBOL)->USUARIO}  	,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,""    	,,"OPERAÇÃO"  	    , ""	,15	   ,.F.,{|| (cAliasBOL)->OPERACAO}  ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,""    	,,"DESCRIÇÃO"  	    , ""	,80   ,.F.,{|| IIF((cAliasBOL)->TIPO ='U', AllTrim((cAliasBOL)->DESC1) + " DE: " + AllTrim((cAliasBOL)->DESC2) + " >> PARA: " + AllTrim((cAliasBOL)->DESC3), IIF((cAliasBOL)->TIPO ='I',AllTrim((cAliasBOL)->DESC4)+' '+AllTrim((cAliasBOL)->DESC5),IIF((cAliasBOL)->TIPO ='D',AllTrim((cAliasBOL)->DESC4),AllTrim((cAliasBOL)->DESC6)))) } ,"LEFT"  ,.T. ,"LEFT" )

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
IF MV_PAR01 = 1 //Clientes
    cQry:="        SELECT DISTINCT " + CRLF
    cQry+="                   'CABERJ   ' OPERADORA,  " + CRLF
    cQry+="                   RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO, " + CRLF
    cQry+="                   CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA, " + CRLF
    cQry+="                   DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO," + CRLF
    cQry+="                   AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A1_NOME DESC4, A1_CGC DESC5," + CRLF
    cQry+="                   TO_CHAR(SA1.R_E_C_N_O_ ) DESC6," + CRLF
  /*  cQry+="                   (CASE WHEN AT_OP = 'U' THEN NVL(D.DESCRICAO,REMOVE_CARACTERS_ESPEC_ADT(AT_FIELD))||' '||" + CRLF
    cQry+="                                               TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_CONTENT))||' >> '||TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_NEWCONT))" + CRLF
    cQry+="                         WHEN AT_OP = 'I' THEN TRIM(A1_NOME)||' '||A1_CGC" + CRLF
    cQry+="                         WHEN AT_OP = 'D' THEN TRIM(A1_NOME)" + CRLF
    cQry+="                         ELSE TO_CHAR(SA1010.R_E_C_N_O_ ) END) DESCRICAO, " + CRLF*/
    cQry+="                   TO_DATE(AT_DATE,'yyyymmdd') DT,                  " + CRLF
    cQry+="                   TRIM(A1_NOME)||'('||A1_COD||')' CLIENTE" + CRLF
    cQry+="            FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA1010 SA1 , SIGA.DICIONARIO_SA123 D" + CRLF
    cQry+="            WHERE  AT_TABLE LIKE 'SA1010%'                             " + CRLF
    cQry+="            AND    (AT_FIELD LIKE 'A1_NREDUZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NOME%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NATUREZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_CGC%' OR        " + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XCONTA%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XAGENC%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XDGCON%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_EMAIL%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NATUREZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_PESSOA%')" + CRLF
    cQry+="            AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'" + CRLF
    cQry+="            AND    SA1.R_E_C_N_O_ = AT_RECID" + CRLF
    cQry+="            AND    D.TABELA (+) = 'SA1'" + CRLF
    cQry+="            AND    D.COLUNA (+) = TRIM(AT_FIELD)" + CRLF
    cQry+="            UNION ALL" + CRLF
    cQry+="            SELECT DISTINCT" + CRLF
    cQry+="                   'INTEGRAL ' OPERADORA," + CRLF
    cQry+="                   RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO, " + CRLF
    cQry+="                   CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA," + CRLF
    cQry+="                   DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO," + CRLF
    cQry+="                   AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A1_NOME DESC4, A1_CGC DESC5," + CRLF
    cQry+="                   TO_CHAR(SA1.R_E_C_N_O_ ) DESC6," + CRLF
    /*cQry+="                   (CASE WHEN AT_OP = 'U' THEN NVL(D.DESCRICAO,REMOVE_CARACTERS_ESPEC_ADT(AT_FIELD))||' '||REMOVE_CARACTERS_ESPEC_ADT(AT_CONTENT)||' >> '||REMOVE_CARACTERS_ESPEC_ADT(AT_NEWCONT)" + CRLF
    cQry+="                         WHEN AT_OP = 'I' THEN TRIM(A1_NOME)||' '||A1_CGC" + CRLF
    cQry+="                         WHEN AT_OP = 'D' THEN TRIM(A1_NOME)" + CRLF
    cQry+="                         ELSE TO_CHAR(SA1020.R_E_C_N_O_ ) END) DESCRICAO, " + CRLF*/
    cQry+="                   TO_DATE(AT_DATE,'yyyymmdd') DT," + CRLF
    cQry+="                   TRIM(A1_NOME)||'('||A1_COD||')' CLIENTE" + CRLF
    cQry+="            FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA1020 SA1 , SIGA.DICIONARIO_SA123 D" + CRLF
    cQry+="            WHERE  AT_TABLE LIKE 'SA1020%'" + CRLF
    cQry+="            AND    (AT_FIELD LIKE 'A1_NREDUZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NOME%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NATUREZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_CGC%' OR        " + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XCONTA%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XAGENC%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_XDGCON%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_EMAIL%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_NATUREZ%' OR" + CRLF
    cQry+="                    AT_FIELD LIKE 'A1_PESSOA%')" + CRLF
    cQry+="            AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'" + CRLF
    cQry+="            AND    SA1.R_E_C_N_O_ = AT_RECID" + CRLF
    cQry+="            AND    D.TABELA (+) = 'SA1'" + CRLF
    cQry+="            AND    D.COLUNA (+) = TRIM(AT_FIELD)" + CRLF
    cQry+="            ORDER BY DT,CLIENTE,OPERADORA" + CRLF
    ELSEIf MV_PAR01 = 2 //Fornecedores
	    // Query para buscar os dados no banco


	    cQry:=" SELECT DISTINCT 																					" + CRLF
        cQry+="         'CABERJ   ' OPERADORA,                 														" + CRLF
        cQry+="         RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO,              					" + CRLF
        cQry+="         CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA,                 " + CRLF
        cQry+="         DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO,     " + CRLF
        cQry+="         AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A2_NOME DESC4, A2_CGC DESC5,  " + CRLF
        cQry+="         TO_CHAR(SA2.R_E_C_N_O_ ) DESC6,                                                             " + CRLF
/*      COMENTADO POIS A CONCATENAÇÃO NÃO ESTAVA FUNCIONANDO. SOLUÇÃO: A CONCATENAÇÃO ESTÁ SENDO FEITA DIRETO NO TRCELL()
        cQry+="         (CASE WHEN AT_OP = 'U' THEN (TRIM(AT_FIELD) || ' DE: '||                 					" + CRLF
        cQry+="                       TRIM(AT_CONTENT)||' >> PARA: '||TRIM(AT_NEWCONT) ) ELSE              			" + CRLF
        cQry+="           CASE WHEN AT_OP = 'I' THEN (TRIM(A2_NOME)||' '||A2_CGC) ELSE     							" + CRLF
        cQry+="           CASE WHEN AT_OP = 'D' THEN TRIM(A2_NOME)         											" + CRLF
        cQry+="           ELSE TO_CHAR(SA2.R_E_C_N_O_ ) END END END) DESCRICAO,            							" + CRLF
        */
        cQry+="         TO_DATE(AT_DATE,'yyyymmdd') DT,                 											" + CRLF
        cQry+="         TRIM(A2_NOME)||'('||A2_COD||')' FORNEC                  									" + CRLF
        cQry+="    FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA2010 SA2 , SIGA.DICIONARIO_SA123 D                 		" + CRLF
        cQry+="    WHERE  AT_TABLE LIKE 'SA2010%'                 													" + CRLF
        cQry+="    AND    (AT_FIELD LIKE 'A2_CGC%' OR                 												" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NOME%' OR                 												" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NREDUZ%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_BANCO%' OR                         									" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_AGENCIA%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_XDVAGE%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NATUREZ%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_CONTA%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NUMCON%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_EMAIL%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECISS%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECINSS%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECPIS%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECCOFI%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECCSLL%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_YBLQPLS%' OR                 											" + CRLF
        cQry+="            AT_FIELD LIKE 'A2_CALCIRF%')                 											" + CRLF
        cQry+="    AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'                 								" + CRLF
        cQry+="    AND    SA2.R_E_C_N_O_ = AT_RECID                 												" + CRLF
        cQry+="    AND    D.TABELA (+) = 'SA2'                 														" + CRLF
        cQry+="    AND    D.COLUNA (+) = TRIM(AT_FIELD)                 											" + CRLF
        cQry+="    UNION ALL                                                                                        " + CRLF
        cQry+="    SELECT DISTINCT                                                                                  " + CRLF
        cQry+="         'INTEGRAL '  OPERADORA,                                                                     " + CRLF
        cQry+="         RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO,                                  " + CRLF
        cQry+="         CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA,                 " + CRLF
        cQry+="         DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO,     " + CRLF
        cQry+="         AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A2_NOME DESC4, A2_CGC DESC5,  " + CRLF
        cQry+="         TO_CHAR(SA2.R_E_C_N_O_ ) DESC6,                                                             " + CRLF
        /*
        cQry+="         (CASE WHEN AT_OP = 'U' THEN NVL(D.DESCRICAO,AT_FIELD)||' '||                                " + CRLF
        cQry+="                       TRIM(AT_CONTENT)||' >> '||TRIM(AT_NEWCONT)                                    " + CRLF
        cQry+="           WHEN AT_OP = 'I' THEN TRIM(A2_NOME)||' '||A2_CGC                                          " + CRLF
        cQry+="           WHEN AT_OP = 'D' THEN TRIM(A2_NOME)                                                       " + CRLF
        cQry+="           ELSE TO_CHAR(SA2020.R_E_C_N_O_ ) END) DESCRICAO,                                          " + CRLF
        */
        cQry+="         TO_DATE(AT_DATE,'yyyymmdd') DT,                                                             " + CRLF
        cQry+="         TRIM(A2_NOME)||'('||A2_COD||')' FORNEC                                                      " + CRLF
        cQry+="    FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA2020 SA2 , SIGA.DICIONARIO_SA123 D                         " + CRLF
        cQry+="    WHERE  AT_TABLE LIKE 'SA2020%'                                                                   " + CRLF
        cQry+="    AND    (AT_FIELD LIKE 'A2_CGC%' OR                                                               " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NOME%' OR                                                              " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NREDUZ%' OR                                                            " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_BANCO%' OR                                                             " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_AGENCIA%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_XDVAGE%' OR                                                            " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NATUREZ%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_CONTA%' OR                                                             " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_NUMCON%' OR                                                            " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_EMAIL%' OR                                                             " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECISS%' OR                                                            " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECINSS%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECPIS%' OR                                                            " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECCOFI%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_RECCSLL%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_YBLQPLS%' OR                                                           " + CRLF
        cQry+="            AT_FIELD LIKE 'A2_CALCIRF%')                                                             " + CRLF
        cQry+="    AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'                 								" + CRLF
        cQry+="    AND    SA2.R_E_C_N_O_ = AT_RECID                                                                 " + CRLF
        cQry+="    AND    D.TABELA (+) = 'SA2'                                                                      " + CRLF
        cQry+="    AND    D.COLUNA (+) = TRIM(AT_FIELD)                                                             " + CRLF 
        cQry+="    ORDER BY DT,FORNEC,OPERADORA                                                                     " + CRLF
    ELSEIF MV_PAR01 = 3 // Vendedores
    cQry:="    SELECT DISTINCT " + CRLF
    cQry+="         'CABERJ   ' OPERADORA,  " + CRLF
    cQry+="         RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO, " + CRLF
    cQry+="         CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA,  " + CRLF
    cQry+="         DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO,  " + CRLF
    cQry+="         AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A3_NOME DESC4, A3_CGC DESC5, " + CRLF
    cQry+="          TO_CHAR(SA3.R_E_C_N_O_ ) DESC6, " + CRLF
    cQry+="         /*(CASE WHEN AT_OP = 'U' THEN NVL(D.DESCRICAO,REMOVE_CARACTERS_ESPEC_ADT(AT_FIELD))||' '|| " + CRLF
    cQry+="                       TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_CONTENT))||' >> '||TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_NEWCONT)) " + CRLF
    cQry+="           WHEN AT_OP = 'I' THEN TRIM(A3_NOME)||' '||A3_CGC " + CRLF
    cQry+="           WHEN AT_OP = 'D' THEN TRIM(A3_NOME) " + CRLF
    cQry+="           ELSE TO_CHAR(SA3010.R_E_C_N_O_ ) END) DESCRICAO,*/ " + CRLF
    cQry+="         TO_DATE(AT_DATE,'yyyymmdd') DT, " + CRLF
    cQry+="         TRIM(A3_NOME)||'('||A3_COD||')' VENDEDOR " + CRLF
    cQry+="    FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA3010 SA3, SIGA.DICIONARIO_SA123 D " + CRLF
    cQry+="    WHERE  AT_TABLE LIKE 'SA3010%' " + CRLF
    cQry+="    AND    (AT_FIELD LIKE 'A3_COD%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_NOME%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_NREDUZ%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_CGC%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_EMAIL%' OR         " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_FORNECE%') " + CRLF
    cQry+="    AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"' " + CRLF
    cQry+="    AND    SA3.R_E_C_N_O_ = AT_RECID " + CRLF
    cQry+="    AND    D.TABELA (+) = 'SA3' " + CRLF
    cQry+="    AND    D.COLUNA (+) = TRIM(AT_FIELD) " + CRLF
    cQry+="    UNION ALL " + CRLF
    cQry+="    SELECT DISTINCT " + CRLF
    cQry+="         'INTEGRAL '  OPERADORA, " + CRLF
    cQry+="         RPAD(CAST(UPPER(AT_NAME) AS VARCHAR2(20)),20,' ') USUARIO, " + CRLF
    cQry+="         CAST(TO_CHAR(TO_DATE(AT_DATE,'yyyymmdd'),'DD/MM/YY') AS CHAR(20)) DATAHORA,  " + CRLF
    cQry+="         DECODE(AT_OP,'D','DELECAO  ','I','INSERCAO ','U','ALTERACAO','L','RECALL   ') OPERACAO,  " + CRLF
    cQry+="         AT_OP TIPO, AT_FIELD DESC1,AT_CONTENT DESC2,AT_NEWCONT DESC3, A3_NOME DESC4, A3_CGC DESC5, " + CRLF
    cQry+="          TO_CHAR(SA3.R_E_C_N_O_ ) DESC6, " + CRLF
    cQry+="         /*(CASE WHEN AT_OP = 'U' THEN NVL(D.DESCRICAO,REMOVE_CARACTERS_ESPEC_ADT(AT_FIELD))||' '|| " + CRLF
    cQry+="                       TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_CONTENT))||' >> '||TRIM(REMOVE_CARACTERS_ESPEC_ADT(AT_NEWCONT)) " + CRLF
    cQry+="           WHEN AT_OP = 'I' THEN TRIM(A3_NOME)||' '||A3_CGC " + CRLF
    cQry+="           WHEN AT_OP = 'D' THEN TRIM(A3_NOME) " + CRLF
    cQry+="           ELSE TO_CHAR(SA3020.R_E_C_N_O_ ) END) DESCRICAO,*/ " + CRLF
    cQry+="         TO_DATE(AT_DATE,'yyyymmdd') DT, " + CRLF
    cQry+="         TRIM(A3_NOME)||'('||A3_COD||')' VENDEDOR " + CRLF
    cQry+="    FROM   ADT.AUDIT_TRAIL@ADT_DBLINK , SA3020 SA3 , SIGA.DICIONARIO_SA123 D " + CRLF
    cQry+="    WHERE  AT_TABLE LIKE 'SA3020%' " + CRLF
    cQry+="    AND    (AT_FIELD LIKE 'A3_COD%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_NOME%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_NREDUZ%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_CGC%' OR " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_EMAIL%' OR         " + CRLF
    cQry+="            AT_FIELD LIKE 'A3_FORNECE%') " + CRLF
    cQry+="    AND    AT_DATE  BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"' " + CRLF
    cQry+="    AND    SA3.R_E_C_N_O_ = AT_RECID " + CRLF
    cQry+="    AND    D.TABELA (+) = 'SA3' " + CRLF
    cQry+="    AND    D.COLUNA (+) = TRIM(AT_FIELD) " + CRLF
    cQry+="    ORDER BY DT,VENDEDOR,OPERADORA " + CRLF

    ENDIF

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
			
		oReport:IncMeter()
		oSection2:PrintLine()
			
		(cAliasBOL)->(DbSkip())
	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe:			")

 u_CABASX1(cPerg,"01","Tipo"		,"","a","MV_CH1" ,"C", 1                        ,0,0,"C","","", "","","MV_PAR01","1 - Cliente","1 - Cliente","1 - Cliente","","2 - Fornecedor","2 - Fornecedor","2 - Fornecedor","3 - Vendedor","3 - Vendedor","3 - Vendedor","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"02","Data de:" 	,"","",	"MV_CH2" ,"D",8                 	    ,0,0,"G","","",	"","","MV_PAR02",""			  ,""			,""			  ,"","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"03","Data até:" 	,"","",	"MV_CH3" ,"D",8                 	    ,0,0,"G","","",	"","","MV_PAR03",""			  ,""			,""			  ,"","","","","","","","","","","","","",{},{},{})
Return()
