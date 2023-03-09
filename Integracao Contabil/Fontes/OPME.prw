#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FuncITEM     �Autor  � Mauro Guerra    � Data �  20/02/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcoes genericas destinadas a contabilizacao do PLS.       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function OPME

Local lAchou

B19->(DbSetOrder(2))

lAchou := B19->(DbSeek(xFilial("B19")+BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)))

Return lAchou