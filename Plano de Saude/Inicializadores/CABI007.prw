#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI007     �Autor  �Angelo Henrique   � Data �  30/05/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inicializador padr�o criado para o protocolo de atendimento ���
���          �devido ao processo de PA x URA, campo ZX_YPLANO .           ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABI007()

	Local _cRet 	:= ""
	Local _aArea 	:= Nil
	Local _aArBI3 	:= Nil

	If FUNNAME() = "CABA069" 

		If INCLUI

			_cRet := ""

		Else

			_aArea  := GetArea()
			_aArBI3 := BI3->(GetArea())

			_cRet := POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")

			RestArea(_aArBI3)
			RestArea(_aArea )

		EndIf	

	EndIf

return _cRet