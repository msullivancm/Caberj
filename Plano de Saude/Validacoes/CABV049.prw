#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV049   �Autor  �Angelo Henrique     � Data �  09/04/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o campo objeto do banco de   ���
���          � conhecimento n�o permitindo assim que outros usu�rios n�o  ���
���          � movimentem informa��es de outros.                          ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV049()
	
	Local _aArea	:= GetArea()
	Local _aAreSZY	:= SZY->(GetArea())
	Local _nPosUsu	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "AC9_XUSU"	})
	Local _nPosLog	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "AC9_OBJETO"	})		
	Local _lRet		:= .T.
	
	If !Empty(aCols[n][_nPosUsu])
		
		If AllTrim(CUSERNAME) != AllTrim(aCols[n][_nPosUsu])
			
			Aviso("Aten��o","N�o � poss�vel alterar este campo, pois voc� n�o � usu�rio responsavel por essa informa��o.",{"OK"})
			
			_lRet := .F.
			
		EndIf
		
	EndIf
			
	RestArea(_aAreSZY	)
	RestArea(_aArea		)
	
Return _lRet