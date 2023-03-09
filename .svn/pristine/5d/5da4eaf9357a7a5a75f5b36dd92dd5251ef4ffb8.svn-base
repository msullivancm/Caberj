User Function LANCCREDINT()

bGerPagto := {||GerPagto()}
bExcPagto := {||ExcPgto()}
Private aRotina:={}

Private cCadastro:="Lancamentos de Creditos de Rateios"
aAdd(aRotina,{"Pesquisar","AxPesqui()",0,1})
aAdd(aRotina,{"&Visualizar","U_MntLanc",0,2})
aAdd(aRotina,{"&Gera Pagto","U_MntLanc",0,3})
aAdd(aRotina,{"&Excluir","U_MntLanc",0,5})

PRIVATE cPath  := ""
PRIVATE cAlias := "ZZV"

dbSelectArea("ZZV")
dbSetOrder(1)
dbGoTop()
MBrowse(,,,,"ZZV")
Return

User Function MntLanc (cAlias,cRecNo,nOpc)
Local nEscolha:=0

If nOpc==2
	AxVisual(cAlias,cRecNo,nOpc)
	
Elseif nOpc==3
	begin Transaction
	nEscolha:=AxInclui(cAlias,cRecNo,nOpc)
	If nEscolha==1
		GERAAUDIMED()
	EndIf
	End Transaction
	
Elseif nOpc==4
	Begin Transaction
	lRet := ExcPagto(cAlias,cRecNo,nOpc)
	If lRet
		nEscolha := AxDeleta(cAlias,cRecNo,nOpc)
	EndIf
	End Transaction
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ InsereBGQ  ³ Autor ³ Leandro Marques   ³ Data ³ 19.09.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Inclui registro de crédito na tabela BGQ conforme plano/RDA³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function InsereBGQ(cCodPlano, cValorBGQ, cTipFaixa)

Local cCodLanBBB := ""
Local cSQL := ""
Local cDescServ := ""

cDescServ := IIf(cTipFaixa == "1","RATEIO INTERNISTA","AAG")

If cCodPlano $ ("0010,0011,0012,0013") //Qdo for empresarial buscar o servico do Afinidade.
	cCodPlano := "0006"
EndIf

//---> Leandro 29/10/2007
If cDescServ == " "
	cCodPlano := "0006"
EndIf

cSQL := " SELECT BBB_CODSER FROM "+RetSQLName("BBB")
cSQL += " WHERE BBB_YCODPL = '"+cCodPlano+"'"
cSQL += " AND BBB_DESCRI LIKE '%"+cDescServ+"%'"
cSQL += " AND ROWNUM = 1 "
PLSQuery(cSQL,"TRR")
cCodLanBBB := TRR->BBB_CODSER


IF AllTrim(cCodLanBBB) == ""
	If cTipFaixa == "2"
		cCodLanBBB := "127"
	Else
		cCodLanBBB := "138"
	EndIf
EndIf

TRR->(DbCloseArea())

BGQ->(Reclock("BGQ",.T.))
BGQ->BGQ_FILIAL	:= xFilial("BGQ")
BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
BGQ->BGQ_CODIGO	:= cCodRda
BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+cCodRDA,"BAU_NOME")
BGQ->BGQ_ANO	    := ZZV->ZZV_ANOPAG
BGQ->BGQ_MES	    := ZZV->ZZV_MESPAG
BGQ->BGQ_CODLAN	:= cCodLanBBB
BGQ->BGQ_VALOR	:= cValorBGQ
BGQ->BGQ_QTDCH	:= 0
BGQ->BGQ_TIPO	:= "2" //Credito
BGQ->BGQ_TIPOCT	:= "2" //PJ
BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
BGQ->BGQ_CODOPE	:= PLSINTPAD()
BGQ->BGQ_CONMFT	:= "0" //Nao
BGQ->BGQ_OBS	    := IIf(cTipFaixa == "1","Rateio Internista - Fatura ","Rateio AAG - Fatura ")+BGQ->BGQ_CODSEQ
BGQ->BGQ_USMES	:= Posicione("BFM",1,PLSINTPAD()+ZZV->(ZZV_ANOPAG+ZZV_MESPAG),"BFM_VALRDA")
BGQ->BGQ_LANAUT	:= "0" //Nao
BGQ->BGQ_YLTAUD	:= ""
BGQ->(MsUnlock())
ConfirmSx8()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ GERAAUDIMED³ Autor ³ Leandro Marques   ³ Data ³ 19.09.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GERAAUDIMED()
Local lret

Private nBytes := 0
Private cTitulo := "Gerando rateio internista"
Processa({|| lret := AdicioAudimed() }, cTitulo, "", .T.)

Return lret


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXCPAGTO   ³ Autor ³ Leandro Marques   ³ Data ³ 19.09.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EXCPAGTO(cAlias,nReg,nOpc)
LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK    	:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }
LOCAL cSQL		:= ""

//PRIVATE cAlias := "ZZV"

//begin Transaction

cSQL := " SELECT R_E_C_N_O_ AS REGBGQ FROM "+RetSQLName("BGQ")
cSQL += " WHERE BGQ_CODIGO = '"+ZZV->ZZV_CODRDA +"' "
cSQL += " AND BGQ_ANO      = '"+ZZV->ZZV_ANOPAG+"' "
cSQL += " AND BGQ_MES      = '"+ZZV->ZZV_MESPAG+"' "
cSQL += " AND BGQ_NUMLOT   = ' ' "
cSQL += " AND D_E_L_E_T_ = ' '   "
PlsQuery(cSQL,"TRB")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apagar somente registros nao pagos, e limpar guias ja marcadas...   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If TRB->(Eof())
	MsgAlert("Impossível excluir o rateio. Adicionais de pagamento já faturados ou inexistentes !","Atenção")
	TRB->(DBCloseArea())
	Return .F.
EndIf

BGQ->(DbSetOrder(2))
ZZV->(DbSetOrder(2))

While !TRB->(Eof())
	BGQ->(DbGoTo(TRB->REGBGQ))
	BGQ->(RecLock("BGQ",.F.))
	BGQ->(DbDelete())
	BGQ->(MsUnlock())
	TRB->(DBSkip())
EndDo

//If //Condicao para nao excluir...
ZZV->(RecLock("ZZV",.F.))
ZZV->(DbDelete())
ZZV->(MsUnlock())
//Endif

//End Transaction

TRB->(DBCloseArea())


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AdicioAudimed ºAutor  ³ Leandro Marquesº Data ³  19/09/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Geracao dos adicionais ao prestador no parametro.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga.                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AdicioAudimed()
Local aRet := {}

Local cRDAAud	:= ""
Local nVlrAud	:= ""
Local nVlrUni	:= 0
Local cSQL		:= ""
Local nProc		:= 0
Local nCont		:= 0
Local nTotReg	:= 0
Local nQtdCri	:= 0
Local nTotQry	:= 0
Local nTotArr	:= 0
Local cCodPla	:= ""
Local cVerPla	:= ""
//Local aProcAud	:= {}
Local aPlaQtd	:= {}
Local aErr		:= {}
Local lPerAud	:= .F.
//----> Leandro 23/08/2007
Local cCrmSolic := ""
Local cTipoPgto := ""
Local cTipFaixa := ""
Local cVlrFX    := ""
Local aNomePro  := ""
Local aQtdePro  := ""
Local IncI      := ""
Local cNomeRDA  := ""
Local nVlrRat   := ""
Local nQtdRat   := ""
Local cMesPag   := ""
Local cAnoPag   := ""
Local nQtdRegua := ""
Local cDataBase := ""
cCodProc  := GetNewPar("MV_YCODPROC","86000020")
//----<
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de indices para busca...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(1)) //Tabela das RDAS
ZZV->(DbSetOrder(1)) //Tabela que guarda os rateios dos internistas / AAG
BE4->(DbSetOrder(11))//Tabela de internacoes
BGQ->(DbSetOrder(2)) //Tabela de adicionais de credito / debito
ZZU->(DbSetOrder(1)) //Tabela de Faixas de Internistas / AAG


If ZZU->(MsSeek(xFilial("ZZU")+ZZV->ZZV_CODRDA))
	If BAU->(MsSeek(xFilial("BAU")+ZZV->ZZV_CODRDA))
		cCrmSolic := BAU->BAU_CONREG
		cTipoPgto := BAU->BAU_GRPPAG
		cNomeRDA  := BAU->BAU_NOME
		cCodRda   := BAU->BAU_CODIGO
		cMesPag   := ZZV->ZZV_MESPAG
		cAnoPag   := ZZV->ZZV_ANOPAG
	EndIf
Else
	MsgAlert("A RDA informada nao esta na classe de rateios para internistas / AAG. Verifique Tabela ZZU")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consulta para verificar o total de internacoes solicitadas pela RDA ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ



If cTipoPgto == "0005"
	cSQL := " SELECT ZZU_TPFAIX AS FAIXA  FROM "+RetSQLName("ZZU")
	cSQL += " WHERE ZZU_CODRDA = '"+cCodRda+"' "
	cSQL += " AND ZZU_DTVGFI = ' ' "
	cSQL += " AND ROWNUM = 1 "
	PLSQuery(cSQL,"TRB")
	cTipFaixa := TRB->FAIXA
	
	If TRB->(Eof())
		MsgAlert("Faixa nao cadastrada para este RDA !!!")
		TRB->(DbCloseArea())
		Return .F.
	EndIf
	
	TRB->(DbCloseArea())
	
	If cTipFaixa == "1" //TRATAMENTO PARA OS INTERNISTAS
		cSQL := " SELECT Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTAL FROM "+RetSQLName("BD6")
		cSQL += " WHERE BD6_FILIAL = ' ' AND BD6_CODOPE = '0001' "
		cSQL += " AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"' "
		cSQL += " AND D_E_L_E_T_ <> '*' "
		cSQL += " AND BD6_CODPRO = '"+cCodProc+"'"
		cSQL += " AND BD6_CODRDA = '"+cCodRda+"'"
		cSQL += " AND BD6_SITUAC = '1' "
		//'104841' ---106593
		//MemoWrite("C:\lanccred.txt",cSQL)
		PLSQuery(cSQL,"TRB")
		nTotQry := TRB->TOTAL
		
		If nTotQry == 0
			MsgAlert("Nao existe atendimentos para este RDA neste periodo !!!")
			TRB->(DbCloseArea())
			Return .F.
		EndIf
		
		TRB->(DbCloseArea())
		
	Else  //TRATAMENTO PARA O PRESTADOR DO AAG
		cSQL := " SELECT Count(DISTINCT bf4_codemp||bf4_matric||bf4_tipreg) AS QTDAAG FROM "+;
		RetSQLName("BF4")+" BF4, "+;
		RetSQLName("BA1")+" BA1, "+;
		RetSQLName("BI3")+" BI3  "
		cSQL += " WHERE BF4_DATBLO = ' '      "
		cSQL += " AND BF4_CODPRO = '0041'     " //Codigo do opcional AAG
		cSQL += " AND BF4.D_E_L_E_T_ = ' '    "
		cSQL += " AND BF4_DATBAS <= '"+DtoS(ZZV->ZZV_DATBAS)+"'"
		cSQL += " AND BF4_FILIAL = BA1_FILIAL "
		cSQL += " AND BF4_CODINT = BA1_CODINT "
		cSQL += " AND BF4_CODEMP = BA1_CODEMP "
		cSQL += " AND BF4_MATRIC = BA1_MATRIC "
		cSQL += " AND BF4_TIPREG = BA1_TIPREG "
		cSQL += " AND BA1_CODINT = BI3_CODINT "
		cSQL += " AND BA1_VERSAO = BI3_VERSAO "
		cSQL += " AND BA1_CODPLA = BI3_CODIGO "
		PLSQuery(cSQL,"TRB")
		nTotQry := TRB->QTDAAG
		
		If nTotQry == 0
			MsgAlert("Nao existe atendimentos para este RDA neste periodo !!!")
			TRB->(DbCloseArea())
			Return .F.
		End If
		
		TRB->(DbCloseArea())
	EndIf
	
	cSQL := " SELECT ZZU_VLRPGF AS VLRFX  FROM "+RetSQLName("ZZU")
	cSQL += " WHERE ZZU_CODRDA = '"+cCodRda+"'"
	cSQL += " AND ZZU_DTVGFI = ' ' "
	cSQL += " AND '"+AllTrim(Str(nTotQry))+"' BETWEEN ZZU_FXQTIN AND ZZU_FXQTFI "
	cSQL += " AND D_E_L_E_T_ = ' ' "
	PLSQuery(cSQL,"TRB")
	cVlrFX := TRB->VLRFX
	TRB->(DbCloseArea())
Else
	MsgAlert("RDA nao pertence ao grupo dos prestadores especiais !!!")
EndIf


Begin Transaction
//-----> Seleciona as qtde x valor por produto
IF cTipFaixa == "1" //TRATAMENTO PARA OS INTERNISTAS
//	cSQL := " SELECT BA1_CODPLA, BA1_VERSAO, BI3_NREDUZ, Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS QTDE FROM "+;
	cSQL := " SELECT BD6_CODPLA, Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS QTDE "
	cSQL += " FROM "+RetSQLName("BD6")+" BD6 "  //	RetSQLName("BD6")+" BD6, "+RetSQLName("BA1")+" BA1, "+RetSQLName("BI3")+" BI3  "
	cSQL += " WHERE BD6_FILIAL = ' ' AND BD6_CODOPE = '0001' "
	cSQL += " AND BD6_ANOPAG = '"+cAnoPag+"'"
	cSQL += " AND BD6_MESPAG = '"+cMesPag+"'"
	cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
	cSQL += " AND BD6_CODPRO = '86000020' "
	cSQL += " AND BD6_CODRDA = '"+cCodRda+"'"
//	cSQL += " AND BD6_FILIAL = BA1_FILIAL "
//	cSQL += " AND BD6_CODOPE = BA1_CODINT "
//	cSQL += " AND BD6_CODEMP = BA1_CODEMP "
//	cSQL += " AND BD6_MATRIC = BA1_MATRIC "
//	cSQL += " AND BD6_TIPREG = BA1_TIPREG "
//	cSQL += " AND BD6_DIGITO = BA1_DIGITO "
//	cSQL += " AND BD6_CODPLA = BI3_CODIGO "
////	cSQL += " AND BA1_CODPLA = BI3_CODIGO "
	cSQL += " AND BD6_SITUAC = '1' "
//	cSQL += " GROUP BY BA1_CODPLA, BA1_VERSAO, BI3_NREDUZ "
	cSQL += " GROUP BY BD6_CODPLA "
	
	//MemoWrite("C:\Teste.txt",cSQL)
	PLSQuery(cSQL,"TRB")
	
Else  //TRATAMENTO PARA O PRESTADOR DO AAG
//	cSQL := " SELECT BA1_CODPLA, BA1_VERSAO, BI3_NREDUZ, Count(DISTINCT bf4_matric||bf4_tipreg) AS QTDE FROM "+;
	cSQL := " SELECT BF4_CODPRO, Count(DISTINCT bf4_matric||bf4_tipreg) AS QTDE "
	cSQL += " FROM "+RetSQLName("BF4")+" BF4 "  //	RetSQLName("BF4")+" BF4, "+RetSQLName("BA1")+" BA1, "+RetSQLName("BI3")+" BI3  "
	cSQL += " WHERE BF4_DATBLO = ' ' "
	cSQL += " AND BF4_CODPRO = '0041' " //Codigo do opcional AAG
	cSQL += " AND BF4.D_E_L_E_T_ = ' ' "
	cSQL += " AND BF4_FILIAL = BA1_FILIAL "
	cSQL += " AND BF4_DATBAS <= '"+DtoS(ZZV->ZZV_DATBAS)+"'"
//	cSQL += " AND BF4_CODINT = BA1_CODINT "
//	cSQL += " AND BF4_CODEMP = BA1_CODEMP "
//	cSQL += " AND BF4_MATRIC = BA1_MATRIC "
//	cSQL += " AND BF4_TIPREG = BA1_TIPREG "
////	cSQL += " AND BA1_CODPLA = BI3_CODIGO "
//	cSQL += " AND BF4_CODPRO = BI3_CODIGO "
//	cSQL += " GROUP BY BA1_CODPLA, BA1_VERSAO, BI3_NREDUZ "
	cSQL += " GROUP BY BF4_CODPRO "
	
	//MemoWrite("c:\LANCCREDINT.TXT",cSQL)
	PLSQuery(cSQL,"TRB")
EndIf
//------<


ZZV->(RecLock("ZZV",.F.))
IF cTipFaixa == "1"
	ZZV->ZZV_VLRRAT := cVlrFX
Else
	ZZV->ZZV_VLRRAT := nTotQry * cVlrFX
EndIf

If ZZV->ZZV_VLRRAT == 0
	MsgAlert(" Valor da faixa nao encontrado ou nao foi cadastrado para a RDA !!!")
	TRB->(DbCloseArea())
	Return .F.
End If

ZZV->ZZV_QTDRAT := nTotQry
ZZV->ZZV_CODOPE := PLSINTPAD()
ZZV->(MsUnlock())

nQtdRegua := 0
While ! TRB->(Eof())
	
	IncProc("Gravando registro de Credito em BGQ")
	nQtdRegua++
	ProcRegua(nQtdRegua)
	cCodPla := TRB->BD6_CODPLA    //TRB->BA1_CODPLA
	cValorPla := (ZZV->ZZV_VLRRAT / nTotQry) * TRB->QTDE
	U_InsereBGQ(cCodPla, cValorPla, cTipFaixa)
	
	TRB->(DbSkip())
End
MsgAlert("Rateio da RDA gerado. Verifique os resultados!")

End Transaction

TRB->(DbCloseArea())

//Return aRet
Return
