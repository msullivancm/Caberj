#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"


#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571   บAutor  ณAngelo Henrique     บ Data ณ  03/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de Solicita็ใo de Exames e Procedimentos.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Private cCadastro 	:= "Solicita็ใo de Exames e Procedimentos"
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta um aRotina proprio                                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Private aCores := {}
	Private aRotina 	:= {{"Pesquisar"  	,"AxPesqui"		,0,1} ,;
		{"Visualizar" 						,"U_CABA571A"	,0,2} ,;
		{"Incluir"	  							,"U_CABA571A"	,0,3} ,;
		{"Alterar"	  							,"U_CABA571A"	,0,4} ,;
		{"Legenda"	  							,"U_CABA571G"	,0,4} ,;
		{"Excluir"	  							,"U_CABA571A"	,0,5} }
	
	Private cDelFunc 	:= ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
	
	Private cString 	:= "ZRS"
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//Legenda																		  ณ
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	Private aCdCores	:= {{"BR_VERDE","Solicita็ใo Nใo Atendida"  },;
		{"BR_VERMELHO","Solicita็ใo Atendida"},;
		{"BR_AMARELO" ,"Solicita็ใo Parcialmente Atendida"},;
		{"BR_CINZA" 	,"Solicita็ใo Expirada"}}
	
	Private aCores	:= {{"u_CABA571H('1')", aCdCores[1,1]},;
		{"u_CABA571H('2')"	, aCdCores[2,1]},;
		{"u_CABA571H('3')"	, aCdCores[3,1]},;
		{"u_CABA571H('4')"	, aCdCores[4,1]}}
	
	dbSelectArea("ZRS")
	dbSetOrder(1)
	mBrowse( 6,1,22,75,"ZRS",,,,,Nil,aCores)
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571A  บAutor  ณAngelo Henrique     บ Data ณ  06/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo que monta a tela a ser exibida para o usuแrio.       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571A(cAlias, nReg, nOpc)
	
	Local aArea     	:= GetArea()
	Local oDlg
	Local nUsado    	:= 0
	Local nCntFor   	:= 0
	Local nOpcA     	:= 0
	Local lContinua 	:= .T.
	Local cQuery    	:= ""
	Local aObjects  	:= {}
	Local aPosObj   	:= {}
	Local aSizeAut  	:= MsAdvSize()
	Local lNopc1    	:= .F.
	Local lNopc2    	:= .F.
	Local cSeq			:= "001"
	Local nPosSeq		:= 0
	Local nPosCont	:= 0
	
	Local aAlter     	:= {}
	Local nOpcx      	:= GD_INSERT+GD_DELETE+GD_UPDATE
	Local cLinOk     	:= "U_CABA571E()"	/*"U_LinOk"*/// Funcao executada para validar o contexto da linha atual do aCols
	Local cTudoOk    	:= "AllWaysTrue"    // Funcao executada para validar o contexto geral da MsNewGetDados (todo aCols)
	Local cIniCpos   	:= "++ZRT_SEQ"        // Nome dos campos do tipo caracter que utilizarao incremento automatico.
	Local nFreeze    	:= 000              // Campos estaticos na GetDados.
	Local nMax       	:= 999              // Numero maximo de linhas permitidas. Valor padrao 99
	Local cFieldOk   	:= "AllwaysTrue"    // Funcao executada na validacao do campo
	Local cSuperDel  	:= ""              	// Funcao executada quando pressionada as teclas <Ctrl>+<Delete>
	Local cDelOk     	:= "AllwaysTrue"   	// Funcao executada para validar a exclusao de uma linha do aCols
	
	Local aBotoes		:= {}
	
	PRIVATE aHEADER 	:= {}
	PRIVATE aCOLS   	:= {}
	PRIVATE aGETS   	:= {}
	PRIVATE aTELA   	:= {}
	
	Private oGetDad
	
	*----------------------------------------------------------------
	*|   Montagem de Variaveis de Memoria                            |
	*----------------------------------------------------------------
	Do case
	Case nOpc = 2
		lNopc1 :=.F.
		lNopc2 :=.F.
	Case nOpc = 3
		lNopc1 :=.T.
		lNopc2 :=.F.
	Case nOpc = 4
		lNopc1 :=.F.
		lNopc2 :=.F.
	Case nOpc = 5
		lNopc1 :=.F.
		lNopc2 :=.F.
	EndCase
	
	RegToMemory( "ZRS", lNopc1, lNopc2 )
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta o aHeader                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	aHeader := {}
	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("ZRT",.T.)
	
	nUsado := 0
	
	Do While ( !SX3->(Eof()) .And. SX3->X3_ARQUIVO == "ZRT" )
		If ( X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL )
			If !(ALLTRIM(SX3->X3_CAMPO) $ "ZRT_FILIAL")
				AADD(aHeader,{ AllTrim(X3Titulo()),;
					SX3->X3_CAMPO,;
					SX3->X3_PICTURE,;
					SX3->X3_TAMANHO,;
					SX3->X3_DECIMAL,;
					SX3->X3_VALID,;
					SX3->X3_USADO,;
					SX3->X3_TIPO,;
					SX3->X3_F3,;
					SX3->X3_CONTEXT,;
					SX3->X3_CBOX,;
					SX3->X3_RELACAO,;
					SX3->X3_WHEN,;
					SX3->X3_VISUAL,;
					SX3->X3_VLDUSER,;
					SX3->X3_PICTVAR,;
					SX3->X3_OBRIGAT})
				nUsado++
			Endif
		Endif
		dbSkip()
	EndDo
	
	*----------------------------------------------------------------+
	*   Montagem do aCols                                            |
	*----------------------------------------------------------------+
	
	dbSelectArea("ZRT")
	dbSetOrder(1)
	
	If nOpc # 3
		
		BeginSql alias "ZRTTMP"
			
			%noparser%
			SELECT *
			FROM %table:ZRT% ZRT
			WHERE 	ZRT_FILIAL = %xFilial:ZRT%  AND
			ZRT_SOLICI = %exp:ZRS->ZRS_SOLICI% AND
			%notDel%
			ORDER BY %Order:ZRT%
			
		EndSql
		
		While (!ZRTTMP->(Eof()))
			aadd(aCOLS,Array(nUsado+1))
			For nCntFor := 1 To nUsado
				If ( aHeader[nCntFor][10] != "V" )
					aCols[Len(aCols)][nCntFor] := FieldGet(FieldPos(aHeader[nCntFor][2]))
				Else
					aCols[Len(aCols)][nCntFor] := CriaVar(aHeader[nCntFor][2])
				EndIf
			Next nCntFor
			aCOLS[Len(aCols)][Len(aHeader)+1] := .F.
			ZRTTMP->(dbSkip())
		EndDo
		
		If select("ZRTTMP")>0
			dbSelectArea("ZRTTMP")
			dbCloseArea()
		EndIf
		
	Endif
	
	dbSelectArea(cAlias)
	
	aObjects := {}
	AAdd( aObjects, { 315,  30, .T., .T. } )
	AAdd( aObjects, { 100,  70, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	DBSELECTAREA(cAlias)
	DBGOTO(nReg)
	
	
	DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7],00 To aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL
	EnChoice( cAlias,nReg, nOpc, , , , , aPosObj[1], , 3 )
	
	oGetDad:= MsNewGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcx,cLinOk,cTudoOk,cIniCpos,;
		/*aAlter*/,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oDlg,aHeader,aCols)
	
	//Menu que irแ aparece no botใo A็๕es Relacionadas
	aadd(aBotoes,{"NG_ICO_LEGENDA", {||CABA571Y()},"Replicar Procedimento","Replicar Procedimento"})
	
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. U_CABA571F(), (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() },,aBotoes)
	
	If  nOpca = 1
		
		CABA571B(cAlias,nReg,nOpc)
		
	EndIf
	RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571B  บAutor  ณAngelo Henrique     บ Data ณ  06/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta as operacoes de exlusao, visualizacao, inclusao     บฑฑ
ฑฑบ          ณou  alteracao	de acordo c/ o nopcx                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA571B(cAlias,nReg,nOpcx)
	
	
	Local aHeader 	:= aClone(oGetDad:aHeader)
	Local aCols		:= aClone(oGetDad:aCols)
	Local i,j			:= 0
	Local nPosSeq		:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZRT_SEQ"	})
	
	//-----------------------
	// Exclusao
	//-----------------------
	If nopcx = 5
		
		DbSelectArea("ZRS")
		DbSetOrder(1)
		Reclock("ZRS",.F.)
		DbDelete()
		MsUnlock()
		
		DbSelectArea("ZRT")
		DbSetOrder(2)
		If DbSeek(xFilial("ZRT")+M->ZRS_SOLICI)
			While !ZRT->(Eof()) .And. ZRT->ZRT_FILIAL+ZRT->ZRT_SOLICI = xFilial("ZRS")+M->ZRS_SOLICI
				
				Reclock("ZRT",.F.)
				DbDelete()
				MsUnlock()
				ZRT->(DbSkip())
				
			EndDo
			
		EndIf
		
		//---------------------------------
		// Inclusใo / Altera็ใo
		//---------------------------------
	ElseIf nOpcx = 3 .OR. nOpcx = 4
		
		
		//------------------------------------------------------------------
		//Gravando / Alterando Cabe็alho
		//------------------------------------------------------------------
		DbSelectArea("ZRS")
		DbSetOrder(1)
		lFound := DbSeek(xFilial("ZRS")+M->ZRS_SOLICI)
		
		Reclock("ZRS",!lFound)
		
		DbSelectArea("SX3")
		DbSetOrder(1)
		DbSeek("ZRS")
		While SX3->X3_ARQUIVO = "ZRS" .and. !Eof()
			
			If X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL
				DbSelectArea("ZRS")
				FieldPut(FieldPos(SX3->X3_CAMPO),&("M->"+SX3->X3_CAMPO))
			Endif
			
			DbSelectArea("SX3")
			DbSkip()
			
		EndDo
		
		DbSelectArea("ZRS")
		ZRS->ZRS_FILIAL 	:= xFilial("ZRS")
		
		If Empty(ZRS->ZRS_USUARI)
			
			ZRS->ZRS_USUARI 	:= Substr(cUsuario,7,6)
			ZRS->ZRS_DATINC 	:= DDATABASE
			ZRS->ZRS_HORINC 	:= TIME()
			
		EndIf
		
		MsUnlock()
		
		For i:=1 to Len(aCols)
			
			If !aCols[i][Len(aHeader)+1]
				
				DbSelectArea("ZRT")
				DbSetOrder(1)
				lFound := DbSeek(xFilial("ZRT")+aCols[i,nPosSeq]+M->ZRS_SOLICI)
				
				Reclock("ZRT", !lFound)
				
				For j:=1 to Len(aHeader)
					FieldPut(FieldPos(AHeader[j,2]),Acols[i,j])
				Next
				
				ZRT->ZRT_FILIAL 	:= xFilial("ZRT")
				ZRT->ZRT_SOLICI	:= M->ZRS_SOLICI
				ZRT->ZRT_MATRIC	:= M->ZRS_MATRIC
				ZRT->ZRT_NUMCR	:= M->ZRS_NUMCR				
				
				MsUnlock()
				
			Else
				
				DbSelectArea("ZRT")
				DbSetOrder(1)
				If DbSeek(xFilial("ZRT")+aCols[i,nPosSeq]+M->ZRS_SOLICI)
					
					Reclock("ZRT", .F.)
					DbDelete()
					MsUnlock()
					
				EndIf
				
			EndIf
			
		Next
		
	Endif
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571C  บAutor  ณAngelo Henrique     บ Data ณ  03/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para incrementar a numera็ใo              บฑฑ
ฑฑบ          ณ Rotina GETSX8NUM nใo estava respeitando no momento da      บฑฑ
ฑฑบ          ณ inclusใo quando fechava a tela e nใo confirmava.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571C
	
	Local _aArea 		:= GetArea()
	Local _cQuery 	:= ""
	Local cAliQry1	:= GetNextAlias()
	Local _cRet		:= ""
	
	_cQuery := " SELECT MAX(ZRS_SOLICI) ZRS_SOLICI "
	_cQuery += " FROM " + RetSqlName("ZRS")+ " ZRS "
	_cQuery += " WHERE ZRS_FILIAL = '" + xFilial("ZRS") + "' "
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	If !((cAliQry1)->(Eof()))
		
		_cRet := SOMA1((cAliQry1)->ZRS_SOLICI)
		
	Else
		
		_cRet := STRZERO(1,TAMSX3("ZRS_SOLICI")[1])
		
	EndIf
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571D  บAutor  ณAngelo Henrique     บ Data ณ  03/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina quer sera utilizada para o gatilho de descri็ใo.    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571D
	
	Local _aArea 		:= GetArea()
	Local _aAreBR8	:= BR8->(GetArea())
	Local _cQuery 	:= ""
	Local _cRet		:= ""
	Local _cTab		:= GDFIELDGET("ZRT_TABELA",n)
	Local _cCdP		:= GDFIELDGET("ZRT_CODPRO",n)
	
	If !Empty(AllTrim(_cCdP))
		
		DbSelectArea("BR8")
		DbSetOrder(1) //BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
		If DbSeek(xFilial("BR8")+_cTab+_cCdP)
			
			_cRet := BR8->BR8_DESCRI
			
		EndIf
		
	EndIf
	
	RestArea(_aAreBR8)
	RestArea(_aArea)
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571E  บAutor  ณAngelo Henrique     บ Data ณ  14/09/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para validar as linhas da Tela.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA571E
	
	Local _aArea := GetArea()
	Local aHeader 	:= aClone(oGetDad:aHeader)
	Local aCols		:= aClone(oGetDad:aCols)
	Local nPosHead	:= 0
	Local lRet			:= .T.
	Local aHeadZRT	:= {}
	
	*'----------------------------------------------------------------------------------------------------'*
	*'Inicio - Valida็ใo para nใo deixar descer a linha se algum campo obrigat๓rio nใo estiver preenchido.'*
	*'----------------------------------------------------------------------------------------------------'*
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbGoTop())
	SX3->(DbSeek("ZRT"))
	
	While !SX3->(Eof( )) .And. SX3->X3_ARQUIVO == "ZRT"
		
		If SX3->X3_CAMPO # 'ZRT_FILIAL'
			aAdd(aHeadZRT,{SX3->X3_CAMPO})
		EndIf
		
		SX3->(dBSkip())
	EndDo
	
	
	For nI := 1 To Len(aCols)
		
		For nJ := 1 To Len(aHeadZRT)
			
			aAreaZ2	:= GetArea()
			
			DbSelectArea("SX3")
			SX3->(DbSetOrder(2))
			SX3->(DbSeek(aHeadZRT[nJ][1]))
			
			nPosHead	:= GDFIELDPOS(aHeadZRT[nJ][1])
			
			If !aCols[nI][Len(aHeader)+1]
				
				If X3OBRIGAT(aHeadZRT[nJ][1]) .And. Empty(aCols[nI,nPosHead])
					
					Aviso( "Aten็ใo", "O Campo " + AllTrim(SX3->X3_TITULO) + " ้ obrigat๓rio, favor preenche-lo. ", { "Ok" } )
					lRet := .F.
					
					Exit
					
				EndIf
				
			EndIf
			
			If !lRet
				Exit
			EndIf
			
			RestArea(aAreaZ2)
			
		Next nJ
		
		If !lRet
			Exit
		EndIf
		
	Next nI
	*'----------------------------------------------------------------------------------------------------'*
	*'Fim    - Valida็ใo para nใo deixar descer a linha se algum campo obrigat๓rio nใo estiver preenchido.'*
	*'----------------------------------------------------------------------------------------------------'*
	
	RestArea(_aArea)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571F  บAutor  ณAngelo Henrique     บ Data ณ  14/09/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para validar as linhas da Tela ao clicar  บฑฑ
ฑฑบ          ณno botใo OK                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA571F
	
	Local _aArea 		:= GetArea()
	Local aHeader 	:= aClone(oGetDad:aHeader)
	Local aCols		:= aClone(oGetDad:aCols)
	Local nPosHead	:= 0
	Local lRet			:= .T.
	Local aHeadZRT	:= {}
	
	*'----------------------------------------------------------------------------------------------------'*
	*'Inicio - Valida็ใo para nใo deixar descer a linha se algum campo obrigat๓rio nใo estiver preenchido.'*
	*'----------------------------------------------------------------------------------------------------'*
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbGoTop())
	SX3->(DbSeek("ZRT"))
	
	While !SX3->(Eof( )) .And. SX3->X3_ARQUIVO == "ZRT"
		
		If SX3->X3_CAMPO # 'ZRT_FILIAL'
			aAdd(aHeadZRT,{SX3->X3_CAMPO})
		EndIf
		
		SX3->(dBSkip())
	EndDo
	
	
	For nI := 1 To Len(aCols)
		
		For nJ := 1 To Len(aHeadZRT)
			
			aAreaZ2	:= GetArea()
			
			DbSelectArea("SX3")
			SX3->(DbSetOrder(2))
			SX3->(DbSeek(aHeadZRT[nJ][1]))
			
			nPosHead	:= GDFIELDPOS(aHeadZRT[nJ][1])
			
			If !aCols[nI][Len(aHeader)+1]
				
				If X3OBRIGAT(aHeadZRT[nJ][1]) .And. Empty(aCols[nI,nPosHead])
					
					Aviso( "Aten็ใo", "O Campo " + AllTrim(SX3->X3_TITULO) + " ้ obrigat๓rio, favor preenche-lo. ", { "Ok" } )
					lRet := .F.
					
					Exit
					
				EndIf
				
			EndIf
			
			If !lRet
				Exit
			EndIf
			
			RestArea(aAreaZ2)
			
		Next nJ
		
		If !lRet
			Exit
		EndIf
		
	Next nI
	*'----------------------------------------------------------------------------------------------------'*
	*'Fim    - Valida็ใo para nใo deixar descer a linha se algum campo obrigat๓rio nใo estiver preenchido.'*
	*'----------------------------------------------------------------------------------------------------'*
	
RestArea(_aArea)

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571G  บAutor  ณAngelo Henrique     บ Data ณ  30/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para visualizar a legenda.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571G
	
	Local aCores  := {}
	
	AAdd(aCores, {"BR_VERDE"		,"Solicita็ใo Nใo Atendida" 			})
	AAdd(aCores, {"BR_VERMELHO"	,"Solicita็ใo Atendida"					})
	AAdd(aCores, {"BR_AMARELO" 	,"Solicita็ใo Parcialmente Atendida"	})
	AAdd(aCores, {"BR_CINZA" 	,"Solicita็ใo Expirada"					})
	
	BrwLegenda("Status da Solicita็ใo","Legenda",aCores)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571H  บAutor  ณAngelo Henrique     บ Data ณ  30/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para validar as situa็๕es da legenda.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571H(_cParam)
	
	Local _lRet 		:= .F.
	
	Private _nVlDias	:= GetMv("MV_XVLDIAS") //Parametro que contem a validade dos processos
	
	Default _cParam 	:= 1
	
	//---------------------------------------------------
	//Inicio das valida็๕es para a legenda
	//---------------------------------------------------
	//"BR_VERDE"		,"Solicita็ใo Nใo Atendida"
	//"BR_VERMELHO"	,"Solicita็ใo Atendida"
	//"BR_AMARELO" 	,"Solicita็ใo Parcialmente Atendida"
	//"BR_CINZA"		,"Solicita็ใo Expirada"
	//---------------------------------------------------
	
	If _cParam == "1"
		
		If dDataBase - ZRS->ZRS_DATSOL < _nVlDias .And. u_CABA571I() == "N"
			
			_lRet := .T.
			
		EndIf
		
	ElseIf _cParam == "2"
		
		If u_CABA571I() == "S"
			
			_lRet := .T.
			
		EndIf
		
	ElseIf _cParam == "3"
		
		If dDataBase - ZRS->ZRS_DATSOL < _nVlDias .And. u_CABA571I() == "P"
			
			_lRet := .T.
			
		EndIf
		
	ElseIf _cParam == "4"
		
		If dDataBase - ZRS->ZRS_DATSOL > _nVlDias .And. u_CABA571I() == "N"
			
			_lRet := .T.
			
		EndIf
		
	EndIf
	
Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571I  บAutor  ณAngelo Henrique     บ Data ณ  30/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para validar as situa็๕es da legenda.     บฑฑ
ฑฑบ          ณnos itens das procedimentos                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA571I
	
	Local _aArea 		:= GetArea()
	Local _aArZRS		:= ZRS->(GetArea())
	Local _aArZRT		:= ZRT->(GetArea())
	Local _cRet		:= ""
	Local _nAtend 	:= 0 //Contador para processo atendido
	Local _nNotAtd 	:= 0 //Contador para processo nใo atendido
	
	DbSelectArea("ZRT")
	DbSetOrder(2) //ZRT_FILIAL+ZRT_SOLICI+ZRT_TABELA
	DbSeek(xFilial("ZRT")+ZRS->ZRS_SOLICI)
	
	While !EOF() .And. ZRS->ZRS_SOLICI == ZRT->ZRT_SOLICI
		
		If ZRT->ZRT_ATEND == "S" //Atendido
			
			_nAtend ++
			
		ElseIf ZRT->ZRT_ATEND == "N" //Nใo Atendido
			
			_nNotAtd ++
			
		EndIf
		
		ZRT->(DbSkip())
		
	EndDo
	
	If _nAtend > 0 .And. _nNotAtd > 0
		
		_cRet := "P"
		
	ElseIf _nAtend > 0
		
		_cRet := "S"
		
	ElseIf _nNotAtd > 0
		
		_cRet := "N"
		
	EndIf
	
	RestArea(_aArZRT)
	RestArea(_aArZRS)
	RestArea(_aArea)
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571J  บAutor  ณAngelo Henrique     บ Data ณ  26/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada como gatilho para preenchimento do campo  บฑฑ
ฑฑบ          ณZRT_CODPRO, quando o mesmo nใo ้ preenchido pela consulta.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA571J(_cParam)
	
	Local _aArea  	:= GetArea()
	Local _nPosTab	:= Ascan(aHeader,{|x| x[2] == "ZRT_TABELA"})
	Local _nPosCod	:= Ascan(aHeader,{|x| x[2] == "ZRT_CODPRO"})
	Local _nPosDsp	:= Ascan(aHeader,{|x| x[2] == "ZRT_DESPRO"})
	Local _lRet		:= .T.
	Local _cCodPsa	:= ""
	Local _Retorno	:= ""
	
	Default _cParam	:= ""
		
	_cCodPsa := aCols[n][_nPosCod]
			
	If !Empty(AllTrim(_cCodPsa))
		
		DbSelectArea("BR8")
		DbSetOrder(1)
		If DbSeek(xFilial("BR8")+aCols[n][_nPosTab]+_cCodPsa)
			
			aCols[n][_nPosDsp] := BR8->BR8_DESCRI
			
		Else
			
			Aviso("Aten็ใo", "Codigo nใo cadastrado", {"OK"})
			_lRet := .F.
			
		EndIf
		
		If _cParam == "1"
			
			_Retorno := _lRet
			
		Else
			
			_Retorno := aCols[n][_nPosDsp]
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return _Retorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571K  บAutor  ณAngelo Henrique     บ Data ณ  28/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada como consulta padrใo Profissional de saudeบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA571K()
	
	Local _aArea 			:= GetArea()
	Local _aArBB0			:= BB0->(GetArea())
	Local _aArZZF			:= ZZF->(GetArea())
	Local lRet 			:= .T.
	
	Local oButton1		:= Nil
	Local oButton2		:= Nil
	Local cAlias1 		:= GetNextAlias()
	Local aItens			:= {"1 - Nome","2 - Codigo", "3 - Est. CR + Num. CR + Sigla CR"}
	Local cCombo			:= aItens[1]
	Local oGet1			:= Nil
	
	Private oOK   		:= LoadBitmap(GetResources(),"BR_VERDE")
	Private oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO")
	Private oListBox1		:= Nil
	Private aDadosBB0 	:= {}
	Private cGet1			:= SPACE(20)
	
	Static _oDlg2			:= Nil
	
	Public _cCrmRet	:= ""
	Public _cNomRet	:= ""
	
	cQuery := " SELECT BB0.BB0_CODIGO CODIGO, BB0.BB0_NOME NOME, " + c_ent
	cQuery += " TRIM(BB0.BB0_ESTADO)||'-'||TRIM(BB0.BB0_NUMCR)||'-'||TRIM(BB0.BB0_CODSIG) NUMCR, " + c_ent
	cQuery += " BB0.BB0_ESTADO ESTADO, BB0.BB0_DATBLO DATBLO " + c_ent
	cQuery += " FROM " + RetSqlName("BB0") + " BB0, " + RetSqlName("ZZF") + " ZZF " + c_ent
	cQuery += " WHERE BB0.D_E_L_E_T_ = ' ' " + c_ent
	cQuery += " AND ZZF.D_E_L_E_T_ = ' ' " + c_ent
	cQuery += " AND BB0.BB0_FILIAL = '" + xFilial("BB0") + "' " + c_ent
	cQuery += " AND ZZF.ZZF_FILIAL = '" + xFilial("ZZF") + "' " + c_ent
	cQuery += " AND BB0.BB0_CODIGO = ZZF.ZZF_CODIGO " + c_ent
	cQuery += " AND BB0.BB0_FILIAL = ZZF.ZZF_FILIAL " + c_ent
	cQuery += " AND ZZF.ZZF_TIPO <> '2' " + c_ent
	cQuery += " AND BB0.BB0_DATBLO = ' ' " + c_ent
	cQuery += " AND ZZF.ZZF_DATBLO = ' ' " + c_ent
	
	DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)
	
	(cAlias1)->(DbGoTop())
	
	*'-------------------------------------------------'*
	*'Valida็ใo para saber se a query possui resultados'*
	*'-------------------------------------------------'*
	If (cAlias1)->(Eof())
		
		Aviso( "Aten็ใo", "Nใo existem dados a consultar", {"Ok"} )
		
		lRet := .F.
		
	Else
		
		Do While (cAlias1)->(!Eof())
			
			aAdd( aDadosBB0, { IIF(Empty((cAlias1)->DATBLO),.T., .F.),(cAlias1)->CODIGO, (cAlias1)->NOME, (cAlias1)->NUMCR, (cAlias1)->ESTADO} )
			
			(cAlias1)->(DbSkip())
			
		Enddo
		
		DbCloseArea(cAlias1)
		
		
		DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de Profissionais de Sa๚de" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL
		
		oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABA571K_1(cCombo)},,,,.T.,,,,,,,,,'cCombo')
		
		@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABA571K_2(cCombo,cGet1)  OF _oDlg2 PIXEL
		
		@ 030, 004 LISTBOX oListBox1 FIELDS HEADER " ", "C๓digo", "Nome", "Est. CR + Num. CR + Sigla CR", "Estado" SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL
		
		@ 185, 004 BUTTON oButton1 PROMPT "Ok" 		SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABA571K_3(), _oDlg2:End(),.F.)) PIXEL
		@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()) PIXEL
		
		//--------------------------------------------------------------------
		//Ordenando primeiro por nome, pois ้ a primeira posi็ใo do combobox
		//--------------------------------------------------------------------
		ASORT(aDadosBB0,,, { |x, y| x[3] < y[3] } )
		
		oListBox1:SetArray(aDadosBB0)
		
		oListBox1:bLine := {|| {IIF(aDadosBB0[oListBox1:nAT,01],oOK,oNo),aDadosBB0[oListBox1:nAT,02],aDadosBB0[oListBox1:nAT,03],aDadosBB0[oListBox1:nAT,04],aDadosBB0[oListBox1:nAT,05]}}
		
		oListBox1:blDblClick := {||IIF(CABA571K_3(), _oDlg2:End(),.F.)}
		
		ACTIVATE MSDIALOG _oDlg2 CENTERED
		
	EndIf
	
	RestArea(_aArZZF)
	RestArea(_aArBB0)
	RestArea(_aArea)
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571_K บAutor  ณAngelo Henrique     บ Data ณ  29/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para ordenar o vetor da pesquisa.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA571K_1(_cParam)
	
	Default _cParam := ""
	
	If SUBSTR(_cParam,1,1) == "1" //Nome
		
		ASORT(aDadosBB0,,, { |x, y| x[3] < y[3] } )
		
	ElseIf SUBSTR(_cParam,1,1) == "2" //Codigo
		
		ASORT(aDadosBB0,,, {|x, y| x[2] < y[2]})
		
	ElseIf SUBSTR(_cParam,1,1) == "3" //Est. CR + Num. CR + Sigla CR
		
		ASORT(aDadosBB0,,, { |x,y|, x[4] < y[4] } )
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	oListBox1:SetArray(aDadosBB0)
	oListBox1:bLine := {|| {IIF(aDadosBB0[oListBox1:nAT,01],oOK,oNo),aDadosBB0[oListBox1:nAT,02],aDadosBB0[oListBox1:nAT,03],aDadosBB0[oListBox1:nAT,04],aDadosBB0[oListBox1:nAT,05]}}
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return aDadosBB0

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571_K2บAutor  ณAngelo Henrique     บ Data ณ  29/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para ordenar o vetor da pesquisa conforme บฑฑ
ฑฑบ          ณpreenchido no GET                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA571K_2(_cParam1,_cParam2)
	
	Default _cParam1 := "" //Op็ใo selecionada no combo
	Default _cParam2 := "" //Caracteres digitados no MSGET
	
	If SUBSTR(_cParam1,1,1) == "1" //Nome
		
		ASORT(aDadosBB0,,, {|x, y| x[3] = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "2" //Codigo
		
		ASORT(aDadosBB0,,, {|x, y| x[2] = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "3" //Est. CR + Num. CR + Sigla CR
		
		ASORT(aDadosBB0,,, { |x,y|, x[4] = UPPER(AllTrim(_cParam2))})
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	oListBox1:SetArray(aDadosBB0)
	oListBox1:bLine := {|| {IIF(aDadosBB0[oListBox1:nAT,01],oOK,oNo),aDadosBB0[oListBox1:nAT,02],aDadosBB0[oListBox1:nAT,03],aDadosBB0[oListBox1:nAT,04],aDadosBB0[oListBox1:nAT,05]}}
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return aDadosBB0

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571_K3บAutor  ณAngelo Henrique     บ Data ณ  29/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para pegar a linha selecionada ap๓s a     บฑฑ
ฑฑบ          ณpesquisa da consulta padrใo.                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA571K_3()
	
	Local _lRet		:= .T.
	
	Public _cCrmRet	:= ""
	Public _cNomRet	:= ""
	
	DbSelectArea("BB0")
	DbSetOrder(1)
	If DbSeek(xFilial("BB0")+aDadosBB0[oListBox1:nAT][2])
		
		If !Empty(BB0->BB0_DATBLO)
			
			_lRet := .F.
			Aviso("Aten็ใo", "Profissional nใo pode ser utilizado, pois encontra-se bloqueado.",{"OK"})
			
		Else
			
			_cCrmRet	:= BB0->BB0_NUMCR
			_cNomRet	:= BB0->BB0_NOME
			
		EndIf
		
	Else
		
		_lRet := .F.
		Aviso("Aten็ใo", "Profissional nใo localizado.",{"OK"})
		
	EndIf
	
Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA571_Y บAutor  ณAngelo Henrique     บ Data ณ  27/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para replicar a linha digitada no acols   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA571Y()
	
	Local _aArea 		:= GetArea()
	Local _nOpc 		:= 0
	Local _no			:= 1
	Local _aCols 		:= aClone(oGetDad:aCols[oGetDad:nAt])	
	Local _aVtNw		:= {}
	Local _nSeq		:= 0
	Local _no			:= 0
	Local _nx			:= 0
	Local _nk			:= 0
	
	Private _oDlg		:= Nil
	Private oGtMat	:= Nil
	Private cReplic	:= SPACE(3)
	Private _oBtn		:= Nil
	Private _oSay		:= Nil
	Private _oGroup	:= Nil
	Private _oBtn		:= Nil
	Private oFont		:= Nil	
	
	DEFINE MSDIALOG _oDlg FROM 0,0 TO 110,500 PIXEL TITLE 'Replicar Procedimentos'
	
	_oGroup:= tGroup():New(10,10,50,230,'Favor digitar a quantidade de vezes em que o procedimento serแ replciado',_oDlg,,,.T.)
	
	@ 25, 16  MSGET oGtMat VAR cReplic SIZE 70,10 OF _oGroup PIXEL PICTURE "@R 999"
	
	_oBtn := TButton():New( 27,100,"Replicar"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},040,012,,,,.T.,,"",,,,.F. )
	_oBtn := TButton():New( 27,170,"Fechar"	,_oDlg,{||_oDlg:End()				},040,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg CENTERED
	
	If _nOpc = 1
		
		For _nx := 1 To Len(oGetDad:aCols)	
			
			If _nSeq < Val(oGetDad:aCols[_nx][1])
			
				_nSeq := Val(oGetDad:aCols[_nx][1]) 								
				
			EndIf			
		
		Next _nx
		
		For _no := 1 To Val(cReplic)						
																		
			_nSeq++
			
			//-----------------------------------------------------------------------------
			//Infleizmente teve que ficar com as posi็๕es fechadas, pois ao realizar
			//um aClone do vetor original para trabalhar, o protheus estava se 
			//comportando de forma incorreta e alimentando posi็๕es nใo 
			//mencionadas
			//-----------------------------------------------------------------------------
			aAdd(oGetDad:aCols,{STRZERO(_nSeq, TAMSX3("ZRT_SEQ")[1]),;
				oGetDad:aCols[oGetDad:nAt,2],;
				oGetDad:aCols[oGetDad:nAt,3],;
				oGetDad:aCols[oGetDad:nAt,4],;
				oGetDad:aCols[oGetDad:nAt,5],;
				oGetDad:aCols[oGetDad:nAt,6]})
		
		Next _no																								
									
	EndIf
	
Return