#Include 'Protheus.ch'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABG009   �Autor  �Mateus Medeiros     � Data �  29/10/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para validar qual empresa e tipo de pagamento foi   ���
�� informado em tela de inclus�o da fam�lia.     						  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABG010()
	
	Local aArea := GetArea()
	Local aAreaBA3 := BA3->(GetArea())
	Local lRet := .F. 
	Local cCtaNova := GetNewPar('MV_YCTANEW','5380') 
	Local cBcoNovo := GetNewPar('MV_YCTANEW','237')
	Local cAgeNova := GetNewPar('MV_YCTANEW','3369')
		
		// Somente ser� disparado o gatilho se a empresa for Afinidade 
		// e o tipo de cobran�a for Boleto - 04 	
		if M->BA3_CODEMP == "0002" .and.  M->BA3_TIPPAG == '04'
			lRet := .T. 
		endif 
	
	RestArea(aArea)
	
Return lRet

