#include "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ PLSCBVPG º Autor ³ Frederico O. C. Jr º Data ³  27/04/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ manipular nivel de coparticipação					      º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSCBVPG

Local aArea			:= GetArea()
Local aRet			:= {.F.}
Local nVlrApr		:= PARAMIXB[2]
Local cCodPad		:= PARAMIXB[3]
Local cCodPro		:= PARAMIXB[4]
Local aDadUsr		:= PLSGETUSR()
Local cGrpCob		:= "   "
Local cChNivCP		:= ""

if Alltrim(FunName()) $ "PLSA001|PLSA001A"

	cGrpCob		:= U_BuscaGrupCob(PLSINTPAD(), cCodPad, cCodPro)

	cChNivCP	:= xFilial("BT7") + SubStr(aDadUsr[2],1,8) + aDadUsr[9] + aDadUsr[39] +	aDadUsr[41] + aDadUsr[42] + aDadUsr[11] + aDadUsr[12]

	BT7->(DbSetOrder(1))	// BT7_FILIAL+BT7_CODINT+BT7_CODIGO+BT7_NUMCON+BT7_VERCON+BT7_SUBCON+BT7_VERSUB+BT7_CODPRO+BT7_VERPRO
	if BT7->(DbSeek( cChNivCP ))

		cChNivCP	:= xFilial("BT7") + SubStr(aDadUsr[2],1,8) + aDadUsr[9] + aDadUsr[39] +	aDadUsr[41] + aDadUsr[42] + aDadUsr[11] + aDadUsr[12] + cGrpCob

		aRet := {	.T.			,;
					nVlrApr		,;
					"BT7"		,;
					cChNivCP	}

	else

		cChNivCP	:= xFilial("BRV") + SubStr(aDadUsr[2],1,4) + aDadUsr[11] + aDadUsr[12] + cGrpCob

		BRV->(DbSetOrder(1))	// BRV_FILIAL+BRV_CODPLA+BRV_VERSAO+BRV_CODGRU
		if BRV->(DbSeek( cChNivCP ))

			aRet := {	.T.				,;
						nVlrApr			,;
						"BRV"			,;
						cChNivCP		}
		
		endif

	endif

endif

restArea(aArea)

return aRet
