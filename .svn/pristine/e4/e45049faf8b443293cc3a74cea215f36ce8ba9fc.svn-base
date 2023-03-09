#Include 'Protheus.ch'

//*---------------------------------------------------------|
//* Rotina:PLS090EX           						        |  
//*---------------------------------------------------------|
// Autor: Mateus Medeiros     |     Data:09/05/18           |
//*---------------------------------------------------------|
// Descrição: Bloqueio da rotina de exclusão                |
//*  - Libera - Operativa.                                  |
//*---------------------------------------------------------|

User Function PLS090EX()
	
	Local aArea := GetArea()
	Local aAreaBEA := BEA->(Getarea())
	Local lRet     := .T. 
	
	if Alltrim(BEA->BEA_USUOPE) == "OPERAT"
		
		MsgStop("Operação não permitida. Esta solicitação foi realizada pelo portal da Operativa. Solicite o prestador o cancelamento pelo portal da Operativa.")
		lRet := .F.
		 
	endif 
		
	RestArea(aAreaBEA)
	RestArea(aArea)
	
Return lRet