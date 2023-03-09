#include "Rwmake.ch"
      
User Function PLSE2GRV
Local aArea := GetArea()

//Atualize campos do SE2 - Titulos a Receber conforme regra especifica
If !SE2->( EOF() )

	SE2->(RecLock("SE2",.F.))
	
		SE2->E2_YDTSYST := DATE()
   //         se2->e2_inss := se2->e2_vretins
   //         se2->e2_irrf := se2->e2_vretirf 

	SE2->(MsUnLock())

	//Alert("plse2agr")

EndIf

RestArea(aArea)

Return

