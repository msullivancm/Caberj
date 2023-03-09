#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLSALTM2 º Autor ³ Frederico O. C. Jr    º Data ³ 31/01/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ 	* O Ponto de entrada PLSALTM2 tem por objetivo retornar   º±±
±±º          ³ 	o Valor Calculado em moeda corrente, Valor da Metragem e  º±±
±±º          ³ 	o Alias de referência em relação a regra utilizada.		  º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSALTM2()

Local aArea			:= GetArea()

Local nRef			:= Paramixb[01]
Local cAlias		:= Paramixb[02]
//Local lOK			:= Paramixb[03]
Local nVlrFil		:= Paramixb[04]
Local nVlrFilCalc	:= Paramixb[05]
//Local cCodRda		:= Paramixb[06]
//Local cCodInt		:= Paramixb[07]
//Local cCodLoc		:= Paramixb[08]
//Local cCodEsp		:= Paramixb[09]
//Local cRegAte		:= Paramixb[10]
//Local lCobCoPart	:= Paramixb[11]
Local cCodPro		:= Paramixb[12]
//Local cCodUnd		:= Paramixb[13]
//Local dDatAnalise	:= Paramixb[14]
Local cCodPad		:= Paramixb[15]
Local nQtd			:= Paramixb[16]
//Local lReembolso	:= Paramixb[17]
Local nFatMul		:= Paramixb[18]
Local cConsFt		:= Paramixb[19]

Local aDadUsr		:= PLSGETUSR()

Local aRetorno		:= { nVlrFilCalc, nVlrFil, cAlias }
Local cTpEve		:= ""
Local cAcomod		:= ""
Local dDatPro		:= StoD("")

if Alltrim(FunName()) $ "PLSA001|PLSA001A"

	if len(aDadUsr) > 0

		if AllTrim(funname()) == "PLSA001A"

			cTpEve	:= BOW->BOW_XTPEVE
			cAcomod	:= BOW->BOW_PADINT
			dDatPro	:= BOW->BOW_XDTEVE
		
		endif

		// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> ZZZ -> B7T)
		aTbReem		:= U_RtTbReem(aDadUsr, "", cCodPad, cCodPro, cTpEve, cAcomod, dDatPro)

		if aTbReem[1] <> 0

			nVlrFil		:= iif(aTbReem[2][5] <> 0, aTbReem[2][5], nVlrFil)					// Obtem o valor unitario do filme.

			aRetorno[2]	:= nVlrFil
			aRetorno[1]	:= ( (nVlrFil * nRef) * nQtd) * iif(cConsFt == "1", nFatMul, 1)
			
		endif
	
	endif

endif

RestArea(aArea)

return aRetorno
