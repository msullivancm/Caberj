#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV035  �Autor  �Mateus Medeiros     � Data �  04/10/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir ao usuario o n�o          ��
���          �preenchimento do campo E-mail no cadastro de Vidas.         ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABV035()

	Local _aArea 	:= GetArea()
	Local _aArBTS 	:= BTS->(GetArea())
	Local _lRet		:= .T.

	if Empty(ALLTRIM(M->BTS_EMAIL))
		_lRet := .F.
		IF ALLTRIM(M->BTS_EMAIL) # "E-MAIL OBRIGATORIO"
			Aviso("Aten��o","O Preenchimento do campo e-mail � obrigat�rio.", {"OK"})
		ENDIF
	else
		if AT("@",M->BTS_EMAIL)==0
			_lRet := .F.
			IF ALLTRIM(M->BTS_EMAIL) # "E-MAIL OBRIGATORIO"
				Aviso("Aten��o","E-mail informado n�o � v�lido.", {"OK"})
			ENDIF
		endif
	EndIf
//IIF( M->BTS_XSMAIL == "S",!Empty(M->BTS_EMAIL) .AND. AT("@",M->BTS_EMAIL)>0 ,Empty(M->BTS_EMAIL) .OR. AT("@",M->BTS_EMAIL)>0 )  
	RestArea(_aArBTS)
	RestArea(_aArea)

return _lRet