#INCLUDE 'PROTHEUS.CH' 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV009   ºAutor  ³Leonardo Portella   º Data ³  26/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao dos campos BD5_USUARI e ZZQ_CODBEN, impedindo que º±±
±±º          ³sejam selecionadas matriculas de Reciprocidade eventual na  º±±
±±º          ³digitacao de contas medicas e no reembolso.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV009(cCampo)

Local oDlg1		:= Nil
Local oGrp1		:= Nil
Local oBmp1		:= Nil
Local oSay1		:= Nil
Local oSay2		:= Nil
Local oSay3		:= Nil
Local oSay4		:= Nil
Local oSBtn1	:= Nil
Local aArea		:= GetArea()
Local aAreaBA1	:= BA1->(GetArea())   
Local lRet		:= .T. 
Local oFont		:= TFont():New('Courier New',,14,.T.)  
Local cMatric	:= ""

Default cCampo	:= "BD5_USUARI"

cMatric := &('M->' + cCampo)

BA1->(DbSetOrder(2))//BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO

If BA1->(DbSeek(xFilial('BA1') + cMatric))

	if BA1->BA1_XTPBEN == 'RECIPR' .or. (cEmpAnt == '01' .and. BA1->BA1_CODEMP $ '0004|0009')

		lRet 	:= .F.

		oDlg1	:= MsDialog():New( 095,232,301,630,If(cEmpAnt == '01','Caberj','Integral'),,,.F.,,,,,,.T.,,,.T. )
		
		oGrp1	:= TGroup():New( 008,012,064,190,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
		
		oBmp1	:= TBitmap():New( 016,016,10,10,,"BR_LARANJA",.F.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )

		oSay1	:= TSay():New( 016,030,{||"Matrícula de Reciprocidade"},oGrp1,,oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,144,012)
		oSay2	:= TSay():New( 036,016,{||"A matrícula " + AllTrim(M->BD5_USUARI) + " (" + 	AllTrim(Capital(BA1->BA1_NOMUSR)) + ")"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
		oSay3	:= TSay():New( 044,016,{||"informada é de reciprocidade."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
		oSay4	:= TSay():New( 052,016,{||"Favor verificar a matrícula e a empresa selecionada."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
		
		oSBtn1	:= SButton():New( 076,164,1,{||oDlg1:End()},oDlg1,,"", )
		
		oDlg1:Activate(,,,.T.)
	
	endif

EndIf
	
BA1->(RestArea(aAreaBA1))
RestArea(aArea)

Return lRet
