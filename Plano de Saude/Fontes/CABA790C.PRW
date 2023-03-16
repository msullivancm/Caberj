#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё DEFINE
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
#DEFINE PLS_ADMINITRADOR '2'
STATIC lEvo := .F.
STATIC cPlMsgAud := ''
//-------------------------------------------------------------------
/*/{Protheus.doc} CABA790C

Controle da class auditoria

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
CLASS CABA790C FROM PLSCONTR

	DATA cAudito			AS STRING
	DATA cDirFax   	 	AS STRING
	DATA cPerfil   	 	AS STRING
	DATA cDesPerf  	 	AS STRING
	DATA cCodDep	 		AS STRING
	DATA cOperad			AS STRING
	DATA cACab				AS STRING
	DATA cAIte				AS STRING
	DATA cACri				AS STRING
	DATA nIdxIte			AS NUMERIC
	DATA nIdxCri			AS NUMERIC
	DATA cOwner			AS STRING
	DATA cAllPerfil     	AS STRING
	DATA cNumGuia       	AS STRING
	DATA cCoddepa			AS STRING
	DATA lLibGuia			AS LOGIC
	DATA lIncProc			AS LOGIC
	DATA lVldRot			AS LOGIC
	DATA lIncDem   	 	AS LOGIC
	DATA lIncPar   	 	AS LOGIC
	DATA lIncEnc   	 	AS LOGIC
	DATA lMonFax   	 	AS LOGIC
	DATA lNegPar  	 		AS LOGIC
	DATA lIncAno 	 		AS LOGIC
	DATA lDemanda  	 	AS LOGIC
	DATA lInconsistente 	AS LOGIC
	DATA lIncoRes			AS LOGIC
	DATA lNotInRes			AS LOGIC
	DATA lParticipativa	AS LOGIC
	DATA lAgendada			AS LOGIC
	DATA lIntSau   	 	AS LOGIC
	DATA lVisAud   	 	AS LOGIC
	DATA lEmAnalise	 	AS LOGIC
	DATA lEspera  	 		AS LOGIC
	DATA lAnalisada  		AS LOGIC
	DATA lAutorizada 		AS LOGIC
	DATA lOwner		 	AS LOGIC
	DATA lThisDep       	AS LOGIC
	DATA lVisible	 		AS LOGIC
	DATA lHaveOwner	 	AS LOGIC
	DATA lHaveGuia			AS LOGIC
	DATA lConsulta			AS LOGIC
	DATA lSadt				AS LOGIC
	DATA lInternacao		AS LOGIC
	DATA lEvolucao			AS LOGIC
	DATA lOdonto			AS LOGIC
	DATA lReembolso		AS LOGIC
	DATA lOPME				AS LOGIC
	DATA lRotinaGen		AS LOGIC
	DATA lProrrog			AS LOGIC
	DATA lCriDia 			AS LOGIC

	METHOD New() Constructor
	METHOD GetRotiAtu(aDad,cPerfil)
	METHOD GetFiles(cDirPerf,aFiles)
	METHOD GetDocBC(nAt,aFiles,cAlias,cUnico)
	METHOD SetPerfil(cPerfil)
	METHOD SetPrioridade(cPrio)
	METHOD SetSituac(cSituac)
	METHOD SetNegPar(lNegPar)
	METHOD SetOnlyVisible(lVisible)
	METHOD SetAuditoria(lAuditoria,lIntern,lEvolu,lReembolso,lPartic,aDadCri,aCabCri,cCodCri,cRegInt,cAliasCri,aColsITE,aHeaderITE,cAliasIte)
	METHOD SetDemanda()
	METHOD EMail()
	METHOD BancoCon(cAlias,nOpc,lLog,cTipo)
	METHOD VldAplication()
	METHOD NegComp()
	METHOD VldFLD(nFolder,oTFolder,cAlias)
	METHOD VldAcessoGui(lEmAnlise,lIncons,lAutori, lAudit, cAlias)
	METHOD MarkAll(oMark,lMarcar)
	METHOD DelDocBC(nAt,aFiles)
	METHOD SetAtuPClass()
	METHOD SetFieldGui( oSelf )
	METHOD ProcPart()

	METHOD Destroy()

EndClass
//-------------------------------------------------------------------
/*/{Protheus.doc} New
Construtor da Class

@param cOperad Operadora do sistema registro da BX4

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD New() CLASS CABA790C
	::cOperad := RETCODUSR()
	DEFAULT ::cPerfil	:= PLS_ADMINITRADOR
	DEFAULT ::cCodDep	:= ""
	DEFAULT ::lVisible	:= .F.
	DEFAULT ::lVldRot	:= .T.
	DEFAULT ::lNegPar	:= .F.
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁVerifica se e possivel utilizar esta rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !PLSALIASEXI("B53")
		::lVldRot := .F.
		_Super:ExbMHelp( "NЦo И possМvel utilizar esta rotina!" ) //"NЦo И possМvel utilizar esta rotina!"
		Return Self
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza informacoes da classe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	::SetAtuPClass()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se for interna-saude
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If ::lIntSau
		::SetOnlyVisible(.T.)
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return Self
//-------------------------------------------------------------------
/*/{Protheus.doc} BancoCon
Banco de conhecimento

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
METHOD BancoCon(cAlias,lChkDeman,nOpc,lLog,cTipo) Class CABA790C
	LOCAL aArea      := GetArea()
	LOCAL nHoraBase  := Seconds()
	LOCAL cCodUsuDef := "XXXXXX"
	LOCAL lRet		 := .T.
	LOCAL oPADC 	 := NIL
	LOCAL cChaveIn  	:= B53->B53_NUMGUI
	LOCAL cChaveAC9 := If(B53->B53_TIPO == "6", xfilial('B4A')+cChaveIn, xfilial('BE4')+cChaveIn)

	PRIVATE aRotina  := {}
	DEFAULT nOpc 	 := 1
	DEFAULT lLog	 := .T.
	DEFAULT lChkDeman:= .F.

	aRotina := {{"Conhecimento",'MsDocument',0,3},{"InclusЦo RАpida",'PLSDOcs',0,3}} //"Conhecimento"

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza informacoes da classe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	::SetAtuPClass()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se nao for interna-saude e a guia И de demanda
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If lChkDeman .And. !::lIntSau
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Verifica se foi selecionada a opcao de b. conhecimento da demanda.
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oPADC := PLSPADRC():New(cAlias)
	
		If oPADC:lMDDemanda .And. ::lDemanda
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Verifica se o registro de demanda (processo) pode ser editado se nao for 
		//Ё o owner especifico do registro lOwnerEsp
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !oPADC:lOwnerEsp .And. !oPADC:lEditaProcesso
				_Super:ExbMHelp( "Acesso negado ao processo") //"Acesso negado ao processo"
				Return
			EndIf
		EndIf
	
		oPADC:Destroy()
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se o acesso foi permitido exibi banco de conhecimento
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If B53->B53_TIPO != "6"

		BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
		BEA->( MsSeek( xFilial("BEA") + cChaveIn ) )
	
		if cTipo == "I"
	
			DbSelectArea("BE2")
			cIndex := CriaTrab(NIL,.F.)
			cQuery := "BE2_FILIAL == '" + xFilial("BE2") + "' "
			cQuery += " .And. BE2_OPEMOV == '" + BEA->BEA_OPEMOV + "'"
			cQuery += " .And. BE2_ANOAUT == '" + BEA->BEA_ANOAUT + "'"
			cQuery += " .And. BE2_MESAUT == '" + BEA->BEA_MESAUT + "'"
			cQuery += " .And. BE2_NUMAUT == '" + BEA->BEA_NUMAUT + "'"
		
			IndRegua("BE2",cIndex,BE2->(IndexKey()),,cQuery)
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Ativa o banco de conhecimento
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		
			If BE2->(!Eof())
				lRet := MaWndBrowse(0,0,300,600,"UsuАrio","BE2",,aRotina,,,,.T.,,,,,,.F.) //"Retorno de Doctos. de Saida"
			EndIf
		
		else
	
			DbSelectArea("BEA")
			cIndex := CriaTrab(NIL,.F.)
			MsDocument( "BEA", BEA->( RecNo() ), 2 )
	
		endif

	Else

		B4A->( DbSetOrder(1) ) //B4A_FILIAL + B4A_OPEMOV + B4A_ANOAUT + B4A_MESAUT + B4A_NUMAUT + DTOS(B4A_DATPRO) + B4A_HORPRO
		B4A->( MsSeek( xFilial("B4A") + cChaveIn ) )
	
		if cTipo == "I"

			DbSelectArea("B4C")
			cIndex := CriaTrab(NIL,.F.)
			cQuery := "B4C_FILIAL == '" + xFilial("B4C") + "' "
			cQuery += " .And. B4C_OPEMOV == '" + B4A->B4A_OPEMOV + "'"
			cQuery += " .And. B4C_ANOAUT == '" + B4A->B4A_ANOAUT + "'"
			cQuery += " .And. B4C_MESAUT == '" + B4A->B4A_MESAUT + "'"
			cQuery += " .And. B4C_NUMAUT == '" + B4A->B4A_NUMAUT + "'"
		
			IndRegua("B4C",cIndex,B4C->(IndexKey()),,cQuery)
		
			If B4C->(!Eof())
				MaWndBrowse(0,0,300,600,"Retorno de Doctos. de Saida","B4C",,aRotina,,,,.T.,,,,,,.F.) //"Retorno de Doctos. de Saida"
			EndIf
		
		else
	
			DbSelectArea("B4A")
			cIndex := CriaTrab(NIL,.F.)
			MsDocument( "B4A", B4A->( RecNo() ), 2 )
	
		endif
		
	EndIf

	AC9->(DbSetOrder(2))//AC9_FILIAL, AC9_ENTIDA, AC9_FILENT, AC9_CODENT, AC9_CODOBJ, R_E_C_N_O_, D_E_L_E_T_

	If AC9->(dbSeek( xFilial("AC9") + cAlias +xfilial(cAlias)+cChaveAC9))
		dbSelectArea("B53")
		If B53->(dbSeek(xFilial("B53")+cChaveIn))
			If B53->B53_BANCON != '1'
				B53->(Reclock("B53",.F.))
				B53->B53_BANCON := '1'
				B53->(MsUnlock())
			EndIf
		EndIf
	else
		dbSelectArea("B53")
		If B53->(dbSeek(xFilial("B53")+cChaveIn))
			If B53->B53_BANCON != '0'
				B53->(Reclock("B53",.F.))
				B53->B53_BANCON := '0'
				B53->(MsUnlock())
			EndIf
		EndIf
	EndIf

	RetIndex( cAlias )
	dbClearFilter()
	FErase( cIndex+OrdBagExt() )

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se cancelou 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !lRet
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Deleta registro da acb de lixo
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		DelAcbAc9()
	Else
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Inclusao ou exclusao de banco de conhecimento na guia
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If cAlias == 'BE2'
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Autaliza guia
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			B53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )
			B53:SetValue("B53_BANCON",'1' )
			B53:CRUD()
			B53:Destroy()
		EndIf
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Registro de log da rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If lLog
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava registro de alteracao da aplicacao ou tabela
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oBX3 := PLSSTRUC():New("BX3")
		oBX3:SetlAltera(.T.)
		oBX3:SetValue("BX3_FILIAL", xFilial("BX3") )
		oBX3:SetValue("BX3_ALIAS", cAlias )
		oBX3:SetValue("BX3_DATA", Date() )
		oBX3:SetValue("BX3_HORA", Time() )
		oBX3:SetValue("BX3_ESTTRB", GetComputerName() )
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Se incluiu alguma coisa no banco de conhecimento
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet
			oBX3:SetValue("BX3_OPERAD", cCodUsuDef )
			oBX3:SetValue("BX3_TIPO", '1' )
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Grava dados na base de dados
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !oBX3:CRUD()
				oBX3:ExbMHelp( oBX3:GetErrorMessage(.T.) )
			EndIf
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Atualiza registro de acesso do usuario corrente
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oBX3:SetValue("BX3_OPERAD", ::cOperad )
		oBX3:SetValue("BX3_TIPO", '0' )
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava dados na base de dados
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !oBX3:CRUD()
			oBX3:ExbMHelp( oBX3:GetErrorMessage(.T.) )
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Destroy o modelo
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oBX3:Destroy()
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Rest nas linhas do browse e na area
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	RestArea( aArea )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё DuraГЦo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	_Super:SetLog(nHoraBase)
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(lRet)
/*/{Protheus.doc} GetRotiAtu
Retorna se uma rotina foi ou nao atualizada

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
METHOD GetRotiAtu(aDad,cPerfil) Class CABA790C
	LOCAL aRet		 := {}
	LOCAL nI		 := 1
	LOCAL oGEN		 := NIL
	LOCAL cTipoRe	 := '1'
	LOCAL cTipoAc	 := '0'
	LOCAL cCodUsuDef := "XXXXXX"
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Dados do Operador
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	For nI:=1 To Len(aDad)
		If nI > Len(aDad)
			Exit
		EndIf
	
		If ("XXX" == aDad[nI,1] .And. !::lMonFax) .Or. ("B69" == aDad[nI,1] .And. !::lIncAno) .Or.;
				("B68" == aDad[nI,1] .And. !::lIncDem) .Or. ("B72" == aDad[nI,1] .And. !::lIntSau) .Or.;
				("B70" == aDad[nI,1] .And. !::lIncPar) .Or. ("B71" == aDad[nI,1] .And. !::lIncEnc)
			aDel(aDad,nI)
			aSize(aDad,Len(aDad)-1)
			nI--
		EndIf
	Next
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Selecion todos os acesso deste usuario 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oGEN := CABREGIC():New()
	oGEN:GetDadBx3(aDad,::cOperad,cTipoAc,cCodUsuDef,cTipoRe)
	oGEN:Destroy()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Retorna Matriz Ajustada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	aRet := _Super:GetVal(aDad,,.T.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da funcao
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(aRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } VldFLD
Validacao ao entrar no folder

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VldFLD(nFolder,oTFolder,cAlias) Class CABA790C
	LOCAL lRet := .T.
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Instancia o modelo de dados												 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oBX3 := PLSSTRUC():New("BX3")
	oBX3:SetValue("BX3_FILIAL", xFilial("BX3") )
	oBX3:SetValue("BX3_OPERAD", ::cOperad )
	oBX3:SetValue("BX3_ALIAS", cAlias )
	oBX3:SetValue("BX3_DATA", Date() )
	oBX3:SetValue("BX3_HORA", Time() )
	oBX3:SetValue("BX3_TIPO", '0' )
	oBX3:SetValue("BX3_ESTTRB", GetComputerName() )
	oBX3:SetlAltera(.T.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Grava dados na base de dados											 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !oBX3:CRUD()
		oBX3:ExbMHelp( oBX3:GetErrorMessage(.T.) )
	EndIf
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Destroy o modelo														 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oBX3:Destroy()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza a descricao do folder
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oTFolder:ADIALOGS[nFolder]:cTitle := AllTrim(StrTran(oTFolder:ADIALOGS[nFolder]:cTitle,'*',''))
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } MarkAll
Marca e desmarca linhas do browse

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MarkAll(oMark,lMarcar) Class CABA790C
	LOCAL aArea   := GetArea()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Restaura area
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	RestArea( aArea )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return NIL
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetPerfil
Seta o perfil desejado

@author Alexander Santos
@since 09/03/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetPerfil(cPerfil) Class CABA790C
	::cPerfil := cPerfil
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetPrioridade
Seta prioridade da guia

@author Alexander Santos
@since 09/03/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetPrioridade(cPrio) Class CABA790C
	LOCAL B53 := NIL
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Seta nova prioridade
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !Empty(X3COMBO("B53_PRIORI",cPrio))
		B53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )
		B53:SetValue("B53_PRIORI", cPrio)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava dados na base de dados											 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !B53:CRUD()
			B53:ExbMHelp( B53:GetErrorMessage(.T.) )
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Destroy
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		B53:Destroy()
	Else
		_Super:ExbMHelp( "OpГЦo BOX do campo invalida") //"OpГЦo BOX do campo invalida"
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetNegPar
Seta a opcao negar participacao

@author Alexander Santos
@since 09/03/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetNegPar(lNegPar) Class CABA790C
	::lNegPar := lNegPar
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetSituac
Seta situac da guia

@author Alexander Santos
@since 09/03/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetSituac(cSituac) Class CABA790C
	LOCAL oB53		:= NIL
	LOCAL oGEN 	:= NIL
	LOCAL aChave := {}
	LOCAL aChaveB4A	:= {}
	LOCAL aChaveBE2	:= {}
	LOCAL aChaveBEJ	:= {}
	LOCAL aChaveBQV 	:= {}
	LOCAL aChaveB45 	:= {}
	LOCAL nPosit := 0
	LOCAL nNegat := 0
	LOCAL cOperad := If (GetNewPar("MV_PLFLUIG", .F.) == .T.,GetNewPar("MV_OPERFLG","0000"),::cOperad)
	LOCAL cTipo
	LOCAL aDadUsr := PLSDADUSR(B53->B53_MATUSU,'1',.F.,dDatabase,,,"NAO_VALIDAR_CARTAO")
	Local lForLib := .F.
	LOCAL lFamYes	:= 	.F.
 
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza informacoes da classe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	::SetAtuPClass()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se tem guia selecionada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !::lHaveGuia

		_Super:ExbMHelp( "NЦo existe guia para analise") //"NЦo existe guia para analise"
		Return
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se a guia tem o mesmo perfil do auditor
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If ::cPerfil <> PLS_ADMINITRADOR .And. !(::cPerfil $ ::cAllPerfil)
		_Super:ExbMHelp( "O seu perfil nЦo esta autorizado a analisar esta guia!") //"O seu perfil nЦo esta autorizado a analisar esta guia!"
		Return
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se a guia estiver cancelada nЦo podera auditar.
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If B53->B53_STATUS = "6"
		_Super:ExbMHelp("Esta guia foi cancelada.")//"Esta guia foi cancelada."
		Return
	EndIf

	If B53->b53_TIPO = "2"
		BEA->(dbSetOrder(12))
	
		If BEA->(dbSeek(xFilial("BEA")+B53->(B53_CODOPE+B53_CODLDP+B53_CODPEG+B53_NUMERO+B53_ORIMOV)))
			If BEA->BEA_CANCEL == "1"
				_Super:ExbMHelp("Esta guia foi cancelada.")//"Esta guia foi cancelada."
				Return
			EndIf
		EndIf
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o beneficiАrio foi desligado ou familia bloqueada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	BA3->(dbSetOrder(1))
	If BA3->(dbSeek(xFilial("BA3") + SUBSTR(B53->B53_MATUSU,1,14)+aDadUsr[9]+aDadUsr[12]+aDadUsr[41]+aDadUsr[42])) .And. B53->B53_PROINT <> '1'
	
		If !EMPTY(BA3->BA3_DATBLO) .AND. BA3->BA3_DATBLO <= dDataBase
			BDS->(dbSetOrder(1))
			If BDS->(dbSeek(xFilial("BDS") + B53->B53_NUMGUI)) .And. B53->B53_SITUAC == '0' .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO)) .And. B53->B53_TIPO <>"6"
				nOk:= 	Aviso("UsuАrio Bloqueado"  ,;//"UsuАrio Bloqueado"
				"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:"
				"ObservaГЦo: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"ObservaГЦo: "
				"Operador: " + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","NЦo"},3) //"Sim" "NЦo"
				If nOk == 2
					Return
				Else
					lFamYes := .T.
				EndIf

			ElseIf B53->B53_TIPO =="6" .And. !Empty(B4A->B4A_GUIREF) .And. BDS->(dbSeek(xFilial("BDS") + B4A->B4A_GUIREF)) .And. B53->B53_SITUAC == '0' .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO))
				nOk:= 	Aviso("UsuАrio Bloqueado"  ,;//"UsuАrio Bloqueado"
				"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:"
				"ObservaГЦo: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"ObservaГЦo: "
				"Operador: " + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","NЦo"},3) //"Sim" "NЦo"
				If nOk == 2
					Return
				Else
					lFamYes := .T.
				EndIf

			ElseIf B53->B53_SITUAC == '0'
				_Super:ExbMHelp("FamМlia bloqueada, nЦo serА possМvel auditar a guia.")//"FamМlia bloqueada, nЦo serА possМvel auditar a guia."
				Return
			EndIf
		ElseIf !EMPTY(BA3->BA3_DESLIG) .AND. BA3->BA3_LIMITE < dDataBase
			
			_Super:ExbMHelp("BeneficiАrio desligado, nЦo serА possМvel auditar a guia.")//"BeneficiАrio desligado, nЦo serА possМvel auditar a guia."
			Return
		EndIf
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o beneficiАrio esta bloqueado
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	BA1->(dbSetOrder(2))
	If BA1->(dbSeek(xFilial("BA1") + B53->B53_MATUSU)) .And. B53->B53_PROINT <> '1'
	
		If !EMPTY(BA1->BA1_DATBLO) .AND. BA1->BA1_DATBLO <= dDataBase .And. !lFamYes
	
			BDS->(dbSetOrder(1))
			If BDS->(dbSeek(xFilial("BDS") + B53->B53_NUMGUI)) .And. B53->B53_SITUAC == '0' .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO)) .And. B53->B53_TIPO <>"6"
				nOk:= 	Aviso("UsuАrio Bloqueado"  ,;//"UsuАrio Bloqueado"
				"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:"
				"ObservaГЦo: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"ObservaГЦo: "
				"Operador: " + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","NЦo"},3)//"Sim" "NЦo"
				If nOk == 2
					Return
				EndIf
			ElseIf B53->B53_TIPO =="6" .And. !Empty(B4A->B4A_GUIREF) .And. BDS->(dbSeek(xFilial("BDS") + B4A->B4A_GUIREF)) .And. B53->B53_SITUAC == '0' .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO)) .And. B53->B53_TIPO <>"6"
				nOk:= 	Aviso("UsuАrio Bloqueado"  ,;//"UsuАrio Bloqueado"
				"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiАrio no perМodo do atendimento, porИm a crМtica de bloqueio foi forГada com a seguinte justificativa:"
				"ObservaГЦo: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"ObservaГЦo: "
				"Operador: "  + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","NЦo"},3)//"Sim" "NЦo"
				If nOk == 2
					Return
				EndIf

			ElseIf B53->B53_SITUAC == '0'
				_Super:ExbMHelp("UsuАrio bloqueado, nЦo serА possМvel auditar a guia.")//"UsuАrio bloqueado, nЦo serА possМvel auditar a guia."
				Return
			EndIf
		
		EndIf
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se a RDA esta bloqueada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	BAU->(dbSetOrder(1))
	If BAU->(dbSeek(xFilial("BAU") + B53->B53_CODRDA))
	
	//se a data do bloqueio for menor que a data atual, exibe a mensagem.
		If !EMPTY(BAU->BAU_CODBLO) .AND. BAU->BAU_DATBLO < dDataBase
			
			_Super:ExbMHelp("RDA bloqueada, nЦo serА possМvel auditar a guia.")//"RDA bloqueada, nЦo serА possМvel auditar a guia."
			Return
	
	//Se a data do bloqueio for igual a data atual, verifica ba BC4 se a RDA esta bloqueada de acordo com a hora incluida.
		ElseIf BAU->BAU_DATBLO == dDataBase
		
			BC4->(dbSetOrder(1))
		
			If BC4->(dbSeek(xFilial("BC4") + B53->B53_CODRDA + DTOS(dDataBase)))
			
			//verifica os registros de bloqueio e desbloqueio.
				While !BC4->(EOF()) .AND. BC4->(BC4_FILIAL + BC4_CODCRE + DTOS(BC4_DATA)) == xFilial("BC4") + B53->B53_CODRDA + DTOS(dDataBase)
				
				//verificar se o ultimo registro И de bloqueio e se o horАrio do bloqueio ja foi ultrapassado.
					If BC4->BC4_TIPO == "0" .AND. BC4->BC4_HORA <= SUBSTR(STRTRAN(TIME(), ":", ""),1,4)
						cTipo := BC4->BC4_TIPO
					Else
						cTipo := "1"
					EndIf
				
					BC4->(dbSkip())
				EndDo
			
			// exibe a mensagem de bloquieo da RDA.
				If cTipo == "0"
					_Super:ExbMHelp("RDA bloqueada, nЦo serА possМvel auditar a guia.")//"RDA bloqueada, nЦo serА possМvel auditar a guia."
					Return
				EndIf
			EndIf
		EndIf
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Tratamento do Situac
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Do Case
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё A guia vai ficar em espera
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Case cSituac == "3"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Verifica se tem acesso a guia
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !::VldAcessoGui()
			Return
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Retira guia do monitor
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Case cSituac == "1"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Verifica se tem acesso a guia
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !::VldAcessoGui()
			Return
		EndIf
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Guia autorizada e procedimento da auditoria participativa
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !::lParticipativa .And. ::lAutorizada
			_Super:ExbMHelp( "Somente guia Autorizada e Participativa") //"Somente guia Autorizada e Participativa"
			Return
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Liberar ou Pegar guia
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Case cSituac == "2"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Ja foi analisada e tem inconsistencia
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If ::lInconsistente
			_Super:ExbMHelp( "Esta guia jА foi analisada, utilize a opГЦo InconsistЙncia" ) //"Esta guia jА foi analisada, utilize a opГЦo InconsistЙncia"
			Return
		EndIf
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se esta reservada para outro operador
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If ::lHaveOwner .And. !::lOwner
			//Verifica se o usuАrio tem autorizaГЦo para liberar guias bloqueadas por outros usuАrios e se nЦo apresentou a mensagem 
			IF ::lLibGuia .and. !cPlMsgAud == B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
				lForLib := MsgYesNo("A guia esta bloqueada para:" + UPPER(USRRETNAME(B53->B53_OPERAD)) + "Deseja mesmo liberar esta Guia?", "Tem autorizaГЦo?") //A guia esta bloqueada para:/"Deseja mesmo liberar esta Guia?"
				cPlMsgAud := B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
			//Verifica se o usuАrio tem autorizaГЦo para liberar guias bloqueadas por outros usuАrios e se jА exibiu a mensagem 
			ElseIf ::lLibGuia .and. cPlMsgAud == B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
				lForLib := .T.
			EndIf
			IF (!lForLib)
				_Super:ExbMHelp( "Guia reservada para outro Operador" ) //"Guia reservada para outro Operador"
				Return
			EndIf
		EndIf
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se e do mesmo departamento
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !::lHaveOwner .And. !::lThisDep
			_Super:ExbMHelp( "Somente o operador deste departamento tem acesso" ) //"Somente o operador deste departamento tem acesso"
			Return
		EndIf
	
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Verifica status atual da guia
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

		If ::cACri == "BEG"
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Se a guia foi analisada por completo, nЦo serА possМvel reservar a guia
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

			If B53->b53_SITUAC == "1"
				_Super:ExbMHelp("")
				Return
			EndIf
	
			If B53->B53_ALIMOV == "B4A"
		
				B4A->(dbSetOrder(1))
				If B4A->(dbSeek(xFilial("BA4")+B53->B53_NUMGUI))
	
					While !B4A->(EOF()) .AND. xFilial("B4A")+B4A->(B4A_OPEMOV+B4A_ANOAUT+B4A_MESAUT+B4A_NUMAUT) ==;
							xFilial("B4A")+B53->B53_NUMGUI
	
						If B4A->B4A_STATUS == '1'
							nPosit++
						Else
							nNegat++
						EndIf
						B4A->(dbSkip())
					EndDo
				EndIf
			Else
	
				BE2->(dbSetOrder(1))
				If BE2->(dbSeek(xFilial("BE2")+B53->B53_NUMGUI))
	
					While !BE2->(EOF()) .AND. xFilial("BE2")+BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) ==;
							xFilial("BE2")+B53->B53_NUMGUI
	
						If BE2->BE2_STATUS == '1'
							nPosit++
						Else
							nNegat++
						EndIf
						BE2->(dbSkip())
					EndDo
				EndIf
			EndIf
	
			oB53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )

			if nPosit == 0 .AND. nNegat > 0
				oB53:SetValue("B53_STATUS", "3")
			ElseIf nPosit > 0 .AND. nNegat > 0
				oB53:SetValue("B53_STATUS", "2")
			ElseIf nPosit > 0 .AND. nNegat == 0
				oB53:SetValue("B53_STATUS", "1")
			EndIf

			If !oB53:CRUD()
				oB53:ExbMHelp( oB53:GetErrorMessage(.T.) )
			EndIf
		Else

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Se a guia foi analisada por completo, nЦo serА possМvel reservar a guia
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

			If B53->B53_SITUAC == "1"
				_Super:ExbMHelp("")
				Return
			EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё se aguia nao foi analisada por completo a guia podera ser reservada
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			BEJ->(dbSetOrder(1))
			If BEJ->(dbSeek(xFilial("BEJ")+B53->B53_NUMGUI))

				While !BEJ->(EOF()) .AND. xFilial("BEJ")+BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) ==;
						xFilial("BEJ")+B53->B53_NUMGUI

					If BEJ->BEJ_STATUS == '1'
						nPosit++
					Else
						nNegat++
					EndIf
					BEJ->(dbSkip())
				EndDo

				BQV->(dbSetOrder(1))
				If BQV->(dbSeek(xFilial("BQV")+B53->B53_NUMGUI))

					While !BQV->(EOF()) .AND. xFilial("BQV")+BQV->(BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT) ==;
							xFilial("BQV")+B53->B53_NUMGUI

						If BQV->BQV_STATUS == '1'
							nPosit++
						Else
							nNegat++
						EndIf
						BQV->(dbSkip())
					EndDo
				EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Cria o objeto para a atualizacao
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				oB53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )

				if nPosit == 0 .AND. nNegat > 0
					oB53:SetValue("B53_STATUS", "3")
				ElseIf nPosit > 0 .AND. nNegat > 0
					oB53:SetValue("B53_STATUS", "2")
				ElseIf nPosit > 0 .AND. nNegat == 0
					oB53:SetValue("B53_STATUS", "1")
				EndIf

				If !oB53:CRUD()
					oB53:ExbMHelp( oB53:GetErrorMessage(.T.) )
				EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Destroy
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				oB53:Destroy()
			EndIf

		EndIf
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Chave
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		aChave := {}
		AaDd(aChave, { ::SetFieldGui(::cACri+"_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) } )
		AaDd(aChave, { ::SetFieldGui(::cACri+"_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) } )
		AaDd(aChave, { ::SetFieldGui(::cACri+"_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2)} )
		AaDd(aChave, { ::SetFieldGui(::cACri+"_NUMAUT"), '=', Right(B53->B53_NUMGUI,8)} )
		If (::cACri)->( FieldPos(::cACri+"_PENDEN") ) > 0
			AaDd(aChave, { ::cACri+"_PENDEN", '<>', '0'} )
		Endif
		If (::cACri)->( FieldPos(::cACri+"_CODGLO") ) > 0
			AaDd(aChave, { ::cACri+"_CODGLO", '<>', ''} )
		Endif
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё verifica se a guia foi totalmente analisada 
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		
		If B53->b53_SITUAC == "2"
				
			If ::cACri == "BEG"
				
				If B53->B53_ALIMOV == "B4A"
					B4A->(dbSetOrder(1))
					B4A->(dbGoTop())
			
					IF B4A->(dbSeek( xFilial("B4A")+B53->B53_NUMGUI))
					
						aChaveB4A := {}
						AaDd(aChaveB4A, { "B4A_OPEMOV", '=', Left(B53->B53_NUMGUI,4) 		} )
						AaDd(aChaveB4A, { "B4A_ANOAUT", '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
						AaDd(aChaveB4A, { "B4A_MESAUT", '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
						AaDd(aChaveB4A, { "B4A_NUMAUT", '=', Right(B53->B53_NUMGUI,8) 		} )
												
						oGEN := CABREGIC():New()
						
						If oGEN:GetCountReg("B4A",aChaveB4A ) == 0
							cSituac := "1"
						Else
							cSituac := "0"
						EndIf
							
						oGEN:Destroy()
					EndIf
				Else
				
					BE2->(dbSetOrder(1))
					BE2->(dbGoTop())
			
					IF BE2->(dbSeek( xFilial("BE2")+B53->B53_NUMGUI))
					
						aChaveBE2 := {}
						AaDd(aChaveBE2, { "BE2_OPEMOV", '=', Left(B53->B53_NUMGUI,4) 		} )
						AaDd(aChaveBE2, { "BE2_ANOAUT", '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
						AaDd(aChaveBE2, { "BE2_MESAUT", '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
						AaDd(aChaveBE2, { "BE2_NUMAUT", '=', Right(B53->B53_NUMGUI,8) 		} )
												
						oGEN := CABREGIC():New()
						
						If oGEN:GetCountReg("BE2",aChaveBE2 ) == 0
							cSituac := "1"
						Else
							cSituac := "0"
						EndIf
							
						oGEN:Destroy()
					EndIf
				EndIf
			Else
				BEJ->(dbSetOrder(1))
				BEJ->(dbGoTop())
		
				IF BEJ->(dbSeek( xFilial("BEJ")+B53->B53_NUMGUI))
				
					aChaveBEJ := {}
					AaDd(aChaveBEJ, { "BEJ_CODOPE", '=', Left(B53->B53_NUMGUI,4) 		} )
					AaDd(aChaveBEJ, { "BEJ_ANOINT", '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
					AaDd(aChaveBEJ, { "BEJ_MESINT", '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
					AaDd(aChaveBEJ, { "BEJ_NUMINT", '=', Right(B53->B53_NUMGUI,8) 		} )
											
					oGEN := CABREGIC():New()
					
					If oGEN:GetCountReg("BEJ",aChaveBEJ ) == 0
						cSituac := "1"
					Else
						cSituac := "0"
					EndIf
						
					oGEN:Destroy()
						
				EndIf
				
				IF BQV->(dbSeek( xFilial("BQV")+B53->B53_NUMGUI))
					
					aChaveBQV := {}
					AaDd(aChaveBQV, { "BQV_CODOPE", '=', Left(B53->B53_NUMGUI,4) 		} )
					AaDd(aChaveBQV, { "BQV_ANOINT", '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
					AaDd(aChaveBQV, { "BQV_MESINT", '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
					AaDd(aChaveBQV, { "BQV_NUMINT", '=', Right(B53->B53_NUMGUI,8) 		} )
					AaDd(aChaveBQV, { "BQV_AUDITO", '=', "1" 		} )
						
					oGEN := CABREGIC():New()
					
					If oGEN:GetCountReg("BQV",aChaveBQV ) == 0
						cSituac := "1"
					Else
						cSituac := "0"
					EndIf
						
					oGEN:Destroy()
				
				EndIf
				 
				IF B45->(dbSeek( xFilial("B45")+B53->B53_NUMGUI))
					
					aChaveB45 := {}
					AaDd(aChaveB45, { "B45_OPEMOV", '=', Left(B53->B53_NUMGUI,4) 		} )
					AaDd(aChaveB45, { "B45_ANOAUT", '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
					AaDd(aChaveB45, { "B45_MESAUT", '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
					AaDd(aChaveB45, { "B45_NUMAUT", '=', Right(B53->B53_NUMGUI,8) 		} )
											
					oGEN := CABREGIC():New()
					
					If oGEN:GetCountReg("B45",aChaveB45 ) == 0
						cSituac := "1"
					Else
						cSituac := "0"
					EndIf
						
					oGEN:Destroy()
					
						
				EndIf
			EndIf
		EndIf
	OtherWise
	EndCase
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se e situac valido
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !Empty(X3COMBO("B53_SITUAC",cSituac)) //0=NЦo;1=Sim;2=Em Analise;3=Em Espera;4=InconsistЙncia
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Seta nova prioridade
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )
		oB53:SetValue("B53_SITUAC", cSituac)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Atualiza informacoes da guia data e hora
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		Do Case
		Case cSituac == '1'
			oB53:SetValue("B53_DATFIM", dDataBase )
			oB53:SetValue("B53_HORFIM", Left(Time(),5) )
			
		Case cSituac == '2' .AND. EMPTY(B53->B53_DATINI)
			oB53:SetValue("B53_DATINI", dDataBase )
			oB53:SetValue("B53_HORINI", Left(Time(),5) )
		EndCase
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Atribui operador da guia
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !::lHaveOwner .OR. cSituac == '3' .OR. cSituac == '2'
			oB53:SetValue("B53_OPERAD",cOperad)
		Else
			oB53:SetValue("B53_OPERAD",'')
		EndIf
	 
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava dados na base de dados
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If !oB53:CRUD()
			oB53:ExbMHelp( oB53:GetErrorMessage(.T.) )
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Destroy
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:Destroy()
	Else
		_Super:ExbMHelp( "OpГЦo BOX do campo invalida") //"OpГЦo BOX do campo invalida"
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } GetFiles
Retorna todos os arquivo de uma pasta e subpastas

@author Alexander Santos
@since 09/03/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD GetFiles(cDirPerf,aFiles) Class CABA790C
	LOCAL nI		:= 1
	LOCAL aFilDir	:= {}
	DEFAULT aFiles 	:= {}
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Retira espacos desnecessario
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	cDirPerf := PLSMUDSIS( MsDocRmvBar(AllTrim(cDirPerf)) )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Arquivos e diretorio da pasta informada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	aFilDir := Directory( cDirPerf + PLSMUDSIS("\*.*"), "D")
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se tem somente arquivo ou subpastas
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	For nI:=1 To Len(aFilDir)
	
		If Left(aFilDir[nI,1],1) <> '.'
			If aFilDir[nI,5] == 'D'
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			//Ё Processando a subpasta
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				::GetFiles(cDirPerf + "\" + aFilDir[nI,1] + "\",aFiles)
			
			ElseIf At('excluido_',Lower(aFilDir[nI,1])) == 0
	    
				AaDd(aFiles, { aFilDir[nI,1] , PLSMUDSIS( cDirPerf + "\" ) } )
	    	
			EndIf
		EndIf
	
	Next
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Para ter um linha 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If Len(aFiles)==0
		aFiles := { { "" , "" } }
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(aFiles)
//-------------------------------------------------------------------
/*/ { Protheus.doc } GetDocBC
Alimenta e mostra registro selecionado no banco de conhecimento

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD GetDocBC(nAt,aFiles,cAlias,cUnico) Class CABA790C
	LOCAL aArea 	:= GetArea()
	LOCAL lRet		:= .T.
	LOCAL nH		:= 0
	LOCAL cDescri	:= ""
	LOCAL cChvUni	:= ""
	LOCAL cCodUsuDef:= "XXXXXX"
	LOCAL cFile		:= SubStr(aFiles[nAt,1],1,At('.',aFiles[nAt,1])-1 )
	LOCAL cDirFile 	:= aFiles[nAt,2]+aFiles[nAt,1]
	PRIVATE aRotina := {}

	If EMPTY(cFile)
		_Super:ExbMHelp("NЦo existe arquivos no monitor de documentos.")//"NЦo existe arquivos no monitor de documentos."
		Return
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Abre controle de semafoto
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If ( nH := PLSAbreSem("GetDocBC" + cFile + ".SMF",.F.) ) > 0
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//ЁColoca banco de conhecimento na memoria 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		RegToMemory("ACB",.T.)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//ЁRetorna o nome do arquivo
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		SplitPath( cDirFile,,,@cDescri)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//ЁPreenchimento do wizard
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		lRet := MsDocWzGrv( cDirFile, cDescri, {}, {} )
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//ЁMonta Chave Unica
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet
			If !Empty(cUnico)
				cChvUni := (cAlias)->&(cUnico)
				If Empty(cChvUni)
					_Super:ExbMHelp( "Chave informada para registro do banco de conhecimento invalida" ) //"Chave informada para registro do banco de conhecimento invalida"
					lRet := .F.
				EndIf
			Else
				_Super:ExbMHelp( "Informe chave unica para registro do banco de conhecimento" ) //"Informe chave unica para registro do banco de conhecimento"
				lRet := .F.
			EndIf
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//ЁSe tudo ok monta registro do banco de conhecimento
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

		If lRet
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Grava registro de alteracao da aplicacao ou tabela
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			oBX3 := PLSSTRUC():New("BX3")
			oBX3:SetlAltera(.T.)
			oBX3:SetValue("BX3_FILIAL", xFilial("BX3") )
			oBX3:SetValue("BX3_OPERAD", cCodUsuDef )
			oBX3:SetValue("BX3_ALIAS", cAlias )
			oBX3:SetValue("BX3_DATA", Date() )
			oBX3:SetValue("BX3_HORA", Time() )
			oBX3:SetValue("BX3_TIPO", '1' )
			oBX3:SetValue("BX3_ESTTRB", GetComputerName() )
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Grava dados na base de dados
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !oBX3:CRUD()
				oBX3:ExbMHelp( oBX3:GetErrorMessage(.T.) )
			EndIf
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Atualiza registro de acesso do usuario corrente
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			oBX3:SetValue("BX3_OPERAD", ::cOperad )
			oBX3:SetValue("BX3_TIPO", '0' )
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Grava dados na base de dados
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !oBX3:CRUD()
				oBX3:ExbMHelp( oBX3:GetErrorMessage(.T.) )
			EndIf
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Destroy o modelo
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			oBX3:Destroy()
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Gravacao do registro caso nao existe
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			oAC9 := PLSSTRUC():New("AC9",MODEL_OPERATION_INSERT,1)
			oAC9:SetValue("AC9_FILIAL", xFilial( "AC9") )
			oAC9:SetValue("AC9_FILENT", xFilial( cAlias ) )
			oAC9:SetValue("AC9_ENTIDA", cAlias )
			oAC9:SetValue("AC9_CODENT", cChvUni )
			oAC9:SetValue("AC9_CODOBJ", M->ACB_CODOBJ )
			oAC9:CRUD()
			oAC9:Destroy()
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se o acesso foi permitido exibi banco de conhecimento
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			Aadd(aRotina,{"Conhecimento","MsDocument", 0 , 4}) //"Conhecimento"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//ЁBanco de conhecimento
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			lRet := MsDocument( cAlias, (cAlias)->( Recno() ),1)
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//ЁExclui documento da lista
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If lRet
				::DelDocBC(nAt,aFiles)
			Else
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			//Ё Deleta registro da acb de lixo
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				DelAcbAc9(.T.)
			EndIf
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Fecha Semaforo
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		PLSFechaSem(nH,"GetDocBC" + cFile + ".SMF")
	Else
		_Super:ExbMHelp("Arquivo sendo usado por outro Monitor")//"Arquivo sendo usado por outro Monitor"
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁRestaura area
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	RestArea( aArea )
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina															 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return NIL
//-------------------------------------------------------------------
/*/ { Protheus.doc } DelDocBC
Deleta arquivo da pasta de monitor de fax

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD DelDocBC(nAt,aFiles) Class CABA790C
	LOCAL nRenOk  := -1
	LOCAL cRename := aFiles[nAt,2] + 'excluido_' + aFiles[nAt,1]
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Retomeia pois a GetFiles nao pega arquivos com excluido_
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	nRenOk := FRename(aFiles[nAt,2]+aFiles[nAt,1] , cRename )
	If nRenOk == -1
		_Super:ExbMHelp( "NЦo foi possivel excluir arquivo da lista" ) //"NЦo foi possivel excluir arquivo da lista"
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina															 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return NIL
//-------------------------------------------------------------------
/*/ { Protheus.doc } VldAplication
Retorna dados da guia posicionada

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VldAplication() Class CABA790C
	LOCAL lRet := .T.
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o operador tem acesso a rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !::lMonFax .And. !::lIncAno .And. !::lIncDem .And. !::lIntSau .And. !::lIncPar .And. !::lIncEnc
		_Super:ExbMHelp("Rotina disponМvel apenas para operador autorizado") //"Rotina disponМvel apenas para operador autorizado"
		lRet:= .F.
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina															 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetOnlyVisible
Set se a rotina serА somente em modo visual

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetOnlyVisible(lVisible) Class CABA790C
	::lVisible := lVisible
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } VldAcessoGui
Valida acesso a guia se o operador tem direito

@author Alexander Santos
@since 02/02/11            
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VldAcessoGui(lEmAnlise,lIncons,lAutori, lAudit, cAlias, lEvol) Class CABA790C
	LOCAL lRet			:= .T.
	LOCAL lForLib		:= .F.
	DEFAULT lEmAnlise	:= .T.
	DEFAULT lIncons	:= .F.
	DEFAULT lAutori	:= .F.
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza informacoes da classe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	::SetAtuPClass(lEvol)


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se tem guia para ser analisada
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !::lHaveGuia
		_Super:ExbMHelp( "NЦo existe guia para analise") //"NЦo existe guia para analise"
		lRet := .F.
	
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se nao for da interna-saude
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !::lIntSau .And. !::lInconsistente
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Verifica se foi encaminhada e se o operador e do mesmo departamento
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet .And. !::lHaveOwner .And. !::lThisDep
			_Super:ExbMHelp( "Somente o operador deste departamento tem acesso") //"Somente o operador deste departamento tem acesso"
			lRet := .F.
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Verifica se a guia tem dono 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet .And. ::lHaveOwner .And. !::lOwner
		//Verifica se o usuАrio tem autorizaГЦo para liberar guias bloqueadas por outros usuАrios e se nЦo exibiu a mensagem 
			IF ::lLibGuia .and. !cPlMsgAud == B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
				lForLib := MsgYesNo("A guia esta bloqueada para:" + UPPER(USRRETNAME(B53->B53_OPERAD)) + "Deseja mesmo liberar esta Guia?", "Tem autorizaГЦo?") //A guia esta bloqueada para:/"Deseja mesmo liberar esta Guia?"
				cPlMsgAud := B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
		//Verifica se o usuАrio tem autorizaГЦo para liberar guias bloqueadas por outros usuАrios e se jА exibiu a mensagem 
			ElseIf ::lLibGuia .and. cPlMsgAud == B53->(B53_CODLDP+B53_CODPEG+B53_NUMERO)
				lForLib := .T.
			EndIf
			IF (!lForLib)
				_Super:ExbMHelp( "Somente o operador desta guia tem acesso") //"Somente o operador desta guia tem acesso"
				lRet	:= .F.
			EndIf
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Se esta ok 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet .And. lEmAnlise
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Verfica se a guia esta em analise
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !::lEmAnalise
		
				_Super:ExbMHelp( "A guia deve estar em analise") //"A guia deve estar em analise"
				lRet := .F.
			
			EndIf
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Verifica se a guia esta autorizada
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lRet .And. lAutori .And. ::lAutorizada .And. !::lEvolucao
			_Super:ExbMHelp( "Esta guia jА esta autorizada!") //"Esta guia jА esta autorizada!"
			lRet := .F.
		EndIf
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o procedimento selecionado И de auditoria
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !EMPTY(lAudit) .AND. lAudit
		If ::cAudito == "0"
			_Super:ExbMHelp("Este procedimento nЦo possui critica para auditoria") //Este procedimento nЦo possui critica para auditoria
			lRet := .F.
		EndIf
	EndIf

//дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetAtuPClass
Seta valor nas proprioedades da classe

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetAtuPClass(lEvol) CLASS CABA790C

	DEFAULT lEvol := .F.
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza propriedades
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	AtuPClass(Self, lEvol)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetFieldGui
Ajusta campos conforme a guia

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetFieldGui(cCampo) Class CABA790C
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁSe for internacao ajusta campos
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Do Case
	Case ::lInternacao .Or. ::lEvolucao
		cCampo := StrTran(cCampo,'AUT','INT')
		cCampo := StrTran(cCampo,'OPEMOV','CODOPE')
	Case ::lOdonto
	Case ::lReembolso
	EndCase
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁFim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(cCampo)
//-------------------------------------------------------------------
/*/ { Protheus.doc } SetAuditoria
Cria o registro para auditoria por guia

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetAuditoria(lAuditoria,lIntern,lEvolu,lReembolso,lPartic,aDadCri,aCabCri,cCodCri,cRegInt,cAliasCri,aColsITE,aHeaderITE,cAliasIte,lOPME) Class CABA790C
	LOCAL nI			:= 1
	LOCAL cAlias 	 	:= "BEA"
	LOCAL cOpeMov   	:= ""
	LOCAL cCarInt   	:= ""
	LOCAL cNumAut		:= ""
	LOCAL cTipo		 	:= ""
	LOCAL cTpGuia	 	:= ""
	LOCAL cPerAud 		:= ""
	LOCAL cTipAdm		:= ""
	LOCAL cPriori		:= "0"
	LOCAL cOriMov		:= ""
	LOCAL cCodDep		:= ""
	LOCAL cCodMun 		:= ""
	LOCAL lAutorizacao 	:= .F.
	LOCAL lFutura		:= .F.
	LOCAL lDemand		:= .F.
	LOCAL aMat			:= {}
	LOCAL oGEN			:= NIL
	LOCAL oB53			:= NIL
	LOCAL nPosit 		:= 0
	LOCAL nNegat 		:= 0
	LOCAL oBE4			:= NIL
	LOCAL lGui			:= .F.
	LOCAL cChave		:= ""
	LOCAL lIntEvo		:= lIntern .Or. lEvolu
	LOCAL nPosGlo		:= 0
	DEFAULT aColsITE	:= {}
	DEFAULT aHeaderITE	:= {}
	DEFAULT cAliasIte	:= {}
	DEFAULT lOPME		:= .F.

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se esta habilitada a nova auditoria
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If GetNewPar("MV_PL790NE","0") == "0"
		Return
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Define Alias
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If lIntern .Or. lEvolu
		cAlias := "BE4"
		If lEvolu
			cAliasCri:="BQZ" //dEFAULT E TABELA BEG DE CRITICAS DA INTERNAгцO
		Endif
	ElseIf lReembolso
		cAlias := "B44"
	ElseIf lOPME
		cAlias := "B4A"
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Variaveis
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	cOpeMov := Iif( lIntEvo,(cAlias)->&(cAlias+"_CODOPE"),(cAlias)->&(cAlias+"_OPEMOV") )
	cNumAut := cOpeMov + Iif( !lIntEvo,(cAlias)->( &(cAlias+"_ANOAUT")+&(cAlias+"_MESAUT")+&(cAlias+"_NUMAUT") ),(cAlias)->( &(cAlias+"_ANOINT")+&(cAlias+"_MESINT")+&(cAlias+"_NUMINT") ) )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Municipio do local de atendimento
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	If lOPME
	
		dbSelectArea("BID")
		BEA->(dbSetOrder(1) )
		BEA->( MsSeek( xFilial("BEA")+B4A->B4A_GUIREF))
		If BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) == B4A->B4A_GUIREF
			If BB8->( MsSeek( xFilial("BB8")+ BEA->BEA_CODRDA+cOpeMov+ BEA->BEA_CODLOC+BEA->BEA_LOCAL) )
				cCodMun := BB8->BB8_CODMUN
			Else
				cCodMun := BID->BID_CODMUN
			Endif
		Else
			cCodMun := BID->BID_CODMUN
		Endif
	
	Else

		If BB8->( MsSeek( xFilial("BB8") + (cAlias)->&(cAlias+"_CODRDA") + cOpeMov + (cAlias)->&(cAlias+"_CODLOC") + (cAlias)->&(cAlias+"_LOCAL") ) )
			cCodMun := BB8->BB8_CODMUN
		EndIf
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Quando nao e reembolso
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If lEvolu .Or. lIntern
		cOriMov := BE4->BE4_ORIMOV
		cTpGuia := '3'
	ElseIf !lReembolso .And. !lOPME .And. (!lEvolu .Or. !lIntern)
		cOriMov := (cAlias)->&(cAlias+"_ORIMOV")
		cTpGuia := BEA->BEA_TIPO
	ElseIf lOPME
		cOriMov := '3'
		cTpGuia := '6'
	Else
		cOriMov := '3'
		cTpGuia := '5'
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Tipo de adimissao
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If (cAlias)->( FieldPos(cAlias+"_TIPADM") ) > 0
		cTipAdm := (cAlias)->&(cAlias+"_TIPADM")
	Else
		cTipAdm := GetNewPar("MV_PLSTPAD","6")
	EndIf
	cCarInt := Posicione("BDR",1,xFilial("BDR") + cOpeMov + cTipAdm,"BDR_CARINT")

	nPosGlo := PLRETPOS(cAliasCri + "_CODGLO",aCabCri)

	If nPosGlo > 0 .And. Len(aDadCri) >= nPosGlo
		lDemand := Ascan( aDadCri,{|x| x[nPosGlo] == cCodCri } ) > 0
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Alimenta o perfil de auditoria com base na critica						 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	For nI := 1 To Len(aDadCri)
		If nPosGlo > 0 .And. !Empty( aDadCri[ nI,nPosGlo ] )
	
			cTipo := Posicione("BCT",1,xFilial("BCT") + cOpeMov + aDadCri[ nI,nPosGlo ],"BCT_TIPO")
		
			If At(cTipo,cPerAud) == 0
				cPerAud += cTipo+";"
			EndIf
		EndIF
	Next
	cPerAud := Iif(Empty(cPerAud),"0;1;2;",cPerAud)
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Classificacao da prioridade
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд

	If ExistBlock("PLSAUDPR") .And. lAuditoria
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Dados enviado ao ponto de entrada 0=Baixa,1=Media,2=Alta
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд    
		lAutorizacao :=	Iif(BEA->BEA_ORIGEM == "1" .And. (!lEvolu .Or. !lIntern),.T.,.F. )

		If lIntEvo
			lFutura := (cAlias)->&(cAlias+"_PRVINT") > (cAlias)->&(cAlias+"_DTDIGI")
		ElseIf 	lReembolso
			lFutura := (cAlias)->&(cAlias+"_DATPRO") > (cAlias)->&(cAlias+"_DTDIGI")
		ElseIf 	lOPME
			lFutura := (cAlias)->&(cAlias+"_DATPRO") > (cAlias)->&(cAlias+"_DATSOL")
		Else
			lFutura := (cAlias)->&(cAlias+"_DATSOL") > (cAlias)->&(cAlias+"_DTDIGI")
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Avaliacao do ponto de entrada
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		cPriori := ExecBlock("PLSAUDPR",.F.,.F.,{cOriMov,cTipo,lAutorizacao,cCarInt,lFutura,lReembolso,lEvolu,lIntern } )
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Instancia o modelo de dados												 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	oB53 := PLSSTRUC():New("B53")

	If Existblock("PL790INIP")
		oB53 := ExecBlock("PL790INIP", .F., .F., {oB53} )
	Endif

	oB53:SetValue("B53_NUMGUI", cNumAut )
	oB53:SetValue("B53_ORIMOV", cOriMov )
	oB53:SetValue("B53_CODMUN", cCodMun )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Tem que verificar se ja nao existe pois a evolucao vai inserir varios procedimento na mesma guia
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oGEN := CABREGIC():New()
	oGEN:GetDadReg("B53",1, xFilial("B53") + cNumAut + cOriMov )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se nao existir inseri
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !oGEN:lFound
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Chaves																	 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetValue("B53_FILIAL", xFilial(cAlias) )
		oB53:SetValue("B53_ALIMOV", cAlias )
		oB53:SetValue("B53_RECMOV", cValToChar( (cAlias)->( Recno() ) ) )
		oB53:SetValue("B53_CODOPE", cOpeMov )
		oB53:SetValue("B53_CODLDP", IIf(lOPME, "0000",(cAlias)->&(cAlias+"_CODLDP") ))
		oB53:SetValue("B53_CODPEG", IIf(lOPME,"00000000",(cAlias)->&(cAlias+"_CODPEG") ))
		oB53:SetValue("B53_NUMERO", Iif(lIntEvo,(cAlias)->&(cAlias+"_NUMERO"), Iif(lOPME, (cAlias)->&(cAlias+"_NUMAUT"),(cAlias)->&(cAlias+"_NUMGUI") ) ))
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Campos restantes														 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetValue("B53_DATMOV", dDataBase )
		oB53:SetValue("B53_HORMOV", Left(Time(),5) )
		oB53:SetValue("B53_MATUSU", (cAlias)->( &(cAlias+"_OPEUSR")+&(cAlias+"_CODEMP")+&(cAlias+"_MATRIC")+&(cAlias+"_TIPREG")+&(cAlias+"_DIGITO") ) )
		oB53:SetValue("B53_NOMUSR", Posicione( "BA1",2,xFilial("BA1") + (cAlias)->( &(cAlias+"_OPEUSR")+&(cAlias+"_CODEMP")+&(cAlias+"_MATRIC")+&(cAlias+"_TIPREG")+&(cAlias+"_DIGITO") ) ,"BA1_NOMUSR" ) )
		oB53:SetValue("B53_DEMAND", Iif(lDemand,"1","0") )
		oB53:SetValue("B53_PARTIC", Iif(lPartic,"1","0") )
		oB53:SetValue("B53_STATUS", (cAlias)->&(cAlias+"_STATUS") )
		oB53:SetValue("B53_CARINT", cCarInt )
		oB53:SetValue("B53_PERAUD", cPerAud  )
		oB53:SetValue("B53_TIPO", cTpGuia )
		oB53:SetValue("B53_AGEPAR", "0" )
		oB53:SetValue("B53_SITUAC", "0" )
		oB53:SetValue("B53_BANCON", "0" )
		oB53:SetValue("B53_ENCAMI", "0" )
	
		If lOPME
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se for guia de anexos clinicos, o sistema busca a RDA da guia usada como
		//	referencia na guia de anexos.														 
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If !lGui
				BE4->(dbSetORder(2))
				lGui := BE4->(dbSeek(xFilial("BE4") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
				cCRda := BE4->BE4_CODRDA
			EndIf
		
			If !lGui
				BE2->(dbSetORder(3))
				lGui := BE2->(dbSeek(xFilial("BE2") + BE2->(BE2_OPEMOV + BE2_ANOINT + BE2_MESINT + BE2_NUMINT)))
				cCRda := BE2->BE2_CODRDA
			EndIf
		
			If !lGui
				B44->(dbSetORder(1))
				B44->(dbSeek(xFilial("B44") + B44->(B44_OPEMOV + B44_ANOAUT + B44_MESAUT + B44_NUMAUT)))
				cCRda := B44->B44_CODRDA
			EndIf
		 
			oB53:SetValue("B53_CODRDA", cCRda )
		
		Else
			oB53:SetValue("B53_CODRDA", (cAlias)->&(cAlias+"_CODRDA") )
		EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava o departamento quando for de demanda
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lDemand
		
			oBX4 := CABREGIC():New()
			oBX4:GetDadReg("BX4" ,1, ( xFilial("BX4") + RETCODUSR() + PlsIntPad() ) )

			If oBX4:lFound
				cCodDep := oBX4:GetValue("BX4_CODDEP")
				oB53:SetValue("B53_CODDEP", cCodDep )
			EndIf
		                   
			oBX4:Destroy()
		Else
		// Ponto de entrada para personalizar a gravaГЦo do departamento. Valido somente se nao for demanda.
			If Existblock("PLSDEPTO")
				cCodDep := Execblock("PLSDEPTO", .f., .f., {cOriMov,cTipo,lAutorizacao,cCarInt,lFutura,lReembolso,lEvolu,lIntern,aDadCri,aCabCri,aColsITE,aHeaderITE,cAliasIte,cAliasCri,cRegInt,lPartic} )
				oB53:SetValue("B53_CODDEP", cCodDep)
			Endif
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё NЦo tenha sido informado pega do parametro XML POR EXEMPLO.
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If Empty(cCodDep)
			cCodDep := GetNewPar("MV_PL790DP","001")
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Evolucao de Internacao
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetValue("B53_PROINT", Iif(lEvolu,"1","0") )
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Na internacao
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetValue("B53_REGINT", cRegInt )
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё 0=Baixa;1=Media;2=Alta
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetValue("B53_PRIORI", cPriori )
	
		If lEvolu
	
			cChave := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)

			BEJ->(dbSetOrder(1))
			If BEJ->(dbSeek(xFilial("BEJ") + cChave))

				While !BEJ->(EOF()) .AND. xFilial("BEJ")+BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) ==;
						xFilial("BEJ") + cChave
	
					If BEJ->BEJ_STATUS == '1'
						nPosit++
					Else
						nNegat++
					EndIf
					BEJ->(dbSkip())
				EndDo
			EndIf

			BQV->(dbSetOrder(1))
			If BQV->(dbSeek(xFilial("BQV") + cChave))

				While !BQV->(EOF()) .AND. xFilial("BQV")+BQV->(BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT) ==;
						xFilial("BQV") + cChave

					If BQV->BQV_STATUS == '1'
						nPosit++
					Else
						nNegat++
					EndIf
					BQV->(dbSkip())
				EndDo
			EndIf
		
			oBE4 := PLSSTRUC():New( "BE4",4,,BE4->( Recno() ) )
		
			If nPosit == 0 .AND. nNegat > 0
				oBE4:SetValue("BE4_STATUS", "3")
				oB53:SetValue("B53_STATUS", "3")
				lAudEvo := .T.
			ElseIf nPosit > 0 .AND. nNegat > 0
				oBE4:SetValue("BE4_STATUS", "2")
				oB53:SetValue("B53_STATUS", "2")
				lAudEvo := .T.
			ElseIf nPosit > 0 .AND. nNegat == 0
				oBE4:SetValue("BE4_STATUS", "1")
				oB53:SetValue("B53_STATUS", "1")
			EndIf
		
			If !oBE4:CRUD()
				oBE4:ExbMHelp( oBE4:GetErrorMessage(.T.) )
			EndIf
			oBE4:Destroy()
		
		EndIf

	Else
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Complementa o perfil
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		aMat := _Super:Split(";", oGEN:GetValue("B53_PERAUD") )
		For nI:=1 To Len(aMat)
			If !Empty(aMat[nI]) .And. !(aMat[nI] $ cPerAud)
				cPerAud += aMat[nI]+";"
			EndIf
		Next
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Se a guia ja foi analisada limpa o operador
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If oGEN:GetValue("B53_SITUAC") == "1"
			oB53:SetValue("B53_OPERAD", "" )
			oB53:SetValue("B53_SITUAC", "0" )
			oB53:SetValue("B53_DATINI", CToD("") )
			oB53:SetValue("B53_HORINI", "" )
			oB53:SetValue("B53_DATFIM", CToD("") )
			oB53:SetValue("B53_HORFIM", "" )
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Campos que devem ser alterados
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oB53:SetlAltera(.T.)
		oB53:SetValue("B53_PERAUD", cPerAud )
		oB53:SetValue("B53_DEMAND", Iif(lDemand,"1","0") )
		oB53:SetValue("B53_PARTIC", Iif(lPartic,"1","0") )
		oB53:SetValue("B53_CARINT", cCarInt )
		oB53:SetValue("B53_PRIORI", cPriori )
		oB53:SetValue("B53_PROINT", Iif(lEvolu,"1","0") )
		oB53:SetValue("B53_SITUAC", "0" )
	
		If !EMPTY(oGEN:getValue("B53_DATFIM"))
			oB53:SetValue("B53_DATMOV", date() )
			oB53:SetValue("B53_HORMOV", SUBSTR(Time(), 1, 5) )
		EndIf
	
		If lEvolu
			BEJ->(dbSetOrder(1))
			If BEJ->(dbSeek(xFilial("BEJ")+B53->B53_NUMGUI))

				While !BEJ->(EOF()) .AND. xFilial("BEJ")+BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) ==;
						xFilial("BEJ")+B53->B53_NUMGUI
	
					If BEJ->BEJ_STATUS == '1'
						nPosit++
					Else
						nNegat++
					EndIf
					BEJ->(dbSkip())
				EndDo
			EndIf

			BQV->(dbSetOrder(1))
			If BQV->(dbSeek(xFilial("BQV")+B53->B53_NUMGUI))

				While !BQV->(EOF()) .AND. xFilial("BQV")+BQV->(BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT) ==;
						xFilial("BQV")+B53->B53_NUMGUI

					If BQV->BQV_STATUS == '1'
						nPosit++
					Else
						nNegat++
					EndIf
					BQV->(dbSkip())
				EndDo
			EndIf
		EndIf

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Cria o objeto para a atualizacao
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	
		If lEvolu
			oBE4 := PLSSTRUC():New( "BE4",4,,BE4->( Recno() ) )
		
			If nPosit == 0 .AND. nNegat > 0
				oBE4:SetValue("BE4_STATUS", "3")
				oB53:SetValue("B53_STATUS", "3")
				lAudEvo := .T.
			ElseIf nPosit > 0 .AND. nNegat > 0
				oBE4:SetValue("BE4_STATUS", "2")
				oB53:SetValue("B53_STATUS", "2")
				lAudEvo := .T.
			ElseIf nPosit > 0 .AND. nNegat == 0
				oBE4:SetValue("BE4_STATUS", "1")
				oB53:SetValue("B53_STATUS", "1")
			EndIf
		
		EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Grava dados na base de dados											 
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If lEvolu
			If !oBE4:CRUD()
				oBE4:ExbMHelp( oBE4:GetErrorMessage(.T.) )
			EndIf
			oBE4:Destroy()
		EndIf

	EndIf

	If !oB53:CRUD()
		oB53:ExbMHelp( oB53:GetErrorMessage(.T.) )
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Destroy a Classe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oB53:Destroy()
	oGEN:Destroy()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁFim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } EMail
Envia email

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD EMail() Class CABA790C
	LOCAL aArea	:= GetArea()
	LOCAL lRet		:= .F.
	LOCAL cTo		:= ""
	LOCAL cFrom 	:= ""
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica dados do usuario de envio
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	PswOrder(2)
	cFrom := UsrRetMail(RetCodUsr())//AllTrim(PswRet(1)[1][14])

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica dados do usuario destinatario
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	cTo := UsrRetMail(B70->B70_COPAGE)//AllTrim(PswRet(1)[1][14])

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se tem e-mail
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	If Empty(cFrom)
		_Super:ExbMHelp( "E-MAIL nЦo informado para o Remetente" ) //"E-MAIL nЦo informado para o Remetente"
		Return
	EndIf

	If Empty(cTo)
		_Super:ExbMHelp( "E-MAIL nЦo informado para o DestinatАrio" ) //"E-MAIL nЦo informado para o DestinatАrio"
		Return
	EndIf

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Dados enviado ao destinatario
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	cBeneficiario 	:= AllTrim(B53->B53_MATUSU + " - " + Posicione("BA1",2,xFilial("BA1")+B53->B53_MATUSU,"BA1->BA1_NOMUSR"))
	cNumGui			:= AllTrim(B53->B53_NUMGUI)
	cRda			:= AllTrim(B53->B53_CODRDA + " - " + Posicione("BAU",1,xFilial("BAU")+B53->B53_CODRDA,"BAU->BAU_NOME"))
	cDHRea			:= AllTrim(DToC(B70->B70_DATREA) + " - " + B70->B70_HORREA)
	cDHAge			:= AllTrim(DToC(B70->B70_DATAGE) + " - " + B70->B70_HORAGE)
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o usuario de e para tem email
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд 
	If !Empty(cFrom) .And. !Empty(cTo)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
    //ЁMonta o corpo do e-mail												   
    //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		cBody := "<html>"
		cBody += "<style type='text/css'><!--"
		cBody += ".texto {"
		cBody += "	font-family: Arial, Helvetica, sans-serif;font-size: 12px;"
		cBody += "	color: #333333;text-decoration: none;font-weight: normal;"
		cBody += "}"
		cBody += ".titulo {"
		cBody += "	font-family: Arial, Helvetica, sans-serif;font-size: 16px;"
		cBody += "	color: #19167D;text-decoration: none;font-weight: bold;"
		cBody += "}"
		cBody += "--></style>"

		cBody += "<body>"
		cBody += "<table width='400' height='60' border='0' cellpadding='0' cellspacing='0'>"
		cBody += "<tr class='titulo'>"
		cBody += "<td height='10'>"
		cBody += "	<strong><font size='4'>Auditoria Participativa - Agendamento</font></strong>"
		cBody += "<td>"
		cBody += "</tr>"
		cBody += "<tr><td><br></td></tr>"
		cBody += "<tr>"
		cBody += "<td height='30'>"
		cBody += "<table>"
		cBody += "	<tr class='texto'>"
		cBody += "		<td width='130' align='Right'><strong>Beneficiario:</strong></td>"
		cBody += "		<td>"+cBeneficiario+"</td>"
		cBody += "	</tr>"

		cBody += "	<tr class='texto'>"
		cBody += "		<td width='130' align='Right'><strong>Rede de Atendimento:</strong></td>"
		cBody += "		<td>"+cRda+"</td>"
		cBody += "	</tr>"
	 
		cBody += "	<tr class='texto'>"
		cBody += "		<td width='130' align='Right'><strong>Numero da Guia:</strong></td>"
		cBody += "		<td>"+cNumGui+"</td>"
		cBody += "	</tr>"
	
		cBody += "	<tr class='texto'>"
		cBody += "		<td width='130' align='Right'><strong>RealizaГЦo:</strong></td>"
		cBody += "		<td>"+cDHRea+"</td>"
		cBody += "	</tr>"
	
		cBody += "	<tr class='texto'>"
		cBody += "		<td width='130' align='Right'><strong>Agendamento:</strong></td>"
		cBody += "		<td>"+cDHAge+"</td>"
		cBody += "	</tr>"
		cBody += "</table>"
		cBody += "</td>"
		cBody += "</tr>"
		cBody += "</table>"
		cBody += "</body>"
		cBody += "</html>"
    //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
    //ЁEnvia email
    //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		::SendEmail(cFrom,cTo,,,"Agendamento de Visita",cBody) //"Agendamento de Visita"
    //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
    //ЁVerifica se teve erro
    //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		_Super:ExbMHelp( ::cErro )
		lRet := .T.
	Else
		_Super:ExbMHelp( "E-MAIL nЦo encontrado" ) //"E-MAIL nЦo encontrado"
		lRet := .F.
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Rest nas linhas do browse e na area										 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	RestArea( aArea )
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//ЁFim do Metodo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } NegComp
Nega participacao do item

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD NegComp() Class CABA790C
	LOCAL cSequen := (::cAIte)->&(::cAIte + "_SEQUEN")
	LOCAL cCodPad := (::cAIte)->&(::cAIte + "_CODPAD")
	LOCAL cCodPro := (::cAIte)->&(::cAIte + "_CODPRO")
	LOCAL cStatus := (::cAIte)->&(::cAIte + "_STATUS")
	LOCAL dDatPro := (::cAIte)->&(::cAIte + "_DATPRO")
	LOCAL cCodRda := B53->B53_CODRDA
	LOCAL cMatric := B53->B53_MATUSU
	LOCAL cChave  := xFilial("B53") + B53->( B53_CODOPE + B53_CODLDP + B53_CODPEG + B53_NUMERO + B53_ORIMOV ) + cSequen
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Nega ou autoriza a participacao
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	PLSNACOM(cSequen,cCodPad,cCodPro,cStatus,dDatPro,,cChave,cCodRDA,.T.,cMatric)
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina															 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } NegComp
Nega participacao do item

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD SetDemanda() Class CABA790C
	LOCAL B53 := NIL
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Atualiza para demanda
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	B53 := PLSSTRUC():New( "B53",4,,B53->( Recno() ) )
	B53:SetValue("B53_DEMAND",'1' )
	B53:CRUD()
	B53:Destroy()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da Rotina															 
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
//-------------------------------------------------------------------
/*/ { Protheus.doc } Destroy
Libera da memoria o obj (Destroy)

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD Destroy() Class CABA790C
	FreeObj(Self)
Return
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁAtuPClass Ё Autor Ё Totvs				    Ё Data Ё 17/03/11 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Atualiza propriedades da Classe	  						  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function AtuPClass(oSelf, lEvol)
	LOCAL aRet 	:= {}

	Iif(lEvol,lEvo := .T.,Nil)

//Operador Corrente
	oSelf:cOperad := RETCODUSR()

//Dados do operador
	RetDadOpe(oSelf)

//Informacoes da guia
	
//Informacoes da guia
	oSelf:lEmAnalise		:= B53->B53_SITUAC=='2'
	oSelf:lEspera  	 		:= B53->B53_SITUAC=='3'
	oSelf:lAnalisada 		:= Iif(B53->B53_SITUAC=='1',.T.,.F.)
	oSelf:lInconsistente	:= Iif(B53->B53_SITUAC=='4',.T.,.F.)
	oSelf:lIncoRes			:= Iif(B53->B53_SITUAC=='4' .And. B72->B72_INCONS == '1',.T.,.F.)
	oSelf:lNotInRes			:= Iif(B53->B53_SITUAC=='4' .And. B72->( Eof() ),.T.,.F.)
	oSelf:lAutorizada   	:= Iif(B53->B53_STATUS=='1',.T.,.F.)
	oSelf:lParticipativa	:= Iif(B53->B53_PARTIC=='1',.T.,.F.)
	oSelf:lAgendada     	:= Iif(B53->B53_AGEPAR=='1',.T.,.F.)
	oSelf:lDemanda			:= Iif(B53->B53_DEMAND=='1',.T.,.F.)
	oSelf:lHaveOwner 		:= !Empty(B53->B53_OPERAD)
	oSelf:lOwner 			:= B53->B53_OPERAD==oSelf:cOperad
	oSelf:lThisDep 			:= Empty(B53->B53_CODDEP) .Or. B53->B53_CODDEP==oSelf:cCodDep
	oSelf:cOwner			:= B53->B53_OPERAD
	oSelf:lHaveGuia  		:= !Empty(B53->B53_NUMGUI)
	oSelf:cNumGuia  		:= B53->B53_NUMGUI
	oSelf:cCodDepa			:= oSelf:cCodDep //[r7]
	//oSelf:lRotinaGen		:= IIF(B53->B53_ROTGEN == "1", .T., .F.)
	oSelf:cAllPerfil		:= B53->B53_PERAUD
	oSelf:lConsulta     	:= AllTrim(B53->B53_TIPO)=='1'
	oSelf:lSadt				:= AllTrim(B53->B53_TIPO)=='2'
	oSelf:lInternacao		:= AllTrim(B53->B53_TIPO)=='3'
	oSelf:lOdonto			:= AllTrim(B53->B53_TIPO)=='4'
	oSelf:lReembolso		:= AllTrim(B53->B53_TIPO)=='5'
	oSelf:lOPME				:= AllTrim(B53->B53_TIPO)=='6'
	oSelf:lProrrog			:= AllTrim(B53->B53_TIPO)=='11'
	oSelf:lEvolucao 		:= lEvo
	oSelf:lCriDia			:= (AllTrim(B53->B53_TIPO)=='3' .or. AllTrim(B53->B53_TIPO)=='11') .and. u_CAB790VDIA(B53->B53_NUMGUI, AllTrim(B53->B53_TIPO))
	oSelf:cACab				:= B53->B53_ALIMOV
	aRet 					:= RetAliRel(oSelf)
	oSelf:cAIte				:= aRet[1]
	oSelf:cACri				:= aRet[2]
	oSelf:nIdxIte			:= aRet[3]
	oSelf:nIdxCri  			:= aRet[4]
	oSelf:cAudito 			:= RetAudito(oSelf)

Return
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁRetDadOpe Ё Autor Ё Totvs			    	Ё Data Ё 17/03/11 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Atualiza propriedades da Classe	  						  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RetDadOpe(oSelf)
	LOCAL nPos := 0
	LOCAL aRet := {}
	LOCAL oBX4 := CABREGIC():New()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Acesso ao registro
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oBX4:GetDadReg("BX4" ,1, ( xFilial("BX4") + oSelf:cOperad + PlsIntPad() ) )
	oSelf:cDesPerf := ""
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Se existe
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If oBX4:lFound
		oSelf:cPerfil := oBX4:GetValue("BX4_PERAUD")
		oSelf:cDirFax := oBX4:GetValue("BX4_DIRDOC")
	
		aRet := RetSx3Box( X3CBox( Posicione('SX3',2,"BX4_PERAUD",'X3_CBOX') ),,,1 )
	
		If (nPos := AsCan( aRet , {|x| AllTrim(x[2]) == oSelf:cPerfil} ) ) > 0
			oSelf:cDesPerf := aRet[nPos,3]
		EndIf
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se pode incluir processo de demanda
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oSelf:cCodDep 	:= oBX4:GetValue("BX4_CODDEP")
	oSelf:lLibGuia	:= IIf( BX4->(FieldPos('BX4_LIBGUI')) > 0, oBX4:GetValue("BX4_LIBGUI") == "1", .F. )
	oSelf:lIncDem 	:= oBX4:GetValue("BX4_PROCES") == "1"
	oSelf:lIncPar 	:= oBX4:GetValue("BX4_PARTIC") == "1"
	oSelf:lIncEnc 	:= oBX4:GetValue("BX4_ENCMIN") == "1"
	oSelf:lIntSau 	:= oBX4:GetValue("BX4_INTSAU") == "1"
	oSelf:lIncAno	:= oBX4:GetValue("BX4_ANOTAC") == "1"
	oSelf:lMonFax 	:= oBX4:GetValue("BX4_MOTDOC") == "1"
	oSelf:lVisAud 	:= oBX4:GetValue("BX4_VISAUD") == "1"
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oBX4:Destroy()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim da rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁRetAliRel Ё Autor Ё Totvs			    	Ё Data Ё 17/03/11 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Retorna os alias relacionado como alias informado          Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RetAliRel(oSelf)
	LOCAL aRet := {"","",1,1}
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica o alias selecionado {Item,Critica,IdxItem,IdxCritica}
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	Do Case
	Case oSelf:lSadt .Or. oSelf:lConsulta
		aRet := {"BE2","BEG",1,1}
	Case oSelf:lInternacao .And. !oSelf:lEvolucao
		aRet := {"BEJ","BEL",1,1}
	Case oSelf:lEvolucao
		aRet := {"BQV","BQZ",1,1}
	Case oSelf:lOdonto
		aRet := {"BE2","BEG",1,1}
	Case oSelf:lReembolso
		aRet := {"B45","B46",1,1}
	Case oSelf:lOPME
		aRet := {"B4C","BEG",1,1}
	Case oSelf:lPRORROG
		aRet := {"B4Q","BQZ",1,1}	
	EndCase
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return(aRet)
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁDelAcbAc9 Ё Autor Ё Totvs			    	Ё Data Ё 17/03/11 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Verifica se ficou alguma sujeito na acb quando fecha a telaЁ╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function DelAcbAc9(lExcAC9)
	LOCAL oAC9 		:= NIL
	LOCAL oACB 		:= NIL
	DEFAULT lExcAC9 := .F.
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Elimina lixo da acb
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	If !lExcAC9
		If !ACB->( Eof() )
			oAC9 := CABREGIC():New()
			oAC9:GetDadReg( "AC9",1, xFilial("AC9") + ACB->ACB_CODOBJ,,,.F. )
	
			If !oAC9:lFound
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			//Ё Deleta arquivo movido para pasta do banco de conhecimento
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				If FErase(MsDocPath()+"\"+ACB->ACB_OBJETO) == -1
					QOut("Impossivel deletar arquivo gerado no banco de conhecimento ["+MsDocPath()+"\"+ACB->ACB_OBJETO+"]") //"Impossivel deletar arquivo gerado no banco de conhecimento ["
				EndIf
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			//Ё Delete o lixo que foi gravado na acb
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
				oACB := PLSSTRUC():New( "ACB",MODEL_OPERATION_DELETE,,ACB->(Recno()))
				oACB:CRUD()
			
				oACB:Destroy()
				oAC9:Destroy()
			EndIf
		EndIf
	Else
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Deleta arquivo movido para pasta do banco de conhecimento
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If FErase(MsDocPath()+"\"+ACB->ACB_OBJETO) == -1
			QOut("Impossivel deletar arquivo gerado no banco de conhecimento ["+MsDocPath()+"\"+ACB->ACB_OBJETO+"]") //"Impossivel deletar arquivo gerado no banco de conhecimento ["
		EndIf
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Delete o lixo que foi gravado na acb
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oACB := PLSSTRUC():New( "ACB",MODEL_OPERATION_DELETE,,ACB->( Recno() ) )
		oACB:CRUD()
		oACB:Destroy()
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	//Ё Delete o lixo que foi gravado na acb
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		oAC9 := PLSSTRUC():New( "AC9",MODEL_OPERATION_DELETE,,AC9->( Recno() ) )
		oAC9:CRUD()
		oAC9:Destroy()
	EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Fim do Rotina
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
Return

/*/ { Protheus.doc } ProcPart
Informa para o auditor que o procedimento И participativo, 
caso exista registro criado no folder participativo

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD ProcPart() Class CABA790C

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Objeto que verifica e retorna se existe alguma participativa criada no folder
//  participativa
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
	oB70 := CABREGIC():New()
	oB70:GetDadReg("B70",1, xFilial("B70") + B53->(B53_ALIMOV+B53_RECMOV),,,.T. )

	If B53->B53_TIPO == "2" // LiberaГЦo/ Lib. Odonto/ AurotizaГЦo SADT e Odonto.

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o procedimento que esta sendo auditado И participativo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		If BE2->BE2_PARTIC == "1"
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se existir registro na pasta participativa relacionado ao procedimento e
		//  ainda nЦo foi realizado a confirmaГЦo
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If oB70:lFound .AND. oB70:GetValue("B70_RELCON") == "0"
				_Super:ExbMHelp("")
			EndIf
		EndIf

	ElseIf B53->B53_TIPO == "3" // InternaГЦo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o procedimento que esta sendo auditado И participativo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд	
		If BEJ->BEJ_PARTIC == "1"
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se existir registro na pasta participativa relacionado ao procedimento e
		//  ainda nЦo foi realizado a confirmaГЦo
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If oB70:lFound .AND. oB70:GetValue("B70_RELCON") == "0"
				_Super:ExbMHelp("")
			EndIf
		EndIf
	
	ElseIf B53->B53_TIPO == "5" // Reembolso

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
//Ё Verifica se o procedimento que esta sendo auditado И participativo
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд	
		If B45->B45_PARTIC == "1"
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
		//Ё Se existir registro na pasta participativa relacionado ao procedimento e
		//  ainda nЦo foi realizado a confirmaГЦo
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд
			If oB70:lFound .AND. oB70:GetValue("B70_RELCON") == "0"
				_Super:ExbMHelp("")
			EndIf
		EndIf
	EndIf

Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁCABA790C  Ё Autor Ё Totvs				    Ё Data Ё 30/03/10 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Somente para compilar a class							  Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function CABA790C
Return


/*/{Protheus.doc} RetAudito
Retorna se a guia esta em auditoria.
@author victor.silva
@since 17/10/2016
@return caracter, Status da guia
/*/
static function RetAudito(oSelf)
	local cAliGui	:= oSelf:cACab
	local cAliEve	:= oSelf:cAIte
	local cNumGuia	:= oSelf:cNumGuia
	local cChave	:= ""
	local cAudito	:= "0"
	local aArea		:= {}
	local oReg 		:= CABREGIC():New()
	local nIdx		:= 1
	Local cAlias1   := GetNextAlias()

//Verifica se o alias esta preenchido
	if Empty(cAliGui)
		return cAudito
	endif

//Inicializa a chave
	cChave	:= xFilial(cAliGui) + cNumGuia

//Salva area
	aArea	:= (cAliGui)->(GetArea())

//Se o item nao estiver posicionado, procura no cabecalho da guia
	if !lEvo

	//Se for internacao utiliza o indice 2
		if oSelf:lInternacao
			nIdx := 2
		endif
	
		oReg:GetDadReg(cAliGui,nIdx,cChave,,,.T.)

	//Retorna o valor
		if oReg:lFound
		
		// Devido o padrЦo alterar o campo BE4_AUDITO de forma errada, foi necessАrio a correГЦo abaixo.
			cCodOpe := subStr(B53->B53_NUMGUI,1,TamSx3("BEL_CODOPE")[1])
			cAnoInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+1,TamSx3("BEL_ANOINT")[1])
			cMesInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+TamSx3("BEL_ANOINT")[1]+1,TamSx3("BEL_MESINT")[1])
			cNumInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+TamSx3("BEL_ANOINT")[1]+TamSx3("BEL_MESINT")[1]+1,TamSx3("BEL_NUMINT")[1])
		
			BeginSql alias cAlias1
		
				
				SELECT count(BEL_CODOPE)  CONT
				FROM %table:BEL%
				WHERE
				BEL_NUMINT = %Exp:cNumInt%
				AND BEL_ANOINT = %Exp:cAnoInt%
				AND BEL_MESINT = %Exp:cMesInt%
				AND BEL_CODOPE = %Exp:cCodOpe%
				AND D_E_L_E_T_ = ' '
							
			EndSql
	
			If (cAlias1)->CONT > 0
			
				cAudito := oReg:GetValue(cAliGui + "_AUDITO")
			
				if cAudito == '0'
					oReg:SetValue(cAliGui + "_AUDITO",'1')
				Endif
			
			Endif
		
			If select(cAlias1) > 0
				dbselectarea(cAlias1)
				dbclosearea()
			endif
		
			cAudito := oReg:GetValue(cAliGui + "_AUDITO")
		
		endif

//Senao, pega direto do item
	else

	//Salva area
		aArea	:= (cAliEve)->(GetArea())
	
	//Monta a estrutura do registro 
		oReg:GetDadReg(cAliEve,,,(cAliEve)->(RecNo()),,.T.)
	
	//Retorna o valor
		if oReg:lFound
		
		// Devido o padrЦo alterar o campo BE4_AUDITO de forma errada, foi necessАrio a correГЦo abaixo.
			cCodOpe := subStr(B53->B53_NUMGUI,1,TamSx3("BEL_CODOPE")[1])
			cAnoInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+1,TamSx3("BEL_ANOINT")[1])
			cMesInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+TamSx3("BEL_ANOINT")[1]+1,TamSx3("BEL_MESINT")[1])
			cNumInt := subStr(B53->B53_NUMGUI,TamSx3("BEL_CODOPE")[1]+TamSx3("BEL_ANOINT")[1]+TamSx3("BEL_MESINT")[1]+1,TamSx3("BEL_NUMINT")[1])
		
			BeginSql alias cAlias1
					
				SELECT count(BQZ_CODOPE)  CONT
				FROM %table:BQZ%
				WHERE
				BQZ_NUMINT = %Exp:cNumInt%
				AND BQZ_ANOINT = %Exp:cAnoInt%
				AND BQZ_MESINT = %Exp:cMesInt%
				AND BQZ_CODOPE = %Exp:cCodOpe%
				AND D_E_L_E_T_ = ' '
							
			EndSql
	
			If (cAlias1)->CONT > 0
			
				cAudito := oReg:GetValue(cAliEve + "_AUDITO")
			
				if cAudito == '0'
					oReg:SetValue(cAliEve + "_AUDITO",'1')
					
				Endif
				
				
				cQuery := "update "+RetSqlName("BQZ")+" SET BQZ_PENDEN = '1' "
				cQuery += " WHERE
				cQuery += " BQZ_NUMINT = '"+cNumInt+"'"
				cQuery += " AND BQZ_ANOINT = '"+cAnoInt+"'"
				cQuery += " AND BQZ_MESINT = '"+cMesInt+"'"
				cQuery += " AND BQZ_CODOPE = '"+cCodOpe+"'"
				cQuery += " AND D_E_L_E_T_ = ' '            "
					
				TCsQLeXEC(cQuery)
			
			Endif
		
			If select(cAlias1) > 0
				dbselectarea(cAlias1)
				dbclosearea()
			endif
			
			cAudito := oReg:GetValue(cAliEve + "_AUDITO")
		
		endif
	
	endif

//Destroi o objeto
	oReg:Destroy()

//Restaura a area
	RestArea(aArea)

return cAudito
