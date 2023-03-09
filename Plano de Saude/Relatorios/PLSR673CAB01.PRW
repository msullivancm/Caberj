
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR673 ³ Autor ³ Angelo Sperandio       ³ Data ³ 03.02.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Extrato de Movimentacao da RDA                             ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR673()                                                  ³±±±
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
User Function PLSR673CAB01()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCentury      := __setcentury()
LOCAL aSx1Stru      := SX1->( DbStruct() )
LOCAL nTamPerg      := aSx1Stru[1,3]
PRIVATE cRelDir     := GetMv("MV_RELT")
PRIVATE nQtdLin
PRIVATE cNomeProg   := "PLSR673CAB01"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 132       
PRIVATE nLimite     := 220
PRIVATE cTamanho    := GetNewPar("MV_PLTA673","M","G")    
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Conferencia Interna Pagto"
PRIVATE cTitDem     := "CONFERENCIA INTERNA DE PAGAMENTO    -           Mes.......: "
PRIVATE cDesc1      := "Emite o extrato de servicos prestados pela RDA"
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD7"    


//Leonardo Portella - 17/10/13 - Virada P11 - Inicio - Foram criados novos parametros no relatorio padrao. Precisdo colocar em outra pergunta o SX1 deste relatorio.

//PRIVATE cPerg       := "PLR673" + space(nTamPerg - 6)
PRIVATE cPerg       := "PL673C" + space(nTamPerg - 6)
PRIVATE lFas35		:= .F.

//Leonardo Portella - 17/10/13 - Virada P11 - Fim

PRIVATE nRel        := "PLSR673CAB01"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Procedimento","Matricula Usuario","Impresso","Nome Usuario","Data Procedimento","Numero Guia"}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nLi         := 0
PRIVATE nLinPag     := 68
PRIVATE pMoeda1     := "@E 999,999.99"
PRIVATE pMoeda2     := "@E 999,999,999.99"
PRIVATE nTamDes     := 35
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCodOpe
PRIVATE cRdaDe
PRIVATE cRdaAte
PRIVATE cAno
PRIVATE cMes
PRIVATE cPegDe
PRIVATE cPegAte
PRIVATE nTipQbc
PRIVATE nTipRel
PRIVATE nFase
PRIVATE nNumImp
PRIVATE nImpBlq
PRIVATE cClaPre
PRIVATE cNumFat    

PRIVATE cNumFatF

PRIVATE lImpZero
PRIVATE aRet := {.T.,""}

PRIVATE lLisRes
PRIVATE lLisTit
PRIVATE nImpEnd
PRIVATE lGuiCob
PRIVATE lLisFor
Private	cLocDe    := ""
Private	cLocAte   := ""
PRIVATE dDatDe	  := stod("")
PRIVATE dDatAte	  := stod("")
PRIVATE cEspDe    := ""
PRIVATE cEspAte   := ""
PRIVATE cEmpDe	  := ""
PRIVATE cEmpAte   := ""
PRIVATE cConDe    := ""
PRIVATE cConAte   := ""
PRIVATE cSubDe    := ""
PRIVATE cSubAte   := ""
PRIVATE cPlaDe    := ""
PRIVATE cPlaAte   := ""
PRIVATE cProDe    := ""
PRIVATE cProAte   := ""
PRIVATE cLdpDe    := ""
PRIVATE cLdpAte   := ""
PRIVATE nImpMat   := 1
PRIVATE lImpLocRq := .F.
PRIVATE lImpCoPar := .F.
PRIVATE mv_par41  := ""
PRIVATE mv_par42  := ""
PRIVATE mv_par43  := ""
PRIVATE mv_par44  := ""
PRIVATE mv_par45  := ""
PRIVATE mv_par46  := ""
PRIVATE aLog      := {}
Private b673Err   := .T.   

private cfilbd7   := xFilial("BD7")    
private cfilbd6   := xFilial("BD6") 
private cfilbd5   := xFilial("BD5")
private cfilbe4   := xFilial("Be4") 

private nBD6VLRAPR :=0
/*
private cfilbd7   := ' '    
private cfilbd6   := ' ' 
private cfilbd5   := ' '
private cfilbe4   := ' '
*/
Set Century Off

If BD6->(FieldPos("BD6_PAGRDA")) == 0
	MsgStop("SIGAPLS - Campo BD6_PAGRDA nao criado, por favor entrar em contato com o Suporte.")
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AtuSXB()
CriaSX1() //nova pergunta...
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRel := SetPrint(cAlias,nRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey  == 27
	If  lCentury
		set century on
	Endif
	Return
Endif

cCodOpe   := mv_par01
cRdaDe    := mv_par02
cRdaAte   := mv_par03
cAno      := mv_par04
cMes      := mv_par05
cPegDe    := mv_par06
cPegAte   := mv_par07
nTipRel   := mv_par08
nFase     := mv_par09
nNumImp   := mv_par10
nImpBlq   := mv_par11
cClaPre   := mv_par12
cNumFat   := mv_par13
lImpZero  := If(mv_par14==1,.T.,.F.)
lLisRes   := If(mv_par15==1,.T.,.F.)
lLisTit   := If(mv_par16==1,.T.,.F.)
nImpEnd	  := mv_par17  //1=RDA --- 2=Local Atend.
lGuiCob	  := If(mv_par18==1,.T.,.F.)
lLisFor	  := If(mv_par19==1,.T.,.F.)
If  lGuiCob .and. BD6->(FieldPos("BD6_NUMSE1")) == 0
	msgalert("Para listar apenas as guias ja cobradas, eh necessario ter o campo BD6_NUMSE1 criado e atualizado BD6")
	If  lCentury
		set century on
	Endif
	Return(aRet)
Endif
cLocDe	  := mv_par20
cLocAte	  := mv_par21
dDatDe	  := mv_par22
dDatAte	  := mv_par23
cEspDe    := mv_par24
cEspAte   := mv_par25
cLdpDe    := mv_par26
cLdpAte   := mv_par27
cEmpDe	  := mv_par28
cEmpAte   := mv_par29
cConDe    := mv_par30
cConAte   := mv_par31
cSubDe    := mv_par32
cSubAte   := mv_par33
cPlaDe    := mv_par34
cPlaAte   := mv_par35
cProDe    := mv_par36
cProAte   := mv_par37
nImpMat   := mv_par38
lImpLocRq := (mv_par39 == 1)
lImpCoPar := (mv_par40 == 1)
cGuiDe    := mv_par41
cGuiAte   := mv_par42
dDatDiD	  := mv_par43
dDatDiA	  := mv_par44
cNFSSDe   := mv_par45
cNFSSAte  := mv_par46 

cNumFatF  := mv_par50
canof     := substr(cNumFatF,1,4)
cmesf     := substr(cNumFatF,5,2)
cnumlotf  := substr(cNumFatF,7,4)

//Leonardo Portella - 17/10/13 - Virada P11
lFas35 := ( mv_par47 == 1 )

If  nTipRel == 1
	lAnalitico := .T.
Else
	lAnalitico := .F.
Endif
cTitDem   += RetMesAno(cAno+cMes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

nTipQbc := aReturn[8]

If nTipQbc == 1 .or. nTipQbc == 5 .or. nTipQbc == 6
  cCabec1 := "Procedimento    Descricao                                                                        " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar, "Co-Particip","")
  cCabec2 := "Matricula              Usuario                                       Movimento        Qtd TP   Qt Ref Un   Dt.Mov. INS    Valor     "+Iif(cTamanho == "G","Desc.Loc.Atend.","")
ElseIf nTipQbc == 2 .or.  nTipQbc == 4 // Usuario
  cCabec1 := "Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar,"Co-Particip","")
  cCabec2 := "Procedimento          Descricao                                       Movimento       Qtd  TP   Qt Ref Un  Dt.Mov. INS    Valor     "+Iif(cTamanho == "G","Desc.Loc.Atend.","")
Else
  cCabec1 := "Impresso               Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar,"Co-Particip","")
  cCabec2 := "Procedimento          Descricao                                       Movimento       Qtd TP   Qt Ref Un   Dt.Mov. INS    Valor"+Iif(cTamanho == "G","Desc.Loc.Atend.","")
Endif

MsAguarde({|| R673Imp() }, cTitulo, "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera filtro do BD7                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ms_flush()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lCentury
	set century on
Endif

Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ PL673Err   ³ Autor ³Timoteo Bega         ³ Data ³ 08/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Tratamento de Erro para filtro do usuario				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ PL673Err()								 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ PLSR673()										          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL673Err(e)
If e:gencode > 0  
	If b673Err	
		msgStop("Expressão criada pelo filtro é inváida"+chr(10)+chr(10)+e:Description)
		b673Err := .F.
	Endif
EndIf

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673Imp  ³ Autor ³ Angelo Sperandio      ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime o extrato mensal dos servicos prestados            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673Imp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nInd,nFor
LOCAL   nOrd        := aReturn[8]
LOCAL   cFor
LOCAL   cOrdem
LOCAL   cInd        := CriaTrab(Nil,.F.)
LOCAL   cSQL
Local   cOri        := ""
LOCAL   aSomaGlo    := {}
LOCAL   aRetAux		:= {}
LOCAL   nVlrItem    := 0
LOCAL   nVlrGloIt   := 0
LOCAL   nVlrTotGui  := 0
LOCAL   nVlrTotNot  := 0
LOCAL   nITens      := 0
Local 	nVlrRef     := 0
Local   nVlrGRef    := 0
Local 	nVlrPRef    := 0
Local 	nVlrTotPro  := 0
Local   aProcImp    := {}
Local   lListaCab   := .F.
Local   lTemMov
Local   lTem
LOCAL   cNameBD7    := RetSQLName("BD7")
LOCAL   cNameBA3    := RetSQLName("BA3")
LOCAL   nPosLot
LOCAL   nTotVlr
LOCAL   nTotIrf
LOCAL   nTotIns
Local   nTotAcr
Local   nTotDec
LOCAL   nLiq
LOCAL   nPos
LOCAL   cImpAnt
LOCAL   cGuiAnt
LOCAL   lLocEnd		:= .F.
Local   cGlosa		:= ""
Local   cBloq       := ""
Local   cBloq1      := ""
Local   cTipGlo     := ""
Local   cDesBlo	    := ""
Local 	cDesLoc	   	:= ""
Local   nTotGlo    	:= 0
Local   cImpMat    	:= ""
LOCAL 	cBdxCodP  	:= "0"
Local   cLotBD7 	:= ""
Local   cLotBMR 	:= ""
Local   lInssUnic
Local   i
Local   cClaIns
Local   cDepIr
LOCAL 	cAcao
LOCAL 	cJusti
Local   cLocReq
Local   cCoPart
LOCAL   nI
Local   lContrRet	:= SuperGetMv("MV_BX10925",.T.,"2") == "1"  .And.;
						 (!Empty( SE5->( FieldPos( "E5_VRETPIS" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_VRETCOF" ) ) ) .And. ;
				 		  !Empty( SE5->( FieldPos( "E5_VRETCSL" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_PRETPIS" ) ) ) .And. ;
						  !Empty( SE5->( FieldPos( "E5_PRETCOF" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_PRETCSL" ) ) ) .And. ;
						  !Empty( SE2->( FieldPos( "E2_SEQBX"   ) ) ) .And. !Empty( SFQ->( FieldPos( "FQ_SEQDES"  ) ) ) )
Local   nOutImp		:= 	0
Local 	nOutBaixa   :=  0
Local   nTotOutImp  :=	0
Local 	lCposVld	:=	(BBC->(FieldPos("BBC_VLDINI")) > 0 .And. BBC->(FieldPos("BBC_VLDFIM")) > 0)
Local aStruBD7 := BD7->(DbStruct())
Local nCntFor  := 0 
Local lBaixa   := .F.
Local lISS     := .F.
Local nTemBGQ  := 0   
Local nPis	   := 0
Local nCofins  := 0
Local nCSLL    := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Matriz Principal														 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aTrbBD7 := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Controle de Glosas...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aGlosas     := {}
PRIVATE lGlosou     := .F.
PRIVATE cIni 		:= ""
PRIVATE cLinha 		:= ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtd        := 0
PRIVATE nVlrGlo     := 0
PRIVATE nVlrPag     := 0
PRIVATE nDebFix     := 0
PRIVATE nCreFix     := 0
PRIVATE nDebVar     := 0
PRIVATE nCreVar     := 0
PRIVATE nDebApo     := 0
PRIVATE nCreApo     := 0

PRIVATE ntDebFix    := 0
PRIVATE ntCreFix    := 0
PRIVATE ntDebVar    := 0
PRIVATE ntCreVar    := 0
PRIVATE ntDebApo    := 0
PRIVATE ntCreApo    := 0

PRIVATE nCreTot     := 0
PRIVATE nDebTot     := 0
PRIVATE nVlrTot     := 0
PRIVATE nVlrIRF     := 0
PRIVATE nTotal      := 0
PRIVATE cRdaAnt
PRIVATE lFirst      := .T.
Private aResProd    := {0,0,0,0,0,0,0}
Private aResProdT   := {0,0,0,0,0,0,0}
Private aTabRes     := {}
Private aTabResT    := {}
Private lTemLot     := .F.
Private lLotImp     := .F.    // indica que existe lote somente de impostos
Private cLotImp     := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ variaveis de trabalho...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cNomCre     //Nome do Credenciado completo...
PRIVATE cMovime     //Codigo do movimento
PRIVATE cEspecia
PRIVATE cOpeLot
PRIVATE cNumLot := ""
PRIVATE cDesLot := ""
PRIVATE aLotes
PRIVATE cLotes  := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Corrige base de dados                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  1 == 2 // nFase <> 2   // ??? atencao
	MsProcTxt("Analisando base de dados ...")
	ProcessMessages()
	cSQL := " SELECT BD7.R_E_C_N_O_ AS BD7_RECNO, BA3.BA3_TIPOUS FROM " + cNameBD7 + " BD7, " + cNameBA3 + " BA3 "
	cSQL += " WHERE BD7.D_E_L_E_T_ = ' ' "
	cSQL += "   AND BD7_FASE  <> '4' "
	cSQL += "   AND BA3_FILIAL = '" + xFilial("BA3") + "' "
	cSQL += "   AND BA3_CODINT = BD7_OPEUSR "
	cSQL += "   AND BA3_CODEMP = BD7_CODEMP "
	cSQL += "   AND BA3_MATRIC = BD7_MATRIC "
	cSQL += "   AND BA3.D_E_L_E_T_ = ' ' "
	cSQL += "   AND BD7_TIPUSR <> BA3_TIPOUS "

	cSQL := ChangeQuery(cSQL)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
	While ! Trb->(Eof())
		nQtd++
		MsProcTxt("Corrigindo Base... " + alltrim(str(nQtd)))
		ProcessMessages()
		BD7->(dbGoTo(Trb->BD7_RECNO))
		BD7->(RecLock("BD7",.F.))
		BD7->BD7_TIPUSR := Trb->BA3_TIPOUS
		BD7->(msUnLock())
		Trb->(dbSkip())
	Enddo
	Trb->(DbCloseArea())
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mensagem                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsProcTxt("Processando Dados...")
ProcessMessages()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta  no BD7  			                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cSql := " SELECT BD6_NOMUSR,"
cSql := "SELECT "+RetSQLName("BD7")+".R_E_C_N_O_ RECBD7"
cSql += "  FROM " + RetSQLName("BD7") //+ ", " + RetSQLName("BD6")

//cSql += "  WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND " // Joany

//Leonardo Portella - 13/12/13 - Inicio - Voltei o xFilial()

//cSql += "  WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND "
cSql += "  WHERE BD7_FILIAL = '"+cfilbd7+"' AND "

//Leonardo Portella - 13/12/13 - Fim

cSql += " BD7_CODOPE = '"+cCodOpe+"' AND "
cSql += " BD7_CODLDP >= '" +cLdpDe + "' AND BD7_CODLDP <= '" + cLdpAte + "' AND "
cSql += " BD7_CODPEG >= '" + cPegDe+ "' AND BD7_CODPEG <= '" + cPegAte + "' AND " 
cSql += " BD7_NUMERO >= '" + cGuiDe+ "' AND BD7_NUMERO <= '" + cGuiAte + "' AND "
If     nFase == 1 // pronta
	cSql += "BD7_SITUAC <> '2' AND BD7_FASE = '3' AND "
ElseIf nFase == 2 // faturada
	cSql += "BD7_SITUAC <> '2' AND BD7_FASE = '4' AND "
ElseIf nFase == 3 // conferencia
	cSql += "BD7_SITUAC <> '2' AND BD7_FASE = '2' AND "
EndIf
cSql += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "
If  ! Empty(cNumFat) .And. nFase == 2
	cSql += "BD7_OPELOT = '"+cCodOpe+"' AND BD7_NUMLOT = '"+cNumFat+"' AND "
Else
	If  nFase == 2
		cSql += "BD7_OPELOT = '"+cCodOpe+"' AND BD7_NUMLOT LIKE '"+cAno+cMes+"%' AND "
	Else
		cSql += "(BD7_ANOPAG < '" + cAno + "' OR ( BD7_ANOPAG = '" + cAno + "' AND BD7_MESPAG  <= '" + cMes + "' )) AND "
	Endif
Endif 

//Leonardo Portella - 17/10/13 - Virada P11 - Inicio

If lFas35
	cSql += " BD7_YFAS35 = 'T' AND "
EndIf

//Leonardo Portella - 17/10/13 - Virada P11 - Fim

//Leonardo Portella - 31/07/14 - Inicio - Chamado - ID: 12634

If !empty(mv_par48)//Tipo de guia
	cSql += " BD7_TIPGUI = '" + mv_par48 + "' AND "
EndIf

If mv_par49 == 1 //Somente Glosadas
	cSql += " BD7_VLRGLO > 0 AND "
Endif

//Leonardo Portella - 31/07/14 - Fim

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao generica que trata campos do estorno		   					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If FindFunction("PlReChvEst")
   	aRetAux  := PlReChvEst("BD7",.F.,.T.,.F.,.T.)
   	cSQL     += aRetAux[1]
Endif

Do Case
	Case nImpBlq == 1 // imprimir guias bloqueadas pelo sistema
		cSql += "( BD7_BLOPAG <> '1' Or (BD7_BLOPAG = '1' AND BD7_BLQAUG =  ' ') Or BD7_SITUAC = '3' ) AND "
	Case nImpBlq == 2 // imprimir guias bloqueadas por auto-gerado
		cSql += "( BD7_BLOPAG <> '1' Or (BD7_BLOPAG = '1' AND BD7_BLQAUG <> ' ') ) AND BD7_SITUAC <> '3' AND "
	Case nImpBlq == 3 // imprimir todas guias bloqueadas
		cSql += ""
	Otherwise         // nao imprimir guias bloqueadas
		cSql += "BD7_BLOPAG <> '1' AND BD7_SITUAC <> '3' AND "
EndCase

If ! lImpZero
	cSql += " BD7_VLRPAG > 0 AND"
Endif

If ! Empty(dDatAte)
	cSql += " BD7_DATPRO >= '" + DTOS(dDatDe) + "' AND BD7_DATPRO <= '" + DTOS(dDatAte) + "' AND "
Endif

If ! Empty(cEspAte)
	cSql += " BD7_CODESP >= '" + cEspDe + "' AND BD7_CODESP <= '" + cEspAte + "' AND "
Endif

If ! Empty(cEmpAte)
	cSql += " BD7_CODEMP >= '" + cEmpDe + "' AND BD7_CODEMP <= '" + cEmpAte + "' AND"
Endif

If ! Empty(cPlaAte)
	cSql += " BD7_CODPLA >= '" + cPlaDe + "' AND BD7_CODPLA <= '" + cPlaAte + "' AND "
Endif

If ! Empty(cProAte)
	cSql += " BD7_CODPRO >= '" + 	cProDe + "' AND BD7_CODPRO <= '" + cProAte + "' AND "
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Somente pega as guias de um mesma NFSS							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If BD7->(FieldPos("BD7_SEQNFS")) > 0
  If !Empty(cNFSSAte) 
  	cSQL += " ( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) AND "
  EndIf
Endif  

If  ! Empty(aReturn[7])
	cSql += PLSParSQL(aReturn[7]) + " AND "
Endif
                       
cSql += RetSQLName("BD7")+".D_E_L_E_T_ = ' '"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ BD7 COM BD6                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "
cSql += " AND BD6_CODOPE = BD7_CODOPE "
cSql += " AND BD6_CODLDP = BD7_CODLDP "
cSql += " AND BD6_CODPEG = BD7_CODPEG "
cSql += " AND BD6_NUMERO = BD7_NUMERO "
cSql += " AND BD6_ORIMOV = BD7_ORIMOV "
cSql += " AND BD6_SEQUEN = BD7_SEQUEN "
cSql += " AND BD6_CODPAD = BD7_CODPAD "
cSql += " AND BD6_CODPRO = BD7_CODPRO "
cSql += " AND " + RetSQLName("BD6")+".D_E_L_E_T_ = ' '"*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta ordem                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipQbc == 1
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_CODPAD,BD7_CODPRO,BD7_DATPRO,BD7_CODOPE,BD7_CODEMP,BD7_MATRIC,BD7_TIPREG "
ElseIf nTipQbc == 2
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_CODOPE,BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,BD7_DATPRO,BD7_CODPAD,BD7_CODPRO "
ElseIf nTipQbc == 3
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_NUMIMP,BD7_CODOPE,BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,BD7_CODPAD,BD7_CODPRO "
ElseIf nTipQbc == 4
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_NOMUSR,BD7_CODPAD,BD7_CODPRO"
ElseIf nTipQbc == 5
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_DATPRO,BD7_CODPAD,BD7_CODPRO "
ElseIf nTipQbc == 6
	cSql+= " ORDER BY BD7_FILIAL,BD7_CODRDA,BD7_NUMLOT,BD7_CODOPE,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_CODPAD,BD7_CODPRO"
EndIf                  

cSQL := ChangeQuery(cSQL)

If Empty(aReturn[7])
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBD7",.F.,.T.)
Else
	bError := ErrorBlock({|e| PL673Err(e) })
	Begin Sequence	
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBD7",.F.,.T.)
	End Sequence
EndIf

If !b673Err
	Return b673Err
EndIf

For nCntFor := 1 To Len(aStruBD7)
	If ( aStruBD7[nCntFor,2]<>"C" )
 		TcSetField("TrbBD7",aStruBD7[nCntFor,1],aStruBD7[nCntFor,2],aStruBD7[nCntFor,3],aStruBD7[nCntFor,4])
	EndIf
Next nCntFor

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montado Matriz															 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(dbSetOrder(2))                                                                                     
While !TrbBD7->( Eof() )

	BD7->(DbGoTo(TrbBD7->RECBD7))
	BA1->(DbSeek(xFilial("BA1")+BD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)))     
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lote																	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If At(BD7->BD7_NUMLOT,cLotBD7) == 0
		cLotBD7 +=  IIf(Empty(cLotBD7), "", ",") + "'" + BD7->BD7_NUMLOT + "'"
		If !Empty(cNumFat)
			cLotBMR +=  IIf(Empty(cLotBMR), "", ",") + "'" + SubStr(BD7->BD7_NUMLOT, 7, 4) + "'"
	    Endif
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Matriz																	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	{xFilial("BD7"),; // Joany
//	AaDd(aTrbBD7,  {xFilial("BD7")/*"16"*/,;		//01 - Filial    
		AaDd(aTrbBD7,  {cfilbd7    ,;	//01 - Filial
					BA1->BA1_NOMUSR,;	//02 - Nome Usuario
					BD7->BD7_CODRDA,;	//03 - Codigo Rda
					BD7->BD7_NUMLOT,;	//04 - Numero Lote
					BD7->BD7_CODOPE,;	//05 - Operadora
					BD7->BD7_CODLDP,;	//06 - Local Digitacao
					BD7->BD7_CODPEG,;	//07 - Peg
					BD7->BD7_NUMERO,;	//08 - Guia
					BD7->BD7_ORIMOV,;	//09 - Origem Movimento
					BD7->BD7_SEQUEN,;	//10 - Sequencia
					BD7->BD7_CODEMP,;	//11 - Empresa
					BD7->BD7_MATRIC,;	//12 - Matricula
					BD7->BD7_TIPREG,;	//13 - Tipo Usuarios
					BD7->BD7_CODPAD,;	//14 - Cd Tp Tabela
					BD7->BD7_CODPRO,;	//15 - Codigo Procedimento
					BD7->BD7_NUMIMP,;	//16 - Numero do Impresso
					BD7->BD7_REFTDE,;	//17 - Referencia
					BD7->BD7_VLRPAG,;	//18 - Valor Pagamento
					BD7->BD7_VLRGLO,;	//19 - Valor Glosa
					BD7->BD7_BLOPAG,;	//20 - Bloqueia Pagamento
					BD7->BD7_SITUAC,;	//21 - Situacao
					BD7->BD7_BLQAUG,;	//22 - Bloqueado pelo AG
					BD7->BD7_DESBLO,;	//23 - Descricao do Bloqueio
					Iif(BD7->( FieldPos("BD7_CLAINS") ) > 0,Iif(BD7->BD7_CLAINS == "1" ,"F" ,"J" )," "),;//24 -
					BD7->BD7_CODUNM,;	//25 - Unidade
					BD7->BD7_UNITDE,;	//26 - Unidade
					BD7->BD7_DATPRO,;	//27 - Data do Procedimento
					BD7->BD7_MODCOB,;	//28 - Modalidade Cobranca
					BD7->BD7_TIPUSR,;	//29 - Tipo de Usuario
					BD7->BD7_INTERC,;	//30 - Intercambio Sim ou Nao
					TrbBD7->RECBD7 ,;  //31 - Recno do campo
					BD7->bd7_vlrman,;	//32 - vlr considerado para pagto     //altamiro 19/05/2015
					BD7->bd7_vlrapr})	//33 - Vlr apresentado para cobranca  //altamiro 19/05/2015   
					 						    
					TrbBD7->( DbSkip() )
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho													 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbBD7->( DbCloseArea() )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(cMes)) + "/" + cAno
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona indices                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BD5->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BR8->(DbSetOrder(1))
BDX->(DbSetOrder(1))
BAF->(dbSetOrder(1))
BB8->(dbSetOrder(1))
SA2->(dbSetOrder(1))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra BAU-Rede de Atendimento                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT R_E_C_N_O_ BAU_RECNO FROM " + RetSQLName("BAU")
cSQL += " WHERE BAU_FILIAL  = '" + xFilial("BAU") + "' AND "
cSQL += "       BAU_CODIGO >= '" + cRdaDe    + "' AND BAU_CODIGO <= '" + cRdaAte    + "' AND "
cSQL += "D_E_L_E_T_ = ''"
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBAU",.F.,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cada RDA                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! TrbBAU->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Verificando... " + Left(AllTrim(BAU->BAU_NOME),30))
	ProcessMessages()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona BAU-Rede de Atendimento                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbGoTo(TrbBAU->BAU_RECNO))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona SA2-Fornecedores                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  lLisFor
		SA2->(msSeek(xFilial("SA2")+BAU->(BAU_CODSA2+BAU_LOJSA2)))
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA pertence ao grupo informado                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  ! empty(cClaPre) .and. ! BAU->BAU_TIPPRE $ cClaPre
		TrbBAU->(DbSkip())
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA existe para a operadora desejada                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAW->(DbSetOrder(1))
	If  ! BAW->(msSeek(xFilial("BAW")+BAU->BAU_CODIGO+cCodOpe))
		TrbBAU->(DbSkip())
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe movimento de producao medica para a rda               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lTemMov := .F.                                        
//	xFilial("BD7") // Joany
//	If aScan( aTrbBD7 , { |x| x[1]+x[3] == xFilial("BD7")/*"16"*/+BAU->BAU_CODIGO } ) > 0   
	If aScan( aTrbBD7 , { |x| x[1]+x[3] == cfilbd7 +BAU->BAU_CODIGO } ) > 0
		lTemMov := .T.
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se tem debito/credito                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nFase <> 2 // diferente de faturado
		cSQL := " SELECT COUNT(*) QTD FROM " + RetSQLName("BBC")
		cSQL += " WHERE BBC_FILIAL =  '" + xFilial("BBC")  + "' AND "
		cSQL += "       BBC_CODIGO =  '" + BAU->BAU_CODIGO + "' AND "
		cSQL += "       BBC_STATUS =  '1' AND "
		cSQL += "       BBC_PROMED =  '1' AND "
		If lCposVld // BOPS 98697
			cSQL += " ( '" + cAno + cMes + "01' >= BBC_VLDINI ) AND "
			cSQL += " ( ( '" + DtoS(LastDay(CtoD("01/"+cMes+"/"+cAno))) + "' <= BBC_VLDFIM ) OR ( BBC_VLDFIM = '        ' ) ) AND "
		EndIf
		cSQL += "       D_E_L_E_T_ = '' "
		cSQL := ChangeQuery(cSQL)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBBC",.F.,.T.)

		If  TrbBBC->QTD > 0
			lTemMov := .T.
		Endif
		TrbBBC->(DbCloseArea())
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se tem debito/credito                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := " SELECT BGQ_NUMLOT FROM " + RetSQLName("BGQ")
	cSQL += " WHERE BGQ_FILIAL =  '" + xFilial("BGQ") + "' AND "
	cSQL += "       BGQ_CODIGO =  '" + BAU->BAU_CODIGO + "' AND "
	cSQL += "       BGQ_ANO    =  '" + cAno            + "' AND "
	cSQL += "       BGQ_MES    =  '" + cMes            + "' AND "
	If  nFase == 2 // Faturado
		cSQL += "   BGQ_NUMLOT <> '" + space(10)       + "' AND "
		If ! Empty(dDatAte) .And. ! Empty(cLotBD7) .And. !Empty(cNumFat)
			cSQL += "   BGQ_NUMLOT IN (" + cLotBD7 + ") AND "
		EndIf
	Else
		cSQL += "   BGQ_NUMLOT =  '" + space(10)       + "' AND "
	Endif
	cSQL += "D_E_L_E_T_ = ' '"
	cSQL := ChangeQuery(cSQL)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBGQ",.F.,.T.)
	nTemBGQ := 0 
	
	TrbBGQ->( dbEval({|| nTemBGQ ++,IIf(!Empty(cNumFat),"",cLotBMR +=IIf(Empty(cLotBMR), "", ",");
										 + "'" + SubStr(TrbBGQ->BGQ_NUMLOT, 7, 4) + "'")}) )
    If nTemBGQ > 0
	   lTemMov := .T. 
	Endif
	TrbBGQ->(DbCloseArea()) 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se tem apontamento de producao                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := " SELECT COUNT(*) QTD FROM " + RetSQLName("BCE")
	cSQL += " WHERE BCE_FILIAL =  '" + xFilial("BCE") + "' AND "
	cSQL += "       BCE_CODIGO =  '" + BAU->BAU_CODIGO + "' AND "
	cSQL += "       BCE_CODINT =  '"+  cCodOpe         +"'  AND "
	cSQL += "       BCE_ANOPAG =  '" + cAno            + "' AND "
	cSQL += "       BCE_MESPAG =  '" + cMes            + "' AND "
	If nFase == 2 // Faturado
	   cSQL += "   BCE_NUMLOT <> '" + space(10)       + "' AND "
	   If ! Empty(dDatAte) .And. ! Empty(cLotBD7) .And. !Empty(cNumFat)
	      cSQL += "   BCE_NUMLOT IN (" + cLotBD7 + ") AND "
	   EndIf
	Else
	   cSQL += "   BCE_NUMLOT =  '" + space(10)       + "' AND "
	Endif
	cSQL += "D_E_L_E_T_ = ''"
	cSQL := ChangeQuery(cSQL)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBCE",.F.,.T.)

	If TrbBCE->QTD > 0
	   lTemMov := .T.
	Endif
	TrbBCE->(DbCloseArea())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a RDA teve alguma movimentacao                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  ! lTemMov
		TrbBAU->(DbSkip())
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mensagem de processamento                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Imprimindo... " + Left(AllTrim(BAU->BAU_NOME),30))
	ProcessMessages()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis relativas a RDA                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  BAU->BAU_CALIMP $ "1,3"
		cDepIr := " Dependentes IR: " + PLSDEPIR(BAU->BAU_CODIGO,cAno,cMes)
	Else
		cDepIr := ""
	Endif
	cEspecia  := PLSLISESP(BAU->BAU_CODIGO)
	aLotes    := {}
	lInssUnic := .F.
	If  nFase == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta query                                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSQL := " SELECT BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
		cSQL += "  FROM " + RetSQLName("BMR")
		cSQL += "  WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
		cSQL += "    AND BMR_OPERDA = '" + cCodOpe + "' "
		cSQL += "    AND BMR_CODRDA = '" + BAU->BAU_CODIGO + "' "
		cSQL += "    AND BMR_OPELOT = '" + cCodOpe + "' "    
		if !Empty(cNumFatF)
   		    cSQL += "    AND BMR_ANOLOT = '" + cAnoF    + "' "
		    cSQL += "    AND BMR_MESLOT = '" + cMesf    + "' "
		    If !Empty(dDatAte) .And. ! Empty(cnumlotF)
		     	cSQL += "    AND BMR_NUMLOT IN (" + cnumlotF+ ") "
		    EndIf
		Else  
		    cSQL += "    AND BMR_ANOLOT = '" + cAno    + "' "
		    cSQL += "    AND BMR_MESLOT = '" + cMes    + "' "
		    If !Empty(dDatAte) .And. ! Empty(cLotBMR)
		     	cSQL += "    AND BMR_NUMLOT IN (" + cLotBMR + ") "                                                    
		    EndIf 
		EndIf     
		cSQL += "    AND D_E_L_E_T_ = ' ' "
		cSQL += " GROUP BY BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
		cSQL += " ORDER BY BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Executa query                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSQL := ChangeQuery(cSQL)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)

		BMR->(DbSetOrder(1))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa arquivo de trabalho                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cLotes := ""
		While ! Trb->(eof())
			cLotes += "'" + Trb->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "',"
			BMR->(msSeek(Trb->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))
			If  BMR->BMR_CODLAN < "170" // nao eh um lote apenas de impostos
				aadd(aLotes,{cCodOpe,Trb->BMR_ANOLOT+Trb->BMR_MESLOT+Trb->BMR_NUMLOT})
			Else
				aadd(aLotes,{cCodOpe,Trb->BMR_ANOLOT+Trb->BMR_MESLOT+Trb->BMR_NUMLOT})
				lLotImp := .T.
				cLotImp := Trb->BMR_ANOLOT+Trb->BMR_MESLOT+Trb->BMR_NUMLOT
			Endif
			Trb->(dbSkip())
		Enddo
		Trb->(dbCloseArea())
		cLotes := alltrim(cLotes)
		If  right(cLotes,1) == ","
			clotes := "(" + substr(cLotes,1,len(cLotes)-1) + ")"
		Endif
	Else
		aadd(aLotes,{space(4),space(10)})
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aResProdT := {0,0,0,0,0,0,0}
	aTabResT  := {}
	ntBIss    := 0
	ntIss     := 0
	ntBPis    := 0
	ntPis     := 0
	ntBCofins := 0
	ntCofins  := 0
	ntBIR     := 0
	ntIR      := 0
	ntBCSLL   := 0
	ntCSLL    := 0
	ntBINSSPF := 0
	ntINSSPF  := 0
	ntBINSSPJ := 0
	ntINSSPJ  := 0
	ntBINSSJF := 0
	ntINSSJF  := 0
	ntPINSSPJ := 0
	ntPINSSPF := 0
	ntCrPINSS := 0
	lFirst    := .T.
	ntDebFix  := 0
	ntCreFix  := 0
	ntDebVar  := 0
	ntCreVar  := 0
	ntDebApo  := 0
	ntCreApo  := 0
	cRdaAnt   := BAU->BAU_CODIGO
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa todos os lotes da RDA                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nPosLot := 1 to len(aLotes)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta cabecalho                                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  lAnalitico
			If nTipQbc == 1 .or. nTipQbc == 5
			  cCabec1 := "Procedimento    Descricao                                                                        " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar, "Co-Particip","")
			  cCabec2 := "Matricula              Usuario                                       Movimento        Qtd TP   Qt Ref Un   Dt.Mov. INS    Valor     "+Iif(cTamanho == "G","Desc.Loc.Atend.","")
			ElseIf nTipQbc == 2 .or.  nTipQbc == 4 // Usuario
			  cCabec1 := "Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar,"Co-Particip","")
			  cCabec2 := "Procedimento          Descricao                                       Movimento       Qtd  TP   Qt Ref Un  Dt.Mov. INS    Valor     "+Iif(cTamanho == "G","Desc.Loc.Atend.","")
	        ElseIf nTipQbc == 6
              cCabec1 := "Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao     ","") + IIf(lImpCoPar,"Co-Particip","")
              cCabec2 := "Procedimento          Descricao                                       Movimento       Qtd  TP   Qt Ref Un  Dt.Mov. INS    Valor     "+Iif(cTamanho == "G","Desc.Loc.Atend.","")
			Else
			  cCabec1 := "Impresso               Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar,"Co-Particip","")
			  cCabec2 := "Procedimento          Descricao                                       Movimento       Qtd TP   Qt Ref Un   Dt.Mov. INS    Valor"+Iif(cTamanho == "G","Desc.Loc.Atend.","")
			Endif
		Else
			cCabec1 := "Tipo Debito/Credito           Descricao                                   Credito         Debito"
			cCabec2 := ""
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa variaveis relativas ao lote                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOpeLot := aLotes[nPosLot,1]
		cNumLot := aLotes[nPosLot,2]
		BAF->(msSeek(xFilial("BAF") + cOpeLot + cNumLot))
		cDesLot := BAF->BAF_HISTIT
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa variaveis                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aResProd := {0,0,0,0,0,0,0}
		aTabRes  := {}
		nVlrPag  := 0
		nVlrGlo  := 0
		nDebFix  := 0
		nCreFix  := 0
		nDebVar  := 0
		nCreVar  := 0
		nCreApo  := 0
		nDebTot  := 0
		nCreTot  := 0
		nTotal   := 0
		aGlosas  := {}
		lTem    := .F.
		lTemLot := .F.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa variaveis                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProAnt := "" //BD7->(BD7_CODPAD+BD7_CODPRO)
		cUsuAnt := "" //BD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)
		cImpAnt := "" //BD7->(BD7_NUMIMP+BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)
        cGuiAnt := ""
		lFirst    := .T.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa todas as guias deste lote                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//		xFilial("BD7") // Joany
//		nPos := aScan( aTrbBD7 , { |x| x[1]+x[3]+x[4] == xFilial("BD7")/*"16"*/+BAU->BAU_CODIGO+cNumLot } )  
        If empty( cNumFatF )
       	   nPos := aScan( aTrbBD7 , { |x| x[1]+x[3]+x[4] == cfilbd7 +BAU->BAU_CODIGO+cNumLot } )
       	else                                                                                      
           nPos := aScan( aTrbBD7 , { |x| x[1]+x[3]+x[4] == cfilbd7 +BAU->BAU_CODIGO+cNumFat } )
       	EndIf 
		If lAnalitico
			If nPos > 0 .Or. (nPos == 0 .And. lLisRes)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime dados da RDA                                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				R673RDA()
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Producao medica                                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cLinha := Replicate('-',nLimite)
				R673Linha(cLinha,1,0)
				cLinha := "Producao Medica"
				R673Linha(cLinha,1,0)
			EndIf  
		EndIf
		If nPos > 0
			For nI := nPos To Len(aTrbBD7)          
			  if empty(cnumfatf)
				 If aTrbBD7[nI,3] <> BAU->BAU_CODIGO .Or. aTrbBD7[nI,4] <> cNumLot
				    Exit
				 EndIf           
			  Else               
                 If aTrbBD7[nI,3] <> BAU->BAU_CODIGO .Or. aTrbBD7[nI,4] <> cNumfat
				    Exit
				 EndIf           
			  EndIf 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona BD6-Item da Guia                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  aTrbBD7[nI,1]+aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]+aTrbBD7[nI,9]+aTrbBD7[nI,10] <>;
					BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
//					xFilial("BD6") // Joany
//					BD6->( msSeek( xFilial("BD6")/*"16"*/+aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]+aTrbBD7[nI,9]+aTrbBD7[nI,10] ) )
					BD6->( msSeek( cfilbd6 +aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]+aTrbBD7[nI,9]+aTrbBD7[nI,10] ) )   
					nBD6VLRAPR:= bd6->BD6_VLRAPR
				Endif  
								 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ BOPS 103585 - Verifica "Data Digitacao" para cada procedimento.    ³
				//³               Esta verificacao era feita no cabecalho (BD5/BE4),   ³
				//³               porem pode ocorrer de haver procedimentos com data   ³
				//³               de digitacao diferente da informada no cabecalho.    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !(BD6->BD6_DTDIGI  >= dDatDiD .And. BD6->BD6_DTDIGI <= dDatDiA) .And. !Empty(dDatDiA)
					Loop
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona BD5,BE4-Capa da Guia                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If aTrbBD7[nI,9] == '2' .And. aTrbBD7[nI,1]+aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] <> ;
					BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
//					xFilial("BE4") // Joany
//					BE4->( MsSeek( xFilial("BE4")/*"16"*/+aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] ) )
					BE4->( MsSeek( cfilbe4  +aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] ) )
					
					cDesLoc := Posicione("BB8",1,xFilial("BB8")+BE4->(BE4_CODRDA+BE4_OPERDA+BE4_CODLOC+BE4_LOCAL),"BB8_DESLOC")
					
					If !(BE4->BE4_LOCAL  >= cLocDe .And. BE4->BE4_LOCAL <= cLocAte) .And. !Empty(cLocAte)
						Loop
					Endif
					
					If !(BE4->BE4_CONEMP  >= cConDe .And. BE4->BE4_CONEMP <= cConAte) .And. !Empty(cConAte)
						Loop
					Endif
					
					If !(BE4->BE4_SUBCON  >= cSubDe .And. BE4->BE4_SUBCON <= cSubAte) .And. !Empty(cSubAte)
						Loop
					Endif
					
				Else                                                                                                
//					BD5->( MsSeek( xFilial("BD5")/*"16"*/+aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] ) )
					BD5->( MsSeek( cfilbd5 +aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] ) )
					cDesLoc := Posicione("BB8",1,xFilial("BB8")+BD5->(BD5_CODRDA+BD5_OPERDA+BD5_CODLOC+BD5_LOCAL),"BB8_DESLOC")
					
					If !(BD5->BD5_LOCAL >= cLocDe .And. BD5->BD5_LOCAL <= cLocAte) .and. !Empty(cLocAte)
						Loop
					Endif
					
					If !(BD5->BD5_CONEMP  >= cConDe .And. BD5->BD5_CONEMP <= cConAte) .and. !Empty(cConAte)
						Loop
					Endif
					
					If !(BD5->BD5_SUBCON  >= cSubDe .And. BD5->BD5_SUBCON <= cSubAte) .and. !Empty(cSubAte)
						Loop
					Endif
					
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se deve listar apenas guias cobradas                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  nFase == 1 .And. lGuiCob .And. BD6->(FieldPos("BD6_NUMSE1")) > 0 .And. Empty(BD6->BD6_NUMSE1) // pagar somente guias ja cobradas
					Loop
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona BA1-Usuarios                                                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) <> aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13]
					If !BA1->( MsSeek( xFilial("BA1")+aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] ) )
						Loop
					EndIf
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona BR8-Tabela Padrao                                              ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  BR8->(BR8_CODPAD+BR8_CODPSA) <> aTrbBD7[nI,14]+aTrbBD7[nI,15]
					BR8->( MsSeek( xFilial("BR8")+aTrbBD7[nI,14]+aTrbBD7[nI,15] ) )
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica quebra                                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nImpMat == 1
					cImpMat := BD6->BD6_MATUSA
				ElseIf nImpMat == 2
					cImpMat := "1"
				Else
					cImpMat := "2"
				EndIf
				If  lAnalitico
					cLocReq := IIf(lImpLocRq, PadR(X3Combo("BD6_LOCREQ",BD6->BD6_LOCREQ),20), "")
					cCoPart := IIf(lImpCoPar, IIf(BD6->BD6_VLRTPF > 0,"Sim","Nao"), "")
					Do Case
						Case nTipQbc == 1 .Or. nTipQbc == 5 // Procedimento
							If  cProAnt <> aTrbBD7[nI,14]+aTrbBD7[nI,15] .And. ! lFirst
								cLinha := Space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
								R673Linha(cLinha,1,0)
								nTotal := 0
							Endif
							If  cProAnt <> aTrbBD7[nI,14]+aTrbBD7[nI,15] .or. lFirst
								cLinha := TransForm(aTrbBD7[nI,14]+aTrbBD7[nI,15],"@R !! !!.!!.!!!-!") + "  " + substr(BR8->BR8_DESCRI,1,80) + Space(1) + cLocReq + Space(1) + cCoPart
								R673Linha(cLinha,1,0)
							Endif
							If  cUsuAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] .Or. lFirst
								If ExistBlock("P673MATR")
									Execblock("P673MATR",.F.,.F.,{nTipQbc,cIni,cLinha})
	                        	Else
									If  cImpMat == "1"
										cIni := PadR(transform(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"@R !!!!.!!!!.!!!!!!.!!-!"),21) + space(2) + substr(BA1->BA1_NOMUSR,1,42) + space(1)
									Else
										If  len(alltrim(BD6->BD6_MATANT)) == 17
											cIni := PadR(Transform(BD6->BD6_MATANT,"@R !!!!.!!!!.!!!!!!.!!-!"),21) + space(2) + substr(BA1->BA1_NOMUSR,1,42) + space(1)
										Else
											cIni := PadR(Transform(BD6->BD6_MATANT,"@R !!!.!!!!.!!!!!!.!!-!"),21) + space(2) + substr(BA1->BA1_NOMUSR,1,42) + space(1)
										Endif
									Endif
							  	EndIf
							Endif
						Case nTipQbc == 2 .or.  nTipQbc == 4// Usuario
							If  cUsuAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] .and. ! lFirst
								cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
								R673Linha(cLinha,1,0)
								nTotal := 0
							Endif
							If  cUsuAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] .or. lFirst
								If ExistBlock("P673MATR")
									Execblock("P673MATR",.F.,.F.,{nTipQbc,cIni,cLinha})
								Else
									If  cImpMat == "1"
										cLinha := PadR(transform(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"@R !!!!.!!!!.!!!!!!.!!-!"),21) + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
									Else
										If  len(alltrim(BD6->BD6_MATANT)) == 17
											cLinha := PadR(Transform(BD6->BD6_MATANT,"@R !!!!.!!!!.!!!!!!.!!-!"),21) + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
										Else
											cLinha := PadR(Transform(BD6->BD6_MATANT,"@R !!!.!!!!.!!!!!!.!!-!") ,21)+ "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
										Endif
									Endif
								EndIf
								R673Linha(cLinha,1,0)
							Endif
							If  cProAnt <> aTrbBD7[nI,14]+aTrbBD7[nI,15] .Or. lFirst
								cIni := aTrbBD7[nI,14] 					+ space(2) + ;
										aTrbBD7[nI,15]	            	+ space(2) + ;
										SubStr(BD6->BD6_DESPRO,1,42) 	+ space(2)
							Endif
						Case nTipQbc == 3 // Impresso
							If  cImpAnt <> aTrbBD7[nI,16]+aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] .And. ! lFirst
								cLinha := Space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
								R673Linha(cLinha,1,0)
								nTotal := 0
							Endif
							If  cImpAnt <> aTrbBD7[nI,16]+aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13] .Or. lFirst
								If  cImpMat == "1"
									cLinha := BD6->BD6_NUMIMP + "-" + aTrbBD7[nI,10] + "   " + PadR(Transform(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"@R !!!!.!!!!.!!!!!!.!!-!"),21) + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
								Else
									If  len(alltrim(BD6->BD6_MATANT)) == 17
										cLinha := BD6->BD6_NUMIMP + "-" + aTrbBD7[nI,10] + "   " + PadR(Transform(BD6->BD6_MATANT,"@R !!!!.!!!!.!!!!!!.!!-!"),21) + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
									Else
										cLinha := BD6->BD6_NUMIMP + "-" + aTrbBD7[nI,10] + "   " + PadR(Transform(BD6->BD6_MATANT,"@R !!!.!!!!.!!!!!!.!!-!"),21) + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
									Endif
								Endif
								R673Linha(cLinha,1,0)
							Endif
							If  cProAnt <> aTrbBD7[nI,14]+aTrbBD7[nI,15] .Or. lFirst
								cIni := aTrbBD7[nI,14]				+ space(2) + ;
										aTrbBD7[nI,15]	            + space(2) + ;
										substr(BD6->BD6_DESPRO,1,42) + space(2)
                      		Endif
                 		Case nTipQbc == 6
                 		 	If  cGuiAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] .and. ! lFirst	
                          		cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
                          		R673Linha(cLinha,1,0)
                          		nTotal := 0
                      		Endif
                      		If  cGuiAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8] .or. lFirst	
                          		If ExistBlock("P673MATR")
                          			Execblock("P673MATR",.F.,.F.,{nTipQbc,cIni,cLinha})	
		                      	Else
		                          	If  cImpMat == "1"
										cLinha := transform(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"@R !!!!.!!!!.!!!!!!.!!-!") + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
									Else
										If  len(alltrim(BD6->BD6_MATANT)) == 17
											cLinha := Transform(BD6->BD6_MATANT,"@R !!!!.!!!!.!!!!!!.!!-!") + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
										Else
											cLinha := Space(1)+Transform(BD6->BD6_MATANT,"@R !!!.!!!!.!!!!!!.!!-!") + "  " + PadR(BA1->BA1_NOMUSR, 42) + Space(1) + cLocReq + Space(1) + cCoPart
										Endif
									Endif
								Endif
								R673Linha(cLinha,1,0)
							Endif
							If  cGuiAnt+cProAnt <> aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]+aTrbBD7[nI,14]+aTrbBD7[nI,15] .or. lFirst
								cIni := aTrbBD7[nI,14]              + space(2) + ;
										aTrbBD7[nI,15]              + space(2) + ;
										substr(BD6->BD6_DESPRO,1,42) + space(2) 
							Endif
					EndCase
				Endif
				lFirst := .F.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicializa variaveis                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  nNumImp == 3
					cMovime := aTrbBD7[nI,7] + '-' + aTrbBD7[nI,8] + '-' + aTrbBD7[nI,10]
				Elseif  nNumImp == 1
					cMovime := Space(8) + '-' + aTrbBD7[nI,8] + '-' + aTrbBD7[nI,10]
				Else
					If  ! empty(BD6->BD6_NUMIMP)
						cMovime := Space(1) + BD6->BD6_NUMIMP + '-' + aTrbBD7[nI,10]
					Else
						cMovime := Space(8) + '-' + aTrbBD7[nI,8] + '-' + aTrbBD7[nI,10]
					Endif
				Endif
				nVlrRef   := aTrbBD7[nI,17] * BD6->BD6_QTDPRO // ??? ags
				nVlrItem  := If(BAU->BAU_PAGPRO $ "1, ",Round(aTrbBD7[nI,18],2),0)
				nVlrGloIt := If(BAU->BAU_PAGPRO $ "1, " .And. BD6->BD6_PAGRDA <> "1",Round(aTrbBD7[nI,19],2),0)
				If  BAU->BAU_PAGPRO $ "1, " .and. (aTrbBD7[nI,20] == "1" .OR. aTrbBD7[nI,21] == "3") .And. BD6->BD6_PAGRDA <> "1"
					nVlrGloIt := nVlrItem
					nVlrItem  := 0
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existe bloqueio                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cGlosa  := " "
				cBloq   := " "
				cBloq1  := " "
				cDesBlo := ""
				If     aTrbBD7[nI,20] = '1' // bloqueado pelo BD7
					cBloq   := "B"
					If  aTrbBD7[nI,22] $ "1,2"
						cBloq1  := "A"
						cDesBlo := "BLOQUEADO PELA ROTINA DE AUTO-GERADO"
					Else
						cBloq1  := "S"
						cDesBlo := aTrbBD7[nI,23]
					Endif
				ElseIf aTrbBD7[nI,21] = '3' // bloqueado pelo menu
					cBloq   := "B"
					cBloq1  := "S"
					cDesBlo := aTrbBD7[nI,23]
				Else
					cGlosa := IF(nVlrGloIt > 0,"G"," ")
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime linha de detalhe                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  lAnalitico
					
					cClaIns := aTrbBD7[nI,24]
					
					Do Case
						Case nTipQbc == 1 .or. nTipQbc = 5 // Procedimento       
                                    //	Str(BD6->BD6_QTDPRO,3)		+ space(1) + ;
									//	aTrbBD7[nI,25]				+ space(1) + ;
									//	Str(nVlrRef,7,2)			+ space(1) + ;

							cLinha := 	cIni 						+ space(1) + ;	
										PadR(cMovime,21)			+ space(1) + ; 
										Str(aTrbBD7[nI,32],7,2)    + space(1) + ; 
										Str(aTrbBD7[nI,33],7,2)    + space(1) + ;
										aTrbBD7[nI,26]				+ space(1) + ;
										dtoc(aTrbBD7[nI,27])		+ space(1) + ;
										cClaIns						+ space(1) + ;
										TransForm(nVlrItem,pMoeda1)	+ space(1) + ;
										cGlosa						+ ; 
										Str(aTrbBD7[nI,19],7,2)    + space(1) + ;
										cBloq						+ space(1) +;
	        	                    IIf(cTamanho == "G",cDesLoc,"")
	                      cLinha := IIF(Empty(SubStr(cLinha,1,8)),SubStr(cLinha,9),cLinha)
	                      R673Linha(cLinha,1,0)
	                      cIni := Space(74)
						Case nTipQbc == 2 .or. nTipQbc ==4 // Usuario
							cLinha := 	cIni 						+ space(1) + ;	
										PadR(cMovime,21)			+ space(1) + ;
                                    	Str(aTrbBD7[nI,32],7,2)    + space(1) + ;
										Str(aTrbBD7[nI,33],7,2)    + space(1) + ;
										aTrbBD7[nI,26]				+ space(1) + ;
										DtoC(aTrbBD7[nI,27])		+ space(1) + ;
										cClaIns						+ space(1) + ;
										TransForm(nVlrItem,pMoeda1)	+ space(1) + ;
										cGlosa						+ ;       
										Str(aTrbBD7[nI,19],7,2)    + space(1) + ;
										cBloq						+ space(1) +;
	        	                    IIf(cTamanho == "G",cDesLoc,"")
	                      cLinha := IIF(Empty(SubStr(cLinha,1,8)),SubStr(cLinha,9),cLinha)
	                      R673Linha(cLinha,1,0)
	                      cIni := Space(74)
						Case nTipQbc == 3 // Impresso
							cLinha := 	cIni 						+ space(1) + ;	
										PadR(cMovime,21)			+ space(1) + ;
										Str(aTrbBD7[nI,32],7,2)    + space(1) + ;
										Str(aTrbBD7[nI,33],7,2)    + space(1) + ;
										aTrbBD7[nI,26]				+ space(1) + ;
										DtoC(aTrbBD7[nI,27])		+ space(1) + ;
										cClaIns						+ space(1) + ;
										TransForm(nVlrItem,pMoeda1)	+ space(1) + ;
										cGlosa						+  ;     
										Str(aTrbBD7[nI,19],7,2)    + space(1) + ;
										cBloq						+ space(1) +;
	        	                    IIf(cTamanho == "G",cDesLoc,"")
	                      cLinha := IIF(Empty(SubStr(cLinha,1,8)),SubStr(cLinha,9),cLinha)
	                      R673Linha(cLinha,1,0)
	                      cIni := Space(74)
                 		Case nTipQbc == 6     
                 			cLinha :=   cIni						+ space(1) + ;
                                		PadR(cMovime,21)			+ space(1) + ;
										Str(aTrbBD7[nI,32],7,2)    + space(1) + ;
										Str(nBD6VLRAPR,7,2)    + space(1) + ;
                        		        aTrbBD7[nI,26]				+ space(1) + ;
		                                dtoc(aTrbBD7[nI,27])		+ space(1) + ;
        		                        cClaIns						+ space(1) + ;
              			                TransForm(nVlrItem,pMoeda1)	+ space(1) + ;
        	            		        cGlosa						+ ;     
   										Str(aTrbBD7[nI,19],7,2)    + space(1) + ;
		        	                    cBloq						+ space(1) +;
        		                    IIf(cTamanho == "G",cDesLoc,"")
                      	  cLinha := IIF(Empty(SubStr(cLinha,1,8)),SubStr(cLinha,9),cLinha)
                      	  R673Linha(cLinha,1,0)
                      	  cIni := space(74)  
                      	  nBD6VLRAPR:=0
					EndCase
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Controle sobre glosas...                                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  ! empty(cGlosa) .or. ! empty(cBloq)
					If     cBloq1 == "S"
						cTipGlo := "Bl. Manual"
					ElseIf cBloq1 == "A"
						cTipGlo := "Bl.Aut-Ger"
					Else
						cTipGlo := "Glosa     "
					Endif
					aadd(aGlosas,{aTrbBD7[nI,31],;
					aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]+aTrbBD7[nI,9]+aTrbBD7[nI,14]+aTrbBD7[nI,15]+aTrbBD7[nI,10],;
					nVlrGloIt,;
					cMovime,;
					aTrbBD7[nI,25],;
					cTipGlo,;
					cDesBlo})
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Salva campos de quebra                                                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cProAnt := aTrbBD7[nI,14]+aTrbBD7[nI,15]
				cUsuAnt := aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13]
				cImpAnt := aTrbBD7[nI,16]+aTrbBD7[nI,5]+aTrbBD7[nI,11]+aTrbBD7[nI,12]+aTrbBD7[nI,13]
	            cGuiAnt := aTrbBD7[nI,5]+aTrbBD7[nI,6]+aTrbBD7[nI,7]+aTrbBD7[nI,8]
				lTem := .T.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Acumula valores                                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTotal  += nVlrItem
				nVlrPag += nVlrItem
				Do Case
					Case aTrbBD7[nI,28] <> '1' .And. aTrbBD7[nI,29] = '1' .And. aTrbBD7[nI,30] <> '1'
						aResProd[1]  += nVlrItem   //Custo Operacional PF
						aResProdT[1] += nVlrItem   //Custo Operacional PF
					Case aTrbBD7[nI,28] <> '1' .And. aTrbBD7[nI,29] = '2' .And. aTrbBD7[nI,30] <> '1'
						aResProd[2]  += nVlrItem   //Custo Operacional PJ
						aResProdT[2] += nVlrItem   //Custo Operacional PJ
					Case aTrbBD7[nI,28] = '1' .And. aTrbBD7[nI,29] = '1' .And. aTrbBD7[nI,30] <> '1'
						aResProd[3]  += nVlrItem   //Pre Pagamento PF
						aResProdT[3] += nVlrItem   //Pre Pagamento PF
					Case aTrbBD7[nI,28] = '1' .And. aTrbBD7[nI,29] = '2' .And. aTrbBD7[nI,30] <> '1'
						aResProd[4]  += nVlrItem   //Pre Pagamento PJ
						aResProdT[4] += nVlrItem   //Pre Pagamento PJ
					Case aTrbBD7[nI,30] = '1'
						aResProd[5]  += nVlrItem   //Intercambio
						aResProdT[5] += nVlrItem   //Intercambio
					OtherWise
						aResProd[6]  += nVlrItem   //Outros
						aResProdT[6] += nVlrItem   //Outros
						aadd(aLog,{aTrbBD7[nI,5]+"."+aTrbBD7[nI,6]+"."+aTrbBD7[nI,7]+"."+aTrbBD7[nI,8]+"."+aTrbBD7[nI,9]+"."+aTrbBD7[nI,10],aTrbBD7[nI,29],aTrbBD7[nI,28],aTrbBD7[nI,30] } )
				EndCase
			Next
		EndIf	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime total da producao medica do lote                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  lAnalitico
			If  ! lTem 
				If lLisRes
					cLinha := "Nenhum lancamento ref producao medica"
					R673Linha(cLinha,2,1)
				EndIf
			Else
				If     nTipQbc == 1 .or. nTipQbc == 5
					cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,1,0)
					cLinha := space(90) + "Total da producao medica: " + TransForm(nVlrPag,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,2,0)
				ElseIf nTipQbc == 2 .or.  nTipQbc == 4// Usuario
					cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,1,0)
					cLinha := space(90) + "Total da producao medica: " + TransForm(nVlrPag,pMoeda2)  // ver caso negativo ags ???
                    R673Linha(cLinha,2,0)
                ElseIf nTipQbc == 6
                    cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
                    R673Linha(cLinha,1,0)
                    cLinha := space(90) + "Total da producao medica: " + TransForm(nVlrPag,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,2,0)
				Else
					cLinha := space(90) + "Total:                    " + TransForm(nTotal,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,1,0)
					cLinha := space(90) + "Total da producao medica: " + TransForm(nVlrPag,pMoeda2)  // ver caso negativo ags ???
					R673Linha(cLinha,2,0)
				Endif
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lista glosas                                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  Len(aGlosas) > 0
				cLinha := "Glosa/Bloqueio  Movimento            Par      Valor Motivo Glosa/Bloqueio"
				R673Linha(cLinha,1,0)
				cLinha := "--------------- -------------------- --- ---------- --------------------------------------------------------------------------------"
				R673Linha(cLinha,1,0)
				nTotal := 0
				For I := 1 To Len(aGlosas)
					
					BD7->( DbGoTo(aGlosas[I,1]) )
					
					If !Empty(cJusti) .And. cBdxCodP <> BD7->BD7_CODPRO
						R673Linha(Space(52)+cJusti,1,0)
						cJusti := ""
					EndIf
					
					nTotal += aGlosas[i,3]
					
					cGlosa := SubStr(alltrim(aGlosas[i,4])+Space(20),1,20) + Space(1) + ;
					aGlosas[i,5] + Space(1) + ;
					TransForm(aGlosas[i,3],pMoeda1)
					
					If  !Empty(aGlosas[i,7])
						cLinha := aGlosas[i,6] + Space(6) + cGlosa + Space(1) + aGlosas[i,7]
						R673Linha(cLinha,1,0)
					Else
						If  BDX->(msSeek(xFilial("BDX")+aGlosas[i,2]))
							While ! BDX->(Eof()) .And. BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == ;
								xFilial("BDX")+aGlosas[i,2]
								If  BDX->BDX_TIPREG == "1"
									cAcao   := AllTrim( X3COMBO("BDX_ACAO",BDX->BDX_ACAO) )
									If aGlosas[i,6] <> "Glosa     "
										cLinha  := Left(cAcao,5) + "/" + aGlosas[i,6] + cGlosa + Space(1) + BDX->BDX_DESGLO
									Else
										cLinha  := cAcao + Space(16-Len(cAcao)) + cGlosa + Space(1) + BDX->BDX_DESGLO
									EndIf
									R673Linha(cLinha,1,0)
									If !Empty(BDX->BDX_RESPAL)
										cJusti   := 'Justificativa.: ' + BDX->BDX_RESPAL
										cBdxCodP := BDX->BDX_CODPRO
									EndIf
									cGlosa   := Space(35)
								Endif
								BDX->(DbSkip())
							Enddo
						Endif
						
						If  !Empty(cGlosa)
							R673Linha(aGlosas[I,6] + Space(6) + cGlosa,1,0)
						Endif
						
					Endif
				Next
				
				If !Empty(cJusti)
					R673Linha(Space(52)+cJusti,1,0)
					cJusti := ""
				EndIf
				
				cLinha := "Total" + Space(36) + TransForm(nTotal,pMoeda1)
				R673Linha(cLinha,1,0)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lista cabecalho                                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  lLisRes
				cLinha := Replicate('-',nLimite)
				R673Linha(cLinha,1,0)
				cLinha := "Outros Debitos/Creditos       Descricao                                   Credito         Debito"
				R673Linha(cLinha,1,0)
				cLinha := "-----------------------       ------------------------------------        -------         ------"
				R673Linha(cLinha,1,0)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lista outros debitos/creditos                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R673DC(cOpeLot,cNumLot,.T.,lLisRes)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Total debitos/creditos                                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nDebTot := nDebFix + nDebVar + nDebApo
			nCreTot := nCreFix + nCreVar + nCreApo
			
			If  lLisRes
				cLinha := Padr("Total Outros Debitos/Creditos",65,".") + ": " + TransForm(nCreTot,pMoeda2) + " "  + TransForm(nDebTot,pMoeda2)
				R673Linha(cLinha,2,0)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta resumo                                                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For i := 1 to len(aGlosas)
				nTotGlo += aGlosas[i,3]
			Next
			
			cValor  := TransForm(nTotGlo,pMoeda2)
			aadd(aTabRes,{"Total Glosa",cValor,Space(Len(cValor)),Space(Len(cValor)),""})
			
			aTabRes := {}
			nVlrTot := nVlrPag + nCreFix + nCreVar + nCreApo - nDebFix - nDebVar - nDebApo
			cValor  := TransForm(nVlrTot,pMoeda2)
			If  nVlrTot >= 0
				cValor  := TransForm(nVlrTot,pMoeda2)
				aadd(aTabRes,{"Total Bruto",cValor,Space(Len(cValor)),Space(Len(cValor)),""})
			Else
				cValor  := TransForm(nVlrTot * -1,pMoeda2)
				aadd(aTabRes,{"Total Bruto",Space(Len(cValor)),cValor,Space(Len(cValor)),""})
			Endif
			nBIss     := 0
			nIss      := 0
			nBPis     := 0
			nPis      := 0
			nBCofins  := 0
			nCofins   := 0
			nBIR      := 0
			nIR       := 0
			nBCSLL    := 0
			nCSLL     := 0
			nBINSSPF  := 0
			nINSSPF   := 0
			nBINSSPJ  := 0
			nINSSPJ   := 0
			nBINSSJF  := 0
			nINSSJF   := 0
			nPINSSPJ  := 0
			nPINSSPF  := 0
			nCrPINSS  := 0
			If  nFase == 2 //somente faturadas
				//Buscar imposto PIS, Cofins, CSLL, IR e INSS PF, INSSPJ
				BMR->(DbSetOrder(3))
				If  BMR->(msSeek(xFilial("BMR")+cCodOpe+BAU->BAU_CODIGO+cOpeLot+cNumLot))
					While ! BMR->(Eof()) .And. BMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOTE+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) == ;
						xFilial("BMR")+cCodOpe+BAU->BAU_CODIGO+cOpeLot+cNumLot
						Do Case
							Case BMR->BMR_CODLAN == "182"
								nBINSSPJ  += BMR->BMR_VLRPAG
								ntBINSSPJ += BMR->BMR_VLRPAG
								lInssUnic := .T.
							Case BMR->BMR_CODLAN == "183"
								nINSSPJ   += BMR->BMR_VLRPAG
								ntINSSPJ  += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "184"
								nBIss     += BMR->BMR_VLRPAG
								ntBIss    += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "185"
								nIss      += BMR->BMR_VLRPAG
								ntIss     += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "186"
								nBPis     += BMR->BMR_VLRPAG
								ntBPis    += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "187"
								nPis      += BMR->BMR_VLRPAG
								ntPis     += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "188"
								nBCofins  += BMR->BMR_VLRPAG
								ntBCofins += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "189"
								nCofins   += BMR->BMR_VLRPAG
								ntCofins  += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "190"
								nBCSLL    += BMR->BMR_VLRPAG
								ntBCSLL   += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "191"
								nCSLL     += BMR->BMR_VLRPAG
								ntCSLL    += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "192"
								nBINSSPF  += BMR->BMR_VLRPAG
								ntBINSSPF += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "193"
								nINSSPF   += BMR->BMR_VLRPAG
								ntINSSPF  += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "194"
								nBINSSPJ  += BMR->BMR_VLRPAG
								ntBINSSPJ += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "195"
								nINSSPJ   += BMR->BMR_VLRPAG
								ntINSSPJ  += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "196"
								nBINSSPF  += BMR->BMR_VLRPAG
								ntBINSSPF += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "197"
								nINSSPF   += BMR->BMR_VLRPAG
								ntINSSPF  += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "198"
								nBIR      += BMR->BMR_VLRPAG
								ntBIR     += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "199"
								nIR       += BMR->BMR_VLRPAG
								ntIR      += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "179"
								nPINSSPJ  += BMR->BMR_VLRPAG
								ntPINSSPJ += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "180"
								nPINSSPF  += BMR->BMR_VLRPAG
								ntPINSSPF += BMR->BMR_VLRPAG
							Case BMR->BMR_CODLAN == "181"
								nCrPINSS  += BMR->BMR_VLRPAG
								ntCrPINSS += BMR->BMR_VLRPAG
						EndCase
						BMR->(DbSkip())
					Enddo
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Busca impostos calculados                                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If  Len(aLotes) == 1 .and. lLotImp
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta query                                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSQL := " SELECT BMR_ANOLOT, BMR_MESLOT, BMR_CODLAN, BMR_VLRPAG, R_E_C_N_O_ AS BMR_RECNO"
					cSQL += "  FROM " + RetSQLName("BMR")
					cSQL += "  WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
					cSQL += "    AND BMR_CODRDA = '" + BAU->BAU_CODIGO + "' "
					cSQL += "    AND BMR_ANOLOT = '" + cAno    + "' "
					cSQL += "    AND BMR_MESLOT = '" + cMes    + "' "
					If ! Empty(dDatAte) .And. ! Empty(cLotBMR)
						cSQL += "    AND BMR_NUMLOT IN (" + cLotBMR + ") "
					EndIf
					cSQL += "    AND BMR_CODLAN IN ('183','193','195','197','199') "
					cSQL += "    AND D_E_L_E_T_ = ' ' "
					cSQL += " ORDER BY BMR_ANOLOT, BMR_MESLOT ,R_E_C_N_O_ "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Executa query                                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSQL := ChangeQuery(cSQL)
					dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Processa arquivo de trabalho                                        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					While ! Trb->(Eof())
						Do Case
							Case TRB->BMR_CODLAN == "183" ; nINSSPJ  += Trb->BMR_VLRPAG ; lInssUnic := .T.  // inss PF
							Case TRB->BMR_CODLAN == "193" ; nINSSPF  += Trb->BMR_VLRPAG  // inss PF
							Case TRB->BMR_CODLAN == "195" ; nINSSPJ  += Trb->BMR_VLRPAG  // inss PJ
							Case TRB->BMR_CODLAN == "197" ; nINSSPF  += Trb->BMR_VLRPAG  // inss PJ filantropico
							Case TRB->BMR_CODLAN == "199" ; nIR      += Trb->BMR_VLRPAG  // ir
							Case TRB->BMR_CODLAN == "179" ; nPINSSPJ += TRB->BMR_VLRPAG  // Prov INSS PJ
							Case TRB->BMR_CODLAN == "180" ; nPINSSPF += TRB->BMR_VLRPAG  // Prov INSS PF
							Case TRB->BMR_CODLAN == "181" ; nCrPINSS += TRB->BMR_VLRPAG  // Cred Prov INSS
						EndCase
						Trb->(DbSkip())
					Enddo
					Trb->(dbCloseArea())
				Endif
				
				If nPis+nCofins+nCSLL == 0
					cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
					cSQL += "  FROM " + RetSQLName("SE2")
					cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
					cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
					cSQL += "    AND E2_PLLOTE = '" + cNumLot + "' "
					cSQL += "    AND D_E_L_E_T_ = ' ' "
					cSQL += " ORDER BY E2_VENCTO "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Executa query                                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSQL := ChangeQuery(cSQL)
					dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
     				lISS := .F.
         		While ! Trb->(eof())
						SE2->(dbGoTo(Trb->E2_RECNO))
						If (SE2->E2_TIPO == MVINSS .And. ;
							IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
							SE2->E2_TIPO == MVTAXA
							Trb->(dbSkip())
							Loop
						Endif
												
						nPis 		+= SE2->E2_VRETPIS 
						nCofins 	+= SE2->E2_VRETCOF
					   nCSLL  	+= SE2->E2_VRETCSL
					    
					   ntPis    += SE2->E2_VRETPIS
			    		ntCofins += SE2->E2_VRETCOF
			    		ntCSLL   += SE2->E2_VRETCSL
			    		
			    		If !Empty(SE2->E2_PARCISS)
			    			lISS := .T.
			    		Endif    
			    					    								    					    				    
			    		Trb->(dbSkip())
					End
					Trb->(dbCloseArea())
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta resumo                                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cValor := TransForm(0,pMoeda2) // apenas para pegar o tamanho deste campo
				If  nIss > 0 .or. nBIss > 0
					aadd(aTabRes,{"ISS"    ,Space(Len(cValor)),TransForm(nIss   ,pMoeda2),TransForm(nBIss   ,pMoeda2),""})
				Endif
				If  nPis > 0 .or. nBPis > 0
					aadd(aTabRes,{"PIS"    ,Space(Len(cValor)),TransForm(nPis   ,pMoeda2),TransForm(nBPis   ,pMoeda2),""})
				Endif
				If  nCofins > 0 .or. nBCofins > 0
					aadd(aTabRes,{"COFINS" ,Space(Len(cValor)),TransForm(nCofins,pMoeda2),TransForm(nBCofins,pMoeda2),""})
				Endif
				If  nCSLL   > 0 .or. nBCSLL > 0
					aadd(aTabRes,{"CSLL"   ,Space(Len(cValor)),TransForm(nCSLL  ,pMoeda2),TransForm(nBCSLL  ,pMoeda2),""})
				Endif
				If  nPINSSPF > 0
					aadd(aTabRes,{"Prov INSS PF",Space(Len(cValor)),TransForm(nPINSSPF,pMoeda2),TransForm(nBINSSPF,pMoeda2),""})
				Endif
				If  nPINSSPJ > 0
					aadd(aTabRes,{"Prov INSS PJ",Space(Len(cValor)),TransForm(nPINSSPJ,pMoeda2),TransForm(nBINSSPJ,pMoeda2),""})
				Endif
				If  nINSSPF > 0 .or. nBINSSPF > 0
					aadd(aTabRes,{"INSS PF",Space(Len(cValor)),TransForm(nINSSPF,pMoeda2),TransForm(nBINSSPF,pMoeda2),""})
				Endif
				If  nINSSPJ > 0 .or. nBINSSPJ > 0
					If  lInssUnic
						aadd(aTabRes,{"INSS"   ,Space(Len(cValor)),TransForm(nINSSPJ,pMoeda2),TransForm(nBINSSPJ,pMoeda2),""})
					Else
						aadd(aTabRes,{"INSS PJ",Space(Len(cValor)),TransForm(nINSSPJ,pMoeda2),TransForm(nBINSSPJ,pMoeda2),""})
					Endif
				Endif
				If  nINSSJF > 0 .or. nBINSSJF > 0
					aadd(aTabRes,{"INSS JF",Space(Len(cValor)),TransForm(nINSSJF,pMoeda2),TransForm(nBINSSJF,pMoeda2),""})
				Endif
				If  nIR > 0 .or. nBIR > 0
					aadd(aTabRes,{"I.R"    ,Space(Len(cValor)),TransForm(nIR    ,pMoeda2),TransForm(nBIR    ,pMoeda2),cDepIr})
				Endif
				If  nCrPINSS > 0
					aadd(aTabRes,{"Cred Prov INSS",TransForm(nCrPINSS,pMoeda2),space(len(cValor)),space(len(cValor)),""})
				Endif
			Endif
			
		   	nVlrTot := nVlrPag + nCreTot - nDebTot - If(!lISS,nIss,0) - nPis - nCofins - nCSLL - nINSSPF - nINSSPJ - nINSSJF - nIR - nPINSSPF - nPINSSPJ + nCrPINSS
		
			If  nVlrTot > 0
				cValor := TransForm(nVlrTot,pMoeda2)
				aadd(aTabRes,{"Total Liquido",cValor,Space(Len(cValor)),Space(Len(cValor)),""})
			Else
				cValor := TransForm(nVlrTot * -1,pMoeda2)
				aadd(aTabRes,{"Total Liquido",Space(Len(cValor)),cValor,Space(Len(cValor)),""})
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta cabecalho                                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCabec1 := "Tipo Debito/Credito           Descricao                                   Credito         Debito"
			cCabec2 := ""
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime resumo do lote da RDA                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R673RDA()
			R673Res_Prod(aResProd)
			R673DC(cOpeLot,cNumLot,.F.,!lLisRes)
			nDebTot := nDebFix + nDebVar + nDebApo
			nCreTot := nVlrPag + nCreFix + nCreVar + nCreApo
			cLinha := Padr("Total Debitos/Creditos",65,".") + ": " + TransForm(nCreTot,pMoeda2) + " "  + TransForm(nDebTot,pMoeda2)
			R673Linha(cLinha,2,0)
			R673Res()
		Endif
	Next
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime resumo da RDA                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLotes) > 1 .or. ! lAnalitico
		If Empty(dDatAte)
			cTitulo := AllTrim(cTitulo) + " - RESUMO MENSAL"
		EndIf
		R673RDA(.F.)
		R673Res_Prod(aResProdT)
		If  lAnalitico
			R673DC("","",.F.,.T.)
		Else
			R673DC("","",.T.,.T.)
		Endif
		nVlrPag := aResProdT[1] + aResProdT[2] + aResProdT[3] + aResProdT[4] + aResProdT[5] + aResProdT[6] + aResProdT[7]
		nDebTot := ntDebFix + ntDebVar + ntDebApo
		nCreTot := nVlrPag + ntCreFix + ntCreVar + ntCreApo
		cLinha := Padr("Total Debitos/Creditos",65,".") + ": " + TransForm(nCreTot,pMoeda2) + " "  + TransForm(nDebTot,pMoeda2)
		R673Linha(cLinha,2,0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Busca impostos calculados                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (! GetNewPar("MV_PLPGUNI","1") $ "1,3" .and. BAU->BAU_CALIMP == "3") .or. ;
			! lAnalitico
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa variaveis                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ntBIss    := 0
			ntIss     := 0
			ntBPis    := 0
			ntPis     := 0
			ntBCofins := 0
			ntCofins  := 0
			ntBCSLL   := 0
			ntCSLL    := 0
			ntBINSSPF := 0
			ntINSSPF  := 0
			ntBINSSPJ := 0
			ntINSSPJ  := 0
			ntBINSSPF := 0
			ntINSSPF  := 0
			ntPINSSPJ := 0
			ntPINSSPF := 0
			ntCrPINSS := 0
			ntBIR     := 0
			ntIR      := 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta query                                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cSQL := " SELECT BMR_ANOLOT, BMR_MESLOT, BMR_CODLAN, BMR_VLRPAG, R_E_C_N_O_ AS BMR_RECNO"
			cSQL += "  FROM " + RetSQLName("BMR")
			cSQL += "  WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
			cSQL += "    AND BMR_CODRDA = '" + BAU->BAU_CODIGO + "' "
			cSQL += "    AND BMR_ANOLOT = '" + cAno    + "' "
			cSQL += "    AND BMR_MESLOT = '" + cMes    + "' "
			If ! Empty(dDatAte) .And. ! Empty(cLotBMR)
				cSQL += "    AND BMR_NUMLOT IN (" + cLotBMR + ")
			EndIf
			cSQL += "    AND D_E_L_E_T_ = ' ' "
			cSQL += " ORDER BY BMR_ANOLOT, BMR_MESLOT ,R_E_C_N_O_ "
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Executa query                                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cSQL := ChangeQuery(cSQL)
			dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Processa arquivo de trabalho                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While ! Trb->(eof()) 
				Do Case
					Case TRB->BMR_CODLAN == "182" ; ntBINSSPJ += TRB->BMR_VLRPAG ; lInssUnic := .T.
					Case TRB->BMR_CODLAN == "183" ; ntINSSPJ  += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "184" ; ntBIss    += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "185" ; ntIss     += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "186" ; ntBPis    += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "187" ; ntPis     += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "188" ; ntBCofins += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "189" ; ntCofins  += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "190" ; ntBCSLL   += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "191" ; ntCSLL    += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "192" ; ntBINSSPF += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "193" ; ntINSSPF  += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "194" ; ntBINSSPJ += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "195" ; ntINSSPJ  += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "196" ; ntBINSSPF += TRB->BMR_VLRPAG //nBINSSJF += BMR->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "197" ; ntINSSPF  += TRB->BMR_VLRPAG //nINSSJF  += BMR->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "198" ; ntBIR     += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "199" ; ntIR      += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "179" ; ntPINSSPJ += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "180" ; ntPINSSPF += TRB->BMR_VLRPAG
					Case TRB->BMR_CODLAN == "181" ; ntCrPINSS += TRB->BMR_VLRPAG
				EndCase
				Trb->(dbSkip())
			Enddo
			Trb->(dbCloseArea())
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta resumo                                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For i := 1 to len(aGlosas)
			nTotGlo += aGlosas[i,3]
		Next
		
		cValor  := TransForm(nTotGlo,pMoeda2)
		aadd(aTabRes,{"Total Glosa",space(len(cValor)),cValor,space(len(cValor)),""})
		
		aTabRes := {}
		nVlrTot := nVlrPag + ntCreFix + ntCreVar + ntCreApo - ntDebFix - ntDebVar - ntDebApo
		cValor  := TransForm(nVlrTot,pMoeda2)
		If  nVlrTot >= 0
			cValor  := TransForm(nVlrTot,pMoeda2)
			aadd(aTabRes,{"Total Bruto",cValor,space(len(cValor)),space(len(cValor)),""})
		Else
			cValor  := TransForm(nVlrTot * -1,pMoeda2)
			aadd(aTabRes,{"Total Bruto",space(len(cValor)),cValor,space(len(cValor)),""})
		Endif
		
		If ntPis+ntCofins+ntCSLL == 0
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
			cSQL += "    AND E2_PLLOTE = '" + cNumLot + "' "
			cSQL += "    AND D_E_L_E_T_ = ' ' "
			cSQL += " ORDER BY E2_VENCTO "
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Executa query                                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cSQL := ChangeQuery(cSQL)
			dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
			lISS := .F.
			While ! Trb->(eof())
				SE2->(dbGoTo(Trb->E2_RECNO))
				If (SE2->E2_TIPO == MVINSS .And. ;
					IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
					SE2->E2_TIPO == MVTAXA
					Trb->(dbSkip())
					Loop
				Endif
				
				nPis    += SE2->E2_VRETPIS 
				nCofins += SE2->E2_VRETCOF 
		    	nCSLL   += SE2->E2_VRETCSL
			    
				ntPis    += SE2->E2_VRETPIS
				ntCofins += SE2->E2_VRETCOF
				ntCSLL   += SE2->E2_VRETCSL
			    
			    If !Empty(SE2->E2_PARCISS)
			    	lISS := .T.
			    Endif
			    		   		    
			Trb->(dbSkip())
			End
			Trb->(dbCloseArea())
		Endif
		
		If  nFase == 2 //somente faturadas
			cValor := TransForm(0,pMoeda2) // apenas para pegar o tamanho deste campo
			If  ntIss > 0 .or. ntBIss > 0
				aadd(aTabRes,{"ISS"    ,space(len(cValor)),TransForm(ntIss   ,pMoeda2),TransForm(ntBIss   ,pMoeda2),""})
			Endif
			If  ntPis > 0 .or. ntBPis > 0
				aadd(aTabRes,{"PIS"    ,space(len(cValor)),TransForm(ntPis   ,pMoeda2),TransForm(ntBPis   ,pMoeda2),""})
			Endif
			If  ntCofins > 0 .or. ntBCofins > 0
				aadd(aTabRes,{"COFINS" ,space(len(cValor)),TransForm(ntCofins,pMoeda2),TransForm(ntBCofins,pMoeda2),""})
			Endif
			If  ntCSLL   > 0 .or. ntBCSLL > 0
				aadd(aTabRes,{"CSLL"   ,space(len(cValor)),TransForm(ntCSLL  ,pMoeda2),TransForm(ntBCSLL  ,pMoeda2),""})
			Endif
			If  ntPINSSPF > 0
				aadd(aTabRes,{"Prov INSS PF",space(len(cValor)),TransForm(ntPINSSPF,pMoeda2),space(len(cValor)),""})
			Endif
			If  ntPINSSPJ > 0
				aadd(aTabRes,{"Prov INSS PJ",space(len(cValor)),TransForm(ntPINSSPJ,pMoeda2),space(len(cValor)),""})
			Endif
			If  ntINSSPF > 0 .or. ntBINSSPF > 0
				aadd(aTabRes,{"INSS PF",space(len(cValor)),TransForm(ntINSSPF,pMoeda2),TransForm(ntBINSSPF,pMoeda2),""})
			Endif
			If  ntINSSPJ > 0 .or. ntBINSSPJ > 0
				If  lInssUnic
					aadd(aTabRes,{"INSS"   ,space(len(cValor)),TransForm(ntINSSPJ,pMoeda2),TransForm(ntBINSSPJ,pMoeda2),""})
				Else
					aadd(aTabRes,{"INSS PJ",space(len(cValor)),TransForm(ntINSSPJ,pMoeda2),TransForm(ntBINSSPJ,pMoeda2),""})
				Endif
			Endif
			If  ntINSSJF > 0 .or. ntBINSSJF > 0
				aadd(aTabRes,{"INSS JF",space(len(cValor)),TransForm(ntINSSJF,pMoeda2),TransForm(ntBINSSJF,pMoeda2),""})
			Endif
			If  ntIR > 0 .or. ntBIR > 0
				aadd(aTabRes,{"I.R"    ,space(len(cValor)),TransForm(ntIR    ,pMoeda2),TransForm(ntBIR    ,pMoeda2),cDepIr})
			Endif
			If  ntCrPINSS > 0
				aadd(aTabRes,{"Cred Prov INSS",TransForm(ntCrPINSS,pMoeda2),space(len(cValor)),space(len(cValor)),""})
			Endif
		Endif
	
	  	nVlrTot := nCreTot - nDebTot - If(!lISS,ntIss,0) - ntPis - ntCofins - ntCSLL - ntINSSPF - ntINSSPJ - ntINSSJF - ntIR - ntPINSSPJ - ntPINSSPF + ntCrPINSS
	  	
		If  nVlrTot > 0
			cValor := TransForm(nVlrTot,pMoeda2)
			aadd(aTabRes,{"Total Liquido",cValor,space(len(cValor)),space(len(cValor)),""})
		Else
			cValor := TransForm(nVlrTot * -1,pMoeda2)
			aadd(aTabRes,{"Total Liquido",space(len(cValor)),cValor,space(len(cValor)),""})
		Endif
		R673Res()
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os titulos gerados                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nFase == 2 .and. lLisTit
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta query                                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  empty(cLotes)
			cLotes := "('')"
		Endif
		cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
		cSQL += "  FROM " + RetSQLName("SE2")
		cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		cSQL += "    AND E2_CODRDA = '" + BAU->BAU_CODIGO + "' "
		cSQL += "    AND E2_PLLOTE IN " + cLotes
		cSQL += "    AND D_E_L_E_T_ = ' ' "  
		cSQL += " ORDER BY E2_VENCTO "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Executa query                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSQL := ChangeQuery(cSQL)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb",.F.,.T.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa arquivo de trabalho                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTitulos := {}
		While ! Trb->(eof())
			lBaixa := .F.
			lISS   := .F.
			SE2->(dbGoTo(Trb->E2_RECNO))
			If (SE2->E2_TIPO == MVINSS .And. ;
				IIf(GetNewPar("MV_PLPGUNI","1") == "3", IIf(SE2->(FieldPos("E2_FORORI")) > 0, Empty(SE2->E2_FORORI), .T.), .T.)) .Or. ;
				SE2->E2_TIPO == MVTAXA
				Trb->(dbSkip())
				Loop
			Endif
			
			If !Empty(SE2->E2_BAIXA)
				lBaixa := .T.
			Endif
			
			If !Empty(SE2->E2_PARCISS)
				lISS := .T.
			Endif
						
			nPos := aScan(aTitulos,{|x| x[1]+x[2] == SE2->E2_PREFIXO+SE2->E2_NUM})
			If  nPos == 0
				//             1-prefixo,       2-numero,   3-tipo, 4-emissao, 5-vencto, 6-valor, 7-ir, 8-inss, 9-acrescimo, 10-decrescimo, 11-Outros Impostos (PIS/COFINS/CSLL/ISS)
				aadd(aTitulos,{SE2->E2_PREFIXO,SE2->E2_NUM,""     ,ctod("")  ,ctod("") ,0       ,0    ,0, 0, 0, 0, .F.,0, SE2->E2_BAIXA})  // Acrescentada a data de baixa do título - 02/04/2013 - Marcelo Giglio
				nPos := len(aTitulos)
			Endif
			nValor := SE2->E2_VALOR //If (SE2->E2_VALLIQ > 0,SE2->E2_VALLIQ,SE2->E2_VALOR) //+ SE2->E2_INSS + SE2->E2_COFINS + SE2->E2_PIS + SE2->E2_IRRF + SE2->E2_CSLL + SE2->E2_ISS
			If  empty(SE2->E2_PARCELA) // indica que eh o titulo principal
				If  SE2->E2_TIPO == "NDF"
					nValor := nValor * -1
				Endif
				
				nOutImp := SE2->E2_VRETPIS + SE2->E2_VRETCOF + SE2->E2_VRETCSL + If(!lContrRet,SE2->E2_VRETISS,If(!lISS,SE2->E2_VRETISS,0))
				
			  	aTitulos[nPos, 3] := SE2->E2_TIPO
				aTitulos[nPos, 4] := SE2->E2_EMISSAO
				aTitulos[nPos, 5] := SE2->E2_VENCTO
				aTitulos[nPos, 6] := nValor + SE2->E2_IRRF + SE2->E2_INSS + If(lContrRet .And. !lBaixa,0,nOutImp)
				aTitulos[nPos, 7] := IIf(aTitulos[nPos, 7] == 0, SE2->E2_IRRF, aTitulos[nPos, 7])
				aTitulos[nPos, 8] := IIf(aTitulos[nPos, 8] == 0, IIf(SE2->E2_TIPO == MVINSS, nValor, SE2->E2_INSS), aTitulos[nPos, 8])
				aTitulos[nPos, 9] := SE2->E2_ACRESC
				aTitulos[nPos,10] := SE2->E2_DECRESC
				aTitulos[nPos,11] := If(!lContrRet,nOutImp,If(lISS,nOutImp+SE2->E2_ISS,nOutImp))
				aTitulos[nPos,12] := lISS
				aTitulos[nPos,13] := SE2->E2_ISS
				aTitulos[nPos,14] := SE2->E2_BAIXA  // Acrescentada a data de baixa do título - 02/04/2013 - Marcelo Giglio
			Else
				If  Alltrim(SE2->E2_PARCELA) $ StrZero(1, TamSX3("E2_PARCELA")[1])
					aTitulos[nPos,8] := nValor
				Else
					aTitulos[nPos,7] := nValor
				Endif
			Endif
			Trb->(dbSkip())
		Enddo
		Trb->(dbCloseArea())
		
		nTotVlr    := 0
		nTotIns    := 0
		nTotIrf    := 0  
		nTotOutImp := 0           
		nTotAcr    := 0
		nTotDec    := 0
		If  Len(aTitulos) > 0    
		    cLinha := "Titulos Gerados"
		    R673Linha(cLinha,1,1)
			cLinha := "Pfx Numero    Tp Emissao  Vencto   BaixaTit       Valor          IRRF           INSS       Outr Imp  Acrescimo Decrescimo     Liquido"
			R673Linha(cLinha,1,0)
			cLinha := "--- --------- -- -------- -------- -------- -------------- -------------  ------------  ----------- ---------- ---------- ------------"
			R673Linha(cLinha,1,0)
		EndIf	
		For nPos := 1 to len(aTitulos)
			nLiq   := aTitulos[nPos,6] - aTitulos[nPos,7] - aTitulos[nPos,8] + aTitulos[nPos,9] - aTitulos[nPos,10] - If(!lContrRet,aTitulos[nPos,11],If(aTitulos[nPos,12],aTitulos[nPos,11]-aTitulos[nPos,13],aTitulos[nPos,11]))
			cLinha := aTitulos[nPos,1] + space(1) + ;
			aTitulos[nPos,2] + space(1) + ;
			aTitulos[nPos,3] + space(0) + ;
			dtoc(aTitulos[nPos,4]) + space(1) + ;
			dtoc(aTitulos[nPos,5]) + space(1) + ;
			dtoc(aTitulos[nPos,14]) + space(1) + ;   // Adicionada a impressão da data da baixa do título - 02/04/2013 - Marcelo Giglio
			TransForm(aTitulos[nPos, 6],pMoeda2) + space(0) + ;
			TransForm(aTitulos[nPos, 7],pMoeda2) + space(0) + ;
			TransForm(aTitulos[nPos, 8],pMoeda2) + space(0) + ;
			TransForm(aTitulos[nPos,11],pMoeda2) + space(0) + ;
			TransForm(aTitulos[nPos, 9],pMoeda1) + space(0) + ;
			TransForm(aTitulos[nPos,10],pMoeda1) + space(0) + ;
			TransForm(nLiq             ,pMoeda2)
			R673Linha(cLinha,1,0)
			nTotVlr    += aTitulos[nPos,6]
			nTotIrf    += aTitulos[nPos,7]
			nTotIns    += aTitulos[nPos,8]   
			nTotOutImp += aTitulos[nPos,11]   
			nTotAcr    += aTitulos[nPos,9]
			nTotDec    += aTitulos[nPos,10]
		Next
		If  Len(aTitulos) > 1
			cLinha := "                                    -------------- -------------- -------------- -------------- ---------- ---------- --------------"
		    R673Linha(cLinha,1,1)
			nLiq := nTotVlr - nTotIrf - nTotIns - nTotOutImp + nTotAcr - nTotDec
			cLinha := "Total" + space(31) + ;
			TransForm(nTotVlr,pMoeda2) + space(1) + ;
			TransForm(nTotIrf,pMoeda2) + space(1) + ;
			TransForm(nTotIns,pMoeda2) + space(1) + ;
			TransForm(nTotOutImp,pMoeda2) + space(1) + ;
			TransForm(nTotAcr,pMoeda1) + space(1) + ;
			TransForm(nTotDec,pMoeda1) + space(1) + ;
			TransForm(nLiq   ,pMoeda2)
			R673Linha(cLinha,1,0)
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime as mensagens de extrato prestador (BN4)...                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aMsgExt := PLSEXTPRE(BAU->BAU_CODIGO,cCodOpe,cAno,cMes,BAU->BAU_COPCRE)
	If  Len(aMsgExt) > 0
		cLinha := PadC("MENSAGENS DE EXTRATO", 132, "-")
		R673Linha(cLinha,1,2)
	Endif
	For nFor := 1 To Len(aMsgExt)
		cLinha := PadC(&(AllTrim(aMsgExt[nFor])), 132)
		R673Linha(cLinha,1,0)
	Next
	If  Len(aMsgExt) > 0
		cLinha := PadC("", 132, "-")
		R673Linha(cLinha,1,1)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os dados do credenciado no fim da pagina...                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLi := 50
	BA0->(DbSetOrder(1))
	BA0->(msSeek(xFilial("BA0")+cCodOpe))
	cLinha := BA0->(BA0_CODIDE+BA0_CODINT)+" - "+AllTrim(BA0->BA0_NOMINT)+Space(02)+"CNPJ: "+transform(BA0->BA0_CGC,"@R !!.!!!.!!!/!!!!-!!")
	R673Linha(cLinha,1,1)
	cLinha := BAU->BAU_CODIGO+' - '+BAU->BAU_NOME
	R673Linha(cLinha,1,0)
	If  len(alltrim(BAU->BAU_CPFCGC)) == 11
		cLinha := "INSS: " + AllTrim(BAU->BAU_INSS) + '   CPF: ' + transform(BAU->BAU_CPFCGC,"@R !!!.!!!.!!!-!!")
	Else
		cLinha := "INSS: " + AllTrim(BAU->BAU_INSS) + '   CNPJ: ' + transform(BAU->BAU_CPFCGC,"@R !!.!!!.!!!/!!!!-!!")
	Endif
	R673Linha(cLinha,1,0)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se eh para buscar o endereco pela RDA ou pelo Local de Atendimento    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nImpEnd == 1 //RDA
		cLinha := AllTrim(BAU->BAU_END) + " - " + AllTrim(BAU->BAU_BAIRRO)
		R673Linha(cLinha,1,0)
		cLinha := TransForm(BAU->BAU_CEP,PesqPict("BAU","BAU_CEP")) + " - " + AllTrim(posicione("BID",1,xFilial("BID")+BAU->BAU_MUN,"BID_DESCRI")) + " - " + BAU->BAU_EST
		R673Linha(cLinha,1,0)
	Else //Local Atendimento
		BB8->(msSeek(xFilial("BB8")+BAU->BAU_CODIGO+cCodOpe))
		While ! BB8->(Eof()) .and. BB8->BB8_FILIAL == xFilial("BB8")  .and. ;
			BB8->BB8_CODIGO == BAU->BAU_CODIGO .and. ;
			BB8->BB8_CODINT == cCodOpe
			If  Empty(BB8->BB8_DATBLO)
				lLocEnd = .T.
				Exit
			Endif
			BB8->(DbSkip())
		Enddo
		If  lLocEnd
			cLinha := AllTrim(BB8->BB8_END) + " - " + AllTrim(BB8->BB8_BAIRRO)
			R673Linha(cLinha,1,0)
			cLinha := TransForm(BB8->BB8_CEP,PesqPict("BB8","BB8_CEP")) + " - " + AllTrim(posicione("BID",1,xFilial("BID")+BB8->BB8_CODMUN,"BID_DESCRI")) + " - " + BB8->BB8_EST
			R673Linha(cLinha,1,0)
		Else
			cLinha := ""
			R673Linha(cLinha,1,0)
			cLinha := ""
			R673Linha(cLinha,1,0)
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodade padrao                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),cTamanho)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa proximo registro                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TrbBAU->(DbSkip())
Enddo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo de trabalho                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbBAU->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mensagem de processamento                         		 				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  len(aLog) > 0
	PLSCRIGEN(aLog,{{"Movimento","@!",120},{"BD7_TIPUSR","@!",50},{"BD7_MODCOB","@!",50},{"BD7_INTERC","@!",50}},"Ocorrencias no processamento",nil,nil)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	OurSpool(nrel)
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673RDA   ³ Autor ³ Angelo Sperandio     ³ Data ³ 28.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime dados da RDA                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673RDA(lImpLot)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime dados da RDA                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Default lImpLot := .T.
nli := 999
If  lLisFor
	cLinha := "Fornecedor: " + SA2->A2_COD + "-" + SA2->A2_LOJA + " " + SA2->A2_NOME
	R673Linha(cLinha,1,0)
Endif
cRdaAnt := BAU->BAU_CODIGO
cLinha := "R.D.A.: " + BAU->BAU_CODIGO + "-" + alltrim(BAU->BAU_NOME) + ;
"  Classe: " + alltrim(posicione("BAG",1,xFilial("BAG")+BAU->BAU_TIPPRE,"BAG_DESCRI")) + ;
"  Tipo: " + alltrim(X3COMBO("BAU_COPCRE",BAU->BAU_COPCRE))
R673Linha(cLinha,1,0)
cLinha := "Especialidade: " + alltrim(cEspecia)
R673Linha(cLinha,1,0)
If  lImpLot
	cLinha := "Lote..: " + cOpeLot + " " + cNumLot + " - " + cDesLot
	R673Linha(cLinha,1,0)
Endif

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673DC    ³ Autor ³ Angelo Sperandio     ³ Data ³ 28.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime outros debitos/creditos                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673DC(cOpeLot,cNumLot,lSoma,lLisRes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local   cTit := ""
Local 	lCposVld	:=	(BBC->(FieldPos("BBC_VLDINI")) > 0 .And. BBC->(FieldPos("BBC_VLDFIM")) > 0)
Default cOpeLot := ""
Default cNumLot := ""
Default lSoma   := .T.
nDebFix := 0
nCreFix := 0
nCreVar := 0
nDebVar := 0
nCreApo := 0
nDebApo := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista debitos/creditos fixos                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lAnalitico
	//  cLinha := Replicate(' ',nLimite)
	//  R673Linha(cLinha,1,0)
Endif
cTit := "Debitos/Creditos Fixos:       "
lTem := .F.
If  nFase == 2 // Faturada
	BGQ->(DbSetOrder(2))
	If  BGQ->(msSeek(xFilial("BGQ")+BAU->BAU_CODIGO+cAno+cMes+cCodOpe))
		While ! BGQ->(Eof()) .And. ;
			BGQ->(BGQ_FILIAL+BGQ_CODIGO+BGQ_ANO+BGQ_MES+BGQ_CODOPE) == xFilial("BGQ")+cRdaAnt+cAno+cMes+cCodOpe
			If  ! empty(cOpeLot+cNumLot) .and. ;
				BGQ->(BGQ_OPELOT+BGQ_NUMLOT) <> cOpeLot+cNumLot
				BGQ->(DbSkip())
				Loop
			Endif
			If  alltrim(BGQ->BGQ_NUMLAU) <> "BBC"
				BGQ->(DbSkip())
				Loop
			Endif
			BBB->(DbSetOrder(1))
			BBB->(msSeek(xFilial("BBB")+BGQ->BGQ_CODLAN))
			If  lLisRes // lAnalitico
				cValor := TransForm(BGQ->BGQ_VALOR,pMoeda2)
				If  BGQ->BGQ_TIPO == "1"
					If  lLisRes
						cLinha := cTit + Padr(BGQ->BGQ_CODLAN + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
						space(len(cValor)) + " " + cValor + " " + ;
						If(alltrim(BGQ->BGQ_NUMLAU) <> "BBC",substr(BGQ->BGQ_OBS,1,35),"")
							R673Linha(cLinha,1,0)
						Endif
					Else
						If  BGQ->BGQ_TIPO == "2"
							If  lLisRes
								cLinha := cTit + Padr(BGQ->BGQ_CODLAN + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
								cValor + " " + space(len(cValor)) + " " + ;
								If(alltrim(BGQ->BGQ_NUMLAU) <> "BBC",substr(BGQ->BGQ_OBS,1,35),"")
									R673Linha(cLinha,1,0)
								Endif
							Endif
						Endif
						cTit := space(30)
					EndIf
					If  BGQ->BGQ_TIPO == "1"
						nDebFix += BGQ->BGQ_VALOR
					Else
						If  BGQ->BGQ_TIPO == "2"
							nCreFix += BGQ->BGQ_VALOR
						Endif
					Endif
					lTem := .T.
           BGQ->(DbSkip())
       EndDo          
       
    Endif    
    
Else

    BBC->(DbSetOrder(2))
    If  BBC->(msSeek(xFilial("BBC")+BAU->BAU_CODIGO+"11"))
        While ! BBC->(Eof()) .And. ;
                BBC->(BBC_FILIAL+BBC_CODIGO+BBC_STATUS+BBC_PROMED) == ;
                xFilial("BBC")+cRdaAnt+"11"
		   // BOPS 98697
		   If lCposVld
			   If ! ( cAno + cMes + "01" >= DtoS(BBC->BBC_VLDINI) .And. ;
				   (DtoS(LastDay(CtoD("01/"+cMes+"/"+cAno))) <= DtoS(BBC->BBC_VLDFIM) .Or. Empty(BBC->BBC_VLDFIM)) )
				   BBC->(DbSkip())
				   Loop
			   EndIf
		   EndIf
           BBB->(DbSetOrder(1))
	       BBB->(msSeek(xFilial("BBB")+BBC->BBC_CODSER))
   	       If  lLisRes // lAnalitico
               cValor := TransForm(BBC->BBC_VALOR,pMoeda2) 
	           If  BBB->BBB_TIPSER == "1"
                   If  lLisRes
                       cLinha := cTit + Padr(BBC->BBC_CODSER + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
	                             space(len(cValor)) + " " + cValor
                       R673Linha(cLinha,1,0)
                   Endif
               Else
	               If  BBB->BBB_TIPSER == "2"
                       If  lLisRes
                           cLinha := cTit + Padr(BBC->BBC_CODSER + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
	                                 cValor + " " + space(len(cValor))
                           R673Linha(cLinha,1,0)
                       Endif
                   Endif
               Endif
               cTit := space(30)
	       Endif
	       If  BBB->BBB_TIPSER == "1"
	           nDebFix += BBC->BBC_VALOR
    	   Else
	           If  BBB->BBB_TIPSER == "2"
	               nCreFix += BBC->BBC_VALOR                  
	           Endif
	       Endif                                 
	       lTem := .T.
    	   BBC->(DbSkip())
	    Enddo
    Endif   
Endif
If  lLisRes
    cLinha := cTit + Padr("Total Debitos/Creditos Fixos",nTamDes,".") + ": " + ;
              TransForm(nCreFix,pMoeda2) + " " + ;
              TransForm(nDebFix,pMoeda2)
    R673Linha(cLinha,1,0)
Endif    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista debitos/creditos variaveis                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lLisRes
    If  lLisRes // lAnalitico
        cLinha := Replicate(' ',nLimite)
        R673Linha(cLinha,1,0)
    Endif    
Endif
cTit := "Debitos/Creditos Variaveis:   "
lTem := .F.
BGQ->(DbSetOrder(2))
If  BGQ->(msSeek(xFilial("BGQ")+cRdaAnt+cAno+cMes+cCodOpe))
    While ! BGQ->(Eof()) .And. ;
   		    BGQ->(BGQ_FILIAL+BGQ_CODIGO+BGQ_ANO+BGQ_MES+BGQ_CODOPE) == ;
	        xFilial("BGQ")+cRdaAnt+cAno+cMes+cCodOpe
       If  ! empty(cOpeLot+cNumLot) .and. ;
           BGQ->(BGQ_OPELOT+BGQ_NUMLOT) <> cOpeLot+cNumLot
           BGQ->(DbSkip())
           Loop
       Endif	              
       If  alltrim(BGQ->BGQ_NUMLAU) == "BBC"
           BGQ->(DbSkip())
           Loop
       Endif	              
       If  nFase == 2 .and. empty(BGQ->BGQ_NUMLOT)
           BGQ->(DbSkip())
           Loop
       Endif
       If  nFase <> 2 .and. ! empty(BGQ->BGQ_NUMLOT)
           BGQ->(DbSkip())
           Loop
       Endif
	   BBB->(DbSetOrder(1))
	   BBB->(msSeek(xFilial("BBB")+BGQ->BGQ_CODLAN))
	   If  lLisRes // lAnalitico
           cValor := TransForm(BGQ->BGQ_VALOR,pMoeda2) 
           If  BGQ->BGQ_TIPO == "1"
               If  lLisRes
    	           cLinha := cTit + Padr(BGQ->BGQ_CODLAN + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
	                         space(len(cValor)) + " " + cValor + " " + ;
                             If(alltrim(BGQ->BGQ_NUMLAU) <> "BBC",substr(BGQ->BGQ_OBS,1,35),"")
                   R673Linha(cLinha,1,0)
               Endif 
           Else
               If  BGQ->BGQ_TIPO == "2"
                   If  lLisRes
    	               cLinha := cTit + Padr(BGQ->BGQ_CODLAN + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
	                             cValor + " " + space(len(cValor)) + " " + ;
	                             If(alltrim(BGQ->BGQ_NUMLAU) <> "BBC",substr(BGQ->BGQ_OBS,1,35),"")
                       R673Linha(cLinha,1,0)
                   Endif 
               Endif
           Endif
           cTit := space(30)
	   EndIf
       If  BGQ->BGQ_TIPO == "1"
	       nDebVar += BGQ->BGQ_VALOR
	   Else
           If  BGQ->BGQ_TIPO == "2"
	           nCreVar += BGQ->BGQ_VALOR
	       Endif
	   Endif                                 
       lTem := .T.
       BGQ->(DbSkip())
    Enddo
Endif    
If  lLisRes
    cLinha := cTit + Padr("Total Debitos/Creditos variaveis",nTamDes,".") + ": " + ;
              TransForm(nCreVar,pMoeda2) + " " + ;
              TransForm(nDebVar,pMoeda2) 
    R673Linha(cLinha,1,0)
Endif    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista apontamentos                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  lLisRes
    If  lLisRes // lAnalitico
        cLinha := Replicate(' ',nLimite)
        R673Linha(cLinha,1,0)
    Endif    
Endif    
cTit := "Apontamentos da Producao:     "
lTem := .F.
BCE->(DbSetOrder(2))
If  BCE->(msSeek(xFilial("BGQ")+cRdaAnt+cCodOpe+cAno+cMes))
    While ! BCE->(Eof()) .And. BCE->(BCE_FILIAL+BCE_CODIGO+BCE_CODINT+BCE_ANOPAG+BCE_MESPAG) == ;
                                xFilial("BGQ")+cRdaAnt+cCodOpe+cAno+cMes
                                
	   If ! Empty(cOpeLot+cNumLot) .And. BCE->(BCE_OPELOT+BCE_NUMLOT) <> cOpeLot+cNumLot
	       BCE->(DbSkip())
	       Loop
	   EndIf
                                
       If  lLisRes // lAnalitico
           BBB->(DbSetOrder(1))
           BBB->(msSeek(xFilial("BBB")+BCE->BCE_CODPAG))
           cValor := TransForm(BCE->BCE_VLRAPT,pMoeda2) 
           If  lLisRes
               cLinha := cTit + Padr(BCE->BCE_CODPAG + "-" + alltrim(BBB->BBB_DESCRI),nTamDes,".") + ": " + ;
	                     TransForm(BCE->BCE_VLRAPT,pMoeda2) 
               R673Linha(cLinha,1,0)
           Endif
           cTit := space(30)
	   EndIf
       nCreApo += BCE->BCE_VLRAPT
       lTem := .T.
       BCE->(DbSkip())
    Enddo
Endif    
If  lLisRes
    cLinha := cTit + Padr("Total Apontamentos da Producao",nTamDes,".") + ": " + ;
              TransForm(nCreApo,pMoeda2) + " " + ;
              TransForm(nDebApo,pMoeda2) 
    R673Linha(cLinha,1,0)
Endif    
//cLinha := Replicate(' ',nLimite)
//R673Linha(cLinha,1,0)

If  lSoma
    ntDebFix += nDebFix
    ntCreFix += nCreFix
    ntCreVar += nCreVar
    ntDebVar += nDebVar
    ntCreApo += nCreApo
    ntDebApo += nDebApo
Endif    

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673Res     ³ Autor ³ Angelo Sperandio   ³ Data ³ 28.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime resumo dos totais                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673Res()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cTit                      
Local i
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista cabecalho                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinha := Replicate('-',nLimite)
R673Linha(cLinha,1,0)
cLinha := "Resumo do Pagamento           Descricao                                   Credito         Debito           Base"
R673Linha(cLinha,1,0)
cLinha := "                              ------------------------------------        -------         ------           ----"
R673Linha(cLinha,1,0)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime resumo                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTit := "                              "
If  len(aTabRes) > 0
    For i := 1 to len(aTabRes)
        cLinha := cTit + Padr(aTabRes[i,1],nTamDes,".") + ": " + aTabRes[i,2] + " " + aTabRes[i,3] + " " + aTabRes[i,4] + " " + aTabRes[i,5]
        R673Linha(cLinha,1,0)
        cTit := space(30)
    Next    
Endif                    
cLinha := Replicate('-',nLimite)
R673Linha(cLinha,1,0)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673Res_Prod³ Autor ³ Angelo Sperandio   ³ Data ³ 28.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime resumo da producao medica                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673Res_Prod(aRes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nX := 0
Local aTitulo := {  "Custo Operacional Pessoa Fisica",;
					"Custo Operacional Pessoa Juridica",;
					"Pre-Pagamento Pessoa Fisica",;
					"Pre-Pagamento Pessoa Juridica",;
					"Intercambio",;
					"Outros",;
					"Glosas" }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista cabecalho                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinha := Replicate('-',nLimite)
R673Linha(cLinha,1,0)
nli++
cTit := "Resumo da Producao Medica:    "

nTotal := 0
For nX := 1 TO Len(aRes)
    If  aRes[nX] > 0
        cLinha := cTit + Padr(aTitulo[nX],nTamDes,".") + ": " + Transform(aRes[nX],pMoeda2)
        R673Linha(cLinha,1,0)
        cTit := space(30)
    	If  nX < 7
		    nTotal += aRes[nX]
		EndIf
    EndIf
Next

cLinha := cTit + Padr("Total da Producao Medica",nTamDes,".") + ": " + Transform(nTotal,pMoeda2)
R673Linha(cLinha,1,1)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R673Linha ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime linha de detalhe                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R673Linha(cLinha,nAntes,nApos)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL i
LOCAL nLiRDA := nLi                                                          
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salta linhas antes                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemLot := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salta linhas antes                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 to nAntes
    nli++
Next    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nli > nLinPag
    nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
    nli++               
    
	//Acrescenta "R.D.A - CLASSE - ESPECIALIDADE" a cada nova pagina.
   	If nLiRDA <> 999
   		@ nLi, 0 PSAY "R.D.A.: " + BAU->BAU_CODIGO + "-" + alltrim(BAU->BAU_NOME) + ;
		          "   Classe: " + alltrim(posicione("BAG",1,xFilial("BAG")+BAU->BAU_TIPPRE,"BAG_DESCRI"))
        nli++               
   		@ nLi, 0 PSAY "Especialidade: " + alltrim(cEspecia)
        nli++               
        @ nLi, 0 PSAY "Lote..: " + cOpeLot + " " + cNumLot + " " +cDesLot

		nli:=nli+1
		@nli,0 PSAY Replicate('-',nLimite)
		nli++
	EndIf
	
Endif    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime linha de detalhe                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ nLi, 0 pSay cLinha
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salta linhas apos                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 to nApos
    nli++
Next    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetMesAno      ºAutor ³Paulo Carnelossi  º Data ³ 09/01/04  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna Mes/Ano                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function	RetMesAno(cAnoMes)
Static aMeses := {"Jan","Fev","Mar","Abr","Mai","Jun",;
					"Jul", "Ago", "Set", "Out", "Nov", "Dez"}
Local cString := ""					

If Val(Right(cAnoMes,2)) > 0 .And. Val(Right(cAnoMes,2)) <= 12
    cString := aMeses[Val(Right(cAnoMes,2))]+"/"+Left(cAnoMes,4)
Else
    cString := Right(cAnoMes,2)+"/"+Left(cAnoMes,4)
EndIf

Return(cString) 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function CriaSX1()
LOCAL aRegs	 :=	{}

DbSelectArea("SX1")
SX1->(DbSetOrder(1))

If SX1->(MsSeek(cPerg+"02"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BA0PLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BA0PLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

If SX1->(MsSeek(cPerg+"03"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BA0PLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BA0PLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

If SX1->(MsSeek(cPerg+"06"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BC1PLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BC1PLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

If SX1->(MsSeek(cPerg+"07"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BC1PLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BC1PLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf       

If SX1->(MsSeek(cPerg+"12"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BY0PL3" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BY0PL3"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

If SX1->(MsSeek(cPerg+"13"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "BAF" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "BAF"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

If SX1->(MsSeek(cPerg+"28"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "B7APLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "B7APLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf
		
If SX1->(MsSeek(cPerg+"29"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "B7APLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "B7APLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf
		
If SX1->(MsSeek(cPerg+"34"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "B2DPLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "B2DPLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf
		
If SX1->(MsSeek(cPerg+"35"))
	If ( AllTrim(SX1->X1_F3) == "" .Or. AllTrim(SX1->X1_F3) <> "B2DPLS" )
		SX1->(RecLock("SX1",.F.))
		SX1->X1_F3 := "B2DPLS"
		SX1->X1_PYME  := "N"
		SX1->(MsUnLock())
	EndIf
EndIf

aadd(aRegs,{cPerg,"45","Número da NFSS De ?"      ,"","","mv_ch)","C", 10,0,0,"G","","mv_par45",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BBZPLS"		,""})
aadd(aRegs,{cPerg,"46","Número da NFSS Ate ?"     ,"","","mv_ch(","C", 10,0,0,"G","","mv_par46",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","","BBZPLS"		,""})

If  SX1->(MsSeek(cPerg+"45")) .And. !("Número da NFSS De ?" $ SX1->X1_PERGUNT) 
       SX1->(RecLock("SX1",.F.))
       SX1->(DbDelete())
       SX1->(MsUnLock())
Endif 
                                                                   
If  SX1->(MsSeek(cPerg+"46")) .And. !("Número da NFSS Ate ?" $ SX1->X1_PERGUNT) 
       SX1->(RecLock("SX1",.F.))
       SX1->(DbDelete())
       SX1->(MsUnLock())
Endif 
/*
while  SX1->(MsSeek(cPerg+"48")) 
       SX1->(RecLock("SX1",.F.))
       SX1->(DbDelete())
       SX1->(MsUnLock())
enddo

while  SX1->(MsSeek(cPerg+"49")) 
       SX1->(RecLock("SX1",.F.))
       SX1->(DbDelete())
       SX1->(MsUnLock())
enddo
*/
PlsVldPerg( aRegs )

//Leonardo Portella - 31/07/14 - Inicio - Chamado - ID: 12634

PutSx1(cPerg,"48","Tipo Guia?"    		,"","","mv_ch)","C",TamSx3(	'BCL_TIPGUI')[1]	,0,0,"G","","BB2PLS"   	,"","","mv_par48",""		,"","","",""   		,"","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"49","Somente glosadas?"	,"","","mv_ch-","C",01							,0,0,"C","","   "   	,"","","mv_par49","Sim"		,"","","","Não"		,"","","","","","","","","","","",{},{},{})

PutSx1(cPerg,"50","Lote Finaceiro ?"	,"","","mv_ch-","C",10							,0,0,"G","","   "   	,"","","mv_par50",""		,"","","",""		,"","","","","","","","","","","",{},{},{})

//Leonardo Portella - 31/07/14 - Fim

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuSXB    ºAutor  ³Microsiga           º Data ³  03/Mai/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza o SXB de acordo com a FNC SCCXIT.                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLSR673                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuSXB()
Local aSXB     := {}
Local aEstrut  := {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM","XB_WCONTEM"}
Local i		   := 0
Local j		   := 0
Local bAtu	   := .F.

DbSelectArea("SXB")
SX1->(DbSetOrder(1))

If !SXB->( DbSeek("BJ7PLS6") )
	bAtu := .T.
	aAdd(aSXB,{	"BJ7PLS","6","01","","Lote de Cobranca","","",'PlsFilTp6("BDC")',''})
EndIf

If !SXB->( DbSeek("B2DPLS6") )
	bAtu := .T.
	aAdd(aSXB,{	"B2DPLS","6","01","","Planos de Saude","","",'PlsFilTp6("BI3")',''})
EndIf

If bAtu
	For i:= 1 To Len(aSXB)
		RecLock("SXB",.T.)	
		For j:=1 To Len(aSXB[i])
			If !Empty(FieldName(FieldPos(aEstrut[j]))) .And. aSXB[i,j] != NIL
				FieldPut(FieldPos(aEstrut[j]),aSXB[i,j])
			EndIf
		Next j	
		dbCommit()
		MsUnLock()
	Next i 
EndIf

Return
