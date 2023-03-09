#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV038  ºAutor  ³Angelo Henrique     º Data ³  19/12/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação criada para não permitir que o campo de hora no    ±±
±±º          ³processo de contas médicas fique em branco.                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV038(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aArBE4 	:= BE4->(GetArea())
	Local _oRet		:= Nil
	
	Default _cParam	:= "1" //1 - Chamado pela validação campo || 2 - Chamado pelo gatilho
	
	If _cParam == "1"
		
		If Empty(AllTrim(STRTRAN(M->BE4_HRALTA,':',' ')))
			
			Aviso("Atenção","Necessário preenchimento do campo de Hora",{"OK"})
			
			_oRet := .F.
			
		Else
			
			_oRet := .T.
			
		Endif
		
	ElseIf _cParam == "2"
		
		If !(Empty(M->BE4_DTALTA))
			
			If Empty(AllTrim(STRTRAN(M->BE4_HRALTA,':',' ')))
				
				Aviso("Atenção","Necessário preenchimento do campo de Hora",{"OK"})
				
			Endif
			
		Endif
		
		//-------------------------------------------------
		//Mudando o tipo de recebimento do campo
		//-------------------------------------------------
		_oRet := M->BE4_HRALTA
		
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return _oRet