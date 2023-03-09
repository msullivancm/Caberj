
#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS264L4  �Autor  � Jean Schulz        � Data �  16/10/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tratar linha de impressao do cartao, a fim de inserir demais���
���          �dados cfme necessidade do cliente.                          ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                    
User Function PLS264L4
Local aRet	:= {}
Static nLinha := 0

Aadd(aRet,';')
Aadd(aRet,.T.)
Aadd(aRet,'"'+StrZero(nLinha,11)+'";')
nLinha++

Return aRet            