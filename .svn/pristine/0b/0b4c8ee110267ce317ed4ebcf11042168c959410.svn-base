#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV044     ºAutor  ³Angelo Henrique   º Data ³  06/02/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validações pertinentes a P12, pois em alguns campos não     º±±
±±º          ³deixa passar quando é branco, a rotina trava o restante     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºParametros³ Esta rotina será chamada de vários campos:                 º±±
±±º   1      ³ Chamada 1 virá do campo BEJ_CODPRO;                        º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV044(_cParam)
	
	Local _aArea	:= GetArea()
	Local _aArBEJ	:= BEJ->(GetArea())
	Local _aArBEL	:= BEL->(GetArea())
	Local _lRet		:= .T.
	
	Default _cParam	:= ""
	
	If _cParam == "1" //BEJ_CODPRO
	
		If !(Empty(M->BEJ_CODPRO))
			
			//----------------------------------------------------------------------------------------------------------------------
			//Validação abaixo estava sendo chamada no X3_VALID
			//----------------------------------------------------------------------------------------------------------------------
			_lRet := PLSMUDCOD("BEJ").AND.PLSA092Aut(M->BEJ_SEQUEN,M->BEJ_CODPAD,M->BEJ_CODPRO,M->BEJ_QTDPRO,"1","BEJ","BE4","BEL")
			
			//----------------------------------------------------------------------------------------------------------------------
			//Se estiver tudo OK na primeira validação será chamado a validação que estava no campo X3_VLDUSER
			//----------------------------------------------------------------------------------------------------------------------
			If _lRet
		
				_lRet := U_MsgOrtProt(M->BEJ_CODPRO).AND.&(FORMULA("TCC")) .AND. IIF(LEN(ALLTRIM(M->BEJ_CODPRO))<8,.F.,.T.)  
			
			EndIf
			
		EndIf
	
	EndIf
	
	RestArea(_aArBEL)
	RestArea(_aArBEJ)
	RestArea(_aArea	)
	
Return _lRet

