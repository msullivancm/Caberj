#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CABA013    ³ Autor ³ Luzio Tavares     ³ Data ³ 25.08.2009 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Bloqueia guias conforme parametro.                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA013()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL aSays     := {}
LOCAL aButtons  := {}
LOCAL cCadastro := "Processamento da Fase das PEGS"

Private cPerg     := "CABA13"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o sx1 sob demanda...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CRIASX1(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta texto para janela de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

AADD(aSays,"Processamento da Fase das PEGS")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta botoes para janela de processamento                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
AADD(aButtons, { 1,.T.,{|| MsAguarde({|| U_CABA013Blq(cPerg)}, "", "Processando...", .T.),FechaBatch() }} )
AADD(aButtons, { 2,.T.,{|| FechaBatch() }} )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe janela de processamento                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

FormBatch( cCadastro, aSays, aButtons,, 160 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA013BlqºAutor  ³Luzio Tavares       º Data ³  25/08/2009 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA013Blq(cPerg,lPerg,cCodOpe,cCodLDPDe,cCodLDPAte,cCodPEGDe,cCodPEGAte,cAnoDe,cMesDe,cAnoAte,cMesAte, lJob,;
cCodRDADe,cCodRDAAte, cCodEmpDe, cCodEmpAte, nTipAcao, cCodBlo, cEmpExc, cGrpPag, cTipPes, cRDAExc)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSQL
Local cMatrOrig  := ""
Local cAnoMesBDH := ""
Local lBloqueia  := .F.
Local lRetorna   := .F.
Local aRecNum   := {}
Local cRecNum   := ""
Local nVlrBlo := 0
Local aLog    := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definicao de variaveis utilizadas no relatorio de emissao do LOG³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   	:= "CABA013"			// Nome do Arquivo utilizado no Spool
Local Titulo 	:= "Relatorio de analise de bloqueio de Guias Medicas"
Local cDesc1 	:= "Este programa ira emitir uma relatorio das guias encontradas"
Local cDesc2 	:= "no arquivo que atendam as regras dos parametros informados e"
Local cDesc3 	:= "que serao posteriormente bloqueados."
Local nomeprog	:= "CABA013.PRW"		// nome do programa
Local cString 	:= ""					// Alias utilizado na Filtragem
Local lDic    	:= .F. 					// Habilita/Desabilita Dicionario
Local lComp   	:= .F. 					// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro 	:= .F. 					// Habilita/Desabilita o Filtro

Private Tamanho := "G"					// P/M/G
Private Limite  := 220					// 80/132/220
Private aReturn := { "Zebrado",;		//[1] Reservado para Formulario
					 1,;				//[2] Reservado para N§ de Vias
					 "Administração",;	//[3] Destinatario
					 1,;				//[4] Formato => 1-Comprimido 2-Normal	
					 1,;	    		//[5] Midia   => 1-Disco 2-Impressora
					 1,;				//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
					 "",;				//[7] Expressao do Filtro
					 1 } 				//[8] Ordem a ser selecionada
					 					//[9]..[10]..[n] Campos a Processar (se houver)

Private m_pag    := 1					// Contador de Paginas
Private nLastKey := 0					// Controla o cancelamento da SetPrint e SetDefault
//Private cPerg    := "CABA13"				// Pergunta do Relatorio
Private aOrdem   := {}					// Ordem do Relatorio

Default cPerg      := space(6)
Default lPerg      := .T.
Default cCodOpe    := space(4)
Default cCodLDPDe  := space(4)
Default cCodLDPAte := space(4)
Default cCodPEGDe  := space(8)
Default cCodPEGAte := space(8)
Default cAnoDe     := space(4)
Default cMesDe     := space(2)
Default cAnoAte    := space(4)
Default cMesAte    := space(2)
Default cCodRDADe  := space(6)
Default cCodRDAAte := space(6)
Default cCodEmpDe  := space(4)
Default cCodEmpAte := space(4)
Default nTipAcao   := 0
Default cCodBlo    := space(03)
Default cEmpExc    := space(0)
Default cGrpPag    := space(0)
Default cTipPes    := "A"
Default	cRDAExc    := space(0)
Default lJob       := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados dos parametros...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lPerg
	Pergunte(cPerg,.F.)
	
	/*
	aRecNum := U_SelEmp()
	For I := 1 To Len(aRecNum)
	cRecNum += AllTrim(Str(aRecNum[I][3])) + IIF(I<>Len(aRecNum),",","")
	Next
	*/
	
	cCodOpe    := mv_par01
	cCodLDPDe  := mv_par02
	cCodLDPAte := mv_par03
	cCodPEGDe  := mv_par04
	cCodPEGAte := mv_par05
	cAnoDe     := mv_par06
	cMesDe     := mv_par07
	cAnoAte    := mv_par08
	cMesAte    := mv_par09
	cCodRDADe  := mv_par10
	cCodRDAAte := mv_par11
	cCodEmpDe  := mv_par12
	cCodEmpAte := mv_par13
	nTipAcao   := mv_par14
	cCodBlo    := mv_par15
	cEmpExc    := AllTrim(mv_par16)
	cGrpPag    := AllTrim(mv_par17)
//	cTipPes    := mv_par18
	cRDAExc    := AllTrim(mv_par19)
	
	If mv_par18 == 1 // Pessoa Fisica
		cTipPes := "F"
	ElseIf mv_par18 == 2 // Pessoa Juridica
		cTipPes := "J"
	Else
		cTipPes := "A"
	EndIf
Endif

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona todos os grupos empresas parametrizados...                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT BCI.R_E_C_N_O_ AS REG "
cSQL += " FROM "+RetSQLName("BCI")+" BCI, "+RetSQLName("BAU ")+" BAU "
cSQL += " WHERE BCI_FILIAL = '"+xFilial("BCI")+"'  AND "
cSQL += " BAU_FILIAL = '"+xFilial("BAU")+"'  AND "
cSQL += " BCI_CODOPE = '"+cCodOpe+"'  AND "
cSQL += " BCI_CODLDP >= '"+cCodLDPDe+"' AND BCI_CODLDP <= '"+cCodLDPAte+"'  AND "
cSQL += " BCI_CODPEG >= '"+cCodPEGDe+"' AND BCI_CODPEG <= '"+cCodPEGAte+"'  AND "
//cSQL += " BCI_ANO||BCI_MES BETWEEN '"+cAnoDe+cMesDe+"' AND '"+cAnoAte+cMesAte+"'  AND "
cSQL += " (BCI_ANO < '"+cAnoDe+"' OR (BCI_ANO = '"+cAnoDe+"' AND BCI_MES <= '"+cMesDe+"')) AND "
cSQL += " BCI_CODRDA BETWEEN '"+cCodRDADe+"' AND '"+cCodRDAAte+"'  AND "
cSQL += " BCI_SITUAC = '1' AND "
cSQL += " BCI_FASE <> '4' AND "
If !Empty(cGrpPag)
cSQL += " BAU_GRPPAG BETWEEN '"+cGrpPag+"' AND "
EndIf
If cTipPes != "A"   //Ambas
cSQL += " BAU_TIPPE = '"+cTipPes+"' AND "
EndIf
cSQL += " BAU_CODIGO = BCI_CODRDA AND "
cSQL += " BCI.D_E_L_E_T_ <> '*' AND "
cSQL += " BAU.D_E_L_E_T_ <> '*' "
*/

cSQL := "SELECT BD5.R_E_C_N_O_ AS REG "
cSQL += " FROM "+RetSQLName("BD5")+" BD5, "+RetSQLName("BAU ")+" BAU "
cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"'  AND "
cSQL += " BAU_FILIAL = '"+xFilial("BAU")+"'  AND "
cSQL += " BD5_CODOPE = '"+cCodOpe+"'  AND "
cSQL += " BD5_CODLDP >= '"+cCodLDPDe+"' AND BD5_CODLDP <= '"+cCodLDPAte+"'  AND "
cSQL += " BD5_CODPEG >= '"+cCodPEGDe+"' AND BD5_CODPEG <= '"+cCodPEGAte+"'  AND "
//cSQL += " BCI_ANO||BCI_MES BETWEEN '"+cAnoDe+cMesDe+"' AND '"+cAnoAte+cMesAte+"'  AND "
//cSQL += " (BD5_ANOPAG < '"+cAnoDe+"' OR (BD5_ANOPAG = '"+cAnoDe+"' AND BD5_MESPAG <= '"+cMesDe+"')) AND "
cSQL += " BD5_ANOPAG||BD5_MESPAG = '"+cAnoDe+cMesDe+"' AND "
cSQL += " BD5_CODRDA BETWEEN '"+cCodRDADe+"' AND '"+cCodRDAAte+"'  AND "
cSQL += " BD5_CODEMP BETWEEN '"+cCodEmpDe+"' AND '"+cCodEmpAte+"'  AND "
If !Empty(AllTrim(cEmpExc))
	cSQL += " BD5_CODEMP NOT IN ('"+AllTrim(cEmpExc)+"') AND "
EndIf

If nTipAcao == 1 .or. nTipAcao == 3    //Bloqueio
	cSQL += " BD5_SITUAC = '1' AND "
	cSQL += " BD5_BLOPAG <> '1' AND "
	cSQL += " BD5_FASE   = '3' AND "
	cSQL += " BD5_NUMFAT = ' ' AND "
	cSQL += " BD5_NUMSE1 = ' ' AND "
	cSQL += " BD5_NUMLOT = ' ' AND "
	//	cSQL += " BD5_SEQPF = ' ' AND "
ElseIf nTipAcao == 2 .or. nTipAcao == 4    //Desbloqueio
	cSQL += " BD5_SITUAC = '3' AND "
	cSQL += " BD5_BLOPAG = '1' AND "
	cSQL += " BD5_FASE   = '3' AND "
	cSQL += " BD5_NUMFAT = ' ' AND "
	cSQL += " BD5_NUMSE1 = ' ' AND "
	cSQL += " BD5_NUMLOT = ' ' AND "
	cSQL += " BD5_MOTBLO = '"+cCodBlo+"' AND "
EndIf

If !Empty(cGrpPag)
	cSQL += " BAU_GRPPAG BETWEEN '"+cGrpPag+"' AND "
EndIf
If cTipPes != "A"   //Ambas
	cSQL += " BAU_TIPPE = '"+cTipPes+"' AND "
EndIf
cSQL += " BAU_CODIGO = BD5_CODRDA AND "
cSQL += " BD5.D_E_L_E_T_ <> '*' AND "
cSQL += " BAU.D_E_L_E_T_ <> '*' "

PLSQuery(cSQL,"Trb")
/*
While ! Trb->(Eof())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona na PEG...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbGoTo(Trb->REG))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com o tipo de guia posiciona no cabecalho da guia...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BD5->(DbSetOrder(1))
If BD5->(MsSeek(xFilial("BD5")+BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)))
While !BD5->(Eof()) .AND. BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG) == BCI->(BCI_FILIAL+BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
lRetorna := .F.

If !lJob
MsProcTXT("Processando Guia "+BD5->BD5_CODLDP+" - "+BD5->BD5_CODPEG+" - "+BD5->BD5_NUMERO+" ...")
Else
ConOut("Processando Guia "+BD5->BD5_CODLDP+" - "+BD5->BD5_CODPEG+" - "+BD5->BD5_NUMERO+" ...")
EndIf
If !Empty(cEmpExc) .AND. (BD5->BD5_CODEMP $ cEmpExc)
lRetorna := .T.
EndIf
If !Empty(cRDAExc) .AND. (BD5->BD5_CODRDA $ cRDAExc)
lRetorna := .T.
EndIf
If !Empty(cCodEmpAte) .AND. ((Upper(Substr(cCodEmpAte,1,1)) != "Z") .AND. (BD5->BD5_CODEMP > cCodEmpAte))
lRetorna := .T.
EndIf
If !Empty(cCodEmpDe) .AND. (Val(BD5->BD5_CODEMP) < Val(cCodEmpDe))
lRetorna := .T.
EndIf
If lRetorna
BD5->(DbSkip())
Loop
EndIf

lBloqueia := .F.

If nTipAcao == 1  //Bloqueio
If BD5->BD5_SITUAC == "1" .AND. BD5->BD5_BLOPAG != '1' .AND. BD5->BD5_FASE == "3" .AND.;
Empty(BD5->BD5_NUMFAT) .AND. Empty(BD5->BD5_NUMSE1) .AND. Empty(BD5->BD5_NUMLOT)   //.AND. Empty(BD5->BD5_SEQPF)

BD6->(DbSetOrder(1))
If BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))
While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)

If BD6->BD6_SITUAC == "1" .AND. BD6->BD6_BLOPAG != '1' .AND. BD6->BD6_FASE == "3" .AND.;
Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT)   //.AND. Empty(BD6->BD6_SEQPF)

cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)

BD7->(DbSetOrder(1))
If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
If BD7->BD7_SITUAC == "1" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)
BD7->(RecLock("BD7",.F.))
BD7->BD7_SITUAC := "3"      // Bloqueada
BD7->BD7_MOTBLO := cCodBlo
If BD7->BD7_BLOPAG != "1"
BD7->BD7_BLOPAG := "2"   //Bloqueia pagamento
EndIf
BD7->(MsUnLock())
lBloqueia := .T.
nVlrBlo += BD7->BD7_VLRPAG
EndIf
BD7->(DbSkip())
Enddo
Endif
If lBloqueia
BD6->(RecLock("BD6",.F.))
BD6->BD6_SITUAC := "3"      // Bloqueada
BD6->BD6_MOTBPG := cCodBlo
BD6->BD6_BLOPAG := "1"      // Bloqueia o pagamento
BD6->(MsUnLock())
EndIf
EndIf
BD6->(DbSkip())
Enddo

Endif
Endif
Else  //DesBloqueio
If BD5->BD5_SITUAC == "3" .AND. BD5->BD5_BLOPAG == '1' .AND. BD5->BD5_FASE == "3" .AND.;
Empty(BD5->BD5_NUMFAT) .AND. Empty(BD5->BD5_NUMSE1) .AND. Empty(BD5->BD5_NUMLOT) .AND.;
BD5->BD5_MOTBLO == cCodBlo

BD6->(DbSetOrder(1))
If BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))
While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)

If BD6->BD6_SITUAC == "3" .AND. BD6->BD6_BLOPAG == '1' .AND. BD6->BD6_FASE == "3" .AND.;
Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT) .AND.;   //.AND. Empty(BD6->BD6_SEQPF)
BD6->BD6_MOTBPG == cCodBlo

cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)

BD7->(DbSetOrder(1))
If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

If BD7->BD7_SITUAC == "3" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)  //.AND. BD7->BD7_MOTBPG == cCodBlo
//										If BD7->BD7_SITUAC == "3" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)  // .AND. BD7->BD7_MOTBPG == cCodBlo

BD7->(RecLock("BD7",.F.))
BD7->BD7_SITUAC := "1"      // DesBloqueada
BD7->BD7_MOTBLO := "  "
If BD7->BD7_BLOPAG != "1"
BD7->BD7_BLOPAG := "0"
EndIf
BD7->(MsUnLock())
lBloqueia := .T.
nVlrBlo += BD7->BD7_VLRPAG
EndIf
BD7->(DbSkip())
Enddo
Endif
If lBloqueia
BD6->(RecLock("BD6",.F.))
BD6->BD6_SITUAC := "1"      // DesBloqueada
BD6->BD6_MOTBPG := "  "
BD6->BD6_BLOPAG := "0"      // DesBloqueia o pagamento
BD6->(MsUnLock())
EndIf
EndIf
BD6->(DbSkip())
Enddo

Endif
Endif
EndIf
If lBloqueia
BD5->(RecLock("BD5",.F.))
If nTipAcao == 1  //Bloqueio
BD5->BD5_SITUAC := "3"      // Bloqueada
BD5->BD5_MOTBLO := cCodBlo
BD5->BD5_BLOPAG := "1"
Else
BD5->BD5_SITUAC := "1"      // DesBloqueada
BD5->BD5_MOTBLO := "  "
BD5->BD5_BLOPAG := "0"
EndIf
BD5->(MsUnLock())
aadd(aLog,{BD5->BD5_CODRDA,BD5->BD5_NOMRDA,nVlrBlo})
nVlrBlo := 0
EndIf
BD5->(DbSkip())
Enddo

Else
BE4->(DbSetOrder(1))  //BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE
If BE4->(MsSeek(xFilial("BE4")+BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)))
While ! BE4->(Eof()) .And. BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG) == BCI->(BCI_FILIAL+BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
lRetorna := .F.

If !lJob
MsProcTXT("Processando Guia "+BE4->BE4_CODLDP+" - "+BE4->BE4_CODPEG+" - "+BE4->BE4_NUMERO+" ...")
Else
ConOut("Processando Guia "+BE4->BE4_CODLDP+" - "+BE4->BE4_CODPEG+" - "+BE4->BE4_NUMERO+" ...")
EndIf

If !Empty(cEmpExc) .AND. (BE4->BE4_CODEMP $ cEmpExc)
lRetorna := .T.
EndIf
If !Empty(cRDAExc) .AND. (BE4->BE4_CODRDA $ cRDAExc)
lRetorna := .T.
EndIf
If !Empty(cCodEmpAte) .AND. ((Upper(Substr(cCodEmpAte,1,1)) != "Z") .AND. (BD5->BD5_CODEMP > cCodEmpAte))
lRetorna := .T.
EndIf
If !Empty(cCodEmpDe) .AND. (Val(BE4->BE4_CODEMP) < Val(cCodEmpDe))
lRetorna := .T.
EndIf
If lRetorna
BE4->(DbSkip())
Loop
EndIf

lBloqueia := .F.

If nTipAcao == 1  //Bloqueio
If BE4->BE4_SITUAC == "1" .AND. BE4->BE4_BLOPAG != "1" .AND. BE4->BE4_FASE == "3" .AND.;
Empty(BE4->BE4_NUMSE1) .AND. Empty(BE4->BE4_NUMLOT)

BD6->(DbSetOrder(1))
If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)))
While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == ;
BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)

If BD6->BD6_SITUAC == "1" .AND. BD6->BD6_BLOPAG != '1' .AND. BD6->BD6_FASE == "3" .AND.;
Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT)   //.AND. Empty(BD6->BD6_SEQPF)

cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)

BD7->(DbSetOrder(1))
If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

If BD7->BD7_SITUAC == "1" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)
BD7->(RecLock("BD7",.F.))
BD7->BD7_SITUAC := "3"      // Bloqueada
BD7->BD7_MOTBLO := cCodBlo
If BD7->BD7_BLOPAG != "1"
BD7->BD7_BLOPAG := "2"   //Bloqueia pagamento
EndIf
BD7->(MsUnLock())
lBloqueia := .T.
nVlrBlo += BD7->BD7_VLRPAG
EndIf
BD7->(DbSkip())
Enddo
Endif
If lBloqueia
BD6->(RecLock("BD6",.F.))
BD6->BD6_SITUAC := "3"      // Bloqueada
BD6->BD6_MOTBPG := cCodBlo
BD6->BD6_BLOPAG := "1"      // Bloqueia o pagamento
BD6->(MsUnLock())
EndIf
EndIf
BD6->(DbSkip())
Enddo
Endif
Endif
Else  //DesBloqueio
If BE4->BE4_SITUAC == "1" .AND. BE4->BE4_BLOPAG != "1" .AND. BE4->BE4_FASE == "3" .AND.;
Empty(BE4->BE4_NUMSE1) .AND. Empty(BE4->BE4_NUMLOT) .AND. BE4->BE4_MOTBLO == cCodBlo

BD6->(DbSetOrder(1))
If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)))
While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == ;
BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)

If BD6->BD6_SITUAC == "3" .AND. BD6->BD6_BLOPAG == '1' .AND. BD6->BD6_FASE == "3" .AND.;
Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT) .AND.;   //.AND. Empty(BD6->BD6_SEQPF)
BD6->BD6_MOTBPG == cCodBlo

cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)

BD7->(DbSetOrder(1))
If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

If BD7->BD7_SITUAC == "3" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)  //.AND. BD7->BD7_MOTBPG == cCodBlo

BD7->(RecLock("BD7",.F.))
BD7->BD7_SITUAC := "1"      // DesBloqueada
BD7->BD7_MOTBLO := "  "
If BD7->BD7_BLOPAG != "1"
BD7->BD7_BLOPAG := "0"
EndIf
BD7->(MsUnLock())
lBloqueia := .T.
nVlrBlo += BD7->BD7_VLRPAG
EndIf
BD7->(DbSkip())
Enddo
Endif
If lBloqueia
BD6->(RecLock("BD6",.F.))
BD6->BD6_SITUAC := "1"      // DesBloqueada
BD6->BD6_MOTBPG := "  "
BD6->BD6_BLOPAG := "0"      // Bloqueia o pagamento
BD6->(MsUnLock())
EndIf
EndIf
BD6->(DbSkip())
Enddo

Endif
Endif
EndIf
If lBloqueia
BE4->(RecLock("BE4",.F.))
If nTipAcao == 1  //Bloqueio
BE4->BE4_SITUAC := "3"      // Bloqueada
BE4->BE4_MOTBLO := cCodBlo
BE4->BE4_BLOPAG = "1"
Else
BE4->BE4_SITUAC := "1"      // DesBloqueada
BE4->BE4_MOTBLO := "  "
BE4->BE4_BLOPAG = "0"
EndIf
BE4->(MsUnLock())
aadd(aLog,{BD5->BD5_CODRDA,BD5->BD5_NOMRDA,BD5->CODLDP,BD5->CODPEG,BD5->NUMERO,nVlrBlo})
nVlrBlo := 0
EndIf
BE4->(DbSkip())
Enddo
EndIf
Endif
//	Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza peg...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	BCI->(RecLock("BCI",.F.))
//	BCI->BCI_SITUAC := "3"
//	BCI->(MsUnLock())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa proxima peg a ser analisada...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Trb->(DbSkip())
Enddo
*/

While ! Trb->(Eof())
	BD5->(DbGoTo(Trb->REG))
	If !lJob
		MsProcTXT("Processando Guia "+BD5->BD5_CODLDP+" - "+BD5->BD5_CODPEG+" - "+BD5->BD5_NUMERO+" ...")
	Else
		ConOut("Processando Guia "+BD5->BD5_CODLDP+" - "+BD5->BD5_CODPEG+" - "+BD5->BD5_NUMERO+" ...")
	EndIf
	
	lBloqueia := .F.
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))
		While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
			BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)
			
			cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
			cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)
			
			If nTipAcao == 1 .or. nTipAcao == 3
				If BD6->BD6_SITUAC == "1" .AND. BD6->BD6_BLOPAG != '1' .AND. BD6->BD6_FASE == "3" .AND.;
					Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT)   //.AND. Empty(BD6->BD6_SEQPF)
					
					BD7->(DbSetOrder(1))
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
							BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
							If BD7->BD7_SITUAC == "1" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)
  							    If nTipAcao == 1   //Bloquear
									BD7->(RecLock("BD7",.F.))
									BD7->BD7_SITUAC := "3"      // Bloqueada
									BD7->BD7_MOTBLO := cCodBlo
									If BD7->BD7_BLOPAG != "1"
										BD7->BD7_BLOPAG := "2"   //Bloqueia pagamento
									EndIf
									BD7->(MsUnLock())
									
									//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
									u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)
								EndIf
								lBloqueia := .T.
								nVlrBlo += BD7->BD7_VLRPAG
							EndIf
							BD7->(DbSkip())
						Enddo
					Endif
				EndIf
			ElseIf nTipAcao == 2 .or. nTipAcao == 4  //Desbloquear ou analisar Desbloqueio
				If BD6->BD6_SITUAC == "3" .AND. BD6->BD6_BLOPAG == '1' .AND. BD6->BD6_FASE == "3" .AND.;
					Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT) .AND.;   //.AND. Empty(BD6->BD6_SEQPF)
					BD6->BD6_MOTBPG == cCodBlo
					
					BD7->(DbSetOrder(1))
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
							BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
							If BD7->BD7_SITUAC == "3" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)
  							    If nTipAcao == 2
									BD7->(RecLock("BD7",.F.))
									BD7->BD7_SITUAC := "1"      // DesBloqueada
									BD7->BD7_MOTBLO := "  "
									If BD7->BD7_BLOPAG != "1"
										BD7->BD7_BLOPAG := "0"
									EndIf
									BD7->(MsUnLock())
									
									//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
									u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
								EndIf	
								lBloqueia := .T.
								nVlrBlo += BD7->BD7_VLRPAG
							EndIf
							BD7->(DbSkip())
						Enddo
					Endif
				EndIf
			EndIf
			If lBloqueia .and. (nTipAcao != 3 .and. nTipAcao != 4)
				BD6->(RecLock("BD6",.F.))
				If nTipAcao == 1  //Bloqueio
					BD6->BD6_SITUAC := "3"      // Bloqueada
					BD6->BD6_MOTBPG := cCodBlo
					BD6->BD6_BLOPAG := "1"      // Bloqueia o pagamento
				ElseIf nTipAcao == 2  //DesBloqueio
					BD6->BD6_SITUAC := "1"      // DesBloqueada
					BD6->BD6_MOTBPG := "  "
					BD6->BD6_BLOPAG := "0"      // Bloqueia o pagamento
				EndIf
				BD6->(MsUnLock())
			EndIf
			BD6->(DbSkip())
		Enddo
		
		If lBloqueia
			If (nTipAcao != 3 .and. nTipAcao != 4) //Analise
				BD5->(RecLock("BD5",.F.))
				If nTipAcao == 1  //Bloqueio
					BD5->BD5_SITUAC := "3"      // Bloqueada
					BD5->BD5_MOTBLO := cCodBlo
					BD5->BD5_BLOPAG := "1"
				Else
					BD5->BD5_SITUAC := "1"      // DesBloqueada
					BD5->BD5_MOTBLO := "  "
					BD5->BD5_BLOPAG := "0"
				EndIf
				BD5->(MsUnLock())
			EndIf	
			//		aadd(aLog,{BD5->BD5_CODRDA,BD5->BD5_NOMRDA,nVlrBlo})
			aadd(aLog,{BD5->BD5_CODRDA,BD5->BD5_NOMRDA,BD5->BD5_CODLDP,BD5->BD5_CODPEG,BD5->BD5_NUMERO,BD5->BD5_OPEUSR,BD5->BD5_CODEMP,BD5->BD5_MATRIC,BD5->BD5_TIPREG,BD5->BD5_DIGITO,BD5->BD5_NOMUSR,BD5->BD5_REGATE,nVlrBlo})
			nVlrBlo := 0
		EndIf
	Endif
	Trb->(DbSkip())
Enddo

Trb->(DbCloseArea())

cSQL := "SELECT BE4.R_E_C_N_O_ AS REG "
cSQL += " FROM "+RetSQLName("BE4")+" BE4, "+RetSQLName("BAU ")+" BAU "
cSQL += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' AND "
cSQL += " BAU_FILIAL = '"+xFilial("BAU")+"' AND "
cSQL += " BE4_CODOPE = '"+cCodOpe+"' AND "
cSQL += " BE4_CODLDP >= '"+cCodLDPDe+"' AND BE4_CODLDP <= '"+cCodLDPAte+"' AND "
cSQL += " BE4_CODPEG >= '"+cCodPEGDe+"' AND BE4_CODPEG <= '"+cCodPEGAte+"' AND "
//cSQL += " (BE4_ANOPAG < '"+cAnoDe+"' OR (BE4_ANOPAG = '"+cAnoDe+"' AND BE4_MESPAG <= '"+cMesDe+"')) AND "
cSQL += " BE4_ANOPAG||BE4_MESPAG = '"+cAnoDe+cMesDe+"' AND "
cSQL += " BE4_CODRDA BETWEEN '"+cCodRDADe+"' AND '"+cCodRDAAte+"' AND "
cSQL += " BE4_CODEMP BETWEEN '"+cCodEmpDe+"' AND '"+cCodEmpAte+"' AND "
If !Empty(AllTrim(cEmpExc))
	cSQL += " BE4_CODEMP NOT IN ('"+AllTrim(cEmpExc)+"') AND "
EndIf

If nTipAcao == 1 .or. nTipAcao == 3    //Bloqueio
	cSQL += " BE4_SITUAC = '1' AND "
	cSQL += " BE4_BLOPAG <> '1' AND "
	cSQL += " BE4_FASE   = '3' AND "
	cSQL += " BE4_NUMFAT = ' ' AND "
	cSQL += " BE4_NUMSE1 = ' ' AND "
	cSQL += " BE4_NUMLOT = ' ' AND "
ElseIf nTipAcao == 2 .or. nTipAcao == 4    //Desbloqueio
	cSQL += " BE4_SITUAC = '3' AND "
	cSQL += " BE4_BLOPAG = '1' AND "
	cSQL += " BE4_FASE   = '3' AND "
	cSQL += " BE4_NUMFAT = ' ' AND "
	cSQL += " BE4_NUMSE1 = ' ' AND "
	cSQL += " BE4_NUMLOT = ' ' AND "
	cSQL += " BE4_MOTBLO = '"+cCodBlo+"' AND "
EndIf

If !Empty(cGrpPag)
	cSQL += " BAU_GRPPAG BETWEEN '"+cGrpPag+"' AND "
EndIf
If cTipPes != "A"   //Ambas
	cSQL += " BAU_TIPPE = '"+cTipPes+"' AND "
EndIf
cSQL += " BAU_CODIGO = BE4_CODRDA AND "
cSQL += " BE4.D_E_L_E_T_ <> '*' AND "
cSQL += " BAU.D_E_L_E_T_ <> '*' "

PLSQuery(cSQL,"Trb")

While ! Trb->(Eof())
	BE4->(DbGoTo(Trb->REG))            
	If !lJob
		MsProcTXT("Processando Guia "+BE4->BE4_CODLDP+" - "+BE4->BE4_CODPEG+" - "+BE4->BE4_NUMERO+" ...")
	Else
		ConOut("Processando Guia "+BE4->BE4_CODLDP+" - "+BE4->BE4_CODPEG+" - "+BE4->BE4_NUMERO+" ...")
	EndIf
	
	lBloqueia := .F.
	
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)))
		While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == ;
			BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
			
			cMatrOrig  := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
			cAnoMesBDH := BD6->(BD6_ANOPAG+BD6_MESPAG)
			
			If nTipAcao == 1 .or. nTipAcao == 3  //Bloqueio ou Analisar Bloqueio
				If BD6->BD6_SITUAC == "1" .AND. BD6->BD6_BLOPAG != '1' .AND. BD6->BD6_FASE == "3" .AND.;
					Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT)   //.AND. Empty(BD6->BD6_SEQPF)
					
					BD7->(DbSetOrder(1))
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
							BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

							If BD7->BD7_SITUAC == "1" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)
  							    If nTipAcao == 1
									BD7->(RecLock("BD7",.F.))
									BD7->BD7_SITUAC     := "3"      // Bloqueada
									BD7->BD7_MOTBLO     := cCodBlo
									If BD7->BD7_BLOPAG  != "1"
										BD7->BD7_BLOPAG := "2"   //Bloqueia pagamento
									EndIf
									BD7->(MsUnLock())
									
									//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
									u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)
								EndIf	
								lBloqueia := .T.
								nVlrBlo += BD7->BD7_VLRPAG
							EndIf
							BD7->(DbSkip())
						Enddo
					Endif
				EndIf
			ElseIf nTipAcao == 2 .or. nTipAcao == 4      //Desbloqueio ou Analisar Desbloqueio
				If BD6->BD6_SITUAC == "3" .AND. BD6->BD6_BLOPAG == '1' .AND. BD6->BD6_FASE == "3" .AND.;
					Empty(BD6->BD6_NUMFAT) .AND. Empty(BD6->BD6_NUMSE1) .AND. Empty(BD6->BD6_NUMLOT) .AND.;   //.AND. Empty(BD6->BD6_SEQPF)
					BD6->BD6_MOTBPG == cCodBlo

					BD7->(DbSetOrder(1))
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
							BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

							If BD7->BD7_SITUAC == "3" .AND. BD7->BD7_FASE == "3" .AND. Empty(BD7->BD7_NUMLOT)  //.AND. BD7->BD7_MOTBPG == cCodBlo
  							    If nTipAcao == 2
									BD7->(RecLock("BD7",.F.))
									BD7->BD7_SITUAC := "1"      // DesBloqueada
									BD7->BD7_MOTBLO := "  "
									If BD7->BD7_BLOPAG != "1"
										BD7->BD7_BLOPAG := "0"
									EndIf

									BD7->(MsUnLock())
									
									//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
									u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
								EndIf	
								lBloqueia := .T.
								nVlrBlo += BD7->BD7_VLRPAG
							EndIf
							BD7->(DbSkip())
						Enddo
					Endif
				EndIf
			EndIf
			If lBloqueia .and. (nTipAcao != 3 .and. nTipAcao != 4)
				BD6->(RecLock("BD6",.F.))
				If nTipAcao == 1  //Bloqueio
					BD6->BD6_SITUAC := "3"      // Bloqueada
					BD6->BD6_MOTBPG := cCodBlo
					BD6->BD6_BLOPAG := "1"      // Bloqueia o pagamento
				Else
					BD6->BD6_SITUAC := "1"      // DesBloqueada
					BD6->BD6_MOTBPG := "  "
					BD6->BD6_BLOPAG := "0"      // Bloqueia o pagamento
				EndIf
				BD6->(MsUnLock())
			EndIf
			BD6->(DbSkip())
		Enddo
	Endif
	
	If lBloqueia
		If (nTipAcao != 3 .and. nTipAcao != 4) //Analise
			BE4->(RecLock("BE4",.F.))
			If nTipAcao == 1  //Bloqueio
				BE4->BE4_SITUAC := "3"      // Bloqueada
				BE4->BE4_MOTBLO := cCodBlo
				BE4->BE4_BLOPAG = "1"
			ElseIf nTipAcao == 2  //desbloqueio
				BE4->BE4_SITUAC := "1"      // DesBloqueada
				BE4->BE4_MOTBLO := "  "
				BE4->BE4_BLOPAG = "0"
			EndIf
			BE4->(MsUnLock())
		EndIf	
		aadd(aLog,{BE4->BE4_CODRDA,BE4->BE4_NOMRDA,BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,BE4->BE4_OPEUSR,BE4->BE4_CODEMP,BE4->BE4_MATRIC,BE4->BE4_TIPREG,BE4->BE4_DIGITO,BE4->BE4_NOMUSR,"1",nVlrBlo})
		nVlrBlo := 0
	EndIf
	Trb->(DbSkip())
Enddo

Trb->(DbCloseArea())

If lPerg
	If !lJob
		MsgInfo("Processamento concluido com sucesso.")
	EndIf
Endif

////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
////³ Atualiza dados em disco...                                          ³
////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If Len(aLog) > 0
//	PLSCRIGEN(aLog,{ {"Codigo","@C",30},{"Nome do RDA","@C",60},{"Local","@C",30},{"PEG","@C",30},{"Numero","@C",30},{"Vlr. Bloqueado","@E 999999999.99",30} },"Guias Bloqueadas",.T.)
//Endif

//Pergunte(cPerg, .F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)

If (nLastKey <> 27)
	SetDefault(aReturn,cString)
Endif
RptStatus( {|lEnd| ImpLog(@lEnd,wnRel,cString,nomeprog,Titulo,aLog,nTipAcao) }, Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina principal...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIASX1   ºAutor  ³Microsiga           º Data ³  08/06/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CRIASX1(cPerg)
                                                                                                                                                                                                        
PutSx1(cPerg,"01","Operadora                 ","","","mv_ch1","C",04,0,0,"G","NaoVazio()                           ","B89PLS","S","","mv_par01","        ","","","0001","           ","","","        ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"02","Local Dig. De             ","","","mv_ch2","C",04,0,0,"G","                                     ","      ","S","","mv_par02","        ","","","    ","           ","","","        ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"03","Local Dig. Ate            ","","","mv_ch3","C",04,0,0,"G","NaoVazio()                           ","      ","S","","mv_par03","        ","","","    ","           ","","","        ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"04","PEG De                    ","","","mv_ch4","C",08,0,0,"G","                                     ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"05","PEG Ate                   ","","","mv_ch5","C",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par05","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"06","Ano De                    ","","","mv_ch6","C",04,0,0,"G","NaoVazio()                           ","      ","S","","mv_par06","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"07","Mes De                    ","","","mv_ch7","C",02,0,0,"G","NaoVazio()                           ","      ","S","","mv_par07","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"08","Ano Ate                   ","","","mv_ch8","C",04,0,0,"G","NaoVazio()                           ","      ","S","","mv_par08","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"09","Mes Ate                   ","","","mv_ch9","C",02,0,0,"G","NaoVazio()                           ","      ","S","","mv_par09","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"10","RDA De                    ","","","mv_cha","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par10","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"11","RDA Ate                   ","","","mv_chb","C",06,0,0,"G","NaoVazio()                           ","BAUPLS","S","","mv_par11","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
//PutSx1(cPerg,"12","Empresa De          ","","","mv_chc","C",04,0,0,"G","                                           ","BJLPLS","S","","mv_par12","        ","","","    ","           ","","","          ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"12","Grupo Empresa De          ","","","mv_chc","C",04,0,0,"G","                                     ","BYIPLS","S","","mv_par12","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"13","Grupo Empresa Ate         ","","","mv_chd","C",04,0,0,"G","NaoVazio()                           ","BYIPLS","S","","mv_par13","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"14","Acao do Programa          ","","","mv_che","N",01,0,0,"C","NaoVazio()                           ","      ","S","","mv_par14","Bloqueia","","","    ","Desbloqueia","","","Analisar Bloqueio","","","Analisar Desbloqueio","","","","","",{},{},{},"")
PutSx1(cPerg,"15","Motivo (Des)Bloqueio      ","","","mv_chf","C",03,0,0,"G","NaoVazio() .and. U_ValTabBW(mv_par15)","BW    ","S","","mv_par15","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"16","Grupos Empresas Excessoes ","","","mv_chg","C",99,0,0,"G","                                     ","      ","S","","mv_par16","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"17","Grupo de Pagamento RDA    ","","","mv_chh","C",50,0,0,"G","Vazio() .Or. U_CABRVGRP(mv_par17)    ","B1UCAB","S","","mv_par17","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"18","Tipo de Pessoa RDA        ","","","mv_chi","N",01,0,0,"C","                                     ","      ","S","","mv_par18","Fisica  ","","","    ","Juridica   ","","","Ambas    ","","","","","","","","",{},{},{},"")
//PutSx1(cPerg,"18","Tipo de Prestador   ","","","mv_chi","C",10,0,0,"G","fTpPrest()                                 ","      ","S","","mv_par18","        ","","","    ","           ","","","          ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"19","RDAs Excessoes            ","","","mv_chj","C",99,0,0,"G","                                     ","      ","S","","mv_par19","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
//PutSx1(cPerg,"20","Acao do Programa          ","","","mv_chk","N",01,0,0,"C","                                     ","      ","S","","mv_par20","Analisa ","","","    ","Bloqueia   ","","","Relatorio","","","","","","","","",{},{},{},"")
//PutSx1(cPerg,"19","Tipo de Atendimento ","","","mv_chi","C",10,0,0,"G","fTpPrest()                                 ","      ","S","","mv_par18","        ","","","    ","           ","","","       ","","","","","","","","",{},{},{},"")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValTabBW       ³ Autor ³ Luzio Tavares ³ Data ³ 03.09.2009 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ 									                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ValTabBW(cMotBlo)
LOCAL lRet := .F.

SX5->(DbSetOrder(1))
lRet := SX5->(DbSeek(xFilial("SX5")+"BW"+cMotBlo))

If lRet
	cDesBlo := X5Descri()
Else
	Help("",1,"RECNO")
Endif

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SelEmp    ºAutor  ³ Luzio Tavares      º Data ³  03/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Informa as matriculas manualmente para impressao de etiquetaº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function SelEmp()

Local aSaveArea := GetArea()
Local oDlg
Local oLbx
Local aNumRec := {}
Local oMatric
Local cMatric := CriaVar("BAU_CODIGO")   //BA1_CODINT"+"BA1_CODEMP"+"BA1_MATRIC"+"BA1_TIPREG"+"BA1_DIGITO", .F.)
Alert(cMatric)
//Local oCodInt
//Local cCodInt	:= PLSIntPad()
//Local oCodEmp
//Local cCodEmp	:= CriaVar("BA1_CODEMP", .F.)
//Local oMatric
//Local cMatric	:= CriaVar("BA1_MATRIC", .F.)
//Local oTipReg
//Local cTipReg	:= CriaVar("BA1_TIPREG", .F.)
//Local oDigito
//Local cDigito	:= CriaVar("BA1_DIGITO", .F.)

Aadd( aNumRec, {"", "", 0} )

DEFINE MSDIALOG oDlg TITLE "Rede de Atencimento para Selecao." FROM 0,0 TO 320,620 PIXEL

EnchoiceBar(oDlg, {|| oDlg:End() }, {|| (aNumRec:={},oDlg:End()) } )

@ 018,005 SAY "Matricula" OF oDlg PIXEL
@ 018,030 MSGET oMatric VAR cMatric OF oDlg SIZE 100,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oMatric, cMatric) F3 "B92PLS"
//	@ 018,030 GET oCodInt VAR cCodInt OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,060 GET oCodEmp VAR cCodEmp OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,090 GET oMatric VAR cMatric OF oDlg SIZE 40,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,135 GET oTipReg VAR cTipReg OF oDlg SIZE 15,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,155 GET oDigito VAR cDigito OF oDlg SIZE 10,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)

@ 035,005 LISTBOX oLbx FIELDS HEADER "Codigo", "Nome do Usuário", "Record" SIZE 300, 120 NOSCROLL OF oDlg PIXEL
oLbx:SetArray(aNumRec)
oLbx:bLine:={||{ aNumRec[oLbx:nAt,01], aNumRec[oLbx:nAt,02], aNumRec[oLbx:nAt,03] }}
oLbx:nAt := 1
oLbx:aColSizes := {70, 170, 30}
oLbx:BLDBLCLICK := { || CABR004Excl(oLbx) }

ACTIVATE MSDIALOG oDlg CENTERED

Return(aNumRec)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRRVALMAT ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se a matricula existe e adiciona na lista.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//Static Function VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)
Static Function CRRVALMAT(oLbx, oMatric, cMatric)

BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
//If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
	BA1->( DbSetOrder(5) )		// BA1_FILIAL + BA1_MATANT + BA1_TIPANT
	//	If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
	If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
		MsgStop("Matricula informada não cadastrada...")
		//		oCodInt:SetFocus()
		oMatric:SetFocus()
	Endif
Endif

If BA1->( Found() )
	If !Empty( oLbx:AARRAY[1][1] )
		Aadd( oLbx:AARRAY, {"", "", 0} )
	Endif
	
	oLbx:AARRAY[Len(oLbx:AARRAY)][1] :=	BA1->BA1_CODINT + "." +;
	BA1->BA1_CODEMP + "." +;
	BA1->BA1_MATRIC + "." +;
	BA1->BA1_TIPREG + "-" +;
	BA1->BA1_DIGITO
	oLbx:AARRAY[Len(oLbx:AARRAY)][2] :=	BA1->BA1_NOMUSR
	oLbx:AARRAY[Len(oLbx:AARRAY)][3] :=	BA1->( RecNo() )
	
	oLbx:nAt := 1
	oLbx:Refresh()
	//	oCodInt:SetFocus()
	oMatric:SetFocus()
Endif

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR013ExcºAutor  ³Luzio Tavares       º Data ³  09/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exclui a linha selecionada na lista de matriculas digitadas º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR013Exc(oLbx)

Local aArray := Aclone( oLbx:AARRAY )

If MsgYesNo("Deseja excluir este usuário ?")
	If Len(aArray) > 0
		Adel(aArray, oLbx:nAt) // deleta o item
		Asize(aArray, Len(aArray) - 1) //redimensiona o array
	Endif
Endif

If Len(aArray) == 0
	Aadd( aArray, {"", "", 0} )
Endif

oLbx:AARRAY := Aclone( aArray )
oLbx:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpLog    ºAutor  ³Luzio Tavares       º Data ³  09/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que ira imprimir o arquivo de LOG.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpLog(lEnd,wnrel,cString,nomeprog,Titulo,aLog,nTitCompl)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local Titulo 	:= "Analise de "+Iif(nTitCompl == 1 .or. nTitCompl == 3,"Bloqueio","Desbloqueio")+" das Guias Medicas"
Local nLi		:= 0			// Linha a ser impressa
Local nMax		:= 58			// Maximo de linhas suportada pelo relatorio
Local cbCont	:= 0			// Numero de Registros Processados
Local cbText	:= SPACE(10)	// Mensagem do Rodape
Local cCabec1	:= "Codigo   Nome                                      Local.PEG.Numero        Matricula Beneficiario  Nome                                                        Valor"
//Relatorio de analise do bloqueio administrativo de Guias" 			// Label dos itens
Local cCabec2	:= "" 			// Label dos itens
Local nVlrTot   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nI		:= 0			// Controle de laco

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena vetor aReg para gerar uma PEG para cada tipo de guia         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//aSort(aLog,,, { |x,y| x[1]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]+x[9] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]+y[8]+y[9]})
aSort(aLog,,, { |x,y| x[1]+x[3]+x[4]+x[5] < y[1]+y[3]+y[4]+y[5]})

/*
BE4->BE4_CODRDA,  1
BE4->BE4_NOMRDA,  2
BE4->BE4_CODLDP,  3
BE4->BE4_CODPEG,  4
BE4->BE4_NUMERO,  5
BE4->BE4_OPEUSR,  6
BE4->BE4_CODEMP,  7
BE4->BE4_MATRIC,  8
BE4->BE4_TIPREG,  9
BE4->BE4_DIGITO,  10
BE4->BE4_NOMUSR,  11
nVlrBlo           12 
*/

SetRegua( Len(aLog) )

For nI := 1 To Len(aLog)
	
	IncRegua()
	
	If lEnd
		@Prow()+1,000 PSay "CANCELADO PELO OPERADOR..."
		Exit
	Endif
//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0	
//Codigo   Nome                                      Local.PEG.Numero        Matricula Beneficiario  Nome                                                        Valor 
//075205 - HOSP DE CLINS DE NITEROI                  0001.00028646.00000072  0001.0005.007629.00-7 - LEONARDO RODRIGUES CRUZ                            999.999.999,99

	IncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000 PSay aLog[nI,1]+" - "+aLog[nI,2]+"  "+aLog[nI,3]+"."+aLog[nI,4]+"."+aLog[nI,5]+"  "+aLog[nI,6]+"."+aLog[nI,7]+"."+aLog[nI,8]+"."+aLog[nI,9]+"-"+aLog[nI,10]+" - "+aLog[nI,11]+"  "+Transform(aLog[nI,13],"@E 999,999,999.99")
	nVlrTot += aLog[nI,13]
Next nI

If nLi != 0
	nLi++
	nLi++
	@ nLi,000 PSay "Total "+Iif(nTitCompl == 1,"bloqueado",Iif(nTitCompl == 3,"a ser bloqueado",Iif(nTitCompl == 2,"desbloqueado","a ser desbloqueado")))
	@ nLi,150 PSay Transform(nVlrTot,"@E 999,999,999.99")
Else
	IncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi+1,000 PSay "Nao ha informacoes para imprimir este relatorio"
Endif

Roda(cbCont,cbText,Tamanho)

Set Device To Screen
If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IncLine   ºAutor  ³Luzio Tavares       º Data ³  09/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Incrementa o contador de linhas para impressão nos relato   º±±
±±º          ³rios e verifica se uma nova pagina sera iniciada.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ nLi      - Numero da linha em que sera impresso            º±±
±±º          ³ nInc     - Quantidade de linhas a serem incrementadas      º±±
±±º          ³ nMax     - Numero maximo de linhas por pagina              º±±
±±º          ³ Titulo   - Titulo do cabecalho do relatorio                º±±
±±º          ³ cCabec1  - Primeira linha do lalbel do relatorio           º±±
±±º          ³ cCabec2  - Segunda linha do label do relatorio             º±±
±±º          ³ NomeProg - Nome do programa que sera impresso no cabecalho º±±
±±º          ³ Tamanho  - Tamanho de colunas do relatorio                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncLine(nLi,nInc,nMax,Titulo,cCabec1,cCabec2,NomeProg,Tamanho)

Local nChrComp	:= IIF(aReturn[4]==1,15,18)		// Define se o caracter sera comprimido ou normal

nLi+=nInc
If nLi > nMax .or. nLi < 5
	nLi := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,nChrComp)
	nLi++
Endif

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ RetFai    ³ Autor ³ Luzio Tavares        ³ Data ³ 28.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Retorna a faixa etaria do usuario                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RetFai(nIdade)

BL9->(DbGoTop())
While ! BL9->(Eof())
   If nIdade <= BL9->BL9_IDADEF
     nFaixa := Val(BL9->BL9_SEQUEN)
     Exit
   Endif
   BL9->(DbSkip())
Enddo

Return(nFaixa)
          
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ fPegaVal  ³ Autor ³ Luzio Tavares        ³ Data ³ 29.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Retorna valor de cada faixa                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function fPegaVal(aSubTot,cTipUsu,cSexo,nFaixa)

Local nScan
nScan := aScan(aSubTot,{|x|x[1]==Alltrim(cTipUsu) .AND. x[2]==Alltrim(cSexo) .And. x[3]==nFaixa})
If nScan == 0
   Return(Transform(0,pQuant))
Else
   Return(Transform(aSubTot[nScan,4],pQuant))   
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ProcSubTot³ Autor ³ Luzio Tavares         ³ Data ³26.02.2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa Sub-Total                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function ProcSubTot()       

LOCAL aL :=	LayOutSubT()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	If nAnaSin = 1
		@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
	EndIf	
	++nLi
Endif

FmtLin({},aL[01],,,@nLi)
FmtLin({cOperad,cGrupEmp,cDescGru},aL[02],,,@nLi)
FmtLin({},aL[03],,,@nLi)
FmtLin({},aL[04],,,@nLi)
FmtLin({},aL[05],,,@nLi)
FmtLin({},aL[06],,,@nLi)
FmtLin({},aL[07],,,@nLi)
FmtLin({},aL[08],,,@nLi)
FmtLin({},aL[09],,,@nLi)
FmtLin(aLinTit,aL[10],,,@nLi)      
FmtLin({},aL[11],,,@nLi)
FmtLin(aLinDep,aL[12],,,@nLi)      
FmtLin({},aL[13],,,@nLi)
FmtLin(aLinAgr,aL[14],,,@nLi)      
FmtLin({},aL[15],,,@nLi)
FmtLin(aValTxt,aL[16],,,@nLi)
FmtLin({},aL[17],,,@nLi)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ProcTotGer³ Autor ³ Luzio Tavares         ³ Data ³26.02.2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa Total Geral                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function ProcTotGer()

LOCAL	aL		:=	LayOutTotG()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	If nAnaSin = 1
		@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
	EndIf	
	++nLi
Endif
          
FmtLin({},aL[01],,,@nLi)
FmtLin({cOpeDe,cGrupoDe,"",cGrupoAte},aL[02],,,@nLi)
FmtLin({},aL[03],,,@nLi)
FmtLin({},aL[04],,,@nLi)
FmtLin({},aL[05],,,@nLi)
FmtLin({},aL[06],,,@nLi)
FmtLin({},aL[07],,,@nLi)
FmtLin({},aL[08],,,@nLi)
FmtLin({},aL[09],,,@nLi)
FmtLin(aLinTotTit,aL[10],,,@nLi)      
FmtLin({},aL[11],,,@nLi)
FmtLin(aLinTotDep,aL[12],,,@nLi)      
FmtLin({},aL[13],,,@nLi)
FmtLin(aLinTotAgr,aL[14],,,@nLi)      
FmtLin({},aL[15],,,@nLi)
FmtLin(aValTotTxt,aL[16],,,@nLi)
FmtLin({},aL[17],,,@nLi)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³LayOutSubT³ Autor ³ Luzio Tavares         ³ Data ³26.02.0208³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta Lay-Out do sub-total                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function LayOutSubT()

Local aL := Array(17)

aL[01]:="+=========================================================================================================================+"
aL[02]:="| Resumo do Grupo/Empresa: ####-#### - ############################################                                       |"
aL[03]:="+=========================================================================================================================+"
aL[04]:="|                                             Faixas Etarias - Padrao ANS                                                 |"
aL[05]:="+=========================================================================================================================+"
aL[06]:="| Idade     |   0  - 17   |   18 - 29   |   30 - 39   |   40 - 49   |   50 - 59   |   60 - 69   |  70 - 999   |  TOTAIS   |"
aL[07]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[08]:="| Sexo      |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |           |"
aL[09]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[10]:="| Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[11]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[12]:="| Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[13]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[14]:="| Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[15]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[16]:="| TOTAIS    |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  | ######### |"
aL[17]:="+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"
Return(aL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³LayOutTotG³ Autor ³ Luzio Tavares         ³ Data ³26.02.2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta Lay-Out do total geral                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function LayOutTotG()

Local aL := Array(17)

aL[01]:="+=========================================================================================================================+"
aL[02]:="| Resumo Geral do Relatorio  --->>  Grupo/Empresa: ####-#### a ####-####                                                  |"
aL[03]:="+=========================================================================================================================+"
aL[04]:="|                                             Faixas Etarias - Padrao ANS                                                 |"
aL[05]:="+=========================================================================================================================+"
aL[06]:="| Idade     |   0  - 17   |   18 - 29   |   30 - 39   |   40 - 49   |   50 - 59   |   60 - 69   |  70 - 999   |  TOTAIS   |"
aL[07]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[08]:="| Sexo      |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |           |"
aL[09]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[10]:="| Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[11]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[12]:="| Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[13]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[14]:="| Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[15]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[16]:="| TOTAIS    |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  | ######### |"
aL[17]:="+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"
Return(aL)
