#include "RWMAKE.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS001OK  ºAutor  ³Microsiga           º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍ8ÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para validar a valor do reembolso x proto- º±±
±±º          ³colo apresentado.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS001OK()

Local aArea			:= GetArea()
Local aAreaB44		:= B44->(GetArea())
Local aAreaZZQ		:= ZZQ->(GetArea())
Local aAreaBOW		:= BOW->(GetArea())
Local aAreaSZ9		:= SZ9->(GetArea())
Local lRet			:= .T.
Local nOpc			:= paramixb[1]
Local cSQL			:= ""
Local nAuxFJaPg		:= 0

if nOpc == 3

	B44->(DbSetOrder(9))	// B44_FILIAL+B44_YCDPTC
	if B44->(DbSeek(xFilial("B44") + M->B44_YCDPTC))
		MsgInfo("Já possui um cálculo para o protocolo: " + M->B44_YCDPTC + "! Verifique!")
		lRet	:= .F.
	endif
	RestArea(aAreaB44)
	
	if lRet

		ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
		if ZZQ->(DbSeek(xFilial("ZZQ") + M->B44_YCDPTC))

			if Round(M->B44_VLRPAG + M->B44_VLRGLO + M->B44_VLABPF, 0) > Round(ZZQ->ZZQ_VLRTOT, 0)
				MsgInfo("Valor do reembolso é maior que o valor protocolado! Verifique!")
				lRet	:= .F.
			elseif Round(M->B44_VLRPAG + M->B44_VLRGLO + M->B44_VLABPF,0) < Round(ZZQ->ZZQ_VLRTOT, 0)
				MsgInfo("Valor do reembolso é menor que o valor protocolado! Verifique!")
				lRet	:= .F.
			endif
		endif
	
	endif

	If lRet

		ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
		if ZZQ->(DbSeek(xFilial("ZZQ") + M->B44_YCDPTC))

			if ZZQ->ZZQ_TPSOL == '1' .and. ZZQ->ZZQ_TIPPRO == '4'	// remmbolso de auxilio funeral

				cSQL := " SELECT SUM(B45_VLRPAG) AS TOTAUXF"
				cSQL += " FROM " + RetSQLName("B44") + " B44"
				cSQL +=   " INNER JOIN " + RetSQLName("B45") + " B45"
				cSQL +=     " ON (    B45_FILIAL = B44_FILIAL"
				cSQL +=         " AND B45_OPEMOV = B44_OPEMOV"
				cSQL +=         " AND B45_ANOAUT = B44_ANOAUT"
				cSQL +=         " AND B45_MESAUT = B44_MESAUT"
				cSQL +=         " AND B45_NUMAUT = B44_NUMAUT)"
				cSQL += " WHERE B44.D_E_L_E_T_ = ' ' AND B45.D_E_L_E_T_ = ' '"
				cSQL +=   " AND B44_FILIAL = '" + xFilial("B44") + "'"
				cSQL +=   " AND B44_OPEUSR = '" + M->B44_OPEUSR  + "'"
				cSQL +=   " AND B44_CODEMP = '" + M->B44_CODEMP  + "'"
				cSQL +=   " AND B44_MATRIC = '" + M->B44_MATRIC  + "'"
				cSQL +=   " AND B44_TIPREG = '" + M->B44_TIPREG  + "'"
				cSQL +=   " AND B45_CODPRO = '" + GetNewPar("MV_YCDAFUN","90990013") + "'"
				PLSQuery(cSQL,"TRB45")
				
				nAuxFJaPg := TRB45->TOTAUXF		// Valor já pago de funeral para o beneficiário
				
				TRB45->(DbCloseArea())

				cSQL := " SELECT SUM(BD4_VALREF) AS VLMAXAUXF"
				cSQL += " FROM " + RetSQLName("BD4") + " BD4"
				cSQL += " WHERE BD4.D_E_L_E_T_ = ' '"
				cSQL +=   " AND BD4_FILIAL = '" + xFilial("BD4") + "'"
				cSQL +=   " AND BD4_CODPRO = '" + GetNewPar("MV_YCDAFUN","90990013") + "'"
				cSQL +=   " AND (BD4_VIGINI = ' ' OR BD4_VIGINI <= '" + DtoS(M->B44_DATPRO) + "')"
				cSQL +=   " AND (BD4_VIGFIM = ' ' OR BD4_VIGFIM >= '" + DtoS(M->B44_DATPRO) + "')"
				cSQL +=   " AND BD4_CODIGO = 'REA'"
				PLSQuery(cSQL,"TRB45")

				if nAuxFJaPg + M->B44_VLRPAG > TRB45->VLMAXAUXF

					MsgInfo("Valor máximo do auxílio funeral já foi reembolsado."					+ Chr(13)+Chr(10) +;
							"Valor já pago: "		+ Transform(nAuxFJaPg, "@E 999,999.99")			+ Chr(13)+Chr(10) +;
							"Valor máx. vigente: "	+ Transform(TRB45->VLMAXAUXF,"@E 999,999.99")	)
					lRet	:= .F.
				endif
				
				TRB45->(DbCloseArea())

			endif

		endif

	endif

	if lRet

		// Se não teve critica para impedir gravação - atualizar status do protocolo
		ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
		if ZZQ->(DbSeek(xFilial("ZZQ") + M->B44_YCDPTC))

			ZZQ->(Reclock("ZZQ",.F.))
				ZZQ->ZZQ_STATUS := "3"	// Vinculado
			ZZQ->(MsUnlock())

		endif
	
	endif

elseif nOpc == 5

	// BIANCHINI - 26/06/2020 - Trava de exclusão de Reembolso com custo fechado
	if !Empty(B44->B44_YDTCON)

		SZ9->(DbSetOrder(1))
		if SZ9->(DbSeek(xFilial("SZ9") + SubStr(DtoS(B44->B44_YDTCON),1,6)))
			if SZ9->Z9_STATUS == "F"
				MsgInfo("Este reembolso pertence a uma competência de custo já fechada."	+ Chr(13)+Chr(10) +;
						"Não será possivel realizar a exclusão!"							)
				lRet	:= .F.
			endif
		endif
	
	endif

	if lRet

		ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
		if ZZQ->(DbSeek(xFilial("ZZQ") + M->B44_YCDPTC))

			ZZQ->(Reclock("ZZQ",.F.))
				ZZQ->ZZQ_STATUS := "1"	// Protocolado
			ZZQ->(MsUnlock())
		
		endif
	
	endif

endif

RestArea(aAreaSZ9)
RestArea(aAreaBOW)
RestArea(aAreaZZQ)
RestArea(aAreaB44)
RestArea(aArea)

return lRet
