#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rdmake    ³PLSXMLPAD ³ Autor ³ Alexander Santos				  ³ Data ³ 19.07.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Rdmake para troca do codigo da tabela								  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

// Leonardo Portella - 24/06/11 - Alteracao para fazer o de/para de tabelas conforme a tabela Medlink atual

User Function PLSXMLPAD(cCodTab,cCodPro,c_TissVer)

Local aArea			:= GetArea()
Local aRet			:= {}
Local aRetBKP		:= {}
Local cQuery		:= ""
Local cAliasTMP		:= GetNextAlias()
Local lAchouTab		:= .F.
Local lAchouProc	:= .F.
Local aTabs			:= {}					// Leonardo Portella - 16/01/12
Local lDeParaRec	:= .F.
Local cDescric		:= ""
Local aAreaBR8		:= BR8->(GetArea())
Local cTpProc		:= ""

//Leonardo Portella - Inicio - 03/12/13
Default cCodTab		:= allTrim(paramixb[1])
Default cCodPro 	:= allTrim(paramixb[2])
Default c_TissVer	:= '2.02.03'			// allTrim(paramixb[6])	//Leonardo Portella - 03/09/14 - Virada TISS 3. Manter compatibilidade com TISS 2.02.03
//Leonardo Portella - Fim 

cDescric := POSICIONE("BR8",1,xFilial("BR8")+cCodTab+cCodPro,"BR8_DESCRI")
cTpProc  := BR8->BR8_TPPROC

RestArea(aAreaBR8)

aRet	:= {cCodTab,cCodPro,cDescric}
aRetBKP	:= aClone(aRet)
aAdd(aRetBKP,.F.)

If c_TissVer < '3.00.00' // Leonardo Portella - 03/09/14 - Virada TISS 3. Manter compatibilidade com TISS 2.02.03

	if select(cAliasTMP) > 0 
		(cAliasTMP)->(DbCloseArea())
	endif
	
	//Cadastro de/para procedimentos reciprocidade: CDDPRECIP (SZ7)
	cQuery := " SELECT Z7_TABPROC,Z7_PROCLOC" 					+ CRLF
	cQuery += " FROM " + RetSqlName('SZ7') 						+ CRLF
	cQuery += " WHERE Z7_FILIAL = '" + xFilial('SZ7') + "'" 	+ CRLF
	cQuery +=	" AND Z7_CODRDA = '" + BAU->BAU_CODIGO + "'" 	+ CRLF
	cQuery +=	" AND Z7_PROCREC = '" + cCodPro + "'" 			+ CRLF
	cQuery +=	" AND D_E_L_E_T_ = ' '" 						+ CRLF

	TcQuery cQuery New Alias (cAliasTMP)

	If !(cAliasTMP)->(EOF())
		aRet		:= {(cAliasTMP)->Z7_TABPROC, (cAliasTMP)->Z7_PROCLOC}
		lDeParaRec	:= .T.
	Else
		lDeParaRec	:= .F.
	EndIf
	(cAliasTMP)->(DbCloseArea())

	aRetBKP[4]		:= lDeParaRec

	If !lDeParaRec //Se nao tem de/para procedimentos reciprocidade eu busco normalmente

		if select(cAliasTMP) > 0 
			(cAliasTMP)->(DbCloseArea())
		endif

		//Busco a tabela que contem o procedimento e esta amarrada no de/para da Medlink (PAT)
		cQuery := " SELECT DISTINCT BR8_CODPAD, TABS_MEDLINK(BR8_CODPAD, BR8_CODPSA, " + If(cEmpAnt == '01',"'CABERJ'","'INTEGRAL'") + ") TABS_MEDLINK"	+ CRLF
		cQuery += " FROM " + RetSqlName("BR8") + " BR8" 			   										  					 						+ CRLF
		cQuery += " WHERE BR8.D_E_L_E_T_ = ' ' " 						   										  					   					+ CRLF
		cQuery +=	" AND BR8_FILIAL       = '" + xFilial('BR8') + "'" 												   			 			 			+ CRLF
		cQuery +=	" AND TRIM(BR8_CODPSA) = '" + cCodPro + "'" 				 												   			 			+ CRLF
		cQuery += " ORDER BY BR8_CODPAD DESC" 																							 				+ CRLF

		TcQuery cQuery New Alias (cAliasTMP)

		(cAliasTMP)->(dbGoTop())

		lAchouProc := !(cAliasTMP)->(EOF())

		While !(cAliasTMP)->(EOF())

			//Se encontrei, altero a tabela da Medlink pela tabela Caberj apontada no "de/para"
			If cCodTab $ allTrim((cAliasTMP)->TABS_MEDLINK)
				cCodTab		:= (cAliasTMP)->BR8_CODPAD
				lAchouTab	:= .T.
				exit
			EndIf

			aAdd(aTabs, (cAliasTMP)->BR8_CODPAD)	//Leonardo Portella - 16/01/12

			(cAliasTMP)->(dbSkip())
		EndDo
		(cAliasTMP)->(dbCloseArea())

		aRet 	:= {cCodTab,cCodPro,cDescric}
		aRetBKP	:= aClone(aRet)

		//Leonardo Portella - 24/10/14 - Chamado ID: 14163
		aAdd(aRetBKP,lDeParaRec)

		If !lAchouProc .or. !lAchouTab

			// So altero se para XXXXXXXX se nao tiver encontrado com o procedimento e tabela originais na BR8
			BR8->(DbSetOrder(1))
			If !BR8->(MsSeek(xFilial('BR8') + cCodTab + cCodPro))

				// Caso nao encontre o procedimento em nenhuma tabela, retorno XXXXXXXX para identificar que o procedimento veio errado no XML
				If !lAchouProc

					aRet := {cCodTab, Replicate('X',TamSX3('BR8_CODPSA')[1]), cDescric}
				
				//Caso nao encontre tabela de "de/para", retorno XX para identificar que a tabela veio errada no XML (existe tabela com o procedimento, mas nao eh a informada)
				ElseIf !lAchouTab
			
					//Leonardo Portella - 16/01/12 - Inicio - Caso a tabela nao exista e somente exista uma tabela com aquele codigo, utilizar este, conforme definido com Eloiza.
					//aRet := {Replicate('X',TamSX3('BR8_CODPAD')[1]),cCodPro}
					If len(aTabs) == 1
						aRet := {aTabs[1], cCodPro, cDescric}
					//Existe mais de uma tabela contendo o procedimento informado
					Else
						aRet := {Replicate('X', TamSX3('BR8_CODPAD')[1]), cCodPro, cDescric}
					EndIf
					//Leonardo Portella - 16/01/12 - Fim
				
				EndIf

			EndIf

			BR8->(RestArea(aAreaBR8))
		
		EndIf
	
	EndIf

Else	// versão acima da versão 3
	
	BeginSql Alias cAliasPCW
		%noparser%
		SELECT PCW_CODPAD, PCW_CODPSA, PCW_TABPRO, PCW_CODPRO 
		FROM %table:PCW%
		WHERE PCW_CODRDA   = %exp:BAU->BAU_CODIGO%
			AND PCW_CODPAD = %exp:cCodTab%
			AND PCW_CODPSA = %exp:cCodPro%
			AND %notdel%
		ORDER BY PCW_CODPSA
	EndSql
	
	if (cAliasPCW)->(!EOF())
		cCodTab  := (cAliasPCW)->PCW_TABPRO
		cCodPro  := (cAliasPCW)->PCW_CODPRO
		cDescric := POSICIONE("BR8", 1, xFilial("BR8")+(cAliasPCW)->PCW_TABPRO+(cAliasPCW)->PCW_CODPRO, "BR8_DESCRI")
		aRet := { (cAliasPCW)->PCW_TABPRO, (cAliasPCW)->PCW_CODPRO, cDescric}
	else
		aRet := {cCodTab, cCodPro, cDescric}
	endif 
	
	if select(cAliasPCW) > 0 
		(cAliasPCW)->(DbCloseArea())
	endif

EndIf // Leonardo Portella - 03/09/14 - Virada TISS 3. Manter compatibilidade com TISS 2.02.03

//Leonardo Portella - 14/04/15 - Inicio 
//De|para emergencial da rede DASA que nao conseguiu atualizar os codigos CIEFAS

// 07/07/21 - Fred -> o bloco abaixo foi comentado visto que existia erro na query e na execução
// da mesma (query montada na cQry e executada a cQuery). Chegando à conclusão que esta regra nunca
// aconteceu de fato (se entrasse neste 'if' daria erro). Onde, conforme conversa com Roberto, até
// uma análise da regra, se de fato é pertinente, ficará fora.
/*
If BAU->BAU_CODIGO $ '060402|111406|002127|134210|103226|140023|140142|140040|140139|140066|140155|140171|111414'

	//CIEFAS, exclui pacotes e exclui codigos proprios (entre 80 e 99)
	If ( cCodTab == '01' ) .and. ( cTpProc <> '6' ) .and. ( Left(cCodPro,2) < '80' )

		if select(cAliasTMP) > 0 
			(cAliasTMP)->(DbCloseArea())
		endif

		cQry := " SELECT BA8A.BA8_CDPADP AS CODTAB,     TRIM(BA8A.BA8_CODPRO) as CODPRO,"			+ CRLF
		cQry +=		   " BA8B.BA8_CDPADP as CODTAB_ANT, TRIM(BA8B.BA8_CODANT) as COD_ANTERIOR,"		+ CRLF
		cQry +=		   " TRIM(BA8A.BA8_DESCRI) as DESCRI"				 							+ CRLF
		cQry += " FROM " + RetSqlName('BA8') + " BA8A"												+ CRLF
		cQry +=	  " INNER JOIN " + RetSqlName('BA8') + " BA8B"										+ CRLF
		cQry +=		" ON (    BA8B.BA8_FILIAL = '" + xFilial('BA8') + "'"							+ CRLF
		cQry +=			" AND BA8B.BA8_CDPADP = '16'" 												+ CRLF
		cQry +=			" AND BA8B.BA8_CODPRO = BA8A.BA8_CODANT)"									+ CRLF
		cQry += " WHERE BA8A.D_E_L_E_T_ = ' ' AND BA8B.D_E_L_E_T_ = ' '"							+ CRLF
		cQry +=	  "	AND BA8A.BA8_FILIAL = '" + xFilial('BA8') + "'" 								+ CRLF
		cQry +=	  "	AND BA8A.BA8_CDPADP = '" + cCodTab + "'" 										+ CRLF
		cQry +=	  "	AND BA8A.BA8_CODPRO = '" + cCodPro + "'" 										+ CRLF
		cQry +=	  "	AND BA8A.BA8_NIVEL = '4'" 														+ CRLF
		cQry +=	  " AND BA8B.BA8_NIVEL = '4'" 														+ CRLF
		cQry += " ORDER BY BA8A.BA8_CODPRO"															+ CRLF

		TcQuery cQry New Alias (cAliasTMP)

		// De|para com os codigos TUSS
		If !(cAliasTMP)->(EOF())
			aRet := {(cAliasTMP)->CODTAB_ANT, (cAliasTMP)->COD_ANTERIOR, (cAliasTMP)->DESCRI}
		EndIf
		(cAliasTMP)->(DbCloseArea())

	EndIf

EndIf
*/
// 07/07/21 - Fred -> fim alteração

// Leonardo Portella - 14/04/15 - Fim 

If IsInCallStack('U_TABPROCXML')
	aAdd(aRet,aRetBKP)

// Na importacao mantenho os procedimentos mesmo que nao exista na base Protheus. Sem alteracao no enviado no XML, exceto Reciprocidade 
// por causa do De/Para (SZ7)
ElseIf !aRetBKP[4]

	// Leonardo Portella - 24/10/14 - Inicio - Chamado ID: 14163
	// aRet := aRetBKP
	aRet 	:= Array(3)
	aRet[1]	:= aRetBKP[1]
	aRet[2]	:= aRetBKP[2]
	aRet[3]	:= aRetBKP[3]
	// Leonardo Portella - 24/10/14 - Fim - Chamado ID: 14163

EndIf

RestArea(aArea)

Return aRet

*****************************************************************************************************************************************************

User Function TabProcXML

	Local aArea 		:= GetArea()
	Local aAreaBR8		:= BR8->(GetArea())

	Private c_VerTISS
	Private cMGet 		:= ''
	Private cProc      	:= Space(30)
	Private cTab       	:= Space(2)
	Private dEve		:= StoD('')

	aOpcoes    := {"2.02.03","3.02.00"}
	aSort(aOpcoes,,,{|x,y| x > y})
	c_VerTISS  := "2.02.03"//aOpcoes[1]

	SetPrvt("oDlg1","oSay1","oSay2","oSay3","oGet1","oGet2","oGet3","oMGet1","oSBtn1","oSBtn2")

	oDlg1      := MSDialog():New( 088,232,699,927,"Tipo de participacao",,,.F.,,,,,,.T.,,,.T. )

	oSay1      := TSay():New( 016,008,{||"*"}				,oDlg1,,,.F.,.F.,.F.,.T.,656372	,CLR_WHITE,044,008)
	oSay2      := TSay():New( 016,011,{||"Tabela no XML"}	,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
	oSay3      := TSay():New( 016,065,{||"*"}				,oDlg1,,,.F.,.F.,.F.,.T.,656372	,CLR_WHITE,040,008)
	oSay4      := TSay():New( 016,068,{||"Procedimento"}	,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay5      := TSay():New( 016,173,{||"Data evento"}	,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)

	oGet1      := TGet():New( 016,048,{|u| If(PCount()>0,cTab:=u,cTab)}	,oDlg1,012,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTab",,)
	oGet2      := TGet():New( 016,104,{|u| If(PCount()>0,cProc:=u,cProc)}	,oDlg1,064,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cProc",,)
	oGet3      := TGet():New( 016,204,{|u| If(PCount()>0,dEve:=u,dEve)}	,oDlg1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dEve",,)

	oMGet1     := TMultiGet():New( 056,008,{|u| If(PCount()>0,cMGet:=u,cMGet)},oDlg1,332,240,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

	oSBtn1     := SButton():New( 036,008,1,{||Busca(c_VerTISS)}		,oDlg1,,"", )
	oSBtn2     := SButton():New( 036,040,2,{||oDlg1:End()}	   		,oDlg1,,"", )
	oSBtn3     := SButton():New( 036,072,6,{||PrintLog(cMGet)}		,oDlg1,,"", )

	oSay6      := TSay():New( 036,105,{||"Para que as alterações feitas no Procedimento tenham efeito é necessário que o analista do "}	,oDlg1,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,300,008)
	oSay6      := TSay():New( 044,105,{||"Contas Médicas saia da tela de Digitação do Contas Médicas!"}									,oDlg1,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,300,008)
//oSay7      := TSay():New( 016,250,{||"*"}					,oDlg1,,,.F.,.F.,.F.,.T.,656372	,CLR_WHITE,040,008)
//oSay8      := TSay():New( 016,253,{||"Versão XML TISS"}	,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)

//oCBox1     := TComboBox():New( 016,300,{|u| If(PCount()>0,c_VerTISS:=u,c_VerTISS)},aOpcoes,040,010,oDlg1,,{||},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,c_VerTISS )

	oDlg1:Activate(,,,.T.)

	BR8->(RestArea(aAreaBR8))
	RestArea(aArea)

Return

*************************************

Static Function Busca(c_VerTISS)

	Local aRet 		:= U_PLSXMLPAD(AllTrim(cTab),AllTrim(cProc),c_VerTISS)
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	Local cChaveBKC	:= ''
	Local lContinua	:= .T.

	cMGet := 'Empresa: ' + AllTrim(SM0->M0_NOMECOM) 																+ CRLF
	cMGet += CRLF

	If ( ( aRet[1] <> aRet[3][1] ) .or. ( aRet[2] <> aRet[3][2] ) )
	
		cMGet += 'Tabela informada: ' + aRet[3][1] 																	+ CRLF
		cMGet += 'Proc. informado:  ' + aRet[3][2] 																	+ CRLF
		cMGet += CRLF
	
		If At('X',aRet[1]) > 0
			cMGet += 'Tabela NAO localizado Protheus: ' + aRet[1]													+ CRLF
		Else
			cMGet += 'Tabela localizado Protheus: ' + aRet[1]														+ CRLF
		EndIf
	
		If At('X',aRet[2]) > 0
			cMGet += 'Proc. NAO localizado Protheus: ' + aRet[2]													+ CRLF
		Else
			cMGet += 'Proc. localizado Protheus:  ' + aRet[2]														+ CRLF
		EndIf
	
	Else
		cMGet += 'Tabela Protheus: ' + aRet[1] 																		+ CRLF
		cMGet += 'Proc. Protheus:  ' + aRet[2] 																		+ CRLF
	EndIf

	cMGet += 'De/para Reciprocidade : ' + If(aRet[3][3],'SIM','NÃO')												+ CRLF

	BR8->(DbSetOrder(1))
	If BR8->(MsSeek(xFilial('BR8') + aRet[1] + aRet[2]))
		cMGet += 'Descr.:  ' + AllTrim(BR8->BR8_DESCRI) 													   		+ CRLF
	EndIf

	cMGet += CRLF + 'Erro 581:' 																			 		+ CRLF
	cMGet += 'Conteúdos possíveis da TAG <posicaoProfissional> NO XML:' + CRLF 								  		+ CRLF

	cQry := "SELECT 'XML :' || BWT_CODEDI PART_XML,'PROTHEUS: ' || BWT_CODPAR PART_PROTHEUS,BWT_DESCRI DESCRI"	 	+ CRLF
	cQry += "FROM " + RetSqlName('BWT')																		   		+ CRLF
	cQry += "WHERE D_E_L_E_T_ = ' '" 																		   		+ CRLF
	cQry += "ORDER BY 2"			 																		   		+ CRLF

	TcQuery cQry New Alias cAlias

	While !cAlias->(EOF())

		cMGet += cAlias->PART_PROTHEUS + ' ' + cAlias->PART_XML + ' ' + cAlias->DESCRI + CRLF
	 
		cAlias->(DbSkip())

	EndDo

	cAlias->(DbCloseArea())

	cMGet += CRLF + 'TDE do procedimento:' + CRLF

	cAlias := GetNextAlias()

	cQry := "SELECT BD4_CODTAB,BD4_CODIGO,BD4_CODTPA,BD4_VIGINI,BD4_VIGFIM"			+ CRLF
	cQry += "FROM " + RetSqlName('BD4') 											+ CRLF
	cQry += "WHERE BD4_FILIAL = '" + xFilial('BD4') + "'" 							+ CRLF
	cQry += "  AND BD4_CDPADP = '" + aRet[1] + "'" 									+ CRLF
	cQry += "  AND BD4_CODPRO = '" + aRet[2] + "'" 									+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 												+ CRLF

	TcQuery cQry New Alias cAlias

	If cAlias->(EOF())
		cMGet += CRLF + 'Não foi encontrado nenhum dado na TDE este procedimento... [ ' + DtoC(dEve) + ' ]'					+ CRLF
	EndIf

	While !cAlias->(EOF())
    
		lContinua := .T.
	
		cMGet += CRLF + 'Unidade: ' + cAlias->BD4_CODIGO + ' Tabela TDE: ' + cAlias->BD4_CODTAB + ' '
	
		If empty(dEve)
			cMGet += "Vigência [ " + DtoC(StoD(cAlias->BD4_VIGINI)) + " ] até [ " + DtoC(StoD(cAlias->BD4_VIGFIM)) + " ]" 	+ CRLF
		ElseIf ( StoD(cAlias->BD4_VIGINI) <= dEve ) .and. ( empty(cAlias->BD4_VIGFIM) .or. ( StoD(cAlias->BD4_VIGFIM) >= dEve ) )
			cMGet += "Vigência [ " + DtoC(StoD(cAlias->BD4_VIGINI)) + " ] até [ " + DtoC(StoD(cAlias->BD4_VIGFIM)) + " ] - OK - atende no dia [ " + DtoC(dEve) + " ]" + CRLF
		Else
			cMGet += "Vigência [ " + DtoC(StoD(cAlias->BD4_VIGINI)) + " ] até [ " + DtoC(StoD(cAlias->BD4_VIGFIM)) + " ] NÃO atende no dia [ " + DtoC(dEve) + " ]" + CRLF
			lContinua := .F.
		EndIf
	
		If lContinua
		
			If !empty(cAlias->BD4_CODTPA)
				cMGet += '- Tipo Participação: ' + cAlias->BD4_CODTPA + '[ BD4 ( TDE ) ] '
				cMGet += POSICIONE('BWT',1,xFilial('BWT')+PLSINTPAD()+cAlias->BD4_CODTPA,'BWT_DESCRI') + CRLF
			Else
				cMGet += '- Tipo Participação:    [ BD4 ( TDE ) ] Não localizado' + CRLF
			EndIf
		
			BKC->(DbSetOrder(1))//BKC_FILIAL, BKC_CODIGO, BKC_CODOPE, BKC_CODPAR
		
			cChaveBKC := xFilial('BKC')+cAlias->BD4_CODIGO + PLSINTPAD()
			
			If BKC->(MsSeek(cChaveBKC))
			
				While ( cChaveBKC == BKC->(BKC_FILIAL + BKC_CODIGO + BKC_CODOPE) )
				
					cCodPar := BKC->BKC_CODPAR
				
					If !empty(cCodPar)
						cMGet += '- Tipo Participação: ' + cCodPar + '[ BKC ( Detalhe da Unidade de Medida de Saúde ) ] '
						cMGet += POSICIONE('BWT',1,xFilial('BWT')+PLSINTPAD()+cCodPar,'BWT_DESCRI') + CRLF
					EndIf
				
					BKC->(DbSkip())
				
				EndDo
			
			Else
				cMGet += '- Tipo Participação: Não foi encontrado nas tabelas [ BD4 ( TDE ) e BKC ( Detalhe da Unidade de Medida de Saúde ) ]' + CRLF
			EndIf
		
		EndIf
	
		cAlias->(DbSkip())
	EndDo

	cAlias->(DbCloseArea())

Return

******************************************************************************************************************************************************************

User Function ParTISS3

	Local lConfirmou := .F.

	Private oProcOk    	:= LoadBitMap(GetResources(),"BR_VERMELHO")
	Private oProcNOk 	:= LoadBitMap(GetResources(),"BR_VERDE")

	Private aObjects 	:= {}
	Private aSizeAut 	:= MsAdvSize(.T.)//Vai usar Enchoice

	Private aCabPEG		:= {" "	," ","Oper."	,"Local","PEG"	,"Cod. RDA"	,"Nome RDA"	,"Vlr. Apres."	,"Vlr. Glos."	,"Vlr. Pagto."	}
	Private aTamPEG		:= {15	,15	,20		,20		,30		,25			,150		,80				,80				,80				}

	lAjustHor	:= .T.
	lAjustVert	:= .T.

	aAdd( aObjects, { 100,  30, lAjustHor, lAjustVert, .T. } )

	nSepHoriz 	:= 5
	nSepVert	:= 5
	nSepBorHor 	:= 5
	nSepBorVert	:= 5
                    
	aInfo  		:= { aSizeAut[1], aSizeAut[2], aSizeAut[3], aSizeAut[4], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
	aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

	DEFINE MSDIALOG oDlg TITLE "Conferência de Guias/PEGs - Fase 3.5" FROM 00,00 to 40,100// aSizeAut[2],aSizeAut[1] TO aSizeAut[6],aSizeAut[5] //OF GetWndDefault() PIXEL
    
	oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2]			,{||'PEGs'}	,oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
	
	bDbClickPEG	:= {|| }

	bChangePEG	:= {|| }
	
	bLinePEG	:= {|| }

	oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]-10,,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.T.,,.T.,,.F.,,, )

	//oBrwPEG:SetArray(aBrwPEG)

	//oBrwPEG:bLine 	:= bLinePEG

	oBrwPEG:nScrollType := 1 // Scroll VCR

	aBut 	:= {}
	
	aAdd(aBut, {"PARAMETROS"	, {||U_Caba322Leg()}	, "Legenda"	, "Legenda"	} )
	
	bOk 	:= {||lConfirmou := .T.,oDlg:End()}
	bCancel := {||lConfirmou := .F.,oDlg:End()}
	
	ACTIVATE MSDIALOG oDlg /*ON INIT EnchoiceBar(oDlg,bOk,bCancel,.F.,aBut)*/ CENTERED

	If lConfirmou

		oProcess := MsNewProcess():New({|lFim| Alert('OK') },AllTrim(SM0->M0_NOMECOM),"",.F.)
		oProcess:Activate()

	EndIf

Return

User Function TSTMON

	cRet := PLSGETVINC("BTU_CDTERM", "BAU",.F.,"40")
	cRet := PLSGETVINC("BTU_CDTERM", "BAG",.F.,"40")

Return
