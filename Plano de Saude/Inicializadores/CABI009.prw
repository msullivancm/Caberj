#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI009     �Autor  �Angelo Henrique   � Data �  30/05/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inicializador padr�o criado para o campo de status OPME     ���
���          �uma vez que muitas op��es surgiram para atender a demanda.  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function CABI009

	Local _aArea 	:= GetArea()
	Local _aArE4 	:= BE4->(GetArea())	
	Local _cRet		:= ""	

	If BE4->BE4_YSOPME = "1"

		_cRet		:= "ANALIS. ADM"

	ElseIf BE4->BE4_YSOPME = "2"

		_cRet		:= "EXIG. ADM"		

	ElseIf BE4->BE4_YSOPME = "3"

		_cRet		:= "ANALIS. AUD."	

	ElseIf BE4->BE4_YSOPME = "4"

		_cRet		:= "EXIG. AUD."

	ElseIf BE4->BE4_YSOPME = "5"

		_cRet		:= "CUMPRIMENTO AUDITORIA"	

	ElseIf BE4->BE4_YSOPME = "6"

		_cRet		:= "JUNTA MEDICA"	

	ElseIf BE4->BE4_YSOPME = "7"

		_cRet		:= "ANALIS. OPME"	

	ElseIf BE4->BE4_YSOPME = "8"

		_cRet		:= "OPME FINALIZADO"	

	ElseIf BE4->BE4_YSOPME = "9"
		
		_cRet		:= "AGUARDANDO LIB."
	
	ElseIf BE4->BE4_YSOPME = "A"

		_cRet		:= "INTERNACAO LIB."
	
	ElseIf BE4->BE4_YSOPME = "B"

		_cRet		:= "OPME AUT FORNEC/PRESTADOR"
			
	ElseIf BE4->BE4_YSOPME = "C"

		_cRet		:= "NEGADO"		

	EndIf	

	RestArea(_aArE4)
	RestArea(_aArea)	

return _cRet