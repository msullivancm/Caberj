#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV058B �Autor  �SERGIO CUNHA    	 � Data �  29/07/2019 ���
�������������������������������������������������������������������������͹��
���Desc.     �ALERTA DE QUANTIDADE SOLICITADA X AUTORIZADA NA ROTINA DE   ���
���          �DE AUDITORIA POR GUIA                                       ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function CABV058(_status)

	Local _aArea 		:= GetArea()
	Local _aArBR72 		:= B72->(GetArea())
	local cParecer 		:= _status
	local lret := .T.
	

	if cParecer == "0" .and. (cvaltochar(M->B72_QTDAUT) == "0" .or. (cvaltochar(M->B72_QTDAUT) < cvaltochar(M->B72_QTDSOL)))
		
		MSGALERT('<font color="#FF0000"><b>Aten��o</b></font><br><b>'+cUserName+'</b>, verifique a quantidade a ser autorizada com a quantidade solicitada.<br><b>Quantidade solicitada: </b><font color="#FF0000">'+cvaltochar(M->B72_QTDSOL)+'</font>  <br><b>Quantidade autorizada: </b><font color="#FF0000">'+cvaltochar(M->B72_QTDAUT)+'</font>')

	endIf
	B72->(RestArea(_aArBR72))
	RestArea(_aArea)
	
return lret

