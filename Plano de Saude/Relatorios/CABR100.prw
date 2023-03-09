#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR100  ³ Autor ³ Leonardo Portella     ³ Data ³06/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de contas de RDA (prestador) bloqueadas por      ³±±
±±³          ³ convenio ou credenciadas.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR100

Local oReport 
Private cPerg	:= "CABR100"  

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

oReport	:= TReport():New("CABR100","Contas bloqueadas por RDA","CABR100", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de contas bloqueadas por RDA")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //EspaÃ§amento entre colunas. 
//oReport:SetLandscape() //ImpressÃ£o em paisagem.  
oReport:SetPortrait() //ImpressÃ£o em retrato.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Contas bloqueadas por RDA")
oRDA:SetTotalInLine(.F.) 

TRCell():New(oRDA ,'B37_CODRDA'	,'B37'	,/*Titulo*/					,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'B37_NOMRDA'	,'B37'	,/*Titulo*/					,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'B36_DTPROC'	,'B36'	,/*Titulo*/					,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'B37_VLRPAG'	,'B37'	,'Valor pagto no bloq.'		,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'B37_SALPAG'	,'B37'	,'Saldo pagto no bloq.'		,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'B37_VLRBLO'	,'B37'	,/*Titulo*/					,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'TIPO'		,		,'Tipo'						,/*Picture*/	,12				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA:SetTotalText("Total geral")

TRFunction():New(oRDA:Cell("B37_VLRPAG")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell("B37_SALPAG")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
TRFunction():New(oRDA:Cell("B37_VLRBLO")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)

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

Private oRDA   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private cSepCsv		:= If(mv_par06 == 1,';',',')
Private lExcel		:= mv_par05 == 1
Private cPathCsv 	:= GetTempPath()
Private cBuffer		:= ''
Private cArq		:= ''
Private nCont		:= 0

If lExcel 

	cArq	:= cPathCsv + "CABR100_" + DtoS(dDatabase) + "_" + StrTran(Time(),":","")+".CSV"
	nHdl 	:= FCreate(cArq) 

	cBuffer += RetTitle("B37_CODRDA") 	+ cSepCsv
	cBuffer += RetTitle("B37_NOMRDA")	+ cSepCsv
	cBuffer += RetTitle("B36_DTPROC")	+ cSepCsv
	cBuffer += 'Valor pagto no bloq.'	+ cSepCsv
	cBuffer += 'Saldo pagto no bloq.'	+ cSepCsv
	cBuffer += RetTitle("B37_VLRBLO")	+ cSepCsv
	cBuffer += 'Tipo'					+ cSepCsv
	cBuffer += CRLF                                    

EndIf    

If mv_par04 == 1 .or. mv_par04 == 3
	                 
	// Quebra por RDA
	oBreak01 := TRBreak():New(oRDA,oRDA:Cell("B37_CODRDA"),"Subtotal por RDA",.F.) 
	
	TRFunction():New(oRDA:Cell("B37_VLRPAG"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRPAG)}		,.F.,.F.)
	TRFunction():New(oRDA:Cell("B37_SALPAG"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRPAG)}		,.F.,.F.)
	TRFunction():New(oRDA:Cell("B37_VLRBLO"),NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRBLO)}		,.F.,.F.)
	
EndIf

If mv_par04 == 2 .or. mv_par04 == 3
		
	// Quebra por tipo
	oBreak02 := TRBreak():New(oRDA,oRDA:Cell("TIPO"),"Subtotal por Tipo",.F.) 
	
	TRFunction():New(oRDA:Cell("B37_VLRPAG"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRPAG)}		,.F.,.F.)
	TRFunction():New(oRDA:Cell("B37_SALPAG"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRPAG)}		,.F.,.F.)
	TRFunction():New(oRDA:Cell("B37_VLRBLO"),NIL,"SUM",oBreak02,/*Titulo*/,"@E 999,999,999.99",{||cAlias->(B37_VLRBLO)}		,.F.,.F.)
	
EndIf

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
	    
	    If lExcel
	    	cBuffer := CRLF + CRLF + 'Cancelado pelo operador!!!' + CRLF
	    	FWrite(nHdl,cBuffer,len(cBuffer))
		EndIf
		
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()

	oRDA:Cell('B37_CODRDA'	):SetValue(cAlias->(B37_CODRDA)					)
	oRDA:Cell('B37_NOMRDA' 	):SetValue(cAlias->(B37_NOMRDA)					)
	oRDA:Cell('B36_DTPROC' 	):SetValue(DtoC(StoD(cAlias->(B36_DTPROC)))	)
	oRDA:Cell('B37_VLRPAG' 	):SetValue(cAlias->(B37_VLRPAG)					)
	oRDA:Cell('B37_SALPAG' 	):SetValue(cAlias->(B37_SALPAG)					)
	oRDA:Cell('B37_VLRBLO' 	):SetValue(cAlias->(B37_VLRBLO)					)
	oRDA:Cell('TIPO' 		):SetValue(cAlias->(TIPO)						)
	
	If lExcel
	     
		cBuffer += cAlias->(B37_CODRDA)  																		+ cSepCsv
		cBuffer += cAlias->(B37_NOMRDA)																			+ cSepCsv
		cBuffer += DtoC(StoD(cAlias->(B36_DTPROC)))															+ cSepCsv
		cBuffer += If(mv_par06 == 1,strTran(str(cAlias->(B37_VLRPAG))	,'.',','),str(cAlias->(B37_VLRPAG)))	+ cSepCsv
		cBuffer += If(mv_par06 == 1,strTran(str(cAlias->(B37_SALPAG))	,'.',','),str(cAlias->(B37_SALPAG)))	+ cSepCsv
		cBuffer += If(mv_par06 == 1,strTran(str(cAlias->(B37_VLRBLO)) 	,'.',','),str(cAlias->(B37_VLRBLO)))	+ cSepCsv
		cBuffer += cAlias->(TIPO) 																				+ cSepCsv
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

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

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
    
ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next

cQuery := "SELECT 	B37_CODRDA, B37_NOMRDA, B37_VLRPAG, B37_SALPAG, B37_VLRBLO, B36_DTPROC,"									 					+ CRLF
cQuery += "			CASE WHEN BAU_GRPPAG BETWEEN '3001' AND '3004' THEN 'CREDENCIADO' ELSE CASE WHEN BAU_GRPPAG = '0006' THEN 'PGTO PRESTADOR NEGOCIADO' ELSE 'CONVENIO' END  END AS TIPO"									+ CRLF
cQuery += "FROM " + RetSqlName('B37') + " B37"																										+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BAU') + " BAU ON BAU.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '" + xFilial('BAU') + "' AND BAU_CODIGO = B37_CODRDA"	+ CRLF
cQuery += "INNER JOIN " + RetSqlName('B36') + " B36 ON B36.D_E_L_E_T_ = ' ' AND B36_FILIAL = '" + xFilial('B36') + "' AND B36_CODOPE = B37_CODOPE"	+ CRLF 
cQuery += "		AND B36_NUMLOT = B37_NUMLOT"																										+ CRLF 
cQuery += "WHERE B37.D_E_L_E_T_ = ' '"																			 									+ CRLF
cQuery += "  	AND B37_FILIAL = '" + xFilial('B37') + "'"																							+ CRLF
cQuery += "  	AND B37_CODRDA BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"	 
If mv_par08 = 1																
   cQuery += "  	AND BAU_GRPPAG IN ('0006','3001','3002','3003','3004','3005','3006')"								  															+ CRLF
EndIf
//NAO POSSO CONSIDERAR O LOTE DE DESBLOQUEIO (B37_LOTDES = ' ') POIS ESTE EH PREENCHIDO NA BD7 APOS A INCLUSAO DO LOTE DE DESBLOQUEIO E 
//ANTES DO PROCESSAMENTO DESTE. ENTAO VERIFICO SE EXISTE NA BD7 ALGUM LOTE DE BLOQUEIO IGUAL AO LOTE NA B37.

If(mv_par07 <> '*')
	cQuery += "  	AND B37_NUMLOT IN " + FormatIn(allTrim(mv_par07)	,';')																						+ CRLF
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
	
	cQuery += "  	AND B37_NUMLOT IN " + FormatIn(allTrim(cLotesBlo)	,';')																						+ CRLF
	
EndIf

If mv_par03 == 1 //Ordem por codigo RDA
	cQuery += "ORDER BY TIPO, B37_CODRDA, B37_NOMRDA" 				 																				+ CRLF
Else //Ordem por nome RDA
	cQuery += "ORDER BY TIPO, B37_NOMRDA, B37_CODRDA"								 							 									+ CRLF
EndIf		
	
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
aAdd(aHelp, "Ordena o relatorio por codigo"	)
aAdd(aHelp, "ou nome do RDA"				)
PutSX1(cPerg,"03","Ordem"				,"","","mv_ch03","N",01					,0,1,"C","",""			,"","","mv_par03","Codigo RDA"	,"","","","Nome RDA"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o critÃ©rio utilizado para")
aAdd(aHelp, "imprimir o subtotal."	)
PutSX1(cPerg,"04","Subtotal por"		,"","","mv_ch04","N",01					,0,1,"C","",""			,"","","mv_par04","RDA"	,"","","","Tipo"  		,"","","RDA e tipo" 			,"","","Nenhum"				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o se o relatorio devera")
aAdd(aHelp, "ser exportado para Excel"		)
PutSX1(cPerg,"05","Gera Excel"			,"","","mv_ch05","N",01					,0,1,"C","",""			,"","","mv_par05","Sim"	,"","","","Nao"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o separador do Excel"	)
aAdd(aHelp, "Utilizado somente caso a"		)
aAdd(aHelp, "opcao gera Excel esteja como"	)
aAdd(aHelp, "'Sim'"		)
PutSX1(cPerg,"06","Separador Excel"		,"","","mv_ch06","N",01					,0,1,"C","",""			,"","","mv_par06",";"	,"","","",","  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe os lotes de bloqueios")
aAdd(aHelp, "Separe-os por ';'. Caso queira")
aAdd(aHelp, "selecionar todos , informe '*'")
PutSX1(cPerg,"07","Lotes Bloq"			,"","","mv_ch07","C",99					,0,1,"G","",""			,"","","mv_par07",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)
 
aHelp := {}
aAdd(aHelp, "Considera os grupos de pagamento ")
aAdd(aHelp, "0006,3001,3002,3003,3004,3005,3006")
aAdd(aHelp, "Se SIM so estes grupos sera listados ")
PutSX1(cPerg,"08","Considera Grupo de Pagamento"			,"","","mv_ch08","N",01					,0,1,"C","",""			,"","","mv_par08","Sim"	,"","","","Nao"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************

