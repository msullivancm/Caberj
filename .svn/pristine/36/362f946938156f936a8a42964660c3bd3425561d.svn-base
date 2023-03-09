/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P720GRVG  ºAutor  ³ Jean Schulz        º Data ³  06/05/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para gravacao do tipo de participacao      º±±
±±º          ³conforme regra do cliente.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function P720GRVG   
Local cChave := Substr(Alltrim(paramixb[1]),1,25)
Local aAreaBD7 := BD7->(GetArea())

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1' 

	If FunName() == "PLSA092"
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "P720GRVG - 1")
	
	EndIf
	
EndIf

BD7->(DbSetOrder(1)) //BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
BD7->(MsSeek(xFilial("BD7")+cChave))
While !BD7->(Eof()) .And. cChave == BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)

	If Empty(BD7->BD7_CODTPA)
		BD7->(RecLock("BD7",.F.))
		BD7->BD7_CODTPA := "H"
	//	BD7->BD7_DESTPA := "HOSPITAL/LABORATORIOS/CLINICAS"
		BD7->(MsUnlock())
	Endif
	BD7->(DbSkip())
EndDo

RestArea(aAreaBD7)   

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1' 

	If FunName() == "PLSA092" 
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "P720GRVG - 2")
	
	EndIf
	
EndIf

Return Nil