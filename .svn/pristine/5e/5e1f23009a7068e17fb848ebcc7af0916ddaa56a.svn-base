#include "PROTHEUS.CH"
#include 'TOTVS.CH'
#include 'TOPCONN.CH'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Objeto     ³ PLCALCEV    ³ Autor ³ Jean Schulz           ³ Data ³ 12/04/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o  ³ Tratamento para desconto de determinados RDAs.   			   ³±±
±±³            ³ Obs: nunca arredondar o retorno do ponto de entrada. Ja       ³±±
±±³            ³ tratado pelo programa original que chama.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ MP8           					                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLCALCEV()

Local aArea			:= GetArea()
Local aAreaBD5		:= BD5->(GetArea())
Local aAreaB44		:= B44->(GetArea())
Local aAreaB45		:= BD5->(GetArea())
Local aAreaBAU		:= BAU->(GetArea())
Local aAreaBA1		:= BA1->(GetArea())
Local aAreaBA3		:= BA3->(GetArea())

Local lCobCoPart	:= paramixb[ 1]			// Indica se é pagamento ou cobrança
//Local lCompra		:= paramixb[ 2]			// Na cobrança, indica se é compra ou mudanca de fase
Local nVlrTot		:= paramixb[ 3]			// Total acumulado do aRet
Local aRet			:= paramixb[ 4]			// Matriz que contem a composição de valores dos itens
Local cCodInt		:= paramixb[ 5]			// Operadora
Local aRdas			:= paramixb[ 6]			// Dados da Rda
Local cCodPad		:= paramixb[ 7]			// Tabela
Local cCodPro		:= paramixb[ 8]			// Procedimento
//Local cCodPla		:= paramixb[ 9]			// Plano
//Local nQtd		:= paramixb[10]			// Qtd. Procedimento
Local dDatPro		:= paramixb[11]			// Data Procedimento
Local aDadUsr		:= paramixb[12]			// Array de Usuario
//Local nVlrApr		:= paramixb[13]			// Valor Apresentado
//Local cChaveLib	:= paramixb[14]			// Chave de Liberação

Local cCodRda		:= ""
Local cGrpCob		:= ""

Local cCodTabTMP	:= '024'			// tabela default
Local aRetVazio	    := {}
Local nFatMul		:= 1
Local nPerAplic		:= 100
Local nAcuPac		:= 0
Local lUsrInte		:= .F.
Local nValUs		:= 0
Local nValUCO		:= 0
Local nValFil		:= 0
Local nValBanda		:= 0
Local nTotNaoBlq	:= paramixb[3]
Local nValReemb		:= 0
Local nPercBD7		:= 0
Local nTotJaAjus	:= 0

Local nInd			:= 1
Local nPos			:= 1
Local nPos2			:= 2
Local nCont			:= 0
Local nCont2		:= 0
Local aAux			:= {}
Local cDtInte		:= ""
Local cDtAlta		:= ""
Local cHtml			:= ""
Local xCont 		:= 0
Local aVetCpPag		:= StrTokarr( AllTrim(M->B45_YCPPAG) , ",")
Local nCt			:= 0
Local nPosCpPag		:= 0
Local cTpEve		:= ""
Local cAcomod		:= ""
Local cFtTxt		:= ""
Local cTpTab		:= ""
Local cDesTab		:= ""
Local lDtIncIn		:= .F.

if Alltrim(FunName()) $ "PLSA001|PLSA001A"
	cCodRda	:= M->B44_CODRDA
else
	cCodRda	:= BD6->BD6_CODRDA
endif

// Parametro MV_YOPAVLC guarda os codigos de Operadora (BA0) de Intercambio
// Somente efetuado o processamento do PE operadora da RDA diferente de intercambio
BAU->(DbSetOrder(1))
BAU->(DbSeek(xFilial("BAU") + cCodRda ))

if !(trim(BAU->BAU_CODOPE) $ GetNewPar("MV_YOPAVLC",""))

	if !lCobCoPart .and. !(Alltrim(FunName()) $ "PLSA987|PLSA001|PLSA001A")

		for nInd := 1 to Len(aRet)

			for nPos := 1 to Len(aRet[nInd,5])

				nPos2 := aScan(aRdas, { |x| Alltrim(x[1]) == Alltrim(aRet[nInd,1]) } )

				if nPos2 > 0

					nPerAplic	:= BuscaPerApl(aRdas[nPos2,2], cCodPad, cCodPro, dDatPro)

					if nPerAplic <> 100

						aRet[nInd,5,nPos,4] := noround(aRet[nInd,5,nPos,4]*(nPerAplic/100),2)
					
					endif

					nAcuPac += aRet[nInd,5,nPos,4]
				
				endif
			
			next
		
		next

		nVlrTot := nAcuPac
	
	elseif Alltrim(FunName()) $ "PLSA001|PLSA001A"			// Tratar valorizacao especifica para reembolso

		// 01/08/19: BIANCHINI - Tratamento para não ser chamado na Lupa da Composição do Procedimento
		if !IsInCallStack('U_LISTBOXMAR')

			lUsrInte	:= .F.
			aAux		:= PLSUSRINTE(aDadUsr[02], M->B45_DATPRO, M->B45_HORPRO, .F., .F., "BD5")

			if valtype(aAux) == "A"
				lUsrInte := aAux[1]
			endif

			// Setar que tem coparticipação
			if lUsrInte .or. (!empty(M->B44_REGINT))
				M->B45_YRGATE	:= '2'  // Internação
			else
				M->B45_YRGATE	:= '1'  //Ambulatorial
				if empty(M->B45_ABATPF)
					M->B45_ABATPF	:= '1'
				endif
			endif

			//BIANCHINI - 13/12/2013 - Tratamento para somente posicionar quando realmente o regime for internação
			if lUsrInte .and. M->B44_YSENHA <> " "

				// Carrega data e hora para checagem no final da rotina para procedimentos fora do intervalo de internação
				cDtInte	:= Posicione("BE4", 7, xFilial("B44") + M->B44_YSENHA, "DTOS(BE4_DATPRO)")
				cDtAlta	:= Posicione("BE4", 7, xFilial("B44") + M->B44_YSENHA, "DTOS(BE4_DTALTA)")

				//Validacao de Datas para o Procedimento
				if !( DtoS(M->B45_DATPRO) >= cDtInte .and. DtoS(M->B45_DATPRO) <= cDtAlta )  .and. cDtAlta <> " "

					Alert("Você informou data do procedimento incompatível com a senha: " + AllTrim(M->B44_YSENHA) + ". Favor corrigir e valorar novamente.")
					nVlrTot		:= 0
					aRet		:= aRetVazio
					lDtIncIn	:= .T.
				
				endif
			
			endif
			
			if !lDtIncIn

				cGrpCob	:= U_BuscaGrupCob(PLSINTPAD(), cCodPad, cCodPro)

				if AllTrim(funname()) == "PLSA001A"

					cTpEve	:= BOW->BOW_XTPEVE
					cAcomod	:= BOW->BOW_PADINT

				endif

				// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> ZZZ -> B7T)
				aTbReem		:= U_RtTbReem(aDadUsr, cGrpCob, cCodPad, cCodPro, cTpEve, cAcomod, dDatPro)
				
				if aTbReem[1] <> 1		// Não existe na matriz de reembolso

					cHtml := '<div style="font-family:Courier New">'
					cHtml += '<br><b><font color="#0000FF" style="font-size:14px">Sem regra parametrizada na Matriz de Reembolso!</font></b>' + '<br>'
					cHtml += '<br>Empresa:'				+ Replicate("&nbsp;",12) + '<b><font color="#FF0000">' + SubStr(aDadUsr[2],5,4)	+ '</font></b>'
					cHtml += '<br>Contrato:'			+ Replicate("&nbsp;",11) + '<b><font color="#FF0000">' + aDadUsr[9]				+ '</font></b>'
					cHtml += '<br>Subcontrato:'			+ Replicate("&nbsp;",08) + '<b><font color="#FF0000">' + aDadUsr[41]			+ '</font></b>'
					cHtml += '<br>Produto:'				+ Replicate("&nbsp;",12) + '<b><font color="#FF0000">' + aDadUsr[11]			+ '</font></b>'
					cHtml += '<br>Grupo de Cobertura:'	+ Replicate("&nbsp;",01) + '<b><font color="#FF0000">' + cGrpCob				+ '</font></b>'
					cHtml += "</div>"
					MsgInfo(cHtml)
				
				endif

				// Verificar se identificou parametrização válida de reembolso
				if aTbReem[1] <> 0

					// A query pode retornar mais de uma regra (porém a mesma vem ordenada por precedência - a primeira sendo a regra mais forte)
					cCodTabTMP		:= aTbReem[2][1]
					nFatMul			:= M->B45_YFTREE	// iif(aTbReem[2][2] <> 0, aTbReem[2][2], 1)
					nValUS			:= aTbReem[2][3]
					nValUCO			:= aTbReem[2][4]
					nValFil			:= aTbReem[2][5]
					nValBanda		:= aTbReem[2][6]

					cTpTab			:= iif(aTbReem[2][7]==1, "TDE Honorário/Evento", iif(aTbReem[2][7]==2, "TDE Porte Anestésico", iif(aTbReem[2][7]==3, "TDE Demais Eventos", "TDE Reembolso x Operadora")) )
					cDesTab			:= AllTrim(Posicione("BF8",1,xFilial("BF8") + PlsIntPad() + cCodTabTMP, "BF8_DESCM"))

					if aTbReem[2][2] <> 0 .and. aTbReem[2][2] <> M->B45_YFTREE
						cFtTxt	:= '<font color="#FF0000">' + AllTrim(str(nFatMul  )) + ' (forçado)'
					else
						cFtTxt	:= '<font color="#006400">' + AllTrim(str(nFatMul  ))
					endif

					// Buscar percentual caso tenha tratamento de Via de Acesso
					BGR->(DbSetOrder(1))	// BGR_FILIAL+BGR_CODINT+BGR_CODVIA
					if BGR->(DbSeek( xFilial("BGR") + cCodInt + M->B45_VIA )) .and. !empty(M->B45_VIA)
						nPerAplic	:= BGR->BGR_PERC
					endif

					// Alert informativo da parametrização de reembolso
					cHtml := '<div style="font-family:Courier New">'
					cHtml += '<br><b><font color="#0000FF" style="font-size:18px">Parametrização de Pagamento do Reembolso:</font></b>' + '<br>'

					cHtml += '<br>Tipo de Tabela:'			+ Replicate("&nbsp;",06) + '<b><font color="#2F4F4F">' +			cTpTab				+ '</font></b>'

					cHtml += '<br>TDE de Reembolso:'		+ Replicate("&nbsp;",04) + '<b><font color="#006400">' + cCodTabTMP + " - " + cDesTab	+ '</font></b>'
					cHtml += '<br>Fator Multiplicador:' 	+ Replicate("&nbsp;",01) + '<b>' +									cFtTxt				+ '</font></b>'
					if nValBanda > 0
						cHtml += '<br>Banda:'				+ Replicate("&nbsp;",15) + '<b><font color="#006400">' + AllTrim(str(nValBanda))		+ '</font></b>'
					endif
					if nValUS > 0
						cHtml += '<br>US (Valor do CH):'	+ Replicate("&nbsp;",04) + '<b><font color="#006400">' + AllTrim(str(nValUS   ))		+ '</font></b>'
					endif
					if nValUCO > 0
						cHtml += '<br>UCO:'					+ Replicate("&nbsp;",17) + '<b><font color="#006400">' +  AllTrim(str(nValUCO))			+ '</font></b>'
					endif
					if nValFil > 0
						cHtml += '<br>Filme:'				+ Replicate("&nbsp;",15) + '<b><font color="#006400">' +  AllTrim(str(nValFil))			+ '</font></b>'
					endif
					if !empty(M->B45_VIA) .and. nPerAplic > 0
						cHtml += '<br>Perc. Via Acesso:'	+ Replicate("&nbsp;",04) + '<b><font color="#006400">' + AllTrim(str(nPerAplic))		+ '</font></b>'
					endif
					cHtml += "</div>"
					MsgInfo(cHtml)
				
				endif

				M->B45_MATRIC	:= M->B44_USUARI
				M->B45_EST		:= M->B44_UFATE
				M->B45_CODMUN	:= M->B44_MUNATE
				M->B44_SENHA	:= M->B44_YSENHA
				
				BEGIN SEQUENCE

					nVlrTot		:= 0
					nTotNaoBlq	:= nTotNaoBlq * nFatMul

					// ====================== Retirado do PLSVLRPRO.PRW =====================//
					// Retorno da função                                                     //
					// 1  => Conteudo do vetor aRet:                                         //
					//     1  => Unidade de Medida que foi calculada                         //
					//     2  => Unidade de Valor em que a Unidade de Medida foi calculada   //
					//     3  => .T. ou .F. se foi calculado corretamente                    //
					//     4  => Mensagem caso nao tenha sido calculado corretamente         //
					//     5  => Valor calculado                                             //
					//     6  => Codigo da Mensagem(Glosa)                                   //
					// 2  => Valor total do evento                                           //
					//=======================================================================//

					for xCont := 1 to Len(aRet)

						if AllTrim(aRet[xCont,1]) $ "UCO" .and. !empty(aRet[xCont,5])

							if nValUCO == 0						// se não tenho UCO customizada (pego a padrão)
								nValUCO	:= aRet[xCont,5,1,3]
							endif

							if nValBanda > 0
								BD3->(DbSetOrder(1))	// BD3_FILIAL+BD3_CODIGO
								if BD3->(DbSeek( xFilial("BD3") + "UCO" ))
									if BD3->BD3_CONSBD == '1'	// considera banda no cálculo do UCO
										aRet[xCont,5,1,9]	:= nValBanda
									endif
								endif
							endif

							nTotNaoBlq	-= aRet[xCont,5,1,4]	// retiro valor antes do ajuste do total

							aRet[xCont,5,1,3]	:= nValUCO
							nValReemb			:= NoRound( (aRet[xCont,5,1,1] * aRet[xCont,5,1,3] * nFatMul * M->B45_QTDPRO * (aRet[xCont,5,1,9]/100)) * (nPerAplic/100),2 )
							aRet[xCont,5,1,4]	:= nValReemb
							aRet[xCont,5,1,5]	:= nValReemb

							nTotNaoBlq	+= aRet[xCont,5,1,4]	// retorno valor do UCO após acerto da conta
						
						endif

					next xCont


					for nCont := 1 to Len(aVetCpPag)

						for nCont2 := 1 to Len(aRet)

							nPos := 0

							if Substr(aVetCpPag[nCont],1,3) <> "AUX"

								if Alltrim(aRet[nCont2,1]) == AllTrim(aVetCpPag[nCont])
									nPos	:= nCont2
									nCont2	:= Len(aRet)
								endif
							
							else

								if Alltrim(aRet[nCont2,1]) == Substr(aVetCpPag[nCont],1,3) .and. aRet[nCont2,15] == Substr(aVetCpPag[nCont],4)
									nPos	:= nCont2
									nCont2	:= Len(aRet)
								endif
							
							endif
						
						next nCont2

						if nPos > 0
							aDel(aRet,nPos)
							aSize(aRet,Len(aRet)-1)
						endif
					
					next nCont
				
					// Tratar composicoes que estao bloqueadas, caso o valor forcado seja usado
					if M->B45_YVLFOR > 0

						if Len(aVetCpPag) > 0

							for nCt := 1 to Len(aRet)

								nPosCpPag	:= aScan(aVetCpPag, iif(aRet[nCt,1] == "AUX", aRet[nCt,1]+StrZero(aRet[nCt,5,1,4],2), aRet[nCt,1]) )

								if nPosCpPag > 0
									nTotNaoBlq -= aRet[nCt,5,1,4]
								endif
							
							next
						
						endif

					endif

					for nInd := 1 to Len(aRet)

						if aRet[nInd,3] .and. M->B45_YVLFOR > 0

							if nInd < Len(aRet)

								nPercBD7			:= Round(aRet[nInd,5,1,4] * (100/nTotNaoBlq), 2)
								aRet[nInd,5,1,4]	:= M->B45_YVLFOR * (nPercBD7/100)
								aRet[nInd,5,1,5]	:= M->B45_YVLFOR * (nPercBD7/100)
								nTotJaAjus			+= aRet[nInd,5,1,4]

							else

								aRet[nInd,5,1,4]	:= M->B45_YVLFOR - nTotJaAjus
								aRet[nInd,5,1,5]	:= M->B45_YVLFOR - nTotJaAjus
							
							endif

						endif

						nVlrTot	+= aRet[nInd,5,1,4]

					next nInd
					
				
				END SEQUENCE

			endif

		endif
	
	endif

endif

RestArea(aAreaBD5)
RestArea(aAreaB44)
RestArea(aAreaB45)
RestArea(aAreaBAU)
RestArea(aAreaBA1)
RestArea(aAreaBA3)
RestArea(aArea)

return {nVlrTot,aRet}


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BuscaPerAplºAutor  ³ Jean Schulz       º Data ³  12/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Buscar percentual de pagamento relativo ao procedimento    º±±
±±º          ³ cfme tabela especifica do cliente.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaPerApl(cCodRDA, cCodPad, cCodPro, dDatPro)

Local nRet	:= 100

ZZO->(DbSetOrder(1))
if ZZO->(DbSeek(xFilial("ZZO") + cCodRDA))

	while ZZO->(!EOF()) .and. ZZO->ZZO_CODRDA == cCodRDA

		if (ZZO->ZZO_VIGINI <= dDatPro) .and. ((!Empty(ZZO->ZZO_VIGFIN) .and. ZZO->ZZO_VIGFIN >= dDatPro) .or. Empty(ZZO->ZZO_VIGFIN))

			// Caso nao tenha sido parametrizado procedimento, obter percentual.
			if Empty(ZZO->ZZO_CODPAD) .and. Empty(ZZO->ZZO_CODPRO)
				nRet := ZZO->ZZO_PERCEN
			endif

			// Tratar procedimentos por grupo, subgrupo e item
			if Substr(ZZO->ZZO_CODPRO,3,5) == "00000"

				if cCodPad+Substr(cCodPro,1,2) == ZZO->ZZO_CODPAD+Substr(ZZO->ZZO_CODPRO,1,2)
					nRet := ZZO->ZZO_PERCEN
					exit
				endif
			
			elseif Substr(ZZO->ZZO_CODPRO,5,3) == "000"

				if cCodPad+Substr(cCodPro,1,4) == ZZO->ZZO_CODPAD+Substr(ZZO->ZZO_CODPRO,1,4)
					nRet := ZZO->ZZO_PERCEN
					exit
				endif
			
			else

				if cCodPad+cCodPro == ZZO->(ZZO_CODPAD+ZZO_CODPRO)
					nRet := ZZO->ZZO_PERCEN
					exit
				endif
			
			endif
		
		endif

		ZZO->(DbSkip())
	end

endif

return nRet
