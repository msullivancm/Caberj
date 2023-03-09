#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABG012  ºAutor  ³Fabio Bianchini     º Data ³  14/12/2018 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho criado para preencher o campo CBOS do Calculo de    º±±
±±º          ³Reembolso (B44_XCBOS), acordo com a regra de preenchimento  º±±
±±º          ³do protocolo							                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABG012(cGUIINT)

Local cQuery    := ""
Local cAliasBE4 := GetNextAlias() 
Local lRet 		:= .T.

	cQuery := "	SELECT BE4_CODOPE||BE4_ANOINT||BE4_MESINT||BE4_NUMINT GUIINT  "+CRLF
	cQuery += "	  FROM "+retSqlName("BE4")+" BE4        "+CRLF
	cQuery += "	 WHERE  								"+CRLF
	cQuery += "   BE4.BE4_FILIAL = '"+ xFilial("BE4")   + "' AND			"+CRLF
	cQuery += "   BE4.BE4_CODOPE = '"+PLSINTPAD()       + "' AND			"+CRLF
	cQuery += "   BE4.BE4_ANOINT = '"+SUBS(cGUIINT,5,4) + "' AND            "+CRLF
	cQuery += "   BE4.BE4_MESINT = '"+SUBS(cGUIINT,9,2) + "' AND            "+CRLF
	cQuery += "	  BE4.BE4_NUMINT = '"+SUBS(cGUIINT,11,8) + "' AND            "+CRLF
	cQuery += "	  BE4.D_E_L_E_T_ = ' ' 				   "+ CRLF

	if select(cAliasBE4) > 0
		(cAliasBE4)->(dbclosearea())
		cAliasBE4 := GetNextAlias()
	endif					

	PlsQuery(cQuery,cAliasBE4)
	
	If select(cAliasBE4) > 0
		M->BE4_GUIINT := (cAliasBE4)->(GUIINT)
		(cAliasBE4)->(dbclosearea())
	Endif

Return lRet