#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI005     ºAutor  ³Angelo Henrique   º Data ³  16/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializador padrão criado para mostrar o status da ANS.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI010()
	
	Local _aArea 	:= GetArea()
	Local _aArE1 	:= BE1->(GetArea())
	Local _aArEA 	:= BEA->(GetArea())
	Local _cRet		:= ""
	
	/*	--------------------------------------------------------------------------------------------------------------
	||	BEA_YDTCAN <> ' ' ENTAO SOLICITAÇÃO CANCELADA
	||	BEA_STATUS = '2' AND BEA_XDTLIB <> ' ' ENTAO AUTORIZADA PARCIALMENTE
	||	BEA_STATUS = '1' AND BEA_XDTLIB <> ' ' ENTAO AUTORIZADA
	||	BEA_STATUS = '2' AND BEA_XDTLIB = ' ' ENTAO EM ANALISE
	||	BEA_STATUS = '1' AND BEA_XDTLIB = ' ' ENTAO EM ANALISE
	||	BEA_STATUS = '3' AND BEA_STALIB = '2' ENTAO NEGADA
	||	--------------------------------------------------------------------------------------------------------------*/
	
	If BEA->BEA_DTDIGI > CTOD("19/01/2018")
		
		If !(Empty(BEA->BEA_YDTCAN))
			
			_cRet := "CANCELADA"
			
		ElseIf BEA->BEA_STATUS = '2' .And. !(Empty(BEA->BEA_XDTLIB))
			
			_cRet := "AUT. PARCIAL"
			
		ElseIf BEA->BEA_STATUS = '1' .And. !(Empty(BEA->BEA_XDTLIB))
			
			_cRet := "AUTORIZADA"
			
		ElseIf BEA->BEA_STATUS = '2' .And. Empty(BEA->BEA_XDTLIB) .OR. 	;
				BEA->BEA_STATUS = '1' .And. Empty(BEA->BEA_XDTLIB) .OR. ;
				BEA->BEA_STATUS = '3' .And. BEA->BEA_STALIB = '1' .OR.	;
				BEA->BEA_STATUS $ ('1|2') .And. BEA->BEA_AUDITO = '1' .And. Empty(BEA->BEA_XDTLIB) 
			
			_cRet := "EM ANALISE"
			
		ElseIf BEA->BEA_STATUS = '3' .And. BEA->BEA_STALIB = '2'
			
			_cRet := "NEGADA"
			
		EndIf
		
	Else
		
		_cRet := " "
		
	EndIf
	
	
	RestArea(_aArEA)
	RestArea(_aArE1)
	RestArea(_aArea)
	
	
Return _cRet