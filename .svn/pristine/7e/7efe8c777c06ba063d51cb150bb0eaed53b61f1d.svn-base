#include "PLSA090.ch"
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR010   บAutor  ณMateus Medeiros	 บ Data ณ  27/09/18     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Maprec (Relat๓rio de Mapa de Recebimento) 				        บฑฑ
ฑฑบ          ณ  de acordo com os parametros  (Atualizado 2018 )           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ  Angelo Henrique - Data: 10/08/2022                        บฑฑ
ฑฑบ          ณ  Efetuadas melhorias na query e no fonte                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Aten็ใo: SOMENTE PARA CABERJ                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR010()

	Local c_Perg := "CABR010"

	Private lEnd := .F.

	CriaSX1( c_Perg )

	If Pergunte( c_Perg,.T. )

		Processa( {|| GeraMaprec(@lEnd)   }, "Aguarde...", "Gerando Maprec Reajuste da compet๊ncia "+mv_par01+mv_par02+".",.T.)

	EndIf

Return

/*/{Protheus.doc} GeraMaprec
Rotina que ira montar a query
@type function
@version  1.0
@author angelo.cassago
@since 10/08/2022
@param lEnd, logical, caso seja encerrado
/*/
Static Function GeraMaprec(lEnd)

	Local aArea        	:= GetArea()
	Local cQuery       	:= ""
	Local oFWMsExcel    := Nil
	Local oExcel        := Nil
	Local cAliasMp	  	:= GetNextAlias()
	Local cArquivo    	:= GetTempPath()+cvaltochar(randomize(1,100000))+'_CABR010.xml'
	Local c_Competencia := mv_par01+cvaltochar(strzero(val(mv_par02),2))
	Local cComp5		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),5))+''
	Local nRegs			    := 0
	Local cWkSkeet      := MesExtenso(mv_par02)+'_Maprec'
	Local cMesExt		    := MesExtenso(mv_par02)

	Local cMesE1 		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),1))+''
	Local cMesE2 		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),2))+''
	Local cMesE3 		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),3))+''
	Local cMesE4 		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),4))+''
	Local cMesE5 		    := ''+anomes(MonthSub(ctod('01'+'/'+cvaltochar(strzero(val(mv_par02),2))+'/'+mv_par01),5))+''
	Local cAno			    := cvaltochar(year(ddatabase))

	//Pegando os dados
	cMesE1 		:= substr(cMesE1,1,4)+'/'+substr(cMesE1,5,2)
	cMesE2 		:= substr(cMesE2,1,4)+'/'+substr(cMesE2,5,2)
	cMesE3 		:= substr(cMesE3,1,4)+'/'+substr(cMesE3,5,2)
	cMesE4 		:= substr(cMesE4,1,4)+'/'+substr(cMesE4,5,2)
	cMesE5 		:= substr(cMesE5,1,4)+'/'+substr(cMesE5,5,2)
	cQuery += "SELECT   " + CRLF
	cQuery += "	ROWNUM, " + CRLF
	cQuery += "	B.*,    " + CRLF
	cQuery += "	(       " + CRLF
	cQuery += "		CASE  " + CRLF
	cQuery += "			WHEN NVL(B.VALORBDK, 0 ) <> 0 " + CRLF
	cQuery += "			THEN B.VALORBDK               " + CRLF
	cQuery += "			ELSE B.VALORBBU               " + CRLF
	cQuery += "		END                             " + CRLF
	cQuery += "	) VALOR                           " + CRLF
	cQuery += "FROM                               " + CRLF
	cQuery += "	(                                 " + CRLF
	cQuery += "		SELECT                          " + CRLF
	cQuery += "			(                             " + CRLF
	cQuery += "				SELECT                      " + CRLF
	cQuery += "					BDQ_VALOR                 " + CRLF
	cQuery += "				FROM                        " + CRLF
	cQuery += "					" + RetSqlName("BDQ") + " BDQ " + CRLF
	cQuery += "				WHERE                           " + CRLF
	cQuery += "					BDQ_FILIAL = '" + xFilial("BDQ") + "' " + CRLF
	cQuery += "					AND BDQ_CODINT = BA1_CODINT           " + CRLF
	cQuery += "					AND BDQ_CODEMP = BA1_CODEMP           " + CRLF
	cQuery += "					AND BDQ_MATRIC = BA1_MATRIC           " + CRLF
	cQuery += "					and                                   " + CRLF
	cQuery += "                    (                          " + CRLF
	cQuery += "                        bdq.bdq_datate = ' '   " + CRLF
	cQuery += "                        or                     " + CRLF
	cQuery += "                        bdq.bdq_datate >= '" + DTOS(DATE()) + "' " + CRLF
	cQuery += "                    )                                            " + CRLF
	cQuery += "                    and bdq.bdq_datde   <> ' '                   " + CRLF
	cQuery += "					AND d_e_l_e_t_ = ' '                                    " + CRLF
	cQuery += "					AND ROWNUM = 1                                          " + CRLF
	cQuery += "			) DESCONTO,                                                 " + CRLF
	cQuery += "			A.*,                                                        " + CRLF
	cQuery += "			PESQ_RETORNA_QTD_FAIXA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, '" + cAno + "') QTD_FAIXA , " + CRLF
	cQuery += "			(                                                            " + CRLF
	cQuery += "				SELECT                                                     " + CRLF
	cQuery += "					BDK_VALOR                                                " + CRLF
	cQuery += "				FROM                                                       " + CRLF
	cQuery += "					" + RetSqlName("BDK") + "                                " + CRLF
	cQuery += "				WHERE                                                      " + CRLF
	cQuery += "					BDK_FILIAL =  '" + xFilial("BDK") + "'                   " + CRLF
	cQuery += "					AND BDK_CODINT = BA1_CODINT                              " + CRLF
	cQuery += "					AND BDK_CODEMP = BA1_CODEMP                              " + CRLF
	cQuery += "					AND BDK_MATRIC = BA1_MATRIC                              " + CRLF
	cQuery += "					AND BDK_TIPREG = BA1_TIPREG                              " + CRLF
	cQuery += "					AND d_e_l_e_t_ = ' '                                     " + CRLF
	cQuery += "					AND                                                      " + CRLF
	cQuery += "						(                                                      " + CRLF
	cQuery += "							(                                                    " + CRLF
	cQuery += "								BA1_MUDFAI = 0                                     " + CRLF
	cQuery += "								AND BA1_faicob = BDK_CODFAI                        " + CRLF
	cQuery += "							)                                                    " + CRLF
	cQuery += "							OR                                                   " + CRLF
	cQuery += "							(                                                    " + CRLF
	cQuery += "								BA1_MUDFAI <> 0                                    " + CRLF
	cQuery += "								AND IDADE >= BDK_IDAINI                            " + CRLF
	cQuery += "								AND IDADE <= BDK_IDAFIN                            " + CRLF
	cQuery += "							)                                                    " + CRLF
	cQuery += "						)                                                      " + CRLF
	cQuery += "					AND ROWNUM = 1                                           " + CRLF
	cQuery += "			) VALORBDK ,                                                 " + CRLF
	cQuery += "			(                                                            " + CRLF
	cQuery += "				SELECT                                                     " + CRLF
	cQuery += "					BBU_VALFAI                                               " + CRLF
	cQuery += "				FROM                                                       " + CRLF
	cQuery += "					" + RetSqlName("BBU") + "                                " + CRLF
	cQuery += "				WHERE                                                      " + CRLF
	cQuery += "					BBU_FILIAL =  '" + xFilial("BBU") + "'                   " + CRLF
	cQuery += "					AND BBU_CODOPE = BA1_CODINT                              " + CRLF
	cQuery += "					AND BBU_CODEMP = BA1_CODEMP                              " + CRLF
	cQuery += "					AND BBU_MATRIC = BA1_MATRIC                              " + CRLF
	cQuery += "					AND                                                      " + CRLF
	cQuery += "						(                                                      " + CRLF
	cQuery += "							BBU_TABVLD >= SYSDATE                                " + CRLF
	cQuery += "							OR                                                   " + CRLF
	cQuery += "							BBU_TABVLD = ' '                                     " + CRLF
	cQuery += "						)                                                      " + CRLF
	cQuery += "					AND D_E_L_E_T_ = ' '                                     " + CRLF
	cQuery += "					AND                                                      " + CRLF
	cQuery += "						(                                                      " + CRLF
	cQuery += "							(                                                    " + CRLF
	cQuery += "								BA1_MUDFAI = 0                                     " + CRLF
	cQuery += "								AND BA1_FAICOB = BBU_CODFAI                        " + CRLF
	cQuery += "							)                                                    " + CRLF
	cQuery += "							OR                                                   " + CRLF
	cQuery += "							(                                                    " + CRLF
	cQuery += "								BA1_MUDFAI <> 0                                    " + CRLF
	cQuery += "								AND IDADE >= BBU_IDAINI                            " + CRLF
	cQuery += "								AND IDADE <= BBU_IDAFIN                            " + CRLF
	cQuery += "							)                                                    " + CRLF
	cQuery += "						)                                                      " + CRLF
	cQuery += "					AND ROWNUM = 1                                           " + CRLF
	cQuery += "			) VALORBBU                                                   " + CRLF
	cQuery += "		FROM                                                           " + CRLF
	cQuery += "			(                                                            " + CRLF
	cQuery += "				SELECT                                                     " + CRLF
	cQuery += "					RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BA1_CODEMP,'C') GRUPOPLANO ,                  " + CRLF
	cQuery += "					MAX(BI3_NREDUZ) PLANO,                                                                      " + CRLF
	cQuery += "					(BA1_CODINT ||BA1_CODEMP ||BA1_MATRIC ||BA1_TIPREG ||BA1_DIGITO) MATRIC,                    " + CRLF
	cQuery += "					BA1_NOMUSR NOME,                                         " + CRLF
	cQuery += "					BA1_MUDFAI,                                              " + CRLF
	cQuery += "					ba1_faicob,                                              " + CRLF
	cQuery += "					ba1_tipreg,                                              " + CRLF
	cQuery += "					ba1_matric,                                              " + CRLF
	cQuery += "					ba1_codemp,                                              " + CRLF
	cQuery += "					ba1_codint,                                              " + CRLF
	cQuery += "					IDADE_S(BA1_DATNAS, TO_CHAR(sysdate, 'YYYYMMDD')) IDADE, " + CRLF
	cQuery += "					FORMATA_DATA_MS(BA1_DATNAS) DATNAS,                      " + CRLF
	cQuery += "					FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)) DATBLO," + CRLF
	cQuery += "					TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD') DAT_REAJUS,         " + CRLF
	cQuery += "					TRUNC(MONTHS_BETWEEN(TO_DATE('01/05/2013','DD/MM/YYYY'), TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))) MESES_CONTR, " + CRLF
	cQuery += "					BA3_MESREA MESREA,                                       " + CRLF
	cQuery += "					BA3_INDREA INDREA,                                       " + CRLF
	cQuery += "					(                                                        " + CRLF
	cQuery += "						CASE                                                   " + CRLF
	cQuery += "							WHEN BA1_DATNAS BETWEEN '19561101' AND '19561130'    " + CRLF
	cQuery += "							THEN 'SIM'                                           " + CRLF
	cQuery += "							ELSE 'NAO'                                           " + CRLF
	cQuery += "						END                                                    " + CRLF
	cQuery += "					)ANIVERSARIANTE,                                         " + CRLF
	cQuery += "					DECODE                                                   " + CRLF
	cQuery += "                        (                                         " + CRLF
	cQuery += "                            BA3_TIPPAG,                           " + CRLF
	cQuery += "                            '00','SEM ENVIO',                     " + CRLF
	cQuery += "                            '01','PREVI',                         " + CRLF
	cQuery += "                            '02','LIQ',                           " + CRLF
	cQuery += "                            '03','EMP',                           " + CRLF
	cQuery += "                            '04','112',                           " + CRLF
	cQuery += "                            '05','175',                           " + CRLF
	cQuery += "                            '06','SISDEB',                        " + CRLF
	cQuery += "                            '07','ITAU',                          " + CRLF
	cQuery += "                            '08','PREVI',                         " + CRLF
	cQuery += "                            ''                                    " + CRLF
	cQuery += "                        ) TIPPAG,                                 " + CRLF
	cQuery += "					DECODE(BM1_CODTIP,'101','','') OBS,                      " + CRLF
	cQuery += "					DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM') MUDAFAIXA,  " + CRLF
	cQuery += "					BM1_CODFAI,                                              " + CRLF
	cQuery += "					SUM                                                      " + CRLF
	cQuery += "						(                                                      " + CRLF
	cQuery += "							CASE                                                 " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),-5),'YYYYMM') " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)  " + CRLF
	cQuery += "								ELSE 0                                        " + CRLF
	cQuery += "							END                                             " + CRLF
	cQuery += "						) cMes5,                                          " + CRLF
	cQuery += "					SUM                                                 " + CRLF
	cQuery += "						(                                                 " + CRLF
	cQuery += "							CASE                                            " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),-4),'YYYYMM') " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)  " + CRLF
	cQuery += "								ELSE 0                                        " + CRLF
	cQuery += "							END                                             " + CRLF
	cQuery += "						) cMes4,                                          " + CRLF
	cQuery += "					SUM                                                 " + CRLF
	cQuery += "						(                                                 " + CRLF
	cQuery += "							CASE                                            " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),-3),'YYYYMM') " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)  " + CRLF
	cQuery += "								ELSE 0                                        " + CRLF
	cQuery += "							END                                             " + CRLF
	cQuery += "						)  cMes3,                                         " + CRLF
	cQuery += "					SUM                                                 " + CRLF
	cQuery += "						(                                                 " + CRLF
	cQuery += "							CASE                                            " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),-2),'YYYYMM') " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)  " + CRLF
	cQuery += "								ELSE 0                                        " + CRLF
	cQuery += "							END                                             " + CRLF
	cQuery += "						) cMes2,                                          " + CRLF
	cQuery += "					SUM                                                 " + CRLF
	cQuery += "						(                                                 " + CRLF
	cQuery += "							CASE                                            " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),-1),'YYYYMM') " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)  " + CRLF
	cQuery += "								ELSE 0                                        " + CRLF
	cQuery += "							END                                             " + CRLF
	cQuery += "						) cMes1,                                          " + CRLF
	cQuery += "					SUM                                                 " + CRLF
	cQuery += "						(                                                 " + CRLF
	cQuery += "							CASE                                            " + CRLF
	cQuery += "								WHEN BM1_CODTIP = '101' AND BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + c_Competencia + "','YYYYMM'),0),'YYYYMM')  " + CRLF
	cQuery += "								THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR)        " + CRLF
	cQuery += "								ELSE 0                                              " + CRLF
	cQuery += "							END                                                   " + CRLF
	cQuery += "						) cMesAt                                                " + CRLF
	cQuery += "				FROM                                                        " + CRLF
	cQuery += "					BM1010 BM1                                                " + CRLF
	cQuery += "                                                                   " + CRLF
	cQuery += "                    INNER JOIN                                     " + CRLF
	cQuery += "                        " + RetSqlName("BA3") + " BA3              " + CRLF
	cQuery += "                    ON                                             " + CRLF
	cQuery += "                        BA3_FILIAL      = BM1_FILIAL               " + CRLF
	cQuery += "                        AND BA3_CODINT  = BM1_CODINT               " + CRLF
	cQuery += "                        AND BA3_CODEMP  IN ('0001','0002','0005')  " + CRLF
	cQuery += "                        AND BA3.D_E_L_E_T_  = ' '                  " + CRLF
	cQuery += "                                                                   " + CRLF
	cQuery += "                    INNER JOIN                                     " + CRLF
	cQuery += "                        " + RetSqlName("BA1") + " BA1              " + CRLF
	cQuery += "                    ON                                             " + CRLF
	cQuery += "                        BA1_FILIAL          = BM1_FILIAL           " + CRLF
	cQuery += "                        AND BA1_CODINT      = BM1_CODINT           " + CRLF
	cQuery += "                        AND BA1_CODEMP      = BM1_CODEMP           " + CRLF
	cQuery += "                        AND BA1_MATRIC      = BM1_MATRIC           " + CRLF
	cQuery += "                        AND BA1_TIPREG      = BM1_TIPREG           " + CRLF
	cQuery += "                        AND BA1_FILIAL      = BA3_FILIAL           " + CRLF
	cQuery += "                        AND BA1_CODINT      = BA3_CODINT           " + CRLF
	cQuery += "                        AND BA1_CODEMP      = BA3_CODEMP           " + CRLF
	cQuery += "                        AND BA1_MATRIC      = BA3_MATRIC           " + CRLF
	cQuery += "                        AND BA1_CODPLA      = BA3_CODPLA           " + CRLF
	cQuery += "                        AND BA1.D_E_L_E_T_  = ' '                  " + CRLF
	cQuery += "                                                                   " + CRLF
	cQuery += "                    INNER JOIN                                     " + CRLF
	cQuery += "                        " + RetSqlName("BFQ") + " BFQ              " + CRLF
	cQuery += "                    ON                                             " + CRLF
	cQuery += "                        BFQ_FILIAL          = BM1_FILIAL           " + CRLF
	cQuery += "                        AND BFQ_CODINT      = BM1_CODINT 				  " + CRLF
	cQuery += "                        AND BFQ_PROPRI||BFQ_CODLAN = BM1_CODTIP    " + CRLF
	cQuery += "                        AND BFQ_YTPANL      = 'M'                  " + CRLF
	cQuery += "                        AND BFQ.D_E_L_E_T_  = ' '                  " + CRLF
	cQuery += "                                                                   " + CRLF
	cQuery += "                    INNER JOIN                                     " + CRLF
	cQuery += "                        " + RetSqlName("BI3") + " BI3              " + CRLF
	cQuery += "                    ON                                             " + CRLF
	cQuery += "                        BI3_FILIAL          = BA1_FILIAL           " + CRLF
	cQuery += "                        AND BI3_CODINT      = BA1_CODINT           " + CRLF
	cQuery += "                        AND BI3_CODIGO      = BA1_CODPLA           " + CRLF
	cQuery += "                        AND BI3.D_E_L_E_T_  = ' '                  " + CRLF
	cQuery += "				WHERE                                                       " + CRLF
	cQuery += "					BM1_FILIAL      = '" + xFilial("BM1") + "'                " + CRLF
	cQuery += "					AND BM1_CODINT  = '0001'                                  " + CRLF
	cQuery += "					AND BM1_CODEMP  IN ('0001','0002','0005')                 " + CRLF
	cQuery += "                    AND BM1_CODTIP  = '101'                        " + CRLF
	cQuery += "					AND BM1_ANO||BM1_MES BETWEEN '" + cComp5 + "' AND '" + c_Competencia + "'                                     " + CRLF
	cQuery += "                    AND ('' IS NULL OR (INSTR('',retorna_descri_grupo_plano(TRIM(bi3_ygrpla), ba1_codemp, 'C'))) > 0)  " + CRLF
	cQuery += "					AND BM1.D_E_L_E_T_  = ' '                                         " + CRLF
	cQuery += "				GROUP BY                                                            " + CRLF
	cQuery += "					RETORNA_DESCRI_GRUPO_PLANO(TRIM(BI3_YGRPLA),BA1_CODEMP,'C'),      " + CRLF
	cQuery += "					BI3_NREDUZ,                                                       " + CRLF
	cQuery += "					(BA1_CODINT ||BA1_CODEMP ||BA1_MATRIC ||BA1_TIPREG ||BA1_DIGITO), " + CRLF
	cQuery += "					BA1_NOMUSR,                                              " + CRLF
	cQuery += "					BA1_MUDFAI,                                              " + CRLF
	cQuery += "					ba1_faicob,                                              " + CRLF
	cQuery += "					IDADE_S(BA1_DATNAS, TO_CHAR(sysdate, 'YYYYMMDD')),       " + CRLF
	cQuery += "					FORMATA_DATA_MS(BA1_DATNAS),                             " + CRLF
	cQuery += "					FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)),       " + CRLF
	cQuery += "					ba1_tipreg,                                              " + CRLF
	cQuery += "					ba1_matric,                                              " + CRLF
	cQuery += "					ba1_codemp,                                              " + CRLF
	cQuery += "					ba1_codint,                                              " + CRLF
	cQuery += "					TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'),                    " + CRLF
	cQuery += "					TRUNC(MONTHS_BETWEEN(TO_DATE('01/08/2013','DD/MM/YYYY'), " + CRLF
	cQuery += "					TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))),                  " + CRLF
	cQuery += "					BA3_MESREA,                                              " + CRLF
	cQuery += "					BA3_INDREA,                                              " + CRLF
	cQuery += "					(                                                        " + CRLF
	cQuery += "						CASE                                                   " + CRLF
	cQuery += "							WHEN BA1_DATNAS BETWEEN '19561101' AND '19561130'    " + CRLF
	cQuery += "							THEN 'SIM'                                           " + CRLF
	cQuery += "							ELSE 'NAO'                                           " + CRLF
	cQuery += "						END                                                    " + CRLF
	cQuery += "					),                                                       " + CRLF
	cQuery += "					DECODE                                                   " + CRLF
	cQuery += "                        (                                         " + CRLF
	cQuery += "                            BA3_TIPPAG,                           " + CRLF
	cQuery += "                            '00','SEM ENVIO',                     " + CRLF
	cQuery += "                            '01','PREVI',                         " + CRLF
	cQuery += "                            '02','LIQ',                           " + CRLF
	cQuery += "                            '03','EMP',                           " + CRLF
	cQuery += "                            '04','112',                           " + CRLF
	cQuery += "                            '05','175',                           " + CRLF
	cQuery += "                            '06','SISDEB',                        " + CRLF
	cQuery += "                            '07','ITAU',                          " + CRLF
	cQuery += "                            '08','PREVI',                         " + CRLF
	cQuery += "                            ''                                    " + CRLF
	cQuery += "                        ),                                        " + CRLF
	cQuery += "					DECODE(BM1_CODTIP,'101','',''),                          " + CRLF
	cQuery += "					DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM'),            " + CRLF
	cQuery += "					BM1_CODFAI                                               " + CRLF
	cQuery += "				ORDER BY                                                   " + CRLF
	cQuery += "					(                                                        " + CRLF
	cQuery += "						case                                                   " + CRLF
	cQuery += "							when BA3_MESREA >= '08'                              " + CRLF
	cQuery += "							then 0                                               " + CRLF
	cQuery += "							else 1                                               " + CRLF
	cQuery += "						end                                                    " + CRLF
	cQuery += "					),                                                       " + CRLF
	cQuery += "					BA3_MESREA,1,2,3,4,5,6,7,8,17                            " + CRLF
	cQuery += "			) a                                                          " + CRLF
	cQuery += "	) B                                                              " + CRLF

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasMp,.T.,.T.)

	dbSelectArea(cAliasMp)
	(cAliasMp)->(dbgotop())

	MemoWrite("C:\Temp\query_CABR010.txt",cQuery)

	if (cAliasMp)->(!eof())

		(cAliasMp)->(dbGoTop())
		(cAliasMp)->(dbEval({||nRegs++}))
		(cAliasMp)->(dbGoTop())

		//Criando o objeto que irแ gerar o conte๚do do Excel
		oFWMsExcel := FWMSExcel():New()

		//Aba 01 - Log_Boletos
		oFWMsExcel:AddworkSheet(cWkSkeet)

		//Criando a Tabela
		oFWMsExcel:AddTable(cWkSkeet,cMesExt)

		//Adicionando Coluna
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'DESCONTO'      ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'GRUPOPLANO'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'PLANO'         ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'MATRIC'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'NOME'          ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_MUDFAI'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_FAICOB'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_TIPREG'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_MATRIC'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_CODEMP'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BA1_CODINT'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'IDADE'         ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'DATNAS'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'DATBLO'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'DAT_REAJUS'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'MESES_CONTR'   ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'MESREA'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'INDREA'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'ANIVERSARIANTE',1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'TIPPAG'        ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'OBS'           ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'MUDAFAIXA'     ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'BM1_CODFAI'    ,1)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,cMesE5          ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,cMesE4          ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,cMesE3          ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,cMesE2          ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,cMesE1	        ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,c_Competencia   ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'QTD_FAIXA'     ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'VALORBDK'      ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'VALORBBU'      ,3)
		oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'VALOR'         ,3)

		ProcRegua(nRegs) // Atribui quantidade de registros que serใo impressos

		//Criando as Linhas... Enquanto nใo for fim da query
		While !((cAliasMp)->(EoF()))

			if lEnd
				Alert("Processo terminado pelo usuแrio")
				Exit
			endif

			IncProc()
			IncProc("Aguarde.. Gerando Maprec..")

			oFWMsExcel:AddRow(cWkSkeet,cMesExt,{;
				(cAliasMp)->DESCONTO,;
				(cAliasMp)->GRUPOPLANO,;
				(cAliasMp)->PLANO,;
				(cAliasMp)->MATRIC,;
				(cAliasMp)->NOME,;
				(cAliasMp)->BA1_MUDFAI,;
				(cAliasMp)->BA1_FAICOB,;
				(cAliasMp)->BA1_TIPREG,;
				(cAliasMp)->BA1_MATRIC,;
				(cAliasMp)->BA1_CODEMP,;
				(cAliasMp)->BA1_CODINT,;
				(cAliasMp)->IDADE,;
				(cAliasMp)->DATNAS,;
				(cAliasMp)->DATBLO,;
				(cAliasMp)->DAT_REAJUS,;
				(cAliasMp)->MESES_CONTR,;
				(cAliasMp)->MESREA,;
				(cAliasMp)->INDREA,;
				(cAliasMp)->ANIVERSARIANTE,;
				(cAliasMp)->TIPPAG,;
				(cAliasMp)->OBS,;
				(cAliasMp)->MUDAFAIXA,;
				(cAliasMp)->BM1_CODFAI,;
				(cAliasMp)->cMes5,;
				(cAliasMp)->cMes4,;
				(cAliasMp)->cMes3,;
				(cAliasMp)->cMes2,;
				(cAliasMp)->cMes1,;
				(cAliasMp)->cMesAt,;
				(cAliasMp)->QTD_FAIXA,;
				(cAliasMp)->VALORBDK,;
				(cAliasMp)->VALORBBU,;
				(cAliasMp)->VALOR;
				})

			(cAliasMp)->(DbSkip())

		EndDo

		if !lEnd

			//Ativando o arquivo e gerando o xml
			oFWMsExcel:Activate()
			oFWMsExcel:GetXMLFile(cArquivo)

			//Abrindo o excel e abrindo o arquivo xml
			oExcel := MsExcel():New()           //Abre uma nova conexใo com Excel
			oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
			oExcel:SetVisible(.T.)              //Visualiza a planilha
			oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas

		Endif

	Else

		Aviso("Nใo hแ dados!!!","Nใo hแ Maprec a ser impresso com os parโmetros informados!",{"OK"})

	EndIf

	if select(cAliasMp) > 0
		(cAliasMp)->(DbCloseArea())
	endif

	RestArea(aArea)

Return

/*/{Protheus.doc} CriaSX1
Fun็ใo parar criar as perguntas
@type function
@version  1.0
@author angelo.cassago
@since 10/08/2022
@param cPerg, character, nome da pergunta
/*/
Static Function CriaSX1(cPerg)

	PutSx1(cPerg,"01",OemToAnsi("Ano Reajuste")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("M๊s Reajuste")			,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return
