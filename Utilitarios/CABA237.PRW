#Include "Protheus.ch"
#Include "Totvs.ch"
#Include "FWMBROWSE.CH"

// Variavel utilizada para definir o estilo da tela criada pelo objeto MSDialog - Não exibe o botão de "X" para fechar a tela
#define DS_MODALFRAME   128

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA237  º Autor ³ Frederico O. C. Jr º Data ³  09/11/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Log de envio de e-mail					                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA237()

Local oBrowse

Private aRotina		:= MenuDef()
Private cCadastro	:= "Controle de Envio de E-mail"

oBrowse	:= BrowseDef()

return


//-------------------------------------------------------------------
// Browse definition
//-------------------------------------------------------------------
Static Function BrowseDef()

Local oBrowse as object

oBrowse	:= FwMBrowse():New()

oBrowse:SetAlias('ZA2')
oBrowse:SetDescription(cCadastro)
oBrowse:SetCacheView(.F.)			// Desabilita Cache da View, pois gera colunas dinamicamente
oBrowse:Activate()

return oBrowse


//-------------------------------------------------------------------
// Definição do MenuDef
//-------------------------------------------------------------------
Static Function MenuDef()

Local aRotina	:= {}

ADD OPTION aRotina TITLE "Visualizar" ACTION 'U_CABA237A("ZA2",ZA2->(Recno()),2)' OPERATION 2 ACCESS 0

return aRotina


//-------------------------------------------------------------------
// Função de Controle e Manutenção dos registros do cadastro
//-------------------------------------------------------------------
User Function CABA237A(cAlias,nReg,nOpc)

Local oSize			:= FwDefSize():New(.T.)
Local oDlg
Local oScroll
Local oFont
Local bAll			:= {|| oDlg:End() }
Local aPosObj		:= {}
Local cReg			:= ""
//Local aField		:= {{"ZB7_CODIGO","ZB7_ROTINA","ZB7_EMAILD","ZB7_DATA","ZB7_HORA"}}
Local oSay
Local lHtml			:= .T.

Default nOpc		:= 2			// visualizar

oSize:AddObject( "ENCHOICE" , 100, 30, .T., .T. , .T. )		// enchoice
oSize:AddObject( "HEADER"   , 100, 70, .T., .T. , .T. )		// box com o corpo do e-mail

oSize:lProp		:= .T.				// Proporcional
oSize:lLateral	:= .F.
oSize:aMargins	:= { 3, 3, 3, 3 }	// Espaco ao lado dos objetos 0, entre eles 3
oSize:Process()						// Dispara os calculos

aAdd(aPosObj,{oSize:GetDimension('ENCHOICE','LININI'), oSize:GetDimension('ENCHOICE','COLINI'), oSize:GetDimension('ENCHOICE','LINEND'),     oSize:GetDimension('ENCHOICE','COLEND'),   oSize:GetDimension("ENCHOICE","XSIZE"), oSize:GetDimension("ENCHOICE","YSIZE")   })
aAdd(aPosObj,{oSize:GetDimension('HEADER'  ,'LININI'), oSize:GetDimension('HEADER'	,'COLINI'), oSize:GetDimension('HEADER'  ,'LINEND')-120, oSize:GetDimension('HEADER'  ,'COLEND')-3, oSize:GetDimension("HEADER"	 ,"XSIZE"), oSize:GetDimension("HEADER"  ,"YSIZE")-40})

DEFINE MSDIALOG oDlg TITLE cCadastro FROM oSize:aWindSize[1], oSize:aWindSize[2] TO oSize:aWindSize[3], oSize:aWindSize[4] Style DS_MODALFRAME OF oMainWnd pixel

	oDlg:lEscClose	:= .F.

	RegToMemory(cAlias, If(nOpc==3,.T.,.F.))
	ZA2->(MSMGET():New("ZA2",ZA2->(Recno()),nOpc,,,,,{aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},,,,,,oDlg,,,.F.,,,.T.,))

	//23 27 14 41 03 17

	cReg := ZA2->ZA2_CORPO

	// Cria fonte para ser usada no TSay
	oFont := TFont():New('Arial',,-14,.T.)

	// Cria objeto Scroll
	//oScroll := TScrollBox():New(oDlg,aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],.T.,.T.,.T.)

	// Cria o TSay permitindo texto no formato HMTL
	//oSay := TSay():New(03,03,{||alltrim(cReg)},oScroll,,oFont,,,,.T.,,,aPosObj[2,5],aPosObj[2,6],,,,,,lHtml)
	//oSay:lWordWrap = .F.

	oPanelGraf		:= TPanel():New( aPosObj[2,1], aPosObj[2,2], /*cText*/, oDlg, , /*lCentered*/, /*uParam7*/, /*nClrText*/, /*nClrBack*/, aPosObj[2,5], aPosObj[2,6]+40,.F.,.T. )

	oScroll			:= TScrollArea():New( oPanelGraf, 01, 01, aPosObj[2,5], aPosObj[2,6], .T., .T., .T. )
	oScroll:Align	:= CONTROL_ALIGN_ALLCLIENT

	// Cria painel
	oPanel := TPanel():New( 05, 05, /*cText*/, oScroll, , /*lCentered*/, /*uParam7*/, /*nClrText*/, /*nClrBack*/, 800, 800)

	// Define objeto painel como filho do scroll
	oScroll:SetFrame( oPanel )

	oSay := TSay():New(05,05,{||alltrim(cReg)},oPanel,,oFont,,,,.T.,,,800,800,,,,,,lHtml)
	oSay:lWordWrap = .F.

ACTIVATE MSDIALOG oDlg ON INIT Eval({ || EnChoiceBar(oDlg, bAll, bAll,.F.,{}) })

return


//-------------------------------------------------------------------
// Função de Controle e Manutenção dos registros do cadastro
//-------------------------------------------------------------------
User Function CABA237B(cPara, cCc, cBCC, cAssunto, cCorpo, aAnexos, cFrom, aControle, lStatus, cServSMTP, cError, cError2)

Local cCodigo	:= ""
Local nI		:= 1
Local cAnexos	:= ""
Local cUsuaLog	:= RetCodUsr()
Local cLogErro	:= ""

cCodigo	:= GetSX8Num("ZA2","ZA2_SEQUEN")
CONFIRMSX8()

//------------------------------------------//
// aControle:	1: Rotina					//
//				2: Protocolo				//
//				3: Matricula				//
//				4: Cod. RDA					//
//				5: Grupo/Empresa			//
//				6: Cod./Loja Fornecedor		//
//				7: Corretor					//
//------------------------------------------//

RecLock("ZA2",.T.)

	ZA2->ZA2_FILIAL	:= xFilial("ZA2")
	ZA2->ZA2_SEQUEN	:= cCodigo

	ZA1->(DbSetOrder(1))	// ZA1_FILIAL+ZA1_CODIGO
	if ZA1->(DbSeek( xFilial("ZA1") + aControle[1] )) .and. !empty(aControle[1])
		ZA2->ZA2_PROCES	:= aControle[1]
	endif

	ZA2->ZA2_DATENV	:= date()
	ZA2->ZA2_HORENV	:= StrTran(Time(),":","")
	ZA2->ZA2_STATUS	:= iif(lStatus, "1", "2")	// 1=Sucesso;2=Erro no envio
	ZA2->ZA2_REMETE	:= cFrom
	ZA2->ZA2_DESTIN	:= cPara
	ZA2->ZA2_COPIA	:= cCc
	ZA2->ZA2_COPIOC	:= cBCC
	ZA2->ZA2_ASSUNT	:= cAssunto
	ZA2->ZA2_CORPO	:= cCorpo
	if !empty(cUsuaLog)
		ZA2->ZA2_CODUSR	:= cUsuaLog
		ZA2->ZA2_NOMUSR	:= UsrFullName(cUsuaLog)
	else
		ZA2->ZA2_CODUSR	:= "WEB"
		ZA2->ZA2_NOMUSR	:= "Log Incluido via WebService"
	endif

	SZX->(DbSetOrder(1))	// ZX_FILIAL+ZX_SEQ
	if SZX->(DbSeek( xFilial("SZX") + aControle[2] )) .and. !empty(aControle[2])
		ZA2->ZA2_PROTOC	:= aControle[2]
	endif

	BA1->(DbSetOrder(2))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	if BA1->(DbSeek( xFilial("BA1") + aControle[3] )) .and. !empty(aControle[3])
		ZA2->ZA2_MATRIC	:= aControle[3]
		ZA2->ZA2_NOMBEN	:= BA1->BA1_NOMUSR
	endif

	BAU->(DbSetOrder(1))	// BAU_FILIAL+BAU_CODIGO
	if BAU->(DbSeek( xFilial("BAU") + aControle[4] )) .and. !empty(aControle[4])
		ZA2->ZA2_CODRDA	:= aControle[4]
		ZA2->ZA2_NOMRDA	:= BAU->BAU_NOME
	endif

	BG9->(DbSetOrder(1))	// BG9_FILIAL+BG9_CODINT+BG9_CODIGO+BG9_TIPO
	if BG9->(DbSeek( xFilial("BG9") + PlsIntPad() + aControle[5] )) .and. !empty(aControle[5])
		ZA2->ZA2_EMPRES	:= aControle[5]
		ZA2->ZA2_NOMEMP	:= BG9->BG9_DESCRI
	endif

	SA2->(DbSetOrder(1))	// A2_FILIAL+A2_COD+A2_LOJA
	if SA2->(DbSeek( xFilial("SA2") + aControle[6] )) .and. !empty(aControle[6])
		ZA2->ZA2_FORNEC	:= SubStr(aControle[6],1,6)
		ZA2->ZA2_LOJA	:= SubStr(aControle[6],7,2)
		ZA2->ZA2_NOMFOR	:= SA2->A2_NOME
	endif

	SA3->(DbSetOrder(1))	// A3_FILIAL+A3_COD
	if SA3->(DbSeek( xFilial("SA3") + aControle[7] )) .and. !empty(aControle[7])
		ZA2->ZA2_CORRET	:= aControle[7]
		ZA2->ZA2_NOMCOR	:= SA3->A3_NOME
	endif

	if FieldPos("ZA2_SERVER") > 0
		ZA2->ZA2_SERVER	:= cServSMTP
		ZA2->ZA2_ERRO	:= cError
		ZA2->ZA2_ERRO2	:= cError2
	else

		if !empty(cError)
			cLogErro := "SMTP 1: " + AllTrim(cError)
			if !empty(cError2)
				cLogErro += " | SMTP 2: " + AllTrim(cError2)
			else
				cLogErro += " | ENVIO COM SUCESSO NO SMTP 2"
			endif
			ZA2->ZA2_ERRO	:= cLogErro
		endif
		
	endif

	for nI := 1 to len(aAnexos)
		cAnexos	+= aAnexos[nI] + chr(13) + chr(10)
	next
	ZA2->ZA2_ANEXO	:= cAnexos

ZA2->(MsUnLock())

return
