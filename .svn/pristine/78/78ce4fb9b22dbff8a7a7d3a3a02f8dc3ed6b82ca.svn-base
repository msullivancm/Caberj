#Include "PLSMGER.CH"

#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB := PLSRETLADC()

***********************
User Function CRJR998()
***********************

	Private nQtdLin	:= 64
	Private nCaracter	:= 15
	Private nLin	 	:= nLimite := Limite := 220
	Private m_pag     := 1
	Private cTamanho	:= Tamanho := "G"
	Private cTitulo	:= "Relatorio Gerencial de Pagamento de Associado"
	Private cNomeProg	:= "CRJR998"
	Private cDesc1		:= cDesc2 := cDesc3 := cCabec1 := cCabec2 := ""
	Private cAlias		:= "BA3"
	Private cPerg		:= "CRJ998"
	Private cRel		:= "CRJR998"
	Private aReturn	:= {"Zebrado", 1, "Administracao", 1, 1, 1, "", 1}
	Private aOrdens	:= {"Codigo do plano"}
	Private lDicion	:= lCompres := lCrystal := lAbortPrint := .F.
	Private lFiltro	:= .T.
	Private aDescMot  := {{"NOR", "NORMAL"              },;
                         {"DAC", "DACAO"               },;
                         {"DEV", "DEVOLUCAO"           },;
                         {"DEB", "DEBITO CC"           },;
                         {"LOJ", "OUTRA LOJA"          },;
                         {"CAN", "CANCELAMENTO"        },;
                         {"NEG", "NEGOCIACAO"          },;                                                                                                            
                         {"DPJ", "DEPOSITO JUDICIAL"   },;
                         {"BNF", "BAIXA NAO FINANCEIRA"},;
                         {"CMP", "COMPENSAÇÃO"         },;
                         {"FAT", "BAIXA POR FATURA"    },;                                                  
                         {"REE", "REEMBOLSO"           }}

	CriaSX1()

	cRel := SetPrint(cAlias, cRel, cPerg, @cTitulo, cDesc1, cDesc2, cDesc3, lDicion, aOrdens, lCompres, "G", {}, lFiltro, lCrystal)

	//Verifica se foi cancelada a operacao
	If nLastKey  == 27
		Return
	Endif

	//Recebe parametros
	Pergunte(cPerg, .F.)

	cOpe      := mv_par01
	dBaixaDe  := mv_par02
	dBaixaAte := mv_par03
	dVencDe   := mv_par04
	dVencAte  := mv_par05
	cCodPlaI  := mv_par06
	cCodPlaF  := mv_par07
	nTipo     := mv_par08
	lListTit	 := (mv_par09 == 1)
	nConsid	 := mv_par10
	nIdent    := mv_par11
	cNumTit   := AllTrim(mv_par12)
	cMotDe    := mv_par13
	cMotAte   := mv_par14

   //Sintetico
   If nTipo == 2
      lListTit := .T.
   Endif

   cCabec1 := "Plano                                                                                                                                                                                                                 "
	cCabec2 := "Referencia      Motivo    Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartão       Outros          Liquido          Baixado"

	cTitulo := AllTrim(cTitulo) + " - " + "Referencia " + dToc(dBaixaDe) + " a " + dToc(dBaixaAte) + ' - Motivos de Baixa Sem Movto. Bancario.'

	//Configura Impressora
	SetDefault(aReturn, cAlias)

	//Monta RptStatus
	Proc2BarGauge({|| aCriticas := RJ002Imp()}  , "Imprimindo...")
Return

**************************
Static Function RJ002Imp()
**************************

Local i 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nRat 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nH 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

   //Variaveis do IndRegua
	Local I         := N := 0
	Local nTotMen	 := nTotOpc   := nTotAde  := nTotDeb  := nTotCre   := nTotPar  := nTotTax   := nTotTar   := nTotPla   :=;
	      nTotFar   := nTotPF    := nTotOut  := nTotJur  := nTotTit   := nTotal   := nPos      := nPosTit   := nPosPla   :=;
	      nTotGMen  := nTotGOpc  := nTotGAde := nTotGDeb := nTotGCre  := nTotGPF  := nTotGTar  := nTotGFar  := nTotGOut  :=;
	      nTotGBai  := nTotGJur  := nTotGGui := nTotGui  := nTotCar   := nTotGCar := nTotGeral := nTotLinha := nTotGrupo :=;
	      nTotBaixa := nTotPMen  := nTotPOpc := nTotPAde := nTotPDeb  := nTotPCre := nTotPPf   := nTotPTar  := nTotPFar  :=;
	      nTotPJur  := nTotPOut  := nTotPGui := nTotPCar := nTotPGrp  := nTotPBai := nVenMen   := nVenOpc   := nVenAde   :=;
	      nVenDeb   := nVenCre   := nVenPF   := nVenTar  := nVenFar   := nVenJur  := nVenGui   := nVenCar   := nVenOut   :=;
	      nVenGrupo := nVenBaixa := nRat     := nH       := nBaixaDac := 0
	Local _cCodPla	 := _cVerPla := cPrefixNE5 := ""                           
   Local lLog      := .F.
	Local pMoeda1	 := "@E           9,999,999.99"
	Local pMoeda2	 := "@E       9,999,999,999.99"
	Local pMoeda3	 := "@E 999,999,999,999,999.99"
	Local aTitulos	 := {}
	Local aPlaUsr	 := {}
	Local aSomaMot  := {}
	Local aSomaTMot := {}
   Local aCampoTRB := {{"TR1_CODIGO", "C", TamSX3("BM1_CODPLA")[1], 0},;
                       {"TR1_DESCRI", "C", TamSX3("BM1_DESPLA")[1], 0},;
                       {"TR1_ANO"   , "C", TamSX3("BM1_ANO")[1]   , 0},;
                       {"TR1_MES"   , "C", TamSX3("BM1_MES")[1]   , 0},;
                       {"TR1_TIPCOB", "C", TamSX3("E1_FORMREC")[1], 0},;
                       {"TR1_BAIXA" , "D", 8                      , 0},;
                       {"TR1_VENCTO", "D", 8                      , 0},;
                       {"TR1_PREFIX", "C", TamSX3("E1_PREFIXO")[1], 0},;
                       {"TR1_NUM"   , "C", TamSX3("E1_NUM")[1]    , 0},;
                       {"TR1_PARCEL", "C", TamSX3("E1_PARCELA")[1], 0},;
                       {"TR1_TIPO"  , "C", TamSX3("E1_TIPO")[1]   , 0},;
                       {"TR1_VALTIT", "N", TamSX3("E1_VALOR")[1]  , 2},;
                       {"TR1_VLRBAI", "N", TamSX3("E1_VALOR")[1]  , 2},; 
                       {"TR1_TOTBAI", "N", TamSX3("E1_VALOR")[1]  , 2},;
                       {"TR1_NUMBCO", "C", TamSX3("E1_NUMBCO")[1] , 0},;
                       {"TR1_VLRMEN", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRDEB", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRCRE", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLROPC", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRTAX", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRPF" , "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRTAR", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRFAR", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRGUI", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRCAR", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLRJUR", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_VLROUT", "N", TamSX3("BM1_VALOR")[1] , 2},;
                       {"TR1_MOTBX" , "C", TamSX3("E5_MOTBX")[1]  , 0}}	

	//Exibe mensagem informativa
	IncProcG1("Aguarde. Buscando dados no servidor...")
	ProcessMessage()

	//Totalizadores por Empresa
	Private nTotCobEmp := nTotRegEmp := 0
	Private aQtdusrEmp := 0

	//Totalizadores por Contrato
	Private nTotCobCon := nTotRegCon := 0
	Private aQtdusrCon := 0

	//Totalizadores por SubContrato
	Private nTotCobSub := nTotRegSub := nVlrCob := 0
	Private aQtdusrSub := 0

	//Monta variaveis com os prefixos utilizados pelo SIGAPLS para gerar titulos no contas a receber
	SX5->(DBSetOrder(1))
	cPrefixos := ""
	If SX5->(DBSeek(xFilial("SX5")+"BK"))
		Do While !SX5->(Eof()) .And. Alltrim(SX5->X5_TABELA) == 'BK'
			cPrefixos += If(Empty(cPrefixos), "", ";") + AllTrim(SX5->X5_CHAVE)
			SX5->(dbSkip())
		EndDo
	EndIf

	//Lista todos os tipos de motivos de baixa que não efetivam movimentação bancária
	PlsQuery("SELECT DISTINCT E5_MOTBX FROM " + RetSqlName("SE5") + " WHERE E5_FILIAL = '" + xFilial("SE5") + "' AND E5_PREFIXO IN " + FormatIn(cPrefixos, ";") + " AND D_E_L_E_T_ = '' GROUP BY E5_MOTBX", "tmpSE5")
   Do While !tmpSE5->(Eof())
	   If !MovBcoBx(tmpSE5->E5_MOTBX, .F.)
	      cPrefixNE5 += If(Empty(cPrefixNE5), "", ";") + AllTrim(tmpSE5->E5_MOTBX)
	   EndIf   
	   tmpSE5->(DbSkip())
	EndDo
	tmpSE5->(DBCloseArea())

	//Monta Expressao de filtro
	cQuery := "SELECT E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_MOTBX, E5_DTDISPO, E5_VALOR, E5_DATA, E5_RECPAG, E5_SEQ, E5_TIPODOC "
	cQuery += "FROM " + RetSqlName("SE5") + ", " + RetSqlName("SE1") + " "	
	cQuery += "WHERE E5_FILIAL  = E1_FILIAL  AND "
	cQuery +=       "E5_PREFIXO = E1_PREFIXO AND "
	cQuery +=       "E5_NUMERO  = E1_NUM     AND "
	cQuery +=       "E5_PARCELA = E1_PARCELA AND "
	cQuery +=       "E5_TIPO    = E1_TIPO    AND "
	cQuery +=       "E1_FILIAL  = E5_FILIAL  AND "
	cQuery +=       "E1_FILIAL  = " + xFilial("SE5") + " AND "	
	cQuery +=       "E5_MOTBX IN " + FormatIn(cPrefixNE5, ";") + " AND "
//	cQuery +=       "E5_MOTBX <> '" + GetNewPar("MV_PLMOTBC", "CAN") + "'"  solicitação do fabio financeiro , para sair baixa por cancelamento 

	//Expressao de filtro da data da baixa e do vencimento
	If nConsid == 1
		cQuery += " ((E5_DATA 	between '" + DToS(dBaixaDe) + "' AND '" + DToS(dBaixaAte) + "') OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
		cQuery += " AND E5_DATA  >= '" + DToS(dBaixaDe) + "'"
	Else
		cQuery += " AND ((E5_DTDISPO  between '" + DToS(dBaixaDe) + "' AND '" + DToS(dBaixaAte) + "') OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
		cQuery += " AND E5_DTDISPO  >= '" + DToS(dBaixaDe) + "'"
	Endif

	cQuery += " AND E5_MOTBX between '" + cMotDe + "' AND '" + cMotAte + "'" 

	If lListTit
		cQuery += " AND E1_VENCTO	between '" + DToS(dVencDe) + "' AND '" + DToS(dVencAte)	+ "' "
	Endif

	If Empty(cNumTit)
		//Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
		cQuery += " AND E5_PREFIXO IN " + FormatIn(cPrefixos, ";")
		cQuery += " AND E5_NUMERO >= '      ' AND E5_NUMERO <= 'ZZZZZZ' "
	Else
		If nIdent == 1
			//Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
			cQuery += " AND E5_PREFIXO IN " + FormatIn(cPrefixos, ";")
			cQuery += " AND E5_NUMERO = '" + cNumTit + "' "
		Else
			//Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
			cQuery += " AND E1_PREFIXO IN " + FormatIn(cPrefixos, ";")
			cquery += " AND E1_NUMBCO = '" + cNumTit + "' "
		Endif		
	Endif                                                                           

	//Nao considera abatimentos
	cQuery += " AND E5_TIPO NOT IN " + FormatIn(MVABATIM, "|")
	cQuery += " AND E5_TIPODOC NOT IN ('DC','D2','JR','J2','TL','MT','M2','CM','C2','TR','TE') "
	cQuery += " AND " + RetSqlName("SE1") + ".D_E_L_E_T_ = ' '  "
	cQuery += " AND " + RetSqlName("SE5") + ".D_E_L_E_T_ = ' '  "

	// seta a ordem de acordo com a opcao do usuario
	cQuery += " ORDER BY E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ"
	PlsQuery(cQuery, "TRBSE1")

	BarGauge1Set(TRBSE1->(RecCount()))

	TRBSE1->(DbGoTop())

	BQC->(dbSetOrder(1))
	BFQ->(dbSetOrder(1))
	BI3->(dbSetorder(1))
	SE1->(dbSetorder(1))
	BA1->(dbSetorder(2))

	//Cria o Arquivo de Trabalho que armazenara os valores por produto
	cArqTRB := CriaTrab(aCampoTRB, .T.)
	dbUseArea(.T.,, cArqTRB, "TRB1", .F.) 
   cIndice := "TR1_CODIGO+TR1_ANO+TR1_MES+TR1_TIPCOB+TR1_VENCTO+"+IndexKey()
   Index on &cIndice To &cArqTRB

	//Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno
	cInd1TRB := CriaTrab(Nil, .F.)

	//Indice diferenciado para a opcao de impressao de titulos
	If lListTit
		If nIdent == 1
		   //Listar numero do titulo
			IndRegua("TRB1", cInd1TRB, "TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + DToS(TR1_VENCTO) + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO",,, "Indexando Arquivo de Trabalho")
		Else
		   //Listar nosso numero
			IndRegua("TRB1", cInd1TRB, "TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + DToS(TR1_VENCTO) + TR1_NUMBCO",,,"Indexando Arquivo de Trabalho")
		EndIf
	Else
		IndRegua("TRB1", cInd1TRB, "TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + DToS(TR1_VENCTO)",,, "Indexando Arquivo de Trabalho")
	EndIf

	// Indexa o arquico temporario
	TRB1->(DBClearIndex())
	TRB1->(DBSetIndex(cInd1TRB+OrdBagExt()))

	//Define matriz de planos
	aPlanos	:= {}
	cPreRat	:= cNumRat := cParRat := cTipRat := cChvTit := ""
 	
   Do While !TRBSE1->(Eof())
      lCanc  := .F.
      
      aArea := GetArea()
      
      cQuery := "SELECT R_E_C_N_O_ FROM " + RetSqlName("SE5") + " " +;
                "WHERE E5_FILIAL  = '" + TRBSE1->(E5_FILIAL)  + "' AND " +;
                      "E5_PREFIXO = '" + TRBSE1->(E5_PREFIXO) + "' AND " +;
                      "E5_NUMERO  = '" + TRBSE1->(E5_NUMERO)  + "' AND " +;
                      "E5_PARCELA = '" + TRBSE1->(E5_PARCELA) + "' AND " +;
                      "E5_TIPO    = '" + TRBSE1->(E5_TIPO)    + "' AND " +;
                      "E5_CLIFOR  = '" + TRBSE1->(E5_CLIFOR)  + "' AND " +;
                      "E5_LOJA    = '" + TRBSE1->(E5_LOJA)    + "' AND " +;
                      "E5_SEQ     = '" + TRBSE1->(E5_SEQ)     + "' AND " +;
                      "E5_TIPODOC = 'ES'"
      PlsQuery(cQuery, "TRBSE5")
      
      If !TRBSE5->(Eof())
      	TRBSE5->(DBCloseArea())
         RestArea(aArea)
         TRBSE1->(DBSkip())
         Loop
      EndIf
      
      TRBSE5->(DBCloseArea())
      
      RestArea(aArea)
      
		//Verifica se o titulo sofreu movimentacao
		lCanc   := lDac := .F.
		nBaixa  := TRBSE1->E5_VALOR
		cPrefix := TRBSE1->E5_PREFIXO
		cNum    := TRBSE1->E5_NUMERO
		cParcel := TRBSE1->E5_PARCELA
		cTipo   := TRBSE1->E5_TIPO
		cCLi    := TRBSE1->E5_CLIFOR
		cLoja   := TRBSE1->E5_LOJA
		cSeq    := TRBSE1->E5_SEQ
		cMotBx  := TRBSE1->E5_MOTBX
	
		If nConsid == 1
		   //Considera data da baixa
			dData := TRBSE1->E5_DATA
		Else
		   //Considera data da disponibilizacao
			dData := TRBSE1->E5_DTDISPO
		Endif
		
      //Posiciona o SE1 novamente
      SE1->(DBSeek(xFilial("SE1")+cPrefix+cNum+cParcel+cTipo))
		
      _cAno   := SE1->E1_ANOBASE
      _cMes   := SE1->E1_MESBASE
      nQtd    := 0
      aRateio := {}
      lRateio := lFracao := .F.
		
      //Caso seja uma baixa parcial e exista mais de um produto na composicao do titulo, o valor da baixa devera
      //Ser fracionado durante o rateio do valor da baixa entre os planos
      lFracao := ((SE1->E1_VALOR - nBaixa) > 0)
		
      IncProcG1("Processando titulo - " + SE1->(E1_PREFIXO + '.' + E1_NUM + '.' + E1_PARCELA + E1_TIPO))
      ProcessMessage()
      
      //Verifico se existe mais de um produto na
      //Composicao do titulo e caso exista, realizo o rateio do valor da baixa
      cSql := " SELECT DISTINCT(" + RetSqlName("BM1") + ".BM1_CODPLA) "
      cSql += " FROM  " + RetSqlName("BM1") + " "
      cSql += " WHERE BM1_FILIAL = '" + xFilial("BM1") + "' AND "
      cSql +=        "BM1_PREFIX = '" + cPrefix        + "' AND "
      cSql +=        "BM1_NUMTIT = '" + cNum           + "' AND "
      cSql +=        "BM1_PARCEL = '" + cParcel        + "' AND "
      cSql +=        "BM1_TIPTIT = '" + cTipo          + "' AND "
      cSql +=        "BM1_CODPLA between '" + cCodPlaI + "' AND '" + cCodPlaF + "' AND "
      cSql +=        "D_E_L_E_T_ <> '*' "

      PlsQuery(cSql, "TRB")
		
      If TRB->(RecCount()) > 1
        //Deve ter pelo menos 2 planos para que seja necessario fazer o rateio
        lRateio := .T.
      EndIf
		
      TRB->(dbCloseArea())
		
      cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_DESTIP, BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BM1_TIPO "
      cSql += "FROM  " + RetSqlName("BM1") + " "
      cSql += "WHERE BM1_FILIAL = '" + xFilial("BM1") + "' AND "
      cSql +=       "BM1_PREFIX = '" + cPrefix        + "' AND "
      cSql +=       "BM1_NUMTIT = '" + cNum           + "' AND "
      cSql +=       "BM1_PARCEL = '" + cParcel        + "' AND "
      cSql +=       "BM1_TIPTIT = '" + cTipo          + "' AND "
      cSql +=       "BM1_CODPLA between '" + cCodPlaI + "' AND '" + cCodPlaF + "' AND "
      cSql +=       "D_E_L_E_T_ <> '*' "
      cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
		
      PlsQuery(cSql, "TRB")

      BarGauge2Set(TRB->(RecCount()))
		
      aPlaUsr := {}
      cChvTit := ""

      Do While !TRB->(Eof())
         //Apresenta mensagem em tela
         IncProcG2("Processando familia - " + BA3->(BA3_CODINT + '.' + BA3_CODEMP + '.' + BA3_MATRIC))
         ProcessMessage()

         //Posiciona a familia do usuario
         If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
            BA3->(MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)))
         EndIf

         //Posiciona o usuario
         If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
            BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)))
         EndIf

         //Defini qual o plano do usuario
         _cCodPla := _cVerPla := ""

         //Regra numero um: Utiliza o plano do BM1.
         If !Empty(TRB->BM1_CODPLA) .And. !Empty(TRB->BM1_VERPLA)
            _cCodPla := TRB->BM1_CODPLA
            _cVerPla := TRB->BM1_VERPLA
         EndIf
			
         //Regra numero tres: Utiliza o plano do usuario ou da familia.
         If Empty(_cCodPla)
            If !Empty(BA1->BA1_CODPLA)
               _cCodPla := BA1->BA1_CODPLA
               _cVerPla := BA1->BA1_VERSAO
            Else
               _cCodPla := BA3->BA3_CODPLA
               _cVerPla := BA3->BA3_VERSAO
            EndIf
         EndIf
						
         //Verifica se foi abortada a impressao
         If Interrupcao(lAbortPrint)
            Exit
         EndIf
			
         //Posiciona o produto
         BI3->(MsSeek(xFilial("BA3")+BA3->BA3_CODINT+_cCodPla))

         //Alimenta o arquivo temporario
         If nIdent == 1
            //Lista numero do titulo
            cChave := _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
         Else 
            //Lista nosso numero
            cChave := _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) + IIf(!Empty(SE1->E1_NUMBCO), SE1->E1_NUMBCO, SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
         EndIf

         //Procura registro no arquivo temporário
         lFound := TRB1->(MsSeek(cChave))
			
         TRB1->(RecLock("TRB1", !lFound))
         
         If !lFound
            TRB1->TR1_CODIGO := _cCodPla
            TRB1->TR1_DESCRI := BI3->BI3_DESCRI
            TRB1->TR1_ANO    := _cAno
            TRB1->TR1_MES    := _cMes
            TRB1->TR1_VLRTAR := SE1->E1_DECRESC
            TRB1->TR1_BAIXA  := dData
            TRB1->TR1_VENCTO := SE1->E1_VENCTO
            TRB1->TR1_TIPCOB := SE1->E1_FORMREC
            TRB1->TR1_PREFIX := SE1->E1_PREFIXO
            TRB1->TR1_NUM    := SE1->E1_NUM
            TRB1->TR1_PARCEL := SE1->E1_PARCELA
            TRB1->TR1_TIPO   := SE1->E1_TIPO
            TRB1->TR1_VALTIT := SE1->E1_VALOR
            TRB1->TR1_TOTBAI := nBaixa
            TRB1->TR1_MOTBX  := cMotBx
				
            //Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio
            If !lRateio .And. lListTit
               TRB1->TR1_VLRBAI := nBaixa
            Endif
				
            If !Empty(SE1->E1_NUMBCO)
               TRB1->TR1_NUMBCO := SE1->E1_NUMBCO
            Else
               TRB1->TR1_NUMBCO := SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
            EndIf
         EndIf
			
         //Atualiza matriz com valores do plano
         //Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio
         If !lRateio .And. !lListTit .And. TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT) <> cChvTit
            TRB1->TR1_VLRBAI += nBaixa
            cChvTit := TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)
         EndIf

         Do Case
            Case TRB->BM1_CODTIP $ '101,118'  //Mensalidade
               TRB1->TR1_VLRMEN += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP $ '102,133'	 //Opcionais
               TRB1->TR1_VLROPC += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP == '103'		 //Taxa de adesao
               TRB1->TR1_VLRTAX += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP == '909'		 //Guia medico
               TRB1->TR1_VLRGUI += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP $ '107, 908' //Cartao de identificaçao
               TRB1->TR1_VLRCAR += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP $ cCodigosPF //Co-participacoes...
               TRB1->TR1_VLRPF  += TRB->BM1_VALOR

            Case AllTrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
               TRB1->TR1_VLRFAR += TRB->BM1_VALOR

            Case AllTrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993")	// Juros...
               TRB1->TR1_VLRJUR += TRB->BM1_VALOR

            Case TRB->BM1_CODTIP $ cCodDB		//Debitos / creditos...
               If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
                  If BFQ->BFQ_DEBCRE == '2' 	//Credito.
                     TRB1->TR1_VLRCRE += TRB->BM1_VALOR
                  Elseif BFQ->BFQ_DEBCRE == '1' //Debitos.
                     TRB1->TR1_VLRDEB += TRB->BM1_VALOR
                  Endif
               Endif

            OtherWise
               TRB1->TR1_VLROUT += TRB->BM1_VALOR
         EndCase
			
         //Libera o registro
         TRB1->(MsUnlock())
			
         //Acumula o valor de cada plano para calcular as partes do rateio...
         If lRateio
            If (nPos := Ascan(aRateio, {|x| x[1] == cChave})) == 0
               Aadd(aRateio, {cChave, IIf(TRB->BM1_TIPO == '1', TRB->BM1_VALOR, (TRB->BM1_VALOR * -1)), 0})
            Else
               If TRB->BM1_TIPO == '1'
                  aRateio[nPos][2] += TRB->BM1_VALOR
               Else
                  aRateio[nPos][2] -= TRB->BM1_VALOR
               Endif
            Endif
         Endif
			
         //Acessa o proximo registro
         TRB->(DbSkip())
      EndDo
		
      //Realiza o rateio e grava no arquivo temporario a parte referente a cada plano que compoem o titulo...
      If lRateio .And. Len(aRateio) > 0
         For nH := 1 To Len(aRateio)
            If lFracao
               nFracao := Round(aRateio[nH][2] / SE1->E1_VALOR,17)
               nRat    := Round((nFracao * nBaixa), 2)
            Else
               nRat    := aRateio[nH][2]
            Endif

            If TRB1->(MsSeek(aRateio[nH][1])) // Procura registro no arquivo temporario...
               TRB1->(RecLock("TRB1", .F.))
               TRB1->TR1_VLRBAI := nRat
               TRB1->(MsUnlock())
            Endif
         Next
      Endif
	
      TRB->(DBCloseArea())
      TRBSE1->(DBSkip())
   EndDo
   
   //Ajuste de rateio por coluna
   TRB1->(DBGotop())
   Do While !TRB1->(Eof())
      If TRB1->TR1_VLRBAI < TRB1->TR1_VALTIT
         //Calcula o fator...
         nFator := (TRB1->TR1_VLRBAI / TRB1->TR1_VALTIT)

         // Altera os aplicando o fator sobre os valores ja apurados...
         TRB1->(RecLock("TRB1", .F.))
         TRB1->TR1_VLRMEN := Round((TRB1->TR1_VLRMEN * nFator), 2)
         TRB1->TR1_VLROPC := Round((TRB1->TR1_VLROPC * nFator), 2)
         TRB1->TR1_VLRTAX := Round((TRB1->TR1_VLRTAX * nFator), 2)
         TRB1->TR1_VLRDEB := Round((TRB1->TR1_VLRDEB * nFator), 2)
         TRB1->TR1_VLRCRE := Round((TRB1->TR1_VLRCRE * nFator), 2)
         TRB1->TR1_VLRPF  := Round((TRB1->TR1_VLRPF  * nFator), 2)
         TRB1->TR1_VLRTAR := Round((TRB1->TR1_VLRTAR * nFator), 2)
         TRB1->TR1_VLRFAR := Round((TRB1->TR1_VLRFAR * nFator), 2)
         TRB1->TR1_VLRJUR := Round((TRB1->TR1_VLRJUR * nFator), 2)
         TRB1->TR1_VLRGUI := Round((TRB1->TR1_VLRGUI * nFator), 2)
         TRB1->TR1_VLRCAR := Round((TRB1->TR1_VLRCAR * nFator), 2)

         //Recalcula valores
         nTotal := TRB1->(TR1_VLRMEN + TR1_VLROPC + TR1_VLRTAX + TR1_VLRDEB + TR1_VLRCRE + TR1_VLRPF + TR1_VLRTAR + TR1_VLRFAR + TR1_VLRJUR + TR1_VLRGUI + TR1_VLRCAR)
					
         //É possível existir diferença de centavos em função do fator					
         nDif   := TRB1->TR1_VLRBAI - nTotal 
					           
         //Se existir diferença, adiciona na coluna de contra prestação
         If nDif > 0
            TRB1->TR1_VLRMEN += nDif
         EndIf
         TRB1->(MsUnlock())
      EndIf
      TRB1->(DBSkip())
   EndDo
   
   aSort(aSomaMot, , , { |x, y| x[2] < y[2] })

   nTotPMen  := nTotPOpc  := nTotPAde  := nTotPDeb  := nTotPCre  := nTotPPF     := nTotPTar    :=;
   nTotPFar  := nTotPJur  := nTotPGui  := nTotPCar  := nTotPOut  := nTotPGrupo  := nTotPBaixa  := 0 
   
   nTotVMen  := nTotVOpc  := nTotVAde  := nTotVDeb  := nTotVCre  := nTotVPF     := nTotVTar    :=;
   nTotVFar  := nTotVJur  := nTotVGui  := nTotVCar  := nTotVOut  := nTotVGrupo  := nTotVBaixa  := 0
   
   nTotTcMen := nTotTcOpc := nTotTcAde := nTotTcDeb := nTotTcCre := nTotTcPF    := nTotTcTar   :=;
   nTotTcFar := nTotTcJur := nTotTcGui := nTotTcCar := nTotTcOut := nTotTcGrupo := nTotTcBaixa := 0
   
   nTotGMen  := nTotGOpc  := nTotGAde  := nTotGDeb  := nTotGCre  := nTotGPF     := nTotGTar    :=;
   nTotGFar  := nTotGJur  := nTotGGui  := nTotGCar  := nTotGOut  := nTotGGrupo  := nTotGBaixa  := 0
   
   nTotAmMen := nTotAmOpc := nTotAmAde := nTotAmDeb := nTotAmCre := nTotAmPF    := nTotAmTar   :=;
   nTotAmFar := nTotAmJur := nTotAmGui := nTotAmCar := nTotAmOut := nTotAmGrupo := nTotAmBaixa := 0   

   //Altera o titulo do relatorio
   cTitulo := "Relatorio Gerencial de Pagamento de Associado" + " - " + "Referencia " + dToc(dBaixaDe) + " a " + dToc(dBaixaAte)+' - Sem Movto. Bancario.'

   TRB1->(DBGotop())
   TRB1->(DBSetOrder(1))
   
   nLi        := 7
   nTipoLin   := 1
   cGrpVencto := cTitVencto := dToc(TRB1->TR1_VENCTO)
   cGrpAnoMes := cTitAnoMes := AllTrim(TRB1->TR1_ANO) + "/" + AllTrim(TRB1->TR1_MES)
   cGrpPlano  := cTitPlano  := TRB1->TR1_CODIGO
   cGrpTipoCB := cTitTipoCB := TRB1->TR1_TIPCOB
   bTitPlano  := .T. 
   bTitAnoMes := .T. 
   bTitTipoCB := .T. 
   bTitVenc   := .T.
   bTotPlano  := .F. 
   bTotAnoMes := .F. 
   bTotTipoCB := .F. 
   bTotVenc   := .F.
   
   Cabec(cTitulo, cCabec1, cCabec2, cNomeProg, "G", nCaracter)
   
   Do While !TRB1->(Eof())
      Do While !TRB1->(Eof()) .And. cGrpPlano == TRB1->TR1_CODIGO
         Do While !TRB1->(Eof()) .And. cGrpPlano+cGrpAnoMes == TRB1->(TR1_CODIGO+AllTrim(TR1_ANO)+"/"+AllTrim(TR1_MES))
            Do While !TRB1->(Eof()) .And. cGrpPlano+cGrpAnoMes+cGrpTipoCB == TRB1->(TR1_CODIGO+AllTrim(TR1_ANO)+"/"+AllTrim(TR1_MES)+TR1_TIPCOB)
               Do While !TRB1->(Eof()) .And. cGrpPlano+cGrpAnoMes+cGrpTipoCB+cGrpVencto == TRB1->(TR1_CODIGO+AllTrim(TR1_ANO)+"/"+AllTrim(TR1_MES)+TR1_TIPCOB+dToc(TR1_VENCTO))
                  Do Case 
                    Case nLi >= 48 //Emissão do rodapé
                        Roda(0, Space(10))
                        If !TRB1->(Eof())
                           Cabec(cTitulo, cCabec1, cCabec2, cNomeProg, "G", nCaracter)                        
                           nLi      := 7
                           nTipoLin := 1
                           Loop
                        EndIf
               
                     OtherWise
                        If bTotVenc
                           @nLi++         
                           @nLi,000 PSay Replicate('-', 220)
                           @nLi++            
                           @nLi,000 Psay "Total " + cTitVencto + ":"
                           @nLi,019 Psay Transform(nTotVMen  , pMoeda2)
                           @nLi,033 Psay Transform(nTotVOpc  , pMoeda1)
                           @nLi,046 Psay Transform(nTotVAde  , pMoeda1)
                           @nLi,059 Psay Transform(nTotVDeb  , pMoeda1)
                           @nLi,072 Psay Transform(nTotVCre  , pMoeda1)
                           @nLi,085 Psay Transform(nTotVPF   , pMoeda2)
                           @nLi,102 Psay Transform(nTotVTar  , pMoeda1)
                           @nLi,115 Psay Transform(nTotVFar  , pMoeda1)
                           @nLi,128 Psay Transform(nTotVJur  , pMoeda1)
                           @nLi,142 Psay Transform(nTotVGui  , pMoeda1)
                           @nLi,155 Psay Transform(nTotvCar  , pMoeda1)
                           @nLi,168 Psay Transform(nTotVOut  , pMoeda1)
                           @nLi,181 Psay Transform(nTotVGrupo, pMoeda2)
                           @nLi,198 Psay Transform(nTotVBaixa, pMoeda2)
                           @nLi++         
                           @nLi,000 PSay Replicate('-', 220)
                           nTotVMen   := nTotVOpc := nTotVAde := nTotVDeb := nTotVCre := nTotVPF    := nTotVTar   :=;
                           nTotVFar   := nTotVJur := nTotVGui := nTotVCar := nTotVOut := nTotVGrupo := nTotVBaixa := 0
                           bTotVenc   := .F.
                           cTitVencto := DtoC(TRB1->TR1_VENCTO)
                           Loop
                        EndIf

                        If bTotTipoCB
                           @nLi++         
                           @nLi,000 PSay Replicate('-', 220)
                           @nLi++            
                           @nLi,000 Psay "Total " + Left(cTitTipoCB, 20) + ":"
                           @nLi,019 Psay Transform(nTotTcMen  , pMoeda2)
                           @nLi,033 Psay Transform(nTotTcOpc  , pMoeda1)
                           @nLi,046 Psay Transform(nTotTcAde  , pMoeda1)
                           @nLi,059 Psay Transform(nTotTcDeb  , pMoeda1)
                           @nLi,072 Psay Transform(nTotTcCre  , pMoeda1)
                           @nLi,085 Psay Transform(nTotTcPF   , pMoeda2)
                           @nLi,102 Psay Transform(nTotTcTar  , pMoeda1)
                           @nLi,115 Psay Transform(nTotTcFar  , pMoeda1)
                           @nLi,128 Psay Transform(nTotTcJur  , pMoeda1)
                           @nLi,142 Psay Transform(nTotTcGui  , pMoeda1)
                           @nLi,155 Psay Transform(nTotTcCar  , pMoeda1)
                           @nLi,168 Psay Transform(nTotTcOut  , pMoeda1)
                           @nLi,181 Psay Transform(nTotTcGrupo, pMoeda2)
                           @nLi,198 Psay Transform(nTotTcBaixa, pMoeda2)
                           @nLi++         
                           @nLi,000 PSay Replicate('-', 220)
                           bTotTipoCB := .F.
                           nTotTcMen  := nTotTcOpc := nTotTcAde := nTotTcDeb := nTotTcCre := nTotTcPF    := nTotTcTar   :=;
                           nTotTcFar  := nTotTcJur := nTotTcGui := nTotTcCar := nTotTcOut := nTotTcGrupo := nTotTcBaixa := 0
                           cGrpTipoCB := TRB1->TR1_TIPCOB
                           Loop
                        EndIf
                        
                        If bTotAnoMes
                           @nLi++
                           @nLi,000 PSay Replicate('-', 220)
                           @nLi++
                           @nLi,000 Psay "Total " + cTitAnoMes + ":"
                           @nLi,019 Psay Transform(nTotAmMen  , pMoeda2)
                           @nLi,033 Psay Transform(nTotAmOpc  , pMoeda1)
                           @nLi,046 Psay Transform(nTotAmAde  , pMoeda1)
                           @nLi,059 Psay Transform(nTotAmDeb  , pMoeda1)
                           @nLi,072 Psay Transform(nTotAmCre  , pMoeda1)
                           @nLi,085 Psay Transform(nTotAmPF   , pMoeda2)
                           @nLi,102 Psay Transform(nTotAmTar  , pMoeda1)
                           @nLi,115 Psay Transform(nTotAmFar  , pMoeda1)
                           @nLi,128 Psay Transform(nTotAmJur  , pMoeda1)
                           @nLi,142 Psay Transform(nTotAmGui  , pMoeda1)
                           @nLi,155 Psay Transform(nTotAmCar  , pMoeda1)
                           @nLi,168 Psay Transform(nTotAmOut  , pMoeda1)
                           @nLi,181 Psay Transform(nTotAmGrupo, pMoeda2)
                           @nLi,198 Psay Transform(nTotAmBaixa, pMoeda2)
                           @nLi++         
                           @nLi,000 PSay Replicate('-', 220)
                           bTotAnoMes := .F.
                           nTotAmMen  := nTotAmOpc := nTotAmAde := nTotAmDeb := nTotAmCre := nTotAmPF    := nTotAmTar   :=;
                           nTotAmFar  := nTotAmJur := nTotAmGui := nTotAmCar := nTotAmOut := nTotAmGrupo := nTotAmBaixa := 0
                           cTitPlano  := TRB1->(AllTrim(TR1_ANO)+"/"+AllTrim(TR1_MES))
                           Loop
                        EndIf

                        If bTotPlano
                           @nLi++
                           @nLi,000 PSay Replicate('-', 220)
                           @nLi++
                           @nLi,000 Psay "Total Plano " + cTitPlano + ": "
                           @nLi,019 Psay Transform(nTotPMen  , pMoeda2)
                           @nLi,033 Psay Transform(nTotPOpc  , pMoeda1)
                           @nLi,046 Psay Transform(nTotPAde  , pMoeda1)
                           @nLi,059 Psay Transform(nTotPDeb  , pMoeda1)
                           @nLi,072 Psay Transform(nTotPCre  , pMoeda1)
                           @nLi,085 Psay Transform(nTotPPF   , pMoeda2)
                           @nLi,102 Psay Transform(nTotPTar  , pMoeda1)
                           @nLi,115 Psay Transform(nTotPFar  , pMoeda1)
                           @nLi,128 Psay Transform(nTotPJur  , pMoeda1)
                           @nLi,142 Psay Transform(nTotPGui  , pMoeda1)
                           @nLi,155 Psay Transform(nTotPCar  , pMoeda1)
                           @nLi,168 Psay Transform(nTotPOut  , pMoeda1)
                           @nLi,181 Psay Transform(nTotPGrupo, pMoeda2)
                           @nLi,198 Psay Transform(nTotPBaixa, pMoeda2)
                           @nLi+=2
                           @nLi,000 Psay "Totais dos Motivos de Baixa"
                           For Z := 1 To Len(aSomaMot)
                              @nLi++
                              nMotBx := Ascan(aDescMot, {|x| x[1] == aSomaMot[Z][1]})
                              If nMotBx > 0      
                                 @nLi,000 Psay aDescMot[nMotBx][2] + Space(20 - Len(aDescMot[nMotBx][2])) + " : " + Transform(aSomaMot[Z][2], pMoeda3)
                              Else
                                 @nLi,000 Psay aSomaMot[Z][1] + Space(17) + " : " + Transform(aSomaMot[Z][2], pMoeda3)
                              EndIf                              
                           Next Z
                           aSomaMot  := {}                           
                           @nLi++                           
                           @nLi,000 PSay Replicate('-', 220)
                           bTotPlano := .F.
                           nTotPMen  := nTotPOpc := nTotPAde := nTotPDeb := nTotPCre := nTotPPF    := nTotPTar   :=;
                           nTotPFar  := nTotPJur := nTotPGui := nTotPCar := nTotPOut := nTotPGrupo := nTotPBaixa := 0
                           cTitPlano := TRB1->TR1_CODIGO
                           Loop
                        EndIf

                        If bTitPlano
                           @nLi++
                           @nLi++                  
                           @nLi,000 PSay Replicate('-', 220)
                           @nLi++
                           @nLi,000 Psay "==> " + TRB1->TR1_CODIGO + " - " + TRB1->TR1_DESCRI
                           @nLi++
                           @nLi,000 PSay Replicate('-', 220)
                           bTitPlano := .F.
                           Loop
                        EndIf         

                        If bTitAnoMes
                           @nLi++
                           @nLi,000 Psay "=> " + AllTrim(TRB1->TR1_ANO) + "/" + AllTrim(TRB1->TR1_MES)
                           bTitAnoMes := .F.
                           Loop
                        EndIf

                        If bTitTipoCB
                           If BQL->(DBSeek(xFilial("BQL")+TRB1->TR1_TIPCOB))
                              cDesTipCb := BQL->BQL_DESCRI
                           Else
                              cDesTipCb := "Tipo de cobrança nao encontrado."
                           EndIf
                           @nLi++
                           @nLi,003 Psay "Tipo de Cobrança: " + TRB1->TR1_TIPCOB + " " + cDesTipCb
                           @nLi++
                           @nLi,000 PSay Replicate('-', 220)
                           bTitTipoCB := .F.
                           Loop
                        EndIf

                        If bTitVenc
                           @nLi++
                           @nLi,000 Psay "*** " + dToc(TRB1->TR1_VENCTO)
                           @nLi++
                           @nLi,000 PSay Replicate('-', 220)                           
                           bTitVenc := .F.
                           Loop
                        EndIf
                        
                        Z := Ascan(aSomaMot, {|aLinha| aLinha[1] == TRB1->TR1_MOTBX})
                        If Z == 0
                           Aadd(aSomaMot, {TRB1->TR1_MOTBX, TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)})
                        Else
                           aSomaMot[Z][2] += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        EndIf            
            
                        Z := Ascan(aSomaTMot, {|aLinha| aLinha[1] == TRB1->TR1_MOTBX})
                        If Z == 0
                           Aadd(aSomaTMot, {TRB1->TR1_MOTBX, TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)})
                        Else
                           aSomaTMot[Z][2] += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        EndIf

                        nTotAmMen   += TRB1->TR1_VLRMEN
                        nTotAmOpc   += TRB1->TR1_VLROPC
                        nTotAmAde   += TRB1->TR1_VLRTAX
                        nTotAmDeb   += TRB1->TR1_VLRDEB
                        nTotAmCre   += TRB1->TR1_VLRCRE
                        nTotAmPF    += TRB1->TR1_VLRPF
                        nTotAmTar   += TRB1->TR1_VLRTAR
                        nTotAmFar   += TRB1->TR1_VLRFAR
                        nTotAmJur   += TRB1->TR1_VLRJUR
                        nTotAmGui   += TRB1->TR1_VLRGUI
                        nTotAmCar   += TRB1->TR1_VLRCAR
                        nTotAmOut   += TRB1->TR1_VLROUT
                        nTotAmGrupo += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        nTotAmBaixa += TRB1->TR1_VLRBAI                     
                     
                        nTotTcMen   += TRB1->TR1_VLRMEN
                        nTotTcOpc   += TRB1->TR1_VLROPC
                        nTotTcAde   += TRB1->TR1_VLRTAX
                        nTotTcDeb   += TRB1->TR1_VLRDEB
                        nTotTcCre   += TRB1->TR1_VLRCRE
                        nTotTcPF    += TRB1->TR1_VLRPF
                        nTotTcTar   += TRB1->TR1_VLRTAR
                        nTotTcFar   += TRB1->TR1_VLRFAR
                        nTotTcJur   += TRB1->TR1_VLRJUR
                        nTotTcGui   += TRB1->TR1_VLRGUI
                        nTotTcCar   += TRB1->TR1_VLRCAR
                        nTotTcOut   += TRB1->TR1_VLROUT
                        nTotTcGrupo += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        nTotTcBaixa += TRB1->TR1_VLRBAI
            
                        nTotVMen   += TRB1->TR1_VLRMEN
                        nTotVOpc   += TRB1->TR1_VLROPC
                        nTotVAde   += TRB1->TR1_VLRTAX
                        nTotVDeb   += TRB1->TR1_VLRDEB
                        nTotVCre   += TRB1->TR1_VLRCRE
                        nTotVPF    += TRB1->TR1_VLRPF
                        nTotVTar   += TRB1->TR1_VLRTAR
                        nTotVFar   += TRB1->TR1_VLRFAR
                        nTotVJur   += TRB1->TR1_VLRJUR
                        nTotVGui   += TRB1->TR1_VLRGUI
                        nTotVCar   += TRB1->TR1_VLRCAR
                        nTotVOut   += TRB1->TR1_VLROUT
                        nTotVGrupo += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        nTotVBaixa += TRB1->TR1_VLRBAI
            
                        nTotGMen   += TRB1->TR1_VLRMEN
                        nTotGOpc   += TRB1->TR1_VLROPC
                        nTotGAde   += TRB1->TR1_VLRTAX
                        nTotGDeb   += TRB1->TR1_VLRDEB
                        nTotGCre   += TRB1->TR1_VLRCRE
                        nTotGPF    += TRB1->TR1_VLRPF
                        nTotGTar   += TRB1->TR1_VLRTAR
                        nTotGFar   += TRB1->TR1_VLRFAR
                        nTotGJur   += TRB1->TR1_VLRJUR
                        nTotGGui   += TRB1->TR1_VLRGUI
                        nTotGCar   += TRB1->TR1_VLRCAR
                        nTotGOut   += TRB1->TR1_VLROUT
                        nTotGGrupo += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        nTotGBaixa += TRB1->TR1_VLRBAI                        
            
                        nTotPMen   += TRB1->TR1_VLRMEN
                        nTotPOpc   += TRB1->TR1_VLROPC
                        nTotPAde   += TRB1->TR1_VLRTAX
                        nTotPDeb   += TRB1->TR1_VLRDEB
                        nTotPCre   += TRB1->TR1_VLRCRE
                        nTotPPF    += TRB1->TR1_VLRPF
                        nTotPTar   += TRB1->TR1_VLRTAR
                        nTotPFar   += TRB1->TR1_VLRFAR
                        nTotPJur   += TRB1->TR1_VLRJUR
                        nTotPGui   += TRB1->TR1_VLRGUI
                        nTotPCar   += TRB1->TR1_VLRCAR
                        nTotPOut   += TRB1->TR1_VLROUT
                        nTotPGrupo += TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
                        nTotPBaixa += TRB1->TR1_VLRBAI
            
                        Do Case 
                           Case nTipo == 1
                              nLi++
                              
                              If lListTit
                                 If nIdent == 1
                                    //Lista numero do titulo
                                    @nLi,000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO + TR1_MOTBX)					
                                 Else
                                    //Lista nosso numero 
                                    @nLi,000 Psay TRB1->TR1_NUMBCO				
                                 EndIf               
                              EndIf
                              
                              @nLi,019 Psay Transform(TRB1->TR1_VLRMEN, pMoeda2)                  
                              @nLi,033 Psay Transform(TRB1->TR1_VLROPC, pMoeda1)                  
                              @nLi,046 Psay Transform(TRB1->TR1_VLRTAX, pMoeda1)
                              @nLi,059 Psay Transform(TRB1->TR1_VLRDEB, pMoeda1)                  
                              @nLi,072 Psay Transform(TRB1->TR1_VLRCRE, pMoeda1)                  
                              @nLi,085 Psay Transform(TRB1->TR1_VLRPF , pMoeda2)                  
                              @nLi,102 Psay Transform(TRB1->TR1_VLRTAR, pMoeda1)                  
                              @nLi,115 Psay Transform(TRB1->TR1_VLRFAR, pMoeda1)
                              @nLi,128 Psay Transform(TRB1->TR1_VLRJUR, pMoeda1)
                              @nLi,142 Psay Transform(TRB1->TR1_VLRGUI, pMoeda1)                  
                              @nLi,155 Psay Transform(TRB1->TR1_VLRCAR, pMoeda1)                  
                              @nLi,168 Psay Transform(TRB1->TR1_VLROUT, pMoeda1)                  
                              @nLi,181 Psay Transform(TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+TR1_VLRFAR+TRB1->TR1_VLRJUR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)       , pMoeda2)                  
                              @nLi,198 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2)

                           Case nTipo == 2
               
                           Case nTipo == 3
               
                        EndCase
                  EndCase                  
                  
                  TRB1->(DBSkip())
               EndDo
               
               If cGrpVencto <> dToc(TRB1->TR1_VENCTO)
                  cGrpVencto := dToc(TRB1->TR1_VENCTO)
                  bTitVenc   := bTotVenc   := .T.
               EndIf               
            EndDo
            
            If cGrpTipoCB <> TRB1->TR1_TIPCOB .Or. TRB1->(Eof())
               cGrpTipoCB := TRB1->TR1_TIPCOB
               bTitTipoCB := bTitVenc := bTotTipoCB := bTotVenc := .T.
            EndIf
         EndDo
         
         If cGrpAnoMes <> AllTrim(TRB1->TR1_ANO) + "/" + AllTrim(TRB1->TR1_MES) .Or. TRB1->(Eof())
            cGrpAnoMes := AllTrim(TRB1->TR1_ANO) + "/" + AllTrim(TRB1->TR1_MES)
            bTitAnoMes := bTitTipoCB := bTitVenc := bTotAnoMes := bTotTipoCB := bTotVenc := .T.
         EndIf
      EndDo
      
      If cGrpPlano <> TRB1->TR1_CODIGO .Or. TRB1->(Eof())
         cGrpPlano  := TRB1->TR1_CODIGO
         bTitPlano  := bTitAnoMes := bTitTipoCB := bTitVenc := bTotPlano := bTotAnoMes := bTotTipoCB := bTotVenc := .T.
      EndIf      

      TRB1->(DBSkip())
   EndDo
   
   @nLi++         
   @nLi,000 PSay Replicate('-', 220)
   @nLi++
   @nLi,000 Psay "Total"
   @nLi,019 Psay Transform(nTotGMen  , pMoeda2)
   @nLi,033 Psay Transform(nTotGOpc  , pMoeda1)
   @nLi,046 Psay Transform(nTotGAde  , pMoeda1)
   @nLi,059 Psay Transform(nTotGDeb  , pMoeda1)
   @nLi,072 Psay Transform(nTotGCre  , pMoeda1)
   @nLi,085 Psay Transform(nTotGPF   , pMoeda2)
   @nLi,102 Psay Transform(nTotGTar  , pMoeda1)
   @nLi,115 Psay Transform(nTotGFar  , pMoeda1)
   @nLi,128 Psay Transform(nTotGJur  , pMoeda1)
   @nLi,142 Psay Transform(nTotGGui  , pMoeda1)
   @nLi,155 Psay Transform(nTotGCar  , pMoeda1)
   @nLi,168 Psay Transform(nTotGOut  , pMoeda1)
   @nLi,181 Psay Transform(nTotGGrupo, pMoeda2)
   @nLi,198 Psay Transform(nTotGBaixa, pMoeda2)
   nLi++
   nLi++
   @nLi,000 Psay "Total Geral dos Motivos de Baixa"
   For Z := 1 To Len(aSomaTMot)
      nLi++
      nMotBx := Ascan(aDescMot, {|x| x[1] == aSomaTMot[Z][1]})
      If nMotBx > 0      
         @nLi,000 Psay aDescMot[nMotBx][2] + Space(20 - Len(aDescMot[nMotBx][2])) + " : " + Transform(aSomaTMot[Z][2], pMoeda3)
      Else
         @nLi,000 Psay aSomaTMot[Z][1] + Space(17) + " : " + Transform(aSomaTMot[Z][2], pMoeda3)
      EndIf
   Next Z
   @nLi++
   @nLi,000 PSay Replicate('-', 220)
   @nLi++
   Roda(0, Space(10))

   TRBSE1->(DBClosearea())

   //Finaliza e elimina o arquivo fisico do temporario...
   TRB1->(dbCloseArea())
   FErase(cArqTRB  + ".DBF")
   FErase(cInd1TRB + OrdBagExt()) 

   SET DEVICE TO SCREEN

   //Libera impressao
   If aReturn[5] == 1
      dbCommitAll()
	   Set Printer To
	   Ourspool(cRel)
   Endif

   MS_FLUSH()   
Return

//Atualiza SX1
Static Function CriaSX1()
   Local aRegs	:=	{}

   Aadd(aRegs,{cPerg, "01", "Operadora ?      ", "", "", "mv_ch1", "C", 04, 0, 0, "G", "", "mv_par01", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", IIf(PlsGetVersao() >= 8, "B89PLS", "B89"), ""})
   Aadd(aRegs,{cPerg, "02", "Data De ?        ", "", "", "mv_ch2", "D", 08, 0, 0, "G", "", "mv_par02", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "03", "Data Ate?        ", "", "", "mv_ch3", "D", 08, 0, 0, "G", "", "mv_par03", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "04", "Vencimento De ?  ", "", "", "mv_ch4", "D", 08, 0, 0, "G", "", "mv_par04", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "05", "Vencimento Ate?  ", "", "", "mv_ch5", "D", 08, 0, 0, "G", "", "mv_par05", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "06", "Produto de ?     ", "", "", "mv_ch6", "C", 04, 0, 0, "G", "", "mv_par06", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", IIf(PlsGetVersao() >= 8, "B2DPLS", "B2D"), ""})
   Aadd(aRegs,{cPerg, "07", "Produto ate?     ", "", "", "mv_ch7", "C", 04, 0, 0, "G", "", "mv_par07", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", IIf(PlsGetVersao() >= 8, "B2DPLS", "B2D"), ""})
   Aadd(aRegs,{cPerg, "08", "Tipo Relatorio?  ", "", "", "mv_ch8", "N", 01, 0, 0, "C", "", "mv_par08", "Analitico" , "", "", "", "", "Sintetico"   , "", "", "", "", "Resumido","", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "09", "Listar titulos?  ", "", "", "mv_ch9", "N", 01, 0, 0, "C", "", "mv_par09", "Sim"       , "", "", "", "", "Nao"         , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "10", "Considerar Data? ", "", "", "mv_cha", "N", 01, 0, 0, "C", "", "mv_par10", "Da Baixa"  , "", "", "", "", "Da disponib.", "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "11", "Identificação ?  ", "", "", "mv_chb", "N", 01, 0, 0, "C", "", "mv_par11", "No. Titulo", "", "", "", "", "Nosso Numero", "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "12", "Titulo ? 		    ", "", "", "mv_chc", "C", 16, 0, 0, "G", "", "mv_par12", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "13", "Motivo Baixa De? ", "", "", "mv_chd", "C", 03, 0, 0, "G", "", "mv_par13", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
   Aadd(aRegs,{cPerg, "14", "Motivo Baixa Ate?", "", "", "mv_che", "C", 03, 0, 0, "G", "", "mv_par14", ""          , "", "", "", "", ""            , "", "", "", "", ""        ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})

   PlsVldPerg(aRegs)
Return