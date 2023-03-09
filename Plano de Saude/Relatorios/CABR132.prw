#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR132  ³ Autor ³                       ³ Data ³  /  /    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Custos Administrados por RDA.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR132

Local oReport 
Local cUsrAut 	:= AllTrim(GetNewPar('MV_XRCUADM','000427;000179'))//Alan e Esther
Private cPerg	:= "CABR132" 

If !RetCodUsr() $ ( AllTrim(GetMv('MV_XGETIN')) + '|' + AllTrim(GetMV('MV_XGERIN')) + '|' + cUsrAut )
	MsgStop('Usuário sem acesso a este relatório',AllTrim(SM0->M0_NOMECOM))     	
Else
	oReport:= ReportDef()
	oReport:PrintDialog()
EndIf

Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oRDA
Local oCompet

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR132","Analítico por RDA","CABR132", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Analítico por RDA")

*'--------------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'--------------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //EspaÃ§amento entre colunas. 
oReport:SetLandscape() //ImpressÃ£o em paisagem.  
//oReport:SetPortrait() //ImpressÃ£o em retrato.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Analítico por RDA")
oRDA:SetTotalInLine(.F.)

//TRCell():New(oRDA ,'DUPLICADO'			,	,'Dupl.'		,/*Picture*/			,3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'OCORRENCIAS' 		,	,'Ocorrências'	,/*Picture*/			,25	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'VALOR_2012_10' 		,	,'Vlr 2012_10'	,'@E 999,999,999.99'	,12	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
TRCell():New(oRDA ,'VALOR_2012_11' 		,	,'Vlr 2012_11'	,'@E 999,999,999.99'	,12	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
TRCell():New(oRDA ,'VALOR_LOTE'			,	,'Vlr Lote'		,'@E 999,999,999.99'	,12	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
TRCell():New(oRDA ,'LOTE'		 		,	,'Lote Pgto'	,/*Picture*/			,10	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'MESANO'		 		,	,'Mes/Ano'		,/*Picture*/			,7	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'IMPRESSO'	 		,	,'Num. guia'	,/*Picture*/			,TamSX3('BD7_NUMIMP')[1]	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'ID'					,	,'ID Pgto'		,/*Picture*/ 			,8	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'CODIGO_RDA'			,	,'Cod. RDA'		,/*Picture*/			,6	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'NOME_RDA'			,	,'Nome RDA'		,/*Picture*/  			,35	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'LOCAL_DIG'			,	,'Loc Dig.'		,/*Picture*/ 			,4	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'PEG'				,	,'PEG'			,/*Picture*/  			,8	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'NUMERO'				,	,'Num.'			,/*Picture*/  			,8	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'SEQUENCIA'			,	,'Seq.'			,/*Picture*/  			,3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New(oRDA ,'MATRIC'				,	,'Matric.'		,/*Picture*/  			,17	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'NOME_BENEF'			,	,'Nome benef.'	,/*Picture*/  			,25	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA:SetTotalText("Total geral")

TRFunction():New(oRDA:Cell('VALOR_2012_10')		,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell('VALOR_2012_11')		,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell('VALOR_LOTE')		,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)

Local oBreak01                             
Local oBreak02                             

Private oRDA   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private cBuffer		:= ''
Private cArq		:= ''
Private nCont		:= 0

//Quebra por RDA
//oBreak01 := TRBreak():New(oRDA,oRDA:Cell("B37_CODRDA"),"Subtotal por RDA",.F.) 
	
//TRFunction():New(oRDA:Cell("B37_VLRPAG"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRPAG)}		,.F.,.F.)

Processa({||nCont := FilTRep()},"Grupo Caberj")

//Se nao tiver esta linha, nÃ£o imprime os dados
oRDA:init()

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

While !( cAlias->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()

	//oRDA:Cell('DUPLICADO' 			):SetValue(cAlias->(DUPLICADO)				)
	oRDA:Cell('OCORRENCIAS' 		):SetValue(AllTrim(cAlias->(OCORRENCIAS)) 	)
	oRDA:Cell('VALOR_2012_10'	 	):SetValue(cAlias->(VL2012_10)		 		)
	oRDA:Cell('VALOR_2012_11' 		):SetValue(cAlias->(VL2012_11)				)
	oRDA:Cell('VALOR_LOTE' 			):SetValue(cAlias->(VALOR_LOTE)	   			)
	oRDA:Cell('LOTE'			 	):SetValue(cAlias->(LOTE)					)
	oRDA:Cell('ID'				 	):SetValue(cAlias->(ID)	 					)
	oRDA:Cell('CODIGO_RDA'		 	):SetValue(cAlias->(BAU_CODIGO)				)
	oRDA:Cell('NOME_RDA'		 	):SetValue(cAlias->(BAU_NOME)				)
	oRDA:Cell('LOCAL_DIG'		 	):SetValue(cAlias->(BD7_CODLDP)				)
	oRDA:Cell('PEG'	 			 	):SetValue(cAlias->(BD7_CODPEG) 			)
	oRDA:Cell('NUMERO'			 	):SetValue(cAlias->(BD7_NUMERO)				)
	oRDA:Cell('SEQUENCIA'		 	):SetValue(cAlias->(BD7_SEQUEN)				)
	//oRDA:Cell('MATRIC'			 	):SetValue(cAlias->(MATRIC)					)
	oRDA:Cell('NOME_BENEF'		 	):SetValue(AllTrim(cAlias->(NOME_BENEF))	)
	oRDA:Cell('MESANO'			 	):SetValue(Substr(cAlias->(LOTE),5,2) + '/' + Left(cAlias->(LOTE),4))
	oRDA:Cell('IMPRESSO'		 	):SetValue(AllTrim(cAlias->(IMPRESSO))	)

	oRDA:PrintLine()

    cAlias->(DbSkip())

EndDo

oRDA:Finish()

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next

cQuery := "SELECT *" 																																			+ CRLF 
cQuery += "FROM (" 																																				+ CRLF
cQuery += "SELECT  CASE WHEN INSTR(OCORRENCIAS,'|') > 0 THEN 'SIM' ELSE 'NAO' END DUPLICADO,OCORRENCIAS," 														+ CRLF
cQuery += "        CASE WHEN INSTR(OCORRENCIAS,'2012_10') > 0 THEN (SELECT VL_APROV FROM CUSTO_ADM_201210 WHERE BD7RECNO = RECNO) ELSE 0 END VL2012_10,"  		+ CRLF
cQuery += "        CASE WHEN INSTR(OCORRENCIAS,'2012_11') > 0 THEN (SELECT VL_APROV FROM CUSTO_ADM_201211 WHERE BD7RECNO = RECNO) ELSE 0 END VL2012_11,"		+ CRLF
cQuery += "        CASE WHEN INSTR(OCORRENCIAS,'LOTE') > 0 THEN BD7_VLRPAG ELSE 0 END VALOR_LOTE, BD7_NUMLOT LOTE,BD7_ANOPAG ANO,BD7_MESPAG MES,"				+ CRLF
cQuery += "        CASE WHEN E2_FILIAL IS NULL THEN ' ' ELSE E2_PREFIXO||E2_NUM END TITULO," 																	+ CRLF
cQuery += "        RECNO ID,BAU_CODIGO,BAU_NOME,FORNECE,MATRIC,NOME_BENEF,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_SEQUEN,BD7_NUMIMP IMPRESSO"						+ CRLF
cQuery += "FROM" 																	   																			+ CRLF
cQuery += "(" 																	   																				+ CRLF
cQuery += "  SELECT  DUPLICIDADE_CUSTO_ADM(BD7.R_E_C_N_O_) OCORRENCIAS,BD7.R_E_C_N_O_ RECNO,BD7_VLRPAG,BD7_NUMLOT,BAU_CODIGO,BAU_NOME,BAU_CODSA2 FORNECE," 		+ CRLF
cQuery += "          TRIM(BA1_NOMUSR) NOME_BENEF,BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC," 											+ CRLF
cQuery += "          BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_SEQUEN,BD7_ANOPAG,BD7_MESPAG,BD7_NUMIMP" 								  								+ CRLF
cQuery += "  FROM BD7010 BD7" 																	 																+ CRLF
cQuery += "  INNER JOIN BAU010 BAU ON BAU_FILIAL = ' '   " 																	 									+ CRLF
cQuery += "    AND BAU_CODIGO = '" + cValToChar(mv_par01) + "'" 																								+ CRLF
cQuery += "    AND BAU.D_E_L_E_T_ = '  ' " 																	 													+ CRLF
cQuery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = '  '" 														   												+ CRLF
cQuery += "    AND BA1_CODINT = BD7_OPEUSR" 																	 												+ CRLF
cQuery += "    AND BA1_CODEMP = BD7_CODEMP" 																	 												+ CRLF
cQuery += "    AND BA1_MATRIC = BD7_MATRIC" 																	  												+ CRLF
cQuery += "    AND BA1_TIPREG = BD7_TIPREG" 																	  												+ CRLF
cQuery += "    AND BA1.D_E_L_E_T_ = ' '" 																	  													+ CRLF
cQuery += "  WHERE BD7.R_E_C_N_O_ IN" 																	 														+ CRLF
cQuery += "    (" 																	  																			+ CRLF
cQuery += "    SELECT BD7RECNO" 																  																+ CRLF
cQuery += "    FROM CUSTO_ADM_201210" 																															+ CRLF
cQuery += "    WHERE CUSTO_ADM_201210.CODRDA = '" + cValToChar(mv_par01) + "'" 																					+ CRLF
cQuery += "      AND CUSTO_ADM_201210.VL_APROV > 0" 																											+ CRLF
cQuery += "" 																	   																				+ CRLF
cQuery += "    UNION" 																	 																		+ CRLF
cQuery += "" 																	 																				+ CRLF
cQuery += "    SELECT BD7RECNO" 																	  															+ CRLF
cQuery += "    FROM CUSTO_ADM_201211" 																	  														+ CRLF
cQuery += "    WHERE CUSTO_ADM_201211.CODRDA = '" + cValToChar(mv_par01) + "'" 																					+ CRLF
cQuery += "      AND CUSTO_ADM_201211.VL_APROV > 0" 																											+ CRLF
cQuery += "    )" 																																				+ CRLF
cQuery += "    AND BD7.D_E_L_E_T_ = ' '" 														   																+ CRLF
cQuery += ") Q" 																	  																			+ CRLF
cQuery += "LEFT JOIN SE2010 SE2 ON E2_FILIAL = '01'" 																   											+ CRLF
cQuery += "  AND E2_FORNECE = FORNECE" 															 																+ CRLF
cQuery += "  AND E2_LOJA = '01'" 																																+ CRLF
cQuery += "  AND E2_PREFIXO = 'CLI'" 														   																	+ CRLF
cQuery += "  AND E2_PLLOTE = BD7_NUMLOT" 																	 													+ CRLF
cQuery += "  AND SE2.D_E_L_E_T_ = ' '" 																															+ CRLF
cQuery += ")"						 																															+ CRLF
cQuery += "WHERE ( ( '" + cValToChar(mv_par02) + "' = '1' AND DUPLICADO = 'SIM' )"															 					+ CRLF
cQuery += "  OR ( '" + cValToChar(mv_par02) + "' = '2' AND DUPLICADO = 'NAO' )"																					+ CRLF
cQuery += "  OR ( '" + cValToChar(mv_par02) + "' = '3' ) )"																				 						+ CRLF
cQuery += "ORDER BY DUPLICADO DESC,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_SEQUEN" 																				+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(DbGoTop())

nCont := 0   

COUNT TO nCont

cAlias->(DbGoTop())

Return nCont

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aAdd(aHelp, "Informe o RDA")         
PutSX1(cPerg , "01" , "RDA" 			,"","","mv_ch1","C",TamSx3("BAU_CODIGO")[1],0,0,"G",""	,"BAUNFE","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Duplicados?")         
PutSX1(cPerg , "02" , "Duplicados"		,"","","mv_ch2","N",1,0,0,"C",""	,"","","","mv_par02","Sim","","","","Não","","","Ambos","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************
