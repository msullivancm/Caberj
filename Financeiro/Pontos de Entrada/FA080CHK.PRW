#include "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FA080CHK � Autor �Jose Carlos Noronha � Data �  01/08/2007 ���
�������������������������������������������������������������������������͹��
���Desc.     � Criticar se o Titulo Gerado no PLS Pode Ser Baixado        ���
���          � na Rotina de Baixas a Pagar Manual.(FINA080)               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA080CHK
Local lRet := .T.
 
// " " - Titulos Bloqueados
// "S" - Titulos Liberados por NF
// "M" - Titulos Liberados Manualmente
// A2_YBLQPLS = "N" - Fornecedor Sem Bloqueio

//lRet := (SE2->E2_YLIBPLS $ "|S|") .or. (!Substr(E2_ORIGEM,1,3) $ "PLS") .or. (POSICIONE("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_YBLQPLS") = "N")
lRet := (SE2->E2_YLIBPLS $ "|S_M|") .or. (!Substr(SE2->E2_ORIGEM,1,3) $ "PLS") .or. (POSICIONE("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_YBLQPLS") = "N")

If ! lRet
   Alert("Este Titulo Nao Esta Liberado Para Pagamento.")
Endif
                                          
Return lRet