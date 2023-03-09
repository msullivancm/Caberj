#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MEDIAIM   ºAutor  ³Leonardo Portella   º Data ³  21/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Media de tempo da importacao. Estimativa calculada atraves  º±±
±±º          ³do log gravado na tabela customizada PBB.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MEDIAIM

Local cQuery 	:= ""
Local cAlias	:= GetNextAlias()
Local aMedia	:= {}
Local cMsg 		:= ''
Local cMedias   := ''

Private cPerg	:= "MEDIAIM"  

AjustaSx1()

If !Pergunte(cPerg,.T.)
	Return
EndIf

cQuery += "SELECT TRIM(PBB_TAGLOG) PBB_TAGLOG,TRIM(PBB_DESLOG) PBB_DESLOG,SUBSTR(PBB_DATHOR,1,8) DIA_LOG" 					+ CRLF
cQuery += "FROM " + RetSqlName('PBB')																						+ CRLF
cQuery += "WHERE D_E_L_E_T_ = '  '" 																  						+ CRLF
cQuery += "	AND PBB_FILIAL = '" + xFilial('PBB') + "'"	 																	+ CRLF
cQuery += "	AND PBB_TAGLOG = 'AMBIENTE IMPORTACAO'"																			+ CRLF
cQuery += "	AND ( PBB_DATHOR LIKE '" + DtoS(mv_par01) + "%' OR PBB_DATHOR LIKE '" + DtoS(mv_par02) + "%' )"				+ CRLF
cQuery += "GROUP BY SUBSTR(PBB_DATHOR,1,8),PBB_TAGLOG,PBB_DESLOG" 					 										+ CRLF
cQuery += "ORDER BY PBB_DESLOG,DIA_LOG" 												   									+ CRLF

TcQuery cQuery New Alias cAlias

While !cAlias->(EOF())
    aMedia 	:= MediaAmb(AllTrim(cAlias->(PBB_DESLOG)),cAlias->(DIA_LOG))
	cMedias += aMedia[1]
	cMsg 	+= aMedia[2]
	
	cAlias->(DbSkip())
EndDo

cAlias->(DbCloseArea())

cMsg := cMedias + Replicate('-',30) + CRLF + cMsg

LogErros(cMsg,'Tempo importacao',,'M')

Return      

*************************************************************************************************************

Static Function MediaAmb(cAmb,cDiaLog)

Local aRet 		:= ''
Local cQuery1 	:= ""
Local cAlias1	:= GetNextAlias()
Local nQtd1		:= 0
Local nMedia1	:= 0
Local cAnt1		:= ""
Local nTot1		:= 0
Local cMsg1		:= ""
Local cMedia1	:= ""

cQuery1 += "SELECT PBB_DATHOR,SUBSTR(PBB_DATHOR,9,2)||':'||SUBSTR(PBB_DATHOR,11,2)||':'||SUBSTR(PBB_DATHOR,13,2) HORA_LOG,PBB_XML" 	+ CRLF
cQuery1 += "FROM " + RetSqlName('PBB')																					 			+ CRLF
cQuery1 += "WHERE D_E_L_E_T_ = '  '" 																	  	   						+ CRLF
cQuery1 += "	AND PBB_FILIAL = '" + xFilial('PBB') + "'"																			+ CRLF
cQuery1 += "	AND PBB_DATHOR LIKE '" + cDiaLog + "%'"				 		 														+ CRLF
cQuery1 += "	AND PBB_TAGLOG = 'AMBIENTE IMPORTACAO'"																				+ CRLF
cQuery1 += "	AND PBB_DESLOG = '" + cAmb + "'"					 	 															+ CRLF
cQuery1 += "GROUP BY PBB_DATHOR,PBB_TAGLOG,PBB_DESLOG,PBB_XML"							 											+ CRLF
cQuery1 += "ORDER BY PBB_DESLOG,PBB_DATHOR,PBB_XML"											   										+ CRLF

TcQuery cQuery1 New Alias cAlias1

cXMLAnt := ""
lInicio := .T.
    
While !cAlias1->(EOF())

	If lInicio
		cAnt1 	:= cAlias1->(HORA_LOG)
		lInicio := .F.	
	EndIf
	    
	If cXMLAnt <> cAlias1->(PBB_XML)
		cXMLAnt := cAlias1->(PBB_XML)
		cMsg1 += CRLF + '[' + cAmb + '] ' + cAlias1->(PBB_DATHOR) + ' : - [ ' + AllTrim(cAlias1->(PBB_XML)) + ' ]' + CRLF
		cAlias1->(DbSkip())
		loop
	EndIf
	
	cTempoGasto := ElapTime(cAnt1, cAlias1->(HORA_LOG))
	cMsg1 += '[' + cAmb + '] ' + cAlias1->(PBB_DATHOR) + ' : ' + cTempoGasto + ' [ ' + AllTrim(cAlias1->(PBB_XML)) + ' ]' + CRLF
    cAnt1 := cAlias1->(HORA_LOG)
    nQtd1++
    nTot1 += Val(Substr(cTempoGasto,1,2)) * 60 * 60 + Val(Substr(cTempoGasto,4,2)) * 60 + Val(Substr(cTempoGasto,7,2))
	
	cAlias1->(DbSkip())
EndDo

If nQtd1 > 0
	cMsg1 	+= CRLF
	nMedia1 := NoRound(nTot1 / nQtd1, 0)
	nHoras 	:= NoRound(nMedia1 / (60*60),0)
	nMin	:= NoRound((nMedia1 - ( nHoras * 60 * 60 )) / 60,0)
	nSeg	:= nMedia1 - ( nHoras * 60 * 60 ) - ( nMin * 60 )
	cMedia1 := 'MÉDIA [' + cAmb + '] [' + DtoC(StoD(cDiaLog)) + ']: ' + StrZero(nHoras,2) + ':' + StrZero(nMin,2) + ':' + StrZero(nSeg,2) + CRLF
EndIf

cAlias1->(DbCloseArea())

aRet := {cMedia1,cMsg1}

Return aRet

*************************************************************************************************************

Static Function AjustaSx1

aHelp := {}
aAdd(aHelp, "Informe a primeira data a comparar")
PutSX1(cPerg,"01","Dt Comp 01"	,"","","mv_ch01","D",8,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a segunda data a comparar")
PutSX1(cPerg,"02","Dt Comp 02"	,"","","mv_ch02","D",8,0,1,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return
