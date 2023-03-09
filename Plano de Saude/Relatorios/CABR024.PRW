#include "PROTHEUS.CH"
#INCLUDE "PLSTISS.CH"
#define	 cPicCNES	PesqPict("BB8","BB8_CNES")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR024  ³ Autor ³ Luzio Tavares         ³ Data ³ 26.05.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Guia de Consulta                                           ³±±
±±³          ³ Guia de Servico Profissional / Servico Auxiliar de Diag-   ³±±
±±³          ³ nostico e Terapia - SP/SADT                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CABR431(aPar)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR024(aPar)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbCont, Cabec1, Cabec2, Cabec3, nPos, wnrel
Local cTamanho   := "M"
Local cDesc1     := "Impressao da Guia de Consulta/SADT"
Local cDesc2     := "de acordo com a configuracao do usuario."
Local cDesc3     := " "
Local aArea	     := GetArea()
Local lGerTXT    := .T.
Local nSvRecno   := BBD->(Recno())
Local lGuia      := .T.
Local lReceita   := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLayout

Private aReturn  := { "Zebrado", 1,"Administracao", 1, 1, 1, "", 1 }
Private aLinha	 := { }
Private nLastKey := 0
Private cTitulo	 := "GUIA DE CONSULTA/SADT"
Private cPerg    := "" 

DEFAULT aPar := {"1",.F.}

//If aPar[1] == "1"
//	cPerg := "PL430N"+Space((10-Len("PL430N")))
//Else
//	cPerg := "PLR430"+Space((10-Len("PLR430")))
//EndIf

////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
////³ Ajusta perguntas                                                         ³
////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//CriaSX1(aPar) //cria pergunta...

lGerTXT := aPar[2] // Imprime Direto sem passar pela tela de configuracao/preview do relatorio

//If aPar[1] == "2" .And. lGerTXT
//	If ! Pergunte("PL430N", .T.)
//		Return
//	EndIf
//EndIf

//--Altera o Set Epch para 1910
nEpoca := SET(5, 1910)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CbCont   := 0
Cabec1   := OemtoAnsi(cTitulo)
Cabec2   := " "
Cabec3   := " "
cString  := "BBD"
aOrd     := {}

wnRel := "CABR024" // Nome Default do relatorio em Disco

		dbSelectArea("SX6")
        SX6->(DbSetOrder(1))
        If !SX6->(DbSeek(xFilial("SX6")+"MV_YNUGUIA",.F.))
			While ! SX6->(RecLock("SX6",.T.)) 
			Enddo                  
			RecLock("SX6",.T.)
			SX6->X6_FIL	  	:= xFilial("SX6")
			SX6->X6_VAR		:= "MV_YNUGUIA"
			SX6->X6_TIPO		:= "N"
			SX6->X6_DESCRIC	:= "CONTROLE DA NUMERACAO DAS GUAIS EMITIDAS PELOS"
			SX6->X6_DESC1		:= "NUPRES DA CABERJ"
			SX6->X6_DESC2		:= ""
			SX6->X6_DSCSPA	:= ""
			SX6->X6_DSCSPA1	:= ""
			SX6->X6_DSCSPA2	:= ""
			SX6->X6_DSCENG	:= ""
			SX6->X6_DSCENG1	:= ""
			SX6->X6_CONTEUD	:= "1"
			SX6->X6_CONTSPA	:= "1"
			SX6->X6_CONTENG	:= "1"
			SX6->X6_PROPRI	:= "U"
			SX6->X6_PYME	:= "S"
			SX6->(MsUnlock())						
        Endif   

//If aPar[1] == "1"
//	Pergunte(cPerg,.F.)
//Endif

wRel := SetPrint(cString, wnRel, cPerg, @cTitulo, cDesc1, cDesc2, cDesc3, .F., aOrd, .F., cTamanho,,.F.,,, lGerTXT)

If nLastKey = 27
	Set Filter To
	Return
Endif

If lGerTXT
	SetPrintFile(wnRel)
EndIf

//If aPar[1] == "1"
	nLayout := mv_par01
//Endif

RptStatus({|lEnd| R024Imp(@lEnd, wRel, cString, aPar, lGerTXT, nLayout)}, cTitulo)

//-- Posiciona o ponteiro
BBD->(dbGoto(nSvRecno))

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Restaura Area e Ordem de Entrada                              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
//--Retornar Set Epoch Padrao
SET(5, nEpoca)
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R024IMP  ³ Autor ³ Luzio Tavares         ³ Data ³ 26/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABAR024                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R024Imp(lEnd, wRel, cString, aPar, lGerTXT, nLayout)

Local cCodOpe
Local cGrupoDe
Local cGrupoAte
Local cContDe
Local cContAte
Local cSubDe
Local cSubAte
Local nTipo
Local cSQL
Local aConsulta := {}
Local aSADT     := {}

Private nQtdGuias := 0

DEFAULT aPar    := {"1",.F.}

If aPar[1] == "1"  // Impressao Individual
	aAdd(aSADT, MtaDados(BBD->BBD_TIPO))
EndIf

//If Len(aConsulta) > 0
//	PlsTISS1(aConsulta, lGerTXT, NIL )
//EndIf
If Len(aSADT) > 0
	CABRTISS(aSADT, lGerTXT, NIL )
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MtaDados ³ Autor ³ Luzio Tavares         ³ Data ³ 26/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Grava STATUS da tabela BEA e chama a funcao "CABGSADT"     ³±±
±±³          ³ que ira retornar o array com os dados a serem impressos.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABAR024V                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MtaDados(nGuia)

Local aDados := {}

aDados := CABGSADT(nGuia) // Funcao que monta o array com os dados da guia de CONSULTA ou SP/SADT

Return aDados

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Luzio Tavares        ³ Data ³ 26.05.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1(aPar)

LOCAL aRegs	 :=	{}

If aPar[1] == "1"
	aadd(aRegs,{cPerg,"01","Selecionar Layout Papel:" ,"","","mv_ch1","N", 1,0,0,"C","","mv_par01","Ofício 2"         	,"","","","","Papel A4"            	,"","","","","Papel Carta"              ,"","","","",""       ,"","","","","","","","",""   ,""})
Else
	aadd(aRegs,{cPerg,"09","Selecionar Layout Papel:" ,"","","mv_ch9","N", 1,0,0,"C","","mv_par09","Ofício 2"         	,"","","","","Papel A4"            	,"","","","","Papel Carta"              ,"","","","",""       ,"","","","","","","","",""   ,""})
Endif

PlsVldPerg( aRegs )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ CABGSADT  ³ Autor ³ Luzio Tavares         ³ Data ³ 26.05.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Dados Relatório TISS (Guia Consulta e SP/SADT )             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABR024                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nGuia ( Informe 1- Guia de Consulta e 2-Guia de SP/SADT )   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABGSADT(nGuia)

Local aDados := {}
Local aCpo25 := {}
Local aCpo26 := {}
Local aCpo27 := {}
Local aCpo28 := {}
Local aCpo29 := {}
Local aCpo40 := {}
Local aCpo51 := {}
Local aCpo52 := {}
Local aCpo53 := {}
Local aCpo54 := {}
Local aCpo55 := {}
Local aCpo56 := {}
Local aCpo57 := {}
Local aCpo58 := {}
Local aCpo59 := {}
Local aCpo60 := {}
Local aCpo61 := {}
Local aCpo62 := {}
Local aCpo63 := {}
Local aCpo65 := {}
Local aCpo66 := {}
Local aCpo67 := {}
Local aCpo68 := {}
Local aCpo69 := {}
Local aCpo70 := {}
Local aCpo71 := {}
Local aCpo72 := {}
Local aCpo73 := {}
Local aCpo74 := {}
Local aCpo75 := {}
Local aCpo76 := {}
Local aCpo77 := {}
Local aCpo78 := {}
Local aCpo79 := {}
Local aCpo80 := {}
Local aCpo81 := {}
Local aCpo82 := {}
Local aCpo83 := {}
Local aCpo84 := {}
Local aCpo85 := {}
Local nVrproc := 0
Local nVrTaxas := 0
Local nVrMater := 0
Local nVrMedic := 0
Local nVrTaxas := 0
Local nVrDiar  := 0
Local nVrGases := 0
Local nTotOPM  := 0

Local lTemPFExe
Local lExecPF
Local lBE2Aut
Local nRecBAU   := 0
Local nOrdBAU   := 0
Local cGuia     := Space(0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Operadora                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA0->(dbSetOrder(1))
BA0->(dbSeek(xFilial("BA0")+BBD->(BBD_CODINT)))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Usuario                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(dbSetOrder(2))
BA1->(dbSeek(xFilial("BA1")+BBD->(BBD_CODPAC)))    //INT+BBD_CODEMP+BEA_MATRIC+BEA_TIPREG)))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Vidas                                  			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BTS->(dbSetOrder(1))
BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Familias/Usuarios                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->(dbSetorder(01))
BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Produtos de Saude - Plano                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BI3->(dbSetOrder(1))
BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Medico Solicitante                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BB0->(dbSetOrder(4))
//	BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))
BB0->(dbSeek(xFilial("BB0")+BBD->(BBD_ESTCR+BBD_NUMREG+BBD_SIGLA)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Rede de Atendimento                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(dbSetOrder(1))
BAU->(dbSeek(xFilial("BAU")+BBD->BBD_CODIGO))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Contas Medicas                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BTI->(dbSetOrder(1))
BTI->(MsSeek(xFilial("BTI")+BBD->(BBD_FILIAL+BBD_NUMATE)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Especialidade                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAQ->(dbSetOrder(1))
BAQ->(MsSeek(xFilial("BAQ")+BBD->(BBD_CODINT+BBD_CODESP)))

// Dados da Autorizacao
aAdd(aDados, BA0->BA0_SUSEP) // 1
aAdd(aDados, ""  )   //BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2
aAdd(aDados, ""  )   //if (!Empty(BEA->BEA_GUIPRI),BEA->BEA_GUIPRI,BD5->BD5_GUIINT)) // 3
aAdd(aDados, BBD->BBD_DATA) // 4
aAdd(aDados, ""  )   //BEA->BEA_SENHA) // 5
aAdd(aDados, CtoD("  /  /    ")  )   //IIf(Empty(BEA->BEA_SENHA), StoD(""), BEA->BEA_VALSEN)) // 6
aAdd(aDados, dDatabase )  //BEA->BEA_DTDIGI) // 7
// Dados do Beneficiario
If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 8
	aAdd(aDados, BBD->(SubStr(BBD_CODPAC,1,4)+"."+SubStr(BBD_CODPAC,5,4)+"."+SubStr(BBD_CODPAC,9,6)+"."+SubStr(BBD_CODPAC,15,2)+"-"+SubStr(BBD_CODPAC,17,1)))
Else
	aAdd(aDados, BA1->BA1_MATANT)
EndIf
aAdd(aDados, BI3->BI3_NREDUZ) // 9
aAdd(aDados, BA1->BA1_DTVLCR) // 10
aAdd(aDados, BBD->BBD_NOME) // 11
aAdd(aDados, BTS->BTS_NRCRNA) // 12
// Dados do Contratado Solicitante
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Medico Solicitante                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BB0->(dbSetOrder(4) )
BB0->(dbSeek(xFilial("BB0")+BBD->(BBD_ESTCR+BBD_NUMREG+BBD_SIGLA)))
If  BBD->(FieldPos("BBD_RDACON")) > 0 .and. !Empty(BBD->BBD_RDACON)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Salva Recnos												 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nRecBAU := BAU->(Recno())
	nOrdBAU := BAU->(IndexOrd())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona Rede de Atendimento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+BBD->BBD_RDACON))
	
	aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 13
	aAdd(aDados, BAU->BAU_NOME) // 14
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona registros											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(DbSetOrder(nOrdBAU))
	BAU->(DbGoTo(nRecBAU))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Como no nosso sistema não existe local de atendimento para   ³
	//| o contratado solicitante, o CNES esta sendo enviado em branco|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BB8->(dbSetOrder(1))
	BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BBD_CODINT+BBD_CODLOC)))
	aAdd(aDados, Transform('', cPicCNES)) // 15
Else
	aAdd(aDados, IIf(Len(AllTrim(BB0->BB0_CGC)) == 11, Transform(BB0->BB0_CGC, "@R 999.999.999-99"), Transform(BB0->BB0_CGC, "@R 99.999.999/9999-99"))) // 13
	aAdd(aDados, BB0->BB0_NOME) // 14
	BB8->(dbSetOrder(1))
	BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BBD->(BBD_CODINT+BBD_CODLOC)))
	aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 15
Endif

aAdd(aDados, BB0->BB0_NOME)   // 16
aAdd(aDados, BBD->BBD_SIGLA)  // 17
aAdd(aDados, BBD->BBD_NUMREG) // 18
aAdd(aDados, BBD->BBD_ESTCR)  // 19
aAdd(aDados, BAQ->BAQ_CBOS)   // 20
// Dados da solicitacao/procedimentos/exames solicitados

aAdd(aDados, { BBD->BBD_DATA, BBD_FIMATE }) // 21

aAdd(aDados, "E" )   //BDR->BDR_CARINT) // 22

aAdd(aDados, BBD->BBD_CID)                                        // 23

BTH->(dbSetOrder(1))
BTH->(dbSeek(xFilial("BTH")+BBD->BBD_NUMATE))
aAdd(aDados, AllTrim(BTH->BTH_YINDC))                             // 24  Indicacao Clinica

cGuia     := Space(0)
nQtdGuias := 0

BTI->(dbSetOrder(1))
cChave := (xFilial("BTI")+BBD->BBD_NUMATE)
If BTI->(dbSeek(cChave))
	Do While !BTI->(Eof()) .And. cChave == BTI->(BTI_FILIAL+BTI_CODATE)
		
		lBTIAut := BTI->BTI_QTD > 0
		
		BR8->(dbSetOrder(1))
		BR8->(dbSeek(xFilial("BR8")+BTI->(BTI_CODPAD+BTI_CODPRO)))
		
		If !(BR8->BR8_TPPROC $ GetNewPar("MV_YTPPROG","0_5_6"))  //Somente procedimento, diarias, taxas, ortese
			BTI->(DbSkip())
			Loop
		EndIf
		
		aAdd(aCpo25, {AllTrim(BTI->BTI_YNGUIA),;
		Posicione("BF8", 2, xFilial("BF8")+BTI->(BTI_CODPAD+BTI_CODPRO), "BF8_TABTIS"),;
		PlsPicPro(BTI->BTI_CODPAD, BTI->BTI_CODPRO),;
		BR8->BR8_DESCRI,;  //27
		BTI->BTI_QTD,;     //28
		BTI->BTI_QTD,;     //29
		0,;                //61
		0})                //62     //25
		
		// * * * * * * * * * *    A T E N C A O     * * * * * * * * * * * * * corrigir aqui apra trazer o codigo da TISS
		//		aAdd(aCpo25, Posicione("BF8", 2, xFilial("BF8")+BTI->(BTI_CODPAD+BTI_CODPRO), "BF8_TABTIS"))    //25
		aAdd(aCpo26, PlsPicPro(BTI->BTI_CODPAD, BTI->BTI_CODPRO)) // 26
		aAdd(aCpo27, BR8->BR8_DESCRI)      //BE2->BE2_DESPRO)      // 27
		aAdd(aCpo28, BTI->BTI_QTD)                                 // 28
		aAdd(aCpo29, BTI->BTI_QTD)                                 // 29
		
		aAdd(aCpo61, 0)                                            // 61
		aAdd(aCpo62, 0)                                            // 62
		
		If cGuia <> AllTrim(BTI->BTI_YNGUIA)
			cGuia     := AllTrim(BTI->BTI_YNGUIA)
			nQtdGuias += 1
		EndIf
		
		BTI->(dbSkip())
		
	Enddo
	
	aSort(aCpo25,,,{|x,y| x[1]+x[3] < y[1]+y[3]})
EndIf
aAdd(aCpo65, nVrProc)
aAdd(aCpo66, nVrTaxas)
aAdd(aCpo67, nVrMater)
aAdd(aCpo68, nVrMedic)
aAdd(aCpo69, nVrDiar)
aAdd(aCpo70, nVrGases)
aAdd(aCpo71, nVrProc+nVrTaxas+nVrMater+nVrMedic+nVrDiar+nVrGases)
aAdd(aCpo85, nTotOPM)

aAdd(aDados, aCpo25)
aAdd(aDados, aCpo26)
aAdd(aDados, aCpo27)
aAdd(aDados, aCpo28)
aAdd(aDados, aCpo29)
// Dados do Contratado executante
lTemPFExe := .F. // Tem Profissional Executante informado na Guia
lExecPF   := .F. // O executante (RDA) eh pessoa fisica

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Rede de Atendimento                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(dbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+BBD->BBD_CODIGO))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Profissional de Saude                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Empty(BEA->BEA_REGEXE)
	BB0->(dbSetOrder(4) )
	lTemPFExe := BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)))
Else
	If BAU->BAU_TIPPE == "F"
		BB0->(dbSetOrder(1))
		lExecPF := BB0->(dbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
	EndIf
EndIf

BB8->(dbSetOrder(1))
BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BBD->(BBD_CODINT+BBD_CODLOC)))

aAdd(aDados, "") // 30
aAdd(aDados, "") // 31
aAdd(aDados, "") // 32
aAdd(aDados, "") // 33
aAdd(aDados, "") // 34
aAdd(aDados, "") // 35
aAdd(aDados, "") // 36
aAdd(aDados, "") // 37
aAdd(aDados, "") // 38
aAdd(aDados, "") // 39
aCpo40 := {}
aAdd(aCpo40, "") // 40

aAdd(aCpo40, "") // 40a
aAdd(aDados, aCpo40) // 40 e 40a
aAdd(aDados, "") // 41
aAdd(aDados, "") // 42
aAdd(aDados, "") // 43
aAdd(aDados, "") // 44
aAdd(aDados, { "", "" }) // 45 e 45a ??????(45a)?????grau de participacao?????
//		EndIf
// Dados do Atendimento

aAdd(aDados, "")
aAdd(aDados, "")   //BEA->BEA_INDACI) // 47
aAdd(aDados, "")   //BEA->BEA_TIPSAI) // 48
// Consulta de referencia
aAdd(aDados, "")   //BEA->BEA_TIPDOE) // 49
aAdd(aDados, {0,""})  //{ BEA->BEA_TPODOE, BEA->BEA_UTPDOE } ) // 50

// Procedimentos e exames realizados
aAdd(aDados, aCpo51)
aAdd(aDados, aCpo52)
aAdd(aDados, aCpo53)
aAdd(aDados, aCpo54)
aAdd(aDados, aCpo55)
aAdd(aDados, aCpo56)
aAdd(aDados, aCpo57)
aAdd(aDados, aCpo58)
aAdd(aDados, aCpo59)
aAdd(aDados, aCpo60)
aAdd(aDados, aCpo61)
aAdd(aDados, aCpo62)
aAdd(aDados, aCpo63) // Data e Assinatura de Procedimentos em Serie
aAdd(aDados, "" )     //AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02))  // 64
aAdd(aDados, aCpo65) // 65 - Vr Procedimentos
aAdd(aDados, aCpo66) // 66 - Vr Taxas e Alugueis
aAdd(aDados, aCpo67) // 67 - Vr Materiais
aAdd(aDados, aCpo68) // 68 - Vr Medicamentos
aAdd(aDados, aCpo69) // 69 - Vr Diarias
aAdd(aDados, aCpo70) // 70 - Vr Gases Medicinais
aAdd(aDados, aCpo71)
// OPM Solicitadas
aAdd(aDados, aCpo72)
aAdd(aDados, aCpo73)
aAdd(aDados, aCpo74)
aAdd(aDados, aCpo75)
aAdd(aDados, aCpo76)
aAdd(aDados, aCpo77)
// OPM Utilizadas
aAdd(aDados, aCpo78)
aAdd(aDados, aCpo79)
aAdd(aDados, aCpo80)
aAdd(aDados, aCpo81)
aAdd(aDados, aCpo82)
aAdd(aDados, aCpo83)
aAdd(aDados, aCpo84)
aAdd(aDados, aCpo85)	 // 85 - Valor Total de OPM
aAdd(aDados, dDataBase)   //CtoD(""))  // dDataBase 86 - Data e Assinatura do Solicitante
aAdd(aDados, ctod(""))  // 87 - Data e Assinatura do Responsavel pela Autorizacao
aAdd(aDados, ctod(""))  // 88 - Data e Assinatura do Beneficiario ou Responsavel
//If BEA->BEA_ORIGEM == "1"
//aAdd(aDados, dDataBase) // 89 - Data e Assinatura do Prestador Executante
//Else
aAdd(aDados, ctod("")) // 89 - Data e Assinatura do Prestador Executante
//Endif
//	Else
//		MsgInfo("Guia Originada da Internação, para Impressão ir a Rotina de Internação.")
//	EndIf

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ CABRTISS  ³ Autor ³ Luzio Tavares         ³ Data ³ 27.05.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS (Guia de Serv/SADT ) -             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informacoes do relatorio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem ssar pela tela	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABRTISS(aDados, lGerTXT, nLayout, cLogoGH)

Local nQ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nJ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nA := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nZ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aPrcGui := {}
Local nLinMax
Local nColMax
Local nLinIni	:= 0		// Linha Lateral (inicial) Esquerda
Local nColIni	:= 0		// Coluna Lateral (inicial) Esquerda
Local nColA4    := 0
Local nColSoma  := 0
Local nColSoma2 := 0
Local nLinA4	:= 0
Local cFileLogo
Local lPrinter
Local nLin
Local nOldLinIni
Local nOldColIni
Local nI, nJ, nX, nN
Local nV, nV1, nV2, nV3, nV4
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local lImpnovo  :=.T.
Local nVolta    := 0
Local nP        := 0
Local nP1       := 0
Local nP2       := 0
Local nP3       := 0
Local nP4       := 0
Local nT        := 0
Local nT1       := 0
Local nT2       := 0
Local nT3       := 0
Local nT4       := 0
Local nTotOPM   := 0
Local nProx     := 0
Local nProx     := 0
Local nNroGuia	:= 0
//Local nNroGuiaSX6 := GetNewPar("MV_YNUGUIA",1)

Default lGerTXT := .F.
Default nLayout := 2
Default cLogoGH := ''
Default aDados := { {;
"123456",;
"12345678901234567892",;
"12345678901234567892",;
CtoD("01/01/07"),;
"12345678901234567892",;
CtoD("01/01/07"),;
CtoD("01/01/07"),;
"12345678901234567892",;
Replicate("M",20),;
CtoD("12/12/07"),;
Replicate("M",70),;
"123456789102345",;
"14.141.114/00001-35",;
Replicate("M",70),;
"1234567",;
Replicate("M",70),;
"1234567",;
"123456789102345",;
"ES",;
"12345",;
{ CtoD("12/12/07"), "2210" },;
"E",;
"12345",;
Replicate("M",70),;
{ "10", "20", "30", "40", "50" } ,;
{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234" },;
{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;
{ 111,111,11,1,1 },;
{ 999,999,99,9,9 },;
"14.141.114/00001-35",;
Replicate("M",70),;
"999",;
Replicate("M",40),;
"MMMMM",;
Replicate("M",15),;
Replicate("M",40),;
"MM",;
"1234567",;
"12345-678",;
{ "1234567", "27.456.658/0001-35" },;
Replicate("M",70),;
"1234567",;
"123456789102345",;
"MM",;
{ "12345", "01" },;
"01",;
"1",;
"1",;
"1",;
{ 12,"M" },;
{ CtoD("01/01/07"),CtoD("01/02/07"),CtoD("01/03/07"),CtoD("01/04/07"),CtoD("01/05/07")},;
{ "0107","0207","0307","0407","0507" },;
{ "0607","0707","0807","0907","1007" },;
{ "MM","AA","BB","CC","DD"},;
{ "1234567890","2345678901","3456789012","4567890123","5678901234"},;
{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60)},;
{ 12,1,2,3,4},;
{ "M","A","B","C","D"},;
{ "M","E","F","G","H"},;
{ 111.00,222.00,333.00,444.00,999.99 },;
{ 99999999.99,22222.22,33333.33,44444.44,11111.11 },;
{ 11111111.11,55555.00,66666.00,77777.00,88888.00 },;
{ CtoD("01/01/07"),CtoD("02/01/07"),CtoD("03/01/07"),CtoD("04/01/07"),CtoD("05/01/07"),CtoD("06/01/07"),CtoD("07/01/07"),CtoD("08/01/07"),CtoD("09/01/07"),CtoD("10/01/07")},;
Replicate("M", 240),;
{1333333.22},;
{2333333.22},;
{3333333.22},;
{4333333.22},;
{5333333.22},;
{6333333.22},;
{73333333.22},;
{ "11", "22", "33", "44", "55", "66", "77", "88", "99" },;
{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
{ Replicate ("M", 60), Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60) },;
{ 01, 1, 2, 03, 04, 05, 06, 7, 99 }, ;
{ Replicate ("I", 40), Replicate ("J", 40), Replicate ("K", 40), Replicate ("L", 40), Replicate ("M", 40), Replicate ("N", 40), Replicate ("O", 40), Replicate ("P", 40), Replicate ("Q", 40) },;
{ 999999.99, 111111.99, 222229.99, 333999.99, 444449.99, 555559.99, 666669,99, 777779.99, 888899.99 },;
{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
{ 399999999.99, 499999999.99, 599999999.99, 699999.99, 799999.99, 899999.99, 99.99, 09.99, 19.99 },;
{1999999.99},;
CtoD("01/01/07"),;
CtoD("02/01/07"),;
CtoD("03/01/07"),;
CtoD("04/01/07") } }

nLinMax	:=	2375
nColMax	:=	3370 //3365

oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal

oPrint	:= TMSPrinter():New(STR0059) //"GUIA DE SERVICO PROFISSIONAL"

oPrint:SetLandscape()		// Modo paisagem

oPrint:SetPaperSize(9)     // Papél A4

// Verifica se existe alguma impressora configurada para Impressao Grafica
lPrinter := oPrint:IsPrinterActive()

If !lPrinter
	oPrint:Setup()
EndIf

For nA := 1 to len(aDados)

For nZ := 1 To nQtdGuias
	
//verifica a quantidade de procedimento a ser impresso por grupo de procedimentos
//	nGrpProc := 0    
//	cnZ := Space(0)
//	For nJ := 1 to Len(aDados[nA, 25])
//		If aDados[nA, 25, nJ, 1] != cnZ
//			cnZ := aDados[nA, 25, nJ, 1]    //StrZero(nZ,1,0)
//			nGrpProc += 1
//		EndIf
//	Next

	nGrpProc := 0    
	aPrcGui := {}
	For nJ := 1 to Len(aDados[nA, 25])
		If aDados[nA, 25, nJ, 1] == StrZero(nZ,1,0)
			nGrpProc += 1
			Aadd(aPrcGui,aDados[nA, 25, nJ])
		EndIf
	Next

	lImpnovo := .T.

	nVolta  := 0
	nT      := 0
	nT1     := 0
	nT2     := 0
	nT3     := 0
	nT4     := 0
	nProx   := 0
		
	While lImpnovo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Atualiza a numero da guia no SX6                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//		nNroGuia := nValCorSX6 + 1
//		PutMv("MV_YNUGUIA",nNroGuia)

		dbSelectArea("SX6")
        SX6->(DbSetOrder(1))
        If SX6->(DbSeek(xFilial("SX6")+"MV_YNUGUIA",.F.))
			While ! SX6->(RecLock("SX6",.F.)) 
			Enddo                  
			nNroGuia := Val(SX6->X6_CONTEUD) + 1
			SX6->X6_CONTEUD := AllTrim(Str(nNroGuia))
			SX6->X6_CONTSPA := AllTrim(Str(nNroGuia))
			SX6->X6_CONTENG := AllTrim(Str(nNroGuia))
//			nRecSX6 := SX6->(Recno())
//			SX6->(DbGoTo(nRecSX6))
			SX6->(MsUnLock())
		EndIf	

		lImpnovo:=.F.
		
		nVolta  += 1
		nT      += 5
		nT1     += 5
		nT2     += 10
		nT3     += 9
		nT4     += 9
		nProx   += 1
		
		//Se a quant de procedimento for menor que 5, implementa com vazio os demais
//		If Len(aDados[nA, 25]) < nGrpProc < nT
		If nGrpProc < nT
			For nQ := Len(aPrcGui) + 1 To nT   //nGrpProc
				aAdd(aPrcGui, {StrZero(nZ,1,0),"","","",0,0})
			Next
		EndIf
		
		//Se a quant de procedimento for menor que 5, implementa com vazio os demais
		//			For nI := 25 To 29
		For nI := 26 To 29
			If Len(aDados[nA, nI]) < nT   // menor que 5 linhas
				For nJ := Len(aDados[nA, nI]) + 1 To nT
					If AllTrim(Str(nI)) $ "28,29"
						aAdd(aDados[nA, nI], 0)
					Else
						aAdd(aDados[nA, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI
		
		For nI := 51 To 62
			If Len(aDados[nA, nI]) < nT1
				For nJ := Len(aDados[nA, nI]) + 1 To nT1
					If AllTrim(Str(nI)) $ "51"
						aAdd(aDados[nA, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "57,60,61,62"
						aAdd(aDados[nA, nI], 0)
					Else
						aAdd(aDados[nA, nI], "")
					EndIf
				Next nJ
			EndIf
		Next
		
		If Len(aDados[nA, 63]) < nT2
			For nJ := Len(aDados[nA, 63]) + 1 To nT2
				aAdd(aDados[nA, 63], StoD(""))
			Next nJ
		EndIf
		
		For nI := 65 To 71
			If Len(aDados[nA, nI]) < nVolta
				For nJ := Len(aDados[nA, nI]) + 1 To nVolta
					aAdd(aDados[nA, nI], 0)
				Next nJ
			EndIf
		Next nI
		
		For nI := 72 To 77
			If Len(aDados[nA, nI]) < nT3
				For nJ := Len(aDados[nA, nI]) + 1 To nT3
					If AllTrim(Str(nI)) $ "75,77"
						aAdd(aDados[nA, nI], 0)
					Else
						aAdd(aDados[nA, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI
		
		For nI := 78 To 84
			If Len(aDados[nA, nI]) < nT4
				For nJ := Len(aDados[nA, nI]) + 1 To nT4
					If AllTrim(Str(nI)) $ "81,83,84"
						aAdd(aDados[nA, nI], 0)
					Else
						aAdd(aDados[nA, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI
		
		If Len(aDados[nA, 85]) < nVolta
			For nJ := Len(aDados[nA, 85]) + 1 To nVolta
				aAdd(aDados[nA, 85], 0)
			Next nJ
		EndIf
		
		nLinIni   := 0
		nColIni   := 0
		nColA4    := 0
		nLinA4	  := 0
		nColSoma  := 0
		nColSoma2 := 0
		
		oPrint:StartPage()	// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)
		
		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 	// Tem que estar abaixo do RootPath
		EndIf
		
		nColA4    := -0395
		nLinA4    := -0010
		nColSoma  := -0300
		nColSoma2 := -0190
		
		oPrint:Say(nLinIni + 0050, nColIni + 1852 + (nColA4/2), STR0060, oFont02n,,,, 2)                      //"GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE DIAGNÓSTICO E TERAPIA - SP/SADT"
		oPrint:Say(nLinIni + 0060, nColIni + 2950 + (nColA4/2), "2 - "+STR0002, oFont01)                      //"Nº"
//		oPrint:Say(nLinIni + 0040, nColIni + 3046 + (nColA4/2), aDados[nA, 02], oFont03n)                       //Numero da Guia
		oPrint:Say(nLinIni + 0040, nColIni + 3046 + (nColA4/2), StrZero(nNroGuia,20,0), oFont03n)             //Numero da Guia
		
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 0010, nLinIni + 0269 + nLinA4, nColIni + 0315)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 0020, "1 - "+STR0003, oFont01)                           //"Registro ANS"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 0030, aDados[nA, 01], oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 0320, nLinIni + 0269 + nLinA4, nColIni + 1035)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 0330, "3 - "+STR0061, oFont01) //"Nº Guia Principal"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 0340, aDados[nA, 03], oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 1040, nLinIni + 0269 + nLinA4, nColIni + 1345)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 1050, "4 - "+STR0062, oFont01) //"Data da Autorização"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 1060, DtoC(aDados[nA, 04]), oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 1350, nLinIni + 0269 + nLinA4, nColIni + 1755)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 1360, "5 - "+STR0063, oFont01) //"Senha"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 1370, aDados[nA, 05], oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 1760, nLinIni + 0269 + nLinA4, nColIni + 2165)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 1770, "6 - "+STR0064, oFont01) //"Data Validade da Senha"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 1780, DtoC(aDados[nA, 06]), oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 2170, nLinIni + 0269 + nLinA4, nColIni + 2465)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 2180, "7 - "+STR0004, oFont01) //"Data de Emissão da Guia"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 2190, DtoC(aDados[nA, 07]), oFont04)
		
		oPrint:Say(nLinIni + 0274 + nLinA4, nColIni + 0010, STR0005, oFont01) //"Dados do Beneficiário"
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 0010, nLinIni + 0398 + nLinA4, nColIni + 0425)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 0020, "8 - "+STR0006, oFont01) //"Número da Carteira"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 0030, aDados[nA, 08], oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 0430, nLinIni + 0398 + nLinA4, nColIni + 1572 + nColA4)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 0440, "9 - "+STR0007, oFont01) //"Plano"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 0450, aDados[nA, 09], oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 1577 + nColA4, nLinIni + 0398 + nLinA4, nColIni + 1835 + nColA4)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 1587 + nColA4, "10 - "+STR0008, oFont01) //"Validade da Carteira"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 1597 + nColA4, DtoC(aDados[nA, 10]), oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 1840 + nColA4, nLinIni + 0398 + nLinA4, nColIni + 3290 + nColA4)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 1850 + nColA4, "11 - "+STR0009, oFont01) //"Nome"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 1860 + nColA4, SubStr(aDados[nA, 11], 1, 52), oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 3295 + nColA4, nLinIni + 0398 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 3305 + nColA4, "12 - "+STR0010, oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 3315 + nColA4, aDados[nA, 12], oFont04)
		
		oPrint:Say(nLinIni + 0403 + nLinA4, nColIni + 0010, STR0065, oFont01) //"Dados do Contratado Solicitante"
		oPrint:Box(nLinIni + 0433 + nLinA4, nColIni + 0010, nLinIni + 0527 + nLinA4, nColIni + 0426)
		oPrint:Say(nLinIni + 0438 + nLinA4, nColIni + 0020, "13 - "+STR0012, oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say(nLinIni + 0468 + nLinA4, nColIni + 0030, aDados[nA, 13], oFont04)
		oPrint:Box(nLinIni + 0433 + nLinA4, nColIni + 0431, nLinIni + 0527 + nLinA4, nColIni + 2245)
		oPrint:Say(nLinIni + 0438 + nLinA4, nColIni + 0441, "14 - "+STR0013, oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 0468 + nLinA4, nColIni + 0451, SubStr(aDados[nA, 14], 1, 65), oFont04)
		oPrint:Box(nLinIni + 0433 + nLinA4, nColIni + 2250, nLinIni + 0527 + nLinA4, nColIni + 2480)
		oPrint:Say(nLinIni + 0438 + nLinA4, nColIni + 2260, "15 - "+STR0014, oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0468 + nLinA4, nColIni + 2270, aDados[nA, 15], oFont04)
		
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 0010, nLinIni + 0626 + nLinA4, nColIni + 1824)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 0020, "16 - "+STR0066, oFont01) //"Nome do Profissional Solicitante"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 0030, SubStr(aDados[nA, 16], 1, 66), oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 1829, nLinIni + 0626 + nLinA4, nColIni + 2122)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 1839, "17 - "+STR0022, oFont01) //"Conselho Profissional"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 1849, aDados[nA, 17], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2127, nLinIni + 0626 + nLinA4, nColIni + 2480)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2137, "18 - "+STR0023, oFont01) //"Número no Conselho"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2147, aDados[nA, 18], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2485, nLinIni + 0626 + nLinA4, nColIni + 2575)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2495, "19 - "+STR0018, oFont01) //"UF"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2505, aDados[nA, 19], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2580, nLinIni + 0626 + nLinA4, nColIni + 2790)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2590, "20 - "+STR0024, oFont01) //"Código CBO S"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2600, aDados[nA, 20], oFont04)
		
		oPrint:Say(nLinIni + 0631 + nLinA4, nColIni + 0010, STR0067, oFont01) //"Dados da Solicitação / Procedimentos e Exames Solicitados"
		oPrint:Box(nLinIni + 0661 + nLinA4, nColIni + 0010, nLinIni + 0755 + nLinA4, nColIni + 0315)
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 0020, "21 - "+STR0068, oFont01) //"Data/Hora da Solicitação"
		oPrint:Say(nLinIni + 0696 + nLinA4, nColIni + 0030, DtoC(aDados[nA, 21,1]) + " " + Transform(aDados[nA, 21,2], "@R 99:99"), oFont04)
		oPrint:Box(nLinIni + 0661 + nLinA4, nColIni + 0320, nLinIni + 0755 + nLinA4, nColIni + 0735)
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 0330, "22 - "+STR0069, oFont01) //"Caráter da Solicitação"
		oPrint:Line(nLinIni + 0691+ nLinA4, nColIni + 0340, nLinIni + 0738 + (nLinA4/2), nColIni + 0340)
		oPrint:Line(nLinIni + 0738+ (nLinA4/2), nColIni + 0340, nLinIni + 0738 + (nLinA4/2), nColIni + 0387)
		oPrint:Line(nLinIni + 0691+ nLinA4, nColIni + 0387, nLinIni + 0738 + (nLinA4/2), nColIni + 0387)
		oPrint:Say(nLinIni + 0696 + nLinA4, nColIni + 0353, aDados[nA, 22], oFont04)
		oPrint:Say(nLinIni + 0706 + nLinA4, nColIni + 0400, STR0070+"  "+STR0071, oFont01) //"E-Eletiva"###"U-Urgência/Emergência"
		oPrint:Box(nLinIni + 0661 + nLinA4, nColIni + 0740, nLinIni + 0755 + nLinA4, nColIni + 0905)
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 0750, "23 - "+STR0072, oFont01) //"CID 10"
		oPrint:Say(nLinIni + 0696 + nLinA4, nColIni + 0760, aDados[nA, 23], oFont04)
		oPrint:Box(nLinIni + 0661 + nLinA4, nColIni + 0910, nLinIni + 0755 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 0920, "24 - "+STR0073, oFont01) //"Indicação Clinica (obrigatório se pequena cirurgia, terapia, consulta referenciada e alto custo)"
		oPrint:Say(nLinIni + 0696 + nLinA4, nColIni + 0930, aDados[nA, 24], oFont04)
		
		oPrint:Box(nLinIni + 0760 + nLinA4, nColIni + 0010, nLinIni + 1005 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 0765 + nLinA4, nColIni + 0020, "25 - "+STR0074, oFont01) //"Tabela"
		oPrint:Say(nLinIni + 0765 + nLinA4, nColIni + 0150, "26 - "+STR0075, oFont01) //"Código do Procedimento"
		oPrint:Say(nLinIni + 0765 + nLinA4, nColIni + 0450, "27 - "+STR0076, oFont01) //"Descrição"
		oPrint:Say(nLinIni + 0765 + nLinA4, nColIni + 3425 + nColA4, "28 - "+STR0077, oFont01,,,,1) //"Qt.Solic."
		oPrint:Say(nLinIni + 0765 + nLinA4, nColIni + 3635 + nColA4, "29 - "+STR0078, oFont01,,,,1) //"Qt.Autoriz."
		
		nOldLinIni := nLinIni
		
		If nVolta = 1
			nV := 1
		Endif
		
/*
		For nP := nV To nT
			If aDados[nA, 25, nP, 1] == StrZero(nZ,1,0)
				If nVolta <> 1
					nN := nP - ((5*nVolta)-5)
					oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 0025, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 0025, AllTrim(Str(nP)) + " - ", oFont01)
				Endif
				//			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0065, aDados[nA, 25, nP], oFont04)
				//			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0150, aDados[nA, 26, nP], oFont04)
				//			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0450, aDados[nA, 27, nP], oFont04)
				//			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 3425 + nColA4, IIf(Empty(aDados[nA, 28, nP]), "", Transform(aDados[nA, 28, nP], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0065, aDados[nA, 25, nP, 3], oFont04)
				oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0150, aDados[nA, 25, nP, 4], oFont04)
				oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0450, Transform(aDados[nA, 25, nP, 5], "@E 9"), oFont04)
				oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 3425 + nColA4, IIf(Empty(aDados[nA, 25, nP, 6]), "", Transform(aDados[nA, 25, nP, 6], "@E 9999.99")), oFont04,,,,1)
				
				nLinIni += 40
			EndIf
		Next nP
*/

		For nP := nV To nT
			If nVolta <> 1
				nN := nP - ((5*nVolta)-5)
				oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 0025, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 0025, AllTrim(Str(nP)) + " - ", oFont01)
			Endif
			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0150, AllTrim(aPrcGui[nP, 3]), oFont04)
			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 0450, AllTrim(aPrcGui[nP, 4]), oFont04)
//			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 3425 + nColA4, Transform(aPrcGui[nP, 5], "@E 9999.99"), oFont04,,,,1)
			oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 3425 + nColA4, IIf(Empty(aPrcGui[nP, 5]), "", Transform(aPrcGui[nP, 5], "@E 9999.99")), oFont04,,,,1)
			
			nLinIni += 40
		Next nP
		
//		If nT < Len(aDados[nA, 26]) .or. lImpnovo
//		If nT < nGrpProc .or. lImpnovo
		If nT < Len(aPrcGui) .or. lImpnovo
			nV := nP
			lImpnovo:=.T.
		Endif
		
		nLinIni := nOldLinIni
		
		oPrint:Say(nLinIni + 1010 + nLinA4, nColIni + 0010, STR0079, oFont01) //"Dados do Contratado Executante"
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 0010, nLinIni + 1134 + nLinA4, nColIni + 0416)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 0020, "30 - "+STR0012, oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 0030, aDados[nA, 30], oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 0421, nLinIni + 1134 + nLinA4, nColIni + 1316 + nColSoma)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 0431, "31 - "+STR0013, oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 0441, SubStr(aDados[nA, 31], 1, 32), oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 1321 + nColSoma, nLinIni + 1134 + nLinA4, nColIni + 1433 + nColSoma)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 1331 + nColSoma, "32 - "+STR0015, oFont01) //"T.L."
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 1341 + nColSoma, aDados[nA, 32], oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 1438 + nColSoma, nLinIni + 1134 + nLinA4, nColIni + 2413 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 1448 + nColSoma, "33-34-35 - "+STR0016, oFont01) //"Logradouro - Número - Complemento"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 1458 + nColSoma, SubStr(AllTrim(aDados[nA, 33]) + IIf(!Empty(aDados[nA, 34]), ", ","") + AllTrim(aDados[nA, 34]) + IIf(!Empty(aDados[nA, 35]), " - ","") + AllTrim(aDados[nA, 35]), 1, 35), oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 2418 + nColA4, nLinIni + 1134 + nLinA4, nColIni + 3023 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 2428 + nColA4, "36 - "+STR0017, oFont01) //"Município"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 2438 + nColA4, SubStr(aDados[nA, 36], 1, 21), oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 3028 + nColA4, nLinIni + 1134 + nLinA4, nColIni + 3130 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 3038 + nColA4, "37 - "+STR0018, oFont01) //"UF"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 3048 + nColA4, aDados[nA, 37], oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 3135 + nColA4, nLinIni + 1134 + nLinA4, nColIni + 3320 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 3145 + nColA4, "38 - "+STR0080, oFont01) //"Cód.IBGE"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 3155 + nColA4, aDados[nA, 38], oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 3325 + nColA4, nLinIni + 1134 + nLinA4, nColIni + 3510 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 3335 + nColA4, "39 - "+STR0020, oFont01) //"CEP"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 3345 + nColA4, aDados[nA, 39], oFont04)
		oPrint:Box(nLinIni + 1040 + nLinA4, nColIni + 3515 + nColA4, nLinIni + 1134 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1045 + nLinA4, nColIni + 3525 + nColA4, "40 - "+STR0014, oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 3535 + nColA4, aDados[nA, 40, 1], oFont04)
		
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 0010, nLinIni + 1233 + nLinA4, nColIni + 0590)
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 0020, "40a - "+STR0081, oFont01) //"Código na Operadora / CPF do exec. complementar"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 0030, SubStr(aDados[nA, 40, 2], 1, 68), oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 0595, nLinIni + 1233 + nLinA4, nColIni + 2436 + nColA4)
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 0605, "41 - "+STR0082, oFont01) //"Nome do Profissional Executante/Complementar"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 0615, SubStr(aDados[nA, 41], 1, 68), oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 2441 + nColA4, nLinIni + 1233 + nLinA4, nColIni + 2715 + nColA4)
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 2451 + nColA4, "42 - "+STR0022, oFont01) //"Conselho Profissional"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 2461 + nColA4, aDados[nA, 42], oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 2720 + nColA4, nLinIni + 1233 + nLinA4, nColIni + 3055 + nColA4)
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 2730 + nColA4, "43 - "+STR0023, oFont01) //"Número no Conselho"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 2740 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), aDados[nA, 43], oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 3060 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), nLinIni + 1233 + nLinA4, nColIni + 3160 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 3070 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), "44 - "+STR0018, oFont01) //"UF"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 3080 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), aDados[nA, 44], oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 3165 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), nLinIni + 1233 + nLinA4, nColIni + 3372 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 3175 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), "45 - "+STR0024, oFont01) //"Código CBO S"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 3185 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), aDados[nA, 45, 1], oFont04)
		oPrint:Box(nLinIni + 1139 + nLinA4, nColIni + 3377 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), nLinIni + 1233 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1144 + nLinA4, nColIni + 3387 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), "45a - "+STR0083, oFont01) //"Grau de Participação"
		oPrint:Say(nLinIni + 1174 + nLinA4, nColIni + 3397 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2), aDados[nA, 45, 2], oFont04)
		
		oPrint:Say(nLinIni + 1238 + nLinA4, nColIni + 0010, STR0041, oFont01) //"Dados do Atendimento"
		oPrint:Box(nLinIni + 1268 + nLinA4, nColIni + 0010, nLinIni + 1362 + nLinA4, nColIni + 1185)
		oPrint:Say(nLinIni + 1273 + nLinA4, nColIni + 0020, "46 - "+STR0084, oFont01) //"Tipo Atendimento"
		oPrint:Line(nLinIni + 1298+ nLinA4, nColIni + 0030, nLinIni + 1348 + nLinA4, nColIni + 0030)
		oPrint:Line(nLinIni + 1348+ nLinA4, nColIni + 0030, nLinIni + 1348 + nLinA4, nColIni + 0087)
		oPrint:Line(nLinIni + 1298+ nLinA4, nColIni + 0087, nLinIni + 1348 + nLinA4, nColIni + 0087)
		oPrint:Say(nLinIni + 1303 + nLinA4, nColIni + 0043, aDados[nA, 46], oFont04)
		oPrint:Say(nLinIni + 1298 + nLinA4, nColIni + 0100, "01 - "+STR0085+"    "+"02 - "+STR0086+"    "+"03 - "+STR0087+"    "+"04 - "+STR0088+"    "+"05 - "+STR0089+"    "+"06 - "+STR0090, oFont01) //"Remoção"###"Pequena Cirurgia"###"Terapias"###"Consulta"###"Exame"###"Atendimento Domiciliar"
		oPrint:Say(nLinIni + 1328 + nLinA4, nColIni + 0100, "07 - "+STR0091+"    "+"08 - "+STR0092+"    "+"09 - "+STR0093+"    "+"10 - "+STR0094, oFont01) //"SADT Internado"###"Quimioterapia"###"Radioterapia"###"TRS-Terapia Renal Substitutiva"
		oPrint:Box(nLinIni + 1268 + nLinA4, nColIni + 1190, nLinIni + 1362 + nLinA4, nColIni + 2450 + nColA4/2)
		oPrint:Say(nLinIni + 1273 + nLinA4, nColIni + 1200, "47 - "+STR0033, oFont01) //"Indicação de Acidente"
		oPrint:Line(nLinIni + 1298+ nLinA4, nColIni + 1210, nLinIni + 1348 + nLinA4, nColIni + 1210)
		oPrint:Line(nLinIni + 1348+ nLinA4, nColIni + 1210, nLinIni + 1348 + nLinA4, nColIni + 1257)
		oPrint:Line(nLinIni + 1298+ nLinA4 , nColIni + 1257, nLinIni + 1348 + nLinA4, nColIni + 1257)
		oPrint:Say(nLinIni + 1303 + nLinA4, nColIni + 1223, aDados[nA, 47], oFont04)
		oPrint:Say(nLinIni + 1313 + nLinA4, nColIni + 1270, "0 - "+STR0034+"   "+"1 - "+STR0035+"   "+"2 - "+STR0036, oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"
		oPrint:Box(nLinIni + 1268 + nLinA4, nColIni + 2455 + nColA4/2, nLinIni + 1362 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1273 + nLinA4, nColIni + 2465 + nColA4/2, "48 - "+STR0050, oFont01) //"Tipo de Saída"
		oPrint:Line(nLinIni + 1298+ nLinA4 , nColIni + 2475 + nColA4/2, nLinIni + 1348 + nLinA4, nColIni + 2475 + nColA4/2)
		oPrint:Line(nLinIni + 1348+ nLinA4, nColIni + 2475 + nColA4/2, nLinIni + 1348 + nLinA4, nColIni + 2522 + nColA4/2)
		oPrint:Line(nLinIni + 1298+ nLinA4 , nColIni + 2522 + nColA4/2, nLinIni + 1348 + nLinA4, nColIni + 2522 + nColA4/2)
		oPrint:Say(nLinIni + 1303 + nLinA4, nColIni + 2488 + nColA4/2, aDados[nA, 48], oFont04)
		oPrint:Say(nLinIni + 1313 + nLinA4, nColIni + 2535 + nColA4/2, "1 - "+STR0051+"    "+"2 - "+STR0052+"    "+"3 - "+STR0053+"    "+"4 - "+STR0054+"    "+"5 - "+STR0055+"    "+"6 - "+STR0095, oFont01) //"Retorno"###"Retorno SADT"###"Referência"###"Internação"###"Alta"###"Óbito"
		
		oPrint:Say(nLinIni + 1367 + nLinA4, nColIni + 0010, STR0096, oFont01) //"Consulta Referência"
		oPrint:Box(nLinIni + 1397 + nLinA4, nColIni + 0010, nLinIni + 1491 + nLinA4, nColIni + 0315)
		oPrint:Say(nLinIni + 1402 + nLinA4, nColIni + 0020, "49 - "+STR0026, oFont01) //"Tipo de Doença"
		oPrint:Line(nLinIni + 1427 + nLinA4 , nColIni + 0030, nLinIni + 1477 + nLinA4, nColIni + 0030)
		oPrint:Line(nLinIni + 1477 + nLinA4, nColIni + 0030, nLinIni + 1477 + nLinA4, nColIni + 0077)
		oPrint:Line(nLinIni + 1427 + nLinA4 , nColIni + 0077, nLinIni + 1477 + nLinA4, nColIni + 0077)
		oPrint:Say(nLinIni + 1432  + nLinA4, nColIni + 0043, aDados[nA, 49], oFont04)
		oPrint:Say(nLinIni + 1442  + nLinA4, nColIni + 0090, STR0027+"    "+STR0028, oFont01) //"A-Aguda"###"C-Crônica"
		oPrint:Box(nLinIni + 1397  + nLinA4, nColIni + 0320, nLinIni + 1491 + nLinA4, nColIni + 0770)
		oPrint:Say(nLinIni + 1402  + nLinA4, nColIni + 0330, "50 - "+STR0029, oFont01) //"Tempo de Doença"
		oPrint:Line(nLinIni + 1427 + nLinA4 , nColIni + 0340, nLinIni + 1477 + nLinA4, nColIni + 0340)
		oPrint:Line(nLinIni + 1477 + nLinA4, nColIni + 0340, nLinIni + 1477 + nLinA4, nColIni + 0426)
		oPrint:Line(nLinIni + 1427 + nLinA4 , nColIni + 0426, nLinIni + 1477 + nLinA4, nColIni + 0426)
		If aDados[nA,50,1] > 0
			oPrint:Say(nLinIni + 1432 + nLinA4, nColIni + 0353, IIF((StrZero(aDados[nA, 50,1], 2, 0))=="00","",(StrZero(aDados[nA, 50,1], 2, 0))), oFont04)
		Endif
		oPrint:Say(nLinIni + 1442 + nLinA4, nColIni + 0434, "-", oFont01)
		oPrint:Line(nLinIni+ 1427 + nLinA4 , nColIni + 0447, nLinIni + 1477 + nLinA4, nColIni + 0447)
		oPrint:Line(nLinIni+ 1477 + nLinA4, nColIni + 0447, nLinIni  + 1477 + nLinA4, nColIni + 0494)
		oPrint:Line(nLinIni+ 1427 + nLinA4 , nColIni + 0494, nLinIni + 1477 + nLinA4, nColIni + 0494)
		oPrint:Say(nLinIni + 1432 + nLinA4, nColIni + 0457, aDados[nA, 50,2], oFont04)
		oPrint:Say(nLinIni + 1442 + nLinA4, nColIni + 0510, STR0030+"  "+STR0031+"  "+STR0032, oFont01) //"A-Anos"###"M-Meses"###"D-Dias"
		
		oPrint:Say(nLinIni + 1496 + nLinA4, nColIni + 0010, STR0097, oFont01) //"Procedimentos e Exames realizados"
		oPrint:Box(nLinIni + 1526 + nLinA4, nColIni + 0010, nLinIni + 1766 + nLinA4, nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0020, "51 - "+STR0098, oFont01) //"Data"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0210, "52 - "+STR0099, oFont01) //"Hora Inicial"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0380, "53 - "+STR0100, oFont01) //"Hora Final"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0540, "54 - "+STR0074, oFont01) //"Tabela"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0660, "55 - "+STR0075, oFont01) //"Código do Procedimento"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 0940, "56 - "+STR0076, oFont01) //"Descrição"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 2825 + nColA4, "57 - "+STR0101, oFont01,,,,1) //"Qtde."
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 2855 + nColA4, "58 - "+STR0102, oFont01) //"Via"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 2945 + nColA4, "59 - "+STR0103, oFont01) //"Tec."
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 3230 + nColA4, "60 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 3465 + nColA4, "61 - "+STR0105, oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say(nLinIni + 1531 + nLinA4, nColIni + 3675 + nColA4, "62 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"
		
		nOldLinIni := nLinIni
		
		If nVolta == 1
			nV1:=1
		Endif
		
		For nP1 := nV1 To nT1
			if nVolta <> 1
				nN := nP1-((5*nVolta)-5)
				oPrint:Say(nLinIni + 1566 + nLinA4, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say(nLinIni + 1566 + nLinA4, nColIni + 0020, AllTrim(Str(nP1)) + " - ", oFont01)
			endif
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0065, IIf(Empty(aDados[nA, 51, nP1]), "", DtoC(aDados[nA, 51, nP1])), oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0210, IIf(Empty(aDados[nA, 52, nP1]), "", Transform(aDados[nA, 52, nP1], "@R 99:99")), oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0380, IIf(Empty(aDados[nA, 53, nP1]), "", Transform(aDados[nA, 53, nP1], "@R 99:99")), oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0540, aDados[nA, 54, nP1], oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0660, aDados[nA, 55, nP1], oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 0940, aDados[nA, 56, nP1], oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 2825 + nColA4, IIf(Empty(aDados[nA, 57, nP1]), "", Transform(aDados[nA, 57, nP1], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 2855 + nColA4, aDados[nA, 58, nP1], oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 2945 + nColA4, aDados[nA, 59, nP1], oFont04)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 3230 + nColA4, IIf(Empty(aDados[nA, 60, nP1]), "", Transform(aDados[nA, 60, nP1], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 3465 + nColA4, IIf(Empty(aDados[nA, 61, nP1]), "", Transform(aDados[nA, 61, nP1], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1561 + nLinA4, nColIni + 3675 + nColA4, IIf(Empty(aDados[nA, 62, nP1]), "", Transform(aDados[nA, 62, nP1], "@E 99,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP1
		
		If nT1 < Len(aDados[nA, 55]) .or. lImpnovo
			nV1:=nP1
			lImpnovo:=.T.
		Endif
		
		nLinIni := nOldLinIni
		
		oPrint:Box(nLinIni + 1771 + nLinA4, nColIni + 0010, nLinIni + 1971 + (2*nLinA4), nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1776 + nLinA4, nColIni + 0020, "63 - "+STR0107, oFont01) //"Data e Assinatura de Procedimentos em Série"
		
		nOldColIni := nColIni
		
		if nVolta=1
			nV2:=1
		Endif
		
		For nP2 := nV2 To nT2 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say(nLinIni + 1841 + nLinA4, nColIni + 0030, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say(nLinIni + 1841 + nLinA4, nColIni + 0030, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say(nLinIni + 1836 + nLinA4, nColIni + 0070 , DtoC(aDados[nA, 63, nP2]), oFont04)
			oPrint:Line(nLinIni + 1861 + nLinA4, nColIni + 0210, nLinIni + 1861 + nLinA4, nColIni + 0747 + nColSoma2)
			nColIni += 670
		Next nP2
		
		nColIni := nOldColIni
		
		nOldColIni := nColIni
		
		if nVolta=1
			nV2:=1
		Endif
		
		For nP2 := nV2+1 To nT2+1 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say(nLinIni + 1925 + (2*nLinA4), nColIni + 0030, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say(nLinIni + 1925 + (2*nLinA4), nColIni + 0030, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say(nLinIni + 1920 + (2*nLinA4), nColIni + 0070, DtoC(aDados[nA, 63, nP2]), oFont04)
			oPrint:Line(nLinIni + 1945 + (2*nLinA4), nColIni + 0210, nLinIni + 1945 + (2*nLinA4), nColIni + 0747 + nColSoma2)
			nColIni += 670
		Next nP2
		
		nColIni := nOldColIni
		
		if nT2 < Len(aDados[nA, 63]).or. lImpnovo
			nV2:=nP2-1
			lImpnovo:=.T.
		Endif
		
		oPrint:Box(nLinIni + 1976 + (2*nLinA4), nColIni + 0010, nLinIni + 2176 + (3*nLinA4), nColIni + 3755 + nColA4)
		oPrint:Say(nLinIni + 1981 + (2*nLinA4), nColIni + 0020, "64 - "+STR0056, oFont01) //"Observação"
		
		If nModulo == 51    //Gestão Hospitalar
			if nVolta=1
				nV1:=1
			Endif
			
			nLin := 1988
			For nP1 := nV1 To nT1
				if nVolta <> 1
					nN:=nP1-((5*nVolta)-5)
					oPrint:Say(nLinIni + nLin + nLinA4, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say(nLinIni + nLin + nLinA4, nColIni + 0020, AllTrim(Str(nP1)) + " - ", oFont01)
				endif
				oPrint:Say(nLinIni + nLin + nLinA4, nColIni + 0065, aDados[nA, 64, nP1], oFont04)
				
				nLin += 35
			Next nP1
			
			if nT1 < Len(aDados[nA, 64]).or. lImpnovo
				nV1:=nP1
				lImpnovo:=.T.
			Endif
		Else
			nLin := 2011
			
			For nI := 1 To MlCount(aDados[nA, 64], 130)
				cObs := MemoLine(aDados[nA, 64], 130, nI)
				oPrint:Say(nLinIni + nLin + (2*nLinA4), nColIni + 0030, cObs, oFont04)
				nLin += 35
			Next nI
			
		Endif
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 0010, nLinIni + 2275 + (4*nLinA4), nColIni + 0591 + (nColA4/7) )
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 0020, "65 - "+STR0108, oFont01) //"Total Procedimentos R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 0566 + (nColA4/7), Transform(aDados[nA, 65,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 0596 + (nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 1117 + 2*(nColA4/7))
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 0606 + (nColA4/7), "66 - "+STR0109, oFont01) //"Total Taxas e Aluguéis R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 1092 + 2*(nColA4/7), Transform(aDados[nA, 66,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 1122 + 2*(nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 1643  + 3*(nColA4/7))
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 1132 + 2*(nColA4/7), "67 - "+STR0110, oFont01) //"Total Materiais R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 1618 + 3*(nColA4/7), Transform(aDados[nA, 67,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 1648 + 3*(nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 2169 + 4*(nColA4/7) )
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 1658 + 3*(nColA4/7), "68 - "+STR0111, oFont01) //"Total Medicamentos R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 2144 + 4*(nColA4/7), Transform(aDados[nA, 68,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 2174 + 4*(nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 2695 + 5*(nColA4/7) )
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 2184 + 4*(nColA4/7), "69 - "+STR0112, oFont01) //"Total Diárias R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 2670 + 5*(nColA4/7), Transform(aDados[nA, 69,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 2700 + 5*(nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 3221 + 6*(nColA4/7) )
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 2710 + 5*(nColA4/7), "70 - "+STR0113, oFont01) //"Total Gases Medicinais R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 3196 + 6*(nColA4/7), Transform(aDados[nA, 70,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 2181 + (3*nLinA4), nColIni + 3226 + 6*(nColA4/7), nLinIni + 2275 + (4*nLinA4), nColIni + 3755  + 7*(nColA4/7))
		oPrint:Say(nLinIni + 2186 + (3*nLinA4), nColIni + 3236 + 6*(nColA4/7), "71 - "+STR0114, oFont01) //"Total Geral da Guia R$"
		oPrint:Say(nLinIni + 2216 + (3*nLinA4), nColIni + 3735 + 7*(nColA4/7), Transform(aDados[nA, 71,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		
		
		oPrint:Box(nLinIni + 2280 + (4*nLinA4), nColIni + 0010, nLinIni + 2425 + (6*nLinA4), nColIni + 0986 + (nColA4/4) )
		oPrint:Say(nLinIni + 2285 + (4*nLinA4), nColIni + 0020 , "86 - "+STR0115, oFont01) //"Data e Assinatura do Solicitante"
		oPrint:Say(nLinIni + 2315 + (4*nLinA4), nColIni + 0030 , DtoC(aDados[nA, 86]), oFont04)
		oPrint:Box(nLinIni + 2280 + (4*nLinA4), nColIni + 0991  + (nColA4/4), nLinIni + 2425 + (6*nLinA4), nColIni + 1907 + 2*(nColA4/4) )
		oPrint:Say(nLinIni + 2285 + (4*nLinA4), nColIni + 1001  + (nColA4/4), "87 - "+STR0116, oFont01) //"Data e Assinatura do Responsável pela Autorização"
		oPrint:Say(nLinIni + 2315 + (4*nLinA4), nColIni + 1011  + (nColA4/4), DtoC(aDados[nA, 87]), oFont04)
		oPrint:Box(nLinIni + 2280 + (4*nLinA4), nColIni + 1912  + 2*(nColA4/4), nLinIni + 2425 + (6*nLinA4), nColIni + 2828 + 3*(nColA4/4) )
		oPrint:Say(nLinIni + 2285 + (4*nLinA4), nColIni + 1922  + 2*(nColA4/4), "88 - "+STR0058, oFont01) //"Data e Assinatura do Beneficiário ou Responsável"
		oPrint:Say(nLinIni + 2315 + (4*nLinA4), nColIni + 1932  + 2*(nColA4/4), DtoC(aDados[nA, 88]), oFont04)
		oPrint:Box(nLinIni + 2280 + (4*nLinA4), nColIni + 2833  + 3*(nColA4/4), nLinIni + 2425 + (6*nLinA4), nColIni + 3755 + 4*(nColA4/4) )
		oPrint:Say(nLinIni + 2285 + (4*nLinA4), nColIni + 2843  + 3*(nColA4/4), "89 - "+STR0117, oFont01) //"Data e Assinatura do Prestador Executante"
		oPrint:Say(nLinIni + 2315 + (4*nLinA4), nColIni + 2853  + 3*(nColA4/4), DtoC(aDados[nA, 89]), oFont04)
		
		oPrint:EndPage()	// Finaliza a pagina
	Enddo
	
Next nY
Next 

If lGerTXT
	oPrint:Print()		// Imprime Relatorio
Else
	oPrint:Preview()	// Visualiza impressao grafica antes de imprimir
EndIf

Return
