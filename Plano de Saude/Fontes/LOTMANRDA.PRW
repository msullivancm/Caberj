#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ LotManRda ³ Autor ³Thiago Machado Correa ³ Data ³ 24.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Geracao do Lote de Manutencao de codigos/valores x Rda     ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ RR Sistema		                                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LotManRda()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina := {{ "Pesquisar"	, 'AxPesqui'							, 0 , K_Pesquisar	},;
					{ "Visualizar"	, 'U_LOTMAN("SZE", SZE->(Recno()), 2)'	, 0 , K_Visualizar	},;
					{ "Novo Lote"	, 'U_LOTMAN("SZE", SZE->(Recno()), 3)'	, 0 , K_Incluir		},;
					{ "Excluir Lote", 'U_LOTMAN("SZE", SZE->(Recno()), 5)'	, 0 , K_Excluir 	}}   

PRIVATE cCadastro 	:= "Manutenção de Códigos/Valores x Rda"
PRIVATE nLeg	 	:= 0     
PRIVATE aVetFim 	:= {}
PRIVATE lShowBrw    := .T.

PRIVATE cRdaIni := ""
PRIVATE cRdaFim := ""
PRIVATE cGrvIni := ""
PRIVATE cGrvFim := ""
PRIVATE cTabIni := ""
PRIVATE cProIni := ""
PRIVATE cTabFim := ""
PRIVATE cProFim := ""
PRIVATE nAcao   := 0
PRIVATE nValor  := 0
PRIVATE nAplVlr := 0
PRIVATE dProVig := StoD("")
PRIVATE nTipAut := 0
PRIVATE cAcoIni := ""
PRIVATE cAcoFim := ""
PRIVATE cPlaIni := ""
PRIVATE cPlaFim := ""
PRIVATE nRelPre := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Endereca a funcao de BROWSE                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SZE->(DbSetOrder(1))
SZE->(MsSeek(xFilial("SZE")))
SZE->(mBrowse(06,01,22,75,"SZE",,,,,,))

Return
              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LOTMAN   ³ Autor ³ Thiago Machado Correa ³ Data ³ 24.12.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Geracao do Lote de Manutencao				              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LOTMAN(cAlias,nReg,nOpt)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nOpca     := 0
LOCAL nTmp      := 0
LOCAL oEnchoice
LOCAL oDlg
LOCAL bOK       := {|| nOpca := 1,oDlg:End() }
LOCAL bCancel   := {|| nOpca := 0,oDlg:End() }
LOCAL aButtons  := {}  
LOCAL aCriGen   := {}    
LOCAL aRetGen   := {}
LOCAL cNomRot   := ""
LOCAL cTipMov   := ""
LOCAL cDesAut   := ""
PRIVATE cSequen := ""

PRIVATE lAbortPrint := .F.
PRIVATE oFolder
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Detalhes...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aCabSZF := {}
PRIVATE aDadSZF := {}
PRIVATE aVetSZF := {}
PRIVATE oBrwSZF 

If Len(aVetFim) > 0

	For nTmp := 1 to Len(aVetFim)

		Do Case
			Case aVetFim[nTmp][1] == "I"
				cTipMov := "Inclusão "
			Case aVetFim[nTmp][1] == "A"
				cTipMov := "Alteração"
			Case aVetFim[nTmp][1] == "E"
				cTipMov := "Exclusão "
			OtherWise
				cTipMov := "Nenhum registro selecionado!"
		EndCase

		Do Case
			Case aVetFim[nTmp][2] == "BC0"
				cNomRot := "Procedimentos Autorizados    "
				If aVetFim[nTmp][1] == "I"
					cDesAut := IIF(aVetFim[nTmp][4][12][2]=="1","Executa",IIF(aVetFim[nTmp][4][12][2]=="2","Solicita","Executa/Solicita"))
					Aadd(aCriGen,{	cNomRot,cTipMov,aVetFim[nTmp][4][2][2],aVetFim[nTmp][4][4][2],aVetFim[nTmp][4][5][2],aVetFim[nTmp][4][7][2],aVetFim[nTmp][4][8][2],aVetFim[nTmp][4][9][2],cDesAut})
				ElseIf aVetFim[nTmp][1] == "A"
					cDesAut := aVetFim[nTmp][4][15][1] + " := " + DtoC(aVetFim[nTmp][4][15][2])
					Aadd(aCriGen,{	cNomRot,cTipMov,aVetFim[nTmp][4][2][2],aVetFim[nTmp][4][4][2],aVetFim[nTmp][4][5][2],aVetFim[nTmp][4][7][2],aVetFim[nTmp][4][8][2],aVetFim[nTmp][4][9][2],cDesAut})
				Endif

			Case aVetFim[nTmp][2] == "BBN"
				cNomRot := "Procedimentos Não Autorizados"
				cDesAut := ""
				Aadd(aCriGen,{	cNomRot,cTipMov,aVetFim[nTmp][4][2][2],aVetFim[nTmp][4][4][2],aVetFim[nTmp][4][5][2],"",aVetFim[nTmp][4][7][2],aVetFim[nTmp][4][8][2],cDesAut})

			Case aVetFim[nTmp][2] == "BC6"
				cNomRot := "Tabela de Preços x Rda       "
				If aVetFim[nTmp][1] == "I"
					cDesAut := IIF(nAplVlr==1,"% Reajuste",IIF(nAplVlr==2,"Valor Reajuste","Vlr Inc Reajuste")) + " = " + Transform(nValor,"@E 99,999,999.99")
					Aadd(aCriGen,{	cNomRot,cTipMov,aVetFim[nTmp][4][3][2],"","",aVetFim[nTmp][4][4][2],aVetFim[nTmp][4][5][2],aVetFim[nTmp][4][6][2],cDesAut})
				ElseIf aVetFim[nTmp][1] == "A"
					cDesAut := aVetFim[nTmp][4][29][1] + " := " + DtoC(aVetFim[nTmp][4][29][2])
					Aadd(aCriGen,{	cNomRot,cTipMov,aVetFim[nTmp][4][3][2],"","",aVetFim[nTmp][4][4][2],aVetFim[nTmp][4][5][2],aVetFim[nTmp][4][6][2],cDesAut})
				Endif
			
			OtherWise
				Aadd(aCriGen,{	aVetFim[nTmp][2],cTipMov,"","","","","","",""})
		EndCase

	Next

	aRetGen := PLSCRIGEN(aCriGen,{	{"Cadastro","@C",75},{"Movimentação","@C",40},{"Código da Rda","@C",40},{"Local de Atendto","@C",45},{"Especialidade","@C",40},{"TDE","@C",15},{"Tabela","@C",20},{"Procedimento","@C",20},{"Tipo","@C",100}},	IIF(nRelPre == 2,"Alterações Realizadas...","Relatório de Prévia de Alterações..."))

	If ! aRetGen[1]
		aVetFim  := {}
		aCriGen  := {}   
		lShowBrw := .T.
	Endif         
	
	Return

Else
	If ! lShowBrw
		nOpt := K_Visualizar
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta dados do cabecalho...                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nOpt = K_Excluir .Or. nOpt = K_Visualizar)

	Copy "SZE" TO MEMORY                 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega os registros detalhe que compoem o Lote...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Store Header "SZF" TO aCabSZF For .T.
	
	SZF->(DbSetOrder(1))
	If SZF->(MsSeek(xFilial("SZF")+SZE->SZE_CODIGO))
		Store COLS "SZF" TO aDadSZF FROM aCabSZF VETTRAB aVetSZF While SZF->(SZF_FILIAL+SZF_CODIGO) == SZE->(SZE_FILIAL+SZE_CODIGO)
	Else
	    Store COLS Blank "SZF" TO aDadSZF FROM aCabSZF
	Endif
	
	nLido := 0

	aSize := MsAdvSize(.T.)
	aObjects := {}       
	AAdd( aObjects, { 1, 1, .T., .T., .F. } )
	AAdd( aObjects, { 1, 1, .T., .T., .T. } )
	
	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T., .F. )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Dialogo...                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 TO aSize[6],aSize[5] OF GetWndDefault() Pixel

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Enchoice...                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oEnchoice := MsMGet():New(cAlias,nReg,K_Visualizar,,,,,aPosObj[1],nil,,,,,oDlg,,,.F.)
	
	@ aPosObj[2][1],aPosObj[2][2] FOLDER oFolder SIZE aPosObj[2][3],aPosObj[2][4] OF oDlg PIXEL PROMPTS "Detalhes"

	oBrwSZF := TPLSBrw():New(001,002,aPosObj[2][3]-3,aPosObj[2][4]-14,nil  ,oFolder:aDialogs[1],nil    , nil ,nil    ,nil   ,nil, .T.   ,nil  ,.T.   ,nil   ,aCabSZF,aDadSZF,.F.,"SZF",K_Visualizar,"Detalhes",nil,nil)

	oBrwSZF:bLostFocus 	:=	{|| cSequen := oBrwSZF:FieldGet("SZF_CODIGO"),lRefresh := .T. }  
								
	oBrwSZF:bChange		:= 	{|| Eval(oBrwSZF:bLostFocus),NIL }

	//Atualiza Informacoes cfme Browse	
	Eval(oBrwSZF:bLostFocus)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa o Dialogo...                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlg ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,aButtons) } ) Center	

Endif

Do Case
	Case nOpt == K_Incluir
		GeraLote()
	Case nOpt == K_Excluir
		If nOpca == K_OK
			Processa( {|| ExcLote(SZE->SZE_CODIGO) }, "Excluindo Lote de Manutenção de Valores")
		Endif
	OtherWise
		lShowBrw := .T.
EndCase

Return nOpca == K_OK

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ExcLote   ³ Autor ³Thiago Machado Correa ³ Data ³ 24.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exclui Lote de Manutencao				                  ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ExcLote(cSeq)

Local nCont := 0

SZE->(DbSetOrder(1))
SZF->(DbSetOrder(1))

If MsgYesNo("Confirma exclusão do Lote de Manutenção?")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a transacao...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
	Begin transaction 

	//Conta Registros para a Regua
	SZF->(DbSetOrder(1))
	SZF->(MsSeek(xFilial("SZF")+cSeq))
	
	While SZF->SZF_FILIAL==xFilial("SZF") .and. SZF->SZF_CODIGO==cSeq .and. ! SZF->(Eof())
		nCont++
		SZF->(DbSkip())
	EndDo

	//Prepara regua
	ProcRegua(nCont)

	//Exclui registros Detalhe do Lote
	SZF->(MsSeek(xFilial("SZF")+cSeq))

	While SZF->SZF_FILIAL==xFilial("SZF") .and. SZF->SZF_CODIGO==cSeq .and. ! SZF->(Eof())

		IncProc("Excluindo Lote de Manutenção: "+SZF->SZF_CODIGO)

		//Retorna informacoes para Base de Dados
		DbSelectArea(SZF->SZF_TABELA)
		DbGoTo(SZF->SZF_RECNO)
				
		RecLock(SZF->SZF_TABELA,.F.)
		If SZF->SZF_TIPO == "1"
			DbDelete()
		Else
			If SZF->SZF_TABELA == "BC0"
				BC0->BC0_VIGATE := SZF->SZF_BC027A
			ElseIf SZF->SZF_TABELA == "BC6"
				BC6->BC6_VIGFIM := SZF->SZF_BC627A
			Endif
		Endif
		MSUnLock()
   			
		SZF->(RecLock("SZF",.F.))
		SZF->(DbDelete())
		SZF->(MSUnLock())    	

		SZF->(DbSkip())
	EndDo

	//Exclui Lote
	SZE->(MsSeek(xFilial("SZE")+cSeq))

	SZE->(RecLock("SZE",.F.))
	SZE->(DbDelete())
	SZE->(MSUnLock())    	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza transacao...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ        
  	End Transaction 			
  	
  	MsgInfo("Lote excluído com sucesso!")
      
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ GeraLote  ³ Autor ³Thiago Machado Correa ³ Data ³ 24.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Gera Lote de Manutencao de Valores	                      ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraLote()

Local cPerg := "YPLSLM"  

AjustaSX1(cPerg)                

If lShowBrw .and. MsgYesNo("Confirma geração do Lote de Manutenção de Valores?")

	If Pergunte(cPerg,.T.)
		Processa( {|| CalcLote() }, "Calculando Manutenção de Valores","Preparando Ambiente...")
	Endif

Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CalcLote ºAutor  ³Thiago Machado Correaº Data ³  24/12/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao Principal						                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcLote()

Local oDlgRda
Local nOpcao
Local cFilRda  := ""
Local lInverte := .F.

Local cSQL    := ""
Local cCampo  := ""
Local cAlias  := ""
Local nSeqSZE := 0
Local nTotReg := 0
Local nTemp   := 0
Local nTmp    := 0
Local aCampos := {}
Local aRet    := {}
Local aTmp    := {}

PRIVATE cMarca

//Alimenta variaveis da pergunta
cRdaIni := mv_par01
cRdaFim := mv_par02
cGrvIni := mv_par03
cGrvFim := mv_par04
cTabIni := mv_par05
cProIni := mv_par06
cTabFim := mv_par07
cProFim := mv_par08
nAcao   := mv_par09
nValor  := mv_par10
nAplVlr := mv_par11
dProVig := mv_par12
nTipAut := mv_par13
cAcoIni := mv_par14
cAcoFim := mv_par15
cPlaIni := mv_par16
cPlaFim := mv_par17
nRelPre := mv_par18

//Seleciona registros para o filtro
cQuery := " SELECT BAU_CODIGO FROM " + RetSqlName("BAU")
cQuery += " WHERE BAU_FILIAL = '"+xFilial("BAU")+"' 
cQuery += " AND BAU_CODIGO >= '"+cRdaIni+"' AND BAU_CODIGO <= '"+cRdaFim+"'"
cQuery += " AND BAU_YGRVLR >= '"+cGrvIni+"' AND BAU_YGRVLR <= '"+cGrvFim+"'"
cQuery += " AND " + RetSqlName("BAU") + ".D_E_L_E_T_ = ' '"	
PLSQuery(cQuery,"TMP")

While ! TMP->(Eof())

	cFilRda += "'"+TMP->BAU_CODIGO+"'"

	TMP->(DbSkip())
	
	If ! TMP->(Eof())
		cFilRda += ","
	Endif
EndDo

TMP->(DbCloseArea())

DbSelectArea("BAX")
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria filtro para RDA...						                        	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFiltro := "@BAX_FILIAL = '"+xFilial("BAX")+"' AND BAX_CODIGO IN ("+cFilRda+") AND D_E_L_E_T_ <> '*' "
	
SET FILTER TO &cFiltro
	
BAX->(MsSeek(xFilial("BAX")))
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Dialog...                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSize := MsAdvSize()
aObjects := {}       
AAdd( aObjects, { 100, 1, .F., .T., .F. } )
AAdd( aObjects, { 1, 1, .T., .T., .F. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects, .t., .t. )	

DEFINE MSDIALOG oDlgRda TITLE "Rede de Atendimento x Especialidade" FROM aSize[7],0 TO aSize[6],aSize[5] OF GetWndDefault() Pixel

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define campos para exibicao em browse...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aCampos,{"BAX_YOK"		," "					})
aadd(aCampos,{"BAX_CODIGO"	,"Código Rda"			})
aadd(aCampos,{"BAX_CODLOC"	,"Local de Atendimento"	})
aadd(aCampos,{"BAX_CODESP"	,"Especialidade"		})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta CheckBox. Marcar desmarcar todos...                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lCheck := .T.
oCheck := IW_CheckBox(012,001,"Marca/Desmarca Todos","lCheck")
oCheck:bChange := {|| MsAguarde( {|| MarkBrw(.T.,cGrvIni,cGrvFim,cMarca) } ) }
MarkBrw(.F.,cGrvIni,cGrvFim,cMarca)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta MarkBrowse...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrowse := IW_Browse(25,1,aPosObj[2][3],aPosObj[2][4],"BAX","BAX_YOK",nil,aCampos)

oBrowse:oBrowse:bAllMark := {|| MsAguarde( {|| MarkBrw(.T.,cGrvIni,cGrvFim,cMarca) } ) }

cMarca := ThisMark()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o Dialogo...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlgRda CENTERED ON INIT EnchoiceBar(oDlgRda,{|| nOpcao := 1,oDlgRda:End()},{|| nOpcao := 0,ODlgRda:End()})

If nOpcao == 1

	cQuery := " SELECT BAX_CODIGO, BAX_CODINT, BAX_CODLOC, BAX_CODESP, BAX_CODSUB, "+RetSqlName("BAX")+".R_E_C_N_O_ AS BAX_RECNO FROM " + RetSqlName("BAX") + ", " + RetSqlName("BAU")
	cQuery += " WHERE BAX_FILIAL = '"+xFilial("BAX")+"' AND BAX_YOK <> '" + cMarca + "'"
	cQuery += " AND BAU_CODIGO >= '"+cRdaIni+"' AND BAU_CODIGO <= '"+cRdaFim+"'"
	cQuery += " AND BAU_YGRVLR >= '"+cGrvIni+"' AND BAU_YGRVLR <= '"+cGrvFim+"'"
	cQuery += " AND BAU_FILIAL = BAX_FILIAL AND BAU_CODIGO = BAX_CODIGO"
	cQuery += " AND " + RetSqlName("BAU") + ".D_E_L_E_T_ = ' '"	
	cQuery += " AND " + RetSqlName("BAX") + ".D_E_L_E_T_ = ' '"	
	cQuery += " ORDER BY BAX_CODIGO, BAX_CODINT, BAX_CODLOC, BAX_CODESP, BAX_CODSUB"
	PLSQuery(cQuery,"TMPBAX")

	While ! TMPBAX->(Eof())    
		nTotReg++
		TMPBAX->(DbSkip())
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula alteracoes...													 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	Do Case                                                                                  
		Case nAcao == 1 //Procedimentos Autorizados
			Processa( {|| aVetFim := IncProAut(nTotReg) }, "Incluindo Procedimentos Autorizados","Preparando Ambiente...")
		Case nAcao == 2 //Procedimentos Nao Autorizados
			Processa( {|| aVetFim := IncNaoAut(nTotReg) }, "Incluindo Procedimentos Não Autorizados","Preparando Ambiente...")
		Case nAcao == 3 //Reajuste de Valores
			Processa( {|| aVetFim := ReajVlr(nTotReg) }, "Reajustando Tabela de Preços x Rda","Preparando Ambiente...")
		OtherWise
			aVetFim := {}
	EndCase
	
	If nRelPre <> 1 .and. Len(aVetFim) > 0

		lShowBrw := .F.

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Lote de Manutencao...												 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
		cSQL := " SELECT MAX(SZE_CODIGO) SEQ FROM " + RetSqlName("SZE") 
		cSQL += " WHERE SZE_FILIAL = '" + xFilial("SZE") + "' AND D_E_L_E_T_ = ' ' "
		
		PLSQuery(cSQL,"TRBSZE")
		
		If TRBSZE->(Eof())
			nSeqSZE := 1
		Else 
			nSeqSZE := (val(TRBSZE->SEQ)+1)
		Endif           
		
		TRBSZE->(DbCloseArea())

		Begin transaction 
		
		//Cria arquivo de Lote
		SZE->(RecLock("SZE",.T.))
		SZE->SZE_FILIAL := xFilial("SZE")
		SZE->SZE_CODIGO := StrZero(nSeqSZE,8)
		SZE->SZE_RDAINI := cRdaIni
		SZE->SZE_RDAFIM := cRdaFim          
		SZE->SZE_GRVINI := cGrvIni
		SZE->SZE_GRVFIM := cGrvFim
		SZE->SZE_TABINI := cTabIni
		SZE->SZE_PROINI := cProIni
		SZE->SZE_TABFIM := cTabFim
		SZE->SZE_PROFIM := cProFim
		SZE->SZE_ACAO   := StrZero(nAcao,1)
		SZE->SZE_VALOR  := nValor
		SZE->SZE_TIPO   := StrZero(nAplVlr,1)
		SZE->SZE_VIGINI := dProVig
		SZE->SZE_TIPAUT := StrZero(nTipAut,1)
		SZE->SZE_ACOINI := cAcoIni
		SZE->SZE_ACOFIM := cAcoFim
		SZE->SZE_PLAINI := cPlaIni
		SZE->SZE_PLAFIM := cPlaFim
		SZE->SZE_USUARI := cUserName
		SZE->SZE_DATA   := dDatabase
		SZE->SZE_HORA   := substr(Time(),1,2)+substr(Time(),4,2)
		SZE->(MsUnlock())
		
		For nTemp := 1 to Len(aVetFim)

            //Altera Base de Dados
            cAlias := aVetFim[nTemp][2]
            
   			DbSelectArea(cAlias)
   			
			If aVetFim[nTemp][1] == "I"

				aTmp := aClone(aVetFim[nTemp][4])
				
				RecLock(cAlias,.T.)
				For nTmp := 1 to Len(aTmp)
					cCampo  := cAlias + "->" + aTmp[nTmp][1]
					&cCampo := aTmp[nTmp][2]
				Next
				MSUnLock()
                 
			Else
				
				DbGoTo(aVetFim[nTemp][3])
				
				RecLock(cAlias,.F.)
				If cAlias == "BC0"
					BC0->BC0_VIGATE := aVetFim[nTemp][4][15][2]
				ElseIf cAlias == "BC6"
					BC6->BC6_VIGFIM := aVetFim[nTemp][4][29][2]
				EndIf
				MSUnLock()

			Endif
			
			//Cria registros de detalhamento do Lote
			SZF->(RecLock("SZF",.T.))
			SZF->SZF_FILIAL := xFilial("SZF")
			SZF->SZF_CODIGO := SZE->SZE_CODIGO
			SZF->SZF_TABELA := cAlias
			SZF->SZF_RECNO  := Recno()
			SZF->SZF_TIPO   := IIF(aVetFim[nTemp][1]=="I","1","2")
			
			If aVetFim[nTemp][1] <> "I"
			
				Do Case
					Case aVetFim[nTemp][2] == "BC0"
						SZF->SZF_BC027A := aVetFim[nTemp][4][14][2]
						SZF->SZF_BC027N := aVetFim[nTemp][4][15][2]

					Case aVetFim[nTemp][2] == "BC6"
						SZF->SZF_BC627A := aVetFim[nTemp][4][15][2]
						SZF->SZF_BC627N := aVetFim[nTemp][4][29][2]
	            EndCase
	            
            Endif

			SZF->(MsUnlock()) 
            
        Next
        
    	End transaction 

	Endif
		
	TMPBAX->(DbCloseArea())

	//Mensagem ao usuario
	If Len(aVetFim) == 0
		aAdd(aVetFim,{"","XXX",0,{},0})
	Endif

Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao   ³ MarkBrw ³ Autor ³ Thiago Machado Correa³ Data ³ 31.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Marca/Desmarca todos os itens do Browse...                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MarkBrw(lObj,cGrvIni,cGrvFim,cMarca)

LOCAL cSQL
DEFAULT lObj := .T.

If  lObj
    MsProcTXT(If(lCheck,"Marcando","Desmarcando")+" Todos os Prestadores...")
	ProcessMessages()    
Endif    

cSQL := "UPDATE "+RetSQLName("BAX")+" SET BAX_YOK = '  '"
cSQL += " WHERE BAX_FILIAL = '"+xFilial("BAX")+"' AND D_E_L_E_T_ = ' '"
TCSQLExec(cSQL)

cSQL := "UPDATE "+RetSQLName("BAX")+" SET BAX_YOK = "
If lCheck
   cSQL := cSQL + "'  '"
Else  
   cSQL := cSQL + "'"+cMarca+"'"
Endif                                               
cSQL += " WHERE BAX_FILIAL = '"+xFilial("BAX")+"' AND D_E_L_E_T_ = ' '"
TCSQLExec(cSQL)

BAX->(DbGoTop())
BAX->(MsSeek(xFilial("BAX")))

If  lObj
    oBrowse:oBrowse:Refresh()
Endif    

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AjustaSX1ºAutor  ³Thiago Machado Correaº Data ³  24/12/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta as perguntas do SX1 da rotina.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("RDA De")                    ,"","","mv_cha","C",06,0,0,"G","","BA0","","","mv_par01",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("RDA Ate")                   ,"","","mv_chb","C",06,0,0,"G","","BA0","","","mv_par02",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Grupo de Valores De")       ,"","","mv_chc","C",04,0,0,"G","","SZD","","","mv_par03",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Grupo de Valores Ate")      ,"","","mv_chd","C",04,0,0,"G","","SZD","","","mv_par04",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Cod Tp Proc De")            ,"","","mv_che","C",02,0,0,"G","",""   ,"","","mv_par05",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Cod Proced De")             ,"","","mv_chf","C",16,0,0,"G","",""   ,"","","mv_par06",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Cod Tp Proc Ate")           ,"","","mv_chg","C",02,0,0,"G","",""   ,"","","mv_par07",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Cod Proced Ate")            ,"","","mv_chh","C",16,0,0,"G","",""   ,"","","mv_par08",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Acao")                      ,"","","mv_chi","N",01,0,0,"C","",""   ,"","","mv_par09","Autorizado","","","","Nao Autorizado","","","Reajuste"          ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Valor")                     ,"","","mv_chj","N",17,4,0,"G","",""   ,"","","mv_par10",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Valor aplicado como")       ,"","","mv_chk","N",01,0,0,"C","",""   ,"","","mv_par11","% Reajuste","","","","Valor Reajuste","","","Vlr Inc Reajuste"  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Inicio da Próxima Vigência"),"","","mv_chl","D",08,0,0,"G","",""   ,"","","mv_par12",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Tipo (Autorização)")        ,"","","mv_chm","N",01,0,0,"C","",""   ,"","","mv_par13","Executa"   ,"","","","Solicita"      ,"","","Ambos"             ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"14",OemToAnsi("Acomodação De")             ,"","","mv_chn","C",02,0,0,"G","",""   ,"","","mv_par14",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"15",OemToAnsi("Acomodação Ate")            ,"","","mv_cho","C",02,0,0,"G","",""   ,"","","mv_par15",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"16",OemToAnsi("Produto De")                ,"","","mv_chp","C",04,0,0,"G","",""   ,"","","mv_par16",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"17",OemToAnsi("Produto Ate")               ,"","","mv_chq","C",04,0,0,"G","",""   ,"","","mv_par17",""          ,"","","",""              ,"","",""                  ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"18",OemToAnsi("Somente Relatório Prévio")  ,"","","mv_chr","N",01,0,0,"C","",""   ,"","","mv_par18","Sim"       ,"","","","Nao"           ,"","",""                  ,"","","","","","","","",{},{},{})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IncProAutºAutor  ³Thiago Machado Correaº Data ³  03/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclui Procedimentos Autorizados - BC0                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncProAut(nTotBax)

Local aRet   := {}  
Local aTmp   := {}
Local aTab   := {}
Local cSql   := ""
Local cCp1   := ""
Local cCp2   := ""
Local nInd   := 0

ProcRegua(nTotBax)

//Encerra a vigencia dos procedimentos ja cadastrados
TMPBAX->(DbGoTop())

While ! TMPBAX->(Eof())
    
	IncProc("Encerrando a vigência dos procedimentos...")

	cSql := " SELECT R_E_C_N_O_ REG FROM " + RetSqlName("BC0")
	cSql += " WHERE BC0_FILIAL = '"+xFilial("BC0")+"'"
	cSql += " AND BC0_CODIGO = '"+TMPBAX->BAX_CODIGO+"'"
	cSql += " AND BC0_CODINT = '"+TMPBAX->BAX_CODINT+"'"
	cSql += " AND BC0_CODLOC = '"+TMPBAX->BAX_CODLOC+"'"
	cSql += " AND BC0_CODESP = '"+TMPBAX->BAX_CODESP+"'"
	cSql += " AND BC0_CODPAD >= '"+cTabIni+"' AND BC0_CODPAD <= '"+cTabFim+"'"
	cSql += " AND BC0_CODOPC >= '"+cProIni+"' AND BC0_CODOPC <= '"+cProFim+"'"
	cSql += " AND D_E_L_E_T_ = ' '"	
	cSql += " ORDER BY BC0_CODIGO, BC0_CODINT, BC0_CODLOC, BC0_CODESP, BC0_CODPAD, BC0_CODOPC"
	PLSQuery(cSql,"TMP")

	While ! TMP->(Eof())
        
		BC0->(DbGoTo(TMP->REG))
		
		aTmp := {}

		aAdd(aTmp,{"BC0_FILIAL"	,BC0->BC0_FILIAL	})
		aAdd(aTmp,{"BC0_CODIGO"	,BC0->BC0_CODIGO	})
		aAdd(aTmp,{"BC0_CODINT"	,BC0->BC0_CODINT	})
		aAdd(aTmp,{"BC0_CODLOC"	,BC0->BC0_CODLOC	})
		aAdd(aTmp,{"BC0_CODESP"	,BC0->BC0_CODESP	})
		aAdd(aTmp,{"BC0_CODSUB"	,BC0->BC0_CODSUB	})
		aAdd(aTmp,{"BC0_CODTAB"	,BC0->BC0_CODTAB	})
		aAdd(aTmp,{"BC0_CODPAD"	,BC0->BC0_CODPAD	})
		aAdd(aTmp,{"BC0_CODOPC"	,BC0->BC0_CODOPC	})
		aAdd(aTmp,{"BC0_NIVEL"	,BC0->BC0_NIVEL		})
		aAdd(aTmp,{"BC0_FORMUL"	,BC0->BC0_FORMUL	})
		aAdd(aTmp,{"BC0_TIPO"	,BC0->BC0_TIPO		})
		aAdd(aTmp,{"BC0_VIGDE"	,BC0->BC0_VIGDE		})
		aAdd(aTmp,{"BC0_VIGATE"	,BC0->BC0_VIGATE	})
		aAdd(aTmp,{"BC0_VIGATE"	,(dProVig-1)		})

		aAdd(aRet,{"A","BC0",TMP->REG,aTmp,Len(aRet)})

		TMP->(DbSkip())
	EndDo

	TMP->(DbCloseArea())	
	
	TMPBAX->(DbSkip())
EndDo

//Inicia nova vigencia
cSql := " SELECT BA8_CODTAB, BA8_CODPAD, BA8_CODPRO, BA8_NIVEL FROM " + RetSqlName("BA8")
cSql += " WHERE BA8_FILIAL = '"+xFilial("BA8")+"'"
cSql += " AND BA8_CODPAD >= '"+cTabIni+"' AND BA8_CODPAD <= '"+cTabFim+"'"
cSql += " AND BA8_CODPRO >= '"+cProIni+"' AND BA8_CODPRO <= '"+cProFim+"'"
cSql += " AND D_E_L_E_T_ = ' '"	
cSql += " ORDER BY BA8_CODTAB, BA8_CODPAD, BA8_CODPRO"
PLSQuery(cSql,"TRBBA8")

TMPBAX->(DbGoTop())
  
ProcRegua(nTotBax)

While ! TMPBAX->(Eof())

	IncProc("Incluindo Procedimentos Autorizados...")
	
	TRBBA8->(DbGoTop())

	While ! TRBBA8->(Eof())

		aTab := PLSESPNIV(TRBBA8->BA8_CODPAD)
		aTmp := {}
		cCp1 := ""
		cCp2 := ""
		nInd := 0

		aAdd(aTmp,{"BC0_FILIAL"	,xFilial("BC0")					})
		aAdd(aTmp,{"BC0_CODIGO"	,TMPBAX->BAX_CODIGO				})
		aAdd(aTmp,{"BC0_CODINT"	,TMPBAX->BAX_CODINT				})
		aAdd(aTmp,{"BC0_CODLOC"	,TMPBAX->BAX_CODLOC				})
		aAdd(aTmp,{"BC0_CODESP"	,TMPBAX->BAX_CODESP				})
		aAdd(aTmp,{"BC0_CODSUB"	,TMPBAX->BAX_CODSUB				})
		aAdd(aTmp,{"BC0_CODTAB"	,substr(TRBBA8->BA8_CODTAB,5,3)})
		aAdd(aTmp,{"BC0_CODPAD"	,TRBBA8->BA8_CODPAD				})
		aAdd(aTmp,{"BC0_CODOPC"	,TRBBA8->BA8_CODPRO				})
		aAdd(aTmp,{"BC0_NIVEL"	,TRBBA8->BA8_NIVEL				})
		aAdd(aTmp,{"BC0_FORMUL"	,"1"							})
		aAdd(aTmp,{"BC0_TIPO"	,StrZero(nTipAut,1)				})
		aAdd(aTmp,{"BC0_VIGDE"	,dProVig						})
		
		For nInd := 1 To aTab[1]
			cCp1 := "BC0_CDNV0"+StrZero(nInd,1)
			cCp2 := Subs(TRBBA8->BA8_CODPRO,aTab[2,nInd,1],aTab[2,nInd,2])
			aAdd(aTmp,{cCp1,cCp2})
		Next

		aAdd(aRet,{"I","BC0",0,aTmp,Len(aRet)})
		
		TRBBA8->(DbSkip())
	EndDo

	TMPBAX->(DbSkip())
EndDo

TRBBA8->(DbCloseArea())

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IncNaoAutºAutor  ³Thiago Machado Correaº Data ³  04/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclui Procedimentos Nao Autorizados - BBN                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncNaoAut(nTotBax)

Local aRet   := {}  
Local aTmp   := {}
Local aTab   := {}
Local cSql   := ""
Local cCp1   := ""
Local cCp2   := ""
Local nInd   := 0

BBN->(DbSetOrder(1))

ProcRegua(nTotBax)

//Encerra a vigencia dos procedimentos Autorizados
TMPBAX->(DbGoTop())

While ! TMPBAX->(Eof())
    
	IncProc("Encerrando a vigência dos procedimentos...")

	cSql := " SELECT R_E_C_N_O_ REG FROM " + RetSqlName("BC0")
	cSql += " WHERE BC0_FILIAL = '"+xFilial("BC0")+"'"
	cSql += " AND BC0_CODIGO = '"+TMPBAX->BAX_CODIGO+"'"
	cSql += " AND BC0_CODINT = '"+TMPBAX->BAX_CODINT+"'"
	cSql += " AND BC0_CODLOC = '"+TMPBAX->BAX_CODLOC+"'"
	cSql += " AND BC0_CODESP = '"+TMPBAX->BAX_CODESP+"'"
	cSql += " AND BC0_CODPAD >= '"+cTabIni+"' AND BC0_CODPAD <= '"+cTabFim+"'"
	cSql += " AND BC0_CODOPC >= '"+cProIni+"' AND BC0_CODOPC <= '"+cProFim+"'"
	cSql += " AND (BC0_VIGATE = '' OR BC0_VIGATE >= '"+DtoS(dProVig)+"')"
	cSql += " AND D_E_L_E_T_ = ' '"	
	cSql += " ORDER BY BC0_CODIGO, BC0_CODINT, BC0_CODLOC, BC0_CODESP, BC0_CODPAD, BC0_CODOPC"
	PLSQuery(cSql,"TMP")

	While ! TMP->(Eof())

		BC0->(DbGoTo(TMP->REG))
		
		aTmp := {}

		aAdd(aTmp,{"BC0_FILIAL"	,BC0->BC0_FILIAL	})
		aAdd(aTmp,{"BC0_CODIGO"	,BC0->BC0_CODIGO	})
		aAdd(aTmp,{"BC0_CODINT"	,BC0->BC0_CODINT	})
		aAdd(aTmp,{"BC0_CODLOC"	,BC0->BC0_CODLOC	})
		aAdd(aTmp,{"BC0_CODESP"	,BC0->BC0_CODESP	})
		aAdd(aTmp,{"BC0_CODSUB"	,BC0->BC0_CODSUB	})
		aAdd(aTmp,{"BC0_CODTAB"	,BC0->BC0_CODTAB	})
		aAdd(aTmp,{"BC0_CODPAD"	,BC0->BC0_CODPAD	})
		aAdd(aTmp,{"BC0_CODOPC"	,BC0->BC0_CODOPC	})
		aAdd(aTmp,{"BC0_NIVEL"	,BC0->BC0_NIVEL		})
		aAdd(aTmp,{"BC0_FORMUL"	,BC0->BC0_FORMUL	})
		aAdd(aTmp,{"BC0_TIPO"	,BC0->BC0_TIPO		})
		aAdd(aTmp,{"BC0_VIGDE"	,BC0->BC0_VIGDE		})
		aAdd(aTmp,{"BC0_VIGATE"	,BC0->BC0_VIGATE	})
		aAdd(aTmp,{"BC0_VIGATE"	,(dProVig-1)		})

		aAdd(aRet,{"A","BC0",TMP->REG,aTmp,Len(aRet)})

		TMP->(DbSkip())
	EndDo

	TMP->(DbCloseArea())	
	
	TMPBAX->(DbSkip())
EndDo

//Inclui procedimentos como Nao Autorizados
cSql := " SELECT BR8_CODPAD, BR8_CODPSA, BR8_NIVEL FROM " + RetSqlName("BR8")
cSql += " WHERE BR8_FILIAL = '"+xFilial("BR8")+"'"
cSql += " AND BR8_CODPAD >= '"+cTabIni+"' AND BR8_CODPAD <= '"+cTabFim+"'"
cSql += " AND BR8_CODPSA >= '"+cProIni+"' AND BR8_CODPSA <= '"+cProFim+"'"
cSql += " AND D_E_L_E_T_ = ' '"	
cSql += " ORDER BY BR8_CODPAD, BR8_CODPSA"
PLSQuery(cSql,"TRBBR8")

TMPBAX->(DbGoTop())
  
ProcRegua(nTotBax)

While ! TMPBAX->(Eof())

	IncProc("Incluindo Procedimentos Autorizados...")
	
	TRBBR8->(DbGoTop())

	While ! TRBBR8->(Eof())
    
		If ! BBN->(MsSeek(xFilial("BBN")+TMPBAX->(BAX_CODIGO+BAX_CODINT+BAX_CODLOC+BAX_CODESP)+TRBBR8->(BR8_CODPAD+BR8_CODPSA)))
		
			aTab := PLSESPNIV(TRBBR8->BR8_CODPAD)
			aTmp := {}
			cCp1 := ""
			cCp2 := ""
			nInd := 0
	
			aAdd(aTmp,{"BBN_FILIAL"	,xFilial("BBN")		})
			aAdd(aTmp,{"BBN_CODIGO"	,TMPBAX->BAX_CODIGO	})
			aAdd(aTmp,{"BBN_CODINT"	,TMPBAX->BAX_CODINT	})
			aAdd(aTmp,{"BBN_CODLOC"	,TMPBAX->BAX_CODLOC	})
			aAdd(aTmp,{"BBN_CODESP"	,TMPBAX->BAX_CODESP	})
			aAdd(aTmp,{"BBN_CODSUB"	,TMPBAX->BAX_CODSUB	})
			aAdd(aTmp,{"BBN_CODPAD"	,TRBBR8->BR8_CODPAD	})
			aAdd(aTmp,{"BBN_CODPSA"	,TRBBR8->BR8_CODPSA	})
			aAdd(aTmp,{"BBN_NIVEL"	,TRBBR8->BR8_NIVEL	})
			
			For nInd := 1 To aTab[1]
				cCp1 := "BBN_CDNV0"+StrZero(nInd,1)
				cCp2 := Subs(TRBBR8->BR8_CODPSA,aTab[2,nInd,1],aTab[2,nInd,2])
				aAdd(aTmp,{cCp1,cCp2})
			Next
	
			aAdd(aRet,{"I","BBN",0,aTmp,Len(aRet)})
		
		Endif
		
		TRBBR8->(DbSkip())
	EndDo

	TMPBAX->(DbSkip())
EndDo

TRBBR8->(DbCloseArea())

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReajVlr  ºAutor  ³Thiago Machado Correaº Data ³  04/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Reajusta valores na Tabela de Precos x Rda - BC6            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReajVlr(nTotBax)

Local aRet    := {}  
Local aTmp    := {}
Local aRda    := {}
Local aVetAlt := {}
Local aVetInc := {}
Local cSql    := ""
Local cCodTab := ""
Local nTmp    := 0
Local nVlr    := 0    
Local nInd    := 0
Local aTab    := {}

TMPBAX->(DbGoTop())

While ! TMPBAX->(Eof())

	If aScan(aRda,TMPBAX->BAX_CODIGO) == 0
		aAdd(aRda,TMPBAX->BAX_CODIGO)
	Endif

	TMPBAX->(DbSkip())
EndDo

ProcRegua(Len(aRda))

For nTmp := 1 to Len(aRda)

	IncProc("Encerrando a vigência dos procedimentos...")

	cSql := " SELECT R_E_C_N_O_ REG FROM " + RetSqlName("BC6")
	cSql += " WHERE BC6_FILIAL = '"+xFilial("BC6")+"'"
	cSql += " AND BC6_CODINT = '"+PlsIntPad()+"'"
	cSql += " AND BC6_CODRDA = '"+aRda[nTmp]+"'"
	cSql += " AND BC6_CODPAD >= '"+cTabIni+"' AND BC6_CODPAD <= '"+cTabFim+"'"
	cSql += " AND BC6_CODPRO >= '"+cProIni+"' AND BC6_CODPRO <= '"+cProFim+"'"
	cSql += " AND (BC6_VIGFIM = '' OR BC6_VIGFIM >= '"+DtoS(dProVig)+"')"
	cSql += " AND (BC6_TIPLAN = '1' OR (BC6_CODACO >= '"+cAcoIni+"' AND BC6_CODACO <= '"+cAcoFim+"'))"
	cSql += " AND (BC6_TPLANP = '1' OR (BC6_CODPLA >= '"+cPlaIni+"' AND BC6_CODPLA <= '"+cPlaFim+"'))"
	cSql += " AND D_E_L_E_T_ = ' '"	
	cSql += " ORDER BY BC6_CODPAD, BC6_CODPRO"
	PLSQuery(cSql,"TMP")

	While ! TMP->(Eof())
		
		BC6->(DbGoTo(TMP->REG))
		
		aTmp := {}

		aAdd(aTmp,{"BC6_FILIAL"	,BC6->BC6_FILIAL	})
		aAdd(aTmp,{"BC6_CODINT"	,BC6->BC6_CODINT	})
		aAdd(aTmp,{"BC6_CODRDA"	,BC6->BC6_CODRDA	})
		aAdd(aTmp,{"BC6_CODTAB"	,BC6->BC6_CODTAB	})
		aAdd(aTmp,{"BC6_CODPAD"	,BC6->BC6_CODPAD	})
		aAdd(aTmp,{"BC6_CODPRO"	,BC6->BC6_CODPRO	})
		aAdd(aTmp,{"BC6_CDPRRA"	,BC6->BC6_CDPRRA	})
		aAdd(aTmp,{"BC6_TIPLAN"	,BC6->BC6_TIPLAN	})
		aAdd(aTmp,{"BC6_CODACO"	,BC6->BC6_CODACO	})
		aAdd(aTmp,{"BC6_TPLAN"	,BC6->BC6_TPLAN 	})
		aAdd(aTmp,{"BC6_CODOPE"	,BC6->BC6_CODOPE	})
		aAdd(aTmp,{"BC6_TPLANP"	,BC6->BC6_TPLANP	})
		aAdd(aTmp,{"BC6_CODPLA"	,BC6->BC6_CODPLA	})
		aAdd(aTmp,{"BC6_VIGINI"	,BC6->BC6_VIGINI	})
		aAdd(aTmp,{"BC6_VIGFIM"	,BC6->BC6_VIGFIM	})
		aAdd(aTmp,{"BC6_USPCO"	,BC6->BC6_USPCO		})
		aAdd(aTmp,{"BC6_VRPCO"	,BC6->BC6_VRPCO		})
		aAdd(aTmp,{"BC6_USRCO"	,BC6->BC6_USRCO		})
		aAdd(aTmp,{"BC6_VRRCO"	,BC6->BC6_VRRCO		})
		aAdd(aTmp,{"BC6_USPPP"	,BC6->BC6_USPPP		})
		aAdd(aTmp,{"BC6_VRPPP"	,BC6->BC6_VRPPP		})
		aAdd(aTmp,{"BC6_USRPP"	,BC6->BC6_USRPP		})
		aAdd(aTmp,{"BC6_VRRPP"	,BC6->BC6_VRRPP		})
		aAdd(aTmp,{"BC6_NIVEL"	,BC6->BC6_NIVEL		})
		aAdd(aTmp,{"BC6_CDNV01"	,BC6->BC6_CDNV01	})
		aAdd(aTmp,{"BC6_CDNV02"	,BC6->BC6_CDNV02	})
		aAdd(aTmp,{"BC6_CDNV03"	,BC6->BC6_CDNV03	})
		aAdd(aTmp,{"BC6_CDNV04"	,BC6->BC6_CDNV04	})
		
		aVetAlt := aClone(aTmp)
		aVetInc := aClone(aTmp)
        
		//Inclui registro de alteracao
		aAdd(aVetAlt,{"BC6_VIGFIM"	,(dProVig-1)	})     
		aAdd(aRet,{"A","BC6",TMP->REG,aVetAlt,Len(aRet)})
		
		//Inclui registro de inclusao
		aVetInc[14][2] := dProVig
		aVetInc[15][2] := StoD("")

		Do Case
			Case nAplVlr == 1 //% Reajuste
				aVetInc[16][2] := (aVetInc[16][2] + (aVetInc[16][2] * (nValor/100)))
				aVetInc[17][2] := (aVetInc[17][2] + (aVetInc[17][2] * (nValor/100)))
				aVetInc[18][2] := (aVetInc[18][2] + (aVetInc[18][2] * (nValor/100)))
				aVetInc[19][2] := (aVetInc[19][2] + (aVetInc[19][2] * (nValor/100)))
				aVetInc[20][2] := (aVetInc[20][2] + (aVetInc[20][2] * (nValor/100)))
				aVetInc[21][2] := (aVetInc[21][2] + (aVetInc[21][2] * (nValor/100)))
				aVetInc[22][2] := (aVetInc[22][2] + (aVetInc[22][2] * (nValor/100)))
				aVetInc[23][2] := (aVetInc[23][2] + (aVetInc[23][2] * (nValor/100)))
						
			Case nAplVlr == 2 //Valor Reajuste
				aVetInc[16][2] := IIF(aVetInc[16][2]>0,nValor,0)
				aVetInc[17][2] := IIF(aVetInc[17][2]>0,nValor,0)
				aVetInc[18][2] := IIF(aVetInc[18][2]>0,nValor,0)
				aVetInc[19][2] := IIF(aVetInc[19][2]>0,nValor,0)
				aVetInc[20][2] := IIF(aVetInc[20][2]>0,nValor,0)
				aVetInc[21][2] := IIF(aVetInc[21][2]>0,nValor,0)
				aVetInc[22][2] := IIF(aVetInc[22][2]>0,nValor,0)
				aVetInc[23][2] := IIF(aVetInc[23][2]>0,nValor,0)

			Case nAplVlr == 3 //Vlr Inc Reajuste
				aVetInc[16][2] += IIF(aVetInc[16][2]>0,nValor,0)
				aVetInc[17][2] += IIF(aVetInc[17][2]>0,nValor,0)
				aVetInc[18][2] += IIF(aVetInc[18][2]>0,nValor,0)
				aVetInc[19][2] += IIF(aVetInc[19][2]>0,nValor,0)
				aVetInc[20][2] += IIF(aVetInc[20][2]>0,nValor,0)
				aVetInc[21][2] += IIF(aVetInc[21][2]>0,nValor,0)
				aVetInc[22][2] += IIF(aVetInc[22][2]>0,nValor,0)
				aVetInc[23][2] += IIF(aVetInc[23][2]>0,nValor,0)

		EndCase
		
		aAdd(aRet,{"I","BC6",0,aVetInc,Len(aRet)})

		TMP->(DbSkip())
	EndDo

	TMP->(DbCloseArea())		

	//Inclui procedimentos que nao estao cadastrados em BC6 caso a opcao escolhida seja 'Valor Reajuste'
	If nAplVlr == 2
        
		cCodTab := RetTab(aRda[nTmp])
		
		cSql := " SELECT BR8_CODPAD, BR8_CODPSA, BR8_NIVEL FROM " + RetSqlName("BR8")
		cSql += " WHERE BR8_FILIAL = '"+xFilial("BR8")+"'"
		cSql += " AND BR8_CODPAD >= '"+cTabIni+"' AND BR8_CODPAD <= '"+cTabFim+"'"
		cSql += " AND BR8_CODPSA >= '"+cProIni+"' AND BR8_CODPSA <= '"+cProFim+"'"
		cSql += " AND " + RetSqlName("BR8") + ".D_E_L_E_T_ = ' '"
		cSql += " AND (SELECT COUNT(*) FROM "+RetSqlName("BC6")+" WHERE BC6_FILIAL = '"+xFilial("BC6")+"' AND BC6_CODINT = '"+PlsIntPad()+"' AND BC6_CODRDA = '"+aRda[nTmp]+"' AND BC6_CODPAD >= '"+cTabIni+"' AND BC6_CODPAD <= '"+cTabFim+"' AND BC6_CODPRO >= '"+cProIni+"' AND BC6_CODPRO <= '"+cProFim+"' AND "+RetSqlName("BC6")+".D_E_L_E_T_=' ') = 0"
		cSql += " ORDER BY BR8_CODPAD, BR8_CODPSA"
		PLSQuery(cSql,"TMP")
        
		While ! TMP->(Eof())

			aTmp := {}

			aAdd(aTmp,{"BC6_FILIAL"	,xFilial("BC6")	})
			aAdd(aTmp,{"BC6_CODINT"	,PlsIntPad()	})
			aAdd(aTmp,{"BC6_CODRDA"	,aRda[nTmp]		})
			aAdd(aTmp,{"BC6_CODTAB"	,cCodTab		})
			aAdd(aTmp,{"BC6_CODPAD"	,TMP->BR8_CODPAD	})
			aAdd(aTmp,{"BC6_CODPRO"	,TMP->BR8_CODPSA	})
			aAdd(aTmp,{"BC6_CDPRRA"	,TMP->BR8_CODPSA	})
			aAdd(aTmp,{"BC6_TIPLAN"	,"1"	})
			aAdd(aTmp,{"BC6_CODACO"	,""		})
			aAdd(aTmp,{"BC6_TPLAN"	,"1" 	})
			aAdd(aTmp,{"BC6_CODOPE"	,""		})
			aAdd(aTmp,{"BC6_TPLANP"	,"1"	})
			aAdd(aTmp,{"BC6_CODPLA"	,""		})
			aAdd(aTmp,{"BC6_VIGINI"	,dProVig	})
			aAdd(aTmp,{"BC6_VIGFIM"	,StoD("")	})
			aAdd(aTmp,{"BC6_USPCO"	,0			})
			aAdd(aTmp,{"BC6_VRPCO"	,nValor		})
			aAdd(aTmp,{"BC6_USRCO"	,0			})
			aAdd(aTmp,{"BC6_VRRCO"	,0			})
			aAdd(aTmp,{"BC6_USPPP"	,0			})
			aAdd(aTmp,{"BC6_VRPPP"	,nValor		})
			aAdd(aTmp,{"BC6_USRPP"	,0			})
			aAdd(aTmp,{"BC6_VRRPP"	,0			})
			aAdd(aTmp,{"BC6_NIVEL"	,TMP->BR8_NIVEL	})

			aTab := PLSESPNIV(TMP->BR8_CODPAD)

			For nInd := 1 To aTab[1]
				aAdd(aTmp,{"BC6_CDNV0"+StrZero(nInd,1),Substr(TMP->BR8_CODPSA,aTab[2,nInd,1],aTab[2,nInd,2])})
			Next

			aAdd(aRet,{"I","BC6",0,aTmp,Len(aRet)})

			TMP->(DbSkip())
		EndDo
		
		TMP->(DbCloseArea())		
		
	Endif    

Next

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RetTab   ºAutor  ³Thiago Machado Correaº Data ³  02/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna Tela de Precos x Rda (BC5)						   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RetTab(cRda)

BC5->(DbSetOrder(1))

If ! BC5->(MsSeek(xFilial("BC5")+PlsIntPad()+cRda))

	BC5->(RecLock("BC5",.T.))
	BC5->BC5_FILIAL := xFilial("BC5")
	BC5->BC5_CODINT := PlsIntPad()
	BC5->BC5_CODRDA := cRda
	BC5->BC5_CODTAB := "001"
	BC5->BC5_DESCRI := "TABELA 001"
	BC5->(MSUnLock())    	

Endif

Return BC5->BC5_CODTAB