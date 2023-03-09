#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR081  ³ Autor ³ Leonardo Portella     ³ Data ³17/06/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Estatistica de digitacao. Somente a capa e somente         ³±±
±±³          ³ digitados (nao importados).                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR081

Local oReport 
Local cCodUsr		:= RetCodUsr()

//Usuarios autorizados conforme chamado ID 6625 (danielle, elisangelac, joana.barbosa, antonio.giordano, mariana.oliveira)
Local cUsrsAutor	:= GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN') + '|' + GetNewPar('MV_XRELDIG','000032|000376|000713|000633|000726')

Private cPerg		:= "CABR081"  

If cCodUsr $ cUsrsAutor

	oReport:= ReportDef()
	oReport:PrintDialog()
	
Else 
	MsgStop('Usuário [ ' + cCodUsr + ' - ' + AllTrim(UsrFullName(cCodUsr)) + ' ] sem autorizacao para acessar este relatório [ ' + ProcName() + ' ]',AllTrim(SM0->M0_NOMECOM))
EndIf

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

oReport	:= TReport():New("CABR081","Relatorio de digitacao","CABR081", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de digitacao de guias")

*'------------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'------------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Relatorio de digitacao")
oRDA:SetTotalInLine(.F.)                  

TRCell():New(oRDA ,'TIPOGUIA'	,,"Tipo Guia"  		,/*Picture*/  		,15	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'CODANA'		,,"Codigo"			,/*Picture*/  		,8	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'NOMANA'		,,"Nome analista"	,/*Picture*/   		,80	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA:SetTotalText("Total geral")   

If mv_par06 == 2//Sintetico
	TRCell():New(oRDA ,'QTD' 		,,"Quantidade"		,/*Picture*/	,20	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRFunction():New(oRDA:Cell("QTD")	,NIL,"SUM",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
Else
	TRCell():New(oRDA ,'DTHRA' 		,,"Data/Hora"		,/*Picture*/	,20	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRFunction():New(oRDA:Cell("TIPOGUIA")	,NIL,"COUNT",/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)
EndIf
	
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
Private cArq		:= ''
Private nCont		:= 0

If mv_par05 == 1//Analista  

	If mv_par06 == 2//Sintetico
		oBreak01 := TRBreak():New(oRDA,oRDA:Cell('NOMANA'),"Subtotal por analista",.F.) 
		TRFunction():New(oRDA:Cell('QTD') 		,NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999",{||cAlias->(QTD)}	   		,.F.,.F.)
	Else
		oBreak01 := TRBreak():New(oRDA,oRDA:Cell('NOMANA'),"Subtotal por analista",.F.) 
		TRFunction():New(oRDA:Cell('NOMANA')	,NIL,"COUNT",oBreak01,/*Titulo*/,"@E 999,999,999",{||cAlias->(NOMANA)}		,.F.,.F.)
	EndIf
	
ElseIf mv_par05 == 2//Tipo de Guia

	If mv_par06 == 2//Sintetico
		oBreak01 := TRBreak():New(oRDA,oRDA:Cell('TIPOGUIA'),"Subtotal por tipo de guia",.F.) 
		TRFunction():New(oRDA:Cell('QTD') 		,NIL,"SUM",oBreak01,/*Titulo*/,"@E 999,999,999",{||cAlias->(QTD)}			,.F.,.F.)
	Else
		oBreak01 := TRBreak():New(oRDA,oRDA:Cell('TIPOGUIA'),"Subtotal por tipo de guia",.F.) 
		TRFunction():New(oRDA:Cell('TIPOGUIA')	,NIL,"COUNT",oBreak01,/*Titulo*/,"@E 999,999,999",{||cAlias->(TIPOGUIA)}	,.F.,.F.)
	EndIf
	
EndIf

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
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:Cell('TIPOGUIA'	):SetValue(cAlias->(TIPOGUIA)	)
	oRDA:Cell('CODANA' 		):SetValue(cAlias->(CODANA)		)
	oRDA:Cell('NOMANA'	 	):SetValue(cAlias->(NOMANA)		)
	
	If mv_par06 == 2//Sintetico
		oRDA:Cell('QTD'  		):SetValue(cAlias->(QTD)		)
	Else
		oRDA:Cell('DTHRA'  		):SetValue(cAlias->(DTHRA)		)
	EndIf
	
	oRDA:PrintLine()
	
    cAlias->(dbSkip())

EndDo     

oRDA:Finish()

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtro do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par06 == 2//Sintetico
	cQuery += "SELECT CODANA,NOMANA,TIPOGUIA,COUNT(*) QTD FROM "																		+ CRLF
Else
	cQuery += "SELECT * FROM "	 																										+ CRLF
EndIf

cQuery += "("				 																											+ CRLF
cQuery += "SELECT DECODE(BD5_TIPGUI,'01','CONSULTA','02','SADT','-') TIPOGUIA,BD5_XANALI CODANA,BD5_XNOANA NOMANA,BD5_XDTHRA DTHRA" 	+ CRLF
cQuery += "FROM " + RetSqlName('BD5') + " BD5" 																							+ CRLF
cQuery += "WHERE BD5_XANALI BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'" 															+ CRLF

//TO_CHAR(TO_DATE(SUBSTR(BD5_XDTHRA,1,8),'DD/MM/YY'),'YYYYMMDD') estava dando erro no Oracle - Log da digitao criado em 2013
cQuery += "  AND ('20'||SUBSTR(BD5_XDTHRA,7,2)||SUBSTR(BD5_XDTHRA,4,2)||SUBSTR(BD5_XDTHRA,1,2)) BETWEEN '" + DtoS(mv_par03) + "' AND '" + DtoS(mv_par04) + "'"															+ CRLF

cQuery += "  AND D_E_L_E_T_ = ' '" 																										+ CRLF
cQuery += "UNION ALL" 																													+ CRLF
cQuery += "SELECT 'INTERNACAO' TIPOGUIA,BE4_XANALI CODANA,BE4_XNOANA NOMANA,BE4_XDTHRA DTHRA"											+ CRLF
cQuery += "FROM " + RetSqlName('BE4') + " BE4" 																							+ CRLF
cQuery += "WHERE BE4_XANALI BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"															+ CRLF

//TO_CHAR(TO_DATE(SUBSTR(BE4_XDTHRA,1,8),'DD/MM/YY'),'YYYYMMDD') estava dando erro no Oracle - Log da digitao criado em 2013
cQuery += "  AND ('20'||SUBSTR(BE4_XDTHRA,7,2)||SUBSTR(BE4_XDTHRA,4,2)||SUBSTR(BE4_XDTHRA,1,2)) BETWEEN '" + DtoS(mv_par03) + "' AND '" + DtoS(mv_par04) + "'"									+ CRLF

cQuery += "  AND D_E_L_E_T_ = ' '" 																										+ CRLF
cQuery += ")"				 																											+ CRLF

If mv_par06 == 2//Sintetico
	cQuery += "GROUP BY CODANA,NOMANA,TIPOGUIA"																							+ CRLF

	If mv_par05 == 1//Analista
		cQuery += "ORDER BY NOMANA,TIPOGUIA"																							+ CRLF
	ElseIf mv_par05 == 2//Tipo de Guia
		cQuery += "ORDER BY TIPOGUIA,NOMANA"																							+ CRLF
	EndIf 
	
ElseIf mv_par05 == 1//Analista
	cQuery += "ORDER BY NOMANA,TIPOGUIA,DTHRA"																							+ CRLF
ElseIf mv_par05 == 2//Tipo de Guia
	cQuery += "ORDER BY TIPOGUIA,NOMANA,DTHRA"																							+ CRLF
EndIf

TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())              

nCont := 0

COUNT TO nCont

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
aAdd(aHelp, "Informe o analista inicial")
PutSX1(cPerg , "01" , "Analista de" 		,"","","mv_ch1","C",6,0,0,"G","","LOGINU","",""	,"mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o analista final")
PutSX1(cPerg , "02" , "Analista ate" 		,"","","mv_ch2","C",6,0,0,"G","","LOGINU","",""	,"mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data inicial")
PutSX1(cPerg , "03" , "Data de" 	   		,"","","mv_ch3","D",8,0,0,"G","","","",""			,"mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data final")
PutSX1(cPerg , "04" , "Data ate" 	   		,"","","mv_ch4","D",8,0,0,"G","","","",""			,"mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a ordem do relatório"	)
PutSX1(cPerg,"05","Ordem"					,"","","mv_ch05","N",01,0,1,"C","","","",""		,"mv_par05","Analista"	,"","","","Tipo Guia","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe se o relatório será "	)
aAdd(aHelp, "analítico ou sintético"		)
PutSX1(cPerg,"06","Tipo"					,"","","mv_ch06","N",01,0,1,"C","","","",""		,"mv_par06","Analítico"	,"","","","Sintético","","","","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************