#include 'protheus.ch'
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV031  �Autor  �Angelo Henrique     � Data �  03/04/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para visualizar se os campos de data de    ���
���          �inclus�o e data de exclus�o est�o preenchidos corretamente  ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABV031()

	Local _aArea 	:= GetArea()
	Local _lRet		:= .T.

	//-----------------------------------------------------------------
	//S� ira validar se o campo data de exclus�o estiver preenchida
	//-----------------------------------------------------------------
	If !(Empty(M->BQQ_DATEXC)) .And. !(Empty(M->BQQ_DATINC))

		//---------------------------------------------------------------------------------
		//Validar se a data preenchida na inclus�o n�o � maior que a data da exclus�o
		//--------------------------------------------------------------------------------- 
		If M->BQQ_DATINC < M->BQQ_DATEXC .Or. M->BQQ_DATINC = M->BQQ_DATEXC

			Aviso("Aten��o","A data de inclus�o n�o pode ser menor ou igual a Data de Exclus�o",{"OK"})
			_lRet := .F.

		EndIf

	EndIf		

	RestArea(_aArea)

return _lRet