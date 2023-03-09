#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI015   �Autor  �Angelo Henrique     � Data �  13/09/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Usado para inicializar a descri��o da negativa de           ���
���          �reembolso.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABI015()
	
	Local _aArea	:= GetArea()
	Local _aArZZQ	:= ZZQ->(GetArea())
	Local _aArSX5	:= SX5->(GetArea())
	Local _aArBTQ	:= BTQ->(GetArea())
	Local _cRet		:= ""
	
	If Len(AllTrim(ZZQ->ZZQ_MOTCAN)) > 3
		
		_cRet := POSICIONE("BTQ",1,xFilial("BTQ") + "38" + ZZQ->ZZQ_MOTCAN,"BTQ_DESTER")
		
	Else
		
		If Empty(ZZQ->ZZQ_MOTCAN)
			
			_cRet := ""
			
		Else
			
			_cRet := POSICIONE("SX5",1,xFilial("SX5") + "ZQ" + ZZQ->ZZQ_MOTCAN,"X5_DESCRI")
			
		EndIf
		
		
	EndIf
	
	RestArea(_aArBTQ)
	RestArea(_aArSX5)
	RestArea(_aArZZQ)
	RestArea(_aArea	)
	
Return _cRet

