#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'UTILIDADES.CH'
#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA040GRV  ºAutor  ³Angelo Henrique     º Data ³  10/10/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado no final da gravação do titulo a   º±±
±±º          ³a receber.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFunção:   ³Criado função executada para o processo de boleto de aluguelº±±
±±º          ³onde é exibido uma tela para preenchimento das naturezas    º±±
±±º          ³e suas respectivas descrições, gravando elas na tabela de   º±±
±±º          ³multi naturezas SEV.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj  			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA040GRV()

	Local _aArea 	:= GetArea()
	Local _aArSE1 	:= SE1->(GetArea())
	Local _aArSEV 	:= SEV->(GetArea())
	Local _aArSED 	:= SED->(GetArea())
	Local _cMvPref	:= GetNewPar("MV_XPRFBOL", "ALG") //Prefixo para identificar que o boleto é de Aluguel

	//------------------------------------------------------------
	//Processo de Boletos encontra-se atualmente na INTEGRAL
	//------------------------------------------------------------
	If cEmpAnt == "02" .And. Upper(AllTrim(SE1->E1_PREFIXO)) == Upper(AllTrim(_cMvPref))

		If MsgYesNo("Este titulo é um boleto Aluguel","Valida Boleto.")

			u_BolAlg()

		EndIf

	EndIf

	RestArea(_aArSED)
	RestArea(_aArSEV)
	RestArea(_aArSE1)
	RestArea(_aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BolAlg    ºAutor  ³Angelo Henrique     º Data ³  10/10/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFunção:   ³Criado função executada para o processo de boleto de aluguelº±±
±±º          ³onde é exibido uma tela para preenchimento das naturezas    º±±
±±º          ³e suas respectivas descrições, gravando elas na tabela de   º±±
±±º          ³multi naturezas SEV.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj  			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BolAlg

	Local nOpc 		:= GD_INSERT+GD_DELETE+GD_UPDATE
	Local _cText1	:= "Prefixo: " + SE1->E1_PREFIXO + "  Numero: " + AllTrim(SE1->E1_NUM) + " Tipo: " + AllTrim(SE1->E1_TIPO)
	Local _cText2	:= "Cliente: " + AllTrim(SE1->E1_CLIENTE) + " - " + AllTrim(SE1->E1_NOMCLI) + " - Valor: " + AllTrim(Transform(SE1->E1_VALOR,"@R 999,999,999.99"))

	Private aCoBrw1 := {}
	Private aHoBrw1 := {}
	Private noBrw1  := 0
	Private oFont1 	:= Nil
	Private oDlg1 	:= Nil
	Private oGrp1 	:= Nil
	Private oSay1 	:= Nil
	Private oSay2 	:= Nil
	Private oBrw1 	:= Nil
	Private oBtn1 	:= Nil
	Private oBtn2 	:= Nil

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oFont1     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 092,232,442,956,"Informações do Boleto de Aluguel",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 004,004,164,352,"     Processo de Boleto de Aluguel     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 016,012,{||_cText1},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,332,008)
	oSay2      := TSay():New( 032,012,{||_cText2},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,332,008)

	//----------------------------------------------
	//Monta o cabeçalho da SEV
	//----------------------------------------------
	MHoBrw1()

	//----------------------------------------------
	//Monta os itens da SEV
	//----------------------------------------------
	MCoBrw1()

	oBrw1      := MsNewGetDados():New(048,008,140,348,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oGrp1,aHoBrw1,aCoBrw1 )

	oBtn1      := TButton():New( 144,300,"CANCELAR"	,oGrp1,{||oDlg1:End()			}	,037,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 144,252,"GRAVAR"	,oGrp1,{||GrvSED(),oDlg1:End()	}	,037,012,,,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

Return

//ÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//Function  ³ MHoBrw1() - Monta aHeader da MsNewGetDados para o Alias:
//ÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Static Function MHoBrw1()

	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("SEV",.T.)

	Do While ( !SX3->(Eof()) .And. SX3->X3_ARQUIVO == "SEV" )
		If ( X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL )
			If !(ALLTRIM(SX3->X3_CAMPO) $ "EV_FILIAL|EV_PARC|EV_RATEICC|EV_IDDOC|EV_PERC")

				noBrw1 ++

				AADD(aHoBrw1,{ AllTrim(X3Titulo()),;
					SX3->X3_CAMPO,;
					SX3->X3_PICTURE,;
					SX3->X3_TAMANHO,;
					SX3->X3_DECIMAL,;
					SX3->X3_VALID,;
					SX3->X3_USADO,;
					SX3->X3_TIPO,;
					SX3->X3_F3,;
					SX3->X3_CONTEXT,;
					SX3->X3_CBOX,;
					SX3->X3_RELACAO,;
					SX3->X3_WHEN,;
					SX3->X3_VISUAL,;
					SX3->X3_VLDUSER,;
					SX3->X3_PICTVAR,;
					SX3->X3_OBRIGAT})

			Endif
		Endif
		dbSkip()
	EndDo

Return


//ÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//Function  ³ MCoBrw1() - Monta aCols da MsNewGetDados para o Alias:
//ÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Static Function MCoBrw1()
	
	Local nI		:= 0
	Local cQuery 	:= ""
	Local cSelect 	:= ""
	Local _cAlias 	:= GetNextAlias()
	Local aBuffer 	:= {}	
	Local _aAreSEV	:= SEV->(GetArea())

	For nI := 1 to len(aHoBrw1)

		If aHoBrw1[nI][10] != 'V'

			cSelect += aHoBrw1[nI][2] + ','

		EndIf
	Next

	cSelect := left(cSelect,len(cSelect)-1)

	cQuery := "SELECT													" + CRLF
	cQuery += "   " + cSelect											  + CRLF
	cQuery += "FROM														" + CRLF
	cQuery += "    " + RetSqlName("SEV") + " SEV 						" + CRLF
	cQuery += "WHERE													" + CRLF
	cQuery += "    SEV.EV_FILIAL 		= '" + SE1->E1_FILIAL 	+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_PREFIXO 	= '" + SE1->E1_PREFIXO 	+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_NUM 		= '" + SE1->E1_NUM 		+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_PARCELA 	= '" + SE1->E1_PARCELA 	+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_TIPO 		= '" + SE1->E1_TIPO 	+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_CLIFOR 	= '" + SE1->E1_CLIENTE 	+ "' 	" + CRLF
	cQuery += "    AND SEV.EV_LOJA 		= '" + SE1->E1_LOJA 	+ "' 	" + CRLF
	cQuery += "    AND SEV.D_E_L_E_T_   = ' '							" + CRLF

	TcQuery cQuery New Alias _cAlias

	If !_cAlias->(EOF())

		_cAlias->(DbGoTop())

		While !_cAlias->(EOF())

			aBuffer := {}

			For nI := 1 to len(aHoBrw1)

				cCpo 	:= aHoBrw1[nI][2]

				If aHoBrw1[nI][8] == 'D'
					aAdd(aBuffer,StoD(_cAlias->&cCpo))

				ElseIf aHoBrw1[nI][10] == 'V'

					DbSelectArea("SED")
					DbSetOrder(1)
					If DbSeek(xFilial("SED") + _cAlias->EV_NATUREZ)

						aAdd(aBuffer,AllTrim(SED->ED_DESCRIC))

					Else

						aAdd(aBuffer," ")

					EndIf

				Else
					aAdd(aBuffer,_cAlias->&cCpo)
				EndIf
			Next

			aAdd(aBuffer,.F.)

			aAdd(aCoBrw1,aBuffer)

			_cAlias->(DbSkip())

		EndDo

	Else

		Aadd(aCoBrw1,Array(noBrw1+1))
		For nI := 1 To noBrw1
			aCoBrw1[1][nI] := CriaVar(aHoBrw1[nI][2])
		Next
		aCoBrw1[1][noBrw1+1] := .F.

	EndIf

	_cAlias->(DbCloseArea())

	RestArea(_aAreSEV)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvSED    ºAutor  ³Angelo Henrique     º Data ³  10/10/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá incluir as informações na tabela de multi    º±±
±±º          ³naturezas.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj  			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvSED

	Local _aArea 	:= GetArea()
	Local _aArSEV	:= SEV->(GetArea())
	Local _ni		:= 0
	Local _nPosVal	:=  aScan(aHoBrw1,{|x|AllTrim(x[2]) == "EV_VALOR" 	})
	Local _nPosnNat	:=  aScan(aHoBrw1,{|x|AllTrim(x[2]) == "EV_NATUREZ" })
	Local _lAchou	:= .F.
	Local _aBkpAc	:= oBrw1:aCols

	For _ni:= 1 To Len(_aBkpAc)

		If !_aBkpAc[_ni][Len(aHoBrw1)+1]

			If _aBkpAc[_ni][_nPosVal] <> 0 .And. !(Empty(_aBkpAc[_ni][_nPosnNat]))

				DbSelectArea("SEV")
				DbSetOrder(1) //EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_NATUREZ
				_lAchou := DbSeek(xFilial("SEV") + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)+_aBkpAc[_ni][_nPosnNat])

				RecLock("SEV", !_lAchou )

				SEV->EV_FILIAL	:= xFilial("SEV")
				SEV->EV_PREFIXO	:= SE1->E1_PREFIXO
				SEV->EV_NUM		:= SE1->E1_NUM
				SEV->EV_PARCELA	:= SE1->E1_PARCELA
				SEV->EV_CLIFOR	:= SE1->E1_CLIENTE
				SEV->EV_LOJA	:= SE1->E1_LOJA
				SEV->EV_TIPO	:= SE1->E1_TIPO
				SEV->EV_VALOR	:= _aBkpAc[_ni][_nPosVal]
				SEV->EV_NATUREZ	:= _aBkpAc[_ni][_nPosnNat]
				SEV->EV_RECPAG	:= "R"
				SEV->EV_PERC	:= 0
				SEV->EV_RATEICC	:= "2"
				SEV->EV_IDENT	:= "1"

				SEV->(MsUnLock())

			EndIf

		Else

			DbSelectArea("SEV")
			DbSetOrder(1) //EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_NATUREZ
			If DbSeek(xFilial("SEV") + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)+_aBkpAc[_ni][_nPosnNat])

				RecLock("SEV", .F. )

				DbDelete()

				SEV->(MsUnLock())

			EndIf

		EndIf

	Next _ni

	RestArea(_aArSEV)
	RestArea(_aArea	)

Return