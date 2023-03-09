#include "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSRINT ³ Autor ³ DAVID DE OLIVEIRA      ³ Data ³ 08.08.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ RELATÓRIO DE MOVIMENTAÇÃO DE INTERCAMBIO                   ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSRINT()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes feitas pelo LSOUZA em 21/06/2006                           ³±±±
±±³ Alterado Perguntas/Respostas :: Apenas a Descricao                    ³±±±
±±³ Colocado o NroDeImpresso no relatorio, solicitado pela Andreia (SRP)  ³±±±
±±³ Alterado para pegar o Codigo da Unimed, qdo for Unimed, na coluna RDA ³±±±
±±³ Ajustado o Cabecalho                                                  ³±±±
±±³ Alterado a funcao PLSCRIGEN :: Linha 164                              ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSRINT()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private xCri := {}
PRIVATE lGerTxt   := .F.
Private cRelDir   := GetMv("MV_RELT") 
PRIVATE nQtdLin
PRIVATE cNomeProg   := "PLSRINT"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Movimentação"
PRIVATE cTitDem     := "Relatorio de Movimentação"
PRIVATE cTpPrest    := "Relatorio de Atendimento de Intercambio e SRP"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "PLRINT"
PRIVATE nRel        := "PLSRINT"
PRIVATE m_pag       := 0
PRIVATE lCompres    := .T.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "Zebrado", 2,"Administração", 1, 2, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1
PRIVATE cCabec2
PRIVATE nColuna     := 00
PRIVATE nLi         := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTipoImp
PRIVATE nTipoRel
PRIVATE nTipoDad
PRIVATE cCodOpe
PRIVATE cOpeDe
PRIVATE cOpeAte
PRIVATE cGrpDe
PRIVATE cGrpAte               
PRIVATE cCtrDe
PRIVATE cCtrAte
PRIVATE cSubDe
PRIVATE cSubAte
PRIVATE cMatrDe
PRIVATE cMatrAte
PRIVATE cMesDe    
PRIVATE cAnoDe
PRIVATE cMesAte    
PRIVATE cAnoAte
PRIVATE nFase
PRIVATE nResumo           
PRIVATE __pMoeda    := "@E 999,999.99"
PRIVATE cQuebLDP
PRIVATE cQuebPEG
PRIVATE cQuebGUI
PRIVATE cImprCan
Private nSomNCob
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de mascara (picture)                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE pMoeda      := "@E 99,999,999.99"

CriaSX1() //nova pergunta...
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRel := SetPrint(cAlias,nRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrderns,.T.,cTamanho,,.F.)//SetPrint(cAlias,nRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal,,lGerTXT)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
   Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
                                                                                                                                                                                            
//carrega variaveis com os parametros
nTipoImp  := mv_par01
nTipoRel  := mv_par02
nTipoDad  := mv_par03
cCodOpe	  := mv_par04
cOpeDe	  := mv_par05
cOpeAte   := mv_par06
cGrpDe	  := mv_par07
cGrpAte	  := mv_par08
cCtrDe	  := mv_par09
cCtrAte   := mv_par10
cSubDe    := mv_par11
cSubAte   := mv_par12
cMatrDe   := mv_par13
cMatrAte  := mv_par14
cMesDe	  := mv_par15    
cAnoDe	  := mv_par16
cMesAte	  := mv_par17    
cAnoAte	  := mv_par18
nFase	  := mv_par19
cGrpOpDe  := mv_par20
cGrpOpAte := mv_par21
nOrd	  := mv_par22
cCodpad	  := mv_par23
cProcDe	  := mv_par24
cProcAte  := mv_par25
cImprCan  := mv_par26
nSomNCob  := mv_par27
cGrpCob   := mv_par28
dDtDe	  := mv_par29
dDtAte    := mv_par30
nQbrPr	  := mv_par31                        
dDtMovDe  := mv_par32
dDtMovAte := mv_par33
cNumTit   := mv_par34
nPercIns  := mv_par35

if nPercIns > 0 
	cCabec1     := "NRO IMPRESSO      PEG-GUIA-LOC DG        CODIGO                NOME                       DT PROC  RDA       QTD CODIGO  AMB   DESC                    Valor CH   TP   Quantid.          TAX        VLR      TOTAL  Vlr.INSS" 
Else
	cCabec1     := "NRO IMPRESSO      PEG-GUIA-LOC DG        CODIGO                NOME                       DT PROC  RDA       QTD CODIGO  AMB   DESC                    Valor CH   TP   Quantid.          TAX        VLR      TOTAL" 	
Endif	
cCabec2     := "NRO IMPRESSO      PEG-GUIA-LOC DG        CODIGO                NOME                       DT PROC  RDA       QTD     CODIGO    DESC                 TAX      FILME     TOTAL"

if nQbrPr == 2
	nOrd := 1
Endif
           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Limite de linhas                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipoImp == 1
   nQtdLin := 48
   @nLi,0 PSAY AvalImp(nLimite)
Else
   nQtdLin := 58
   @nLi,0 PSAY Chr(15)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lGerTXT
	SetPrintFile(nrel)
EndIF
SetDefault(aReturn,cAlias)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lGerTxt
    RIntImp()
Else
    MsAguarde({|| RIntImp() }, cTitulo, "", .T.)
Endif    
If Len(xCri) > 0
	PLSCRIGEN(xCri,{ {" Procedimento ","@C",50}, {" Composição ","@C",40},{" Tipo RDA ","@C",30},{" Problema ","@C",50}}, " Critica ") 
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera filtro feito no arquivo BD7...                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ms_flush()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ RIntImp  ³ Autor ³ DAVID DE OLIVEIRA     ³ Data ³ 08.08.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ RELATÓRIO DE MOVIMENTAÇÃO DE INTERECAMBIO        .         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RIntImp()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ IndRegua...                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL   cSQL   
Local   cCodPro     := ""
LOCAL   nVlrTotGui  := 0
LOCAL   nVlrGuiaTot := 0
LOCAL   nVlrTotNot  := 0
LOCAL   nVlrTotTax  := 0
LOCAL   nITens      := 0
LOCAL   aGuiasImp   := {}
Local 	nVlrRef     := 0
Local   nVlrGRef    := 0
Local 	nVlrPRef    := 0
Local 	nVlrTotPro  := 0
Local   aProcImp    := {}
Local   lListaCab := .F., lFirst := .T.
Local 	nTotRec
Local 	nQtdRec
Local   nQtdePro := 1
PRIVATE   nVlrItem	    := 0   
PRIVATE   nVlrTax		:= 0       
PRIVATE   cBloq	
Private   nVlrBloq		:= 0
PRIVATE   nVlrFil		:= 0
PRIVATE   aResumo     := {}
PRIVATE   cLast    := ""
PRIVATE   cLastGui    := ""
PRIVATE	  cLastFam    := ""
PRIVATE   cInicio     := ""
PRIVATE   nlinha	:= 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Controle de Glosas...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aGlosas     := {}
PRIVATE lGlosou     := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtd        := 0
PRIVATE nVlrGlo     := 0
PRIVATE nVlrPag     := 0
PRIVATE nVlrTot     := 0
PRIVATE nVlrIRF     := 0
PRIVATE cQuebOp     := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ variaveis de trabalho...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cNomUsr    //Nome do usuario que fez o procedimento...                          
PRIVATE cNomOp     //Nome da Operadora...
PRIVATE cMovime    //Codigo do movimento
PRIVATE cMatUsr
PRIVATE cUsu

PRIVATE nAux := 0
PRIVATE cMatMed
PRIVATE cProcedi
PRIVATE cCopartic := ""

private cCodRda := ""
private cNroImpresso := "" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe mensagem...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If  ! lGerTxt
    MsProcTxt("Selecionando Dados")
Endif    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo)+space(01)+Iif(nTiporel=1,"Intercambio","SRP")//+" - "+PLRETMES(Val(cMes))+"/"+cAno
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Ordens Default...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(DbSetOrder(2))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Regra para Definição de Ano / Mes de apuração                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If cAnoDe <> cAnoAte .and. cMesAte = '01'
//   cAnoAte := str(val(cAnoAte)-1,4)
//   cMesAte := '12'              
//Else
//   cMesAte := strzero(val(cMesAte)-1,2)
//EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona as pegs a serem impressas
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT BD6_CODOPE, BD6_OPEORI, BD6_NOMUSR, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_CODPAD, BD6_CODPRO, BD6_VLRPF, BD6_VLRTAD, BD6_BLOCPA, "
cSQL += "BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO ,BD6_MATUSA, BD6_DATPRO, BD6_ORIMOV, BD6_CODRDA, BD6_QTDPRO, "
cSQL += "BD6_VLRTPF, BD6_VLRBPF, BD6_TPPF, BD6_ANOPAG, BD6_MESPAG, BD6_SEQUEN, BD6_MATANT,BD6_PERVIA "
cSQL += "FROM "+RetSQLName("BD6")+IIF(!Empty(cGrpCob),", "+RetSQLName("BQC"),"")+" WHERE "
cSQL += "BD6_FILIAL = '"+xFilial("BD6")+"' AND "
cSQL += "BD6_CODOPE BETWEEN '    ' AND 'ZZZZ' AND "
cSQL += "BD6_CODLDP BETWEEN '    ' AND 'ZZZZ' AND "
cSQL += "BD6_CODPAD||BD6_CODPRO BETWEEN '"+cCodPad+cProcDe+"' AND '"+cCodPad+cProcAte+"' AND "
If !Empty(cGrpCob) // Imprime Somente Guias do Grupo de Cobranca
	// indice 9 do BD6 --> BD6_FILIAL + BD6_OPEUSR + BD6_CODEMP + BD6_ANOPAG + BD6_MESPAG + BD6_CONEMP + BD6_VERCON + BD6_SUBCON + BD6_VERSUB
	// indice 1 do BQC --> BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
	cSQL += "BQC_FILIAL = '" + xFilial("BQC") + "' AND "
	cSQL += "BQC_CODIGO = BD6_OPEUSR || BD6_CODEMP AND "
	cSQL += "BQC_NUMCON = BD6_CONEMP AND "
	cSQL += "BQC_VERCON = BD6_VERCON AND "
	cSQL += "BQC_SUBCON = BD6_SUBCON AND "
	cSQL += "BQC_VERSUB = BD6_VERSUB AND "
	cSQL += "BD6_OPEUSR = '" + PLSIntPad() + "' AND "
	cSQL += "BQC_GRPCOB = '" + cGrpCob + "' AND "
	cSQL += "BD6_BLOCPA <> '1' AND "
Endif

if cImprCan == 1 // Imprime Somente Guias Ativas
	cSQL += "BD6_SITUAC = '1' AND "
Endif	
If nTipoRel == 1
	cSQL += "BD6_OPEORI >= '"+cOpeDe+"' AND BD6_OPEORI <= '"+cOpeAte+"' AND "
	cSQL += "BD6_INTERC = '1' AND "
	cSQL += "BD6_OPEORI <> '"+cCodOpe+"' AND "
	//cSQL += "BD6_CODPLA = 'INTC' AND "
Else
	cSQL += "BD6_CODEMP BETWEEN '"+cGrpDe+"' AND '"+cGrpAte+"' AND "
	cSQL += "BD6_CONEMP BETWEEN '"+cCtrDe+"' AND '"+cCtrAte+"' AND "
	cSQL += "BD6_SUBCON BETWEEN '"+cSubDe+"' AND '"+cSubAte+"' AND "
	cSQL += "BD6_MATRIC BETWEEN '"+cMatrDe+"' AND '"+cMatrAte+"' AND "
	//cSQL += "BD6_CODPLA = 'SRP' AND " 
EndIf
cSQL += "BD6_ANOPAG||BD6_MESPAG BETWEEN '"+cAnoDe+cMesDe+"' AND '"+cAnoAte+cMesAte+"' AND "
If nFase == 1 //Digitação
   cSQL += "BD6_FASE = '1' AND "
ElseIf nFase == 2 //Conferencia
   cSQL += "BD6_FASE = '2' AND "   
ElseIf nFase == 3 //Pronta  
   cSQL += "BD6_FASE = '3'  AND "
ElseIf nFase == 4 // Pronta e Faturada
  //cSQL += "(BD6_FASE = '3' OR BD6_FASE = '4') AND " //cSQL += "BD6_SEQPF <> '      ' AND "
   	cSQL += "BD6_FASE = '4' AND " //cSQL += "BD6_SEQPF <> '      ' AND " Nelson em 06/06/07 lista somente as que ja foram pagas 
EndIF                                         

if !Empty(cNumTit)
	cSQL += "BD6_NUMSE1 = '"+cNumTit+"' AND "
Else
	If nSomNCob == 1 // Somente Nao Cobradas
	   cSQL += "BD6_NUMSE1 = '             ' AND "
	ElseIf nSomNCob == 2 // Somente Cobradas
	   cSQL += "BD6_NUMSE1 > '             ' AND "
	Endif   
Endif	

if !dtoc(dDtAte) == "  /  /  "
	cSQL += " BD6_DTDIGI >= '"+dtos(dDtDe)+"' AND "
	cSQL += " BD6_DTDIGI <= '"+dtos(dDtAte)+"' AND "
Endif

if !dtoc(dDtMovAte) == "  /  /  "
	cSQL += " BD6_DATPRO >= '"+dtos(dDtMovDe)+"' AND "
	cSQL += " BD6_DATPRO <= '"+dtos(dDtMovAte)+"' AND "
Endif

cSQL += "BD6_BLOCPA <> '1' AND "
cSQL += RetSQLName("BD6")+".D_E_L_E_T_ = ' ' "
If nTipoRel == 1
   Do Case
   		Case nOrd = 1 
   			cSQL += "ORDER BY BD6_OPEORI, BD6_MATANT "
   		Case nOrd = 2
   			cSQL += "ORDER BY BD6_OPEORI, BD6_NOMUSR "
   		Case nord = 3
   			cSQL += "ORDER BY BD6_OPEORI, BD6_CODPEG, BD6_NUMERO "
   		Case nord = 4
   			cSQL += "ORDER BY BD6_OPEORI, BD6_NUMIMP "
   EndCase
Else
   Do Case
   		Case nOrd = 1  
         	cSQL += "ORDER BY BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO  "
     	Case nOrd = 2
			cSQL += "ORDER BY BD6_CODEMP, BD6_NOMUSR  "
		Case nord = 3
			cSQL += "ORDER BY BD6_CODEMP, BD6_CODPEG, BD6_NUMERO  "
	EndCase
EndIf

PLSQUERY(cSQL,"TrbOp")

nTotRec := TrbOp->(RECCount())
nQtdRec	:= 0
MsProcTxt("Gerando Relatório")

//COMPOSIÇÃO DOS EVENTOS
DbSelectArea("BD7")
BD7->(DbSetOrder(1))
//PRESTADORES
DbSelectArea("BAU")
BAU->(DbSetOrder(1)) 
//OPERADORAS
DbSelectArea("BA0")
BA0->(DbSetOrder(1))
//Arquivo de Faturamento
DbSelectArea("BDH")
BDH->(DbSetOrder(1))

//Monta Resumo do Final da Página Zerado

aadd(aResumo,{"Serviços Médicos",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Meios Proprios  ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Unimed          ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Hospitais       ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Laboratorios    ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Clinicas        ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Unimed          ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Outros Atos     ",0,0,0,0,0,0,0,0,0,0,0})
aadd(aResumo,{"Total           ",0,0,0,0,0,0,0,0,0,0,0})
@nLi,0 PSAY Chr(15)
lPrimUFm := .T.
While !TrbOp->(Eof())
    nQtdRec++
    MsProcTxt("Guia "+strZero(nQtdRec,6))
    
//	BA3->( DbSetOrder(1) )		// BA3_FILIAL + BA3_CODINT + BA3_CODEMP + BA3_MATRIC + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB
//	BA3->( MsSeek(xFilial("BA3")+TRBOP->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)) )
	
//	BQC->( DbSetOrder(1) )		// BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
// 	BQC->( MsSeek(xFilial("BQC")+BA3->(BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB)) )
	
//	If BQC->BQC_GRPCOB <> cGrpCob
//		TRBOP->( DbSkip() )
//		Loop
//	Endif
	
    //zera vaiaveis para nova guia
	cQueb	      := Iif(nTipoRel==1,TrbOp->BD6_OPEORI,TrbOp->BD6_CODEMP)
    nVlrTotGui  := 0
	//nVlrTotNot  := 0
	nITens      := 0
	nVlrRef     := 0
	nVlrItem	:= 0
	nVlrtax		:= 0
	nVlrGRef    := 0
	nVlrPRef    := 0
	nVlrTotPro  := 0
	nQtd        := 0
	nVlrPag     := 0
	nVlrTot     := 0
	cBloq		:= TRBOP->BD6_BLOCPA
    /*
    //Verifica se a guia já esta faturada para o usuário no BDH
    If  (nFase == 4 .AND.;
    	BDH->(MsSeek(xFilial("BDH")+TRBOP->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_ANOPAG+BD6_MESPAG))) .AND.;
    	BDH->BDH_STATUS = '1') .OR.;
    	(nFase == 4 .AND.;
    	!BDH->(MsSeek(xFilial("BDH")+TRBOP->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_ANOPAG+BD6_MESPAG)))) .OR.;
    	(nFase == 3 .AND.;
        BDH->(MsSeek(xFilial("BDH")+TRBOP->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_ANOPAG+BD6_MESPAG))) .AND.;
        BDH->BDH_STATUS = '0')
        
        TRBOP->(DbSkip())          
	    Loop
	
    EndIf
    */
    If nTipoRel == 1 .AND.;
       BA0->(MsSeek(xFilial("BA0")+TRBOP->BD6_OPEORI)) .AND.;
       (BA0->BA0_GRUOPE < cGrpOpDe .AND. cGrpOpAte < BA0->BA0_GRUOPE)
	   
	   TRBOP->(DbSkip())
	   Loop
	
	EndIf
		
    If nTipoDad == 1//impressão de dados em modo analitico
        //posiciona no primeiro item da composição desse procedimento
	    If BD7->(MsSeek(xFilial("BD7")+"0055"+TRBOP->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
	    	BAU->(MsSeek(xFilial("BAU")+BD7->BD7_CODRDA))
	    	PrtCab   := .F.        
	        cQuebLDP := BD7->BD7_CODLDP
	        cQuebPEG := BD7->BD7_CODPEG
	        cQuebGUI := BD7->BD7_NUMERO
	        cCodPro  := BD7->(BD7_CODPAD+BD7_CODPRO)
			cOrimov	 := BD7->BD7_ORIMOV
			cSequen	 := BD7->BD7_SEQUEN
			     
			// --			
			// -- Solicitado pela Andreia (SRP) - 21/06/2006
			// -- Solicitado pela Andreia (SRP) - 28/05/2007 Sera exibido o BAU->BAU_CODIGO da RDA e nao mais o BAU->BAU_CONREG
			// -- Solicitado pela Andreia (SRP) - 12/06/2007 Operadora nao devera aparecer o codigo da operadora e sim o da RDA da operadora
			//cCodRda  := strzero( val( if( BAU->BAU_TIPPRE == "UNI", BAU->BAU_CODOPE, BAU->BAU_CODIGO ) ), 10 )
			cCodRda  := strzero(val(BAU->BAU_CODIGO), 10 )
			
	        lFirst := .T.
	        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	        //³ Inicia a quebra por Peg...                                   ³
	        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	        While ! BD7->(Eof()) .And. BD7->(BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO+BD7->BD7_ORIMOV+BD7_SEQUEN) ==;//BD7->(BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO+BD7_CODPAD+BD7_CODPRO) ==;
	        						   cQuebLDP+cQuebPEG+cQuebGUI+cOrimov+cSequen
				lTemBD7 	:= .F.
	      		lListaCab 	:= .F.       	
	      		nVlrItem	:= 0
				nVlrtax		:= 0
	        	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Verifica se foi abortada a impressao...                            ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            If Interrupcao(lAbortPrint) 
	               nLi ++
	               @ nLi, nColuna pSay "***ABORTADO PELO USUÁRIO***"
	               Exit
	            Endif
			 	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Verifica quebra...                                                 ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            If cQueb <> cLast .and. !empty(cLast) 
	                   RIntImpr_Resumo(aResumo,nVlrbloq)
	                   RIntPag(.T., cTitulo, .F., .T.,aResumo)
	            Else
	              //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	              //³ Imprime cabecalho...                                                     ³
	              //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	              RIntPag(.F., cTitulo, .F., .F.,aResumo)
	            Endif
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Exibe mensagem...                                                  ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            If  ! lGerTxt
	                MsProcTXT("Movimentacao "+BD7->(BD7_ANOPAG+"."+BD7_MESPAG+"-"+BD7_NUMERO))
	            Endif
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Busca nome do usuario do item posicionado...                       ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            BA1->(DbSetOrder(2))
	            If BA1->(DbSeek(xFilial("BA1")+TRBOP->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
	               cNomUsr := Subs(TRBOP->BD6_NOMUSR,1,25)//Subs(BA1->BA1_NOMUSR,1,25)
	            Else
	               cNomUsr := Space(25)
	            Endif
	            cMatUsr := IF(TRBOP->BD6_MATUSA=="1".and.BA1->BA1_CODINT==BA1->BA1_OPEORI,BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"-"+BA1_TIPREG+"-"+BA1_DIGITO),Subs(BA1->BA1_MATANT,1,17)+Space(04))
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Monta numero da movimentacao...                                    ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        cMovime      := BD7->BD7_CODPEG+"-"+BD7->BD7_NUMERO+"-"+BD7->BD7_CODLDP		        
		        
		        //--
 		        //-- Nro do Impresso, solicitado pela Andreia. 21-06-2006
		        //-- 
		        cNumGui      := BD7->BD7_NUMERO
		        cNroImpresso := BD7->BD7_NUMIMP
	                        
	            If TRBOP->BD6_TPPF = '1'
	            	nVlrItem := BD7->BD7_VLRBPF
	            Else
	            	nVlrItem := BD7->BD7_VLRTPF - BD7->BD7_VLRTAD
	            EndIf
				
   			    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		        //³ Posiciona BR8-Tabela Padrao                                              ³
		        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        If  BR8->(BR8_CODPAD+BR8_CODPSA) <> BD7->(BD7_CODPAD+BD7_CODPRO) 
		            BR8->(msSeek(xFilial("BR8")+BD7->(BD7_CODPAD+BD7_CODPRO)))
		        Endif 
		        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		        //³ Posiciona BD6-Item da Guia NELSON EM 28/05/07 PQ O BD6 ESTAVA VINDO DESPOSICIONADO ³
		        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        BD6->(DbSelectArea("BD6"))
            	BD6->(DbSetOrder(1))
	            BD6->(MsSeek(xFilial("BD6")+BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO )))
	            
	            
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		        //³ Posiciona BD4-composicao do procedimento se a tabela do BD6 for de intercambio     ³ //nelson 29/05/07 solicitado andreia 
		        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            nValRef := 0
	            cUnid   := " "
	            BD4->(DbSelectArea("BD4"))
            	BD4->(DbSetOrder(1))
	            If BD4->(MsSeek(xFilial("BD4")+"0055001"+BD7->(BD7_CODPAD+BD7_CODPRO+BD7_CODUNC)))
	               nValRef := BD4->BD4_VALREF   
	               //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		           //³ Posiciona BD3- Unidade para o intercambio                                          ³ //nelson 29/05/07 solicitado andreia 
		           //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
	                BD3->(DbSelectArea("BD3"))
            	    BD3->(DbSetOrder(1))
	                If BD3->(MsSeek(xFilial("BD3")+BD4->BD4_CODIGO))
	                   cUnid:= BD3->BD3_UNIDAD
	                EndIf
	            EndIf                            
	                 
			    //nVlrRef  := BD7->BD7_REFTDE ** Anterior
			    
	            if BR8->BR8_CONSFT == "1"
			      	nVlrRef   := IIF(BD7->BD7_FATMUL>0,BD7->BD7_FATMUL,1) *((IIF(nValRef >0,nValRef,BD7->BD7_REFTDE) * BD6->BD6_QTDPRO)*iif(BD6->BD6_PERVIA>0,BD6->BD6_PERVIA,100)/100) // Mostra a quantidade de CHC de acordo com o a VIA
		        Else
					nVlrRef   := ((IIF(nValRef >0,nValRef,BD7->BD7_REFTDE) * BD6->BD6_QTDPRO)*iif(BD6->BD6_PERVIA>0,BD6->BD6_PERVIA,100)/100) // Mostra a quantidade de CHC de acordo com o a VIA          
		        endif	

			    nVlrTax	 := BD7->BD7_VLRTAD
			    
		        nQtdePro := TRBOP->BD6_QTDPRO
                     
    	    	If nQtdePro = 0
        		   nQtdePro := 1
        		EndIf

			    If cBloq = '1'
			        nVlrBloq += nVlrItem+nVlrTax
			    EndIf
							    			
			    nVlrIns := Resumo(cCodOpe,cQuebLDP,cQuebPEG,cQuebGUI,nVlrItem,nVlrRef,nVlrTax,nPercIns)
			    // gravo nessa variavel o valor do inss mais ainda nao vou tratar , preciso colocar a coluna 

	            cInicio := cMatUsr+Space(01)+cNomUsr+Space(01)

	            //impressão do relatório 
	            if nQbrPr == 1 // Quebra Por Nota
					If cLastgui <> cQuebLDP+cQuebPEG+cQuebGUI
						If nVlrGuiaTot <> 0
							nLi++
	        		    	@ nLi, nColuna + 185 pSay "TOTAL DA NOTA: "+TransForm(nVlrGuiaTot,__pMoeda)
		    		    	nVlrGuiaTot := 0
		    		    	nLi++
	            		EndIf
	            		nLi++                                                                     
					   @ nLi, nColuna pSay padR(cNroImpresso + "  " + cMovime+Space(01)+cInicio+Space(01)+DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +;
						Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(BD7->BD7_CODPRO)+Space(01)+;
					    substr(PLDESPRO(BD7->BD7_CODPAD,BD7->BD7_CODPRO),1,20)+Space(01)+STR(BD7->BD7_COEFPF,7,2)+Space(01)+BD7->BD7_TPCOPF+;
					    SPACE(01)+IIF(Empty(BD7->BD7_CODUNC),BD7->BD7_CODUNM,BD7->BD7_CODUNC)+Space(01)+Str(nVlrRef,7,2)+;
					    IIf(BD7->(FieldPos("BD7_REFTDE"))>0,Space(1)+IIF(Empty(cUnid),BD7->BD7_UNITDE,cUnid),"     ")+;
					    Space(01)+TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda)+Space(1)+iif(nVlrIns==0,"",Transform(nVlrIns,"@E 99,999.99")),220)
					 Else    
					    nLi++      
					    @ nLi, nColuna pSay padR(cNroImpresso + "  " + Space(len(cMovime+Space(01)+cInicio))+;
					    Space(01)+DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(BD7->BD7_CODPRO)+Space(01)+;
					    substr(PLDESPRO(BD7->BD7_CODPAD,BD7->BD7_CODPRO),1,20)+Space(01)+STR(BD7->BD7_COEFPF,7,2)+Space(01)+BD7->BD7_TPCOPF+;
					    SPACE(01)+IIF(Empty(BD7->BD7_CODUNC),BD7->BD7_CODUNM,BD7->BD7_CODUNC)+Space(01)+Str(nVlrRef,7,2)+;
					    IIf(BD7->(FieldPos("BD7_REFTDE"))>0,Space(1)+IIF(Empty(cUnid),BD7->BD7_UNITDE,cUnid),"     ")+;
					    Space(01)+TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda)+Space(1)+iif(nVlrIns==0,"",Transform(nVlrIns,"@E 99,999.99")),220)
					EndIf
				Else // Quebra Por Familia
					If cLastFam <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
						If nVlrGuiaTot <> 0
							nLi++
	        		    	@ nLi, nColuna + 185 pSay "TOTAL FAMILIA: "+TransForm(nVlrGuiaTot,__pMoeda)
		    		    	nVlrGuiaTot := 0
		    		    	nLi++
		    		    	lPrimUFm := .T.
		        		EndIf
		        		if lPrimUFm
			        		if BA1->BA1_TIPREG <> '00' 
				    		    	nIdBA1 := BA1->(IndexOrd())
				    		    	nRcBa1 := BA1->(Recno())
		    			    		BA1->(DbSetOrder(1))
			    			    	if BA1->(MsSeek(xFilial("BA1")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+"T")))
			    			    		@ nLi, nColuna pSay padR("TITULAR DA FAMILIA:  "+BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"-"+BA1_TIPREG) +" - "+BA1->BA1_NOMUSR ,220)
			    			    	Endif	
		   	    		    		BA1->(DbSetOrder(nIdBA1))
			    		    		BA1->(dbGoto(nRcBA1))
		    		    	Endif
		    		    	lPrimUFM := .F.
		    		    Endif	
	            		nLi++                                                                     
					   @ nLi, nColuna pSay padR(cNroImpresso + "  " + cMovime+Space(01)+cInicio+Space(01)+DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +;
						Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(BD7->BD7_CODPRO)+Space(01)+;
					    substr(PLDESPRO(BD7->BD7_CODPAD,BD7->BD7_CODPRO),1,20)+Space(01)+STR(BD7->BD7_COEFPF,7,2)+Space(01)+BD7->BD7_TPCOPF+;
					    SPACE(01)+IIF(Empty(BD7->BD7_CODUNC),BD7->BD7_CODUNM,BD7->BD7_CODUNC)+Space(01)+Str(nVlrRef,7,2)+;
					    IIf(BD7->(FieldPos("BD7_REFTDE"))>0,Space(1)+IIF(Empty(cUnid),BD7->BD7_UNITDE,cUnid),"     ")+;
					    Space(01)+TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda)+Space(1)+iif(nVlrIns==0,"",Transform(nVlrIns,"@E 99,999.99")),220) 				     
					Else    
						if cLastUsr <> BA1->(BA1_TIPREG)
							cLinTmp := cNroImpresso + "  " + cMovime+Space(01)+cInicio+Space(01)
						Else 
							cLinTmp := cNroImpresso + "  " + Space(len(cMovime+Space(01)+cInicio+Space(01)))
						Endif  
					    nLi++      
					    @ nLi, nColuna pSay padR(cLinTmp+;
					    DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(BD7->BD7_CODPRO)+Space(01)+;
					    substr(PLDESPRO(BD7->BD7_CODPAD,BD7->BD7_CODPRO),1,20)+Space(01)+STR(BD7->BD7_COEFPF,7,2)+Space(01)+BD7->BD7_TPCOPF+;
					    SPACE(01)+IIF(Empty(BD7->BD7_CODUNC),BD7->BD7_CODUNM,BD7->BD7_CODUNC)+Space(01)+Str(nVlrRef,7,2)+;
					    IIf(BD7->(FieldPos("BD7_REFTDE"))>0,Space(1)+IIF(Empty(cUnid),BD7->BD7_UNITDE,cUnid),"     ")+;
					    Space(01)+TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda)+Space(1)+iif(nVlrIns==0,"",Transform(nVlrIns,"@E 99,999.99")),220)
					EndIf
				Endif	            	            
				
				cLast      := Iif(nTipoRel==1,TrbOp->BD6_OPEORI,TrbOp->BD6_CODEMP)
				nVlrTotGui := nVlrItem        
				nVlrTotNot += nVlrItem        
				nVlrTotTax += nVlrTax
				nVlrGRef   := nVlrRef
				nItens     := 1
				lfirst	   := .f.
				cLastgui   := cQuebLDP+cQuebPEG+cQuebGUI
				cLastFam   := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				cLastUsr   := BA1->(BA1_TIPREG)
				
            	nVlrGuiaTot += nVlrTax+nVlrItem//nVlrTotTax+nVlrTotNot
		        
		        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Soma total                                            ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            nVlrPag := nVlrPag + nVlrItem
	            nVlrPRef := nVlrPRef + nVlrRef
	            nQtd ++
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		        //³ Acessa proximo registro...                                               ³
		        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        BD7->(DbSkip())	                
	        EndDo //While ! BD7->(Eof()) .And. BD7->BD7_CODLDP == cQuebLDP .And. BD7->BD7_CODPEG == cQuebPEG .And. BD7->BD7_NUMERO == cQuebGUI        
	        
	    EndIf //BD7->(MsSeek(xFilial("BD7")+"0055"+BD6_CODLDP+BD6_CODPEG+BD7_NUMERO))
    Else
    	cQuebLDP := TRBOP->BD6_CODLDP
	    cQuebPEG := TRBOP->BD6_CODPEG
	    cQuebGUI := TRBOP->BD6_NUMERO
	    cOrimov  := TRBOP->BD6_ORIMOV
	    cSequen	 := TRBOP->BD6_SEQUEN	
        nQtdePro := TRBOP->BD6_QTDPRO
                     
        	If nQtdePro = 0
        	   nQtdePro := 1
        	EndIf

	    nVlrFil	 := 0
    	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Imprime cabecalho...                                                     ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    If cQueb <> cLast .and. !empty(cLast)
           RIntImpr_Resumo(aResumo,nvlrBloq)
	       RIntPag(.T., cTitulo, .F., .T.,aResumo)
	    Else
	              //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	              //³ Imprime cabecalho...                                                     ³
	              //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	        RIntPag(.F., cTitulo, .F., .F.,aResumo)
	    Endif
    	If  ! lGerTxt
	      MsProcTXT("Movimentacao "+TRBOP->(BD6_ANOPAG+"."+BD6_MESPAG+"-"+BD6_NUMERO)+"  - Pagina "+StrZero(m_pag,4))
	    Endif
	     //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	     //³ Busca nome do usuario do item posicionado...                       ³
	     //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	     BA1->(DbSetOrder(2))
	     If BA1->(DbSeek(xFilial("BA1")+TRBOP->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
	     cNomUsr := SubStr(TRBOP->BD6_NOMUSR,1,25)//Subs(BA1->BA1_NOMUSR,1,25)
	     Else
	       cNomUsr := Space(25)
	     Endif
	     cMatUsr := IF(TRBOP->BD6_MATUSA=="1".and.BA1->BA1_CODINT==BA1->BA1_OPEORI,BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"-"+BA1_TIPREG+"-"+BA1_DIGITO),Subs(BA1->BA1_MATANT,1,17)+Space(04))
	     //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	     //³ Monta numero da movimentacao...                                    ³
	     //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		 cMovime := TRBOP->BD6_CODPEG+"-"+TRBOP->BD6_NUMERO+"-"+TRBOP->BD6_CODLDP
		        
	     cNumGui := TRBOP->BD6_NUMERO

	     If BD7->(MsSeek(xFilial("BD7")+"0055"+TRBOP->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
	     	BAU->(MsSeek(xFilial("BAU")+BD7->BD7_CODRDA))
	     	PrtCab  := .F.        
	        cQuebLDP := TRBOP->BD6_CODLDP
	    	cQuebPEG := TRBOP->BD6_CODPEG
	    	cQuebGUI := TRBOP->BD6_NUMERO
	    	cCodPro  := BD7->(BD7_CODPAD+BD7_CODPRO)
	    	cOrimov  := TRBOP->BD6_ORIMOV
	    	cSequen	 := TRBOP->BD6_SEQUEN
	        lFirst := .T.                
	        nQtdePro := TRBOP->BD6_QTDPRO
                     
        	If nQtdePro = 0
        	   nQtdePro := 1
        	EndIf
        	
			// --			
			// -- Solicitado pela Andreia (SRP) - 21/06/2006
			// --
			//cCodRda  := PLSZero(if( BAU->BAU_TIPPRE == "UNI", BAU->BAU_CODOPE, BAU->BAU_CONREG ), 10 )
			cCodRda  := strzero(val(BAU->BAU_CODIGO), 10 )

	        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	        //³ Inicia a quebra por Peg...                                   ³
	        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	     While ! BD7->(Eof()) .And. BD7->(BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO+BD7->BD7_ORIMOV+BD7_SEQUEN) ==;//BD7->(BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO+BD7_CODPAD+BD7_CODPRO) ==;
	        						   cQuebLDP+cQuebPEG+cQuebGUI+cOrimov+cSequen
	       	     
	       	 //nVlrItem:= Iif(TRBOP->BD6_TPPF == '1', (TRBOP->BD6_VLRBPF * BD7->BD7_PERCEN)/100, ((TRBOP->BD6_VLRTPF - TRBOP->BD6_VLRTAD) * BD7->BD7_PERCEN)/100)
	       	 
	       	 If TRBOP->BD6_TPPF = '1'
	           	nVlrItem := BD7->BD7_VLRBPF
	         Else
	           	nVlrItem := BD7->BD7_VLRTPF - BD7->BD7_VLRTAD
	         EndIf
	           	 
		 	 nVlrTax  := BD7->BD7_VLRTAD
   	         nVlrGuiaTot := 0		 	 
		 	 
		 	 If cBloq = '1'
			        nVlrBloq += nVlrItem+nVlrTax
			 EndIf
	       	     
			 Resumo(cCodOpe,cQuebLDP,cQuebPEG,cQuebGUI,nVlrItem,0,nVlrTax)
			
		 	 BD7->(DbSkip())
			 
		 EndDo			
		 EndIf
		 	 
		 cInicio := cMatUsr+Space(01)+cNomUsr+Space(01)
          		 
		 //--
		 //-- Nro do Impresso, solicitado pela Andreia. 21-06-2006
		 //-- 
		 cNroImpresso := BD7->BD7_NUMIMP
	     
		   //If cLastgui <> cQuebLDP+cQuebPEG+cQuebGUI
		   If cUsu <> cMatUsr
			   	If nVlrGuiaTot <> 0
					nLi++
        	    	@ nLi, nColuna + 185 pSay "TOTAL DA NOTA: "+TransForm(nVlrGuiaTot,__pMoeda)
	    	    	nVlrGuiaTot := 0
            		nLi++
            	EndIf    
            	nLi++
  	            @ nLi, nColuna pSay padR(cNroImpresso + "     " + cMovime+Space(01)+cInicio+Space(01)+DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +;
		   		Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(TRBOP->BD6_CODPRO)+Space(01)+;
		   		substr(PLDESPRO(TRBOP->BD6_CODPAD,TRBOP->BD6_CODPRO),1,20)+Space(01)+;
		   		TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrFil,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda),220)
		   Else
		        nLi++
		        @ nLi, nColuna pSay padR(cNroImpresso + "     " + Space(len(cMovime+Space(01)+cInicio+Space(01)))+DtoC(TRBOP->BD6_DATPRO)+Space(01)+ cCodRda +;
		   		Str(nQtdePro,3)+Iif(cBloq='1','*',Space(01))+PLDesCod(TRBOP->BD6_CODPRO)+Space(01)+;
		   		substr(PLDESPRO(TRBOP->BD6_CODPAD,TRBOP->BD6_CODPRO),1,20)+Space(01)+;
		   		TransForm(nVlrTax,__pMoeda)+Space(01)+TransForm(nVlrFil,__pMoeda)+Space(01)+TransForm(nVlrItem,__pMoeda)+Space(01)+TransForm(nVlrItem+nVlrTax,__pMoeda),220)
		   EndIf
		   
		   clastgui   :=cQuebLDP+cQuebPEG+cQuebGUI
		   cLast      := Iif(nTipoRel==1,TrbOp->BD6_OPEORI,TrbOp->BD6_CODEMP)
		   nVlrTotGui := nVlrItem        
		   nVlrTotNot += nVlrItem        
		   nVlrTotTax += nVlrTax
		   nVlrGRef   := nVlrRef
		   nItens     := 1
		   cUsu		  := cMatUsr
		   nVlrGuiaTot += nVlrTax+nVlrItem//nVlrTotTax+nVlrTotNot
           nVlrGuiaTot := 0
           
		 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	     //³ Soma total                                                         ³
	     //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	     nVlrPag  += nVlrItem
	     nQtd ++
    EndIf     

    TrbOp->(DbSkip())
    
    If nTipoDad = 1 .or. ;
       (nTipoDad <> 1 .AND. SubStr(cUsu,1,17) <> TRBOP->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) .AND. !EMPTY(cUsu))
		nVlrTotNot := 0
		nVlrTotTax := 0
		
	EndIf    
	
EndDo//While !TrbOp->(Eof())

RIntImpr_Resumo(aResumo,nVlrBloq)
TrbOp->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe mensagem...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  ! lGerTxt
    MsProcTXT("Calculando totais do relatorio...")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
    Set Printer To
	IIF(!lGerTxt,OurSpool(nrel),.t.)
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

Static Function RIntImpr_Resumo(aResumo,nVlrBloq)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nJ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local lListaCab := .F., lResumo := .T.
Local cResCab1 := Replicate("-",220)
Local cResCab2 := "|DESCRICAO               |   CONSULTAS     |    SERVIÇOS    |  TRATAMENTO HOSP.  |            |   VLR    |          |    TAXA   |     TOTAL   |"
Local cResCab3 := "|                        | QTD     |  VLR  |  QTD   |  VLR  |  QTD   |   VLR     |  VLR FIL   | MAT/MED  | DIARIAS  |    ADM    |             |"
//rotina para impressão do resumo

If (nQtdLin - nLi) <= 20//verifica se o resumo logo abaixo dos dados ou será em uma nova pagina
	RIntPag(.t., cTitulo, .f., .f. ,aResumo)
EndIf

nLi += 1
@ nLi, nColuna PSay "RESUMO....."
nLi+=2
@ nLi, nColuna PSay cResCab1
nLi++
@ nLi, nColuna PSay cResCab2 
nLi++
@ nLi, nColuna PSay cResCab3
nLi++
@ nLi, nColuna PSay cResCab1
nLi++
@ nLi, nColuna PSay "ATOS PRINCIPAIS"
nLi++
//imprime atos principais
For nI:= 1 to 3
	@ nLi, nColuna+5 PSay aResumo[nI][1]+Space(05)+Strzero(aResumo[nI][2],5)+Space(03)+Transform(aResumo[nI][3],__pMoeda)+;
	Space(03)+Strzero(aResumo[nI][4],5)+Transform(aResumo[nI][5],__pMoeda)+Space(03)+Strzero(aResumo[nI][6],5)+Space(03)+;
	Transform(aResumo[nI][7],__pMoeda)+Space(03)+Transform(aResumo[nI][8],__pMoeda)+Space(03)+Transform(aResumo[nI][9],__pMoeda)+;
	Space(03)+strzero(aResumo[nI][10],5)+Space(03)+Transform(aResumo[nI][11],__pMoeda)+Space(03)+;
	Transform(aResumo[nI][12],__pMoeda)
	nLi++
End
//imprime atos auxiliares
@ nLi, nColuna PSay "ATOS AUXILIARES"
nLi++
//nLinha++	
For nI:= 4 to 7
	@ nLi, nColuna+5 PSay aResumo[nI][1]+Space(05)+Strzero(aResumo[nI][2],5)+Space(03)+Transform(aResumo[nI][3],__pMoeda)+;
	Space(03)+Strzero(aResumo[nI][4],5)+Transform(aResumo[nI][5],__pMoeda)+Space(03)+Strzero(aResumo[nI][6],5)+Space(03)+;
	Transform(aResumo[nI][7],__pMoeda)+Space(03)+Transform(aResumo[nI][8],__pMoeda)+Space(03)+Transform(aResumo[nI][9],__pMoeda)+;
	Space(03)+Strzero(aResumo[nI][10],5)+Space(03)+Transform(aResumo[nI][11],__pMoeda)+Space(03)+;
	Transform(aResumo[nI][12],__pMoeda)
	nLi++
End
//OUTROS ATOS
@ nLi, nColuna PSay aResumo[8][1]+Space(10)+Strzero(aResumo[8][2],5)+Space(03)+Transform(aResumo[8][3],__pMoeda)+;
Space(03)+Strzero(aResumo[8][4],5)+Transform(aResumo[8][5],__pMoeda)+Space(03)+Strzero(aResumo[8][6],5)+Space(03)+;
Transform(aResumo[8][7],__pMoeda)+Space(03)+Transform(aResumo[8][8],__pMoeda)+Space(03)+Transform(aResumo[8][9],__pMoeda)+;
Space(03)+Strzero(aResumo[8][10],5)+Space(03)+Transform(aResumo[8][11],__pMoeda)+Space(03)+;
Transform(aResumo[8][12],__pMoeda)
nLi++
//TOTAL DAS COLUNAS
@ nLi, nColuna PSay aResumo[9][1]+Space(10)+Strzero(aResumo[9][2],5)+Space(03)+Transform(aResumo[9][3],__pMoeda)+;
Space(03)+Strzero(aResumo[9][4],5)+Transform(aResumo[9][5],__pMoeda)+Space(03)+Strzero(aResumo[9][6],5)+Space(03)+;
Transform(aResumo[9][7],__pMoeda)+Space(03)+Transform(aResumo[9][8],__pMoeda)+Space(03)+Transform(aResumo[9][9],__pMoeda)+;
Space(03)+Strzero(aResumo[9][10],5)+Space(03)+Transform(aResumo[9][11],__pMoeda)+Space(03)+;
Transform(aResumo[9][12],__pMoeda)
nLi++
If nVlrBloq > 0
	nLi++
	@ nLi, nColuna PSay "VALOR TOTAL DE NOTAS BLOQUEADAS ---------- "+ Transform(nVlrBloq,__pMoeda)
	nLi++
EndIf
//zera arrray de resumo
For nI:=1 to Len(aResumo)
  For nJ:= 2 to 12
     aResumo[nI][nJ] := 0
  End			    	
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodade padrao do produto Microsiga                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

Static Function RIntPag(lForce, cTitulo, lListaCab, lResumo,aResumo)

Local cFase
default lForce := .F.                             
default lListaCab := .T.
default lResumo := .F.
//chama a rotina de cabeçalho se for uma quebra de pagina
//If lResumo
//   lResumo := .F.
//   RIntImpr_Resumo(aResumo)
//EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//Rotina para impressão do cabeçalho das páginas                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If lForce .or. empty(clast) //.and. nLinha > 1
//  nLinha:= nLinha + (nQtdLin-nLinha)
//EndIf
If nLi >= nQtdLin .Or. lForce .or. Empty(cLast)
   nLi := 6
   cFase := ""
   If nFase == 1
      cFase:= "Digitacao"
   ElseIf nFase == 2
      cFase:= "Conferencia"
   ElseIf nFase == 3
      cFase:= "Pronta"
   ElseIf nFase == 4
      cFase:= "Pronta/Faturada"
   EndIF
   Cabec(cTitulo,If(lListaCab,cCabec1,""),If(lListaCab,cCabec2,""),cNomeProg,cTamanho,nCaracter)
   If nTipoRel == 1
	   BA0->(DbSetOrder(1))
       BA0->(MsSeek(xFilial("BA0")+cQueb)) //posiciona na Operadora
       cNom := BA0->(BA0_CODIDE+BA0_CODINT+Space(03)+BA0_NOMINT)
	   @ nLi, nColuna pSay "UNIMED VALE DO SINOS - Sociedade Cooperativa de Trabalho Medico "+Space(20)+;
	   						SUBSTR(DTOC(dDataBase),1,2)+ " de " + MesExtenso(MONTH(dDataBase)) + " de " + STR(YEAR(dDataBase),4)+Space(10) 
	   nLi += 2
	   @ nLi, nColuna pSay "RELATORIO DE INTERCAMBIO ENTRE UNIMEDS (CAMARA) - COMPETENCIA: "+cMesDe+"/"+cAnoDe+" até "+cMesAte+"/"+cAnoAte+" FASE..: "+cFase
	   nLi += 2
	   @ nLi, nColuna pSay "UNIMED..: " + cNom
	   nLi ++
	   nLinha+=5
   Else
       DbSelectArea("BG9")
       BG9->(DbSetOrder(1))
       BG9->(MsSeek(xFilial("BA0")+"0055"+cQueb)) //posiciona na empresa
       cNom := BG9->(BG9_CODIGO+"-"+BG9_DESCRI)
       @ nLi, nColuna pSay "UNIMED VALE DO SINOS - Sociedade Cooperativa de Trabalho Medico "+Space(20)+;
	   						SUBSTR(DTOC(dDataBase),1,2)+ " de " + MesExtenso(MONTH(dDataBase)) + " de " + STR(YEAR(dDataBase),4)+Space(10)
	   nLi += 2
	   @ nLi, nColuna pSay "RELATORIO DE CUSTO OPERACIONAL - COMPETENCIA: "+cMesDe+"/"+cAnoDe+" até "+cMesAte+"/"+cAnoAte+" FASE..: "+cFase
	   nLi += 2
	   @ nLi, nColuna pSay "GRUPO EMPRESA..: " + cNom
	   nLi ++
	   nLinha+=5
   EndIf
   
   
   If  nTipoDad == 1
	   @ nLi, nColuna pSay Replicate("=",220)   
	   nLi ++
	   @ nLi, nColuna pSay cCabec1//cabeçalho se o relatório for analisto
	   nLi ++
	   @ nLi, nColuna pSay Replicate("=",220)   
	   nLi++
   Else
       @ nLi, nColuna pSay Replicate("=",220)   
       nLi ++
	   @ nLi, nColuna pSay cCabec2//cabeçalho se o relatório for sintético
	   nLi ++
	   @ nLi, nColuna pSay Replicate("=",220)	   
	   nLi++
   EndIf
      	   
Endif

Return

Static Function Resumo(cCodOpe,cQuebLDP,cQuebPEG,cQuebGUI,nVlrItem,nVlrRef,nVlrTax,nPercIns)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nRet := 0

If TRBOP->BD6_CODPRO = '70004108'
				    
	aResumo[7][2]  += TRBOP->BD6_QTDPRO 
	aResumo[7][3]  += ROUND(nVlrItem,2)
	aResumo[7][11] += ROUND(nVlrTax,2)
				
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "MED"
				
    aResumo[1][2]  += TRBOP->BD6_QTDPRO 
	aResumo[1][3]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)      
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "LAB"
				
    aResumo[5][4]  += TRBOP->BD6_QTDPRO 
	aResumo[5][5]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "FIS"
				
    aResumo[6][4]  += TRBOP->BD6_QTDPRO 
	aResumo[6][5]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)
			   
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "MED" //$ "CLI,LAB,MED"
				    
    aResumo[1][4]  += TRBOP->BD6_QTDPRO 
	aResumo[1][5]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "MED"
				    
    aResumo[1][4]  += TRBOP->BD6_QTDPRO 
	aResumo[1][5]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "LAB"
				    
    aResumo[5][4]  += TRBOP->BD6_QTDPRO 
	aResumo[5][5]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)


ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'HM' .AND. !BAU->BAU_TIPPRE $ 'PAT,LAB,CLI' //BAU->BAU_TIPPRE <> 'PAT' 

	aResumo[1][6]  += TRBOP->BD6_QTDPRO 
	aResumo[1][7]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = 'HOS' 

	aResumo[1][6]  += TRBOP->BD6_QTDPRO 
	aResumo[1][7]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
 				
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = 'PAT'
                	
   	aResumo[2][2]  += TRBOP->BD6_QTDPRO 
	aResumo[2][3]  += ROUND(nVlrItem,2)
	aResumo[2][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
					
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = 'PAT'
			   
	aResumo[2][4]  += TRBOP->BD6_QTDPRO 
	aResumo[2][5]  += ROUND(nVlrItem,2)
	aResumo[2][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
			   
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = "HOS"
			   		
	aResumo[4][4]  += TRBOP->BD6_QTDPRO 
	aResumo[4][5]  += ROUND(nVlrItem,2)
	aResumo[4][11] += ROUND(nVlrTax,2)
	DbselectArea("BE4")
	If MsSeek(xFilial("BE4")+cCodOpe+cQuebLDP+cQuebPEG+cQuebGUI)
	   aResumo[4][10] += BE4->BE4_DIASIN
	EndIf
				
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = "LAB"
               		
	aResumo[5][4]  += TRBOP->BD6_QTDPRO 
	aResumo[5][5]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)
			   
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = "CLI"
					
    aResumo[6][4]  += TRBOP->BD6_QTDPRO 
	aResumo[6][5]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)			   


ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "LAB"//NELSON INCLUIU
               		
	aResumo[5][4]  += TRBOP->BD6_QTDPRO 
	aResumo[5][5]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)


ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "CLI" // NELSON INCLUIU
					
    aResumo[6][4]  += TRBOP->BD6_QTDPRO 
	aResumo[6][5]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)			   


ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = "MED"
					
    aResumo[1][4]  += TRBOP->BD6_QTDPRO 
	aResumo[1][5]  += ROUND(nVlrItem,2)
	aResumo[1][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. !BD7->BD7_CODUNM $ 'HM,VMT,FIL' .AND. BAU->BAU_TIPPRE = "FIS"
					
    aResumo[6][4]  += TRBOP->BD6_QTDPRO 
	aResumo[6][5]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)
			   
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'FIL' .AND. BAU->BAU_TIPPRE = "HOS"
			  		
	aResumo[4][8]  += ROUND(nVlrItem,2)
	aResumo[4][11] += ROUND(nVlrTax,2)
	If MsSeek(xFilial("BE4")+cCodOpe+cQuebLDP+cQuebPEG+cQuebGUI)
	   aResumo[4][10] += BE4->BE4_DIASIN
	EndIf
			  		
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'FIL' .AND. BAU->BAU_TIPPRE = "LAB"
			  		
	aResumo[5][8]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'FIL' .AND. BAU->BAU_TIPPRE = "MED"
			  		
	aResumo[5][8]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)
             
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'FIL' .AND. BAU->BAU_TIPPRE $ "CLI,FIS"
			   		
	aResumo[6][8]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "HOS"
			  		
	aResumo[4][9]  += ROUND(nVlrItem,2)
	aResumo[4][11] += ROUND(nVlrTax,2)
	If MsSeek(xFilial("BE4")+cCodOpe+cQuebLDP+cQuebPEG+cQuebGUI)
	   aResumo[4][10] += BE4->BE4_DIASIN
	EndIf

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "HOS"
			  		
	aResumo[4][9]  += ROUND(nVlrItem,2)
	aResumo[4][11] += ROUND(nVlrTax,2)
	If MsSeek(xFilial("BE4")+cCodOpe+cQuebLDP+cQuebPEG+cQuebGUI)
	   aResumo[4][10] += BE4->BE4_DIASIN
	EndIf

			  		
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "LAB"
			  		
	aResumo[5][9]  += ROUND(nVlrItem,2)
	aResumo[5][11] += ROUND(nVlrTax,2)
              
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE $ "CLI,MED" //BAU->BAU_TIPPRE = "CLI" PODE HAVER MEDICAMENTO E MATERIAL PARA MEDICO (Ex. UMA IMOBILIZAÇÃO) NELSON EM 10/07/07
			   		
    aResumo[6][9]  += ROUND(nVlrItem,2)
   	aResumo[6][11] += ROUND(nVlrTax,2)

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE $ "CLI,MED" //BAU->BAU_TIPPRE = "CLI" PODE HAVER MEDICAMENTO E MATERIAL PARA MEDICO (Ex. UMA IMOBILIZAÇÃO) NELSON EM 10/07/07
			   		
	aResumo[6][9]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000'.AND. BD7->BD7_CODUNM = 'VMT' .AND. BAU->BAU_TIPPRE = "PAT"
			   		
	aResumo[6][9]  += ROUND(nVlrItem,2)
	aResumo[6][11] += ROUND(nVlrTax,2)
			  		 
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) = '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "UNI"
				
    aResumo[3][2]  += TRBOP->BD6_QTDPRO 
	aResumo[3][3]  += ROUND(nVlrItem,2)
	aResumo[3][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif
	
ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000' .AND. BD7->BD7_CODUNM = 'HM' .AND. BAU->BAU_TIPPRE = "UNI"
				
    aResumo[3][4]  += TRBOP->BD6_QTDPRO 
	aResumo[3][5]  += ROUND(nVlrItem,2)
	aResumo[7][11] += ROUND(nVlrTax,2)
	if nPercIns > 0 
		nRet := (nVlrTax+nVlrItem)*nPercIns/100
	Endif

ElseIf SubStr(TRBOP->BD6_CODPRO,1,3) <> '000' .AND. BD7->BD7_CODUNM <> 'HM' .AND. BAU->BAU_TIPPRE = "UNI"
				
    aResumo[7][4]  += TRBOP->BD6_QTDPRO 
	aResumo[7][5]  += ROUND(nVlrItem,2)
	aResumo[7][11] += ROUND(nVlrTax,2)

Else
//PLSCRIGEN(xCri,{ {"Procedimento ","@C",10}, {"Composição ","@C",3} ,{"Tipo RDA","@E 999",3}}, " Critica ")  	 
	Aadd(xCri,{TRBOP->BD6_CODPRO,BD7->BD7_CODUNM , BAU->BAU_TIPPRE,"Não entrou no Resumo" })
EndIf
               
//Incrementa o total das Linhas
For nI:= 1 to Len(aResumo)
    aResumo[nI][12] := ROUND(aResumo[nI][3]+aResumo[nI][5]+aResumo[nI][7]+aResumo[nI][8]+;
    aResumo[nI][9]+aResumo[nI][11],2)
End
               
//Incrementa o total das colunas
For nI:= 2 to 12
    aResumo[9][nI] := ROUND(aResumo[1][nI]+aResumo[2][nI]+aResumo[3][nI]+aResumo[4][nI]+aResumo[5][nI]+;
    aResumo[6][nI]+aResumo[7][nI]+aResumo[8][nI],2)
End

Return(nRet)

Static Function CriaSX1()

Local aRegs	:=	{}
Local cPerg	:=	'PLRINT'

aadd(aRegs,{cPerg,"01","Tipo de Impressão"				,"","","mv_ch1","C", 1,0,0,"C","","mv_par01","Laser/Jato" ,"","","","","Matricial","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"02","Tipo Relatório"					,"","","mv_ch2","C", 1,0,0,"C","","mv_par02","Intercambio" ,"","","","","SRP","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Dados"							,"","","mv_ch3","C", 1,0,0,"C","","mv_par03","Analitico" ,"","","","","Sintetico","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Cod. Op. Padrao	"				,"","","mv_ch4","C", 4,0,0,"G","","mv_par04","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Operadora Intercambio de"		,"","","mv_ch5","C", 4,0,0,"G","","mv_par05","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"06","Operadora Intercambio Até"		,"","","mv_ch6","C", 4,0,0,"G","","mv_par06","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Grupo Empresa de"				,"","","mv_ch7","C", 4,0,0,"G","","mv_par07","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"08","Grupo Empresa Até"				,"","","mv_ch8","C", 4,0,0,"G","","mv_par08","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","Contrato De"					,"","","mv_ch9","C",12,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","B7B","","",""})
aAdd(aRegs,{cPerg,"10","Contrato Ate"					,"","","mv_cha","C",12,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","B7B","","",""})
aAdd(aRegs,{cPerg,"11","Sub-Contrato De"				,"","","mv_chb","C",9,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","B7C","","",""})
aAdd(aRegs,{cPerg,"12","Sub-Contrato Ate"				,"","","mv_chc","C",9,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","B7C","","",""})
aAdd(aRegs,{cPerg,"13","Matricula De"					,"","","mv_chd","C",6,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Matricula Ate"					,"","","mv_che","C",6,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"15","Mes Pag De"						,"","","mv_chf","C", 2,0,0,"G","","mv_par15","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Ano Pag De"						,"","","mv_chg","C", 4,0,0,"G","","mv_par16","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"17","Mes Pag Até"					,"","","mv_chh","C", 2,0,0,"G","","mv_par17","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"18","Ano Pag Até"					,"","","mv_chi","C", 4,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"19","Fase"							,"","","mv_chj","C", 1,0,0,"C","","mv_par19","Digitação" ,"","","","","Conferencia","","","","","Pronta","","","","","Pronta/Faturada","","","","","","","","","",""})
aadd(aRegs,{cPerg,"20","Grupo Operadora De"				,"","","mv_chk","C", 2,0,0,"G","","mv_par20","" ,"","","","","","","","","","","","","","","","","","","","","","BA2","","",""})
aadd(aRegs,{cPerg,"21","Grupo Operadora Ate"			,"","","mv_chl","C", 2,0,0,"G","","mv_par21","" ,"","","","","","","","","","","","","","","","","","","","","","BA2","","",""})
aadd(aRegs,{cPerg,"22","Ordem"							,"","","mv_chm","C", 1,0,0,"C","","mv_par22","Cod Usu","","","","","Nome Usu","","","","","Peg+Guia","","","","","Impresso","","","","","","","BA2","","",""})
aadd(aRegs,{cPerg,"23","Tipo Padrão"					,"","","mv_chm","C", 2,0,0,"G","","mv_par23","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"24","Código Procedimento Inicial"	,"","","mv_cho","C", 8,0,0,"G","","mv_par24","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"25","Código Procedimento Final  "	,"","","mv_chp","C", 8,0,0,"G","","mv_par25","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"26","Imprime Somente Guias Ativas"	,"","","mv_chq","C", 1,0,0,"C","","mv_par26","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"27","Tipo Cobranca"					,"","","mv_chr","C", 1,0,0,"C","","mv_par27","Som Nao Cobr","","","","","Som Cobrad","","","","","Ambas","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"28","Grupo de Cobrança"				,"","","mv_chs","C", 4,0,0,"G","","mv_par28","","","","","","","","","","","","","","","","","","","","","","","","","BR0PLS",""})
aadd(aRegs,{cPerg,"29","Data Digit de"					,"","","mv_cht","D", 8,0,0,"G","","mv_par29","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"30","Data Digit Ate"					,"","","mv_chu","D", 8,0,0,"G","","mv_par30","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"31","Quebra Por"						,"","","mv_chv","C", 1,0,0,"C","","mv_par31","Peg+Guia","","","","","Familia","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"32","Data Movim de"					,"","","mv_chx","D", 8,0,0,"G","","mv_par32","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"33","Data Movim Ate"					,"","","mv_chw","D", 8,0,0,"G","","mv_par33","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"34","Numero do Titulo"				,"","","mv_chw","C",13,0,0,"G","","mv_par34","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"35","Perc. Inss (Zero nao Aparece)"	,"","","mv_chy","N", 5,2,0,"G","","mv_par35","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )
    
Return

