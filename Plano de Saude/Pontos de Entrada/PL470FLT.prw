/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PL470FLT  �Autor  �Microsiga           � Data �  17/09/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para alimentar centro de custo conforme    ���
���          �cadastro da RDA.                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PL470FLT()
Local _cSQL := ""

BAU->(DbSetOrder(1))

_cSQL := " SELECT R_E_C_N_O_ AS REG "
_cSQL += " FROM "+RetSQLName("SE2")
_cSQL += " WHERE E2_FILIAL = '"+xFilial("SE2")+"' "
_cSQL += " AND E2_PLOPELT = '"+BAF->BAF_CODOPE+"' "
_cSQL += " AND E2_PLLOTE = '"+BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)+"' "
_cSQL += " AND D_E_L_E_T_ <> '*' "

PLSQuery(_cSQL,"TRBUPD")

While !TRBUPD->(Eof())
	SE2->(DbGoTo(TRBUPD->REG))
	RecLock("SE2",.F.)
	SE2->E2_CCD := Posicione("BAU",1,xFilial("BAU")+SE2->E2_CODRDA,"BAU_CC")
	SE2->E2_YNPARCE := "00/00"
	SE2->(MsUnlock())
	TRBUPD->(DbSkip())
Enddo

TRBUPD->(DbCloseArea())

Return