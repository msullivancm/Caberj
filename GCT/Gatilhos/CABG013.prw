#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt CHR(13) + CHR(10)

/*/{Protheus.doc} CABG013
Gatilho criado para trazer a numeração correta do número da medição
@type function
@author angelo.cassago
@since 07/02/2020
@version 1.0
@return ${_cRet}, ${numero da medição}
@example
(examples)
@see (links_or_references)
/*/

USER FUNCTION CABG013()
	
	Local _aArea 	:= GetArea()
	Local _aArCND 	:= CND->(GetArea())
	Local _cQuery	:= ""
	Local _cAlias	:= GetNextAlias()
	Local _cRet		:= ""
	Local _lAchou	:= .T.
	
	_cQuery	:= " SELECT																					" + cEnt
	_cQuery	+= " 	 LPAD(MAX(CND.CND_NUMMED)+1," + CVALTOCHAR(TAMSX3("CND_NUMMED")[1]) + ",'0') CONT	" + cEnt
	_cQuery	+= " FROM																					" + cEnt
	_cQuery += " 	" + RetSqlName("CND") + " CND 														" + cEnt
	_cQuery	+= " WHERE																					" + cEnt
	_cQuery	+= " 	 CND.CND_CONTRA = '" + M->CND_CONTRA + "'											" + cEnt
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias)
	
	If !(_cAlias)->(EOF())
		
		_cRet := AllTrim((_cAlias)->CONT)
	
	Else
	
		_cRet := STRZERO(1,TAMSX3("CND_NUMMED")[1])   
		
	EndIf	
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
	//--------------------------------------------------------------------------------------
	//Validação acrescentada pois no ORACLE estava contabilizando  
	//corretamente, porém no PROTHEUS estava tarzendo valor anterios
	//--------------------------------------------------------------------------------------
	While _lAchou 
	
		DbSelectArea("CND")
		DbSetOrder(7) //CND_FILIAL+CND_CONTRA+CND_REVISA+CND_NUMMED
		If DbSeek(xFilial("CND") + M->(CND_CONTRA+CND_REVISA) + _cRet )
		
			_cRet := SOMA1(_cRet)
			
		Else
		
			_lAchou := .F.
		
		EndIf 			
	
	EndDo
	
	RestArea(_aArCND)
	RestArea(_aArea	)
	
Return _cRet 