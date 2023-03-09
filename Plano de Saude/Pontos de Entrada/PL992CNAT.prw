/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSAUT02  ºAutor  ³Microsiga           º Data ³  02/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina destinada a implementar criticas relativas a mudanca º±±
±±º          ³de fase e autorizacoes.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL992CNAT
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis da rotina...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Local cGrpGer	:= ParamIxb[1]
Local cNature	:= ParamIxb[2]
Local cRecon	:= ParamIxb[3]
Local cRefer	:= ParamIxb[4]
Local cUF		:= ParamIxb[5]
Local cTpPlan	:= ParamIxb[6]
Local cSegmen	:= ParamIxb[7]
Local cNovaNat	:= cNature
Local aAreaBR8	:= BR8->(GetArea())

If Select("BD7QRY") > 0

	If cNature $ "A999,I999"
	
		BR8->(DbSetOrder(1)) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
		If BR8->(MsSeek(xFilial("BR8")+BD7QRY->(BD7_CODPAD+BD7_CODPRO)))
	
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

Endif

RestArea(aAreaBR8)

Return cNovaNat