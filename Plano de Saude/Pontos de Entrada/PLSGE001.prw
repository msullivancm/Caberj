#include "Rwmake.ch"
      
User Function PLSGE001(lFunc1,lFunc2,aVet1)
Local aArea := GetArea()

	SE1->(RecLock("SE1",.F.))
	
	     SE1->E1_FLUXO    := "N"
	
	SE1->(MsUnLock())
	

RestArea(aArea)

Return

