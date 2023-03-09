#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV034  �Autor  �Angelo Henrique     � Data �  28/08/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir que o canal n�o seja      ��
���          �alterado, pois em alguns casos pessoas de outros setores    ���
���          �est�o alterando o canal para poder encerr�-lo.              ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABV034(_cParam)

	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())
	Local _lRet		:= .T.

	Default _cParam := ""
		
	If SZX->ZX_CANAL = "000002" //OUVIDORIA

		If _cParam <> SZX->ZX_CANAL
			
			_lRet := .F.
			
			Aviso("Aten��o","N�o � poss�vel trocar o CANAL quando o mesmo esta selecionado para a OUVIDORIA.", {"OK"})			

		EndIf

	EndIf

	RestArea(_aArZX)
	RestArea(_aArea)

return _lRet