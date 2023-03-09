#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV023   �Autor  �Angelo Henrique     � Data �  17/06/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar a prorroga��o no processo de ���
���          �interna��o, para n�o permitir a prorroga��o quando alguns   ���
���          �campos referente a alta estiverem preenchidos.              ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV023()
	
	Local _aArea 	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _lRet	:= .T.
	
	If !(Empty(M->BE4_TIPALT))
		
		Aviso("Aten��o", "J� existe motivo de alta informada para esta interna��o, prorroga��o n�o ser� conclu�da.", {"OK"})
		_lRet	:= .F.
		
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArea)
	
Return _lRet
