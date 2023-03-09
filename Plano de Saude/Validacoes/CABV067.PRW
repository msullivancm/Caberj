#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV067  º Autor ³ Frederico O. C. Jr  º Data   ³ 31/08/22 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ 	* Validar se matricula é odontológica				      º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABV067(cMatric, lForcar, cCampo)

Local aArea		:= GetArea()
Local lRet		:= .T.
Local cMatVid	:= ""
Local aMatric	:= {}
Local cMatNew	:= Space(17)

// Campos para montar browse em caso de mais de um matricula assistencial
Local aStruct	:= {}
Local oTempTab	:= FWTemporaryTable():New("TMP")
Local i			:= 0
Local aCampos	:= {}
Local oDlgCP
Local oMark
Local lInverte	:= .F.
Local cMark		:= GetMark()
Local oButton1
Local oButton2

Default lForcar	:= .F.
Default cCampo	:= ""

if !empty(cMatric)

	BA1->(DbSetOrder(2))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	if BA1->(DbSeek(xFilial("BA1") + cMatric ))

		cMatVid	:= BA1->BA1_MATVID

		BI3->(DbSetOrder(1))	// BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
		if BI3->(DbSeek(xFilial("BI3") + BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO) ))

			if BI3->BI3_CODSEG == '004'		// Odontológico

				lRet	:= .F.

				BA1->(DbSetOrder(7))	// BA1_FILIAL+BA1_MATVID
				if BA1->(DbSeek(xFilial("BA1") + cMatVid ))

					while BA1->(!EOF()) .and. BA1->BA1_MATVID == cMatVid

						if empty(BA1->BA1_MOTBLO) .or. BA1->BA1_DATBLO > ddatabase

							BI3->(DbSetOrder(1))	// BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
							if BI3->(DbSeek(xFilial("BI3") + BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO) ))

								if BI3->BI3_CODSEG <> '004'		// Odontológico

									aAdd( aMatric, { .F., BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO), BA1->BA1_CODPLA, AllTrim(BI3->BI3_DESCRI) })

								endif

							endif

						endif
						
						BA1->(DbSkip())
					end

				endif

				if !lForcar		// Não permite forçar (rotinas de Liberação/Autorização SADT e Internação)

					if len(aMatric) == 0

						alert("A matricula informada pertence a um plano ODONTOLÓGICO e este beneficiário não possui um plano ASSISTENCIAL ativo, logo não poderá seguir com o lançamento da guia.")
					
					elseif len(aMatric) > 1

						Alert("A matricula informada pertence a um plano ODONTOLÓGICO e este beneficiário possui mais de um plano ASSISTENCIAL ativo."		+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
								"Por favor selecionar qual matricula assistencial gostaria de seguir com o atendimento.")

						aAdd(aStruct, {'OK'			, TamSX3('C1_OK')[3], TamSX3('C1_OK')[1], TamSX3('C1_OK')[2]	})
						aAdd(aStruct, {'MATRICULA'	, "C"				, 17				, 0						})
						aAdd(aStruct, {'PRODUTO'	, "C"				, 04				, 0						})
						aAdd(aStruct, {'DESCRICAO'	, "C"				, 60				, 0						})
						
						oTempTab:SetFields( aStruct )
						oTempTab:AddIndex("01", {"MATRICULA"})
						oTempTab:Create()
						
						for i := 1 to len(aMatric)
						
							RecLock("TMP", .T.)
								TMP->MATRICULA	:= aMatric[i][2]
								TMP->PRODUTO	:= aMatric[i][3]
								TMP->DESCRICAO	:= aMatric[i][4]
							TMP->(MsUnLock())
						
						next
						
						TMP->(DbGoTop())
						
						// Criar cabeçalho dos campos na tela
						aAdd(aCampos, {'OK'			, , ""			, GetSx3Cache('C1_OK', 'X3_PICTURE')	})
						aAdd(aCampos, {'MATRICULA'	, , "Matricula"	, ""									})
						aAdd(aCampos, {'PRODUTO'	, , "Produto"	, ""									})
						aAdd(aCampos, {'DESCRICAO'	, , "Descrição"	, ""									})
						
						// Montar tela
						DEFINE MSDIALOG oDlgCP TITLE OemToAnsi("Pesquisa Beneficiário") FROM 0,0 TO 350,500 PIXEL
						
							oMark := MsSelect():New("TMP", "OK", "", aCampos, lInverte, cMark, {010,010,150,243},,,oDlgCP,,)
							oMark:oBrowse:lCanAllMark := .T.
							oMark:oBrowse:lHasMark	  := .T.
							
							DEFINE SBUTTON oButton1 FROM 158, 090 TYPE 01 OF oDlgCP ENABLE ACTION ( cMatNew := CAPV067A(), oDlgCP:End() )
							DEFINE SBUTTON oButton2 FROM 158, 130 TYPE 02 OF oDlgCP ENABLE ACTION oDlgCP:End()

						ACTIVATE DIALOG oDlgCP CENTERED
						
						oTempTab:Delete()

						if !empty(cMatNew)

							&("M->" + cCampo ) := cMatNew
							lRet	:= .T.

						endif

					elseif len(aMatric) == 1

						cMatNew	:= aMatric[1][2]
						MsgInfo("A matricula informada pertence a um plano ODONTOLÓGICO, logo a mesma será sustituída pela ASSISTENCIAL."		+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
									"Matricula: "	+ Transform(cMatNew, "@R 9999.9999.999999.99-9")											+ CHR(13)+CHR(10) +;
									"Plano: "		+ aMatric[1][3] + " - " + AllTrim(aMatric[1][4]) )
						
						&("M->" + cCampo ) := cMatNew
						lRet	:= .T.
						
					endif
				
				else			// Permite forçar - Protocolo de atendimento

					lRet	:= .T.

					if len(aMatric) == 0

						MsgInfo("INFORMATIVO: a matricula informada pertence a um plano ODONTOLÓGICO, porém o mesmo não possui plano ASSISTENCIAL ativo.")
					
					elseif len(aMatric) > 1

						if !MsgYesNo("A matricula informada é de um plano ODONTOLÓGICO, porém este beneficiário possui mais de um plano ASSISTENCIAL ativo." + CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
										"Deseja prosseguir o atendimento com a matricula odontológica (SIM) ou substituir por uma das matriculas assistenciais (NÃO)?")

							aAdd(aStruct, {'OK'			, TamSX3('C1_OK')[3], TamSX3('C1_OK')[1], TamSX3('C1_OK')[2]	})
							aAdd(aStruct, {'MATRICULA'	, "C"				, 17				, 0						})
							aAdd(aStruct, {'PRODUTO'	, "C"				, 04				, 0						})
							aAdd(aStruct, {'DESCRICAO'	, "C"				, 60				, 0						})
							
							oTempTab:SetFields( aStruct )
							oTempTab:AddIndex("01", {"MATRICULA"})
							oTempTab:Create()
							
							for i := 1 to len(aMatric)
							
								RecLock("TMP", .T.)
									TMP->MATRICULA	:= aMatric[i][2]
									TMP->PRODUTO	:= aMatric[i][3]
									TMP->DESCRICAO	:= aMatric[i][4]
								TMP->(MsUnLock())
							
							next
							
							TMP->(DbGoTop())
							
							// Criar cabeçalho dos campos na tela
							aAdd(aCampos, {'OK'			, , ""			, GetSx3Cache('C1_OK', 'X3_PICTURE')	})
							aAdd(aCampos, {'MATRICULA'	, , "Matricula"	, ""									})
							aAdd(aCampos, {'PRODUTO'	, , "Produto"	, ""									})
							aAdd(aCampos, {'DESCRICAO'	, , "Descrição"	, ""									})
							
							// Montar tela
							DEFINE MSDIALOG oDlgCP TITLE OemToAnsi("Pesquisa Beneficiário") FROM 0,0 TO 350,500 PIXEL
							
								oMark := MsSelect():New("TMP", "OK", "", aCampos, lInverte, cMark, {010,010,150,243},,,oDlgCP,,)
								oMark:oBrowse:lCanAllMark := .T.
								oMark:oBrowse:lHasMark	  := .T.
								
								DEFINE SBUTTON oButton1 FROM 158, 090 TYPE 01 OF oDlgCP ENABLE ACTION ( cMatNew := CAPV067A(), oDlgCP:End() )
								DEFINE SBUTTON oButton2 FROM 158, 130 TYPE 02 OF oDlgCP ENABLE ACTION oDlgCP:End()

							ACTIVATE DIALOG oDlgCP CENTERED
							
							oTempTab:Delete()

							if !empty(cMatNew)

								&("M->" + cCampo ) := cMatNew
							
							endif

						endif

					elseif len(aMatric) == 1

						cMatNew	:= aMatric[1][2]

						if !MsgYesNo("A matricula informada é de um plano ODONTOLÓGICO, porém este beneficiário possui um plano ASSISTENCIAL ativo."			+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
										"Matricula: "	+ Transform(cMatNew, "@R 9999.9999.999999.99-9")														+ CHR(13)+CHR(10)					+;
										"Plano: "		+ aMatric[1][3] + " - " + AllTrim(aMatric[1][4])														+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
										"Deseja prosseguir o atendimento com a matricula odontológica (SIM) ou substituir pela matricula assistencial (NÃO)?"										 )
						
							&("M->" + cCampo ) := cMatNew
						
						endif

					endif

				endif

			endif

		endif

	endif

endif

RestArea(aArea)

return lRet


// Tratamento do markbrowse para retornar o selecionado
Static Function CAPV067A()

Local cRet		:= Space(17)
Local nCont		:= 0

TMP->(DbGoTop())
while !TMP->(EOF())

	if TMP->(Marked("OK"))
		cRet := TMP->MATRICULA
		nCont++
	endif
	
	TMP->(DbSkip())
end

if nCont == 0
	MsgInfo("Nenhuma matricula selecionada!")
elseif nCont > 1
	MsgInfo("Selecionar somente uma matricula!")
	cRet		:= Space(17)
endif

return cRet
