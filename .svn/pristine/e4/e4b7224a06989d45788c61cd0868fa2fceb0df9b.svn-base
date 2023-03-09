#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV030  ºAutor  ³Angelo Henrique     º Data ³  19/04/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá validar o prestador selecionado no momento   º±±
±±º          ³da internação.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABV030()

	Local _aArea 	:= GetArea()
	Local _aArBE4 	:= BE4->(GetArea())
	Local _aArBB8 	:= BB8->(GetArea())
	Local _lRet		:= .T.

	DbSelectArea("BB8")
	DbSetOrder(1) //BB8_FILIAL+BB8_CODIGO+BB8_CODINT+BB8_CODLOC+BB8_LOCAL
	If DbSeek(xFilial("BB8")+ M->BE4_CODRDA + M->BE4_OPERDA) 

		While !EOF() .AND. M->BE4_CODRDA + M->BE4_OPERDA == BB8->(BB8_CODIGO+BB8_CODINT)

			If BB8->BB8_LOCAL != "009"			

				_lRet := .F.				

			EndIf

			If BB8->BB8_LOCAL == "009"

				_lRet := .T.
				Exit

			EndIf


			BB8->(DbSkip())

		EndDo

		//------------------------------------------------------------------
		//Caso não seja encontrado nenhum local para Hospital
		//será criticado o Prestador durante a inclusão da Internação
		//------------------------------------------------------------------
		If !_lRet

			Aviso("Atenção","Prestador não autorizador para executar/solicitar senha para regime de atendimento de internação..",{"OK"})

		EndIf

	EndIf

	RestArea(_aArBB8)
	RestArea(_aArBE4)
	RestArea(_aArea)

return _lRet