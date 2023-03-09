/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GRAVALOG  �Autor  �Roger Cangianeli    � Data �  10/02/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para gravacao de log de erro, quando nao for possi- ���
���          � vel encontrar a conta contabil para retorno.               ���
�������������������������������������������������������������������������͹��
���Revisao   � 13/07/06 - Revisao e otimizacao da rotina.                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Gravalog(cMsg,cTpLog)

Local cLog, cLog1

cLog	:= Subs(cTpLog+'|'+cMsg,001,256)
cLog1	:= Subs(cTpLog+'|'+cMsg,257,256)

RecLock('SZU',.T.)
SZU->ZU_FILIAL	:= xFilial('SZU')
SZU->ZU_DATA	:= Date()
SZU->ZU_HORA	:= Subs(AllTrim(Time()),1,8)
SZU->ZU_LOG		:= cLog
SZU->ZU_LOG1	:= cLog1
msUnlock()

Return

