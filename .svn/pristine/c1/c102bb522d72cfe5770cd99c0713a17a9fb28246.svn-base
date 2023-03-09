#INCLUDE "plsr018n.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR018N³ Autor ³ Luciano Aparecido      ³ Data ³ 22.03.07 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Demonstrativo de Pagamento                                 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR018N()                                                 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSR018NCab()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1     := STR0001 //"Emite Relatório de Pagamento RDA"
Local cDesc2     := ""
Local cDesc3     := " "
Local cTamanho   := "M"
Local wnRel      := "PLSR018N"
Local cString    := "BMR"
Local aOrd       := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCodOpe
Local cRdaDe
Local cRdaAte
Local cAno
Local cMes
Local cClaPre
Local nLayout

Private cPerg    := "PL018N"
Private Titulo   := FunDesc() //"Demonstrativo de Pagamentos"
Private aReturn  := { "Zebrado", 1,"Administração", 1, 1, 1, "", 1 }
Private nLastKey :=0
Private cabec1   := ""
Private cabec2   := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If	!Pergunte(cPerg,.T.)
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VerIfica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nLastKey = 27
	Set Filter To
	Return
EndIf

cCodOpe   := mv_par01
cRdaDe    := mv_par02
cRdaAte   := mv_par03
cAno      := mv_par04
cMes      := mv_par05
cClaPre   := mv_par06
nLayout   := mv_par07

RptStatus({|lEnd| R018NImp(@lEnd, wnRel, cString,cCodOpe,cRdaDe,cRdaAte,cAno,cMes,cClaPre,nLayout)}, Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R018NImp ³ Autor ³ Luciano Aparecido     ³ Data ³ 22.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Chamada do Relatorio                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R018NImp(lEnd, wRel, cString, cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre,nLayout)
Local cTissVer := PLSTISSVER()
Local aDados := {}

aAdd(aDados, u_MtaDadosCbj(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cTissVer))

If (cTissVer < "3")
	PLSTISS8(aDados, nLayout)
Else
	PLSTISS8B(aDados, nLayout)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ MtaDados  ³ Autor ³ Luciano Aparecido    ³ Data ³ 22.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ chama a funcao "PLSDPGT"                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function MtaDadosCbj(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cTissVer)

Local aDados := {}

// Funcao que monta o array com os dados da guia
If (cTissVer < "3")
	aDados := u_PLSDPGTcab(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre)
Else
	aDados := u_PLSDPGTBcab(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre)
EndIf

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSDPGT   ³ Autor ³ Luciano Aparecido     ³ Data ³ 05.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Dados Relatório TISS (Guia Demonstrativo de Pagamento )     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodOpe - Código da Operadora                               ³±±
±±³          ³ cRdaDe  - Código da RDA a ser processada (de)               ³±±
±±³          ³ cRdaAte - Código da RDA a ser processada (Até)              ³±±
±±³          ³ cAno    - Informe o Ano a ser processado                    ³±±
±±³          ³ cMes    - Informe o Mês a ser processado                    ³±±
±±³          ³ cClaPre - Classe RDA                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSDPGTcab(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre,cNFSSDe,cNFSSAte,cNmTitPg,cAlias)

	Local aCpo04,aCpo05, aCpo06, aCpo07, aCpo08, aCpo09, aCpo10, aCpo11, aCpo12, aCpo13
	Local aCpo14, aCpo15, aCpo16, aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22
	Local aCpo23, aCpo24, aCpo25, aCpo26, aCpo27,aCpo28
	Local aDados
	Local cSQL
	Local nInd1, nCont:=0
	LOCAL cNmLotPg		:= ""
	LOCAL cRdaLote		:= ""

	DEFAULT cNFSSDe 	:= ""
	DEFAULT cNFSSAte 	:= ""
	DEFAULT cNmTitPg 	:= ""
	DEFAULT cAlias := "SE2"

	DBSELECTAREA(cAlias)
	// Variaveis para buscar o BMR pelo numero do titulo.
	If !Empty(cNmTitPg)
		If cAlias ="SE2"
			SE2->(dbSetorder(01))
			If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
				cCodOpe  := SE2->E2_PLOPELT
				cNmLotPg := Subs(SE2->E2_PLLOTE,7,4)
				cRdaLote := SE2->E2_CODRDA
	            cFornece:= SE2->E2_FORNECE
	            cLoja    := SE2->E2_LOJA
				cAno := SE2->E2_ANOBASE
				cMes := SE2->E2_MESBASE
			Endif
		Else
			SC7->(dbSetorder(01))
			If SC7->(dbSeek(xFilial("SC7")+cNmTitPg))
				cCodOpe  := If(SC7->(FieldPos("C7_PLOPELT"))>0,SC7->C7_PLOPELT,PLSINTPAD())
				cNmLotPg := Subs(SC7->C7_LOTPLS,7,4)
				cRdaLote := SC7->C7_CODRDA
				cFornece:= SC7->C7_FORNECE
	            cLoja    := SC7->C7_LOJA

				cAno := Substr(SC7->C7_LOTPLS,1,4)
				cMes := Substr(SC7->C7_LOTPLS,5,2)
			Endif


		Endif
	Else
		cFornece:=SE2->E2_FORNECE
		cLoja := SE2->E2_LOJA

	Endif
	aDados := {}

	cSQL := "SELECT BMR_ANOLOT, BMR_CODLAN, BMR_CODRDA, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"
	cSQL += "  FROM " + RetSqlName("BMR")
	cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' AND "
	cSQL += "  BMR_OPELOT = '" + cCodOpe + "' AND "
	If !Empty(cNmLotPg)
	    cSQL += "BMR_CODRDA = '" + cRdaLote + "' AND "
		cSQL += "BMR_NUMLOT = '" + cNmLotPg + "' AND "

	Else
	    cSQL += "( BMR_CODRDA >= '" + cRdaDe + "' AND BMR_CODRDA <= '" + cRdaAte + "' ) AND "
	Endif

	cSQL += " BMR_ANOLOT = '" + cAno + "' AND "
	cSQL += " BMR_MESLOT = '" + cMes + "' AND "
	cSql += RetSQLName("BMR")+".D_E_L_E_T_ = ' '"
	cSQL += " ORDER BY BMR_FILIAL, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT, BMR_OPERDA, BMR_CODRDA, BMR_CODLAN "

	PlsQuery(cSQL,"TrbBMR")

	// BA0 - Operadoras de Saude
	BA0->(dbSetOrder(1))
	BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

   	Do While ! TrbBMR->(Eof())
	    nCont+=1
		// BAU - Redes de Atendimento
		BAU->(dbSetOrder(1))
		BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))

		// BAF - Lotes plsde Pagamentos RDA
		BAF->(dbSetOrder(1))
		BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))

		If Empty(cNmTitPg) .and. Empty(cNmLotPg)
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO,E2_VENCTO,E2_FORNECE,E2_LOJA "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
			cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
			cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
			cSQL += "    AND D_E_L_E_T_ = ' ' "
			PlsQuery(cSQL,"TrbSE2")

			If ! TrbSE2->(Eof())
				SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
			EndIf

			TrbSE2->(DbCloseArea())
		Endif

		// SA2 - Cadastro de Fornecedores
		SA2->(dbSetOrder(1))
		SA2->(msSeek(xFilial("SA2")+cFornece+cLoja))

		If nCont == 1
			aAdd(aDados, BA0->BA0_SUSEP) // 1
			aAdd(aDados, BA0->BA0_NOMINT) // 2
			aAdd(aDados, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99")) // 3
			aCpo04 := {}
			aCpo05 := {}
			aCpo06 := {}
			aCpo07 := {}
			aCpo08 := {}
			aCpo09 := {}
			aCpo10 := {}
			aCpo11 := {}
			aCpo12 := {}
			aCpo13 := {}
			aCpo14 := {}
			aCpo15 := {}
			aCpo16 := {}
			aCpo17 := {}
			aCpo18 := {}
			aCpo19 := {}
			aCpo20 := {}
			aCpo21 := {}
			aCpo22 := {}
			aCpo23 := {}
			aCpo24 := {}
			aCpo25 := {}
			aCpo26 := {}
			aCpo27 := {}
			aCpo28 := {}
		Endif

		cSQL := "SELECT BD7_CODOPE, BD7_CODRDA, BD7_CODOPE, BD7_CODLDP,BD7_NUMERO, BD7_CODPEG, BD7_ORIMOV,BD7_SEQUEN,BD7_CODPAD, BD7_VLRAPR,BD7_CODPRO, BD7_VLRPAG, BD7_VLRGLO "
		cSQL += "  FROM " + RetSqlName("BD7")
		cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
		cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Somente pega as guias de um mesma NFSS							  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BD7->(FieldPos("BD7_SEQNFS")) > 0
		  	If !Empty(cNFSSAte)
		  		cSQL += "AND ( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) "
		  	EndIf
		Endif
		cSQL += "   AND D_E_L_E_T_ = ' '"
		cSQL += " ORDER BY BD7_CODLDP,BD7_CODPEG"

		PlsQuery(cSQL,"TrbBD7")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Contas Medicas                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(dbSetOrder(1))
		BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))

		aAdd(aCpo04, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 4
		aAdd(aCpo05, BAF->BAF_DTDIGI) // 5
		aAdd(aCpo06, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6
		aAdd(aCpo07, BAU->BAU_NOME) // 7

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BD7->(BD7_CODRDA+BD7_CODOPE)+BD5->BD5_CODLOC))

		aAdd(aCpo08, Transform(BB8->BB8_CNES, cPicCNES)) // 8
		aAdd(aCpo09, If(cAlias=="SE2",SE2->E2_VENCTO,CTOD(" / / "))) // 9   DATA DO PAGAMENTO
		aAdd(aCpo10, { IF (BAU->BAU_FORPGT =='1',"X",""),;  //Credito em conta
						IF (BAU->BAU_FORPGT =='2',"X",""),;  //Carteira
		               IF (BAU->BAU_FORPGT =='3',"X","")})  // Boleto Bancário   10   FORMA DE PAGAMENTO
		aAdd(aCpo11, IF (BAU->BAU_FORPGT =='1',SA2->A2_BANCO,""))  // 11   BANCO
		aAdd(aCpo12, IF (BAU->BAU_FORPGT =='1',SA2->A2_AGENCIA,"")) // 12   AGENCIA
		aAdd(aCpo13, IF (BAU->BAU_FORPGT =='1',SA2->A2_NUMCON,""))  // 13   NUMERO DA CONTA/CHEQUE

		aAdd(aCpo14,{})
		aAdd(aCpo15,{})
		aAdd(aCpo16,{})
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})
		aAdd(aCpo21,{})
		aAdd(aCpo27,{})

		nGerInf  := 0
		nGerProc := 0
		nGerLib  := 0
		nGerGlo  := 0
		nVrInf   := 0
		nVrProc  := 0
		nVrLib   := 0
		nVrGlo   := 0

		nInd1 := Len(aCpo04)

		TrbBD7->(dbGoTop())
		Do While !TrbBD7->(Eof())

			nVrInf   := 0
			nVrProc  := 0
			nVrLib   := 0
			nVrGlo   := 0

			// BCI - PEGS
			BCI->(dbSetOrder(5)) //BCI_FILIAL + BCI_OPERDA + BCI_CODRDA + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
			BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))

			aAdd(aCpo14[nInd1], If(cAlias=="SE2",SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA),SC7->C7_NUM))
			aAdd(aCpo15[nInd1], TrbBD7->(BD7_CODLDP+BD7_CODPEG))
			aAdd(aCpo16[nInd1], BCI->BCI_DATREC)
			aAdd(aCpo17[nInd1], BCI->BCI_CODPEG)

			cChRDA  := TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChRDA

				nVrInf  += TrbBD7->BD7_VLRAPR
				nVrProc += TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO
				nVrLib  += TrbBD7->BD7_VLRPAG
				nVrGlo  += TrbBD7->BD7_VLRGLO

				TrbBD7->(dbSkip())
			EndDo

			aAdd(aCpo18[nInd1], nVrInf)
			aAdd(aCpo19[nInd1], nVrProc)
			aAdd(aCpo20[nInd1], nVrLib)
			aAdd(aCpo21[nInd1], nVrGlo)
			nGerInf  += nVrInf
			nGerProc += nVrProc
			nGerLib  += nVrLib
			nGerGlo  += nVrGlo
		EndDo

		aAdd(aCpo22, nGerInf)
		aAdd(aCpo23, nGerProc)
		aAdd(aCpo24, nGerLib)
		aAdd(aCpo25, nGerGlo)
		aAdd(aCpo26,(nGerProc-nGerGlo))
		TrbBD7->(dbCloseArea())
		aAdd(aDados, aCpo04)
		aAdd(aDados, aCpo05)
		aAdd(aDados, aCpo06)
		aAdd(aDados, aCpo07)
		aAdd(aDados, aCpo08)
		aAdd(aDados, aCpo09)
		aAdd(aDados, aCpo10)
		aAdd(aDados, aCpo11)
		aAdd(aDados, aCpo12)
		aAdd(aDados, aCpo13)
		aAdd(aDados, aCpo14)
		aAdd(aDados, aCpo15)
		aAdd(aDados, aCpo16)
		aAdd(aDados, aCpo17)
		aAdd(aDados, aCpo18)
		aAdd(aDados, aCpo19)
		aAdd(aDados, aCpo20)
		aAdd(aDados, aCpo21)
		aAdd(aDados, aCpo22) // 22
		aAdd(aDados, aCpo23) // 23
		aAdd(aDados, aCpo24) // 24
		aAdd(aDados, aCpo25) // 25
		aAdd(aDados, aCpo26) // 26

		nDeb :=0
		nCred:=0
		cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
		Do While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR

			If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
				BMS->(dbSetOrder(1))
				BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
				Do While ! BMS->(Eof()) .And. ;
						BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
						TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)
					aAdd(aCpo27[nInd1], { IIf(BMS->BMS_DEBCRE == "1", "(-) ", "(+) ") + BMS->BMS_CODSER + " - " + Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI"), BMS->BMS_VLRPAG })
					if BMS->BMS_DEBCRE == "1"
						nDeb+=BMS->BMS_VLRPAG
					else
						nCred+=BMS->BMS_VLRPAG
					Endif
					BMS->(dbSkip())
				EndDo
			ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"
				aAdd(aCpo27[nInd1], { IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN), "BLR_DESCRI"), TrbBMR->BMR_VLRPAG })
				If TrbBMR->BMR_DEBCRE == "1"
					nDeb+=TrbBMR->BMR_VLRPAG
				else
					nCred+=TrbBMR->BMR_VLRPAG
				Endif
			EndIf

		TrbBMR->(dbSkip())
		EndDo

		aAdd(aDados, aCpo27)
		aAdd(aCpo28, ((nGerProc-nGerGlo)+nCred)-nDeb)
		aAdd(aDados, aCpo28) // 28

	EndDo

	TrbBMR->(DbCloseArea())

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSDPGTB  ³ Autor ³ Luciano Aparecido     ³ Data ³ 05.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Dados Relatório TISS (Guia Demonstrativo de Pagamento )     ³±±
±±³          ³ TISS 3                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodOpe - Código da Operadora                               ³±±
±±³          ³ cRdaDe  - Código da RDA a ser processada (de)               ³±±
±±³          ³ cRdaAte - Código da RDA a ser processada (Até)              ³±±
±±³          ³ cAno    - Informe o Ano a ser processado                    ³±±
±±³          ³ cMes    - Informe o Mês a ser processado                    ³±±
±±³          ³ cClaPre - Classe RDA                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSDPGTBcab(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre,cNFSSDe,cNFSSAte,cNmTitPg,cAliasP,lWeb,cDataPag)

Local aCpo04, aCpo05, aCpo06, aCpo07, aCpo08, aCpo09, aCpo10, aCpo11, aCpo12, aCpo13, aCpo14, aCpo15, aCpo16
Local aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22, aCpo23, aCpo24, aCpo25, aCpo26, aCpo27, aCpo28 
Local aDados	:= {}
Local aDadosTot	:= {}
Local aVetTmp	:= {}
Local aDecPad	:= {}
Local cSQL		:= ""
Local nCont		:= 0
local nPercen	:= 0
Local nInd1		:= 0
Local cNmLotPg	:= ""
Local cRdaLote	:= ""
Local lAdd14	:= .F.
Local lAdd17 	:= .F.
Local nI		:= 1
Local cDePara25	:= ""
Local cDePara26	:= ""
Local cDePara27	:= ""
Local nGerLib	:= 0
Local cCodRdaLoop	:= ""
Local cCodLan	:= ""
Local nDeb		:= 0
Local nCred		:= 0
//Variáveis de Imposto
Local nCIRRF 	:= 0
Local nCISS  	:= 0
Local nCPIS  	:= 0
Local nCINSS 	:= 0
Local nCCOFINS 	:= 0
Local nCCSLL   	:= 0
Local nGerInf  := 0
Local nGerProc := 0
Local nGerGlo := 0
Local dRetCalen := NIL
Local nLiDeCr := 1
Local nTamTit := 1

DEFAULT cNFSSDe 	:= ""
DEFAULT cNFSSAte 	:= ""
DEFAULT cNmTitPg 	:= ""
DEFAULT cAliasP		:= "SE2"
Default cDataPag	:= ""
DBSELECTAREA("SE2")

cSQL := "SELECT DISTINCT BMR_CODRDA, BMR_ANOLOT, BMR_CODLAN, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"  


	
	// BAU - Redes de Atendimento
	BAU->(dbSetOrder(1))
	BAU->(msSeek(xFilial("BAU")+cRdaDe))
	
	If BAU->BAU_CALIMP ==  '1' 
		// Variaveis para buscar o BMR pelo numero do titulo.
    	If cAliasP == "SE2"
			SE2->(dbSetorder(01)) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA                                                                                               
			If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
				//Quando o prestador usa integração com o pedido de compras mas já tem a nota/titulo
				cSQL += " FROM " + RetSqlName("SE2") + " SE2 "

				cSQL += " INNER JOIN " + RetSqlName("SD1")+ " SD1 "
				cSQL += "  ON D1_FILIAL = '" + xFilial("SD1") + "' "
				cSQL += "  AND D1_DOC = E2_NUM "
				cSQL += "  AND D1_FORNECE = E2_FORNECE "
				cSQL += "  AND D1_LOJA 	= E2_LOJA "
				cSQL += "  AND D1_DTDIGIT = SE2.E2_EMIS1 "
				cSQL += "  AND SD1.D_E_L_E_T_ = ' ' "
	
				cSQL += " INNER JOIN " + RetSqlName("SC7") + " SC7  "
				cSQL += "   ON C7_FILIAL = '" + xFilial("SC7") + "' "
				cSQL += "   AND C7_NUM 	  = D1_PEDIDO "
				cSQL += "   AND C7_ITEM   = D1_ITEMPC "
				cSQL += "   AND SC7.D_E_L_E_T_ = ' ' "
	
				cSQL += " INNER JOIN " + RetSqlName("BMR") + " BMR "
				cSQL += "   ON BMR_FILIAL = '" + xFilial("BMR") + "' "
				cSQL += "   AND BMR_OPERDA = C7_PLOPELT "
				cSQL += "   AND BMR_CODRDA = C7_CODRDA "
				cSQL += "   AND BMR_OPELOT = C7_PLOPELT "
				cSQL += "   AND BMR_ANOLOT = SubString(C7_LOTPLS,1,4) "
				cSQL += "   AND BMR_MESLOT = SubString(C7_LOTPLS,5,2) "
				cSQL += "   AND BMR_NUMLOT = SubString(C7_LOTPLS,7,4) "
				cSQL += "   AND BMR.D_E_L_E_T_ = ' ' "
				
				cSQL += " WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
				cSQL += " AND E2_PREFIXO 	= '"+SubString(cNmTitPg,01,TamSx3("E2_PREFIXO")[1])+"' "
				nTamTit := nTamTit + TamSx3("E2_PREFIXO")[1]
				cSQL += " AND E2_NUM 		= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_NUM")[1])+"' "
				nTamTit := nTamTit + TamSx3("E2_NUM")[1]
				cSQL += " AND E2_PARCELA 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_PARCELA")[1])+"' "
				nTamTit := nTamTit + TamSx3("E2_PARCELA")[1]
				cSQL += " AND E2_TIPO 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_TIPO")[1])+"' "
				nTamTit := nTamTit + TamSx3("E2_TIPO")[1]
				cSQL += " AND E2_FORNECE = '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_FORNECE")[1])+"' "
				nTamTit := nTamTit + TamSx3("E2_FORNECE")[1]
				cSQL += " AND E2_LOJA 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_LOJA")[1]) + " ' "
				cSQL += " AND SE2.D_E_L_E_T_ = ' '	
				
				//Valor dos Impostos para sair nos campos de 25 a 28
				nCIRRF		:= SE2->E2_IRRF
				nCISS		:= SE2->E2_ISS
				nCPIS		:= SE2->E2_PIS
				nCINSS		:= SE2->E2_INSS
				nCCOFINS 	:= SE2->E2_COFINS
				nCCSLL   	:= SE2->E2_CSLL
			EndIf
		Else
			//Quando o prestador utiliza integração com pedido de compras, mas ainda não tem nota/titulo, tem somente o pedido SC7
			SC7->(DbSetOrder(1))
			If SC7->(msSeek(xFilial("SC7")+cNmTitPg)) .or. SC7->(DBSeek(xFilial("SC7")+alltrim(cNmTitPg)))

				cSQL += " FROM " + RetSqlName("SC7") + " SC7 "
	
				cSQL += " INNER JOIN " + RetSqlName("BMR") + " BMR "
				cSQL += "    ON BMR_FILIAL = '"+xFilial("BMR")+"' "
				cSQL += "   AND BMR_OPERDA = C7_PLOPELT "
				cSQL += "   AND BMR_CODRDA = C7_CODRDA "
				cSQL += "   AND BMR_OPELOT = C7_PLOPELT "
				cSQL += "   AND BMR_ANOLOT = SubString(C7_LOTPLS,1,4) "
				cSQL += "   AND BMR_MESLOT = SubString(C7_LOTPLS,5,2) "
				cSQL += "   AND BMR_NUMLOT = SubString(C7_LOTPLS,7,4) "
	
				cSQL += " WHERE C7_FILIAL = '"+xFilial("SC7")+"' "
				cSQL += "   AND C7_NUM 	= '"+cNmTitPg+"' "
				cSQL += "   AND SC7.D_E_L_E_T_ = ' ' "
				
				//Valor dos Impostos para sair nos campos de 25 a 28
				nCIRRF		:= SC7->C7_VALIR
				nCISS		:= SC7->C7_VALISS
				nCPIS		:= SC7->C7_VALIMP6 //Conforme boletim TEUS65
				nCINSS		:= SC7->C7_VALINS
				nCCOFINS 	:= SC7->C7_VALIMP5 //Conforme boletim TEUS65
				nCCSLL   	:= SC7->C7_VALCSL
		
			EndIf
		EndIf
	Else
		//Quando o prestador está configurado para gerar financeiro
		cSQL += " FROM " + RetSqlName("SE2") + " SE2 "	

		cSQL += " INNER JOIN " + RetSqlName("BMR") + " BMR
		cSQL += "    ON BMR_FILIAL = '" + xFilial("BMR") + "' "
		cSQL += "   AND BMR_OPERDA = E2_PLOPELT "
		cSQL += "   AND BMR_CODRDA = E2_CODRDA "
		cSQL += "   AND BMR_OPELOT = E2_PLOPELT "
		cSQL += "   AND BMR_ANOLOT = SubString(E2_PLLOTE ,1,4) " 
		cSQL += "   AND BMR_MESLOT = SubString(E2_PLLOTE ,5,2) "
		cSQL += "   AND BMR_NUMLOT = SubString(E2_PLLOTE ,7,4) "
		cSQL += "   AND BMR.D_E_L_E_T_ = ' ' "

		cSQL += " WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		
		cSQL += "   AND E2_PLLOTE LIKE '" + cAno + cMes + '%' + "' "
		//cSQL += " AND E2_PREFIXO 	= '"+SubString(cNmTitPg,01,TamSx3("E2_PREFIXO")[1])+"' "
		nTamTit := nTamTit + TamSx3("E2_PREFIXO")[1]
		//cSQL += " AND E2_NUM 		= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_NUM")[1])+"' "
		nTamTit := nTamTit + TamSx3("E2_NUM")[1]
		//cSQL += " AND E2_PARCELA 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_PARCELA")[1])+"' "
		nTamTit := nTamTit + TamSx3("E2_PARCELA")[1]
		//cSQL += " AND E2_TIPO 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_TIPO")[1])+"' "
		nTamTit := nTamTit + TamSx3("E2_TIPO")[1]
		//cSQL += " AND E2_FORNECE = '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_FORNECE")[1])+"' "
		cSQL += " AND E2_FORNECE = '"+BAU->BAU_CODSA2+"' "
		nTamTit := nTamTit + TamSx3("E2_FORNECE")[1]
		//cSQL += " AND E2_LOJA 	= '"+SubString(cNmTitPg,nTamTit,TamSx3("E2_LOJA")[1]) + " ' "
		cSQL += " AND E2_LOJA 	= '"+BAU->BAU_LOJSA2 + " ' "
		cSQL += " AND SE2.D_E_L_E_T_ = ' '	
		
	EndIf		
	
cSql += " AND BMR.D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BMR_CODRDA, BMR_CODLAN, BMR_OPERDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "

cSQL	:= ChangeQuery(cSQL)
PlsQuery(cSQL,"TrbBMR")

	// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

nGerInf  := 0
nGerProc := 0
nGerLib  := 0
nGerGlo  := 0

While ! TrbBMR->(Eof())
	cCodRdaLoop := TrbBMR->(BMR_CODRDA)
	While ! TrbBMR->(Eof()) .And. cCodRdaLoop == TrbBMR->(BMR_CODRDA)
		nCont+=1
		// BAU - Redes de Atendimento
		BAU->(dbSetOrder(1))
		BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))
	
		// BAF - Lotes plsde Pagamentos RDA
		BAF->(dbSetOrder(1))
		BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))
	
		If Empty(cNmTitPg) .and. Empty(cNmLotPg)
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO,E2_VENCTO,E2_FORNECE,E2_LOJA "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
			cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
			cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
			cSQL += "    AND D_E_L_E_T_ = ' ' "
			PlsQuery(cSQL,"TrbSE2")
	
			If ! TrbSE2->(Eof())
				SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
			EndIf
	
			TrbSE2->(DbCloseArea())
		EndIf
	
		// SA2 - Cadastro de Fornecedores
		SA2->(dbSetOrder(1))
		SA2->(msSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))
		
		//BB8
		BB8->(dbSetOrder(1))
		BB8->(msSeek(xFilial("BB8")+BAU->BAU_CODIGO+cCodOpe))
		
		nCountLoc := 0
		
		while !BB8->(EoF()) .and. BB8->BB8_CODIGO == BAU->BAU_CODIGO .and. BB8->BB8_CODINT == cCodOpe
			cCodCnes := BB8->BB8_CNES
			nCountLoc++
			BB8->(dbSkip())
		enddo	
		
		//Caso exista mais de um CNES (devido há mais de um local de atendimento) ou esteja vazio no cadastro, preenche com "9999999"
		if nCountLoc <> 1 .or. Empty(cCodCnes)
			cCodCnes := "9999999"
		endif
		
		If nCont == 1
			aAdd(aDados, BA0->BA0_SUSEP) // 1
			aAdd(aDados, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 2
			aAdd(aDados, BA0->BA0_NOMINT) // 3
			aAdd(aDados, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99") ) // 4
			aAdd(aDados, dDataBase) // 5 - Data de emissao do demonstrativo
			aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6 - Codigo identificador do prestador contratado executante junto a operadora, conforme contrato estabelecido
			aAdd(aDados, BAU->BAU_NOME) // 7 - Razao Social, nome fantasia ou nome do prestador contratado da operadora que executou o procedimento
			aAdd(aDados, cCodCnes) // 8 - CNES. Orientacao: Caso o prestador ainda nao possua o codigo do CNES ou exista mais de um cnes para o prestador, preencher o campo com 9999999
			//Se for SC7, não tem data de vencimento do título, busco então no calendário de pagamento	
			if cAliasP == "SC7
				//Busca dados do calendário de pagamento
				dRetCalen := PLSCHKNCAL(StrZero(Month(SC7->C7_EMISSAO), 2), AllTrim(Str(Year(SC7->C7_EMISSAO))))
				aAdd(aDados, dRetCalen)
			else
				//Verifica se tem baixa no título
				if Empty(SE2->E2_BAIXA)
					//Caso não tenha baixa, obtém o vencimento real
					aAdd(aDados, SE2->E2_VENCREA) // 9   Data do pagamento ou data prevista para o pagamento
				else
					//Caso tenha baixa, já foi pago, obtemos a data da baixa
					aAdd(aDados, SE2->E2_BAIXA) // 9   Data do pagamento
				endif		
			endif
			aAdd(aDados, BAU->BAU_FORPGT)  // 10   Codigo da forma como sera efetuado o pagamento dos servicos ao prestador, conforme tabela de dominio no 34 - ok Protheus 1,2,3 iguais
			aAdd(aDados, IF (BAU->BAU_FORPGT =='1',SA2->A2_BANCO,""))  // 11   BANCO
			aAdd(aDados, IF (BAU->BAU_FORPGT =='1',SA2->A2_AGENCIA,"")) // 12   AGENCIA
			aAdd(aDados, IF (BAU->BAU_FORPGT =='1',SA2->A2_NUMCON,""))  // 13   NUMERO DA CONTA/CHEQUE		
			aCpo14 := {}
			aCpo15 := {}
			aCpo16 := {}
			aCpo17 := {}
			aCpo18 := {}
			aCpo19 := {}
			aCpo20 := {}
			aCpo21 := {}
			aCpo22 := {}
			aCpo23 := {}
			aCpo24 := {}
			aCpo25 := {}
			aCpo26 := {}
			aCpo27 := {}
			aCpo28 := {}
			aCpo29 := {}
			aCpo30 := {}
			aCpo31 := {}
			aCpo32 := {}
	
		EndIf	
					
		If TrbBMR->BMR_CODLAN == "101"
			cCodLan := TrbBMR->BMR_CODLAN 
			nInd1 := 0
			
			aAdd(aCpo14,{}) //Data que a operadora recebeu o lote de guias de cobranca do prestador.
			aAdd(aCpo15,{}) //Numero atribuido pela operadora ao lote de guias encaminhado pelo prestador.
			aAdd(aCpo16,{}) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora
			aAdd(aCpo17,{})
			aAdd(aCpo18,{})
			aAdd(aCpo19,{})
			aAdd(aCpo20,{})
			While ! TrbBMR->(Eof()) .And. cCodRdaLoop == TrbBMR->(BMR_CODRDA) .And. TrbBMR->BMR_CODLAN == "101"  
				cSQL := "SELECT BD7_CODOPE, BD7_CODRDA, BD7_CODOPE, BD7_CODLDP,BD7_NUMERO, BD7_CODPEG, BD7_ORIMOV,BD7_SEQUEN,BD7_CODPAD, BD7_VLRAPR,BD7_CODPRO, BD7_VLRPAG, BD7_VLRGLO, BD7_PERCEN, BD7_VLRBPR "
				cSQL += "  FROM " + RetSqlName("BD7") + " BD7 "
				cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
				cSQL += "   AND BD7_CODOPE = '" + cCodOpe + "' "	
				cSQL += "   AND BD7_OPELOT = '" + TrbBMR->(BMR_OPELOT) + "'"	
				cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
				cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"				
				If BD7->(FieldPos("BD7_SEQNFS")) > 0
					If !Empty(cNFSSAte)
						cSQL += "AND ( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) "
					EndIf
				EndIf
				cSQL += " AND BD7_SITUAC = '1' "
				cSQL += "   AND BD7.D_E_L_E_T_ = ' '"	
				cSQL += " ORDER BY BD7_CODLDP,BD7_CODPEG"
			
				PlsQuery(cSQL,"TrbBD7")
			
				If !TrbBD7->(Eof())
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Posiciona Contas Medicas                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BD5->(dbSetOrder(1))
					BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))
									
					BB8->(dbSetOrder(1))
					BB8->(dbSeek(xFilial("BB8")+BD7->(BD7_CODRDA+BD7_CODOPE)+BD5->BD5_CODLOC))
														
										
					nVrInf   := 0
					nVrProc  := 0
					nVrLib   := 0
					nVrGlo   := 0
				
					lAdd14 := .F.
					lAdd17 := .F.
					
					TrbBD7->(dbGoTop())
					While !TrbBD7->(Eof())									
						
						//Zera o valor em cada iteração.
						nVrInf   := 0
						nVrProc  := 0
						nVrLib   := 0
						nVrGlo   := 0
				
						// BCI - PEGS
						BCI->(dbSetOrder(5)) //BCI_FILIAL + BCI_OPERDA + BCI_CODRDA + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
						BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))
						lAdd14 := .T.
										
						cChRDA  := TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
						While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChRDA				
							lAdd17 := .T.
														
							//Seekar BD6 para pegar o BD6_VLRAPR do procedimento. Calcula o valor informado de acordo com a BD6_VLRAPR * Qtd apresentada
							BD6->(dbSetOrder(1))
							BD6->(MsSeek(xFilial("BD6")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))
							
							//Para guias de consulta
							if (TrbBD7->BD7_VLRAPR > 0 .and. (TrbBD7->BD7_PERCEN == 0 .or. TrbBD7->BD7_PERCEN == 100))
								nVrInf  += TrbBD7->BD7_VLRAPR
								nVrProc += TrbBD7->BD7_VLRAPR //Valor processado é o mesmo que o valor informado
							else
								nPercen := PLGETPCEN(BD6->BD6_VLRBPR, TrbBD7->BD7_VLRBPR)
								
								nVrInf  += ( BD6->BD6_VALORI * nPercen ) / 100 
								nVrProc += ( BD6->BD6_VALORI * nPercen ) / 100 //Valor processado é o mesmo que o valor informado
							endif
							 
							nVrLib  += TrbBD7->BD7_VLRPAG
							nVrGlo  += TrbBD7->BD7_VLRGLO
				
							TrbBD7->(dbSkip())
						End
						
						nInd1++
						
						If nInd1 == 1
							aAdd(aCpo14[nInd1], BCI->BCI_DATREC)
							aAdd(aCpo15[nInd1], BCI->BCI_CODPEG)
							aAdd(aCpo16[nInd1], BCI->BCI_LOTGUI) //IIF(Empty(BCI->BCI_PROTOC),TrbBD7->(BD7_CODLDP+BD7_CODPEG),BCI->BCI_PROTOC)) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora						
							aAdd(aCpo17[nInd1], nVrInf)
							aAdd(aCpo18[nInd1], nVrProc)
							aAdd(aCpo19[nInd1], nVrLib)
							aAdd(aCpo20[nInd1], nVrGlo)
						Else
							aAdd(aCpo14,{}) //Data que a operadora recebeu o lote de guias de cobranca do prestador.
							aAdd(aCpo15,{}) //Numero atribuido pela operadora ao lote de guias encaminhado pelo prestador.
							aAdd(aCpo16,{}) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora
							aAdd(aCpo17,{})
							aAdd(aCpo18,{})
							aAdd(aCpo19,{})
							aAdd(aCpo20,{})
							aAdd(aCpo14[nInd1], BCI->BCI_DATREC)
							aAdd(aCpo15[nInd1], BCI->BCI_CODPEG)
							aAdd(aCpo16[nInd1], BCI->BCI_LOTGUI) //IIF(Empty(BCI->BCI_PROTOC),TrbBD7->(BD7_CODLDP+BD7_CODPEG),BCI->BCI_PROTOC)) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora						
							aAdd(aCpo17[nInd1], nVrInf)
							aAdd(aCpo18[nInd1], nVrProc)
							aAdd(aCpo19[nInd1], nVrLib)
							aAdd(aCpo20[nInd1], nVrGlo)
						EndIf
						nGerInf  += nVrInf
						nGerProc += nVrProc
						nGerLib  += nVrLib
						nGerGlo  += nVrGlo
					End
				
					If (!lAdd14)
						aAdd(aCpo14, {""})
						aAdd(aCpo15, {""})
						aAdd(aCpo16, {""})
					ElseIf (!lAdd17)
						aAdd(aCpo17, {""})
						aAdd(aCpo18, {""})
						aAdd(aCpo19, {""})
						aAdd(aCpo20, {""})
					EndIf
					
					TrbBD7->(dbCloseArea())
				EndIf
				TrbBMR->(dbskip()) 
			End
			
			aAdd(aCpo21, nGerInf) //Valor total informado pelo prestador, correspondendo ao somatorio dos valores informados de todos os lotes/protocolos apresentados na data de pagamento
			aAdd(aCpo22, nGerProc) //Valor total utilizado como base pela operadora para o processamento do pagamento a ser efetuado, correspondendo ao somatorio dos valores processados de todos os lotes/protocolos apresentados na data de pagamento
			aAdd(aCpo23, nGerLib) //Valor total previsto para pagamento ao prestador. Corresponde ao somatorio dos valores liberados de todos os lotes/protocolos apresentados na data de pagamento.
			aAdd(aCpo24, nGerGlo) //Valor total glosado pela operadora, correspondendo ao somatorio dos valores glosados de todos os lotes/protocolos apresentados na data de pagamento.						

			IIF(Len(aDados) >= 14,aAdd(aDados[14], aCpo14),aAdd(aDados, aCpo14))
			IIF(Len(aDados) >= 15,aAdd(aDados[15], aCpo15),aAdd(aDados, aCpo15))
			IIF(Len(aDados) >= 16,aAdd(aDados[16], aCpo16),aAdd(aDados, aCpo16))
			IIF(Len(aDados) >= 17,aAdd(aDados[17], aCpo17),aAdd(aDados, aCpo17))
			IIF(Len(aDados) >= 18,aAdd(aDados[18], aCpo18),aAdd(aDados, aCpo18))
			IIF(Len(aDados) >= 19,aAdd(aDados[19], aCpo19),aAdd(aDados, aCpo19))
			IIF(Len(aDados) >= 20,aAdd(aDados[20], aCpo20),aAdd(aDados, aCpo20))
			IIF(Len(aDados) >= 21,aAdd(aDados[21], aCpo21),aAdd(aDados, aCpo21))
			IIF(Len(aDados) >= 22,aAdd(aDados[22], aCpo22),aAdd(aDados, aCpo22))
			IIF(Len(aDados) >= 23,aAdd(aDados[23], aCpo23),aAdd(aDados, aCpo23))
			IIF(Len(aDados) >= 24,aAdd(aDados[24], aCpo24),aAdd(aDados, aCpo24)) 
			
			//Imprimir os valores obtidos dos impostos de forma direta no relatório, através do SE2 ou SC7
			//Isso foi feito pois nem sempre um título gerado estava gravando a BMR correspondente aos tributos abaixos e para
			//garantir que sai no relatório, foram colocados manualmente, conforme tabela de Domínio 27 da TISS
			//Assim no aDecPad temos a Descrição e o Código TISS correto para sair no relatório e antes de inserir no relatório,
			//é feito um Ascan no campo 26, para ter a certeza que este valor já não foi inserido, evitando duplicação.
			nLenDC 	:= Len(aCpo25)	
			
			if nLenDC == 0
				aadd(aCpo25, {""})
				aadd(aCpo26, {""})
				aadd(aCpo27, {""})
				aadd(aCpo28, {""})
				
				nLenDC := 1
			endif
			
			nLiDeCr := 1
			aVetTmp := {nCIRRF,nCISS,nCPIS,nCINSS,nCCOFINS,nCCSLL}
			
			For nI := 1 to len(aVetTmp)
				If aVetTmp[nI] > 0
					aDecPad := {}			
					//Percorre o campo de descrição para não		
					Do Case //r7
						Case nI == 1 //IRRF
							If ( aScan(aCpo26,{|x| x[1]=="01"}) <= 0  )
								aDecPad   := {"Imposto de renda retido na fonte (IRRF)", "01"}	
							EndIf						
						Case nI == 2 //ISS
							If ( aScan(aCpo26,{|x| x[1]=="02"}) <= 0  )
								aDecPad   := {"Imposto sobre serviços (ISS)", "02"}
							EndIf							
						Case nI == 3 //PIS
							If ( aScan(aCpo26,{|x| x[1]=="04"}) <= 0  )
								aDecPad   := {"Programa de integração social (PIS)", "04"}	
							EndIf					
						Case nI == 4 //INSS
							If ( aScan(aCpo26,{|x| x[1]=="03"}) <= 0  )
								aDecPad   := {"Instituto nacional de seguridade social (INSS)", "03"}			
							EndIf					
						Case nI == 5 //COFINS						
							If ( aScan(aCpo26,{|x| x[1]=="05"}) <= 0  )		
								aDecPad	:= {"Contribuição sobre o financiamento da seguridade social","05"}		
							EndIf				
						Case nI == 6 //CSLL
							If ( aScan(aCpo26,{|x| x[1]=="06"}) <= 0  )
								aDecPad	:= {"Contribuição sobre o lucro liquido (CSLL)","06"}	
							EndIf					
					Endcase
					
					If ((nLiDeCr <= 5) .AND. (Len(aDecPad) > 0))
						
						aCpo25[nLiDeCr][1] :=  Iif( !Empty( cDePara25 ), cDePara25 ,"1" ) // //Indicador de debito ou credito conforme tabela de dominio no 37
						aCpo26[nLiDeCr][1] :=  Iif( !Empty( cDePara26 ), cDePara26 ,aDecPad[2] ) //Codigo do debito ou credito, conforme tabela de dominio no 27
						aCpo27[nLiDeCr][1] :=  Iif( !Empty( cDePara27 ), cDePara27, aDecPad[1] ) //Descricao de valores debitados ou creditados por data de pagamento
						aCpo28[nLiDeCr][1] :=  aVetTmp[nI] //Valor
						
						//Incrementar apenas se houve inclusão, evitando espaço vazio, bem como a somatória dos débitos aqui gerados.
						nLiDeCr++
						nDeb += aVetTmp[nI]
						
						aAdd(aCpo25, {""})
						aAdd(aCpo26, {""})
						aAdd(aCpo27, {""})
						aAdd(aCpo28, {""})						
					EndIf	
				EndIf
			Next
			
			IIF(Len(aDados) >= 25,aAdd(aDados[25], aCpo25),aAdd(aDados, aCpo25))
			IIF(Len(aDados) >= 26,aAdd(aDados[26], aCpo26),aAdd(aDados, aCpo26))
			IIF(Len(aDados) >= 27,aAdd(aDados[27], aCpo27),aAdd(aDados, aCpo27))
			IIF(Len(aDados) >= 28,aAdd(aDados[28], aCpo28),aAdd(aDados, aCpo28))
			
		ElseIf TrbBMR->BMR_CODLAN $ "102,103,104,105"
		
			/*nInd1 := 1
			If nInd1 > 0
				For nI := Len(aCpo25[nInd1]) To 5
					aAdd(aCpo25[nInd1], "")
					aAdd(aCpo26[nInd1], "")
					aAdd(aCpo27[nInd1], "")
					aAdd(aCpo28[nInd1], "")
				Next
			EndIf*/
			nDeb :=0
			nCred:=0
			nLiDeCr := 1
			nLenDC := Len(aCpo25)
			cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
			//While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR
		
			//If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
			BMS->(dbSetOrder(1)) //BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN+BMS_CODPLA+BMS_CC
			BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
			While ! BMS->(Eof()) .And. ;
					BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
					TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)
					
				cDePara25 := PLSIMPVINC('BLR', '37', BMS->BMS_DEBCRE)
				cDePara26 := PLSIMPVINC('BLR', '27', BMS->BMS_CODSER)
				cDePara27 := PLSIMPVINC('BLR', '27', BMS->BMS_CODSER,.T.)

				If nLiDeCr <= 5
					If LEN(aCpo25[nLenDC]) < nLiDeCr
						AADD(aCpo25[nLenDC],"")
					EndIf
					If LEN(aCpo26[nLenDC]) < nLiDeCr
						AADD(aCpo26[nLenDC],"")
					EndIf
					If LEN(aCpo27[nLenDC]) < nLiDeCr
						AADD(aCpo27[nLenDC],"")
					EndIf
					If LEN(aCpo28[nLenDC]) < nLiDeCr
						AADD(aCpo28[nLenDC],"")
					EndIf
					aCpo25[nLenDC][nLiDeCr] := Iif(!Empty( cDePara25 ),cDePara25,BMS->BMS_DEBCRE) //Indicador de debito ou credito conforme tabela de dominio no 37 (PROTHEUS COINCIDE)
					aCpo26[nLenDC][nLiDeCr] := Iif(!Empty( cDePara26 ),cDePara26,BMS->BMS_CODSER) //Codigo do debito ou credito, conforme tabela de dominio no 27
					aCpo27[nLenDC][nLiDeCr] := Iif(!Empty( cDePara27 ),cDePara27,Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI") )  //Descricao de valores debitados ou creditados por data de pagamento
					aCpo28[nLenDC][nLiDeCr] := BMS->BMS_VLRPAG
				EndIf
				nLiDeCr++
				aAdd(aCpo25, {""})
				aAdd(aCpo26, {""})
				aAdd(aCpo27, {""})
				aAdd(aCpo28, {""})
				if BMS->BMS_DEBCRE == "1"
					nDeb += BMS->BMS_VLRPAG
				else
					nCred += BMS->BMS_VLRPAG
				Endif
				BMS->(dbSkip())
			End
			
			IIF(Len(aDados) >= 25,aAdd(aDados[25], aCpo25),aAdd(aDados, aCpo25))
			IIF(Len(aDados) >= 26,aAdd(aDados[26], aCpo26),aAdd(aDados, aCpo26))
			IIF(Len(aDados) >= 27,aAdd(aDados[27], aCpo27),aAdd(aDados, aCpo27))
			IIF(Len(aDados) >= 28,aAdd(aDados[28], aCpo28),aAdd(aDados, aCpo28))
			
		ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"
		
			/*nInd1 := 1
			If nInd1 > 0
				For nI := Len(aCpo25[nInd1]) To 5
					aAdd(aCpo25[nInd1], "")
					aAdd(aCpo26[nInd1], "")
					aAdd(aCpo27[nInd1], "")
					aAdd(aCpo28[nInd1], "")
				Next
			EndIf*/
			nDeb :=0
			nCred:=0
			nLiDeCr := 1
				
			cDePara25 := PLSIMPVINC('BLR', '37', TrbBMR->BMR_DEBCRE)
			cDePara26 := PLSIMPVINC('BLR', '27', TrbBMR->BMR_CODLAN)
			cDePara27 := PLSIMPVINC('BLR', '27', TrbBMR->BMR_CODLAN,.T.)
			
			If nLiDeCr <= 5
				If LEN(aCpo25[nLenDC]) < nLiDeCr
					AADD(aCpo25[nLenDC],"")
				EndIf
				If LEN(aCpo26[nLenDC]) < nLiDeCr
					AADD(aCpo26[nLenDC],"")
				EndIf
				If LEN(aCpo27[nLenDC]) < nLiDeCr
					AADD(aCpo27[nLenDC],"")
				EndIf
				If LEN(aCpo28[nLenDC]) < nLiDeCr
					AADD(aCpo28[nLenDC],"")
				EndIf
				aCpo25[nLenDC][nLiDeCr] :=  Iif(!Empty( cDePara25 ), cDePara25 ,TrbBMR->BMR_DEBCRE) // //Indicador de debito ou credito conforme tabela de dominio no 37
				aCpo26[nLenDC][nLiDeCr] :=  Iif(!Empty( cDePara26 ), cDePara26 ,TrbBMR->BMR_CODLAN ) //Codigo do debito ou credito, conforme tabela de dominio no 27
				aCpo27[nLenDC][nLiDeCr] :=  Iif(!Empty( cDePara27 ) ,cDePara27, Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN), "BLR_DESCRI")  ) //Descricao de valores debitados ou creditados por data de pagamento
				aCpo28[nLenDC][nLiDeCr] :=  TrbBMR->BMR_VLRPAG
			Endif
			
			nLiDeCr++

			If TrbBMR->BMR_DEBCRE == "1"
				nDeb+=TrbBMR->BMR_VLRPAG
			Else
				nCred+=TrbBMR->BMR_VLRPAG
			EndIf
			
			IIF(Len(aDados) >= 25,aAdd(aDados[25], aclone(aCpo25[1])),aAdd(aDados, aclone(aCpo25)))
			IIF(Len(aDados) >= 26,aAdd(aDados[26], aclone(aCpo26[1])),aAdd(aDados, aclone(aCpo26)))
			IIF(Len(aDados) >= 27,aAdd(aDados[27], aclone(aCpo27[1])),aAdd(aDados, aclone(aCpo27)))
			IIF(Len(aDados) >= 28,aAdd(aDados[28], aclone(aCpo28[1])),aAdd(aDados, aclone(aCpo28)))
			
			aAdd(aCpo25, {""})
			aAdd(aCpo26, {""})
			aAdd(aCpo27, {""})
			aAdd(aCpo28, {""})
			
		EndIf
		
		TrbBMR->(dbSkip())			
    End
    		
	aAdd(aCpo29, nDeb)  //Total de debitos
	aAdd(aCpo30, nCred) //Total de creditos
	aAdd(aCpo31, ((nGerLib-nDeb)+nCred)) // Total geral

	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)

	DbSelectArea("BH1")
	DbSelectArea("BH2")
	BH1->(dbSetOrder(1))
	BH2->(dbSetOrder(1))

	/*
	If BH1->(MsSeek(xFilial("BH1")))
		While ! BH1->(Eof())
			If (Empty(Alltrim(cRdaDe)) .or. BH1->BH1_RDADE >= TrbBMR->BMR_CODRDA) .and. ;
				(Empty(Alltrim(cRdaAte)) .or. BH1->BH1_RDAATE <= TrbBMR->BMR_CODRDA) //.and. ;
					
				If BH2->(MsSeek(xFilial("BH2")+BH1->BH1_CODIGO))
					While ! BH2->(Eof()) .And. (BH1->BH1_CODIGO == BH2->BH2_CODIGO)
						aAdd(aCpo32, BH2->BH2_MSG01)
						BH2->(dbSkip())
					End
				EndIf
			Else
				aAdd(aCpo32, "")
			EndIf
			BH1->(dbSkip())
		End
	EndIf
	*/
	
	//TODO: Alterar a mensagem e incluir novo tipo 'Demonstrativo prest.'
	aAdd(aCpo32, "")
	
	aAdd(aDados, aCpo32)
    
    aAdd(aDadosTot,aDados)
    aDados := {}
    nCont := 0
End

TrbBMR->(DbCloseArea())

Return aDadosTot
