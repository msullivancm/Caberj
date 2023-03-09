/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL992DNAT ºAutor  ³Microsiga           º Data ³  02/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada que modificara o item que nao foi classifi-º±±
±±º          ³cado pela rotina do sip, devido a problemas na base.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL992DNAT
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis da rotina...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Local aAreaBR8 := BR8->(GetArea())

Local cNature := ParamIxb[1]
Local cCodOpe := ParamIxb[2]
Local cCodLdp := ParamIxb[3]
Local cCodPeg := ParamIxb[4]
Local cNumero := ParamIxb[5]
Local cOriMov := ParamIxb[6]
Local cSequen := ParamIxb[7]
Local cCodPad := ParamIxb[8]
Local cCodPro := ParamIxb[9]
Local cNovaNat:= cNature

If cNature $ "A999,I999"

	BR8->(DbSetOrder(1)) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
	If BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

		If cNature=="A999" 
			If Empty(BR8->BR8_CLASIP) .And. !Empty(BR8->BR8_CLASP2)
				cNovaNat := BR8->BR8_CLASP2
			Endif
		Else
			If Empty(BR8->BR8_CLASP2) .And. !Empty(BR8->BR8_CLASIP)
				cNovaNat := BR8->BR8_CLASIP
			Endif
		Endif

		If Empty(cNovaNat)
			cNovaNat := "AZZZ"		
		Endif
	Else
		cNovaNat := "AZZZ"
	Endif
		
Endif

RestArea(aAreaBR8)

Return cNovaNat