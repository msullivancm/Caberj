
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSPESQLIB�Autor  �Microsiga           � Data �  01/18/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User function PlsPesqLIB(cOpeRda,cCodRda)
LOCAL cRdaGen := GetMv("MV_PLSRDAG")
LOCAL cRet    := "@#BEA_ORIGEM=='2' .And. ((BEA_OPERDA=='"+cOpeRda+"' .And. BEA_CODRDA=='"+cCodRda+"') .OR.(BEA_CODRDA == '"+cRdaGen+"')) .And. BEA->BEA_STALIB=='1'@#"
Return(cRet)