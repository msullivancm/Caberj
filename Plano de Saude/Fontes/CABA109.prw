#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

******************************************************************************************************************************************************

User Function caba109()
	
	Local aCores       := {}
	
	Private nUsado     := 0
	Private cCadastro  := "Data Liberação para o Site "
	Private cAlias1    := "ZUM"
	Private cAlias2    := "ZUL"
	Private cFilZUM    := ""
	Private cFilZUL    := ""
	Private aRotina    := {}
	Private aPos       := {15, 1, 70, 315}
	Private oCliente   := Nil
	Private oTotal     := Nil
	Private cCliente   := ""
	Private nTotal     := 0
	
	Private aObjects 	:= {}
	Private aSizeAut 	:= MsAdvSize(.T.)//Vai usar Enchoice
	
	lAjustHor	:= .T.
	lAjustVert	:= .T.
	
	aAdd( aObjects, { 100,  60, lAjustHor, lAjustVert, .T. } )
	aAdd( aObjects, { 100,  40, lAjustHor, lAjustVert, .T. } )
	
	nSepHoriz 	:= 5
	nSepVert	:= 5
	nSepBorHor 	:= 5
	nSepBorVert	:= 5
	
	aInfo  		:= { aSizeAut[1], aSizeAut[2], aSizeAut[3], aSizeAut[4], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
	aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )
	
	aAdd( aRotina ,{"Pesquisar" ,"AxPesqui"    ,0,1})
	aAdd( aRotina ,{"Visualizar",'u_Mod3Visual',0,2})
	aAdd( aRotina ,{"Incluir"   ,'u_Mod3Inclui',0,3})
	aAdd( aRotina ,{"Alterar"   ,'u_Mod3Altera',0,4})
	aAdd( aRotina ,{"Excluir"   ,'u_Mod3Exclui',0,5})
	
	If Empty(Posicione("SX3",1,cAlias1,"X3_ARQUIVO"))
		Help("",1,"","NOX3X2IX","NÃO É POSSÍVEL EXECUTAR, FALTA"+CRLF+"X3, X2, IX E X7",1,0)
		RETURN
	Endif
	
	dbSelectArea('ZUL')
	dbSetOrder(1)
	cfilzul := xFilial('ZUL')
	
	dbSelectArea('ZUM')
	dbSetOrder(1)
	cFilZUM := xFilial('ZUM')
	
	mBrowse(,,,,'ZUM')
	
Return .T.

******************************************************************************************************************************************************

User Function Mod3Visual( cAlias, nRecNo, nOpc )
	
	Local nX        := 0
	Local nCols     := 0
	Local nOpcA     := 0
	Local oDlg      := Nil
	Local oGet      := Nil
	Local oMainWnd  := Nil
	
	Local aSizeAut		:= MsAdvSize() 	//Angelo Henrique - Data: 12/09/2019
	Local aInfo 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosObj 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosInc		:= {}
	
	Private aTela   := {}
	Private aGets   := {}
	Private aHeader := {}
	Private aCols   := {}
	Private bCampo  := { |nField| Field(nField) }
	
	cCliente := ""
	nTotal := 0
	
	//+----------------------------------
	//| Inicia as variaveis para Enchoice
	//+----------------------------------
	dbSelectArea('ZUM')
	dbSetOrder(1)
	dbGoTo(nRecNo)
	For nX:= 1 To FCount()
		M->&(Eval(bCampo,nX)) := FieldGet(nX)
	Next nX
	
	//+----------------
	//| Monta o aHeader
	//+----------------
	CriaHeader()
	
	//+--------------
	//| Monta o aCols
	//+--------------
	dbSelectArea('ZUL')
	dbSetOrder(2)//ZUL_FILIAL+ZUL_CODEMP+ZUL_ANO+ZUL_MES+ZUL_CODVEN
	dbSeek(ZUM_FILIAL + ZUM_CODEMP + ZUM_ANO + ZUM_MES )
	
	While !Eof() .and. ( ZUL->( ZUL_FILIAL + ZUL_CODEMP + ZUL_ANO + ZUL_MES ) == ZUM->( ZUM_FILIAL + ZUM_CODEMP + ZUM_ANO + ZUM_MES ))
		aAdd(aCols,Array(nUsado+1))
		nCols ++
		// nTotal += SZ2->Z2_VALOR
		
		For nX := 1 To nUsado
			
			If aHeader[nX][2]	== 'ZUL_DESEMP'
				aCols[nCols][nX] := If(Empty(ZUL_CODEMP),"",Posicione("BG9",1,xFilial("BG9") + PLSINTPAD() + ZUL_CODEMP,"BG9_DESCRI"))
			ElseIf aHeader[nX][2]	== 'ZUL_NOMVEN'
				aCols[nCols][nX] := If(Empty(ZUL_CODVEN),"",Posicione("SA3",1,xFilial("SA3")+ZUL_CODVEN,"A3_NOME"))
			ElseIf ( aHeader[nX][10] != "V")
				aCols[nCols][nX] := FieldGet(FieldPos(aHeader[nX][2]))
			Else
				aCols[nCols][nX] := CriaVar(aHeader[nX][2],.T.)
			Endif
			
		Next nX
		
		aCols[nCols][nUsado+1] := .F.
		dbSelectArea(cAlias2)
		dbSkip()
	End
	
	//---------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM 8,0 TO 28,80 OF oMainWnd
	//---------------------------------------------------------------------------------------------------------------
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSizeAut[7], 00 To aSizeAut[6], aSizeAut[5] OF oMainWnd PIXEL
	
	aPosInc  := {aSizeAut[2], 1, 130, aSizeAut[3]}
	
	EnChoice( cAlias, nRecNo, nOpc, , , , , aPosInc, , 3)
		
	//----------------------------------------------
	//Inicio - Angelo Henrique - Data: 13/09/2019
	//----------------------------------------------
	aObjects := {}
	AAdd( aObjects, { 315,  30, .T., .T. } )
	AAdd( aObjects, { 100,  70, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
		
	oGet := MsGetDados():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][3],aPosObj[2][4],nOpc,.T./*[ cLinhaOk]*/,.T./*[ cTudoOk]*/,,,,,,99/*[ nMax]*/)				
	//---------------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------		
	
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpcA:=1,Iif(oGet:TudoOk(),oDlg:End(),nOpcA := 0)},{||oDlg:End()})
	
Return .T.

******************************************************************************************************************************************************

User Function Mod3Inclui( cAlias, nRecNo, nOpc )
	
	Local nOpcA      	:= 0
	Local nX         	:= 0
	Local oDlg       	:= Nil
	
	Local aSizeAut		:= MsAdvSize() 	//Angelo Henrique - Data: 12/09/2019
	Local aInfo 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosObj 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosInc		:= {}
	
	Private aTela    	:= {}
	Private aGets    	:= {}
	Private aHeader  	:= {}
	Private aCols    	:= {}
	Private bCampo   	:= {|nField| FieldName(nField) }
	
	cCliente := ""
	nTotal := 0
	
	//+--------------------------------------
	//| Cria Variaveis de Memoria da Enchoice
	//+--------------------------------------
	dbSelectArea(cAlias1)
	For nX := 1 To FCount()
		M->&(Eval(bCampo,nX)) := CriaVar(FieldName(nX),.T.)
	Next nX
	
	//+----------------
	//| Monta o aHeader
	//+----------------
	CriaHeader()
	
	//+--------------
	//| Monta o aCols
	//+--------------
	aAdd(aCols,Array(nUsado+1))
	nUsado := 0
	
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias2)
	
	While !Eof() .And. SX3->X3_ARQUIVO == cAlias2
		If X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL
			nUsado++
			aCols[1][nUsado] := CriaVar(Trim(SX3->X3_CAMPO),.T.)
		Endif
		dbSkip()
	End
	
	//---------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM 8,0 TO 28,80 OF oMainWnd
	//---------------------------------------------------------------------------------------------------------------
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSizeAut[7], 00 To aSizeAut[6], aSizeAut[5] OF oMainWnd PIXEL
	
	aPosInc  := {aSizeAut[2], 1, 130, aSizeAut[3]}
	
	EnChoice( cAlias, nRecNo, nOpc, , , , , aPosInc, , 3)
		
	//----------------------------------------------
	//Inicio - Angelo Henrique - Data: 13/09/2019
	//----------------------------------------------
	aObjects := {}
	AAdd( aObjects, { 315,  30, .T., .T. } )
	AAdd( aObjects, { 100,  70, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	//oGet := MsGetDados():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][4],aPosObj[2][3],nOpc,"u_Mod3LinOk()","u_Mod3TudOk()")			
	oGet := MsGetDados():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][3],aPosObj[2][4],nOpc,"u_Mod3LinOk()","u_Mod3TudOk()")
	//---------------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------
	
	aButtons := {}
	aAdd(aButtons,{"TK_VERTIT",{||aColComiss(M->ZUM_CODEMP,M->ZUM_ANO,M->ZUM_MES)},"Busca vendedor","Busca vendedor"})
	
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA:=1,If(u_Mod3Tudok().And.Obrigatorio(aGets,aTela),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()},.F.,aButtons)
	
	If nOpcA == 1
		Begin Transaction
			If Mod3Grava(1)
				EvalTrigger()
				If __lSX8
					ConfirmSX8()
				Endif
			EndIf
		End Transaction
	Else
		If __lSX8
			RollBackSX8()
		Endif
	Endif
	
Return .T.

******************************************************************************************************************************************************

User Function Mod3Altera( cAlias, nRecNo, nOpc )
	
	Local nOpcA      := 0
	Local nX         := 0
	Local nCols      := 0
	Local oDlg       := Nil
	
	Local aSizeAut		:= MsAdvSize() 	//Angelo Henrique - Data: 12/09/2019
	Local aInfo 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosObj 		:= {} 			//Angelo Henrique - Data: 12/09/2019
	Local aPosInc		:= {}
	
	Private aTela    := {}
	Private aGets    := {}
	Private aHeader  := {}
	Private aCols    := {}
	Private aAltera  := {}
	Private bCampo   := {|nField| FieldName(nField) }
	
	cCliente := ""
	nTotal := 0
	
	//+----------------------------------
	//| Inicia as variaveis para Enchoice
	//+----------------------------------
	dbSelectArea('ZUM')
	dbSetOrder(1)
	dbGoTo(nRecNo)
	For nX := 1 To FCount()
		M->&(Eval(bCampo,nX)) := FieldGet(nX)
	Next nX
	
	//+----------------
	//| Monta o aHeader
	//+----------------
	CriaHeader()
	
	//+--------------
	//| Monta o aCols
	//+--------------
	
	dbSelectArea('ZUL')
	dbSetOrder(2)//ZUL_FILIAL+ZUL_CODEMP+ZUL_ANO+ZUL_MES+ZUL_CODVEN
	ZUL->(dbSeek(ZUM_FILIAL + ZUM_CODEMP + ZUM_ANO + ZUM_MES ))
	
	While !ZUL->(Eof()) .and. ( ZUL->( ZUL_FILIAL + ZUL_CODEMP + ZUL_ANO + ZUL_MES ) == ZUM->( ZUM_FILIAL + ZUM_CODEMP + ZUM_ANO + ZUM_MES ))
		
		aAdd(aCols,Array(nUsado+1))
		nCols ++
		
		For nX := 1 To nUsado
			
			If aHeader[nX][2]	== 'ZUL_DESEMP'
				aCols[nCols][nX] := u_cGetDesBG9(xFilial("BG9") + PLSINTPAD() + ZUL->ZUL_CODEMP)
			ElseIf aHeader[nX][2]	== 'ZUL_NOMVEN'
				aCols[nCols][nX] := u_cGetDesSA3(xFilial("SA3") + ZUL->ZUL_CODVEN)
			ElseIf aHeader[nX][2]	== 'ZUL_ANO'
				aCols[nCols][nX] := ZUL->ZUL_ANO
			ElseIf aHeader[nX][2]	== 'ZUL_MES'
				aCols[nCols][nX] := ZUL->ZUL_MES
			ElseIf ( aHeader[nX][10] != "V")
				aCols[nCols][nX] := FieldGet(FieldPos(aHeader[nX][2]))
			Else
				aCols[nCols][nX] := CriaVar(aHeader[nX][2],.T.)
			Endif
			
		Next nX
		
		aCols[nCols][nUsado+1] := .F.
		dbSelectArea(cAlias2)
		aAdd(aAltera,Recno())
		ZUL->(dbSkip())
	End									
	
	//---------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM 8,0 TO 28,80 OF oMainWnd
	//---------------------------------------------------------------------------------------------------------------
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSizeAut[7], 00 To aSizeAut[6], aSizeAut[5] OF oMainWnd PIXEL
	
	aPosInc  := {aSizeAut[2], 1, 130, aSizeAut[3]}
	
	EnChoice( cAlias, nRecNo, nOpc, , , , , aPosInc, , 3)
	
	//----------------------------------------------
	//Inicio - Angelo Henrique - Data: 13/09/2019
	//----------------------------------------------
	aObjects := {}
	AAdd( aObjects, { 315,  30, .T., .T. } )
	AAdd( aObjects, { 100,  70, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	//oGet := MSGetDados():New(75,2,130,315,nOpc,"u_Mod3LinOk()","u_Mod3TudOk()","+Z2_ITEM",.T.)				
	oGet := MSGetDados():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][3],aPosObj[2][4],nOpc,"u_Mod3LinOk()","u_Mod3TudOk()","+Z2_ITEM",.T.)	
	//---------------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 13/09/2019
	//---------------------------------------------------------------------------------------------------------------
		
	aButtons := {}
	aAdd(aButtons,{"TK_VERTIT",{||aColComiss(M->ZUM_CODEMP,M->ZUM_ANO,M->ZUM_MES)},"Busca vendedor","Busca vendedor"})
	
	ACTIVATE MSDIALOG oDlg ON INIT Eval({||EnchoiceBar(oDlg,{|| nOpca:=1,If(u_Mod3Tudok().And.Obrigatorio(aGets,aTela),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()},.F.,aButtons)})
	
	If nOpcA == 1
		Begin Transaction
			If Mod3Grava(2,aAltera)
				EvalTrigger()
				If __lSX8
					ConfirmSX8()
				Endif
			EndIf
		End Transaction
	Else
		If __lSX8
			RollBackSX8()
		Endif
	Endif
Return

******************************************************************************************************************************************************

User Function Mod3Exclui( cAlias, nRecNo, nOpc )
	
	Local lExclui 	:= MsgYesNo('Confirma a exclusão?',AllTrim(SM0->M0_NOMECOM))
	Local cChave	:= ''
	
	If lExclui
		
		BEGIN TRANSACTION
			
			ZUM->(DbGoTo(nRecNo))
			cChave := ZUM->(xFilial('ZUL') + ZUM_CODEMP + ZUM_ANO + ZUM_MES)
			RecLock('ZUM',.F.)
			ZUM->(DbDelete())
			MsUnlock()
			
			ZUL->(DbSetOrder(2))//ZUL_FILIAL+ZUL_CODEMP+ZUL_ANO+ZUL_MES+ZUL_CODVEN
			ZUL->(DbSeek(cChave))
			
			While !ZUL->(EOF()) .and. ( ZUL->(ZUL_FILIAL+ZUL_CODEMP+ZUL_ANO+ZUL_MES) == cChave )
				RecLock('ZUL',.F.)
				ZUL->(DbDelete())
				MsUnlock()
				ZUL->(DbSkip())
			EndDo
			
		END TRANSACTION
		
	EndIf
	
Return .T.

******************************************************************************************************************************************************

Static Function CriaHeader()
	nUsado  := 0
	aHeader := {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias2)
	While ( !Eof() .And. SX3->X3_ARQUIVO == cAlias2 )
		If ( X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL )
			aAdd(aHeader,{ Trim(X3Titulo()), ;
				SX3->X3_CAMPO   , ;
				SX3->X3_PICTURE , ;
				SX3->X3_TAMANHO , ;
				SX3->X3_DECIMAL , ;
				SX3->X3_VALID   , ;
				SX3->X3_USADO   , ;
				SX3->X3_TIPO    , ;
				SX3->X3_ARQUIVO , ;
				SX3->X3_CONTEXT } )
			nUsado++
		Endif
		dbSkip()
	End
	
Return

******************************************************************************************************************************************************

User Function Mod3AtuCli()
	
	cCliente := ""
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	
	If dbSeek( xFilial("SA1")+M->Z1_CLIENTE+M->Z1_LOJA )
		cCliente := Trim(SA1->A1_NREDUZ)
	Endif
	
	oCliente:Refresh()
	
Return .T.

******************************************************************************************************************************************************

User Function Mod3LinOk()
	Local lRet      := .T.
	Local i         := 0
	Local nP_QtdVen := 0
	Local nP_PrcVen := 0
	
Return( lRet )

******************************************************************************************************************************************************

User Function Mod3TudOk()
	
	Local lRet       := .T.
	/*
	Local nP_CODEMP := ' '
	Local nP_ANO    := ' '
	Local nP_CODVEN := ' '
	Local nP_MES    := ' '
	Local nP_DATLIB := ' '
	
	
	Local cMsg       := ""
	
	nP_CODEMP  := aScan(aHeader,{|x| Trim(x[2])=="ZUL_CODEMP"})
	nP_ANO     := aScan(aHeader,{|x| Trim(x[2])=="ZUL_ANO" })
	nP_CODVEN  := aScan(aHeader,{|x| Trim(x[2])=="ZUL_CODVEN" })
	nP_MES     := aScan(aHeader,{|x| Trim(x[2])=="ZUL_MES" })
	nP_DATLIB  := aScan(aHeader,{|x| Trim(x[2])=="ZUL_DATLIB" })
	
	For i := 1 To Len(aCols)
		
		If aCols[i][nUsado+1] .or. Empty(aCols[i][1])
			Loop
		Endif
		
		cCODEMP   := aCols[i][nP_CODEMP]
		cANO      := aCols[i][nP_ANO ]
		cCODVEN   := aCols[i][nP_CODVEN]
		cMES      := aCols[i][nP_MES ]
		dDATLIB   := aCols[i][nP_DATLIB]
		
		If Empty(cCODEMP)
			cMsg := "Campo codigo da Empresa  preenchimento obrigatorio"
			lRet := .F.
		Endif
		
		If Empty(cANO) .And. lRet
			cMsg := "Campo Ano preenchimento obrigatorio"
			lRet := .F.
		Endif
		
		If !lRet
			MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
			Exit
		Endif
		
	Next i
	*/
Return( lRet )

******************************************************************************************************************************************************

Static Function Mod3Grava(nOpc,aAltera)
	
	Local lGravou  := .F.
	Local nUsado   := 0
	Local nSeq     := 1
	Local nX       := 0
	Local nI       := 0
	Private bCampo := { |nField| FieldName(nField) }
	
	nUsado := Len(aHeader) + 1
	
	//+----------------
	//| Se for inclusao
	//+----------------
	If nOpc == 1
		//+--------------------------
		//| Colocar os itens em ordem
		//+--------------------------
		aSort(aCols,,,{|x,y| x[1] < y[2] })
		
		//+---------------
		//| Grava os itens
		//+---------------
		dbSelectArea('ZUL')
		dbSetOrder(1)
		For nX := 1 To Len(aCols)
			If !Empty(aCols[nX][1]) .or. !aCols[nX][nUsado]
				RecLock(cAlias2,.T.)
				For nI := 1 To Len(aHeader)
					FieldPut(FieldPos(Trim(aHeader[nI,2])),aCols[nX,nI])
				Next nI
				
				MsUnLock()
				nSeq ++
				lGravou := .T.
			Endif
		Next nX
		
		//+------------------
		//| Grava o Cabecalho
		//+------------------
		dbSelectArea('ZUM')
		RecLock(cAlias1,.T.)
		For nX := 1 To FCount()
			If "FILIAL" $ FieldName(nX)
				FieldPut(nX,cFilZUM)
			Else
				FieldPut(nX,M->&(Eval(bCampo,nX)))
			Endif
		Next nX
		MsUnLock()
	Endif
	
	//+-----------------
	//| Se for alteracao
	//+-----------------
	If nOpc == 2
		//+--------------------------------------
		//| Grava os itens conforme as alteracoes
		//+--------------------------------------
		dbSelectArea(cAlias2)
		dbSetOrder(1)
		For nX := 1 To Len(aCols)
			If nX <= Len(aAltera)
				dbGoto(aAltera[nX])
				RecLock(cAlias2,.F.)
				If aCols[nX][nUsado]
					dbDelete()
					Mod3X2Del(cAlias2)
				EndIf
			Else
				If !aCols[nX][nUsado]
					RecLock(cAlias2,.T.)
				Endif
			Endif
			
			If !aCols[nX][nUsado]
				For nI := 1 To Len(aHeader)
					FieldPut(FieldPos(Trim(aHeader[nI,2])),aCols[nX,nI])
				Next nI
				/*         SZ2->Z2_FILIAL := cFilZUL
				SZ2->Z2_NUM    := M->Z1_NUM
				SZ2->Z2_ITEM   := StrZero(nSeq,2) */
				MsUnLock()
				nSeq ++
				lGravou := .T.
			EndIf
		Next nX
		
		//+----------------------------------------------------
		//| Aqui eu reordeno a sequencia gravada fora de ordem.
		//+----------------------------------------------------
		/*   If lGravou
		nSeq := 1
		dbSelectArea(cAlias2)
		dbSetOrder(1)
		dbSeek(cFilZUL+M->Z1_NUM,.F.)
		While !Eof() .And. cFilZUL == SZ1->Z1_FILIAL .And. SZ2->Z2_NUM == M->Z1_NUM
			RecLock(cAlias2,.F.)
			SZ2->Z2_ITEM := StrZero(nSeq,2)
			MsUnLock()
			nSeq++
			lGravou := .T.
			dbSkip()
		End
	EndIf
	*/
	//+------------------
	//| Grava o Cabecalho
	//+------------------
	If lGravou
		dbSelectArea(cAlias1)
		RecLock(cAlias1,.F.)
		For nX := 1 To FCount()
			If "FILIAL" $ FieldName(nX)
				FieldPut(nX,cFilZUM)
			Else
				FieldPut(nX,M->&(Eval(bCampo,nX)))
			Endif
		Next
		MsUnLock()
	Else
		dbSelectArea(cAlias1)
		RecLock(cAlias1,.F.)
		dbDelete()
		MsUnLock()
		Mod3X2Del(cAlias1)
	Endif
Endif

//+----------------
//| Se for exclucao
//+----------------
If nOpc == 3
	//+----------------
	//| Deleta os Itens
	//+----------------
	dbSelectArea(cAlias2)
	dbSetOrder(1)
	dbSeek(M->(ZUL_FILIAL+ ZUL_CODEMP+ZUL_CODVEN+ZUL_ANO+ZUL_MES) )
	While !Eof() .And. ZUL->ZUL_FILIAL ==ZUM->ZUM_FILIAL .and. ZUL->ZUL_CODEMP == ZUM->ZUM_CODEMP .and. ZUL->ZUL_ANO == ZUM->ZUM_ANO .and. ZUL->ZUL_MES == ZUM->ZUM_MES
		/*
		dbSelectArea(cAlias2)
		dbSetOrder(1)
		dbSeek(cFilZUL+M->Z1_NUM,.T.)
		While !Eof() .And. cFilZUL == SZ1->Z1_FILIAL .And. SZ2->Z2_NUM == M->Z1_NUM*/
			RecLock(cAlias2)
			dbDelete()
			MsUnLock()
			dbSkip()
			Mod3X2Del(cAlias2)
		End
		
		//+-------------------
		//| Deleta o Cabecalho
		//+-------------------
		dbSelectArea(cAlias1)
		RecLock(cAlias1)
		dbDelete()
		MsUnLock()
		Mod3X2Del(cAlias1)
		lGravou := .T.
	EndIf
	
Return( lGravou )

******************************************************************************************************************************************************

Static Function Mod3X2Del(cFilSX2)
	Local aArea := GetArea()
	dbSelectArea("SX2")
	dbSetOrder(1)
	If dbSeek(cFilSX2)
		RecLock("SX2",.F.)
		SX2->X2_DELET := SX2->X2_DELET + 1
		MsUnLock()
	Endif
	RestArea( aArea )
Return

***************************************************************************************************************************************************************

User Function AtuZUL
	
	Local nI 		:= 0
	Local nJ		:= 0
	Local cVarBusc 	:= ''
	Local uContVar
	Local aZUM		:= {'ZUM_CODEMP','ZUM_DESEMP','ZUM_ANO','ZUM_MES'}
	Local nPosHead	:= 0
	Local lRet		:= .T.
	
	If INCLUI .or. ALTERA
		
		Do Case
			
		Case AllTrim(ReadVar()) == 'M->ZUM_MES'
			If Empty(M->ZUM_MES)
				MsgStop('Informe o mês!',AllTrim(SM0->M0_NOMECOM))
				lRet := .F.
			ElseIf !( PadL(AllTrim(M->ZUM_MES),2,'0') $ '01|02|03|04|05|06|07|08|09|10|11|12' )
				MsgStop('O mês informado [ ' + AllTrim(M->ZUM_MES) + ' ] é inválido!',AllTrim(SM0->M0_NOMECOM))
				lRet := .F.
			Else
				M->ZUM_MES := PadL(AllTrim(M->ZUM_MES),2,'0')
			EndIf
			
		Case AllTrim(ReadVar()) == 'M->ZUM_ANO'
			If Empty(M->ZUM_ANO)
				MsgStop('Informe o ano!',AllTrim(SM0->M0_NOMECOM))
				lRet := .F.
			ElseIf Val(M->ZUM_ANO) < ( Year(Date()) - 1 )
				MsgStop('O ano informado [ ' + AllTrim(M->ZUM_ANO) + ' ] não pode ser menor que [ ' + cValToChar( Year(Date()) - 1 ) + ' ]!',AllTrim(SM0->M0_NOMECOM))
				lRet := .F.
			ElseIf Val(M->ZUM_ANO) > ( Year(Date()) + 1 )
				MsgStop('O ano informado [ ' + AllTrim(M->ZUM_ANO) + ' ] não pode ser maior que [ ' + cValToChar( Year(Date())+ 1 ) + ' ]!',AllTrim(SM0->M0_NOMECOM))
				lRet := .F.
			EndIf
			
		EndCase
		
		If lRet
			
			//Variaveis que devem se corresponder entre ZUM e ZUL
			For nI := 1 to Len(aZUM)
				
				cVarBusc 	:= 'M->' + aZUM[nI]
				
				If aZUM[nI] == 'ZUM_DESEMP'
					uContVar	:= If(Empty(M->ZUM_CODEMP),"",Posicione("BG9",1,xFilial("BG9") + PLSINTPAD() + M->ZUM_CODEMP,"BG9_DESCRI"))
				Else
					uContVar	:= &cVarBusc
				EndIf
				
				For nJ := 1 to Len(aCols)
					
					cVarBusc			:= Replace(aZUM[nI],'ZUM','ZUL')
					nPosHead			:= aScan(aHeader,{|x|AllTrim(x[2]) == AllTrim(cVarBusc)})
					
					If nPosHead > 0
						aCols[nJ][nPosHead] := uContVar
					EndIf
				Next
			Next
			
			For nJ := 1 to Len(aCols)
				
				//Variaveis somente ZUL
				
				nPosHead	:= aScan(aHeader,{|x|AllTrim(x[2]) == 'ZUL_NOMVEN'})
				
				If nPosHead > 0
					uContVar	:= If((Type('M->ZUL_CODVEN')=='U') .or. Empty(M->ZUL_CODVEN),"",Posicione("SA3",1,xFilial("SA3")+M->ZUL_CODVEN,"A3_NOME"))
					aCols[nJ][nPosHead] := uContVar
				EndIf
				
			Next
			
		EndIf
		
		GetDRefresh()
		
	EndIf
	
Return lRet

***************************************************************************************************************************************************************

User Function lValVen(c_CodVen,c_CodEmp,c_Ano,c_Mes)
	
	Local lRet 		:= .T.
	Local aArea		:= GetArea()
	Local aAreaSA3	:= SA3->(GetArea())
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	
	lRet := ExistCpo('SA3',c_CodVen,1)
	
	If lRet
		
		cQry := "SELECT DISTINCT BXQ_CODVEN" 					+ CRLF
		cQry += "FROM " + RetSqlName("BXQ")   					+ CRLF
		cQry += "WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "'" 	+ CRLF
		cQry += "	AND BXQ_CODEMP = '" + c_CodEmp + "'" 		+ CRLF
		cQry += "	AND BXQ_CODVEN = '" + c_CodVen + "'" 		+ CRLF
		cQry += "	AND BXQ_ANO = '" + c_Ano + "'" 				+ CRLF
		cQry += "	AND BXQ_MES = '" + c_Mes + "'" 				+ CRLF
		cQry += "	AND D_E_L_E_T_ = ' '" 						+ CRLF
		
		TcQuery cQry New Alias cAlias
		
		lRet := !cAlias->(EOF())
		
		cAlias->(DbCloseArea())
		
		If !lRet
			MsgStop('Vendedor [ ' + Posicione("SA3",1,xFilial("SA3") + c_CodVen,"A3_NOME") + ' ] não pertence a empresa [ ' + c_CodEmp + ' ]!',AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	EndIf
	
	SA3->(RestArea(aAreaSA3))
	RestArea(aArea)
	
Return lRet

***************************************************************************************************************************************************************

User Function lValEmp(c_CodEmp,c_Ano,c_Mes)
	
	Local lRet 		:= .T.
	Local aArea		:= GetArea()
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	
	If !empty(c_CodEmp) .and. !empty(c_Ano) .and. !empty(c_Mes)
		
		cQry := "SELECT COUNT(ZUM_CODEMP) QTD" 					+ CRLF
		cQry += "FROM " + RetSqlName("ZUM")   					+ CRLF
		cQry += "WHERE ZUM_FILIAL = '" + xFilial('ZUM') + "'" 	+ CRLF
		cQry += "	AND ZUM_CODEMP = '" + c_CodEmp + "'" 		+ CRLF
		cQry += "	AND ZUM_ANO = '" + c_Ano + "'" 				+ CRLF
		cQry += "	AND ZUM_MES = '" + c_Mes + "'" 				+ CRLF
		cQry += "	AND D_E_L_E_T_ = ' '" 						+ CRLF
		cQry += "GROUP BY ZUM_CODEMP,ZUM_ANO,ZUM_MES" 			+ CRLF
		
		TcQuery cQry New Alias cAlias
		
		lRet := ( cAlias->(QTD) == 0 )
		
		cAlias->(DbCloseArea())
		
		If !lRet
			MsgStop('Já existe lançamento de faturamento para a empresa [ ' + c_CodEmp + ' ] ' + CRLF + 'no período [ ' + c_Mes + '/' + c_Ano + ' ]!',AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	EndIf
	
	RestArea(aArea)
	
Return lRet

***************************************************************************************************************************************************************

Static Function aColComiss(c_CodEmp,c_Ano,c_Mes)
	
	Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aColRet	:= {}
	Local aArea		:= GetArea()
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	Local lComisFat	:= MsgYesNo('Incluir somente comissões faturadas?' + CRLF + '(Títulos a pagar do vendedor emitido)',AllTrim(SM0->M0_NOMECOM))
	Local aZUL		:= {'ZUL_CODEMP','ZUL_DESEMP','ZUL_ANO','ZUL_MES','ZUL_CODVEN','ZUL_NOMVEN','ZUL_DATLIB'}
	
	cQry := "SELECT DISTINCT BXQ_CODEMP,BXQ_ANO,BXQ_MES,BXQ_CODVEN"		+ CRLF
	cQry += "FROM " + RetSqlName("BXQ")   				   				+ CRLF
	cQry += "WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "'" 				+ CRLF
	cQry += "	AND BXQ_CODEMP = '" + c_CodEmp + "'" 	 				+ CRLF
	cQry += "	AND BXQ_ANO = '" + c_Ano + "'" 			 				+ CRLF
	cQry += "	AND BXQ_MES = '" + c_Mes + "'" 			 				+ CRLF
	
	If lComisFat
		cQry += "	AND BXQ_E2NUM <> ' '"		 		 				+ CRLF
	EndIf
	
	cQry += "	AND D_E_L_E_T_ = ' '" 						  			+ CRLF
	cQry += "ORDER BY BXQ_CODEMP,BXQ_ANO,BXQ_MES,BXQ_CODVEN" 			+ CRLF
	
	TcQuery cQry New Alias cAlias
	
	If cAlias->(EOF())
		MsgStop('Não existe movimento de comissão ' + If(lComisFat,'faturado ','') + ' para a empresa [ ' + c_CodEmp + ' ] ' + CRLF + ' no período [ ' + c_Mes + '/' + c_Ano + ' ]!',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
	nCont := 0
	
	While !cAlias->(EOF())
		
		nCont++
		
		If Len(aCols) < nCont
			aAdd(aCols,Array(nUsado+1))
			aCols[nCont][nUsado+1] := .F.
		EndIf
		
		For nI := 1 to Len(aZUL)
			
			cVarBusc 	:= 'cAlias->' + Replace(aZUL[nI],'ZUL','BXQ')
			
			nPosHead:= aScan(aHeader,{|x|AllTrim(x[2]) == AllTrim(aZUL[nI])})
			
			If nPosHead <= 0
				Loop
			EndIf
			
			Do Case
				
			Case aZUL[nI] == 'ZUL_DESEMP'
				uContVar	:= If(Empty(cAlias->BXQ_CODEMP),"",Posicione("BG9",1,xFilial("BG9") + PLSINTPAD() + cAlias->BXQ_CODEMP,"BG9_DESCRI"))
				
			Case aZUL[nI] == 'ZUL_NOMVEN'
				uContVar	:= If(Empty(cAlias->BXQ_CODVEN),"",Posicione("SA3",1,xFilial("SA3")+cAlias->BXQ_CODVEN,"A3_NOME"))
				
			Case aZUL[nI] == 'ZUL_DATLIB'
				If empty(aCols[nCont][nPosHead])
					uContVar	:= StoD('')
				Else
					Loop
				EndIf
				
			Otherwise
				uContVar	:= &cVarBusc
				
			EndCase
			
			aCols[nCont][nPosHead] := uContVar
			
		Next
		
		cAlias->(DbSkip())
		
	EndDo
	
	cAlias->(DbCloseArea())
	
	RestArea(aArea)
	
	GetDRefresh()
	
Return aColRet

*********************************************************************************************************************************************

User Function cGetDesBG9(cBusc)
	
	Local cRet 		:= ''
	Local aArea		:= GetArea()
	Local aAreaBG9	:= BG9->(GetArea())
	
	BG9->(DbSetOrder(1))
	
	If !empty(cBusc) .and. BG9->(MsSeek(cBusc))
		cRet := BG9->BG9_DESCRI
	EndIf
	
	BG9->(RestArea(aAreaBG9))
	RestArea(aArea)
	
Return cRet

/*********************************************************************************************************************************************/

User Function cGetDesSA3(cBusc)
	
	Local cRet 		:= ''
	Local aArea		:= GetArea()
	Local aAreaSA3	:= SA3->(GetArea())
	
	SA3->(DbSetOrder(1))
	
	If !empty(cBusc) .and. SA3->(MsSeek(cBusc))
		cRet := SA3->A3_NOME
	EndIf
	
	SA3->(RestArea(aAreaSA3))
	RestArea(aArea)
	
Return cRet