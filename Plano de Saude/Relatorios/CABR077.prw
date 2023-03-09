#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR077  ³ Autor ³ Fabio Bianchini      ³ Data ³ 06/02/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Previa e Comprovante de entrega de remessa.   |±±
±±³          ³ Conforme solicitado por Dr. Giordano - chamado             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR077

Local oReport 
Private cPerg		:= "CABR077"  
Private aOrdem 		:= {'RDA','Ano/Mes'}

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
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oRemessa     

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

oReport	:= TReport():New("CABR077","Previa do comprovante de remessa","CABR077", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Previa do comprovante de remessa")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oRemessa := TRSection():New(oReport,"Previa comprovante de remessa",,aOrdem)

TRCell():New(oRemessa ,'GRPPAG'		 		,'BAU'	,'Grp.Pg.'				,/*Picture*/ 				,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_DATDIG'			,		,'Dat.Dig.'				,/*Picture*/ 				,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'COMPETENCIA'		,		,'Compet.'				,/*Picture*/   				,10			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_NOMRDA'			,  		, 						,/*Picture*/				,30			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DESC_LOCAL'			,		,'Descr. Local'			,/*Picture*/ 				,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_NUMREM'			,'ZZP'	, 						,/*Picture*/  				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_QTINAM'			,'ZZP'	,'Qtd Amb.' 			,/*Picture*/ 				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_VLINAM'			,'ZZP'	,'Vlr Amb.'				,/*Picture*/ 				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_QTINHO'			,'ZZP'	,'Qtd Hosp.'			,/*Picture*/ 				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_VLINHO'			,'ZZP'	,'Vlr Hosp.'			,/*Picture*/ 				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_QTINOD'			,'ZZP'	,'Qtd Odont.'			,/*Picture*/				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ZZP_VLINOD'			,'ZZP'	,'Vlr Odont.' 			,/*Picture*/  				,/*Tamanho*/  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'AMB_ODONT_HOSP'		,'ZZP'	,'Tot. Amb/Odont/Hosp'	,"@E 999,999,999,999.99"	,20			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'USUARIO'			,		,'USUARIO' 				,/*Picture*/				,25			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oBreak01 		:= TRBreak():New(oRemessa,oRemessa:Cell("GRPPAG"),"Subtotal por GRUPO PAGTO" 	,.F.) 

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
	
TRFunction():New(oRemessa:Cell("AMB_ODONT_HOSP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_QTINAM") 	 		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_VLINAM")  			,NIL,"SUM"	   		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_QTINHO")	  		,NIL,"SUM"	  		,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_VLINHO") 	 		,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_QTINOD")  			,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ZZP_VLINOD")  			,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oRemessa:Cell("ZZP_NUMREM")  			,NIL,"COUNT"		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

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

Private oRemessa 	:= oReport:Section(1)
Private cAliasCart 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0

//Executa query que alimenta o alias cAliasCart 
Processa({||nCont := FilTRep()},AllTrim(SM0->M0_NOMECOM))

//Se nao tiver esta linha, nao imprime os dados
oRemessa:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( cAliasCart->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()
    
	oRemessa:Cell('GRPPAG' 	   		):SetValue(cAliasCart->(GRPPAG))
	oRemessa:Cell('ZZP_DATDIG' 		):SetValue(StoD(cAliasCart->(ZZP_DATDIG)))
	oRemessa:Cell('COMPETENCIA'		):SetValue(cAliasCart->(ZZP_MESPAG) + '/' + cAliasCart->(ZZP_ANOPAG))
	oRemessa:Cell('ZZP_NOMRDA'		):SetValue(cAliasCart->(ZZP_CODRDA) +'-'+ cAliasCart->(ZZP_NOMRDA))
	oRemessa:Cell('DESC_LOCAL'		):SetValue(Left(cAliasCart->(CTT_DESC01),20))
	oRemessa:Cell('ZZP_NUMREM'		):SetValue(cAliasCart->(ZZP_NUMREM))
	oRemessa:Cell('ZZP_QTINAM'		):SetValue(cAliasCart->(ZZP_QTINAM))
	oRemessa:Cell('ZZP_VLINAM'		):SetValue(cAliasCart->(ZZP_VLINAM))
	oRemessa:Cell('ZZP_QTINHO'		):SetValue(cAliasCart->(ZZP_QTINHO))
	oRemessa:Cell('ZZP_VLINHO'		):SetValue(cAliasCart->(ZZP_VLINHO))
	oRemessa:Cell('ZZP_QTINOD' 		):SetValue(cAliasCart->(ZZP_QTINOD))
	oRemessa:Cell('ZZP_VLINOD'		):SetValue(cAliasCart->(ZZP_VLINOD))
	oRemessa:Cell('AMB_ODONT_HOSP'	):SetValue(cAliasCart->(AMB_ODONT_HOSP))
	oRemessa:Cell('USUARIO'			):SetValue(cAliasCart->(ZZP_CODANA) +'-'+ usrretname(cAliasCart->(ZZP_CODANA)))
	
    
	oRemessa:PrintLine()
		
    cAliasCart->(DbSkip())
    
EndDo

oRemessa:Finish()

cAliasCart->(DbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros a serem analisados...')
Next
	   
if cEmpAnt == '01'
	cQuery := "SELECT TRIM(BAU_GRPPAG)||'-'||RETORNA_GRUPO_PGTO_RDA('C',TRIM(BAU_GRPPAG)) GRPPAG, "	   			+ CRLF
else
	cQuery := "SELECT TRIM(BAU_GRPPAG)||'-'||RETORNA_GRUPO_PGTO_RDA('I',TRIM(BAU_GRPPAG)) GRPPAG, "	   			+ CRLF
Endif
cQuery += "   ZZP_DATDIG,ZZP_MESPAG,ZZP_ANOPAG, ZZP_YLOCAL,ZZP_NUMREM,ZZP_CODRDA,ZZP_NOMRDA, ZZP_QTINAM, "	    + CRLF		
cQuery += "   ZZP_VLINAM,ZZP_QTINHO,ZZP_VLINHO,ZZP_QTINOD,ZZP_VLINOD, "				   			   				+ CRLF
cQuery += "   NVL(CTT_DESC01,'-') CTT_DESC01,(ZZP_VLINAM + ZZP_VLINHO + ZZP_VLINOD) AMB_ODONT_HOSP, "			+ CRLF
cQuery += "   ZZP_CODANA " 																						+ CRLF
cQuery += "FROM " + RetSqlName('ZZP') + " ZZP" 																												+ CRLF
cQuery += "LEFT JOIN " + RetSqlName('CTT') + " CTT ON CTT.D_E_L_E_T_ = ' ' " 																				+ CRLF
cQuery += "   AND CTT_FILIAL = '" + xFilial('CTT') + "'" 																									+ CRLF
cQuery += "   AND CTT_CUSTO = ZZP_YLOCAL" 																													+ CRLF
cQuery += "LEFT JOIN " + RetSqlName('BAU') + " BAU ON BAU.D_E_L_E_T_ = ' ' " 																				+ CRLF
cQuery += "   AND BAU_FILIAL = '" + xFilial('BAU') + "'" 																									+ CRLF
cQuery += "   AND BAU_DATBLO = ' '     " 																													+ CRLF
cQuery += "   AND BAU_CODIGO = ZZP_CODRDA     " 																											+ CRLF
cQuery += "WHERE ZZP.D_E_L_E_T_ = ' '" 																														+ CRLF
cQuery += "   AND ZZP_FILIAL = '" + xFilial('ZZP') + "'" 																									+ CRLF

If !empty(mv_par02)
	cQuery += "   AND ZZP_DATDIG BETWEEN '" + DtoS(mv_par01) + "' AND '" +  DtoS(mv_par02) + "'" 															+ CRLF
EndIF

If !empty(mv_par05) .and. !empty(mv_par06)
	cQuery += "   AND ZZP_ANOPAG||ZZP_MESPAG BETWEEN '" + PadL(mv_par04,4,'0') + PadL(mv_par03,2,'0') + "' AND '" +  PadL(mv_par06,4,'0') + PadL(mv_par05,2,'0') + "'" + CRLF
EndIf             

if !empty(mv_par07)
	cQuery += "   AND ZZP_YLOCAL = '" + trim(mv_par07) + "'" 																								+ CRLF
endif

if !empty(mv_par08)
	cQuery += "   AND BAU_GRPPAG = '" + trim(mv_par08) + "'" 																								+ CRLF
endif

cQuery += "ORDER BY NVL(TRIM(BAU_GRPPAG),'SEM GRP.PGTO.') "

Do Case

	Case oRemessa:nOrder == 1
		cQuery += ",ZZP_CODRDA"
		
	Case oRemessa:nOrder == 2    
		cQuery += ",ZZP_ANOPAG,ZZP_MESPAG"
	
EndCase

TcQuery cQuery New Alias cAliasCart

cAliasCart->(DbGoTop())

nCont := 0

COUNT TO nCont

cAliasCart->(DbGoTop())

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
aAdd(aHelp, "Informe a data de digitacao inicial")
PutSX1(cPerg , "01" , "Digitacao De" 	,"","","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de digitacao final")
PutSX1(cPerg , "02" , "Digitacao Ate" 	,"","","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes da competencia inicial")
PutSX1(cPerg , "03" , "Mes Comp. De" 	,"","","mv_ch3","C",2,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano da competencia inicial")
PutSX1(cPerg , "04" , "Ano Comp. De" 	,"","","mv_ch4","C",4,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes da competencia final")
PutSX1(cPerg , "05" , "Mes Comp. Ate" 	,"","","mv_ch5","C",2,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano da competencia final")
PutSX1(cPerg , "06" , "Ano Comp. Ate" 	    ,"","","mv_ch6","C",4,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Local da Digitasção")
PutSX1(cPerg , "07" , "Local da Digitasção"	,"","","mv_ch7","C",4,0,0,"C","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Grupo de Pagamento")
PutSX1(cPerg , "08" , "Grupo de Pagamento" 	,"","","mv_ch8","C",4,0,0,"C","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return
