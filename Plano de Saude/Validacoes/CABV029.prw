#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV028  ºAutor  ³Angelo Henrique     º Data ³  27/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação para exibir mensagem caso o beneficiário tenha    º±±
±±º          ³bloqueio do tipo temporário (aquele que não é encaminhado   º±±
±±º          ³ para a ANS).                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV029(_cParam1)

	Local _aArea 		:= GetArea()
	Local _lRet			:= .T.	
	Local _cPln			:= ""
	Local _cMatric		:= ""
	Local _cMsg			:= GetNewPar("MV_XBLQTMP","Favor visualizar a situação deste beneficiário com o setor de Cadastro.")
	
	Default _cParam1	:= "1" //1 - Internação (BE4) || 2 - Autorização/Liberação (BE1) 

	If _cParam1 == "1"
	
		_cMatric = M->BE4_USUARI
	
	Else
	
		_cMatric = M->BE1_USUARI
	
	EndIf


	//Validação para saber se o beneficiário selecionado esta bloqueado.
	If !Empty(_cMatric)

		//Reforço o ponteramento na tabela
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cMatric)

			If cEmpAnt == "01"

				_cPln = "509|563" 

			Else

				_cPln = "765|749"

			EndIf

			If !(Empty(BA1->BA1_DATBLO)) .AND. BA1->BA1_MOTBLO $ _cPln

				Aviso("Atenção",_cMsg,{"OK"})

			EndIf

		EndIf

	EndIf

	RestArea(_aArea)

Return _lRet