/*+-------------------------------------------------------------------------+*
 *|Funcao      | CABANEG  | Autor | Eduardo Folly (Korus Consultoria)       |*
 *+------------+------------------------------------------------------------+*
 *|Data        | 07.05.2009                                                 |*
 *+------------+------------------------------------------------------------+*
 *|Descricao   | Programa para efetuar a negociação.                        |*
 *+------------+------------------------------------------------------------+*
 *|Solicitante | Antonio Segurasse / Financeiro                             |*
 *+------------+------------------------------------------------------------+*
 *|Arquivos    |                                                            |*
 *+------------+------------------------------------------------------------+*
 *|             ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            |*
 *+-------------------------------------------------------------------------+*
 *| Programador       |   Data   | Motivo da Alteração                      |*
 *+-------------------+----------+------------------------------------------+*
 *| Altamiro          |12/04/2017|rocado o titulos IGPM por ATUAL.          |*
 *+-------------------+----------+------------------------------------------+*/

#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"
                                
#Define _LF Chr(13)+Chr(10) // Quebra de linha.
#Define _BL 60				// Espaçamento na proposta de neogicação.

//*********************
User Function CABA211()
//*********************

	Local aArea	:= GetArea()

	Private cFilBA0	:= xFilial("BA0")
	Private cFilBA1	:= xFilial("BA1")
	Private cFilBI3	:= xFilial("BI3")
	Private cFilBSQ	:= xFilial("BSQ")
	Private cFilSA1 := xFilial("SA1")
	Private cFilSE1 := xFilial("SE1")
	Private cFilSZ4	:= xFilial("SZ4")
	Private cFilSZG := xFilial("SZG")
	Private cFilSZH := xFilial("SZH")

	Private cTpBaixa := "REE" // Deve ser NEG

    Private cCadastro := OemToAnsi("Negociação de Títulos em Atraso") 

	Private aCores	:= {{"SZG->ZG_STATUS == 'A'", "BR_VERDE"	},;	// Negociação em aberto.
						{"SZG->ZG_STATUS == 'P'", "BR_AMARELO"	},;	// Negociação com proposta impressa.
						{"SZG->ZG_STATUS == 'T'", "BR_AZUL"		},;	// Negociação com termo impresso.
						{"SZG->ZG_STATUS == 'C'", "BR_VERMELHO"	}}	// Negociação concluída.

	Private aRotina	:= {{OemToAnsi("Pesquisar")		, "AxPesqui"		, 0,  1},;
						{OemToAnsi("Visualizar")	, "U_caba011Crud"	, 0,  2},;
						{OemToAnsi("Incluir")		, "U_Caba011Crud"	, 0,  3},;
						{OemToAnsi("Alterar")		, "U_Caba011Crud"	, 0,  4},;
						{OemToAnsi("Imp. Proposta")	, "U_Cb011Imp"		, 0,  6},;
						{OemToAnsi("Imp. Termo")	, "U_Cb011WordImp"	, 0,  6},;
						{OemToAnsi("Confirmar")		, "U_Cb011Confirma"	, 0,  6},;
						{OemToAnsi("Cancelar")		, "U_Cb011Cancel"	, 0,  5},;
						{OemToAnsi("Legenda")		, "U_Caba011Leg"	, 0,  6},;
						{OemToAnsi("Teste")			, "U_UUTeste()"	, 0,  6}}

	Private cPerg := "CABA10"

	aSX1 := {}
	aAdd(aSx1,{"GRUPO", "ORDEM", "PERGUNT"             , "VARIAVL", "TIPO", "TAMANHO", "DECIMAL", "GSC", "VALID", "VAR01"   , "F3", "GRPSXG", "DEF01", "DEF02", "DEF03", "DEF04", "DEF05"})
	aAdd(aSx1,{cPerg  , "01"   , "Somente em carteira?", "mv_ch1" , "N"   , 1        , 0        , "C"  , ""     , "mv_par01", ""  , ""      , "Sim"  , "Nao"  , ""     , ""     , ""     })
	fCriaSX1(cPerg, aSX1)

	Pergunte(cPerg, .F.)

	SetKey(123, {||Pergunte("CABA10", .T.)})

	mBrowse(6, 1, 22, 75, "SZG",,,,,,aCores)

	SetKey(123)

	RestArea(aArea)
Return


/*+-------------------------------------------------------------------------+
  |  Função........: caba011Leg                                             |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Legenda da rotina.                                     |
  +-------------------------------------------------------------------------+*/
//************************
User Function caba011Leg()
//************************
	BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"		, "Negociação em aberto."				},;
										{"BR_AMARELO"	, "Negociação com proposta impressa."	},;
										{"BR_AZUL"		, "Negociação com termo impresso."		},;
										{"BR_VERMELHO"	, "Negociação concluída."				}})

Return Nil


/*+-------------------------------------------------------------------------+
  |  Função........: caba011Crud                                            |
  |  Data..........: 12.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Manutenção das informações das negociações.            |
  +-------------------------------------------------------------------------+*/
//*****************************************
User Function caba011Crud(cAlias,nReg,nOpc)
//*****************************************
	
	Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aObjects	:= {}
	Local aButtons	:= {}
	Local aSize		:= MsAdvSize()
	Local aSN		:= {"Sim", "Não"}
	Local nOpca		:= 0
	Local oDlg

	Local nTop		:= aSize[1]
	Local nBotton	:= aSize[3]
	Local nLeft		:= aSize[1]
	Local nRight	:= aSize[5]
 
	Local nTamPSup	:= 20	// Tamanho do painel superior
	Local nTamPLat	:= 100	// Tamanho do painel lateral

	Local oFnt14	:= TFont():New("Arial",,14,,.F.,,,,,.F.,.F.)
	Local oFnt16	:= TFont():New("Arial",,16,,.F.,,,,,.F.,.F.)
	
	Private oTik		:= LoadBitMap(GetResources() , "LBOK_OCEAN" )
	Private oNul		:= LoadBitMap(GetResources() , "LBNO_OCEAN" )
	Private cNeg		:= ""
	Private cCliente	:= SZG->ZG_CLIENTE
	Private cLojaCli	:= SZG->ZG_LOJA
    Private cAlsSE1		:= GetNextAlias()
	Private dDtNeg		:= dDataBase

	Private cIgpm		:= "Não"
	Private cJuros		:= "Não"
	Private nTotSel		:= 0
	Private nVlPre		:= 0
	Private cCndPag		:= CriaVar("ZG_CONDPAG")
	Private nTxJur		:= SuperGetMv("MV_CABJUR1",,1)
	Private nVlNeg		:= 0
	Private lErrIgpm	:= .T. // Para mostrar erro do cadastro do IGPM somente na primeira vez que ocorrer.
	Private cUltCob		:= ""

	Private aCampos		:= {}
	Private aParcelas	:= {}
	Private dParcela	:= Ctod("  /  /  ")
	Private aHdPar		:= {}
	Private	aClPar		:= {}

	// Ordem dos campos do tcbrowse.
	Private aOrdCmp		:= {"E1_PREFIXO", "E1_NUM"    , "E1_PARCELA", "E1_TIPO"   , "E1_SALDO"  , "E1_VENCREA", "E1_MESBASE",;
							"E1_ANOBASE", "E1_CODINT" , "E1_CODEMP" , "E1_MATRIC" , "E1_DECRESC", "E1_ACRESC"}

	// Ordem dos campos do msnewgetdados.
	Private aOrdGet		:= {"E1_PREFIXO", "E1_NUM"   , "E1_PARCELA", "E1_TIPO"   , "E1_SALDO", "E1_VENCREA"}

	Pergunte(cPerg, .F.)

	// CABA995 - Manutenção do cadastro de IGPM.
	aAdd(aButtons, {"PEDIDO", {||U_CABA995()}, "Manut. IGPM"})

	// Sendo um inclusão o usuário deverá selecionar o cliente.
	If nOpc == 3
		cNeg := CriaVar("ZG_CODIGO")
		fNextNeg()

		bOpca		:= .F.
		cCliente	:= Space(6)
		cLoja		:= Space(2)

		Define MsDialog oDlgCli From 000,000 To 110,213 Title "Cliente da Negociação" Of oMainWnd Pixel
		@ 004, 007 To 035, 100
		@ 010, 014 Say "Cliente"
		@ 018, 014 Get cCliente	Size 52,08 F3 "SA1"
		@ 010, 070 Say "Loja"
		@ 018, 070 Get cLoja    Size 20,08 Valid ExistCpo("SA1") .Or. Vazio()

		@ 038, 040 BmpButton Type 1 Action (bOpca := .T., oDlgCli:End())
		@ 038, 070 BmpButton Type 2 Action (oDlgCli:End())

		Activate MsDialog oDlgCli Centered

		If !bOpca
			Return
		EndIf

		UltimaCobr(.T.) // Obtem data para inicio das parcelas.
	Else
		If SZG->ZG_STATUS == "C" .And. nOpc == 4
			ApMsgAlert("Uma negociacao concluida nao pode ser alterada.")
			Return .F.
		EndIf

		cNeg := SZG->ZG_CODIGO

    EndIf

	If Select(cAlsSE1) > 0; (cAlsSE1)->(dbCloseArea()); EndIf

	// Definição dos campos.
	dbSelectArea("SX3")
	aAreaSX3 := SX3->(GetArea())
	SX3->(dbSetOrder(2))
	For x := 1 To Len(aOrdCmp)
  		If SX3->(dbSeek(aOrdCmp[x]))
			aAdd(aCampos, {SX3->X3_TITULO, SX3->X3_CAMPO, SX3->X3_PICTURE, SX3->X3_TAMANHO, SX3->X3_DECIMAL, "", .F., SX3->X3_TIPO, "", "", 0})
  		EndIf
 	Next

	For x := 1 To Len(aOrdGet)
  		If SX3->(dbSeek(aOrdGet[x]))
			aAdd(aHdPar, {SX3->X3_TITULO, SX3->X3_CAMPO, SX3->X3_PICTURE, SX3->X3_TAMANHO, SX3->X3_DECIMAL, "", .F., SX3->X3_TIPO, "", ""})
  		EndIf
 	Next
	RestArea(aAreaSX3)

	C010AbreTit(nOpc)

	nRegs := 0
	(cAlsSE1)->(dbEval({||nRegs++}))

    If nRegs == 0 //.And. nOpc <> 2
		ApMsgStop("Não existem títulos em aberto para este cliente.")
		Return .F.
    EndIf

	cTRB := CriaTrab(Nil, .F.)
	COPY TO &(cTRB)
	(cAlsSE1)->(dbclosearea())

	cAlsSE1 := "TRB2" // GetNextAlias() -- Erro de Create Index.

	dbUseArea(.T., , cTRB, (cAlsSE1), .F., .F.)
	// IndRegua((cAlsSE1), (cAlsSE1), "E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO",,/*cCondicao*/, "Ordenando arquivo temporário...")

	If nOpc != 3 // Diferente de inclusão
		cJuros		:= If(SZG->ZG_JUROS == "S", "Sim", "Não")
		cIgpm		:= If(SZG->ZG_IGPM == "S", "Sim", "Não")
		nTxJur		:= SZG->ZG_TXJUROS
		cCndPag		:= SZG->ZG_CONDPAG
		dDtNeg		:= SZG->ZG_DTNEG
		nTotSel		:= SZG->ZG_VLTOTAL
		nVlPre		:= SZG->ZG_VLPRESE
		nVlNeg		:= SZG->ZG_VALOR

		// Selecionar titulos.
		dbSelectArea("SZH")
		SZH->(dbSetOrder(1))
		SZH->(dbSeek(cFilSZH + cNeg + "E"))
		While !SZH->(Eof()) .And. SZH->(ZH_CODIGO+ZH_NEGTIPO) == cNeg + "E"
			If (cAlsSE1)->(dbSeek(SZH->(ZH_PREFIXO+ZH_NUM+ZH_PARCELA+ZH_TIPO)))
				RecLock(cAlsSE1, .F.)
				(cAlsSE1)->OK := "X"
				(cAlsSE1)->(MsUnlock())
			EndIf
			SZH->(dbSkip())
		EndDo
		(cAlsSE1)->(dbGoTop())

		// Se tiver sido confirmada deverá localizar as parcelas geradas.
		If nOpc == 2 .And. SZG->ZG_STATUS == "C"
			dbSelectArea("SZH")
			SZH->(dbSetOrder(1))
			SZH->(dbSeek(cFilSZH + cNeg + "S"))
			While !SZH->(Eof()) .And. SZH->(ZH_CODIGO+ZH_NEGTIPO) == cNeg + "S"
				aAdd(aClPar, {SZH->ZH_PREFIXO, SZH->ZH_NUM, SZH->ZH_PARCELA, SZH->ZH_TIPO, SZH->ZH_VALOR, SZH->ZH_VENCREA, .F.})
				SZH->(dbSkip())
			EndDo
		EndIf

	EndIf

//	CalcValPres() // Calculo do valor presente.

	oDlg := MsDialog():New(nTop, nLeft, nBotton, nRight, cCadastro,,,,,,,, oMainWnd, .T.)

	// Painel Superior
	nTop		+= 12
	nPTamH		:= (nRight - nLeft) /  2
	nPTamV		:= nTamPSup
	nPLeft		:= 0

	//oPanelSupA	:= tPanel():New(nTop + nPTamV, nPLeft, "", oDlg,,,,, CLR_GRAY, nPTamH, 1)
	//oPanelSup	:= tPanel():New(nTop, nPLeft, "", oDlg,,,,, CLR_HGRAY, nPTamH, nPTamV)
	nTop		+= 3

	nPLeft		+= 5
	oSay9		:= tSay():New(nTop + 2, nPLeft, {|| "Negociação:"}, oDlg,, oFnt14,,,, .T.,,, nPTamH, 12)
	nPLeft		+= 32
	oGetNeg		:= tGet():New(nTop, nPLeft, bSetGet(cNeg), oDlg, 50, 10, "@!",,,, oFnt14,,, .T.,,, {||.T.},,,,.T.,,, "cNeg")

	nPLeft		+= 58
	oSay10		:= tSay():New(nTop + 2, nPLeft, {|| "Cliente:"}, oDlg,, oFnt14,,,, .T.,,, nPTamH, 12)
	nPLeft		+= 20
	oGetCli		:= tGet():New(nTop, nPLeft, bSetGet(cCliente), oDlg, 50, 10, "@!",,,, oFnt14,,, .T.,,, {||.T.},,,,.T.,,, "cCliente")

	nPLeft		+= 58
	oSay11		:= tSay():New(nTop + 2, nPLeft, {|| "Loja:"}, oDlg,, oFnt14,,,, .T.,,, nPTamH, 12)
	nPLeft		+= 14
	oGetLjCli	:= tGet():New(nTop, nPLeft, bSetGet(cLojaCli), oDlg, 20, 10, "@!",,,, oFnt14,,, .T.,,, {||.T.},,,,.T.,,, "cLojaCli")

	bAtuVlPre	:= {|| MsgRun("Calculando ...",,{||(CalcValPres(),fHeaderClick(.F.),CalcParcelas())})}

	// Painel Lateral.
	nTop	:= aSize[1] + 12
	nPTamH	:= nTamPLat
	nPTamV	:= ((nBotton - nTop) / 2) - nTop
	nPLeft	:= ((nRight - nLeft) /  2) - nPTamH + 2


//	oPanelLatA	:= tPanel():New(nTop + nTamPSup, nPLeft - 1, "", oDlg,,,,, CLR_GRAY, 1, nPTamV)
//	oPanelLat	:= tPanel():New(nTop, nPLeft, "", oDlg,,,,, CLR_HGRAY, nPTamH, nPTamV)

	nPLeft	+= 08
	nPTamH	-= 12

	nTop += 05
	oSay1		:= tSay():New(nTop, nPLeft, {|| "Utiliza IGMP:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oCmbIgmp	:= tComboBox():New(nTop, nPLeft, bSetGet(cIgpm), aSN, nPTamH, 12, oDlg,,, bAtuVlPre,,, .T., oFnt16)

	nTop += 15
	oSay2		:= tSay():New(nTop, nPLeft, {|| "Utiliza Juros:"}, oDlg,, oFnt16,,,, .T.,,, 100, 12)
	nTop += 10
	oCmbJuros	:= tComboBox():New(nTop, nPLeft, bSetGet(cJuros), aSN, nPTamH, 12, oDlg,,, bAtuVlPre,,, .T., oFnt16)

	nTop += 15
	oSay3		:= tSay():New(nTop, nPLeft, {|| "Data da Negociação:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetDtNeg	:= tGet():New(nTop, nPLeft, bSetGet(dDtNeg), oDlg, nPTamH, 10, "@D",,,, oFnt16,,, .T.,,, {||.T.},,,bAtuVlPre)

	nTop += 17
	oSay4		:= tSay():New(nTop, nPLeft, {|| "Condição de Pagamento:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetCndPag	:= tGet():New(nTop, nPLeft, bSetGet(cCndPag), oDlg, nPTamH, 10, "@D",{||ExistCPO("SE4")},,, oFnt16,,, .T.,,, {||.T.},,,{||CalcParcelas()},,,"SE4", "cCndPag")

	nTop += 50 // Espaçamento
	oSay5		:= tSay():New(nTop, nPLeft, {|| "Total Selecionado:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetTotSel	:= tGet():New(nTop, nPLeft, bSetGet(nTotSel), oDlg, nPTamH, 10, "@E 999,999,999,999.99",,,, oFnt16,,, .T.,,, {||.T.},,,,.T.,,, "nTotSel")

	nTop += 17
	oSay6		:= tSay():New(nTop, nPLeft, {|| "Valor Presente:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetVlPre	:= tGet():New(nTop, nPLeft, bSetGet(nVlPre),  oDlg, nPTamH, 10, "@E 999,999,999,999.99",,,, oFnt16,,, .T.,,, {||.T.},,,,.T.,,, "nVlPre")

	nTop += 17
	oSay8		:= tSay():New(nTop, nPLeft, {|| "Taxa de Juros (%):"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetTxJur	:= tGet():New(nTop, nPLeft, bSetGet(nTxJur),  oDlg, nPTamH, 10, "@E 999,999,999,999.99",,,, oFnt16,,, .T.,,, {||.T.},,,,.T.,,, "nTxJur")

	nTop += 17
	oSay7		:= tSay():New(nTop, nPLeft, {|| "Valor Negociação:"}, oDlg,, oFnt16,,,, .T.,,, nPTamH, 12)
	nTop += 10
	oGetVlNeg	:= tGet():New(nTop, nPLeft, bSetGet(nVlNeg),  oDlg, nPTamH, 10, "@E 999,999,999,999.99",,,, oFnt16,,, .T.,,, {||.T.},,,,.T.,,, "nVlNeg")

	// Centro da página

	// TcBrowse - Seleção de títulos.
	nTop	:= (aSize[1] + nTamPSup + 13)
	nLeft	:= aSize[1]
	nWidth	:= (aSize[5] - nLeft) / 2 - nTamPLat + 1
	nHeight	:= (aSize[3] / 2 - nTop) / 2

	oBrwTit	:= TCBrowse():New(nTop, nLeft, nWidth, nHeight,,,,oDlg,,,,{||.T.},,,,,,,,.F.,cAlsSE1,.T.,,.F.,,,.F.)

	nAls := Select(cAlsSE1)
	
	If nOpc == 3 .Or. nOpc == 4
		oBrwTit:AddColumn(TCColumn():New("",{||If(Empty((cAlsSE1)->OK),oNul,oTik)},,,,,08,.T.,.F.,,,,.F.))
	EndIf
	
	For x := 1 To Len(aCampos)
		If aCampos[x][11] > 0
			nEspaco := aCampos[x][11]
		Else
			nEspaco := If(aCampos[x][4]>Len(aCampos[x][1]), 3+(aCampos[x][4]*3.7), 3+(Len(aCampos[x][1])*3.7))
		EndIf
		oCol := TCColumn():New(aCampos[x][1], FieldWBlock(aCampos[x][2], nAls), aCampos[x][3],,, If(aCampos[x][8]=="N","RIGHT","LEFT"), nEspaco, .F., .F.,,,, .F.,)
		oBrwTit:AddColumn(oCol)
	Next

	oBrwTit:blDblClick := {||fClick()}
	oBrwTit:bHeaderClick := {||fHeaderClick()}

	// MsNewGetDados - Parcelas
	nAux	:= nTop - nTamPSup
	nTop	+= nHeight
	nHeight := (aSize[3] - nAux) / 2

	oGetPar	:= MsNewGetDados():New(nTop, nLeft, nHeight, nWidth, 2, "AllwaysTrue", "AllwaysTrue",,{},,, Nil,,, oDlg, aHdPar, aClPar)

	oBrwTit:SetFocus()

	If nOpc == 2
		// Desabilitar itens
		oCmbIgmp:Disable()
		oCmbJuros:Disable()
		oGetDtNeg:lReadOnly := .T.
		oGetCndPag:lReadOnly := .T.
		oBrwTit:blDblClick := {||}
		oBrwTit:bHeaderClick := {||}

		// Remover itens que não pertencem a negociação.
		(cAlsSE1)->(dbGoTop())
		While !(cAlsSE1)->(Eof())
			If Empty((cAlsSE1)->OK)
				RecLock(cAlsSE1, .F.)
				(cAlsSE1)->(dbDelete())
				(cAlsSE1)->(MsUnlock())
			EndIf
			(cAlsSE1)->(dbSkip())
		EndDo
		(cAlsSE1)->(dbGoTop())

	EndIf

	If nOpc != 3 .And. SZG->ZG_STATUS != "C"
		Eval(bAtuVlPre)
	EndIf

	oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg, {||If(CABA010Ok(),(nOpca:=1,oDlg:End()),"")}, {||oDlg:End()},,aButtons))

	If nOpca == 1 // Botão OK clicado.

		If nOpc == 3 .Or. nOpc == 4 // Se for inclusão ou alteração.
			lInclui := nOpc == 3
			
			// Verifica se o número da negociação já existe.
			cOldNeg := cNeg
			If lInclui
				fNextNeg()
			EndIf

			aMat := {}
			fRetMat(@aMat)

			// Salvar informações da negociação.
			If !lInclui
				dbSelectArea("SZG")
				dbSetOrder(1)
				dbSeek(cFilSZG+cNeg)
			EndIf

			nDep := 0
			If BA1->(DbSeek(cFilBA1+aMat[1]+aMat[2]+aMat[3]))
				While !BA1->(Eof()) .And. aMat[1]+aMat[2]+aMat[3] == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC
					If AllTrim(BA1->BA1_TIPUSU) <> "T" .and. AllTrim(BA1->BA1_DATBLO) == '' // ALTAMIRO	21/08/2018
						nDep ++
					Else
						cCodPla		:= BA1->BA1_CODPLA + " - "
						cCodPla		+= Posicione("BI3", 1, cFilBA1+BA1->BA1_CODINT+BA1->BA1_CODPLA, "BI3_NREDUZ")
						nIdade		:= Int((Date() - BA1->BA1_DATNAS)/365)
						nTemplano	:= Int((Date() - BA1->BA1_DATINC)/365)
					EndIf
					BA1->(dbSkip())
				EndDo
			EndIf

			nVlSinist	:= 0
			nAnoBase	:= Val(Left(Dtos(dDtNeg), 4))
			While(nVlSinist == 0)
				nVlSinist := RetVlStl(aMat[1]+aMat[2]+aMat[3], AllTrim(Str(nAnoBase)), "4")
				nAnoBase--
				If nAnoBase < 2005
					Exit
				EndIf
            EndDo

			RecLock("SZG", lInclui)
			SZG->ZG_FILIAL	:= cFilSZG
			SZG->ZG_CODIGO	:= cNeg
			SZG->ZG_STATUS	:= "A"
			SZG->ZG_CLIENTE	:= cCliente
			SZG->ZG_LOJA	:= cLojaCli
			SZG->ZG_NOME	:= Posicione("SA1", 1, cFilSA1+cCliente+cLojaCli, "A1_NOME")
			SZG->ZG_CODINT	:= aMat[1]
			SZG->ZG_CODEMP	:= aMat[2]
			SZG->ZG_MATRIC	:= aMat[3]
			SZG->ZG_TIPREG	:= "00" // Verificar se está correto.
			SZG->ZG_PLANO	:= cCodPla
			SZG->ZG_IDADE	:= nIdade
			SZG->ZG_DEPENDE	:= nDep
			SZG->ZG_TEMPOPL	:= nTemplano
			SZG->ZG_SINISTR	:= nVlSinist
			SZG->ZG_JUROS	:= Left(cJuros, 1)
			SZG->ZG_IGPM	:= Left(cIgpm, 1)
			SZG->ZG_TXJUROS	:= nTxJur
			SZG->ZG_CONDPAG := cCndPag
			SZG->ZG_DTNEG	:= dDtNeg
			SZG->ZG_VLTOTAL := nTotSel
			SZG->ZG_VLPRESE	:= nVlPre
			SZG->ZG_VALOR	:= nVlNeg
			SZG->(MsUnlock())

			// Salvar itens da negociação.
			// Titulos selecionados
			dbSelectArea("SZH")
			SZH->(dbSetOrder(1))
			dbSelectArea(cAlsSE1)
			(cAlsSE1)->(dbGoTop())
			While !(cAlsSE1)->(Eof())
				If !Empty((cAlsSE1)->OK)
					lAdd := .T. // Cria 
					If SZH->(dbSeek(cFilSZH + cNeg + "E" + (cAlsSE1)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						lAdd := .F. // Atualiza
					EndIf
					
					RecLock("SZH", lAdd)
					SZH->ZH_FILIAL	:= cFilSZH
					SZH->ZH_CODIGO	:= cNeg
					SZH->ZH_NEGTIPO	:= "E" // E=Entrada / S=Saida
					SZH->ZH_PREFIXO	:= (cAlsSE1)->E1_PREFIXO
					SZH->ZH_NUM		:= (cAlsSE1)->E1_NUM
					SZH->ZH_PARCELA	:= (cAlsSE1)->E1_PARCELA
					SZH->ZH_TIPO	:= (cAlsSE1)->E1_TIPO
					SZH->ZH_VENCREA	:= (cAlsSE1)->E1_VENCREA
					SZH->ZH_ANOBASE	:= (cAlsSE1)->E1_ANOBASE
					SZH->ZH_MESBASE	:= (cAlsSE1)->E1_MESBASE
					SZH->ZH_VLORI	:= (cAlsSE1)->E1_SALDO
					SZH->ZH_VLPRESE := (cAlsSE1)->VLPRESENTE
					SZH->ZH_VALOR	:= If((cAlsSE1)->VLPRESENTE==0, (cAlsSE1)->E1_SALDO, (cAlsSE1)->VLPRESENTE)
					SZH->(MsUnlock())
				Else
					If SZH->(dbSeek(cFilSZH + cNeg + "E" + (cAlsSE1)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						RecLock("SZH", .F.)
						SZH->(dbDelete()) // Exclui
						SZH->(MsUnlock())
					EndIf
				EndIf
				(cAlsSE1)->(dbSkip())
			EndDo

			// Titulos criados

			// Mensagem informando que o número da negociação foi alterado.
			If lInclui
				If cOldNeg != cNeg
					ApMsgAlert("Negociação salva com o número " + cNeg + ".")
				EndIF
			PutMv("MV_XNUMNEG", cNeg)
			EndIf

		EndIf

	EndIf
	
	If Select(cAlsSE1) > 0; (cAlsSE1)->(dbCloseArea()); EndIf

Return


/*+-------------------------------------------------------------------------+
  |  Função........: caba011Ok                                              |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Validação dos dados da tela (TudoOK).                  |
  +-------------------------------------------------------------------------+*/
//*************************
Static Function caba011Ok()
//*************************
	Local lRet := .F.
	
	// Verifica se existe pelo menos um título selecionado.
	dbSelectArea(cAlsSE1)
	aAreaSE1 := (cAlsSE1)->(GetArea())
	(cAlsSE1)->(dbGoTop())
	While !(cAlsSE1)->(Eof()) .And. !lRet
		If !Empty((cAlsSE1)->OK)
			lRet := !lRet
		EndIf
		(cAlsSE1)->(dbSkip())
	EndDo

	If !lRet
		ApMsgStop("Pelo menos um título deve ser selecionado.")
	EndIf

	// Verificar se a data da negociação está preenchida.
	If lRet .And. Empty(dDtNeg)
		lRet := !lRet
		ApMsgStop("A data de negociação deve ser informada.")
	EndIf

	// Verificar se a condição de pagamento está preenchida.
	If lRet .And. Empty(cCndPag)
		lRet := !lRet
		ApMsgStop("A condição de pagamento deve ser informada.")
	EndIf

	RestArea(aAreaSE1)

Return lRet


/*+-------------------------------------------------------------------------+
  |  Função........: C010AbreTit                                            |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Query para obter títulos em aberto do cliente.         |
  +-------------------------------------------------------------------------+*/
//*******************************
Static Function C010AbreTit(nOpc)
//*******************************

Local a := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cQry := ""
	Local cTabSE1	:= RetSqlName("SE1")	
	Local cTabSZG	:= RetSqlName("SZG")
	Local cTabSZH	:= RetSqlName("SZH")

	cQry += _LF + "SELECT ' ' AS OK, " + Implode(aOrdCmp, ", ")
	cQry += _LF + ", 0 AS VLPRESENTE "
	cQry += _LF + "FROM " + cTabSE1
	cQry += _LF + "WHERE " + cTabSE1 + ".D_E_L_E_T_ <> '*'"
	cQry += _LF + "	AND E1_FILIAL  = '" + cFilSE1  + "'"
	cQry += _LF + "	AND E1_CLIENTE = '" + cCliente + "'"
	cQry += _LF + "	AND E1_LOJA    = '" + cLojaCli + "'"
    // Somente títulos em carteira.
	If mv_par01 == 1
		cQry += _LF + "	AND E1_PORTADO    = '   '"
	EndIf
	cQry += _LF + "	AND E1_TIPO NOT IN " + FormatIn(MVABATIM, "|"     )
	cQry += _LF + "	AND E1_TIPO NOT IN " + FormatIn(MV_CRNEG, If("|"$MV_CRNEG, "|", ",") )
	cQry += _LF + "	AND E1_TIPO NOT IN " + FormatIn(MVRECANT, If("|"$MVRECANT, "|", ",") )
	cQry += _LF + "	AND (E1_ORIGEM IN ('PLSA510') OR E1_PREFIXO = 'ANT' OR TRIM(E1_TIPO) IN ('PR','FT'))"

	If nOpc == 2
		// Listar titulos pertencentes somente a esta negociação.
		cQry += _LF + "	AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO IN ("
	Else
		cQry += _LF + "	AND (E1_VENCTO  < '" + Dtos(dDtNeg) + "' OR TRIM(E1_TIPO) IN ('PR','FT'))"
		cQry += _LF + "	AND E1_SALDO > 0"
		// Não listar titulos que pertencem a outras negociações.
		cQry += _LF + "	AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO NOT IN ("
	EndIf

	cQry += _LF + "		SELECT ZH_PREFIXO||ZH_NUM||ZH_PARCELA||ZH_TIPO FROM " + cTabSZG
	cQry += _LF + "		LEFT JOIN " + cTabSZH + " ON"
	cQry += _LF + "		ZH_FILIAL = ZG_FILIAL"
	cQry += _LF + "		AND ZH_CODIGO = ZG_CODIGO"
	cQry += _LF + "		AND " + cTabSZH + ".D_E_L_E_T_ = " + cTabSZG + ".D_E_L_E_T_"
	cQry += _LF + "		WHERE ZG_CLIENTE = '" + cCliente + "'"
	cQry += _LF + "		AND ZG_LOJA = '" + cLojaCli + "'"
	cQry += _LF + "		AND ZH_NEGTIPO = 'E'"
	cQry += _LF + "		AND ZG_FILIAL = '" + cFilSZG  + "'"
	cQry += _LF + "		AND " + cTabSZG + ".D_E_L_E_T_ <> '*'"
	
	If nOpc == 2
		cQry += _LF + "		AND ZG_CODIGO = '" + cNeg + "'"
	EndIf

	If nOpc == 4
		cQry += _LF + "		AND ZG_CODIGO <> '" + cNeg + "'"
	EndIf

	cQry += _LF + "	)"

	cQry += _LF + "	ORDER BY E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "
	
	dbUseArea(.T.,'TOPCONN',TCGenQry(,,cQry), cAlsSE1, .T., .T.)

	For a := 1 To Len(aCampos)
		If aCampos[a][8] == "D"
			TCSetField(cAlsSE1, aCampos[a][2], "D", aCampos[a][4], aCampos[a][5])
		EndIf
	Next

Return


/*+-------------------------------------------------------------------------+
  |  Função........: fClick                                                 |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Ao selecionar um titulo.                               |
  +-------------------------------------------------------------------------+*/
//*****************************
Static Function fClick(lUpdate)
//*****************************
	Default lUpdate := .T.

	If !(cAlsSE1)->(Eof())

		If lUpdate
		
			cMat := fRetMat()

			If Len(cMat)==0 .Or. cMat == (cAlsSE1)->(E1_CODINT+E1_CODEMP+E1_MATRIC)
		
				RecLock(cAlsSE1, .F.)
				(cAlsSE1)->OK := If((cAlsSE1)->OK=="X", "", "X")
				(cAlsSE1)->(MsUnLock())

				If (cAlsSE1)->OK == "X"
					nTotSel	+= (cAlsSE1)->E1_SALDO
					nVlPre	+= (cAlsSE1)->E1_SALDO + (cAlsSE1)->VLPRESENTE
				Else
					nTotSel	-= (cAlsSE1)->E1_SALDO
					nVlPre	-= (cAlsSE1)->E1_SALDO + (cAlsSE1)->VLPRESENTE
				EndIf
				CalcParcelas()

			Else
				ApMsgStop("Apenas títudos com mesma matrícula podem ser selecionados.")
			EndIf

		Else
			If (cAlsSE1)->OK == "X"
				nTotSel	+= (cAlsSE1)->E1_SALDO
				nVlPre	+= (cAlsSE1)->E1_SALDO + (cAlsSE1)->VLPRESENTE
			EndIf	
		EndIf		

		oGetTotSel:Refresh()
		oGetVlPre:Refresh()
    EndIf
Return


/*+-------------------------------------------------------------------------+
  |  Função........: fRetMat                                                |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Verifica se existe algum título selecionado e retorna  |
  |                : a matrícula.                                           |
  +-------------------------------------------------------------------------+*/
//	aArray deve ser passado por referencia para obter os valores separados.
//*****************************
Static Function fRetMat(aArray)
//*****************************
	Local cMat		:= ""
	Local aAreaSE1	:= (cAlsSE1)->(GetArea())
	Local lPesq		:= .T.

	aArray	:= {}

	(cAlsSE1)->(dbGoTop())

	While !(cAlsSE1)->(Eof()) .And. lPesq
		If !Empty((cAlsSE1)->OK)
			cMat := (cAlsSE1)->(E1_CODINT+E1_CODEMP+E1_MATRIC)
			aAdd(aArray, (cAlsSE1)->(E1_CODINT))
			aAdd(aArray, (cAlsSE1)->(E1_CODEMP))
			aAdd(aArray, (cAlsSE1)->(E1_MATRIC))
			lPesq := .F.
		EndIf
		(cAlsSE1)->(dbSkip())
	EndDo

	RestArea(aAreaSE1)

Return cMat


/*+-------------------------------------------------------------------------+
  |  Função........: fHeaderClick                                           |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Ao inverter seleção dos titulos ou necessidade de      |
  |                : atualizar os valores painel lateral.                   |
  +-------------------------------------------------------------------------+*/
//***********************************
Static Function fHeaderClick(lUpdate)
//***********************************
	Local nReg := (cAlsSE1)->(RecNo())

	Default lUpdate := .T.

	If !lUpdate
		nTotSel	:= 0
		nVlPre	:= 0
	EndIf

	(cAlsSE1)->(dbGoTop())
	While !(cAlsSE1)->(Eof())
		fClick(lUpdate)
		(cAlsSE1)->(dbSkip())
	EndDo

	(cAlsSE1)->(dbGoTo(nReg))
	oBrwTit:Refresh()
Return


/*+-------------------------------------------------------------------------+
  |  Função........: CalcValPres                                            |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Calcula valor presente dos titulos.                    |
  +-------------------------------------------------------------------------+*/
//***************************
Static Function CalcValPres()
//***************************
	Local aArea := (cAlsSE1)->(GetArea())

	(cAlsSE1)->(dbGoTop())
	While !(cAlsSE1)->(Eof())
		RecLock(cAlsSE1, .F.)
		If cIgpm == "Sim"
			nValor := (cAlsSE1)->E1_SALDO - (cAlsSE1)->E1_DECRESC + (cAlsSE1)->E1_ACRESC
			(cAlsSE1)->VLPRESENTE := CalcIgpm((cAlsSE1)->E1_VENCREA, dDtNeg, nValor, .T., lErrIgpm)
			lErrIgpm := .F.
		Else
			(cAlsSE1)->VLPRESENTE := 0
		EndIf
		(cAlsSE1)->(MsUnlock())

		(cAlsSE1)->(dbSkip())
	EndDo

	RestArea(aArea)
Return


/*+-------------------------------------------------------------------------+
  |  Função........: CalcIgpm                                               |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Calculo do IGPM.                                       |
  +-------------------------------------------------------------------------+*/
//**************************************************************
Static Function CalcIgpm(dDataTit, dDataBx, nValor, lIGP, lErro)
//**************************************************************
	
Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local MULTA     := GetNewPar("MV_XMULTA", 2) // Multa por mora ??
//	Local JUROS     := GetNewPar("MV_XJUROS", 1)
	Local IGPM      := 0
	Local DATATIT   := dDataTit
	Local DATABAIXA := dDataBx
	Local VALOR     := nValor
	Local TOTDEV    := 0
	Local DATAPROC  := ""
	Local aIgpm     := {}
	Local aArea     := GetArea()
	Local aErros	:= {}

	Default lIGP    := .T.
//	Default lJuros  := .T.
	Default lErro	:= .T.

	nDiasAt  := DATABAIXA - DATATIT
	nDiasAt2 := DATABAIXA - DATATIT

	dbSelectArea("SZ4")

	If lIGP
		cDataAnt := ""
		If nDiasAt2 > 0
			SZ4->(dbSetOrder(1))
			While nDiasAt2 > 0
				CAUX     := DaySub(DATABAIXA , nDiasAt2)
				DATAPROC := SubStr(DTOS(CAUX),1,6)
				If cDataAnt <> DATAPROC
					If SZ4->(dbSeek(cFilSZ4+DATAPROC))
						If SZ4->Z4_VALOR > 0
							AADD(aIgpm, (1+(SZ4->Z4_VALOR/100)))
						EndIf
					Else
						If DATAPROC <> SubStr(Dtos(DATABAIXA),1,6)
							aAdd(aErros, {Right(DATAPROC, 2) + "/" +Left(DATAPROC, 4)})
						EndIf
					EndIf	   
				EndIf
				nDiasAt2  := nDiasAt2 - 30
				cDataAnt  := DATAPROC
			EndDo

			If Len(aIgpm) > 0
				IGPM := aIgpm[1]
			EndIf

			If Len(aIgpm) > 1
				For nI := 2 To Len(aIgpm)
					IGPM *= aIgpm[nI]
				Next
			EndIf

			If Len(aIgpm) > 0
				IGPM -= 1
				IGPM *= 100
			EndIf
		EndIf
	EndIf

	// Só recebe multa caso esteja em atraso.
	If nDiasAt <= 0
		MULTA := 0
	EndIf

	TOTDEV := VALOR * (MULTA/100)	// Calculo da multa
	TOTDEV += VALOR * (IGPM/100)	// Calculo do Igpm

	If lErro .And. Len(aErros) > 0
		PlsCriGen(aErros, {{"Mes / Ano", "@!", 5}}, "Críticas IGPM", .T., "Não encontrado valor do IGPM para os meses listados acima.")
	EndIf

	RestArea(aArea)

Return TOTDEV


/*+-------------------------------------------------------------------------+
  |  Função........: UltimaCobr                                             |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Verifica ultima cobrança e calcula data da primeira    |
  |                : parcela a ser cobrada.                                 |
  +-------------------------------------------------------------------------+*/
//******************************
Static Function UltimaCobr(lMsg)
//******************************
	Local cQry	:= ""
	Local cAls2	:= GetNextAlias()

	Default lMsg := .F.

	cQry :=		" SELECT MAX(E1_ANOBASE||E1_MESBASE) MESANO"
	cQry += _LF+" FROM "+RetSqlName("SE1")+" SE1"
	cQry += _LF+" WHERE SE1.E1_FILIAL  = '" + cFilSE1 + "'"
	cQry += _LF+"   AND SE1.E1_CLIENTE = '" + cCliente      + "'"
	cQry += _LF+"   AND SE1.E1_LOJA    = '" + cLojaCli      + "'"
	cQry += _LF+"   AND SE1.D_E_L_E_T_ <> '*'"
	cQry += _LF+"   AND (SE1.E1_ORIGEM  = 'PLSA510' OR SE1.E1_PREFIXO = 'ANT')"
	cQry += _LF+"   AND (SELECT Count(SE5.R_E_C_N_O_) AS TOT FROM "+RetSqlName("SE5")+" SE5"
	cQry += _LF+"           WHERE SE5.D_E_L_E_T_ <> '*'"
	cQry += _LF+"           AND E5_FILIAL  = SE1.E1_FILIAL"
	cQry += _LF+"           AND E5_PREFIXO = E1_PREFIXO"
	cQry += _LF+"           AND E5_NUMERO  = E1_NUM"
	cQry += _LF+"           AND E5_PARCELA = E1_PARCELA"
	cQry += _LF+"           AND E5_MOTBX   = 'CAN'"
	cQry += _LF+"           )= 0"

	If Select(cAls2) <> 0; (cAls2)->(dbCloseArea()); Endif
	dbUseArea(.T., "TopConn", TcGenQry(,,cQry), cAls2, .T., .T.)

	If (cAls2)->(!Eof()) .And. !Empty((cAls2)->MESANO)
		If lMsg
			ApMsgAlert("ATENÇÃO : Última cobrança gerada em " + Right((cAls2)->MESANO, 2) + "/" + Left((cAls2)->MESANO, 4) + ".")
		EndIf
		cUltCob := (cAls2)->MESANO
	Endif

	(cAls2)->(dbCloseArea())

Return


/*+-------------------------------------------------------------------------+
  |  Função........: CalcParcelas                                           |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Calculo das parcelas.                                  |
  +-------------------------------------------------------------------------+*/
//****************************
Static Function CalcParcelas()
//****************************

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	If !Empty(cCndPag)

		nVlPre := Round(nVlPre, 2)

		If AllTrim(cUltCob) >= SubStr(DtoS(dDtNeg),1,6)
			dParcela := Lastday(Ctod('01'+'/'+Right(cUltCob,2)+'/'+SubStr(cUltCob,1,4)))+1
		Else//If AllTrim((cAls2)->MESANO) < (SubStr(DtoS(dDataBase),1,4)+SubStr(DtoS(dDataBase),5,2))
			dParcela := dDtNeg
		EndIf

		aParcelas := Condicao(nVlPre, cCndPag,, dParcela)

		If cJuros == "Sim"
			nVlParc := Round(nVlPre *(((nTxJur/100)*((1+(nTxJur/100))^Len(aParcelas))) / (((1+(nTxJur/100))^Len(aParcelas))-1)),2)
		Else
			nVlParc := Round(nVlPre / Len(aParcelas),2)
		EndIf

		cParc			:= "1"
		nVlNeg			:= 0
		If ValType(oGetPar) == "O"; oGetPar:aCols := {}; EndIf
		For x := 1 To Len(aParcelas)
			If ValType(oGetPar) == "O"
				// adquirir dinamicamente a posição dos campos para o preenchimento.
  				aAdd(oGetPar:aCols, {"", "", cParc, "PR", nVlParc, aParcelas[x][1], .F.})
  			EndIf
  			If cParc == "Z"
  				cParc := "1"
  			Else
	  			cParc := Soma1(cParc, 1)
  			EndIf
  			
//			aParcelas[x][2] := nVlParc

			nVlNeg += nVlParc
		Next
		If ValType(oGetPar) == "O"
			oGetVlNeg:Refresh()
			oGetPar:Refresh()
		EndIf

	EndIf
Return


/*+-------------------------------------------------------------------------+
  |  Função........: fNextNeg                                               |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Verifica se a negociação já existe.                    |
  +-------------------------------------------------------------------------+*/
//************************
Static Function fNextNeg()
//************************
	aAreaSZG := SZG->(GetArea())
	dbSelectArea("SZG")
	SZG->(dbSetOrder(1))
	While SZG->(dbSeek(cFilSZG+cNeg))
		cNeg := Soma1(cNeg)
	EndDo
	RestArea(aAreaSZG)
Return


/*+-------------------------------------------------------------------------+
  |  Função........: cb011Imp                                               |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Impressão da proposta.                                 |
  +-------------------------------------------------------------------------+*/
//**********************
User Function cb011Imp()
//**********************
	Local aArea		:= GetArea()
	Local cTitulo	:= "Proposta de Parcelamento"

	Private oGetPar		:= ""
	Private cUltCob		:= ""
	Private aParcelas	:= {}
	Private cCliente	:= SZG->ZG_CLIENTE
	Private cLojaCli	:= SZG->ZG_LOJA
	Private dDtNeg		:= SZG->ZG_DTNEG
	Private cCndPag		:= SZG->ZG_CONDPAG
	Private nTxJur		:= SZG->ZG_TXJUROS
	Private cJuros		:= If(SZG->ZG_JUROS=="S", "Sim", "Não")
	Private nVlPre		:= SZG->ZG_VLPRESE

	Private nVlParc		:= 0
	Private nVlNeg		:= 0

	// Condições de pagamento que serão listadas no relatório.
	Private aCondPag := {"903", "904", "905", "906", "907", "908", "909", "910", "912", "915", "918", "924", "936"}

	If SZG->ZG_STATUS == 'C'
		ApMSgStop("Não é possível imprimir proposta de uma negociação concluída.")
		Return .T.
	EndIf

	If !LoadParc()
		Return .F.
	EndIf

	oReport	:= TReport():New("CABANEG", cTitulo, /*cPerg*/, {|oReport| PrintReport(oReport)}, cTitulo)

	oReport:PrintDialog()

	RestArea(aArea)

Return


/*+-------------------------------------------------------------------------+
  |  Função........: PrintReport                                            |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Função auxiliar para impressão da proposta.            |
  +-------------------------------------------------------------------------+*/
//**********************************
Static Function PrintReport(oReport)
//**********************************

Local a := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local oFnt12	:= TFont():New("Arial"		,,12,,.F.,,,,,.F.,.F.)
	Local oFnt12c	:= TFont():New("Courier New",,12,,.F.,,,,,.F.,.F.)
	Local oFnt12N	:= TFont():New("Arial"		,,12,,.T.,,,,,.F.,.F.)
	Local oFnt12cN	:= TFont():New("Courier New",,12,,.T.,,,,,.F.,.F.)
	Local oFnt14N	:= TFont():New("Arial"		,,14,,.T.,,,,,.F.,.F.)
	Local oFnt32N	:= TFont():New("Courier New",,22,,.T.,,,,,.F.,.F.)

	Local nTop		:= 100
	Local nTopInt	:= nTop
	Local nLeft		:= 80

	oReport:HideHeader()
	oReport:HideFooter()

	oReport:SayBitmap(nTop, nLeft, "lgrl01.bmp", 400, 123)

    cMsg := "PROPOSTA DE PARCELAMENTO N° " + SZG->ZG_CODIGO
	oReport:Say(nTop + 25, nLeft + 550, cMsg, oFnt32N)

	nTop += 210
    cMsg := "De: Setor de Cobrança"
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)
	
	nTop += _BL
    cMsg := "Para: DIFIN"
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)
	
	nTop += 120
    cMsg := "Cliente: " + SZG->ZG_CLIENTE + "/" + SZG->ZG_LOJA + " - " + SZG->ZG_NOME
	oReport:Say(nTop, nLeft, cMsg, oFnt12)

	nTop += _BL
    cMsg := "Plano: " + SZG->ZG_PLANO
	oReport:Say(nTop, nLeft, cMsg, oFnt12)

	nTop += 120
    cMsg := "Perfil"
	oReport:Say(nTop, nLeft, cMsg, oFnt14N)

	// Perfil
	nTop	+= _BL
	nTopAux	:= nTop
	nRight	:= nLeft + 1000

	oReport:Line(nTopAux, nLeft, nTopAux, nRight)

	nTop += 10
    cMsg := "Tempo no Plano (Anos)"
	oReport:Say(nTop, nLeft + 10, cMsg, oFnt12N)
    cMsg := StrZero(SZG->ZG_TEMPOPL, 2)
	oReport:Say(nTop, nLeft + 550, cMsg, oFnt12)

	nTop += _BL
	oReport:Line(nTop, nLeft, nTop, nRight)

	nTop += 10
    cMsg := "Qtde. Dependentes"
	oReport:Say(nTop, nLeft + 10, cMsg, oFnt12N)
    cMsg := StrZero(SZG->ZG_DEPENDE, 2)
	oReport:Say(nTop, nLeft + 550, cMsg, oFnt12)

	nTop += _BL
	oReport:Line(nTop, nLeft, nTop, nRight)

	nTop += 10
    cMsg := "Faixa Etária (Anos)"
	oReport:Say(nTop, nLeft + 10, cMsg, oFnt12N)
    cMsg := AllTrim(Str(SZG->ZG_IDADE))
	oReport:Say(nTop, nLeft + 550, cMsg, oFnt12)

	nTop += _BL
	oReport:Line(nTop, nLeft, nTop, nRight)

	nTop += 10
    cMsg := "Sinistralidade"
	oReport:Say(nTop, nLeft + 10, cMsg, oFnt12N)
    cMsg := AllTrim(Transform(SZG->ZG_SINISTR, "@E 999.99")) + "%"
	oReport:Say(nTop, nLeft + 550, cMsg, oFnt12)

	nBotton := nTop + _BL
	oReport:Line(nTopAux, nLeft, nBotton, nLeft)
	oReport:Line(nTopAux, nRight, nBotton, nRight)
	oReport:Line(nBotton, nLeft, nBotton, nRight)

	nCol := nLeft + 500
	oReport:Line(nTopAux, nCol, nBotton, nCol)

	// Débitos em aberto
	nTop += 120
    cMsg := "Débitos em Aberto"
	oReport:Say(nTop, nLeft, cMsg, oFnt14N)

	nTop	+= _BL
	nTopAux := nTop
	nCol0	:= nLeft
	nCol1	:= nCol0 + 220	// Mes/Ano
	nCol2	:= nCol1 + 280	// Vencimento
	nCol3	:= nCol2 + 400	// Numero
	nCol4	:= nCol3 + 400	// Valor Nominal
	nCol5	:= nCol4 + 400	// Multa/IGPM	
	nRight	:= nCol5 + 400	// Valor Presente

	nTot1	:= 0
	nTot2	:= 0
	nTot3	:= 0

	oReport:Line(nTopAux, nLeft, nTopAux, nRight)

	// Cabeçalho
	nTop += 10	
    cMsg := "Mês/Ano"
	oReport:Say(nTop, nCol0 + 20, cMsg, oFnt12N)

    cMsg := "Vencimento"
	oReport:Say(nTop, nCol1 + 20, cMsg, oFnt12N)

    cMsg := "Número"
	oReport:Say(nTop, nCol2 + 50, cMsg, oFnt12N)

    cMsg := "Valor Nominal"
	oReport:Say(nTop, nCol3 + 15, cMsg, oFnt12N)

    cMsg := "Multa/ATUAL."
	oReport:Say(nTop, nCol4 + 20, cMsg, oFnt12N)

    cMsg := "Valor Presente"
	oReport:Say(nTop, nCol5 + 15, cMsg, oFnt12N)

	nTop += _BL
	oReport:Line(nTop, nLeft, nTop, nRight)
	
	// Conteúdo
	dbSelectArea("SZH")
	SZH->(dbSetOrder(1))
	If SZH->(dbSeek(cFilSZH + SZG->ZG_CODIGO + "E"))
		While !SZH->(Eof()) .And. SZH->(ZH_FILIAL+ZH_CODIGO+ZH_NEGTIPO) == cFilSZH+SZG->ZG_CODIGO+"E"
			nTop += 10

		    cMsg := SZH->ZH_MESBASE + "/" + SZH->ZH_ANOBASE
			oReport:Say(nTop, nCol0 + 15, cMsg, oFnt12c)

		    cMsg := Dtoc(SZH->ZH_VENCREA)
			oReport:Say(nTop, nCol1 + 15, cMsg, oFnt12c)

		    cMsg := SZH->ZH_PREFIXO + "-" + SZH->ZH_NUM + " " + SZH->ZH_PARCELA + " " + SZH->ZH_TIPO
			oReport:Say(nTop, nCol2 + 15, cMsg, oFnt12c)

		    cMsg := Transform(SZH->ZH_VLORI, "@E 999,999,999.99")
			oReport:Say(nTop, nCol3 + 15, cMsg, oFnt12c)
			nTot1 += SZH->ZH_VLORI

		    cMsg := Transform(SZH->ZH_VLPRESE, "@E 999,999,999.99")
			oReport:Say(nTop, nCol4 + 15, cMsg, oFnt12c)
			nTot2 += SZH->ZH_VLPRESE

		    cMsg := Transform(SZH->ZH_VALOR, "@E 999,999,999.99")
			oReport:Say(nTop, nCol5 + 15, cMsg, oFnt12c)
			nTot3 += SZH->ZH_VALOR

			nTop += _BL
			oReport:Line(nTop, nLeft, nTop, nRight)

			SZH->(dbSkip())

			If nTop > oReport:PageHeight() - 100
				// Grade
				nBotton := nTop //+ _BL
				oReport:Line(nTopAux, nLeft, nBotton, nLeft)
				oReport:Line(nTopAux, nRight, nBotton, nRight)
				oReport:Line(nBotton, nLeft, nBotton, nRight)

				oReport:Line(nTopAux, nCol1, nBotton, nCol1)
				oReport:Line(nTopAux, nCol2, nBotton, nCol2)
				oReport:Line(nTopAux, nCol3, nBotton, nCol3)
				oReport:Line(nTopAux, nCol4, nBotton, nCol4)
				oReport:Line(nTopAux, nCol5, nBotton, nCol5)

				oReport:EndPage()
				nTop	:= nTopInt

				oReport:SayBitmap(nTop, nLeft, "lgrl01.bmp", 400, 123)

			    cMsg := "PROPOSTA DE PARCELAMENTO N° " + SZG->ZG_CODIGO
				oReport:Say(nTop + 25, nLeft + 550, cMsg, oFnt32N)

				nTop	+= 210

			    cMsg := "Débitos em Aberto - Continuação"
				oReport:Say(nTop, nLeft, cMsg, oFnt14N)

				nTop	+= _BL
				nTopAux := nTop

				// Cabeçalho
				oReport:Line(nTopAux, nLeft, nTopAux, nRight)

				nTop += 10	
			    cMsg := "Mês/Ano"
				oReport:Say(nTop, nCol0 + 20, cMsg, oFnt12N)

			    cMsg := "Vencimento"
				oReport:Say(nTop, nCol1 + 20, cMsg, oFnt12N)

			    cMsg := "Número"
				oReport:Say(nTop, nCol2 + 50, cMsg, oFnt12N)

			    cMsg := "Valor Nominal"
				oReport:Say(nTop, nCol3 + 15, cMsg, oFnt12N)

			    cMsg := "Multa/IGPM"
				oReport:Say(nTop, nCol4 + 20, cMsg, oFnt12N)

			    cMsg := "Valor Presente"
				oReport:Say(nTop, nCol5 + 15, cMsg, oFnt12N)

				nTop += _BL
				oReport:Line(nTop, nLeft, nTop, nRight)

			EndIf

    	EndDo
	EndIf

	// Rodapé
	nTop += 10

    cMsg := "Totais"
	oReport:Say(nTop, nCol2 + 50, cMsg, oFnt12N)

    cMsg := Transform(nTot1, "@E 999,999,999.99")
	oReport:Say(nTop, nCol3 + 15, cMsg, oFnt12c)

    cMsg := Transform(nTot2, "@E 999,999,999.99")
	oReport:Say(nTop, nCol4 + 15, cMsg, oFnt12c)

    cMsg := Transform(nTot3, "@E 999,999,999.99")
	oReport:Say(nTop, nCol5 + 15, cMsg, oFnt12c)

	// Grade
	nBotton := nTop + _BL
	oReport:Line(nTopAux, nLeft, nBotton, nLeft)
	oReport:Line(nTopAux, nRight, nBotton, nRight)
	oReport:Line(nBotton, nLeft, nBotton, nRight)

	oReport:Line(nTopAux, nCol1, nBotton, nCol1)
	oReport:Line(nTopAux, nCol2, nBotton, nCol2)
	oReport:Line(nTopAux, nCol3, nBotton, nCol3)
	oReport:Line(nTopAux, nCol4, nBotton, nCol4)
	oReport:Line(nTopAux, nCol5, nBotton, nCol5)

	// Simulação de Parcelamento
	nTop += 120

	If nTop > oReport:PageHeight() - 1350
		oReport:EndPage()
		nTop	:= nTopInt

		oReport:SayBitmap(nTop, nLeft, "lgrl01.bmp", 400, 123)

	    cMsg := "PROPOSTA DE PARCELAMENTO N° " + SZG->ZG_CODIGO
		oReport:Say(nTop + 25, nLeft + 550, cMsg, oFnt32N)

		nTop	+= 210
	EndIf
	
    cMsg := "Simulação de Parcelamento"
	oReport:Say(nTop, nLeft, cMsg, oFnt14N)

	nTop	+= _BL
	nTopAux := nTop
	nCol0	:= nLeft
	nCol1	:= nCol0 + 320	// Qtd. Parcelas
	nCol2	:= nCol1 + 400	// Valor Parcela
	nRight	:= nCol2 + 400	// Total

	oReport:Line(nTopAux, nLeft, nTopAux, nRight)

	// Cabeçalho
	nTop += 10	
    cMsg := "Qtd. Parcelas"
	oReport:Say(nTop, nCol0 + 20, cMsg, oFnt12N)

    cMsg := "Valor Parcela"
	oReport:Say(nTop, nCol1 + 40, cMsg, oFnt12N)

    cMsg := "Total"
	oReport:Say(nTop, nCol2 + 250, cMsg, oFnt12N)

	nTop += _BL
	oReport:Line(nTop, nLeft, nTop, nRight)
	
	// Conteúdo
	For a := 1 To Len(aCondPag)
		cCndPag	:= aCondPag[a]

		CalcParcelas()

	    cMsg := StrZero(Len(aParcelas), 2)
		oReport:Say(nTop, nCol0 + 100, cMsg, oFnt12c)

		cMsg := Transform(nVlParc, "@E 999,999,999.99")
		oReport:Say(nTop, nCol1 + 15, cMsg, oFnt12c)

		cMsg := Transform(nVlParc * Len(aParcelas), "@E 999,999,999.99")
		oReport:Say(nTop, nCol2 + 15, cMsg, oFnt12c)

		nTop += _BL
		oReport:Line(nTop, nLeft, nTop, nRight)
	Next

	nBotton := nTop
	oReport:Line(nTopAux, nLeft, nBotton, nLeft)
	oReport:Line(nTopAux, nRight, nBotton, nRight)
	oReport:Line(nBotton, nLeft, nBotton, nRight)

	oReport:Line(nTopAux, nCol1, nBotton, nCol1)
	oReport:Line(nTopAux, nCol2, nBotton, nCol2)

	// Ancorado no final da página
	cCndPag	:= SZG->ZG_CONDPAG
	CalcParcelas()

	nTop := oReport:PageHeight()

	nTop -= 115
	cMsg := "Emissão " + Dtoc(dDataBase) + " " + Time()
	oReport:Say(nTop, nLeft, cMsg, oFnt12)

	nTop -= 110
	cMsg := "Assinatura: ________________________________________________"
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)

	nTop -= 80
	cMsg := "(  ) Reprovada"
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)

	nTop -= 80
	cMsg := "Proposta Aprovada: __________ Vezes"
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)

	nTop -= 80
	cMsg := "Proposta do Assistido:     " + StrZero(Len(aParcelas), 2)
	cMsg += " Vezes de " + AllTrim(Transform(nVlParc, "@E 999,999,999.99"))
	cMsg += "          Total: " + Transform(nVlParc * Len(aParcelas), "@E 999,999,999.99")
	oReport:Say(nTop, nLeft, cMsg, oFnt12N)

	If SZG->ZG_STATUS == "A"
		RecLock("SZG", .F.)
		SZG->ZG_STATUS := "P"
		SZG->(MsUnlock())
    EndIf

Return


/*+-------------------------------------------------------------------------+
  |  Função........: cb011WordImp                                           |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Termo de confissão de dívida (Word).                   |
  +-------------------------------------------------------------------------+*/
//**************************
User Function cb011WordImp()
//**************************
	Local cDataExt	:= StrZero(Day(dDataBase), 2) + " de " + MesExtenso(dDataBase) + " de " + StrZero(Year(dDataBase), 4)

	Private oGetPar		:= ""
	Private cUltCob		:= ""
	Private aParcelas	:= {}
	Private cCliente	:= SZG->ZG_CLIENTE
	Private cLojaCli	:= SZG->ZG_LOJA
	Private dDtNeg		:= SZG->ZG_DTNEG
	Private cCndPag		:= SZG->ZG_CONDPAG
	Private nTxJur		:= SZG->ZG_TXJUROS
	Private cJuros		:= If(SZG->ZG_JUROS=="S", "Sim", "Não")
	Private nVlPre		:= SZG->ZG_VLPRESE

	Private nVlParc		:= 0
	Private nVlNeg		:= 0
    






	If !LoadParc()
		Return .F.
	EndIf

	Do Case
		Case SZG->ZG_STATUS == "A"
			ApMsgStop("A negociação encontra-se ABERTA. Deve-se imprimir a proposta.")
			Return .F.

		Case SZG->ZG_STATUS == "C"
			ApMSgStop("Não é possível imprimir proposta de uma negociação concluída.")
			Return .F.

		Otherwise
			If !ApMsgYesNo("A negociação já foi autorizada?")
				Return .F.
			EndIf
	EndCase

	cNome		:= SZG->ZG_NOME
	cIdent		:= Posicione("SA1", 1, cFilSA1+SZG->ZG_CLIENTE+SZG->ZG_LOJA, "A1_PFISICA")
	cIdent		:= If(Empty(cIdent), "<EM BRANCO>", cIdent)
	cMod11		:= Modulo11(SZG->ZG_CODINT + SZG->ZG_CODEMP + SZG->ZG_MATRIC + SZG->ZG_TIPREG)
	cMatPlan	:= SZG->ZG_CODINT + "." + SZG->ZG_CODEMP + "." + SZG->ZG_MATRIC + "-" + SZG->ZG_TIPREG + "." + cMod11
	cMatPlan	+= " - Plano: " + SubStr(SZG->ZG_PLANO, 8)
                                                                 
   
     
//aki altamiro  
 cParc1  := cParc2  := cParc3  := cParc4  := cParc5  := cParc6  := cParc7  := cParc8  := cParc9  := cParc10 := "" 
 cParc11 := cParc12 := cParc13 := cParc14 := cParc15 := cParc16 := cParc17 := cParc18 := cParc19 := cParc20 := ""
 cParc21 := cParc22 := cParc23 := cParc24:= ""

    
  	cSQL := " SELECT ZH_PREFIXO ,ZH_NUM ,ZH_PARCELA ,ZH_TIPO ,ZH_VENCREA, ZH_VALOR"
	cSQL += " FROM " + RetSQLName("SZH") + " SZH " 
	cSQL += " WHERE ZH_FILIAL = '" + xFilial("SZH") + "' "

	cSQL += " AND ZH_CODIGO = '" + SZG->ZG_CODIGO + "' "
	cSQL += " AND ZH_NEGTIPO  = 'E' "
	
	cSQL += " AND D_E_L_E_T_ = ' ' "
	cSQL += " ORDER BY ZH_VENCREA "
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa query                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     

      cSQL := ChangeQuery(cSQL)
      If Select("Tmp") <> 0 
         Tmp->(DbCloseArea()) 
      Endif
      DbUseArea(.T.,"TopConn",TcGenQry(,,cSQL),'Tmp',.F.,.T.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa arquivo de trabalho                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lLock := .F.                  
		cPicta	:= "@R 999,999.99"                                               
	i :=1
	While !Tmp->(eof()) 
       Do Case
	      Case	i = 1
                cParc1   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 2
                cParc2   := tmp->( ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+"  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 3
                cParc3   := tmp->( ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+"  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 4
                cParc4   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 5
                cParc5   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 6
                cParc6   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 7
                cParc7   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 8
                cParc8   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 9
                cParc9   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 10
                cParc10   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 11
                cParc11   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 12
                cParc12   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta))) 
          Case	i = 13
                cParc13   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 14
                cParc14   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 15
                cParc15   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))       
          Case	i = 16
                cParc16   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 17
                cParc17   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 18
                cParc18   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 19
                cParc19   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))
          Case	i = 20
                cParc20   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))                       
          Case	i = 21
                cParc21   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))                       
          Case	i = 22
                cParc22   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))                      
          Case	i = 23
                cParc23   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))                      
          Case	i = 24
                cParc24   := tmp->(ZH_PREFIXO+" " +ZH_NUM+ " "+ ZH_PARCELA+" " + ZH_TIPO+" " + substr (ZH_VENCREA,7,2)+"/"+ substr (ZH_VENCREA,5,2)+"/"+ substr (ZH_VENCREA,1,4)+ "  R$ " + AllTrim(Transform( ZH_VALOR, cPicta)))                                       	
       EndCase
       i++
       TMP->(DbSkip())         
    EndDo                                                                                                                                    
    
//fim                    

	BA0->(dbSetOrder(1))
	BA0->(dbSeek(cFilBA0+PlsIntPad()))
	cNomeOper	:= BA0->BA0_NOMINT
	cCnpj		:= BA0->BA0_CGC
	cAns		:= BA0->BA0_SUSEP

	cDataIni	:= SubStr(Dtos(aParcelas[1][1]), 5, 2) + "/" + Left(Dtos(aParcelas[1][1]), 4)
	cDataFim	:= ""
	If Len(aParcelas) > 1
		cDataFim	:= " e a última em " + SubStr(Dtos(aParcelas[Len(aParcelas)][1]), 5, 2)
		cDataFim	+= "/" + Left(Dtos(aParcelas[Len(aParcelas)][1]), 4)
	EndIf

	cArquivo := GetNewPar("MV_YATNEG","M:\Protheus_Data\IntegracaoProtheusOffice\CABERJ_31.dot")   
//	cArquivo := ("M:\Protheus_Data\IntegracaoProtheusOffice\CABERJ_31.dot")
 
	If !File(cArquivo)
		cMsg := "Arquivo " + cArquivo + " não encontrado." + _LF
		cMsg += "Verifique o parametro MV_YATNEG."
		ApMsgStop(cMsg)
	EndIf

	// Inicializa objeto do word.
	oWord := Ole_CreateLink('TMsOleWord97')

	Ole_NewFile(oWord, cArquivo)
//	Ole_SetProperty( oWord, oleWdVisible  , .T. )
//	Ole_SetProperty( oWord, oleWdPrintBack, .T. )

	cPict	:= "@R 999,999,999.99"

	// Variaveis que serão substituidas  
	
	Ole_SetDocumentVar(oWord,"c_Parc1"  , iif(empty(cParc1) , " " , cParc1  ))
	
	Ole_SetDocumentVar(oWord,"c_Parc2"  , iif(empty(cParc2), " " ,"-   " + cParc2  ))
    
	Ole_SetDocumentVar(oWord,"c_Parc3"  , iif(empty(cParc3), " " ,  cParc3  ))
	
    Ole_SetDocumentVar(oWord,"c_Parc4"  , iif(empty(cParc4), " " ,"-   " +  cParc4  ))
    
	Ole_SetDocumentVar(oWord,"c_Parc5"  , iif(empty(cParc5), " " ,  cParc5  ))
    
    Ole_SetDocumentVar(oWord,"c_Parc6"  , iif(empty(cParc6), " " ,"-   " +  cParc6   )) 

	Ole_SetDocumentVar(oWord,"c_Parc7"  , iif(empty(cParc7), " " ,  cParc7   ))

	Ole_SetDocumentVar(oWord,"c_Parc8"  , iif(empty(cParc8), " " ,"-   " +  cParc8   ))

	Ole_SetDocumentVar(oWord,"c_Parc9"  , iif(empty(cParc9), " " ,  cParc9   ))

	Ole_SetDocumentVar(oWord,"c_Parc10"  , iif(empty(cParc10), " " ,"-   " +  cParc10 ))

	Ole_SetDocumentVar(oWord,"c_Parc11"  , iif(empty(cParc11), " " , cParc11  ))

	Ole_SetDocumentVar(oWord,"c_Parc12"  , iif(empty(cParc12), " " ,"-   " + cParc12  ))

    Ole_SetDocumentVar(oWord,"c_Parc13"  , iif(empty(cParc13), " " , cParc13  ))

	Ole_SetDocumentVar(oWord,"c_Parc14"  , iif(empty(cParc14), " " ,"-   " + cParc14  ))

	Ole_SetDocumentVar(oWord,"c_Parc15"  , iif(empty(cParc15), " " , cParc15  ))

	Ole_SetDocumentVar(oWord,"c_Parc16"  , iif(empty(cParc16), " " ,"-   " + cParc16  ))

	Ole_SetDocumentVar(oWord,"c_Parc17"  , iif(empty(cParc17), " " , cParc17  ))

	Ole_SetDocumentVar(oWord,"c_Parc18"  , iif(empty(cParc18), " " ,"-   " + cParc18  ))

    Ole_SetDocumentVar(oWord,"c_Parc19"  , iif(empty(cParc19), " " , cParc19  ))

	Ole_SetDocumentVar(oWord,"c_Parc20"  , iif(empty(cParc20), " " ,"-   " + cParc20  ))

	Ole_SetDocumentVar(oWord,"c_Parc21"  , iif(empty(cParc21), " " , cParc21  )) 

    Ole_SetDocumentVar(oWord,"c_Parc22"  , iif(empty(cParc22), " " ,"-   " + cParc22  ))

	Ole_SetDocumentVar(oWord,"c_Parc23"  , iif(empty(cParc23), " " , cParc23  ))

	Ole_SetDocumentVar(oWord,"c_Parc24"  , iif(empty(cParc24), " " ,"-   " + cParc24  ))
	
	
	
	
	Ole_SetDocumentVar(oWord,"c_Nome"    , cNome    )
	Ole_SetDocumentVar(oWord,"c_Ident"   , cIdent   )
	Ole_SetDocumentVar(oWord,"c_MatPlan" , cMatPlan )

	Ole_SetDocumentVar(oWord,"c_Oper"    , cNomeOper)
	Ole_SetDocumentVar(oWord,"c_Cnpj"    , cCnpj    )
	Ole_SetDocumentVar(oWord,"c_Ans"     , cAns     )

	Ole_SetDocumentVar(oWord,"n_ValTot"  , AllTrim(Transform(nVlNeg, cPict))  + " (" + Extenso(nVlNeg        ,.F.,1) + ")")
	Ole_SetDocumentVar(oWord,"n_QtdParc" , AllTrim(Str(Len(aParcelas)))       + " (" + Extenso(Len(aParcelas),.T.,1) + ")")
	Ole_SetDocumentVar(oWord,"n_ValParc" , AllTrim(Transform(nVlParc, cPict)) + " (" + Extenso(nVlParc       ,.F.,1) + ")")
	Ole_SetDocumentVar(oWord,"d_DataIni" , cDataIni )
	Ole_SetDocumentVar(oWord,"d_DataFim" , cDataFim )
	Ole_SetDocumentVar(oWord,"d_DataExt" , cDataExt )
	Ole_SetDocumentVar(oWord,"c_Multa"   , Str(GetNewPar("MV_XMULTA",2),2) + "%" + " (" + Extenso(GetNewPar("MV_XMULTA",2),.T.,1) + " por cento) ")
	Ole_SetDocumentVar(oWord,"c_Juros"   , Str(nTxJur, 2) + "%" + " (" + Extenso(nTxJur,.T.,1) + " por cento) ")

	//Atualiza Variaveis
	Ole_UpDateFields(oWord)

	ApMsgInfo("Documento do Word Aberto.")

	Ole_CloseFile(oWord)
	Ole_CloseLink(oWord)

	If SZG->ZG_STATUS == "P"
		RecLock("SZG", .F.)
		SZG->ZG_STATUS := "T"
		SZG->(MsUnlock())
	EndIf

Return


/*+-------------------------------------------------------------------------+
  |  Função........: LoadParc                                               |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Carrega variáveis a para cálculo de parcelas.          |
  +-------------------------------------------------------------------------+*/
//************************
Static Function LoadParc()
//************************
	UltimaCobr(.F.)

	CalcParcelas()

	If nVlNeg <> SZG->ZG_VALOR
		ApMsgStop("Inconsistência na negociação " + AllTrim(SZG->ZG_CODIGO) + "." )
		Return .F.
	EndIf

Return .T.


/*+-------------------------------------------------------------------------+
  |  Função........: cb011Confirma                                          |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Confirmação da negociação.                             |
  +-------------------------------------------------------------------------+*/
//***************************
User Function cb011Confirma()
//***************************
	Local aArea := GetArea()

	If !ApMsgYesNo("Deseja confirmar a negociação?")
		Return .F.
	EndIf

	Do Case
		Case SZG->ZG_STATUS == "A"
			ApMsgAlert("A proposta não foi impressa.")

		Case SZG->ZG_STATUS == "P"
			ApMsgAlert("O termo não foi impresso.")

		Case SZG->ZG_STATUS == "T"
			Private lReturn := .F.
			Processa({||lReturn := fConfirma()})

			If lReturn
				ApMsgInfo("Operação Concluída.")
			Else
				ApMsgStop("Operação Cancelada.")
			EndIf

		Case SZG->ZG_STATUS == "C"
			ApMsgAlert("A negociação já foi confirmada.")

	EndCase

	RestArea(aArea)

Return .T.


/*+-------------------------------------------------------------------------+
  |  Função........: fConfirma                                              |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Confirmação da negociação.                             |
  +-------------------------------------------------------------------------+*/
//*************************
Static Function fConfirma()
//*************************

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local aArea			:= GetArea()
	Local lHead			:= .F.
	Local cArquivo		:= ""
	Local nHdlPrv		:= 0
	Local nRegE1		:= 0
	Local cHistoric		:= "FAT DE NEG " + Dtoc(SZG->ZG_DTNEG)
	Local cTipReg		:= "00"
	Local cCodInt
	Local cCodEmp
	Local cMatric
	Local cConEmp
	Local cVerCon
	Local cSubCon
	Local cVerSub
	Local cDigito
	Local cCobNiv
	**'Inicio - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 
	Local oError := ErrorBlock({|e| u_ErroFun1("Mensagem de Erro: " +chr(10)+ e:Description)})    
	**'Fim - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 

	Private oGetPar		:= ""
	Private cUltCob		:= ""
	Private aParcelas	:= {}
	Private cNeg		:= SZG->ZG_CODIGO
	Private cCliente	:= SZG->ZG_CLIENTE
	Private cLojaCli	:= SZG->ZG_LOJA
	Private cTipoCli	:= Posicione("SA1", 1, cFilSA1+cCliente+cLojaCli, "A1_TIPO")
	Private dDtNeg		:= SZG->ZG_DTNEG
	Private cCndPag		:= SZG->ZG_CONDPAG
	Private nTxJur		:= SZG->ZG_TXJUROS
	Private cJuros		:= If(SZG->ZG_JUROS=="S", "Sim", "Não")
	Private nVlPre		:= SZG->ZG_VLPRESE

	Private nVlParc		:= 0
	Private nVlNeg		:= 0

	// Dados da Fatura
	Private cAlias	:= "SE1"
	Private cPrefix	:= "PLS"
	Private cFatura := Soma1(GetMV("MV_NUMFAT"), TamSx3("E1_NUM")[1])
	Private cTipo	:= "FT"
	Private cNat	:= "30"
	Private cPadrao	:= "595"
	Private cLote

	
	// Quantidades de processos.
	ProcRegua(3)

	// Pergunta de configuração da rotina de fatura.
	Pergunte("AFI280",.F.)

	// Carrega parcelas.	
	If !LoadParc()                                                    
		Return .F.
	EndIf

	// Verifica se as datas das parcelas são inferiores a data base do sistema.
	If aParcelas[1][1] < dDataBase
		ApMsgAlert("Data do vencimento da primeira parcela inferior a data base do sistema.")
		Return .F.
	EndIf

	// Variáveis para funções do FINA280.
	nTotal	:= nVlNeg

	// Verifica se o número da fatura já foi utilizado.
  	dbSelectArea("SE1")
	SE1->(dbSetOrder(1))
	While SE1->(dbSeek(cFilSE1+cPrefix+cFatura+" "+cTipo))
		cFatura := Soma1(cFatura, TamSx3("E1_NUM")[1])
		SE1->( dbSkip() )
	EndDo  

	// Percorrer os itens de SZH
	dbSelectArea("SE1")
	SE1->(dbSetOrder(1))

	IncProc("Marcando títulos ...")

	dbSelectArea("SZH")
	SZH->(dbSetOrder(1))
	cChave := cFilSZH+cNeg+"E"
	SZH->(dbSeek(cChave))  
	
	
	**'Inicio - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 
	Begin Transaction
	Begin Sequence
	
	**'Fim - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 

	While !SZH->(Eof()) .And. SZH->(ZH_FILIAL+ZH_CODIGO+ZH_NEGTIPO) == cChave

		// Posiciona SE1
		If !SE1->(dbSeek(cFilSE1+SZH->(ZH_PREFIXO+ZH_NUM+ZH_PARCELA+ZH_TIPO)))
			ApMsgStop("Título " + ZH_PREFIXO+"-"+ZH_NUM+"-"+ZH_PARCELA+"-"+ZH_TIPO+" não encontrado em SE1.")
			
			**'Marcela Coimbra    Data: 24/06/2010'**
			
			SZH->(dbSkip())
			Loop
			
			//Return .F. 
			
			**'Fim Marcela Coimbra    Data: 24/06/2010'**
			
		EndIf      

		// Adquire informações do usuário para criação dos títulos provisórios.
		cCodInt := SE1->E1_CODINT
		cCodEmp := SE1->E1_CODEMP
		cMatric := SE1->E1_MATRIC

		// Verifica se o titulo possui BSQ.
		// Caso exista registro em BSQ, excluir.
		aDadosBSQ := {}
		aAdd(aDadosBSQ, {"BSQ_PREORI", SZH->ZH_PREFIXO	, Nil})
		aAdd(aDadosBSQ, {"BSQ_NUMORI", SZH->ZH_NUM		, Nil})
		aAdd(aDadosBSQ, {"BSQ_PARORI", SZH->ZH_PARCELA	, Nil})
		aAdd(aDadosBSQ, {"BSQ_TIPORI", SZH->ZH_TIPO		, Nil})

		fGeraBSQ(aDadosBSQ, 5) // Excluir

		// Marca registros para montagem da fatura. // FINA280
		FA280MonFa("SE1", cFilSE1, SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->(Recno()), cFatura, cPrefix, cTipo)
		SE1->(MsUnlock()) // Destrava registro marcado.
		SZH->(dbSkip())
	EndDo

	// Adquire o nível de cobrança.
//	SZH->(dbSkip(-1))
//	cCobNiv := Posicione("BBT", 7, cFilBBT + SZH->(ZH_PREFIXO+ZH_NUM+ZH_PARCELA+ZH_TIPO), "BBT_NIVEL")

	// Adquire dados de BA1 para criação dos títulos PR.
	dbSelectArea("BA1")
	aAreaBA1 := BA1->(GetArea())
	BA1->(dbSetOrder(2))
	If BA1->(dbSeek(cFilBA1+cCodInt+cCodEmp+cMatric+cTipReg))
		cConEmp := BA1->BA1_CONEMP
		cVerCon := BA1->BA1_VERCON
		cSubCon := BA1->BA1_SUBCON
		cVerSub := BA1->BA1_VERSUB
		cDigito	:= BA1->BA1_DIGITO
	EndIf	
	RestArea(aAreaBA1)

	// Cria fatura em SE1
	IncProc("Gerando Fatura ...")

	FA280GrFat(;
		cCliente,				;	// Codigo do Cliente para Geracao da Fatura
		cLojaCli,				;	// Codigo da Loja do Cliente para Geracao da Fatura
		cCliente,				;	// Codigo do Cliente
		cLojaCli,				;	// Loja do Cliente
		cFatura,				;	// Numero da Fatura
		cPrefix,				;	// Prefixo da Fatura
		" ",					;	// Parcela da Fatura
		cTipo,					;	// Tipo da Fatura
		dDtNeg,					;	// Data de Vencimento da Parcela da Fatura
		cNat,					;   // Natureza da Fatura
		CriaVar("E1_PORTADO"),	;	// Banco da Fatura
		nVlNeg,   				;	// Valor da Duplicata
		0,						;	// ValCruz
		0,						;	// ValrURV
		1,						;	// Moeda da Fatura
		nRegE1,					;	// Registro do SE1
		cPadrao,				;	// Codigo do lancamento Padronizado
		@nTotal,  				;	// Valor Total da Fatura
		@lHead,					;	// @lHead
		@cArquivo,				;	// @cArquivo
		@nHdlPrv)					// @nHdlPrv

	// Preenche demais dados da fatura.
	If SE1->(dbSeek(cFilSE1+cPrefix+cFatura+" "+cTipo))
		SE1->(Reclock("SE1",.F.))
		SE1->E1_HIST	:= cHistoric
		SE1->E1_XNUMNEG	:= cNeg
		SE1->E1_CODINT	:= cCodInt
		SE1->E1_CODEMP	:= cCodEmp
		SE1->E1_MATRIC	:= cMatric
		SE1->E1_CONEMP	:= cConEmp
		SE1->E1_VERCON	:= cVerCon
		SE1->E1_SUBCON	:= cSubCon
		SE1->E1_VERSUB	:= cVerSub
		SE1->(MsUnlock())
	EndIf

	// Baixar Fatura
	cHist := "NEGOCIACAO EM: " + Dtoc(dDtNeg)
	aDadSE1 := {}
	aAdd(aDadSE1, {"E1_PREFIXO"		, cPrefix				, Nil })
	aAdd(aDadSE1, {"E1_NUM"			, cFatura				, Nil })
	aAdd(aDadSE1, {"E1_PARCELA"		, " "		 			, Nil })
	aAdd(aDadSE1, {"E1_TIPO"		, cTipo		 			, Nil })
	aAdd(aDadSE1, {"E1_CLIENTE"		, cCliente	  			, Nil })
	aAdd(aDadSE1, {"E1_LOJA"		, cLojaCli	   			, Nil })
	aAdd(aDadSE1, {"AUTMOTBX"		, cTpBaixa				, Nil }) // Mudar para NEG
	aAdd(aDadSE1, {"AUTBANCO"		, CriaVar("A6_COD")		, Nil })
	aAdd(aDadSE1, {"AUTAGENCIA"		, CriaVar("A6_AGENCIA")	, Nil })
	aAdd(aDadSE1, {"AUTCONTA"		, CriaVar("A6_NUMCON")	, Nil })
	aAdd(aDadSE1, {"AUTDTBAIXA"		, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTDTCREDITO"	, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTHIST"		, cHistoric				, Nil })
	aAdd(aDadSE1, {"E1_HIST"		, cHist					, Nil })
	aAdd(aDadSE1, {"AUTVALREC"		, nVlNeg				, Nil })
			
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		Return .F.
	Endif

	// Criação das parcelas.
	IncProc("Criando Parcelas ...")
	cParcela := "0"
	cHistor := "PARCELAMENTO EM " + Dtoc(dDtNeg)
	For x := 1 To Len(aParcelas)

		If cParcela == "Z"
			cParcela := "1"
			cFatura := Soma1(cFatura, 6)
		Else
			cParcela := Soma1(cParcela, 1)
		EndIf
//		cParcela	:= Soma1(cParcela, 1)

		dVencto		:= aParcelas[x][1]
		nValor		:= nVlParc //aParcelas[x][2]
		cAnoBase	:= SubStr(Dtos(dVencto), 1, 4)
		cMesBase	:= SubStr(Dtos(dVencto), 5, 2)
		nPorcJur	:= If(SZG->ZG_JUROS == "S", nTxJur, 0)
		nCalcJur	:= nValor * nPorcJur / 100

	    // Criação de títulos provisórios.
		aDadosTit := {}
		aAdd(aDadosTit, {"E1_PREFIXO"	, cPrefix	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, cFatura	, Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, cParcela	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, "PR"	  	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, cNat	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, cCliente	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, cLojaCli	, Nil})
		aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	, Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, dVencto  	, Nil})
		aAdd(aDadosTit, {"E1_VALOR"		, nValor  	, Nil})
		aAdd(aDadosTit, {"E1_PORCJUR"	, nPorcJur 	, Nil})
		aAdd(aDadosTit, {"E1_JUROS"		, nCalcJur 	, Nil})
		aAdd(aDadosTit, {"E1_HIST"		, cHistor	, Nil}) 
		aAdd(aDadosTit, {"E1_CODINT"	, cCodInt	, Nil})
		aAdd(aDadosTit, {"E1_CODEMP"	, cCodEmp	, Nil})
		aAdd(aDadosTit, {"E1_MATRIC"	, cMatric	, Nil})
		aAdd(aDadosTit, {"E1_CONEMP"	, cConEmp	, Nil})
		aAdd(aDadosTit, {"E1_VERCON"	, cVerCon	, Nil})
		aAdd(aDadosTit, {"E1_SUBCON"	, cSubCon	, Nil})
		aAdd(aDadosTit, {"E1_VERSUB"	, cVerSub	, Nil})
		aAdd(aDadosTit, {"E1_XNUMNEG"	, cNeg	  	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, cAnoBase	, Nil})
		aAdd(aDadosTit, {"E1_MESBASE"	, cMesBase	, Nil})

		MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,3)

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		EndIf

	    // Criação de informações de saída na tabela SZH.
		RecLock("SZH", .T.)
		SZH->ZH_FILIAL	:= cFilSZH
		SZH->ZH_CODIGO	:= cNeg
		SZH->ZH_NEGTIPO := "S"
		SZH->ZH_PREFIXO	:= cPrefix
		SZH->ZH_NUM		:= cFatura
		SZH->ZH_PARCELA	:= cParcela
		SZH->ZH_TIPO	:= "PR"
		SZH->ZH_VENCREA	:= dVencto
		SZH->ZH_ANOBASE	:= cAnoBase
		SZH->ZH_MESBASE	:= cMesBase
		SZH->ZH_VLORI	:= 0
		SZH->ZH_VLPRESE	:= 0
		SZH->ZH_VALOR	:= nValor
		SZH->(MsUnlock())

		// Criar BSQ
		cCodSeq		:= PLSA625Cd("BSQ_CODSEQ", "BSQ", 1, "D_E_L_E_T_", " ")
		cUsuari		:= cCodInt + cCodEmp + cMatric + cTipReg + cDigito
		cNivel		:= If(AllTrim(cMatric) <> "", "5", "4")
		cObs		:= "PARCLTO: PARCELA " + StrZero(x, 2) + " DE " + StrZero(Len(aParcelas), 2)
		cCodLan		:= SuperGetMv("MV_XXNEGDE",,"991")
		aDadosBSQ	:= {}
		
		aAdd(aDadosBSQ, {"BSQ_CODSEQ"	, cCodSeq	, Nil})
		aAdd(aDadosBSQ, {"BSQ_CODINT"	, cCodInt	, Nil})
		aAdd(aDadosBSQ, {"BSQ_CODEMP"	, cCodEmp	, Nil})
		aAdd(aDadosBSQ, {"BSQ_MATRIC"	, cMatric	, Nil})
		aAdd(aDadosBSQ, {"BSQ_CONEMP"	, cConEmp	, Nil})
		aAdd(aDadosBSQ, {"BSQ_VERCON"	, cVerCon	, Nil})
		aAdd(aDadosBSQ, {"BSQ_SUBCON"	, cSubCon	, Nil})
		aAdd(aDadosBSQ, {"BSQ_VERSUB"	, cVerSub	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ANO"		, cAnoBase	, Nil})
		aAdd(aDadosBSQ, {"BSQ_MES"		, cMesBase	, Nil})
		aAdd(aDadosBSQ, {"BSQ_CODLAN"	, cCodLan	, Nil})
		aAdd(aDadosBSQ, {"BSQ_TIPO"		, "1"		, Nil})
		aAdd(aDadosBSQ, {"BSQ_VALOR"	, nValor	, Nil})
		aAdd(aDadosBSQ, {"BSQ_PREORI"	, cPrefix	, Nil})
		aAdd(aDadosBSQ, {"BSQ_NUMORI"	, cFatura	, Nil})
		aAdd(aDadosBSQ, {"BSQ_PARORI"	, cParcela	, Nil})
		aAdd(aDadosBSQ, {"BSQ_TIPORI"	, "PR"		, Nil})
		aAdd(aDadosBSQ, {"BSQ_TIPEMP"	, cTipoCli	, Nil})
		aAdd(aDadosBSQ, {"BSQ_AUTOMA"	, "1"		, Nil})
//		aAdd(aDadosBSQ, {"BSQ_COBINV"	, cCobNiv	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZNATUR"	, cNat		, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZCLIEN"	, cCliente	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZLOJA"	, cLojaCli	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZEMISS"	, dDataBase	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZEMIS1"	, dDataBase	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZHIST"	, cHistor	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZVENCT"	, dVencto	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZVENRE"	, dVencto	, Nil})
		aAdd(aDadosBSQ, {"BSQ_ZJUROS"	, nPorcJur	, Nil})
		aAdd(aDadosBSQ, {"BSQ_NPARCE"	, "1"		, Nil})
		aAdd(aDadosBSQ, {"BSQ_COBNIV"	, cNivel	, Nil})
		aAdd(aDadosBSQ, {"BSQ_USUARI"	, cUsuari	, Nil})
		aAdd(aDadosBSQ, {"BSQ_OBS"		, cObs		, Nil})

		fGeraBSQ(aDadosBSQ, 3) // Incluir

	Next

	// Altera dados dos titulos baixados.
	dbSelectArea("SZH")
	SZH->(dbSetOrder(1))
	cChave := cFilSZH+cNeg+"E"
	SZH->(dbSeek(cChave))
	While !SZH->(Eof()) .And. SZH->(ZH_FILIAL+ZH_CODIGO+ZH_NEGTIPO) == cChave
		// Preenche o campo E1_XNUMNEG com o número da negociação.
		RecLock("SE1", .F.)
		SE1->E1_XNUMNEG := cNeg
		SE1->E1_YTPEDSC := "NEGOCIACAO FATURA"

		// Preencher acréscimo com o valor presente menos o valor original.
		If SZG->ZG_IGPM == "S"
			SE1->E1_ACRESC := SZH->ZH_VLPRESE - SZH->ZH_VLORI
		EndIf

		// Informar taxa de juros e valor.
		If SZG->ZG_JUROS == "S"
			SE1->E1_PORCJUR	:= nTxJur
			SE1->E1_JUROS	:= SE1->E1_VALOR * nTxJur / 100
		EndIf

		SE1->(MsUnlock())
		SZH->(dbSkip())
	EndDo	
	// Grava o numero da ultima fatura gerada.
	PutMv("MV_NUMFAT", cFatura)

	// Marca a negociação como confirmada.
	RecLock("SZG", .F.)
	SZG->ZG_STATUS := "C"
	SZG->(MsUnlock())

	RestArea(aArea)

	Pergunte(cPerg, .F.)                 
	
	**'Inicio - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 
	End Sequence
	
	ErrorBlock(oError)
	
	End Transaction
	**'Fin - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 
	

Return .T.


/*+-------------------------------------------------------------------------+
  |  Função........: cb011Cancel                                            |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Cancelamento da negociação.                            |
  +-------------------------------------------------------------------------+*/
//*************************
User Function cb011Cancel()
//*************************
	Local aArea		:= GetArea()

	Private lMsErroAuto	:= .F.
	Private lRetVar		:= .T.

	If SZG->ZG_STATUS != "C"
		fCancelaZG(SZG->(RecNo()))
	Else

		// Verifica se existem registros em BSQ que já foram faturados.
		dbSelectArea("SZH")
		SZH->(dbSetOrder(1))
		dbSelectArea("BSQ")
		BSQ->(dbSetOrder(5))

		cChave := cFilSZH+SZG->ZG_CODIGO+"S"
		If SZH->(dbSeek(cChave))
			While SZH->(ZH_FILIAL+ZH_CODIGO+ZH_NEGTIPO) == cChave
				If BSQ->(dbSeek(cFilBSQ+SZH->(ZH_PREFIXO+ZH_NUM+ZH_PARCELA+ZH_TIPO)))
					If !Empty(BSQ_NUMCOB+BSQ_PREFIX+BSQ_NUMTIT+BSQ_PARCEL+BSQ_TIPTIT)
						cMsg := 	"A parcela referente a " + SZH->ZH_MESBASE + "/" + SZH->ZH_ANOBASE + " já foi faturada."
						cMsg += _LF+"A negociação nao podera ser cancelada."
						ApMsgStop(cMsg)
						Return .F.
					EndIf
				Else
					cMsg := 	"Titulo "+SZH->ZH_PREFIXO+" - "+SZH->ZH_NUM+" "+SZH->ZH_PARCELA+" "+SZH->ZH_TIPO+" não foi encontrado em BSQ."
					cMsg += _LF+"A negociação nao podera ser cancelada."
					ApMsgStop(cMsg)
					Return .F.
				EndIf
				SZH->(dbSkip())
			EndDo
		Else
			ApMsgStop("Titulos gerados pela negociação não foram encontrados.")
			Return .F.
		EndIf

		// Estorna baixa da fatura.
		If !SZH->(dbSeek(cChave))
			ApMsgStop("Titulo da fatura não encontrado para cancelamento de baixa.")
			Return .F.
		EndIf

		nBaixa	:= 1
		aBaixa	:= {}
		aAdd(aBaixa, {"E1_PREFIXO"	, SZH->ZH_PREFIXO	, Nil})
		aAdd(aBaixa, {"E1_NUM"		, SZH->ZH_NUM   	, Nil})
		aAdd(aBaixa, {"E1_PARCELA"	, " "				, Nil})
		aAdd(aBaixa, {"E1_TIPO"		, "FT"				, Nil})
		aAdd(aBaixa, {"AUTMOTBX"	, cTpBaixa		    , Nil})
		aAdd(aBaixa, {"AUTDTBAIXA"	, dDataBase		    , Nil})
		aAdd(aBaixa, {"AUTDTCREDITO", dDataBase		    , Nil})

		MSExecAuto({|x,y,z,w| fina070(x,y,z,w)},aBaixa,5,.F.,nBaixa) //Estorno

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		EndIf


		// Cancela fatura.
		dbSelectArea("SE1")
		SE1->(dbSetOrder(1))
		If SE1->(dbSeek(cFilSE1+SZH->ZH_PREFIXO+SZH->ZH_NUM+" FT"))
			Fa280Can("SE1", "", 6)
			//Tratamento do erro da rotina Fa280Can : Verifica se fatura ainda existe para saber a escolha do usuário.
			If SE1->(dbSeek(cFilSE1+SZH->ZH_PREFIXO+SZH->ZH_NUM+" FT"))

				// Deverá baixar novamente a fatura.
				cHistoric	:= "FAT DE NEG " + Dtoc(SZG->ZG_DTNEG)
				aDadSE1		:= {}

				aAdd(aDadSE1, {"E1_PREFIXO"		, SE1->E1_PREFIXO		, Nil })
				aAdd(aDadSE1, {"E1_NUM"			, SE1->E1_NUM			, Nil })
				aAdd(aDadSE1, {"E1_PARCELA"		, SE1->E1_PARCELA		, Nil })
				aAdd(aDadSE1, {"E1_TIPO"		, SE1->E1_TIPO	 		, Nil })
				aAdd(aDadSE1, {"E1_CLIENTE"		, SE1->E1_CLIENTE		, Nil })
				aAdd(aDadSE1, {"E1_LOJA"		, SE1->E1_LOJA	   		, Nil })
				aAdd(aDadSE1, {"AUTMOTBX"		, cTpBaixa				, Nil })
				aAdd(aDadSE1, {"AUTBANCO"		, CriaVar("A6_COD")		, Nil })
				aAdd(aDadSE1, {"AUTAGENCIA"		, CriaVar("A6_AGENCIA")	, Nil })
				aAdd(aDadSE1, {"AUTCONTA"		, CriaVar("A6_NUMCON")	, Nil })
				aAdd(aDadSE1, {"AUTDTBAIXA"		, dDataBase				, Nil })
				aAdd(aDadSE1, {"AUTDTCREDITO"	, dDataBase				, Nil })
				aAdd(aDadSE1, {"AUTHIST"		, cHistoric				, Nil })
				aAdd(aDadSE1, {"E1_HIST"		, SE1->E1_HIST			, Nil })
				aAdd(aDadSE1, {"AUTVALREC"		, SE1->E1_VALOR			, Nil })
			
				lMsErroAuto := .F.
				MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
				If lMsErroAuto
					DisarmTransaction()
					MostraErro()
					Return .F.
				Endif
				ApMsgInfo("Processo cancelado pelo usuario.")
				Return .F.
			EndIf
		Else
			ApMsgStop("Titulo da fatura não encontrado para cancelamento.")
        	Return .F.
		EndIf

		// Movimento de crédito do BSQ.
		Processa({||lRetVar := fCancelaBSQ()})

		// Exclusão da negociação.
		Processa({||lRetVar := fCancelaZG(SZG->(RecNo()))})
	EndIf

	If lRetVar
		ApMSgInfo("Operação Concluída.")
	EndIf

	RestArea(aArea)
Return .T.

             
/*+-------------------------------------------------------------------------+
  |  Função........: fCancelaBSQ                                            |
  |  Data..........: 06.08.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Cancelamento de BQS e titulos provisorios.             |
  +-------------------------------------------------------------------------+*/
//***************************
Static Function fCancelaBSQ()
//***************************
		// Cancelar BSQ e titulos provisorios.
		dbSelectArea("SE1")
		SE1->(dbSetOrder(1))
		dbSelectArea("SZH")
		SZH->(dbSetOrder(1))
		SZH->(dbGoTop())
		cChave := cFilSZH + SZG->ZG_CODIGO + "S"
		If SZH->(dbSeek(cChave))
			While SZH->(ZH_FILIAL+ZH_CODIGO+ZH_NEGTIPO) == cChave
				// Cancelar registros de BSQ
				aDadosBSQ := {}
				aAdd(aDadosBSQ, {"BSQ_PREORI", SZH->ZH_PREFIXO	, Nil})
				aAdd(aDadosBSQ, {"BSQ_NUMORI", SZH->ZH_NUM		, Nil})
				aAdd(aDadosBSQ, {"BSQ_PARORI", SZH->ZH_PARCELA	, Nil})
				aAdd(aDadosBSQ, {"BSQ_TIPORI", SZH->ZH_TIPO		, Nil})

				fGeraBSQ(aDadosBSQ, 5) // Gerar crédito

				// Remover títulos provisórios.
				aDadosTit := {}
				aAdd(aDadosTit, {"E1_PREFIXO"	, SZH->ZH_PREFIXO	, Nil})
				aAdd(aDadosTit, {"E1_NUM"		, SZH->ZH_NUM		, Nil})
				aAdd(aDadosTit, {"E1_PARCELA"	, SZH->ZH_PARCELA	, Nil})
				aAdd(aDadosTit, {"E1_TIPO"		, SZH->ZH_TIPO	  	, Nil})

				MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,5)

				If lMsErroAuto
					DisarmTransaction()
					MostraErro()
					Return .F.
				EndIf

				SZH->(dbSkip())
			EndDo
		EndIf

Return .T.


/*+-------------------------------------------------------------------------+
  |  Função........: fCancelaZG                                             |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Exclusão de SZG e SZH.                                 |
  +-------------------------------------------------------------------------+*/
//*********************************
Static Function fCancelaZG(nRecSZG)
//*********************************

	SZG->(dbGoTo(nRecSZG))
	cCod := SZG->ZG_CODIGO

	dbSelectArea("SZH")
	SZH->(dbSetOrder(1))
	If SZH->(dbSeek(cFilSZH+cCod))
		While !SZH->(Eof()) .And. SZH->(ZH_FILIAL+ZH_CODIGO) == cFilSZH+cCod
			RecLock("SZH", .F.)
			SZH->(dbDelete())
			SZH->(MsUnlock())
			SZH->(dbSkip())
		EndDo
	Else
		Return .F.
	EndIf

	RecLock("SZG", .F.)
	SZG->(dbDelete())
	SZG->(MsUnlock())

Return .T.


/*+-------------------------------------------------------------------------+
  |  Função........: fGeraBSQ                                               |
  |  Data..........: 13.06.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Função para gravar / excluir registros da tabela BSQ.  |
  +-------------------------------------------------------------------------+*/
//*************************************
Static Function fGeraBSQ(aDados, nBord)
//*************************************
	Local iT	:= 1
	Local lRet	:= .T.

	// Inclusão
	If nBord == 3
		aAreaBSQ := BSQ->(GetArea())
		BSQ->(RecLock("BSQ",.T.))
		For iT := 1 To Len(aDados)
			BSQ->(FieldPut(FieldPos(aDados[iT,1]),aDados[iT,2]))
		Next
		BSQ->(MsUnlock())
		RestArea(aAreaBSQ)

	// Exclusão Débito
	ElseIf nBord == 5
		lRet := fPesqBSQ(aDados, nBord, "1")

	// Criação de título de crédito
	ElseIf nBord == 9
		lRet := fPesqBSQ(aDados, nBord, "1")

	EndIf

Return lRet



//********************************************
Static Function fPesqBSQ(aDados, nBord, cTipo)
//********************************************
	Local lRet		:= .F.
	Local cPesq		:= cFilBSQ
	Local aAreaBSQ	:= BSQ->(GetArea())

	cPesq	+= aDados[aScan(aDados, {|x| x[1] == "BSQ_PREORI"}), 2]
	cPesq	+= aDados[aScan(aDados, {|x| x[1] == "BSQ_NUMORI"}), 2]
	cPesq	+= aDados[aScan(aDados, {|x| x[1] == "BSQ_PARORI"}), 2]
	cPesq	+= aDados[aScan(aDados, {|x| x[1] == "BSQ_TIPORI"}), 2]
		
	dbSelectArea("BSQ")
	BSQ->(dbSetOrder(5)) //BSQ_FILIAL + BSQ_PREORI + BSQ_NUMORI + BSQ_PARORI + BSQ_TIPORI + BSQ_SEQ
//	BSQ->(dbGoTop())
	If BSQ->(dbSeek(cPesq))
		lRet := .T.

// Correção temporária.
		While !BSQ->(Eof()) .And. AllTrim(BSQ->(BSQ_FILIAL+BSQ_PREORI+BSQ_NUMORI+BSQ_PARORI+BSQ_TIPORI)) == AllTrim(cPesq)
//		While !BSQ->(Eof()) .And. BSQ->(BSQ_FILIAL+BSQ_PREORI+BSQ_NUMORI+BSQ_PARORI+BSQ_TIPORI) == cPesq
			If BSQ->BSQ_TIPO == cTipo
				If nBord == 5 // Excluir
					lRet := fApagaBSQ(aDados, nBord, cTipo)
				ElseIf nBord == 9 // Clonar
					lRet := fClonaBSQ(aDados, nBord, cTipo)
				EndIf
			EndIf
			BSQ->(dbSkip())
		EndDo
//	Else
//		lRet := .F.
	EndIf

	RestArea(aAreaBSQ)

Return lRet



//*********************************************
Static Function fApagaBSQ(aDados, nBord, cTipo)
//*********************************************
	Local lRet := .T.

	// Verificar se não foi faturado.	

	BSQ->(RecLock("BSQ",.F.))
	BSQ->(dbDelete())
	BSQ->(MsUnlock())
Return lRet



//*********************************************
Static Function fClonaBSQ(aDados, nBord, cTipo)
//*********************************************
	Local aClone	:= {}
	Local aAreaSX3	:= SX3->(GetArea())
	Local aAreaBSQ	:= BSQ->(GetArea())
	Local lRet		:= .F.

	RegToMemory("BSQ", .F., .F.)

	// Percorre todos os campos de BSQ e cria um vetor para clonagem.
	dbSelectArea("SX3")
	SX3->(dbSetOrder(1))
	SX3->(dbSeek("BSQ"))
	While !SX3->(Eof()) .And. SX3->X3_ARQUIVO = "BSQ"

		cCampo := AllTrim(SX3->X3_CAMPO)

		If (X3Uso(SX3->X3_USADO) .And. /*cNivel >= SX3->X3_NIVEL .And.*/ SX3->X3_CONTEXT != "V") ;
				.Or. cCampo == "BSQ_COBNIV"

			If cCampo == "BSQ_CODSEQ"
				xDado	:= PLSA625Cd("BSQ_CODSEQ", "BSQ", 1, "D_E_L_E_T_", " ")
			ElseIf cCampo == "BSQ_CODLAN"
				xDado	:= SuperGetMv("MV_XXNEGCR",,"990")
			ElseIf cCampo == "BSQ_TIPO"
				xDado	:= "2"
			Else
				xDado	:= &("BSQ->" + SX3->X3_CAMPO)
			EndIf

			aAdd(aClone, {cCampo, xDado, Nil})

		EndIf

		SX3->(dbSkip())
	
	EndDo

	If Len(aClone) > 0
		lRet := fGeraBSQ(aClone, 3) // Incluir
	EndIf

	RestArea(aAreaBSQ)
	RestArea(aAreaSX3)

Return lRet




/*+-------------------------------------------------------------------------+
  |  Função........: Implode                                                |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Função auxiliar para unir itens de um array em uma     |
  |                : string com delimitadores.                              |
  +-------------------------------------------------------------------------+*/
//*****************************************
Static Function Implode(aArray, cSeparator)
//*****************************************
	Local cString	:= ""
	Local a			:= 0	
	Local n			:= Len(aArray)

	For a := 1 To n - 1
		cString += aArray[a] + cSeparator
	Next
	
	cString += aArray[n]
	
Return cString


/*+-------------------------------------------------------------------------+
  |  Função........: fCriaSx1                                               |
  |  Data..........: 07.05.2009                                             |
  |  Analista......: Eduardo de Moraes Folly                                |
  |  Descrição.....: Função auxiliar para criar perguntas em SX1.           |
  +-------------------------------------------------------------------------+*/
//****************************************
Static Function fCriaSx1(cPerg,aSx1,lExcl)
//****************************************
	Local nLin,nCol,cCampo
	lExcl := If( lExcl==Nil , .F. , lExcl )

	SX1->(dbSetOrder(1))

	If !lExcl.And.SX1->(dbSeek(cPerg+aSx1[Len(aSx1),2]))
		Return
	EndIf

	SX1->(dbSeek(cPerg))
	While !SX1->(Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(RecLock("SX1",.F.,.F.))
		SX1->(dbDelete())
		SX1->(MsUnLock())
		SX1->(dbSkip())
	EndDo
	For nLin := 2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For nCol := 1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,nCol]
			SX1->(FieldPut(SX1->(FieldPos(cCampo)),aSx1[nLin,nCol] ))
		Next nCol
		SX1->(MsUnLock())
	Next nLin
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BusRecDes   ºAutor  ³ Jean Schulz      º Data ³  30/07/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca receita e despesa de determinado beneficiário, em     º±±
±±º          ³determinada competência.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ cChave : chave de pesquisa.                                º±±
±±º          ³ cAno: ano de avaliacao.   a                                º±±
±±º          ³ cNivel: 4-familia / 5-usuario                              º±±
±±ºRetorno   ³ 13 posicoes (12 meses + 1 acumulado no ano).               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RetVlStl(cChave,cAno,cNivel)
	Local _aRet			:= {}
	Local _aArea		:= GetArea()
	Local _aAreaBX9		:= BX9->(GetArea())
	Local _nVlrCus		:= 0
	Local _nVlrRec		:= 0
	Local nVlCalcSnt	:= 0.00

	dbSelectArea("BX9")
	BX9->(dbSetOrder(6)) //BX9_FILIAL + BX9_TIPO + BX9_ANO + BX9_CODOPE + BX9_CODEMP + BX9_MATRIC + BX9_TIPREG
	If BX9->(dbSeek(xFilial("BX9")+cNivel+cAno+cChave))
		_nVlrRec := BX9->BX9_VRRACU
		_nVlrCus := BX9->BX9_VRCACU
	Endif

	If _nVlrRec <> 0
		nVlCalcSnt := Round((_nVlrCus/If(_nVlrRec<1, 1, _nVlrRec))*100,2) 
	EndIf
 
	RestArea(_aAreaBX9)
	RestArea(_aArea)

Return nVlCalcSnt

**'Inicio - Marcela Coimbra - 28/06/2010'  **
**'Rotina para tratamento de erro'** 
User Function ErroFun1(cMsg)

DisarmTransaction()   
                        
Alert(cMsg)    
__Quit()

Return      

**'Fim - Marcela Coimbra - 28/06/2010'  **
**'Rotina para tratamento de erro'** 