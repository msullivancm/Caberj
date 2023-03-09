#INCLUDE "Protheus.ch"

/*---------------------------------------------------------------|
|Estrutura: CABA219                                             |
|----------------------------------------------------------------|
|Autor  : Luiz Otávio Campos                                     |
|----------------------------------------------------------------|
|Data:   13/05/2022                                              |
|----------------------------------------------------------------|
|Descrição: Função para atualizar o Grupo de Cobrança das        | 
| familias de acordo com o Subcontrato.     					 |
|----------------------------------------------------------------*/

User Function CABA219()
	Local aArea := GetArea()
	Local lRet  := .T.

	If M->BQC_GRPCOB <> BQC->BQC_GRPCOB
		If MsgYesNo(OemtoAnsi("O Grupo de cobrança foi alterado. Deseja atualizar o grupo de cobrança das famílias deste subcontrato?") )
			Processa({|| U_CABA219A()}) 
		EndIf
	EndIf
		
	RestArea(aArea)
Return lRet


/*---------------------------------------------------------------|
|Estrutura: CABA219                                             |
|----------------------------------------------------------------*/

User Function CABA219A
	Local cAlisTRB := GetnextAlias()
	Local cSQL := ""

	cSQL := " SELECT R_E_C_N_O_ FROM "+RETSQLNAME("BA3")
	cSQL += " WHERE BA3_FILIAL = '"+xFilial("BA3")+"'"
	cSQL += "   AND BA3_CODINT||BA3_CODEMP = '"+BQC->BQC_CODIGO+"'"
	cSQL += "   AND BA3_CONEMP = '"+BQC->BQC_NUMCON+"'"         
	cSQL += "   AND BA3_VERCON = '"+BQC->BQC_VERCON+"'"         
	cSQL += "   AND BA3_SUBCON = '"+BQC->BQC_SUBCON+"'"         
	cSQL += "   AND BA3_VERSUB = '"+BQC->BQC_VERSUB+"'"      
		
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cSQL), cAlisTRB, .F., .T.)   
		
	DbSelectArea(cAlisTRB)
	DBGOTOP()

	While !(cAlisTRB)->(Eof())

		IncProc(" Processando ..." )

		DbSelectArea("BA3")
		Dbgoto((cAlisTRB)->R_E_C_N_O_)
		
		RecLock("BA3", .F.)
		BA3->BA3_GRPCOB	:=  M->BQC_GRPCOB
		MsUnlock()
			
		DbSelectArea(cAlisTRB)
		(cAlisTRB)->(DbSkip())
	EndDo

Return
