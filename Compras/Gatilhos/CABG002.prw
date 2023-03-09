#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABG002  �Autor  �Angelo Henrique     � Data �  23/12/2016 ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho   utilizado no processo de compras para alguns      ���
���          �campos referentes ao processo de OPME.                      ���
���          �Gatilho criado apartir do campo de preenchimento do produto ���
���          �Ser� ativado apartir da segunda linha do ACOLS.             ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABG002()

	Local _aArea 	:= GetArea()
	Local _aArSC7	:= SC7->(GetArea())	
	Local _nPosSen	:= Ascan(aHeader,{|x| x[2] = "C7_XSENHA"})	
	Local _cRet		:= ""

	//---------------------------------------------------
	//Validar se nao � a primeira linha 
	//pois nela ser� preenchida a primeira vez
	//o campo de senha e de OPME
	//---------------------------------------------------
	If n != 1 

		//--------------------------------------------------
		//Valida��o do Campo de Senha	
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
