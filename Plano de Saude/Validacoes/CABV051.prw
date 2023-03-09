#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV051   �Autor  �Angelo Henrique     � Data �  20/04/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o canal no momento em que    ���
���          �esta sendo vinculado com a porta de entrada.                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
���Parametro � 1 - Chamado pela rotina de vinculo com a porta de entrada. ���
���          � 2 - Chamado pela rotina de protocolo de atendimento.       ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV051(_cParam1)
	
	Local _aArea		:= GetArea()
	Local _aArPCB		:= PCB->(GetArea())
	Local _aArPCC		:= PCC->(GetArea())
	Local _lRet			:= .T.
	
	Default _cParam1	:= "1"
	
	If _cParam1	== "1"
		
		DbSelectArea("PCB")
		DbSetOrder(1)
		If DbSeek(xFilial("PCB") + M->PCC_CDCANA)
			
			If PCB->PCB_BLOQ = "1" //SIM
				
				Aviso("Aten��o","Canal n�o pode ser utilizado pois encontra-se bloqueado.",{"OK"})
				
				_lRet := .F.
				
			EndIf
			
		EndIf
		
	ElseIf _cParam1	== "2"
		
		DbSelectArea("PCB")
		DbSetOrder(1)
		If DbSeek(xFilial("PCB") + M->ZX_CANAL)
			
			If PCB->PCB_BLOQ = "1" //SIM
				
				Aviso("Aten��o","Canal n�o pode ser utilizado pois encontra-se bloqueado.",{"OK"})
				
				_lRet := .F.
				
			EndIf
			
		EndIf
		
		
	EndIf
	
	RestArea(_aArPCC)
	RestArea(_aArPCB)
	RestArea(_aArea	)
	
Return _lRet