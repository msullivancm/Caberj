#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS260DGR º Autor ³ Frederico O. C. Jr º Data ³  14/06/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  PE acionado apos a gravacao da BA1 e BA3 na familia/	  º±±
±±º          ³  usuario recebendo os dados passados pelo PE PLS260AGR. 	  º±±
±±º          ³  Utilizado para identificar os beneficiários que foram     º±±
±±º          ³  incluídos na movimentação e gerar carência. Caso altere a º±±
±±º          ³  data de inclusao, data de carência ou tipo de carência    º±±
±±º          ³  abrir possibilidade de recalcular as carências.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS260DGR

Local aArea			:= GetArea()
Local aAreaBA1		:= BA1->(GetArea())

Local lInclusao		:= PARAMIXB[1][1]
Local aInclusao		:= PARAMIXB[1][2]
Local aAlterac		:= PARAMIXB[1][3]

Local i				:= 0
Local lAtuali		:= .F.

if lInclusao

	// Posicionar em qualquer benficiário da família - processará toda a família
	BA1->(DbSetOrder(2))
	if BA1->(DbSeek( xFilial("BA1") + M->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) ))
		U_GerCarBen(BA1->(RECNO()), 1 )
		//U_GerDtLim( BA1->(RECNO()), 1 )
	endif

else

	// Se teve algum beneficiario incluído na alteração
	for i := 1 to len(aInclusao)

		BA1->(DbSetOrder(2))
		if BA1->(DbSeek( xFilial("BA1") + aInclusao[i] ))
			U_GerCarBen( BA1->(RECNO()), 4 )				// Processa unicamente o beneficário
			//U_GerDtLim( BA1->(RECNO()), 3 )
		endif
	
	next

	// Na alteração, verificar se houve mudança nas datas de inclusão, carência ou tipo de carência
	for i := 1 to len(aAlterac)

		lAtuali	:= .F.

		BA1->(DbSetOrder(2))
		if BA1->(DbSeek( xFilial("BA1") + aAlterac[i][1] ))

			if		BA1->BA1_DATINC <> aAlterac[i][2][1]
				//U_GerDtLim( BA1->(RECNO()), 2 )
				lAtuali := .T.
			elseif	BA1->BA1_DATCAR <> aAlterac[i][2][2]
				lAtuali := .T.
			elseif	BA1->BA1_XTPCAR <> aAlterac[i][2][3]
				lAtuali := .T.
			endif

			if lAtuali		// Algum dos campos foram atualizados

				if MsgYesNo( AllTrim(BA1->BA1_NOMUSR)														+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
							 "Houve alteração na data de inclusão, data de carência ou tipo de carência."	+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
							 "Deseja reprocessar a carência do beneficiário?"								)
				
					U_GerCarBen( BA1->(RECNO()), 4 )				// Processa unicamente o beneficário
				
				endif
			
			endif

		endif
	
	next

endif

RestArea(aArea)
RestArea(aAreaBA1)

return

