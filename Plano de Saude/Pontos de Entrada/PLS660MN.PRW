#INCLUDE "PROTHEUS.CH"

USER FUNCTION PLS660MN()
Local nOpc := paramixb[1]
Local lRet := .T.

/*----------------------------------
Op��o do menu que est� sendo chamada
	6 - Par.reajuste;
	7 - (Des)bloq.sub-Ct.;
----------------------------------*/
IF Alltrim(FunName()) $ "CABA233" 
    IF nOpc == 6 .OR. nOpc == 7 .OR. nOpc == 8
        lRet := .F.	
            U_CABA233A()
    Else
        lRet := .T.
    EndIF
EndIF

Return lRet
