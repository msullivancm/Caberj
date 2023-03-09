#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#include "PROTHEUS.CH"
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё CABR013 Ё Autor Ё Luzio Tavares          Ё Data Ё 02.10.08 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Usuarios participantes do projeto AED/AAG que tiveram      Ё╠╠╠
╠╠Ё          Ё cobranca de co-participacao ou Solicitantes que pertecem aoЁ╠╠╠
╠╠Ё          Ё projeto AED/AAG e/ou Numero de Impresso dos nucleos.       Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё CABR013()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё CABERJ                                                     Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function CABR013()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis padroes para todos os relatorios...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local lCentury      := __setcentury()
PRIVATE cRelDir     := GetMv("MV_RELT")
PRIVATE nQtdLin
PRIVATE cNomeProg   := "CABR013"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220   //132   //220
PRIVATE cTamanho    := "G"   //"G"
PRIVATE cTitulo     := "Co-participacao para atendimento AED e Nucleos "
PRIVATE cTitDem     := "DEMONSTRATIVO DE COBRANCA DE CO-PARTICIPACAO - Mes de : "
PRIVATE cDesc1      := "Lista as guias que possuem co-participacao calculada"
PRIVATE cDesc2      := "para usuarios que participam do projeto AED ou os "
PRIVATE cDesc3      := "atendimentos do nucleo de atendimento."
PRIVATE cAlias      := "BD7"
PRIVATE cPerg       := "CABR13"
PRIVATE nRel        := "CABR013"
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE cCabec1     := "Matricula         Usuario                                     Local PEG      Dt.Mov.    Mes/Ano Num. Impresso           Solcitante                                         Lote Pagto.   Fatura Cob."
//Impresso               Matricula              Usuario                                    " + IIf(lImpLocRq, "Local Requisicao  ","") + IIf(lImpCoPar,"Co-Particip","")
PRIVATE cCabec2     := "          Procedimento     Descricao                                             Numero   Seq    Co-Particip %Co-Part.  Executante "
//Procedimento          Descricao                                       Movimento       Qtd TP   Qt Ref Un   Dt.Mov. INS    Valor"+Iif(cTamanho == "G","Desc.Loc.Atend.","")

PRIVATE nColuna     := 00
PRIVATE nLi         := 100
PRIVATE nLinPag     := 68
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Parametros do relatorio (SX1)...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCodOpe
PRIVATE cRdaDe
PRIVATE cRdaAte
PRIVATE cAnoDe
PRIVATE cMesDe
PRIVATE cAnoAte
PRIVATE cMesAte
PRIVATE cLdpDe
PRIVATE cLdpAte
PRIVATE cPegDe
PRIVATE cPegAte
PRIVATE cEmpDe
PRIVATE cEmpAte
PRIVATE nFase
PRIVATE cGrpPagDe
PRIVATE cGrpPagAte
PRIVATE cTipAna

PRIVATE aRet := {.T.,""}

If BD6->(FieldPos("BD6_PAGRDA")) == 0
	MsgStop("SIGAPLS - Campo BD6_PAGRDA nao criado, por favor entrar em contato com o Suporte.")
	Return
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ajusta perguntas                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
CriaSX1() //nova pergunta...
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Acessa parametros do relatorio...                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nRel := SetPrint(cAlias,nRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  nLastKey  == 27
	If  lCentury
		set century on
	Endif
	Return
Endif

cCodOpe   := mv_par01
cRdaDe    := mv_par02
cRdaAte   := mv_par03
cAnoDe    := mv_par04
cMesDe    := mv_par05
cAnoAte   := mv_par06
cMesAte   := mv_par07
cLdpDe    := mv_par08
cLdpAte   := mv_par09
cPegDe    := mv_par10
cPegAte   := mv_par11
cEmpDe    := mv_par12
cEmpAte   := mv_par13
nFase     := mv_par14
cGrpPagDe  := mv_par15
cGrpPagAte := mv_par16
//cGuiDe    := mv_par15
//cGuiAte   := mv_par16
cTipAna := mv_par17

cTitDem += RetMesAno(cAnoDe+cMesDe)
//cTitDem += " a "
//cTitDem += RetMesAno(cAnoAte+cMesAte)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//MsAguarde({|| CABR013Imp() }, cTitulo, "", .T.)
Processa({|| CABR013IMP() }, "Processando...", "", .T.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera filtro do BD7                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ms_flush()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da rotina                                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Return(aRet)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   ЁCABR013ImpЁ Autor Ё Luzio Tavares         Ё Data Ё 02.10.08 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Imprime o extrato mensal dos servicos prestados            Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function CABR013Imp()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa variaveis                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local nInd,nFor
LOCAL cSQL
LOCAL nVlrItem    := 0
LOCAL nVlrGloIt   := 0
LOCAL nVlrTotGui  := 0
LOCAL nVlrTotNot  := 0
LOCAL nITens      := 0
Local nVlrRef     := 0
Local nVlrGRef    := 0
Local nVlrPRef    := 0
Local nVlrTotPro  := 0
Local aProcImp    := {}
Local lListaCab   := .F.
Local lTemMov
Local lTem
LOCAL nPosLot
LOCAL nTotVlr
LOCAL nTotIrf
LOCAL nTotIns
Local nTotAcr
Local nTotDec
LOCAL nLiq
LOCAL nPos
LOCAL cImpAnt
LOCAL cGuiAnt
Local i
LOCAL nI
Local nOutImp		:= 	0
Local nTotOutImp  :=	0

Local lSolAED	:= .F.
Local lGuiVERDE := .F.
Local lTemCoPF := .T.
Local lTemAED := .F.
Local nProc  := 1    // incrementado por unidade de registro
Local nTvlPF := 0
Local lProcTemPF := .T.
Local aQtd := {}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Matriz Principal														 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE aTrbBD6 := {}
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Controle de Glosas...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE aGlosas     := {}
PRIVATE lGlosou     := .F.
PRIVATE cIni 		:= ""
PRIVATE cLinha 		:= ""
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores...                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
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
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё variaveis de trabalho...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cNomCre     //Nome do Credenciado completo...
PRIVATE cMovime     //Codigo do movimento
PRIVATE cEspecia
PRIVATE cOpeLot
PRIVATE cNumLot
PRIVATE cDesLot
PRIVATE aLotes
PRIVATE cLotes  := ""
PRIVATE dDatPro := Ctod("  /  /    ")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Mensagem                                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//MsProcTxt("Processando Dados...")
//ProcessMessages()

If cTipAna = 1
	//	cSql := "SELECT DECODE(E1_FORMREC,'01','RIOPREVI','08','RIOPREVI','04','112','06','SISDEB '|| SUBSTR(E1_VENCTO,7,2),'05','175',E1_FORMREC) FORMREC, "
	//	cSql += "       BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG MATRIC,BD6_CODLDP LOCALD,BD6_CODPEG PEG,BD6_NUMERO NUMERO,BD6_SEQUEN SEQUEN, "
	//	cSql += "       BD6_NUMIMP IMPRESSO,BD6_CDPFSO SOLICITANTE,BD6_CODPRO CODIGO,BD6_DESPRO PROCEDIMENTO,BD6_VLRPAG VALOR,BD6_VLRTPF VALOR_COPART, "
	//	cSql += "       BD6_NUMSE1 TITULO,E1_SALDO VALOR_TIT,BD6_NOMUSR NOME,TRIM(BA1_DDD) || ' ' ||TRIM(BA1_TELEFO) FONE, "
	//	cSql += "       (CASE WHEN BA1_YTEL2 <> ' ' THEN TRIM(BA1_DDD) || ' ' ||TRIM(BA1_YTEL2) ELSE ' ' END) FONE2, "
	//	cSql += "      (CASE WHEN BA1_YCEL <> ' ' THEN TRIM(BA1_DDD) || ' ' ||TRIM(BA1_YCEL) ELSE ' ' END) CEL, "
	//	cSql += "      '___________________________________' OBSERVACAO "
	//	cSql += "FROM " + RetSQLName("BF4") + " BF4, "+RetSQLName("BD6") + " BD6, "+RetSQLName("SE1") + " SE1, "+RetSQLName("BA1") + " BA1, "
	
	cSql := " SELECT BD6_FILIAL, BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,BD6_SEQUEN,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG, "
	cSql += " BD6_CODPRO, BD6_DESPRO, BD6_VLRPAG, BD6_VLRTPF, BD6_NOMUSR, BD6_PERCOP, "
	cSql += " DECODE(TRIM(BD6_CODPLA),NULL,BA3_CODPLA,BD6_CODPLA) AS BD6_CODPLA, "
	cSql += " BD6_ANOPAG, BD6_MESPAG, BD6_DIGITO, BD6_CODRDA, BD6_NOMRDA, BD6_CDPFSO, BD6_DATPRO, BD6_NOMSOL, BD6_CDPFSO, BD6_SEQPF, "
	cSql += " BD6_BLOCPA, BD6_BLOPAG, BD6_NUMFAT, BD6_NUMSE1, BD6_NUMLOT, BD6_NUMIMP, bd6.r_e_c_n_o_ RECNO, BD6_CODPAD, BD6_OPERDA "
	
	cSql += "FROM " + RetSQLName("BF4") + " BF4, "+RetSQLName("BD6") + " BD6, "+RetSQLName("BA1") + " BA1, "
	cSql += RetSQLName("BA3") + " BA3, "+RetSQLName("BAU") + " BAU "
	cSql += "WHERE  BF4_FILIAL = '  ' "
	cSql += "AND    BF4_CODINT = '0001' "
	cSql += "AND    BF4_CODPRO IN ('0024','0038','0041') "
	cSql += "AND    BF4_DATBLO = '      ' "
	cSql += "AND    BD6_FILIAL = BF4_FILIAL "
	cSql += "AND    BD6_OPEUSR = BF4_CODINT "
	cSql += "AND    BD6_CODEMP = BF4_CODEMP "
	cSql += "AND    BD6_MATRIC = BF4_MATRIC "
	cSql += "AND    BD6_TIPREG = BF4_TIPREG "
	cSql += "AND    BA1_FILIAL = BD6_FILIAL "
	cSql += "AND    BA1_CODINT = BD6_OPEUSR "
	cSql += "AND    BA1_CODEMP = BD6_CODEMP "
	cSql += "AND    BA1_MATRIC = BD6_MATRIC "
	cSql += "AND    BA1_TIPREG = BD6_TIPREG "
	cSql += "AND BD6_ANOPAG||BD6_MESPAG BETWEEN '" + cAnoDe+cMesDe + "' AND '" + cAnoAte+cMesAte + "' "
	cSql += "AND BA3_CODINT = BD6_OPEUSR "
	cSql += "AND BA3_CODEMP = BD6_CODEMP "
	cSql += "AND BA3_MATRIC = BD6_MATRIC "
	
	If nFase == 1 // Pronta
		cSql += " AND BD6_FASE = '3' "
	ElseIf nFase == 2 // faturada
		cSql += "AND BD6_FASE = '4' "
		cSql += "AND BD6_NUMLOT <> '  ' "
	ElseIf nFase == 3 // Ambas
		cSql += "AND BD6_FASE IN ('3','4') "
	EndIf
	cSql += " AND BD6_SITUAC = '1' "
	cSql += " AND BD6_BLOCPA <> '1' "
	cSql += " AND BD6_BLOPAG <> '1' "
	
	cSql += "AND    BD6_VLRTPF > 0 "
	cSql += "AND   ((TRIM(TRANSLATE(BD6_NUMIMP,'0123456789','          ')) IS NULL "
	cSql += "AND   ((SELECT COUNT(R_E_C_N_O_) QTD FROM SZC010 SZC WHERE TO_NUMBER(TRIM(BD6_NUMIMP)) BETWEEN ZC_NUMINI AND ZC_NUMFIM AND SZC.D_E_L_E_T_ = ' ') > 0)) "
	cSql += "      AND "
	cSql += "      ((SELECT COUNT(*) QTD FROM ZZF010 ZZF WHERE ZZF_FILIAL = '  ' AND ZZF_CODIGO = BD6_CDPFSO AND ZZF.D_E_L_E_T_ = ' ') > 0) OR "
	cSql += "      BD6_VLRPAG = BD6_VLRTPF ) "
	//cSql += "--AND    BD6_NOMUSR LIKE 'JOSE DE ALMEIDA%' "
	//cSql += "AND    E1_FILIAL = '01' "
	//cSql += "AND    E1_PREFIXO = SUBSTR(BD6_NUMSE1,1,3) "
	//cSql += "AND    E1_NUM     = SUBSTR(BD6_NUMSE1,4,6) "
	//cSql += "AND    E1_PARCELA = SUBSTR(BD6_NUMSE1,10,1) "
	//cSql += "AND    E1_TIPO    = SUBSTR(BD6_NUMSE1,11,3) "
	//cSql += "AND    E1_ANOBASE||E1_MESBASE = '200812' "
	cSQL += "AND BAU_FILIAL = '"+ xFilial("BAU") +"' "
	cSQL += "AND BAU_CODIGO = BD6_CODRDA "
	If !Empty(cRdaAte)
		cSql += "AND BAU_CODIGO BETWEEN '" + cRdaDe + "' AND '" + cRdaAte + "' "
	EndIf
	If !Empty(cGrpPagAte)
		cSql += " AND BAU_GRPPAG BETWEEN '"+cGrpPagDe+"' AND '"+cGrpPagAte+"' "
	EndIf
	cSql += "AND    BF4.D_E_L_E_T_ = ' ' "
	cSql += "AND    BD6.D_E_L_E_T_ = ' ' "
//	cSql += "AND    SE1.D_E_L_E_T_ = ' ' "
	cSql += "AND    BA1.D_E_L_E_T_ = ' ' "
	cSql += "AND BAU.D_E_L_E_T_ = ' ' "
	cSql += "AND BA3.D_E_L_E_T_ = ' ' "     
	
Else
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta  no BD7  			                                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cSql := " SELECT BD6_FILIAL, BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,BD6_SEQUEN,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG, "
	cSql += " BD6_CODPRO, BD6_DESPRO, BD6_VLRPAG, BD6_VLRTPF, BD6_NOMUSR, BD6_PERCOP, "
	cSql += " DECODE(TRIM(BD6_CODPLA),NULL,BA3_CODPLA,BD6_CODPLA) AS BD6_CODPLA, "
	cSql += " BD6_ANOPAG, BD6_MESPAG, BD6_DIGITO, BD6_CODRDA, BD6_NOMRDA, BD6_CDPFSO, BD6_DATPRO, BD6_NOMSOL, BD6_CDPFSO, BD6_SEQPF, "
	cSql += " BD6_BLOCPA, BD6_BLOPAG, BD6_NUMFAT, BD6_NUMSE1, BD6_NUMLOT, BD6_NUMIMP, bd6.r_e_c_n_o_ RECNO, BD6_CODPAD, BD6_OPERDA "
	//bF4_codpro, BF4_DATBAS, BF4_DATBLO,
	//ZZF_CODIGO
	
	cSql += " FROM " + RetSQLName("BD6") + " BD6, "+RetSQLName("BA3") + " BA3, "+RetSQLName("BAU") + " BAU "
	cSql += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
	//cSql += " AND BD6_CODope = '0001' "
	//cSql += " AND BD6_CODLDP = '0001' "
	//cSql += " AND BD6_CODPEG = '00124382' "
	//cSql += " AND BD6_ANOPAG||BD6_MESPAG = '200810' "
	If !Empty(cLdpAte)
		cSql += " AND BD6_CODLDP BETWEEN '" + cLdpDe + "' AND '" + cLdpAte + "' "
	Endif
	If !Empty(cPegAte)
		cSql += " AND BD6_CODPEG BETWEEN '" + cPegDe + "' AND '" + cPegAte + "' "
	Endif
	If !Empty(cEmpAte)
		cSql += " AND BD6_CODEMP BETWEEN '" + cEmpDe + "' AND '" + cEmpAte + "' "
	Endif
	//If !Empty(cGuiAte)
	//	cSql += " AND BD6_NUMIMP BETWEEN '" + cGuiDe + "' AND '" + cGuiAte + "' "
	//Endif
	
	cSQL += "AND BAU_FILIAL = '"+ xFilial("BAU") +"' "
	cSQL += "AND BAU_CODIGO = BD6_CODRDA "
	If !Empty(cRdaAte)
		cSql += "AND BAU_CODIGO BETWEEN '" + cRdaDe + "' AND '" + cRdaAte + "' "
	EndIf
	If !Empty(cGrpPagAte)
		cSql += " AND BAU_GRPPAG BETWEEN '"+cGrpPagDe+"' AND '"+cGrpPagAte+"' "
	EndIf
	cSql += "AND BD6_ANOPAG||BD6_MESPAG BETWEEN '" + cAnoDe+cMesDe + "' AND '" + cAnoAte+cMesAte + "' "
	
	cSql += "AND BD6_VLRTPF > 0 "
	
	/*
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Funcao generica que trata campos do estorno		   					        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If FindFunction("PlReChvEst")
	aRetAux  := PlReChvEst("BD7",.F.,.T.,.F.,.T.)
	cSQL     += aRetAux[1]
	Endif
	*/
	
	cSql += " AND BA3_CODINT = BD6_OPEUSR "
	cSql += " AND BA3_CODEMP = BD6_CODEMP "
	cSql += " AND BA3_MATRIC = BD6_MATRIC "
	
	If nFase == 1 // Pronta
		cSql += " AND BD6_FASE = '3' "
	ElseIf nFase == 2 // faturada
		cSql += "AND BD6_FASE = '4' "
		cSql += "AND BD6_NUMLOT <> '  ' "
	ElseIf nFase == 3 // Ambas
		cSql += "AND BD6_FASE IN ('3','4') "
	EndIf
	cSql += " AND BD6_SITUAC = '1' "
	cSql += " AND BD6_BLOCPA <> '1' "
	cSql += " AND BD6_BLOPAG <> '1' "
	cSql += " AND BD6.D_E_L_E_T_ = ' ' "
	cSql += " AND BAU.D_E_L_E_T_ = ' ' "
	cSql += " AND BA3.D_E_L_E_T_ = ' ' "
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta ordem                                                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cSql += " ORDER BY BD6_FILIAL,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,BD6_CODPAD,BD6_CODPRO, BD6_CODRDA "

memowrit("C:\CABR013.SQL",cSQL)

PLSQuery(cSql,"TrbBD6")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta regua                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TrbBD6->(DBEval( { | | nTotal++ }))
TrbBD6->( DbGotop())
ProcRegua(nTotal)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Montado Matriz															 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While !TrbBD6->( Eof() )
	
	lGuiVERDE := .F.
	lSolAED := .F.
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Mensagem de processamento                                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Npercent := (nProc/nTotal)*100
	IncProc("Imprimindo... " + Transform(Npercent,"@E 999.99") + "  %. Reg.: "+ Transform(nProc,"@E 9,999,999") +" de: "+ Transform(nTotal,"@E 9,999,999"))
	ProcessMessage()
	
	//Verifica se a guia esta dentro da numeracao das guias cadastradas como utilizadas no programa AED/AAG.
	lGuiVERDE := VldGuia(TrbBD6->BD6_NUMIMP)
	
	lSolAED := BusSolZZF(TrbBD6->BD6_CDPFSO)
	
	//Verifica se a RDA executante pertence a rede de referencia do AED/AAG e do Nucleo de Atendimento.
	lExeAED := .F.
	SZ0->(DbSetOrder(1))
	If SZ0->(MsSeek(xFilial("SZ0")+TrbBD6->(BD6_CODOPE+BD6_OPERDA+BD6_CODRDA)))
		While !SZ0->(Eof()) .And.  SZ0->(Z0_FILIAL+Z0_CODINT+Z0_OPERDA+Z0_CODRDA) == xFilial("SZ0")+TrbBD6->(BD6_CODOPE+BD6_OPERDA+BD6_CODRDA)
			If (SZ0->Z0_STATUS == "0" .Or. Empty(SZ0->Z0_STATUS)) .And.;
			   dDatPro >= SZ0->Z0_VIGINI .and.;
			   (dDatPro <= SZ0->Z0_VIGFIM .or. Empty(SZ0->Z0_VIGFIM))
				lExeAED := .T.
				Exit
			Endif
			SZ0->(DbSkip())
		Enddo
	Endif

	cCodPla := TrbBD6->BD6_CODPRO
	cVerPla := "001"
	cPlaAnt := cCodPla
	cVerAnt := cVerPla
	
	dDatPro := TrbBD6->BD6_DATPRO
	
	nProc++
	
	If (lSolAED .and. lGuiVERDE) // Caso o solicitante pertenГa ao AED e a guia for Verde.
		// Para os casos do AAG.
		// Ira Entrar neste IF se o solciitante for participanete do AED e se Guia for VERDE.
		// Caso o solcitante nao for do AED e a Guia nao for Verde nao entra neste IF.
		// Se o usuario nao pertencer ao AED, mas a Guia eh VERDE e o SOLICITANTE for participante do AED entra neste IF.
		// Isto servira para os casos dos NUPRES e dos atendimentos AAG.
		// Nao ira cobrar co-participacao
		lTemCoPF := .F.
		// So ira tratar se o usuario possui algum opcional AAG/AED cadastrado e se o solicitante for do AED e/ou a Guia for Verde
		// So entra neste IF se o solicitante for do AED e/ou a Guia for VERDE, independente do do ususario possuir ou nao o opcional do AED.
		// Verifica se o usuario possui algum opcional AAG/AED cadastrado, caso o solicitante nao for do AED e/ou Formulario nao for VERDE
		//Se o usuario nao pertencer ao AED, ma s aGeuia eh VERDE ou o SOLICITANTE for participante do AED nao entra neste IF.
	ElseIf BF4->(MsSeek(xFilial("BF4")+TrbBD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG))) //.and. (lSolAED .or. lGuiVERDE)
		
		While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == TrbBD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG) .And. !BF4->(Eof())
			
			//Zerar co-participacao (regra AED). Caso cobrar co-part, devera ser analisado conforme regras
			//parametrizadas no produto opcional.
			If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0023,0024")
				
				If Empty(BF4->BF4_DATBLO) .Or. !Empty(BF4->BF4_DATBLO) .And. (Dtos(dDatPro) < Dtos(BF4->BF4_DATBLO))
					
					cCodPla := BF4->BF4_CODPRO
					cVerPla := BF4->BF4_VERSAO
					lTemCoPF := .T.
					lTemAED := .T.
					
					Exit
					
				Endif
			ElseIf (lSolAED .or. lGuiVERDE)
				lTemCoPF := .F.
			Endif
			
			BF4->(DbSkip())
			
		Enddo
	Else
		TrbBD6->(DbSkip())
		Loop
	Endif
	// Se o usuario nao for participante do AED e o solicitante nao for do AED e a Guia nao for VERDE, tera coparticipacao.
	// Se o usuario nao for participante do AED e o solcitante for do AED ou a guia nao for VERDE, tera coparticipacao
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime cabecalho                                                        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  nli > nLinPag
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+
	//Matricula         Usuario                                     Local PEG      Dt.Mov.    Mes/Ano Num. Impresso           Solcitante                                         Lote Pagto.    
	//12345678901234567 1234567890123456789012345678901234567890(*) 0001  12345678 1234567890 1234567 12345678901234567890(*) 123456-1234567890123456789012345678901234567890(*) 9999999999999  PLS440893 DP
	//          Procedimento     Descricao                                             Numero   Seq    Co-Particip %Co-Particip
	//				1234567890123456 12345678901234567890123456789012345678901234567890(*) 12345678 123 999,999,999.99       999,99
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime linha de detalhe                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	@ nLi, 000 pSay TrbBD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
	@ nLi, 018 pSay Alltrim(TrbBD6->BD6_NOMUSR)+Iif(lTemAED,"(*)","")
	@ nLi, 062 pSay TrbBD6->BD6_CODLDP
	@ nLi, 068 pSay TrbBD6->BD6_CODPEG
	@ nLi, 077 pSay TrbBD6->BD6_DATPRO
	@ nLi, 088 pSay TrbBD6->BD6_mespag+"/"+TrbBD6->bd6_anopag
	@ nLi, 096 pSay TrbBD6->BD6_NUMIMP+Iif(lGuiVERDE,"(*)","")
	@ nLi, 120 pSay TrbBD6->BD6_CDPFSO+"-"+TrbBD6->BD6_NOMSOL+Iif(lSolAED,"(*)","")
	@ nLi, 171 pSay TrbBD6->BD6_NUMLOT
	@ nLi, 186 pSay TrbBD6->BD6_NUMSE1
	nli++
	@ nLi, 120 pSay TrbBD6->BD6_CODRDA+"-"+TrbBD6->BD6_NOMRDA+Iif(lExeAED,"(*)","")
	nli++

	cFilial := TrbBD6->BD6_FILIAL
	cOpeusr := TrbBD6->BD6_OPEUSR
	cCodEmp := TrbBD6->BD6_CODEMP
	cMatric := TrbBD6->BD6_MATRIC
	cTipreg := TrbBD6->BD6_TIPREG
	cDigito := TrbBD6->BD6_DIGITO
	
	cCodOpe := TrbBD6->BD6_CODOPE
	cCodLdp := TrbBD6->BD6_CODLDP
	cCodPeg := TrbBD6->BD6_CODPEG
	cNumero := TrbBD6->BD6_NUMERO
	
	While !TrbBD6->(EOF()) .and. TrbBD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) == cOpeusr+cCodEmp+cMatric+cTipreg+cDigito .and.;
		TrbBD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == cCodOpe+cCodLdp+cCodPeg+cNumero
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Mensagem de processamento                                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		Npercent := (nProc/nTotal)*100
		IncProc("Imprimindo... " + Transform(Npercent,"@E 999.99") + "  %. Reg.: "+ Transform(nProc,"@E 9,999,999") +" de: "+ Transform(nTotal,"@E 9,999,999"))
		//		IncProc("Imprimindo... " + Transform(Npercent,"@E 999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9,999,999"))
		ProcessMessage()
		
		//Localiza parametrizacoes de produto x proc x qtd...
		If BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla+cVerPla)) .and. lTemCoPF .and. !lTemAED
			
			//Localiza parametrizacoes tanto para procedimentos agrupados, como para atribuicoes diretas...
			cCodPad := TrbBD6->BD6_CODPAD
			cCodPro := TrbBD6->BD6_CODPRO
			
			nCont := 1
			nTamSub := 16
			While nCont <= 3
				
				If cCodPad == "01" //Somente para CIEFAS/AMB...
					If nCont == 1
						cProBus := cCodPro
						nNivel := 3
						nTamSub := 16
						
					ElseIf nCont == 2
						cProBus := Substr(cProBus,1,4)+Replicate("0",3)
						nNivel := 2
						nTamSub := 4
						
					ElseIf nCont == 3
						cProBus := Substr(cProBus,1,2)+Replicate("0",5)
						nNivel := 1
						nTamSub := 2
						
					Endif
				Endif
				
				If BB2->(MsSeek(xFilial("BB2")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
					cProBus := BB2->BB2_CODPSA
					
					If BHD->(MsSeek(xFilial("BHD")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
						
						lProcTemPF := .T.
						aQtd := {}
						
						// Comentado por Luzio em 25/09/08, para que considere apenas os procedimenos relamente identicos e no mesmo nivel, pois da forma
						// como estava, o array era alimentado com todos os procedimentos caso o parametrizado fosse niveis 1 e 2,
						// e com procedimentos fora de veigencia. Dessa forma se nao encontrar um procedimento de nivel 3, ira considerar
						// pesquisar pelo sub-grupo ou grupo e alimentara a array somente com o procedimento grupo.
						//					While !BHD->(Eof()) .And. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+Substr(BHD->BHD_CODPSA,1,nTamSub)==PLSINTPAD()+cCodPla+cVerPla+cCodPad+Substr(cProBus,1,nTamSub)
						While !BHD->(Eof()) .And. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+BHD->BHD_CODPSA == PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus
							If Empty(BHD->BHD_VIGATE) .or. (DtoS(dDatPro) <= DtoS(BHD->BHD_VIGATE) .and. DtoS(dDatPro) >= DtoS(BHD->BHD_VIGDE))
								If BHD->BDH_PERCOP = 0
									aadd(aQtd,{BHD->BHD_TIPO,BHD->BHD_QTD,BHD->BHD_PERCOP,BHD->BHD_VLRCOP,BHD->BHD_VALUS, BHD->BHD_TXADM,BHD->BHD_LIMFRA,BHD->BHD_SOMCOM,Iif(nI==2,"0","1"),BHD->BHD_CODIGO, BHD->BHD_VERSAO, BHD->BHD_CODPAD, BHD->BHD_CODPSA})
									lProcTemPF := .F.
								EndIf
							EndIf
							BHD->(DbSkip())
							nCont := 3
						Enddo
					Endif
				Endif
				
				nCont++
				
			Enddo
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime cabecalho                                                        Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nli > nLinPag
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		
		@ nLi, 010 pSay TrbBD6->BD6_CODPRO
		@ nLi, 027 pSay TrbBD6->BD6_DESPRO+Iif(!lProcTemPF,"(*)","")
		@ nLi, 081 pSay TrbBD6->BD6_NUMERO
		@ nLi, 090 pSay TrbBD6->BD6_SEQUEN
		@ nLi, 094 pSay Transform(TrbBD6->BD6_VLRTPF,"@E 999,999,999.99")
		If !lProcTemPF
			@ nLi, 115 pSay Transform(TrbBD6->BD6_PERCOP,"@E 999.99") //aQtd[1,3]
		EndIf
		
		nTVlPF += TrbBD6->BD6_VLRTPF
		nli++
		
		//		Roda(0,space(10),cTamanho)
		
		TrbBD6->( DbSkip() )
	EndDo
	nli++
	
	//Retorna parametros da funcao a condicao normal...
	cCodPla := cPlaAnt
	cVerPla := cVerAnt
	
	cPlaAnt := ""
	cVerAnt := ""
	
EndDo

nLi++
@ nLi, 081 pSay "Total"
@ nLi, 094 pSay Transform(nTVlPF,"@E 999,999,999.99")

nli += 2

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho	  					             							  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TrbBD6->( DbCloseArea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
	Set Printer To
	OurSpool(nrel)
End
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim do Relat╒rio                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return(aRet)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё BusSolZZF Ё Autor Ё Luzio Tavares        Ё Data Ё 02/10/08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Verifica se o solicitante participa do AED/AAG             Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function BusSolZZF(cCodSol)
Local lRet := .F.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Filtra ZZF-Profissional Saude paraticipante do AED ou AAG                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cSQL := " SELECT ZZF_CODIGO, ZZF_TIPO, ZZF_DATA FROM " + RetSQLName("ZZF")
cSQL += " WHERE ZZF_FILIAL  = '" + xFilial("ZZF") + "' "
cSQL += " AND ZZF_CODIGO = '" + cCodsol + "' "
cSQL += " AND D_E_L_E_T_ = ' '"
PLSQUERY(cSQL,"TrbZZF")

dbSelectArea("TrbZZF")
TrbZZF->(DbGotop())

While !TrbZZF->(Eof())
	If TrbZZF->ZZF_TIPO $ "1_2" .And. DtoS(dDatPro) >= DtoS(TrbZZF->ZZF_DATA)
		lRet := .T.
	Endif
	TrbZZF->(DbSkip())
Enddo

TrbZZF->(DbCloseArea())

Return(lRet)

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммммммкммммммяммммммммммммммммммкммммммяммммммммммм╩╠╠
╠╠╨Programa  ЁRetMesAno      ╨Autor ЁLuzio Tavares     ╨ Data Ё 02.10.08  ╨╠╠
╠╠лммммммммммьмммммммммммммммйммммммоммммммммммммммммммйммммммоммммммммммм╧╠╠
╠╠╨Desc.     ЁRetorna Mes/Ano                                             ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function RetMesAno(cAnoMes)
Static aMeses := {"Jan","Fev","Mar","Abr","Mai","Jun","Jul", "Ago", "Set", "Out", "Nov", "Dez"}
Local cString := ""

If Val(Right(cAnoMes,2)) > 0 .And. Val(Right(cAnoMes,2)) <= 12
	cString := aMeses[Val(Right(cAnoMes,2))]+"/"+Left(cAnoMes,4)
Else
	cString := Right(cAnoMes,2)+"/"+Left(cAnoMes,4)
EndIf

Return(cString)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CriaSX1   Ё Autor Ё Luzio Tavares        Ё Data Ё 02.10.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}

/*
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica versao do sistema												 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If PlsGetVersao() >= 8
If  SX1->(msSeek(cPerg+"01"))
If Alltrim(SX1->X1_F3) == "B89"
If SX1->(msSeek(cPerg+"44"))
SX1->(RecLock("SX1",.F.))
SX1->(dbDelete())
SX1->(msUnLock())
Endif
Endif
Endif
If  SX1->(msSeek(cPerg+"26"))
If Alltrim(SX1->X1_F3) == "B89PLS"
If SX1->(msSeek(cPerg+"44"))
SX1->(RecLock("SX1",.F.))
SX1->(dbDelete())
SX1->(msUnLock())
Endif
Endif
Endif
Endif
If  ! SX1->(msSeek(cPerg+"44"))
While .T.
If  SX1->(MsSeek(cPerg))
SX1->(RecLock("SX1",.F.))
SX1->(DbDelete())
SX1->(MsUnLock())
Else
Exit
Endif
Enddo
Endif

If  SX1->(MsSeek(cPerg+"14")) .And. !('Imprimir Val' $ SX1->X1_PERGUNT)
While .T.
If  SX1->(MsSeek(cPerg))
SX1->(RecLock("SX1",.F.))
SX1->(DbDelete())
SX1->(MsUnLock())
Else
Exit
Endif
Enddo
Endif
*/

aadd(aRegs,{cPerg,"01","Operadora"              ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","RDA De"                 ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"03","RDA Ate"                ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BA0PLS","BA0"),""})
aadd(aRegs,{cPerg,"04","Ano Base De"            ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"05","Mes Base De"            ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05",""            ,"","","","",""               ,"","","","",""               ,"","","","",""                   ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"06","Ano Base Ate"           ,"","","mv_ch6","C", 4,0,0,"G","","mv_par06",""            ,"","","","",""               ,"","","","",""               ,"","","","",""    			      ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"07","Mes Base Ate"           ,"","","mv_ch7","C", 2,0,0,"G","","mv_par07",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"08","Local Dig. De"          ,"","","mv_ch8","C", 4,0,0,"G","","mv_par08",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BAZPLS","BAZ"),""})
aadd(aRegs,{cPerg,"09","Local Dig. Ate"         ,"","","mv_ch9","C", 4,0,0,"G","","mv_par09",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BAZPLS","BAZ"),""})
aadd(aRegs,{cPerg,"10","Peg De"                 ,"","","mv_cha","C", 8,0,0,"G","","mv_par10",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"11","Peg Ate"                ,"","","mv_chb","C", 8,0,0,"G","","mv_par11",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"12","Empresa De"             ,"","","mv_chc","C", 4,0,0,"G","","mv_par12",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"13","Empresa Ate"            ,"","","mv_chd","C", 4,0,0,"G","","mv_par13",""            ,"","","","",""               ,"","","","",""               ,"","","","",""       			   ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"14","Fase"                   ,"","","mv_che","N", 1,0,0,"C","","mv_par14","Pronta"      ,"","","","","Faturada"       ,"","","","","Ambas"          ,"","","","",""       			   ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"15","Grupo Pagamento De"     ,"","","mv_chf","C", 4,0,0,"G","","mv_par15",""            ,"","","","",""               ,"","","","",""               ,"","","","",""                   ,"","","","","","","","","BRZPLS","",""})
aadd(aRegs,{cPerg,"16","Grupo Pagamento Ate"    ,"","","mv_chg","C", 4,0,0,"G","","mv_par16",""            ,"","","","",""               ,"","","","",""               ,"","","","",""                   ,"","","","","","","","","BRZPLS","",""})
aadd(aRegs,{cPerg,"17","Tipo de Analise"        ,"","","mv_chh","N", 1,0,0,"C","","mv_par17","AED/AAG"     ,"","","","","Geral"          ,"","","","","Ambas"          ,"","","","",""        			   ,"","","","","","","","",""   	,""})

PlsVldPerg( aRegs )
Return

**********************************************************
* Funcao....: VldGuia()                                 *
* Finalidade: verifica se a Guia pertence ao AED			*
**********************************************************
Static Function VldGuia(cGuia)

Local lRet    := .F.
Local aArea   := GetArea()

cQuery:="SELECT ZC_NUMINI, ZC_NUMFIM, ZC_SITUAC FROM "+RetSQLName("SZC")+" "
cQuery+="WHERE D_E_L_E_T_ <> '*' AND '"+cGuia+"' BETWEEN ZC_NUMINI AND ZC_NUMFIM "

TCQUERY cQuery ALIAS "VALTAL" NEW

dbselectarea("VALTAL")
If !Eof() .AND. VALTAL->ZC_SITUAC $ " _1"
	lRet:=.T.
EndIf
VALTAL->(DbCloseArea())

RestArea(aArea)

Return(lRet)
