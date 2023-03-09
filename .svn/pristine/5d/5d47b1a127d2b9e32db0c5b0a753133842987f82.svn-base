#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABG008   ºAutor  ³Angelo Henrique     º Data ³  28/09/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Aviso que será exibido caso o beneficiário possua mais de  º±±
±±º          ³60 anos para a URA MATER e AFINIDADE.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABG008(_cParam1)
	
	Local _aArea		:= GetArea()
	Local _aArBA1		:= BA1->(GetArea())
	Local _aArSZX		:= SZX->(GetArea())
	Local _cRet			:= M->ZX_USUARIO
	Local oFont		:= Nil
	Local nIdade		:= Nil
	Local dDataIni		:= DaySub(dDatabase,15)
	Local dDataFim		:= DaySum(dDatabase,15)
	Local dDataAnive	:= Nil
	Local aMsgs			:= {}
	Local nRow 			:= 0
	Local oModal 
	Local oContainer
	Local nSize			:= 100
	Local cCssInfo := "QLabel {  position: relative;  padding: 0.75rem 1.25rem;  margin-bottom: 1rem; "
	cCssInfo += " border: 1px solid transparent;  border-radius: 0.25rem;  color: #721c24;"
	cCssInfo += "  background-color: #f8d7da;  border-color: #f5c6cb; margin-top: 1rem; text-align:center; "
	cCssInfo += "  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, "
	cCssInfo += " 'Helvetica Neue', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', "
	cCssInfo += " 'Segoe UI Symbol', 'Noto Color Emoji';  font-size: 1rem;  font-weight: 400;  line-height: 1.5;}"

	Default _cParam1	:= "" //Matricula do beneficiário
	
	If cEmpAnt == "01"
		
		DbSelecTArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cParam1 )
			
			//--------------------------------------------------------------------------------------------
			//Solicitado somente para Mater e Afinidade
			//--------------------------------------------------------------------------------------------
			If BA1->BA1_CODEMP $ "0001|0002|0005"

				nIdade := Calc_Idade(ddatabase,BA1->BA1_DATNASC)

				dDataAnive := YearSum(BA1->BA1_DATNASC, nIdade)

				// Se a data de aniversário estiver entre 15 dias atras ou 15 dias a frente 
				If dDataAnive >= dDataIni .AND. dDataAnive <= dDataFim
					
					//Calcula as diferenças de data entre 15 dias atras e o aniversário e tbm 15 dias a frente 
					nQtdDayAnt := IIF(dDataAnive - dDataIni < 0, ((dDataAnive - dDataIni) * -1) , (dDataAnive - dDataIni) )
					
					nQtdDayPos := IIF(dDataAnive - dDataFim < 0, ((dDataAnive - dDataFim) * -1) , (dDataAnive - dDataFim) )

					nDias := IIF(dDataAnive - dDatabase < 0, (dDataAnive - dDatabase) * -1, dDataAnive - dDatabase)
					//Calcula Idade
					If nIdade >= 60
						AADD(aMsgs,{ { || "Beneficiário possui idade igual ou superior a 60 anos!!"} ,Nil})
					EndIf
					//Verifica se o aniversário é hoje
					If dDataAnive == dDatabase
						AADD(aMsgs,{ { || "Hoje é aniversário deste beneficiário!!!"},Nil})
					EndIf
					//Verifica se o aniversário ainda vai acontecer ou já aconteceu
					If nQtdDayAnt < nQtdDayPos 
						AADD(aMsgs,{ { || "O aniversário deste beneficiário foi há " + cValtoChar(nDias) + " dias!!"},Nil})
					Else
						AADD(aMsgs,{ { || "O aniversário deste beneficiário será daqui há " + cValtoChar(nDias) + " dias!!"},Nil})
					EndIf
					
					//Percorre o array adicionando as mensagens
					For nA := 1 To Len(aMsgs)
						
						nSize +=  17 * Len(aMsgs)
						If nA == 1

							oFont     := TFont():New( "Segoe UI",,-16,.T.)
							oModal  := FWDialogModal():New()       
							oModal:SetEscClose(.F.)
							oModal:setTitle("AVISOS")

							oModal:setSize(nSize, 330)
							oModal:createDialog()
							oModal:addCloseButton(nil, "Fechar")
							oContainer := TPanel():New( ,,, oModal:getPanelMain() )
							oContainer:Align := CONTROL_ALIGN_ALLCLIENT

						EndIf

						aMsgs[nA][2] := TSay():New( nRow += 20 ,010, aMsgs[nA][1],oContainer,,oFont,.F.,.F.,.F.,.T.,CLR_HRED,CLR_WHITE,310,016)
						aMsgs[nA][2]:SetCSS(cCssInfo)
												
						If nA == Len(aMsgs)
							oModal:Activate()
						EndIf

					Next

				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArSZX)
	RestArea(_aArBA1)
	RestArea(_aArea )
	
Return _cRet

