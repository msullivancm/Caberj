#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV053   �Autor  �Angelo Henrique     � Data �  12/12/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar informa��es na tela de       ���
���          � Parecer da Auditoria.                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
*/

User Function CABV053(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _lRet		:= .T.
	Local _nQtdAut	:= M->B72_QTDAUT
	
	Default _cParam	:= "1"
	
	If _cParam = "1"
		
		_lRet := CABV053A()
		
	EndIf	
	
	RestArea(_aArea)
	
Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV053A  �Autor  �Angelo Henrique     � Data �  12/12/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar a quantidade autorizada na   ���
���          � rotina de Parecer (Auditoria)                              ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
*/

Static Function CABV053A
	
	Local _lRet := .T.
	
	If  M->B72_QTDAUT > M->B72_XQTDSL
	
		_lRet := .F.
		
		Aviso("Aten��o","Quantidade autorizada maior que a solicitada, favor corrigir.",{"OK"})
	
	EndIf	
	
Return _lRet