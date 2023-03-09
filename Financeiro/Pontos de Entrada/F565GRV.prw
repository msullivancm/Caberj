#Include 'Protheus.ch'

/*/{Protheus.doc} F565GRV
Rotina para gravar o numero da liquidação no campo customizado da fatura
para ser usado em outro P.E. F565TPLIQ
Permitindo assim que os campos pertinentes ao PLS sejam gravados corretamente
@type function
@version  1.0
@author angelo.cassago
@since 24/10/2022
/*/
User Function F565GRV

	Local _aArea := GetArea()

	DbSelectArea("TRB")
	TRB->(DBGOTOP())

	While TRB->(!EOF())

		If !Empty(TRB->MARCA)

			DbSelectArea("SE2")
			DbSetOrder(1) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
			If DbSeek(TRB->CHAVE)

				RecLock("SE2", .F.)

				SE2->E2_YFATFOR := CLIQUID

				MsUnlock()

			EndIf

		EndIf

		TRB->(DbSkip())

	EndDo

	RestArea(_aArea)

Return
