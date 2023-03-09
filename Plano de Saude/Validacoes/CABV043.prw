#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV043  �Autor  �Angelo Henrique     � Data �  18/01/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir que o usu�rio digite a    ��
���          �data prevista ser menor do que a data de solicita��o.       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABV043(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aArBE4 	:= BE4->(GetArea())
	Local _lRet		:= .T.
	
	Default _cParam := "1"
	
	If _cParam = "1"
	
		If M->BE4_XDTPR < M->BE4_YDTSOL
			
			Aviso("Aten��o","N�o � poss�vel preencher a Data Prevista de Autoriza��o menor que a Data de Solicita��o.",{"OK"})
			
			_lRet		:= .F.
			
		EndIf
		
	ElseIf _cParam = "2"
		
		If dDatAut < BE4->BE4_YDTSOL
			
			_cMsg := "N�o � poss�vel preencher a Data Prevista de Autoriza��o menor que a Data de Solicita��o." + CRLF
			_cMsg += "Data de Solicita��o: " + DTOC(BE4->BE4_YDTSOL) + "." + CRLF
			
			Aviso("Aten��o", _cMsg,{"OK"})
			
			_lRet		:= .F.
			
		EndIf
			
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArea )
	
Return _lRet