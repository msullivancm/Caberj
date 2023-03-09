#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³IMPETICAR³ Autor ³ Jean Schulz            ³ Data ³ 16.04.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de etiquetas para propostas.                     ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR038()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IMPETICAR(aArray,nColunas)

Private nQtdLin     := 55
Private cNomeProg   := "PLR038"
//Private nLimite     := 132
//Private cTamanho    := "G"
Private cTitulo     := "Etiquetas"
Private cDesc1      := "Etiquetas"
Private cDesc2      := ""
Private cDesc3      := ""
Private cAlias      := "BA1"
Private cPerg       := "ABCDE"
Private cRel        := "IMPETI"
Private nLi         := nQtdLin+1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .T.
Private lCrystal    := .F.
Private aOrderns    := {}
//Private aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private cCabec1 	:= ""
Private cCabec2 	:= ""
Private dData1
Private dData2


Private cTamanho := "P"				   	// P/M/G
Private nLimite  := 80  //132 //220	    		// 80/132/220
Private nTipo   := 18
Private aReturn := { "Zebrado",;	    	//[1] Reservado para Formulario
1,;		   		//[2] Reservado para N§ de Vias
"Administração",;	//[3] Destinatario
2,;			   	//[4] Formato => 1-Comprimido 2-Normal
1,;	    	   	//[5] Midia   => 1-Disco 2-Impressora
1,;			   	//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
"",;			   	//[7] Expressao do Filtro
1 } 			   	//[8] Ordem a ser selecionada
//				[9]..[10]..[n]    //Campos a Processar (se houver)

Private nLastKey:= 0	// Controla o cancelamento da SetPrint e SetDefault
Private nFormat := 1    //
Private nNumCol := 0
Private cTipImp := 1
Private nPosCol := 1

If nColunas > 2			// Matriculas digitadas
	Tamanho := "M"		// P/M/G
	Limite  := 132      // 80/132/220
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

If (nLastKey == 27)
	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

aReturn[4] := 2

SetDefault(aReturn,cAlias)

If (nLastKey == 27)
	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| RImpepr(aArray,nColunas) }, cTitulo, "", .T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ RImpepr  ³ Autor ³ Jean Schulz           ³ Data ³ 22.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Emite relatorio de Carteirinhas Emitidas                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function RImpepr(aCarta,nColunas)

Local cLinha	:= ""
Local cDesCom	:= ""
Local cDesPer1	:= ""
Local cDesPer2	:= ""
Local cSql		:= ""
Local cArqTmp	:= ""
Local cIndTmp	:= ""
Local cEmpAnt	:= ""
Local cEstCob   := ""
Local nCont		:= 0
Local nI		:= 0
Local nPos		:= 0
Local nTotal	:= 0
Local nJ		:= 0
Local nTotLin	:= 0
Local nLin		:= 0
Local aResp		:= {}
Local aLin		:= {}
Local aResumo	:= {}
Local cConAnt   := ""
Local cSubAnt   := ""
Local nTotSub   := 0
Local nCont		:= 0

//Legenda aCarta
//1-Matricula completa BA1 (Titular)
//2-Nome usuario BA1 (Titular)
//3-Matricula completa BA1 (Dependente 24 anos)
//4-Nome Usuario BA1 (Dependente 24 anos)
//5-Nome do produto reduzido.
//6-Descricao Grau de parentesco.
//7-Data de nascimento.
//8-Data composta.
//9-Data de bloqueio
//10-Endereco de cobranca
//11-Bairro de cobranca
//12-Cidade de cobranca
//13-UF cobranca
//14-Cep cobranca
//15-Cod.Cliente
//16-Loja cliente
//17-Cod. Plano Sugerido
//18-Versao Plano Sugerido
//19-Descricao Plano Sugerido
//20-Cod Emp. Destino
//21-Contrato Emp. destino
//22-Versao Contrato emp. Destino
//23-SubContr. Empr. Destino
//24-Versao Subcontr. Empr. Destino


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//setPrc( pRow(),pCol())
If nColunas > 2							// Matriculas digitadas
	@ pRow(),pCol() Psay AvalImp(132)
Else
	@ pRow(),pCol() Psay AvalImp(80)
EndIf
//If cTipImp = 2
//	nLin := pRow() + 2
//EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to Len(aCarta)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		nCont := Len(aCarta)
	Endif
	
	If !Empty(aCarta[nCont,17]) .And. aCarta[nCont,25] == "1"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Corpo do Boleto								    		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ColIni := 0
		nI := 1
		nJ := 0
		aLin := Array(5,nColunas)
	
		While nI <= nColunas
		
			If Empty(aCarta[nCont,17]) .Or. aCarta[nCont,25] <> "1"
				nCont++
				If nCont > Len(aCarta)
					Exit
				Endif
				Loop
			Endif
		
			aLin[1,nI]:= Substr(("CODIGO : " +Transform(aCarta[nCont,1],"@R !!!!.!!!!.!!!!!!.!!-!")),1,42)
			aLin[2,nI]:= Substr(aCarta[nCont,2],1,42)
			aLin[3,nI]:= Substr(Alltrim(aCarta[nCont,10]),1,36)
			aLin[4,nI]:= Substr(AllTrim(aCarta[nCont,11])+" - "+ AllTrim(aCarta[nCont,12]),1,42)
			aLin[5,nI]:= Substr(aCarta[nCont,13]+"  CEP:"+Transform(aCarta[nCont,14],"@R !!!!!-!!!"),1,42)
			
			//Caso nI == nColunas, somar somente no For anterior...
			If nI <> nColunas
				nCont++
			Endif
			
			nI++
	
			If nCont > Len(aCarta)
				nI := nColunas + 1
			Endif
			
		EndDo
	
		nI:= 0
		
		For nJ := 1 to 5
			For nI := 1 TO nColunas
				ColIni := (nI-1) * 45
				@ nLin,ColIni PSAY aLin[nJ,nI]
			Next
			nLin += 1
		Next
		nLin += 1
		
		If nTotLin = 10
			nTotLin := 0
			eject
		Else
			nTotLin++
		Endif

		
	Endif
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
Endif

Return
