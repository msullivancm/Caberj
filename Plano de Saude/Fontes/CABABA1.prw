#Include 'RWMAKE.CH'                                                                            

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABABA1   �Autor  �Jeferson Couto      � Data �  16/10/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o nome do usu�rio titular caso n�o seja definido   ���
���          � o usu�rio no lan�amento                                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABABA1(cBSQusu)

Local aArea := GetArea()
Local cNome := ""

If !empty(cBSQusu)
	cNome := PlNomusr(cBSQusu)
Else
	DbSelectArea("BA1")
	DbSetOrder(1)
	If DbSeek(xFilial("BA1") + BSQ->BSQ_CODINT + BSQ->BSQ_CODEMP + BSQ->BSQ_MATRIC + 'T')
		cNome := BA1->BA1_NOMUSR
	EndIf
EndIf

DbSelectArea("BSQ")

RestArea(aArea)

Return(cNome)