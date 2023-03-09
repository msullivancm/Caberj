#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'

User Function CABG012()
	
	Local _aArea	:= GetArea()
	Local _aArSEV	:= SEV->(GetArea())
	Local _aArSED	:= SED->(GetArea())
	Local _cRet		:= " "
	Local _aBkpAc	:= {}
	Local _nPosNat	:= 0
	Local cMultNat	:= IIF(valtype(M->E1_MULTNAT) = "U", SE1->E1_MULTNAT, M->E1_MULTNAT)
	
	//-----------------------------------------------------------
	//Chamada pela tela de boletos de Alugueis
	//-----------------------------------------------------------
	If cMultNat != "1"
		
		If Valtype(oBrw1) == "O"
			
			_aBkpAc		:= oBrw1:aCols
			_nPosNat	:= aScan(aHoBrw1,{|x|AllTrim(x[2]) == "EV_NATUREZ" })
			
			If !(Empty(_aBkpAc[n][_nPosNat]))
				
				DbSelectArea("SED")
				DbSetOrder(1)
				If DbSeek(xFilial("SED") + _aBkpAc[n][_nPosNat] )
					
					_cRet := AllTrim(SED->ED_DESCRIC)
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArSED)
	RestArea(_aArSEV)
	RestArea(_aArea	)
	
Return _cRet