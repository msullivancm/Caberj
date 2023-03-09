#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABG003  �Autor  �Angelo Henrique     � Data �  23/12/2016 ���
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

user function CABG003()

	Local _aArea 	:= GetArea()
	Local _aArSC7	:= SC7->(GetArea())		
	Local _nPosAut	:= Ascan(aHeader,{|x| x[2] = "C7_XAUTOP"})
	Local _cRet		:= ""

	//---------------------------------------------------
	//Validar se nao � a primeira linha 
	//pois nela ser� preenchida a primeira vez
	//o campo de senha e de OPME
	//---------------------------------------------------
	If n != 1 

		//--------------------------------------------------
		//Valida��o do campo Autoriza��o OPME	
		//--------------------------------------------------
		If !(Empty(AllTrim(aCols[1][_nPosAut])))

			aCols[n][_nPosAut] := AllTrim(aCols[1][_nPosAut])
			_cRet := AllTrim(aCols[1][_nPosAut])

		EndIf

	EndIf	

	RestArea(_aArea)
	RestArea(_aArSC7)

	GetDRefresh()

return _cRet
