#INCLUDE 'PROTHEUS.CH'

//Antes da montagem do browse do CM

User Function PLS500LC

Local lAcessaCM := .T.  
Local aArea		:= GetArea()
Local aAreaSX3	:= SX3->(GetArea())

DbSelectArea("SX3")
SX3->(DbSetOrder(2))

If SX3->(DbSeek("BE4_DATPRO")) .and. ( SX3->X3_VISUAL <> 'A' )
	SX3->(RecLock("SX3",.F.))
		SX3->X3_VISUAL  := 'A'
	SX3->(MsUnlock())	
EndIf                                                           

If SX3->(DbSeek("BE4_HORPRO")) .and. ( SX3->X3_VISUAL <> 'A' )
	SX3->(RecLock("SX3",.F.))
		SX3->X3_VISUAL  := 'A'
	SX3->(MsUnlock())	
EndIf 

SX3->(RestArea(aAreaSX3))
RestArea(aArea)

Return lAcessaCM