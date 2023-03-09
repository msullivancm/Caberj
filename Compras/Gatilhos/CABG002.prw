#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABG002  ºAutor  ³Angelo Henrique     º Data ³  23/12/2016 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho   utilizado no processo de compras para alguns      º±±
±±º          ³campos referentes ao processo de OPME.                      º±±
±±º          ³Gatilho criado apartir do campo de preenchimento do produto º±±
±±º          ³Será ativado apartir da segunda linha do ACOLS.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABG002()

	Local _aArea 	:= GetArea()
	Local _aArSC7	:= SC7->(GetArea())	
	Local _nPosSen	:= Ascan(aHeader,{|x| x[2] = "C7_XSENHA"})	
	Local _cRet		:= ""

	//---------------------------------------------------
	//Validar se nao é a primeira linha 
	//pois nela será preenchida a primeira vez
	//o campo de senha e de OPME
	//---------------------------------------------------
	If n != 1 

		//--------------------------------------------------
		//Validação do Campo de Senha	
		//--------------------------------------------------
		If !(Empty(AllTrim(aCols[1][_nPosSen])))

			aCols[n][_nPosSen] := AllTrim(aCols[1][_nPosSen])
			_cRet := AllTrim(aCols[1][_nPosSen])

		EndIf

	EndIf	

	RestArea(_aArea)
	RestArea(_aArSC7)

	GetDRefresh()

return _cRet
