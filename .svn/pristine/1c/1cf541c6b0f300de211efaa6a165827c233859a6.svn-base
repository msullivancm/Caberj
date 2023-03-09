//Data     : 13/01/2009
//Tecnico  : Luiz Alves Felizardo
//Descricao: Relatorio de negociacoes realizadas, canceladas e em andamento

***********************
User Function CABR092()
***********************

   Local cDesc1  := "Este programa tem como objetivo imprimir relatorio "
   Local cDesc2  := "negociacoes realizadas, canceladas e em andamento"
   Local cDesc3  := "de acordo com os parametros informados pelo usuario."
   Local cPict   := ""
   Local titulo  := "Negociações"
   Local nLin    := 80
   Local Cabec1  := "Cliente                                          Cod.                                                                               Valor       Quant.          Valor     Parcelas          Valor     Parcelas         Total"
   Local Cabec2  := "                                                 Plano                                                                           Original     Parcelas      Negociado        Pagas           Pago    Em Aberto     Em Aberto"
                   //          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21         
                   //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678900123456789
   Local imprime := .T.
   Local aOrd    := {}

   Private lEnd     := lAbortPrint  := .F.
   Private CbTxt    := ""
   Private limite   := 220
   Private tamanho  := "G"
   Private nomeprog := "CABR92" // Coloque aqui o nome do programa para impressao no cabecalho
   Private nTipo    := 18
   Private aReturn  := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
   Private nLastKey := 0
   Private cbtxt    := Space(10)
   Private cbcont   := 00
   Private CONTFL   := m_pag := 01
   Private wnrel    := "CABR92"
   Private cPerg    := "CABR92"
   
   fCriaSX1()
   
   Pergunte(cPerg, .T.)
   
   DBSelectArea("SE1")
   SE1->(DBSetOrder(1))
   
   wnrel := SetPrint("SE1", NomeProg, cPerg, @titulo, cDesc1, cDesc2, cDesc3, .F., aOrd, .T., Tamanho, , .T.)
   If nLastKey == 27
	   Return(.F.)
   EndIf

   SetDefault(aReturn, "SE1")
   If nLastKey == 27
      Return(.F.)
   EndIf

   nTipo := If(aReturn[4] == 1, 15, 18)

   RptStatus({|| RunReport(Cabec1, Cabec2, Titulo, nLin)}, Titulo)
Return(.T.)


*******************************************************
Static Function RunReport(Cabec1, Cabec2, Titulo, nLin)
*******************************************************
	Local cTabSE1 := RetSqlName("SE1")
	Local cTabBSQ := RetSqlName("BSQ")
	Local cFilSE1 := xFilial("SE1")
	Local cFilBSQ := xFilial("BSQ")
   
	lIncluir	:= .T.
	cCriterio	:= ""
	nQuant		:= nTotal	:= nQuantPG		:= nQuantAB		:= nTotalPG		:= nTotalAB		:= nTotOri		:= 0
	nQuantGR	:= nTotalGR	:= nQuantPGGR	:= nQuantABGR	:= nTotalPGGR	:= nTotalABGR	:= nTotOriGR	:= 0   

	cQry := "SELECT DISTINCT NUMNEG, CLIENTE, NOME, PLANO, TMPPLANO FROM CABE010R3, " + RetSqlName("BBT")
	cQry += " WHERE BBT_CLIFOR = CLIENTE AND BBT_NUMTIT = NUMERO AND BBT_PREFIX = PREFIXO AND BBT_PARCEL = PARCELA AND BBT_TIPTIT = TIPO"
	cQry += " AND BBT_CODPLA = SUBSTR(PLANO, 1, 4) AND " + RetSqlName("BBT") + ".D_E_L_E_T_ = ' ' "
	cQry += " AND SUBSTR(PLANO, 1, 4) BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' "
	cQry += " AND BBT_CODOPE||BBT_CODEMP||BBT_MATRIC BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "' "
	cQry += " AND CLIENTE BETWEEN '" + mv_par06 + "' AND '" + mv_par07 + "' "
	cQry += " GROUP BY NUMNEG, CLIENTE, NOME, PLANO, TMPPLANO"

	If Select("TMP1") > 0 ; TMP1->(DbCloseArea()) ; Endif
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP1", .F., .T.)

    nRec := 0
    TMP1->(DbGoTop())
    TMP1->(DbEval({||nRec++}))
    TMP1->(DbGoTop())

	SetRegua(nRec)

	While TMP1->(!Eof())

		IncRegua()

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		If nLin > 55
			Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
			nLin := 8
		EndIf      

		nQuant := nTotal := nQuantPG := nQuantAB := nTotalPG := nTotalAB := 0

		cQry :="SELECT BSQ_VALOR AS VALOR, NVL(BSQ_MES, '  ')||'/'||NVL(BSQ_ANO, '    ') AS MESANO, "
		cQry +="NVL(BSQ_VALOR - (SE1B.E1_SALDO * BSQ_VALOR / SE1B.E1_VALOR), 0) AS BAIXADO "
		cQry +="FROM " + cTabSE1 + " SE1A "

		cQry +="LEFT JOIN " + cTabBSQ + " BSQ ON "
		cQry +="	BSQ_PREORI = SE1A.E1_PREFIXO "
		cQry +="AND BSQ_NUMORI = SE1A.E1_NUM "
		cQry +="AND BSQ_PARORI = SE1A.E1_PARCELA "
		cQry +="AND BSQ_TIPORI = SE1A.E1_TIPO "

		cQry +="LEFT JOIN " + cTabSE1 + " SE1B ON "
		cQry +="	SE1B.E1_PREFIXO	= BSQ_PREFIX "
		cQry +="AND SE1B.E1_NUM		= BSQ_NUMTIT "
		cQry +="AND SE1B.E1_PARCELA	= BSQ_PARCEL "
		cQry +="AND SE1B.E1_TIPO	= BSQ_TIPTIT "
		cQry +="AND SE1B.E1_FILIAL	= '" + cFilSE1 + "' "

		cQry +="WHERE"
		cQry +="	BSQ.D_E_L_E_T_	= ' ' "
		cQry +="AND (SE1B.D_E_L_E_T_ = ' ' OR SE1B.D_E_L_E_T_ IS NULL) "
		cQry +="AND BSQ.BSQ_FILIAL	= '" + cFilBSQ + "' "
		cQry +="AND SE1A.E1_FILIAL	= '" + cFilSE1 + "' "
		cQry +="AND SE1A.R_E_C_N_O_ IN "
		cQry +="    ( "
		cQry +="        SELECT MAX(R_E_C_N_O_) "
		cQry +="        FROM SE1010 "
		cQry +="        WHERE "
		cQry +="        	E1_XNUMNEG	= '" + TMP1->NUMNEG + "' "
		cQry +="        AND E1_TIPO	= 'PR' "
		cQry +="        GROUP BY "
		cQry +="            E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "
		cQry +="    ) "
		cQry +="ORDER BY BSQ_ANO, BSQ_MES"

		If Select("TMP2") > 0 ; TMP2->(DbCloseArea()) ; EndIf
		DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP2", .F., .T.)

		cQry := "SELECT E1_VALOR FROM " + cTabSE1 + " WHERE E1_TIPO = 'FT' AND E1_FILIAL = '" + cFilSE1 + "' AND "
		cQry += cTabSE1 + ".D_E_L_E_T_ = ' ' AND E1_XNUMNEG = '" + TMP1->NUMNEG + "'"
		
		If Select("TMP3") > 0 ; TMP3->(DbCloseArea()) ; EndIf
		DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP3", .F., .T.)

		While !TMP2->(Eof())

			If lAbortPrint
				@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
				Exit
			EndIf

			If nLin > 55
				Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
				nLin := 8
			EndIf 

			nQuant++

			If mv_par03 == 2
				nLin++
				@nLin,000 PSay TMP1->(CLIENTE + " " + NOME)
				@nLin,049 PSay TMP1->PLANO
				@nLin,085 PSay TMP2->MESANO
//				@nLin,140 PSay nQuant							Picture "@E 9999999999"
				@nLin,153 PSay TMP2->VALOR						Picture "@E 9,999,999.99"
//				@nLin,168 PSay nQuantPG							Picture "@E 9999999999"
				@nLin,181 PSay TMP2->BAIXADO					Picture "@E 9,999,999.99"
//				@nLin,196 PSay nQuantAB							Picture "@E 9999999999"
				@nLin,208 PSay TMP2->VALOR - TMP2->BAIXADO		Picture "@E 9,999,999.99"
			EndIf

			If TMP2->VALOR - TMP2->BAIXADO > 0
				nQuantAB++
			EndIf
			
			If TMP2->BAIXADO > 0
				nQuantPG++
			EndIf

			nTotal		+= TMP2->VALOR
			nTotalPG	+= TMP2->BAIXADO
			nTotalAB	+= TMP2->VALOR - TMP2->BAIXADO

			TMP2->(DBSkip())
		EndDo
		
		TMP2->(DBCloseArea())

		IncRegua()

		If nQuant > 0
			nLin++
			If mv_par03 == 1
				@nLin,000 PSay TMP1->(CLIENTE + " " + NOME)
				@nLin,049 PSay TMP1->PLANO
			Else 
				@nLin,000 PSay Replicate("-", 220)
				nLin++
				@nLin,000 PSay "Total Cliente:"
            EndIf

			nTotOri := TMP3->E1_VALOR
			@nLin,125 PSay nTotOri	Picture "@E 9,999,999.99"
			@nLin,140 PSay nQuant	Picture "@E 9999999999"
			@nLin,153 PSay nTotal	Picture "@E 9,999,999.99"
			@nLin,168 PSay nQuantPG	Picture "@E 9999999999"
			@nLin,181 PSay nTotalPG	Picture "@E 9,999,999.99"
			@nLin,196 PSay nQuantAB	Picture "@E 9999999999"
			@nLin,208 PSay nTotalAB	Picture "@E 9,999,999.99"

			If mv_par03 == 2
				nLin++
				@nLin,000 PSay Replicate("-", 220)
				nLin += 2
			EndIf

			nTotOriGR	+= nTotOri
			nQuantGR	+= nQuant
			nTotalGR	+= nTotal
			nQuantPGGR	+= nQuantPG
			nTotalPGGR	+= nTotalPG
			nQuantABGR	+= nQuantAB
			nTotalABGR	+= nTotalAB

		EndIf

		TMP3->(dbCloseArea())
		TMP1->(DBSkip())
	EndDo

	TMP1->(DBCloseArea())

//	nLin++
	@nLin,000 PSay Replicate("-", 220)
	nLin++

	@nLin,000 PSay "Total Geral"
	@nLin,125 PSay nTotOriGR	Picture "@E 9,999,999.99"
	@nLin,140 PSay nQuantGR		Picture "@E 9999999999"
	@nLin,153 PSay nTotalGR		Picture "@E 9,999,999.99"
	@nLin,168 PSay nQuantPGGR	Picture "@E 9999999999"
	@nLin,181 PSay nTotalPGGR	Picture "@E 9,999,999.99"
	@nLin,196 PSay nQuantABGR	Picture "@E 9999999999"
	@nLin,208 PSay nTotalABGR	Picture "@E 9,999,999.99"

	nLin++
	@nLin,000 PSay Replicate("-", 220)

	SET DEVICE TO SCREEN

	If aReturn[5] == 1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

Return(.T.)


//************************
Static Function fCriaSX1()
//************************

Local lI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	aPergs	:= {}
	lAltera	:= .F.

	aAdd(aPergs, {"01", "Plano de........?", "", "", "mv_ch1", "C", 08, 0, 0, "G", "", "mv_par01", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "BI3", ""})
	aAdd(aPergs, {"02", "Plano até.......?", "", "", "mv_ch2", "C", 08, 0, 0, "G", "", "mv_par02", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "BI3", ""})
	aAdd(aPergs, {"03", "Tipo............?", "", "", "mv_ch3", "N", 01, 0, 0, "C", "", "mv_par03", "Sintetico", "", "", "", "", "Analitico", "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
	aAdd(aPergs, {"04", "Matrícula de....?", "", "", "mv_ch4", "C", 14, 0, 0, "G", "", "mv_par04", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
	aAdd(aPergs, {"05", "Matrícula até...?", "", "", "mv_ch5", "C", 14, 0, 0, "G", "", "mv_par05", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
	aAdd(aPergs, {"06", "Cliente de......?", "", "", "mv_ch6", "C", 06, 0, 0, "G", "", "mv_par06", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "SA1", ""})
	aAdd(aPergs, {"07", "Cliente até.....?", "", "", "mv_ch7", "C", 06, 0, 0, "G", "", "mv_par07", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "SA1", ""})

	SX1->(DBSetOrder(1))
   
	For lI := 1 To Len(aPergs)
		lAltera := SX1->(DBSeek(cPerg+aPergs[lI][1]))
		RecLock("SX1", !lAltera)
		SX1->X1_GRUPO   := cPerg
		SX1->X1_ORDEM   := aPergs[lI][01]
		SX1->X1_PERGUNT := aPergs[lI][02]
		SX1->X1_PERSPA  := aPergs[lI][03]
		SX1->X1_PERENG  := aPergs[lI][04]
		SX1->X1_VARIAVL := aPergs[lI][05]
		SX1->X1_TIPO    := aPergs[lI][06]
		SX1->X1_TAMANHO := aPergs[lI][07]
		SX1->X1_DECIMAL := aPergs[lI][08]
		SX1->X1_PRESEL  := aPergs[lI][09]
		SX1->X1_GSC     := aPergs[lI][10]
		SX1->X1_VALID   := aPergs[lI][11]
		SX1->X1_VAR01   := aPergs[lI][12]
		SX1->X1_DEF01   := aPergs[lI][13]
		SX1->X1_DEFSPA1 := aPergs[lI][14]
		SX1->X1_DEFENG1 := aPergs[lI][15]
		SX1->X1_CNT02   := aPergs[lI][16]
		SX1->X1_VAR02   := aPergs[lI][17]
		SX1->X1_DEF02   := aPergs[lI][18]
		SX1->X1_DEFSPA2 := aPergs[lI][19]
		SX1->X1_DEFENG2 := aPergs[lI][20]
		SX1->X1_CNT02   := aPergs[lI][21]
		SX1->X1_VAR03   := aPergs[lI][22]
		SX1->X1_DEF03   := aPergs[lI][23]
		SX1->X1_DEFSPA3 := aPergs[lI][24]
		SX1->X1_DEFENG3 := aPergs[lI][25]
		SX1->X1_CNT03   := aPergs[lI][26]
		SX1->X1_VAR04   := aPergs[lI][27]
		SX1->X1_DEF04   := aPergs[lI][28]
		SX1->X1_DEFSPA4 := aPergs[lI][29]
		SX1->X1_DEFENG4 := aPergs[lI][30]
		SX1->X1_CNT04   := aPergs[lI][31]
		SX1->X1_VAR05   := aPergs[lI][32]
		SX1->X1_DEF05   := aPergs[lI][33]
		SX1->X1_DEFSPA5 := aPergs[lI][34]
		SX1->X1_DEFENG5 := aPergs[lI][35]
		SX1->X1_CNT05   := aPergs[lI][36]
		SX1->X1_F3      := aPergs[lI][37]
		SX1->X1_PYME    := aPergs[lI][38]
		SX1->(MsUnlock())             
	Next lI

Return(.T.)