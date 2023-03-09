#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV040  �Autor  �Angelo Henrique     � Data �  12/01/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para informar ao usu�rio que o procedimento ��
���          �prenchido em tela necessita de analise pr�via.              ���
���          �Valida�ao chamada na rotina de Libera��o.                   ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABV040()
	
	Local _aArea	:= GetArea()
	Local _aArBEA	:= BEA->(GetArea())
	Local _aArBE2	:= BE2->(GetArea())
	Local _aArBR8	:= BR8->(GetArea())
	Local _lRet		:= .T.
	
	DbSelectArea("BR8")
	DbSetOrder(1) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
	If DbSeek(xFilial("BR8") + M->(BE2_CODPAD + BE2_CODPRO))
		
		If BR8->BR8_XPAUT = "1"
			
			MSGINFO("Este procedimento necessita de analise pr�via, o prazo previsto para libera��o �: " + DTOC(DAYSUM(DATE(),15)) + ".", "Aten��o" )
			
		EndIf
		
	EndIf
	
	RestArea(_aArBR8)
	RestArea(_aArBE2)
	RestArea(_aArBEA)
	RestArea(_aArea	)
	
Return _lRet
