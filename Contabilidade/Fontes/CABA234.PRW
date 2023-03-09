#INCLUDE "TOTVS.CH"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA 			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_SALDO_ANT    	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_VLR_DEBITO   	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_VLR_CREDITO  	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_MOVIMENTO 		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_SALDO_ATU 		14
#DEFINE 	COL_SEPARA8			15
#DEFINE 	TAM_VALOR			20

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr040	³ Autor ³ Ramon de Almeida N.	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ctbr040()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


User Function CABA234()

	Static cTpValor  := "D"

// Local lImpBalR4		:= TRepInUse()

	Private titulo		:= ""
	Private nomeprog	:= "CABA234"

	cTpValor := Alltrim(GetMV("MV_TPVALOR"))

		If Select("cArqTmp") > 0
			cArqTmp->(dbCloseArea())
		EndIf


	CABA234A(.T.)

	//Limpa os arquivos temporários
	CTBGerClean()

Return



// /*
// ------------------------------------------------------------------------- RELEASE 3 -------------------------------------------------------------------------------
// */



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr040R3³ Autor ³ Ramon de Almeida N.	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ctbr040()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function CABA234A(wnRel)
	Local aSetOfBook
	Local aCtbMoeda	:= {}
// LOCAL cDesc1 		:= "Este programa ira imprimir o Balancete de Verificacao Modelo 1 (80 Colunas), a"
// LOCAL cDesc2 		:= "conta eh impressa limitando-se a 20 caracteres e sua descricao 30 caracteres,"
// LOCAL cDesc3		:= "os valores impressao sao saldo anterior, debito, credito e saldo atual do periodo."
	LOCAL cString		:= "CT1"
	Local cTitOrig		:= ""
	Local lRet			:= .T.
	Local nDivide		:= 1
	Local lExterno 	:= .F.
	Local nQuadro
// Local lPerg			:= .T.
	PRIVATE nLastKey 	:= 0
	PRIVATE cPerg	 	:= "CABA234A"
	PRIVATE aLinha		:= {}
	PRIVATE nomeProg  	:= "CABA234A"
	PRIVATE titulo 		:= "Balancete de Verificacao"
	Private aSelFil		:= {}
	Default wnRel := ""

	lExterno := !Empty(wnRel)

	cTitOrig	:= titulo

		If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
			Return
		EndIf

	li	:= 60 //80

	Private aQuadro := { "","","","","","","",""}

		For nQuadro :=1 To Len(aQuadro)
			aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
		Next

	CtbCarTxt()

	Pergunte("CTR040",.T.)

	_cArquivo:= tFileDialog("Todos os arquivos de texto (*.txt)",'Selecao de Arquivos',0,/*pasta origem*/,.T.,)

		If !(SUBSTR(_cArquivo, len(_cArquivo)-3, 4) = ".csv" .or. SUBSTR(_cArquivo, len(_cArquivo)-4, 5) = ".xlsx" .or. SUBSTR(_cArquivo, len(_cArquivo)-3, 4) = ".xml")
			_cArquivo+=".txt"			
		Endif

	_nHdl     := fCreate(_cArquivo)

 		If _nHdl == -1
			MsgAlert("O arquivo de nome "+ _cArquivo +" nao pode ser executado! Verifique os parametros.","Atencao!")
			Return
		Endif


// //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// //³ Variaveis utilizadas para parametros								  ³
// //³ mv_par01				// Data Inicial                  	  		  ³
// //³ mv_par02				// Data Final                        		  ³
// //³ mv_par03				// Conta Inicial                         	  ³
// //³ mv_par04				// Conta Final  							  ³
// //³ mv_par05				// Imprime Contas: Sintet/Analit/Ambas   	  ³
// //³ mv_par06				// Set Of Books				    		      ³
// //³ mv_par07				// Saldos Zerados?			     		      ³
// //³ mv_par08				// Moeda?          			     		      ³
// //³ mv_par09				// Pagina Inicial  		     		    	  ³
// //³ mv_par10				// Saldos? Reais / Orcados	/Gerenciais   	  ³
// //³ mv_par11				// Quebra por Grupo Contabil?		    	  ³
// //³ mv_par12				// Filtra Segmento?					    	  ³
// //³ mv_par13				// Conteudo Inicial Segmento?		   		  ³
// //³ mv_par14				// Conteudo Final Segmento?		    		  ³
// //³ mv_par15				// Conteudo Contido em?				    	  ³
// //³ mv_par16				// Imprime Coluna Mov ?				    	  ³
// //³ mv_par17				// Salta linha sintetica ?			    	  ³
// //³ mv_par18				// Imprime valor 0.00    ?			    	  ³
// //³ mv_par19				// Imprimir Codigo? Normal / Reduzido  		  ³
// //³ mv_par20				// Divide por ?                   			  ³
// //³ mv_par21				// Imprimir Ate o segmento?			   		  ³
// //³ mv_par22				// Posicao Ant. L/P? Sim / Nao         		  ³
// //³ mv_par23				// Data Lucros/Perdas?                 		  ³
// //³ mv_par24				// Imprime Quadros Contábeis?				  ³
// //³ mv_par25				// Rec./Desp. Anterior Zeradas?				  ³
// //³ mv_par26				// Grupo Receitas/Despesas?      			  ³
// //³ mv_par27				// Data de Zeramento Receita/Despesas?		  ³
// //³ mv_par28                // Num.linhas p/ o Balancete Modelo 1	  ³
// //³ mv_par29				// Descricao na moeda?						  ³
// //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*

If ! lExterno
	Pergunte("CABA234",.T.)

	If mv_par30 == 1 .And. Len( aSelFil ) <= 0 .And. !IsBlind()
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf

	wnrel	:= "CABA234"            //Nome Default do relatorio em Disco
	wnrel := SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

Endif
/*
If wnRel == "CABA234B"
	If mv_par30 == 1 .And. Len( aSelFil ) <= 0 .And. !IsBlind()
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
Endif
*/

 	If nLastKey == 27
		Set Filter To
		Return
	Endif

// //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// //³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
// //³ Gerencial -> montagem especifica para impressao)		     ³
// //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	If !ct040Valid(mv_par06)
		lRet := .F.
			Else
  			aSetOfBook := CTBSetOf(mv_par06)
	Endif

	If mv_par20 == 2			// Divide por cem
		nDivide := 100
			ElseIf mv_par20 == 3		// Divide por mil
			nDivide := 1000
				ElseIf mv_par20 == 4		// Divide por milhao
				nDivide := 1000000
	EndIf

	If lRet
		aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
			If Empty(aCtbMoeda[1])
      		Help(" ",1,"NOMOEDA")
      			lRet := .F.
   			Endif
	Endif

	If lRet
		If (mv_par25 == 1) .and. ( Empty(mv_par26) .or. Empty(mv_par27) )
			cMensagem	:= "Favor preencher os parametros Grupos Receitas/Despesas e "
			cMensagem	+= "Data Sld Ant. Receitas/Desp. "
			MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des")
			lRet    	:= .F.
    	EndIf
	EndIf

	If !lRet
		Set Filter To
		Return
	EndIf


	If nLastKey == 27
		Set Filter To
		Return
	Endif


	Processa({||Caba234Bb(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lExterno,cTitorig)})

	MsgAlert("Arquivo salvo com sucesso!")
	// RptStatus({|lEnd| Caba234Bb(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lExterno,cTitorig)})

	// Close(_oGeraTxt)
Return

// /*/
// ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
// ±±³Program   ³CTR040IMP ³ Autor ³ Ramon de Almeida N.   ³ Data ³ 24.07.00 ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Descri‡…o ³ Imprime relatorio -> Balancete Verificacao Modelo 1        ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Sintaxe   ³CTR040Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda)          ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Retorno   ³ Nenhum                                                     ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Uso       ³ Generico                                                   ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Parametros³ lEnd       - A‡ao do Codeblock                             ³±±
// ±±³          ³ WnRel      - T¡tulo do relat¢rio                           ³±±
// ±±³          ³ cString    - Mensagem                                      ³±±
// ±±³          ³ aSetOfBook - Matriz ref. Config. Relatorio                 ³±±
// ±±³          ³ aCtbMoeda  - Matriz ref. a moeda                           ³±±
// ±±³          ³ nDivide    - Valor para divisao de valores                 ³±±
// ±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
// /*/
static Function Caba234Bb(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lExterno,cTitOrig)

	Local aColunas		:= {}
// LOCAL CbTxt			:= Space(10)
// Local CbCont		:= 0
	LOCAL limite		:= 132
	Local cabec1   	:= ""
// Local cabec2   	:= ""
	Local cSeparador	:= ""
	Local cPicture
	Local cDescMoeda
// Local cCodMasc
	Local cMascara
	Local cGrupo		:= ""
	Local cArqTmp
	Local dDataFim 	:= mv_par02
// Local lFirstPage	:= .T.
// Local lJaPulou		:= .F.
// Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
// Local lPula			:= Iif(mv_par17==1,.T.,.F.)
// Local lNormal		:= Iif(mv_par19==1,.T.,.F.)
	Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.)
	Local l132			:= .T.
	Local nDecimais
// Local nTotDeb		:= 0
// Local nTotCrd		:= 0
// Local nTotMov		:= 0
// Local nGrpDeb		:= 0
// Local nGrpCrd		:= 0
	Local cSegAte   	:= mv_par21
	Local nDigitAte	:= 0
	Local lImpAntLP	:= Iif(mv_par22 == 1,.T.,.F.)
	Local dDataLP		:= mv_par23
	Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
	Local lRecDesp0		:= Iif(mv_par25==1,.T.,.F.)
	Local cRecDesp		:= mv_par26
	Local dDtZeraRD		:= mv_par27
// Local n
	Local oMeter
	Local oText
	Local oDlg
	Local lImpPaisgm	:= .F.
// Local nMaxLin   	:= iif( mv_par28 > 58 , 58 , mv_par28 )
	Local cMoedaDsc		:= mv_par29
	Local nMasc			:= 0
	Local cMasc			:= ""
	Local dDataOld 		:= MsDate()
	Private _cEOL   := &("CHR(13)+CHR(10)")

	cDescMoeda 	:= Alltrim(aCtbMoeda[2])

	nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

		if lExterno // Chamado THZFJJ - Se não for chado por outro relatorio trocar a data
			dDataBase := dDataFim
		endif

		If Empty(aSetOfBook[2])
			cMascara := GetMv("MV_MASCARA")
				Else
				cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
		EndIf

	cPicture 		:= aSetOfBook[4]

		If mv_par16 == 2 .And. !lExterno .And. 	aReturn[4] == 2	//Se nao imprime coluna mov. e eh paisagem
			lImpPaisgm	:= .T.
			limite		:= 220
		EndIf

// //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// //³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
// //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Upper(Alltrim(Titulo)) == Upper(Alltrim(cTitorig)) // Se o titulo do relatorio nao foi alterado pelo usuario
			IF mv_par05 == 1
			Titulo:=	"BALANCETE DE VERIFICACAO SINTETICO DE "
				ElseIf mv_par05 == 2
				Titulo:=	"BALANCETE DE VERIFICACAO ANALITICO DE "
					ElseIf mv_par05 == 3
					Titulo:=	"BALANCETE DE VERIFICACAO DE "
			EndIf
		EndIf

		If cPaisLoc == 'RUS'
			Titulo += 	", " + AllTrim("TEXTO PARA SUBSTITUIR") + " " + DTOC(mv_par01) + " " + AllTrim("TEXTO PARA SUBSTITUIR") + " " + Dtoc(mv_par02) + ", " +;
			AllTrim("TEXTO PARA SUBSTITUIR") + " " + cDescMoeda + " " + CtbTitSaldo(mv_par10)
				Else
				Titulo += DTOC(mv_par01) + " " + AllTrim("TEXTO PARA SUBSTITUIR") + " " + Dtoc(mv_par02) + ", " +;
				AllTrim("TEXTO PARA SUBSTITUIR") + " " + cDescMoeda + " " + CtbTitSaldo(mv_par10)
		EndIf

		If nDivide > 1
			Titulo += " (" + "TEXTO PARA SUBSTITUIR" + Alltrim(Str(nDivide)) + ")"
		EndIf

		If mv_par16 == 1 .And. ! lExterno		// Se imprime saldo movimento do periodo
			cabec1 := "|  CODIGO              |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |    DEBITO     |    CREDITO   | MOVIMENTO DO PERIODO |   SALDO ATUAL    |"
			tamanho := "G"
			limite	:= 220
			l132	:= .F.
				Else

			If lImpPaisgm		//Se imprime em formato paisagem
				cabec1 := "|  CODIGO                     |      D E S C R I C A O                          |        SALDO ANTERIOR             |           DEBITO             |            CREDITO                |         SALDO ATUAL               |"
					Else
					cabec1 := "|  CODIGO               |   D  E  S  C  R  I  C  A  O    |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"
			EndIf
		Endif

		If ! lExterno
			SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))
		Endif

		If l132
			If lImpPaisgm
			aColunas := { 000,001, 030, 032, 080,086, 116, 118, 147, 151, 183, , ,187,219}
				Else
				aColunas := { 000,001, 024, 025, 057,058, 077, 078, 094, 095, 111, , , 112, 131 }
			EndIf
				Else
					aColunas := { 000,001, 030, 032, 080,082, 112, 114, 131, 133, 151, 153, 183,185,219}
		Endif

		If !lExterno
			m_pag := mv_par09
		Endif

// //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// //³ Monta Arquivo Temporario para Impressao							  ³
// //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lExterno  .or. IsBlind()
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
			mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
			.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,"",lRecDesp0,;
			cRecDesp,dDtZeraRD,,,,,,,cMoedaDsc,,aSelFil)
				Else
					MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
					mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
					mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
					.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,"",lRecDesp0,;
					cRecDesp,dDtZeraRD,,,,,,,cMoedaDsc,,aSelFil)},;
					"Criando Arquivo Temporário...",;  //"Criando Arquivo Temporario..."
					"Balancete Verificacao")
		EndIf

// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
	//Efetua tratamento da mascara para consegui efetuar o controle do segmento
		For nMasc := 1 to Len( cMascara )
			cMasc += SubStr( cMascara,nMasc,1 )
		Next nMasc
			nDigitAte := CtbRelDig(cSegAte,cMasc)
		EndIf

	_cLin := "Conta Contábil; Descrição/Nome da Conta; Saldo Anterior; Débitos; Crédito; Saldo Final"
	_cLin += _cEOL

// grava linha no TXT
	If fWrite(_nHdl,_cLin,Len(_cLin)) != Len(_cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Return
		Endif
	Endif

	dbSelectArea("cArqTmp")
	dbGoTop()

	ProcRegua(RecCount())

	cGrupo := GRUPO

	While !Eof()
		If lEnd
			@Prow()+1,0 PSAY "***** CANCELADO PELO OPERADOR *****"
				Exit
		EndIF

		IncProc()

	******************** FILTRAGEM PARA IMPRESSAO *************************

	//Se desconsiderar saldo anterior de contas de receita e despesas e não imprimir zeros

		If lRecDesp0 .And. !lVlrZerado
		//Se não houver saldo na conta não imprimir a mesma, caso o saldo anterior seja desconsiderado lRecDesp0 (mv_par25)
			If SALDOANT == 0 .And. SALDODEB == 0  .And. SALDOCRD == 0 .And. SALDOATU  == 0
				dbSkip()
				Loop
			EndIf
		EndIf

		If mv_par05 == 1					// So imprime Sinteticas
			If TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
				ElseIf mv_par05 == 2				// So imprime Analiticas
					If TIPOCONTA == "1"
						dbSkip()
						Loop
					EndIf
			EndIf

	//Filtragem ate o Segmento ( antigo nivel do SIGACON)
	If !Empty(cSegAte)
		If Len(Alltrim(CONTA)) > nDigitAte
			dbSkip()
			Loop
		Endif
	EndIf


	cConta:=AllTrim(("cArqTmp")->CONTA)
	cDescConta:=AllTrim(("cArqTmp")->DESCCTA)
	nSalAnt:=("cArqTmp")->SALDOANT
	nSalDeb:=("cArqTmp")->SALDODEB
	nSalCrd:=("cArqTmp")->SALDOCRD
	nSalAtu:=("cArqTmp")->SALDOATU

// Conta Contábil; Descrição/Nome da Conta; Saldo Anterior; Débitos; Crédito; Saldo Final

If !(SubStr(cConta, 1, 1) $ "1/4/6")
	_cLin := cConta+";"+ cDescConta+";"+StrTran(cValToChar(nSalAnt),".",",")
	_cLin +=";"+StrTran(cValToChar(nSalDeb),".",",")
	_cLin +=";"+StrTran(cValToChar(nSalCrd),".",",")
	_cLin += ";"+StrTran(cValToChar(nSalAtu),".",",")
	_cLin += _cEOL
else
	_cLin := cConta+";"+ cDescConta+";"+StrTran(cValToChar(nSalAnt*-1),".",",")
	_cLin +=";"+StrTran(cValToChar(nSalDeb),".",",")
	_cLin +=";"+StrTran(cValToChar(nSalCrd),".",",")
	_cLin += ";"+StrTran(cValToChar(nSalAtu*-1),".",",")
	_cLin += _cEOL
Endif


	// grava linha no TXT
	If fWrite(_nHdl,_cLin,Len(_cLin)) != Len(_cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Return
		Endif
	Endif

	************************* ROTINA DE IMPRESSAO *************************
	/*
	If mv_par11 == 1 							// Grupo Diferente - Totaliza e Quebra
		If cGrupo != GRUPO
			@li,00 PSAY REPLICATE("-",limite)
			li+=2
			@li,00 PSAY REPLICATE("-",limite)
			li++
			@li,aColunas[COL_SEPARA1] PSAY "|"
			@li,39 PSAY "T O T A I S  D O  G R U P O: " + cGrupo + ") : "  
			@li,aColunas[COL_SEPARA4] PSAY "|"
			ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
			@li,aColunas[COL_SEPARA5] PSAY "|"
			ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
			@li,aColunas[COL_SEPARA6] PSAY "|"
			@li,aColunas[COL_SEPARA8] PSAY "|"
			li++
			li		:= 60
			cGrupo	:= GRUPO
			nGrpDeb	:= 0
			nGrpCrd	:= 0
		EndIf

	ElseIf  mv_par11 == 2
		If NIVEL1				// Sintetica de 1o. grupo
			li := 60
		EndIf
	EndIf

	IF li > nMaxLin
		If !lFirstPage
			@Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho,,dDataOld)
		lFirstPage := .F.
	EndIf

	@ li,aColunas[COL_SEPARA1] 		PSAY "|"
	If lNormal
		If TIPOCONTA == "2" 		// Analitica -> Desloca 2 posicoes
			If l132
				EntidadeCTB(CONTA,li,aColunas[COL_CONTA]+2,21,.F.,cMascara,cSeparador)
			Else
				EntidadeCTB(CONTA,li,aColunas[COL_CONTA]+2,27,.F.,cMascara,cSeparador)
			EndIf
		Else
			If l132
				EntidadeCTB(CONTA,li,aColunas[COL_CONTA],23,.F.,cMascara,cSeparador)
			Else
				EntidadeCTB(CONTA,li,aColunas[COL_CONTA],29,.F.,cMascara,cSeparador)
			EndIf
		EndIf
	Else
		If TIPOCONTA == "2"		// Analitica -> Desloca 2 posicoes
			@li,aColunas[COL_CONTA] PSAY Alltrim(CTARES)
		Else
			@li,aColunas[COL_CONTA] PSAY Alltrim(CONTA)
		EndIf
	EndIf

	@ li,aColunas[COL_SEPARA2] 		PSAY "|"

	If !l132
		@ li,aColunas[COL_DESCRICAO] 	PSAY Substr(DESCCTA,1,48)
	Else
		@ li,aColunas[COL_DESCRICAO] 	PSAY Substr(DESCCTA,1,30)
	Endif

	@ li,aColunas[COL_SEPARA3]		PSAY "|"
	ValorCTB(SALDOANT,li,aColunas[COL_SALDO_ANT],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)

	@ li,aColunas[COL_SEPARA4]		PSAY "|"
	ValorCTB(SALDODEB,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)

	@ li,aColunas[COL_SEPARA5]		PSAY "|"
	ValorCTB(SALDOCRD,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,NORMAL, , , , , ,lPrintZero)
	
	@ li,aColunas[COL_SEPARA6]		PSAY "|"

	If !l132
		ValorCTB(MOVIMENTO,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA7] PSAY "|"	
	Endif
	ValorCTB(SALDOATU,li,aColunas[COL_SALDO_ATU],17,nDecimais,.T.,cPicture,NORMAL, , , , , ,lPrintZero)

	@ li,aColunas[COL_SEPARA8] PSAY "|"

	lJaPulou := .F.

	If lPula .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
		li++
		@ li,aColunas[COL_SEPARA1] PSAY "|"
		@ li,aColunas[COL_SEPARA2] PSAY "|"
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		@ li,aColunas[COL_SEPARA4] PSAY "|"
		@ li,aColunas[COL_SEPARA5] PSAY "|"
		@ li,aColunas[COL_SEPARA6] PSAY "|"
		If !l132
			@ li,aColunas[COL_SEPARA7] PSAY "|"
			@ li,aColunas[COL_SEPARA8] PSAY "|"
		Else
			@ li,aColunas[COL_SEPARA8] PSAY "|"
		EndIf
		li++
		lJaPulou := .T.
	Else
		li++
	EndIf

	************************* FIM   DA  IMPRESSAO *************************

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If TIPOCONTA == "1"
			If NIVEL1
				nTotDeb += SALDODEB
				nTotCrd += SALDOCRD
				nGrpDeb += SALDODEB
				nGrpCrd += SALDOCRD
			EndIf
		EndIf
	Else									// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If TIPOCONTA == "2"
				nTotDeb += SALDODEB
				nTotCrd += SALDOCRD
				nGrpDeb += SALDODEB
				nGrpCrd += SALDOCRD
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If TIPOCONTA == "1"
				If NIVEL1
					nTotDeb += SALDODEB
					nTotCrd += SALDOCRD
					nGrpDeb += SALDODEB
					nGrpCrd += SALDOCRD
				EndIf
			EndIf
    	Endif
	EndIf*/


		dbSkip()

	EndDO

/*
// //IF li != 80 .And. !lEnd
IF li <= 58 .OR. li >= 58 .And. !lEnd
	IF li > nMaxLin
		@Prow()+1,00 PSAY	Replicate("-",limite)
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho,,dDataOld)
		li++
	Endif
	If mv_par11 == 1							// Grupo Diferente - Totaliza e Quebra
		If cGrupo != GRUPO .Or. Eof()
			@li,00 PSAY REPLICATE("-",limite)
			li++
			@li,aColunas[COL_SEPARA1] PSAY "|"
			@li,39 PSAY "T O T A I S  D O  G R U P O: " + cGrupo + ") : " 
			@li,aColunas[COL_SEPARA4] PSAY "|"
			ValorCTB(nGrpDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
			@li,aColunas[COL_SEPARA5] PSAY "|"
			ValorCTB(nGrpCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
			@li,aColunas[COL_SEPARA6] PSAY "|"
			If !l132
				nTotMov := nTotMov + (nGrpCrd - nGrpDeb)
				If Round(NoRound(nTotMov,3),2) < 0
					ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
				ElseIf Round(NoRound(nTotMov,3),2) > 0
					ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
                EndIf
				@ li,aColunas[COL_SEPARA7] PSAY "|"
			Endif
			@li,aColunas[COL_SEPARA8] PSAY "|"
			li++
			@li,00 PSAY REPLICATE("-",limite)
			li+=2
		EndIf
	EndIf

	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,aColunas[COL_SEPARA1] PSAY "|"
	@li,39 PSAY "T O T A I S  D O  M E S : "
	@li,aColunas[COL_SEPARA4] PSAY "|"
	ValorCTB(nTotDeb,li,aColunas[COL_VLR_DEBITO],16,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero)
	@li,aColunas[COL_SEPARA5] PSAY "|"
	ValorCTB(nTotCrd,li,aColunas[COL_VLR_CREDITO],16,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero)
	@li,aColunas[COL_SEPARA6] PSAY "|"
 	If !l132
		nTotMov := nTotMov + (nTotCrd - nTotDeb)
		If Round(NoRound(nTotMov,3),2) < 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero)
		ElseIf Round(NoRound(nTotMov,3),2) > 0
			ValorCTB(nTotMov,li,aColunas[COL_MOVIMENTO],17,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero)
		EndIf
		@li,aColunas[COL_SEPARA7] PSAY "|"
	EndIf
	@li,aColunas[COL_SEPARA8] PSAY "|"
	li++
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,0 PSAY " "

	IF lExterno
		If (li + 3) < 60
			@57,00 PSAY __PrtfatLine()
  		  	@58,01 Psay "Microsiga Software S/A" 
 		   	If Tamanho == "M"
   		 		@58,100 Psay "Hora Término" + " " + Time()      
   	 		ElseIf Tamanho == "G"
	   		 	@58,190 Psay "Hora Término: " + " "+ Time()
    		Else
	    		@58,050 Psay "Hora Término" + " "+ Time()	  
			EndIf
			@59,00 PSAY __PrtfatLine()
		EndIf
	Endif
	Set Filter To
EndIF


If mv_par24 ==1
	ImpQuadro(Tamanho,X3USO("CT2_DCD"),dDataFim,mv_par08,aQuadro,cDescMoeda,nomeprog,(If (lImpAntLP,dDataLP,cTod(""))),cPicture,nDecimais,lPrintZero,mv_par10)
EndIf

If aReturn[5] = 1 .And. ! lExterno
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf
*/


	dbSelectArea("cArqTmp")
		Set Filter To
	dbCloseArea()
	If Select("cArqTmp") == 0
		FErase(cArqTmp+GetDBExtension())
		FErase(cArqTmp+OrdBagExt())
	EndIF

	dbselectArea("CT2")

	If ! lExterno
		MS_FLUSH()
	Endif

	dDataBase := dDataOld

Return .T.

// /*/
// ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
// ±±³Programa  ³CT040Valid³ Autor ³ Ramon de Almeida N.   ³ Data ³ 24.07.00 ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Descri‡…o ³ Valida Perguntas                                           ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Sintaxe   ³Ct040Valid(cSetOfBook)                                      ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Retorno   ³ .T./.F.                                                    ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Uso       ³ Generico                                                   ³±±
// ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
// ±±³Parametros³ ExpC1 = Codigo da Config. Relatorio                        ³±±
// ±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
// /*/
static Function Ca234Cc(cSetOfBook)

	Local aSaveArea:= GetArea()
	Local lRet		:= .T.

	If !Empty(cSetOfBook)
		dbSelectArea("CTN")
		dbSetOrder(1)
			If !dbSeek(xfilial()+cSetOfBook)
				aSetOfBook := ("","",0,"","")
				Help(" ",1,"NOSETOF")
				lRet := .F.
			EndIf
	EndIf

	RestArea(aSaveArea)

Return lRet


// /*
// ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
// ±±ºPrograma  ³ CTR040MAXL ºAutor ³ Eduardo Nunes Cirqueira º Data ³  31/01/07 º±±
// ±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
// ±±ºDesc.     ³ Baseado no parametro MV_PAR28 ("Num.linhas p/ o Balancete      º±±
// ±±º          ³ Modelo 1"), cujo conteudo esta na variavel "nMaxLin", controla º±±
// ±±º          ³ a quebra de pagina no TReport                                  º±±
// ±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
// ±±ºUso       ³ AP                                                             º±±
// ±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
// */
Static Function CAB234MxLn(nMaxLin,nLinReport)

	nLinReport++

	If nLinReport > nMaxLin
		oReport:EndPage()
		nLinReport := 10
	EndIf

Return Nil


// /*
// ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
// ±±ºPrograma  ³ nCtCGCCabTR  º Autor ³ Fabio Jadao Caires      º Data ³ 31/01/07º±±
// ±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
// ±±ºDesc.     ³ Chama a funcao padrao CtCGCCabTR reiniciando o contador de      º±±
// ±±º          ³ linhas para o controle do relatorio.                            º±±
// ±±º          ³                                                                 º±±
// ±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
// ±±ºUso       ³ AP                                                              º±±
// ±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
// ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
// */
STATIC FUNCTION CABA234AaBbCc(dDataFim,titulo,oReport,dDataRef)
	Local dDataold		:= Ctod("//")
	Local cTexto		:= ""

	Default dDataRef	:= dDataBase

	nLinReport := 10
	oReport:SetPageNumber(n_pagini)

	oReport:OnPageBreak({|| n_pagini += 1})
	nLinReport := 10

	dDataOld := dDataBase
	dDataBase := dDataRef

	cTexto := CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport,,,,,,,,,,MV_PAR01)
	dDataBase := dDataOld
	Return(cTexto)
Return
