#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI006     �Autor  �Angelo Henrique   � Data �  30/05/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inicializador padr�o criado para o protocolo de atendimento ���
���          �devido ao processo de PA x URA, campo ZX_NOMUSR.            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABI006()

	Local _cRet 	:= ""
	Local _aArea 	:= Nil
	Local _aArBA1 	:= Nil

	If FUNNAME() = "CABA069" 

		If INCLUI

			_cRet := ""

		Else

			_aArea := GetArea()
			_aArBA1:= BA1->(GetArea())

			_cRet := POSICIONE("BA1",2,XFILIAL("BA1")+SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG),"BA1_NOMUSR")

			RestArea(_aArBA1)
			RestArea(_aArea )

		EndIf	

	EndIf

return _cRet