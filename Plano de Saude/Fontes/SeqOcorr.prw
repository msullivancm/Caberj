#Include "rwmake.ch"
#Include "topconn.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SeqOcorr  �Autor  � Raquel Casemiro    � Data �  27/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � funcao para calcular o sequencial na tabela de ocorrencias ���
�������������������������������������������������������������������������͹��
���Uso       � Axcadastro Ocorrencias                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                                                        
User Function SeqOcorr(cCODRDA)

LOCAL cSQL		:= ""    
LOCAL cRet      := 0     


cSQL := " SELECT NVL(MAX(ZZ7_SEQ),0)  AS PROX FROM " + RetSqlName("ZZ7") + " "
cSQL += " WHERE D_E_L_E_T_ <> '*' "
cSQL += " AND ZZ7_CODRDA = '"+cCODRDA+"' "
PLSQuery(cSQL,"TRB")    
cRet := STRzero(VAL(TRB->PROX)+1,3)    // completa com zeros a esquerda

TRB->(DbCloseArea())                                

M->ZZ7_SEQ :=Alltrim(cRet)

Return .t.
