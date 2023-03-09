#INCLUDE "PROTHEUS.CH"
#INCLUDE "UTILIDADES.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV005   �Autor  �Leonardo Portella   � Data �  13/10/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Modo de edicao do campo BA1_FAICOB, que somente podera ser  ���
���          �alterado por usuarios no parametro MV_XFAIUSR e da GETIN e  ���
���          �GERIN.                                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV005

Local lOk 		:= .F.
Local cCodUsr	:= RetCodUsr()

If cCodUsr $ SuperGetMv('MV_XFAIUSR') .or. cCodUsr $ SuperGetMv('MV_XGETIN') .or. cCodUsr $ SuperGetMv('MV_XGERIN') 
	lOk := .T.
EndIf

Return lOk