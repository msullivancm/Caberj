#include 'TOTVS.CH'
#include 'TOPCONN.CH'

//PE após a inclusão das críticas [ BDX ] no PLSA720 pela função PLSA720GCr.
//Na glosa do Estaleiro, na verdade o pagamento e zerado, independente de ter ou nao BDX. No caso desta rotina
//devera utilizar a glosa do sistema e colocar em ativa pronta glosada, aproveitando o BDX.
//Ponto de entrada dentro do controle de transações.
//Neste momento todos os tratamentos padrões do sistema já foram realizados e a guia já mudou de fase.
/*
- Novo escopo da customizacao conforme conversado com a Marcia e Dr. Giordano em 06/03/15:
Todas as glosas feitas pelo sistema deverao cair na fase ativa, inclusive se for um clone. Caso a critica esteja
parametrizada errada, o setor responsavel devera corrigir em tempo habil, mesmo que seja um prestador critico.
Quando for incluir glosa manual, o sistema devera seguir o fluxo sem esta intervencao.
"O ANALISTA SOMENTE PODERA DIMINUIR O VALOR DE PAGAMENTO, NUNCA AUMENTAR." - Dr. Giordano
*/

User Function PLS720G1
	
	Local aArea			:= GetArea()
	Local aAreaBD6		:= BD6->(GetArea())
	Local c_AliasTab 	:= PARAMIXB[1]
	Local n_RecTab		:= &( c_AliasTab + '->(Recno())' )
	Local a_CritGiord	:= {}
	Local lGlosaDir
	Local cCodOpe		:= &( c_AliasTab + '->' + c_AliasTab + '_CODOPE' )
	Local cFase			:= &( c_AliasTab + '->' + c_AliasTab + '_FASE' )
	Local cCodEmp		:= &( c_AliasTab + '->' + c_AliasTab + '_CODEMP' )
	Local cCodLDP		:= &( c_AliasTab + '->' + c_AliasTab + '_CODLDP' )
	Local cCodPEG		:= &( c_AliasTab + '->' + c_AliasTab + '_CODPEG' )
	Local cNumGui		:= &( c_AliasTab + '->' + c_AliasTab + '_NUMERO' )
	Local cOrimov		:= &( c_AliasTab + '->' + c_AliasTab + '_ORIMOV' )
	Local nVlrGlo		:= &( c_AliasTab + '->' + c_AliasTab + '_VLRGLO' )
	Local nVlrPag		:= &( c_AliasTab + '->' + c_AliasTab + '_VLRPAG' )
	Local cTipoGuia		:= &( c_AliasTab + '->' + c_AliasTab + '_TIPGUI' )
	Local lEstaleiro
	Local lRepasse		:= .F.
	Local aCritEst		:= IIF((cEmpAnt=='01' .and. BD5->BD5_CODEMP $ '5000|5001|5002') .or. (cEmpAnt=='02' .and. BD5->BD5_CODEMP $ '0180|0183|0188|0189|0190|0259 '),u_aCriEstaleiro(),{.f.,.f.,0})  
	Local c_ChaveGui	:= ""
	Local c_ChaveGui2	:= ""
	Local lProcDupl		:= .F.  //Bianchini - 19/10/2018 - RDM 315 - Glosar Procedimentos ja existentes em outras guias
	Local aVet 			:= {"","","","","","",""} //Só pra não dar erro na função 
	Local nDifData 		:= 0 //BIANCHINI - 10/12/2019 - Copart 12 meses
	Local cCodBlo  		:= ""
	Local cDesBlo  		:= ""
	
	//Bianchini - 19/10/2018 - RDM 315 - Glosar Procedimentos ja existentes em outras guias
	//                                   Acrescentado em todos os CASE´s: " .and. !lProcDupl "
	If (Alltrim(FunName()) $ 'PLSA498|PLSA720') .or. (IsInCallStack("PLSA175FAS"))
		c_ChaveGui 	:= &(c_AliasTab + '->('+c_AliasTab+'_CODOPE + '+c_AliasTab+'_CODLDP + '+c_AliasTab+'_CODPEG + '+c_AliasTab+'_NUMERO)')
		BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
		If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))
			While !BD6->(EOF()) .AND. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == xFilial("BD6") + c_ChaveGui 
				If !( BD5->BD5_CODLDP $ '0000|0010|0017' )
					lProcDupl := u_CritRecob(BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO),DTOS(BD6->BD6_DATPRO),aVet,aVet,BD6->BD6_CODRDA,BD6->BD6_OPEUSR,BD6->BD6_CODEMP,BD6->BD6_MATRIC,BD6->BD6_TIPREG)
					If lProcDupl
						Exit
					Endif
				Endif		
				BD6->(DbSkip())
			Enddo
		Endif
	Endif
	
	Do Case
		
		//Se nao for na Digitacao CM ou Mudanca fase lote nao altero
	Case !( Alltrim(FunName()) $ 'PLSA498' .or. IsInCallStack("PLSA175FAS") .or. IsInCallStack('U_AJUSTAGUIAS') ) .and. !lProcDupl
		lGlosaDir := .F.
		
		/*//Leonardo Portella - 12/09/16 - Início - TEMPORÁRIO: Conforme solicitado pelo Altamiro, não glosar reciprocidade (0004) nunca para os RDAs Fleury (138460|138851)
		
	Case ( cEmpAnt == '01' ) .and. ( cCodEmp == '0004' ) .and. ( BAU->BAU_CODIGO $ '138460|138851' ) .and. !lProcDupl
		lRepasse 	:= .F.
		lGlosaDir 	:= .F.
		
		If ( ( cFase == '2' ) .or. ( cFase == '3' .and. nVlrGlo > 0 ) )
			AutPronta(c_AliasTab,n_RecTab)
		EndIf
		
		//Leonardo Portella - 12/09/16 - Fim - TEMPORÁRIO: Conforme solicitado pelo Altamiro, não glosar reciprocidade (0004) nunca para os RDAs Fleury (138460|138851)
		*/
		
		//Leonardo Portella - 02/12/16 - Início - TEMPORÁRIO: Conforme solicitado pelo Roberto, não glosar RDA 140171 
	//BIANCHINI - 20/07/2020 - Retirado do ar por estar limpando as glosas e pagando valores acima do normal
	/*
	Case ( cEmpAnt == '01' ) .and. ( BAU->BAU_CODIGO $ '111406|111414|134210|140040|140139|140147|140155|140171' ) .and. !lProcDupl
		lRepasse 	:= .F.
		lGlosaDir 	:= .F.
		
		If ( ( cFase == '2' ) .or. ( cFase == '3' .and. nVlrGlo > 0 ) )
			AutPronta(c_AliasTab,n_RecTab)
		EndIf
	*/	
		//Leonardo Portella - 02/12/16 - Fim - TEMPORÁRIO: Conforme solicitado pelo Roberto, não glosar a PEG 00639768 do RDA 140171 (Repasse DASA)
		
	Case ( cEmpAnt == '02' ) .and. ( BAU->BAU_CODIGO == '999997'/*RDA repasse Caberj/Integral*/ ) 
		lRepasse 	:= .T.
		lGlosaDir 	:= .F.
		
	Case ( cEmpAnt == '01' ) .and. ( BAU->BAU_CODIGO == '140880'/*RDA repasse Estaleiro*/ ) 
		lRepasse 	:= .T.
		lGlosaDir 	:= .F.
		
	Case cFase <> '2' .and. !lProcDupl
		lGlosaDir := .F.
		
		//Excluir o local de digitacao da OPME
	Case cCodLDP == '0013' .and. !lProcDupl
		lGlosaDir := .F.
		
	Case ( cEmpAnt == '01' ) .and. ( cCodEmp $ '0004|0009' ) 
		lGlosaDir := .F.
		
	Case ( BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") )
		lGlosaDir := .F.
		
		//Leonardo Portella - 07/04/15 - Inicio - Chamado - ID: 16584
		//RDAs que podem reconsiderar nao caem em glosa direto. Solicitado por Nilton e Max (Giordano de ferias).
		//Rede D'or
		
	Case ( u_lRDAPodeRec(BAU->BAU_CODIGO) ) .and. !lProcDupl
		lGlosaDir := .F.
		
		//Leonardo Portella - 07/04/15 - Fim
		
	Case aCritEst[1] .and. !aCritEst[2] //Leonardo Portella - 30/06/15 - Caiu na regra estaleiro e nao e para pagar
		lGlosaDir 	:= .T.
		lEstaleiro	:= .T.
		
	Otherwise
		lGlosaDir 	:= .F.//.T.//PROJETO RECONSIDERA: ESTA VARIAVEL NESTE PONTO TEM QUE ESTAR COMO .T.
		lEstaleiro	:= .F.
		lRepasse	:= .F.
		
	End Case
	
	c_ChaveGui 	:= &(c_AliasTab + '->('+c_AliasTab+'_CODOPE + '+c_AliasTab+'_CODLDP + '+c_AliasTab+'_CODPEG + '+c_AliasTab+'_NUMERO)')
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))
		
		//--------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data: 31/07/2018											|
		//--------------------------------------------------------------------------------------
		// RDM 302 / 2018
		//--------------------------------------------------------------------------------------
		// Projeto - Valoração do Brasíndice – Acrescimento/Desconto.							|
		//--------------------------------------------------------------------------------------
		// A Rotina Abaixo irá atualizar campos na BD6 e na BD7:								|
		// DESCONTO:						| ACRESCIMO 										|
		// BD6_PERDES						| BD6_MAJORA										|
		// BD6_VLRDES						|													|
		// BD6_TABDES						|													|
		//--------------------------------------------------------------------------------------
		// Campos BD7:																			|
		// DESCONTO:						| ACRESCIMO 										|
		// BD7_DSCCLI						| BD7_MAJORA 										|										|
		//--------------------------------------------------------------------------------------
		 
		/////U_CABA005()
		
		//--------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data: 31/07/2018												|
		//--------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------
		//Inicio - Fabio Bianchini - Data: 10/12/2019											|
		//--------------------------------------------------------------------------------------
		// DECISÃO DE FORUM EM 14/10/2019 - A PARTIR DE 01/11/2019 COBRAR COPART REFERENTE A    |
		// 12 MESES ENTRE ADATA DE PROCESSAMENTO E A DATA DO EVENTO. SOMENTE MATER E  			|
		// AFINIDADE(CABERJ)																	|
		//--------------------------------------------------------------------------------------	
		c_ChaveGui2 := xFilial("BD6") + &(c_AliasTab + '->('+c_AliasTab+'_CODOPE + '+c_AliasTab+'_CODLDP + '+c_AliasTab+'_CODPEG + '+c_AliasTab+'_NUMERO + '+c_AliasTab+'_ORIMOV)')
		
		u_Bloq12M(c_ChaveGui2)
		//--------------------------------------------------------------------------------------
		//Fim - Fabio Bianchini - Data: 10/12/2019												|
		//--------------------------------------------------------------------------------------	
		
		//--------------------------------------------------------------------------------------
		//Inicio - Fabio Bianchini - Data: 17/03/2020											|
		//--------------------------------------------------------------------------------------
		// Checar se BD6 é SEM copart e se possui consolidação sem cobrança					    |
		//--------------------------------------------------------------------------------------	
		u_ChkCopBDH(c_ChaveGui2)
		//--------------------------------------------------------------------------------------
		//Fim - Fabio Bianchini - Data: 17/03/2020												|
		//--------------------------------------------------------------------------------------	
	EndIf
	
	If lGlosaDir
		//Glosa direto e coloca em ativa pronta
		CritGloDir(c_AliasTab,n_RecTab,lEstaleiro)
	ElseIf lRepasse
		If ( ( cFase == '2' ) .or. ( cFase == '3' .and. nVlrGlo > 0 ) )
			AutPronta(c_AliasTab,n_RecTab)
		ElseIf ( cFase == '3' .and. ( nVlrPag == 0 ) .and. ( cTipoGuia == '01' ))
			AtuRepasse(cTipoGuia)//Leonardo Portella - 22/05/15
		ElseIf ( cFase == '3' .and. ( cTipoGuia == '02' ))
			AtuRepasse(cTipoGuia)//Leonardo Portella - 22/05/15
		EndIf
	EndIf
	
	RestArea(aArea) 
	RestArea(aAreaBD6)
	
Return

//********************************************************************************************************************************************************************************

Static Function CritGloDir(c_Alias,n_Recno,lEstaleiro)
	
	Local c_AliasQr		:= GetNextAlias()
	Local cQry			:= ''
	Local cGloCrit		:= ''
	Local nGlosaGuia	:= 0
	Local nI			:= 0
	Local cDecodeGlo	:= ''
	Local lGlosaAut		:= .F.
	Local cInfoGlo		:= ''
	Local lGloGuia		:= .F.
	Local aArea			:= GetArea()
	Local aAreaBD6		:= BD6->(GetArea())
	Local aAreaBDX		:= BDX->(GetArea())
	//BIANCHINI - 09/05/2019 - P12 - RETIRADO DO PLSA720 PARA COMPOR NOVA ESTRUTURA DE ARRAY
	local lBDX_VLRGTX	:= BDX->( fieldPos("BDX_VLRGTX") ) > 0
	local lBDX_VLTXPG 	:= BDX->( fieldPos("BDX_VLTXPG") ) > 0
	local lGloAut		:= .f.	
	
	c_ChaveGui 	:= &(c_Alias + '->('+c_Alias+'_CODOPE + '+c_Alias+'_CODLDP + '+c_Alias+'_CODPEG + '+c_Alias+'_NUMERO)')
	aItensGlo	:= {}
	
	If !lEstaleiro
		
		cQry := "SELECT DISTINCT BDX_CODGLO, BDX_DESGLO" 											+ CRLF
		cQry += "FROM " + RetSqlName('BDX') + " BDX" 												+ CRLF
		cQry += "WHERE BDX_FILIAL = '" + xFilial('BDX') + "'" 										+ CRLF
		cQry += "  	AND BDX_CODOPE = '" + &( c_Alias + '->' + c_Alias + '_CODOPE' ) + "'" 			+ CRLF
		cQry += "  	AND BDX_CODLDP = '" + &( c_Alias + '->' + c_Alias + '_CODLDP' ) + "'" 			+ CRLF
		cQry += "  	AND BDX_CODPEG = '" + &( c_Alias + '->' + c_Alias + '_CODPEG' ) + "'" 			+ CRLF
		cQry += "  	AND BDX_NUMERO = '" + &( c_Alias + '->' + c_Alias + '_NUMERO' ) + "'" 			+ CRLF
		cQry += "  	AND BDX.D_E_L_E_T_ = ' '" 														+ CRLF
		
		/*
		cQry += "  	AND BDX_CODGLO IN" 																+ CRLF
		cQry += "(" 																				+ CRLF
		cQry += "	'004','008','009','011','013','014','017','021','022','032','033','038','040','047','048','054','060','064','09N','09O','091','095','096','097','099'," + CRLF
		cQry += "	'503','505','506','507','508','509','510','511','513','515','528','530','538','542','554','560','561','702','709','710','714','716','717','718'," + CRLF
		cQry += "	'720','723','726','727','737'" 													+ CRLF
		cQry += ")" 																				+ CRLF
		*/
		
		cQry += "ORDER BY BDX_CODGLO" 																+ CRLF
		
		TcQuery cQry New Alias c_AliasQr
		
		If !c_AliasQr->(EOF())
			lGloGuia 	:= .T.
			cInfoGlo 	:= Left('GLOSA_AUTO: ' + c_AliasQr->(BDX_CODGLO + ' - ' + BDX_DESGLO),TamSx3('BDX_INFGLO')[1])
		EndIf
		
		c_AliasQr->(DbCloseArea())
		
	EndIf
	
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	
	If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))
		
		While 	!BD6->(EOF()) .and. ;
				( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == xFilial("BD6") + c_ChaveGui )
			
			If lEstaleiro .or. lGloGuia .or. ( BD6->BD6_BLOPAG == '1' )
				
				BD6->(Reclock("BD6",.F.))
				
				BD6->BD6_VLRGLO	:= If(BD6->BD6_VLRAPR > 0,BD6->BD6_VLRAPR,BD6->BD6_VLRPAG)
				
				BD6->(MsUnlock())
				
			EndIf
			
			cChaveCrit := c_ChaveGui + BD6->( BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO + BD6_SEQUEN )
			
			BDX->(DbSetOrder(1))//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
			
			If BDX->(MsSeek(xFilial('BDX') + cChaveCrit ))
				
				//Trecho do PLSA500GML (Glosa manual). O mesmo no fim do processo coloca a guia em ativa pronta
				While !BDX->(EOF()) .and. ;
						( BDX->( BDX_FILIAL + BDX_CODOPE + BDX_CODLDP + BDX_CODPEG + BDX_NUMERO + BDX_ORIMOV + BDX_CODPAD + BDX_CODPRO + BDX_SEQUEN ) == ( xFilial('BCT') + cChaveCrit ) )
					
					If !lGloGuia
						cInfoGlo := BDX->BDX_CODGLO + ' - ' + Posicione('BCT',1,xFilial('BCT') + BDX->(BDX_CODOPE + BDX_CODGLO),'BCT_DESCRI')
						cInfoGlo := Left('GLOSA_AUTO: ' + cInfoGlo,TamSx3('BDX_INFGLO')[1])
					EndIf
					
					BDX->(Reclock("BDX",.F.))
					
					BDX->BDX_INFGLO := If(lEstaleiro,'GLOSA_AUTO: ESTALEIRO - CPPS',cInfoGlo)
					BDX->BDX_VLRAPR := BD6->BD6_VLRAPR
					BDX->BDX_VLRAP2 := BD6->BD6_VLRAPR
					BDX->BDX_VLRBPR := BD6->BD6_VLRBPR
					BDX->BDX_VLRBP2 := BD6->BD6_VLRBPR
					BDX->BDX_VLRMAN := BD6->BD6_VLRMAN
					BDX->BDX_VLRMA2 := BD6->BD6_VLRMAN
					BDX->BDX_VLRPAG := If(BDX->BDX_VLRGL2 >= BD6->BD6_VLRMAN,0,BD6->BD6_VLRMAN-BDX->BDX_VLRGL2)
					BDX->BDX_PERGLO := BDX->BDX_PERGL2
					BDX->BDX_VLRGLO := BDX->BDX_VLRGL2
					BDX->BDX_DESPRO := Posicione("BR8",1,xFilial("BR8")+BD6->(BD6_CODPAD + BD6_CODPRO),"BR8_DESCRI")
					BDX->BDX_GLOSIS := BDX->BDX_CODGLO
					BDX->BDX_DTACAO := dDataBase
					
					BDX->(MsUnlock())
/*					
					aAdd(aItensGlo,;
						{;
						BD6->BD6_SEQUEN,;
						BD6->BD6_VLRPAG,;
						BD6->BD6_VLRGLO,;
						"0",;
						0,;
						0,;
						"1",; // Acao = Sempre 1, glosar!
					"1",;
						"",;
						0;
						})
*/
				//BIANCHINI - Mudança P12 - Aumento do Array
				lGloAut :=  BDX->BDX_TIPGLO == '3'
				aadd(aItensGlo,{BDX->BDX_SEQUEN,;												//01
								BDX->BDX_VLRPAG,;	//BDX->BDX_VLRMAN - Valor Contratado(TDE)	//02
								BDX->BDX_VLRGLO,;												//03
								BDX->BDX_ACAOTX,;						 						//04
								iIf(lBDX_VLRGTX, BDX->BDX_VLRGTX, 0),; 							//05
								BDX->BDX_TIPGLO,;												//06
								iIf(empty(BDX->BDX_ACAO), BDX->BDX_GLACAO, BDX->BDX_ACAO),;		//07
								iIf(empty(BDX->BDX_ACAO), "2", "1"),;							//08 
								BDX->BDX_CODTPA,; 												//09
								BDX->BDX_QTDGLO,; 	   											//10
								BDX->BDX_TIPREG,;												//11
								BDX->BDX_CODGLO,;												//12
								BDX->BDX_VLRPAG,;												//13
								BDX->BDX_PERGLO,;												//14
								iIf(lBDX_VLTXPG,BDX->BDX_VLTXPG,0),;							//15							
								lGloAut})								


					
					BDX->(DbSkip())
					
				EndDo
				
			ElseIf lEstaleiro//Estaleiro que nao caiu em conferencia
				
				u_IncBDX('GLOSA_AUTO: ESTALEIRO - CPPS','EST','GLOSA_AUTO: ESTALEIRO - CPPS')
/*				
				aAdd(aItensGlo,;
					{;
					BD6->BD6_SEQUEN,;
					BD6->BD6_VLRPAG,;
					BD6->BD6_VLRGLO,;
					"0",;
					0,;
					0,;
					"1",; // Acao = Sempre 1, glosar!
				"1",;
					"",;
					0;
					})
*/					
				//BIANCHINI - Mudança P12 - Aumento do Array
				lGloAut :=  BDX->BDX_TIPGLO == '3'
				aadd(aItensGlo,{BDX->BDX_SEQUEN,;												//01
								BDX->BDX_VLRPAG,;	//BDX->BDX_VLRMAN - Valor Contratado(TDE)	//02
								BDX->BDX_VLRGLO,;												//03
								BDX->BDX_ACAOTX,;						 						//04
								iIf(lBDX_VLRGTX, BDX->BDX_VLRGTX, 0),; 							//05
								BDX->BDX_TIPGLO,;												//06
								iIf(empty(BDX->BDX_ACAO), BDX->BDX_GLACAO, BDX->BDX_ACAO),;		//07
								iIf(empty(BDX->BDX_ACAO), "2", "1"),;							//08 
								BDX->BDX_CODTPA,; 												//09
								BDX->BDX_QTDGLO,; 	   											//10
								BDX->BDX_TIPREG,;												//11
								BDX->BDX_CODGLO,;												//12
								BDX->BDX_VLRPAG,;												//13
								BDX->BDX_PERGLO,;												//14
								iIf(lBDX_VLTXPG,BDX->BDX_VLTXPG,0),;							//15							
								lGloAut})								
				
			EndIf
			
			BD6->(DbSkip())
			
		EndDo
		
		BD6->(RestArea(aAreaBD6))
		BDX->(RestArea(aAreaBDX))
		RestArea(aArea)
		
		//Muda a fase da guia para pronta
		PLSXMUDFAS(c_Alias,"3","",BCL->BCL_TIPGUI,CtoD(""),.F.,"3",nil,nil,.T.,aItensGlo,nil,nil,nil)
		
	EndIf
	
	BD6->(RestArea(aAreaBD6))
	BDX->(RestArea(aAreaBDX))
	RestArea(aArea)
	
Return

********************************************************************************************************************************************************************************

User Function lRDAPodeRec(c_CodRDA)
	
	Local lPodeRecon := ( c_CodRDA $ GetNewPar('MV_YPODREC','139653|136158|034479|136174|122807|032883|139718|079693|105115') )
	
Return lPodeRecon

********************************************************************************************************************************************************************************

Static Function AutPronta(c_Alias,n_Recno)
	
	Local c_AliasQr		:= GetNextAlias()
	Local cQry			:= ''
	Local cGloCrit		:= ''
	Local nGlosaGuia	:= 0
	Local nI			:= 0
	Local cDecodeGlo	:= ''
	Local lGlosaAut		:= .F.
	Local cInfoGlo		:= ''
	Local lGloGuia		:= .F.
	Local aArea			:= GetArea()
	Local aAreaBD6		:= BD6->(GetArea())
	Local aAreaBDX		:= BDX->(GetArea())
	Local nVlrBD7		:= 0

	//BIANCHINI - 09/05/2019 - P12 - RETIRADO DO PLSA720 PARA COMPOR NOVA ESTRUTURA DE ARRAY
	local lBDX_VLRGTX	:= BDX->( fieldPos("BDX_VLRGTX") ) > 0
	local lBDX_VLTXPG 	:= BDX->( fieldPos("BDX_VLTXPG") ) > 0
	local lGloAut		:= .f.	
	
	c_ChaveGui 	:= &(c_Alias + '->('+c_Alias+'_CODOPE + '+c_Alias+'_CODLDP + '+c_Alias+'_CODPEG + '+c_Alias+'_NUMERO)')

	aItensGlo	:= {}
	
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	
	If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))
		
		While 	!BD6->(EOF()) .and. ;
				( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == xFilial("BD6") + c_ChaveGui )
			
			nVlrBD7 := 0
			
			cChaveBD6 := xFilial("BD6") + c_ChaveGui
			
			BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC
			
			If BD7->(MsSeek(cChaveBD6))
				
				While BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) == cChaveBD6
					
					If  ( BD6->( BD6_CODPAD + BD6_CODPRO + BD6_SEQUEN ) == BD7->( BD7_CODPAD + BD7_CODPRO + BD7_SEQUEN ) )
						
						If BD7->BD7_VLRGLO > 0
							
							BD7->(Reclock('BD7',.F.))
							
							BD7->BD7_VLRPAG := BD7->BD7_VLRPAG + BD7->BD7_VLRGLO
							BD7->BD7_VLRMAN	:= BD7->BD7_VLRPAG
							BD7->BD7_VLRAPR	:= BD7->BD7_VLRPAG
							//BD7->BD7_VALORI	:= BD7->BD7_VLRPAG
							BD7->BD7_VLRGLO	:= 0
							
							BD7->(MsUnlock())
							
						EndIf
					
						If ( BD7->BD7_SITUAC = '1' ) .and. ( BD7->BD7_BLOPAG <> '1' )
							nVlrBD7 += BD7->BD7_VLRPAG
						EndIf

					EndIf
					//BIANCHINI - 20/07/2020 - Retirado daqui porque estava acumulando todos os SEQUEN´s.
					//If ( BD7->BD7_SITUAC = '1' ) .and. ( BD7->BD7_BLOPAG <> '1' )
					//	nVlrBD7 += BD7->BD7_VLRPAG
					//EndIf
					BD7->(DbSkip())
					
				EndDo
				
			EndIf
			
			BD6->(Reclock("BD6",.F.))
			
			BD6->BD6_VLRPAG	:= nVlrBD7
			BD6->BD6_VLRGLO	:= 0
			BD6->BD6_VLRMAN	:= BD6->BD6_VLRPAG
			//BD6->BD6_VLRBPR	:= BD6->BD6_VLRPAG    //Valor Contratado.  Deve deixar mostrar o valor original
			//BD6->BD6_VALORI	:= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO 
			
			BD6->(MsUnlock())
			
			cChaveCrit := c_ChaveGui + BD6->( BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO + BD6_SEQUEN )
			
			BDX->(DbSetOrder(1))//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
			
			If BDX->(MsSeek(xFilial('BDX') + cChaveCrit ))
				
				//Trecho do PLSA500GML (Glosa manual). O mesmo no fim do processo coloca a guia em ativa pronta
				While !BDX->(EOF()) .and. ;
						( BDX->( BDX_FILIAL + BDX_CODOPE + BDX_CODLDP + BDX_CODPEG + BDX_NUMERO + BDX_ORIMOV + BDX_CODPAD + BDX_CODPRO + BDX_SEQUEN ) == ( xFilial('BCT') + cChaveCrit ) )
					
					BDX->(Reclock("BDX",.F.))
					
					BDX->BDX_INFGLO := 'REPASSE INTEGRAL'
					BDX->BDX_VLRAPR := BD6->BD6_VLRAPR
					BDX->BDX_VLRAP2 := BD6->BD6_VLRAPR
					BDX->BDX_VLRBPR := BD6->BD6_VLRBPR
					BDX->BDX_VLRBP2 := BD6->BD6_VLRBPR
					BDX->BDX_VLRMAN := BD6->BD6_VLRMAN
					BDX->BDX_VLRMA2 := BD6->BD6_VLRMAN
					BDX->BDX_VLRPAG := BD6->BD6_VLRAPR
					BDX->BDX_PERGLO := BDX->BDX_PERGL2
					BDX->BDX_VLRGLO := BDX->BDX_VLRGL2
					BDX->BDX_DESPRO := Posicione("BR8",1,xFilial("BR8")+BD6->(BD6_CODPAD + BD6_CODPRO),"BR8_DESCRI")
					BDX->BDX_GLOSIS := BDX->BDX_CODGLO
					BDX->BDX_DTACAO := dDataBase
					
					BDX->(MsUnlock())
						
					aadd(aItensGlo,{BDX->BDX_SEQUEN,;												//01
									BDX->BDX_VLRPAG,;	//BDX->BDX_VLRMAN - Valor Contratado(TDE)	//02
									BDX->BDX_VLRGLO,;												//03
									BDX->BDX_ACAOTX,;						 						//04
									iIf(lBDX_VLRGTX, BDX->BDX_VLRGTX, 0),; 							//05
									BDX->BDX_TIPGLO,;												//06
									iIf(empty(BDX->BDX_ACAO), BDX->BDX_GLACAO, BDX->BDX_ACAO),;		//07
									iIf(empty(BDX->BDX_ACAO), "2", "1"),;							//08 
									BDX->BDX_CODTPA,; 												//09
									BDX->BDX_QTDGLO,; 	   											//10
									BDX->BDX_TIPREG,;												//11
									BDX->BDX_CODGLO,;												//12
									BDX->BDX_VLRPAG,;												//13
									BDX->BDX_PERGLO,;												//14
									iIf(lBDX_VLTXPG,BDX->BDX_VLTXPG,0),;							//15							
									lGloAut})								
					
					BDX->(DbSkip())
					
				EndDo
				
			EndIf
			
			BD6->(DbSkip())
			
		EndDo
		
		BD6->(RestArea(aAreaBD6))
		BDX->(RestArea(aAreaBDX))
		RestArea(aArea)
		
		//Muda a fase da guia para pronta
		PLSXMUDFAS(c_Alias,"3","",BCL->BCL_TIPGUI,CtoD(""),.F.,"3",nil,nil,.T.,aItensGlo,nil,nil,nil)
		
	EndIf
	
	BD6->(RestArea(aAreaBD6))
	BDX->(RestArea(aAreaBDX))
	RestArea(aArea)
	
Return

*******************************************************************************************************

//Leonardo Portella - 22/05/15 - Atualizacao do valor de consulta nas guias de Consulta no
//repasse Integral geradas com base no lote de intercambio da Caberj

Static Function AtuRepasse(cTipGuia)
	
	aAreaRep := GetArea()
	aArBD6Rep := BD6->(GetArea())
	aArBD7Rep := BD7->(GetArea())
	
	If BD6->(DbSeek(xFilial("BD6") + BD5->(BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_ORIMOV)))
		
		cIdLote 	:= cValToChar(Val(Left(BCI->BCI_ARQUIV,At('_',BCI->BCI_ARQUIV)-1)))
		
		cAliasRep 	:= GetNextAlias()
		
		cQryRep 	:= "SELECT TIPOGUIA,TOTALGERAL" 								+ CRLF
		cQryRep 	+= "FROM RECIPR_GUIA" 											+ CRLF
		cQryRep 	+= "WHERE IDLOTE = '" + cIdLote + "'" 							+ CRLF
		cQryRep 	+= "	AND NUMEROGUIAPRESTADOR = '" + BD5->BD5_NUMIMP + "'" 	+ CRLF
		
		TcQuery cQryRep New Alias cAliasRep
		
		If !cAliasRep->(EOF())
			
			n_TotalGeral := cAliasRep->TOTALGERAL
			
			While 	!BD6->(EOF()) .and. ;
					BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV) == BD5->(BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_ORIMOV)
				
				BD6->(Reclock('BD6',.F.))
				
				If ( cTipGuia == '01' )//Consulta so tera 1 procedimento
					
					BD6->BD6_VLRAPR := n_TotalGeral
					BD6->BD6_VLRPAG := n_TotalGeral
					BD6->BD6_VLRMAN := n_TotalGeral
					BD6->BD6_VLRBPR := n_TotalGeral
					//BD6->BD6_VALORI := n_TotalGeral
					BD6->BD6_VLRGLO := 0
					
				ElseIf ( cTipGuia == '02' ) .and. ( cAliasRep->TIPOGUIA == 'SDTI' )
					
					BD6->BD6_BLOCPA := '1'
					BD6->BD6_VLRTPF := '0'
					BD6->BD6_DESBPF := 'REPASSE - REG ATD INTER CABERJ'
					
				EndIf
				
				BD6->(Msunlock())
				
				If 	( cTipGuia == '01' ) .and. ;
						BD7->(DbSeek(xFilial("BD7") + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN)))
					
					BD7->(RecLock("BD7",.F.))
					
					BD7->BD7_VLRPAG := n_TotalGeral
					BD7->BD7_VLRAPR := n_TotalGeral
					
					BD7->(MsUnlock())
					
				EndIf
				
				BD6->(DbSkip())
				
			EndDo
			
			//Muda a fase da guia para pronta
			PLSXMUDFAS('BD5',"3","",BD5->BD5_TIPGUI,CtoD(""),.F.,"3",nil,nil,.T.,{},nil,nil,nil)
			
		EndIf
		
		cAliasRep->(DbCloseArea())
		
	EndIf
	
	BD6->(RestArea(aArBD6Rep))
	BD7->(RestArea(aArBD7Rep))
	RestArea(aAreaRep)
	
Return

*************************************************************************************************************************

//O padrao deleta todas as glosas, acabando com o historico. Quebro a chave e depois atualizo de volta para evitar isso.

User Function UpdBDXOri(nRecBD6,lMarca)
	
	Local aArea 	:= GetArea()
	Local aArBD6	:= BD6->(GetArea())
	Local cUpd		:= ''
	Local cOriDif	:= 'X'
	
	BD6->(DbGoTo(nRecBD6))
	
	If ( BD6->BD6_VLRGLO > 0 ) .and. ( BCL->BCL_ALIAS == 'BD5' )
		
		cUpd := "UPDATE " + RetSqlName('BDX') + " SET BDX_ORIMOV = '" + If(lMarca,cOriDif,BD6->BD6_ORIMOV) + "'" 	+ CRLF
		cUpd += "WHERE BDX_FILIAL = '" + xFilial('BDX') + "'" 														+ CRLF
		cUpd += "  AND BDX_CODOPE = '" + BD6->BD6_CODOPE + "'" 														+ CRLF
		cUpd += "  AND BDX_CODLDP = '" + BD6->BD6_CODLDP + "'" 														+ CRLF
		cUpd += "  AND BDX_CODPEG = '" + BD6->BD6_CODPEG + "'" 														+ CRLF
		cUpd += "  AND BDX_NUMERO = '" + BD6->BD6_NUMERO + "'" 														+ CRLF
		cUpd += "  AND BDX_CODPAD = '" + BD6->BD6_CODPAD + "'" 														+ CRLF
		cUpd += "  AND BDX_CODPRO = '" + BD6->BD6_CODPRO + "'" 														+ CRLF
		cUpd += "  AND BDX_SEQUEN = '" + BD6->BD6_SEQUEN + "'" 														+ CRLF
		cUpd += "  AND BDX_ORIMOV = '" + If(lMarca,BD6->BD6_ORIMOV,cOriDif) + "'" 									+ CRLF
		cUpd += "  AND D_E_L_E_T_ = ' '" 																			+ CRLF
		
		If TcSqlExec(cUpd) < 0
			QOut("Falha na atualização do BDX_ORIMOV [ " + TcSqlError() + " ]")
		EndIf
		
		//BDX->(DbCommit())
		
	EndIf
	
	BD6->(RestArea(aArBD6))
	RestArea(aArea)
	
Return

*************************************************************************************************************************
