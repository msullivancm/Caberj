#INCLUDE 'PROTHEUS.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³F460CANC ³ Autor ³ Angelo Henrique       ³ Data ³26/09/2019 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Ponto de entrada chamdo no cancelamento da liquidação     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FIN460E1()
	
	Local _aArea		:= GetArea()
	Local _aArSE1		:= SE1->(GetArea())
	Local _aArSE5		:= SE5->(GetArea())
	Local _aArFO0		:= FO0->(GetArea())
	Local _aArFO1		:= FO1->(GetArea())
	Local _aArFO2		:= FO2->(GetArea())		
	
	//-------------------------------------------------------------------------------
	//Ponterar nas baixas que os títulos sofreram para poder limpar
	//pois mesmo a rotina realizando o cancelamento delas fica muito confuso
	//para o usuário a forma como o histórico é exibido
	//Com isso realizo a limpeza das movimentações que ficam, para não afetar o 
	//andamento do processo no financeiro
	//-------------------------------------------------------------------------------
	DbSelectArea("SE5")
	DbSetOrder(10) //E5_FILIAL+E5_DOCUMEN
	If DbSeek(SE1->(E1_FILIAL + E1_NUMLIQ))
		
		While SE5->(!EOF()) .And. AllTrim(SE1->E1_NUMLIQ) == AllTrim(SE5->E5_DOCUMEN)
			
			If AllTrim(SE5->E5_MOTBX) == "LIQ"
				
				RecLock("SE5",.F.)
				
				dbDelete()
				
				MsUnlock()
				
			EndIf
			
			SE5->(DbSkip())
			
		EndDo
		
	EndIf
	
	RestArea(_aArFO2)
	RestArea(_aArFO1)
	RestArea(_aArFO0)
	RestArea(_aArSE5)
	RestArea(_aArSE1)
	RestArea(_aArea	)
	
Return 