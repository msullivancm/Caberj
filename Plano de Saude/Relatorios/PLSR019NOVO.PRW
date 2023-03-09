#include "PLSMGER.CH"

#IFDEF TOP
       #include "TOPCONN.CH"
#ENDIF       

#include "PROTHEUS.CH"
#include "COLORS.CH"

#define ANTES_LACO 1
#define COND_LACO 2
#define PROC_LACO 3
#define DEPOIS_LACO 4

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSR019    บAutor  ณPaulo Carnelossi   บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime relacao de utilizacao de servicos medicos p/        บฑฑ
ฑฑบ          ณEmpresa/Familia                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณAlteracao nos relatorios para aceitar alguns novos paramet. บฑฑ
ฑฑบ          ณcomo nro de impresso e matricula sistema antigo.            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PLSR019NOVO()  
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local wnrel
Local cDesc1 := "Este programa tem como objetivo imprimir a rela็ใo de utiliza็ใo  "
Local cDesc2 := "de servi็os m้dicos por empresa/famํlia. O relat๓rio NรO irแ apre-"
Local cDesc3 := "sentar guias jแ cobradas, somente as com fase PRONTA e/ou PAGAS.   "
Local cString := "BD6"
Local aOrd := {"Codigo","Nome","Cod.LDP + PEG + Matricula (Antiga Sem Subtotais)","RDA + PEG + Guia + Matricula (Antiga Sem Subtotais)"} 

PRIVATE cTitulo:= "Rela็ใo de utiliza็ใo de Servi็os M้dicos"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg   := "PLY019" 
Private cPerg1  := "PLW019"
Private nomeprog:= "PLSR019" 
Private nLastKey:=0
Private Tamanho := "G"
Private nTipo
Private cChavAnt := ""
Private nPerINSS := 0 //GetNewPar("MV_PLSINSS", 15)
Private nQtdLin  := 55

BD5->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BAU->(DbSetOrder(1))
BQC->(DbSetOrder(1))
SX1->(DbSetOrder(1))

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Envia controle para a funcao SETPRINT                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
wnrel := "PLSR019NOVO"

//CriaNovoParSX1()
//Pergunte(cPerg,.T.)
//Atualizay_Var()
//CriaNovoParWSX1()
//Pergunte(cPerg1,.T.)
//Atualizaw_Var()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seta variaveis do relatorio                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private cOpeUsr := ""
Private cEmpDe  := ""
Private cEmpAte := ""
Private cConVeI := ""
Private cConVeF := ""
Private cSubVeI := ""
Private cSubVeF := ""
Private cAnoDe  := ""
Private cMesDe  := ""
Private cAnoAte := ""
Private cMesAte := ""
Private nLDPDe  := 0
Private nLDPAte := 0
Private cPegDe  := ""
Private cPegAte := ""
Private cRdaDe  := ""
Private cRdaAte := ""
Private cGCobDe := ""
Private cGCobAte:= ""
Private cDMovDe := ""
Private cDMovAte:= ""
Private cTpProDe:= ""
Private cProcDe := ""
Private cTpProAt:= ""
Private cProcAt := ""
Private cPtuDe  := ""
Private cPtuAte := ""
Private nValDe  := ""
Private nValAte := ""
Private nConVal := ""
Private nTipPes := ""
Private nConGrC := ""

Private nImpSFam:= 0
Private nImpSSub:= 0
Private nImpSCon:= 0
Private nImpSEmp:= 0
Private nImpSMes:= 0

Private nFase   := 0
Private nImpNom := 0
Private nTipMat := 0
Private nNumDoc := 0
Private nComPag := 0
Private nMosGlo := 0
Private nImpUsr := 0

Private cTpgIn := ""
Private cTpgFn := ""

Private aVetLeg := {}

Private nImpSGer:= 0
Private lInterca := .F.

CriaNovoParSX1()
Pergunte(cPerg,.T.)
Atualizay_Var()
//CriaNovoParWSX1()
//Pergunte(cPerg1,.T.)
//Atualizaw_Var()


Private nTamNImp  := GetNewPar("MV_YTAMNI",7) // Parametro de tamanho do nro impresso, a fim de controlar impressao

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho,,.F.)

If nLastKey == 27
   Return
End

SetDefault(aReturn,cString)

If nLastKey == 27
   Return ( NIL )
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Caso rel. intercambio, modificar dados apresentados...       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|lEnd| PLSR019Imp(@lEnd,wnRel,cString)},cTitulo)

M->BF8_CODINT := cOpeUsr 
M->BTC_CODPAD := cTpProDe 

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณ Fun…o    ณPLSR019Impณ Autor ณ Paulo Carnelossi      ณ Data ณ 22/01/04 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Descri…o ณRelacao de Utilizacao de Servicos Medicos p/ Empresa/Familiaณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Sintaxe   ณPLSR019Imp(lEnd,wnRel,cString)                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso       ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function PLSR019Imp(lEnd,wnRel,cString)
Local cbcont,cbtxt

LOCAL cSQL
Local cArqTrab  := CriaTrab(nil,.F.)
Local aR019Cond
Local aQuebra  := { "", "", "", "", "", "", "" }
Local aBQuebra := {		{||(cArqTrab)->(BD6_OPEUSR)},;
						{||(cArqTrab)->(BD6_CODEMP)},;
						{||(cArqTrab)->(BD6_ANOMES)},;
						{||(cArqTrab)->(BD6_CONTRATO)},;
						{||(cArqTrab)->(BD6_SUBCONTR)},;
						{||(cArqTrab)->(BD6_MATRIC)} 	}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Matriz destinada a abrigar todos os totais utilizados no relatorio(28 elementos)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aTotal  := { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0 }
Local lImpr   := (cAnoDe+cAnoDe != cAnoAte+cMesAte)
Local lCentr  := .F.
Local nOrdSel := aReturn[8]

//Atualizay_Var()
//Atualizaw_Var()
                                                                                                    
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Definicao dos cabecalhos                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cabec1:= "Codigo do Usuario     Nome do Titular da Familia"
cabec2 := "   TR.D Nome USuario       Dt.Atend.  N.Debito               Nome Solic       Rda/Nome RDA   Comp.  F. TG. Qtd. Codigo Proc.        Procedimento       M.G Vlr. Glosa    Valor Pagto    Vlr Base PF   %Cop       Valor PF"
If Val(cPtuDe) > 0 .Or. Val(cPtuAte)>0
	lInterca := .T.
	cabec2 := " TR.D Nome  Usuario   Dt.Atend.  N.Debito          Nome Solic   Rda/Nome RDA Com. F. TG.Qtd.  Codigo Proc.          Procedimento       M.G         V.Glosa  V.Apres. V.Contr.  Difer.   V.Pagto  V.Base PF  %Cop  Valor PF"
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo:=GetMv("MV_COMP")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta novo nome do titulo do relatorio mostrando mes/ano                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If cAnoDe+cAnoDe == cAnoAte+cMesAte
	cTitulo := AllTrim(cTitulo)+" - "+PLRETMES(Val(cAnoDe))+"/"+cAnoDe
EndIf	

dbSelectArea("BD6")
dbSelectArea("BD7")
dbSelectArea("BDX")

cSQL := "SELECT BD6.BD6_OPEUSR, BD6.BD6_CODEMP, BD6.BD6_MATRIC, BD6.BD6_TIPREG,  "
cSQL += "BD6.BD6_DIGITO, BD6.BD6_ANOPAG||BD6.BD6_MESPAG AS BD6_ANOMES, BD6.BD6_ORIMOV, BD6_SEQUEN, "
cSQL += "BD6.BD6_CONEMP||BD6_VERCON AS BD6_CONTRATO, BD6.BD6_SUBCON||BD6. BD6_VERSUB AS BD6_SUBCONTR, "
cSQL += "BD6.BD6_NOMUSR, BD6.BD6_CODRDA, BD6.BD6_NOMRDA, BD6.BD6_SEQIMP, BD6.BD6_QTDPRO, BD6.BD6_VLRAPR, "
cSQL += "BD6.BD6_DATPRO, BD6.BD6_NUMIMP, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO, BD6.BD6_F_VLPF, "
cSQL += "BD6.BD6_CODPAD, BD6.BD6_CODPRO, BD6.BD6_DESPRO, BD6.BD6_VLRBPR, BD6.BD6_BLOPAG, BD6.BD6_CONSFR, "
cSQL += "BD6.BD6_VLRPAG, BD6.BD6_VLRTPF, BD6.BD6_REGSOL, BD6.BD6_VLRBPF, BD6.BD6_PERCOP, "
cSQL += "BD6.BD6_VLRGLO, BD6.BD6_BLOCPA, BA1.BA1_MATANT, BA1.BA1_MATUSB, BD6.BD6_FASE,BD6.BD6_TIPGUI "

If nConGrC = 1
	If nTipPes = 1
		cSQL += ", BA3.BA3_GRPCOB " 
	Else
		cSQL += ", BQC.BQC_GRPCOB " 
	Endif
Endif

cSQL += " FROM " 

cSQL += RetSQLName("BD6")+" BD6, " + RetSQLName("BA1")+" BA1, " +RetSQLName("BA3")+" BA3 "

If nConGrC = 1
	If nTipPes <> 1
		cSQL += ", "+RetSQLName("BQC")+" BQC "
	Endif
Endif

cSQL += "WHERE "
cSQL += "BD6.BD6_FILIAL  = '"+xFilial("BD6")+"' AND "
cSQL += "BD6.BD6_OPEUSR  = '"+cOpeUsr+"' AND " 
cSQL += "BD6.BD6_CODEMP >= '"+cEmpDe+"' AND " 
cSQL += "BD6.BD6_CODEMP <= '"+cEmpAte+"' AND " 
cSQL += "BD6.BD6_CONEMP||BD6.BD6_VERCON >= '"+cConVeI+"' AND " 
cSQL += "BD6.BD6_CONEMP||BD6.BD6_VERCON <= '"+cConVeF+"' AND " 
cSQL += "BD6.BD6_SUBCON||BD6.BD6_VERSUB >= '"+cSubVeI+"' AND " 
cSQL += "BD6.BD6_SUBCON||BD6.BD6_VERSUB <= '"+cSubVeF+"' AND " 
cSQL += "BD6.BD6_ANOPAG||BD6.BD6_MESPAG >= '"+cAnoDe+cMesDe+"' AND " 
cSQL += "BD6.BD6_ANOPAG||BD6.BD6_MESPAG <= '"+cAnoAte+cMesAte+"' AND " 
cSQL += "BD6.BD6_DATPRO >= '"+DTOS(cDMovDe)+"' AND " 
cSQL += "BD6.BD6_DATPRO <= '"+DTOS(cDMovAte)+"' AND " 
cSQL += "BD6.BD6_CODPAD >= '"+cTpProDe+"' AND " 
cSQL += "BD6.BD6_CODPAD <= '"+cTpProAt+"' AND " 
cSQL += "BD6.BD6_CODPRO >= '"+cProcDe+"' AND " 
cSQL += "BD6.BD6_CODPRO <= '"+cProcAt+"' AND "
cSQL += "BD6.BD6_FILIAL = BA1.BA1_FILIAL AND "
cSQL += "BD6.BD6_OPEUSR = BA1.BA1_CODINT AND "                                                      
cSQL += "BD6.BD6_CODEMP = BA1.BA1_CODEMP AND "
cSQL += "BD6.BD6_MATRIC = BA1.BA1_MATRIC AND "
cSQL += "BD6.BD6_TIPREG = BA1.BA1_TIPREG AND "
cSQL += "BD6.BD6_CODLDP >= '"+nLDPDe+"' AND "
cSQL += "BD6.BD6_CODLDP <= '"+nLDPAte+"' AND "
cSQL += "BD6.BD6_CODPEG >= '"+cPegDe+"' AND "
cSQL += "BD6.BD6_CODPEG <= '"+cPegAte+"' AND "
cSQL += "BD6.BD6_CODRDA >= '"+cRdaDe+"' AND "
cSQL += "BD6.BD6_CODRDA <= '"+cRdaAte+"' AND "
cSQL += "BD6.BD6_FILIAL = BA3.BA3_FILIAL AND "
cSQL += "BD6.BD6_OPEUSR = BA3.BA3_CODINT AND "
cSQL += "BD6.BD6_CODEMP = BA3.BA3_CODEMP AND "
cSQL += "BD6.BD6_MATRIC = BA3.BA3_MATRIC AND "

/*
cSQL += "BA1.BA1_CODINT = BA3.BA3_CODINT AND "
cSQL += "BA1.BA1_CODEMP = BA3.BA3_CODEMP AND "
cSQL += "BA1.BA1_MATRIC = BA3.BA3_MATRIC AND "
cSQL += "BA1.BA1_CONEMP = BA3.BA3_CONEMP AND "
cSQL += "BA1.BA1_VERCON = BA3.BA3_VERCON AND "
cSQL += "BA1.BA1_SUBCON = BA3.BA3_SUBCON AND "
cSQL += "BA1.BA1_VERSUB = BA3.BA3_VERSUB AND "
*/


If nConGrC = 1
	If nTipPes = 1
		cSQL += "BA3.BA3_GRPCOB >= '"+cGCobDe+"' AND " 
		cSQL += "BA3.BA3_GRPCOB <= '"+cGCobAte+"' AND " 	           
	Else           
		cSQL += "BD6.BD6_OPEUSR || BD6.BD6_CODEMP = BQC.BQC_CODIGO AND "
		cSQL += "BD6.BD6_CONEMP = BQC.BQC_NUMCON AND "
		cSQL += "BD6.BD6_VERCON = BQC.BQC_VERCON AND "
		cSQL += "BD6.BD6_SUBCON = BQC.BQC_SUBCON AND "
		cSQL += "BD6.BD6_VERSUB = BQC.BQC_VERSUB AND "
		cSQL += "BQC.BQC_GRPCOB >= '"+cGCobDe+"' AND " 
		cSQL += "BQC.BQC_GRPCOB <= '"+cGCobAte+"' AND " 
		cSQL += "BA3_COBNIV <> '1' AND "
	Endif
Endif

cSQL += "BD6.BD6_SEQIMP >= '" + cPtuDe + "' AND "
cSQL += "BD6.BD6_SEQIMP <= '" + cPtuAte+ "' AND "
	
If nConVal == 1
	cSQL += "BD6.BD6_VLRTPF >= "+Str(nValDe,17,2)+" AND " 
	cSQL += "BD6.BD6_VLRTPF <= "+Str(nValAte,17,2)+" AND " 
	If nValDe > 0
		cSQL += "( BD6.BD6_BLOCPA <> '1' OR BD6.BD6_BLOPAG <> '1' ) AND "
	Endif
Else
	cSQL += "BD6.BD6_VLRPAG >= "+Str(nValDe,17,2)+" AND " 
	cSQL += "BD6.BD6_VLRPAG <= "+Str(nValAte,17,2)+" AND " 
	If nValDe > 0
		cSQL += "BD6.BD6_BLOPAG <> '1' AND "
	Endif
	
EndIf

If nFase == 1
	cSQL += "BD6.BD6_FASE IN ('2','3') AND " 
ElseIf nFase == 2
	cSQL += "BD6.BD6_FASE = '2' AND " 
ElseIf nFase == 3
	cSQL += "BD6.BD6_FASE = '3' AND " 
ElseIf nFase == 4
	cSQL += "BD6.BD6_FASE IN ('3','4','2') AND "    
ElseIf nFase == 5
	cSQL += "BD6.BD6_FASE IN ('3','4') AND " 
EndIf     

cSQL += " BD6_SITUAC = '1' AND "

If nConVal == 1
    cSQL +=	"BD6.BD6_NUMFAT = ' ' AND "
Endif

cSQL += "BD6.D_E_L_E_T_ <> '*' AND "
cSQL += "BA3.D_E_L_E_T_ <> '*' AND "

If nConGrC = 1
	If nTipPes <> 1
		cSQL += "BQC.D_E_L_E_T_ <> '*' AND "
	Endif
Endif

cSQL += "BA1.D_E_L_E_T_ <> '*' "
cSQL += " ORDER BY "
   

// Montar a Ordem do Relatorio
Do Case

	Case nOrdSel == 1
	
		If nTipMat = 1
			cSQL += " BD6.BD6_CODEMP, BD6.BD6_CONEMP, BD6.BD6_VERCON, BD6.BD6_SUBCON, BD6.BD6_VERSUB, "		
			cSQL += " BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DIGITO, "	
		Else
			cSQL += " BA1.BA1_MATANT, BA1.BA1_MATUSB, "
		Endif	
	
		cSQL += " BD6.BD6_ANOPAG, BD6.BD6_MESPAG, "
		
		If nNumDoc = 1 
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO "
		Else
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMIMP "
		Endif
					
	
	Case nOrdSel == 2
		cSQL += " BD6.BD6_CODEMP, BD6.BD6_ANOPAG, BD6.BD6_MESPAG, "	
		If nImpNom == 2
			cSQL += " BD6.BD6_NOMUSR, "
		EndIf

		If nTipMat = 1
			cSQL += " BD6.BD6_CONEMP, BD6.BD6_VERCON, BD6.BD6_SUBCON, BD6.BD6_VERSUB, "		
			cSQL += " BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DIGITO, "	
		Else
			cSQL += " BA1.BA1_MATANT, BA1.BA1_MATUSB, "
		Endif		
		If nNumDoc = 1 
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO "
		Else
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMIMP "
		Endif
			
	
	Case nOrdSel == 3     
		cSQL += " BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_ANOPAG, BD6.BD6_MESPAG, "		

		If nTipMat = 1
			cSQL += " BD6.BD6_CONEMP, BD6.BD6_VERCON, BD6.BD6_SUBCON, BD6.BD6_VERSUB, "		
			cSQL += " BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DIGITO, "	
		Else
			cSQL += " BA1.BA1_MATANT, BA1.BA1_MATUSB, "
		Endif	
		
		If nNumDoc = 1 
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_NUMERO "
		Else
			cSQL += " BD6.BD6_DATPRO, BD6.BD6_NUMIMP "
		Endif		
			
			
	Case nOrdSel == 4
		cSQL += " BD6.BD6_CODRDA, "
		
		If nNumDoc = 1 
			cSQL += " BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO, "
		Else
			cSQL += " BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMIMP, "
		Endif
		
		If nTipMat = 1
			cSQL += " BD6.BD6_CONEMP, BD6.BD6_VERCON, BD6.BD6_SUBCON, BD6.BD6_VERSUB, "
			cSQL += " BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DIGITO, "
		Else
			cSQL += " BA1.BA1_MATANT, BA1.BA1_MATUSB, "
		Endif
					
		cSQL += "BD6.BD6_ANOPAG, BD6.BD6_MESPAG, BD6.BD6_DATPRO  "
						
EndCase

PLSQuery(cSQL,cArqTrab)

//monta array contendo blocos de codigos que serao executados 
// antes while - cond. while - processamento while - apos while      

// Elemento 1 - ANTES_LACO
// Elemento 2 - COND_LACO
// Elemento 3 - PROC_LACO
// Elemento 4 - DEPOIS_LACO
// Elemento 5 - Variavel para comparacao
// Elemento 6 - Contador
// Elemento 7 - Nome do Campo
// Elemento 8 - Titulo do Campo
aR019Cond := {}

//Quebra enquanto nao fim de Arquivo  -----> BD6_CODEMP
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := ""}, ;
	   		{|nNivel|!Eof()}, ;
		   	{|nNivel|.T.}, ;
		   	{|nNivel|Impr_TotGer(cArqTrab, aTotal[nNivel], aR019Cond[nNivel][8], nImpSGer == 1, aTotal[nNivel+8], aTotal[nNivel+14], aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])}, ;
	   		Nil,;
		   	0, ;
		   	"BD6_OPEUSR",;  //pode ser qq campo
		   	"                Total Geral";
	   } )
   

//1a. Quebra por Grupo Empresa  -----> BD6_CODEMP
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := FieldGet(FieldPos(aR019Cond[nNivel][7]))}, ;
	   		{|nNivel|FieldGet(FieldPos(aR019Cond[nNivel][7])) == aR019Cond[nNivel][5]}, ;
		   	{|nNivel|Impr_Empresa(aQuebra, aBQuebra, nNivel, .F.)}, ;
		   	{|nNivel|Impr_TotEmp(aTotal, aQuebra, aBQuebra, nNivel, aR019Cond[nNivel][8], nImpSEmp == 1)}, ;
	   		Nil,;
		   	0, ;
		   	"BD6_CODEMP",;
		   	"                Sub-Total da Empresa";
	   } )

//2a. Quebra por Ano/Mes Pag -----> BD6_ANOPAG
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := FieldGet(FieldPos(aR019Cond[nNivel][7]))}, ;
	   		{|nNivel|FieldGet(FieldPos(aR019Cond[nNivel][7])) == aR019Cond[nNivel][5]}, ;
		   	{|nNivel|Impr_AnoMes(aQuebra, aBQuebra, nNivel, lImpr, lCentr, .F.)}, ;
		   	{|nNivel|Impr_TotAnoMes(aTotal, aQuebra, aBQuebra, nNivel, aR019Cond[nNivel][8], nImpSMes == 1) }, ;
	   		Nil,;
		   	0, ;
		   	"BD6_ANOMES",;
			space(40)+"              Sub-Total do Mes/Ano";
	   } )


//3a. Quebra por CONTRATO -----> BD6_CONTRATO
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := FieldGet(FieldPos(aR019Cond[nNivel][7]))}, ;
	   		{|nNivel|FieldGet(FieldPos(aR019Cond[nNivel][7])) == aR019Cond[nNivel][5]}, ;
		   	{|nNivel|Impr_Contrato(aQuebra, aBQuebra, nNivel, .F.)}, ;
		   	{|nNivel|Impr_TotContrato(aTotal, aQuebra, aBQuebra, nNivel, aR019Cond[nNivel][8], nImpSCon == 1)}, ;
	   		Nil,;
		   	0, ;
		   	"BD6_CONTRATO",;
			space(40)+"                Sub-Total do Contrato";
	   } )

//4a. Quebra por SUB-CONTRATO  -----> BD6_SUBCONTR
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := FieldGet(FieldPos(aR019Cond[nNivel][7]))}, ;
	   		{|nNivel|FieldGet(FieldPos(aR019Cond[nNivel][7])) == aR019Cond[nNivel][5]}, ;
		   	{|nNivel|Impr_SubContr(aQuebra, aBQuebra, nNivel, .F.)}, ;
		   	{|nNivel|Impr_TotSubContr(aTotal, aQuebra, aBQuebra, nNivel, aR019Cond[nNivel][8], nImpSSub == 1)}, ;
	   		Nil,;
		   	0, ;
		   	"BD6_SUBCONTR",;
			space(40)+"                Sub-Total do Sub-Contrato";
	   } )

//6a. Quebra por FAMILIA (Matricula/Titular) -----> BD6_MATRIC
aAdd( aR019Cond, ;
		   { ;
		   	{|nNivel|aR019Cond[nNivel][5] := FieldGet(FieldPos(aR019Cond[nNivel][7]))}, ;
	   		{|nNivel|FieldGet(FieldPos(aR019Cond[nNivel][7])) == aR019Cond[nNivel][5]}, ;
		   	{|nNivel|Impr_Titular(aQuebra, aBQuebra, nNivel, .F.,cArqTrab),;
		   			 Impr_Detalhe(cArqTrab, aTotal, aQuebra, aBQuebra, nNivel) }, ;
		   	{|nNivel|Impr_TotTitular(aTotal, aQuebra, aBQuebra, nNivel, aR019Cond[nNivel][8], nImpSFam == 1) }, ;
	   		Nil,;
		   	0, ;
		   	"BD6_MATRIC",;
			space(40)+"               Sub-Total da Familia";
	   } )

dbSelectArea(cArqTrab)
(cArqTrab)->(DbGoTop())

SetRegua(RecCount())

// Impressao do detalhe do relatorio com quebra
DetalheRel(aR019Cond, 1, cArqTrab)

Roda(cbcont,cbtxt,tamanho)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Recupera a Integridade dos dados                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea(cArqTrab)
dbCloseArea()

dbSelectArea("BD6")

Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Detalhe บAutor  ณPaulo Carnelossi บ Data ณ  06/01/04   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime linha de detalhe do relatorio                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Impr_Detalhe(cArqTrab, aTotal, aQuebra, aBQuebra, nNivel)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cTipReg := ""
Local cDigito := ""
Local cChaveI := ""
Local cStrRel := ""
Local cNomSol := Space(12)
Local cChaBD7 := ""
Local cStrBD7 := ""
Local nTotBD7 := 0
Local nTGlBD7 := 0
Local nTotGui := 0
Local nTotPro := 0
Local nDifer  := 0
Local cMotGlo := space(4)
Local cCabBD7 := "RDA Pagamento             UN    Refer. TDE/Und.    Coeficiente Fator     Vlr.Bs.Pagto.     Valor Glosa     Valor Pagto."

Local cStrGlo := ""
Local lPriGlo := .T.
Local lEscNome:= .F.
Local nVlrApr := 0
Local aTam := {}

Local aVetDet := {}

cTipReg := (cArqTrab)->(BD6_TIPREG)
cDigito := (cArqTrab)->(BD6_DIGITO)
cNomUsr := Substr((cArqTrab)->(BD6_NOMUSR),1,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verificar se deve mostrar a matr. antiga					 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipMat <> 1
	cTipReg := Substr(IIF(! Empty((cArqTrab)->(BA1_MATANT)),(cArqTrab)->BA1_MATANT, (cArqTrab)->BA1_MATUSB),15,2)
	cDigito := Substr(IIF(! Empty((cArqTrab)->(BA1_MATANT)),(cArqTrab)->BA1_MATANT, (cArqTrab)->BA1_MATUSB),17,1)
Endif	

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca o nome do solicitante do cadastro de RDA				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If BAU->(MsSeek(xFilial("BAU")+replicate("0",6-len(AllTrim((cArqTrab)->(BD6_REGSOL))))+(cArqTrab)->(BD6_REGSOL)))
	cNomSol := Substr(BAU->BAU_NOME,1,12)
EndIf	   

If Empty(cNomSol)
	If (cArqTrab)->(BD6_ORIMOV) == "1" 
		If BD5->(MsSeek(xFilial("BD5")+cOpeUsr+(cArqTrab)->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
			cNomSol := Substr(BD5->BD5_NOMSOL,1,12)
		Endif
	Else
		If BE4->(MsSeek(xFilial("BE4")+cOpeUsr+(cArqTrab)->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
			cNomSol := Substr(BE4->BE4_NOMSOL,1,12)
		Endif
	Endif
Endif


cStrRel := ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Posicionar e montar Array com BDX (Glosas)...                         ณ  
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nMosGlo <> 1
	If (cArqTrab)->BD6_VLRGLO > 0
		If BDX->(MsSeek(xFilial("BDX")+(cArqTrab)->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN))) 

			While BDX->(! Eof()) .And. BDX->(BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == (cArqTrab)->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)       
				Aadd(aVetDet,{BDX->BDX_CODGLO,BDX->BDX_DESGLO, BDX->BDX_INFGLO, BDX->BDX_TIPREG, BDX->BDX_PERGLO, BDX->BDX_VLRGLO})	

				If BDX->BDX_TIPREG = '1'				
					If cMotGlo <> space(4)
						If Substr(cMotGlo,1,3) <> BDX->BDX_CODGLO .And. Len(AllTrim(cMotGlo))=3
							cMotGlo += Substr(cMotGlo,1,3)+"*"
						Endif
					Else
						cMotGlo := BDX->BDX_CODGLO+" "
					Endif

					If Ascan(aVetLeg,{|x| x[1] == BDX->BDX_CODGLO}) = 0
						Aadd(aVetLeg,{BDX->BDX_CODGLO,BDX->BDX_DESGLO})
					Endif

				Endif					
		
				BDX->(DbSkip())								
			Enddo				

		Endif
	Endif	
Endif

If cChavAnt <> (cArqTrab)->(BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODLDP+"-"+BD6_CODPEG+"-"+BD6_NUMERO)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verificar se deve mostrar a Nro Impresso					 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cChaveI := AllTrim((cArqTrab)->(BD6_CODLDP+"-"+BD6_CODPEG+"-"+BD6_NUMERO))
	If nNumDoc <> 1
		cChaveI := AllTrim((cArqTrab)->(BD6_CODLDP+"-"+BD6_CODPEG+"-"+BD6_NUMIMP))
	Endif	
	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Caso seja relatorio de intercambio, tratar (falta de espaco) ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	lEscNome := Iif(Len(Alltrim((cArqTrab)->BD6_NUMIMP))>nTamNImp,.T.,.F.)	
	
	aTam := TamSX3("BD6_NUMERO")
	
	cStrRel := cTipReg+"."+cDigito+" "+Iif(lEscNome,"",cNomUsr)+" "+DtoC((cArqTrab)->BD6_DATPRO)+" "+cChaveI
	cStrRel += Iif(lEscNome,Replicate("",aTam[1]-nTamNImp),"")+" "+cNomSol+" "
	cStrRel += (cArqTrab)->BD6_CODRDA+" "+Substr((cArqTrab)->BD6_NOMRDA,1,8)+" "
    cStrRel	+= substr((cArqTrab)->BD6_ANOMES,5,2)+"/"+substr((cArqTrab)->BD6_ANOMES,1,4)+" "+(cArqTrab)->BD6_FASE+" "+ltrim(rtrim((cArqTrab)->BD6_TIPGUI))
	cChavAnt := (cArqTrab)->(BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODLDP+"-"+BD6_CODPEG+"-"+BD6_NUMERO)
	nTotGui++                                                                                                 
	
EndIf


cStrRel += Transform((cArqTrab)->BD6_QTDPRO,PesqPict("BD6","BD6_QTDPRO"))+" "+(cArqTrab)->BD6_CODPAD+"-"+Transform(BD6_CODPRO,PesqPict("BD6","BD6_CODPRO"))+" "
If lInterca
 cStrRel += Subs((cArqTrab)->BD6_DESPRO,1,15)
Else
 cStrRel += Subs((cArqTrab)->BD6_DESPRO,1,18)     
Endif                                        
 cStrREl += " "+cMotGlo+" "+Transform(Round((cArqTrab)->BD6_VLRGLO,2),"@E 999,999,999.99")+" "


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Valor apresentado para PTU sera sempre a partir de BD7		 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lInterca

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Devido a forma de trabalho do PTU, foi alterada a obtencao do valor apresentado de BD7 (padrao) para BD6 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//nVlrApr := VlrAprBD7((cArqTrab)->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN),(cArqTrab)->BD6_QTDPRO)

	nVlrApr := (cArqTrab)->BD6_VLRAPR * (cArqTrab)->BD6_QTDPRO
	
	nDifer := (cArqTrab)->BD6_VLRBPR-nVlrApr
	If nVlrApr = 0 .Or. (cArqTrab)->BD6_VLRBPR = 0
		nDifer := 0
	Endif
	cStrRel += Transform(Round(nVlrApr,2),"@E 99999.99")+" "+Transform(Round((cArqTrab)->BD6_VLRBPR,2),"@E 99999.99")+" "+Transform(Abs(Round(nDifer,2)),"@E 99999.99")
Endif

cStrRel +=Transform(Iif((cArqTrab)->BD6_BLOPAG <> '1',Round((cArqTrab)->BD6_VLRPAG,2),0),Iif(lInterca,"@E 999,999.99","@E 999,999,999.99"))+" "

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Tratar campo de Blqueio de part. fin. ou pagamento. Sistema nao zera automatico 	  ณ  
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If (cArqTrab)->BD6_BLOCPA = '1' .Or. (cArqTrab)->BD6_BLOPAG = '1'      //////bloqueio de participacao financeira...se tiver sim nao imprime o valor no relatorio
	cStrRel += Transform(0,Iif(lInterca,"@E 999,999.99","@E 999,999,999.99"))+" "+Transform(Round((cArqTrab)->(BD6_PERCOP),2),"@E 999.99")+" "+Transform(0,Iif(lInterca,"@E 999,999.99","@E 999,999,999.99"))
Else
    cStrRel += Transform(Round( Iif((cArqTrab)->BD6_CONSFR<>'1',(cArqTrab)->BD6_VLRBPF,(cArqTrab)->BD6_F_VLPF),2),Iif(lInterca,"@E 999,999.99","@E 999,999,999.99"))+" "+Transform(Round((cArqTrab)->(BD6_PERCOP),2),"@E 999.99")+" "+Transform(Round((cArqTrab)->BD6_VLRTPF,2),Iif(lInterca,"@E 999,999.99","@E 999,999,999.99"))
Endif
nTotPro += (cArqTrab)->BD6_QTDPRO

If Li > nQtdLin
	Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
Endif	
@ Li,000 PSay PadL(cStrRel,220)                    //220
Li++

aTotal[nNivel] += Iif((cArqTrab)->BD6_BLOPAG = '1',0,Round((cArqTrab)->(BD6_VLRPAG),2))
aTotal[nNivel+8] += Round(Iif((cArqTrab)->BD6_BLOCPA = '1',0,(cArqTrab)->(BD6_VLRTPF)),2)
aTotal[nNivel+14] += nTotGui
aTotal[nNivel+20] += nTotPro
aTotal[nNivel+26] += (cArqTrab)->BD6_VLRGLO
aTotal[nNivel+32] += nVlrApr

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Conforme Parametro, imprimir ou nao a comp. de pagamento	 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nComPag == 1

	cChaBD7 := (cArqTrab)->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
	cStrBD7 := ""
	If BD7->(MsSeek(xFilial("BD7")+cChaBD7))
	
		If Li+2 > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif		
	
		@ Li,  000 PSay ""
		@ Li+1,000 PSay PadL(cCabBD7,220)
		@ Li+2,000 PSay PadL(replicate("-",118),220)
		
		Li+=3
		
		nTotBD7 := 0
		nTGlBD7 := 0
	
		While ! BD7->(Eof()) .And. xFilial("BD7")+BD7->(BD7_OPEUSR+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)==xFilial("BD6")+cChaBD7

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Tratar caso for valor a pagar, e estiver bloqueado pagamento ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			
			If nConVal <> 1 .And. nValDe > 0
				If (BD7->BD7_VLRPAG < nValDe .Or. BD7->BD7_VLRPAG > nValAte) .Or. (BD7->BD7_BLOPAG == "1") 
					BD7->(DbSkip())
					Loop
				Endif			    
			Endif
						
			cStrBD7 := BD7->BD7_CODRDA+" "+Substr(BD7->BD7_NOMRDA,1,18)+" "+AllTrim(BD7->BD7_CODUNM)+" "+Transform(Round(BD7->BD7_REFTDE,2),PesqPict("BD7","BD7_REFTDE"))+" "
			cStrBD7 += AllTrim(BD7->BD7_UNITDE)+" "+Transform(BD7->BD7_COEFUT,PesqPict("BD7","BD7_COEFUT"))+Transform(BD7->BD7_FATMUL,PesqPict("BD7","BD7_FATMUL"))+" "
			cStrBD7 += Transform(Round(BD7->BD7_VLRBPR,2),PesqPict("BD7","BD7_VLRBPR"))+" "+Transform(Round(BD7->BD7_VLRGLO,2),PesqPict("BD7","BD7_VLRGLO"))+" "
			cStrBD7 += Iif(BD7->BD7_BLOPAG == "1",Transform(0,PesqPict("BD7","BD7_VLRPAG")),Transform(Round(BD7->BD7_VLRPAG,2),PesqPict("BD7","BD7_VLRPAG")))
					
			nTotBD7 += Iif(BD7->BD7_BLOPAG == "1",0,Round(BD7->BD7_VLRPAG,2))
			nTGlBD7 += Round(BD7->BD7_VLRGLO,2)

			If Li > nQtdLin
				Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			Endif		
				
			@ Li, 000 PSay PadL(cStrBD7,220)
			Li++
	
			BD7->(DbSkip())
			
		EndDo    
		
		If Li+3 > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif		
		
		@ Li,000 PSay PadL(replicate("-",40),220)
		@ Li+1,000 PSay PadL(("Total: "+Transform(nTGlBD7,"@E 999,999,999.9999")+" "+Transform(nTotBD7,"@E 999,999,999.9999")),220)
		@ Li+2,000 PSay PadL(replicate("-",40),220)                                                   
		@ Li+3,000 PSay ""
		
		Li+= 4
		
	Else       
	
		If Li+1 > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif		                              
	
		@ Li,  003 PSay Space(100)+cStrBD7
		@ Li+1,003 PSay ""
		Li+=2		
		
	EndIf	

EndIf

lPriGlo := .T.
If Len(aVetDet) > 0 .And. nMosGlo == 3

	If Li+1 > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif  
	@ Li,100 PSay "Cod / Descr. Glosa"
	@ Li+1,100 PSay Replicate("-",120)
	Li+=2
	
	For i:=1 to Len(aVetDet)
		If Li > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif		                              		
		
		//Separador para cada glosa...
		If lPriGlo	
			lPriGlo := .F.
		Else
			If aVetDet[i,4] == "1" .And. lPriGlo
				If Li+1 > nQtdLin
					Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				Endif		                          				    			
				@ Li,000 PSay ""
				@ Li+1,100 PSay Replicate('-',120)
				Li+=2
			Endif
		Endif
				
		@ Li,100 PSay AllTrim(aVetDet[i,1])+Space(3)+Substr(AllTrim(aVetDet[i,2]),1,60)+Space(1)+Substr(AllTrim(aVetDet[i,3]),1,57)
		Li++	
	Next
	
	@ Li,100 PSay Replicate("-",120)
	Li++

Endif

aVetGlo := {}
aVetDet := {}

(cArqTrab)->(DbSkip())

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Operadora บAutor ณPaulo Carnelossi  บ Data ณ 22/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime dados da Operadora a que se refere o relatorio      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_Operadora(cCodOpe)

BA0->(dbSetOrder(1))
If BA0->(MsSeek(xFilial("BA0")+cCodOpe))
	@ li, 000 PSay PadC(Alltrim(BA0->BA0_NOMINT),220)
	li++
	@ li, 000 PSay PadC(Alltrim(BA0->BA0_END)+" - CEP "+AllTrim(BA0->BA0_CEP)+" "+;
					AllTrim(BA0->BA0_CIDADE)+" ("+BA0->BA0_EST+")",220)
	li++
	@ li, 000 PSay Padc("C.G.C. "+Alltrim(Transform(BA0->BA0_CGC,PesqPict("BA0","BA0_CGC")))+ ;
	               If(BA0->(FieldPos("BA0_INCEST"))>0, "  Insc.Est.: "+BA0->BA0_INCEST,"");
	               , 220)
	li++
	li++
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Empresa   บAutor ณPaulo Carnelossi  บ Data ณ 22/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime dados da Empresa que se refere a qb do relatorio    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_Empresa(aQuebra, aBQuebra, nNivel, lForce)
Local cCompara            

DEFAULT lForce := .T.

cCompara := R019Quebra(aBQuebra, nNivel)

If aQuebra[nNivel] <> cCompara .OR. lForce
	If li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
	EndIf
	
	@ li, 005 PSay "Empresa: "+Eval(aBQuebra[nNivel])+" - "+;
					Posicione("BG9",1,xFilial("BG9")+cCompara,"BG9_DESCRI")
	li++
	li++
EndIf               

If ! lForce
	aQuebra[nNivel]  := cCompara
EndIf	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัอออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotEmp    บAutor ณPaulo Carnelossi บ Data ณ 22/01/04   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯอออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImprime total por empresa                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_TotEmp(aTotal, aQuebra, aBQuebra, nNivel, cTexto, lImpSubTot)
Local lQuebPag   := ! Eof() 

If lImpSubTot

    If Li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
	EndIf	

	cTexto += "("+Right(aQuebra[nNivel], Len(Eval(aBQuebra[nNivel])))+;
					" - "+Substr(Alltrim(Posicione("BG9",1,xFilial("BG9")+aQuebra[nNivel],"BG9_DESCRI")),1,20) + ")"
						
	Impr_SubTot(000,cTexto, .F., "-", .T., .T., aTotal[nNivel], lQuebPag, aTotal[nNivel+8],aTotal[nNivel+14],aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])

EndIf	

aTotal[nNivel-1]	+= aTotal[nNivel]
aTotal[nNivel+7]	+= aTotal[nNivel+8]
aTotal[nNivel+13]	+= aTotal[nNivel+14]
aTotal[nNivel+19]	+= aTotal[nNivel+20]
aTotal[nNivel+25]	+= aTotal[nNivel+26]
aTotal[nNivel+31]	+= aTotal[nNivel+32]

aTotal[nNivel]		:= 0 
aTotal[nNivel+8]	:= 0 
aTotal[nNivel+14]	:= 0
aTotal[nNivel+20]	:= 0
aTotal[nNivel+26]	:= 0
aTotal[nNivel+32]	:= 0



Return NIL	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_AnoMes    บAutor ณPaulo Carnelossi  บ Data ณ 06/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime Ano/Mes de Pagto a que se refere a qb do relatorio  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_AnoMes(aQuebra, aBQuebra, nNivel, lImpr, lCentr, lForce)

Static aMeses := {"Jan","Fev","Mar","Abr","Mai","Jun",;
					"Jul", "Ago", "Set", "Out", "Nov", "Dez"}
Local cString := ""					
Local cCompara, cAnoMesAux 

DEFAULT lForce := .T.


cCompara := R019Quebra(aBQuebra, nNivel)
cAnoMesAux := Eval(aBQuebra[nNivel])

If lImpr .And. (aQuebra[nNivel] <> cCompara .OR. lForce)

	If li > 48
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
		Impr_Empresa(aQuebra, aBQuebra, nNivel-1)
	EndIf

	If Val(Right(cAnoMesAux,2)) > 0 .And. Val(Right(cAnoMesAux,2)) <= 12
	    cString := "*** Mes --> " + aMeses[Val(Right(cAnoMesAux,2))]+"/"+Left(cAnoMesAux,4)+" ***"
	Else
	    cString := "*** Mes --> " + Right(cAnoMesAux,2)+"/"+Left(cAnoMesAux,4)+" ***"
	EndIf

	If lCentr
		@ li, 000 PSay PadC(cString, 220)
	Else
		@ li, 005 PSay cString
	EndIf
	Li++
	
EndIf

If ! lForce
	aQuebra[nNivel]  := cCompara
EndIf	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotAnoMesบAutor ณPaulo Carnelossi บ Data ณ  06/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออออออสออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime Total por Ano/Mes                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Impr_TotAnoMes(aTotal, aQuebra, aBQuebra, nNivel, cTexto, lImprSubTot)
Static aMeses := {"Jan","Fev","Mar","Abr","Mai","Jun",;
					"Jul", "Ago", "Set", "Out", "Nov", "Dez"}
Local cAnoMesAux := Right(aQuebra[nNivel], 6), cString
Local lImpr   := (cAnoDe+cAnoDe != cAnoAte+cMesAte)
Local lQuebPag   := lImpr .And. (R019Quebra(aBQuebra, nNivel-1)==aQuebra[nNivel-1])

If Val(Right(cAnoMesAux,2)) > 0 .And. Val(Right(cAnoMesAux,2)) <= 12
    cString := aMeses[Val(Right(cAnoMesAux,2))]+"/"+Left(cAnoMesAux,4)
Else
    cString := Right(cAnoMesAux,2)+"/"+Left(cAnoMesAux,4)
EndIf

If lImprSubTot
	cTexto += "("+cString+")"
	Impr_SubTot(015,cTexto, .F., "-", .T., .F., aTotal[nNivel], lQuebPag, aTotal[nNivel+8],aTotal[nNivel+14],aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])
EndIf

aTotal[nNivel-1]	+= aTotal[nNivel]
aTotal[nNivel+7]	+= aTotal[nNivel+8]
aTotal[nNivel+13]	+= aTotal[nNivel+14]
aTotal[nNivel+19]	+= aTotal[nNivel+20]
aTotal[nNivel+25]	+= aTotal[nNivel+26]
aTotal[nNivel+31]	+= aTotal[nNivel+32]

aTotal[nNivel]		:= 0 
aTotal[nNivel+8]	:= 0 
aTotal[nNivel+14]	:= 0
aTotal[nNivel+20]	:= 0
aTotal[nNivel+26]	:= 0
aTotal[nNivel+32]	:= 0


Return NIL	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Contrato  บAutor ณPaulo Carnelossi  บ Data ณ 22/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime dados do Contrato                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_Contrato(aQuebra, aBQuebra, nNivel, lForce)
Local cCompara 
Local lCentr := .F.
Local lImpr  := cAnoDe+cAnoDe != cAnoAte+cMesAte

DEFAULT lForce := .T.

cCompara := R019Quebra(aBQuebra, nNivel)

If aQuebra[nNivel] <> cCompara .OR. lForce
  	If li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
		Impr_Empresa(aQuebra, aBQuebra, nNivel-2)
		Impr_AnoMes(aQuebra, aBQuebra, nNivel-1, lImpr, lCentr, .F.)
	EndIf
	
//	@ li, 005 PSay "Contrato: "+Eval(aBQuebra[nNivel]) + iif(BT5->(FieldPos("BT5_YDESC")) > 0," - " + Posicione("BT5",1,xFilial("BT5")+PLSINTPAD()+Eval(aBQuebra[nNivel-2])+Eval(aBQuebra[nNivel]),"BT5_YDESC"),"")                             
//	li++
	
EndIf               

If ! lForce
	aQuebra[nNivel]  := cCompara
EndIf	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotContrato บAutor ณPaulo Carnelossi บ Data ณ 22/01/04 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออสออออออฯอออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDesc.     ณImprime total por Contrato                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_TotContrato(aTotal, aQuebra, aBQuebra, nNivel, cTexto, lImpSubTot)
Local lQuebPag   := ! Eof() .And. (R019Quebra(aBQuebra, nNivel-1)==aQuebra[nNivel-1])

If lImpSubTot

    If Li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
	EndIf	
	cTexto += "("+Right(aQuebra[nNivel], Len(Eval(aBQuebra[nNivel])))+")"
	Impr_SubTot(000,cTexto, .F., "-", .T., .F., aTotal[nNivel], lQuebPag , aTotal[nNivel+8],aTotal[nNivel+14],aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])
EndIf	

aTotal[nNivel-1]	+= aTotal[nNivel]
aTotal[nNivel+7]	+= aTotal[nNivel+8]
aTotal[nNivel+13]	+= aTotal[nNivel+14]
aTotal[nNivel+19]	+= aTotal[nNivel+20]
aTotal[nNivel+25]	+= aTotal[nNivel+26]
aTotal[nNivel+31]	+= aTotal[nNivel+32]

aTotal[nNivel]		:= 0 
aTotal[nNivel+8]	:= 0 
aTotal[nNivel+14]	:= 0
aTotal[nNivel+20]	:= 0
aTotal[nNivel+26]	:= 0
aTotal[nNivel+32]	:= 0

Return NIL	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออหอออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_SubContr    บAutor ณPaulo Carnelossi บData ณ 22/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออสออออออฯอออออออออออออออออสอออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime dados do Sub-Contrato                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_SubContr(aQuebra, aBQuebra, nNivel, lForce)
Local cCompara 
Local lCentr := .F.
Local lImpr  := cAnoDe+cAnoDe != cAnoAte+cMesAte
Local cStrSub := ""

DEFAULT lForce := .T.

cCompara := R019Quebra(aBQuebra, nNivel)

If aQuebra[nNivel] <> cCompara .OR. lForce
	If li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Impr_Empresa(aQuebra, aBQuebra, nNivel-3)
		Impr_AnoMes(aQuebra, aBQuebra, nNivel-2, lImpr, lCentr)
		Impr_Contrato(aQuebra, aBQuebra, nNivel-1)
  	EndIf

	If nTipPes <> 1 .And. nConGrC = 1
		If BQC->(FieldPos("BQC_DESCRI")) > 0
			If BQC->(MsSeek(xFilial("BQC")+PLSINTPAD()+Eval(aBQuebra[nNivel-3])+Eval(aBQuebra[nNivel-1])+Eval(aBQuebra[nNivel])))
				cStrSub := " - "+BQC->BQC_DESCRI+" - Grupo de Cobranca: "+BQC->BQC_GRPCOB
			Endif
		Endif
	Endif
	
	@ li, 005 PSay "Sub-Contrato: "+Eval(aBQuebra[nNivel])  
	@ li, 005 PSay "Sub-Contrato: "+Eval(aBQuebra[nNivel]) + cStrSub
	
	li++
	li++
	
EndIf               

If ! lForce
	aQuebra[nNivel]  := cCompara
EndIf	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotSubContr บAutor ณPaulo Carnelossi บ Data ณ 22/01/04 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออสออออออฯอออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDesc.     ณImprime total por Contrato                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_TotSubContr(aTotal, aQuebra, aBQuebra, nNivel, cTexto, lImpSubTot)
Local lQuebPag   := (R019Quebra(aBQuebra, nNivel-1)==aQuebra[nNivel-1])

If lImpSubTot
    If Li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
	EndIf	
	cTexto += "("+Right(aQuebra[nNivel], Len(Eval(aBQuebra[nNivel])))+")"
	Impr_SubTot(000,cTexto, .F., "-", .T., .F., aTotal[nNivel], lQuebPag, aTotal[nNivel+8],aTotal[nNivel+14],aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])
EndIf	

aTotal[nNivel-1]	+= aTotal[nNivel]
aTotal[nNivel+7]	+= aTotal[nNivel+8]
aTotal[nNivel+13]	+= aTotal[nNivel+14]
aTotal[nNivel+19]	+= aTotal[nNivel+20]
aTotal[nNivel+25]	+= aTotal[nNivel+26]
aTotal[nNivel+31]	+= aTotal[nNivel+32]

aTotal[nNivel]		:= 0 
aTotal[nNivel+8]	:= 0 
aTotal[nNivel+14]	:= 0
aTotal[nNivel+20]	:= 0
aTotal[nNivel+26]	:= 0
aTotal[nNivel+32]	:= 0

Return NIL	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Titular   บAutor ณPaulo Carnelossi  บ Data ณ 23/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณImprime dados do Titular  que se refere a qb do relatorio   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	Impr_Titular(aQuebra, aBQuebra, nNivel, lForce, cArqTrab)
Local cAlias  := Alias()
Local lCentr  := .F.
Local lImpr   := cAnoDe+cAnoDe != cAnoAte+cMesAte
Local cCompara 
Local cCodUsr
Local cMatAtu := ""
Local cMatAnt := ""        

If nImpNom == 1
	cCodUsr := cOpeUsr + (cArqTrab)->(BD6_CODEMP) + (cArqTrab)->(BD6_MATRIC)
Else
	cCodUsr := cOpeUsr + (cArqTrab)->(BD6_CODEMP) + (cArqTrab)->(BD6_MATRIC) + (cArqTrab)->(BD6_TIPREG)
Endif

DEFAULT lForce := .T.

cCompara := R019Quebra(aBQuebra, nNivel)

dbSelectArea("BA1")
dbSetOrder(2)

If MsSeek(xFilial("BA1")+cCodUsr)
	If aQuebra[nNivel] <> cCompara .OR. lForce
		If li > 45
			cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			//Impr_Operadora(cOpeUsr)
			Impr_Empresa(aQuebra, aBQuebra, nNivel-4)
			Impr_AnoMes(aQuebra, aBQuebra, nNivel-3, lImpr, lCentr, .F.)
			Impr_Contrato(aQuebra, aBQuebra, nNivel-2)
			Impr_SubContr(aQuebra, aBQuebra, nNivel-1)
		EndIf 
		
		cMatAtu := BA1->(cOpeUsr+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"."+BA1_DIGITO)
		cMatAnt := Iif(! Empty(BA1->BA1_MATANT),Substr(BA1->BA1_MATANT,1,14), Substr(BA1->BA1_MATUSB,1,14))


		If nTipMat = 1
			@ li, 000 PSay cMatAtu+" "+Substr(BA1->BA1_NOMUSR,1,25)+" Matricula Antiga: "+cMatAnt+Iif(nTipPes = 1 .And. nConGrC = 1," - "+(cArqTrab)->(BA3_GRPCOB),"")
		Else
			@ li, 000 PSay cMatAnt+" "+Substr(BA1->BA1_NOMUSR,1,25)+" Matricula Atual.: "+cMatAtu+Iif(nTipPes = 1 .And. nConGrC = 1," - "+(cArqTrab)->(BA3_GRPCOB),"")
		Endif		               		
		li++
	EndIf
Else
	If li > 45 .OR. lForce
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Impr_Empresa(aQuebra, aBQuebra, nNivel-4)
		Impr_AnoMes(aQuebra, aBQuebra, nNivel-3, lImpr, lCentr, .F.)
		Impr_Contrato(aQuebra, aBQuebra, nNivel-2)
		Impr_SubContr(aQuebra, aBQuebra, nNivel-1)
	EndIf
	    
	@ li, 010 PSay Transform(Left(cCompara,8)+Right(cCompara,6),"@R 9999.9999.999999") + "*** NAO ENCONTRADO CADASTRO ***"
	li++
EndIf

If ! lForce
	aQuebra[nNivel]  := cCompara
EndIf
	
dbSelectArea(cAlias)

Return                                                                 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotTitular  บAutor ณPaulo Carnelossi บ Data ณ 22/01/04 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออสออออออฯอออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDesc.     ณImprime total por Familia (matricula/titular)               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_TotTitular(aTotal, aQuebra, aBQuebra, nNivel, cTexto, lImpSubTot)

If lImpSubTot

    If Li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf	
	cTexto += "("+Right(aQuebra[nNivel], Len(Eval(aBQuebra[nNivel])))+")"
	Impr_SubTot(000,cTexto, .F., "-", .T., .T., aTotal[nNivel], .F. , aTotal[nNivel+8],aTotal[nNivel+14],aTotal[nNivel+20],aTotal[nNivel+26],aTotal[nNivel+32])
EndIf	

aTotal[nNivel-1]	+= aTotal[nNivel]
aTotal[nNivel+7]	+= aTotal[nNivel+8]
aTotal[nNivel+13]	+= aTotal[nNivel+14]
aTotal[nNivel+19]	+= aTotal[nNivel+20]
aTotal[nNivel+25]	+= aTotal[nNivel+26]
aTotal[nNivel+31]	+= aTotal[nNivel+32]

aTotal[nNivel]		:= 0 
aTotal[nNivel+8]	:= 0 
aTotal[nNivel+14]	:= 0
aTotal[nNivel+20]	:= 0
aTotal[nNivel+26]	:= 0
aTotal[nNivel+32]	:= 0


Return NIL	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัอออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_TotGer    บAutor ณPaulo Carnelossi บ Data ณ 22/01/04   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯอออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImprime total geral por operadora                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_TotGer(cArqTrab, nTotGer, cTexto, lImpSubTot, nTotGer2, nTotGui, nTotPro, nTotGlo, nTotApr)

If lImpSubTot
    If Li > 55
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		//Impr_Operadora(cOpeUsr)
	EndIf	

	@ li, 000 PSay "*** TOTAL GERAL ***"
    li++
	
	Impr_SubTot(000,cTexto, .F., "-", .T., .T., nTotGer, .F. ,nTotGer2, nTotGui, nTotPro, nTotGlo, nTotApr)

	Impr_Legenda(aVetLeg)

EndIf	

Return NIL	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณR019Quebra     บAutor ณPaulo Carnelossi  บ Data ณ 22/01/04  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณRetorna string com dados do aBQuebra ate o nivel informado  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R019Quebra(aBQuebra, nNivel)
Local cRetorno := ""

AEVAL(aBQuebra, { |cX,nX| cRetorno += Eval(aBQuebra[nX]) } ,  1,  nNivel) 

Return(cRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDetalheRel บAutor ณPaulo Carnelossi    บ Data ณ  23/09/03   บฑฑ
ฑฑฬออออออออออุอออออออออออสออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime detalhe do relatorio quando existir agrupamentos    บฑฑ
ฑฑบ          ณde acordo com aCondicao (array contendo blocos de codigos)  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DetalheRel(aCondicao, nNivel, cArqTrab)
Local lImprime := .T.

AEVAL(aCondicao,;
				{|cX, nX| (cArqTrab)->(Eval(aCondicao[nX][ANTES_LACO],nX)) } ,  1,  nNivel)

//zerar contador
aCondicao[nNivel][6] := 0

While (cArqTrab)->( ! Eof() .And. AvaliaCondicao(aCondicao, nNivel, cArqTrab) )

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Deve imprimir somente as que o usuario importou, caso parametrizado.  ณ  
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
	If (cArqTrab)->(BD6_ORIMOV) == "1"
		If BD5->(MsSeek(xFilial("BD5")+cOpeUsr+(cArqTrab)->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
//			cUsrImp := BD5->BD5_YUSIMP
			cUsrImp := ""
		Endif
	Else
		If BE4->(MsSeek(xFilial("BE4")+cOpeUsr+(cArqTrab)->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
//			cUsrImp := BE4->BE4_YUSIMP
			cUsrImp := ""
		Endif
	Endif

/*	
	If (Alltrim(cUsrImp) <> Alltrim(cUserName)) .And. (nImpUsr = 1)
		lImprime := .F.		
	Endif
*/	
	

	If lImprime
		If lInterca
			cabec1:= "Codigo do Usuario     Nome do Titular da Familia"+space(78)+DadosPTU((cArqTrab)->BD6_SEQIMP)
		Endif
	
		(cArqTrab)->(Eval(aCondicao[nNivel][PROC_LACO], nNivel))
		
		If nNivel < Len(aCondicao)  // avanca para proximo nivel
			DetalheRel(aCondicao, nNivel+1, cArqTrab)
		EndIf	
	Else
		(cArqTrab)->(dbSkip())
		Loop
	Endif
	   
End

(cArqTrab)->(Eval(aCondicao[nNivel][DEPOIS_LACO],nNivel))

If nNivel > 1
	aCondicao[nNivel-1][6] += aCondicao[nNivel][6]
EndIf			

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหออออออัออออออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณAvaliaCondicaoบAutor ณPaulo Carnelossi    บ Data ณ 23/09/03 บฑฑ
ฑฑฬออออออออออุออออออออออออออสออออออฯออออออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDesc.     ณavalia condicao while (auxiliar a funcao DetalheRel()       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AvaliaCondicao(aCondicao, nNivel, cArqTrab)
Local aAux := {}, lCond := .T., lRet := .T., nY
AEVAL(aCondicao,;
				{|cX, nX| aAdd(aAux,lCond:=(cArqTrab)->(Eval(aCondicao[nX][COND_LACO], nX))) } ,  1,  nNivel) 

For nY := 1 TO Len(aAux)
    If ! aAux[nY]
    	 lRet := .F.
    	 Exit
    EndIf
Next    

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_SubTot บAutor ณPaulo Carnelossi   บ Data ณ  23/09/03   บฑฑ
ฑฑฬออออออออออุออออออออออออสออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime linha de sub-total/total geral                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_SubTot(nCol,cTexto,lAlinDir, cSinal, lImprTot, lImprLinSep, nQuant, lQuebra, nQuant2,nTotGui, nTotPro, nTotGlo, nTotApr)

nCol := If(nCol == NIL, 000, nCol)
lAlinDir := If(lAlinDir == NIL, .T., lAlinDir)
cTexto := If(cTexto == NIL, "Total", cTexto)
cSinal := If(cSinal == NIL, "-", cSinal)
lImprTot := If(lImprTot == NIL, .T., lImprTot)


If lImprTot
	If lAlinDir
		@ li, nCol Psay PadR(AllTrim(cTexto)+": Guias: "+Transform(nTotGui,"@E 999,999.99")+" Procs: "+Transform(nTotPro,PesqPict("BD6","BD6_QTDPRO"))+Iif(lInterca,space(50)+Transform(nTotGlo,"@E 99,999.99")+space(1)+Transform(nTotApr,"@E 999999.99")+space(14),space(60))+Transform(nQuant,"@E 999,999,999.99")+Iif(lInterca,space(15),space(23))+Transform(nQuant2,"@E 999,999,999.99"),220)
	Else
		@ li, nCol Psay PadL(AllTrim(cTexto)+": Guias: "+Transform(nTotGui,"@E 999,999.99")+" Procs: "+Transform(nTotPro,PesqPict("BD6","BD6_QTDPRO"))+Iif(lInterca,space(50)+Transform(nTotGlo,"@E 99,999.99")+space(1)+Transform(nTotApr,"@E 999999.99")+space(14),space(60))+Transform(nQuant,"@E 999,999,999.99")+Iif(lInterca,space(15),space(23))+Transform(nQuant2,"@E 999,999,999.99"),220)
	EndIf
	li++
EndIf	

If lImprLinSep
	@ li, nCol Psay Repl(cSinal,220-nCol)
	li++
EndIf	

If lQuebra
	Li := 80
EndIf
	
Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualizay_VarบAutor  ณJean Schulz      บ Data ณ  14/10/05   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza variaveis de configuracao do relatorio.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Atualizay_Var()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seta variaveis do relatorio                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cOpeUsr := mv_par01
cEmpDe  := mv_par02
cEmpAte := mv_par03
cConVeI := mv_par04
cConVeF := mv_par05
cSubVeI := mv_par06
cSubVeF := mv_par07
cAnoDe  := Substr(mv_par08,1,4)
cMesDe  := Substr(mv_par08,5,2)
cAnoAte := Substr(mv_par09,1,4)
cMesAte := Substr(mv_par09,5,2)
nLDPDe  := mv_par10
nLDPAte := mv_par11
cPegDe  := mv_par12
cPegAte := mv_par13
cRdaDe  := mv_par14
cRdaAte := mv_par15
nConGrC := mv_par16
nTipPes := mv_par17
cGCobDe := mv_par18
cGCobAte:= mv_par19
cDMovDe := mv_par20
cDMovAte:= mv_par21
cTpProDe:= mv_par22
cProcDe := mv_par23
cTpProAt:= mv_par24
cProcAt := mv_par25
cPtuDe  := mv_par26
cPtuAte := mv_par27
nValDe  := mv_par28
nValAte := mv_par29
nConVal := mv_par30

nImpSFam:= mv_par31
nImpSSub:= mv_par32
nImpSCon:= mv_par33
nImpSEmp:= mv_par34
nTipMat := mv_par35
nImpUsr := mv_par36
nFase   := mv_par37

nNumDoc := mv_par38
nComPag := mv_par39
nMosGlo := mv_par40



//Parametros configurados para valor fixo...
nImpSGer:= 1
nImpSMes:= 2 // Imprime Subt. Mes = NAO
nImpNom := 2

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualizaw_VarบAutor  ณJean Schulz      บ Data ณ  14/10/05   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza variaveis de configuracao do relatorio.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Atualizaw_Var()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seta variaveis do relatorio                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cTpgIn := mv_par01
cTpgFn := mv_par02

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpr_Legenda บAutor  ณJean Schulz      บ Data ณ  14/10/05   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime matriz de legenda das Glosas.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Impr_Legenda(aVetor)
Local nCont 

If Len(aVetor) > 0
	Cabec(cTitulo,"Legenda / Motivos de Glosa Apresentados no Relat๓rio","",nomeprog,tamanho,nTipo)	
	Asort( aVetor,,, { |x,y| x[1] < y[1] } )
	For nCont := 1 to Len(aVetor)
		@ Li,000 PSay aVetor[nCont,1]+" - "+aVetor[nCont,2]
		Li++
	Next
Endif 
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVlrAprBD7     บAutor  ณJean Schulz     บ Data ณ  20/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Calcula o valor apresentado pelo arq PTU (NAO EXISTE VLR   บฑฑ
ฑฑบ          ณ APRESENTADO EM BD6010 - PTU).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VlrAprBD7(cChaveBD7,nQtdPro)
Local nValApr := 0

BD7->(MsSeek(xFilial("BD7")+cChaveBD7))
While ! BD7->(Eof()) .And. (cChaveBD7 == BD7->(BD7_OPEUSR+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN))
	nValApr += BD7->BD7_VLRAPR
	BD7->(dbSkip())          
EndDo                                      

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Multiplicar pela quantidade, a fim de manter a proporcionalidade do sistema ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nValApr := (nValApr*nQtdPro)

Return nValApr

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDadosPTU      บAutor  ณJean Schulz     บ Data ณ  20/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Busca e mostra os dados do lote de intercambio selecionado.บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DadosPTU(cSeqImp)         

Local cString := "Seq. PTU nao encontrado!"

BRJ->(dbSetOrder(1))
If BRJ->(MsSeek(xFilial("BRJ")+cSeqImp))
	cString := "LDP: "+BRJ->BRJ_CODLDP+" PEG: "+BRJ->BRJ_CODPEG+" FATURA: "+BRJ->BRJ_NUMFAT+" Origem: "+BRJ->BRJ_OPEORI+" "+Substr(BRJ->BRJ_NOMORI,1,35)
Endif

Return cString

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaNovoParSX1บAutor  ณJean Schulz     บ Data ณ  10/14/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros do relatorio.                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CriaNovoParSX1()

PutSx1(cPerg,"01",OemToAnsi("Operadora")			  ,"","","mv_ch1","C",04,0,0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa De")   		  ,"","","mv_ch2","C",04,0,0,"G","","BG9","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Empresa Ate")   		  ,"","","mv_ch3","C",04,0,0,"G","","BG9","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Contrat / Versao De")   ,"","","mv_ch4","C",15,0,0,"G","","BE3","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Contrato/Versao Ate")   ,"","","mv_ch5","C",15,0,0,"G","","BE3","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Sub-Contr/Versao De")   ,"","","mv_ch6","C",12,0,0,"G","","BE5","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Sub-Contr/Versao Ate")  ,"","","mv_ch7","C",12,0,0,"G","","BE5","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Ano/Mes De")  			 ,"","","mv_ch8","C",06,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Ano/Mes Ate") 			 ,"","","mv_ch9","C",06,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Local Digitacao De?")   ,"","","mv_chz","C",04,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Local Digitacao Ate?")  ,"","","mv_c01","C",04,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("PEG De?")   			  ,"","","mv_c02","C",08,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("PEG Ate?")               ,"","","mv_c03","C",08,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"14",OemToAnsi("RDA De?")                ,"","","mv_c04","C",06,0,0,"G","","BA0","","","mv_par14","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"15",OemToAnsi("RDA Ate?")               ,"","","mv_c05","C",06,0,0,"G","","BA0","","","mv_par15","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"16",OemToAnsi("Cons. Prox. 3 Param?"),"","","mv_cht","C",01,0,0,"C","","","","","mv_par16","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"17",OemToAnsi("Tipo de Pessoa?")        ,"","","mv_chr","C",01,0,0,"C","","","","","mv_par17","Fisica","","","","Juridica","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"18",OemToAnsi("Grupo Cobranca De?")     ,"","","mv_c06","C",04,0,0,"G","","BR0","","","mv_par16","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"19",OemToAnsi("Grupo Cobranca Ate?")    ,"","","mv_c07","C",04,0,0,"G","","BR0","","","mv_par17","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"20",OemToAnsi("Data Movto De")   		 ,"","","mv_chc","D",08,0,0,"G","","","","","mv_par18","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"21",OemToAnsi("Data Movto Ate")  		 ,"","","mv_chd","D",08,0,0,"G","","","","","mv_par19","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"22",OemToAnsi("Cod Tp Proc De")   	 ,"","","mv_che","C",02,0,0,"G","","B41","","","mv_par22","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"23",OemToAnsi("Cod Proced De")   	     ,"","","mv_chf","C",16,0,0,"G","","YBR","","","mv_par23","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"24",OemToAnsi("Cod Tp Proc Ate")  	 ,"","","mv_chg","C",02,0,0,"G","","B41","","","mv_par24","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"25",OemToAnsi("Cod Proced Ate")   	 ,"","","mv_chh","C",16,0,0,"G","","YBR","","","mv_par25","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"26",OemToAnsi("Imp. PTU De?")     	   ,"","","mv_c08","C",08,0,0,"G","","BRJ","","","mv_par26","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"27",OemToAnsi("Imp. PTU Ate?")    	   ,"","","mv_c09","C",08,0,0,"G","","BRJ","","","mv_par27","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"28",OemToAnsi("Valor De")   			 ,"","","mv_chi","N",17,2,0,"G","","","","","mv_par28","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"29",OemToAnsi("Valor Ate")   			 ,"","","mv_chj","N",17,2,0,"G","","","","","mv_par29","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"30",OemToAnsi("Considerar Valores a")   ,"","","mv_chq","C",01,0,0,"C","","","","","mv_par30","Cobrar","","","","Pagar","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"31",OemToAnsi("Impr.SubTot.Familia")    ,"","","mv_cha","N",01,0,0,"C","","","","","mv_par31","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"32",OemToAnsi("Impr.SubTot.Subcontr")   ,"","","mv_chb","N",01,0,0,"C","","","","","mv_par32","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"33",OemToAnsi("Impr.SubTot.Contrato")   ,"","","mv_chn","N",01,0,0,"C","","","","","mv_par33","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"34",OemToAnsi("Impr.SubTot.Empresa")    ,"","","mv_cho","N",01,0,0,"C","","","","","mv_par34","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"35",OemToAnsi("Tipo Matricula")  	      ,"","","mv_chv","C",01,0,0,"C","","","","","mv_par35","Matricula Atual","","","","Mat. Anterior","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"36",OemToAnsi("Emite Rel. por Usuario?"),"","","mv_chp","N",01,0,0,"C","","","","","mv_par36","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"37",OemToAnsi("Fase")  				  ,"","","mv_chs","C",01,0,1,"C","","","","","mv_par37","Conf./Pronta","","","","Em Conferencia","","","Pronta","","","prontas/pagas/conf","","","Pronta/Paga","","",{},{},{})
PutSx1(cPerg,"38",OemToAnsi("Nro do Docto")  	      ,"","","mv_chx","C",01,0,0,"C","","","","","mv_par38","Guia","","","","Impresso","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"39",OemToAnsi("Exibe Compos. Pagto?") ,"","","mv_chy","C",01,0,0,"C","","","","","mv_par39","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"40",OemToAnsi("Exibe Mot. de Glosas?") ,"","","mv_chz","C",01,0,0,"C","","","","","mv_par40","Nao","","","","Resumido","","","Detalhado","","","","","","","","",{},{},{})    

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaNovoParWSX1บAutor  ณJean Schulz     บ Data ณ  10/14/05   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros do relatorio.                                บฑฑ
ฑฑบ          ณ                                                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                          บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
Static Function CriaNovoParWSX1()
PutSx1(cPerg,"01",OemToAnsi("Tipo de Guia Inicial")			  ,"","","mv_ch1","C",02,0,0,"C","","_U01","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Tipo de Guia Final")   		  ,"","","mv_ch2","C",02,0,0,"C","","_U01","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
Return
*/
