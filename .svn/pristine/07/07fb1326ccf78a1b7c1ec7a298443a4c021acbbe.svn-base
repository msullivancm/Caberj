#Include "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F280CAN   ºAutor  ³Microsiga           º Data ³  01/22/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para cancelar os valores referente a fatura±±
±±º          ³ nas tabelas do modulo PLS.                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//***********************
User Function F280PCAN()
//***********************
	Local aArea := GetArea()
	Local aAreaBBT := BBT->(GetArea())
	Local cQry  := " "
	Local cAliasFat := GetNextAlias()
	
	DbSelectArea("BBT")
	dbSetOrder(7)
	If DbSeek(xFilial("BBT")+cPrefCan+cFatCan)
		If Alltrim(cTipoCan) == "FT"
			RecLock("BBT",.F.)
				BBT->(DbDelete())
			BBT->(msunlock())
		Endif
	Endif
	
	//|------------------------------------------------|
	//|SELECAO DOS TITULOS QUE ORIGINARAM AS  FATURAS  |
	//|------------------------------------------------|
	cQry := " SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_NUM,E1_TIPO,R_E_C_N_O_ RECNOSE1"
	cQry += " FROM " + RetSqlName("SE1")
	cQry += " WHERE D_E_L_E_T_ = ' ' "
	cQry += " AND E1_FILIAL     = '" + xFilial("SE1") + "'"
	cQry += " AND E1_FATPREF    = '" + cPrefCan + "'"
	cQry += " AND E1_FATURA     = '" + cFatCan  + "'"
	
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), cAliasFat, .F., .T.)
	
	While (cAliasFat)->(!eof())
		
		cChave := (cAliasFat)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
		cQuery := " UPDATE "+RetSqlName("BSQ")+" BSQ SET BSQ.D_E_L_E_T_ = '*' WHERE TRIM(BSQ_YNMSE1) = '" + TRIM(cChave) + "'"
		
		If TcSqlExec(cQuery) < 0
			lRet := .F.
		ENDIF
		
		(cAliasFat)->(DbSkip())
		
	Enddo
	
	if select((cAliasFat)) > 0
		dbselectarea(cAliasFat)
		(cAliasFat)->(dbclosearea())
	endif
	
	RestArea(aAreaBBT)
	RestArea(aArea)
	
Return .T.