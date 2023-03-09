
#INCLUDE "plsmcon.ch"
#INCLUDE "TCBROWSE.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "COMMON.CH"
#INCLUDE "RWMAKE.CH"
#Include 'Protheus.ch'
STATIC aBuffer	 := {}

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄX¿
//³Funcao para incluir arquivo no banco de connhecimento sem interacao com tela³
 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄXÙ
*/
User Function MS_INCONH(cPathFile, cAliasEnt, cChaveUn, lOnline, lDelFileOri,lVerifExis,lHelp,cNewPathFile,cPathPublic)
Local aArea 	:= getArea()
Local lRet		:= .F.
Local cObj
LOCAL aFile := {}
LOCAL cNameServ
LOCAL cDir	 	:= getWebDir()

Local cFile		:= ""
Local cExten		:= ""

LOCAL cNewFile	:= ""
LOCAL cNewExten	:= ""

LOCAL cPubFile	:= ""
LOCAL cPubExten	:= ""
LOCAL aRet := {.T., "sucesso"}
LOCAL cErro := ""

Default lOnline     := .F.
Default lDelFileOri := .F.
Default lVerifExis  := .F.
Default lHelp       := .F.
Default cNewPathFile := cPathFile

// tratamento no nome original do arquivo
SplitPath( cPathFile,,, @cFile, @cExten )

// tratamento no nome final do arquivo
SplitPath( cNewPathFile,,, @cNewFile, @cNewExten )

// tratamento no nome final do arquivo
SplitPath( cPathPublic,,, @cPubFile, @cPubExten )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Insere underline nos espaços em branco do nome do arquivo, isso é		 ³
//³ necessário para fazer o download corretamente do arquivo no portal de  ³
//³ noticias.																		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If FindFunction( "MsMultDir" ) .And. MsMultDir()
	cDirDocs := MsRetPath( cNewFile+cNewExten )
Else
	cDirDocs := MsDocPath()
Endif
cNameServ := cNewFile+cNewExten

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se o nome contiver caracteres estendidos, renomeia                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRmvName := Ft340RmvAc(cNameServ)
If !lOnLine
	If !( cRmvName == cNameServ )
		nOpc := Aviso( "Atencao !", "O arquivo '" + cNameServ + ; //"Atencao !"###"O arquivo '"
		    	             "' possui caracteres estendidos. O caracteres estendidos serao alterados para _. Confirma a alteracao ?", { "Sim", "Nao"}, 2 )  //"' possui caracteres estendidos. O caracteres estendidos serao alterados para _. Confirma a alteracao ?"###"Sim"###"Nao"
		If nOpc == 1
			cNameServ:= cRmvName
			
		Else
			lRet := .F.
			lValExist := .F.
			
		EndIf
	EndIf
Endif

If lOnline
	// Copia do client para a pasta do banco de conhecimento 
	If !__COPYFILE( PLSMUDSIS(cPathFile), PLSMUDSIS(cDirDocs + "\" + cNameServ) )
		Return({.F.,"Não foi possível copiar para a pasta de upload"})
	Endif	
	
	// Depois copia do cliente para a pasta publica da web.
	If !__COPYFILE( PLSMUDSIS(cPathFile), PLSMUDSIS(cPathPublic) )
		Return({.F.,"Não foi possível copiar para a pasta publica"})
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Deleta arquivo														   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    if lDelFileOri .AND. file(PLSMUDSIS(cPathFile)) .AND. file(PLSMUDSIS(cDirDocs + "\" + cNameServ))
		FErase(cPathFile)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ na submissao do xml ele tem que gravar no banco de conhecimento la no  |
	//| portal																   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSaveSX8 := GetSX8Len()
	cObj := GetSXENum( "ACB", "ACB_CODOBJ" )

	RecLock( "ACB", .T. )
	ACB->ACB_FILIAL  := xFilial( "ACB" )
	ACB->ACB_CODOBJ := cObj
	ACB->ACB_OBJETO := Left( Upper( cNameServ ), Len( ACB->ACB_OBJETO ) )
	ACB->ACB_DESCRI := cNewFile

	ACB->( MsUnlock() )

	While (GetSx8Len() > nSaveSx8)
		ConfirmSX8()
	EndDo

	RecLock( "AC9", .T. )
	AC9->AC9_FILIAL := xFilial( "AC9" )
	AC9->AC9_FILENT := xFilial( cAliasEnt )
	AC9->AC9_ENTIDA := cAliasEnt
	AC9->AC9_CODENT := cChaveUn
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava o codigo do objeto                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AC9->AC9_CODOBJ := cObj
	AC9->( MsUnlock() )

Else

	dbSelectArea("ACB")
	ACB->(dbGoTop())
	dbSetOrder(2)

	while dbSeek(xFilial("ACB")+Upper(cNameServ))
		aFile := PLSALTNA(cNameServ)

		If aFile[1]
			cFile := aFile[2]
			cNameServ := aFile[2]+cExten
		Else
			Return
		EndIf
	EndDo

	Processa( { || __CopyFile( PLSMUDSIS(cPathFile), PLSMUDSIS(cDirDocs + "\" + cNameServ) ),lRet := File( PLSMUDSIS(cDirDocs + "\" + cNameServ) ) }, "Transferindo objeto","Aguarde...",.F.)

	If PlsAliasExi("BPL")
		If BPL->(FieldPos("BPL_CODIGO")) > 0

	   		If cAliasEnt == "BPL"
	   			PLSINCPRT(cPathFile, cAliasEnt, cChaveUn,BPL->BPL_CODIGO,cNameServ)
	   		EndIf
	    EndIf
	Endif

	nSaveSX8 := GetSX8Len()
	cObj := GetSXENum( "ACB", "ACB_CODOBJ" )

	RecLock( "ACB", .T. )
	ACB->ACB_FILIAL  := xFilial( "ACB" )
	ACB->ACB_CODOBJ := cObj
	ACB->ACB_OBJETO := Left( Upper( cNameServ ), Len( ACB->ACB_OBJETO ) )
	ACB->ACB_DESCRI := cFile

	ACB->( MsUnlock() )

	While (GetSx8Len() > nSaveSx8)
		ConfirmSX8()
	EndDo

	RecLock( "AC9", .T. )
	AC9->AC9_FILIAL := xFilial( "AC9" )
	AC9->AC9_FILENT := xFilial( cAliasEnt )
	AC9->AC9_ENTIDA := cAliasEnt
	AC9->AC9_CODENT := cChaveUn
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava o codigo do objeto                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AC9->AC9_CODOBJ := cObj
	AC9->( MsUnlock() )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao colocar mensagem informativa aqui pois essa rotina tambem eh 	   |
	//| executada em lote no xml											   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lHelp
	     MsgInfo("Arquivo incluido com sucesso!")
	Endif
EndIf
RestArea(aArea)

Return(aRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSPESPROC ³ Autor ³ Michele Tatagiba   ³ Data ³ 23.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Pesquisa generica de Procedimentos ...                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tulio Cesar ³27.05.02³ xxxx ³ Acertos/Melhorias...                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MSA1PESPRO(cCodPad,lAll,cCondSQLAd)
LOCAL nReg          := 0
LOCAL nLin       	:= 1
LOCAL nOpca      	:= 0
LOCAL nSaldo		:= 0
LOCAL nOrdem     	:= 1
LOCAL cChave     	:= Space(40)
LOCAL cTipoPes   	:= ""
LOCAL cCabec		:= ""
LOCAL cCodInt  		:= ""     
LOCAL cCodRDA		:= ""     
LOCAL cEspec   		:= "" 
LOCAL cCodLoc		:= "" 
LOCAL cOpeOri		:= ""    
LOCAL cCodProduto	:= ""     
LOCAL cTipPre  		:= ""     
LOCAL cSQL 			:= ""
LOCAL oDlgPesPro    := NIL
LOCAL oTipoPes		:= NIL
LOCAL oSayPro       := NIL
LOCAL oBrowPro		:= NIL
LOCAL oGetChave		:= NIL
LOCAL oChkChk		:= NIL
LOCAL aBrowPro   	:= {}
LOCAL lOriFol1	:= .F.
LOCAL aVetPad    	:= { {"","",0,"",""} }
LOCAL bRefresh   	:= { || If(!Empty(cChave),MSAPPROPQ(AllTrim(cChave),Subs(cTipoPes,1,1),lChkChk,aBrowPro,aVetPad,oBrowPro,cCodPad,lAll,cCondSQLAd,cCodRDA,cCodInt,cVarRead),.T.), If( Empty(aBrowPro[1,1]) .And. !Empty(cChave),.F.,.T. )  }
LOCAL cValid     	:= "{|| Eval(bRefresh) }"
LOCAL bOK        	:= { || If(!Empty(cChave) .OR. lOriFol1,(nLin := IIf(lOriFol1,oGDProcB:oBrowse:nAt, oBrowPro:nAt),nOpca := 1,lOk:=.T., IIf(lOriFol1,aColsBkp := aClone(oGDProcB:aCols),Nil), IIf(lOriFol1,nPosAtu := oGDProcB:oBrowse:nAt,Nil),oDlgPesPro:End()),Help("",1,"PLSMCON")) }
LOCAL bCanc      	:= { || nOpca := 3,oDlgPesPro:End() }
LOCAL aTipoPes   	:= {}
LOCAL lChkChk    	:= .F.
LOCAL lRet		 	:= .F.
LOCAL aButtons   	:= {} 
LOCAL dDatAnalise	:= dDataBase
LOCAL dDatPro		:= dDataBase
LOCAL aDadUsr		:= PLSGETUSR()      
LOCAL lReembolso	:= .F.     
LOCAL aItensPac     := {} 
LOCAL cVarRead		:= ReadVar()
LOCAL lExB1N		:= PLSALIASEX("B1N")
LOCAL lExbProcBen := .F.
LOCAL aHeadB1N	:= {}
LOCAL aColsB1N	:= {}
LOCAL nU			:= 0
LOCAL nPosCodPro := 0 
LOCAL nPosCodPad := 0 
LOCAL nPosVlrApr := 0
LOCAL nPosQtdPro := 0
LOCAL nPosSequen := 0
LOCAL aColsBkp	:= {}
LOCAL nPOsAtu		:= 0
LOCAL nPosCodRef := 0
LOCAL nPosNomRef := 0

DEFAULT lAll     	:= .T.         
DEFAULT cCondSQLAd  := ""
DEFAULT cCodPad		:= ""
PRIVATE aOpcoes   	:= {}
PRIVATE cCadastro 	:= ""             
Aadd(aButtons, {"POSCLI",{|| PLSCPITEM(cCodPad,aBrowPro[oBrowPro:nAt,1],cCabec) },"Consultar composição"})
Aadd(aButtons, {"RELATORIO",{ || BR8->(DbGoTo(aBrowPro[oBrowPro:nAt,3])), PLSEXITDE(BR8->BR8_CODPAD,BR8->BR8_CODPSA) } ,"Exibe em quais Tabelas o procedimento esta cadastrado"})

//³ _@CodPad variavel private para que nao precise criar mais consulta sxb 
//³ basta criar esta variavel no fonte como privada e tratar a tabela no valid 
//³ do campo ou pergunte utilize uma consulta que nao tenha M-> por exemplo BDUPLS 
If Type("_CodPad_") <> 'U' .And. !Empty(_CodPad_)
	cCodPad	:= _CodPad_
EndIf

DEFINE FONT oFontMsg NAME "Arial" SIZE 000,-012 BOLD
cCabecAux 	:= "B44"
cCabec 	:= "B44"

//³ Verifico se possui procedimentos inseridos pelo portal do beneficiario
If Type("M->B44_PROTOC") <> "U" .AND. !Empty(M->B44_PROTOC)
	If lExB1N
		B1N->(DbSetOrder(1))
		If B1N->(MsSeek(xFilial("B1N") + M->B44_PROTOC ))
			lExbProcBen := .T.
		EndIf
	EndIf	
EndIf


//³ Preencho os parametros
If !Empty(cCabec)       
 	
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODOPE'))") > 0
		cCodInt	:= &("M->"+cCabec+"_CODOPE")
	EndIf 		
	
	If Empty(cCodInt) .And. &(cCabecAux+"->(FieldPos('"+cCabecAux+"_OPERDA'))") > 0 
		cCodInt	:= &("M->"+cCabec+"_OPERDA") 		
	EndIf
	
	If Empty(cCodInt) .And. &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODINT'))") > 0 
		cCodInt	:= &("M->"+cCabec+"_CODINT") 		
	EndIf
	
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODRDA'))") > 0
		cCodRDA	:= &("M->"+cCabec+"_CODRDA")    
	EndIf
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_DATPRO'))") > 0
		dDatPro	:=  &("M->"+cCabec+"_DATPRO")   
	EndIf
EndIf

aadd(aButtons,{"S4WB007N",{ || BR8->(DbGoTo(aBrowPro[oBrowPro:nAt,3])), BR8->(AxVisual("BR8",BR8->(Recno()),K_Visualizar)) } ,"Visualizar parametrizacoes deste procedimento"})
aBrowPro := aClone(aVetPad)

BX8->( DBSetOrder(1) )

aTipoPes := {"1-Nome do Procedimento","2-Codigo do Procedimento"}
aadd(aOpcoes,{"BR8_DESCRI"})
aadd(aOpcoes,{"BR8_CODPSA"})

//³ Define dialogo... 
DEFINE MSDIALOG oDlgPesPro TITLE "Pesquisa de Procedimentos" FROM 008.2,000 TO 32,115 OF GetWndDefault() //

// Constroi o folder
oFolder 		  := TFolder():New(013,005,{"Eventos Beneficiário","Pesquisa padrão" },{"",""},oDlgPesPro,,,,.T.,.F.,450,150) //#
oFolder:aDialogs[1]:lActive := lExbProcBen
oFolder:ShowPage(2)

oGetChave := TGet():New(012,085,{ | U | IF( PCOUNT() == 0, cChave, cChave := U ) },oFolder:aDialogs[2],210,008 ,"@!",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChave)
//oGetChave:lReadOnly := lExbProcBen

//³ FOLDER1: Grid de procedimentos inseridos no protocolo de reembolso
If lExbProcBen
	lOriFol1 := .T.
	@ 010,005 Say oSay PROMPT  "Despesas informadas no protocolo de reembolso:"  SIZE 200,010 OF oFolder:aDialogs[1] PIXEL FONT oFontMsg COLOR CLR_HBLUE  //
	HS_BDados("B1N", @aHeadB1N, @aColsB1N,@nU, 1,, " B1N.B1N_IMGSTA = 'ENABLE' .AND. B1N.B1N_PROTOC = '" + M->B44_PROTOC + "' ",,,/*"ALL""CAMPO1/CAMPO2"*/,,,,,,/*.F.*/,/*aLeg*/,,,,, /*aCpo*/, /*aJoin*/)	
	 
	nPosCodPro := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_CODPRO"}) 
	nPosCodPad := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_CODPAD"}) 
	nPosVlrApr := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_VLRAPR"})
	nPosQtdPro := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_QTDPRO"})
	nPosSequen := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_SEQUEN"})
	nPosSeqB1N := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_SEQUEN"}) 
	nPosCodRef := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_CODREF"})
	nPosNomRef := Ascan(aHeadB1N,{|x|AllTrim(x[2])=="B1N_NOMREF"})
	
	oGDProcB := MsNewGetDados():New(020, 005, 110, 430,0,,,,,,,,,, oFolder:aDialogs[1], aHeadB1N, aColsB1N)    // 000 000 300 500
	oGDProcB:oBrowse:BlDblClick := bOK
	oGDProcB:oBrowse:bGotFocus := {|| IIF(!Empty(oGDProcB:aCols[oGDProcB:oBrowse:nAt,nPosCodPro]),  lOriFol1 := .T.,lOriFol1 := .F.)    }	
EndIf

//³ FOLDER2: Grid de pesquisa de procedimentos
oBrowPro := TcBrowse():New( 030, 007, 430, If(cPaisLoc=="BRA",075,090),,,, oFolder:aDialogs[2],,,,,,,,,,,, .F.,, .T.,, .F., )

ADD COLUMN TO oBrowPro BITMAP DATA { || LoadBitmap( GetResources(), aBrowPro[oBrowPro:nAt,4] ) } TITLE "" WIDTH 015 NOHILITE
oBrowPro:AddColumn(TcColumn():New(STR0046,nil,;
         nil,nil,nil,nil,030,.F.,.F.,nil,nil,nil,.F.,nil))//"Tabela"     
         oBrowPro:ACOLUMNS[2]:BDATA := { || aBrowPro[oBrowPro:nAt,5] }         
oBrowPro:AddColumn(TcColumn():New(STR0047,nil,;
         nil,nil,nil,nil,060,.F.,.F.,nil,nil,nil,.F.,nil))//"Procedimento"     
         oBrowPro:ACOLUMNS[3]:BDATA := { || aBrowPro[oBrowPro:nAt,1] }         
oBrowPro:AddColumn(TcColumn():New(STR0048,nil,;
         nil,nil,nil,nil,090,.F.,.F.,nil,nil,nil,.F.,nil))//"Descricao"     
         oBrowPro:ACOLUMNS[4]:BDATA := { || aBrowPro[oBrowPro:nAt,2] }
@ 011,008 COMBOBOX oTipoPes  Var cTipoPes ITEMS aTipoPes SIZE 070,010 OF oFolder:aDialogs[2] PIXEL COLOR CLR_HBLUE
@ 012,310 CHECKBOX oChkChk   Var lChkChk PROMPT STR0049 PIXEL SIZE 080, 010 OF oFolder:aDialogs[2]//"Pesquisar Palavra Chave"
oBrowPro:SetArray(aBrowPro)
oBrowPro:BLDBLCLICK := bOK
oBrowPro:bGotFocus := {|| lOriFol1 := .F. }
oTipoPes:bLostFocus := {|| oGetChave:Refresh(),oGetChave:SetFocus(),.T.}

If cPaisLoc == "BRA"
   @ 115,013 BITMAP oBmp RESNAME "BR_VERMELHO"   OF oFolder:aDialogs[2] SIZE 20,20 NOBORDER WHEN .F. PIXEL
   @ 115,025 Say oSay PROMPT STR0050 SIZE 100,010 OF oFolder:aDialogs[2] PIXEL//"Nao Pertence ao ROL da ANS"

   @ 115,120 BITMAP oBmp RESNAME "BR_VERDE"   OF oFolder:aDialogs[2] SIZE 20,20 NOBORDER WHEN .F. PIXEL
   @ 115,130 Say oSay PROMPT  STR0051 SIZE 100,010 OF oFolder:aDialogs[2] PIXEL //"Pertence ao ROL da ANS"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o Dialogo...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlgPesPro ON INIT Eval({ ||  EnChoiceBar(oDlgPesPro,bOK,bCanc,.F.,aButtons) }) CENTERED
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ OK
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nOpca == K_OK                         

	lRet := .T.
	If !Empty( aBrowPro[1,1] ) .OR. (lOriFol1)
		If 	!lOriFol1
			BR8->( DbGoTo(aBrowPro[nLin,3]) )
		Else
			BR8->(DbSetOrder(1))
			BR8->(MsSeek(xFilial("BR8") + aColsBkp[nPOsAtu,nPosCodPad] + aColsBkp[nPOsAtu,nPosCodPro]))
		EndIf
		If lOriFol1
			If Type("M->B45_VLRAPR") <> "U"
				M->B45_VLRAPR := aColsBkp[nPOsAtu,nPosVlrApr]
				M->B45_CODPAD := aColsBkp[nPOsAtu,nPosCodPad]
				M->B45_CODPRO := aColsBkp[nPOsAtu,nPosCodPro]
				M->B45_QTDPRO := aColsBkp[nPOsAtu,nPosQtdPro]
				
				If B45->(FieldPos("B45_CODREF")) > 0
					M->B45_CODREF := aColsBkp[nPOsAtu,nPosCodRef]
					M->B45_NOMREF := aColsBkp[nPOsAtu,nPosNomRef]
				EndIf
				
				If Type("M->B45_SEQB1N") <> "U"
					M->B45_SEQB1N := aColsBkp[nPOsAtu,nPosSeqB1N]
				EndIf
			EndIf
		Else	
			If Type("M->B45_SEQB1N") <> "U"
				M->B45_SEQB1N := Space(Len(M->B45_SEQB1N))
			EndIf
		EndIf		
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Retorno da Funcao...                                                     
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSPESPROC ³ Autor ³ Michele Tatagiba   ³ Data ³ 23.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Pesquisa generica de Procedimentos ...                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tulio Cesar ³27.05.02³ xxxx ³ Acertos/Melhorias...                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MSA2PESPRO(cCodPad,lAll,cCondSQLAd)
LOCAL nReg          := 0
LOCAL nLin       	:= 1
LOCAL nOpca      	:= 0
LOCAL nSaldo		:= 0
LOCAL nOrdem     	:= 1
LOCAL cChave     	:= Space(40)
LOCAL cTipoPes   	:= ""
LOCAL cCabec		:= ""
LOCAL cCodInt  		:= ""     
LOCAL cCodRDA		:= ""     
LOCAL cEspec   		:= "" 
LOCAL cCodLoc		:= "" 
LOCAL cOpeOri		:= ""    
LOCAL cCodProduto	:= ""     
LOCAL cTipPre  		:= ""     
LOCAL cSQL 			:= ""
LOCAL oDlgPesPro    := NIL
LOCAL oTipoPes		:= NIL
LOCAL oSayPro       := NIL
LOCAL oBrowPro		:= NIL
LOCAL oGetChave		:= NIL
LOCAL oChkChk		:= NIL
LOCAL aBrowPro   	:= {}
LOCAL lOriFol1	:= .F.
LOCAL aVetPad    	:= { {"","",0,"",""} }
LOCAL bRefresh   	:= { || If(!Empty(cChave),MSAPPROPQ(AllTrim(cChave),Subs(cTipoPes,1,1),lChkChk,aBrowPro,aVetPad,oBrowPro,cCodPad,lAll,cCondSQLAd,cCodRDA,cCodInt,cVarRead),.T.), If( Empty(aBrowPro[1,1]) .And. !Empty(cChave),.F.,.T. )  }
LOCAL cValid     	:= "{|| Eval(bRefresh) }"
LOCAL bOK        	:= { || If(!Empty(cChave) .OR. lOriFol1,(nLin := IIf(lOriFol1,oGDProcB:oBrowse:nAt, oBrowPro:nAt),nOpca := 1,lOk:=.T., IIf(lOriFol1,aColsBkp := aClone(oGDProcB:aCols),Nil), IIf(lOriFol1,nPosAtu := oGDProcB:oBrowse:nAt,Nil),oDlgPesPro:End()),Help("",1,"PLSMCON")) }
LOCAL bCanc      	:= { || nOpca := 3,oDlgPesPro:End() }
LOCAL aTipoPes   	:= {}
LOCAL lChkChk    	:= .F.
LOCAL lRet		 	:= .F.
LOCAL aButtons   	:= {} 
LOCAL dDatAnalise	:= dDataBase
LOCAL dDatPro		:= dDataBase
LOCAL aDadUsr		:= PLSGETUSR()      
LOCAL lReembolso	:= .F.     
LOCAL aItensPac     := {} 
LOCAL cVarRead		:= ReadVar()
LOCAL lExB1N		:= PLSALIASEX("B1N")
LOCAL lExbProcBen := .F.
LOCAL aHeadB1N	:= {}
LOCAL aColsB1N	:= {}
LOCAL nU			:= 0
LOCAL nPosCodPro := 0 
LOCAL nPosCodPad := 0 
LOCAL nPosVlrApr := 0
LOCAL nPosQtdPro := 0
LOCAL nPosSequen := 0
LOCAL aColsBkp	:= {}
LOCAL nPOsAtu		:= 0
LOCAL nPosCodRef := 0
LOCAL nPosNomRef := 0

DEFAULT lAll     	:= .T.         
DEFAULT cCondSQLAd  := ""
DEFAULT cCodPad		:= ""
PRIVATE aOpcoes   	:= {}
PRIVATE cCadastro 	:= ""             
Aadd(aButtons, {"POSCLI",{|| PLSCPITEM(cCodPad,aBrowPro[oBrowPro:nAt,1],cCabec) },"Consultar composição"})
Aadd(aButtons, {"RELATORIO",{ || BR8->(DbGoTo(aBrowPro[oBrowPro:nAt,3])), PLSEXITDE(BR8->BR8_CODPAD,BR8->BR8_CODPSA) } ,"Exibe em quais Tabelas o procedimento esta cadastrado"})

//³ _@CodPad variavel private para que nao precise criar mais consulta sxb 
//³ basta criar esta variavel no fonte como privada e tratar a tabela no valid 
//³ do campo ou pergunte utilize uma consulta que nao tenha M-> por exemplo BDUPLS 
If Type("_CodPad_") <> 'U' .And. !Empty(_CodPad_)
	cCodPad	:= _CodPad_
EndIf

DEFINE FONT oFontMsg NAME "Arial" SIZE 000,-012 BOLD
cCabecAux 	:= "B1N"
cCabec 	:= "B1N"

//³ Preencho os parametros
If !Empty(cCabec)       
 	
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODOPE'))") > 0
		cCodInt	:= &("M->"+cCabec+"_CODOPE")
	EndIf 		
	
	If Empty(cCodInt) .And. &(cCabecAux+"->(FieldPos('"+cCabecAux+"_OPERDA'))") > 0 
		cCodInt	:= &("M->"+cCabec+"_OPERDA") 		
	EndIf
	
	If Empty(cCodInt) .And. &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODINT'))") > 0 
		cCodInt	:= &("M->"+cCabec+"_CODINT") 		
	EndIf
	
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_CODRDA'))") > 0
		cCodRDA	:= &("M->"+cCabec+"_CODRDA")    
	EndIf
	If &(cCabecAux+"->(FieldPos('"+cCabecAux+"_DATPRO'))") > 0
		dDatPro	:=  &("M->"+cCabec+"_DATPRO")   
	EndIf
EndIf

aadd(aButtons,{"S4WB007N",{ || BR8->(DbGoTo(aBrowPro[oBrowPro:nAt,3])), BR8->(AxVisual("BR8",BR8->(Recno()),K_Visualizar)) } ,"Visualizar parametrizacoes deste procedimento"})
aBrowPro := aClone(aVetPad)

BX8->( DBSetOrder(1) )

aTipoPes := {"1-Nome do Procedimento","2-Codigo do Procedimento"}
aadd(aOpcoes,{"BR8_DESCRI"})
aadd(aOpcoes,{"BR8_CODPSA"})

//³ Define dialogo... 
DEFINE MSDIALOG oDlgPesPro TITLE "Pesquisa de Procedimentos" FROM 008.2,000 TO 32,115 OF GetWndDefault() //

// Constroi o folder
oFolder 		  := TFolder():New(013,005,{"Pesquisa padrão" },{"",""},oDlgPesPro,,,,.T.,.F.,450,150) //#

oGetChave := TGet():New(012,085,{ | U | IF( PCOUNT() == 0, cChave, cChave := U ) },oFolder:aDialogs[1],210,008 ,"@!",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChave)

oBrowPro := TcBrowse():New( 030, 007, 430, If(cPaisLoc=="BRA",075,090),,,, oFolder:aDialogs[1],,,,,,,,,,,, .F.,, .T.,, .F., )
ADD COLUMN TO oBrowPro BITMAP DATA { || LoadBitmap( GetResources(), aBrowPro[oBrowPro:nAt,4] ) } TITLE "" WIDTH 015 NOHILITE
oBrowPro:AddColumn(TcColumn():New(STR0046,nil,;
         nil,nil,nil,nil,030,.F.,.F.,nil,nil,nil,.F.,nil))//"Tabela"     
         oBrowPro:ACOLUMNS[2]:BDATA := { || aBrowPro[oBrowPro:nAt,5] }         
oBrowPro:AddColumn(TcColumn():New(STR0047,nil,;
         nil,nil,nil,nil,060,.F.,.F.,nil,nil,nil,.F.,nil))//"Procedimento"     
         oBrowPro:ACOLUMNS[3]:BDATA := { || aBrowPro[oBrowPro:nAt,1] }         
oBrowPro:AddColumn(TcColumn():New(STR0048,nil,;
         nil,nil,nil,nil,090,.F.,.F.,nil,nil,nil,.F.,nil))//"Descricao"     
         oBrowPro:ACOLUMNS[4]:BDATA := { || aBrowPro[oBrowPro:nAt,2] }
@ 011,008 COMBOBOX oTipoPes  Var cTipoPes ITEMS aTipoPes SIZE 070,010 OF oFolder:aDialogs[1] PIXEL COLOR CLR_HBLUE
@ 012,310 CHECKBOX oChkChk   Var lChkChk PROMPT STR0049 PIXEL SIZE 080, 010 OF oFolder:aDialogs[1]//"Pesquisar Palavra Chave"
oBrowPro:SetArray(aBrowPro)
oBrowPro:BLDBLCLICK := bOK
oBrowPro:bGotFocus := {|| lOriFol1 := .F. }
oTipoPes:bLostFocus := {|| oGetChave:Refresh(),oGetChave:SetFocus(),.T.}

@ 115,013 BITMAP oBmp RESNAME "BR_VERMELHO"   OF oFolder:aDialogs[1] SIZE 20,20 NOBORDER WHEN .F. PIXEL
@ 115,025 Say oSay PROMPT STR0050 SIZE 100,010 OF oFolder:aDialogs[1] PIXEL//"Nao Pertence ao ROL da ANS"

@ 115,120 BITMAP oBmp RESNAME "BR_VERDE"   OF oFolder:aDialogs[1] SIZE 20,20 NOBORDER WHEN .F. PIXEL
@ 115,130 Say oSay PROMPT  STR0051 SIZE 100,010 OF oFolder:aDialogs[1] PIXEL //"Pertence ao ROL da ANS"

ACTIVATE MSDIALOG oDlgPesPro ON INIT Eval({ ||  EnChoiceBar(oDlgPesPro,bOK,bCanc,.F.,aButtons) }) CENTERED
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ OK
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nOpca == K_OK                         

	lRet := .T.
	If !Empty( aBrowPro[1,1] ) .OR. (lOriFol1)
		If 	!lOriFol1
			BR8->( DbGoTo(aBrowPro[nLin,3]) )
		Else
			BR8->(DbSetOrder(1))
			BR8->(MsSeek(xFilial("BR8") + aColsBkp[nPOsAtu,nPosCodPad] + aColsBkp[nPOsAtu,nPosCodPro]))
		EndIf
		If lOriFol1
			If Type("M->B45_VLRAPR") <> "U"
				M->B45_VLRAPR := aColsBkp[nPOsAtu,nPosVlrApr]
				M->B45_CODPAD := aColsBkp[nPOsAtu,nPosCodPad]
				M->B45_CODPRO := aColsBkp[nPOsAtu,nPosCodPro]
				M->B45_QTDPRO := aColsBkp[nPOsAtu,nPosQtdPro]
				
				If B45->(FieldPos("B45_CODREF")) > 0
					M->B45_CODREF := aColsBkp[nPOsAtu,nPosCodRef]
					M->B45_NOMREF := aColsBkp[nPOsAtu,nPosNomRef]
				EndIf
				
				If Type("M->B45_SEQB1N") <> "U"
					M->B45_SEQB1N := aColsBkp[nPOsAtu,nPosSeqB1N]
				EndIf
			EndIf
		Else	
			If Type("M->B45_SEQB1N") <> "U"
				M->B45_SEQB1N := Space(Len(M->B45_SEQB1N))
			EndIf
		EndIf		
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Retorno da Funcao...                                                     
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PLSA090SOL ³ Autor ³ Tulio Cesar           ³ Data ³ 13.06.00³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                            
User Function MSVLDSOL(cAlias)
LOCAL lRet 
LOCAL aProg     := PlsRetAut()          
Local aRetQry
Local cQuery1
Local cQuery2           
LOCAL nRegBAU   := BAU->(Recno())
LOCAL nOrdBAU   := BAU->(IndexOrd())
LOCAL nRegBAW   := BAW->(Recno())
LOCAL nOrdBAW   := BAW->(IndexOrd())
LOCAL aRetBAW   := {}
LOCAL lExDATPRO := .F.
LOCAL aAreaSX3  := {}
LOCAL aProfs    := {}
LOCAL lGrdExe 	:= .f. 
DEFAULT cAlias 	:= "BOW"
aRetQry := PLSRQCon("BD6_CODPAD","BD6_CODPRO")

cQuery1 := aRetQry[1]
cQuery2 := aRetQry[2]
    
If Type("M->B4B_UFCONS") <> 'U'
	BB0->(DbSetOrder(4)) //BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG + BB0_CODOPE
	lRet := BB0->(MsSeek(xFilial("BB0")+&("M->B4B_UFCONS")+  PadR( &("M->B4B_NUCONS") , TamSX3( "BB0_NUMCR" )[ 1 ] ) +&("M->B4B_SICONS")))
	while !BB0->(Eof()) .and. xFilial("BB0")+&("M->B4B_UFCONS")+&("M->B4B_NUCONS")+&("M->B4B_SICONS") ==;
	                       	  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG)
	
		aadd(aProfs,{BB0->(Recno()),BB0->BB0_CODIGO})        
		BB0->(DbSkip())
	Enddo
	lGrdExe := .t. //significa que estou no novo grid dos executantes na tela de SDAT ou na tela de HONORARIO INDIVIDUAL
ElseIf Type("M->"+cAlias+"_ESTSOL") <> 'U'
	BB0->(DbSetOrder(4)) //BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG + BB0_CODOPE
	lRet := BB0->(MsSeek(xFilial("BB0")+&("M->"+cAlias+"_ESTSOL")+&("M->"+cAlias+"_REGSOL")+&("M->"+cAlias+"_SIGLA")))
	while !BB0->(Eof()) .and. xFilial("BB0")+&("M->"+cAlias+"_ESTSOL")+&("M->"+cAlias+"_REGSOL")+&("M->"+cAlias+"_SIGLA") ==;
	                       	  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG)
	
		aadd(aProfs,{BB0->(Recno()),BB0->BB0_CODIGO})        
		BB0->(DbSkip())
	Enddo
Endif

If Len(aProfs) > 0
     BB0->(DbGoTo(aProfs[1][1]))
Endif
If lRet
	  If Type("M->"+cAlias+"_NOMSOL") <> 'U' 
	      &("M->"+cAlias+"_NOMSOL") := BB0->BB0_NOME
      Endif
      If Type("M->"+cAlias+"_CDPFSO") <> 'U' 
      	&("M->"+cAlias+"_CDPFSO") := BB0->BB0_CODIGO
      Endif
      If  Type("M->"+cAlias+"_CONREG") <> 'U' 
			&("M->"+cAlias+"_CONREG") := BB0->BB0_NUMCR
      EndIf                          
      If  Type("M->B4B_NOMPRF") <> 'U' 
			&("M->B4B_NOMPRF") := BB0->BB0_NOME
      EndIf                          
      If  Type("M->B4B_CDPFPR") <> 'U' 
			&("M->B4B_CDPFPR") := BB0->BB0_CODIGO
      EndIf    
      	if type("M->B4B_CGC") <> "U"                                     
			M->B4B_CGC :=  BB0->BB0_CGC                               
		endif                        
Endif                   

If !lRet
   Help("",1,"REGNOIS")
Else
	If cAlias == "BE1"
		aAreaSX3 := SX3->(GetArea()) 
		SX3->(DbSetOrder(2))
		If SX3->(DbSeek("BE1_DATPRO"))
	   		lExDATPRO := .T.  
	   	EndIf	
   		SX3->(RestArea(aAreaSX3))
	Else
		lExDATPRO := &(cAlias + "->(FieldPos('" + cAlias + "_DATPRO'))") > 0
	EndIf
	 
	If BB0->(FieldPos("BB0_CODBLO")) > 0 .AND. lExDATPRO 
    	lRet := A090CHEBLO(BB0->BB0_CODIGO,&("M->"+cAlias+"_DATPRO"),nil,aProfs)
		&("M->"+cAlias+"_NOMSOL") := BB0->BB0_NOME
	    &("M->"+cAlias+"_CDPFSO") := BB0->BB0_CODIGO
	    If  &(cAlias + "->(FieldPos('" + cAlias + "_CONREG'))") > 0
			&("M->"+cAlias+"_CONREG") := BB0->BB0_NUMCR
	    EndIf
	EndIf

    If lRet
       BAU->(DbSetOrder(5))
       If BAU->(DbSeek(xFilial("BAU")+BB0->BB0_CODIGO))
          aRetBAW := PLSVldBAW(PLSINTPAD(),nil,nil,nil,nil,nil,nil,BAU->BAU_CODIGO)
          If ! aRetBAW[1]
	         If !lGrdExe
	         	Aviso( "Solicitante",aRetBAW[2,1,1] + aRetBAW[2,1,2],{ STR0022 }, 2 ) //"Ok"
             Else
             	Aviso( "Executante",aRetBAW[2,1,1] + aRetBAW[2,1,2],{ STR0022 }, 2 ) //"Ok"
             Endif
             lRet := .F.
          Endif
        Endif 
    Endif
Endif   

BAU->(DbGoTo(nRegBAU))
BAU->(DbSetOrder(nOrdBAU))
BAU->(DbGoTo(nRegBAW))
BAU->(DbSetOrder(nOrdBAW))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSAPPROPQ ³ Autor ³ Michele Tatagiba   ³ Data ³ 23.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Pesquisa o procedimento na base de dados ...              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tulio Cesar ³27.05.02³ xxxx ³ Acertos/Melhorias...                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MSAPPROPQ(cChave,cTipoPes,lChkChk,aBrowPro,aVetPad,oBrowPro,cCodPad,lAll,cCondSQLAd,cCodRDA,cCodInt,cVarRead)
LOCAL aArea   	:= GetArea()
LOCAL lRet		:= .F.
LOCAL cSQL      := ""                          
LOCAL cCodPsa	:= ""
LOCAL cRetBR8 	:= ""
LOCAL cRetBBM	:= ""
LOCAL cRetBBN	:= ""
LOCAL cRetBC0	:= ""  
LOCAL cRetBD7	:= ""
LOCAL cRetBE2	:= ""
LOCAL lProcLib	:= IIf(GetNewPar("MV_PLSLIBE","0") == "1" .And. Type("M->BE1_NUMLIB") <> "U",IIf(Empty(M->BE1_NUMLIB),.F.,.T.),.F.)
LOCAL lPLibOdo	:= IIf(GetNewPar("MV_PLSLIBE","0") == "1" .And. Type("M->B01_NUMLIB") <> "U",IIf(Empty(M->B01_NUMLIB),.F.,.T.),.F.)
LOCAL lPLibRee	:= IIf(GetNewPar("MV_PLSLIBE","0") == "1" .And. Type("M->B44_NUMLIB") <> "U",IIf(Empty(M->B44_NUMLIB),.F.,.T.),.F.)
LOCAL lProcInt  := IIf( Type("M->B0I_NUMINT") <> "U",IIf(Empty(M->B0I_NUMINT),.F.,.T.),.F.)
LOCAL cPacote	:= GetNewPar("MV_PLSPCTE","")
DEFAULT cVarRead := ""

If lProcLib
	cAlias := "BE1"
ElseIf lPLibOdo
	cAlias := "B01"
ElseIf lProcInt
	cAlias := "B0I"
ElseIf lPLibRee
	cAlias := "B44"
EndIf

If '"' $ cChave .Or. "'" $ cChave
   Aviso( STR0018,STR0019,{ STR0028}, 2 )//"Caracter Invalido"//"Existem caracteres invalidos em sua pesquisa." 	                                                                    
   Return(.F.)
EndIf   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Nome das tabelas
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
cRetBR8 := BR8->(RetSQLName("BR8"))
cRetBBM := BBM->(RetSQLName("BBM"))
cRetBBN := BBN->(RetSQLName("BBN"))
cRetBC0 := BC0->(RetSQLName("BC0"))
cRetBD7 := BD7->(RetSQLName("BD7"))
cRetBE2 := BE2->(RetSQLName("BE2"))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limpa resultado...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aBrowPro := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Veio de uma liberacao ou foi informado participacao
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lProcLib .Or. lPLibOdo .Or. lPLibRee .Or. lProcInt	           
	
	BR8->( DbSetOrder(1) ) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN	

	cSQL := "SELECT BE2_CODPAD,BE2_CODPRO FROM "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Grau de participacao 45a
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lProcLib .And. TYPE("M->BE1_GRAUPA") <> "U" .And. !Empty(M->BE1_GRAUPA) .Or. lPLibRee
		cSQL += RetSQLName("BE2")+", "+RetSQLName("BD7")+" "
	Else
		cSQL += RetSQLName("BE2")+" "	
	EndIf	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ be2																		
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	cSQL += "WHERE BE2_FILIAL = '"+xFilial("BE2")+"' AND "
	cSQL += "BE2_OPEMOV = '"+Substr(&("M->"+cAlias+IIf(lProcInt,"_NUMINT","_NUMLIB")),01,4)+"' AND "
	cSQL += "BE2_ANOAUT = '"+Substr(&("M->"+cAlias+IIf(lProcInt,"_NUMINT","_NUMLIB")),05,4)+"' AND "
	cSQL += "BE2_MESAUT = '"+Substr(&("M->"+cAlias+IIf(lProcInt,"_NUMINT","_NUMLIB")),09,2)+"' AND "
	cSQL += "BE2_NUMAUT = '"+Substr(&("M->"+cAlias+IIf(lProcInt,"_NUMINT","_NUMLIB")),11,8)+"' AND "
	cSQL += RetSQLName("BE2")+".D_E_L_E_T_ = ' ' "	                                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ bd7
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lProcLib .And. TYPE("M->BE1_GRAUPA") <> "U" .And. !Empty(M->BE1_GRAUPA)

		cSQL += "AND BE2_FILIAL = BD7_FILIAL "
		cSQL += "AND BE2_OPEMOV = BD7_CODOPE "
		cSQL += "AND BE2_CODLDP = BD7_CODLDP "
		cSQL += "AND BE2_CODPEG = BD7_CODPEG "
		cSQL += "AND BE2_NUMERO = BD7_NUMERO "
		cSQL += "AND BE2_CODPAD = BD7_CODPAD "
		cSQL += "AND BE2_CODPRO = BD7_CODPRO "
		cSQL += "AND BD7_CODTPA = '" + M->BE1_GRAUPA + "' "
		cSQL += "AND BD7_MOTBLO = ' ' "
		cSQL += "AND BD7_SALDO > 0 AND "	                     
		cSQL += RetSQLName("BD7")+".D_E_L_E_T_ = ' ' "
		
	ElseIf lPLibRee	
		cSQL += "AND BE2_FILIAL = BD7_FILIAL "
		cSQL += "AND BE2_OPEMOV = BD7_CODOPE "
		cSQL += "AND BE2_CODLDP = BD7_CODLDP "
		cSQL += "AND BE2_CODPEG = BD7_CODPEG "
		cSQL += "AND BE2_NUMERO = BD7_NUMERO "
		cSQL += "AND BE2_CODPAD = BD7_CODPAD "
		cSQL += "AND BE2_CODPRO = BD7_CODPRO "
		cSQL += "AND BD7_BLOPAG = '1' AND "
		cSQL += RetSQLName("BD7")+".D_E_L_E_T_ = ' ' "
    EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Order by
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	cSQL += "ORDER BY BE2_FILIAL,BE2_DESPRO"
	
Elseif !Empty(cPacote) .and. (cCodPad $ cPacote) .and. SubStr(cVarRead,4,3) <> "BLD"
	cSql := "SELECT BLZ_CODPRO, BLZ_CODPAD FROM "+RetSqlName("BLZ")+","+RetSqlName("BR8")	
	cSql += " WHERE BLZ_FILIAL = BR8_FILIAL "	
	cSql += "AND BLZ_CODPAD = BR8_CODPAD "
	cSql += "AND BLZ_CODPRO = BR8_CODPSA "		
	cSql += "AND BLZ_FILIAL = '"+xFilial("BLZ")+"' "
	cSql += "AND BLZ_CODINT = '"+cCodInt+"' "	
	cSql += "AND BLZ_CODPAD = '"+cCodPad+"' "
	cSql += "AND BLZ_CODRDA = '"+cCodRDA+"' "
	cSql += "AND "+RetSqlName("BLZ")+".D_E_L_E_T_ = ' ' "	
	
    cSql += MSWHERE(aOpcoes[val(cTipoPes),1],cChave,lChkChk)
	
	cSql += " AND "+RetSqlName("BR8")+".D_E_L_E_T_ = ' ' "		

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ BR8
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	cSQL := "SELECT BR8_CODROL, BR8_CODPAD, BR8_CODPSA, BR8_DESCRI "
	cSQL += ","+cRetBR8+".R_E_C_N_O_ AS BR8REG "
	cSQL += "  FROM "+cRetBR8
	cSQL += " WHERE BR8_FILIAL = '"+xFilial("BR8")+"' " 
		
	If !Empty(cCodPad)
		cSQL += "   AND BR8_CODPAD = '"+cCodPad+"' "   
	EndIf

    cSql += MSWHERE(aOpcoes[val(cTipoPes),1],cChave,lChkChk)
	
	If ! lAll
	   cSQL += " AND BR8_ANASIN = '1'"
	EndIf   

	cSQL += "   AND "+cRetBR8+".D_E_L_E_T_ = ' ' "
	
	If ! Empty(cCondSQLAd)
	   cSQL += cCondSQLAd
	EndIf  
	
	cSQL += "ORDER BY BR8_FILIAL,"+aOpcoes[Val(cTipoPes),1]
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ executa a query
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbPes",.F.,.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ While na area de trabalho
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
TrbPes->( DbGoTop() )
While !TrbPes->( Eof() )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ CodPsa
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ	
	If (lProcLib .Or. lPLibOdo .Or. lPLibRee .Or. lProcInt)
		 cCodPsa := TrbPes->BE2_CODPRO
		 
	Elseif !Empty(cPacote) .and. (cCodPad $ cPacote) .and. SubStr(cVarRead,4,3) <> "BLD"
		cCodPsa := TrbPes->BLZ_CODPRO
		
	Else	
		cCodPsa := TrbPes->BR8_CODPSA
	
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Se veio da liberacao ou e o 45a posiciona a BR8
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If Ascan(aBrowPro,{ |x| AllTrim(x[1]) == AllTrim(cCodPsa) } ) == 0 
	
		If lProcLib .Or. lPLibOdo .Or. lPLibRee .Or. lProcInt
		    BR8->( MsSeek( xFilial("BR8") + TrbPes->(BE2_CODPAD+BE2_CODPRO) ) )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³ matriz de retorno
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			BR8->( AaDd( aBrowPro,{ BR8_CODPSA,BR8_DESCRI,RECNO(),If(cPaisLOC=="BRA",If(Empty(BR8_CODROL),"BR_VERMELHO","BR_VERDE"),"BR_VERDE" ),BR8_CODPAD } ) )
			
		Elseif !Empty(cPacote) .and. (cCodPad $ cPacote) .and. SubStr(cVarRead,4,3) <> "BLD"
		    If BR8->( MsSeek( xFilial("BR8") + TrbPes->(BLZ_CODPAD+BLZ_CODPRO) ) )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
				//³ matriz de retorno
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
				BR8->( AaDd( aBrowPro,{ BR8_CODPSA,BR8_DESCRI,RECNO(),If(cPaisLOC=="BRA",If(Empty(BR8_CODROL),"BR_VERMELHO","BR_VERDE"),"BR_VERDE" ),BR8_CODPAD } ) )
			Endif
						
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³ matriz de retorno
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			TrbPes->( AaDd( aBrowPro,{ BR8_CODPSA,BR8_DESCRI,BR8REG,If(cPaisLOC=="BRA",If(Empty(BR8_CODROL),"BR_VERMELHO","BR_VERDE"),"BR_VERDE" ),BR8_CODPAD } ) )
		EndIf
	EndIf	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Skip
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	TrbPes->( DbSkip() )	
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ fecha area
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
TrbPes->( DbCloseArea() )

// Ordena a matriz de resultados por Descrição.
If !Empty(cPacote) .and. (cCodPad $ cPacote)
	aBrowPro := aSort(aBrowPro,,,{|x,y| x[2] < y[2]})
	
Endif	
	
RestArea(aArea)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa resultado da pesquisa...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aBrowPro) == 0
   aBrowPro := aClone(aVetPad)
EndIf       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza browse...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrowPro:nAt := 1 // Configuro nAt para um 1 pois estava ocorrendo erro de "array out of bound" qdo se fazia
                  // uma pesquisa mais abrangante e depois uma uma nova pesquisa menos abrangente
                  // Exemplo:
                  // 1a. Pesquisa: "A" - Tecle <END> para ir ao final e retorne ate a primeira linha do browse
                  // (via seta para cima ou clique na primeira linha)
                  // 2a. Pesquisa: "AV" - Ocorria o erro
oBrowPro:SetArray(aBrowPro)
oBrowPro:Refresh()
oBrowPro:SetFocus()                
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSWHERE   ³ Autor ³ Alexander Santos   ³ Data ³ 01.07.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Monta where para pesquisa generica						   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static function MSWHERE(cCmpPes,cContBusca,lChk)
LOCAL nI			:= 0
LOCAL nTam		:= 0
LOCAL cWhere		:= ""
LOCAL aWhere		:= {}
LOCAL cCampo		:= '' 
LOCAL cConteudo	:= ''
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ matriz
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
aWhere := strTokArr(cCmpPes,'+')
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ monta where campo e conteudo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
for nI:=1 to len(aWhere)

	if !empty(cContBusca)
		cCampo		:= allTrim(aWhere[nI])
		nTam		:= tamSx3(cCampo)[1]
		cConteudo	:= substr(cContBusca,1,nTam)
		cContBusca	:= substr(cContBusca,nTam+1,len(cContBusca))
		
		if empty(cContBusca) .and. len(cConteudo) != nTam
			cWhere += " AND " + cCampo + " like " + iIf(lChk,"'%","'") + cConteudo + "%' "
		else 
			cWhere += " AND " + cCampo + " = '" + cConteudo + "' "
		endIf
	else
		exit
	endIf
next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Fim da Rotina
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
return(cWhere)


User Function MSWHEN(cCampo)
LOCAL lRet := .T.

If UPPER(cCampo) == "BOW_STATUS"
	If Inclui
		lRet := .F.
	Elseif BOW->BOW_STATUS $ "8,9,6,B"
		lRet := .F.
	
	Endif
Endif

Return lRet
 
User Function MSX3CBOX(cCampo)
LOCAL cRet := "" 

If UPPER(cCampo) == "BOW_STATUS" 
	cRet := "0=Solicitado (Portal);1=Solicitado (Remote);2=Em Analise (Protocolo);3=Deferido;4=Indeferido;5=Em Analise (Guia);6=Faturado;7=Pagamento negado;8=Auditoria Médica;9=Auditoria Administrativa;A=Auditoria Farmaceutica;B=Pago;R=Rascunho;E=Em Edição pelo Usuário"
Endif

If UPPER(cCampo) == "ZZ2_CODIGO" 
	cRet := "0=Notícia;1=Autorização;2=Reembolso;3=Auditoria;4=Cadastro de beneficiário;5=Financeiro;6=Agendamento;7=Promoção da saúde;8=Credenciamento;9=Previdência;A=CRM;B=Pagamento Médico"
Endif

Return cRet 

User Function MSRELACAO(cCampo)
LOCAL cRet := ""

If Alltrim(Upper(cCampo)) == "B45_CODREF"
	If INCLUI
		If !Empty(M->B44_CODREF)
			cRet := M->B44_CODREF
		Else
			cRet := ""
		Endif
		 
	Else
		If Empty(B45->B45_CODREF)
			cRet := M->B44_CODREF
		Else
		 	cRet := M->B45_CODREF
		 Endif
	Endif
Elseif Alltrim(Upper(cCampo)) == "B45_NOMREF"
	If INCLUI 
		If !Empty(M->B44_CODREF)
			cRet := M->B44_NOMREF
		Else
			cRet := ""
		Endif
		 
	Else
		If Empty(B45->B45_CODREF)
			cRet := M->B44_CODREF
		Else
		 	cRet := M->B45_CODREF
		 Endif
	Endif
	
Elseif Alltrim(Upper(cCampo)) == "B1N_DESDOC"	
	If Inclui
		cRet := " "
		
	Else
		cRet := Posicione("BBS",1,xFilial("BBS")+B1N->B1N_TIPDOC,"BBS_DESCRI")
		
	Endif

Elseif Alltrim(Upper(cCampo)) == "BOW_DESDOC"
	If Inclui
		cRet := " "
		
	Else
		cRet := Posicione("BBS",1,xFilial("BBS")+BOW->BOW_TIPDOC,"BBS_DESCRI")
		
	Endif

Elseif Alltrim(Upper(cCampo)) == "B1N_TIPDOC"
	If !Empty(M->BOW_TIPDOC)
		cRet := M->BOW_TIPDOC
	Else
		cRet := " "
	Endif

Elseif Alltrim(Upper(cCampo)) == "B1N_NUMDOC"
	If !Empty(M->BOW_NUMDOC)
		cRet := M->BOW_NUMDOC
	Else
		cRet := " "
	Endif

Elseif Alltrim(Upper(cCampo)) == "B1N_DATDOC"
	If !Empty(M->BOW_DATDOC)
		cRet := M->BOW_DATDOC
	Else
		cRet := " "
	Endif
	
Endif
	
return cRet

User Function MSGATILHO(cCampo)
Local cRet := ''

If cCampo == 'BOW_YTIPRE'
	If M->BOW_YTIPRE == "04"
		cRet := '1'	
	Else
		If M->(BOW_CODEMP+BOW_CONEMP == '0001000000000007')
			cRet := '1'
		Else
			cRet := '0'
		Endif	
	Endif
Endif
		
Return cRet

User Function MSVALID(cCampo)

LOCAL lRet := .T.
LOCAL aCrit := {}

If UPPER(cCampo) == "B45_CODPRO"
	If Empty(M->B45_CODPRO) 
		lRet := .T.
	Else		
		If M->B45_VLRAPR > 0
			Processa({|| lRet := VldB45Pro()},"Aguarde...","Executando tarefas... ",.F.)
			
		Else
			MsgStop("Informe o valor apresentado para que seja possível valorizar o evento.")
			lRet := .F.
			
		Endif		
	Endif	
ElseIf UPPER(cCampo) == "B44_DATPAG"
	If Empty(M->B44_DATPAG)
		lRet := .T.
	Else
		If M->B44_DATPAG < dDataBase
			MsgStop("A data de pagamento não pode ser menor que a data base do sistema.")
			lRet := .F.
		Endif
	Endif
ElseIf UPPER(cCampo) == "ZZK_CODPAD"
	If (Vazio() .OR. BR4->(ExistCpo('BR4',M->ZZK_CODPAD,1)))
		lRet := .T.
	Else
		lRet := .F.
	EndIf
	
ElseIf UPPER(cCampo) == "ZZK_CODPSA"
	If (Vazio() .OR. BR8->(ExistCpo('BR8',M->ZZK_CODPAD+M->ZZK_CODPSA,1)))
		lRet := .T.
		M->ZZK_DESPRO := BR8->BR8_DESCRI
	Else
		M->ZZK_DESPRO := ""
		lRet := .F.
	Endif	
	
Endif

Return lRet

User Function VldB45Pro()
LOCAL lRet := .T.
LOCAL aCri := {}

ProcRegua(2)
ProcessMessage()

IncProc("Validando o procedimento...")
ProcessMessage()
lRet := PLSA090PRO()

If lRet .and. M->B45_STATUS == '1' // So valoriza se o procedimento for autorizado 
	IncProc("Valorizando o procedimento...")
	ProcessMessage()
	
	aCri := P001ValRe("B44","B45","B47")	
Endif

Return (lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MsDocument³ Autor ³ Sergio Silveira       ³ Data ³06/12/2000  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Amarracao entidades x documentos                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 -> Entidade                                            ³±±
±±³          ³ ExpN1 -> Registro                                            ³±±
±±³          ³ ExpN2 -> Opcao                                               ³±±
±±³          ³ ExpX1 -> Sem Funcao                                          ³±±
±±³          ³ ExpN5 -> Tipo de Operacao                                    ³±±
±±³          ³ ExpA6 -> Array de referencia retorno dos anexos ( Recno )    ³±±
±±³          ³ ExpL7 -> Flag que indica se abre as planilhas Excel          ³±±
±±³          ³          conectadas ao Protheus.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MSaudeDoc( cAlias, nReg, nOpc, xVar, nOper, aRecACB , lExcelConnect)

Local aRecAC9      := {}
Local aPosObj      := {}
Local aPosObjMain  := {}
Local aObjects     := {}
Local aSize        := {}
Local aInfo        := {}
Local aGet		   := {}
Local aTravas      := {}
Local aEntidade    := {}
Local aArea        := GetArea()
Local aExclui      := {}
Local aButtons     := {}
Local aUsButtons   := {} 
Local aChave       := {}
Local aButtPE      := {}

Local cCodEnt      := ""
Local cCodDesc     := ""
Local cNomEnt      := ""
Local cEntidade    := "" 
Local cUnico       := "" 

Local lMTCONHEC   := ExistBlock('MTCONHEC')
Local lGravou      := .F.
Local lTravas      := .T.
Local lVisual      := .T. //( aRotina[ nOpc, 4 ] == 2 ) 
Local lAchou       := .F.   
Local lRetCon      := .T.
Local lRet		   := .T.
Local lRemotLin	   := GetRemoteType() == 2 //Checa se o Remote e Linux 

Local nCntFor      := 0
Local nGetCol      := 0
Local nOpcA	       := 0
Local nScan        := 0

Local oDlg
Local oGetD
Local oGet
Local oGet2
Local oOle
Local oScroll, lRetu

Local	cQuery    := ""
Local	cSeek     := ""
Local	cWhile    := ""
Local aNoFields := {"AC9_ENTIDA","AC9_CODENT"}									      // Campos que nao serao apresentados no aCols
Local bCond     := {|| .T.}														      	// Se bCond .T. executa bAction1, senao executa bAction2
Local bAction1  := {|| MsVerAC9(@aTravas,@aRecAC9,@aRecACB,lTravas,nOper,nOpc,.F.) }	// Retornar .T. para considerar o registro e .F. para desconsiderar
Local bAction2  := {|| .F. }															      // Retornar .T. para considerar o registro e .F. para desconsiderar
Local lVisPE	:= lVisual															      // Retornar .T. para considerar o registro e .F. para desconsiderar
Local lHtml := GetRemoteType() == REMOTE_HTML														      // Retornar .T. para considerar o registro e .F. para desconsiderar
Local lTipOS := .F.
Local cLib

DEFAULT aRecAC9    		:= {}
DEFAULT aRecACB    		:= {}
DEFAULT nOper      		:= 1
DEFAULT lExcelConnect	:= .F.

PRIVATE aCols      := {}
PRIVATE aColsSPE   := {}
PRIVATE aHeader    := {}
PRIVATE INCLUI     := .F.
PRIVATE lFilAcols  := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o campo AC9_CODENT      (Nilton MK)
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SX3")
DbSetOrder(2)
If dbSeek("AC9_CODENT") .AND. SX3->X3_TAMANHO < 70
	RecLock("SX3",.F.)
	SX3->X3_TAMANHO	:= 70
    SX3->(MsUnlock())
	X31UpdTable ("AC9")	 
EndIf

//AAdd( aButtons, { "PRODUTO", { || MsDocSize( @oScroll, @oOle, aPosObjMain, aPosObj[2], @aHide ) }, STR0230 } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ponto de entrada validar o acesso a rotina quando chamada pelo menu |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("MTVLDACE")
    lRet := ExecBlock("MTVLDACE",.F.,.F.)
    If ValType(lRetCon) <> "L"
       lRet := .T.
    EndIf
    If !lRet
	    Return .F.
    EndIf	    
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ponto de entrada validar o status do registro   |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("MSDOCVST")
    lRet := ExecBlock("MSDOCVST",.F.,.F.,{cAlias,nReg})
    If ValType(lRet) <> "L"
       lRet := .T.
    EndIf
    If !lRet
	    Return .F.
    EndIf	    
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para bloquear o botão "Banco Conhecimento para alguns usuários |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		       
If lMTCONHEC
    lRetCon := ExecBlock('MTCONHEC', .F., .F.)    
	    
    If ValType(lRetCon) <> "L"
       lRetCon := .T.
    EndIf
	    
EndIf
	 
If lRetCon   
	AAdd( aButtons, { "NORMAS" , { || MsDocCall() },"Banco de Conhecimento", "Banco de Conhecimento" } )  //
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona botoes do usuario na EnchoiceBar                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock( "MSDOCBUT" ) 
	If ValType( aUsButtons := ExecBlock( "MSDOCBUT", .F., .F., { cAlias } ) ) == "A"
		AEval( aUsButtons, { |x| AAdd( aButtons, x ) } ) 	 	
	EndIf 	
EndIf 	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da nova função de banco de conhecimento-Integração com ECM/GED ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If FindFunction("FWHasGed") .And. FWHasGed(cAlias)
	FwUIGed(cAlias)
	Return .T.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona a entidade                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cEntidade := cAlias

dbSelectArea( cEntidade )
MsGoto( nReg )

aEntidade := MsRelation()

nScan := AScan( aEntidade, { |x| x[1] == cEntidade } )

lAchou := .F. 

If Empty( nScan ) 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza a chave unica pelo SX2                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	SX2->( dbSetOrder( 1 ) ) 
	If SX2->( dbSeek( cEntidade ) )  
	
		If !Empty( SX2->X2_UNICO )       
		   
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Macro executa a chave unica                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
			cUnico   := SX2->X2_UNICO 
			cCodEnt  := &cUnico 
			cCodDesc := Substr( AllTrim( cCodEnt ), TamSX3("A1_FILIAL")[1] + 1 )  
			lAchou   := .T. 
				 
		EndIf 					
	
	EndIf 	   

Else 

	aChave   := aEntidade[ nScan, 2 ]
	cCodEnt  := MaBuildKey( cEntidade, aChave ) 
	
	cCodDesc := AllTrim( cCodEnt ) + "-" + Capital( Eval( aEntidade[ nScan, 3 ] ) )    
	
	lAchou := .T. 
 
EndIf 
	
If lAchou 	

	cCodEnt  := PadR( cCodEnt, TamSX3("AC9_CODENT")[1] )
	
	dbSelectArea("AC9")
	dbSetOrder(2)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Prepara variaveis para FillGetDados                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	#IFDEF TOP
		cQuery += "SELECT AC9.*,AC9.R_E_C_N_O_ AC9RECNO FROM " + RetSqlName( "AC9" ) + " AC9 "
		cQuery += "WHERE "
		cQuery += "AC9_FILIAL='" + xFilial( "AC9" )     + "' AND "
		cQuery += "AC9_FILENT='" + xFilial( cEntidade ) + "' AND "
		cQuery += "AC9_ENTIDA='" + cEntidade            + "' AND "
		cQuery += "AC9_CODENT='" + cCodEnt              + "' AND "				
		cQuery += "D_E_L_E_T_<>'*' ORDER BY " + SqlOrder( AC9->( IndexKey() ) )
	#ENDIF 
	cSeek  := xFilial( "AC9" ) + cEntidade + xFilial( cEntidade ) + cCodEnt
	cWhile := "AC9->AC9_FILIAL + AC9->AC9_ENTIDA + AC9->AC9_FILENT + AC9->AC9_CODENT"
	
	
	Do Case
	Case nOper == 1

		SX2->( dbSetOrder( 1 ) )
		SX2->( DbSeek( cEntidade ) )

		cNomEnt := Capital( X2NOME() )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Montagem do Array do Cabecalho                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SX3")
		dbSetOrder(2)
		dbSeek("AA2_CODTEC")
		aadd(aGet,{X3Titulo(),SX3->X3_PICTURE,SX3->X3_F3})
		
		// Tratamento dos campos Memo na montagem do FillGetDados
		SX3->(DbSetOrder(1))
		SX3->(DbGoTop())
		SX3->(DbSeek("AC9"))
		While !SX3->(Eof()) .And. Alltrim(SX3->X3_ARQUIVO) == "AC9"
			If Alltrim(SX3->X3_TIPO) == "M" .And. SX3->X3_CONTEXT == "V" 
				Aadd(aNoFields,SX3->X3_CAMPO)
			Endif
			SX3->(DbSkip())
		EndDo

		dbSelectArea("AC9")
		dbSetOrder(2)
		dbGoTop()
		
		If Tcsrvtype()=="AS/400"  //AS/400 para TOP2 e iSeries para AS/400 TOP4
			FillGetDados(nOpc,"AC9",2,cSeek,{|| &cWhile },{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,,/*bMontCols*/,/*Inclui*/,/*aHeaderAux*/,/*aColsAux*/,/*bAfterCols*/,/*bBeforeCols*/)
			
        Else
        	FillGetDados(nOpc,"AC9",2,cSeek,{|| &cWhile },{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,/*Inclui*/,/*aHeaderAux*/,/*aColsAux*/,/*bAfterCols*/,/*bBeforeCols*/)
        	bAction1 := {|| MsVerAC9(@aTravas,@aRecAC9,@aRecACB,lTravas,nOper,nOpc,.T.) }
        	aColsSPE := aClone(aCols)
        	aCols	:= {}
        	aHeader	:= {}
        	aTravas	:= {}
        	aRecACB := {}
        	aRecAC9 := {}
        	FillGetDados(nOpc,"AC9",2,cSeek,{|| &cWhile },{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,/*Inclui*/,/*aHeaderAux*/,/*aColsAux*/,/*bAfterCols*/,/*bBeforeCols*/)
        	If Len(aColsSPE) > Len(aCols)
        		lFilAcols := .T.
        	Endif
        Endif
		If ( lTravas )

			aSize := MsAdvSize( )

			aObjects := {}	
			AAdd( aObjects, { 100, 100, .T., .T. } )

			aInfo       := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 0, 0 }
			aPosObjMain := MsObjSize( aInfo, aObjects )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Resolve os objetos lateralmente                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aObjects := {}	            		

			AAdd( aObjects, { 150, 100, .T., .T. } )
			AAdd( aObjects, { 100, 100, .T., .T., .T. } )

			aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 4, 4 }
			aPosObj := MsObjSize( aInfo, aObjects, .T. , .T. )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Resolve os objetos da parte esquerda                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aInfo   := { aPosObj[1,2], aPosObj[1,1], aPosObj[1,4], aPosObj[1,3], 0, 4, 0, 0 }

			aObjects := {}
			AAdd( aObjects, { 100,  53, .T., .F., .T. } )
			AAdd( aObjects, { 100, 100, .T., .T. } )

			aPosObj2 := MsObjSize( aInfo, aObjects )

			aHide := {}
            
			INCLUI  := .T.
			lVisual := .f.
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Botao do Wizard de inclusao e associacao                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			Aadd(aButtons, {"MPWIZARD",{|| PLSDOcs("BOW",BOW->(RecNo()),3) },"Inclusão Rápida"})

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ PE usado para impedir que usuarios não autorizados e com status diferente 
			//  de somente "visualiza" possa Excluir o conhecimento.
			// Se a Função retornar .F. o usuario pode incluir, excluir. Se voltar .T. 
			// somente pode incluir.
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   			lVisPE	:= lVisual         

			If ExistBlock("MSDOCEXC") .AND. lVisual = .F.
				lVisPE := iF(ValType(lretu:=ExecBlock("MSDOCEXC",.F.,.F.))=='L',lRetu,lVisual)
			EndIf 

			If ExistBlock("MTENCBUT")
		    	aButtPE := ExecBlock("MTENCBUT",.F.,.F.,{aButtons})
			    If ValType(aButtPE) == "A" 
				    aButtons := aButtPE                            
			    EndIf
			EndIf 

			DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 TO aSize[6],aSize[5] OF oMainWnd PIXEL

			@ 0, 0 BITMAP oBmp RESOURCE "PROJETOAP" of oDlg SIZE 100,1200 PIXEL

			@ aPosObj2[1,1],aPosObj2[1,2] MSPANEL oPanel PROMPT "" SIZE aPosObj2[1,3],aPosObj2[1,4] OF oDlg CENTERED LOWERED //"Botoes"

			nGetCol := 40

			@ 004,005 SAY "Entidade"        SIZE 040,009 OF oPanel  PIXEL // "Entidade" //
			@ 013,005 GET oGet  VAR cNomEnt  SIZE 090,009 OF oPanel PIXEL WHEN .F.	

			@ 027,005 SAY "Descricao"        SIZE 040,009 OF oPanel PIXEL // "Codigo" //
			@ 036,005 GET oGet2 VAR cCodDesc SIZE aPosObj2[1,3] - 60,009 OF oPanel PIXEL WHEN .F.	

			oGetd:=MsGetDados():New(aPosObj2[2,1],aPosObj2[2,2],aPosObj2[2,3],aPosObj2[2,4], nOpc,"MsDocLok","AlwaysTrue",,!lVisPE,NIL,NIL,NIL,1000)
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ A classe scrollbox esta com o size invertido...                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oScroll := TScrollBox():New( oDlg, aPosObj[2,1], aPosObj[2,2], aPosObj[2,4],aPosObj[2,3])
            
			If lHtml         
				oOle := TPaintPanel():new(0,0,aPosObj2[2,3]+300,aPosObj2[2,4],oScroll)              
		   		oOle:Hide()
		  	Else
				oOle    := TOleContainer():New( 0, 0, aPosObj2[2,3]+300,aPosObj2[2,4],oScroll, , "" )
				oOle:Hide()
            EndIf

			oScroll:Cargo := 1                                                                                                                                                                                       
			GetRemoteType( @cLib )
			lTipOS := iif ('MAC' $ clib,.t.,.f.)                                                                                                                                                                                       
       
  			If !lRemotLin .or. lTipOs
  			   if !lTipOs
					@  17.5, aPosObj2[1,3] - 40  BUTTON oButPrev PROMPT "Preview" SIZE 035,012 FONT oDlg:oFont ACTION     ( If( !Empty( AllTrim( GDFieldGet( "AC9_OBJETO" ) ) ), ( oGetd:oBrowse:SetFocus(), MsFlPreview( oOle, @aExclui ) ), .T. ) ) OF oPanel PIXEL     // 
				EndIf
				If lExcelConnect // Tratamento para abertura de Planilhas Excel conactadas do Protheus - SIGAPCO
					@ 34.5, aPosObj2[1,3] - 40  BUTTON oButOpen PROMPT "Abrir"   SIZE 035,012 FONT oDlg:oFont ACTION ( If( !Empty( AllTrim( GDFieldGet( "AC9_OBJETO" ) ) ), ( oGetd:oBrowse:SetFocus(), PcoXlsOpen( @oOle, @aExclui ) ), .T. ) ) OF oPanel PIXEL     //
				Else
					@ 34.5, aPosObj2[1,3] - 40  BUTTON oButOpen PROMPT "Abrir"   SIZE 035,012 FONT oDlg:oFont ACTION ( If( !Empty( AllTrim( GDFieldGet( "AC9_OBJETO" ) ) ), ( oGetd:oBrowse:SetFocus(), MsDocOpen( @oOle, @aExclui ) ), .T. ) )  OF oPanel PIXEL     //"Abrir"
				EndIf
			Else
				@ 34.5, aPosObj2[1,3] - 40  BUTTON oButOpen PROMPT "Abrir"   SIZE 035,012 FONT oDlg:oFont ACTION ( If( !Empty( AllTrim( GDFieldGet( "AC9_OBJETO" ) ) ), ( oGetd:oBrowse:SetFocus(), MsDocOpen( @oOle, @aExclui ) ), .T. ) )  OF oPanel PIXEL     //"Abrir"
			EndIf                 
			
			If lHtml
				oButOpen:cCaption := "Download"          
				oButPrev:Hide()
			EndIf                
			                                                                                    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Adiciona ao array dos objetos que devem ser escondidos                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			AAdd( aHide, oPanel )
			AAdd( aHide, oGetD  )
			If !lRemotLin
				AAdd( aHide, oButPrev )
			EndIf
			AAdd( aHide, oButOpen ) 		

			n := 1

			ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpcA:=1,If(oGetd:TudoOk(),oDlg:End(),nOpcA:=0)},{||oDlg:End()},, aButtons )

			If ( nOpcA == 1 ) .And. !lVisual 
				Begin Transaction
					lGravou := MsDocGrv( cEntidade, cCodEnt, aRecAC9 , , lFilAcols ) 
					If ( lGravou )
						EvalTrigger()
						If ( __lSx8 )
							ConfirmSx8()
						EndIf
						If ExistBlock( "MSDOCOK" ) 
			    			ExecBlock("MSDOCOK",.F.,.F.,{cAlias, nReg})
						EndIf 	
					EndIf
				End Transaction
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exclui os temporarios      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty( aExclui )
				MsDocExclui( aExclui, .F. )
			EndIf 			

		EndIf
		If ( __lSx8 )
			RollBackSx8()
		EndIf
		For nCntFor := 1 To Len(aTravas)
			dbSelectArea(aTravas[nCntFor][1])
			dbGoto(aTravas[nCntFor][2])
			MsUnLock()
		Next nCntFor

	Case nOper == 3
		MsDocGrv( cEntidade, cCodEnt, , .T., lFilAcols )
	Case nOper == 4 	
		MsDocArray( cEntidade, cCodEnt, , , , ,@aRecACB )	
	EndCase

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se nao inclusao, permite a exibicao de mensagens em tela               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOper == 1
		Aviso( "Atencao !", "Nao existe chave de relacionamento definida para o alias " + cAlias, { "Ok" } ) 	 //######
	EndIf

EndIf

RestArea( aArea )

Return(lGravou)

/*

Retorna o titular da familia

*/
User Function MSTitular(cMatricula)
LOCAL cCpf			:= "" 
LOCAL cNome		:= ""
LOCAL cFornec		:= ""
LOCAL cBanco 		:= ""
LOCAL cAgenc 		:= ""
LOCAL cConta 		:= ""
LOCAL cContaDV 	:= ""
LOCAL aRet 		:= {"",; 					// 1-Matricula
						"",;					// 2-CPF
						{"","","","",""},; 	// 3-Dados do fornecedor
						{"","","","",""},; 	// 4-Dado do cliente
						0,;					 	// 5-registro
						"",;					// 6-Email do titular
						""}						// 7-Telefone do titular
						
LOCAL nRecno		:= 0
LOCAL cTitular 		:= GetNewPar("MV_PLCDTIT", "T")
LOCAL cTelefo		:= ""
LOCAL cEmail		:= ""
LOCAL aArea		:= GetArea()
LOCAL aPE			:= {}
		
BA1->(dbSetOrder(2))
BA3->(dbSetorder(1))

If BA1->( dbSeek(xFilial("BA1")+cMatricula) )
	cCpf := "" 
	If  u_MBIsTitular(cMatricula)
		cCpf 			:= BA1->BA1_CPFUSR			
		cNome			:= Alltrim(BA1->BA1_NOMUSR)	
		cMatricula 	:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
		cTelefo		:= BA1->BA1_TELEFO
		cEmail			:= BA1->BA1_EMAIL		
		nRecno := BA1->( Recno() )		
		
		If Existblock("MSTITUL01")
			aPE := Execblock("MSTITUL01",.f.,.f.,{cCpf,cMatricula,cTelefo,cEmail,nRecno,cNome})
					
			If Len(aPE) > 0
				cCPF 			:= aPE[1]
				cMatricula 	:= aPE[2]
				cTelefo		:= aPE[3]
				cEmail			:= aPE[4]
				cNome			:= aPE[5]				
			Endif
		Endif
	Else
		cSql := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR, BA1_EMAIL, BA1_TELEFO, R_E_C_N_O_ RECNO FROM "+RetSqlname("BA1")
		cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
		cSql += " AND BA1_CODINT = '"+BA1->BA1_CODINT+"' "
		cSql += " AND BA1_CODEMP = '"+BA1->BA1_CODEMP+"' "
		cSql += " AND BA1_MATRIC = '"+BA1->BA1_MATRIC+"' "
		cSql += " AND BA1_TIPUSU = '"+cTitular+"' "
		cSql += "AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSql, "TRB1")
		
		While !TRB1->( Eof() )	
			If u_MBIsTitular(TRB1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				cCpf := TRB1->BA1_CPFUSR				
				cNome			:= Alltrim(BA1->BA1_NOMUSR)
				cMatricula 	:= TRB1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				cTelefo		:= TRB1->BA1_TELEFO
				cEmail			:= TRB1->BA1_EMAIL				
				nRecno := TRB1->(RECNO)
				
				If Existblock("MSTITUL01")
					aPE := Execblock("MSTITUL01",.f.,.f.,{cCpf,cMatricula,cTelefo,cEmail,nRecno,cNome})
					
					If Len(aPE) > 0
						cCPF 			:= aPE[1]
						cMatricula 	:= aPE[2]
						cTelefo		:= aPE[3]
						cEmail			:= aPE[4]	
						cNome			:= aPE[5]			
					Endif
				Endif
				
				Exit
			Endif		
			TRB1->( dbSkip() )
		Enddo
		
		TRB1->( dbCloseArea() )
	Endif

	If !Empty(cCpf)
		SA2->( dbSetorder(3) )
		If SA2->( dbSeek(xFilial("SA2")+cCpf))
			cFornec:= SA2->A2_COD
			cBanco := SA2->A2_BANCO
			cAgenc := SA2->A2_AGENCIA
			cConta := SA2->A2_NUMCON
			If SA2->(FieldPos("A2_DVCONT1")) > 0
				cContaDV := SA2->A2_DVCONT1
			Else
				cContaDV := ""
			Endif
		Endif 
	Endif
	
	aRet := {cMatricula,cCpf,{cFornec,cBanco,cAgenc,cConta,cContaDV},{},nRecno,cEmail,cTelefo,cNome}
Endif		

RestArea(aArea)

Return(aRet)


/*

Retorna se o beneficiário é o titular ou não.

*/
User Function MBIsTitular(cMatricula)
LOCAL cTitular 	:= GETNEWPAR("MV_MBTIT", "00")
LOCAL cStrTit		:= ""
LOCAL lRet := .F.
If !Empty(cMatricula)
	cStrTit := Substr(cMatricula,atTipReg[1],atTipReg[2])
	
	If cStrTit == cTitular
		lRet := .T.
	Endif
Endif

Return(lRet)

User Function MBIsConjuge(cMatricula)
LOCAL cConjuge 	:= GETNEWPAR("MV_MBCONJ", "01")
LOCAL cStrCon		:= ""
LOCAL lRet := .F.
If !Empty(cMatricula)
	cStrCon := Substr(cMatricula,atTipReg[1],atTipReg[2])
	
	If cStrCon == cConjuge
		lRet := .T.
	Endif
Endif

Return(lRet)

// Função para validar campos de regra
User Function MS_REGRA(cConteudo)
LOCAL bErro 	:= ErrorBlock({ |e| MSERROR(e)})
LOCAL lRet		:= .T.

PRIVATE __x_mslibError_x := .T.

If &cConteudo
	
Else

Endif

ErrorBlock(bErro)

If ! __x_mslibError_x
	lRet := .F.
Endif

Return( lRet )

/* Erro controlado */
User Function MSERROR(e)
If e:gencode > 0  
	If __x_mslibError_x	
		msgStop("Formula inconsistente"+chr(10)+chr(13)+; //
				"A expressão digitada possui erro e não pode ser gravada: "+e:Description) //
		__x_mslibError_x := .F.
	Endif
EndIf

Return

// Função para incrementar campos no grid
User Function MS_INCRE(cAlias,cCampo,aCriterios,cWhere)
LOCAL cSql 			:= ""
LOCAL cCampoFilial 	:= cAlias+"_FILIAL"
LOCAL cSequen			:= ""
LOCAL nCnt 			:= 0

cSql := "SELECT Max("+cCampo+") VAL_MAX FROM "+RetSqlName(cAlias)+" Where "+cCampoFilial+" = '"+xFilial(cAlias)+"' "
For nCnt := 1 to len(aCriterios)
	cSql += "AND "+aCriterios[nCnt][1]+aCriterios[nCnt][2]+"'"+aCriterios[nCnt][3]+"' "
Next
cSql += "AND D_E_L_E_T_ = ' ' "

If !Empty(cWhere)
	cSql += cWhere
Endif
PlsQuery(cSql, "TRB1")

If TRB1->( Eof() )
	cSequen := "01"
Else
	cSequen := Soma1(TRB1->VAL_MAX)
Endif

TRB1->( dbCloseArea() )

Return cSequen



Return

// Calcula e valida o tamanho de uma string dinamica depois de pronta
User Function MS_LENSTR(cTexto,nMaxLen)


Return .T.

User Function PrimeiroNome(cNome)
LOCAL nAt := At(" ", cNome)

cNome := Substr(cNome,1, nAt)

Return(cNome)

User Function MsCleanStr(cString)

cString := StrTran(cString,"!","")
cString := StrTran(cString,"@","")
cString := StrTran(cString,"#","")
cString := StrTran(cString,"$","")
cString := StrTran(cString,"%","")
cString := StrTran(cString,"&","")
cString := StrTran(cString,"*","")
cString := StrTran(cString,"(","")
cString := StrTran(cString,")","")
cString := StrTran(cString,"-","")
cString := StrTran(cString,"_","")
cString := StrTran(cString,"+","")
cString := StrTran(cString,"=","")
cString := StrTran(cString,"[","")
cString := StrTran(cString,"]","")
cString := StrTran(cString,"{","")
cString := StrTran(cString,"}","")
cString := StrTran(cString,"|","")
cString := StrTran(cString,"\","")
cString := StrTran(cString,":","")
cString := StrTran(cString,";","")
cString := StrTran(cString,",","")
cString := StrTran(cString,".","")
cString := StrTran(cString,"<","")
cString := StrTran(cString,">","")
cString := StrTran(cString,"?","")
cString := StrTran(cString,"/","")
cString := StrTran(cString," ","")
cString := StrTran(cString,"  ","")
cString := Alltrim(cString)

Return cString

User Function MBTEL(cTelefone)
LOCAL aFormats := {	{8,  "99999999"		, "@R 9999-9999", {0,4,4}},; 			// 08 | 9272-4102
						{10, "9999999999"		, "@R (99) 9999-9999", {2,4,4}},; 		// 10 | (27)9272-4102
						{11, "99999999999"	, "@R (999) 9999-9999", {3,4,4}},;		// 11 | (027)9272-4102 - Somente se começar com zero
						{09, "999999999"		, "@R 99999-9999",{0,5,4}},; 			// 09 | 99272-4109
						{11, "99999999999"	, "@R (99) 99999-9999", {2,5,4}},;		// 11 | (27) 99272-4109
						{12, "999999999999"	, "@R (999) 99999-9999",{3,5,4}}}		// 12 | (027) 99272-4109
LOCAL nCnt := 0
LOCAL aRet := {"","",""}

cTelefone := Alltrim(u_LimpaTel(cTelefone))
For nCnt := 1 to Len(aFormats)
	If Len(cTelefone) == aFormats[nCnt][1]
		If  nCnt == 3 .and. Substr(cTelefone,0,1) <> "0"
			Loop
		Endif
		
		// DDD
		If aFormats[nCnt][4][1] > 0
			aRet[1] := substr(cTelefone,0,aFormats[nCnt][4][1])
		Else
			aRet[1] := ""
		Endif
		
		// Prefixo
		aRet[2] := substr(cTelefone,;
							aFormats[nCnt][4][1]+1,;
							aFormats[nCnt][4][2])
		
		// Sufixo
		aRet[3] := substr(cTelefone,;
							(aFormats[nCnt][4][1]+1)+aFormats[nCnt][4][2])
							
		Exit
	Endif
Next
		


Return aRet


User Function LimpaTel(cTelefone)
LOCAL nCnt := 0
LOCAL cChar := ""
LOCAL cToken := ""

For nCnt := 1 To Len(cTelefone)
	cChar := Substr(cTelefone, nCnt, 1)
		
	If cChar $ "!@#$%^&*()_+-=[]{}/\|?.,<>:;''"
		Loop
	Elseif cChar $ '""'
		Loop
	Endif
	
	cToken += cChar
Next

If !Empty(cToken)
	cTelefone := cToken
Endif

Return cTelefone

User Function MSExplMatr(cMatricula, cTipo)
LOCAL cCodInt := ""
LOCAL cCodEmp := ""
LOCAL cMatric := ""
LOCAL cTipReg := ""
LOCAL cDigito := ""
LOCAL aRet := {.F.,cCodInt,cCodEmp,cMatric,cTipReg,cDigito,"Matricula inválida"}
DEFAULT cTipo := 1 

If Empty(cMatricula)
	Return(aRet)
Endif

If cTipo == 1
	If Len(Alltrim(cMatricula)) < 15
		Return(aRet)
	Endif
Else
	If Len(Alltrim(cMatricula)) < 14
		Return(aRet)
	Endif
Endif

cCodInt := Substr(cMatricula,atCodOpe[1],atCodOpe[2])
cCodEmp := Substr(cMatricula,atCodEmp[1],atCodEmp[2])
cMatric := Substr(cMatricula,atMatric[1],atMatric[2])
If cTipo == 1 
	If Len(cMatricula) >= 15
		cTipReg := Substr(cMatricula,atTipReg[1],atTipReg[2])
	Endif
	If Len(cMatricula) >= 17
		cDigito := Substr(cMatricula,atDigito[1],atDigito[2])
	Endif
Endif

aRet := {.T.,cCodInt,cCodEmp,cMatric,cTipReg,cDigito,""}

Return(aRet)

/********************************

Desmembra a estrutura do titulo a partir de uma chave concatenada

********************************/
User Function MSExplTit(cBoletoChave)
LOCAL cPrefixo	:= ""
LOCAL cNumero	 	:= ""
LOCAL cParcela	:= ""
LOCAL cTipo		:= ""
LOCAL aRet 		:= {.F.,cPrefixo, cNumero, cParcela, cTipo,"Titulo inválido"}

LOCAL nTmPrefix	:= TamSx3("E1_PREFIXO")[1] 
LOCAL nTmNumero	:= TamSx3("E1_NUM")[1]
LOCAL nTmParcela	:= TamSx3("E1_PARCELA")[1]
LOCAL nTmTipo		:= TamSx3("E1_TIPO")[1]

LOCAL nPsPrefix	:= 1
LOCAL nPsNumero	:= (nPsPrefix+nTmPrefix)
LOCAL nPsParcela	:= (nPsNumero+nTmNumero) //PLS000080    DP 
LOCAL nPsTipo		:= (nPsParcela+nTmParcela)

If Empty(cBoletoChave)
	Return(aRet)
Endif

cPrefixo	:= Substr(cBoletoChave,nPsPrefix,nTmPrefix)
cNumero	 	:= Substr(cBoletoChave,nPsNumero,nTmNumero)
cParcela	:= Substr(cBoletoChave,nPsParcela,nTmParcela)
cTipo		:= Substr(cBoletoChave,nPsTipo,nTmTipo)

aRet 		:= {.T.,cPrefixo, cNumero, cParcela, cTipo,"Titulo inválido"}

Return(aRet)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³login_beneficiario³Autor³ Mobile Saúde      ³ Data ³22.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Retorna estrutura de critica							   |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MBSetFault(oObj, cCodCri, cDesCri,lLock,cLockKey, cSolucao, cReal_motivo, lContato)
LOCAL nCnt 			:= 1
DEFAULT cDesCri 		:= u_ms_login_alertas(cCodCri)
DEFAULT lLock 		:= .F.
DEFAULT cLockKey 		:= ""
DEFAULT cSolucao		:= ""
DEFAULT cReal_motivo := ""
DEFAULT lContato 		:= .T.

oObj:retorno_status 	:= .F.
oObj:retorno_dados 	:= {}     
		  
Aadd(oObj:retorno_criticas,WsClassNew( "mb_critica"))	 
oObj:retorno_criticas[nCnt]:critica_codigo				:= cCodCri
oObj:retorno_criticas[nCnt]:critica_descricao_problema	:= cDesCri

oObj:retorno_criticas[nCnt]:critica_solucao_problema		:= cSolucao
oObj:retorno_criticas[nCnt]:critica_real_motivo			:= cReal_motivo
oObj:retorno_criticas[nCnt]:critica_autoriza_contato		:= lContato

// Remove o semaforo.
If lLock
	UnLockByName(cLockKey, .T., .T., .F.)
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³PLsLogFil ³ Autor ³ Eduardo Motta         ³ Data ³ 12/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava um log generico                             		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MSLogFil(cLogErro,cLog, lIgnora) //,lBuffer,lAjArq,lQLinha,cDirMod,lCDir, lIgnora)
LOCAL nHdlLog	:= 0
LOCAL nPos      := 0
LOCAL nI        := 0
LOCAL cStrGrv   := ""
LOCAL cDesLog	:= ""
LOCAL cArqlog 	:= PLSMUDSIS( cLog )
LOCAL lMudDir   := Iif( At( PLSMUDSIS("\"),PLSMUDSIS(cLog) ) > 0 ,.F.,.T.)
LOCAL cDate		:= DtoS(Date())+"\"
DEFAULT lBuffer := .F.
DEFAULT lAjArq 	:= .F.
DEFAULT lQLinha := .T.
DEFAULT cDirMod	:= PLSMUDSIS( "\log_mobile\" )
DEFAULT lCDir	:= .T.
DEFAULT lIgnora := .F.

If lIgnora
	Return()
Endif

// Verifica se a gravação do log está ativada
If !u_MSLGPLS()
	Return()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Se permitir incluir data no diretorio
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If !lCDir
	cDate := ""
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao existe o diretorio de log's do modulo cria						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ExistDir(cDirMod+cDate)
	If !ExistDir(cDirMod)
		If MakeDir( cDirMod ) <> 0
			cONout("Impossivel criar diretorio ["+cDirMod+"]")
			cDirMod := ""
		EndIf
	EndIf
	If !Empty(cDirMod)
		cDirMod := PLSMUDSIS( cDirMod+cDate )
		If MakeDir( cDirMod ) <> 0
			cONout("Impossivel criar diretorio ["+cDirMod+"]")
			cDirMod := ""
		EndIf
	EndIf
else
	cDirMod := PLSMUDSIS( cDirMod+cDate )
endIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Ajusta nome do arquivo de log
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if lAjArq
	cArqlog := PLSMUDSIS( PLSAJUARQ( cArqlog ) )
endIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Nome do arquivo mais diretorio
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
if lMudDir
	cArqlog := PLSMUDSIS( cDirMod+cLog )
endIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Gravacao
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
nPos := aScan(aBuffer,{|x| allTrim(upper(x[1])) == allTrim(upper(cLog))})

if lBuffer
   if nPos > 0
      if len(aBuffer[nPos,2]) > 1000
         lBuffer := .F.
      endIf
   endIf
endIf

if !lBuffer

   if nPos > 0

      cDesLog := ""

      for nI := 1 to len(aBuffer[nPos,2])

        if lQLinha
	         cDesLog += aBuffer[nPos,2,nI]+chr(13)+chr(10)
	     else
	         cDesLog += aBuffer[nPos,2,nI]
	     endIf

   		  //verificar se a string esta maior que 1mb
   	 	  if len(cDesLog) > 1000000

		      if !file(cArqLog)
			       if (nHdlLog := fCreate(cArqlog,0)) == -1
					   cONout("Impossivel criar arquivo ["+cArqlog+"]")
					   return
				   endIf
			   else
				   if (nHdlLog := fOpen(cArqlog,2)) == -1
					   cONout("Impossivel abrir arquivo ["+cArqlog+"]")
					   return
				   endIf
			   endIf

			   fSeek(nHdlLog,0,2)

				fWrite(nHdlLog,cDesLog)

			   fClose(nHdlLog)

   		  		cDesLog := ''
   		  endIf

      next

      cLogErro 		  	:= cDesLog + cLogErro
      aBuffer[nPos,2]	:= {}
   endIf

   if !File(cArqLog)
       if (nHdlLog := fCreate(cArqlog,0)) == -1
		   cONout("Impossivel criar arquivo ["+cArqlog+"]")
		   return
	   endIf
   else
	   if (nHdlLog := fOpen(cArqlog,2)) == -1
		   cONout("Impossivel abrir arquivo ["+cArqlog+"]")
		   return
	   endIf
   endIf

   fSeek(nHdlLog,0,2)

   if lQLinha
	   fWrite(nHdlLog, cLogErro + chr(13) + chr(10))
   else
	   fWrite(nHdlLog,cLogErro)
   endIf

   fClose(nHdlLog)
else
   if nPos > 0
      aadd(aBuffer[nPos,2],cLogErro)
   else
      aadd(aBuffer,{cLog,{cLogErro}})
   endIf
endIf

return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLSLGPLS   ³ Autor ³ xxxxxx				 ³ Data ³ 26.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Log															 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MSLGPLS()
STATIC lPLSLGPLS := NIL

If lPLSLGPLS == NIL
	lPLSLGPLS := (GetNewPar("MV_MSXLOG","0")=="1")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return lPLSLGPLS

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MS_CRF   ³ Autor ³ xxxxxx				 ³ Data ³ 26.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Returna comando de final de linha								 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MS_CRF()
Return(CHR(13)+CHR(10))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PlsSomaHor  ºAutor  ³Geraldo Felix Junior       º Data ³  12/22/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ soma horario                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PlsDataHoraEnvio(dDataRef,cOldHor, lSomaOuSub ,cTempo, lUtil)
LOCAL cNewHor := ""
LOCAL aRet	  := {}

If lSomaOuSub
	cNewHor := PlsSomaHor(cOldHor,cTempo)
	
	// Ao adicionar o tempo a hora passou da meia noite, desta forma, adiciona um dia.
	If cOldHor < "00:00" .and. cNewHor > "00:00" 
		dDataRef++
	Endif
Else
	cNewHor := u_MSSubHor(cOldHor,cTempo)
	
	// Ao reduzir o tempo a hora voltou a ser anterior a meia noite, desta forma, retorna um dia.
	If cOldHor > "00:00" .and. cNewHor < "00:00" 
		dDataRef++
	Endif
Endif

aRet := {dDataRef,cNewHor}

Return(aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PlsSubHor    ºAutor  ³Microsiga           º Data ³  07/08/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula diferenca entre dois valores de horas                 º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MSSubHor(cHor1,cHor2)
LOCAL cHora := Space(05)
LOCAL nMin1 := 0
LOCAL nMin2 := 0
LOCAL nMin  := 0
LOCAL nHor  := 0
nMin1 := (Val(SubStr(cHor1,1,2))*60)+Val(SubStr(cHor1,4,2))
nMin2 := (Val(SubStr(cHor2,1,2))*60)+Val(SubStr(cHor2,4,2))
nHor  := Int((nMin2 - nMin1) / 60)
nMin  := (  ( (nMin2 - nMin1) / 60 ) - nHor   )  * 60

If nHor < 0
	nHor := (nHor*-1)
Endif 
If nMin < 0
	nMin := (nMin*-1)
Endif

cHora := StrZero(nHor,2)+":"+StrZero(nMin,2)

Return cHora

User Function MSGravaBX1(cAlias, nRecno, cTipo, cRotina, lws, cCampo, cOld, cNew, cUsuario)
LOCAL cSeq := PLBX1NEW()
LOCAL cType01 := ValType(&(cAlias)->(cCampo))

BX1->(RecLock("BX1",.T.))
	BX1->BX1_FILIAL   := xFilial("BX1")
	BX1->BX1_SEQUEN   := cSeq
	BX1->BX1_ALIAS    := cAlias
	BX1->BX1_RECNO    := StrZero(nRecno,Len(BX1->BX1_RECNO))
	BX1->BX1_TIPO     := cTipo
	BX1->BX1_USUARI   := cUsuario
	BX1->BX1_DATA     := Date()
	BX1->BX1_HORA     := Time()
	BX1->BX1_ROTINA := cRotina
	If !lws
		BX1->BX1_ESTTRB   := GetComputerName()
	Endif	
BX1->(MsUnLock())

BX2->(RecLock("BX2",.T.))
	BX2->BX2_FILIAL   := xFilial("BX2")
	BX2->BX2_SEQUEN   := BX1->BX1_SEQUEN
	BX2->BX2_CAMPO    := cCampo
	BX2->BX2_TITULO   := Posicione("SX3",2,AllTrim(cCampo),"X3_TITULO")

	If     cType01 == "C"
		BX2->BX2_ANTVAL   := cOld
		BX2->BX2_NOVVAL   := cNew
	ElseIf cType01 == "N"
		BX2->BX2_ANTVAL   := Str(cOld,17,4)
		BX2->BX2_NOVVAL   := Str(cNew,17,4)
	ElseIf cType01 == "D"
		BX2->BX2_ANTVAL   := dtoc(cOld)
		BX2->BX2_NOVVAL   := dtoc(cNew)
	Endif
BX2->(MsUnLock())

Return()  

User Function MontaSqlData(cCampo,cDesc,lVirgula)
LOCAL cSql := ""
DEFAULT lVirgula := .T.

cSql +=  " CASE "
cSql +=  " WHEN "
cSql +=  " "+cCampo+" = '"+SPACE(08)+"' " 
cSql +=  " THEN "
cSql +=  " '19500101' "       
cSql +=  " WHEN "
cSql +=  " ( "
cSql +=  " "+cCampo+" < '19000101' "  
cSql +=  " OR "+cCampo+" >= '20501231' "
cSql +=   " ) "
cSql +=   " THEN "
cSql +=  " '19500101' " 
cSql +=   " ELSE "
cSql +=  " "+cCampo+" " 
cSql +=  " END "
cSql +=  " as "+cDesc+" "

If lVirgula
   cSql += ", "
Endif   

Return(cSQL)
