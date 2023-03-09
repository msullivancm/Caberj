//#INCLUDE "CABR017.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³CABR017  ³ Autor ³ Luzio Tavares          ³ Data ³ 07/11/08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Lista as RDAs por tipo de classe, cidade de forma analitica³±±±
±±³          ³ sintetica                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ CABR017                                                    ³±±±
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
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CABR017()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220  //132
PRIVATE cTamanho    := "G"  //"M"
PRIVATE cTitulo     := "Relatorio por Classe da Rede de Atendimento"
PRIVATE cDesc1      := "Emitir a Quantidade de Rede de Atendimento por Classe."
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BAU"
PRIVATE cPerg       := "CABR17"
PRIVATE cRel        := "CABR017"
PRIVATE nli         := 61
PRIVATE m_pag       := 1
PRIVATE lCompres    := .T.   //.F.  // Habilita/Desabilita o Formato Comprimido/Expandido
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
Private nTipo			:= 15
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }

PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Classe                                          Especialidade                             UF Cidade            Regiao                         CEP       Bairro                         Total"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 01
PRIVATE aLinha      := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Dados do parametro...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCodRedDe  := mv_par01 // Codigo da Rede de atendimento de
PRIVATE cCodRedAte := mv_par02 // Codigo da Rede de atendimento ate
PRIVATE cCodEspDe  := mv_par03 //
PRIVATE cCodEspAte := mv_par04 //
PRIVATE cDistribuido := MV_PAR16
PRIVATE nAtivo     := mv_par03 // Somente ativos (Sim;Nao;Ambos)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa ambiente do relatorio somente top...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! PLSRelTop()
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint (padrao)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao (padrao)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey == 27
	Set Filter To
	Return
End
cCodClaDe    := Mv_Par01
cCodClaAte   := Mv_Par02
cCodRdaDe    := mv_par03 // Codigo da Rede de atendimento de
cCodRdaAte   := mv_par04 // Codigo da Rede de atendimento ate
cCodEspDe    := mv_par05
cCodEspAte   := mv_par06
cCodUFDe     := Mv_Par07
cCodUFAte    := Mv_Par08
cCodCEPDe    := Mv_Par09
cCodCEPAte   := Mv_Par10
cCodMunDe    := Mv_Par11
cCodMunAte   := Mv_Par12
cCodRegDe    := Mv_Par13
cCodRegAte   := Mv_Par14
cSepBairro   := Mv_Par15
cDistribuido := MV_PAR16
nAnaSin      := MV_PAR17

nAtivo     := mv_par05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

If  nLastKey == 27
	Set Filter To
	Return
End

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//MsAguarde({|| CABR017Imp() }, cTitulo, "", .T.)
//RptStatus({|lEnd| CABR017IMP(@lEnd,wnRel,cString,nomeprog,Titulo,Cabec1, cabec2)},Titulo)
//RptStatus({|lEnd| CABR017Imp(@lEnd,cRel,cAlias)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa relatorio                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| CABR017Imp() }, "Processando Informações...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera spool                                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	Ourspool(cRel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³CABR017Imp³ Autor ³ Luzio tavaers         ³ Data ³ 07/11/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
//Static Function CABR017Imp(lEnd,cRel,cString)
Static Function CABR017Imp()

Local n := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cSQL
LOCAL nOrdSel  := aReturn[8]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cadastro da Rede de Atendimento...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cBAUName := RetSQLName("BAU")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cCodRed
LOCAL cCampX3
LOCAL cCampCb
LOCAL cContX3
LOCAL cTypeX3
LOCAL cArqOrd
LOCAL cArqSek
LOCAL cSx3Sek
LOCAL cCampBx
LOCAL cResuBx
LOCAL lAux
LOCAL cOper  := ""

Local nTotal   := 0    // recebe o n total de registros
Local nProc    := 1    // incrementado por unidade de registro
Local	Npercent := 0
Local aQtdClaRda := {}

////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
////³ Exibe mensagem...                                                        ³
////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//MsProcTxt(PLSTR0001)

If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
	cCabec1 := "Classe                                            Total"
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * "
If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0 .and. cDistribuido == 2
	cSQL += "FROM "+RetSQLName("BAU")+" BAU, "+RetSQLName("BBF")+" BBF "
Else
	cSQL += "FROM "+RetSQLName("BAU")+" BAU "
EndIf
cSQL += "WHERE D_E_L_E_T_ = ' ' AND "
cSQL += "BAU_FILIAL = '"+xFilial("BAU")+"'  AND "
cSQL += "BAU_CODIGO >= '"+cCodRDADe+"' AND BAU_CODIGO <= '"+cCodRDAAte+"' "
cSQL += "AND BAU_TIPPRE BETWEEN '"+cCodClaDe+"' AND '"+cCodClaAte+"' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com parametro mv_par03 : bloqueado ou nao                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If      nAtivo == 1 //ativo
//	cSQL += " AND BAU_CODBLO = ' ' "
//ElseIf  nAtivo == 2 //bloqueado
//	cSQL += " AND BAU_CODBLO <> ' ' "
//Endif
If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0  .and. cDistribuido == 2
	cSQL += " AND BBF_CODIGO = BAU_CODIGO "
	cSQL += " AND BBF_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Empty(aReturn[7])
	cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com a ordem....                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If      nOrdSel == 1
//	cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "
//ElseIf  nOrdSel == 2
//	cSQL += "ORDER BY BAU_TIPPRE "
//Endif
cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "

//memowrit("C:\CABR017_1.SQL",cSQL)

PLSQuery(cSQL,"BAUTRB")
BAUTRB->(DbGotop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAUTRB->(DBEval( { | | nTotal++ }))
BAUTRB-> ( DbGotop())
ProcRegua(nTotal)

cDistribuido := 2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! BAUTRB->(Eof())
	/*
	If !Empty(cCodMunAte)
	cSql += "AND BAU_MUN BETWEEN '" + cCodMunDe + "' AND '" + cCodMunAte + "' "
	EndIf
	If !Empty(cUFAte)
	cSql += "BAU_EST BETWEEN '" + cUFDe + "' AND '" + cUFAte + "' AND "
	EndIf
	If !Empty(cCEPAte)
	cSql += "BTS.BTS_CEPUSR BETWEEN '" + cCEPDe + "' AND '" + cCEPAte + "' AND "
	EndIf
	*/
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe mensagem...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Npercent := (nProc/nTotal)*100
	IncProc("Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	nProc++
	
	//Agrupa por Classe da Rede de Atendimento
	cClaRDA    := BAUTRB->BAU_TIPPRE
	cCodUF     := BAUTRB->BAU_EST
	cCodMun    := BAUTRB->BAU_MUN
	cCodBairro := BAUTRB->BAU_BAIRRO
	
	If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
		nPosCod  := aScan(aQtdClaRda,{|x|x[1] == cClaRDA})
		If nPosCod == 0
			Aadd( aQtdClaRDA, {cClaRDA,"","","","","","",1} )
		Else
			aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
		EndIf
	ElseIf !Empty(cCodEspAte) .or. !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte)
		cSelect1 := "SELECT * FROM "+RetSQLName("BAX")+" BAX "
		If !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte) // .or. !Empty(cCodRegAte)
			cSelect1 := "SELECT BB8_CODMUN, BB8_EST, BB8_CEP, BB8_DATBLO, BB8_BAIRRO, BID_YAREA, BAX.* FROM "+RetSQLName("BAX")+" BAX, "+RetSQLName("BB8")+" BB8, "+RetSQLName("BID")+" BID "
			cSelect2 := "AND BB8_FILIAL = '"+xFilial("BB8")+"' "
			cSelect2 += "AND BB8_CODIGO = BAX_CODIGO "
			cSelect2 += "AND BB8_CODLOC = BAX_CODLOC "
			cSelect2 += "AND BB8_DATBLO = '        ' "
			cSelect2 += "AND BB8.D_E_L_E_T_ = ' ' "
			cSelect2 += "AND BID_CODMUN = BB8_CODMUN "
			cSelect2 += "AND BID.D_E_L_E_T_ = ' ' "
			If !Empty(cCodUfAte)
				cSelect2 += "AND BB8_EST BETWEEN '"+cCodUfDe+"' AND '"+cCodUfAte+"' "
			ElseIf !Empty(cCodCEPAte)
				cSelect2 += "AND BB8_CEP BETWEEN '"+cCodCEPDe+"' AND '"+cCodCEPAte+"' "
			ElseIf !Empty(cCodMunAte)
				cSelect2 += "AND BB8_CODMUN BETWEEN '"+cCodMunDe+"' AND '"+cCodMunAte+"' "
				//         ElseIf !Empty(cCodRegAte)
				//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
			ElseIf !Empty(cCodRegAte)   ///.and. !cCodRegAte $ ('zzzz_ZZZZ')
				cSelect2 += "AND BID_YAREA BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' "
				//         ElseIf !Empty(cCodRegAte)
				//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
			EndIf
		EndIf
		cSQL := "WHERE BAX_FILIAL = '"+xFilial("BAX")+"' "
		cSQL += "AND BAX_CODIGO = '"+BAUTRB->BAU_CODIGO+"' "
		//		cSQL += "AND BAX_CODINT = '"+BAUTRB->BAU_CODINT+"' "
		cSQL += "AND BAX_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
		//		cSQL += "AND BAX_CODSUB = '"+BFN->BFN_CODSUB+"' "
		cSQL += "AND BAX_DATBLO = '       ' "
		cSQL += "AND BAX.D_E_L_E_T_ = ' ' "
		
		//		memowrit("C:\CABR017_"+BAUTRB->BAU_CODIGO+".SQL",cSelect1+cSQL+cSelect2)
//		memowrit("C:\CABR017_2.SQL",cSelect1+cSQL+cSelect2)
		
		PLSQuery(cSelect1+cSQL+cSelect2,"BAXTRB")
		BAXTRB->(DbGotop())
		
		While !BAXTRB->(Eof())
			/*
			aQtdClaRDA[1] = Codigo da Classe da Rede de Atendimento
			aQtdClaRDA[2] = Codigo da Especialidade
			aQtdClaRDA[3] = Codigo da Bairro
			aQtdClaRDA[4] = Codigo da Municipio
			aQtdClaRDA[5] = Codigo da UF
			aQtdClaRDA[6] = Codigo da Regiao
			aQtdClaRDA[7] = CEP
			aQtdClaRDA[8] = Quantidade de Profissionais
			*/
			cCodEsp    := BAXTRB->BAX_CODESP
			
			cCodUF     := BAXTRB->BB8_EST
			cCodMun    := BAXTRB->BB8_CODMUN
			cCodBairro := IIf(cSepBairro == 1,BAXTRB->BB8_BAIRRO,"")
			cCodRegiao := IIf(cDistribuido == 1,BAXTRB->BID_YAREA,"")
			cCodCep    := ""  //BAXTRB->BB8_CEP
			
			nPosCod  := aScan(aQtdClaRda,{|x|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] == cClaRDA+cCodEsp+cCodBairro+cCodMun+cCodUF+cCodRegiao+cCodCep})
			
			If nPosCod == 0
				Aadd( aQtdClaRDA, {cClaRDA,cCodEsp,cCodBairro,cCodMun,cCodUf,cCodRegiao,cCodCep,1} )
			Else
				aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
			EndIf
			
			BAXTRB->(DbSkip())
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha arquivo...                                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAXTRB->(DbCloseArea())
	EndIf
	
	BAUTRB->(DbSkip())
Enddo

If Len(aQtdClaRDA) > 0
	
	IncProc("Imprimindo...")
	ProcessMessage()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordenar Array por Classe da Rede de Atendimento...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aQtdClaRda,,, { |x,y| x[1]+x[2]+x[5]+x[4]+x[6]+x[7]+x[3] < y[1]+y[2]+y[5]+y[4]+y[6]+y[7]+y[3] })
	
	cClaRDA := ""
	For n = 1 to Len(aQtdClaRDA)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi abortada a impressao...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If Interrupcao(lAbortPrint)
			nLi ++
			@ nLi, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLi > nQtdLin
			nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
			nLi ++
		Endif
		
		If cClaRDA != aQtdClaRDA[n,1]
			@ nLi, 000 pSay aQtdClaRda[n,1]+" - "+Alltrim(Posicione("BAG",1,xFilial("BAG")+Alltrim(aQtdClaRda[n,1]),"BAG_DESCRI"))
			@ nLi, 050 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
			nLi ++
			cClaRDA := aQtdClaRDA[n,1]
		EndIf
		
		/*
		nTotCla += aQtdClaRDA[n,8]
		
		If !Empty(aQtdClaRDA[n,2])  //Especialidade
		an
		EndIf
		If !Empty(aQtdClaRDA[n,5])   //UF
		EndIf
		If !Empty(aQtdClaRDA[n,4])   //Municipio
		EndIf
		If !Empty(aQtdClaRDA[n,6])   //Regiao
		EndIf
		If !Empty(aQtdClaRDA[n,7])   //CEP
		EndIf
		If !Empty(aQtdClaRDA[n,3])   //Bairro
		EndIf
		*/
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Classe...                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                              1                                                                                                   2
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
		//Classe                                          Especialidade                             UF Cidade                          Regiao                         CEP       Bairro                         Total
		//CLI - CLINICAS MEDICAS                          CLINICA MEDICA                            RJ RIO DE JANEIRO                  123456789012345678901234567890 01000-000 123456789012345678901234567890 123456
		//Classe                                            Total
		//CLI - CLINICAS MEDICAS                            999999
		//                                                                                             ....+....1....+....2....+....3....+....4....+....5
		
		If cDistribuido == 1   // So considerada a separacao por Classe da Rede de Atendimento
			@ nLi, 048 pSay Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+Alltrim(aQtdClaRda[n,2]),"BAQ_DESCRI")  //Especialidade
			@ nLi, 090 pSay aQtdClaRda[n,5]   //UF
			@ nLi, 093 pSay Posicione("BID",1,xFilial("BID")+Alltrim(aQtdClaRda[n,4]),"BID_DESCRI")  //Cidade
			@ nLi, 125 pSay aQtdClaRda[n,6]  //Regiao
			@ nLi, 156 pSay aQtdClaRda[n,7]  //CEP
			@ nLi, 166 pSay aQtdClaRda[n,3]  //Bairro
			@ nLi, 197 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
			nLi ++
//		Else
//			@ nLi, 050 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
		EndIf
//		nLi ++
	Next
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),cTamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAUTRB->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()
Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Classe da Rede De    ","","","MV_CH1","C",03,0,0,"G","","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B42PLS",""})
Aadd(aRegs,{cPerg,"02","Classe da Rede Ate   ","","","MV_CH2","C",03,0,0,"G","","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B42PLS",""})
Aadd(aRegs,{cPerg,"03","RDA De               ","","","MV_CH3","C",06,0,0,"G","","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"04","RDA Ate              ","","","MV_CH4","C",06,0,0,"G","","Mv_Par04","   ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"05","Especialidade De     ","","","MV_CH5","C",03,0,0,"G","","Mv_Par05","   ","","","","","   ","","","","","","","","","","","","","","","","","","","BAQPLS",""})
Aadd(aRegs,{cPerg,"06","Especialidade Ate    ","","","MV_CH6","C",03,0,0,"G","","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","BAQPLS",""})
Aadd(aRegs,{cPerg,"07","UF De                ","","","MV_CH7","C",02,0,0,"G","","Mv_Par07","   ","","","","","   ","","","","","","","","","","","","","","","","","","","12    ",""})
Aadd(aRegs,{cPerg,"08","UF Ate               ","","","MV_CH8","C",02,0,0,"G","","Mv_Par08","   ","","","","","   ","","","","","","","","","","","","","","","","","","","12    ",""})
Aadd(aRegs,{cPerg,"09","CEP de               ","","","MV_CH9","C",07,0,0,"G","","Mv_Par09","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B83PLS",""})
Aadd(aRegs,{cPerg,"10","CEP Ate              ","","","MV_CHa","C",08,0,0,"G","","Mv_Par10","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B83PLS",""})
Aadd(aRegs,{cPerg,"11","Municipio De         ","","","MV_CHb","C",09,0,0,"G","","Mv_Par11","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B57PLS",""})
Aadd(aRegs,{cPerg,"12","Municipio Ate        ","","","MV_CHc","C",10,0,0,"G","","Mv_Par12","   ","","","","","   ","","","","","","","","","","","","","","","","","","","B57PLS",""})
Aadd(aRegs,{cPerg,"13","Regiao De            ","","","MV_CHd","C",06,0,0,"G","","Mv_Par13","   ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"14","Regiao Ate           ","","","MV_CHe","C",06,0,0,"G","","Mv_Par14","   ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"15","Separar por bairro   ","","","MV_CHf","N",01,0,0,"C","","Mv_Par15","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"16","Distribui por Regiao ","","","MV_CHg","N",01,0,0,"C","","Mv_Par16","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"17","Analitico/Sintetico  ","","","MV_CHh","N",01,0,0,"C","","Mv_Par17","Analitico","","","","","Sintetico","","","","","","","","","","","","","","","","","","","      ",""})

PlsVldPerg( aRegs )

Return
