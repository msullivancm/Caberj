#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
                         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA057    ºAutor  ³Leonardo Portella   º Data ³  16/11/11  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inclui o capitulo para o RDA (faz a query conforme a tabela º±±
±±º          ³TUSS_ANS que contem os procedimentos da ANS e inclui estes  º±±
±±º          ³procedimentos na BC0.                                       º±±
±±º          ³Querys desenvolvidas por Fabio Bianchini.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA057

Local nProc := 0
      
Processa({||nProc := CapRDACompl()},'Processando...')

Aviso('ATENÇÃO','Foram incluídos ' + AllTrim(Transform(nProc,'@E 999.999.999')) + ' registros na BC0',{'Ok'})

Return      

*****************************************************************************************************************************************

Static Function CapRDACompl

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cAlias := GetNextAlias()
Local cQuery := ""   

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros...')    	
Next

cQuery += "SELECT DISTINCT BC0_FILIAL, BC0_CODIGO, BC0_CODINT, BC0_CODLOC, BC0_CODESP, BC0_CODSUB, '024' BC0_CODTAB, BR8_CODPAD_TUSS  BC0_CODPAD," 	+ CRLF
cQuery += "		To_Char(BR8_CODPSA) BC0_CODOPC, BR8_NIVEL BC0_NIVEL, BC0_VALCH, BC0_VALREA, BC0_VALCOB, BC0_FORMUL, BC0_EXPRES, BC0_PERDES,"		+ CRLF 
cQuery += "		BC0_PERACR, BC0_TIPO, SubStr(BR8_CODPSA,1,5) BC0_CDNV01, SubStr(BR8_CODPSA,1,3) BC0_CDNV02, SubStr(BR8_CODPSA,1,1) BC0_CDNV03'"		+ CRLF
cQuery += "     ' ' BC0_CDNV04, '20101201' BC0_VIGDE, '" + Space(TamSx3('BC0_VIGATE')[1])+ "' BC0_VIGATE, BC0_BANDA"								+ CRLF
cQuery += "FROM " + RetSqlName('BC0') + " BC0,"																										+ CRLF
cQuery += "		" + RetSqlName('BAX') + " BAX"																										+ CRLF
cQuery += "		, ( SELECT DISTINCT" 																												+ CRLF
cQuery += "                BR8_FILIAL" 																												+ CRLF
cQuery += "              , '16'               BR8_CODPAD_TUSS" 																						+ CRLF
cQuery += "              , BR8_CODPAD" 																												+ CRLF
cQuery += "              , Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990)) COD_CIEFAS" 							+ CRLF
cQuery += "              , T.TUSS             BR8_CODPSA" 																							+ CRLF
cQuery += "              , Upper(T.DESC_TUSS) BR8_DESCRI" 																							+ CRLF
cQuery += "              , Max(BR8_NIVEL )    BR8_NIVEL" 																							+ CRLF
cQuery += "              , Max(BR8_BENUTL)    BR8_BENUTL" 																							+ CRLF
cQuery += "              , Max(BR8_AUTORI)    BR8_AUTORI" 																							+ CRLF
cQuery += "              , Max(BR8_PODDIG)    BR8_PODDIG" 																							+ CRLF
cQuery += "              , Max(BR8_SEXO  )    BR8_SEXO" 																							+ CRLF
cQuery += "              , Max(BR8_ANASIN)    BR8_ANASIN" 																							+ CRLF
cQuery += "              , Max(BR8_CARENC)    BR8_CARENC" 																							+ CRLF
cQuery += "              , Max(BR8_UNCAR )    BR8_UNCAR" 																							+ CRLF
cQuery += "              , Max(BR8_QTD   )    BR8_QTD" 																								+ CRLF
cQuery += "              , Max(BR8_UNCA  )    BR8_UNCA" 																							+ CRLF
cQuery += "              , Max(BR8_QTDCRE)    BR8_QTDCRE" 																							+ CRLF
cQuery += "              , Max(BR8_QTDESP)    BR8_QTDESP" 																							+ CRLF
cQuery += "              , Max(BR8_QTDMED)    BR8_QTDMED" 																							+ CRLF
cQuery += "              , Max(BR8_QTDPAT)    BR8_QTDPAT" 																							+ CRLF
cQuery += "              , Max(BR8_QTDGEN)    BR8_QTDGEN" 																							+ CRLF
cQuery += "              , Max(BR8_QTDSOL)    BR8_QTDSOL" 																							+ CRLF
cQuery += "              , Max(BR8_UNQSOL)    BR8_UNQSOL" 																							+ CRLF
cQuery += "              , Max(BR8_QTDCON)    BR8_QTDCON" 																							+ CRLF
cQuery += "              , Max(Decode(Trim(BR8_UNCACO),NULL,'0',BR8_UNCACO))    BR8_UNCACO" 														+ CRLF
cQuery += "              , Max(BR8_PERIOD)    BR8_PERIOD" 																							+ CRLF
cQuery += "              , Max(BR8_UNPERI)    BR8_UNPERI" 																							+ CRLF
cQuery += "              , Max(BR8_PTRCRE)    BR8_PTRCRE" 																							+ CRLF
cQuery += "              , Max(BR8_PTRESP)    BR8_PTRESP" 																							+ CRLF
cQuery += "              , Max(BR8_PTRMED)    BR8_PTRMED" 																							+ CRLF
cQuery += "              , Max(BR8_PTRPAT)    BR8_PTRPAT" 																							+ CRLF
cQuery += "              , Max(BR8_PTRGEN)    BR8_PTRGEN" 																							+ CRLF
cQuery += "              , Max(BR8_PERSOL)    BR8_PERSOL" 																							+ CRLF
cQuery += "              , Max(BR8_UNPSOL)    BR8_UNPSOL" 																							+ CRLF
cQuery += "              , Max(BR8_PERCON)    BR8_PERCON" 																							+ CRLF
cQuery += "              , Max(Decode(Trim(BR8_UNPECO),NULL,'0',BR8_UNPECO))    BR8_UNPECO" 														+ CRLF
cQuery += "              , Max(Decode(Trim(BR8_APOSQT),NULL,'0',BR8_APOSQT))    BR8_APOSQT" 														+ CRLF
cQuery += "              , Max(BR8_APOSPE)    BR8_APOSPE" 																							+ CRLF
cQuery += "              , Max(BR8_IDAMIN)    BR8_IDAMIN" 																							+ CRLF
cQuery += "              , Max(BR8_UNIMIN)    BR8_UNIMIN" 																							+ CRLF
cQuery += "              , Max(BR8_ATOCOP)    BR8_ATOCOP" 																							+ CRLF
cQuery += "              , Max(BR8_IDAMAX)    BR8_IDAMAX" 																							+ CRLF
cQuery += "              , Max(BR8_UNIMAX)    BR8_UNIMAX" 																							+ CRLF
cQuery += "              , Max(BR8_APQTSO)    BR8_APQTSO" 																							+ CRLF
cQuery += "              , Max(BR8_APPESO)    BR8_APPESO" 																							+ CRLF
cQuery += "              , Max(BR8_FAIDES)    BR8_FAIDES" 																							+ CRLF
cQuery += "              , Max(BR8_QTMIAU)    BR8_QTMIAU" 																							+ CRLF
cQuery += "              , Max(BR8_QTMAAU)    BR8_QTMAAU" 																							+ CRLF
cQuery += "              , Max(BR8_PARCOR)    BR8_PARCOR" 																							+ CRLF
cQuery += "              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',TO_CHAR(T.TUSS),' ')    BR8_CODROL" 													+ CRLF
cQuery += "              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',Upper(T.DESC_TUSS),' ')    BR8_DESROL" 												+ CRLF
cQuery += "              , Max(BR8_DIAPD1)    BR8_DIAPD1" 																							+ CRLF
cQuery += "              , Max(BR8_DIAPD2)    BR8_DIAPD2" 																							+ CRLF
cQuery += "              , Max(BR8_DIAPD3)    BR8_DIAPD3" 																							+ CRLF
cQuery += "              , Max(BR8_TABREM)    BR8_TABREM" 																							+ CRLF
cQuery += "              , Max(BR8_CLASSE)    BR8_CLASSE" 																							+ CRLF
cQuery += "              , Max(BR8_ADCNOT)    BR8_ADCNOT" 																							+ CRLF
cQuery += "              , Max(BR8_CODTAB)    BR8_CODTAB" 																							+ CRLF
cQuery += "              , Max(BR8_TIPEVE)    BR8_TIPEVE" 																							+ CRLF
cQuery += "              , Max(BR8_REGATD)    BR8_REGATD" 																							+ CRLF
cQuery += "              , Max(BR8_TRTSER)    BR8_TRTSER" 																							+ CRLF
cQuery += "              , Max(BR8_CTREQU)    BR8_CTREQU" 																							+ CRLF
cQuery += "              , Max(BR8_PERADC)    BR8_PERADC" 																							+ CRLF
cQuery += "              , Max(BR8_CDPDAD)    BR8_CDPDAD" 																							+ CRLF
cQuery += "              , Max(BR8_PROADC)    BR8_PROADC" 																							+ CRLF
cQuery += "              , Max(BR8_TIPADC)    BR8_TIPADC" 																							+ CRLF
cQuery += "              , Max(BR8_PERAD )    BR8_PERAD" 																							+ CRLF
cQuery += "              , Max(BR8_CHADC )    BR8_CHADC" 																							+ CRLF
cQuery += "              , Max(BR8_CRR   )    BR8_CRR" 																								+ CRLF
cQuery += "              , Max(BR8_CLACAR)    BR8_CLACAR" 																							+ CRLF
cQuery += "              , Max(BR8_TPPROC)    BR8_TPPROC" 																							+ CRLF
cQuery += "              , Max(BR8_PERFOR)    BR8_PERFOR" 																							+ CRLF
cQuery += "              , Max(BR8_CODEDI)    BR8_CODEDI" 																							+ CRLF
cQuery += "              , Max(Decode (BR8_QTDPER,'0',' ',BR8_QTDPER)) BR8_QTDPER" 																	+ CRLF
cQuery += "              , Max(BR8_PROBLO)    BR8_PROBLO" 																							+ CRLF
cQuery += "              , Max(BR8_CONMFT)    BR8_CONMFT" 																							+ CRLF
cQuery += "              , Max(BR8_LIBESP)    BR8_LIBESP" 																							+ CRLF
cQuery += "              , Max(BR8_PODREM)    BR8_PODREM" 																							+ CRLF
cQuery += "              , Max(BR8_TIPDIA)    BR8_TIPDIA" 																							+ CRLF
cQuery += "              , Max(BR8_GAUSS )    BR8_GAUSS" 																							+ CRLF
cQuery += "              , Max(BR8_TRRGSL)    BR8_TRRGSL" 																							+ CRLF
cQuery += "              , Max(BR8_TRRGEX)    BR8_TRRGEX" 																							+ CRLF
cQuery += "              , Max(BR8_CONSFT)    BR8_CONSFT" 																							+ CRLF
cQuery += "              , Max(BR8_TMPCIR)    BR8_TMPCIR" 																							+ CRLF
cQuery += "              , Max(BR8_ODONTO)    BR8_ODONTO" 																							+ CRLF
cQuery += "              , Max(BR8_COBMDP)    BR8_COBMDP" 																							+ CRLF
cQuery += "              , Max(BR8_TIPRAX)    BR8_TIPRAX" 																							+ CRLF
cQuery += "              , Max(BR8_OBSOD1)    BR8_OBSOD1" 																							+ CRLF
cQuery += "              , Max(BR8_CLASIP)    BR8_CLASIP" 																							+ CRLF
cQuery += "              , Max(BR8_YPRAUD)    BR8_YPRAUD" 																							+ CRLF
cQuery += "              , Max(BR8_YMATER)    BR8_YMATER" 																							+ CRLF
cQuery += "              , Max(BR8_DATINC)    BR8_DATINC" 																							+ CRLF
cQuery += "              , Max(BR8_YPERRC)    BR8_YPERRC" 																							+ CRLF
cQuery += "              , Max(BR8_YPDREC)    BR8_YPDREC" 																							+ CRLF
cQuery += "              , Max(BR8_FABRIC)    BR8_FABRIC" 																							+ CRLF
cQuery += "              , Max(BR8_CODBAR)    BR8_CODBAR" 																							+ CRLF
cQuery += "              , Max(BR8_CIDOBR)    BR8_CIDOBR" 																							+ CRLF
cQuery += "              , Max(BR8_YEVENT)    BR8_YEVENT" 																							+ CRLF
cQuery += "              , Max(BR8_YEVCAB)    BR8_YEVCAB" 																							+ CRLF
cQuery += "              , Max(BR8_TRAIND)    BR8_TRAIND" 																							+ CRLF
cQuery += "              , Max(BR8_YNEVEN)    BR8_YNEVEN" 																							+ CRLF
cQuery += "              , Max(BR8_CLASP2)    BR8_CLASP2" 																							+ CRLF
cQuery += "              , Max(BR8_YPRCTA)    BR8_YPRCTA" 																							+ CRLF
cQuery += "              , Max(BR8_ALTCUS)    BR8_ALTCUS" 																							+ CRLF
cQuery += "              , Max(BR8_LIMODO)    BR8_LIMODO" 																							+ CRLF
cQuery += "              , Max(BR8_GRPLIM)    BR8_GRPLIM" 																							+ CRLF
cQuery += "              , Max(BR8_DESLIM)    BR8_DESLIM" 																							+ CRLF
cQuery += "              , Max(BR8_UNMENU)    BR8_UNMENU" 																							+ CRLF
cQuery += "              , Max(BR8_YQMDIA)    BR8_YQMDIA" 																							+ CRLF
cQuery += "              , Max(BR8_YTPLSU)    BR8_YTPLSU" 																							+ CRLF
cQuery += "              , Max(BR8_YEVSIP)    BR8_YEVSIP" 																							+ CRLF
cQuery += "              , Max(BR8_YITGAM)    BR8_YITGAM" 																							+ CRLF
cQuery += "              , Max(BR8_YITGIN)    BR8_YITGIN" 																							+ CRLF
cQuery += "              , Max(BR8_EXEEXT)    BR8_EXEEXT" 																							+ CRLF
cQuery += "              , Max(BR8_APOEXT)    BR8_APOEXT" 																							+ CRLF
cQuery += "              , Max(BR8_CONFAC)    BR8_CONFAC" 																							+ CRLF
cQuery += "              , Max(BR8_CODNIV)    BR8_CODNIV" 																							+ CRLF
cQuery += "              , Max(BR8_COBPAR)    BR8_COBPAR" 																							+ CRLF
cQuery += "              , Max(BR8_FORAUT)    BR8_FORAUT" 																							+ CRLF
cQuery += "              , Max(BR8_TPCONS)    BR8_TPCONS" 																							+ CRLF
cQuery += "              , Max(BR8_FCAREN)    BR8_FCAREN" 																							+ CRLF
cQuery += "           FROM " + RetSqlName('BR8') + " b" 																							+ CRLF
cQuery += "              , TUSS_ANS T" 																												+ CRLF
cQuery += "           WHERE BR8_FILIAL = '" + xFilial('BR8') + "'" 																					+ CRLF
cQuery += "            		AND br8_codpad = '01'" 																									+ CRLF
cQuery += "            		AND Trim(BR8_CODPSA) = Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990))" 				+ CRLF
cQuery += "            		AND D_E_L_E_T_ = ' '" 																									+ CRLF
cQuery += "            		AND T.TUSS NOT IN (	SELECT TUSS" 																						+ CRLF
//        --ESTE TRECHO DE QUERY RETORNA OS CODIGOS TUSS QUE APARECEM MAIS DE UMA VEZ
cQuery += "                                 	FROM (	SELECT Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999))," 					+ CRLF
cQuery += "													Trim(T.THM_1990)) CIEFAS, TUSS, DESC_TUSS" 												+ CRLF
cQuery += "                 		                    FROM tuss_ans t" 																			+ CRLF
cQuery += "                                     WHERE 	Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999))" 							+ CRLF
cQuery += "												,Trim(T.THM_1990)) IS NOT NULL" 						   									+ CRLF
//                                           -- AND TEM_BR8(Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990))) = 1
cQuery += "                                       )x" 																								+ CRLF
cQuery += "		                                GROUP BY TUSS, DESC_TUSS" 																			+ CRLF
cQuery += "		                                HAVING Count(TUSS) > 1" 																			+ CRLF
cQuery += "	                              	  )" 																									+ CRLF
cQuery += "      	      	AND TRIM(BR8_CODPSA) NOT IN (	SELECT CIEFAS" 																			+ CRLF
cQuery += "                                           		FROM (	SELECT NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996))," 						+ CRLF
cQuery += "                                                      		TRIM(T.LPM_1999)),TRIM(T.THM_1990)) CIEFAS, TUSS, DESC_TUSS" 				+ CRLF
cQuery += "                                                   		FROM TUSS_ANS T" 																+ CRLF
cQuery += "                                                  		WHERE 	NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996))," 						+ CRLF
//                                                     --AND TEM_BR8(NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996)),TRIM(T.LPM_1999)),TRIM(T.THM_1990))) = 1
cQuery += "                                                 	  			TRIM(T.LPM_1999)),TRIM(T.THM_1990)) IS NOT NULL" 						+ CRLF
cQuery += "														  ) X" 																				+ CRLF
cQuery += "			                                        GROUP BY CIEFAS" 																		+ CRLF
cQuery += "                                          		HAVING COUNT(CIEFAS) > 1" 																+ CRLF
cQuery += "                                         	)" 																							+ CRLF
cQuery += "          GROUP BY BR8_FILIAL, BR8_CODPAD, Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990)), T.TUSS" 	+ CRLF
cQuery += "              , UPPER(T.DESC_TUSS), DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',TO_CHAR(T.TUSS),' '), DECODE(RETORNA_ROL_TUSS(T.TUSS),'1'"		+ CRLF
cQuery += "              ,Upper(T.DESC_TUSS),' ')" 																									+ CRLF
cQuery += "       )" 																																+ CRLF
cQuery += "WHERE BC0_FILIAL = '" + xFilial('BC0') + "'" 																							+ CRLF
cQuery += "           AND BAX_FILIAL = '" + xFilial('BAX') + "'" 																					+ CRLF
cQuery += "           AND Trim(COD_CIEFAS) BETWEEN Substr(BC0_CODOPC,1,2)||'000000' AND Substr(BC0_CODOPC,1,2)||'999999'" 							+ CRLF
cQuery += "           AND Trim(BC0_CODPAD) = Trim(BR8_CODPAD)" 																						+ CRLF
cQuery += "           AND BC0_NIVEL  in  ('1','2')" 																								+ CRLF
cQuery += "           AND BC0_VIGATE = ' '" 																										+ CRLF
cQuery += "           AND BC0_CODIGO = BAX_CODIGO" 																									+ CRLF
cQuery += "           AND BC0_CODLOC = BAX_CODLOC" 																									+ CRLF
cQuery += "           AND BC0_CODESP = BAX_CODESP" 																									+ CRLF
cQuery += "           AND BAX_DATBLO = ' '" 																										+ CRLF
cQuery += "           AND BC0.D_E_L_E_T_ = ' '" 																									+ CRLF
cQuery += "           AND BAX.D_E_L_E_T_ = ' '" 																									+ CRLF
//           --ABRIR CAPITULOS ESPECIFICOS DA CIEFAS EM TUSS - DESCOMENTE E MUDE OS 2 ou 3 PRIMEIROS DIGITOS E O RDA
cQuery += "           AND ( SUBSTR(Trim(COD_CIEFAS),1,2) in ('20','33','21','28','31','32','34','36','25') )" 										+ CRLF
///* or SUBSTR(Trim(COD_CIEFAS),1,4) in ('2502','2505','2506','3201','3202','3203','3204')*/  
cQuery += "           AND BC0_CODIGO IN ('105112','136174')" 																						+ CRLF
//           --and bc0_codesp in ('025','032')
cQuery += "order by bc0_codesp, bc0_codopc" 																										+ CRLF
      
TcQuery cQuery New Alias cAlias

nQtd := 0

COUNT TO nQtd  

cTot := AllTrim(Transform(nQtd,'@E 999.999.999'))

ProcRegua(nQtd)

nQtd := 0

cAlias->(DbGoTop())

While !cAlias->(EOF())

    IncProc('Processando ' + AllTrim(Transform(++nQtd,'@E 999.999.999')) + ' de ' + cTot + ' registros...')

	Reclock('BC0',.T.)

	BC0->BC0_FILIAL 	:= cAlias->BC0_FILIAL
	BC0->BC0_CODIGO 	:= cAlias->BC0_CODIGO
	BC0->BC0_CODINT 	:= cAlias->BC0_CODINT
	BC0->BC0_CODLOC 	:= cAlias->BC0_CODLOC
	BC0->BC0_CODESP 	:= cAlias->BC0_CODESP
	BC0->BC0_CODSUB 	:= cAlias->BC0_CODSUB
	BC0->BC0_CODTAB 	:= cAlias->BC0_CODTAB
	BC0->BC0_CODPAD		:= cAlias->BC0_CODPAD
	BC0->BC0_CODOPC 	:= cAlias->BC0_CODOPC
	BC0->BC0_NIVEL 		:= cAlias->BC0_NIVEL
	BC0->BC0_VALCH		:= cAlias->BC0_VALCH
	BC0->BC0_VALREA		:= cAlias->BC0_VALREA
	BC0->BC0_VALCOB		:= cAlias->BC0_VALCOB
	BC0->BC0_FORMUL		:= cAlias->BC0_FORMUL
	BC0->BC0_EXPRES		:= cAlias->BC0_EXPRES
	BC0->BC0_PERDES		:= cAlias->BC0_PERDES
	BC0->BC0_PERACR		:= cAlias->BC0_PERACR
	BC0->BC0_TIPO		:= cAlias->BC0_TIPO
	BC0->BC0_CDNV01		:= cAlias->BC0_CDNV01
	BC0->BC0_CDNV02		:= cAlias->BC0_CDNV02
	BC0->BC0_CDNV03		:= cAlias->BC0_CDNV03
	BC0->BC0_CDNV04		:= cAlias->BC0_CDNV04
	BC0->BC0_VIGDE		:= cAlias->BC0_VIGDE
	BC0->BC0_VIGATE		:= cAlias->BC0_VIGATE
	BC0->BC0_BANDA		:= cAlias->BC0_BANDA

	MsUnlock()

	cAlias->(DbSkip())

EndDo

cAlias->(DbCloseArea())

Return nQtd

/*      
INTEGRAL      
--------------------------

SELECT DISTINCT BC0_FILIAL
     , BC0_CODIGO
     , BC0_CODINT
     , BC0_CODLOC
     , BC0_CODESP
     , BC0_CODSUB
     , '024' BC0_CODTAB   
     , BR8_CODPAD_TUSS  BC0_CODPAD
     , To_Char(BR8_CODPSA) BC0_CODOPC
     , BR8_NIVEL BC0_NIVEL
     , BC0_VALCH
     , BC0_VALREA
     , BC0_VALCOB
     , BC0_FORMUL
     , BC0_EXPRES
     , BC0_PERDES
     , BC0_PERACR
     , BC0_TIPO
     , SubStr(BR8_CODPSA,1,5) BC0_CDNV01
     , SubStr(BR8_CODPSA,1,3) BC0_CDNV02
     , SubStr(BR8_CODPSA,1,1) BC0_CDNV03
     , ' ' BC0_CDNV04
     , '20101201' BC0_VIGDE
     , '        ' BC0_VIGATE
     , BC0_BANDA
  FROM BC0020 BC0
     , BAX020 BAX
     , ( SELECT DISTINCT
                BR8_FILIAL
              , '16'               BR8_CODPAD_TUSS
              , BR8_CODPAD
              , Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990)) COD_CIEFAS
              , T.TUSS             BR8_CODPSA
              , Upper(T.DESC_TUSS) BR8_DESCRI
              , Max(BR8_NIVEL )    BR8_NIVEL
              , Max(BR8_BENUTL)    BR8_BENUTL
              , Max(BR8_AUTORI)    BR8_AUTORI
              , Max(BR8_PODDIG)    BR8_PODDIG
              , Max(BR8_SEXO  )    BR8_SEXO
              , Max(BR8_ANASIN)    BR8_ANASIN
              , Max(BR8_CARENC)    BR8_CARENC
              , Max(BR8_UNCAR )    BR8_UNCAR
              , Max(BR8_QTD   )    BR8_QTD
              , Max(BR8_UNCA  )    BR8_UNCA
              , Max(BR8_QTDCRE)    BR8_QTDCRE
              , Max(BR8_QTDESP)    BR8_QTDESP
              , Max(BR8_QTDMED)    BR8_QTDMED
              , Max(BR8_QTDPAT)    BR8_QTDPAT
              , Max(BR8_QTDGEN)    BR8_QTDGEN
              , Max(BR8_QTDSOL)    BR8_QTDSOL
              , Max(BR8_UNQSOL)    BR8_UNQSOL
              , Max(BR8_QTDCON)    BR8_QTDCON
              , Max(Decode(Trim(BR8_UNCACO),NULL,'0',BR8_UNCACO))    BR8_UNCACO
              , Max(BR8_PERIOD)    BR8_PERIOD
              , Max(BR8_UNPERI)    BR8_UNPERI
              , Max(BR8_PTRCRE)    BR8_PTRCRE
              , Max(BR8_PTRESP)    BR8_PTRESP
              , Max(BR8_PTRMED)    BR8_PTRMED
              , Max(BR8_PTRPAT)    BR8_PTRPAT
              , Max(BR8_PTRGEN)    BR8_PTRGEN
              , Max(BR8_PERSOL)    BR8_PERSOL
              , Max(BR8_UNPSOL)    BR8_UNPSOL
              , Max(BR8_PERCON)    BR8_PERCON
              , Max(Decode(Trim(BR8_UNPECO),NULL,'0',BR8_UNPECO))    BR8_UNPECO
              , Max(Decode(Trim(BR8_APOSQT),NULL,'0',BR8_APOSQT))    BR8_APOSQT
              , Max(BR8_APOSPE)    BR8_APOSPE
              , Max(BR8_IDAMIN)    BR8_IDAMIN
              , Max(BR8_UNIMIN)    BR8_UNIMIN
              , Max(BR8_ATOCOP)    BR8_ATOCOP
              , Max(BR8_IDAMAX)    BR8_IDAMAX
              , Max(BR8_UNIMAX)    BR8_UNIMAX
              , Max(BR8_APQTSO)    BR8_APQTSO
              , Max(BR8_APPESO)    BR8_APPESO
              , Max(BR8_FAIDES)    BR8_FAIDES
              , Max(BR8_QTMIAU)    BR8_QTMIAU
              , Max(BR8_QTMAAU)    BR8_QTMAAU
              , Max(BR8_PARCOR)    BR8_PARCOR
              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',TO_CHAR(T.TUSS),' ')    BR8_CODROL
              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',Upper(T.DESC_TUSS),' ')    BR8_DESROL
              , Max(BR8_DIAPD1)    BR8_DIAPD1
              , Max(BR8_DIAPD2)    BR8_DIAPD2
              , Max(BR8_DIAPD3)    BR8_DIAPD3
              , Max(BR8_TABREM)    BR8_TABREM
              , Max(BR8_CLASSE)    BR8_CLASSE
              , Max(BR8_ADCNOT)    BR8_ADCNOT
              , Max(BR8_CODTAB)    BR8_CODTAB
              , Max(BR8_TIPEVE)    BR8_TIPEVE
              , Max(BR8_REGATD)    BR8_REGATD
              , Max(BR8_TRTSER)    BR8_TRTSER
              , Max(BR8_CTREQU)    BR8_CTREQU
              , Max(BR8_PERADC)    BR8_PERADC
              , Max(BR8_CDPDAD)    BR8_CDPDAD
              , Max(BR8_PROADC)    BR8_PROADC
              , Max(BR8_TIPADC)    BR8_TIPADC
              , Max(BR8_PERAD )    BR8_PERAD
              , Max(BR8_CHADC )    BR8_CHADC
              , Max(BR8_CRR   )    BR8_CRR
              , Max(BR8_CLACAR)    BR8_CLACAR
              , Max(BR8_TPPROC)    BR8_TPPROC
              , Max(BR8_PERFOR)    BR8_PERFOR
              , Max(BR8_CODEDI)    BR8_CODEDI
              , Max(Decode (BR8_QTDPER,'0',' ',BR8_QTDPER)) BR8_QTDPER
              , Max(BR8_PROBLO)    BR8_PROBLO
              , Max(BR8_CONMFT)    BR8_CONMFT
              , Max(BR8_LIBESP)    BR8_LIBESP
              , Max(BR8_PODREM)    BR8_PODREM
              , Max(BR8_TIPDIA)    BR8_TIPDIA
              , Max(BR8_GAUSS )    BR8_GAUSS
              , Max(BR8_TRRGSL)    BR8_TRRGSL
              , Max(BR8_TRRGEX)    BR8_TRRGEX
              , Max(BR8_CONSFT)    BR8_CONSFT
              , Max(BR8_TMPCIR)    BR8_TMPCIR
              , Max(BR8_ODONTO)    BR8_ODONTO
              , Max(BR8_COBMDP)    BR8_COBMDP
              , Max(BR8_TIPRAX)    BR8_TIPRAX
              , Max(BR8_OBSOD1)    BR8_OBSOD1
              , Max(BR8_CLASIP)    BR8_CLASIP
              , Max(BR8_YPRAUD)    BR8_YPRAUD
              , Max(BR8_YMATER)    BR8_YMATER
              , Max(BR8_DATINC)    BR8_DATINC
              , Max(BR8_YPERRC)    BR8_YPERRC
              , Max(BR8_YPDREC)    BR8_YPDREC
              , Max(BR8_FABRIC)    BR8_FABRIC
              , Max(BR8_CODBAR)    BR8_CODBAR
              , Max(BR8_CIDOBR)    BR8_CIDOBR
              , Max(BR8_YEVENT)    BR8_YEVENT
              , Max(BR8_YEVCAB)    BR8_YEVCAB
              , Max(BR8_TRAIND)    BR8_TRAIND
              , Max(BR8_YNEVEN)    BR8_YNEVEN
              , Max(BR8_CLASP2)    BR8_CLASP2
              , Max(BR8_YPRCTA)    BR8_YPRCTA
              , Max(BR8_ALTCUS)    BR8_ALTCUS
              , Max(BR8_LIMODO)    BR8_LIMODO
              , Max(BR8_GRPLIM)    BR8_GRPLIM
              , Max(BR8_DESLIM)    BR8_DESLIM
              , Max(BR8_UNMENU)    BR8_UNMENU
              , Max(BR8_YQMDIA)    BR8_YQMDIA
              , Max(BR8_YTPLSU)    BR8_YTPLSU
              , Max(BR8_YEVSIP)    BR8_YEVSIP
              , Max(BR8_YITGAM)    BR8_YITGAM
              , Max(BR8_YITGIN)    BR8_YITGIN
              , Max(BR8_EXEEXT)    BR8_EXEEXT
              , Max(BR8_APOEXT)    BR8_APOEXT
              , Max(BR8_CONFAC)    BR8_CONFAC
              , Max(BR8_CODNIV)    BR8_CODNIV
              , Max(BR8_COBPAR)    BR8_COBPAR
              , Max(BR8_FORAUT)    BR8_FORAUT
              , Max(BR8_TPCONS)    BR8_TPCONS
              , Max(BR8_FCAREN)    BR8_FCAREN
           FROM BR8020 b
              , TUSS_ANS T
          WHERE BR8_FILIAL = ' '
            AND br8_codpad = '01'
            AND Trim(BR8_CODPSA) = Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990))
            AND D_E_L_E_T_ = ' '
            AND T.TUSS NOT IN (SELECT TUSS        --ESTE TRECHO DE QUERY RETORNA OS CODIGOS TUSS QUE APARECEM MAIS DE UMA VEZ
                                 FROM (SELECT Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990)) CIEFAS
                                            , TUSS
                                            , DESC_TUSS
                                          FROM tuss_ans t
                                         WHERE Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990)) IS NOT NULL
                                           -- AND TEM_BR8(Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990))) = 1
                                       )x
                                GROUP BY TUSS
                                       , DESC_TUSS
                                HAVING Count(TUSS) > 1
                              )

            AND TRIM(BR8_CODPSA) NOT IN (SELECT CIEFAS
                                           FROM (SELECT NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996)),TRIM(T.LPM_1999)),TRIM(T.THM_1990)) CIEFAS
                                                      , TUSS
                                                      , DESC_TUSS
                                                   FROM TUSS_ANS T
                                                  WHERE NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996)),TRIM(T.LPM_1999)),TRIM(T.THM_1990)) IS NOT NULL
                                                     --AND TEM_BR8(NVL(NVL(NVL(TRIM(T.THM_1992),TRIM(T.LPM_1996)),TRIM(T.LPM_1999)),TRIM(T.THM_1990))) = 1
                                                 )X
                                          GROUP BY CIEFAS
                                          HAVING COUNT(CIEFAS) > 1
                                         )
                                                      
          GROUP BY BR8_FILIAL
              , BR8_CODPAD
              , Nvl(Nvl(Nvl(Trim(T.THM_1992),Trim(T.LPM_1996)),Trim(T.LPM_1999)),Trim(T.THM_1990))
              , T.TUSS
              , UPPER(T.DESC_TUSS)
              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',TO_CHAR(T.TUSS),' ')
              , DECODE(RETORNA_ROL_TUSS(T.TUSS),'1',Upper(T.DESC_TUSS),' ')
       )
         WHERE BC0_FILIAL = ' '
           AND BAX_FILIAL = ' '
           AND Trim(COD_CIEFAS) BETWEEN Substr(BC0_CODOPC,1,2)||'000000' AND Substr(BC0_CODOPC,1,2)||'999999'
           AND Trim(BC0_CODPAD) = Trim(BR8_CODPAD)
           AND BC0_NIVEL  in  ('1','2')
           AND BC0_VIGATE = ' '
           AND BC0_CODIGO = BAX_CODIGO
           AND BC0_CODLOC = BAX_CODLOC
           AND BC0_CODESP = BAX_CODESP
           AND BAX_DATBLO = ' '
           AND BC0.D_E_L_E_T_ = ' '
           AND BAX.D_E_L_E_T_ = ' '
           --ABRIR CAPITULOS ESPECIFICOS DA CIEFAS EM TUSS - DESCOMENTE E MUDE OS 3 PRIMEIROS DIGITOS E O RDA
//           AND ( SUBSTR(Trim(COD_CIEFAS),1,2) in ('51')  /*or SUBSTR(Trim(COD_CIEFAS),1,4) in ('2502','2505','2506','3201','3202','3203','3204')*/ // )
//           --and bc0_codesp in ('025','032')
//           and bc0_codIGO in ('111708')
//      order by bc0_codesp, bc0_codopc    
