#INCLUDE "TOTVS.CH"
#INCLUDE "XMLXFUN.CH"
//#INCLUDE "plsa973.ch"
#INCLUDE "PLSMGER.CH"

#DEFINE cEnt chr(10)+chr(13)

//Define de nome de arquivos
#DEFINE TISVERS GetNewPar("MV_TISSVER","2.02.03")
//Define numeracao dos objetos de hash
#define HASH_TREXE 1

// Define de pastas
STATIC cDirRaiz	   := PLSMUDSIS( GetNewPar("MV_TISSDIR","\TISS\") )
STATIC cDirCaiEn   := PLSMUDSIS( cDirRaiz+"CAIXAENTRADA\" )
STATIC cDirUpload  := PLSMUDSIS( cDirRaiz+"UPLOAD\" )
STATIC cDirUpManu  := PLSMUDSIS( cDirRaiz+"UPLOAD\MANUAL\" )
STATIC cDirBkp 	   := PLSMUDSIS( cDirRaiz+"UPLOAD\BACKUP\")
STATIC aRecnos	   := {}

//Objetos de auxilio para processamento de criticas
STATIC __xTrtExe	:= NIL //Utilizado pela critica X55

/*/{Protheus.doc} CABA974
Rotina para conferencia da importacao XML.
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
User Function CABA974()
	LOCAL nOpca		:= 0
	LOCAL nI 		:= 1
	LOCAL nJ 		:= 1
	LOCAL cStyle 	:= ""
	LOCAL cReg	 	:= ""
	LOCAL lRet		:= .f.
	LOCAL oDlg		:= nil
	LOCAL oDlgReg	:= nil
	LOCAL oReg		:= nil
	LOCAL aButtons	:= {}
	LOCAL aSize 	:= {}
	LOCAL aObjects 	:= {}
	LOCAL aInfo		:= {}
	LOCAL aPosObj	:= {}
	LOCAL bOK      	:= {|| nOpca := 1, oDlg:End() }
	LOCAL bCancel  	:= {|| nOpca := 2, oDlg:End() }
	LOCAL lHabilitThr := GetNewPar("MV_PLTHRE",.F.)

	PRIVATE _lAll		:= .f.
	PRIVATE _cPrefANS   := Iif(TISVERS < "2.02.02" ,"","ansTISS:")
	PRIVATE _lEnd		:= .f.
	PRIVATE _oProcess	:= nil
	PRIVATE _oBrwBXX	:= nil
	PRIVATE _oCheckBox	:= nil
	PRIVATE _aHeaderBXX := {}
	PRIVATE _aColsBXX	:= {}
	PRIVATE _cTISTRAN	:= ""
	PRIVATE _cTISGUIA	:= ""
	PRIVATE _cTISCOMP	:= ""
	PRIVATE _cTISSIMP	:= ""
	PRIVATE bBotao01	:= {|| PLSFILXML() }
	PRIVATE bBotao02	:= {|| Iif(u_CBSUBXML()	, CABCOLSA(),NIL),eval(_oBrwBXX:oBrowse:bChange) }
	PRIVATE bBotao03	:= {|| lRet := CABPPXML()	,iIf(lRet,CABCOLSA(),nil),iIf(lRet,_lAll:=.f.,nil)}
	PRIVATE bBotao04	:= {|| CABACOLS() }
	PRIVATE bBtnSubLt	:= {|| U_CBSUBLOT() }
	PRIVATE bBtnImpLt	:= {|| U_CBIMPLOT() }
	PRIVATE oSayMsg01	:= nil
	PRIVATE oSayMsg02	:= nil
	If GetNewPar("MV_BLOQBAR","0") == "1"
		PRIVATE bBotao05	:= {|| Iif(PLSABLOQ()	, CABCOLSA(),NIL),eval(_oBrwBXX:oBrowse:bChange) }
	Endif
	
	/*if !MsgYesNo("Para este programa, deve-se utilizar somente GUIAS de RECIPROCIDADE CABESP. Deseja Continuar? ")
		Return nil	
	Endif */
// Parametros de tela
	aSize := MsAdvSize(.T.,.F.,400)
	aAdd( aObjects, { 090, 075, .T., .T. } )
	aAdd( aObjects, { 002, 003, .T., .T. } )
	aAdd( aObjects, { 008, 017, .T., .T., .T. } )
	aInfo	:= { aSize[1], aSize[2], aSize[3], aSize[4], 3, 3 }
	aPosObj	:= MsObjSize( aInfo, aObjects, .T. )
	
	// Botoes da tela
	aadd(aButtons,{"Atualizar"			,bBotao04,"<F5> Atualizar"} )

	If lHabilitThr
		aadd(aButtons,{"Submeter"		,bBotao02,"Submeter"} )
		aadd(aButtons,{"Submeter (Lote)" ,bBtnSubLt,"<F6> Submeter (Lote)"} )
		SetKey(VK_F6,bBtnSubLt)

		aadd(aButtons,{"Importar"		,bBotao03,"Importar"} )
		aadd(aButtons,{"Importar (Lote)"  ,bBtnImpLt,"<F7> Importar (Lote)"} )
		SetKey(VK_F7,bBtnImpLt)
	Else
		aadd(aButtons,{"Submeter"		,bBotao02,"<F6> Submeter"} )
		SetKey(VK_F6,bBotao02)

		aadd(aButtons,{"Importar"		,bBotao03,"<F7> Importar"} )
		SetKey(VK_F7,bBotao03)
	EndIf

	if ExistBlock("PLSFILPRO")
		aadd(aButtons,{"Filtro"	,bBotao01	,"<F8> Filtrar"} )
		SetKey(VK_F8,bBotao01)
	endIf

	If GetNewPar("MV_BLOQBAR","0") == "1"
		aadd(aButtons,{"Desbloquear"		,bBotao05,"<F9> Desbloquear"} )
		SetKey(VK_F9,bBotao05)
	EndIf

	aadd(aButtons,{"Excluir"			,{|| lRet := PLSEXCPR(),iIf(lRet,CABCOLSA(),nil),iIf(lRet,eval(_oBrwBXX:oBrowse:bChange),nil),iIf(lRet,_lAll:=.f.,nil)},"Excluir"} )
	aadd(aButtons,{"Capa Lote"			,{|| PLSRIMP(1) },"Imp. Capa Lote"} )
	aadd(aButtons,{"Imp. Resumo"		,{|| PLSRIMP(2) },"Imp. Resumo"} )
	aadd(aButtons,{"Visualiza XML"		,{|| u_CBBXXCONH() },"Visualiza XML"} )
	aadd(aButtons,{"Legenda"			,{|| PLSXMLEG() },"Legenda"} )

//Adiciona Botoes de Usuario³
	If ExistBlock("PL974BUT")
		aButtons := ExecBlock("PL974BUT", .F., .F., {aButtons})
	EndIf
	SetKey(VK_F5,bBotao04)

// Montando dados do peg
	dbSelectArea('BXX')
	BXX->(dbClearFilter())

// Monta aheader
	Store Header "BXX" TO _aHeaderBXX For !( allTrim(SX3->X3_CAMPO) $ "BXX_CODINT,BXX_CODREG,BXX_CHVPEG,BXX_CODUSR,BXX_SEQNFS,BXX_ARQOUT,BXX_CHVPEG,BXX_TPARQU,BXX_QTDEVE" )
	If GetNewPar("MV_BLOQBAR","0") == "1"
		aSeque:= {'BXX_CHKBOX','BXX_IMG','BXX_DATMOV','BXX_TIPGUI','BXX_CODPEG','BXX_CODRDA','BXX_NOMRDA','BXX_ARQIN','BXX_VLRTOT','BXX_QTDGUI','BXX_STATUS',"BXX_SEQUEN", "BXX_BLOQUE"}
	Else
		aSeque:= {'BXX_CHKBOX','BXX_IMG','BXX_DATMOV','BXX_TIPGUI','BXX_CODPEG','BXX_CODRDA','BXX_NOMRDA','BXX_ARQIN','BXX_VLRTOT','BXX_QTDGUI','BXX_STATUS',"BXX_SEQUEN"}
	EndIf
	aNewHead := {}
	For nI :=1 To Len(aSeque)
		If (nJ := aScan(_aHeaderBXX,{|x| aSeque[nI] $ x[2]})) > 0
			aadd(aNewHead,_aHeaderBXX[nJ])
		Endif
	Next
//Adiciona Recno
	aadd(aNewHead, {"Recno", "BXX_CHVPEG", "",10,4,"","€€€€€€€€€€€€€€ ","N",NIL,""})
	_aHeaderBXX := aClone(aNewHead)

// Monta acols
	CABCOLSA()

// Montando tela
	DEFINE MSDIALOG oDlg TITLE "PEGS - Protocolo de Entrega de Guias - CABESP " FROM aSize[7],0 TO aSize[6],aSize[5] of oMainWnd PIXEL

// Montando tela - da grid
	oPanel		 := tPanel():New(0,0,,oDlg,,,,,,0,0)
	oPanel:align := CONTROL_ALIGN_ALLCLIENT

// Checkbox marca e desmarca todos
	_oCheckBox := TCheckBox():New(04,250,"Marca/Desmarca todos",{|u| If(PCount()>0,_lAll:=u,_lAll)},oPanel,95,09,,,,,,,,.T.)
	_oCheckBox:bChange := {|| PLSELREG(_lAll) }

	DEFINE FONT oFontAutor NAME "Arial" SIZE 000,-010 BOLD
	@ 000,318 SAY oSayMsg01 PROMPT "  Somente est�o sendo exibidos os "+alltrim(str(GetNewPar("MV_PLLIARU",500))) +" �ltimos arquivos ACATADOS e IMPORTADOS," SIZE 400,010 OF oPanel PIXEL COLOR CLR_HRED FONT oFontAutor
	@ 005,318 SAY oSayMsg02 PROMPT "  submetidos a partir de "+dtoc(dDataBase-GetNewPar("MV_PLIMBXT",120))+". Para exibir demais utilize F8. SOMENTE DEVE SER UTILIZADA GUIAS DE RECIPROCIDADE CABESP"  SIZE 400,010 OF oPanel PIXEL COLOR CLR_HRED FONT oFontAutor

// MarkBrowse
	_oBrwBXX := msNewGetDados():New(aPosObj[1,1]+12, aPosObj[1,2], aPosObj[1,3]-21, aPosObj[1,4],0, /*"LinOk"*/, /*"TudOk"*/,,,,4096,,,,oPanel,_aHeaderBXX, _aColsBXX)
	_oBrwBXX:oBrowse:bLdblclick 	:= {|| PLSCHKBOX() }
	_oBrwBXX:oBrowse:bChange 		:= {|| cReg := PLSCARMEM(_oBrwBXX:nAt),oReg:Refresh() }
	_oBrwBXX:oBrowse:bGotFocus 		:= {|| cReg := PLSCARMEM(_oBrwBXX:nAt),oReg:Refresh() }
	_oBrwBXX:nAt					:= 1
	_oBrwBXX:Refresh()

// Pesquisa no grid
	HS_GDPesqu( , , _oBrwBXX, oPanel, 002,.T.,3)

// Memo
	cStyle 		 	:= "Q3Frame{ border-style:solid; border-color:#FFFFFF; border-bottom-width:1px; border-top-width:1px; background-color:#D6E4EA }"
	oRodape 		:= TPanelCss():New(aPosObj[2,1]-24,aPosObj[2,2],"",oPanel,,.F.,.F.,,,oPanel:nClientWidth/2-10,(oPanel:nClientHeight/2)-(aPosObj[2,3]-3),.T.,.F.)
	oRodape:setCSS( cStyle )

// Exibe texto do memo
	@ 001,001 GET oReg Var cReg SIZE (oRodape:nClientWidth/2)-2,(oRodape:nClientHeight/2)-2  OF oRodape MULTILINE HSCROLL Pixel READONLY
	oReg:bRClicked 	:= {||AllwaysTrue()}
	oReg:oFont		:= TFont():New("Courier New",0,16)

// Ativa tela
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,aButtons) })

	SET KEY VK_F5 TO
	SET KEY VK_F6 TO
	SET KEY VK_F7 TO
	SET KEY VK_F8 TO
	If GetNewPar("MV_BLOQBAR","0") == "1"
		SET KEY VK_F9 TO
	EndIf
return(nil)

/*/{Protheus.doc} CABCOLSA
Processa a criacao do acols
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function CABCOLSA(lAdd)
	Default lAdd := .F.

// processa
	processa( {|| CABACOLS(lAdd) }, "PEG", "Selecionando Protocolos...", .t.)

return(nil)

/*/{Protheus.doc} CABACOLS
Atualiza aCols
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function CABACOLS(lOnlyAdd)
	local nX := 1
	local nI:=1
	local nLimite	:= GetNewPar("MV_PLLIARU",500)
	local nPosSeq 	:= 0
	local aAuxTrb	:= {}

	Default lOnlyAdd := .F.   //Nao limpa o acols e adiciona os itens do aRecno


// selecionando registros
	BXX->( dbGoTop() )
	BXX->( dbSetorder(1) )//BXX_FILIAL + BXX_CODINT + BXX_CODRDA + BXX_ARQIN

	If !lOnlyAdd
		_aColsBXX := {}
	EndIf

// selecionando registros
	if ! BXX->( msSeek( xFilial("BXX")+PLSINTPAD()/*+'102814'*/ ) )

		nPosSequen := aScan(_aHeaderBXX,{|x|AllTrim(x[2])=="R_E_C_N_O_"} )
		i:=0
		_aHeaderBXX[Len(_aHeaderBXX), 2] := "BXX_SEQUEN" // atualiza titulo do campo para nao validar o SX3

		BXX->(MsGoto(0))
		Store COLS Blank "BXX" TO _aColsBXX FROM _aHeaderBXX

		nPosSequen := aScan(_aHeaderBXX,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
		i:=0
		_aHeaderBXX[Len(_aHeaderBXX), 2] := "R_E_C_N_O_" // atualiza titulo do campo para nao validar o SX3

	else

		cQuery := ""
		lQuery := .T.
		cAliasBXX := "QRYBXX"

		cQuery := "SELECT R_E_C_N_O_ ,BXX_DATMOV,BXX_CODPEG,BXX_ARQIN,BXX_VLRTOT,BXX_TIPGUI,BXX_TIPGUI,BXX_CODRDA,BXX_QTDGUI,BXX_SEQUEN,BXX_STATUS "+cEnt
		cQuery += " FROM "+cEnt
		cQuery += RetSqlName("BXX")+ " BXX "+cEnt
		cQuery += " WHERE "+cEnt

		cQuery += "(BXX_FILIAL = '"+xFilial("BXX")+"'  "+cEnt
		cQuery += "AND BXX_CODINT = '"+PLSINTPAD() +"' 	 "+cEnt
		cQuery += "AND BXX_STATUS IN ('1','3') "+cEnt
		/*if cEmpAnt == '01'
			cQuery += "AND BXX_CODRDA = '102814'"+cEnt
		endif */
		cQuery += "AND BXX_DATMOV >= '"+dtos(dDataBase-GetNewPar("MV_PLIMBXT",120))+"')"+cEnt
		cQuery += " AND BXX.D_E_L_E_T_ = ' ' "+cEnt
		cQuery += "ORDER BY R_E_C_N_O_ DESC  "+cEnt

		If ExistBlock("PL974FIL")
			cQuery := ExecBlock("PL974FIL", .F., .F., {cQuery})
		EndIf

		PlsQuery(cQuery,cAliasBXX)

		nPosSequen := aScan(_aHeaderBXX,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
		i:=0
		_aHeaderBXX[Len(_aHeaderBXX), 2] := "R_E_C_N_O_" // atualiza titulo do campo para nao validar o SX3
		While !Eof()
			i++
			If i > nLimite
				exit
			Endif
			BXX->(MsGoto((cAliasBXX)->R_E_C_N_O_))
			If  Len(_aColsBXX) > 0 .and. lOnlyAdd
				If aScan(_aColsBXX,{|x|AllTrim(x[nPosSequen])==Alltrim(BXX->BXX_SEQUEN)} )  > 0  // Verifica se o registro selecionado pra ser submetido nao esta no grid ja
					Loop
				EndIf
			EndIf
			Aadd(_aColsBXX,Array(Len(_aHeaderBXX)+1))

			For nX := 1 To Len(_aHeaderBXX)
				If ( _aHeaderBXX[nX,10] !=  "V" )
					_aColsBXX[Len(_aColsBXX)][nX] := (cAliasBXX)->(FieldGet(FieldPos(_aHeaderBXX[nX,2])))
				Else
					_aColsBXX[Len(_aColsBXX)][nX] := CriaVar(_aHeaderBXX[nX,2],.T.)
				EndIf
			Next nX
			_aColsBXX[Len(_aColsBXX)][Len(_aHeaderBXX)+1] := .F.

			dbSelectArea(cAliasBXX)
			dbSkip()

		EndDo

		If Empty(_aColsBXX)
			nPosSequen := aScan(_aHeaderBXX,{|x|AllTrim(x[2])=="R_E_C_N_O_"} )
			i:=0
			_aHeaderBXX[Len(_aHeaderBXX), 2] := "BXX_SEQUEN" // atualiza titulo do campo para nao validar o SX3

			BXX->(MsGoto(0))
			Store COLS Blank "BXX" TO _aColsBXX FROM _aHeaderBXX

			nPosSequen := aScan(_aHeaderBXX,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
			i:=0
			_aHeaderBXX[Len(_aHeaderBXX), 2] := "R_E_C_N_O_" // atualiza titulo do campo para nao validar o SX3
		EndIf

		(cAliasBXX)->(dbCloseArea())

	endIf

// Atualiza browse
	if valType(_oBrwBXX) == 'O'
		_oBrwBXX:setArray(_aColsBXX)
		_oBrwBXX:forceRefresh()
		_oBrwBXX:refresh()
	endIf

return(nil)

/*/{Protheus.doc} PLSFILXML
Monsta o filtro da BXX
@type function
@author TOTVS
@since 12.05.07
@version 1.0
/*/
static function PLSFILXML()
	LOCAL nPosIIII	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"} )

// browse nao pode ta com tudo marcado
	aEval(_oBrwBXX:aCols,{|x| x[nPosIIII] := "LBNO" })
	_oBrwBXX:refresh()
	aRecnos	:= {}
	_lAll := .f.
	_oCheckBox:refresh()
	
// Se existir ponto de entra executa filtro
	ExecBlock("PLSFILPRO",.F.,.F.,{})


// Fim da Rorina
return(nil)

/*/{Protheus.doc} PLSEXCPR
Exclui arquivo
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSEXCPR()
	LOCAL aArea := GetArea()
	LOCAL aAreaBXX := BXX->(GetArea())
	LOCAL nPos 	:= 0
	LOCAL lRet	:= .f.

	nPos  := aScan( _oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"} )

// verifica se algum registro foi selecionado
	if nPos > 0 .and. aScan( _oBrwBXX:aCols,{|x| x[nPos] == "LBOK" } ) > 0
		if msgYesNo("Confirma a exclus�o dos registros selecionados?")
			lRet := .t.
			processa( {|| PLSEEXC(nPos) }, "Protocolo", "Excluindo registros...", .f.)
		endIf
	else
		msgAlert("Selecione pelo menos um registro!")
	endIf
	
	restArea(aAreaBXX)
	restArea(aArea)

return(lRet)

/*/{Protheus.doc} PLSEEXC
Exclui
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSEEXC(nPos)
	LOCAL nRecno	:= 0
	LOCAL nPosI 	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_ARQIN"})
	LOCAL nI 		:= 1
	LOCAL aRet		:= {}
	LOCAL aCols 	:= _oBrwBXX:aCols

// proc regua
	procRegua(len(aCols))

// varendo registros
	for nI:=1 to len(aCols)

		incProc("Excluindo...")

	// excluindo
		if aCols[nI,nPos] == "LBOK"
			nRecno 	:= aCols[nI, Len(_aHeaderBXX)]//ultima posicao deve sempre ser o Recno   _aTrbBXX[nI]
			lRet 	:= u_CBMANBXX(/*cCodRda*/,/*cNomArq*/,/*cTipGui*/,/*cLotGui*/,/*nTotEve*/,/*nTotGui*/,/*nVlrTot*/,K_Excluir,nRecno,/*lProcOk*/,/*aRet*/)

		// nao foi possivel excluir
			if !lRet
				aadd(aRet,{"Existem guias da PEG do arquivo ["+allTrim(aCols[nI,nPosI])+"] não estao em fase de digita��o"})
			endIf
		endIf
	next

// inconsistencias
	if len(aRet)>0
		PlsCriGen(aRet, { {"Descri��o","@C",1000} }, "Resultado",,,,,,,,,,,,,,,,,,,,TFont():New("Courier New",7,14,,.F.,,,,.F.,.F.))
	endIf

return(nil)

/*/{Protheus.doc} CABPPXML
Processando xml usando processa
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function CABPPXML()
	LOCAL lRet	:= .f.
	LOCAL nPos  := aScan( _oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"} )
	LOCAL nPos2 := aScan( _oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_IMG"} )
	LOCAL nPos3 := aScan( _oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_BLOQUE"} )
	LOCAL cCodInt	:= PLSINTPAD()
	Local lRetCont	:=.T.

// verifica se algum registro foi selecionado
	If nPos2 > 0 .and. aScan( _oBrwBXX:aCols,{|x| alltrim(x[nPos2]) != "BR_VERDE" .and. alltrim(x[nPos]) == "LBOK"} ) > 0
		MsgStop("Somente podem ser importados arquivos ainda nao importados e que foram acatados.")
		return lRet
	Endif


	If GetNewPar("MV_BLOQBAR","0") == "1"
//Verifica se arquivo est� bloqueado devido importa��o via portal
		If nPos3 > 0 .and. aScan( _oBrwBXX:aCols,{|x| alltrim(x[nPos3]) == "1" .and. alltrim(x[nPos]) == "LBOK"} ) > 0
			MsgStop("Arquivo bloqueado, desbloquear com código de barras.")
			return lRet
		EndIf
	EndIf

	if nPos > 0 .and. aScan( _oBrwBXX:aCols,{|x| x[nPos] == "LBOK" } ) > 0

	// confirmacao da processamento
		if msgYesNo("Confirma importacao dos registros selecionados?")
			lRet := .t.

		// inicio do processo
			_oProcess := msNewProcess():new( {|_lEnd| lRetCont:=PLSPRXML() },"Importando","Importando XML...",.T.)
			_oProcess:activate()
			If lRetCont
				MsgAlert("Importacao concluida!")
			Endif
		endIf
	else
		msgAlert("Selecione pelo menos um registro!")
	endIf

return(lRet)

/*/{Protheus.doc} PLSPRXML
Processando	xml
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSPRXML()
	LOCAL cFileXml	:= ""
	LOCAL cNumPro	:= ""
	LOCAL cCodRda	:= ""
	LOCAL nI 		:= 1
	LOCAL nRecno	:= 0
	LOCAL nTotFile	:= 0
	LOCAL nCont		:= 0
	LOCAL nPos 		:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_ARQIN"})
	LOCAL nPosI		:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CODPEG"})
	LOCAL nPosII 	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"})
	LOCAL nPosIII 	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CODRDA"})
	LOCAL aCols 	:= _oBrwBXX:aCols
	LOCAL aRet		:= {.F.,"",{}}
	LOCAL aRetCri	:= {}
	LOCAL l974		:= .t.
	LOCAL cTissVer	:= ""
	LOCAL nPosSeq   := aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
	LOCAL lTudOk    := .F.

// quantidade de arquivos selecionados
	aEval(aCols,{|x| nTotFile += iIf(x[nPosII]=="LBOK",1,0)})

	_oProcess:setRegua1(nTotFile)

// varendo registros
	for nI:=1 to len(aCols)
		cFileXml := aCols[nI,nPos]
		cCodPeg  := aCols[nI,nPosI]
		cCodRda  := aCols[nI,nPosIII]
		cSeqBXX  := aCols[nI,nPosSeq]

	// somente os selecionados
		if aCols[nI,nPosII] == "LBOK"
			nRecno	 := aCols[nI, Len(_aHeaderBXX)]//_aTrbBXX[nI]
			nCont++
		//	ÄÄÄÄ
		// caso tenha sido cancelado
			if _lEnd
				Exit
			endIf
			BXX->(DbSetOrder(7))
			BXX->(MsSeek(xFilial("BXX")+cSeqBXX))
			If BXX->(FieldPos("BXX_TISVER")) > 0
				cTissVer := BXX->BXX_TISVER
				TISVERS := cTissVer
			EndIf
			lTudOk:= u_CABA974A(BXX->BXX_CHVPEG,cCodRda)
			If !lTudOk
				If !empty(BXX->BXX_CHVPEG)
					if !u_CBDELMOVZ(BXX->BXX_CHVPEG,"1",lTudOk,BXX->BXX_TIPGUI)
						return(.f.)
					endIf
				endIf
			EndIf
			If !LockByName("CABA974"+ BXX->(xFilial("BXX")+BXX_SEQUEN),.T.,.F.)
				MsgInfo("Este Registro est� sendo utilizado em outro terminal ") //"Este Arquivo está sendo utilizado em outro terminal "
				Return(.F.)
			EndIf
			_oProcess:IncRegua1("Arquivo ["+cValToChar(nCont)+"] do total ["+cValToChar(nTotFile)+"]")

		// processamento
			aRet := u_CabaTiss(cFileXml,nil,nil,cCodRda,.T.,_oProcess,cCodPeg,cTissVer)
			u_CBMANBXX(cCodRda,cFileXml/*cNomArq*/,/*cTipGui*/,/*cLotGui*/,/*nTotEve*/,/*nTotGui*/,/*nVlrTot*/,K_Alterar,nRecno,.t.,/*aRet*/)
		endIf
	next

// erro
	if len(aRetCri)>0
		PlsCriGen(aRetCri, { {"Descri��o","@C",1000} }, "Resultado",,,,,,,,,,,,,,,,,,,,TFont():New("Courier New",7,14,,.F.,,,,.F.,.F.))
	endIf

return(nil)

/*/{Protheus.doc} PLSELREG
Marca e desmarca todos
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSELREG(_lAll)
	LOCAL nX		:= 0
	LOCAL nPosSel	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"})
	LOCAL nPos		:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_ARQIN"})

	if len(_oBrwBXX:aCols)==1 .and. empty(_oBrwBXX:aCols[1,nPos])
		_lAll := .f.
	else
		for nX := 1 to len(_oBrwBXX:aCols)
			if !empty(_oBrwBXX:aCols[nX,nPos])
				if _lAll
					_oBrwBXX:aCols[nX,nPosSel] := "LBOK"
				else
					_oBrwBXX:aCols[nX,nPosSel] := "LBNO"
				endIf
			endIf
		next
		_oBrwBXX:Refresh()
	endIf

return(nil)

/*/{Protheus.doc} PLSCHKBOX
Marca e desmarca linha
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSCHKBOX()
	LOCAL nPosSel := aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"})
	LOCAL nPos 	  := aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_ARQIN"})

// verifica se e registro valido para selecao
	If Len(_oBrwBXX:aCols) > 0
		if !empty( _oBrwBXX:aCols[_oBrwBXX:nAt,nPos] )
			if _oBrwBXX:aCols[_oBrwBXX:nAt,nPosSel] == "LBOK"
				_oBrwBXX:aCols[_oBrwBXX:nAt,nPosSel] := "LBNO"
			else
				_oBrwBXX:aCols[_oBrwBXX:nAt,nPosSel] := "LBOK"
			endIf
		endIf
	Endif

return(nil)

/*/{Protheus.doc} PLSCARMEM
Carrega campo memo
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSCARMEM(nLinha)
	LOCAL nRecno := 0
	LOCAL cRet	 := ""

// Posiciona no registro para retorno do memo
	if len(_oBrwBXX:aCols) > 0 .and. nLinha <= len(_oBrwBXX:aCols)
		nRecno := _oBrwBXX:aCols[nLinha, Len(_aHeaderBXX)]//_aTrbBXX[nLinha]
		If ValType(nRecno) == "N"
			DbSelectArea("BXX")
			BXX->(dbGoTo(nRecno))
			cRet := MSMM(BXX->BXX_CODREG,999)
		EndIf
	endIf
	_oBrwBXX:Refresh()

return(cRet)

/*/{Protheus.doc} u_CBSUBXML
Submeter arquivo xml
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
User Function CBSUBXML()

	LOCAL nI			:= 0
	LOCAL cDirOri 	   	:= ""
	LOCAL aArquivos	   	:= {}
	LOCAL aLista	   	:= {}
	LOCAL aMatCol		:= {}
	LOCAL lOk			:= .F.
	LOCAL lRet			:= .T.    // variavel de retorno para verificar se foram selecionados os xmls ou nao
	LOCAL dDtBsBXX 		:= dDataBase


// Selecionar arquivos xml
	cDirOri	  := cGetFile("Arquivos XML |*.xml|","Selecione o diretorio de arquivos XML",,"",.T.,GETF_OVERWRITEPROMPT + GETF_NETWORKDRIVE + GETF_LOCALHARD + GETF_RETDIRECTORY)
	If Empty(cDirOri) // cancelou a janela de selecao do diretorio
		lRet := .F.
		Return(lRet)
	EndIf
	aArquivos := directory(cDirOri+"*.xml")
	fCriaSX1("CABA974CPT")
	Pergunte("CABA974CPT",.T.)
	If !empty(mv_par01)
		dDtBsBXX := mv_par01
	Endif
	p973cest()
	if len(aArquivos) > 0


	// Monta lista de arquivos
		for nI := 1 to len(aArquivos)
			aadd(aLista,{aArquivos[nI][1],DtoC(aArquivos[nI][3]),aArquivos[nI][4],AllTrim(transform(aArquivos[nI][2]/1000,"@E 999,999,999.99"))+" KB",.F.})
		next
		aLista := aSort(aLista,,, { |x,y| DTOS(CTOD(x[2])) < DTOS(CTOD(y[2])) })


	// Colunas do browse
		aadd( aMatCol,{"Arquivo"	,'@!',200} )
		aadd( aMatCol,{"Data"		,'@!',040} )
		aadd( aMatCol,{"Hora"		,'@!',040} )
		aadd( aMatCol,{"Tamanho"	,'@!',040} )


	// Browse para selecionar
		lOk := PLSSELOPT( "Selecione o(s) arquivos(s) a serem importados", "Marca e Desmarca todos", aLista, aMatCol, K_Incluir,.T.,.T.,.F.)


	// Verifica se algum arquivo foi selecionado
		if lOk
			lOk := aScan(aLista,{|x| x[len(aLista[1])] == .T.}) > 0
		endIf


	// Processando arquivos
		if lOk
			_oProcess := msNewProcess():new( {|_lEnd| u_CBSUBMET(cDirOri,aLista,dDtBsBXX) },"Submetendo Arquivos","Verificando estrutura e regras basicas!",.T.)
			_oProcess:Activate()
			If Type('oSayMsg01') <> 'U'
				oSayMsg01:cCaption := "  Estao sendo exibidos os registros submetidos!"
				oSayMsg01:refresh()
				oSayMsg02:cCaption := ""
				oSayMsg02:refresh()
			Endif
		Else
			lRet := .F.
		endIf
	elseIf !empty(cDirOri)
		msgAlert('Pasta n�o contem arquivo XML ou opera��o cancelada')
		lRet := .F.
	endIf


// Limpa as váriáveis estaticas usadas na função	PLVALPRSE
	u_CLIMPAVAR()


return(lRet)

/*/{Protheus.doc} u_CBSUBMET
Submete arquivo
@type function
@author TOTVS
@since 17/07/12
@version 1.0
/*/
User Function CBSUBMET(cDirOri,aLista,dDtBsBXX)
	LOCAL nI 			:= 1
	LOCAL nClear		:= 1
	LOCAL nTotFile		:= 0
	LOCAL nVlrTot		:= 0
	LOCAL nCont			:= 0
	LOCAL cNomArq		:= ""
	LOCAL cMsg			:= ""
	LOCAL cTipGui		:= "08"
	LOCAL cLotGui		:= ""
	LOCAL cTissVer		:= "" //Versao do arquivo XML
	LOCAL cCodRda		:= ""
	LOCAL lContinua		:= .T.
	LOCAL nTamNA		:= TamSX3("BXX_ARQIN")[1]
	LOCAL cCodInt		:= PLSINTPAD()
	LOCAL aRet			:= {}
	LOCAL aDad			:= {"","",""}
	LOCAL nTotEve		:= 0
	LOCAL nTotGui		:= 0
	LOCAL nValTot		:= 0
	LOCAL cSeqBXX		:= ""
	LOCAL aBkpRecno		:= aClone(aRecnos)
	DEFAULT dDtBsBXX	:= dDataBase


// quantidade de arquivos selecionados
	aRecnos := {}

	aEval(aLista,{|x| nTotFile+=iIf(x[5],1,0)})

	_oProcess:setRegua1(nTotFile)


// Faco a limpeza dos itens que estao na pasta temporaria
	For nClear:=1 to Len(aLista)
		If File(cDirUpManu+aLista[nClear,1])
			fErase(cDirUpManu+aLista[nClear,1])
		Endif
	Next


// Monta matriz com arquivos selecionados
	for nI:=1 to Len(aLista)

	// somente os que foram selecioandos
		if !aLista[nI,len(aLista[nI])]
			loop
		endIf

		cNomArq := aLista[nI,1]

	// caso tenha sido cancelado
		if _lEnd
			Exit
		endIf
		nCont++
		_oProcess:IncRegua1("Arquivo ["+cValToChar(nCont)+"] do total ["+cValToChar(nTotFile)+"]")

	// Verifica se o arquivo ja existe
		BXX->(DbSetOrder(4))//BXX_FILIAL + BXX_CODINT + BXX_ARQIN + BXX_CODRDA
		If BXX->( MsSeek( xFilial("BXX") + cCodInt + lower(cNomArq) ) ) .or. BXX->( MsSeek( xFilial("BXX") + cCodInt + upper(cNomArq) ) )

			aadd(aRet, {cNomArq})
			Do Case
			//'0=Em processamento - 'BR_VERMELHO';1=Acatado - 'BR_VERDE';2=Nao acatado-'BR_LARANJA_OCEAN';3=Processado-'BR_CINZA''
			Case BXX->BXX_STATUS == '0'
				aadd(aRet, {"Arquivo ja submetido e em processamento."})
			Case BXX->BXX_STATUS == '1'
				aadd(aRet, {"Arquivo ja submetido e foi acatado."})
			Case BXX->BXX_STATUS == '2'
				aadd(aRet, {"Arquivo ja submetido e nao foi acatado."})
			Case BXX->BXX_STATUS == '3'
				aadd(aRet, {"Arquivo ja submetido e ja importado"})
			EndCase
			aadd(aRecnos,BXX->(Recno()))
			loop

		// Valida arquivo que esta no pasta na \tiss\upload usado no remote e na web
		Else

		// Copio do client para o server - definicao desta pasta no "UPLOADPATH" do ini
		//Se já estiver no servidor usar copyfile
			nRetCpy:=-1
			lRetCpy:=.F.
			If 	Substr(cDirOri,1,1) $"/\"
				nret:=frename( cDirOri+cNomArq,cDirUpManu+cNomArq)
				lRetCpy:=(nRet==0)
			Else
				lRetCpy:=CpyT2S(cDirOri+cNomArq, cDirUpManu)
			Endif

			If !lRetCpy
				aadd(aRet, {"Nao foi possivel copiar o arquivo de [" + cDirOri + "] para [" + cDirUpload + "]"})
				aadd(aRet, {"        Arquivo: " + cNomArq})
				aRecnos := aClone(aBkpRecno)
			else

				cTipGui := "08"
				cCodRda := ""
				cLotGui := ""
				nTotEve := 0
				nTotGui := 0
				nValTot := 0
			//agora eu tenho que ter o sequen ja na hr de validar o arquivo para gravar a nova tabela bxv
				cSeqBXX := BXX->(GETSX8NUM("BXX",'BXX_SEQUEN'))
				BXX->(ConfirmSX8())

				aRet := u_CABA973L(cDirUpManu+cNomArq,@cCodRda,.f.,.t.,@cTipGui,@cLotGui,@nTotEve,@nTotGui,@nValTot,cSeqBXX,cDirUpManu, @cTissVer,_oProcess)

			// Grava na BXX
				u_CBMANBXX(cCodRda,cNomArq,cTipGui,cLotGui,nTotEve,nTotGui,nValTot,/*nOpc*/,/*nRecno*/,/*lProcOk*/,aRet, @cSeqBXX,dDtBsBXX,,cTissVer)

			// Grava na Banco de Conhecimento
				u_CBINCONH(cDirOri+cNomArq, "BXX", xFilial("BXX") + cSeqBXX)

				aadd(aRecnos,BXX->(Recno()))
				aRet := {}
			Endif
		endIf
	next

// exibe alerta com arquivos ja gravados
	if len(aRet)>0
		PlsCriGen(aRet, { {"Descri��o","@C",1000} }, "Resultado",,,,,,,,,,,,,,,,,,,,TFont():New("Courier New",7,14,,.F.,,,,.F.,.F.))
	endIf

return

/*/{Protheus.doc} PLSMANBXX
Grava ou altera a tabela de upload de arquivo xml
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
User Function CBMANBXX(cCodRda,cNomArq,cTipGui,cLotGui,nTotEve,nTotGui,nVlrTot,nOpc,nRecno,lProcOk,aRet, cSequen,dDtBsBXX,cOrigem, cTissVer)
	LOCAL cCodInt	:= PLSINTPAD()
	LOCAL cTexto	:= ""
	LOCAL cFile 	:= ''
	LOCAL cExten 	:= ''
	LOCAL lAcatado	:= .f.
	DEFAULT cCodRda	:= ""
	DEFAULT cNomArq	:= space( TamSX3("BXX_ARQIN")[1] )
	DEFAULT cTipGui	:= "08"
	DEFAULT nTotEve	:= 0
	DEFAULT nTotGui	:= 0
	DEFAULT nVlrTot	:= 0
	DEFAULT nOpc 	:= K_Incluir
	DEFAULT nRecno	:= 0
	DEFAULT lProcOk	:= .t.
	DEFAULT aRet	:= {}
	DEFAULT cSequen	:= ""
	DEFAULT dDtBsBXX := dDataBase
	DEFAULT cOrigem := "0"
	DEFAULT cTissVer := ""

// ajusta nome do arquivo
	cNomArq := cNomArq+space( TamSX3("BXX_ARQIN")[1]-len(cNomArq) )

//Detalhe da importacao
	if len(aRet) > 0
		cTexto := PLSREGT(aRet)
	endIf

// Index
	BXX->( DbSetOrder(1) )
	dbSelectArea("BXX")
	dbSelectArea("BCI")
	BCI->(dbSetOrder(12))

//inclusao, alteracao ou excluisao

	If Empty(cCodRda)
		cCodRda := GetMv("MV_PLSRDAG")//se nao achou o prestador assume a RDA generica
	Endif
	aDatPag  := PLSXVLDCAL(dDtBsBXX,cCodInt) //pego mês e ano, para qdo a importação for do Portal, e qdo o calendário estiver quebrado.
	do case

	//inclusao

	case nOpc == K_Incluir

		if !BXX->( MsSeek( xFilial("BXX") + lower(cCodInt + cCodRda + cNomArq) ) ) .and. ;
				!BXX->( MsSeek( xFilial("BXX") + upper(cCodInt + cCodRda + cNomArq) ) )


			//grava controle de upload
			If Empty(cSequen)
				cSeqBXX := BXX->(GETSX8NUM("BXX",'BXX_SEQUEN'))
				BXX->(ConfirmSX8())
			Else
				cSeqBXX := cSequen
			Endif

			BXX->(recLock("BXX",.t.))
			BXX->BXX_FILIAL	:= xFilial("BXX")
			BXX->BXX_DATMOV	:= dDtBsBXX
			BXX->BXX_CODINT	:= cCodInt
			BXX->BXX_CODUSR	:= Upper( PLRETOPE() )
			BXX->BXX_ARQIN 	:= cNomArq
			BXX->BXX_CODRDA	:= cCodRda
			BXX->BXX_TIPGUI	:= cTipGui
			BXX->BXX_QTDEVE	:= nTotEve
			BXX->BXX_QTDGUI	:= nTotGui
			BXX->BXX_VLRTOT	:= nVlrTot
			BXX->BXX_TPNFS	:= '0'
			BXX->BXX_SEQUEN := cSeqBXX
			If GetNewPar("MV_BLOQBAR","0") == "1"
				BXX->BXX_BLOQUE := '0'
			EndIf
			If !Empty(cTissVer) .AND. BXX->(FieldPos("BXX_TISVER")) > 0 // gravo a versao da tiss no XML recebido para controle
				BXX->BXX_TISVER := cTissVer
			EndIf
			cSequen	:= cSeqBXX // Variavel passada como referencia para utilizacao na gravaco no banco de conhecimento

				//Se o arquivo foi acatado cria o numero do peg
				//Com o texto preenchido e com a posição 3 do array preenchido, se trata de um alerta
			If empty(cTexto) .OR. (!aRet[1] .AND. !empty(cTexto))
				BXX->BXX_STATUS	:= "1"

					//cria o peg correspondente
				BAU->( dbSetOrder(1) ) //BAU_FILIAL + BAU_CODIGO
				BAU->( msSeek(xFilial("BAU")+cCodRda) )

				If !BCI->(msSeek(xFilial("BCI")+cCodInt+PLSRETLDP(2)+cTipGui+cCodRda+Alltrim(Upper(StrTran(cNomArq,".XML",""))))) .AND. !BCI->(msSeek(xFilial("BCI")+cCodInt+PLSRETLDP(2)+cTipGui+cCodRda+cNomArq)) //BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_TIPGUI + BCI_CODRDA + BCI_ARQUIV
					PLSIPP(cCodInt,PLSRETLDP(2),cCodInt,cCodRda,aDatPag[5],aDatPag[4],dDtBsBXX,cTipGui,cLotGui,{},"1",Upper(cNomArq),nTotEve,nTotGui,nVlrTot,cOrigem,,dDtBsBXX)
				EndIf
				BXX->BXX_CODPEG := BCI->BCI_CODPEG
				BXX->BXX_CHVPEG := BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
				If GetNewPar("MV_BLOQBAR","0") == "1"
					BXX->BXX_BARRAS	:= IIf(BAU->BAU_TIPPE=='F','01','02')+BCI->BCI_CODPEG+strzero(val(BAU->BAU_CPFCGC),14)
				EndIf
			Else
				BXX->BXX_STATUS	:= "2"
			EndIf

				//Gravacao do memo
			if !empty(cTexto)
				MSMM(,TamSX3("BXX_DETREG")[1],,ansiToOem(cTexto),1,,,"BXX","BXX_CODREG")
			endIf
			BXX->(msUnLock())

			//Ponto de entrada para atribuir outras informações ao registro da BXX
			//Parametro: 1 - Para diferenciar onde o PE é chamado, neste caso na inclusão do protocolo pela submissão
			If ExistBlock("PL974BXX")
				ExecBlock("PL974BXX", .F., .F., {"1"})
			EndIf

		Else
			BXX->(recLock("BXX",.F.))
			If Empty(cTexto)
				BXX->BXX_STATUS	:= "1"

					//cria o peg correspondente
				BAU->( dbSetOrder(1) ) //BAU_FILIAL + BAU_CODIGO
				BAU->( msSeek(xFilial("BAU")+cCodRda) )

				If SIX->(MsSeek("BCIG")) .and. !Empty(BXX->BXX_IDXML) //nova regra somente se o �ice 16 da BCI estiver criado.. se ele estiver criado, entao temos o campo nvo BCI_IDXML tambem
					BCI->(DbSetOrdeR(16))
					If !(BCI->(MsSeek(xfilial("BCI") + cCodInt + PLSRETLDP(2) + cTipGui + cCodRDA + AllTrim(BXX->BXX_IDXML))))
						PLSIPP(cCodInt,PLSRETLDP(2),cCodInt,cCodRda,strzero(month(dDtBsBXX),2),cValToChar(year(dDtBsBXX)),dDtBsBXX,cTipGui,cLotGui,{},"1",Upper(cNomArq),nTotEve,nTotGui,nVlrTot, , ,dDtBsBXX, , AllTrim(BXX->BXX_IDXML))
					EndIf
				else
					If !BCI->(msSeek(xFilial("BCI")+cCodInt+PLSRETLDP(2)+cTipGui+cCodRda+Alltrim(Upper(StrTran(cNomArq,".XML",""))))) .AND. !BCI->(msSeek(xFilial("BCI")+cCodInt+PLSRETLDP(2)+cTipGui+cCodRda+cNomArq))
						PLSIPP(cCodInt,PLSRETLDP(2),cCodInt,cCodRda,strzero(month(dDtBsBXX),2),cValToChar(year(dDtBsBXX)),dDtBsBXX,cTipGui,cLotGui,{},"1",Upper(cNomArq),nTotEve,nTotGui,nVlrTot, , ,dDtBsBXX)
					EndIf
				EndIf
				BXX->BXX_CODPEG := BCI->BCI_CODPEG
				BXX->BXX_CHVPEG := BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
				BXX->BXX_TIPGUI	:= cTipGui
				BXX->BXX_QTDEVE	:= nTotEve
				BXX->BXX_QTDGUI	:= nTotGui
				BXX->BXX_VLRTOT	:= nVlrTot
				If GetNewPar("MV_BLOQBAR","0") == "1"
					BXX->BXX_BARRAS	:= IIf(BAU->BAU_TIPPE=='F','01','02')+BCI->BCI_CODPEG+strzero(val(BAU->BAU_CPFCGC),14)
				EndIf
				If !Empty(cTissVer) .AND. BXX->(FieldPos("BXX_TISVER")) > 0 // gravo a versao da tiss no XML recebido para controle
					BXX->BXX_TISVER := cTissVer
				EndIf
			Else
				BXX->BXX_STATUS	:= "2"
				if !empty(cTexto)
					MSMM(,TamSX3("BXX_DETREG")[1],,ansiToOem(cTexto),1,,,"BXX","BXX_CODREG")
				endIf
			EndIf
			BXX->(msUnLock())

				//Ponto de entrada para atribuir outras informações ao registro da BXX
				//Parametro: 2 - Para diferenciar onde o PE é chamado, neste caso na importação do XML
			If ExistBlock("PL974BXX")
				ExecBlock("PL974BXX", .F., .F., {"2"})
			EndIf

		Endif


	//alterar
	case nOpc == K_Alterar .and. nRecno > 0

		//Posiciona no registro
		BXX->(dbGoTo(nRecno))
		BXX->(recLock("BXX",.f.))

			//se o processamento do arquivo foi concluido
		if lProcOk
			BXX->BXX_STATUS	:= "3"
		endIf
		BXX->( msUnLock() )

		//Ponto de entrada para atribuir outras informações ao registro da BXX
		//Parametro: 3 - Para diferenciar onde o PE é chamado, neste caso na finalização da gravação do XML mudando o status da BXX
		If ExistBlock("PL974BXX")
			ExecBlock("PL974BXX", .F., .F., {"3"})
		EndIf


	//excluir
	case nOpc == K_Excluir .and. nRecno > 0

		BXX->( dbGoTo(nRecno) )

		//verifica e deleta movimento do contas e atendimento deste peg
		if !empty(BXX->BXX_CHVPEG)
			if !PLSDELMOV(BXX->BXX_CHVPEG,"1")
				return(.f.)
			endIf
		endIf

		//continua exclusao na bxx
		cNomArq	 := allTrim(BXX->BXX_ARQIN)
		lAcatado := BXX->BXX_STATUS == "1"

		If PlsAliasExi("BXV")
			BXV->(DbSetORder(1))
			While BXV->(MsSeek(xFilial("BXV")+"BXV"+BXX->BXX_SEQUEN))
				BXV->( recLock("BXV",.f.) )
				BXV->(dbDelete())
				BXV->( msUnLock() )
			Enddo
		Endif

		BXX->( recLock("BXX",.f.) )

			//memo
		MSMM(BXX->BXX_CODREG,,,,2,,,"BXX","BXX_CODREG")
		BXX->(dbDelete())
		BXX->( msUnLock() )


		//Estou deletando ele do banco de conhecimento
		SplitPath( cNomArq,,, @cFile, @cExten )

		If FindFunction( "MsMultDir" ) .And. MsMultDir()
			cDirDocs := MsRetPath( cFile+cExten )
		Else
			cDirDocs := MsDocPath()
		Endif

		If file(PLSMUDSIS(cDirDocs + "\" + cNomArq))
			fErase(PLSMUDSIS(cDirDocs + "\" + cNomArq))
		Endif
		
		DBSELECTAREA("AC9")
		ACB->(DbSetOrder(2))
		ACB->(MsSeek(xFilial('ACB')+Upper( cFile + cExten )))
		
		while alltrim(xFilial("ACB")+ACB->ACB_OBJETO) == alltrim(xFilial('ACB')+Upper( cFile + cExten )) 
		
			//if alltrim(xFilial("ACB")+ACB->ACB_OBJETO) == alltrim(xFilial('ACB')+Upper( cFile + cExten ))
			
			cQuery := "UPDATE "+RetSqlName("AC9")+" SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE AC9_CODOBJ = '"+ACB->ACB_CODOBJ+"'"
			TcSqlExec(cQuery)
			
		/*	AC9->(DbSetORder(1))
			while AC9->(MsSeek(xFilial("AC9")+ACB->ACB_CODOBJ))
				
				RecLock( "AC9", .F. )
					DbDelete()
				AC9->(MsUnlock()) 
				
				AC9->(dbskip())
			
			Enddo*/
			cQuery := "UPDATE "+RetSqlName("ACB")+" SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE ACB_CODOBJ = '"+ACB->ACB_CODOBJ+"'"
			
			TcSqlExec(cQuery)
			TcSqlExec("COMMIT")
			/*RecLock( "ACB", .F. )
				ACB->(DbDelete())
			ACB->( MsUnlock() )
			*/
			
			ACB->(dbskip())
		Enddo

		//excluir se nao acatado deleta da pasta upload se acatado esta na caixa de entrada
		if lAcatado
			if file(cDirCaiEn+cNomArq)
				fErase(cDirCaiEn+cNomArq)
			endIf
		Endif

		if file(cDirUpload+cNomArq)
			fErase(cDirUpload+cNomArq)
		endIf
		if file(cDirUpManu+cNomArq)
			fErase(cDirUpManu+cNomArq)
		endIf
		if file(cDirBkp+cNomArq)
			fErase(cDirBkp+cNomArq)
		endIf

	endCase

return(.t.)

/*/{Protheus.doc} PLSREGT
Trata o dados do registro
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSREGT(aCriticas)
	LOCAL nI 	:= 0
	LOCAL cTexto:= ""
	LOCAL cAux  := ""

//Criticas
	if aCriticas[1] .OR. !EMPTY(aCriticas[3])
		if len(aCriticas[3])>0
			for nI := 1 to len(aCriticas[3])
				cAux := AllTrim(strTran(strTran(aCriticas[3,nI],chr(13),""),chr(10),""))+CRLF
			//tratamento para evitar overflow na string
				If Len(cTexto)+Len(cAux) < 1000000
					cTexto += cAux
				Else
					Exit
				EndIf
			next
			cTexto += CRLF
		endIf
	endIf

// Fim da Rorina
return(cTexto)

/*/{Protheus.doc} PLSRIMP
Impressao
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
static function PLSRIMP(nOp)
	LOCAL nPosI		:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CODRDA"})
	LOCAL nPosII	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CODPEG"})
	LOCAL nPosIII	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_STATUS"})
	LOCAL nPosIIII	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_CHKBOX"} )
	LOCAL nPosSequen := aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
	LOCAL cCodInt	:= PLSINTPAD()
	LOCAL cCodRda	:= ""
	LOCAL cSequen	:= ""
	LOCAL cCodPeg	:= ""
	LOCAL cChkPeg	:= ""
	LOCAL cStatus	:= ""
	LOCAL ni		:=0
	Local ncout	:=0

// monta a chave
	if nPosI>0 .and. nPosII>0
	///Verificando o que está marcado no Browse
		For ni :=1 to  LEN(_oBrwBXX:aCols)

			If _oBrwBXX:aCols[nI,nPosIIII] == "LBOK"
				ncout+=1
			Endif

		Next

		IF ncout >1
			_lAll := .T.
			cTexto:="Confirma a impress�o das capas de protocolo Selecionadas"
		Else

	// dados
			cCodRda := _oBrwBXX:aCols[_oBrwBXX:nAt,nPosI]
			cCodPeg := _oBrwBXX:aCols[_oBrwBXX:nAt,nPosII]
			cStatus	:= _oBrwBXX:aCols[_oBrwBXX:nAt,nPosIII]
			cSequen	:= _oBrwBXX:aCols[_oBrwBXX:nAt,nPosSequen]
			_lAll := .F.
			cTexto:="Confirma a impress�o da capa de protocolo numero [ "+cCodPeg+" ]"
		Endif

		cStatus	:= _oBrwBXX:aCols[_oBrwBXX:nAt,nPosIII]
		do case

		// impressao da capa de lote peg
		case nOP == 1
			if cStatus $ "1,3"

				if msgYesNo(cTexto)

					// posiciona para pegar a chave do peg (bci)
					BXX->(dbSetorder(2))//BXX_FILIAL + BXX_CODINT + BXX_CODRDA + BXX_CODPEG + DtoS(BXX_DATMOV)
					BXX->( msSeek( xFilial("BXX")+cCodInt+cCodRda+cCodPeg ) )
					If ncout <= 0
						PLSCHKBOX()
					EndIf
					processa( {|| PLSRCPRT(BXX->BXX_CHVPEG,,,,_oBrwBXX) }, "Impressão", "Imprimindo capa de protocolo...", .t.)
					If ncout <= 0
						PLSELREG(.F.)
					EndIf
				endIf
			else
				msgAlert("Imposs�vel imprimir capa de lote para protocolo que n�o foi acatado!")
			endIf

		// impressao critica de processamento
		case nOP == 2
			if cStatus $ "2,3"
				if MsgYesNo("Confirma a impress�o ?")
					processa( {|| PLSRCRIT(cSequen,,,"RESUMO REFERENTE A IMPORTACAO DO ARQUIVO XML",'Informacoes') }, "Impress�o", "Imprimindo...", .t.)
				endIf
			else
				msgAlert("Impressão somente para protocolo não acatado e importado!")
			endIf
		endCase
	else
		msgAlert("Imposs�vel montar chave para emiss�o do relatorio")
	endIf

return(nil)

/*/{Protheus.doc} PLSINCONH
Funcao para incluir arquivo no banco de connhecimento sem interacao com tela
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
User Function CBINCONH(cPathFile, cAliasEnt, cChaveUn, lOnline, lDelFileOri,lVerifExis,lHelp)
	Local aArea 	:= getArea()
	Local lRet		:= .F.
	Local cFile		:= ""
	Local cExten	:= ""
	Local cObj
	LOCAL aFile := {}
	LOCAL cNameServ
	LOCAL cDir	 	:= getWebDir()
	LOCAL lDownload := GetNewPar("MV_PLPDWN", .F.)
	local cDownload  := ""
	Local cTimeIni := ""
	Local cTimeOut := "00:10:00"

	Default lOnline     := .F.
	Default lDelFileOri := .F.
	Default lVerifExis  := .F.
	Default lHelp       := .F.

	SplitPath( cPathFile,,, @cFile, @cExten )


// Insere underline nos espaços em branco do nome do arquivo, isso é
// necessário para fazer o download corretamente do arquivo no portal de
// noticias.

	If FindFunction( "MsMultDir" ) .And. MsMultDir()
		cDirDocs := MsRetPath( cFile+cExten )
	Else
		cDirDocs := MsDocPath()
	Endif

	cNameServ := cFile+cExten


	// Se o nome contiver caracteres estendidos, renomeia
	cRmvName := Ft340RmvAc(cNameServ)
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
	If lOnline      // se for portal
		cTimeIni := Time()
	// Copio do client para o server - definicao desta pasta no "UPLOADPATH" do ini
		__COPYFILE( PLSMUDSIS(cPathFile), PLSMUDSIS(cDirDocs + "\" + cNameServ) )
		lRet := .T.

	// Deleta arquivo
		if lDelFileOri .AND. file(PLSMUDSIS(cPathFile)) .AND. file(PLSMUDSIS(cDirDocs + "\" + cNameServ))
			FErase(cPathFile)
		EndIf

		//Aguarda durante 10 minutos para verificar se o arquivo foi copiado
		While !file(PLSMUDSIS(cDirDocs + "\" + cNameServ)) .AND. ElapTime(cTimeIni, Time()) < cTimeOut
			Sleep(2000)
		EndDo
		
		//Se o arquivo existir na DIRDOC, gravar ACB referente ao objeto
		If (file(PLSMUDSIS(cDirDocs + "\" + cNameServ)))
	// na submissao do xml ele tem que gravar no banco de conhecimento la no  |
	// portal
		nSaveSX8 := GetSX8Len()
		cObj := GetSXENum( "ACB", "ACB_CODOBJ" )

	
		ACB->(DbSetOrder(1))
		IF !(ACB->(MsSeek( xFilial("ACB") + cObj)))
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
	
		// Grava o codigo do objeto
			AC9->AC9_CODOBJ := cObj
			AC9->( MsUnlock() )
		EndIf
		EndIf
	Else

		dbSelectArea("ACB")
		ACB->(dbGoTop())
		ACB->(ACB->(dbSetOrder(2)))

		while ACB->(dbSeek(xFilial("ACB")+Upper(cNameServ)))
			aFile := U_CBALTNA(cNameServ)

			If aFile[1]
				cFile := aFile[2]
				cNameServ := aFile[2]+cExten
			Else
				Return
			EndIf
		EndDo

		Processa( { || __CopyFile( PLSMUDSIS(cPathFile), PLSMUDSIS(cDirDocs + "\" + cNameServ) ),lRet := File( PLSMUDSIS(cDirDocs + "\" + cNameServ) ) }, "Transferindo objeto","Aguarde...",.F.)

		If lDownload //Se permitir download, copia o arquivo para o diretorio web
			cDownload := SuperGetMV("MV_RELT")
			// Copio para pasta de downloads
			Processa( { || __COPYFILE( PLSMUDSIS(cPathFile), PLSMUDSIS(cDownload + "\" + cNameServ) ),lRet := File( PLSMUDSIS(cDownload + "\" + cNameServ) ) }, "Transferindo objeto","Aguarde...",.F.)
		EndIf
		
		If PlsAliasExi("BPL")
			If BPL->(FieldPos("BPL_CODIGO")) > 0

				If cAliasEnt == "BPL"
					u_CBINCPRT(cPathFile, cAliasEnt, cChaveUn,BPL->BPL_CODIGO,cNameServ)
				EndIf
			EndIf
		Endif

		nSaveSX8 := GetSX8Len()
		cObj := GetSXENum( "ACB", "ACB_CODOBJ" )
		
		ACB->(DbSetOrder(1))
		IF !(ACB->(MsSeek( xFilial("ACB") + cObj)))
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

	// Grava o codigo do objeto
		AC9->AC9_CODOBJ := cObj
		AC9->( MsUnlock() )
		EndIf 
	// Nao colocar mensagem informativa aqui pois essa rotina tambem eh 	   |
	//| executada em lote no xml
		If lHelp
			MsgInfo("Arquivo incluido com sucesso!")
		Endif
	EndIf
	RestArea(aArea)
Return()

/*/{Protheus.doc} u_CBBXXCONH
Visualiza o banco de conhecimento para o o xml posicionado
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
User Function CBBXXCONH()
	LOCAL aArea := getArea()
	LOCAL nPosSeq	:= aScan(_oBrwBXX:aHeader,{|x|AllTrim(x[2])=="BXX_SEQUEN"} )
	LOCAL cSequen	:= _oBrwBXX:aCols[_oBrwBXX:nAt,nPosSeq]
	Private aRotina := {}
// AROTINA UTILIZADO NA TELA DO CONHEC. =====================
	AaDd( aRotina, { "Visualizar", 			"MsDocument", 0, 2 } ) //"Visualizar"
	AaDd( aRotina, { "Visualizar", 			"MsDocument", 0, 2 } ) //"Visualizar"
	AaDd( aRotina, { "Visualizar", 			"MsDocument", 0, 2 } ) //"Visualizar"
	aAdd( aRotina, { "Conhecimento",		"MsDocument"	, 0, 3, 0, NIL } )
//=========================================================
	If !Empty(cSequen)
		BXX->(DbSetOrder(7))
		If BXX->(MsSeek(xFilial("BXX") + cSequen))
			cCadastro := "Conhecimento Protocolo XML"
			MsDocument( "BXX", BXX->( RecNo() ), 4 )
		EndIf
	Else
		msgAlert("Registro posicionado com arquivo invalido!")
	EndIf
	RestArea(aArea)
Return()

/*/{Protheus.doc} fCriaSX1
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
Static Function fCriaSX1(cPerg)

	Local aRegs	:=	{}
	aadd(aRegs,{cPerg,"01",'Data Base?',"","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

	PlsVldPerg(aRegs)

Return

/*/{Protheus.doc} U_CBDOcs
Inclusao rapida no banco de conhecimento
@type function
@author TOTVS
@since 05.04.13
@version 1.0
/*/
User Function CBDOcs(cAlias,nReg,nOpc)
	LOCAL cFileInc	  := cGetFile("*.*","Selecione o Arquivo" ,0,"",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.)
	LOCAL cChaveUn
	LOCAL cSlvAlias  := Alias()
	LOCAL nRecSX2    := SX2->(Recno())

	If ! Empty(cFileInc)
		DbSelectArea(cAlias)
		SX2->(DbSeek(cAlias))
		DbSelectArea(cAlias)
		DbGoTo(nReg)
		cChaveUn := &(AllTrim(SX2->X2_UNICO))
		If Empty(cChaveUn)
			DbSetOrder(1)
			cChaveUn:= &(&(cAlias+"->(IndexKey())"))
		EndIf

		u_CBINCONH(cFileInc, cAlias, cChaveUn,.F.,.F.,.T.,.T.,.T.)
	Endif

	If ! Empty(cSlvAlias)
		DbSelectArea(cSlvAlias)
	Endif

	If nRecSX2 > 0
		SX2->(DbGoTo(nRecSX2))
	Endif

Return

/*/{Protheus.doc} PLSALTNA
Verificar existencia de arquivo com mesmo nome e efetuar a alteraçao de nome
@type function
@author TOTVS
@since 05.04.13
@version 1.0
/*/
User Function CBALTNA(cNameServ)

	LOCAL cDirDocs   := ""
	LOCAL cFile      := ""
	LOCAL cExten     := ""
	LOCAL cRmvName   := ""
	LOCAL cNameTerm  := ""
	LOCAL cGet       := ""
	LOCAL cGetFile
	LOCAL lRet       := .T.

	LOCAL nOpca      := 0
	LOCAL nCount     := 0

	LOCAL oDlgNome
	LOCAL oBut1
	LOCAL oBut2
	LOCAL oBmp
	LOCAL oGet1
	LOCAL oBold
	Local aFiles
	LOCAL cCadastro :=""

	If FindFunction( "MsMultDir" ) .And. MsMultDir()
		cDirDocs := MsRetPath( cNameServ )
	Else
		cDirDocs := MsDocPath()
	Endif

	lRet := .F.
	If Aviso( "Aten��o", "O arquivo " + cNameServ + ;
			" nao pode ser incluido pois ja existe no diretorio do banco de conhecimento." + ;
			"Deseja alterar o nome do arquivo?", { "Sim", "Nao"}, 2 ) == 1

		SplitPath( cNameServ, , , @cFile, @cExten )

		cFile := Pad( cFile, Len( ACB->ACB_OBJETO ) )
		cGet  := ""

		// Abre a janela para a digitacao do novo nome

		DEFINE MSDIALOG oDlgNome TITLE cCadastro From ;
			0,0 To 180, 344 OF oMainWnd PIXEL

		DEFINE FONT oBold NAME "Arial" SIZE 0, -13 BOLD

		@  0, 0 BITMAP oBmp RESNAME "LOGIN" oF oDlgNome SIZE 40, 120 NOBORDER WHEN .F. PIXEL

		@ 03, 50 SAY "Alteracao de nome" PIXEL FONT oBold
		@ 12 ,40 TO 14 ,400 LABEL '' OF oDlgNome PIXEL

		@ 35, 50 MSGET cFile SIZE 115, 08 of oDlgNome PICTURE "@S40" PIXEL VALID !Empty( cFile )

			// Este GET foi criado para receber o foco do get acima. Nao retirar !!!

		@ 1000, 1000 MSGET oGet1 VAR cGet SIZE 25, 08 of oDlgNome PIXEL
		oGet1:bGotFocus := { || oBut1:SetFocus() }

		DEFINE SBUTTON oBut1 FROM 52, 135 TYPE 1 ACTION ( nOpca := 1,;
			oDlgNome:End() ) ENABLE of oDlgNome

		DEFINE SBUTTON oBut2 FROM 70, 135 TYPE 2 ACTION ( nOpca := 0,;
			oDlgNome:End() ) ENABLE of oDlgNome

		ACTIVATE MSDIALOG oDlgNome CENTERED

		If nOpca == 1
			cFile     := AllTrim( cFile )
			cNameServ := cFile + cExten
			lRet := .T.
		Else
			lRet  := .F.
		EndIf
	EndIf
Return {lRet,cFile}

/*/{Protheus.doc} PLSINCPRT
Funcao para incluir arquivo no banco de connhecimento Referente a noticias do portal
@type function
@author TOTVS
@since 22/01/14
@version 1.0
/*/
Function u_CBINCPRT(cPathFile, cAliasEnt, cChaveUn,cNmeDir,cNmeArq)

	LOCAL aArea 	:= getArea()
	LOCAL cFile	:= ""
	LOCAL cExten	:= ""
	LOCAL cDir	 	:= getPastPp()

	SplitPath( cPathFile,,, @cFile, @cExten )


// Insere underline nos espaços em branco do nome do arquivo, isso é
// necessário para fazer o download corretamente do arquivo no portal de
// noticias.

	cFile := STRTRAN(cNmeArq, " ", "_")

	If !Empty(cDir)

		// Cria diretorio arquivonoticia o diretório WEB
		MakeDir(getPastPp() + getSkinPls() + "\arquivonoticia")

		// Cria diretorio referente aos arquivos da noticia
		cDirDocs := getPastPp() + getSkinPls() + "\arquivonoticia\"+cNmeDir
		MakeDir(cDirDocs)

	EndIf

	ÄÄÄÄ
	// Copia o arquivo para a pasta

	__COPYFILE( PLSMUDSIS(cPathFile), PLSMUDSIS(cDirDocs + "\" + cFile) )

	RestArea(aArea)
Return()

/*/{Protheus.doc} PLSABLOQ
Funcao para desbloquear PEGs enviadas pelo portal
@type function
@author TOTVS
@since 19/08/14
@version 1.0
/*/
Static Function PLSABLOQ()
	LOCAL oDlgPeg
	LOCAL oBtnBuscar
	PRIVATE cBarra := Space(30)
	PRIVATE lRet := .T.

	DEFINE MSDIALOG oDlgPeg TITLE "Desbloqueio PEG" FROM 0,0 To 100, 218 of oMainWnd PIXEL

	oSaybar = TSay():New( 010,005,{||"Cód. Barras"},oDlgPeg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,100,008) //"Cód. Barras"
	@ 017,005 MSGET cBarra SIZE 100,10 OF oDlgPeg PIXEL PICTURE "@!" VALID CABAVLDBLQ() .and. CABACOLS()

	oBtnBuscar := TButton():New( 032,40,"Confirmar",oDlgPeg,{|| CABAVLDBLQ() .and. CABACOLS() },037,012,,,,.T.,,,,,,.F. ) //"Confirmar"

	ACTIVATE MSDIALOG oDlgPeg CENTERED

Return lRet


/*/{Protheus.doc} CABAVLDBLQ
@type function
@author TOTVS
@since 21/03/12
@version 1.0
/*/
Static Function CABAVLDBLQ()
	Private cMsg := ''
	Private nCount := 0

	If Empty(cBarra)
		MsgStop("Preencher código de barras!")
		Return
	Endif

	dbSelectArea('BXX')
	BXX->( dbSetorder(8) )//BXX_FILIAL + BXX_BARRAS

	If BXX->( MsSeek( xFilial("BXX")+AllTrim(cBarra)  ) ) .AND. BXX->BXX_BLOQUE == '1'
		BXX->(RecLock("BXX",.F.))
		BXX_BLOQUE := "0"
		BXX->( msUnLock() )

		//Ponto de entrada para atribuir outras informações ao registro da BXX
		//Parametro: 4 - Para diferenciar onde o PE é chamado, neste caso no desbloqueio do XML
		If ExistBlock("PL974BXX")
			ExecBlock("PL974BXX", .F., .F., {"4"})
		EndIf

		MsgInfo("PEG "+ BXX_CODPEG +" desbloqueada com sucesso.")
		cBarra := Space(30)
		oSaybar:SetFocus()
		Return lRet

	ElseIf BXX->BXX_BLOQUE == '0'
		MsgStop("PEG "+ BXX_CODPEG +" já desbloqueada.")
	Else
		MsgStop("PEG não localizada.")
	Endif

	cBarra := Space(30)
	oSaybar:SetFocus()

Return lRet

/*/{Protheus.doc} U_CBSUBLOT
Processamento da opção 'Submeter' utilizando múltiplas threads para agilizar o processamentos das guias.
@type function
@author TOTVS
@since 26/04/15
@version 1.0
/*/
User Function CBSUBLOT()

	If u_CBSUBXML()
		CABCOLSA()
	EndIf

	eval(_oBrwBXX:oBrowse:bChange)

Return .T.

/*/{Protheus.doc} U_CBIMPLOT
Processamento da opção 'Importar' utilizando múltiplas threads para agilizar o processamentos das guias.
@type function
@author TOTVS
@since 26/04/15
@version 1.0
/*/
User Function CBIMPLOT()
	Local lRet := .F.

	lRet := CABPPXML()

	If lRet
		CABCOLSA()
		_lAll := .f.
	EndIf

Return .T.


/*/{Protheus.doc} u_CABA974A
Ao importar o arq xml verifico se a Peg a receber as movimentacoes esta vazia, pois estava causando duplicidade
@author: Lucas Nonato
@since : 21/07/2016
/*/
User Function CABA974A(cChvPegB,cCodRda)

	Local lTdOK       := .F.
	Local cSQLPegX    := ""
	Local cCodOpe     := ""
	Local cCodLoc     := ""
	Local cCodPeg     := ""
	Local BD6XMLP     := ""
	DEFAULT cCodRDA   := ""
	DEFAULT cChvPegB  := ""

	cCodOpe := SUBSTR(cChvPegB,1,4)
	cCodLoc := SUBSTR(cChvPegB,5,4)
	cCodPeg := SUBSTR(cChvPegB,9,8)

	cSQLPegX := " SELECT COUNT(1) CONTADOR  FROM " + RetSqlName("BD6")
	cSQLPegX += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
	cSQLPegX += " AND BD6_CODOPE = '" + cCodOpe +"' "
	cSQLPegX += " AND BD6_CODLDP = '" + cCodLoc + "' "
	cSQLPegX += " AND BD6_CODPEG = '" + cCodPeg + "' "
	cSQLPegX += " AND BD6_CODRDA = '" + cCodRDA + "' "
	cSQLPegX += " AND D_E_L_E_T_ = ' ' "

	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQLPegX),"BD6XMLP",.F.,.T.)

	lTdOK := IIF ((BD6XMLP->CONTADOR = 0),.T.,.F.)

	BD6XMLP->(DbCloseArea())

Return (lTdOK)