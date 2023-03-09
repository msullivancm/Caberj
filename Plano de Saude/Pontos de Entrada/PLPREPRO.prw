#Include 'topconn.ch'
#Include 'RWMAKE.CH'
#Include 'PROTHEUS.CH'
#Include 'TOTVS.CH'
#DEFINE CRLF Chr(13)+Chr(10)

#define __aCdCri537 {"537", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "537", 1)}
#define __aCdCri739 {"739", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "739", 1)}
#define __aCdCri740 {"740", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "740", 1)}
#define __aCdCri741 {"741", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "741", 1)}
#define __aCdCri742 {"742", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "742", 1)}
#define __aCdCri792 {"792", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "792", 1)}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLPREPRO บAutor  ณMicrosiga           บ Data ณ  10/09/19    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Ponto de entrada para para manipular o retorno do		  บฑฑ
ฑฑบ          ณ	pre-processamento de xml. 					 			  บฑฑ
ฑฑบ          ณ	DEVE SER COMPILADO SEMPRE NO REMOTE E NO RPO DO HAT		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PLPREPRO()

Local aArea				:= GetArea()
Local aAreaBE4			:= BE4->(GetArea())
Local aAreaBAU			:= BAU->(GetArea())
Local aAreaBTU			:= BTU->(GetArea())
Local aAreaBTQ			:= BTQ->(GetArea())

Local aRet				:= PARAMIXB[1]
Local cCodRDA			:= PARAMIXB[1][2]
Local oXml				:= nil
Local oXmlGuias			:= nil
Local cError			:= ""
Local cWarning			:= ""
Local cGuiaOper			:= ""
Local cGuiaPrestador	:= ""
Local cMatricXML		:= ""
Local cSenhaXML			:= ""
Local lTemSolic			:= .F.
Local cMatric			:= ""
Local cPrest			:= ""
Local aDesCritic		:= {}
Local nX				:= 0
Local nY				:= 0
Local aDadosXML 		:= aClone(aDados)			// aDados - Objeto p๚blico que possui a composi็ใo do XML
Local nXOld				:= 0
Local lErroCID			:= .F.
Local nDiasEnt			:= 0
Local aDataProc			:= {}
Local nPeriod			:= 0
Local dTmpDtBs			:= dDataBase
Local aMatrics			:= {}
Local lMatNor			:= .F.
Local lAchaConv			:= .F.
Local cMatricOld		:= ""
Local lConvenio			:= .F.
Local lJanela			:= .F.
local lValZerado 		:= .F.

Default cARQXML			:= ""						// Variavel Publica com Caminho do XML a partir do RootPath - se nใo tiver schema variavel nใo ้ preenchida


if cCodRDA <> '999997'		// Nใo aplicar crํticas em guias de reciprocidade (filtrado atrav้s da RDA - CABERJ RECIPROCIDADE)

	oXml 	:= XmlParserFile( cARQXML, "_", @cError, @cWarning )

	if cTipGui3X == '01'		// CONSULTA
		oXmlGuias := oXml:_ANS_MENSAGEMTISS:_ANS_PRESTADORPARAOPERADORA:_ANS_LOTEGUIAS:_ANS_GUIASTISS:_ANS_GUIACONSULTA
	elseif cTipGui3X == '02'	// SP/SADT
		oXmlGuias := oXml:_ANS_MENSAGEMTISS:_ANS_PRESTADORPARAOPERADORA:_ANS_LOTEGUIAS:_ANS_GUIASTISS:_ANS_GUIASP_SADT
	elseif cTipGui3X == '03'	// SOLIC. INTERNACAO
		oXmlGuias := oXml:_ANS_MENSAGEMTISS:_ANS_PRESTADORPARAOPERADORA:_ANS_LOTEGUIAS:_ANS_GUIASTISS:_ANS_GUIASOLICITACAOINTERNACAO
	elseif cTipGui3X == '05'	// RESUMO DE INTERNACAO
		oXmlGuias := oXml:_ANS_MENSAGEMTISS:_ANS_PRESTADORPARAOPERADORA:_ANS_LOTEGUIAS:_ANS_GUIASTISS:_ANS_GUIARESUMOINTERNACAO
	elseif cTipGui3X == '06'	// HONORARIO
		oXmlGuias := oXml:_ANS_MENSAGEMTISS:_ANS_PRESTADORPARAOPERADORA:_ANS_LOTEGUIAS:_ANS_GUIASTISS:_ANS_GUIAHONORARIOS
	endif

	// Validar se existe guia de solicita็ใo de interna็ใo para guias de resumo de interna็ใo ou honorแrio m้dico
	if PLSPOSGLO(PlsIntPad(), __aCdCri739[1], __aCdCri739[2], "2")		// Checar se crํtica estแ ativa no Protheus

		if cTipGui3X $ '05|06'

			if ValType(oXmlGuias) == "O"

				lTemSolic	:= .F.
				aDesCritic	:= {}
				cGuiaOper	:= oXmlGuias:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT

				if ValType(XmlChildEx(oXmlGuias,"_ANS_DADOSCONTRATADOEXECUTANTE")) == "O"
					cSenhaXML	:= oXmlGuias:_ANS_SENHA:TEXT
					cMatricXML	:= oXmlGuias:_ANS_BENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
				else
					cSenhaXML	:= oXmlGuias:_ANS_DADOSAUTORIZACAO:_ANS_SENHA:TEXT
					cMatricXML	:= oXmlGuias:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
				endif

				BE4->(DbSetOrder(7))	// BE4_FILIAL+BE4_SENHA
				if BE4->(DbSeek(xFilial("BE4") + AllTrim(cSenhaXML) )) .and. !empty(cSenhaXML)

					while BE4->(!EOF()) .and. AllTrim(cSenhaXML) == AllTrim(BE4->BE4_SENHA)

						if BE4->BE4_TIPGUI == '03' .and. BE4->BE4_CODLDP == '0000'

							cMatric		:= AllTrim(BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO))
							cPrest		:= AllTrim(BE4->BE4_CODRDA)
							exit
						
						endif

						BE4->(DbSkip())
					end
				
				endif

				if cTipGui3X == '05'

					if AllTrim(cMatricXML) == AllTrim(cMatric) .and. AllTrim(cCodRDA) == AllTrim(cPrest)
						lTemSolic	:= .T.
					endif
				
				elseif cTipGui3X == '06'

					if AllTrim(cMatricXML) == AllTrim(cMatric)
						lTemSolic := .T.
					endif
				
				endif

				if !lTemSolic

					// busco a critica do DE-PARA com a terminologia
					BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
					if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri739[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
						endif
					
					endif
					
					// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
					if len(aDesCritic) == 0

						BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
						if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri739[1] ))

							BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
							if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
								aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
							else
								aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
							endif
						
						endif
					
					endif

					if len(aDesCritic) == 0
						aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
						aAdd(aDesCritic, "Descri็ใo: Numero da senha de autorizacao enviada invalida")
					endif

					aAdd(aDesCritic, " * Senha informada: "		+ AllTrim(cSenhaXML)  )
					aAdd(aDesCritic, " * Guia informada: "		+ AllTrim(cGuiaOper)  )
					aAdd(aDesCritic, " * Matricula informada: "	+ AllTrim(cMatricXML) )
					aAdd(aDesCritic, Replicate('-', 80) )
					aAdd(aDesCritic, "" )

					aRet := AddCritica(aRet, aDesCritic)

				endif
			
			else

				for nX := 1 to Len(oXmlGuias)

					lTemSolic	:= .F.
					aDesCritic	:= {}
					cGuiaOper	:= oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT

					if valtype(XmlChildEx(oXmlGuias[nX],"_ANS_DADOSCONTRATADOEXECUTANTE")) == "O"
						cSenhaXML	:= oXmlGuias[nX]:_ANS_SENHA:TEXT
						cMatricXML	:= oXmlGuias[nX]:_ANS_BENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
					else
						cSenhaXML	:= oXmlGuias[nX]:_ANS_DADOSAUTORIZACAO:_ANS_SENHA:TEXT
						cMatricXML	:= oXmlGuias[nX]:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
					endif

					BE4->(DbSetOrder(7))	// BE4_FILIAL+BE4_SENHA
					if BE4->(DbSeek(xFilial("BE4") + AllTrim(cSenhaXML) )) .and. !empty(cSenhaXML)

						while BE4->(!EOF()) .and. AllTrim(cSenhaXML) == AllTrim(BE4->BE4_SENHA)

							if BE4->BE4_TIPGUI == '03' .and. BE4->BE4_CODLDP == '0000'

								cMatric		:= AllTrim(BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO))
								cPrest		:= AllTrim(BE4->BE4_CODRDA)
								exit
							
							endif

							BE4->(DbSkip())
						end
					
					endif

					if cTipGui3X == '05'

						if AllTrim(cMatricXML) == AllTrim(cMatric) .and. AllTrim(cCodRDA) == AllTrim(cPrest)
							lTemSolic	:= .T.
						endif
					
					elseif cTipGui3X == '06'

						if AllTrim(cMatricXML) == AllTrim(cMatric)
							lTemSolic := .T.
						endif
					
					endif

					if !lTemSolic

						// busco a critica do DE-PARA com a terminologia
						BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
						if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri739[1] ))

							BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
							if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
								aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
							endif
						
						endif
						
						// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
						if len(aDesCritic) == 0

							BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
							if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri739[1] ))

								BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
								if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
									aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
									aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
								else
									aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
									aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
								endif
							
							endif
						
						endif

						if len(aDesCritic) == 0
							aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
							aAdd(aDesCritic, "Descri็ใo: Numero da senha de autorizacao enviada invalida")
						endif

						aAdd(aDesCritic, " * Senha informada: "		+ AllTrim(cSenhaXML)  )
						aAdd(aDesCritic, " * Guia informada: "		+ AllTrim(cGuiaOper)  )
						aAdd(aDesCritic, " * Matricula informada: "	+ AllTrim(cMatricXML) )
						aAdd(aDesCritic, Replicate('-', 80) )
						aAdd(aDesCritic, "" )

						aRet := AddCritica(aRet, aDesCritic)
					
					endif
				
				next nX
			
			endif
		
		endif
	
	endif

	// Validar se CID estแ informado e ้ vแlido no Protheus
	if PLSPOSGLO(PlsIntPad(), __aCdCri537[1], __aCdCri537[2], "2")		// Checar se crํtica estแ ativa no Protheus

		if cTipGui3X $ '03|05'

			for nX := 1 to Len(aDadosXML)

				lErroCID := .F.

				if Upper(AllTrim(aDadosXML[nX,1])) == "NUMEROGUIAPRESTADOR"
					if !empty(AllTrim(aDadosXML[nX,3]))
						nXOld		:= nX
						cGuiaOper	:= AllTrim(aDadosXML[nX,3])
					endif
				endif

				if Upper(AllTrim(aDadosXML[nX,1])) == "DIAGNOSTICO" .and. AllTrim(aDadosXML[nXOld,3]) == cGuiaOper
					if empty(AllTrim(aDadosXML[nX,3]))
						lErroCID	:= .T.
					else

						BA9->(DbSetOrder(1))	// BA9_FILIAL+BA9_CODDOE
						if !BA9->(DbSeek( xFilial("BA9") + AllTrim(aDadosXML[nX,3]) ))
							lErroCID	:= .T.
						endif
					
					endif
				
				endif

				if lErroCID

					aDesCritic	:= {}

					// busco a critica do DE-PARA com a terminologia
					BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
					if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri537[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
						endif

					endif

					// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
					if len(aDesCritic) == 0

						BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
						if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri537[1] ))

							BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
							if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
								aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
							else
								aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
							endif
						
						endif

					endif

					if len(aDesCritic) == 0
						aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
						aAdd(aDesCritic, "Descri็ใo: CID nใo informado ou invalido.")
					endif

					aAdd(aDesCritic, " * CID informado: "		+ AllTrim(aDadosXML[nX,3])  )
					aAdd(aDesCritic, " * Guia informada: "		+ AllTrim(cGuiaOper)  )
					aAdd(aDesCritic, Replicate('-', 80) )
					aAdd(aDesCritic, "" )

					aRet := AddCritica(aRet, aDesCritic)

				endif
			
			next nX
		
		endif
	
	endif

	// Valida็ใo de faturamento fora da data e/ou data do atendimento fora da regra de faturamento da operadora
	if PLSPOSGLO(PlsIntPad(), __aCdCri740[1], __aCdCri740[2], "2") .or. PLSPOSGLO(PlsIntPad(), __aCdCri741[1], __aCdCri741[2], "2") .or. PLSPOSGLO(PlsIntPad(), __aCdCri792[1], __aCdCri792[2], "2")

		if cTipGui3X $ '01|02|03|05|06'

			// Buscando dias para entrega deste prestador
			BAU->(DbSetOrder(1))	// BAU_FILIAL+BAU_CODIGO
			if BAU->(DbSeek(xFilial("BAU") + cCodRDA ))
				nDiasEnt := Val(AllTrim(BAU->BAU_XPRENT))
			endif

			if !empty(BXX->BXX_DATMOV)
				dTmpDtBs	:= BXX->BXX_DATMOV
			else
				dTmpDtBs	:= dDataBase
			endif

			// buscar se esta dentro da janela de envio de XML
			lJanela	:= U_ChecaComp(cCodRDA, dTmpDtBs)

			if ValType(oXmlGuias) == "O"

				if cTipGui3X == '01'
					cGuiaOper	:= oXmlGuias:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT
				else
					cGuiaOper := oXmlGuias:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT
				endif

				if XmlChildEx( oXmlGuias, "_ANS_PROCEDIMENTOSEXECUTADOS") <> nil
					if Valtype(oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO) == "O"
						aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO:_ANS_DATAEXECUCAO:TEXT})

						IF XmlChildEx( oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO, "_ANS_VALORUNITARIO") <> nil
							if oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO:_ANS_VALORUNITARIO:TEXT <= "0.00"
								lValZerado := .T.	
								cGuiaPrestador += CRLF + oXmlGuias:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "	
							endif
						ENDIF

					else
						for nY := 1 to Len(oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO)
							aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY]:_ANS_DATAEXECUCAO:TEXT})

							IF XmlChildEx( oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY], "_ANS_VALORUNITARIO") <> nil
								if oXmlGuias:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY]:_ANS_VALORUNITARIO:TEXT <= "0.00"
									lValZerado := .T.	
									cGuiaPrestador += CRLF + oXmlGuias:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "	
								endif
							ENDIF

						next nY
					endif
				endif

				if XmlChildEx( oXmlGuias,"_ANS_OUTRASDESPESAS") <> nil
					if Valtype(oXmlGuias:_ANS_OUTRASDESPESAS:_ANS_DESPESA) == "O"
						aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_OUTRASDESPESAS:_ANS_DESPESA:_ANS_SERVICOSEXECUTADOS:_ANS_DATAEXECUCAO:TEXT})
					else
						for nY := 1 to Len(oXmlGuias:_ANS_OUTRASDESPESAS:_ANS_DESPESA)
							aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_OUTRASDESPESAS:_ANS_DESPESA[nY]:_ANS_SERVICOSEXECUTADOS:_ANS_DATAEXECUCAO:TEXT})
						next nY
					endif
				endif

				if cTipGui3X == '01'

					if XmlChildEx( oXmlGuias, "_ANS_DADOSATENDIMENTO") <> nil
						if Valtype(oXmlGuias:_ANS_DADOSATENDIMENTO) == "O"
							aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_DADOSATENDIMENTO:_ANS_DATAATENDIMENTO:TEXT})

							IF XmlChildEx( oXmlGuias:_ANS_DADOSATENDIMENTO, "_ANS_PROCEDIMENTO") <> nil
								IF XmlChildEx( oXmlGuias:_ANS_DADOSATENDIMENTO:_ANS_PROCEDIMENTO, "_ANS_VALORPROCEDIMENTO") <> nil
									if oXmlGuias:_ANS_DADOSATENDIMENTO:_ANS_PROCEDIMENTO:_ANS_VALORPROCEDIMENTO:TEXT <= "0.00"
										lValZerado := .T.
										cGuiaPrestador += CRLF + oXmlGuias:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "	
									endif
								ENDIF
							ENDIF

						else
							for nY := 1 to Len(oXmlGuias:_ANS_DADOSATENDIMENTO)
								aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias:_ANS_DADOSATENDIMENTO[nY]:_ANS_DATAATENDIMENTO:TEXT})

								IF XmlChildEx( oXmlGuias:_ANS_DADOSATENDIMENTO[nY], "_ANS_PROCEDIMENTO") <> nil
									IF XmlChildEx( oXmlGuias:_ANS_DADOSATENDIMENTO[nY]:_ANS_PROCEDIMENTO, "_ANS_VALORPROCEDIMENTO") <> nil
										if oXmlGuias:_ANS_DADOSATENDIMENTO[nY]:_ANS_PROCEDIMENTO:_ANS_VALORPROCEDIMENTO:TEXT <= "0.00"
											lValZerado := .T.	
											cGuiaPrestador += CRLF + oXmlGuias:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "	
										endif
									ENDIF
								ENDIF
							next nY
						endif
					endif
				
				endif
			
			else

				for nX := 1 to Len(oXmlGuias)

					if cTipGui3X == '01'
						cGuiaOper	:= oXmlGuias[nX]:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT
					else
						cGuiaOper	:= oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT
					endif

					if XmlChildEx( oXmlGuias[nX], "_ANS_PROCEDIMENTOSEXECUTADOS") <> nil
						if Valtype(oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO) == "O"
							aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO:_ANS_DATAEXECUCAO:TEXT})

							IF XmlChildEx( oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO, "_ANS_VALORUNITARIO") <> nil
								if oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO:_ANS_VALORUNITARIO:TEXT <= "0.00"
									lValZerado := .T.
									cGuiaPrestador += CRLF + oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "
								endif
							ENDIF

						else
							for nY := 1 to Len(oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO)
								aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY]:_ANS_DATAEXECUCAO:TEXT})

								IF XmlChildEx( oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY], "_ANS_VALORUNITARIO") <> nil
									if oXmlGuias[nX]:_ANS_PROCEDIMENTOSEXECUTADOS:_ANS_PROCEDIMENTOEXECUTADO[nY]:_ANS_VALORUNITARIO:TEXT <= "0.00"
										lValZerado := .T.	
										cGuiaPrestador += CRLF + oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "
									endif
								ENDIF
							next nY
						endif
					endif

					if XmlChildEx( oXmlGuias[nX], "_ANS_OUTRASDESPESAS") <> nil
						if Valtype(oXmlGuias[nX]:_ANS_OUTRASDESPESAS:_ANS_DESPESA) == "O"
							aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias[nX]:_ANS_OUTRASDESPESAS:_ANS_DESPESA:_ANS_SERVICOSEXECUTADOS:_ANS_DATAEXECUCAO:TEXT})
						else
							for nY := 1 to Len(oXmlGuias[nX]:_ANS_OUTRASDESPESAS:_ANS_DESPESA)
								aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias[nX]:_ANS_OUTRASDESPESAS:_ANS_DESPESA[nY]:_ANS_SERVICOSEXECUTADOS:_ANS_DATAEXECUCAO:TEXT})
							next nY
						endif
					endif

					if cTipGui3X == '01'

						if XmlChildEx (oXmlGuias[nX],"_ANS_DADOSATENDIMENTO") <> nil
							if Valtype(oXmlGuias[nX]:_ANS_DADOSATENDIMENTO) == "O"
								aAdd(aDataProc, {cGuiaOper, cCodRDA, oXmlGuias[nX]:_ANS_DADOSATENDIMENTO:_ANS_DATAATENDIMENTO:TEXT})

								IF XmlChildEx( oXmlGuias[nX]:_ANS_DADOSATENDIMENTO, "_ANS_PROCEDIMENTO") <> nil
									IF XmlChildEx( oXmlGuias[nX]:_ANS_DADOSATENDIMENTO:_ANS_PROCEDIMENTO, "_ANS_VALORPROCEDIMENTO") <> nil
										if oXmlGuias[nX]:_ANS_DADOSATENDIMENTO:_ANS_PROCEDIMENTO:_ANS_VALORPROCEDIMENTO:TEXT <= "0.00"
											lValZerado := .T.	

											if cTipGui3X == '01'
												cGuiaPrestador+= CRLF +  oXmlGuias[nX]:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT  + " || "
											else
												cGuiaPrestador += CRLF +  oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT  + " || "
											endif

										endif
									ENDIF
								ENDIF
							else
								for nY := 1 to Len(oXmlGuias[nX]:_ANS_DADOSATENDIMENTO)
									aAdd(aDataProc,{cGuiaOper,cCodRDA,oXmlGuias[nX]:_ANS_DADOSATENDIMENTO[nY]:_ANS_DATAATENDIMENTO:TEXT})

									IF XmlChildEx( oXmlGuias[nX]:_ANS_DADOSATENDIMENTO[nY], "_ANS_PROCEDIMENTO") <> nil
										IF XmlChildEx( oXmlGuias[nX]:_ANS_DADOSATENDIMENTO[nY]:_ANS_PROCEDIMENTO, "_ANS_VALORPROCEDIMENTO") <> nil
											if oXmlGuias[nX]:_ANS_DADOSATENDIMENTO[nY]:_ANS_PROCEDIMENTO:_ANS_VALORPROCEDIMENTO:TEXT <= "0.00"
												lValZerado := .T.	
												cGuiaPrestador += CRLF + oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT + " || "
											endif
										ENDIF
									ENDIF
								next nY
							endif
						endif
					
					endif
				
				next nX
			
			endif

			if lValZerado
				if PLSPOSGLO(PlsIntPad(), __aCdCri792[1], __aCdCri792[2], "2")

					aDesCritic	:= {}

					// busco a critica do DE-PARA com a terminologia
					BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
					if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri792[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
							IF !EMPTY(cGuiaPrestador)
								aAdd(aDesCritic, "Guia(s): " + cGuiaPrestador)
							ENDIF
						endif

					endif

					// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
					if len(aDesCritic) == 0

						BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
						if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri792[1] ))

							BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
							if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
								aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
								IF !EMPTY(cGuiaPrestador)
									aAdd(aDesCritic, "Guia(s): " + cGuiaPrestador)
								ENDIF
							else
								aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
								IF !EMPTY(cGuiaPrestador)
									aAdd(aDesCritic, "Guia(s): " + cGuiaPrestador)
								ENDIF
							endif
						
						endif

					endif

					if len(aDesCritic) == 0
						aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
						aAdd(aDesCritic, "Descri็ใo: O VALOR DO EVENTO ESTA IGUAL OU MENOR QUE ZERO.")
						IF !EMPTY(cGuiaPrestador)
							aAdd(aDesCritic, "Guia(s): " + cGuiaPrestador)
						ENDIF
					endif

					aRet := AddCritica(aRet, aDesCritic)

				endif
			endif

			if PLSPOSGLO(PlsIntPad(), __aCdCri740[1], __aCdCri740[2], "2")

				aDesCritic	:= {}

				// busco a critica do DE-PARA com a terminologia
				BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
				if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri740[1] ))

					BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
					if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
						aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
						aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
					endif

				endif

				// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
				if len(aDesCritic) == 0

					BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
					if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri740[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
						else
							aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
						endif
					
					endif

				endif

				if len(aDesCritic) == 0
					aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
					aAdd(aDesCritic, "Descri็ใo: FATURAMENTO FORA DA DATA")
				endif

				aAdd(aDesCritic, " * Qtde de dias limite: "	+ AllTrim(str(nDiasEnt)) )

				for nX := 1 to Len(aDataProc)

					// Critica de Data Limite de Entrega de Faturamento
					nPeriod	:= date() - StoD(Replace(aDataProc[nX,3],'-',''), 'yyyymmdd')
					if nPeriod > nDiasEnt

						aAdd(aDesCritic, Replicate('-', 40) )
						aAdd(aDesCritic, " -> Guia informada: "	+ aDataProc[nX,1] )
						aAdd(aDesCritic, " -> Data informada: "	+ DtoC(StoD(Replace(aDataProc[nX,3],'-',''), 'yyyymmdd')) + " (" + AllTrim(str(nPeriod)) + " dias)"	)
						
					endif

				next nX

				if len(aDesCritic) > 3

					aAdd(aDesCritic, Replicate('-', 80) )
					aAdd(aDesCritic, "" )

					aRet := AddCritica(aRet, aDesCritic)

				endif

			endif

			if lJanela

				if PLSPOSGLO(PlsIntPad(), __aCdCri741[1], __aCdCri741[2], "2")

					aDesCritic	:= {}

					// busco a critica do DE-PARA com a terminologia
					BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
					if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri741[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
						endif

					endif

					// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
					if len(aDesCritic) == 0

						BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
						if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri741[1] ))

							BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
							if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
								aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
							else
								aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
								aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
							endif
						
						endif

					endif

					if len(aDesCritic) == 0
						aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
						aAdd(aDesCritic, "Descri็ใo: DATA DE ATENDIMENTO FORA DA REGRA DE FATURAMENTO DA OPERADORA")
					endif

					for nX := 1 to Len(aDataProc)

						// Crํtica de valida็ใo data de procedimento x compet๊ncia de faturamento
						if SubS(Replace(aDataProc[nX,3],'-',''), 1, 6) == SubS(DtoS(dTmpDtBs), 1, 6)

							aAdd(aDesCritic, Replicate('-', 40) )
							aAdd(aDesCritic, " -> Guia informada: "	+ aDataProc[nX,1]											)
							aAdd(aDesCritic, " -> Data informada: "	+ DtoC(StoD(Replace(aDataProc[nX,3],'-',''), 'yyyymmdd'))	)

						endif
					
					next nX

					if len(aDesCritic) > 2

						aAdd(aDesCritic, Replicate('-', 80) )
						aAdd(aDesCritic, "" )

						aRet := AddCritica(aRet, aDesCritic)

					endif

				endif

			endif

		endif

	endif


	// Crํtica de valida็ใo da matrํcula reciprocidade x faturamento
	if PLSPOSGLO(PlsIntPad(), __aCdCri742[1], __aCdCri742[2], "2")

		if cEmpAnt == "01"

			iF cTipGui3X == '01'

				if ValType(oXmlGuias) == "O"
					cGuiaOper	:= oXmlGuias:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT
					cMatricXML	:= oXmlGuias:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
					aAdd(aMatrics, {cGuiaOper, cMatricXML})
				else
					for nX := 1 to len(oXmlGuias)
						cGuiaOper	:= oXmlGuias[nX]:_ANS_CABECALHOCONSULTA:_ANS_NUMEROGUIAPRESTADOR:TEXT
						cMatricXML	:= oXmlGuias[nX]:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
						aAdd(aMatrics, {cGuiaOper, cMatricXML})
					next nX
				endif
			
			elseif cTipGui3X $ '02|03|05|06'

				if ValType(oXmlGuias) == "O"

					cGuiaOper := oXmlGuias:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT
					if valtype(XmlChildEx(oXmlGuias,"_ANS_DADOSCONTRATADOEXECUTANTE")) == "O"
						cMatricXML	:= oXmlGuias:_ANS_BENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
					else
						cMatricXML	:= oXmlGuias:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
					endif
					aAdd(aMatrics, {cGuiaOper, cMatricXML})
				
				else

					for nX := 1 to len(oXmlGuias)

						cGuiaOper := oXmlGuias[nX]:_ANS_CABECALHOGUIA:_ANS_NUMEROGUIAPRESTADOR:TEXT
						if valtype(XmlChildEx(oXmlGuias[nX],"_ANS_DADOSCONTRATADOEXECUTANTE")) == "O"
							cMatricXML	:= oXmlGuias[nX]:_ANS_BENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
						else
							cMatricXML	:= oXmlGuias[nX]:_ANS_DADOSBENEFICIARIO:_ANS_NUMEROCARTEIRA:TEXT
						endif
						aAdd(aMatrics, {cGuiaOper, cMatricXML})
					
					next nX
				
				endif
			
			endif

			lMatNor		:= .F.
			lAchaConv	:= .F.

			for nY := 1 to Len(aMatrics)

				if SubS(aMatrics[nY,2],1,8) <> '00010004'
					lMatNor		:= .T.
				endif

				if SubS(aMatrics[nY,2],1,8) == '00010004' .and. !empty(cMatricOld) .and. cMatricOld <> aMatrics[nY,2]
					lAchaConv := .T.
				endif

				// Valida็ใo para corre็ใo na reciprocidade, pois quando ้ um arquivo de conv๊nio estava criticando da mesma forma
				if lMatNor .and. lAchaConv
					lConvenio	:= .T.
					exit
				endif

				cMatricOld	:= aMatrics[nY,2]
			
			next nY

			if lConvenio

				aDesCritic	:= {}

				// busco a critica do DE-PARA com a terminologia
				BTU->(DbSetOrder(4))	// BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
				if BTU->(DbSeek( xFilial("BTU") + "38" + xFilial("BCT") + __aCdCri742[1] ))

					BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
					if BTQ->(DbSeek( xFilial("BTQ") + BTU->(BTU_CODTAB+BTU_CDTERM) ))
						aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
						aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
					endif

				endif

				// Se nใo achou no de-para (bsucar direto no cadastro de motivo de critica)
				if len(aDesCritic) == 0

					BCT->(DbSetOrder(1))	// BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
					if BCT->(DbSeek( xFilial("BCT") + PlsIntPad() + __aCdCri742[1] ))

						BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						if BTQ->(DbSeek( xFilial("BTQ") + "38" + BCT->BCT_GLTISS )) .and. !empty(BCT->BCT_GLTISS)
							aAdd(aDesCritic, "** ERRO [" + AllTrim(BTQ->BTQ_CDTERM) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BTQ->BTQ_DESTER))
						else
							aAdd(aDesCritic, "** ERRO [" + AllTrim( BCT->(BCT_PROPRI+BCT_CODGLO) ) + "] **")
							aAdd(aDesCritic, "Descri็ใo: " + AllTrim(BCT->BCT_DESCRI))
						endif
					
					endif

				endif

				if len(aDesCritic) == 0
					aAdd(aDesCritic, "** ERRO [" + iif(cEmpAnt == '01', "CABERJ", "INTEGRAL") + "] **")
					aAdd(aDesCritic, "Descri็ใo: EXISTE MATRICULA DE RECIPROCIDADE JUNTA DAS DEMAIS")
				endif

				aAdd(aDesCritic, Replicate('-', 80) )
				aAdd(aDesCritic, "" )

				aRet := AddCritica(aRet, aDesCritic)

			endif
		
		endif

	endif

endif

RestArea(aAreaBTU)
RestArea(aAreaBTQ)
RestArea(aAreaBAU)
RestArea(aAreaBE4)
RestArea(aArea)

return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAddCriticaบAutor  ณMicrosiga           บ Data ณ  10/09/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Adicionar critica na matriz de retorno do PE			  บฑฑ
ฑฑบ          ณ							 					 			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AddCritica(aRet, aCriticas)

Local i		:= 0

if !aRet[1]		// Se ainda nใo tem critica (marcar que importa็ใo foi criticado)
	aRet[1]		:= .T.
endif

for i := 1 to len(aCriticas)

	aAdd( aRet[3], aCriticas[i] )

next

return aRet
