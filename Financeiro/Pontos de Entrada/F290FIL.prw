#include "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � F290FIL  � Autor �Jose Carlos Noronha � Data �  31/07/2007 ���
�������������������������������������������������������������������������͹��
���Desc.     � Filtrar Titulos Bloqueados no Contas a Pagar Gerados no PLS���
���          � na Rotina Titulos Para Faturas.(FINA290)                   ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F290FIL

// "N" - Titulos Bloqueados
// "S" - Titulos Liberados por NF
// "M" - Titulos Liberados Manualmente
// A2_YBLQPLS = "N" - Fornecedor Sem Bloqueio

cFil290 := ' '

/*                                                                                      
cFil290 := '(SE2->E2_YLIBPLS $ "S|M") .OR. (!Substr(E2_ORIGEM,1,3) $ "PLS") .OR. '     
cFil290 += '(POSICIONE("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_YBLQPLS") = "N")'
*/
Return cFil290
