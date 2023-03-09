#Include 'Protheus.ch'


/*
@author: Mateus Medeiros
@description Filtro de tela na função entrevista qualificada.
@date: 03/10/2017

*/

User Function CABA600()

	Local cUser 	:= __cUserId 
	Local cUsrAcc   := SuperGetMv("MV_XQLVIDA",,"001377|001378|001349|001263")
	Local cCodemp   := SuperGetMv("MV_XEMPQVI",,"0251|0271|0182|0220|0255|0282|0262|0270|0222|0253|0149|0256|0250|0254") 
	Local cExpre    := ""
	Local lRet      := .T.
	Local cRet      := '' 
	
	if cEmpant == "02" .and. __cUserId $ cUsrAcc 
	
	  BXA->(DbSetFilter({|| SUBSTR(BXA->BXA_USUARI,5,4) $ cCodemp }, " SUBSTR(BXA->BXA_USUARIO,5,4) $ cCodemp"))
	
	endif 

Return lRet

