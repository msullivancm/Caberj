#include 'protheus.ch'
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV032  �Autor  �Angelo Henrique     � Data �  03/04/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir que o subcontrato        ���
���          �preenchido no IMPVIDA n�o esteja bloqueado ou cancelado.    ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABV032()

	Local _aArea 	:= GetArea()
	Local _aArBQC 	:= BQC->(GetArea())
	Local _lRet		:= .T.		

	If !(Empty(M->ZZ0_SUBCON))

		DbSelectArea("BQC")
		DbSetOrder(1) //BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
		If DbSeek(xFilial("BQC") + M->(ZZ0_CODOPE + ZZ0_CODEMP + ZZ0_NUMCON) + "001" + M->ZZ0_SUBCON)

			If !(Empty(BQC->BQC_DATBLO))

				Aviso("Aten��o","Este subcontrato esta bloqueado e n�o poder� ser utilizado.",{"OK"})
				_lRet := .F.

			EndIf

		EndIf

	EndIf

	RestArea(_aArBQC)
	RestArea(_aArea )

return _lRet