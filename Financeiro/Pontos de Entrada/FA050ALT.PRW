#Include "PROTHEUS.CH"
#Include "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � FA050ALT � Autor � Eduardo Folly (Korus) � Data � 22/08/08 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Valida��o do preenchimento do campo de compet�ncia do PA.  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
��� Altera��es �                                                          ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//**********************
User Function FA050ALT()
//********************** 
	Local lRet := U_VldCompPa() // Fun��o dentro do FA050INC

	If lRet
		lRet := U_VlCodbar( M->E2_CODBAR, ALLTRIM(M->E2_TIPO) ) // Fun��o dentro do FA050INC
	Endif

	If lRet
		lRet := U_VlLinDig( M->E2_LINDIG, ALLTRIM(M->E2_TIPO) ) // Fun��o dentro do FA050INC
	Endif

Return lRet
