#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV028  ºAutor  ³Angelo Henrique     º Data ³  27/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação para exibir a tela de Exceções para o contrato e  º±±
±±º          ³subcontrato.                                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV028(_cParam1,_cParam2)

	Local _aArea 	:= GetArea()
	Local _aArBG9	:= BG9->(GetArea())
	Local _aArBQC	:= BQC->(GetArea())
	Local _cMsg1	:= ""
	Local _cMsg2	:= ""
	Local _cMatric	:= ""	
	Local _lRet		:= .T.

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oFont1","oDlg1","oGrp1","oMGet1","oGrp2","oMGet2","oBtn1")

	Default _cParam1	:= "1" //1 - Validação || 2 - Visualização
	Default _cParam2	:= "1" //1 - Tela de Protocolo || 2 - Tela de Internação

	If _cParam2 = '1'
		
		_cMatric := M->ZX_USUARIO

	Else

		_cMatric := M->BE4_USUARI		

	EndIf

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cMatric)

		DbSelectArea("BT5")
		DbSetOrder(1)//BT5_FILIAL+BT5_CODINT+BT5_CODIGO+BT5_NUMCON+BT5_VERSAO
		If DbSeek(xFilial("BT5") + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_CONEMP + BA1->BA1_VERCON)

			_cMsg1 := BT5->BT5_XOBS 

		EndIf


		DbSelectArea("BQC")
		DbSetOrder(1) //BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
		If DbSeek(xFilial("BQC") + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_CONEMP + BA1->BA1_VERCON + BA1->BA1_SUBCON + BA1->BA1_VERSUB)

			_cMsg2 := BQC->BQC_XOBS 

		EndIf


		If !Empty(_cMsg1) .OR. !Empty(_cMsg2)

			/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
			±± Definicao do Dialog e todos os seus componentes.                        ±±
			Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
			oFont1     := TFont():New( "Times New Roman",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
			oDlg1      := MSDialog():New( 092,232,699,927,"Validação de Exceções - Contrato e SubContrato",,,.F.,,,,,,.T.,,,.T. )
			oGrp1      := TGroup():New( 008,004,128,336,"  Exceções Contrato  ",oDlg1,CLR_BLUE,CLR_WHITE,.T.,.F. )	

			oMGet1     := TMultiGet():New( 024,012,{|u| If(PCount()>0,_cMsg1:=u,_cMsg1)},oGrp1,316,092,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
			oMGet1:lReadOnly := .T.
			oMGet1:GoTop()

			oGrp2      := TGroup():New( 136,004,264,336,"  Exceções SubContrato  ",oDlg1,CLR_BLUE,CLR_WHITE,.T.,.F. )
			oMGet2     := TMultiGet():New( 152,012,{|u| If(PCount()>0,_cMsg2:=u,_cMsg2)},oGrp2,316,104,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
			oMGet2:lReadOnly := .T.
			oMGet2:GoTop()

			oBtn1      := TButton():New( 272,300,"OK",oDlg1,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

			oDlg1:Activate(,,,.T.)

		Else			

			If _cParam1 = '2'

				Aviso("Atenção","Não existem exceções cadastradas para o contrato ou subcontrato.",{"OK"})

			EndIf			

		EndIf

	Else

		Aviso("Atenção","Não existem exceções cadastradas para o contrato ou subcontrato.",{"OK"})

	EndIf

	RestArea(_aArBQC)
	RestArea(_aArBG9)
	RestArea(_aArea)

Return _lRet