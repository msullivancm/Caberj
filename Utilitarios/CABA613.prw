#Include 'Protheus.ch'


//--------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} CABA613
Função utilizada para realizar a importação dos dependentes PLS x FOLHA
Gravação de SRB - RHK - RHL
@type function
@author Mateus Medeiros
@since 22/06/2018
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------
User Function CABA613()
	
	Local aArea := GetArea()
	Local aCabExcel := {}
	
	Private aLog :=	{}
	
	AADD(aCabExcel, {"MATRICULA"	,"C", 6		, 0})
	AADD(aCabExcel, {"DESCRIÇÃO"    ,"C", 1000	, 0})
	
	
	
	Processa( {|| U_CABA613A(@aLog) }, "Aguarde...", "Gravando informações de dependentes do PLS x Folha ...",.F.)
	
	// imprime log
	DlgToExcel({{"ARRAY","LOG da importação dos dependentes PLS no RH",aCabExcel,aLog}})
	// finalização do log
	
	RestArea(aArea)
	
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} CABA613A
Busca informações do titulares e dependentes.
@type function
@author Mateus Medeiros
@since 22/06/2018
@return Nil
/*/

//--------------------------------------------------------------------------------------------------------
User Function CABA613A()
	
	Local aArea  := GetArea()
	Local cAliasTit := GetNextAlias()
	Local nTotal	:= 0
	Local nCount    := 0
	Local bWhile    := {|| (cAliasTit)->(!Eof()) }
	Local bCount    := {|| nTotal++ }
	Local aCabec   := {}
	Local aLinha := {}
	Local aItens := {}
	
	Private cCodPlano := ""
	// Query para buscar os Colaborador - Empresa 0003 -
	// Titulares
	BeginSql Alias cAliasTit
		
		
		SELECT
		TIT.RA_MAT,
		TIT.RA_NOME,
		TIT.RA_ADMISSA,
		CASE WHEN DEPFOL.RB_NOME <> 'NULL' THEN 'OK'
		ELSE
		'NOK'
			END SRB_OK,
	
		CASE WHEN DEPFOL.RB_NOME <> 'NULL' THEN DEPFOL.RB_COD
		ELSE
				(SELECT MAX(RB_COD) FROM %table:SRB% SRB
				WHERE
				RB_MAT = TIT.RA_MAT AND SRB.D_E_L_E_T_ = ' ' )
			END MAX_RB_COD,
			RB_CIC,
			RB_NOME,
			DEP.BA1_MATEMP,
			DEP.BA1_CODEMP,
			DEP.BA1_MATRIC,
			DEP.BA1_TIPREG,
			DEP.BA1_NOMUSR ,
			DEP.BA1_SEXO,
			DEP.GRAU_PARENTESCO,
			DEP.DESC_PARENTESCO,
			DEP.BA1_CPFUSR,
			DEP.BA1_DATNAS,
			DEP.RECBA1,
			DEP.BA1_GRAUPA,
			DEP.GRAUPA2,
			DEP.BA1_CODPLA,
			DEP.BA1_TIPUSU
			
			from (
			SELECT
			RA_MAT,
			RA_NOME,
			BA1_MATEMP,
			BA1_CODEMP,
			BA1_MATRIC,
			RA_ADMISSA,
			CASE
				WHEN BA1.BA1_CODPLA = '0072' THEN '071'
				WHEN BA1.BA1_CODPLA = '0071' THEN '072'
				WHEN BA1.BA1_CODPLA = '0042' THEN '006'
				WHEN BA1.BA1_CODPLA = '0008' THEN '071'
			END   BA1_CODPLA
			FROM %table:BA1% BA1,
			%table:SRA% SRA
			WHERE
			BA1_CODEMP   = '0003'
			AND BA1_CODPLA IN ('0071','0072','0042')
			AND BA1_DATBLO     = ' '
			AND BA1_TIPUSU     = 'T'
			AND BA1.D_E_L_E_T_ = ' '
			AND SRA.D_E_L_E_T_ = ' '
			AND SRA.RA_CIC     = BA1.BA1_CPFUSR
			AND SRA.RA_NASC    = BA1.BA1_DATNAS
			) TIT
			INNER JOIN
			(
			SELECT
			BA1.BA1_SEXO,  
			BA1.BA1_MATEMP,
			BA1.BA1_CODEMP,
			BA1.BA1_MATRIC,
			BA1.BA1_TIPREG,
			BA1.BA1_NOMUSR ,
			BA1.BA1_GRAUPA GRAU_PARENTESCO,
			BRP.BRP_DESCRI DESC_PARENTESCO,
			BA1.BA1_CPFUSR,
			BA1.BA1_DATNAS,
			BA1.BA1_TIPUSU,
			BA1.R_E_C_N_O_ RECBA1,
			CASE
				WHEN BA1_GRAUPA IN ('02','03','04') THEN 'C'
				WHEN BA1_GRAUPA IN ('06','05','12','13','24','25') THEN 'F'
				WHEN BA1_GRAUPA IN ('08','07') THEN 'P'
			ELSE 'O'
			END BA1_GRAUPA,
			CASE
				WHEN BA1_GRAUPA IN ('02','04') THEN '01'
				WHEN BA1_GRAUPA IN ('03') THEN '02'
				WHEN BA1_GRAUPA IN ('05','06') THEN '03'
				WHEN BA1_GRAUPA IN ('07','08') THEN '09'
			END GRAUPA2,
			CASE
				WHEN BA1.BA1_CODPLA = '0072' THEN '071'
				WHEN BA1.BA1_CODPLA = '0071' THEN '072'
				WHEN BA1.BA1_CODPLA = '0042' THEN '006'
				WHEN BA1.BA1_CODPLA = '0008' THEN '071'
			END   BA1_CODPLA
			FROM %table:BA1% BA1
			INNER JOIN %table:BRP% BRP ON
			BRP.BRP_CODIGO = BA1_GRAUPA
			WHERE
			BA1_CODEMP   = '0003'
			AND BA1_CODPLA IN ('0071','0072','0042')
			AND BA1_DATBLO     = ' '
			AND BA1_TIPUSU     = 'D'
			AND BA1.D_E_L_E_T_ = ' '
			AND BRP.D_E_L_E_T_ = ' '
			
			) DEP  ON
			DEP.BA1_MATRIC = TIT.BA1_MATRIC AND
			DEP.BA1_CODEMP = TIT.BA1_CODEMP
			LEFT JOIN
			(
			
			SELECT SRB.* FROM %table:SRB% SRB
			WHERE  D_E_L_E_T_ = ' ' ) DEPFOL ON
			DEPFOL.RB_MAT = TIT.RA_MAT
			AND SUBSTR(DEP.BA1_NOMUSR ,1,INSTR(DEP.BA1_NOMUSR , ' ',1,1)) LIKE '%'||SUBSTR(DEPFOL.RB_NOME,1,INSTR(DEPFOL.RB_NOME, ' ',1,1))
			AND RB_DTNASC = DEP.BA1_DATNAS
			
			ORDER BY TIT.RA_MAT,TIT.BA1_MATRIC,RB_COD,DEP.GRAU_PARENTESCO
			
			
	EndSql

// conta quantidade de registros retornados da query
dbEVal( bCount, nil, bWhile, nil,nil,nil  )


(cAliasTit)->(DbGoTop())
ProcRegua(nTotal)
DBSELECTAREA("SRA")

dO While (cAliasTit)->(!Eof())
	
	SRA->(dbgotop())
	SRA->(DbSetOrder(1))
	SRA->(DbSeek(xFilial("SRA")+(cAliasTit)->RA_MAT,.T.))
	
	//-------------------------------------
	// grava matricula DA EMPRESA na ba1
	//-------------------------------------
	BA1->(dbgotop())
	BA1->(dbgoto((cAliasTit)->RECBA1))
	RecLock("BA1",.F.)
		BA1->BA1_MATEMP := SRA->RA_MAT+IIF(ALLTRIM(UPPER(((cAliasTit)->SRB_OK)))=='OK',(cAliasTit)->MAX_RB_COD,MaxSRB((cAliasTit)->RA_MAT))
	BA1->(MsUnLock())
	//-----------------------------
	// grava titular na RHK
	//GrvRHK(SRA->RA_MAT,(cAliasTit)->BA1_CODPLA)
	//-----------------------------
	nCount++
	IncProc("Analisando Colaborador "+alltrim((cAliasTit)->RA_NOME)+" de "+cValToChar(nCount)+" até "+cValToChar(nTotal)+"." )
	cMaxCod := ''
	if ALLTRIM(UPPER((cAliasTit)->SRB_OK))=='NOK'
		
		aCabec   := {}
		aadd(aCabec,{"RA_FILIAL"  ,xFilial("SRA") ,Nil  })
		aadd(aCabec,{"RA_MAT"   ,(cAliasTit)->RA_MAT ,Nil  })
		
		aItens := {}
		lAlt := .F.
		
		// grava SRB - DE BENEFICIÁRIO QUE NÃO POSSUI VINCULO NA SRB
		if 	eMPTY(alltrim((cAliasTit)->BA1_CPFUSR))
			AAdd(aLog,{"'"+(cAliasTit)->RA_MAT," Dependente "+alltrim((cAliasTit)->BA1_NOMUSR)+" não está com o CPF informado no PLS." })
		endif
		
		
		aLinha := {}
		cMaxCod := MaxSRB((cAliasTit)->RA_MAT)
		aadd(aLinha,{'RB_FILIAL' 	,xFilial("SRB") 					, Nil })
		aadd(aLinha,{'RB_MAT' 		,(cAliasTit)->RA_MAT  				, Nil })
		aadd(aLinha,{'RB_COD'		, cMaxCod							, Nil })
		aadd(aLinha,{'RB_NOME' 		,ALLTRIM((cAliasTit)->BA1_NOMUSR)  	, Nil })
		aadd(aLinha,{'RB_DTNASC' 	,stod((cAliasTit)->BA1_DATNAS)		, Nil })
		aadd(aLinha,{'RB_SEXO' 		,(cAliasTit)->BA1_SEXO    			, Nil })
		aadd(aLinha,{'RB_GRAUPAR' 	,(cAliasTit)->BA1_GRAUPA	  		, Nil })
		aadd(aLinha,{'RB_TIPIR' 	,IIF((cAliasTit)->BA1_TIPUSU == 'D','2','4'	)	, Nil })
		/*	-- campo acima - verificar o que gravar
		- "1" para dep. I.R. sem limite de
		idade.
		- "2" para dep. I.R. até 21 anos idade.
		- "3" para dep. I.R. até 24 anos idade.
		- "4" quando não for dependente I.R.
		*/
		
		aadd(aLinha,{'RB_TIPSF' 	,'3'  								, Nil })
		/*HELP: RB_TIPSF  -- campo acima - verificar o que gravar
		Informe:
		- "1" dep. Sal.Familia sem limite
		idade.- "2" dep. Sal.Familia até 14 anos
		idade.
		- "3" quando não for dep. Sal.
		Familia.*/
		
		//aadd(aLinha,{'RB_LOCNASC' 	,'0'  							, Nil })
		aadd(aLinha,{'RB_CARTORI' 	,''  							, Nil })
		aadd(aLinha,{'RB_NREGCAR' 	,''  							, Nil })
		aadd(aLinha,{'RB_NUMLIVR' 	,''  							, Nil })
		aadd(aLinha,{'RB_NUMFOLH' 	,''  							, Nil })
		aadd(aLinha,{'RB_DTENTRA' 	,iif ( stod((cAliasTit)->BA1_DATNAS) < stod((cAliasTit)->RA_ADMISSA),stod((cAliasTit)->BA1_DATNAS), stod((cAliasTit)->RA_ADMISSA)), Nil })
		//aadd(aLinha,{'RB_DTBAIXA' 	,stod('')/*(cAliasDep)->BA1_DATNAS*/  		, Nil })
		aadd(aLinha,{'RB_TPDEPAM' 	,"1"			  				, Nil })
		aadd(aLinha,{'RB_TIPAMED' ,'1'					  			, Nil })
		//aadd(aLinha,{'RB_CODAMED' ,'' 		   					, Nil })
		//aadd(aLinha,{'RB_NUMAT' 	,'' 			 				, Nil })
		aadd(aLinha,{'RB_CIC' 		,(cAliasTit)->BA1_CPFUSR 		, Nil })
		aadd(aLinha,{'RB_VBDESAM' 	,""  							, Nil })
		aadd(aLinha,{'RB_DTINIAM' 	,STOD("") 					 	, Nil })
		aadd(aLinha,{'RB_DTFIMAM' 	,STOD("")  						, Nil })
		/*aadd(aLinha,{'RB_TPDPODO' 	,'' 							, Nil })
		aadd(aLinha,{'RB_TPASODO' 	,''							 	, Nil })
		aadd(aLinha,{'RB_ASODONT' 	,''								, Nil })
		aadd(aLinha,{'RB_VBDESAO' 	,'' 							, Nil })
		aadd(aLinha,{'RB_DTINIAO' 	,'' 							, Nil })
		aadd(aLinha,{'RB_DTFIMAO' 	,''							 	, Nil })*/
		//aadd(aLinha,{'RB_AUXCRE' 	,SRB->RB_AUXCRE 				, Nil })
		//aadd(aLinha,{'RB_VLRCRE' 	,0  							, Nil })
		aadd(aLinha,{'RB_TPDEP' 	,(cAliasTit)->GRAUPA2		  	, Nil })
		
		
		AAdd(aItens,aLinha)
		// GRAVA SRB
		if GravaDep(aCabec,aItens,lAlt)
			
			/*BA1->(dbgoto((cAliasDep)->RECBA1))
			RecLock("BA1",.F.)
			BA1->BA1_MATEMP := SRB->RB_MAT+SRB->RB_COD
			BA1->(MsUnLock())*/
			AAdd(aLog,{"'"+(cAliasTit)->RA_MAT , " Incluído Dependente "+alltrim((cAliasTit)->BA1_NOMUSR)+"." })
			
		endif
	
	Endif
	
		
		cCodPlano := (cAliasTit)->BA1_CODPLA
			
		GrvRHL((cAliasTit)->RA_MAT,IIF(empty(cMaxCod),(cAliasTit)->MAX_RB_COD,cMaxCod))
		
	//		aLog - Grava log
	(cAliasTit)->(DbSkip())
	
EndDo

if select(cAliasTit) > 0
	dbselectarea(cAliasTit)
	(cAliasTit)->(dbclosearea())
endif

RestArea(aArea)

Return Nil

// Grava Dependentes
Static Function GravaDep(aCab,aItens,lInc)
	
	Local aLog := {}
	Local lRet :=  .T.
	Local nY	:= 0 
	Local nX	:= 0
//	PRIVATE lMsErroAuto := .F.
//	Private lMsHelpAuto	:= .T.
//	Private lAutoErrNoFile := .T.
	
	Default lInc = .T.
	//-- Faz chamada a rotina de cadastro de dependentes  para incluir os dependentes (opcao 3)
	//MSExecAuto({|x,y,k,w| GPEA020(x,y,k,w)},nil,aCab,aItens,iif(lInc,4,3))
	RecLock("SRB",.T.)
	For nX := 1 to len(aItens)
		for nY := 1 to len(aItens[nX])
			&("SRB->"+aItens[nX][nY][1]) := aItens[nX][nY][2]
		Next nY
	Next nX
	SRB->(MsUnLock())
	
	//-- Opcao 3 - Inclui registro//-- Retorno de erro na execução da rotina
	//	If lMsErroAuto
	//		lRet := .F.
	//		AAdd(aLog,aCab[2][2][2], GetAutoGRLog() )
	//	endif
	
Return lRet

// Grava RHK
// Função para gravar os planos de saude do titular
User Function GrvRHK(/*cMat,cCodForn*/)
	
	Local aArea 	:= GetAreA()
	Local cAlias1 	:= GetNextAlias()
	Local lNew		:= .T.
	
	Local nTotal	:= 0
	Local nCount    := 0
	Local bWhile    := {|| (cAlias1)->(!Eof()) }
	Local bCount    := {|| nTotal++ }
	Local CCODEMP	:= "0003"
	
	
	cMesAno := GetMesAno()
	
	// Query para buscar os Colaborador - Empresa 0003 -
	// Titulares
	BeginSql Alias cAlias1
		
		SELECT
		RA_MAT,
		RA_NOME,
		RA_ADMISSA,
		BA1_CODINT,
		BA1_CODEMP,
		BA1_MATRIC,
		BA1_NOMUSR ,
		BA1_CPFUSR,
		BA1.BA1_DATNAS,
		BA1.R_E_C_N_O_ RECBA1,
	CASE
		WHEN BA1.BA1_CODPLA = '0072' THEN '071'
		WHEN BA1.BA1_CODPLA = '0071' THEN '072'
		WHEN BA1.BA1_CODPLA = '0042' THEN '006'
		WHEN BA1.BA1_CODPLA = '0008' THEN '071'
	END   BA1_CODPLA
	FROM %table:BA1% BA1,
	%table:SRA% SRA
	WHERE
	BA1_CODEMP   = %exp:cCodEmp%
	AND BA1_CODPLA IN ('0071','0072','0042')
	AND BA1_DATBLO     = ' '
	AND BA1_TIPUSU     = 'T'
	AND BA1.D_E_L_E_T_ = ' '
	AND SRA.D_E_L_E_T_ = ' '
	AND SRA.RA_CIC     = BA1.BA1_CPFUSR
	AND SRA.RA_NASC    = BA1.BA1_DATNAS
	ORDER BY RA_MAT
	
EndSql

// conta quantidade de registros retornados da query
dbEVal( bCount, nil, bWhile, nil,nil,nil  )


(cAlias1)->(DbGoTop())
ProcRegua(nTotal)
dbselectarea("SRA")
dbselectarea("SRB")

While (cAlias1)->(!Eof())
	
	nCount++
	IncProc("Analisando Colaborador "+alltrim((cAlias1)->BA1_NOMUSR)+" de "+cValToChar(nCount)+" até "+cValToChar(nTotal)+"." )
	
	//	SRA->(dbgotop())
	//	SRA->(DbSetOrder(1))
	//	SRA->(DbSeek(xFilial("SRA")+(cAlias1)->RA_MAT,.T.))
	
	RecLock("RHK",lNew)
	
	if(lNew)
		RHK->RHK_FILIAL 	:= xFilial("RHK")
		RHK->RHK_MAT		:= (cAlias1)->RA_MAT
		RHK->RHK_TPFORN		:= '1'//IIF(aPLAtivos[nI,4] == 'M','1','2') // ASSISTENCIA MEDICA
		RHK->RHK_CODFOR		:= (cAlias1)->BA1_CODPLA
	Else
		If(RHK->RHK_PERFIM < cMesAno)
			RHK->RHK_PERFIM := ""
		endIf
	endIf
	
	//RHK->RHK_PLANO	:= cCodPlano
	
	RHK->RHK_PD		:= '500'
	
	SRB->(dbgotop())
	SRB->(DbSetOrder(1))
	if SRB->(DbSeek(xFilial("SRB")+(cAlias1)->RA_MAT,.T.))
		RHK->RHK_PDDAGR	:= '501'
	endif
	
	RHK->RHK_PERINI	:= GetMesAno()
	RHK->RHK_TPPLAN	:= '2'
	
	RHK->(MsUnlock())
	
	(cAlias1)->(dbskip())
EndDo

RestArea(aArea)

Return


// Grava RHL
// Função para gravar os planos de saude do dependentes
Static Function GrvRHL(cMat,cCod)
	
	Local aArea := GetAreA()
	// Fazer um looping na BA1 para pegar os dependentes
	cCodForn := '001'
	
	//cCodPlano	:= GetPLACod(cCodForn + aPLAtivos[nI,6], aDePara)
	
	cChave := xFilial("RHL")
	cChave += cMat
	cChave += '1'
	cChave += cCodForn
	lNew := !(RHL->(dbSeek(cChave)))
	
	if(!lNew)
		lNew := .T.
		while ( RHL->(!Eof() .And. RHL_FILIAL+RHL_MAT+RHL_TPFORN+RHL_CODFOR == cChave))
			if(RHL->RHL_CODIGO == SRB->RB_COD)
				lNew := .F.
				Exit
			endIf
			RHL->(dbSkip())
		End
	endIf
	
	RecLock("RHL",lNew)
	
	if(lNew)
		RHL->RHL_FILIAL 	:= xFilial("RHL")
		RHL->RHL_MAT		:= cMat
		RHL->RHL_TPFORN		:= '1'//IIF(aPLAtivos[nI,4] == 'M','1','2')
		RHL->RHL_CODFOR		:= cCodForn
	EndIf
	
	RHL->RHL_CODIGO	:= cCod
	RHL->RHL_PLANO	:= cCodPlano
	RHL->RHL_PERINI	:= GetMesAno() 
	RHL->RHL_TPPLAN := '1' // Faixa Salarial
	
	RHL->(MsUnlock())
	
	cChave += SRA->RA_MAT
	cChave += '1'//IIF(aPLAtivos[nI,4] == 'M','1','2')
	cChave += cCodForn
	
	if((RHK->(dbSeek(cChave))))
		RecLock("RHK",.F.)
		RHK->RHK_PDDAGR := SRV->RV_COD
		RHK->(MsUnlock())
	endIf
	
	//-------------------------------------
	// grava matricula DA EMPRESA na ba1
	//-------------------------------------
	/*BA1->(dbgotop((cAliasDep)->RECBA1))
	RecLock("BA1",.F.)
	BA1->BA1_MATEMP := SRA->RA_MAT+cMaxCod
	BA1->(MsUnLock())*/
	
	RestArea(aArea)
	
Return

/*/{Protheus.doc} GetMesAno
Retorna o período no formato MMAAAA
@author PHILIPE.POMPEU
@since 01/04/2016
@version P11
@param cFolMes, caractere, expressão à ser invertida
@return cResult, periodo MMAAAA
/*/
Static Function GetMesAno(cFolMes)
	Local cResult := ""
	Local aPerAtual:={}
	Default cFolMes := ""
	
	fGetPerAtual( @aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetRotOrdinar() )
	If Empty(aPerAtual)
		fGetPerAtual( @aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetCalcRot('9') )
	EndIf
	
	If !(Empty(aPerAtual))
		cFolMes := AnoMes(aPerAtual[1,6])
	else
		cFolMes := AnoMes(Date())
	EndIf
	
	if(cFolMes == Nil)
		cFolMes := AnoMes(Date())
	endIf
	
	cResult := Right(cFolMes,2)
	cResult += Left(cFolMes,4)
Return cResult


Static Function MaxSRB(cMat)

Local cAliasSRB := GetNextAlias()
Local cMaxCod	:= ''
DEfault cMat := ''

BeginSQl Alias cAliasSRB
	SELECT MAX(RB_COD) RB_COD FROM %table:SRB% SRB
				WHERE
				RB_MAT = %exp:cMat% AND SRB.D_E_L_E_T_ = ' '
EndSql 		


if (cAliasSRB)->(!Eof())
	cMaxCod := Soma1((cAliasSRB)->RB_COD)
endif 

if (cAliasSRB)->(!Eof())
	(cAliasSRB)->(dbclosearea())
endif 

		
Return cMaxCod 