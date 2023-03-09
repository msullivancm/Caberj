#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR266  บAutor  ณ Fabio Bianchini     บ Data ณ 22/01/2018  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de Conferencia SIGAGPE Autonomos x Titulos PLS   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR266()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de variaveis                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private oReport  := Nil
Private oSecCab	 := Nil
Private cPerg 	 := PadR ("CABR266", Len (SX1->X1_GRUPO))
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao e apresentacao das perguntas      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//PutSx1(cPerg,"01","Processo?"      ,'','',"mv_ch1","C",TamSx3 ("RC_PROCES")[1] ,0,,"G","","SRC","","","mv_par01","","","","","","","","","","","","","","","","")
//PutSx1(cPerg,"02","Roteiro?"       ,'','',"mv_ch2","C",TamSx3 ("RC_ROTEIR")[1] ,0,,"G","","SRC","","","mv_par02","","","","","","","","","","","","","","","","")
//PutSx1(cPerg,"03","Periodo?"       ,'','',"mv_ch3","C",TamSx3 ("RC_PERIODO")[1],0,,"G","","SRC","","","mv_par03","","","","","","","","","","","","","","","","")
//PutSx1(cPerg,"04","Matricula de?"  ,'','',"mv_ch4","C",TamSx3 ("RC_MAT")[1]    ,0,,"G","","SRC","","","mv_par04","","","","","","","","","","","","","","","","")
//PutSx1(cPerg,"05","Matricula ate?" ,'','',"mv_ch5","C",TamSx3 ("RC_MAT")[1]    ,0,,"G","","SRC","","","mv_par05","","","","","","","","","","","","","","","","")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefinicoes/preparacao para impressao      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef()
oReport:PrintDialog()

Return //Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณ Fabio Bianchini    บ Data ณ 22/01/2018  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo da estrutura do relat๓rio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
//AjustaSX1()

Pergunte(cPerg,.F.)
oReport := TReport():New("CABR266","Diverg๊ncias Titulos PLS x GPE - Aut๔nomos",cPerg,{|oReport| PrintReport(oReport)},"Impressใo de cadastro de produtos em TReport simples.")
oReport:SetLandscape(.T.)

oSecCab := TRSection():New( oReport , "Integra็ใo PLS x GPE - Aut๔nomos", {"QRY"} )
TRCell():New( oSecCab, "RC_MAT"    , "QRY",'MAT.AUTON.'    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "E2_CODRDA" , "QRY",'CODIGO RDA'    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "RA_NOME"   , "QRY",'NOME'          ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "VERBA_110" , "QRY",'V.110-VLR.Bru.',"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "VERBA_403" , "QRY",'V.403-VLR.INSS',"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "VERBA_404" , "QRY",'V.404-VLR.IRRF',"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "VERBA_600" , "QRY",'V.600-VLR.Liq.',"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "TOTAL_FOLHA","QRY",'VLR.TOT.GPE'   ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_PREFIXO", "QRY",'PREFIX.TIT.PLS',/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_NUM"    , "QRY",'NUM.TIT.PLS'   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_PARCELA", "QRY",'PARCELA PLS'   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_TIPO"   , "QRY",'TIPO'          ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "TOTAL_PLS" , "QRY",'VLR.TOT.PLS'   ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "E2_INSS"   , "QRY",'VLR.INSS.PLS'  ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "E2_IRRF", "QRY",'VLR.IRRF.PLS'  ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New( oSecCab, "E2_VALOR"  , "QRY",'VLR.TIT.PLS'   ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_VRETINS", "QRY",'RET.INSS.PLS'  ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_VRETIRF", "QRY",'RET.IRRF.PLS'  ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_SDACRES", "QRY",'ACRESC.PLS'    ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New( oSecCab, "E2_SDDECRE", "QRY",'DECRESC.PLS'   ,"@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

TRCell():New( oSecCab, "SITUACAO"  , "QRY",'SITUACAO'      ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRFunction():New(/*Cell*/             ,/*cId*/,/*Function*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*Section*/)
//TRFunction():New(oSecCab:Cell("B1_COD")  ,/*cId*/,"COUNT"     ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.           ,.T.           ,.F.        ,oSecCab)

oSecCab:SetTotalText("Total de Aut๔nomos")

TRFunction():New(oSecCab:Cell("RC_MAT"),NIL,"COUNT"	,/*oBreak1*/,/*cTitle*/,"@E 9999",/*uFormula*/,.T.,.F.)

Return (oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRCOMR01   บAutor  ณ Vinํcius Moreira   บ Data ณ 12/11/2013  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)
Local cQuery     := ""

//Pergunte(cPerg,.F.)

cQuery := "SELECT * "  + CRLF
cQuery += "  FROM ( "  + CRLF
cQuery += "       SELECT RC_MAT "  + CRLF 
cQuery += "            , E2_CODRDA "  + CRLF
cQuery += "            , RA_NOME "  + CRLF
cQuery += "            , RA_CIC  "  + CRLF
cQuery += "            , VLR_V110 VERBA_110 "  + CRLF
cQuery += "            , VLR_V403 VERBA_403 "  + CRLF
cQuery += "            , VLR_V404 VERBA_404 "  + CRLF
cQuery += "           , VLR_V600 VERBA_600 "  + CRLF
cQuery += "            , SUM(TOTAL_PLS) TOTAL_PLS "  + CRLF
cQuery += "            , SUM(E2_INSS)  E2_INSS "  + CRLF
cQuery += "            , SUM(E2_IRRF)  E2_IRRF "  + CRLF
cQuery += "            , SUM(E2_VALOR) E2_VALOR "  + CRLF
cQuery += "            , CASE WHEN VLR_V110 <> (SUM(TOTAL_PLS)) THEN 'DIVERGENTE'  "  + CRLF
cQuery += "                   ELSE 'IGUAL' "  + CRLF
cQuery += "              END SITUACAO "  + CRLF
cQuery += "         FROM (        "  + CRLF
cQuery += "               SELECT RC_MAT   "  + CRLF
cQuery += "                    , E2_CODRDA "  + CRLF
cQuery += "                    , RA_NOME "  + CRLF
cQuery += "                    , RA_CIC  "  + CRLF
cQuery += "                    , SUM(VLR_V110) VLR_V110 "  + CRLF
cQuery += "                    , SUM(VLR_V403) VLR_V403 "  + CRLF
cQuery += "                    , SUM(VLR_V404) VLR_V404 "  + CRLF
cQuery += "                    , SUM(VLR_V600) VLR_V600 "  + CRLF
cQuery += "                    , E2_VALOR + E2_INSS + E2_IRRF TOTAL_PLS "  + CRLF
cQuery += "                    , E2_INSS "  + CRLF
cQuery += "                    , E2_IRRF "  + CRLF
cQuery += "                    , E2_VALOR "  + CRLF
cQuery += "                    , E2_PREFIXO "  + CRLF
cQuery += "                    , E2_NUM "  + CRLF
cQuery += "                FROM ( "  + CRLF
cQuery += "                        SELECT DISTINCT "  + CRLF
cQuery += "                               RC_MAT  "  + CRLF
cQuery += "                             , RA_NOME "  + CRLF
cQuery += "                             , RA_CIC  "  + CRLF
cQuery += "                             , Case When RC_PD = '110' Then RC_VALOR "  + CRLF
cQuery += "                                    Else 0 "  + CRLF
cQuery += "                               END VLR_V110                	 "  + CRLF
cQuery += "                             , Case When RC_PD = '403' Then RC_VALOR "  + CRLF
cQuery += "                                    Else 0 "  + CRLF
cQuery += "                               END VLR_V403 "  + CRLF
cQuery += "                             , Case When RC_PD = '404' Then RC_VALOR "  + CRLF
cQuery += "                                    Else 0 "  + CRLF
cQuery += "                               END VLR_V404 "  + CRLF
cQuery += "                             , Case When RC_PD = '600' Then RC_VALOR "  + CRLF 
cQuery += "                                    Else 0 "  + CRLF
cQuery += "                               END VLR_V600 "  + CRLF
cQuery += "                             , E2_CODRDA  "  + CRLF
cQuery += "                             , E2_VALOR    "  + CRLF
cQuery += "                             , E2_INSS     "  + CRLF
cQuery += "                             , E2_IRRF      "  + CRLF 
cQuery += "                             , E2_PREFIXO   "  + CRLF
cQuery += "                             , E2_NUM       "  + CRLF 
cQuery += "            	  			 FROM SIGA." + RetSqlName("SRC") + " SRC " + CRLF
cQuery += "                	 			, SIGA." + RetSqlName("SRA") + " SRA " + CRLF
cQuery += "                	 			, SIGA." + RetSqlName("SRV") + " SRV " + CRLF
cQuery += "            					, SIGA." + RetSqlName("SA2") + " SA2 " + CRLF
cQuery += "            					, SIGA." + RetSqlName("SE2") + " SE2 " + CRLF
cQuery += "                         WHERE RC_FILIAL = '"+xFilial("SRC") +"' "  + CRLF
cQuery += "                           AND RA_FILIAL = '"+xFilial("SRA") +"' "  + CRLF
cQuery += "                           AND RV_FILIAL = '"+xFilial("SRV") +"' "  + CRLF
cQuery += "                           AND A2_FILIAL = '"+xFilial("SA2") +"' "  + CRLF
cQuery += "                           AND E2_FILIAL = '"+xFilial("SE2") +"' "  + CRLF
cQuery += "                           AND RA_MAT = RC_MAT "  + CRLF
cQuery += "                           AND RV_COD = RC_PD  "  + CRLF
cQuery += "                			  AND RC_PROCES  = '" + mv_par01 + "' " + CRLF
cQuery += "                			  AND RC_ROTEIR  = '" + mv_par02 + "' " + CRLF
cQuery += "                			  AND RC_PERIODO = '" + mv_par03 + "' " + CRLF
cQuery += "                			  AND RC_MAT BETWEEN '"+mv_par04 + "' AND '" + mv_par05 + "'" + CRLF 
cQuery += "                           AND RC_PD IN ('110','403','404','600')  "  + CRLF
cQuery += "                           AND A2_CGC     = RA_CIC "  + CRLF
cQuery += "                           AND E2_FORNECE = A2_COD "  + CRLF
cQuery += "                           AND E2_LOJA    = A2_LOJA "  + CRLF
cQuery += "          				  AND SUBSTR(E2_PLLOTE,1,6) = '"+mv_par03+"' " + CRLF
cQuery += "                           AND E2_TIPO = 'FT'      "  + CRLF
cQuery += "                           AND SRC.D_E_L_E_T_ = ' ' "  + CRLF
cQuery += "                           AND SRA.D_E_L_E_T_ = ' ' "  + CRLF
cQuery += "                           AND SRV.D_E_L_E_T_ = ' ' "  + CRLF
cQuery += "                           AND SA2.D_E_L_E_T_ = ' ' "  + CRLF
cQuery += "                           AND SE2.D_E_L_E_T_ = ' ' "  + CRLF
cQuery += "                      )     "  + CRLF
cQuery += "                         GROUP BY RC_MAT "  + CRLF
cQuery += "                                , E2_CODRDA "  + CRLF
cQuery += "                                , RA_NOME "  + CRLF
cQuery += "                                , RA_CIC "  + CRLF
cQuery += "                                , E2_VALOR + E2_INSS + E2_IRRF "  + CRLF
cQuery += "                                , E2_INSS "  + CRLF
cQuery += "                                , E2_IRRF "  + CRLF
cQuery += "                                , E2_VALOR "  + CRLF
cQuery += "                                , E2_PREFIXO "  + CRLF
cQuery += "                                , E2_NUM "  + CRLF
cQuery += "               ) "  + CRLF
cQuery += "          GROUP BY RC_MAT  "  + CRLF
cQuery += "               , E2_CODRDA "  + CRLF
cQuery += "               , RA_NOME "  + CRLF
cQuery += "               , RA_CIC  "  + CRLF
cQuery += "               , VLR_V110 "  + CRLF
cQuery += "               , VLR_V403 "  + CRLF
cQuery += "               , VLR_V404 "  + CRLF
cQuery += "               , VLR_V600 "  + CRLF
cQuery += "      )
cQuery += "      WHERE ROUND(VERBA_403,0) <> ROUND(E2_INSS,0) "  + CRLF
cQuery += "         OR ROUND(VERBA_404,0) <> ROUND(E2_IRRF,0) "  + CRLF
cQuery += "      ORDER BY  RC_MAT "  + CRLF
      
//cQuery := ChangeQuery(cQuery)
memowrite("c:\temp\cabr266.sql",cQuery)

If Select("QRY") > 0
	Dbselectarea("QRY")
	QRY->(DbClosearea())
EndIf

TcQuery cQuery New Alias "QRY"

oSecCab:BeginQuery()
oSecCab:EndQuery({{"QRY"},cQuery})
oSecCab:Print()

Return Nil

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aAdd(aHelp, "Processo")      
PutSx1(cPerg,"01","Processo?"      ,'','',"mv_ch1","C",TamSx3 ("RC_PROCES")[1] ,0,,"G","","SRC","","","mv_par01","","","","","","","","","","","","","","","","")

aHelp 	:= {}
aAdd(aHelp, "Roteiro")
PutSx1(cPerg,"02","Roteiro?"       ,'','',"mv_ch2","C",TamSx3 ("RC_ROTEIR")[1] ,0,,"G","","SRC","","","mv_par02","","","","","","","","","","","","","","","","")

aHelp 	:= {}
aAdd(aHelp, "Periodo")
PutSx1(cPerg,"03","Periodo?"       ,'','',"mv_ch3","C",TamSx3 ("RC_PERIODO")[1],0,,"G","","SRC","","","mv_par03","","","","","","","","","","","","","","","","")

aHelp 	:= {}
aAdd(aHelp, "Matricula Inicial")
PutSx1(cPerg,"04","Matricula de?"  ,'','',"mv_ch4","C",TamSx3 ("RC_MAT")[1]    ,0,,"G","","SRC","","","mv_par04","","","","","","","","","","","","","","","","")

aHelp 	:= {}
aAdd(aHelp, "Matricula Final")
PutSx1(cPerg,"05","Matricula ate?" ,'','',"mv_ch5","C",TamSx3 ("RC_MAT")[1]    ,0,,"G","","SRC","","","mv_par05","","","","","","","","","","","","","","","","")

RestArea(aArea2)

Return   

