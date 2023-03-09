#include "rwmake.ch"
//#include "CABA011.CH"
#include "PLSMGER.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA011  ºAutor  ³Luzio Tavares        º Data ³  01/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Browser do Layout para envio de cobrança aos convenios de   º±±
±±º          ³ reciprocidade                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA011()

Local oDlg
Local nOpcA
Local cComFil
Local lInverte := .F.
Local cQuery   := ""
LOCAL lFoundFAT
Private cCodOpe
Private cDirNov
Private cPrefixoBTO
Private cNumTitBTO
Private dVencSE1
Private dEmisSE1
Private nValorSE1
Private cArqNom
Private Inclui := .T.
Private cCodOpe
Private nTipEnv
Private nEnviar
Private cChavePTU
Private lCheck
Private cGrpIni
Private cGrpFim
Private aLog  := {}
Private aLog1 := {}
Private aLog2 := {}
Private cTpTabCBH := ""
//Private aDad510  := {}
Private nValIR   := 0
Private cPerg    := "CAB011"
Private cAno
Private cOpeOriBTO
Private cAnoIniBTO
Private cMesIniBTO

BTO->(DBSetOrder(1)) // Item de fatura de reciprocidade
SE1->(DBSetOrder(1)) // Contas a Receber
BD5->(DBSetOrder(1)) // Cabecalho de Guia Ambulatorial
BE4->(DBSetOrder(1)) // Cabecalho de Guia de Internacao
BEJ->(DBSetOrder(1)) // Itens da autorizacao da Internacao
BAU->(DBSetOrder(1)) // Rede de Atendimento
BR8->(DBSetOrder(1)) // Tabela Padrao
BAQ->(DBSetOrder(1)) // Especialidades Medicas
BD4->(DBSetOrder(1)) // Unidade de Saude
BD6->(DBSetOrder(1)) // Item da Nota
BD7->(DBSetOrder(1)) // Part. Hon. Medicos Itens
BB0->(DbSetOrder(4)) // Profissional da Saude
BBF->(DbSetOrder(1)) // Especialidades

AjustaSX1()

If BD7->(FieldPos("BD7_VLRBPF")) == 0
	MsgStop("Criar campo BD7_VLRBPF")
	Return
Endif

If Pergunte(cPerg,.T.)
	
	cCodOpe   := mv_par01
	nTipEnv   := mv_par02
	nEnviar   := mv_par03
	cGrpIni   := mv_par04
	cGrpFim   := mv_par05
	cEmpIni   := mv_par06
	cEmpfim   := mv_par07
	cConIni   := mv_par08
	cConFim   := mv_par09
	cSubIni   := mv_par10
	cSubFim   := mv_par11
	//	nTipoNota := mv_par06
	nTipoCRDA := mv_par12
	nConvert  := mv_par13
	//	dDataConv := mv_par09
	cDirNov   := mv_par14
	cTpTabCBH := mv_par15
	
	If mv_par16 == 1
		cLayOut := "CABESP"
	EndIf
	
	If nConvert == 2
		SIX->(DbSetOrder(1))
		If !SIX->(MsSeek("BW02"))
			MsgStop("Para usar a opcao de conversao 'Converter TUSS' deve ser criado o indice 2 no arquivo BW0(zero) com a chave BW0_FILIAL+BW0_CODPD2+BW0_CODPR2+BW0_CODPD1+BW0_CODPR1")
			Return
		Endif
		If Empty(cTpTabCBH)
			MsgStop("Para se converter para TUSS deve-se informar o tipo de tabela a que se refere a tabela AMB.")
			Return
		Endif
	Endif
	
	DbSelectArea("BTO")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria filtro para Faturas...						                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case nEnviar = 1
			cComFil := " AND BTO_ENV500 <> '1' "
		Case nEnviar = 2
			cComFil := " AND BTO_ENV500 = '1' "
		Case nEnviar = 3
			cComFil := ""
		Otherwise
			cComFil := ""
	Endcase
	
	cFiltro := "@BTO_FILIAL = '" + xFilial("BTO") + "' AND BTO_STATUS = '1' AND BTO_CODOPE = '" + cCodOpe + "' AND D_E_L_E_T_ <> '*' " + cComFil
	
	If BTO->(FieldPos("BTO_GRPOPE")) > 0
		cFiltro := cFiltro + " AND BTO_GRPOPE >= '" + cGrpIni + "' AND BTO_GRPOPE <= '" + cGrpFim + "' "
	Endif
	
	SET FILTER TO &cFiltro
	
	BTO->(MsSeek(xFilial("BTO")))
	
	Private cMarca := GetMark( )
	
	DEFINE MSDIALOG oDlg TITLE "Itens de faturamento de reciprocidade" From 9,0 To 28,80 OF GetWndDefault()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta CheckBox. Marcar desmarcar todos...                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lCheck := .F.
	oCheck := IW_CheckBox(012,001,"Marca/Desmarca Todos","lCheck")
	oCheck:bChange := {|| MsAguarde( {|| CABA011Mark(cComFil) } ) }
	
	oMark := MsSelect():New("BTO","BTO_OK",,,@lInverte,@cMarca,{20,1,143,315})
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria tela para selecao das faturas...			                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| nOpca := 1,oDlg:End()},{|| nOpca := 0,ODlg:End()})
	
	If  nOpca == 1
		
		cQuery := " SELECT BTO_CODOPE, BTO_NUMERO, BTO_OPEORI, R_E_C_N_O_ AS BTO_RECNO FROM " + RetSqlName("BTO")
		cQuery += " WHERE BTO_FILIAL = '"+xFilial("BTO")+"' AND BTO_OK = '" + cMarca + "' AND D_E_L_E_T_ = ' '"
		
		PLSQuery(cQuery,"TMP2")
		
		While ! TMP2->(EOF())
			
			BTO->(dbGoTo(TMP2->BTO_RECNO))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no respectivo SE1 - Titulos a Receber                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SE1->(DbSetOrder(1))
			If  ! SE1->(MsSeek(xFilial("SE1")+BTO->(BTO_PREFIX+BTO_NUMTIT+BTO_PARCEL+BTO_TIPTIT)))
				lFoundFAT := .F.
			Else
				lFoundFAT := .T.
				nValIR := noround(SE1->E1_IRRF,2)
			Endif
			
			cAno        := dtos(stod(BTO->BTO_ANOINI + BTO->BTO_MESINI + "15")-30)
			cCodOpeBTO  := BTO->BTO_CODOPE
			cOpeOriBTO  := BTO->BTO_OPEORI
			cAnoIniBTO  := BTO->BTO_ANOINI
			cMesIniBTO  := BTO->BTO_MESINI
			cPrefixoBTO := BTO->BTO_PREFIX
			cNumTitBTO  := BTO->BTO_NUMTIT
			cParcelBTO  := BTO->BTO_PARCEL
			cTipTitBTO  := BTO->BTO_TIPTIT
			dVencSE1    := SE1->E1_VENCTO
			dEmisSE1    := SE1->E1_EMISSAO
			nValorSE1   := SE1->E1_VALOR
			cArqNom     := DtoS(ddatabase) + substr(Time(),1,2)+substr(Time(),4,2)+substr(Time(),7,2)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona na operadora para pegar campos no Header - Arquivo(Tipo de registro = 00)  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aDad011 := {}
			BA0->(DbSetOrder(1))
			BA0->(MsSeek(xFilial("BA0")+cOpeOriBTO))
			aadd(aDad011,{padr("2",1),;
			padr(BA0->BA0_SUSEP,10),;
			padr(BA0->BA0_NOMINT,60),;
			padr(BA0->BA0_END,40),;
			padr('',20),;
			padr(BA0->BA0_BAIRRO,30),;
			padr(BA0->BA0_CEP,8),;
			padr(BA0->BA0_CIDADE,30),;
			padr(BA0->BA0_EST,2),;
			padr(StrZero(Val(BA0->BA0_CGC),15),15),;
			padr(strzero(val(BA0->BA0_INCEST),20),20),;
			padr( If( BA0->(FieldPos("BA0_DDD")) > 0 , strzero(val(BA0->BA0_DDD),4)  ,strzero(0,4)),4),;
			padr( If(!Empty(BA0->BA0_TELEF1),alltrim(strtran(BA0->BA0_TELEF1,'-','')),strzero(0,8)),8),;
			padr( If(!Empty(BA0->BA0_FAX1  ),alltrim(strtran(BA0->BA0_FAX1  ,'-','')),strzero(0,8)),8)})
			
			BA0->(MsSeek(xFilial("BA0")+cCodOpe))
			aadd(aDad011,{padr("1",1),;
			padr(BA0->BA0_SUSEP,10),;
			padr(BA0->BA0_NOMINT,60),;
			padr(BA0->BA0_END,40),;
			padr('',20),;
			padr(BA0->BA0_BAIRRO,30),;
			padr(BA0->BA0_CEP,8),;
			padr(BA0->BA0_CIDADE,30),;
			padr(BA0->BA0_EST,2),;
			padr(StrZero(Val(BA0->BA0_CGC),15),15),;
			padr(strzero(val(BA0->BA0_INCEST),20),20),;
			padr( If( BA0->(FieldPos("BA0_DDD")) > 0 , strzero(val(BA0->BA0_DDD),4)  ,strzero(0,4)),4),;
			padr( If(!Empty(BA0->BA0_TELEF1),alltrim(strtran(BA0->BA0_TELEF1,'-','')),strzero(0,8)),8),;
			padr( If(!Empty(BA0->BA0_FAX1  ),alltrim(strtran(BA0->BA0_FAX1  ,'-','')),strzero(0,8)),8)})
			
			DE9->(DbSetOrder(1))
			DE9->(MsSeek(xFilial("DE9")+cLayOut))
			
			MsAguarde( {|| U_GERA011() } )
			
			//			MsAguarde( {|| U_GERA011(cAno,cCodOpeBTO,cOpeOriBTO,cAnoIniBTO,cMesIniBTO,cPrefixoBTO,cNumTitBTO,dVencSE1,;
			//			dEmisSE1,nValorSE1,cArqNom,nTipoCRDA,nConvert,nTipEnv,cCodOpe,.T.,"BD6->BD6_VLRTPF",;
			//			"BD7->BD7_BLOPAG == '1'",cDirNov,cTpTabCBH,cParcelBTO,cTipTitBTO) } )
			
			If lFoundFAT
				U_A011Envi(TMP2->BTO_CODOPE,TMP2->BTO_NUMERO,TMP2->BTO_OPEORI)
			Else
				MsgAlert("Fatura "+BTO->(BTO_PREFIX+BTO_NUMTIT)+" nao pode ser exportada!")
			Endif
			
			TMP2->(DbSkip())
		Enddo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha temporario...								                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TMP2->(DBCloseArea())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Mensagem de processamento                         		 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLog) > 0
			PLSCRIGEN(aLog,{{"Mensagem 1","@!",120},{"Mensagem 2","@!",120},{"Mensagem 3","@!",200}},"Ocorrencias no processamento",nil,nil)
		EndIf
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpa o filtro...								                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BTO->( dbClearFilter() )
	
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ gera011  ºAutor  ³Luzio Tavares        º Data ³  01/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Arquivo de envio                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GERA011()
Local lQuery1 := .T.
Local ii
Local i
LOCAL nI
Local iBD6
Local cNomArq  := ""
Local cQuery   := ""
Local cTipGui  := ""
Local cChave   := ""
Local cString  := ""
Local cClasse  := ""
Local cIndCli  := ""
Local cR501    := ""
Local cR502    := ""
Local cR503    := ""
Local cR504    := ""
//Local cR505    := ""
Local cMes     := substr(cAno,5,2)
Local cAno1    := substr(cAno,1,4)
Local cFatSer  := ""
Local nPos     := 0
Local nTotFat  := 0
Local lAmbula  := .F.
Local lInterc  := .F.
Local aStru501 := {}
Local aStru502 := {}
Local aStru503 := {}
Local aStru504 := {}
//Local aStru505 := {}
Local aStru510 := {}
Local aStru511 := {}
Local aMatMed  := {}
Local aRetQ    := {}
Local cBDHname := RetSqlName("BDH")
Local cBD6name := RetSqlName("BD6")
Local cBD7name := RetSqlName("BD7")
//LOCAL __cCodPad := GETMV("MV_PLSTBPD")
LOCAL cGNT      := "-03"
LOCAL nPosBD7
LOCAL cRdaHm
LOCAL lSipNew
LOCAL lBE4INTSIP
//LOCAL aRetPto504
//LOCAL aRetPto502
//LOCAL aRetPto507
//LOCAL aRetPto505
LOCAL cAnoMesAnt
LOCAL cMatAnt
LOCAL cPadInt
Local cAliasCab
Local nRecBAU
Local nIndBAU
Local lExiProc	:= .F.
Local lDiaria	:= .F.
Local lTemCon	:= .F.
Local nRecBR8   := 0
Local nOrdBR8   := 0
Local nSlvVco   := 0
Local nSlvCco   := 0
Local nSlvFco   := 0
Local nSlvTad   := 0
Local nSlvTco   := 0
Local nSlvTfi   := 0
Local nK	       := 0
Local nJ   		 := 0
LOCAL cSistem
Local nNumSeq := 0
Local nVlPg502   := 0
Local nVlTx502   := 0
Local nVlINSS502 := 0
Local nVlTotPag  := 0
Local nVlTotTax  := 0
Local nVlTotINSS := 0

Private cCampoTOTP := "BD6->BD6_VLRTPF"
Private cQuebraBD7 := "BD7->BD7_BLOPAG == '1'"
Private cLote
Private nVlrCob
Private cCodPsa
Private dDatBas
Private cCGCPre
Private cCodPre
Private cNomPre
Private cTipTab
Private cChaNot
Private cCodInt
Private cDtaAte := space(08)
Private cDatInt := space(08)
Private cDatAlt := space(08)
Private cCodAto   := space(0)
Private cCdEspeReq 	:= ""
Private nQTD_SER := 0
Private nQtdPsa
Private nTOT_SER := 0
Private nQTD_501 := 0  //Quantidade de registros de beneficiarios (utilizado no Registro 99)
Private nQTD_502 := 0  //
Private nQTD_504 := 0
Private nNOT_EXC := 0
Private nNOT_AMB := 0
PRIVATE cDirEnv
PRIVATE lMsg     := .T.
Private nRecR501 := 0
Private	cNomTitCon := ""
Private nQtd_504U := 0
Private	nQtd_502T := 0
Private	nQtd_504T := 0
Private cNovDir := ""
Private nTot_Ser := 0
Private nTot_Tax := 0
Private nTot_INSS := 0
Private cNumImp := Space(14)
Private cLinStr := Space(0)

If lQuery1
	cQuery := " SELECT BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, BD6_CODPRO,  "
	cQuery += cBD6name + ".R_E_C_N_O_ BD6_RECNO "
	cQuery += "FROM "+cBD6name+","+cBDHname+" "
	cQuery += "WHERE "
	cQuery += "BDH_STATUS = '0' AND "
	cQuery += "BDH_NUMSE1 = '"+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' AND "
	cQuery += cBDHname+".D_E_L_E_T_ = '' AND "
	cQuery += cBD6name+".D_E_L_E_T_ = '' AND "
	cQuery += "BD6_FILIAL = '"+xFilial("BD6")+"' AND "
	cQuery += "BDH_FILIAL = '"+xFilial("BDH")+"' AND "
	cQuery += "BD6_OPEUSR = BDH_CODINT AND "
	cQuery += "BD6_CODEMP = BDH_CODEMP AND "
	cQuery += "BD6_MATRIC = BDH_MATRIC AND "
	cQuery += "BD6_TIPREG = BDH_TIPREG AND "
	cQuery += "BD6_SEQPF = BDH_SEQPF AND "
	cQuery += "BD6_ANOPAG = BDH_ANOFT AND "
	cQuery += "BD6_MESPAG = BDH_MESFT AND "
	cQuery += "BD6_SITUAC = '1' AND "
	cQuery += "((SELECT COUNT(*) FROM "+cBD7name+" WHERE "
	cQuery += "   BD7_FILIAL = BD6_FILIAL AND "
	cQuery += "   BD7_CODOPE = BD6_CODOPE AND "
	cQuery += "   BD7_CODLDP = BD6_CODLDP AND "
	cQuery += "   BD7_CODPEG = BD6_CODPEG AND "
	cQuery += "   BD7_NUMERO = BD6_NUMERO AND "
	cQuery += "   BD7_ORIMOV = BD6_ORIMOV AND "
	cQuery += "   BD7_SEQUEN = BD6_SEQUEN AND "
	cQuery += "   BD7_BLOPAG <> '1' ) > 0)"
	cQuery += " ORDER BY BD6_FILIAL, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN "
	
	PLSQuery(cQuery,"TMP")
	
Endif

TMP->(DbGoTop())

If  !TMP->(EOF())
	FERASE("LOGCABA011.TXT")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis        			                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aLog1 := {}
	aLog2 := {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo temporario - BENEFICIARIO Registro (501)                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aStru501,{"Chave","C",018,0})
	aadd(aStru501,{"R501" ,"C",300,0})
	
	cNomArq	 := CriaTrab( aStru501, .T. )
	DbUseArea(.T.,,cNomArq,"R01",.T.)
	R01->(DbCreateInd(cNomArq, "Chave",{|| Chave }))
	
	DbSelectArea("R01")
	R01->(DbSetorder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo temporario - NOTA DE COBRANCA Registro (502)                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aStru502,{"Chave","C",038,0})
	aadd(aStru502,{"R502" ,"C",300,0})
	
	cNomArq	 := CriaTrab( aStru502, .T. )
	DbUseArea(.T.,,cNomArq,"R02",.T.)
	R02->(DbCreateInd(cNomArq, "Chave",{|| Chave }))
	
	DbSelectArea("R02")
	R02->(DbSetorder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria arquivo temporario - SERVICO (OBRIGATORIO) Registro (504)           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aStru504,{"Chave","C",038,0})
	aadd(aStru504,{"R504" ,"C",427,0})
	
	cNomArq	 := CriaTrab( aStru504, .T. )
	DbUseArea(.T.,,cNomArq,"R04",.T.)
	R04->(DbCreateInd(cNomArq, "Chave",{|| Chave }))
	DbSelectArea("R04")
	R04->(DbSetorder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta variaveis R501...						                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cOpeDes  := cOpeOriBTO
	dDatBas  := dDatabase
	
	//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS - CABA011.PRW(486)   Command has no effect 
	//substr(Time(),1,2)+substr(Time(),4,2)+substr(Time(),7,2)
	
	cAnoMesAnt := PLSDIMAM(cAnoIniBTO,cMesIniBTO,"0")
	cCompet    := substr(cAnoMesAnt,5,2) + substr(cAnoMesAnt,1,4)
	
	cFatura  := strzero(val(cNumTitBTO),11)
	dDatVen  := dVencSE1
	dDatEmi  := dEmisSE1
	nValor   := noround(nValorSE1,2)
	nRecR501 := 0
	nRecR504 := 0
	nVlrR504 := 0
	lRecR504 := .F.
	nRecMat  := 0
	nRecOut  := 0
	nMaiMat  := 0
	nMaiOut  := 0
	
	While !TMP->(EOF())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Mensagem de processamento                                  				 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MsProcTXT("Processando " + TMP->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG))
		ProcessMessage()
		
		cNomTitCon := ""
		nRecnoBD6 := TMP->BD6_RECNO
		cChave501 := TMP->(BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
		
		BA1->(DbSetOrder(2))
		If BA1->(MsSeek(TMP->(BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+"00")))
			cNomTitCon := ALLTRIM(BA1->BA1_NOMUSR)+space(50-Len(AllTrim(BA1->BA1_NOMUSR)))
		Endif
		
		If BA1->(FieldPos("BA1_MATEDI")) > 0
			If BA1->(MsSeek(cChave501)) .And. ! Empty(BA1->BA1_MATEDI)
				cMatAnt := BA1->BA1_MATEDI
			Else
				cMatAnt := BD6->BD6_MATANT
			Endif
		Else
			cMatAnt := BD6->BD6_MATANT
		Endif
		cNomUsr := AllTrim(BA1->BA1_NOMUSR)+space(50-Len(AllTrim(BA1->BA1_NOMUSR)))
		
		BA0->(DbSetOrder(1))
		BA0->(MsSeek(xFilial("BA0")+BA1->BA1_OPEORI))
		cCodInt := BA0->BA0_CODINT
		cNomInt := padr(BA0->BA0_NOMINT,50)
		
		While TMP->(BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG) == cChave501 .and. ! TMP->(EOF())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mensagem de processamento                                  				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MsProcTXT("Processando " + TMP->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN))
			ProcessMessage()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona BD6...                                           				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lAmbula  := .F.
			lInterc  := .F.
			lDiaria  := .F.
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona BD6...                                           				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  !BD6->(MsSeek(xFilial("BD6")+TMP->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
				aadd(aLog2,{"   BD6 nao encontrado","Chave BD6: ",TMP->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
				PlsLogFil(Space(03)+aLog2[Len(aLog2),1]+Space(03)+aLog2[Len(aLog2),2]+Space(03)+aLog2[Len(aLog2),3],"LOGCABA011.TXT")
				TMP->(DbSkip())
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se eh Ambulatorial...                                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  BD6->BD6_ORIMOV == "1" //guia de servico/consulta
				If  BD5->(MsSeek(xFilial("BD5")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
					lAmbula := .T.
					cTipGui := "A"
					cAliCab := "BD5"
				Endif
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se eh Internacao...                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  BE4->(MsSeek(xFilial("BE4")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
					
					nRecBR8  := BR8->(Recno())
					nOrdBR8  := BR8->(IndexOrd())
					
					BD6->(DbSetOrder(1))
					If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
						While !BD6->(Eof()) .and. xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV) ==;
							BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)
							
							cCodSer := alltrim(BD6->BD6_CODPRO)
							BR8->(DbSetOrder(3))
							If BR8->(MsSeek(xFilial("BR8")+cCodSer)) .and. BR8->BR8_TPPROC == '4'
								lDiaria := .T.
								exit
							Endif
							BD6->(DbSkip())
							
						Enddo
					Endif
					
					BR8->(DbGoTo(nRecBR8))
					BR8->(DbSetOrder(nOrdBR8))
					
					cAliCab := "BE4"
					If lDiaria
						lInterc := .T.
						cTipGui := "I"
					Else
						lAmbula := .T.
						cTipGui := "A"
					Endif
					cDatInt := SubStr(Dtos(BE4->BE4_DATPRO),7,2)+SubStr(DtoS(BE4->BE4_DATPRO),5,2)+SubStr(DtoS(BE4->BE4_DATPRO),1,4)
					cDatAlt := SubStr(DtoS(BE4->BE4_DTALTA),7,2)+SubStr(DtoS(BE4->BE4_DTALTA),5,2)+SubStr(DtoS(BE4->BE4_DTALTA),1,4)
				Endif
			Endif
			
			If cTipGui == "A"
				cAliasCab := "BD5"
			Else
				cAliasCab := "BE4"
			EndIf
			
			BAU->(DbSetOrder(1))
			BAU->(MsSeek(xFilial("BAU")+&(cAliasCab + "->" + cAliasCab + "_CODRDA"), .F.))
			
			cTipPes := BAU->BAU_TIPPE
			cCGCPre := strzero(val(BAU->BAU_CPFCGC),14)
			cNomPre := padr(BAU->BAU_NOME,50)
			_nMultINSS := Iif(BAU->BAU_TIPPE=="F",0.2,0)
			
			If  cCGCPre == "00000000000000"
				aadd(aLog2,{"   RDA sem cnpj: " + BAU->BAU_CODIGO,"",""})
				PlsLogFil(Space(03)+aLog2[Len(aLog2),1]+Space(03)+aLog2[Len(aLog2),2]+Space(03)+aLog2[Len(aLog2),3],"LOGCABA011.TXT")
			Endif
			If  nTipoCRDA == 1
				cCodPre := BAU->BAU_CODIGO
			Else
				If  Empty(BAU->BAU_CONREG)
					cCodPre := BAU->BAU_CODIGO
				Else
					cCodPre := StrZero(Val(BAU->BAU_CONREG),6)
				Endif
			Endif
			
			cPreReq := cCodPre
			
			If cTipGui=="A"
				If  ! empty(&(cAliCab+"->"+cAliCab+"_DATPRO"))
					cDt := substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),7,2) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),5,2) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),1,4)
				Else
					cDt := "00000000"
				Endif
			Else
				If  ! empty(&(cAliCab+"->"+cAliCab+"_DATPRO"))
					//				cDt := substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),1,4) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),5,2) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),7,2)
					cDt := substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),7,2) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),5,2) + substr(dtos(&(cAliCab+"->"+cAliCab+"_DATPRO")),1,4)
				Else
					cDt := "00000000"
				Endif
			Endif
			cDtaAte := cDt
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta vetor com BD6  		                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nRecnoBD6 := TMP->BD6_RECNO
			cChave    := TMP->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)
			aBD6      := {}
			lConsulta := .T.
			lTemCon   := .F.
			lExiProc  := .T.  //.F.
			
			//Guarda a Guia
			While TMP->(BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG) == cChave501 .and.;
				TMP->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == cChave .and.;
				! TMP->(EOF())
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se tem algum procedimento que nao eh consulta                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  cTipGui == "A"
					
					If ! PLSISCON(AllTrim(TMP->BD6_CODPAD),AllTrim(TMP->BD6_CODPRO))
						lConsulta := .F.
					Else
						lTemCon   := .T.
					Endif
				Endif
				
				aadd(aBD6,TMP->BD6_RECNO)
				TMP->(DbSkip())
			Enddo
			
			BD6->(dbGoTo(nRecnoBD6))
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Alimenta variaveis R502...	                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cLote   := BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO
			//		cNota   := IF(Empty(BD6->BD6_NUMIMP),strzero(val(BD6->BD6_NUMERO),11),strzero(val(BD6->BD6_NUMIMP),11))
			cNumImp := Substr(alltrim(BD6->BD6_NUMIMP),len(AllTrim(BD6->BD6_NUMIMP))*-1,14) + Space(14 - Len(Substr(alltrim(BD6->BD6_NUMIMP),len(AllTrim(BD6->BD6_NUMIMP))*-1,14)))
			cNota   := BD6->BD6_NUMERO
			cChaNot := cChave501 + cLote
			If  cTipGui == "I"  // Internacao
				cTipNot := "5"
			Else
				If  lConsulta
					cTipNot := "1"  // Consulta
				Else
					cTipNot := "2"  // SADT
				Endif
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Alimenta variaveis R503...	                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			If cTipGui == "A"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava a senha de Autorizacao...                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cNroAut := strzero(val(&(cAliCab+"->"+cAliCab+"_NRAOPE")),9)
				If  val(cNroAut) > 0
					cUniAut := cCodInt
					cCodExc := "L"
				Else
					cUniAut := "0000"
					cCodExc := "0"
				EndIf
				
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava a senha de Autorizacao...                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cNroAut := strzero(val(&(cAliCab+"->"+cAliCab+"_NRAOPE")),9)
				
				If  val(cNroAut) > 0
					cUniAut := cCodInt
					cCodExc := "C"
				Else
					cUniAut := "0000"
					cCodExc := "0"
				EndIf
			Endif
			
			If cTipGui=="A"
				cGuiPri := strzero(val(BD5->BD5_GUIPRI),11)
			Else
				cGuiPri := ""
			Endif
			
			If Empty(val(cGuiPri))
				cGuiPri := cNota
			Endif
			
			aReg504 := {}
			For iBD6 := 1 to len(aBD6)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona BD6...			                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BD6->(dbGoTo(aBD6[iBD6]))
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Alimenta variaveis R504...	                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cTipGui <> "A" .and. cAliasCab == "BE4"  .and. BD6->BD6_DATPRO < BE4->BE4_DATPRO
					dDatSer := BE4->BE4_DATPRO
				Else
					dDatSer := BD6->BD6_DATPRO
				Endif
				
				cTipTab := BR8->BR8_TPPROC
				Do Case
					Case cTipTab $ "0"
						cTipTab := "0"
					Case cTipTab $ "3,4"
						cTipTab := "1"
					Case cTipTab $ "1,5"
						cTipTab := "2"
					Case cTipTab $ "2"
						cTipTab := "3"
					Case cTipTab $ "6"
						cTipTab := "4"
					Otherwise
						cTipTab := "0"
				EndCase
				
				If  !Empty(BR8->BR8_CODEDI)
					cCodPsa := strzero(val(BR8->BR8_CODEDI),8)
					cDesPro := Alltrim(BR8->BR8_DESCRI)+Space(250-Len(Alltrim(BR8->BR8_DESCRI)))
				Else
					cCodPsa := strzero(val(BD6->BD6_CODPRO),8)
					cDesPro := Alltrim(BD6->BD6_DESPRO)+Space(250-Len(Alltrim(BD6->BD6_DESPRO)))
				Endif
				//			Endif
				
				If Int(BD6->BD6_QTDPRO) > 999
					nQtdPsa := 999
				Else
					nQtdPsa := Int(Round(BD6->BD6_QTDPRO, 2))
				Endif
				nVlrCob := BD6->(BD6_VLRTPF-BD6_VLRTAD)
				nTaxAdm	:= BD6->BD6_VLRTAD
				nVlINSS := BD6->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
				
				aR504 := {}
				aadd(aR504,cCodInt) 						                            // 06 Codigo da Operadora
				aadd(aR504,SubStr(dtos(dDatSer),7,2)+SubStr(dtos(dDatSer),5,2)+SubStr(dtos(dDatSer),1,4))                       // 09 Data de Execucao
				aadd(aR504,cTipTab)                                                     // 10 Tipo de Tabela
				aadd(aR504,Alltrim(cCodPsa)+Space(20-Len(Alltrim(cCodPsa))))           // 11 Codigo do Servico
				aadd(aR504,cDesPro)                                                     // 11 Codigo do Servico
				aadd(aR504,strzero(nQtdPsa,3))       		                            // 12 Quantidade
				aadd(aR504,Iif(nQtdPsa < 0, "-", "+"))                 // Sinal
				aadd(aR504,strzero(noround((nVlrCob),2)*100,10))       // 13 Valor de Honorario
				aadd(aR504,Iif(nVlrCob < 0, "-", "+"))                 // Sinal
				aadd(aR504,strzero(noround((nTaxAdm),2)*100,10))  		// 22 Taxa de administracao do Servico
				aadd(aR504,Iif(nTaxAdm < 0, "-", "+"))                 // Sinal
				aadd(aR504,strzero(noround((nVlINSS),2)*100,10))       // 22 Taxa de administracao do Servico
				aadd(aR504,Iif(nVlINSS < 0, "-", "+"))                 // Sinal
				aadd(aR504,strzero(noround((nVlrCob+nTaxAdm+nVlINSS),2)*100,12))       // 22 Taxa de administracao do Servico
				aadd(aR504,Iif((nVlrCob+nTaxAdm+nVlINSS)< 0, "-", "+"))                 // Sinal
				aadd(aReg504,aR504)
				nQtd_Ser += nQtdPsa
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Totaliza valores para validacao	 do arquivo...			                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTotFat   += nVlrCob + nTaxAdm
				nTot_Ser  += noround(nVlrCob,2)
				nTot_Tax  += noround(nTaxAdm,2)
				nTot_INSS += noround(nVlINSS,2)
			Next
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Processa vetor com registros R504                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For i := 1 to len(aReg504)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava R504 do arquivo temporario...						                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				R04->(Reclock("R04",.T.))
				R04->Chave := (cChaNot)
				
				cR504 := ""
				For ii := 1 to len(aReg504[i])
					cR504 += aReg504[i][ii]
				Next
				R04->R504 := cR504
				R04->(MsUnlock())
				nQtd_504++
			Next
			
			aMatMed  := {}
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se tem algum registro para esta guia                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  Len(aReg504) == 0
				Loop
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Alimenta variavel cR502...	                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//REC108086     008  0001000400238100              242332000151        J30104947000103HOSPITAL SANTA CRUZ                               15012008                00000001032+0000000052+0000000000+000000001084+0001

			cR502 := cNumImp            				                    // 21 Numero da guia principal que originou o atendimento - TISS
			cR502 += cCodInt							                    // 06 Codigo da Operadora
			cR502 += cChave501+Space(30-(Len(Alltrim(cChave501))))        //(cCodEmp+cMatric+cTipReg+cDigito) // 08 Identificacao do Beneficiario
			cR502 += allTrim(cMatAnt)+Space(20-Len(Alltrim(cMatAnt)))     // 09 Codigo do beneficiario na cabesp
			cR502 += cTipPes                                               // 28 Tipo de Pessoa
			cR502 += Alltrim(cCGCPre)+Space(14-Len(Alltrim(cCGCPre)))     // 29 CNPJ, CGC ou CPF
			cR502 += Alltrim(cNomPre)+Space(50-Len(Alltrim(cNomPre)))     // 07 Nome do Prestador
			cR502 += cDtaAte    						  // 11 Data de Atendimento
			cR502 += cDatInt    						  // 11 Data de Internacao
			cR502 += cDatAlt                              // 22 Data da Alta
			cR502 += cCodExc							  // 12 Codigo da Excessao
			cR502 += strzero(noround(nTot_Ser,2)*100,10)
			cR502 += Iif(ntot_Ser < 0, "-", "+")
			cR502 += strzero(noround(nTot_Tax,2)*100,10)
			cR502 += Iif(ntot_Tax < 0, "-", "+")
			cR502 += strzero(noround(nTot_INSS,2)*100,10)
			cR502 += Iif(ntot_INSS < 0, "-", "+")
			cR502 += strzero(noround((nTot_Ser+nTot_Tax+nTot_INSS),2)*100,12)
			cR502 += Iif((nTot_Ser+nTot_Tax+nTot_INSS) < 0, "-", "+")
			cR502 += StrZero(nQtd_504,4)				  // 21
			nQtd_504U  += nQtd_504
			nVlPg502   += nTot_Ser
			nVlTx502   += nTot_Tax
			nVlINSS502 += nTot_INSS
			nTot_Ser  := 0
			nTot_Tax  := 0
			nTot_INSS := 0
			nQtd_504  := 0

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Alimenta variavel cR503...	                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  cTipGui == "A"
				cR503 := Space(242)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava R502 do arquivo temporario...						                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R02->(Reclock("R02",.T.))
			R02->Chave := (cChaNot)
			R02->R502  := cR502
			R02->(MsUnlock())
			nQtd_502++
			
			If  cCodExc <> "0"
				nNot_Exc++
			Endif
		Enddo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta variavel cR501. BENEFICIARIOS                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		//   ....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+
		//0081234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A23456789012345678901234567890123456789012345678901234
		//008FLAVIA RANGEL MIRANDA                             0001000400237500              226914000167        FLAVIA RANGEL MIRANDA                             0000007299+0000000365+0000000840+000000008504+0002		
		
		cR501 := cCodInt							// 06 Codigo da Operadora
		cR501 += cNomTitCon                         // 08 Identificacao do Beneficiario
		cR501 += AllTrim(cChave501)+Space(30-(Len(Alltrim(cChave501)))) //(cCodEmp+cMatric+cTipReg+cDigito) // 08 Identificacao do Beneficiario
		cR501 += Alltrim(cMatAnt)+Space(20-Len(Alltrim(cMatAnt)))       // 09 Codigo do beneficiario na cabesp
		cR501 += cNomUsr						                         // 10 Nome
		cR501 += strzero(noround(nVlPg502,2)*100,10)
		cR501 += Iif(nVlPg502 < 0, "-", "+")
		cR501 += strzero(noround(nVlTx502,2)*100,10)
		cR501 += Iif(nVlTx502 < 0, "-", "+")
		cR501 += strzero(noround(nVlINSS502,2)*100,10)
		cR501 += Iif(nVlINSS502 < 0, "-", "+")
		cR501 += strzero(noround((nVlPg502+nVlTx502+nVlINSS502),2)*100,12)
		cR501 += Iif((nVlPg502+nVlTx502+nVlINSS502) < 0, "-", "+")
		cR501 += StrZero(nQtd_502,4)               // qtd de registros de guias do beneficiario
		cR501 += StrZero(nQtd_504U,4)              // qtd de registros de Eventos do beneficiario
		nQtd_501++
		nQtd_502T  += nQtd_502
		nQtd_504T  += nQtd_504U
		nVlTotPag  += nVlPg502
		nVlTotTax  += nVlTx502
		nVlTotINSS += nVlInss502
		nQtd_502   := 0
		nQtd_504U  := 0
		nVlPg502   := 0
		nVlTx502   := 0
		nVlINSS502 := 0
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava R502 do arquivo temporario...						                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R01->(Reclock("R01",.T.))
		R01->Chave := (cChave501)
		R01->R501  := cR501
		R01->(MsUnlock())
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coloca diferenca em mat/med                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  GetNewPar("MV_PLATUER","1") == "1"
		If  nTotFat <> nValor
			If  nRecMat <>  0 .or. nRecOut <> 0
				If  nRecMat <>  0
					R04->(dbGoTo(nRecMat))
				Else
					R04->(dbGoTo(nRecOut))
				Endif
				nDif := noround(noround(nValor * 100,0) - noround(nTotFat * 100,0),0)
				nVlr := val(substr(R04->R504,109,14))
				If  (nVlr + nDif) >= 0
					nTotFat  += nDif / 100
					nTot_Ser += nDif / 100
					nVlr     += nDif
					R04->(Reclock("R04",.F.))
					cR04 := R04->R504
					R04->R504  := substr(cR04,1,108) + strzero(nVlr,14) + substr(cR04,123,265)
					R04->(MsUnlock())
				Endif
			Endif
		Endif
	Elseif nTotFat <> nValor
		aadd(aLog1,{"Erro - diferenca encontrada","Oper: " + cOpeOriBTO+ "   Titulo: " + cPrefixoBTO + " " + cNumTitBTO,"Movimento:  "+ alltrim(transform(nTotFat,"@E 999,999,999.99")) + "   Fatura:  "+alltrim(transform(nValor,"@E 999,999,999.99"))})
		PlsLogFil(Space(03)+aLog1[Len(aLog1),1]+Space(03)+aLog1[Len(aLog1),2]+Space(03)+aLog1[Len(aLog1),3],"LOGCABA011.TXT")
		R01->(dbCloseArea())
		R02->(dbCloseArea())
		R04->(dbCloseArea())
		//		R05->(dbCloseArea())
		TMP->(DBCloseArea())
		If  len(aLog1) > 0 .or. len(aLog2) > 0
			If  len(aLog1) > 0
				For i := 1 to len(aLog1)
					aadd(aLog,aLog1[i])
				Next
			Endif
			If  len(aLog2) > 0
				For i := 1 to len(aLog2)
					aadd(aLog,aLog2[i])
				Next
			Endif
			aadd(aLog,{"","",""})
		Endif
		MsgStop("O Arquivo não foi gerado devido a falhas de arredondamento.")
		Return
	Endif
	If  nTotFat <> nValor
		aadd(aLog1,{"Erro - diferenca encontrada","Oper: " + cOpeOriBTO+ "   Titulo: " + cPrefixoBTO + " " + cNumTitBTO,"Movimento:  "+ alltrim(transform(nTotFat,"@E 999,999,999.99")) + "   Fatura:  "+alltrim(transform(nValor,"@E 999,999,999.99"))})
		PlsLogFil(Space(03)+aLog1[Len(aLog1),1]+Space(03)+aLog1[Len(aLog1),2]+Space(03)+aLog1[Len(aLog1),3],"LOGCABA011.TXT")
	Endif
	
	R01->(DbGoTop())
	If  ! R01->(EOF())
		//			PlsPTU(PadR(cLayOut, 6),cArqNom,cDirNov,.F.)
		cCodLay := PadR(cLayOut, 6)
		cNomArq := cArqNom
		cNovDir := cDirNov
		lMsg := .F.
		
		If Empty(cNovDir)
			cDirEnv := PLSMUDSIS( "\ptu\" )
		Else
			cDirEnv := PLSMUDSIS( AllTrim(cNovDir)+"\" )
		EndIf
		nH := FCreate(cDirEnv+cNomArq)
		if FERROR() = 430
			MakeDir(cDirEnv)
			nH := FCreate(cDirEnv+cNomArq)
		endif
		if nH == -1
			MsgInfo('Não foi possivel CRIAR o ARQUIVO!')
			return
		endif
		
		nNumSeq := 1
		cVal      := Strzero(nNumSeq,7,0)
		cVal      += "00"
		cVal      += cCodInt
		cVal      += cNomInt
		cVal      += cCompet
		cVal      += "1"
		cVal      += SUBSTR(DTOS(DDATABASE),7,2)+SUBSTR(DTOS(DDATABASE),5,2)+SUBSTR(DTOS(DDATABASE),1,4)
		cVal      += SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2)+SUBSTR(TIME(),7,2)
		cVal      += "10"+Chr(13)+Chr(10)
		cLinStr   := cVal + Chr(13)+Chr(10)
		ChkGrava(nH,@cVal,.T.)
		
		Do while !R01->(EOF())
			nNumSeq++
			/*
			....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8
            123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			008FLAVIA RANGEL MIRANDA                             0001000400237500              226914000167        FLAVIA RANGEL MIRANDA                             0000007299+0000000365+0000000840+000000008504+0002		
			*/
			
			cChave501 := R01->CHAVE
			cVal      := Strzero(nNumSeq,7,0)
			cVal      += "03"
			cVal      += SubStr(R01->R501,004,50)
			cVal      += SubStr(R01->R501,054,30)
			cVal      += SubStr(R01->R501,084,20)
			cVal      += SubStr(R01->R501,104,50)
			cVal      += Chr(13)+Chr(10)
			cLinStr   := cVal + Chr(13)+Chr(10)
			ChkGrava(nH,@cVal,.T.)
			
			DbSelectArea("R02")
			R02->(MsSeek(cChave501,.t.))
			Do While SUBSTR(R02->CHAVE,1,18) == cChave501 .and. R02->(!EOF())
				cChave502 := SUBSTR(R02->CHAVE,1,35)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta o corpo do arquivo																³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
				/*
				....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
				123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
				REC108086     008  0001000400238100              242332000151        J30104947000103HOSPITAL SANTA CRUZ                               15012008                00000001032+0000000052+0000000000+000000001084+0001
				*/                                                                                                                                            

				nNumSeq++				
				cVal      := Strzero(nNumSeq,7,0)
				cVal      += "05"
				cVal      += SubStr(R02->R502,01,14)    //Numero da Guia
				cVal      += SubStr(R02->R502,70,01)    //Tipo de Pessoa do prestador
				cVal      += SubStr(R02->R502,71,14)    //CPF/CNPJ do prestador
				cVal      += SubStr(R02->R502,85,50)    //Nome do prestador
				cVal      += SubStr(R02->R502,135,08)   // data de atendimento
				cVal      += SubStr(R02->R502,143,08)   //Data de Internacao
				cVal      += SubStr(R02->R502,151,08)   //Data de alta
				cVal      += Chr(13)+Chr(10)
				cLinStr   := cVal + Chr(13)+Chr(10)
				ChkGrava(nH,@cVal,.T.)
				
				DbSelectArea("R04")
				R04->(MsSeek(cChave502,.t.))
				Do While SUBSTR(R04->CHAVE,1,35) == cChave502 .and. R04->(!EOF())
					nNumSeq ++
					/*
					....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
					123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
					00804032009000010014            CONSULTA MEDICA                                                                                                                                                                                                                                           001+0000004200+0000000210+0000000840+000000005250+
					00804032009021010056            EXAME CITOPATOLOGICO CERVICO-VAGINAL ONCOTICO E MI                                                                                                                                                                                                        001+0000001607+0000000080+0000000000+000000001687+
					00804032009021010145            EXAME CITOPATOLOGICO HORMONAL ISOLADO                                                                                                                                                                                                                     001+0000001492+0000000075+0000000000+000000001567+
					00815012008090110099            MATERIAIS NO QUARTO                                                                                                                                                                                                                                       001+0000001032+0000000052+0000000000+000000001084+
					*/
					
					cVal      := Strzero(nNumSeq,7,0)
					cVal      += "07"
					cVal      += SUBSTR(R04->R504,12,20)     //Estrutura do Evento (Codigo do Evento)
					cVal      += SUBSTR(R04->R504,33,250)    //Descricao do Evento
					cVal      += SUBSTR(R04->R504,283,03)
					cVal      += SUBSTR(R04->R504,286,01)
					cVal      += SUBSTR(R04->R504,287,10)
					cVal      += SUBSTR(R04->R504,297,01)
					cVal      += SUBSTR(R04->R504,298,10)
					cVal      += SUBSTR(R04->R504,308,01)
					cVal      += SUBSTR(R04->R504,309,10)
					cVal      += SUBSTR(R04->R504,319,01)
					cVal      += SUBSTR(R04->R504,320,12)
					cVal      += SUBSTR(R04->R504,332,01)
					cVal      += Chr(13)+Chr(10)
					cLinStr   := cVal + Chr(13)+Chr(10)
					ChkGrava(nH,@cVal,.T.)
					R04->(DbSkip())
				EndDo

				/*
				....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8
				123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
				1648139       008  0001000400237500              226914000167        J42420539000140LAB DE PATOL CLIN BRAZ MAIOLINO                   04032009                00000003099+0000000155+0000000000+000000003254+0002
				REC108086     008  0001000400238100              242332000151        J30104947000103HOSPITAL SANTA CRUZ                               15012008                00000001032+0000000052+0000000000+000000001084+0001
				3452982       008  0001000400239100              230597000100        J61486650005061LAB BRONSTEIN                                     06022009                00000001638+0000000082+0000000000+000000001720+0002				
				*/
				
				nNumSeq++
				cVal      := Strzero(nNumSeq,7,0)
				cVal      += "09"
				cVal      += Substr(R02->R502,206,04)
				cVal      += Substr(R02->R502,159,10)
				cVal      += Substr(R02->R502,170,01)
				cVal      += Substr(R02->R502,171,10)
				cVal      += Substr(R02->R502,181,01)
				cVal      += Substr(R02->R502,182,10)
				cVal      += Substr(R02->R502,192,01)
				cVal      += Substr(R02->R502,193,12)
				cVal      += Substr(R02->R502,205,01)
				cVal      += Chr(13)+Chr(10)
				cLinStr   := cVal + Chr(13)+Chr(10)
				ChkGrava(nH,@cVal,.T.)
				
				R02->(DbSkip())
			EndDo
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta o TRAILLER registro do beneficiario												³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			/*
			....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7...+....8
			123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			008FLAVIA RANGEL MIRANDA                             0001000400237500              226914000167        FLAVIA RANGEL MIRANDA                             0000007299+0000000365+0000000840+000000008504+00020003
			*/
			
			nNumSeq++
			cValR01      := Strzero(nNumSeq,7,0)
			cValR01      += "11"
			cValR01      += Substr(R01->R501,200,04)
			cValR01      += Substr(R01->R501,204,04)
			cValR01      += Substr(R01->R501,154,10)
			cValR01      += Substr(R01->R501,164,01)
			cValR01      += Substr(R01->R501,165,10)
			cValR01      += Substr(R01->R501,175,01)
			cValR01      += Substr(R01->R501,176,10)
			cValR01      += Substr(R01->R501,186,01)
			cValR01      += Substr(R01->R501,187,12)
			cValR01      += Substr(R01->R501,199,01)
			cValR01      += Chr(13)+Chr(10)
			
			cLinStr   := cValR01 + Chr(13)+Chr(10)
			ChkGrava(nH,@cValR01,.T.)
			
			R01->(DbSkip())
			
		EndDo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o rodape do arquivo																³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nNumSeq++
		cVal      := Strzero(nNumSeq,7,0)
		cVal      += "99"
		cVal      += StrZero(nQtd_501,4)      //Quantidade de registros de beneficiarios
		cVal      += StrZero(nQtd_502T,6)      //Quantidade de registros de guias
		cVal      += StrZero(nQtd_504T,8)      //Quantidade de registros de eventos
		cVal      += strzero(noround(nVlTotPag,2)*100,12)       //Total valor pago
		cVal      += Iif(nTotFat < 0, "-", "+")              //Sinal do total valor pago
		cVal      += strzero(noround(nVlTotTax,2)*100,12)      //Total valor taxa
		cVal      += Iif(nTot_Tax < 0, "-", "+")   //Sinal do total valor pago
		cVal      += strzero(noround(nVlTotINSS,2)*100,12)     //Total valor inss
		cVal      += Iif(nTot_INSS < 0, "-", "+")              //Sinal do total valor inss
		cVal      += strzero(noround((nVlTotPag+nVlTotTax+nVlTotINSS),2)*100,15)              //Total valor total
		cVal      += Iif((nVlTotPag+nVlTotTax+nVlTotINSS) < 0, "-", "+")              //Sinal do total valor total
		cVal      += Chr(13)+Chr(10)
		cLinStr   := cVal + Chr(13)+Chr(10)
		ChkGrava(nH,@cVal,.T.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha o arquivo																			³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		FClose(nH)
		
		If File(cDirEnv+cNomArq)
			MsgInfo('Arquivo gerado. '+cDirEnv+cNomArq)
		EndIf
		
		aadd(aLog1,{"Arquivo gerado ","Oper: " + cOpeOriBTO + "   Titulo: " + cPrefixoBTO + " " + cNumTitBTO,"Movimento:  "+ alltrim(transform(nTotFat,"@E 999,999,999.99")) + "   Fatura:  "+alltrim(transform(nValor,"@E 999,999,999.99"))})
		PlsLogFil(Space(03)+aLog1[Len(aLog1),1]+Space(03)+aLog1[Len(aLog1),2]+Space(03)+aLog1[Len(aLog1),3],"LOGCABA011.TXT")
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe log de ocorrencias                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLog1) > 0 .or.	len(aLog2) > 0
		If  len(aLog1) > 0
			For i := 1 to len(aLog1)
				aadd(aLog,aLog1[i])
			Next
		Endif
		If  len(aLog2) > 0
			For i := 1 to len(aLog2)
				aadd(aLog,aLog2[i])
			Next
		Endif
		//		aadd(aLog,{"","",""})
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha arquivo temporario...                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R01->(dbCloseArea())
	R02->(dbCloseArea())
	R04->(dbCloseArea())
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha temporario...						                         		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TMP->(DBCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao      						                         		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ A011Envi ºAutor  ³Luzio Tavares        º Data ³  01/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Marca a fatura como enviada                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A011Envi(cOperadora, cNumero, cReciproc)

BTO->(DbGoTop())

If BTO->(MsSeek(xFilial("BTO")+cOperadora+cNumero+cReciproc))
	BTO->(Reclock("BTO",.F.))
	BTO->BTO_ENV500 := "1"
	BTO->(MsUnlock())
Else
	MsgAlert("Erro ao marcar fatura como enviada. Fatura de Reciprocidade nao Encontrada! - "+cOperadora + cNumero)
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares        º Data ³  01/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o pergunte padrao                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora Origem    "   ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"02","Envio de Mat/Med    "   ,"","","mv_ch2","N", 1,0,0,"C","","mv_par02","Fechado","","","","","Aberto","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Enviar              "   ,"","","mv_ch3","N", 1,0,0,"C","","mv_par03","Nao Enviadas","","","","","Ja Enviadas","","","","","Todas","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Grp. Operad. Inicial"   ,"","","mv_ch4","C", 2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","BA2",""})
aadd(aRegs,{cPerg,"05","Grp. Operad. Final  "   ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","BA2",""})
Aadd(aRegs,{cPerg,"06","Grupo/Empresa De    "   ,"","","MV_CH6","C",04,0,0,"G","","Mv_Par06","","","","","","","","","","","","","","","","","","","","","","","","","BG9",""})
Aadd(aRegs,{cPerg,"07","Grupo/Empresa Ate   "   ,"","","MV_CH7","C",04,0,0,"G","","Mv_Par07","","","","","","","","","","","","","","","","","","","","","","","","","BG9",""})
aadd(aRegs,{cPerg,"08","Contrato Inicial    "   ,"","","mv_ch8","C",15,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","BE3PLS",""})
aadd(aRegs,{cPerg,"09","Contrato Final      "   ,"","","mv_ch9","C",15,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","BE3PLS",""})
aadd(aRegs,{cPerg,"10","Sub-Contrato Inicial"   ,"","","mv_cha","C",12,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","BE5PLS",""})
aadd(aRegs,{cPerg,"11","sub-contrato Final  "   ,"","","mv_chb","C",12,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","BE5PLS",""})
aadd(aRegs,{cPerg,"12","Cod.Prestador"          ,"","","mv_chc","N", 1,0,0,"C","","mv_par12","Codigo RDA","","","","","Nr.Cons.Reg.","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"13","Converter TUSS"         ,"","","mv_chd","N", 1,0,0,"C","","mv_par13","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"14","Diretorio de Gravacao " ,"","","mv_che","C",50,0,2,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","",""})
//aadd(aRegs,{cPerg,"06","Imprimir Nota"          ,"","","mv_ch6","N", 1,0,0,"C","","mv_par06","Numero da Guia"         ,"","","","","Numero Impresso"            ,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"15","Tp.Tab. AMB         "   ,"","","mv_chf","C", 2,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","B41PLS",""})
//aadd(aRegs,{cPerg,"09","A partir de"            ,"","","mv_ch9","D", 8,0,0,"G","","mv_par09",""         ,"","","","",""            ,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"16","LayOut              "   ,"","","mv_chg","N", 1,0,0,"C","","mv_par16","CABESP","","","","","A500","","","","","","","","","","","","","","","","","","","",""})
PlsVldPerg( aRegs )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao   ³ CABA011MARK³ Autor ³ Luzio Tavares      ³ Data ³ 01.07.2009 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Marca/Desmarca todos os itens do Browse...                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA011MARK(cFiltro)

LOCAL cSQL

MsProcTXT(If(lCheck,"Marcando","Desmarcando")+" Todas as Faturas...")
ProcessMessage()

cSQL := "UPDATE "+RetSQLName("BTO")+" SET BTO_OK = "

If lCheck
	cSQL := cSQL + "'"+cMarca+"'"
Else
	cSQL := cSQL + "''"
Endif

cSQL += " WHERE BTO_FILIAL = '" + xFilial("BTO") + "' AND D_E_L_E_T_ <> '*' AND "
cSQL += " BTO_STATUS = '1' AND BTO_CODOPE = '" + cOpeOri + "' " + cFiltro

If BTO->(FieldPos("BTO_GRPOPE")) > 0
	cSQL += " AND BTO_GRPOPE >= '" + cGrpIni + "' AND BTO_GRPOPE <= '" + cGrpFim + "' "
Endif

TCSQLExec(cSQL)

BTO->(DbGoTop())
BTO->(MsSeek(xFilial("BTO")))

oMark:oBrowse:Refresh()
Return
