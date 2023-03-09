#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI008     ºAutor  ³Angelo Henrique   º Data ³  30/05/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializador padrão criado para o protocolo de atendimento º±±
±±º          ³devido ao processo de PA x URA, campo ZY_DSCHIST.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABI008()

	Local _cRet 	:= ""
	Local _aArea  	:= GetArea()
	Local _aArPCD 	:= PCD->(GetArea())
	Local _aArPBL 	:= PBL->(GetArea())
	Local _aArBAQ 	:= BAQ->(GetArea())

	If FUNNAME() == "CABA069"

		If !INCLUI .AND. !EMPTY(SZY->ZY_HISTPAD)

			DbSelectArea("PBL")
			DbSetOrder(1)
			If DbSeek(xFilial("PBL") + SZY->ZY_TIPOSV )

				If PBL->PBL_GERED <> '1'

					_cRet := POSICIONE("PCD",1,XFILIAL("PCD")+SZY->ZY_HISTPAD,"PCD_DESCRI")

				Else

					//-----------------------------------------------------------
					//Tratando aqui o processo do GERED
					//-----------------------------------------------------------
					DbSelectArea("BAQ")
					DbSetOrder(1)
					If (DbSeek(xFilial("BAQ") + "0001" + PADR(ALLTRIM(SZY->ZY_HISTPAD),tamsx3("BAQ_CODESP")[1])))

						_cRet := BAQ->BAQ_DESCRI
					
					Else

						_cRet := POSICIONE("PCD",1,XFILIAL("PCD")+SZY->ZY_HISTPAD,"PCD_DESCRI")

					EndIf

				EndIf

			EndIf

		Else

			_cRet := ""

		EndIf

	EndIf

	RestArea(_aArBAQ)
	RestArea(_aArPBL)
	RestArea(_aArPCD)
	RestArea(_aArea )

return _cRet
