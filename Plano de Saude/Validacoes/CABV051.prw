#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV051   ºAutor  ³Angelo Henrique     º Data ³  20/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para validar o canal no momento em que    º±±
±±º          ³esta sendo vinculado com a porta de entrada.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºParametro ³ 1 - Chamado pela rotina de vinculo com a porta de entrada. º±±
±±º          ³ 2 - Chamado pela rotina de protocolo de atendimento.       º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
				
				Aviso("Atenção","Canal não pode ser utilizado pois encontra-se bloqueado.",{"OK"})
				
				_lRet := .F.
				
			EndIf
			
		EndIf
		
	ElseIf _cParam1	== "2"
		
		DbSelectArea("PCB")
		DbSetOrder(1)
		If DbSeek(xFilial("PCB") + M->ZX_CANAL)
			
			If PCB->PCB_BLOQ = "1" //SIM
				
				Aviso("Atenção","Canal não pode ser utilizado pois encontra-se bloqueado.",{"OK"})
				
				_lRet := .F.
				
			EndIf
			
		EndIf
		
		
	EndIf
	
	RestArea(_aArPCC)
	RestArea(_aArPCB)
	RestArea(_aArea	)
	
Return _lRet