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
±±ºPrograma  ³CABV055   ºAutor  ³Fabio Bianchini     º Data ³  14/12/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para validar Codigo CBOS do Calculo de    º±±
±±º          ³ Reembolso, contra criterios de preenchimento do Protocolo  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABV055( cProtoc, cCBOS )
	
Local aArea 	:= GetArea()
Local lRet		:= .T.

Default cProtoc		:= ""
Default cCBOS		:= ""

if !empty(cCBOS)

	B0X->(DbSetOrder(1))
	if B0X->(DbSeek(xFilial("B0X") + cCBOS))

		if B0X->B0X_XATIVO == '1'

			if AllTrim(cCBOS) == '999999'		// CBOS Generico

				lRet	:= .F.

				if !empty(cProtoc)

					ZZQ->(DbSetOrder(1))
					if ZZQ->(DbSeek(xFilial("ZZQ") + cProtoc ))

						if (ZZQ->ZZQ_TPSOL == '2' .and. ZZQ->ZZQ_TIPPRO $ '07') .or. (ZZQ->ZZQ_TPSOL == '1' .and. ZZQ->ZZQ_TIPPRO $ 'A|04')
							lRet	:= .T.
						endif

					endif

				endif

			endif

			if !lRet
				MsgInfo('CBOS Inválido para este tipo de reembolso!')
			endif

		else
			lRet	:= .F.
			MsgInfo("CBOS Bloqueado!")
		endif

	else
		lRet	:= .F.
		MsgInfo("CBOS Inválido!")
	endif

endif

RestArea(aArea)
	
Return lRet

