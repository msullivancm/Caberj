/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F050PISS  �Autor  �Jean Schulz         � Data �  09/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tratamento para ISS regra especifica para prestadores de    ���
���          �servico.                                                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F050PISS()
Local aAreaAtu	:= GetArea()
Local aAreaBAU	:= BAU->(GetArea())
Local nPerISS	:= GetMV("MV_ALIQISS")

If Funname() == "PLSA470" .Or. Alltrim(SE2->E2_ORIGEM) == "PLSMPAG" //Modificar aliquota somente para titulos PLS.
	If BAU->(MsSeek(xFilial("BAU")+Iif(Empty(SE2->E2_CODRDA),M->E2_CODRDA,SE2->E2_CODRDA)))
		nPerISS := BAU->BAU_YALISS
	Endif
Endif

RestArea(aAreaBAU)
RestArea(aAreaAtu)

Return nPerISS