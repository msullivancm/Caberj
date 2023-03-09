#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'

/*
CONTROLE DE NUMERAÇÃO FORMULÁRIOS/GUIAS
A tabela ZRM sera utilizada para controle de numeracao inclusive quando o 
RDA imprimir ou gerar numeracao pelo site.
*/

User Function CABA334

Private aRotina 	:= {}
Private cCadastro 	:= "CONTROLE DE NUMERAÇÃO DE FORMULÁRIOS/GUIAS"

aAdd(aRotina,{"Pesquisar" 	,"AxPesqui"	,0,1})  
aAdd(aRotina,{"Visualizar" 	,"AxVisual"	,0,2})
aAdd(aRotina,{"Incluir" 	,"U_IncZRM"	,0,3})
aAdd(aRotina,{"Alterar" 	,"AxAltera"	,0,4})
aAdd(aRotina,{"Excluir" 	,"U_DelZRM"	,0,5})

DbSelectArea('ZRM')
DbSetOrder(1)
DbGoTop()

mBrowse(6,1,22,75,'ZRM')

Return

****************************************************************************************************

User Function ZRMNUMERO(cTipoForm, nQtd)

Local nRet 		:= 0
Local aArea		:= GetArea()
Local cQry		:= ''
Local cAlias	:= GetNextAlias()

Default nQtd	:= 1

If empty(cTipoForm)

	MsgStop('INFORME O TIPO DE FORMULÁRIO!',AllTrim(SM0->M0_NOMECOM))
	
Else
	
	cQry := "SELECT NVL(MAX(ZRM_NUMFIM),0) NUMFIM" 						+ CRLF
	cQry += "FROM " + RetSqlName('ZRM') 								+ CRLF
	cQry += "WHERE D_E_L_E_T_ = ' '"	 								+ CRLF
	cQry += "	AND ZRM_FILIAL = '" + xFilial('ZRM') + "'"				+ CRLF
	cQry += "	AND TRIM(ZRM_TIPFOR) = '" + AllTrim(cTipoForm) + "'"	+ CRLF
	
	TcQuery cQry New Alias cAlias
	
	nRet := cAlias->NUMFIM + nQtd
	
	cAlias->(DbCloseArea())

EndIf

RestArea(aArea)

Return nRet

****************************************************************************************************

User Function IncZRM

Local nOpca :=  AxInclui("ZRM",/*ZRM->(Recno())*/,3, , , , )
	
If ( nOpca == 1 ) 
	GrvZRM()
EndIf

Return

****************************************************************************************************

Static Function GrvZRM

Local cScript	:= ""

//AxInclui ja incluiu um registro em branco que esta ponteirado ou AxAltera ja esta ponteirado

/*
LOCK TABLE para garantir que ninguem ira inserir uma linha com uma numeracao contendo o numero de outra
linha para o mesmo Tipo de Formulario. O SELECT FOR UPDATE nao atenderia nesta situacao pois preciso inserir
uma linha no site ou em qualquer momento que uma numeracao for gerada. O controle de numeracao tambem pode
ser vinculado a uma grafica ou RDA. 
*/

cScript	:= "BEGIN" 																										+ CRLF 
cScript	+= ""																 											+ CRLF
// SOLICITAÇÃO ALEXANDRE ROCHA - 03/08/15 - SERGIO CUNHA //
cScript	+= "LOCK TABLE " + RetSqlName('ZRM') + " IN EXCLUSIVE MODE;"	 											+ CRLF
//cScript	+= "LOCK TABLE " + RetSqlName('ZRM') + " IN EXCLUSIVE MODE WAIT;"	 										+ CRLF
cScript	+= ""																 											+ CRLF
cScript	+= "BEGIN" 																										+ CRLF
cScript	+= ""																 											+ CRLF
cScript	+= "	UPDATE " + RetSqlName('ZRM') + " SET ZRM_FILIAL = '" + xFilial('XRM') + "'," 							+ CRLF
cScript	+= "		ZRM_TIPFOR = '" + ZRM->ZRM_TIPFOR + "'," 															+ CRLF
cScript	+= "		ZRM_QTDVIA = " + cValToChar(ZRM->ZRM_QTDVIA) + "," 													+ CRLF
cScript	+= "		ZRM_QTDLOT = " + cValToChar(ZRM->ZRM_QTDLOT) + "," 													+ CRLF
cScript	+= "		ZRM_NUMINI = " 																						+ CRLF
cScript	+= "		(" 																									+ CRLF
cScript	+= "		SELECT NVL(MAX(ZRM_NUMFIM),0) + 1" 																	+ CRLF
cScript	+= "		FROM " + RetSqlName('ZRM') 																			+ CRLF
cScript	+= "		WHERE D_E_L_E_T_ = ' '"	 																			+ CRLF
cScript	+= "			AND ZRM_FILIAL = '" + xFilial('ZRM') + "'"														+ CRLF
cScript	+= "			AND TRIM(ZRM_TIPFOR) = '" + AllTrim(ZRM->ZRM_TIPFOR) + "'"										+ CRLF
cScript	+= "			AND R_E_C_N_O_ <> " + cValToChar(ZRM->(Recno()))												+ CRLF
cScript	+= "		)," 																								+ CRLF
cScript	+= "		ZRM_NUMFIM = " 																						+ CRLF 
cScript	+= "		(" 																									+ CRLF
cScript	+= "		SELECT NVL(MAX(ZRM_NUMFIM),0) + " + cValToChar(ZRM->ZRM_QTDVIA) + '*' + cValToChar(ZRM->ZRM_QTDLOT)	+ CRLF
cScript	+= "		FROM " + RetSqlName('ZRM') 																			+ CRLF
cScript	+= "		WHERE D_E_L_E_T_ = ' '"	 																			+ CRLF
cScript	+= "			AND ZRM_FILIAL = '" + xFilial('ZRM') + "'"														+ CRLF
cScript	+= "			AND TRIM(ZRM_TIPFOR) = '" + AllTrim(ZRM->ZRM_TIPFOR) + "'"										+ CRLF
cScript	+= "			AND R_E_C_N_O_ <> " + cValToChar(ZRM->(Recno()))												+ CRLF
cScript	+= "		)," 																								+ CRLF
cScript	+= "		ZRM_QTDTOT = " + cValToChar(ZRM->ZRM_QTDTOT) + "," 													+ CRLF
cScript	+= "		ZRM_NF = '" + ZRM->ZRM_NF + "'," 																	+ CRLF
cScript	+= "		ZRM_DATA = '" + DtoS(ZRM->ZRM_DATA) + "'," 															+ CRLF
cScript	+= "		ZRM_GRAFIC = '" + ZRM->ZRM_GRAFIC + "'," 															+ CRLF
cScript	+= "		ZRM_TIPLIB = '" + ZRM->ZRM_TIPLIB + "'" 															+ CRLF
cScript	+= "	WHERE R_E_C_N_O_ = " + cValToChar(ZRM->(Recno())) + ";"													+ CRLF	
cScript	+= "	END;" 																									+ CRLF
cScript	+= ""																	 										+ CRLF
cScript	+= "COMMIT;" 																									+ CRLF
cScript	+= ""																 											+ CRLF
cScript	+= "EXCEPTION" 																									+ CRLF
cScript	+= "	WHEN OTHERS THEN" 																						+ CRLF 
cScript	+= "      ROLLBACK;" 																							+ CRLF
cScript	+= ""																 											+ CRLF
cScript	+= "END;" 																										+ CRLF
  
If TcSqlExec(cScript) < 0
	MsgStop('Erro ao inserir dados na tabela ' + RetSqlName('ZRM') + CRLF + 'Erro Oracle: ' + CRLF + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
EndIf
	
Return

****************************************************************************************************

User Function DelZRM

Local cQry 		:= ''
Local aAreaDel	:= GetArea()		
Local cAlias 	:= GetNextAlias()
Local cMsg		:= ''

If !ZRM->(EOF())

	cQry := "SELECT ZRM_TIPFOR" 										+ CRLF
	cQry += "FROM " + RetSqlName('ZRM') 								+ CRLF
	cQry += "WHERE ZRM_FILIAL = '" + xFilial('ZRM') + "'" 				+ CRLF
	cQry += "  AND ZRM_TIPFOR = '" + ZRM->ZRM_TIPFOR + "'" 				+ CRLF
	cQry += "  AND ZRM_NUMINI >= " + cValToChar(ZRM->ZRM_NUMFIM)  		+ CRLF 
	cQry += "  AND D_E_L_E_T_ = ' '" 									+ CRLF
	
	TcQuery cQry New Alias cAlias
	
	If cAlias->(EOF())
	
		If MsgYesNo('Confirma a exclusão do registro?',AllTrim(SM0->M0_NOMECOM))
			ZRM->(Reclock('ZRM',.F.))
			ZRM->(DbDelete())
			ZRM->(MsUnlock())
		EndIf
		
	Else
	
		cMsg := 'Já existe registro do tipo ' + AllTrim(ZRM->ZRM_TIPFOR) + ;
				' com numeração superior a numeração deste registro. O registro não poderá ser excluído!'
				
		MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
		
	EndIf
	
	cAlias->(DbCloseArea())
	
	RestArea(aAreaDel)
	
EndIf

Return