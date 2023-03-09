#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função	 ³ CABI020	³ Autor ³ Angelo Henrique         DATA ³ 29/04/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Rotina utilizada para trazer a numeração de FATURA.	 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ CABERJ                		 							  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI020()

	Local _aArea	:= GetArea()
	Local _cAlias	:= GetNextAlias()
	Local cQry		:= ""
	Local _cRet		:= ""

	cQry := " SELECT 									" + CRLF
	cQry += " 	MAX(E1_NUM) + 1 SEQ						" + CRLF
	cQry += " FROM 										" + CRLF
	cQry += "	" + RetSqlName('SE1') + " SE1			" + CRLF
	cQry += " WHERE    									" + CRLF
	cQry += "	SE1.E1_FILIAL = '" + xFilial("SE1") + "'" + CRLF
	cQry += "	AND SE1.E1_PREFIXO  = 'FAT'				" + CRLF	
	
	If Select("_cAlias") > 0
		_cAlias->(DbCloseArea())
	EndIf

	TcQuery cQry New Alias _cAlias

	If !_cAlias->(EOF())
			
		_cRet := STRZERO(_cAlias->SEQ, TAMSX3("E1_NUM")[1]) 
			
	EndIf

	If Select("_cAlias") > 0
		_cAlias->(DbCloseArea())
	EndIf

	RestArea(_aArea)

Return _cRet