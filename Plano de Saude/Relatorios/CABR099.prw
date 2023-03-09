#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR099  ³ Autor ³ Leonardo Portella     ³ Data ³05/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de contas de RDA (prestador) bloqueadas por      ³±±
±±³          ³ competencia.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR099

Local oReport 
Private cPerg	:= "CABR099"  

oReport:= ReportDef()
oReport:PrintDialog()

Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
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

oReport	:= TReport():New("CABR099","Contas bloqueadas por RDA","CABR099", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de contas bloqueadas por RDA")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //EspaÃ§amento entre colunas. 
oReport:SetLandscape() //ImpressÃ£o em paisagem.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Contas bloqueadas por RDA")
oRDA:SetTotalInLine(.F.) 
                                                        
TRCell():New(oRDA ,'BD7_CODRDA'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_NOMRDA'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BI3_NREDUZ'	,'BI3'	,"Plano"	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_LOTBLO'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_VLRMAN'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_VLRGLO'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_VLRPAG'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_VLRBLO'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BD7_MESPAG'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
TRCell():New(oRDA ,'BD7_ANOPAG'	,'BD7'	,/*Titulo*/	,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)

oRDA:SetTotalText("Total geral")   

TRFunction():New(oRDA:Cell("BD7_VLRMAN")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell("BD7_VLRPAG")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell("BD7_VLRGLO")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell("BD7_VLRBLO")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
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
Local oBreak03                             

Private oRDA   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private cSepCsv		:= If(mv_par08 == 1,';',',')
Private lExcel		:= mv_par07 == 1
Private cPathCsv 	:= GetTempPath()
Private cBuffer		:= ''
Private cArq		:= ''
Private nCont		:= 0

If lExcel 

	cArq	:= cPathCsv + "CABR099_" + DtoS(dDatabase) + "_" + StrTran(Time(),":","")+".CSV"
	nHdl 	:= FCreate(cArq) 

	cBuffer += RetTitle("BD7_CODRDA") 	+ cSepCsv
	cBuffer += RetTitle("BD7_NOMRDA")	+ cSepCsv
	cBuffer += "Plano"					+ cSepCsv
	cBuffer += RetTitle("BD7_LOTBLO")	+ cSepCsv
	cBuffer += RetTitle("BD7_VLRMAN")	+ cSepCsv
	cBuffer += RetTitle("BD7_VLRGLO")	+ cSepCsv
	cBuffer += RetTitle("BD7_VLRPAG")	+ cSepCsv
	cBuffer += RetTitle("BD7_VLRBLO")	+ cSepCsv
	cBuffer += RetTitle("BD7_MESPAG")	+ cSepCsv
	cBuffer += RetTitle("BD7_ANOPAG")	+ cSepCsv
	cBuffer += CRLF                                    

EndIf    

Do Case

	Case mv_par10 == 2 .or. mv_par10 == 3
	                 
		If mv_par10 == 3
		
			// Quebra por mes
			oBreak01 := TRBreak():New(oRDA,oRDA:Cell("BD7_MESPAG"),"Subtotal por mÃªs",.F.) 
			
			TRFunction():New(oRDA:Cell("BD7_VLRMAN"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BASE)}		,.F.,.F.)
			TRFunction():New(oRDA:Cell("BD7_VLRPAG"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_PAGAR)}		,.F.,.F.)
			TRFunction():New(oRDA:Cell("BD7_VLRGLO"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_GLOSA)}	,.F.,.F.)
			TRFunction():New(oRDA:Cell("BD7_VLRBLO"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BLOQ)}		,.F.,.F.)
		
		EndIf

		// Quebra por ano
		oBreak02 := TRBreak():New(oRDA,oRDA:Cell("BD7_ANOPAG"),"Subtotal por ano",.F.) 
		
		TRFunction():New(oRDA:Cell("BD7_VLRMAN"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BASE)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRPAG"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_PAGAR)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRGLO"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_GLOSA)}	,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRBLO"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BLOQ)}		,.F.,.F.)
		
	Case mv_par10 == 1

		// Quebra por RDA
		oBreak03 := TRBreak():New(oRDA,oRDA:Cell("BD7_CODRDA"),"Subtotal RDA",.F.) 
		
		TRFunction():New(oRDA:Cell("BD7_VLRMAN"),NIL,"SUM",oBreak03,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BASE)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRPAG"),NIL,"SUM",oBreak03,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_PAGAR)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRGLO"),NIL,"SUM",oBreak03,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_GLOSA)}	,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRBLO"),NIL,"SUM",oBreak03,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BLOQ)}		,.F.,.F.)
		
	Case mv_par10 == 4

		// Quebra por Plano
		oBreak04 := TRBreak():New(oRDA,oRDA:Cell("BI3_NREDUZ"),"Subtotal Plano",.F.) 
		
		TRFunction():New(oRDA:Cell("BD7_VLRMAN"),NIL,"SUM",oBreak04,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BASE)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRPAG"),NIL,"SUM",oBreak04,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_PAGAR)}		,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRGLO"),NIL,"SUM",oBreak04,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_GLOSA)}	,.F.,.F.)
		TRFunction():New(oRDA:Cell("BD7_VLRBLO"),NIL,"SUM",oBreak04,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(VLR_BLOQ)}		,.F.,.F.)	
	
EndCase

MsgRun("Selecionando registros...","GRUPO CABERJ",{||nCont := FilTRep()})

//Se nao tiver esta linha, nÃ£o imprime os dados
oRDA:init()

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0      
	
While !( cAlias->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    If lExcel
	    	cBuffer := CRLF + CRLF + 'Cancelado pelo operador!!!' + CRLF
	    	FWrite(nHdl,cBuffer,len(cBuffer))
		EndIf
		
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:Cell('BD7_CODRDA'	):SetValue(cAlias->(BD7_CODRDA)	)
	oRDA:Cell('BD7_NOMRDA' 	):SetValue(cAlias->(BD7_NOMRDA)	)
	oRDA:Cell('BI3_NREDUZ' 	):SetValue(cAlias->(BI3_NREDUZ)	)
	oRDA:Cell('BD7_LOTBLO' 	):SetValue(cAlias->(BD7_LOTBLO)	)
	oRDA:Cell('BD7_VLRMAN' 	):SetValue(cAlias->(VLR_BASE)	)
	oRDA:Cell('BD7_VLRPAG' 	):SetValue(cAlias->(VLR_PAGAR)	)
	oRDA:Cell('BD7_VLRGLO' 	):SetValue(cAlias->(VLR_GLOSA)	)
	oRDA:Cell('BD7_VLRBLO' 	):SetValue(cAlias->(VLR_BLOQ)	)
    oRDA:Cell('BD7_MESPAG' 	):SetValue(cAlias->(BD7_MESPAG)	)
    oRDA:Cell('BD7_ANOPAG' 	):SetValue(cAlias->(BD7_ANOPAG)	)
	
	If lExcel
	     
		cBuffer += cAlias->(BD7_CODRDA)  																		+ cSepCsv
		cBuffer += cAlias->(BD7_NOMRDA)																			+ cSepCsv
		cBuffer += cAlias->(BI3_NREDUZ)																			+ cSepCsv
		cBuffer += cAlias->(BD7_LOTBLO)																			+ cSepCsv
		cBuffer += If(mv_par08 == 1,strTran(str(cAlias->(VLR_BASE))	,'.',','),str(cAlias->(VLR_BASE)))		+ cSepCsv
		cBuffer += If(mv_par08 == 1,strTran(str(cAlias->(VLR_GLOSA))	,'.',','),str(cAlias->(VLR_GLOSA)))	+ cSepCsv
		cBuffer += If(mv_par08 == 1,strTran(str(cAlias->(VLR_PAGAR))  	,'.',','),str(cAlias->(VLR_PAGAR)))		+ cSepCsv
		cBuffer += If(mv_par08 == 1,strTran(str(cAlias->(VLR_BLOQ))	,'.',','),str(cAlias->(VLR_BLOQ)))		+ cSepCsv
		cBuffer += cAlias->(BD7_MESPAG)																			+ cSepCsv
		cBuffer += cAlias->(BD7_ANOPAG)																			+ cSepCsv
		cBuffer += CRLF
	    
		FWrite(nHdl,cBuffer,len(cBuffer))
			
		cBuffer := ''
	
	EndIf
	
	oRDA:PrintLine()
 	
    cAlias->(dbSkip())

EndDo     

oRDA:Finish()

cAlias->(dbCloseArea())

If lExcel
     
	FClose(nHdl)

	ExecExcel(cArq,,'GRUPO CABERJ - Contas bloqueadas por RDA')

EndIf

Return   

********************************************************************************************************************************

Static Function FilTRep

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³BD7_LOTBLO preenchido -> bloqueado pela rotina de bloqueio             ³
//³                                                                       ³
//³BD7_BLOPAG = '1' -> Valor bloqueado = BD7_VLRPAG                       ³
//³BD7_BLOPAG <> '1' -> Valor bloqueado = BD7_VLRGLO - BD7_VGLANT         ³
//³(VALOR DA GLOSA - VALOR DA GLOSA ANTES DO BLOQUEIO)                    ³
//³                                                                       ³
//³Quando o valor a ser bloqueado eh igual a BD7_VLRPAG a rotina somente  ³
//³bloqueia. Quando o valor a ser bloqueado eh menor a BD7_VLRPAG a rotina³
//³grava o valor da glosa antes de alterar no campo BD7_VGLANT e depois   ³
//³glosa o valor.                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery += "SELECT BD7_CODRDA, BD7_NOMRDA, BI3_NREDUZ, BD7_LOTBLO, SUM(BD7_VLRMAN) VLR_BASE, SUM(CASE WHEN BD7_BLOPAG = '1' THEN 0 ELSE BD7_VLRPAG END) VLR_PAGAR,"	 			+ CRLF
cQuery += "		SUM(CASE WHEN BD7_BLOPAG = '1' THEN BD7_VLRGLO ELSE BD7_VGLANT END) VLR_GLOSA, SUM(CASE WHEN BD7_BLOPAG = '1' THEN BD7_VLRPAG ELSE (BD7_VLRGLO - BD7_VGLANT) END) VLR_BLOQ, BD7_MESPAG, BD7_ANOPAG"	+ CRLF
cQuery += "FROM " + RetSqlName('BD7') + " BD7"																										+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BI3') + " BI3 ON BI3.D_E_L_E_T_ = ' ' AND BI3_FILIAL = '" + xFilial("BI3") + "'AND BI3_CODIGO = BD7_CODPLA"	+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BAU') + " BAU ON BAU.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '" + xFilial('BAU') + "' AND BAU_CODIGO = BD7_CODRDA"	+ CRLF
cQuery += "WHERE BD7.D_E_L_E_T_ = ' '"																												+ CRLF
cQuery += "  AND BD7_FILIAL = '" + xFilial('BD7') + "'"																								+ CRLF
cQuery += "  AND BD7_LOTBLO <> ' ' "																												+ CRLF
cQuery += "  	AND BAU_GRPPAG IN ('0006','3001','3002','3003','3004','3005','3006')"								  															+ CRLF

//ATIVA
cQuery += "  AND BD7_SITUAC = '1'" 																													+ CRLF

//PRONTO
cQuery += "  AND BD7_FASE = '3'" 																													+ CRLF 

cQuery += "  AND BD7_CODRDA BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"																		+ CRLF
cQuery += "  AND BD7_ANOPAG||BD7_MESPAG BETWEEN '" + cValToChar(mv_par05) + strZero(mv_par03,2) + "' AND '" + cValToChar(mv_par06) + strZero(mv_par04,2) + "'" + CRLF

If(mv_par11 <> '*')
	cQuery += "  	AND BD7_LOTBLO IN " + FormatIn(allTrim(mv_par11),';')																						+ CRLF
Else
	
	//Seleciono os lotes de desbloqueio para nao ter que fazer uma subsconsulta linha a linha
	cQryTmp := "SELECT DISTINCT BD7_LOTBLO" 																										  		+ CRLF
	cQryTmp += "FROM " + RetSqlName('BD7') + " BD7" 																					   					+ CRLF
	cQryTmp += "INNER JOIN " + RetSqlName('BI3') + " BI3 ON BI3.D_E_L_E_T_ = ' ' AND BI3_FILIAL = '" + xFilial('BI3') + "'AND BI3_CODIGO = BD7_CODPLA" 	+ CRLF
	cQryTmp += "WHERE BD7.D_E_L_E_T_ = ' '" 																								 				+ CRLF
	cQryTmp += "    AND BD7_FILIAL = '" + xFilial('BD7') + "'" 															 						 			+ CRLF
	cQryTmp += "    AND BD7_LOTBLO <> ' ' " 																												+ CRLF
	cQryTmp += "    AND BD7_SITUAC = '1'" 																										   			+ CRLF
	cQryTmp += "    AND BD7_FASE = '3'" 																							   						+ CRLF
	cQryTmp += "    AND BD7_CODRDA BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"															   			+ CRLF
	cQryTmp += "  	AND BD7_LOTBLO <> ' '"			  																										+ CRLF
	                         
	cAliasTmp := GetNextAlias()
	
	TcQuery cQryTmp New Alias cAliasTmp
	
	cAliasTmp->(dbGoTop())
	
	cLotesBlo := ""
	
	cAliasTmp->(dbEval({||cLotesBlo += cAliasTmp->BD7_LOTBLO + ";"}))  
	
	cAliasTmp->(dbCloseArea())
	                      
	cLotesBlo := left(cLotesBlo,len(cLotesBlo) - 1) 

	cQuery += "  	AND BD7_LOTBLO IN " + FormatIn(allTrim(cLotesBlo),';')																						+ CRLF

EndIf

cQuery += "GROUP BY BD7_CODRDA, BD7_NOMRDA, BI3_NREDUZ, BD7_MESPAG, BD7_ANOPAG, BD7_LOTBLO"															+ CRLF
                                                                                                          
Do Case

	Case mv_par10 == 2 .or. mv_par10 == 3 //Subtotal por ano ou mes e ano
   
		If mv_par09 == 1 //Ordem por codigo RDA
			cQuery += "ORDER BY BD7_ANOPAG, BD7_MESPAG, BD7_CODRDA, BI3_NREDUZ, BD7_LOTBLO"															+ CRLF
		ElseIf mv_par09 == 2 //Ordem por nome RDA
			cQuery += "ORDER BY BD7_ANOPAG, BD7_MESPAG, BD7_NOMRDA, BI3_NREDUZ, BD7_LOTBLO"						 									+ CRLF
		EndIf
		
	Case mv_par10 == 4 //Subtotal por plano
		
		If mv_par09 == 1 //Ordem por codigo RDA
			cQuery += "ORDER BY BI3_NREDUZ, BD7_CODRDA, BD7_ANOPAG, BD7_MESPAG, BD7_LOTBLO"															+ CRLF
		ElseIf mv_par09 == 2 //Ordem por nome RDA
			cQuery += "ORDER BY BI3_NREDUZ, BD7_NOMRDA, BD7_ANOPAG, BD7_MESPAG, BD7_LOTBLO"						 									+ CRLF
		EndIf
		
	Otherwise 
		
		If mv_par09 == 1 //Ordem por codigo RDA
			cQuery += "ORDER BY BD7_CODRDA, BD7_ANOPAG, BD7_MESPAG, BI3_NREDUZ, BD7_LOTBLO"															+ CRLF
		ElseIf mv_par09 == 2 //Ordem por nome RDA
			cQuery += "ORDER BY BD7_NOMRDA, BD7_ANOPAG, BD7_MESPAG, BI3_NREDUZ, BD7_LOTBLO"						 									+ CRLF
		EndIf
				
EndCase
	
TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())

nCont := 0
cAlias->(dbEval({||++nCont}))

cAlias->(dbGoTop())

Return nCont

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Leonardo Portella                       ³±±
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
aAdd(aHelp, "Informe o RDA inicial")         
PutSX1(cPerg , "01" , "RDA de" 			,"","","mv_ch1","C",TamSx3("BAU_CODIGO")[1],0,0,"G",""	,"BAUNFE","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o RDA final")         
PutSX1(cPerg , "02" , "RDA ate" 		,"","","mv_ch2","C",TamSx3("BAU_CODIGO")[1],0,0,"G","","BAUNFE","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes de competencia")      
aAdd(aHelp, "inicial")  
aAdd(aHelp, "1  - Janeiro"						)      
aAdd(aHelp, "2  - Fevereiro"					)      
aAdd(aHelp, "3  - MarÃ§o"						)      
aAdd(aHelp, "4  - Abril"						)      
aAdd(aHelp, "5  - Maio"							)      
aAdd(aHelp, "6  - Junho"						)      
aAdd(aHelp, "7  - Julho"						)      
aAdd(aHelp, "8  - Agosto"						)      
aAdd(aHelp, "9  - Setembro"						)      
aAdd(aHelp, "10 - Outubro"						)      
aAdd(aHelp, "11 - Novembro"						)      
aAdd(aHelp, "12 - Dezembro"						)      
PutSX1(cPerg , "03" , "Mes Comp. de" 	,"","","mv_ch3","N",02						,0,0,"G","",""				,"","","mv_par03",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes de competencia")      
aAdd(aHelp, "final")  
aAdd(aHelp, "1  - Janeiro"						)      
aAdd(aHelp, "2  - Fevereiro"					)      
aAdd(aHelp, "3  - MarÃ§o"						)      
aAdd(aHelp, "4  - Abril"						)      
aAdd(aHelp, "5  - Maio"							)      
aAdd(aHelp, "6  - Junho"						)      
aAdd(aHelp, "7  - Julho"						)      
aAdd(aHelp, "8  - Agosto"						)      
aAdd(aHelp, "9  - Setembro"						)      
aAdd(aHelp, "10 - Outubro"						)      
aAdd(aHelp, "11 - Novembro"						)      
aAdd(aHelp, "12 - Dezembro"						)      
PutSX1(cPerg , "04" , "Mes Comp. ate" 	,"","","mv_ch4","N",02						,0,0,"G","",""			,"","","mv_par04",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano de competencia")      
aAdd(aHelp, "inicial com 4 digitos")      
PutSX1(cPerg,"05","Ano Comp. de"		,"","","mv_ch5","N",04						,0,0,"G","",""			,"","","mv_par05",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano de competencia")      
aAdd(aHelp, "final com 4 digitos")      
PutSX1(cPerg,"06","Ano Comp. ate"		,"","","mv_ch6","N",04						,0,0,"G","",""			,"","","mv_par06",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o se o relatorio devera")
aAdd(aHelp, "ser exportado para Excel"		)
PutSX1(cPerg,"07","Gera Excel"				,"","","mv_ch07","N",01					,0,1,"C","",""			,"","","mv_par07","Sim"	,"","","","Nao"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o separador do Excel"	)
aAdd(aHelp, "Utilizado somente caso a"		)
aAdd(aHelp, "opcao gera Excel esteja como"	)
aAdd(aHelp, "'Sim'"		)
PutSX1(cPerg,"08","Separador Excel"			,"","","mv_ch08","N",01					,0,1,"C","",""			,"","","mv_par08",";"	,"","","",","  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Ordena o relatorio por codigo"	)
aAdd(aHelp, "ou nome do RDA"				)
PutSX1(cPerg,"09","Ordem"					,"","","mv_ch09","N",01					,0,1,"C","",""			,"","","mv_par09","Codigo RDA"	,"","","","Nome RDA"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o critÃ©rio utilizado para")
aAdd(aHelp, "imprimir o subtotal."	)
PutSX1(cPerg,"10","Subtotal por"		,"","","mv_ch10","N",01					,0,1,"C","",""			,"","","mv_par10","RDA"	,"","","","Ano"  		,"","","Ano e mÃªs" 			,"","","Plano"				,"","","Nenhum","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe os lotes de bloqueios")
aAdd(aHelp, "Separe-os por ';'. Caso queira")
aAdd(aHelp, "selecionar todos , informe '*'")
PutSX1(cPerg,"11","Lotes Bloq"			,"","","mv_ch11","C",99					,0,1,"G","",""			,"","","mv_par11",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return   

******************************************************************************************************************************

