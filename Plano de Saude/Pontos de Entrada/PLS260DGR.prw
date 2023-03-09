#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS260DGR � Autor � Frederico O. C. Jr � Data �  14/06/22   ���
�������������������������������������������������������������������������͹��
���Desc.     �  PE acionado apos a gravacao da BA1 e BA3 na familia/	  ���
���          �  usuario recebendo os dados passados pelo PE PLS260AGR. 	  ���
���          �  Utilizado para identificar os benefici�rios que foram     ���
���          �  inclu�dos na movimenta��o e gerar car�ncia. Caso altere a ���
���          �  data de inclusao, data de car�ncia ou tipo de car�ncia    ���
���          �  abrir possibilidade de recalcular as car�ncias.           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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

	// Posicionar em qualquer benfici�rio da fam�lia - processar� toda a fam�lia
	BA1->(DbSetOrder(2))
	if BA1->(DbSeek( xFilial("BA1") + M->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) ))
		U_GerCarBen(BA1->(RECNO()), 1 )
		//U_GerDtLim( BA1->(RECNO()), 1 )
	endif

else

	// Se teve algum beneficiario inclu�do na altera��o
	for i := 1 to len(aInclusao)

		BA1->(DbSetOrder(2))
		if BA1->(DbSeek( xFilial("BA1") + aInclusao[i] ))
			U_GerCarBen( BA1->(RECNO()), 4 )				// Processa unicamente o benefic�rio
			//U_GerDtLim( BA1->(RECNO()), 3 )
		endif
	
	next

	// Na altera��o, verificar se houve mudan�a nas datas de inclus�o, car�ncia ou tipo de car�ncia
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
							 "Houve altera��o na data de inclus�o, data de car�ncia ou tipo de car�ncia."	+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
							 "Deseja reprocessar a car�ncia do benefici�rio?"								)
				
					U_GerCarBen( BA1->(RECNO()), 4 )				// Processa unicamente o benefic�rio
				
				endif
			
			endif

		endif
	
	next

endif

RestArea(aArea)
RestArea(aAreaBA1)

return

