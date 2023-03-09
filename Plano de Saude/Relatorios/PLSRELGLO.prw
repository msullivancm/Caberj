#include "RWMAKE.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PlsRelGloº Autor ³ Thiago Machado Correa º Data ³ 12/04/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Glosas										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R.R. Consultoria                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PlsRelGlo()

Local cPerg := "PLSY99"
Private oLeTxt

AjustaSX1(cPerg)

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Relatório de Glosas")
@ 02,10 TO 65,180
@ 10,018 Say " Este relatório tem como objetivo listar Contas Médicas que"
@ 18,018 Say " possuam valor de glosa agrupadas por Rda."
@ 26,018 Say " "

@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,128 BMPBUTTON TYPE 01 ACTION Processa1(cPerg)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Processa1  ³ Autor ³ Thiago Machado Correa ³Data³ 12/04/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Executa funcao principal							  		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cNomeProg   := "PLSRELGLO"
PRIVATE nQtdLin     := 75
PRIVATE nLimite     := 220
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatório de Glosas x Rda"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD6"
PRIVATE nRel        := "PLSRELGLO"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Conta Médica            Código do Usuário      Nome do Usuário                                     Empresa                                                    Produto"
PRIVATE cCabec2     := "Código       Descrição do Procedimento                           Data          Quantidade Vlr Apresentado    Vlr Glosado  %Glosa        Vlr Pago  Descrição da Glosa"
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0

nRel := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| ImpRel(cPerg)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
EndIf

Close(oLeTxt)

Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ ImpRel   ³ Autor ³ Thiago Machado Correa ³ Data ³ 12.04.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRel(cPerg)

Local cCodOpe := ""
Local cRdaIni := ""
Local cRdaFim := ""
Local cLdpIni := ""
Local cLdpFim := ""
Local cPegIni := ""
Local cPegFim := ""
Local cNumIni := ""
Local cNumFim := ""
Local cCmpIni := ""
Local cCmpFim := ""
Local cEmpIni := ""
Local cEmpFim := ""
Local cFamIni := ""
Local cFamFim := ""
Local cTabIni := ""
Local cTabFim := ""
Local cProIni := ""
Local cProFim := ""
Local nFase   := 0
Local nTipImp := 0
Local nImprim := 0
Local nTot    := 0
Local nTotQtd := 0
Local nTotPag := 0
Local nTotGlo := 0
Local nTotApr := 0
Local nQtdTot := 0
Local nPagTot := 0
Local nGloTot := 0
Local nAprTot := 0
Local nGuiQtd := 0
Local nGuiPag := 0
Local nGuiGlo := 0
Local nGuiApr := 0
Local cSQL    := ""      
Local cCodRda := ""
Local cChaGui := ""
Local cDesRda := ""
Local lIntern := .F.
Local lImpCab := .F.
Local cTabBD6 := RetSQLName("BD6") 
Local cGloDe  := ""
Local cGloAte := ""

Local nVlrDe  := 0
Local nVlrAte := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

cCodOpe := mv_par01
cRdaIni := mv_par02
cRdaFim := mv_par03
cLdpIni := mv_par04
cLdpFim := mv_par05
cPegIni := mv_par06
cPegFim := mv_par07
cNumIni := mv_par08
cNumFim := mv_par09
cCmpIni := mv_par10
cCmpFim := mv_par11
cEmpIni := mv_par12
cEmpFim := mv_par13
cFamIni := mv_par14
cFamFim := mv_par15
cTabIni := mv_par16
cTabFim := mv_par17
cProIni := mv_par18
cProFim := mv_par19
nFase   := mv_par20
nTipImp := mv_par21
nImprim := mv_par22
cGloDe  := mv_par23
cGloAte := mv_par24
nVlrDe  := mv_par25
nVlrAte := mv_par26

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena arquivos...                                       				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BG9->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BDX->(DbSetOrder(2))
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BCT->(DbSetOrder(1))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Redefine Cabecalho...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipImp == 1
	cCabec1 := "Código  Nome da Rda                                   Quantidade Vlr Apresentado     Vlr Glosado        Vlr Pago"
	cCabec2 := ""
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODRDA, BD6_NOMRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD6_CODEMP, BD6_CODPLA, BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, BD6_QTDPRO, BD6_QTDAPR, BD6_VLRAPR, BD6_VLRGLO, BD6_VLRPAG, BD6_TIPGUI,BD6_DATPRO,BD6_HORPRO  FROM " + cTabBD6
cSQL += " WHERE BD6_FILIAL='"+xFilial("BD6")+"' AND BD6_CODOPE='"+cCodOpe+"'"
cSQL +=   " AND BD6_CODLDP>='"+cLdpIni+"' AND BD6_CODLDP<='"+cLdpFim+"'"
cSQL +=   " AND BD6_CODPEG>='"+cPegIni+"' AND BD6_CODPEG<='"+cPegFim+"'"
cSQL +=   " AND BD6_NUMERO>='"+cNumIni+"' AND BD6_NUMERO<='"+cNumFim+"'"
cSQL +=   " AND BD6_CODRDA>='"+cRdaIni+"' AND BD6_CODRDA<='"+cRdaFim+"'"
cSQL +=   " AND BD6_ANOPAG||BD6_MESPAG>='"+substr(cCmpIni,3,4)+substr(cCmpIni,1,2)+"' AND BD6_ANOPAG||BD6_MESPAG<='"+substr(cCmpFim,3,4)+substr(cCmpFim,1,2)+"'"
cSQL +=   " AND BD6_CODEMP>='"+cEmpIni+"' AND BD6_CODEMP<='"+cEmpFim+"'"
cSQL +=   " AND BD6_MATRIC>='"+cFamIni+"' AND BD6_MATRIC<='"+cFamFim+"'"
cSQL +=   " AND BD6_CODPAD>='"+cTabIni+"' AND BD6_CODPAD<='"+cTabFim+"'"
cSQL +=   " AND BD6_CODPRO>='"+cProIni+"' AND BD6_CODPRO<='"+cProFim+"'"

Do Case
	Case nFase == 1
		cSQL +=   " AND BD6_FASE = '3'"
	Case nFase == 2
		cSQL +=   " AND BD6_FASE = '4'"
	Case nFase == 3
		cSQL +=   " AND BD6_FASE IN ('3','4')"
	Case nFase == 4
		cSQL +=   " AND BD6_FASE = '2'"
EndCase
	
cSQL +=   " AND BD6_SITUAC='1' " 
//cSQL +=   " AND BD6_VLRGLO BETWEEN "+nVlrDe+" AND "+nVlrAt+" "
cSQL +=   " AND D_E_L_E_T_=' ' "

cSQL +=   " ORDER BY BD6_CODRDA, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN"

MemoWrite("C:\MICROSIGA\PLSRELGLO.TXT",cSQL)

PLSQuery(cSQL,"TRB")

While ! TRB->(Eof())
	nTot++       
	TRB->(DbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seta Regua...															 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(nTot)

TRB->(DbGoTop())

While ! TRB->(Eof())

	nTotQtd := 0
	nTotPag := 0
	nTotGlo := 0
	nTotApr := 0
	cCodRda := TRB->BD6_CODRDA
	cDesRda := TRB->BD6_NOMRDA
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ignora de acordo com parametros de/para por valor de glosa.		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->BD6_VLRGLO < nVlrDe .Or. TRB->BD6_VLRGLO >nVlrAte
		TRB->(DbSkip())
		Loop	
	Endif
	
	If nTipImp <> 1

		If nLin+2 > nQtdLin
			Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
			nLin := 9
		Endif

		@nLin,nColuna PSAY "Rda: " + TRB->BD6_CODRDA + " - " + TRB->BD6_NOMRDA
		nLin++
		@nLin,nColuna PSAY replicate("-",nLimite)
		nLin++
		nLin++

	Endif

	While TRB->BD6_CODRDA == cCodRda .and. ! TRB->(Eof())
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ignora de acordo com parametros de/para por valor de glosa.		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->BD6_VLRGLO < nVlrDe .Or. TRB->BD6_VLRGLO >nVlrAte
			TRB->(DbSkip())
			Loop	
		Endif
			
		nGuiQtd := 0
		nGuiPag := 0
		nGuiGlo := 0
		nGuiApr := 0
		lImpCab := .F.
		cChaGui := TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)

		While TRB->BD6_CODRDA == cCodRda .and. TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == cChaGui .and. ! TRB->(Eof())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Ignora de acordo com parametros de/para por valor de glosa.		  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRB->BD6_VLRGLO < nVlrDe .Or. TRB->BD6_VLRGLO >nVlrAte
				TRB->(DbSkip())
				Loop	
			Endif
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se foi abortada a impressao...                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Interrupcao(lAbortPrint)
				nLin ++
				@ nLin, nColuna pSay "Relatório cancelado pelo usuário."
				Exit
			Endif
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exibe mensagem...                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Processando...")
			
			BDX->(MsSeek(xFilial("BDX")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)))
			If BDX->BDX_CODGLO < cGloDe .Or. BDX->BDX_CODGLO > cGloAte
					TRB->(DbSkip())
					Loop				
			Endif			
				
			If nImprim <> 3
				
				//Verifica se usuario esta internado
				If TRB->BD6_TIPGUI == "03"   
					lIntern := .T.
				Else
					lIntern := PLSUSRINTE(TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),TRB->BD6_DATPRO,TRB->BD6_HORPRO,.F.,.F.,"BD5")
					
					//--------------------------------------------------------------------
					//Angelo Henrique - Data:02/07/2019
					//--------------------------------------------------------------------
					//A rotina PLSUSRINTE em algunmas situações retorna um vetor
					//--------------------------------------------------------------------					
					If Valtype(lIntern) == "A"
					
						If Len(lIntern) > 0
							lIntern := lIntern[1]
						EndIf
					
					EndIf
					//--------------------------------------------------------------------
					
				Endif                               
						
				//Verifica se descarta registro
				Do Case
					Case nImprim == 1 .and. ! lIntern
						TRB->(DbSkip())
						Loop
					Case nImprim == 2 .and. lIntern
						TRB->(DbSkip())
						Loop
				EndCase		
				
			Endif
			
			If nLin > nQtdLin
				Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
				nLin := 9
			Endif
		
			If nTipImp <> 1
			
				//Posiciona Tabelas
				BG9->(MsSeek(xFilial("BG9")+TRB->(BD6_CODOPE+BD6_CODEMP)))
				BA1->(MsSeek(xFilial("BA1")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
				BA3->(MsSeek(xFilial("BA3")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)))
			
				If TRB->BD6_TIPGUI == "03"   
					BE4->(MsSeek(xFilial("BE4")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
				Else
					BD5->(MsSeek(xFilial("BD5")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
				Endif
				
				If ! BI3->(MsSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
					BI3->(MsSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
				Endif
		
				If ! lImpCab
					
					@nLin,nColuna PSAY TRB->BD6_CODLDP+"."+TRB->BD6_CODPEG+"."+TRB->BD6_NUMERO + "  " + TRB->BD6_OPEUSR+"."+TRB->BD6_CODEMP+"."+TRB->BD6_MATRIC+"."+TRB->BD6_TIPREG+"-"+TRB->BD6_DIGITO + "  " + TRB->BD6_NOMUSR + "  " + TRB->BD6_CODEMP+" - "+substr(BG9->BG9_DESCRI,1,50) + "  " + BI3->BI3_CODIGO+"."+BI3->BI3_VERSAO + "  "+ substr(BI3->BI3_DESCRI,1,50)
					nLin++
					
					lImpCab := .T.

				Endif	
				cDesGlo := Iif(Empty(BDX->BDX_DESGLO),Posicione("BCT",1,xFilial("BCT")+PLSINTPAD()+BDX->BDX_CODGLO,"BCT_DESCRI"),BDX->BDX_DESGLO)
				//@nLin,nColuna PSAY TRB->BD6_CODPAD+"."+substr(TRB->BD6_CODPRO,1,8) + "  " + TRB->BD6_DESPRO + "  " + IIF(TRB->BD6_TIPGUI=="03",DtoC(BE4->BE4_DATPRO),DtoC(BD5->BD5_DATPRO)) + "  " + Transform(TRB->BD6_QTDPRO,"@E 9,999,999.99") + "  " + Transform((TRB->BD6_QTDAPR*TRB->BD6_VLRAPR),"@E 999,999,999.99") + "  " + Transform(TRB->BD6_VLRGLO,"@E 99,999,999.99") + "  " + Transform(BDX->BDX_PERGLO,"@E 999.99") + "  " + Transform(TRB->BD6_VLRPAG,"@E 999,999,999.99") + "  " + BDX->BDX_CODGLO+"-"+substr(cDesGlo,1,70)
				@nLin,nColuna PSAY TRB->BD6_CODPAD+"."+substr(TRB->BD6_CODPRO,1,8) + "  " + TRB->BD6_DESPRO + "  " + IIF(TRB->BD6_TIPGUI=="03",DtoC(BE4->BE4_DATPRO),DtoC(BD5->BD5_DATPRO)) + "  " + Transform(TRB->BD6_QTDPRO,"@E 9,999,999.99") + "  " + Transform((TRB->BD6_QTDPRO*TRB->BD6_VLRAPR),"@E 999,999,999.99") + "  " + Transform(TRB->BD6_VLRGLO,"@E 99,999,999.99") + "  " + Transform(BDX->BDX_PERGLO,"@E 999.99") + "  " + Transform(TRB->BD6_VLRPAG,"@E 999,999,999.99") + "  " + BDX->BDX_CODGLO+"-"+substr(cDesGlo,1,70)
				nLin++
		
			Endif

			nGuiQtd += TRB->BD6_QTDPRO
			nGuiPag += TRB->BD6_VLRPAG
			nGuiGlo += TRB->BD6_VLRGLO
			//nGuiApr += (TRB->BD6_QTDAPR*TRB->BD6_VLRAPR)
			nGuiApr += (TRB->BD6_QTDPRO*TRB->BD6_VLRAPR)
	
			TRB->(DbSkip())
		Enddo

		//Imprime Total da Guia
		If nTipImp <> 1 .And. (nGuiQtd+nGuiApr+nGuiGlo+nGuiPag) > 0
			@nLin,nColuna PSAY space(50) + "Total da Conta Médica: " + Transform(nGuiQtd,"@E 999,999,999.99") + "  " + Transform(nGuiApr,"@E 999,999,999.99") + " " + Transform(nGuiGlo,"@E 999,999,999.99") + space(10) + Transform(nGuiPag,"@E 999,999,999.99")
			nLin++
			nLin++
	    Endif
	
		nTotQtd += nGuiQtd
		nTotPag += nGuiPag
		nTotGlo += nGuiGlo
		nTotApr += nGuiApr
		
	Enddo
	
	//Imprime Total da Rda
	If nTipImp == 1
		@nLin,nColuna PSAY cCodRda + "  " + cDesRda + "  " + Transform(nTotQtd,"@E 999,999,999.99") + "  " + Transform(nTotApr,"@E 999,999,999.99") + "  " + Transform(nTotGlo,"@E 999,999,999.99") + "  " + Transform(nTotPag,"@E 999,999,999.99")
		nLin++
    Else
		@nLin,nColuna PSAY space(61) + "Total da Rda: " + Transform(nTotQtd,"@E 999,999,999.99") + "  " + Transform(nTotApr,"@E 999,999,999.99") + " " + Transform(nTotGlo,"@E 999,999,999.99") + space(10) + Transform(nTotPag,"@E 999,999,999.99")
		nLin++
		nLin++
    Endif

	nQtdTot += nTotQtd
	nPagTot += nTotPag
	nGloTot += nTotGlo
	nAprTot += nTotApr
		
EndDo
       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime totalizador...													 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLin+4 > nQtdLin
	Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)
	nLin := 9
Endif

If nTipImp == 1
	nLin++
	@nLin,nColuna PSAY replicate("-",nLimite)
	nLin++
	@nLin,nColuna PSAY "Total Geral: " + space(37) + Transform(nQtdTot,"@E 999,999,999.99") + "  " + Transform(nAprTot,"@E 999,999,999.99") + "  " + Transform(nGloTot,"@E 999,999,999.99") + "  " + Transform(nPagTot,"@E 999,999,999.99")
	nLin++
	@nLin,nColuna PSAY replicate("-",nLimite)                   
Else
	@nLin,nColuna PSAY replicate("-",nLimite)
	nLin++
	@nLin,nColuna PSAY "Total Geral: " + space(62) + Transform(nQtdTot,"@E 999,999,999.99") + "  " + Transform(nAprTot,"@E 999,999,999.99") + " " + Transform(nGloTot,"@E 999,999,999.99") + space(10) + Transform(nPagTot,"@E 999,999,999.99")
	nLin++
	@nLin,nColuna PSAY replicate("-",nLimite)                   
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha temporario...														 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB->(DbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AjustaSX1ºAutor  ³Thiago Machado Correaº Data ³  12/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta as perguntas do SX1 da rotina.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora"       ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B39","","","",""})
aadd(aRegs,{cPerg,"02","Rda De"          ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","BA0","","","",""})
aadd(aRegs,{cPerg,"03","Rda Ate"         ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BA0","","","",""})
aadd(aRegs,{cPerg,"04","Ldp De"          ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","YCG","","","",""})
aadd(aRegs,{cPerg,"05","Ldp Ate"         ,"","","mv_ch5","C", 4,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","YCG","","","",""})
aadd(aRegs,{cPerg,"06","Peg De"          ,"","","mv_ch6","C", 8,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"07","Peg Ate"         ,"","","mv_ch7","C", 8,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"08","Numero De"       ,"","","mv_ch8","C", 8,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"09","Numero Ate"      ,"","","mv_ch9","C", 8,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"10","Mes/Ano De"      ,"","","mv_cha","C", 6,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"11","Mes/Ano Ate"     ,"","","mv_chb","C", 6,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"12","Empresa De"      ,"","","mv_chc","C", 4,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","B7A","","","",""})
aadd(aRegs,{cPerg,"13","Empresa Ate"     ,"","","mv_chd","C", 4,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","B7A","","","",""})
aadd(aRegs,{cPerg,"14","Familia De"      ,"","","mv_che","C", 6,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"15","Familia Ate"     ,"","","mv_chf","C", 6,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","","",""})
aadd(aRegs,{cPerg,"16","Tabela De"       ,"","","mv_chg","C", 2,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","B41","","","",""})
aadd(aRegs,{cPerg,"17","Tabela Ate"      ,"","","mv_chh","C", 2,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","B41","","","",""})
aadd(aRegs,{cPerg,"18","Procedimento De" ,"","","mv_chg","C",16,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","YBR","","","",""})
aadd(aRegs,{cPerg,"19","Procedimento Ate","","","mv_chh","C",16,0,0,"G","","mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","YBR","","","",""})
aadd(aRegs,{cPerg,"20","Fase"            ,"","","mv_chi","N", 1,0,0,"C","","mv_par20","Pronta"      ,"","","","","Faturada"     ,"","","","","Pronta/Faturada","","","","","Conferencia","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"21","Tipo Impressao"  ,"","","mv_chj","N", 1,0,0,"C","","mv_par21","Sintetico"   ,"","","","","Analitico"    ,"","","","",""               ,"","","","",""           ,"","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"22","Imprimir"        ,"","","mv_chk","N", 1,0,0,"C","","mv_par22","Grande Risco","","","","","Pequeno Risco","","","","","Ambos"          ,"","","","",""           ,"","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"23","Cod. Glosa De"   ,"","","mv_chl","C", 3,0,0,"G","","mv_par23","","","","","","","","","","","","","","","","","","","","","","","","","YBCT","","","",""})
aadd(aRegs,{cPerg,"24","Cod. Glosa Ate"  ,"","","mv_chm","C", 3,0,0,"G","","mv_par24","","","","","","","","","","","","","","","","","","","","","","","","","YBCT","","","",""})

/*
aadd(aRegs,{cPerg,"25","Vlr. Glosa De"   ,"","","mv_chn","N",17,0,0,"G","","mv_par25","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"26","Vlr. Glosa Ate"  ,"","","mv_cho","N",17,0,0,"G","","mv_par26","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
*/

PutSx1(cPerg,"25",OemToAnsi("Valor Glosa De")   			 ,"","","mv_chn","N",17,2,0,"G","","","","","mv_par25","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"26",OemToAnsi("Valor Glosa Ate")   			 ,"","","mv_cho","N",17,2,0,"G","","","","","mv_par26","","","","","","","","","","","","","","","","",{},{},{})


/*
PutSx1(cPerg,"28",OemToAnsi("Valor De")   			 ,"","","mv_chi","N",17,2,0,"G","","","","","mv_par28","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"29",OemToAnsi("Valor Ate")   			 ,"","","mv_chj","N",17,2,0,"G","","","","","mv_par29","","","","","","","","","","","","","","","","",{},{},{})
*/

PlsVldPerg( aRegs )

Return