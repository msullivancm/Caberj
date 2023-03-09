#include "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ PLSRTBND º Autor ³ Frederico O. C. Jr º Data ³  27/04/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ manipular banda										      º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSRTBND

Local aArea			:= GetArea()
Local nBanda		:= PARAMIXB[1]
Local cCodPad		:= PARAMIXB[14]
Local cCodPro		:= PARAMIXB[12]
Local aDadUsr		:= PLSGETUSR()
Local cTpEve		:= ""
Local cAcomod		:= ""
Local dDatPro		:= StoD("")
Local lReal			:= .F.

if Alltrim(FunName()) $ "PLSA001|PLSA001A"

	// Banda basica para reembolso (não pegar a 88 do calendário de pagamento)
	nBanda	:= 100

	if len(aDadUsr) > 0

		if AllTrim(funname()) == "PLSA001A"

			cTpEve	:= M->BOW_XTPEVE
			cAcomod	:= M->BOW_PADINT
			dDatPro	:= M->BOW_XDTEVE
		
		else
			// preciso tratamento no PLSA001
		endif

		// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> ZZZ -> B7T)
		aTbReem		:= U_RtTbReem(aDadUsr, "", cCodPad, cCodPro, cTpEve, cAcomod, dDatPro)

		if aTbReem[1] == 1	// encontrou na matriz de reembolso

			if aTbReem[2][6] <> 0 .and. aTbReem[2][7] == 1	// Tem banda informada e TDE de HM/Evento

				BD4->(DbSetOrder(1))	// BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
				if BD4->(DbSeek(xFilial("BD4") + PLSIntPad() + aTbReem[2][1] + cCodPad + AllTrim(cCodPro) ))

					while BD4->(!EOF()) .and. AllTrim(BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO)) == PLSIntPad() + aTbReem[2][1] + cCodPad + AllTrim(cCodPro)

						if BD4->BD4_CODIGO == 'REA' .and. dDatPro >= BD4->BD4_VIGINI .and. (dDatPro <= BD4->BD4_VIGFIM .or. empty(BD4->BD4_VIGFIM) )
							lReal	:= .T.
						endif

						BD4->(DbSkip())
					end

				endif

				if !lReal
					nBanda	:= aTbReem[2][6]
				endif

			endif
		
		endif
	
	endif

endif

restArea(aArea)

return nBanda
