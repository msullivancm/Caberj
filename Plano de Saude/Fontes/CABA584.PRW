#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA584   ºAutor  ³Leonardo Portella   º Data ³  29/03/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Manutenção da tela de Permissão excepcional digitação RDAs º±±
±±º          ³ Medlink.                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

**********************************************************************************************

User Function CABA584

Local cMacrExclui := "Eval({||MsgStop('Não será possível excluir o registro, apenas desabilitar a autorização de digitação.',Alltrim(SM0->M0_NOMECOM)),.F.})"

AxCadastro('PCH','Liberação especial para digitação de guias de RDAs Medlink',cMacrExclui)

Return

**********************************************************************************************

User Function lDigMedlink(cAliasOp)

Local aArMed	:= GetArea()
Local aArBAU	:= BAU->(GetArea())
Local cAlMed 	:= GetNextAlias()	
Local cQryAl	:= ''
Local lOk 		:= .T.
Local lRDAxMed	
Local aProbl	:= {}
Local aSolucao	:= {}
Local cRDA		:= ''
Local cMes		:= ''
Local cAno		:= ''
Local cLdp		:= ''

Default cAliasOp := 'MEMORIA'

If cAliasOp == 'MEMORIA'
	cRDA	:= M->BCI_CODRDA
	cMes	:= M->BCI_MES
	cAno	:= M->BCI_ANO
	cLdp	:= M->BCI_CODLDP
Else
	cRDA	:= BCI->BCI_CODRDA
	cMes	:= BCI->BCI_MES
	cAno	:= BCI->BCI_ANO
	cLdp	:= BCI->BCI_CODLDP
EndIf

lRDAxMed	:= ( Upper(Posicione('BAU',1,xFilial('BAU') + cRDA, 'BAU_XMEDLI')) $ 'S' )

If lRDAxMed .and. ( cLdp == '0001' )

	cQryAl	:= "SELECT 1" 										+ CRLF
	cQryAl	+= "FROM " + RetSqlName('PCH') + " PCH"				+ CRLF
	cQryAl	+= "WHERE PCH_FILIAL = '" + xFilial('PCH') + "'" 	+ CRLF
	cQryAl	+= "	AND PCH_CODRDA = '" + cRDA	+ "'" 			+ CRLF
	cQryAl	+= "	AND PCH_ANO = '" + cAno	+ "'" 				+ CRLF
	cQryAl	+= "	AND PCH_MES = '" + cMes	+ "'" 				+ CRLF
	cQryAl	+= "	AND PCH_STATUS = 'S'" 						+ CRLF
	cQryAl	+= "	AND PCH.D_E_L_E_T_ = ' '" 					+ CRLF
	
	TcQuery cQryAl New Alias cAlMed
	
	lOk := !cAlMed->(EOF())
	
	cAlMed->(DbCloseArea())
	
	If !lOk
	
		aAdd(aProbl,'RDA [ ' + cRDA + ' ] está configurado para enviar guias pela Medlink e portanto não poderá ter guias digitadas.')
		
		aAdd(aSolucao,'Para digitar guias, solicite ao coordenador de Contas Médicas que libere esta digitação no sistema na competência [ ' + cMes + '/' + cAno + ' ]')
		
		ShowHelpDlg(SM0->M0_NOMECOM, aProbl,,aSolucao,)
		
		If RetCodUsr() $ GetMV('MV_XGETIN')
			lOk := MsgYesNo('TI - Deseja incluir a ' + If(cAliasOp == 'MEMORIA','PEG','Guia') + ' mesmo assim???','TI - Permissao especial para incluir guias')	
		Endif
		
	EndIf

EndIf

BAU->(RestArea(aArBAU))
RestArea(aArMed)

Return lOk

**********************************************************************************************