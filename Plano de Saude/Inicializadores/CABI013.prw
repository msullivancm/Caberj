#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI013   �Autor  �Angelo Henrique     � Data �  16/05/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Usado para inicializar o vetor que carrega as informa��es   ���
���          �pertinentes a tabela BF3 (Doen�as Pr�-Existentes).          ���
���          �Hoje a rotina padr�o n�o esta realizando a chamada da       ���
���          �descri��o.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABI013()
	
	Local _aArea 	:= GetArea()
	Local _aArBF3	:= BF3->(GetArea())
	Local _aArBA9	:= BA9->(GetArea())
	Local _cDesc	:= ""
		
	DbSelectArea("BA9")
	DbSetOrder(1)
	If DbSeek(xFilial("BA9") + BF3->BF3_CODDOE)
		
		_cDesc := BA9->BA9_DOENCA
		
	EndIf
	
	RestArea(_aArBA9)
	RestArea(_aArBF3)
	RestArea(_aArea	)
	
Return _cDesc

